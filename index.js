var sortBy = localStorage.getItem('sortBy');

window.onresize = function() {
    $('#content').css('height', $(window).height() - 180);
    $('#tableForm').css('left', ($(window).width() - $('#tableContent').width()) / 2);
    $('#tableContent').css('left', ($(window).width() - $('#tableContent').width()) / 2);
}

window.onload = function() {
    $('#content').css('height', $(window).height() - 180);
    $('#tableForm')   .css('left', ($(window).width() - $('#tableContent').width()) / 2);
    $('#tableContent').css('left', ($(window).width() - $('#tableContent').width()) / 2);
    
    if (sortBy != null) printData(sortBy);
    else printData('regDate_asc');
    
    document.getElementById('add_btn').onclick = addUser; 
}

function print(out) {
    var tableUsers = document.getElementById('tableContent');
    var str = '';
    for (var i = 0; i < out.DATA.length; i++) {
        str += '<tr>';
        for (var j = 1; j < out.DATA[i].length; j++) {
            if (j != 6 && j != 7) str += '<td>' + out.DATA[i][j] + '</td>';
        }
        str += '<td onclick="getUser('+out.DATA[i][0]+')" style="width: 50px">'
            +'<img src="https://cdn4.iconfinder.com/data/icons/48-bubbles/48/15.Pencil-20.png" alt=""></td>'
            +'<td onclick="deleteUser('+out.DATA[i][0]+')" style="width: 50px"><img src="https://cdn4.iconfinder.com/data/icons/e-commerce-icon-set/48/Remove_2-20.png" alt=""></td></tr>';
    }
    tableUsers.innerHTML = str;
}

function printData(sortBy) {
    localStorage.setItem('sortBy', sortBy);
    $.ajax({
        url		: './webServices.cfc',
        type	: 'GET',
        async   : false,
        data	: {
            method : sortBy
        },
        dataType: 'json',
        success : function(response) {
            print(response);
        }
    });
}

function addUser() {
    var firstName	= $.trim($('#firstName').val());
    var middleName	= $.trim($('#middleName').val());
    var lastName	= $.trim($('#lastName').val());
    var phoneNumber	= $.trim($('#phoneNumber').val());       
    
    var regexp_names = /[А-ЯЁа-яёA-Za-z\-]/;
    var regexp_phone = /(\+{1})+([0-9]{1,3})+(\-{1})+([0-9]{3})+(\-{1})+([0-9]{7})/;
    
    if (!regexp_names.test(firstName)) {
        alert("Неверное имя!\r\nРазрешается использовать только буквы русского и латинского алфавитов.");
        return;
    }
    if (!regexp_names.test(middleName)) {
        alert("Неверное второе имя (отчество)!\r\nРазрешается использовать только буквы русского и латинского алфавитов и символ '-' (дефис) в случае отсутствия отчества и/или среднего имени.");
        return;
    }
    if (!regexp_names.test(lastName)) {
        alert("Неверное фамилия!\r\nРазрешается использовать только буквы русского и латинского алфавитов.");
        return;
    }
    if (!regexp_phone.test(phoneNumber)) {
        alert("Неверный номер телефона!\r\nВведите номер в формате:\r+код_страны `дефис` код_оператора `дефис` номер_телефона, \r например, +7-911-5557799");
        return;
    }

    $.ajax({
        url		: './webServices.cfc?method=add',
        type	: 'POST',
        async   : false,
        data	: {
            firstName	: firstName,
            middleName	: middleName,
            lastName	: lastName,
            phoneNumber	: phoneNumber,  
        },
        dataType: 'json',
        success: function(response) {
            console.log(response);
        }
    });
    printData('regDate_asc');
}

function deleteUser(id) {
    sortBy = localStorage.getItem('sortBy');
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
    console.log('!'+sortBy);
    printData(sortBy);
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
}