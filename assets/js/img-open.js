document.querySelectorAll('img').forEach(img => {
  img.addEventListener('click', function(e){
    window.open(this.src);
  })
});
