//= require _jquery
//= require _imagesloaded.min
;//(function () {
  'use strict';

  var loaded = false;

  var debounce = function(func, waitTime) {
    var timeout = false;
    return function() {
      if (timeout === false) {
        setTimeout(function() {
          func();
          timeout = false;
        }, waitTime);
        timeout = true;
      }
    };
  };

  var closeToc = function() {
    console.log("[closeToc]Removing open class...");
    $(".toc-wrapper").removeClass('open');
    $("#nav-button").removeClass('open');
  };

  function loadToc($toc, tocLinkSelector, tocListSelector, scrollOffset) {
    console.log("[loadToc]Passed parameters are: ", $toc, tocLinkSelector, tocListSelector, scrollOffset);
    var headerHeights = {};
    var pageHeight = 0;
    var windowHeight = 0;
    var originalTitle = document.title;

    var recacheHeights = function() {
      console.log("[recacheHeights]Recaching heights...");
      headerHeights = {};
      pageHeight = $(document).height();
      windowHeight = $(window).height();

      $toc.find(tocLinkSelector).each(function() {
        var targetId = $(this).attr('href');
        var requestElement = targetId.split('#');
        if (requestElement[1] != null) {
          headerHeights[requestElement[1]] = $(document.getElementById(requestElement[1])).offset().top;
        }
      });
    };

    var refreshToc = function() {
      //console.log("[refreshToc]Refreshing ToC...");
      //console.log("[refreshToc]Setting currentTop to be ", $(document).scrollTop(), " + ", scrollOffset);
      var currentTop = $(document).scrollTop() + scrollOffset;
      //console.log("[refreshToc]currentTop is found to be: ", currentTop);
      if (currentTop + windowHeight >= pageHeight) {
        // at bottom of page, so just select last header by making currentTop very large
        // this fixes the problem where the last header won't ever show as active if its content
        // is shorter than the window height
        currentTop = pageHeight + 1000;
      }

      var best = null;
      //console.log("[refreshToc]headerHeights is found to be: ", headerHeights);
      for (var name in headerHeights) {
        if ($toc.find("[h2$='" + name + "']") && 
            (headerHeights[name] != 0 && headerHeights[name] < currentTop && headerHeights[name] > headerHeights[best]) || 
            best === null) {
          best = name;
          //console.log("[refreshToc]regular `best` is found to be: ", best);
        }
      }

      // Catch the initial load case
      if (currentTop == scrollOffset && !loaded) {
        best = window.location.hash;
        loaded = true;
      }

      //catch a scroll back to the top
      if (currentTop == scrollOffset && loaded) {
        best = null;
      }

      var $best = $toc.find("[href$='" + best + "']").first();
      if (!$best.hasClass("active")) {
        // .active is applied to the ToC link we're currently on, and its parent <ul>s selected by tocListSelector
        // .active-expanded is applied to the ToC links that are parents of this one
        //console.log("[refreshToc]swapping out active class...");
        $toc.find(".active").removeClass("active");
        $toc.find(".active-parent").removeClass("active-parent");
        $best.addClass("active");
        $best.parents(tocListSelector).addClass("active").siblings(tocLinkSelector).addClass('active-parent');
        $best.siblings(tocListSelector).addClass("active");
        $toc.find(tocListSelector).filter(":not(.active)").slideUp(150);
        $toc.find(tocListSelector).filter(".active").slideDown(150);
        // TODO remove classnames
        document.title = $best.data("title") + " – " + originalTitle;
      }
    };

    var makeToc = function() {
      console.log("[makeToc]Building ToC :) ...");
      recacheHeights();
      refreshToc();

      $("#nav-button").click(function() {
        $(".toc-wrapper").toggleClass('open');
        $("#nav-button").toggleClass('open');
        return false;
      });
      $(".page-wrapper").click(closeToc);
      $(".toc-link").click(closeToc);

      // reload immediately after scrolling on toc click
      $toc.find(tocLinkSelector).click(function() {
        setTimeout(function() {
          refreshToc();
        }, 0);
      });

      $(window).scroll(debounce(refreshToc, 200));
      $(window).resize(debounce(recacheHeights, 200));
    };

    makeToc();

    window.recacheHeights = recacheHeights;
    window.refreshToc = refreshToc;
  }

  window.loadToc = loadToc;
//})();
