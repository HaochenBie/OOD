<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>pictureManger</title>
    <link href="${pageContext.request.contextPath}/css/base.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tab.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/item_do.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/uploadify.css" type="text/css"></link>

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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.uploadify.v2.0.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/swfobject.js"></script>
        <%
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
%>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
<body style="margin:1px;" id="ff">
<table id="dg" title="PictureManage" class="easyui-datagrid" pagination="true"
       rownumbers="true" fit="true" data-options="pageSize:10"
       url="${pageContext.request.contextPath}/picture/list.do?type=<%=type %>&grade=<%=grade %>"
       toolbar="#tb">
    <thead data-options="frozen:true">
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="10%" align="center" hidden="true">No.</th>
        <th field="path" width="300" align="center" formatter="formatProPic">Thumbnail</th>
        <th field="time" width="150" align="center">create time</th>
        <th field="url" width="150" align="center">editor</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openPictureAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">add</a> <a
            href="javascript:openPictureModifyDialog()"
            class="easyui-linkbutton" iconCls="icon-edit" plain="true">edit</a> <a
            href="javascript:deletePicture()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">delete</a>
    </div>
    <div>
        &nbsp;标题：&nbsp;<input type="text" id="url" size="20"
                              onkeydown="if(event.keyCode==13) searchPicture()"/>&nbsp; <a
            href="javascript:searchPicture()" class="easyui-linkbutton"
            iconCls="icon-search" plain="true">search</a>
    </div>
</div>
<div id="dlg" class="easyui-dialog"
     style="width: 600px;height:350px;padding: 10px 20px; position: relative; z-index:1000;"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post" enctype="multipart/form-data">
        <div style="padding-top:50px;  float:left; width:95%; padding-left:30px;">
            <div id="i_do_wrap">
                <div id="pic11" style="display:none;" class="i_do_div rel">

                </div>
                <div class="i_do_div rel" id="picture"><p class="i_do_tle r_txt abs font14">Show picture</p>
                </div>
                <div class="i_do_div rel" id="i_no_sku_stock_wrap"><p class="i_do_tle r_txt abs font14">Picture link</p>
                    <input type="text" id="desc" name="url" value="" required="true" class="easyui-validatebox" style="border:1px #9c9c9c solid;height:25px;"/>
                    <input type="hidden" name="type" value="<%=type%>"/>
                    <input type="hidden" name="grade" value="<%=grade%>"/>
                    <input type="hidden" name="time" id="time"/>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:savePicture()" class="easyui-linkbutton"
       iconCls="icon-ok">save</a> <a href="javascript:closePictureDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">close</a>
</div>


</body>
<script type="text/javascript">
    var url;

    function searchPicture() {
        $("#dg").datagrid('load', {
            "url": $("#url").val(),
        });
    }

    function deletePicture() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length == 0) {
            $.messager.alert("System", "Please select what you want to delete");
            return;
        }
        var strIds = [];
        for (var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].id);
        }
        var ids = strIds.join(",");
        $.messager.confirm("System", "Are you sure you want to delete <font color=red>"
                + selectedRows.length + "</font>？", function (r) {
            if (r) {
                $.post("${pageContext.request.contextPath}/picture/delete.do",
                        {
                            ids: ids
                        }, function (result) {
                            if (result.success) {
                                $.messager.alert("System", "Deletion successed");
                                $("#dg").datagrid("reload");
                            } else {
                                $.messager.alert("System", "Deletion failed");
                            }
                        }, "json");
            }
        });

    }
    function openPictureAddDialog() {
        $("#dlg").dialog("open").dialog("setTitle", "Add picture");
        var html = '<img name="uploadify2" id="uploadify2"  type="file" />';
        $('#picture').append(html);
        var imghtml = '<img src="images/back.jpg" width="110" height="110" id="img11"  style="display:none;"/><input type="text" id="input11" name="path" value="" style="display:none;" />';
        $('#pic11').append(imghtml);
        initUploadify();
        url = "${pageContext.request.contextPath}/picture/save.do";
    }


    function savePicture() {
        $("#fm").form("submit", {
            url: url,
            onSubmit: function () {
                return $(this).form("validate");
            },
            success: function (result) {
                if (result.success) {
                    $.messager.alert("System", "Saved");
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("reload");
                    resetValue();
                } else {
                    $.messager.alert("System", "Save failed");
                    window.location.reload();
                    return;
                }
            }
        });
    }

    function openPictureModifyDialog() {
        var selectedRows = $("#dg").datagrid('getSelections');
        var row = selectedRows[0];
        var html = '<img name="uploadify2" id="uploadify2"  type="file" />';
        $('#picture').append(html);
        var imghtml = '<img src="images/back.jpg" width="110" height="110" id="img11"  style="display:none;"/><input type="text" id="input11" name="path" value="' + row.path + '" style="display:none;" />';
        $('#pic11').append(imghtml);
        if (selectedRows.length != 1) {
            $.messager.alert("System", "Please pick what you want to edit");
            return;
        }
        initUploadify();
        $("#dlg").dialog("open").dialog("setTitle", "change data");
        $('#fm').form('load', row);
        url = "${pageContext.request.contextPath}/picture/save.do?id="
                + row.id;
    }

    function formatProPic(val, row) {
        return "<img width=100 height=100 src='${pageContext.request.contextPath}/" + val + "'>";
    }

    function resetValue() {
        $("#desc").val("");
        $("#path").val("");
        $('#picture').find('img').remove();
        $('#pic11').find('input').remove();
        $('#pic11').find('img').remove();
    }

    function closePictureDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function initUploadify() {
        $("#uploadify2").uploadify({
            'uploader': 'swf/uploadify2.swf', 			//flash文件的相对路径
            'script': '../loadimg/upload.do',  				
            'fileDataName': 'file', 						
            'cancelImg': 'images/cancel.png', 			
            'queueID': 'div_progress', 					
            'queueSizeLimit': 1, 							
            'fileDesc': '*.jpg;*.gif;*.png;*.ppt;*.pdf;*.jpeg', 	
            'fileExt': '*.jpg;*.gif;*.png;*.ppt;*.pdf;*.jpeg', 		
            'auto': true, 								
            'multi': true, 								
            'simUploadLimit': 1, 						
            'sizeLimit': 2048000,						
            'buttonText': 'Upload',						
            'displayData': 'percentage',     			
            'onComplete': function (evt, queueID, fileObj, response, data) {
                $("#img11").attr("src", "../" + response);
                $("#input11").val(response);
                $("#pic11").removeAttr("style");
                $("#img11").removeAttr("style");
                return false;
            },
            'onError': function (event, queueID, fileObj, errorObj) {
                if (errorObj.type === "File Size") {
                    alert("Max file size is 3M");
                    $("#uploadify").uploadifyClearQueue();
                }
            },
            'onQueueFull': function (event, queueSizeLimit) {
                alert("Picture limit is" + queueSizeLimit);
                return false;
            }
        });
    }
</script>
</head>

</html>