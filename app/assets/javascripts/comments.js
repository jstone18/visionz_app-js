$(document).ready(function() {
  $("a.load_comments").on("click", function(e) {
    //LOAD COMMENTS VIA AJAX
    // $.ajax(({
    //   url: this.href,
    //   dataType: 'script'
    // }))
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
  })

  //CREATE COMMENTS VIA AJAX
//   $('#new_comment').unbind("submit").bind("submit", function(e) {
//     $.ajax({
//       type: "POST",
//       url: this.action,
//       data: $(this).serialize(),
//       success: function(response) {
//         $("#comment_content").val("");
//         var $ol = $("div.post-comments").html(response)
//       }
//     });
//
//     e.preventDefault();
//   })
// })

function Comment(comment) {
  this.username = comment.user.name
  this.comment = comment.content
  // debugger;
}

// Prototype method
  Comment.prototype.formatComment = function() {
    commentHTML = `<li><blockquote>${this.comment}<footer> by: ${this.username}</footer></blockquote></li>`
    return commentHTML
  }

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
      });

      e.preventDefault();

      })


})


// // Comment class constructor
// class Comment {
//   constructor(json) {
//     this.data = json
//   };
//
//   updateHTML()  {
//     $("#postComment").text(this.data.content)
//   };
//
//   formatComment() {
//     let commentHTML = `
//       <div class="dialogbox">
//       <p id="postComment">${this.user.username} Says: ${this.content}</p>
//       </div>
//       `
//     return commentHTML
//   }
// };
//
// function setupCreateComment() {
//   $("#new_comment").submit(function(event) {
//     event.preventDefault();
//
//     let data = $(this).serialize();
//     let url = $(this).attr("action")
//
//     createComment(url, data)
//   })
// };
//
// function createComment(url, data) {
//   $.post(url, data, "json")
//     .done(json => {
//       // debugger;
//       let myComment = new Comment(json);
//       // let comment = myComment.formatComment();
//
//       myComment.updateHTML()
//     })
//     .error(resp => {
//       alert("There is an error", resp);
//     });
// }
//
// $(function() {
//   setupCreateComment();
// })
