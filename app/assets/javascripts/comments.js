$(document).ready(function() {

  $("a.load_comments").on("click", function(e) {

    $.get(this.href).success(function(comments) {
     var $ol = $("div.post-comments")
     $ol.html("")

     comments.forEach(function(comment) {
      const oneComment = new Comment(comment)
      const commentHTML = oneComment.formatComment()
      $ol.append(commentHTML)
     })
    })
    e.preventDefault();
  });

  // Comment Class
  function Comment(comment) {
    this.name = comment.user.name
    this.comment = comment.content
  };

  // Comment Prototype method
  Comment.prototype.formatComment = function() {
    commentHTML = `<li><blockquote>${this.comment}<footer> by: ${this.name}</footer></blockquote></li>`
    return commentHTML
  };

  //Submit comment using JSON and RAILS API
  $(".new_comment").on("submit", function(e){
    $.post(this.action, $(this).serialize(), function(comment) {

      const $ol = $("div.post-comments");
      const newComment = new Comment(comment);
      const commentHTML = newComment.formatComment();

      if($(".no-comments").text() != '') {
        $ol.html(commentHTML);
      } else {
        $ol.append(commentHTML)
      }

      $("#comment_content").val("");
    })
    e.preventDefault();
  });

});
