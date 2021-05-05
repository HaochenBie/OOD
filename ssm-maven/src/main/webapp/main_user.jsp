<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>ssm-maven系统主页</title>
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
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAi22QldoqTNIvSH8bUTYnSniq7st7vryQ"></script>
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
                            "系统提示",
                            "您确定要退出系统吗",
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
                align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>CurrentUser：</strong>${currentUser.userName
                    }</font>【user】
            </td>
        </tr>
    </table>
</div>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div id="googleMap" style="width:100%;height:380px;"></div>
        <script>
  // 初始化地图
      function initialize() {
          var mapProp = {
              center:new google.maps.LatLng(37.09024,-95.71289100000001),
              zoom:4,
              mapTypeId:google.maps.MapTypeId.ROADMAP
          };
          map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
          
          var myLatLng = {lat: -25.363, lng: 131.044};
          var marker = new google.maps.Marker({
              position: myLatLng,
              map: map,
              title: 'Hello World!'
            });
     }
 
     google.maps.event.addDomListener(window, 'load', initialize);
     
 </script>
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
                    href="javascript:openTab(' 文章管理','articleManage.jsp','icon-wenzhang')"
                    class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-wenzhang'"
                    style="width: 150px;"> ArticleManagement</a>
        </div>
        <div title="PictureManage" data-options="iconCls:'icon-shouye'"
             style="padding:10px">
            <a
                    href="javascript:openTab(' 图片设置','pictureManage.jsp?type=1&grade=1','icon-tupians')"
                    class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-tupian'"
                    style="width: 150px;"> PictureSetting</a>
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
            <!-- <a href="javascript:openTab(' 管理员列表','userManage.jsp','icon-lxr')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-lxr'" style="width: 150px;">
                Admin list</a>--><a href="javascript:logout()"
                            class="easyui-linkbutton"
                            data-options="plain:true,iconCls:'icon-exit'"
                            style="width: 150px;">
            Logout</a>
        </div>
    </div>
</div>
</body>
</html>
