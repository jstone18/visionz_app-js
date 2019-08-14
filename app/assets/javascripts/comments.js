$(document).ready(function() {
  $(function() {
    setupCreateComment();
  });


    // Comment clsss constructor
  class Comment {
    constructor(json) {
      this.data = json
    };

    formatComment() {
      let commentHTML = `<li><blockquote><strong>${this.data.user.name}</strong> says:
      <em>${this.data.content}</em></blockquote></li>`
      return commentHTML
    }

    updateHTML() {
      $("#new-comment").text(this.data.user.name);
      $("#new-comment").text(this.data.content);
    }
  };

  // Form submission handler
  function setupCreateComment() {
    $(".new_comment").submit(function(event) {
      event.preventDefault();

      let data = $(this).serialize();
      let url = $(this).attr("action");

      createComment(url, data)

      $("#comment_content").val("");
    });
  };

  // Create Comment
  function createComment(url, data) {
    $.post(url, data, "json")
      .done(json => {
        let $ol = $("div.post-comments");
        let myComment = new Comment(json);
        let commentHTML = myComment.formatComment();

        if($(".no-comments").text() != '') {
          $ol.html(commentHTML);
        } else {
          $ol.append(commentHTML)
        }
        
      })
      .error(resp => {
        alert("There is an error", resp);
      });
  };


});
