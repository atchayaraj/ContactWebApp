
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com">
        </script>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
            }
        </style>
    </head>
    <body class="flex w-full h-screen bg-gray-200">
        <div class="flex flex-col relative bg-white w-96 h-[35rem] mx-auto my-auto rounded-xl" id= "id">
            <div class="flex flex-row sticky top-0 border-b w-full">
                <span class="ml-4 my-4 font-bold">Contacts</span>
                <div class="ml-auto my-auto mr-4">
                    <span class="text-xs bg-gray-800 text-gray-100 px-6 py-2 rounded-lg hover:bg-gray-900 cursor-pointer" onclick="myFunction()">New</span>
                </div>
            </div>
            <%@page import = "java.io.IOException" %>
            <%@page import = "java.sql.SQLException" %>
            <%@page import = "java.sql.Statement"%>
            <%@page import = "java.sql.Connection" %>
            <%@page import = "java.sql.DriverManager" %>
            <%@page import = "java.sql.ResultSet" %>
            <%Connection connection = null;    %>
             <% try{
                connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Raj","atchaya-15816","vinci@Da22raj");
                Statement statement = connection.createStatement();
                String query = "select * from contactDetails";
                ResultSet result = statement.executeQuery(query);
            %>           
            <ul class="overflow-y-auto"></ul>
        </div>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        function myFunction(){
            $(document).ready(function(){
                $("#id").load("newContact.jsp");
            });
        }
    </script>
    <script>
        var unOrderedList = document.getElementsByClassName('overflow-y-auto')[0];
        <% if(result.next() == false){ %>
            var para = document.createElement("p");
            para.innerHTML = "No Contacts Found";
            para.setAttribute('style','padding-left: 100px; padding-top: 190px; font-weight: 700;font-size: 20; ')
            unOrderedList.appendChild(para);
       <% }%>
        <%while(result.next()){ %>            
            var list =  document.createElement('li');
            var img = document.createElement('img');
            var div = document.createElement('div');
            var span = document.createElement('span');
            var span1 = document.createElement('span1');
            img.src = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
            <%if(!result.getString("address").equals("")){   %>             
                img.src = "../images/"+"<%= result.getString("address")%>";          
            <%}%>
            span.innerHTML= "<%= result.getString("name") %>";
            span1.innerHTML = "<%= result.getString("number") %>";
            span.className = 'font-semibold text-sm';
            span1.className = 'text-gray-700 text-xs';
            div.className = 'flex flex-col my-auto ml-4';
            img.className = 'my-auto w-10 h-10 rounded-full';
            list.id = 'list';
            list.className = 'flex flex-row px-8 border-b py-3 border-gray-50 cursor-pointer hover:bg-gray-50 hover:border-gray-50';
            div.appendChild(span); 
            div.appendChild(span1);
            list.appendChild(img);
            list.appendChild(div);   
            unOrderedList.appendChild(list);           
        <%}}catch(SQLException e){}%>
    </script>
    </html>