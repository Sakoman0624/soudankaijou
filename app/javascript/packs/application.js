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


// app/javascript/packs/application.js
document.addEventListener("turbolinks:load", function() {
  const toggleBtn = document.getElementById("sidebar-toggle");
  const sidebar = document.getElementById("sidebar");

  if (toggleBtn && sidebar) {
    toggleBtn.addEventListener("click", function() {
      sidebar.classList.toggle("collapsed");
    });
  }
});

import "bootstrap";

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
});

document.addEventListener("DOMContentLoaded", () => {
  const email = document.getElementById("email");
  const emailStatus = document.getElementById("email-status");
  const pw = document.getElementById("password");
  const pwConfirm = document.getElementById("password-confirm");
  const pwStatus = document.getElementById("pw-confirm-status");
  const togglePw = document.getElementById("toggle-password");
  const pwStrength = document.getElementById("pw-strength");
  const pwStrengthText = document.getElementById("pw-strength-text");

  // メール形式チェック
  email.addEventListener("input", () => {
    if (email.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      emailStatus.innerHTML = '<i class="fa fa-check text-success"></i>';
    } else {
      emailStatus.innerHTML = '<i class="fa fa-times text-danger"></i>';
    }
  });

  // パスワード表示切替
  togglePw.addEventListener("click", () => {
    const type = pw.type === "password" ? "text" : "password";
    pw.type = type;
    togglePw.innerHTML =
      type === "password"
        ? '<i class="fa fa-eye"></i>'
        : '<i class="fa fa-eye-slash"></i>';
  });

  // パスワード強度判定
  pw.addEventListener("input", () => {
    const val = pw.value;
    let strength = 0;
    if (val.length >= 8) strength++;
    if (/[A-Z]/.test(val)) strength++;
    if (/[0-9]/.test(val)) strength++;
    if (/[^A-Za-z0-9]/.test(val)) strength++;

    pwStrength.className = "progress-bar"; // reset
    pwStrength.style.width = (strength * 25) + "%";

    if (strength <= 1) {
      pwStrength.classList.add("weak");
      pwStrengthText.textContent = "弱い";
    } else if (strength === 2) {
      pwStrength.classList.add("medium");
      pwStrengthText.textContent = "普通";
    } else {
      pwStrength.classList.add("strong");
      pwStrengthText.textContent = "強い";
    }
  });

  // パスワード確認一致チェック
  pwConfirm.addEventListener("input", () => {
    if (pw.value && pw.value === pwConfirm.value) {
      pwStatus.innerHTML = '<i class="fa fa-check text-success"></i>';
    } else {
      pwStatus.innerHTML = '<i class="fa fa-times text-danger"></i>';
    }
  });
});

// ripple effect for .tag-chip (軽量)
document.addEventListener('click', function(e) {
  const target = e.target.closest('.tag-chip');
  if (!target) return;

  const rect = target.getBoundingClientRect();
  const ripple = document.createElement('span');
  const size = Math.max(rect.width, rect.height) * 1.2;
  ripple.style.position = 'absolute';
  ripple.style.left = (e.clientX - rect.left - size / 2) + 'px';
  ripple.style.top = (e.clientY - rect.top - size / 2) + 'px';
  ripple.style.width = ripple.style.height = size + 'px';
  ripple.style.borderRadius = '50%';
  ripple.style.background = 'rgba(255,255,255,0.25)';
  ripple.style.transform = 'scale(0)';
  ripple.style.pointerEvents = 'none';
  ripple.style.transition = 'transform 400ms ease, opacity 400ms ease';
  ripple.className = 'tag-chip-ripple';

  target.style.position = 'relative';
  target.appendChild(ripple);

  requestAnimationFrame(() => {
    ripple.style.transform = 'scale(1)';
    ripple.style.opacity = '0';
  });

  setTimeout(() => ripple.remove(), 450);
});
