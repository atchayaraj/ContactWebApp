<!doctype html>
<html>
    <head>
        <%@page import = "java.io.IOException" %>
        <%@page import = "java.sql.SQLException" %>
        <%@page import = "java.sql.Statement"%>
        <%@page import = "java.sql.Connection" %>
        <%@page import = "java.sql.DriverManager" %>
        <%@page import = "java.sql.ResultSet" %>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <style >
            body {
                font-family: 'Poppins', sans-serif;
            }
        </style>
    </head>
    <body class="flex w-full h-screen bg-gray-200">
        <div class="flex flex-col relative bg-white w-96 h-[35rem] mx-auto my-auto rounded-xl" id="id">
            <div class="flex flex-row sticky top-0 border-b w-full">
                <span class="ml-4 my-4 font-bold">Create contact</span>
                <div class="ml-auto my-auto mr-4">
                    <span class="text-xs bg-gray-800 text-gray-100 px-6 py-2 rounded-lg hover:bg-gray-900 cursor-pointer" onClick = "formValidation()">Save</span>
                </div>
            </div>

            <ul class="overflow-y-auto mt-4">
                <!-- action="/" method="POST" name="myForm" -->
                <form id="form"  action="/" method="POST" enctype ='multipart/form-data'>
                </form>
            </ul>
            <div>
                <p id="p">
                </p>
            </div>
            <div class="ml-auto my-auto mr-4">
                <span class="text-xs bg-gray-800 text-gray-100 px-6 py-2 rounded-lg hover:bg-gray-900 cursor-pointer" onClick = "cancel()">Cancel</span>
            </div>
        </div>
    <script>
        var unOrderedList = document.getElementsByClassName("overflow-y-auto mt-4")[0];
        var form = document.getElementById("form");
        for(var i = 0; i<5;++i){
            var list = document.createElement("li");
            var input = document.createElement("input");
            list.className = "flex flex-col px-8 py-3";
            input.type = "text";
            input.className = "w-full border py-3 rounded-xl px-4 text-sm outline-none"
            switch(i){
                case 0:
                    var img = document.createElement("img");
                    img.src = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
                    img.className = "w-16 h-16 rounded-full mx-auto";
                    var label = document.createElement("label");
                    input.type = "file";
                    input.id = "file"
                    input.style.visibility = "hidden";
                    input.className = "";
                    input.name = "image";
                    input.accept = "image/*";
                    label.className = "mx-auto text-xs cursor-pointer hover:underline mt-2";
                    label.setAttribute("for","file");
                    label.innerHTML = "Upload";
                    list.appendChild(img);
                    list.appendChild(label);
                    list.appendChild(input);
                break;
                case 1:
                    input.placeholder = "First name";
                    input.name = "fname";
                    input.id = "fName";
                    list.appendChild(input);
                break;
                case 2:
                    input.placeholder = "Last name";
                    input.name = "lname";
                    input.id = "lName";
                    list.appendChild(input);
                break;
                case 3:
                    input.placeholder = "Phone number";
                    input.pattern = "[0-9]{9}[0-9]{1}";
                    input.name = "number";
                    input.id = "Number";
                    input.maxlength = "10";
                    list.appendChild(input);
                break;

            }
            form.appendChild(list);
            unOrderedList.appendChild(form);
        }
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        function formValidation(){
            var fname = document.getElementById("fName").value;
            var lname = document.getElementById("lName").value;
            var number = document.getElementById("Number").value;
            var image = document.getElementById("file").value;
            var phonenumber = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;
            if((fname == null || fname == "" ) &&(lname == null || lname == "")){
                alert("Name field can't be empty ");
                return false;
            }
            else if(fname.length >= 15 || lname.length >= 15){
                alert("Name maxlength should be within 20 ");
                return false;
            }
            else if(!phonenumber.test(number)){
                alert("Number field should contain only numeric value ");
                return false;
            }
            validateDuplicate();   
        }
        function validateDuplicate(){
            var form = document.getElementById("form");
            var number = document.getElementById("Number").value;
                <%Connection connection = null;    %>
                <% try{
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Raj","atchaya-15816","vinci@Da22raj");
                    Statement statement = connection.createStatement();
                    String query = "select * from contactDetails";
                    ResultSet result = statement.executeQuery(query);
            %> 
            <%while(result.next()){ %>
                if(number == "<%= result.getString("number") %>"){
                    alert("Contact Number is alreay exists");
                    return false;
                }
            <%}}catch(SQLException e){}%>
            // alert("Contact Created");
            // document.getElementById("form").submit();
            $(document).ready(function(){
                $("form").submit(function(event){
                    event.preventDefault();
                });
            });
            $("form").submit();
            // $("#id").load("/");
        }
    </script>
    <script type="text/javascript">
        function cancel(){
            $(document).ready(function(){
                $("#id").load("/");
            });
        }
    </script>
    </body>
</html>