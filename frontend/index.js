'use strict';

(function() {
  $(document).ready(function() {
    var status = $('#status');

    function update() {
      getStatus(
        function(response) {
          var s = '';
          if(response.status) {
            s = 'green';
            msg = 'Someone is home :)';
          }
          else {
            s = 'red';
            msg = 'Nobody is home :(';
          }
          $('body').css('background-color', s);
          status.text(msg);
        },
        function(errors) {
          console.log("uh oh! " + JSON.stringify(errors));
        }
      );
    }

    setInterval(update, 500);
  });
})();

// vim: shiftwidth=2
