// Read More button on show page
$(function() {
  $("#js-more").on("click", function() {
    let id = $(this).data("id");
    $.get("/posts/" + id + ".json", function(data) {
      $("#body-" + id).text(data["description"]);;
    })
  })
})


$("document").ready(function() {
  $("#load-posts").on("click", function() {
    $.get("/posts" + ".json", function(data) {

      post = Object.values(data).map(l => {
        // debugger;
        url = "/posts/" + "${l.id}"
        return `
        <li><blockquote><strong><a href="/posts/${l.id}"><h5>${l.title}</h5></a> by: ${l.user.username}</blockquote></li>
        `
      })
      $("#js-post").html(post)
    })
  })
})
