<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>allBooksManger</title>
    <link href="${pageContext.request.contextPath}/css/base.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tab.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item.css"
          type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item_do.css"
          type="text/css" rel="stylesheet">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/uploadify.css"
          type="text/css">
</head>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
        src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/jquery.uploadify.v2.0.3.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/swfobject.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function openUserModifyDialog() {
    var selectedRows = $("#dg").datagrid('getSelections');
    console.log(selectedRows);
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
    $('#fm').form('load', row);
    $("#password").val("******");
    url = "${pageContext.request.contextPath}/book/update.do?id=" + row.id;
}
</script>
<body style="margin:1px;" id="ff">
<table id="dg" title="Medication Management" class="easyui-datagrid" pagination="true"
       rownumbers="true" fit="true" data-options="pageSize:10"
       url="${pageContext.request.contextPath}/book/listAll.do" toolbar="#tb">
    <thead data-options="frozen:true">
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="10" align="center" hidden="true">编号</th>
        <th field="subtitle" width="10" align="center" hidden="true">副标题</th>
        <th field="title" width="110" align="center">TradeName</th>
        <th field="author" width="100" align="center">Manufacturer</th>
        <th field="isbn" width="120" align="center">NDC Code</th>
        <th field="path" width="100" align="center" formatter="formatProPic">Picture</th>
        <th field="marketPrice" width="70" align="center">Price</th>
        <th hidden field="pages" width="50" align="center">页数</th> 
        <th field="publisher" width="120" align="center">Desease</th>
        <th hidden field="binding" width="10" align="center" hidden="true">装订方式</th>
        <th field="hot" width="10" align="center" hidden="true">热度值</th>
        <th field="status" width="70" align="center"
            formatter="formatStatus">Status
        </th>
        <th field="supply" width="50" align="center">commit</th>
    </tr>
    </thead>
</table>
<div id="tb">
	<div>
        <a href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">add comment</a> <a
            
    </div>
    <div>
        &nbsp;TradeName：&nbsp;<input type="text" id="biaoti" size="20"
                              onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp;&nbsp;Manufacturer：&nbsp;<input
            type="text" id="zuozhe" size="20"
            onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp;
        &nbsp;NDC Code：&nbsp;<input type="text" id="bianma" size="20"
                                 onkeydown="if(event.keyCode==13) searchBook()"/>
                                 &nbsp;Desease：&nbsp;<input type="text" id="publisher" size="20"
                                 onkeydown="if(event.keyCode==13) searchBook()"/>&nbsp; <a
            href="javascript:searchBook()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">Search</a>
    </div>
</div>
<div id="dlg" class="easyui-dialog"
     style="width: 620px;height:250px;padding: 10px 20px" closed="true"
     buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>用户名：</td>
                <td><input type="text" id="supply" name="supply"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>
            
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:saveUser()" class="easyui-linkbutton"
       iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<div id="dlg_c" class="easyui-dialog"
     style="width: 300px;height:450px;padding: 10px 20px; position: relative; z-index:1000;"
     closed="true" buttons="#dlg_c-buttons">
    <form id="fm_c" method="post">
        <table cellspacing="8px" id="tab">
        </table>
    </form>
</div>

</body>
<script type="text/javascript">
    var url;

    function searchBook() {
        $("#dg").datagrid('load', {
            "title": $("#biaoti").val(),
            "author": $("#zuozhe").val(),
            "isbn": $("#bianma").val(),
            "publisher": $("#publisher").val(),
        });
    }


    function openbookInfoPage(id) {
        window.parent.openTab('书籍摆放信息', 'storeInfo.jsp?id=' + id,
                'icon-shujias');
    }

    function formatProPic(val, row) {
        return "<img width=80 height=110 src='../" + val + "'>";
    }
    function formatStatus(val, row) {
        if (row.status == 1)
            return "<div style='color:red;'>Available</div>";
        else
            return "<div style='color:gray;'>Unavailable</div>";
    }
    function closeUserDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }
    function saveUser() {
        $("#fm").form("submit", {
            url: url,
            onSubmit: function () {
                return $(this).form("validate");
            },
            success: function (result) {
                $.messager.alert("系统提示", "保存成功");
                resetValue();
                $("#dlg").dialog("close");
                $("#dg").datagrid("reload");
            }
        });
    }
    function resetValue() {
        $("#userName").val("");
        $("#password").val("");
    }

</script>
</html>