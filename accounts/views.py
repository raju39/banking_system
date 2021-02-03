from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse,JsonResponse
from .models import Withdraw,Deposit,Transaction
from customer.models import CustomerAccountdetail
from datetime import datetime
import csv
from django.core.mail import EmailMessage
from import_export import resources
# Create your views here.




def deposit_view(request):
    email = request.session.get('email', None)
    user_id = request.session.get('user_id', None)
    amount = request.POST.get('amount', None)
    user_type = request.session.get('user_type', None)
    if int(user_type) == 2:
        data = Deposit.objects.filter(dep_user_id=user_id)[0]
        if request.method == "POST":
            tran = Transaction()
            custoData = CustomerAccountdetail.objects.get(acc_user_id=user_id)
            data.amount += int(amount)
            data.date = datetime.now()
            data.dep_user_id = user_id
            tran.amount = amount
            tran.account_no = custoData.account_no
            tran.tran_type = 'Deposit'
            tran.date = datetime.now()
            tran.tran_user_id = user_id
            data.save()
            tran.save()
            total = data.amount
            mail('Deposit amount', 'Deposit amount'+amount, email)
            context = {
                "title": "Deposit amount",
                "deposit": amount,
                "Total_amount": total
            }
            return render(request, "accounts/deposit.html", context)
        else:
            total = data.amount
            context = {
                "Total_amount": total
            }
            return render(request, "accounts/deposit.html",context)
    else:
        return HttpResponseRedirect('/')


def withdrawal_view(request):
    email = request.session.get('email', None)
    user_id = request.session.get('user_id', None)
    amount = request.POST.get('amount', None)
    user_type = request.session.get('user_type', None)
    if int(user_type) == 2:
        dataDeposit = Deposit.objects.filter(dep_user_id=user_id)[0]
        if request.method == "POST":
            tran = Transaction()
            custoData = CustomerAccountdetail.objects.get(acc_user_id=user_id)
            if int(dataDeposit.amount) >= int(amount):
                dataDeposit.amount -= int(amount)
                dataDeposit.save()
                total = dataDeposit.amount
                datawithdraw = Withdraw()
                datawithdraw.amount = amount
                datawithdraw.date = datetime.now()
                datawithdraw.with_user_id = user_id
                tran.amount = amount
                tran.account_no = custoData.account_no
                tran.tran_type = 'Withdraw'
                tran.date = datetime.now()
                tran.tran_user_id = user_id
                datawithdraw.save()
                tran.save()
                mail('Withdraw amount', 'Withdraw amount' + amount, email)
                context = {
                    "title": "Withdraw amount",
                    "withdraw": amount,
                    "Total_amount": total
                }
                return render(request, "accounts/withdrawal.html", context)
            else:
                total = dataDeposit.amount
                context = {
                    "title": "Withdraw amount  is greater than total amount",
                    "withdraw": amount,
                    "Total_amount": total
                }
                return render(request, "accounts/withdrawal.html", context)

        else:
            total = dataDeposit.amount
            context = {
                "Total_amount": total,
                "title": "Withdraw amount",
                "withdraw": amount
            }
            return render(request, "accounts/withdrawal.html", context)
    else:
        return HttpResponseRedirect('/')

def enquiry_view(request):
    email = request.session.get('email', None)
    user_id = request.session.get('user_id', None)
    user_type = request.session.get('user_type', None)
    if int(user_type) == 2:
        data = Deposit.objects.filter(dep_user_id=user_id)[0]
        total = data.amount
        tran = Transaction.objects.filter(tran_user_id=user_id)
        mail('Balance Enquiry ', 'Total Amount:' + total, email)

        context = {
            "title": "Deposit amount",
            "Total_amount": total,
            'data': tran
        }
        return render(request, 'accounts/enquiry.html', context)
    else:
        return HttpResponseRedirect('/')

def report_view(request):
    user_id = request.session.get('user_id', None)
    user_type = request.session.get('user_type', None)
    account_no = request.POST.get('account', None)
    startdate = request.POST.get('start', None)
    enddate = request.POST.get('end', None)
    if int(user_type) == 1:
        if request.method == "POST":
            start = datetime.strptime(startdate, "%Y-%m-%d")
            end = datetime.strptime(enddate, "%Y-%m-%d")
            maxend = datetime.combine(end, datetime.max.time())
            if maxend >= start:
                tran = Transaction.objects.filter(account_no=account_no,date__range=[start, maxend]).values_list('account_no', 'amount', 'tran_type', 'date')
                response = HttpResponse(content_type='text/csv')
                response['Content-Disposition'] = 'attachment; filename="report.csv"'
                writer = csv.writer(response)
                writer.writerow(['account no', 'amount', 'Transaction type', 'date'])
                # users = User.objects.all().values_list('username', 'first_name', 'last_name', 'email')
                for user in tran:
                    writer.writerow(user)
                return response
            else:
                context = {
                    "title": "Your selected start date and end date range is not valid. Please select valid date",
                }
                return render(request, 'accounts/report.html', context)
        else:
            return render(request, 'accounts/report.html')

    else:
        return HttpResponseRedirect('/')



def mail(subject,mail_body,to):
    context = dict()
    # print(mail_body)
    # print(subject)
    # print(from_mail)
    email = EmailMessage(subject, mail_body,'Indian Bank', [to],headers ='')
    email.content_subtype = "html"
    email.send(fail_silently=True)
    context['message']= 'Mail sent'
    return JsonResponse(context)