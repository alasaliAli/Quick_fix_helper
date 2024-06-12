from django.shortcuts import render, redirect


# ******** Guest ********
def auth(view_function):
    def wrapped_view(request, *args, **kwargs):
        if request.user.is_authenticated == False:
            return redirect('login')

        return view_function(request, *args, **kwargs)
    return wrapped_view        


# ******** Authenticated ********
def guest(view_function):
    def wrapped_view(request, *args, **kwargs):
        if request.user.is_authenticated:
            # Handle redirection based on specific conditions
            if request.user.is_superuser or request.user.is_staff:
                return redirect('admin.dashboard')
            else:    
                return redirect('user.dashboard')
        return view_function(request, *args, **kwargs)
    return wrapped_view
    
def admin_required(view_function):
    def wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('login')
        elif not request.user.is_staff and not request.user.is_superuser:
            # Redirect non-admin users to user dashboard or appropriate page
            return redirect('user.dashboard')
        return view_function(request, *args, **kwargs)
    return wrapped_view

def user_required(view_function):
    def wrapped_view(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect('login')
        elif request.user.is_staff or request.user.is_superuser:
            # Redirect admin users to admin dashboard or appropriate page
            return redirect('admin.dashboard')
        return view_function(request, *args, **kwargs)
    return wrapped_view    