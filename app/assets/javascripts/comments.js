$(document).ready(function() {
  $("a.load_comments").on("click", function(e) {
    //LOAD COMMENTS VIA AJAX
    // $.ajax(({
    //   url: this.href,
    //   dataType: 'script'
    // }))
    $.get(this.href).success(function(json) {
     var $ol = $("div.post-comments")
     $ol.html("")

     json.forEach(function(comment) {
       $ol.append("<li>" + "<blockquote>" + comment.content + "<footer>" + 'by: ' + comment.user.username + "</footer>" +
       "</blockquote>" + "</li>" )
     })

    })

    e.preventDefault();
  })

  //CREATE COMMENTS VIA AJAX
  $('#new_comment').unbind("submit").bind("submit", function(e) {
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize(),
      success: function(response) {
        $("#comment_content").val("");
        var $ol = $("div.post-comments").html(response)
      }
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
