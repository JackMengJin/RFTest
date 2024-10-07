*** Settings ***
Library           DateTime
Library           Collections
Library           BuiltIn
Library           SeleniumLibrary

*** Variables ***
${globsl_scalar}    globsl_scalar    # 定义全局标量
@{global_list}    Jack    Maker    Tester    # 定义全局列表
&{global_dict}    name=Tester    age=13    # 定义全局字典

*** Test Cases ***
test01
    log    测试一下    # 打印该信息
    ${date}    Get Current Date
    Should Be Equal    100    100
    add_function    23    17    # 调用这个关键字
    # 定义标量
    ${var_scalar}    Set Variable    hello!
    Log    ${var_scalar}
    # 定义列表
    @{var_list}    Create List    test01    test02    test03
    log    ${var_list}
    log many    @{var_list}
    # 定义字典
    &{var_dict}    Create Dictionary    name=Jack    age=16
    log    ${var_dict}
    log many    &{var_dict}
    # 将变量设置为全局变量
    Set Global Variable    ${var_scalar}

test02
    log    ${globsl_scalar}
    log many    @{global_list}
    log many    &{global_dict}

test03
    # IF判断
    ${var_money}    Set Variable    100
    Run Keyword If    ${var_money}>=50    log    buy
    ...    ELSE IF    ${var_money}>=50    log    gohome
    ...    ELSE    log    workhard
    # FRO循环
    FOR    ${item}    IN    @{global_list}
        LOG    ${item}
        Exit For Loop If    "${item}" == "Jack"
    END
    # FRO循环-IN RANGE
    FOR    ${num}    IN RANGE    5
        LOG    ${num}
        Exit For Loop If    "${num}" == "3"
    END

test04
    Open Browser    https://www.baidu.com/    chrome    # 用谷歌浏览器打开网址
    Maximize Browser Window    # 最大化浏览器
    ${title}    Get Title    # 获取标题
    Comment    Title Should Be    百度一下，你就知道    # 标题断言1
    Comment    Should Be Equal    ${title}    百度一下，你就知道    # 标题断言2
    Run Keyword If    "${title}"=="百度一下，你就知道"    log    测试通过    # 断言3-IF判断
    ...    ELSE    log    测试不通过
    input text    kw    selenium如何使用
    Click Element    //*[@id="su"]    # 点击百度一下
    Sleep    4
    Close All Browsers    # 关闭浏览器
        ${/}

*** Keywords ***
add_function
    [Arguments]    ${num1}    ${num2}
    [Documentation]    运算符不能直接使用，使用python语法需要借助关键字
    Log    10+20
    ${result}    Evaluate    ${num1}+${num2}    # 用evaluate关键字
