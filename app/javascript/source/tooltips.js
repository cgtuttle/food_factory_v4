export function tooltip(){
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover({
    html: true,
    trigger: 'hover',
  });
}
