<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PockectDoc Demo</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-en.js"></script>
    <script type="text/javascript">
        var url;
        function addTab(url, text, iconCls) {
            var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/views/"
                    + url + "'></iframe>";
            $("#tabs").tabs("add", {
                title: text,
                iconCls: iconCls,
                closable: true,
                content: content
            });
        }
        function openTab(text, url, iconCls) {
            if ($("#tabs").tabs("exists", text)) {
                $("#tabs").tabs("close", text);
                addTab(url, text, iconCls);
                $("#tabs").tabs("select", text);
            } else {
                addTab(url, text, iconCls);
            }
        }

        function logout() {
            $.messager
                    .confirm(
                            "System Warning",
                            "Sure you want to logout?",
                            function (r) {
                                if (r) {
                                    window.location.href = "${pageContext.request.contextPath}/user/logout.do";
                                }
                            });
        }
    </script>
    <jsp:include page="login_chk.jsp"></jsp:include>
<body class="easyui-layout">
<div region="north" style="height: 78px;background-color: #ffff">
    <table width="100%">
        <tr>
            <td width="50%"></td>
            <td valign="bottom"
                style="font-size: 20px;color:#8B8B8B;font-family: '楷体';"
                align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>CurrentAdmin：</strong>${currentUser.userName
                    }</font>【Admin】
            </td>
        </tr>
    </table>
</div>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="Front Page" data-options="iconCls:'icon-home'">
                        <div align="center" style="padding-top: 20px;"><a
                    
                    target="_blank" style="font-size: 70px;">PocketDoc</a>
            </div>
            <div align="center" style="padding-top: 20px;"><a href="https://github.com/HaochenBie/OOD"
                                                              target="_blank"
                                                              style="font-size: 20px;">Github address</a></div>

            <div align="center" style="padding-top: 50px;"><a
                    
                    target="_blank" style="font-size: 20px;">Sitao Wang, Haochen Bie, Weilai Mao, Zedong Wang, Haopu Wu</a>
            </div>
            <div align="center" style="padding-top: 20px;"><a
                    
                    target="grey" style="font-size: 20px;">#Admin Page#</a>
            </div>
            <div align="center" style="padding-top: 50px">
                <font color="grey" size="10">Project demo</font>
            </div>
        </div>
    </div>
</div>
<div region="west" style="width: 200px;height:500px;" title="Menu"
     split="true">
    <div class="easyui-accordion">
        <div title="ArticleManage"
             data-options="selected:true,iconCls:'icon-wenzhangs'"
             style="padding: 10px;height:10px;">
            <a
                    href="javascript:openTab(' ArticleManage','articleManage.jsp','icon-wenzhang')"
                    class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-wenzhang'"
                    style="width: 150px;"> ArticleManagement</a>
        </div>
        
        <div title="Medicine Manage" data-options="iconCls:'icon-shuji'"
             style="padding:10px">
            <a
                    href="javascript:openTab(' All medicine','allBooksManage.jsp','icon-shuben')"
                    class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-shuben'"
                    style="width: 150px;">Drugs</a>
        </div>
        <div title="UserManage" data-options="iconCls:'icon-item'"
             style="padding:10px;border:none;">
            <a href="javascript:openTab(' AdminList','userManage.jsp','icon-lxr')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-lxr'" style="width: 150px;">
                Admin list</a><a href="javascript:logout()"
                            class="easyui-linkbutton"
                            data-options="plain:true,iconCls:'icon-exit'"
                            style="width: 150px;">
            Logout</a>
        </div>
    </div>
</div>
</body>
</html>
