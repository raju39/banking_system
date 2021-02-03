from django.shortcuts import render, redirect
from django.contrib import messages
from django.http import HttpResponseRedirect, JsonResponse
from model_utils import Choices
from django.utils.dateformat import format
from django.views.decorators.csrf import csrf_exempt
from django.utils.timezone import now
from django.conf import settings
from django.db.models import Q
from django.contrib.sessions.models import Session
from rest_framework.response import Response
import json
from datetime import datetime
from customer.models import AuthUser,CustomerAccountdetail
from accounts.models import Withdraw,Deposit,Transaction
from django.contrib.auth.hashers import make_password, check_password
import calendar
import time



"""
Customer login request
"""
def customer_login(request):
    email = request.session.get('email', None)
    user_type = request.session.get('user_type', None)
    if request.method == "POST":
        email = request.POST.get('email', None)
        plain_password = request.POST.get('password', None)
        print(plain_password)
        # Get values of password from db
        userdata = AuthUser.objects.filter(email__iexact=email, is_active=1).values('id','email','is_superuser','password')
        if not userdata:
            messages.error(request, 'Incorrect email id or password. Please try again.')
            return render(request, 'customer/login.html')
        if userdata:
            current_user_data = userdata[0]
            user_password_from_db = current_user_data['password']
            user_password = check_password(plain_password, user_password_from_db)
            if (user_password is True):
                request.session['email'] = current_user_data['email']
                request.session['user_type'] = current_user_data['is_superuser']
                request.session['user_id'] = current_user_data['id']
                if int(current_user_data['is_superuser']) == 1:
                    # return render(request, 'customer/customermanagement.html')
                    return HttpResponseRedirect('/usermanagement')
                else:
                    return HttpResponseRedirect('/profile')
            else:
                messages.error(request, 'Incorrect email id or password. Please try again.')
                return render(request, 'customer/login.html')

    elif email:
        return HttpResponseRedirect('/account/summary')
    else:
        return render(request, 'customer/login.html')

"""
Customer logout request
"""
def customer_logout(request):
    email = request.session.get('email',None)
    if email:
        request.session.flush()
    return HttpResponseRedirect('/')



"""
get customermanagement page request
"""
def customermanagement(request):
    user_type = request.session.get('user_type', None)
    email = request.session.get('email', None)
    if email and user_type == 1:
        return render(request, 'customer/customermanagement.html')
    elif email:
        return HttpResponseRedirect('/accounts/summary')
    else:
        return HttpResponseRedirect('/')



"""
Add new user
"""
def adduser(request):
    email = request.session.get('email', None)
    user_type = request.session.get('user_type', None)
    if email and user_type == 1:
        if request.method == "POST":
            first_name = request.POST.get('first_name', None)
            last_name = request.POST.get('last_name', None)
            email = request.POST.get('email', None)
            address = request.POST.get('address', None)
            password = request.POST.get('password', None)
            amount = request.POST.get('amount', None)
            context_dict = dict()
            if (first_name == '') or (last_name == '') or (email == '') or (address == '') or (password == '' )or (amount == '' ):
                context_dict['messages'] = "First name, Last name, email, password, Amount, address can't be empty. all fields required."
                context_dict['status'] = 0
            else:
                check_email = email__exist(email)
                if check_email:
                    context_dict['messages'] = "This email is already registered please enter another one."
                    context_dict['status'] = 0
                else:
                    gmt = time.gmtime()
                    userData = AuthUser()
                    dataDeposit = Deposit()
                    accuntData = CustomerAccountdetail()
                    tran = Transaction()
                    userData.first_name = first_name.capitalize()
                    userData.last_name = last_name
                    userData.email = email.capitalize()
                    userData.password = make_password(password,salt=None,hasher='default')
                    userData.username = email
                    userData.is_superuser = 2
                    userData.is_staff = 1
                    userData.is_active = 1
                    userData.date_joined = datetime.now()
                    userData.save()
                    # print(userData.id)
                    accuntData.address = address
                    accuntData.account_no = calendar.timegm(gmt)
                    accuntData.acc_user_id = userData.id
                    accuntData.created = datetime.now()
                    accuntData.save()
                    dataDeposit.amount += int(amount)
                    dataDeposit.date = datetime.now()
                    dataDeposit.dep_user_id = userData.id
                    dataDeposit.save()
                    tran.amount = amount
                    tran.account_no = accuntData.account_no
                    tran.tran_type = 'Deposit'
                    tran.date = datetime.now()
                    tran.tran_user_id = userData.id
                    tran.save()
                    context_dict['messages'] = "Successfully Created Account."
                    context_dict['status'] = 1
            return JsonResponse(context_dict)
    elif email:
        return HttpResponseRedirect('/account/summary')
    else:
        return HttpResponseRedirect('/')

