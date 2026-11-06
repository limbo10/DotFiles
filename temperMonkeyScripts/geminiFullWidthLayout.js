// ==UserScript==
// @name         Gemini Full-Width Layout
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  Removes the max-width restriction from Gemini conversation containers and user-query elements.
// @author       Sumit
// @match        https://gemini.google.com/*
// @grant        none
// @run-at       document-end
// ==/UserScript==

(function() {
    'use strict';

    function removeMaxWidth() {
        // Select both the conversation container class and the user-query custom element
        const elements = document.querySelectorAll('.conversation-container, user-query');
        elements.forEach(el => {
            if (el.style.maxWidth !== 'none') {
                el.style.setProperty('max-width', 'none', 'important');
            }
        });
    }

    // Observe DOM mutations to handle dynamic SPA navigation and chat updates
    const observer = new MutationObserver(() => {
        removeMaxWidth();
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    // Run on initial load
    removeMaxWidth();
})();
