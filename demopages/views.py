from django.http import HttpResponse


def index(response):
    return HttpResponse("Hello World")


def index2(response):
    return HttpResponse("Test2")
