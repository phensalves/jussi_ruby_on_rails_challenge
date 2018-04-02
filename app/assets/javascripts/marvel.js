var collectCharacters=function(){
  $.ajax({
    type:'GET',
    url:'http://gateway.marvel.com/v1/public/characters?ts=1&apikey=d33768908d6ac342bcda2d942d239037&hash=43be5783174524298e753010ae91abad',
    success:function(){
      $(this).addClass('done');
    }
  });
}

$(document).on("click","#collectCharacters-button",collectCharacters);