// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', function () {
    const userMenu = document.querySelector('.user-menu');
    const toggle = document.getElementById('user-name-toggle');
    const dropdown = document.getElementById('user-dropdown-menu');
  
    if (toggle && userMenu && dropdown) {
      toggle.addEventListener('click', function (e) {
        e.stopPropagation(); // クリックバブル防止
        userMenu.classList.toggle('active');
      });
  
      // メニュー外をクリックしたら閉じる
      document.addEventListener('click', function (e) {
        if (!userMenu.contains(e.target)) {
          userMenu.classList.remove('active');
        }
      });
    }
  });
  