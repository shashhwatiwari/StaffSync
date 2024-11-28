from django.urls import path
from . import views

urlpatterns = [
    path('/', views.login_view, name='staffsync-login' ),
    path("<int:userid>/hr/", views.hr_view, name='staffsync-hr' ),
]