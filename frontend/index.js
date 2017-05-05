'use strict';

(function() {
  $(document).ready(function() {
    var status = $('#status');

    function update() {
      getStatus(
        function(response) {
          var s = '';
          var d = null;
          if(response.status) {
            s = 'green';
            msg = 'Someone is home :)';
            d = function(e) {
              e.removeClass('black');
              e.addClass('white');
            }
          }
          else {
            s = 'red';
            msg = 'Nobody is home :(';
            d = function(e) {
              e.addClass('black');
              e.removeClass('white');
            }
          }
          $('body').css('background-color', s);
          status.text(msg);
          d(status);
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
