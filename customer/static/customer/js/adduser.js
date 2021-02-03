  $(document).ready( function () {
    $('#addusersubmit_form').djValidator();
  } );

// add user request

  $(document).on('submit','#addusersubmit_form', function(e){
    e.preventDefault();

    $.ajax({
        url: "/adduser/",
        type: "POST",
        data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
        contentType: false,       // The content type used when sending data to the server.
        cache: false,             // To unable request pages to be cached
        processData:false,
        }).success(function(data){
        if(data.status == 1){
        alertify.alert(data.messages, function(){
        location.reload();
        });
        $('#addusersubmit_form')[0].reset();

        }else{
        alertify.alert(data.messages);
        }
        }).fail(function(){
        $('#loader').hide()
          alertify.alert('XHR failed, handle this ');
        });
  })


//  user list datatable
$(document).ready( function () {
    $('#userlist').DataTable({
    "processing": true,
    "serverSide": true,
    "searching" : false,
    "ordering" : true,
    "order": [[ 0, "desc" ]],
    "ajax": {
       type: "GET",
       url: "/userlist/",
       dataType: 'json'
     },
    "columns":[
                { "data": "account_no" },
                { "data": "first_name","orderable":false},
                { "data": "last_name","orderable":false },
                { "data": "address" ,"orderable":false},
                { "data": "email","orderable":false },
                { "data": "profile_type" ,"orderable":false},
                { "data": "created_at" ,"orderable":false},
                { "data": "id","orderable":false,
                            "render":
                      function(data,type,row,meta){
                            if(row.status == 0){
                            var a = '<a href="javascript:void(0)" class="active" data-id="'+row.id+'">Deactive</a>';
                            }else{
                            var a = '<a href="javascript:void(0)" class="active" data-id="'+row.id+'">Active</a>';
                            }

                        return a;
                      }
                },
                { "data": "id","orderable":false,
                             "render":
                      function(data,type,row,meta){
                        var a = '<a href="editprofile?id='+row.id+'"><i class="material-icons prefix">edit</i></a>';
                        return a;
                      }
                },
              ],
    });
  } );

// user activate or deactivate

$(document).on('click','.active', function(e){
    e.preventDefault();
    var id = $(this).data('id');
    $("#loader").show()
    $.ajax({
        url: "/user_activate/",
        type: "GET",
        data: {id: id},
        }).success(function(data){
        $("#loader").hide()
        if(data.status == 1){
        alertify.alert(data.messages, function(){
        location.reload();
         });

        }else{
        alertify.alert(data.messages);
        }
        }).fail(function(){
          alertify.alert('XHR failed, handle this ');
        });
})