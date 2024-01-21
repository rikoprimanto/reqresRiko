*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}                 https://reqres.in
${endpoint}                 /api/login
${emailLogin}               eve.holt@reqres.in
${passwordLogin}            cityslicka
${emailInvalidLogin}        peter@klaven
*** Keywords ***
Verifiy success login
    Create Session    reqres    ${base_url}/api/login verify=True
    Set Test Variable    ${data}    {"email":"${emailLogin}","password":${passwordLogin}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/login    data=${data}  headers=${headers}
    Log To Console    success login Response ${response}
	Log To Console    Body Response ${response.content}
	Should Be Equal  ${response.status_code}  ${201}
	${body}=  Set Variable  ${response.json()}

Verifiy unsuccessful login
    Create Session    reqres    ${base_url}/api/login verify=True
    Set Test Variable    ${data}    {"email":"${emailInvalidLogin}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/login    data=${data}  headers=${headers}
    Log To Console    success login Response ${response}
	Log To Console    Body Response ${response.content}
	Should Be Equal  ${response.status_code}  ${400}
	${body}=  Set Variable  ${response.json()}