from django.db import models
from customer.models import AuthUser
from import_export import resources

# Create your models here.


class Withdraw(models.Model):
    with_user = models.ForeignKey(AuthUser,related_name='with_user', on_delete=models.CASCADE)
    amount = models.PositiveIntegerField(default=0)
    date = models.DateTimeField()

    # class Meta:
    #     managed = False
    #     db_table = 'withdraw'

class Deposit(models.Model):
    dep_user = models.ForeignKey(AuthUser,related_name='dep_user', on_delete=models.CASCADE)
    amount = models.PositiveIntegerField(default=0)
    date = models.DateTimeField()

    # class Meta:
    #     managed = False
    #     db_table = 'deposit'


class Transaction(models.Model):
    tran_user = models.ForeignKey(AuthUser,related_name='tran_user', on_delete=models.CASCADE)
    account_no = models.IntegerField(default=0)
    amount = models.PositiveIntegerField(default=0)
    tran_type = models.CharField(max_length=200, blank=True, null=True)
    date = models.DateTimeField()

    # class Meta:
    #     managed = False
    #     db_table = 'transaction'

