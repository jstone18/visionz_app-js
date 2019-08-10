// Comment class constructor
class Comment {
  constructor(json) {
    this.data = json
  };

  updateHTML()  {
    $("#postComment").text(this.data.content)
  };

  formatComment() {
    let commentHTML = `
      <div class="dialogbox">
      <p id="postComment">Says: ${this.content}</p>
      </div>
      `
    return commentHTML
  }
};

function setupCreateComment() {
  $("#new_comment").submit(function(event) {
    event.preventDefault();

    let data = $(this).serialize();
    let url = $(this).attr("action")

    createComment(url, data)
  })
};

function createComment(url, data) {
  $.post(url, data, "json")
    .done(json => {
      let myComment = new Comment(json);
      // let comment = myComment.formatComment();

      myComment.updateHTML()
    })
    .error(resp => {
      alert("There is an error", resp);
    });
}

$(function() {
  setupCreateComment();
})
