// JS script for Show Images button
$(function() {
  $("#js-post").on("click", function() {
    const userId = $(this).data("uid");
    $.get("/users/" + userId + ".json", function(data) {
      debugger;
      let post = data.posts.map(p => {
        
        return `
          <div class="wrapper">
            <h6 style="color:gray;text-align: center;"><u>${p.title}</u></h6>
            <a href="<%= user_post_path(@user.posts, @post) %>">
              <img src="${p.image}"><br>
            </a>
          </div>
        `
      })
      $(".user-images").html(post)
      $(".user-title").html(post)
    })
  })
})
