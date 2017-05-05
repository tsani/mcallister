'use strict';

(function() {
  $(document).ready(function() {
    var status = $('#status');

    function update() {
      getStatus(
        function(response) {
          var s = '';
          if(response.status) {
            s = 'Someone is home!';
          }
          else {
            s = 'Nobody is home!';
          }
          status.text(s);
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
