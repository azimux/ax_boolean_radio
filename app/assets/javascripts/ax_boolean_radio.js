/* requires ax.js from ax_lib */

Ax.BooleanRadio = {
  loadFunction: function() {
    $("a.ax_boolean_radio_clear[visibility!=visible]").css("visibility", "visible");
  }
}

Ax.registerLoadable(Ax.BooleanRadio);

$(function() {
  $("body").delegate("a.ax_boolean_radio_clear", "click", function() {
    var link = $(this);
    var row = link.closest("tr.ax_boolean_row");
    row.find('input:radio').prop("checked", false);
    return false;
  });

  Ax.BooleanRadio.loadFunction($("body"));
});