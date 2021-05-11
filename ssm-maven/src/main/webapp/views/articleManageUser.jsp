<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>articleManger</title>
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
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/ueditor/ueditor.config.js">

    </script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js">

    </script>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>

</head>
<body style="margin:1px;" id="ff">
<table id="dg" title="ArticleManagement" class="easyui-datagrid" pagination="true"
       rownumbers="true" fit="true" data-options="pageSize:10"
       url="${pageContext.request.contextPath}/article/list.do" toolbar="#tb">
    <thead data-options="frozen:true">
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="10%" align="center" hidden="true">No.</th>
        <th field="articleTitle" width="200" align="center">title</th>
        <th field="articleCreateDate" width="150" align="center">create time</th>
        <th field="addName" width="150" align="center">editor</th>
        <th field="content" width="70" align="center"
            formatter="formatHref">
        </th>
    </tr>
    </thead>
</table>
<div id="tb">
    
    <div>
        &nbsp;title：&nbsp;<input type="text" id="articleTitle" size="20"
                              onkeydown="if(event.keyCode==13) searchArticle()"/>&nbsp; <a
            href="javascript:searchArticle()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">search</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog"
     style="width: 850px;height:555px;padding: 10px 20px; position: relative; z-index:1000;"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>Title：</td>
                <td><input type="text" id="title" name="articleTitle"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>Editor：</td>
                <td><input type="text" id="addName" name="addName"/>
                    <input type="text" id="articleCreateDate" name="articleCreateDate" type="hidden"
                           style="display:none;"/>
                </td>
            </tr>
            <tr>
                <td>Details</td>
                <td id="editor">
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveArticle()" class="easyui-linkbutton"
       iconCls="icon-ok">Save</a> <a href="javascript:closeArticleDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">Close</a>
</div>


<script type="text/javascript">
    var url;
    function ResetEditor() {
        UE.getEditor('myEditor', {
            initialFrameHeight: 480,
            initialFrameWidth: 660,
            enableAutoSave: false,
            elementPathEnabled: false,
            wordCount: false,
            /*  toolbars: [
             [
             'fontfamily', 'fontsize', 'forecolor', 'backcolor', 'bold', 'italic', 'underline', '|',
             'link', '|',
             ]
             ]  */
        });
    }
    function searchArticle() {
        $("#dg").datagrid('load', {
            "articleTitle": $("#articleTitle").val(),
        });
    }

    function deleteArticle() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length == 0) {
            $.messager.alert("System", "Please click on the data that you want to delete");
            return;
        }
        var strIds = [];
        for (var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].id);
        }
        var ids = strIds.join(",");
        $.messager
                .confirm(
                        "System",
                        "Are you sure you want to delete <font color=red>" + selectedRows.length
                        + "</font>？",
                        function (r) {
                            if (r) {
                                $
                                        .post(
                                                "${pageContext.request.contextPath}/article/delete.do",
                                                {
                                                    ids: ids
                                                },
                                                function (result) {
                                                    if (result.success) {
                                                        $.messager.alert(
                                                                "System",
                                                                "Deletion complete");
                                                        $("#dg").datagrid(
                                                                "reload");
                                                    } else {
                                                        $.messager.alert(
                                                                "System",
                                                                "Deletion failed");
                                                    }
                                                }, "json");
                            }
                        });

    }

    function openArticleAddDialog() {
        var html = '<div id="myEditor" name="articleContent"></div>';
        $('#editor').append(html);
        ResetEditor(editor);
        var ue = UE.getEditor('myEditor');
        ue.setContent("");
        $("#dlg").dialog("open").dialog("setTitle", "add text");
        url = "${pageContext.request.contextPath}/article/save.do";
    }

    function saveArticle() {
        $("#fm").form("submit", {
            url: url,
            onSubmit: function () {
                return $(this).form("validate");
            },
            success: function (result) {
                $.messager.alert("System", "saved");
                $("#dlg").dialog("close");
                $("#dg").datagrid("reload");
                resetValue();
            }
        });
    }

    function openArticleModifyDialog() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length != 1) {
            $.messager.alert("system waring", "pick the data to edit");
            return;
        }
        var row = selectedRows[0];
        $("#dlg").dialog("open").dialog("setTitle", "change info");
        $('#fm').form('load', row);
        var html = '<div id="myEditor" name="articleContent"></div>';
        $('#editor').append(html);
        ResetEditor(editor);
        var ue = UE.getEditor('myEditor');
        ue.addListener("ready", function () { 
        	ue.setContent(row.articleContent);
        });
        //ue.setContent(row.articleContent);
        url = "${pageContext.request.contextPath}/article/save.do?id="
                + row.id;
    }

    function formatHref(val, row) {
        return "<a href='${pageContext.request.contextPath}/article.html?id=" + row.id + "' target='_blank'>details</a>";
    }

    function resetValue() {
        $("#title").val("");
        $("#addName").val("");
        $("#container").val("");
        ResetEditor();
    }

    function closeArticleDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }
</script>
</body>
</html>