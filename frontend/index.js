'use strict';

(function() {
  $(document).ready(function() {
    var status = $('#status');

    function update() {
      getStatus(
        function(response) {
          var s = '';
          if(response.status) {
            s = 'green'
          }
          else {
            s = 'red;
          }
          $('body').css('background-color', s);
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
