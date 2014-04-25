var jsonheaders = {'Content-Type': 'text/json; charset=utf-8','Access-Control-Allow-Origin':'*'};



var http = require('http');
var mysql = require('mysql');
var mysqlUtilities = require('mysql-utilities');
var url = require('url');
var crypto = require('crypto');


var connection = mysql.createConnection({
    host:     'localhost',
    user:     'root',
    password: '',
    database: 'airport'
});
connection.connect();
// Mix-in for Data Access Methods and SQL Autogenerating Methods
mysqlUtilities.upgrade(connection);

// Mix-in for Introspection Methods
mysqlUtilities.introspection(connection);


function Airplane(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT aiplanes.* FROM airplanes WHERE airplanes.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Airport(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT airports.* FROM airports WHERE airports.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Airports(callback) {
    //console.log(uid);
    connection.query('SELECT airports.* FROM airports WHERE 1', [], function(err, rows, fields) {
        if (rows) callback(rows);
        else console.log(err);
    });
}
function Company(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT companies.* FROM companies WHERE companies.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Flight(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT flights.*, airplanes.id airplane_id, airplanes.model_id airplane_model_id, airplanes.company_id airplane_company_id, models.name model_name, companies.name company_name, a1.name from_name, a2.name to_name, statuses.name status_name FROM flights LEFT JOIN airplanes ON airplanes.id = flights.airplane_id LEFT JOIN models ON models.id = airplanes.model_id LEFT JOIN companies ON companies.id = airplanes.company_id LEFT JOIN airports a1 ON a1.id = flights.from_id LEFT JOIN airports a2 ON a2.id = flights.to_id LEFT JOIN statuses ON statuses.id = flights.status_id  WHERE flights.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}

function FlightByFrom(id, callback) {
    //console.log(uid);
    connection.query('SELECT flights.*, airplanes.id airplane_id, airplanes.model_id airplane_model_id, airplanes.company_id airplane_company_id, models.name model_name, companies.name company_name, a1.name from_name, a2.name to_name, statuses.name status_name FROM flights LEFT JOIN airplanes ON airplanes.id = flights.airplane_id LEFT JOIN models ON models.id = airplanes.model_id LEFT JOIN companies ON companies.id = airplanes.company_id LEFT JOIN airports a1 ON a1.id = flights.from_id LEFT JOIN airports a2 ON a2.id = flights.to_id LEFT JOIN statuses ON statuses.id = flights.status_id  WHERE flights.from_id = ?',
                 [id], function(err, rows, fields) {
        if (rows) callback(rows);
        else console.log(err);
    });
}

function FlightByTo(id, callback) {
    //console.log(uid);
    connection.query('SELECT flights.*, airplanes.id airplane_id, airplanes.model_id airplane_model_id, airplanes.company_id airplane_company_id, models.name model_name, companies.name company_name, a1.name from_name, a2.name to_name, statuses.name status_name FROM flights LEFT JOIN airplanes ON airplanes.id = flights.airplane_id LEFT JOIN models ON models.id = airplanes.model_id LEFT JOIN companies ON companies.id = airplanes.company_id LEFT JOIN airports a1 ON a1.id = flights.from_id LEFT JOIN airports a2 ON a2.id = flights.to_id LEFT JOIN statuses ON statuses.id = flights.status_id  WHERE flights.to_id = ?',
    			 [id], function(err, rows, fields) {
        if (rows) callback(rows);
        else console.log(err);
    });
}

function Model(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT models.* FROM models WHERE models.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Passenger(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT passengers.* FROM passengers WHERE passengers.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Status(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT statuses.* FROM statuses WHERE statuses.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}
function Ticket(id, callback) {
    //console.log(uid);
    connection.queryRow('SELECT tickets.* FROM tickets WHERE tickets.id = ?', [id], function(err, row) {
        if (row) callback(row);
        else console.log(err);
    });
}

http.createServer(function (req, res) {
  var query = url.parse(req.url,true).query;


switch (query.a) {
	case 'get_airports':
		Airports(function (a) {
			if (a) {
			res.writeHead(200, jsonheaders);
		  	res.end(JSON.stringify(a));
		  	} else console.log('error');
		});	  
  	break;

    case 'get_flights':
        if (query.i) {
            if (query.by == 'to') {
                FlightByTo(query.i,function(a){
                    if (a) {
                    res.writeHead(200, jsonheaders);
                    res.end(JSON.stringify(a));
                    } else console.log('error');
                });
            } else {
                FlightByFrom(query.i,function(a){
                    if (a) {
                    res.writeHead(200, jsonheaders);
                    res.end(JSON.stringify(a));
                    } else console.log('error');
                });
            }
        } else {
            res.writeHead(200, jsonheaders);
            res.end(JSON.stringify({'result':'error'}));
        }

    break;

    case "flight_info":
        if (query.i) {
            Flight(query.i,function(a){
                if (a) {
                    res.writeHead(200, jsonheaders);
                    res.end(JSON.stringify(a));
                } else console.log('error');
            });
        } else {
            res.writeHead(200, jsonheaders);
            res.end(JSON.stringify({'result':'error'}));
        }
    break;

  	default:
  		res.writeHead(200, jsonheaders);
		res.end(JSON.stringify({'result':'error'}));
  	break;
}

 }).listen(8080);


console.log('Server running on port 8080.');