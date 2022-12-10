export function filterOnField(){
  console.log("Running filterOnField");
  sortAscending();
  sortDescending();

  function sortAscending(){   
    var sortAscendingIcon = $(".sort-ascending");
    sortAscendingIcon.on("click", function(){
      console.log("sortAscending clicked");
      console.log($(".sort-ascending").data("field"));     
    });
  }

  function sortDescending(){   
    var sortDescendingIcon = $(".sort-descending");
    sortDescendingIcon.on("click", function(){
      console.log("sortDescending clicked");      
    });
  }
  
}