var http = require('http');
var fs = require('fs');
http.createrServer(function(request,response){
    response.writeHead(200,{'Content-Type': 'text/HTML'});
    fs.readFile('contact.html',null{
    	response.write(data);
    	response.end();
    })
}).listen(8180);
