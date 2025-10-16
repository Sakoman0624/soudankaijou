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


// site-search-autocomplete.js
document.addEventListener('DOMContentLoaded', function() {
  const input = document.getElementById('site-search');
  const list = document.getElementById('search-suggestions');
  const clearBtn = document.querySelector('.clear-btn');

  let suggestions = [];
  let selectedIndex = -1;
  let fetchTimeout = null;

  function setExpanded(val) {
    input.setAttribute('aria-expanded', val ? 'true' : 'false');
    if (!val) list.hidden = true;
  }

  function renderList(items) {
    list.innerHTML = '';
    if (!items || items.length === 0) {
      setExpanded(false);
      return;
    }
    items.forEach((it, idx) => {
      const li = document.createElement('li');
      li.className = 'list-group-item';
      li.setAttribute('role','option');
      li.setAttribute('id','search-suggestion-' + idx);
      li.innerHTML = `<div class="d-flex justify-content-between align-items-center">
                        <div class="suggestion-main">${escapeHtml(it.title || it.label || it)}</div>
                        ${it.meta ? `<small class="text-muted ml-2">${escapeHtml(it.meta)}</small>` : ''}
                      </div>`;
      li.addEventListener('click', () => {
        input.value = it.title || it.label || it;
        document.querySelector('form.search-bar').submit();
      });
      list.appendChild(li);
    });
    suggestions = items;
    selectedIndex = -1;
    setExpanded(true);
  }

  function escapeHtml(s) {
    if (!s) return '';
    return String(s).replace(/[&<>"']/g, function(m){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m]); });
  }

  function setActive(index) {
    const children = list.querySelectorAll('.list-group-item');
    children.forEach((el, i) => {
      el.classList.toggle('active', i === index);
    });
    if (index >= 0 && children[index]) {
      input.setAttribute('aria-activedescendant', children[index].id);
      // スクロールイン
      children[index].scrollIntoView({block: 'nearest'});
    } else {
      input.removeAttribute('aria-activedescendant');
    }
  }

  function fetchSuggestions(q) {
    // Debounce
    if (fetchTimeout) clearTimeout(fetchTimeout);
    if (!q || q.trim().length < 1) {
      renderList([]);
      return;
    }
    fetchTimeout = setTimeout(() => {
      fetch(`/search_suggestions.json?q=${encodeURIComponent(q)}`)
        .then(r => r.ok ? r.json() : Promise.reject())
        .then(data => {
          // data expected: [{title:, meta:}, ...] or ["...","..."]
          renderList(data);
          // show clear button if input not empty
          clearBtn.hidden = false;
        })
        .catch(()=> renderList([]));
    }, 220);
  }

  input.addEventListener('input', (e) => {
    fetchSuggestions(e.target.value);
    clearBtn.hidden = !e.target.value;
  });

  input.addEventListener('keydown', (e) => {
    const count = suggestions.length;
    if (!count) return;
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      selectedIndex = Math.min(count - 1, selectedIndex + 1);
      setActive(selectedIndex);
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      selectedIndex = Math.max(0, selectedIndex - 1);
      setActive(selectedIndex);
    } else if (e.key === 'Enter') {
      if (selectedIndex >= 0) {
        e.preventDefault();
        const it = suggestions[selectedIndex];
        input.value = it.title || it.label || it;
        document.querySelector('form.search-bar').submit();
      }
    } else if (e.key === 'Escape') {
      setExpanded(false);
    }
  });

  // clear
  clearBtn.addEventListener('click', () => {
    input.value = '';
    renderList([]);
    clearBtn.hidden = true;
    input.focus();
  });

  // click outside closes
  document.addEventListener('click', (e) => {
    if (!document.querySelector('.search-bar').contains(e.target)) {
      setExpanded(false);
    }
  });
});

/* ==========================
   Hero：スクロール＆軽いパララックス（最小）
   ========================== */
document.addEventListener('turbolinks:load', function() {
  // スクロールボタンの挙動
  document.querySelectorAll('.hero-scroll-down').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      var target = document.querySelector(btn.dataset.target || '#main') || document.body;
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });

  // 軽いパララックス：スクロールで背景を微妙に移動（パフォーマンス配慮）
  var hero = document.querySelector('.hero-landing');
  if (!hero) return;

  // 関数を throttle して呼ぶ
  var ticking = false;
  window.addEventListener('scroll', function() {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
    if (!ticking) {
      window.requestAnimationFrame(function() {
        var scrolled = window.scrollY;
        // 小さな translateY 変換を与えるだけ（負荷低め）
        var offset = Math.min(scrolled * 0.08, 60); // 最大60px
        hero.style.transform = 'translateY(' + (offset * -0.2) + 'px)'; // 微移動
        ticking = false;
      });
      ticking = true;
    }
  }, { passive: true });
});

/* ==========================
   ソートコントロール：インタラクション
   ========================== */
document.addEventListener('turbolinks:load', function() {
  // クリックで即時 active を切り替え（楽観的UI）
  document.querySelectorAll('.sort-btn-group .sort-btn').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      try {
        // 見た目を即時切り替え
        document.querySelectorAll('.sort-btn-group .sort-btn').forEach(function(b){ b.classList.remove('active'); b.classList.add('outline'); b.setAttribute('aria-pressed','false'); });
        btn.classList.add('active'); btn.classList.remove('outline'); btn.setAttribute('aria-pressed','true');
      } catch(err) { /* no-op */ }
      // 実際の読み込みは Rails UJS の remote: true に任せる
    });
  });

  // モバイル select の変更：非AJAXならページ遷移、AJAXにしたければ remote:true で link を使うか fetchで取得
  var mobileSelect = document.getElementById('mobile-sort-select');
  if (mobileSelect) {
    mobileSelect.addEventListener('change', function(e) {
      var url = e.target.value;
      if (!url) return;
      // 普通にページ遷移させる（remote: true の環境が必要ならここを $.get に置き換え）
      window.location.href = url;
    });
  }
});
