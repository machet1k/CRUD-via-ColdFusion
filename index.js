function printData() {
    $.ajax({
        url		: './webServices.cfc?method=print',
        type	: 'GET',
        async   : false,
        dataType: 'json',
        success: function(response) {
            var tableUsers = document.querySelector('#tableContent');
            var str = '<tr><th>First name</th>'
            +'<th>Middle name</th>'
            +'<th>Last name</th>'
            +'<th>Phone number</th>'
            +'<th>Reg. date</th>'
            /*+'<th>Email</th>'
            +'<th>Password</th>'*/
            +'<th colspan="2">Actions</th></tr>';
            for (var i = 0; i < response.DATA.length; i++) {
                str += '<tr>';
                for (var j = 1; j < response.DATA[i].length; j++) {
                    if (j != 6 && j != 7) str += '<td>' + response.DATA[i][j] + '</td>';
                }
                str += '<td onclick="getUser('+response.DATA[i][0]+')" style="width: 50px">'
                    +'<img src="https://cdn4.iconfinder.com/data/icons/48-bubbles/48/15.Pencil-20.png" alt=""></td>'
                    +'<td onclick="deleteUser('+response.DATA[i][0]+')" style="width: 50px"><img src="https://cdn4.iconfinder.com/data/icons/e-commerce-icon-set/48/Remove_2-20.png" alt=""></td></tr>';
            }
            
            tableUsers.innerHTML = str;
        }
    });
}

function addUser() {
    var firstName	= $('#firstName').val();
    var middleName	= $('#middleName').val();
    var lastName	= $('#lastName').val();
    var phoneNumber	= $('#phoneNumber').val();
    var email	    = $('#email').val();
    var password	= $('#password').val();        

    $.ajax({
        url		: './webServices.cfc?method=add',
        type	: 'POST',
        async   : false,
        data	: {
            firstName	: firstName,
            middleName	: middleName,
            lastName	: lastName,
            phoneNumber	: phoneNumber,
            email	    : email,
            password	: password   
        },
        dataType: 'json',
        success: function(response) {
            console.log(response);
        }
    });
    printData();
}

function deleteUser(id) {

    $.ajax({
        url		: './webServices.cfc?method=delete',
        type	: 'POST',
        async   : false,
        data	: {
            del_id	: id
        },
        dataType: 'json',
        success: function(response) {
            console.log(response);
        }
    });
    printData();
}

function getUser(id) {
    localStorage.setItem('id4change', id);
    window.location = "edit.html"; 
}

function editUser() {
    var id	        = $('#edit_id').val();
    var firstName	= $('#firstName').val();
    var middleName	= $('#middleName').val();
    var lastName	= $('#lastName').val();
    var phoneNumber	= $('#phoneNumber').val();
    var email	    = $('#email').val();
    var password	= $('#password').val();    

    $.ajax({
        url		: './webServices.cfc?method=edit',
        type	: 'POST',
        async   : false,
        data	: {
            edit_id	    : id,
            firstName	: firstName,
            middleName	: middleName,
            lastName	: lastName,
            phoneNumber	: phoneNumber,
            email	    : email,
            password	: password
        },
        dataType: 'json',
        success: function(response) {
            console.log(response);
        }
    });
    printData();
}

window.onload = function() {
    printData();
    document.getElementById('add_btn').onclick = addUser; 
}