<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
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

        function searchUser() {
            $("#dg").datagrid('load', {
                "userName": $("#s_userName").val()
            });
        }

        function deleteUser() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length == 0) {
                $.messager.alert("System", "Please selete the data");
                return;
            }
            var strIds = [];
            for (var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("System", "Are you sure to delete <font color=red>"
                    + selectedRows.length + "</font>？", function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/user/delete.do", {
                        ids: ids
                    }, function (result) {
                        if (result.success) {
                            $.messager.alert("System", "Deletion succesed");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("System", "Deletion failed");
                        }
                    }, "json");
                }
            });

        }

        function openUserAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "Add user info");
            url = "${pageContext.request.contextPath}/user/save.do";
        }

        function saveUser() {
            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    $.messager.alert("System", "Saved");
                    resetValue();
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("reload");
                }
            });
        }

        function openUserModifyDialog() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length != 1) {
                $.messager.alert("System", "Please select the files");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "edit user info");
            $('#fm').form('load', row);
            $("#password").val("******");
            url = "${pageContext.request.contextPath}/user/save.do?id=" + row.id;
        }

        function resetValue() {
            $("#userName").val("");
            $("#password").val("");
        }

        function closeUserDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }
    </script>
</head>
<body style="margin:1px;">
<table id="dg" title="UserManage" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/user/list.do" fit="true"
       toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">No.</th>
        <th field="userName" width="100" align="center">Username</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">add</a> <a
            href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">edit</a> <a
            href="javascript:deleteUser()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">delete</a>
    </div>
    <div>
        &nbsp;Username：&nbsp;<input type="text" id="s_userName" size="20"
                               onkeydown="if(event.keyCode==13) searchUser()"/> <a
            href="javascript:searchUser()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">search</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog"
     style="width: 620px;height:250px;padding: 10px 20px" closed="true"
     buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>Username：</td>
                <td><input type="text" id="userName" name="userName"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>Password：</td>
                <td><input type="password" id="password" name="password"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveUser()" class="easyui-linkbutton"
       iconCls="icon-ok">Save</a> <a href="javascript:closeUserDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">Close</a>
</div>
</body>
</html>