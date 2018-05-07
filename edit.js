var id = localStorage.getItem('id4change');

window.onresize = function() {
    $('#content').css('height', $(window).height() - 180);
    $('#tableForm').css('left', ($(window).width() - $('#tableContent').width()) / 2);
}

window.onload = function() { 
    $('#content').css('height', $(window).height() - 180);
    $('#tableForm').css('left', ($(window).width() - $('#tableContent').width()) / 2);
    
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


function editUser() {
    var firstName	= $.trim($('#firstName').val());
    var middleName	= $.trim($('#middleName').val());
    var lastName	= $.trim($('#lastName').val());
    var phoneNumber	= $.trim($('#phoneNumber').val());
    var email	    = $.trim($('#email').val());
    var password	= $.trim($('#password').val());    

    var regexp_names = /[А-ЯЁа-яёA-Za-z\-]/;
    var regexp_phone = /(\+{1})+([0-9]{1,3})+(\-{1})+([0-9]{3})+(\-{1})+([0-9]{7})/;
    var regexp_email = /([a-zA-z\.\-]{1,})+([@]{1})+([a-zA-z]{2,})+([\.]{1})+([a-zA-z]{2,})/;
    
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
    if (!regexp_email.test(email)) {
        alert("Неверный адрес электронной почты!\r\nВведите email в формате:\rНазвание_почты; знак \"собака\" (@); название_домена; \"знак точка\" (.); страна, которой принадлежит домен\r(например, myemail@yandex.ru)");
        return;
    }
    
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