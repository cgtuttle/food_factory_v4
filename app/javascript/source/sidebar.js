export function sideBar() {
  var lastState = localStorage.getItem('lastState');
  var lastStateHidden = lastState == 'hideMenu'
  console.log("lastState: " + lastState);
  console.log("#sidebar class 'out': " + $("#sidebar").hasClass("out"));
  if($("#sidebar").hasClass("out") != lastStateHidden) {
    console.log("Toggling #sidebar.out to: " + lastStateHidden);
    var nextState = lastStateHidden ? 'hideMenu' : 'showMenu'
    localStorage.setItem('lastState', nextState);
    $('#sidebar').toggleClass('out', lastStateHidden);
    $('#content-window').toggleClass('out', lastStateHidden);
  }

  $('#sidebarCollapse').on('click', function () {
    var lastStateHidden = localStorage.getItem('lastState') == 'hideMenu'
    var nextState = lastStateHidden ? 'showMenu' : 'hideMenu'
    console.log("localStorage: " + localStorage.getItem('lastState'))
    $('#sidebar').toggleClass('out', !lastStateHidden);
    $('#content-window').toggleClass('out', !lastStateHidden);
    localStorage.setItem('lastState', nextState);
  });
};

