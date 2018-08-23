//= require _energize
//= require app/_toc
//= require app/_lang

$(function() {
  loadToc($('#toc'), '.toc-link', '.toc-list-h2', 10);
  console.log("[initialize JS]Loaded ToC...");
  setupLanguages($('body').data('languages'));
  console.log("[initialize JS]Loaded langs...")
  $('.content').imagesLoaded( function() {
    window.recacheHeights();
    window.refreshToc();
  });
});

window.onpopstate = function() {
  activateLanguage(getLanguageFromQueryString());
};
