1. add fill to file Database users
2. add fill to Models users
3. up Database to Server

4. composer require laravel/ui
5. php artisan ui bootstrap --auth
6. make middleware (php artisan make:middleware isAdmin)
7. edit middleware 

    if (auth()->user()->isAdmin == 'admin') {
            return $next($request);
        } else {
            return redirect()->route('home')->with('error', "You don't have access");
     }
     
8. go to Kernel file add (
  'isAdmin' => \App\Http\Middleware\status::class,
9. make route (

    Route::group(['middleware' => ['auth']], function () {
      Route::get('/admin', [adminController::class, 'admin'])->name('admin')->middleware('status');
    });
)

10. edit Controller-> Auth ->LoginController edit (
    - RouteServiceProvider::HOME Change to '/home'
    - and add (use Illuminate\Http\Request; 
    
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required',
        ], [
            'email.required' => 'ກະລຸນາປ້ອນອີເມວ',
            'email.email' => 'ກະລຸນາປ້ອນອີເມວທີ່ຖືກຕ້ອງ',
            'password.required' => 'ກະລຸນາປ້ອນລະຫັດຜ່ານ',
        ]);

        if (auth()->attempt(array('email' => $request['email'], 'password' => $request['password']))) {
          if (auth()->user()->status === 'open) {
              if (auth()->user()->isAdmin == 'admin') {
                  return redirect()->route('admin');
              } else {
                 // return redirect()->route('staff');
              }
           }else{
              return redirect()->route('login')->with('error', "ບັນຊີຂອງທ່ານຖືກລະງັບການໃຊ້ງານ");
           }
        } else {
            return redirect()->route('login')->with('error', "ຊື່ຜູ້ໃຊ້ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ");
        }
    }
    



11. add alert login page (
    @if($message = Session::get('error'))
        <div class="alert alert-danger alert-block">
            <button type="button" class="close" data-dismiss="alert">x</button>
            <strong>{{$message}}</strong>
        </div>
    @endif
)

12. add fill to Controller Register add ('isAdmin' => 'member', ) after password