"""
Check user email exist or not
"""

def email__exist(email):
    userdata = AuthUser.objects.filter(email__exact=email)
    if userdata:
        return True
    else:
        return False

"""
Get user list 
"""
def userlist(request):
    email = request.session.get('email', None)
    if email is None:
        return Response(e, status=status.HTTP_404_NOT_FOUND, template_name=None, content_type=None)

    draw = request.GET.get('draw', '')
    length = request.GET.get('length', '')
    start = request.GET.get('start', '')
    search_value = request.GET.get('search[value]', '')
    order_column = request.GET.get('order[0][column]', '')
    order = request.GET.get('order[0][dir]', '')

    if draw:
        draw = int(draw)
    else:
        draw = int(1)
    if length:
        length = int(length)
    else:
        length = int(10)
    if start:
        start = int(start)
    else:
        start = int(0)

    ORDER_COLUMN_CHOICES = Choices(
        ('0', 'account_no'),
    )

    order_column = ORDER_COLUMN_CHOICES[order_column]
    if order == 'asc':
        order_column = '-' + order_column


    queryset = CustomerAccountdetail.objects.all().select_related('acc_user')
    print(queryset.query)
    total = queryset.count()

    count = queryset.count()
    queryset = queryset.order_by(order_column)[start:start + length]
    result = dict()
    CanresultData = list()
    for data in queryset:
        print(data)
        resultData = dict()
        resultData['account_no'] = data.account_no
        resultData['first_name'] = data.acc_user.first_name
        resultData['last_name'] = data.acc_user.last_name
        resultData['address'] = data.address
        if data.acc_user.is_superuser == 1:
            resultData['profile_type'] = 'Manager'
        else:
            resultData['profile_type'] = 'Customer'
        resultData['email'] = data.acc_user.email
        date = format(data.acc_user.date_joined, 'd/m/Y H:i')
        resultData['created_at'] = date
        resultData['status'] = data.acc_user.is_active
        resultData['id'] = data.acc_user.id
        CanresultData.append(resultData)

    result['data'] = CanresultData
    result['draw'] = draw
    result['recordsTotal'] = total
    result['recordsFiltered'] = count
    return JsonResponse(result, safe=False)

"""
user activate or deactivate 
"""

def user_activate(request):
    email = request.session.get('email', None)
    id = request.GET.get('id', None)
    user_type = request.session.get('user_type', None)
    context_dict = dict()
    if email is None:
        return HttpResponseRedirect('/')
    else:
        userdata = AuthUser.objects.get(pk=id)
        if userdata.is_active == 0:
            userdata.is_active = 1
            context_dict['status'] = 1
            context_dict['messages'] = "Successfully user activated"
        else:
            userdata.is_active = 0
            context_dict['status'] = 1
            context_dict['messages'] = "Successfully user deactivated"
        userdata.save()
    return JsonResponse(context_dict)


"""
email check with user id 
"""

def email_check_withid(email,id):
    userdata = AuthUser.objects.filter(~Q(id=id),email__exact=email)
    if userdata:
        return True
    else:
        return False


def profile(request):
    user_id = request.session.get('user_id', None)
    if user_id:
        context_dict = dict()
        userdata = CustomerAccountdetail.objects.filter(acc_user_id=user_id).select_related('acc_user')[0]
        context_dict['first_name'] = userdata.acc_user.first_name
        context_dict['last_name'] = userdata.acc_user.last_name
        context_dict['email'] = userdata.acc_user.email
        context_dict['account_no'] = userdata.account_no
        context_dict['address'] = userdata.address

        return render(request, 'customer/profile.html', context_dict)
    else:
        return HttpResponseRedirect('/')



