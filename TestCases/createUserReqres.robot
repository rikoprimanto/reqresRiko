*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}                 https://reqres.in
${endpoint}                 /api/users
${name}                     morpheus
${job}                      leader

*** Keywords ***
verifiy success create
    Create Session    reqres    ${base_url}/api/users verify=True
    Set Test Variable    ${data}    {"name":"${name}","job":${job}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/users    data=${data}  headers=${headers}
    Log To Console    Create Users Response ${response}
	Log To Console    Create Users Body Response ${response.content}
	Should Be Equal  ${response.status_code}  ${201}
	${body}=  Set Variable  ${response.json()}	
	Set Global Variable     ${name}
	Set Global Variable     ${job}

verifiy failed create
    Create Session    reqres    ${base_url}/api/users verify=True
    Set Test Variable    ${data}    {"name":"${name}"}
    ${headers}=  Create Dictionary
    ${response}    POST On Session    reqres    /api/users    data=${data}  headers=${headers}
    Log To Console    Failed Create Users Response ${response}
	Log To Console    Failed Create Users Body Response ${response.content}
	Should Be Equal  ${response.status_code}  ${400}
	${body}=  Set Variable  ${response.json()}	
	Set Global Variable     ${name}
	Set Global Variable     ${job}
