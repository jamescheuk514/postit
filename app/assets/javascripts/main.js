jQuery(document).ready(function ($) {
  $(function () {
    $('#userContentTabs a:last').tab('show')
  })

  $('#userContentTabs').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  });
});
