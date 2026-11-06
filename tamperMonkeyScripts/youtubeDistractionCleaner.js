// ==UserScript==
// @name         ytb_shelf_thumbnail_remover
// @namespace    http://tampermonkey.net/
// @version      2025-08-20
// @description  try to take over the world!
// @author       dmfk
// @match        *://*.youtube.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=youtube.com
// @grant        none
// ==/UserScript==


(function() {
  'use strict';
  // The main function that hides the specified elements.
  function hideElements() {
    // Hides the "Shorts" shelves on the home page.
    // The tag name 'ytd-rich-shelf-renderer' is what YouTube uses for the Shorts section.
    const shortRichShelfs = document.getElementsByTagName('ytd-rich-shelf-renderer');
    Array.from(shortRichShelfs).forEach(shortRichShelf => {
      shortRichShelf.style.display = 'none';
    });

    const reelShelfs = document.getElementsByTagName('ytd-reel-shelf-renderer');
    Array.from(reelShelfs).forEach(reelShelf => {
      reelShelf.style.display = 'none';
    });

    const gridShelfViews = document.getElementsByTagName('grid-shelf-view-model');
    Array.from(gridShelfViews).forEach(gridShelfView => {
      gridShelfView.style.display = 'none';
    });

       const sectionRenderer = document.getElementsByTagName('ytd-rich-section-renderer');
    Array.from(gridShelfViews).forEach(gridShelfView => {
      gridShelfView.style.display = 'none';
    });




//     const homePageThumbnails = document.getElementsByTagName('yt-thumbnail-view-model');
//     Array.from(homePageThumbnails).forEach(homePageThumbnail => {
//       homePageThumbnail.style.visibility = 'hidden';
//     });


//     const searchVideoThumbnails = document.getElementsByTagName('ytd-thumbnail');
//     Array.from(searchVideoThumbnails).forEach(searchVideoThumbnail => {
//       searchVideoThumbnail.style.visibility = 'hidden';
//     });


    const BrandVideos = document.getElementsByTagName('ytd-brand-video-singleton-renderer');
    Array.from(BrandVideos).forEach(BrandVideo => {
      BrandVideo.style.visibility = 'hidden';
    });

    const ads = document.getElementsByTagName('ytd-ad-slot-renderer')
    Array.from(ads).forEach(ad => {
      ad.style.display = 'none';
    });

//     const commentsSections = document.getElementsByTagName('ytd-comments');
//     Array.from(commentsSections).forEach(commentsSection => {
//       commentsSection.style.display = 'none';
//     });

    const allCustomElements = document.querySelectorAll('ytd-mini-guide-entry-renderer, ytd-guide-entry-renderer');
    allCustomElements.forEach(element => {
        if (element.firstElementChild &&
            element.firstElementChild.tagName === 'A' &&
            element.firstElementChild.getAttribute('title') === 'Shorts') {

            element.style.display = 'none';
        }
    });


      // Hiding 'Explore' and 'More from YouTube' sections.
      const targetTagName = 'ytd-guide-section-renderer';

      const allSections = document.querySelectorAll(targetTagName);
      const elementsToHide = [];

      allSections.forEach(section => {
          // 2. Check the text content of the entire section
          const sectionText = section.textContent;

          // Use includes() to check for either string
          if (sectionText &&
              (sectionText.includes('Explore') || sectionText.includes('More from YouTube'))) {

              elementsToHide.push(section);
          }
      });

      elementsToHide.forEach(element => {
          element.style.display = 'none';
      });

      // Remove Footer
      document.getElementById('footer').style.display = 'none'


    document.getElementsByTagName('ytd-rich-grid-renderer')[0].style.maxWidth = '90%'
  }

  // Use a MutationObserver to detect when new content is added to the page.
  // This is crucial for hiding new Shorts shelves and thumbnails as you scroll down.
  const observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      // Check if new nodes were added to the DOM.
      if (mutation.addedNodes.length > 0) {
        // Call the function to hide the elements again whenever new content appears.
        hideElements();
      }
    });
  });

  // Start observing the body element for changes in its child nodes.
  // 'childList' watches for new elements being added or removed.
  // 'subtree' ensures it also watches for changes inside the body.
  observer.observe(document.body, { childList: true, subtree: true });

  // Initial call to hide existing elements on page load.
  // This handles the content that is already on the page before scrolling.
  hideElements();
})();

