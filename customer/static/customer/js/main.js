 $(document).ready(function(){
	document.addEventListener('DOMContentLoaded', function() {
	    var elems = document.querySelectorAll('select');
	    var instances = M.FormSelect.init(elems, options);
	  });


  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.autocomplete');
    var instances = M.Autocomplete.init(elems, options);
  });

    document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, options);
  });

   document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.tabs');
    var instances = M.Tabs.init(elems, options);
  });

});

 $(document).ready(function(){
    $('.tabs').tabs();
  });


$('.alert_close').click(function(){
    $( ".msg-info" ).fadeOut( "slow", function() {
    });
  });


  // Or with jQuery

  $(document).ready(function(){
    $('select').formSelect();
  });

  $(document).ready(function(){
    $('select').formSelect();
    $('select.select_all').siblings('ul').prepend('<li id=sm_select_all><span>Select All</span></li>');
    $('li#sm_select_all').on('click', function () {
      var jq_elem = $(this),
          jq_elem_span = jq_elem.find('span'),
          select_all = jq_elem_span.text() == 'Select All',
          set_text = select_all ? 'Select None' : 'Select All';
      jq_elem_span.text(set_text);
      jq_elem.siblings('li').filter(function() {
        return $(this).find('input').prop('checked') != select_all;
      }).click();
    });

  });


   $(document).ready(function(){
    $('.modal').modal({
      dismissible: true, // Modal can be dismissed by clicking outside of the modal
      onOpenEnd: function(modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
        $('html, body').css('overflow-x', 'hidden');
        $('.modal').css('position', 'absolute');
      },
      onCloseEnd: function() { // Callback for Modal close
        
      } 
    });
  });