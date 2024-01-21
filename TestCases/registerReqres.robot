*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}                 https://reqres.in
${endpoint}                 /api/register
${emailReg}                 eve.holt@reqres.in
${passwordReg}              pistol
${Invalidemail}             ocirtes@reqres.in
${Invalidpassword}          rahasia@123

*** Keywords ***
Verifiy register
    Create Session    reqres    ${base_url}/api/register verify=True
    Set Test Variable    ${data}    {"email":"${emailReg}","password":${passwordReg}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/register    data=${data}  headers=${headers}
    Log To Console    Create Register Response ${response}
	Log To Console    Create Register Body Response ${response.content}
	Should Be Equal  ${response.status_code}  ${201}
	${body}=  Set Variable  ${response.json()}

Register unsuccessful - Invalid Email and Password
    Create Session    reqres    ${base_url}/api/register verify=True
    Set Test Variable    ${data}    {"email":"${Invalidemail}", "password":"${Invalidpassword}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/register    data=${data}  headers=${headers}
    Log To Console    Failed Register Invalid Response ${response}
	Log To Console    Failed Register Invalid Body Response ${response.content}
    Should Be Equal  ${response.status_code}  ${400}
	${body}=  Set Variable  ${response.json()}

Register unsuccessful - Missing Password
    Create Session    reqres    ${base_url}/api/register verify=True
    Set Test Variable    ${data}    {"email":"", "password":""}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/register    data=${data}  headers=${headers}
    Log To Console    Failed Register Missing Password Response ${response}
	Log To Console    Failed Register Missing Password Body Response ${response.content}
    Should Be Equal  ${response.status_code}  ${400}
	${body}=  Set Variable  ${response.json()}