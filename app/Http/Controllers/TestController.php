<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\View\View;

class TestController extends Controller
{
  
    public function index()
    {
        return view('index');
    }
}
