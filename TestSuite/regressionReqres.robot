*** Settings ***
Library     Collections
Library     RequestsLibrary
Resource    ../TestCases/registerReqres.robot
Resource    ../TestCases/loginReqres.robot
Resource    ../TestCases/createUserReqres.robot

*** Variables ***
#register reqres
${base_url}                 https://reqres.in
${endpoint}                 /api/register
${emailReg}                 eve.holt@reqres.in
${passwordReg}              pistol
${Invalidemail}             ocirtes@reqres.in
${Invalidpassword}          rahasia@123

#login reqrest
${endpoint}                 /api/login
${emailLogin}               eve.holt@reqres.in
${passwordLogin}            cityslicka
${emailInvalidLogin}        peter@klaven

#create
${endpoint}                 /api/users
${name}                     morpheus
${job}                      leader

*** Test Cases ***
register reqres
    Verifiy register
Failed Register
    Register unsuccessful - Invalid Email and Password
    Register unsuccessful - Missing Password

Login reqres
    Verifiy success login
Failed Login
    Verifiy unsuccessful login

Create user success
    verifiy success create

verifiy failed create user
    verifiy failed create