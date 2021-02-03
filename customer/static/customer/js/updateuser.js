  $(document).ready( function () {
    $('#user_update').djValidator();
  } );

// update user request

  $(document).on('submit','#user_update', function(e){
    e.preventDefault();
    $('#loader').show()
    $.ajax({
        url: "/updateuser/",
        type: "POST",
        data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
        contentType: false,       // The content type used when sending data to the server.
        cache: false,             // To unable request pages to be cached
        processData:false,
        }).success(function(data){
        $('#loader').hide()
        if(data.status == 1){
        alertify.alert(data.messages, function(){
        location.reload();
        });

        }else{
        alertify.alert(data.messages);
        }
        }).fail(function(){
        $('#loader').hide()
          alertify.alert('XHR failed, handle this ');
        });
  })


