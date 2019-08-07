// Read More button on show page
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

// Post clsss constructor
class Post {
  constructor(json) {
    this.data = json
  };

  updateHTML() {

    $("#postTitle").text(this.data.title);
    $("#postBody").text(this.data.description);
    $('.preview').html(`<img src="${this.data.image}>"`)
  };
};

// Form submission handler
function setupCreatePost() {
  $("form").submit(function(event) {
    event.preventDefault();

    let data = $(this).serialize();
    let url = $(this).attr("action");
    ;
    createPost(url, data)
  });
};

// Create Post
function createPost(url, data) {

  $.post(url, data, "json")
    .done(json => {
      let myPost = new Post(json);
      // debugger;
      myPost.updateHTML();
    })
    .error(resp => {
      alert("There is an error", resp);
    });
};

$(function() {
  setupCreatePost();
});
