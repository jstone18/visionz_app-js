$(document).ready(function() {
  $(function() {
    $("#js-more").on("click", function() {
      let id = $(this).data("id");
      $.get("/posts/" + id + ".json", function(data) {
        $("#body-" + id).text(data["description"]);;
      })
    })
  })
});
