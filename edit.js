var id = localStorage.getItem('id4change');

function editUser() {
    console.log("editUser отработал!");
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
    window.location = "index.html";
}

window.onload = function() { 
    document.getElementById('save_btn').onclick = editUser;
    $.ajax({
        url		: './webServices.cfc?method=get',
        type	: 'POST',
        data	: {
            get_id	: id
        },
        dataType: 'json',
        success: function(response) {
            $('#firstName').val(response.DATA[0][1]);
            $('#middleName').val(response.DATA[0][2]);
            $('#lastName').val(response.DATA[0][3]);
            $('#phoneNumber').val(response.DATA[0][4]);
            $('#email').val(response.DATA[0][6]);
            $('#password').val(response.DATA[0][7]);
        }
    }); 
}