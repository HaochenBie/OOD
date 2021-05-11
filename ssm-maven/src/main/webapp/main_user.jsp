<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PocketDoc Demo</title>
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
                            "System",
                            "Sure you want to logout",
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
          
          var myLatLng = {lat: 43.028948, lng: -76.110672};
          var myLatLng1 = {lat: 43.021908, lng: -76.110560};
          var myLatLng2 = {lat: 43.047151, lng: -76.129355};
          var myLatLng3 = {lat: 43.042579, lng: -76.136934};
          var myLatLng4 = {lat: 43.043710, lng: -76.158492};
          var marker = new google.maps.Marker({
              position: myLatLng,
              map: map,
              title: 'Walgreens Pharmacy'
            });
          var marker1 = new google.maps.Marker({
              position: myLatLng1,
              map: map,
              title: 'cvs'
            });
          var marker2 = new google.maps.Marker({
              position: myLatLng2,
              map: map,
              title: 'Walgreens Pharmacy'
            });
          var marker3 = new google.maps.Marker({
              position: myLatLng3,
              map: map,
              title: 'Kinney Drugs'
            });
          var marker4 = new google.maps.Marker({
              position: myLatLng4,
              map: map,
              title: 'Westside Family Pharmacy LLC'
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
                    href="javascript:openTab(' Aritcle','articleManageUser.jsp','icon-wenzhang')"
                    class="easyui-linkbutton"
                    data-options="plain:true,iconCls:'icon-wenzhang'"
                    style="width: 150px;"> Article</a>
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
            <!-- <a href="javascript:openTab(' AdminList','userManage.jsp','icon-lxr')"
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
