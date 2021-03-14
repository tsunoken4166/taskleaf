$(document).on('turbolinks:load', function() {
  $("#task_form").validationEngine({
    promptPosition: "inline"
  });
});
