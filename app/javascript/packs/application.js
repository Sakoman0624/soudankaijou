// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import $ from "jquery";
window.$ = $;
window.jQuery = $;

import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 


Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.previewImage = function(event) {
  const reader = new FileReader();
  reader.onload = function () {
    const preview = document.getElementById('preview');
    if (preview) {
      preview.src = reader.result;
    }
  };
  reader.readAsDataURL(event.target.files[0]);
};

document.addEventListener('turbolinks:load', function () {
  const input = document.querySelector('input[type="file"][name="room[image]"]');
  const preview = document.getElementById('preview');

  if (input && preview) {
    input.addEventListener('change', function (event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
          preview.src = e.target.result;
          preview.classList.remove('d-none');
        };
        reader.readAsDataURL(file);
      } else {
        preview.src = "#";
        preview.classList.add('d-none');
      }
    });
  }
});


document.addEventListener("turbolinks:load", function () {
  const withdrawBtn = document.getElementById("withdraw-button");
  const form = document.getElementById("withdraw-form");
  if (!withdrawBtn || !form) return;

  let countdown = 5;
  withdrawBtn.textContent = `退会する（${countdown}秒）`;
  withdrawBtn.disabled = true;

  const interval = setInterval(() => {
    countdown--;
    withdrawBtn.textContent = `退会する（${countdown}秒）`;

    if (countdown <= 0) {
      clearInterval(interval);
      withdrawBtn.textContent = "退会する";
      withdrawBtn.disabled = false;
    }
  }, 1000);

  withdrawBtn.addEventListener("click", function () {
    if (confirm("最終確認です。本当に退会しますか？この操作は元に戻せません。")) {
      form.submit();
    }
  });
});