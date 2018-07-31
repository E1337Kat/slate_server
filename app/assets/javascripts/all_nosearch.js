//= require _energize
//= require app/_toc
//= require app/_lang

$(function() {
  loadToc($($.parseHTML('#toc')[1]), '.toc-link', '.toc-list-h2', 10);
  setupLanguages($('body').data('languages'));
  $('.content').imagesLoaded( function() {
    window.recacheHeights();
    window.refreshToc();
  });
});

window.onpopstate = function() {
  activateLanguage(getLanguageFromQueryString());
};
