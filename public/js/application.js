$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $('#new_question').on('submit', function(e){
    e.preventDefault();

    var number = $(this).find('input[name="survey_id"]').val();
    // JSON.stringify(number); NOT SURE WHY I NEEDED THIS BEFORE TO GET EVERYTHING TO WORK. LOOKS LIKE I DON'T NEED IT
    var input = $(this).find('input[name="content"]');
    var value = input.val();
    input.val('');

    var request = $.ajax({
      method: 'post',
      url: '/question',
      data: {survey_id: number, content: value},
    });

    request.done(function(question){
      $('#question_list ol').append(question);
    });

  });

  // $('.new_choice').on('submit', function(e){
  $('#question_list').on('submit', '.new_choice', function(e){
    e.preventDefault();

    var $question = $(this).find('input[question_id]')
    var $ul = $(this).parent().find('ul');
    var number = $(this).find('input[name="question_id"]').val();
    // JSON.stringify(number);  NOT SURE WHY I NEEDED THIS BEFORE TO GET EVERYTHING TO WORK. LOOKS LIKE I DON'T NEED IT
    var input = $(this).find('input[name="content"]');
    var value = input.val();
    input.val('');

    $.ajax({
        method: 'post',
        url: '/choices',
        data: {question_id: number, content: value},
        success: function(response){
          choice = JSON.parse(response)
          var li = $('<li></li>').text(choice.content);
          $ul.append(li)
          $question.val(choice.question_id)
        },
      });

  });

  function buildQuestion(question) {
    var $question = $('#question_template').clone().show();
    $question.find('.content').text(question.content);
    $question.find('[name="question_id"]').val(question.id);
    return $question;
  };

});
