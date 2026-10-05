// ============================================
// YASHENG FRP - JavaScript v5 (EmailJS + GA4 + spam protection)
// ============================================

// --- Page load timestamp: used by the inquiry form's time-trap spam filter ---
var PAGE_LOADED_AT = Date.now();

// --- GA4 event helper. Analytics must never break the page. ---
function trackEvent(name, params) {
    try {
        if (typeof gtag === 'function') {
            gtag('event', name, params || {});
        }
    } catch (err) { /* ignore */ }
}

// --- EmailJS: wait for CDN SDK to be ready before use ---
// The SDK is loaded via <script defer> in index.html's <head>.
// We set a flag when it's ready so handleSubmit() knows it's safe to call.
(function waitForEmailJS() {
    const EMAILJS_PUBLIC_KEY = 'T3oS6G5q0jXvDcxnw';
    let attempts = 0;
    function tryInit() {
        attempts++;
        if (window.emailjs) {
            emailjs.init(EMAILJS_PUBLIC_KEY);
            window.__emailjsReady = true;
            console.log('[EmailJS] SDK ready.');
        } else if (attempts < 40) {
            setTimeout(tryInit, 100); // poll every 100ms, up to 4s
        } else {
            console.warn('[EmailJS] SDK not available after 4s.');
        }
    }
    tryInit();
})();

// --- Mobile Menu ---
function toggleMenu() {
    const navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
    // reset any expanded dropdowns when the panel closes
    if (!navLinks.classList.contains('active')) {
        navLinks.querySelectorAll('.open').forEach(li => li.classList.remove('open'));
    }
}
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', (e) => {
        const navLinks = document.querySelector('.nav-links');
        const isParent = link.matches('.dropdown > a, .dropdown-sub > a');
        // On mobile, tapping a parent item expands its submenu instead of navigating.
        if (isParent && window.matchMedia('(max-width: 768px)').matches) {
            e.preventDefault();
            const li = link.parentElement;
            // collapse sibling submenus at the same level
            li.parentElement.querySelectorAll(':scope > .open').forEach(s => { if (s !== li) s.classList.remove('open'); });
            li.classList.toggle('open');
            return;
        }
        navLinks.classList.remove('active');
        navLinks.querySelectorAll('.open').forEach(li => li.classList.remove('open'));
    });
});

// --- Auto-highlight current page in main nav (cross-page) ---
function setActiveNav() {
    var path = location.pathname;
    if (path === '') path = '/';
    if (/\/index\.html$/.test(path)) path = path.replace(/\/index\.html$/, '/');

    // Top-level nav links (direct <a> under .nav-links > li)
    document.querySelectorAll('.nav-links > li > a').forEach(function (a) {
        var href = a.getAttribute('href');
        if (!href || href.charAt(0) !== '/') { a.classList.remove('active'); return; }
        var hp = href.split('?')[0].split('#')[0];
        var active;
        if (hp === '/' || hp === '/index.html') {
            // Home: exact only (avoid matching every page)
            active = (path === '/' || path === '/index.html');
        } else {
            var base = hp.replace(/\.html$/, '');
            // exact match OR current path lives under this section directory
            active = (path === hp) || (path.indexOf(base + '/') === 0);
        }
        a.classList.toggle('active', active);
    });

    // Dropdown children (highlight exact page or deeper subpages)
    document.querySelectorAll('.dropdown-menu a, .submenu a').forEach(function (a) {
        var href = a.getAttribute('href');
        if (!href || href.charAt(0) !== '/') { a.classList.remove('active'); return; }
        var hp = href.split('?')[0].split('#')[0];
        var active = (path === hp) || (hp !== '/' && path.indexOf(hp) === 0);
        a.classList.toggle('active', active);
    });
}
setActiveNav();
document.addEventListener('DOMContentLoaded', setActiveNav);
if (window.history && window.history.pushState) {
    // keep highlighting correct if URL changes without full reload
    var _ps = window.history.pushState;
    window.history.pushState = function () { _ps.apply(this, arguments); setActiveNav(); };
}

// --- Navbar scroll effect ---
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 80) {
        navbar.style.boxShadow = '0 4px 20px rgba(15,42,74,0.12)';
        navbar.style.background = 'rgba(255,255,255,0.98)';
    } else {
        navbar.style.boxShadow = 'none';
        navbar.style.background = 'rgba(255,255,255,0.97)';
    }
});

// --- FAQ accordion toggle ---
document.querySelectorAll('.faq-item h4').forEach(function(qh) {
    qh.addEventListener('click', function() {
        const isActive = qh.classList.contains('active');
        // close all
        document.querySelectorAll('.faq-item h4').forEach(function(h) { h.classList.remove('active'); });
        // open clicked one unless it was already open
        if (!isActive) qh.classList.add('active');
    });
    qh.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            qh.click();
        }
    });
});

// --- Smooth scroll ---
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            window.scrollTo({ top: target.offsetTop - 68, behavior: 'smooth' });
        }
    });
});

// --- Active nav link on scroll ---
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-links a[href^="#"]');
window.addEventListener('scroll', () => {
    let current = '';
    sections.forEach(section => {
        if (window.scrollY >= section.offsetTop - 80) current = section.getAttribute('id');
    });
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === '#' + current) link.classList.add('active');
    });
});

// --- Counter animation for hero stats ---
function animateCounters() {
    const statEls = document.querySelectorAll('.stat-num');
    statEls.forEach(el => {
        const text = el.textContent;
        const match = text.match(/(\d+)/);
        if (!match) return;
        const target = parseInt(match[1]);
        let current = 0;
        const step = Math.ceil(target / 40);
        const suffix = text.replace(/\d+/, '');
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            el.textContent = current + suffix;
        }, 40);
    });
}

const heroObs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            animateCounters();
            heroObs.unobserve(e.target);
        }
    });
}, { threshold: 0.3 });

const heroStats = document.querySelector('.hero-stats');
if (heroStats) heroObs.observe(heroStats);

// --- EmailJS Inquiry Form Submission ---
function handleSubmit(e) {
    e.preventDefault();
    const form = document.getElementById('inquiryForm');
    if (!form) return;

    const btn = document.getElementById('submitBtn');
    const formMessage = document.getElementById('formMessage');
    const formSuccess = document.getElementById('formSuccess');
    const formLocation = (location.pathname === '/' || /\/index\.html$/.test(location.pathname)) ? 'homepage' : 'contact_page';

    // ---------- Spam protection ----------
    // Both checks end in the same "success" state on purpose: a bot should not
    // be able to tell that it was filtered out.
    function blockSubmission(reason) {
        console.warn('[Form] blocked by spam filter:', reason);
        trackEvent('form_spam_blocked', { block_type: reason, page_path: location.pathname });
        form.style.display = 'none';
        if (formMessage) formMessage.style.display = 'none';
        if (formSuccess) formSuccess.style.display = 'block';
    }

    // 1) Honeypot: a hidden field that only automated submissions fill in.
    const honeypot = document.getElementById('website');
    if (honeypot && honeypot.value.trim() !== '') {
        blockSubmission('honeypot');
        return;
    }

    // 2) Time trap: no human reads and completes this form in under 3 seconds.
    if (Date.now() - PAGE_LOADED_AT < 3000) {
        blockSubmission('too_fast');
        return;
    }

    // Gather form data
    const d = {
        from_name: document.getElementById('name').value.trim(),
        company: document.getElementById('company').value.trim() || 'N/A',
        from_email: document.getElementById('email').value.trim(),
        phone: document.getElementById('phone').value.trim() || 'N/A',
        product: document.getElementById('product').value,
        quantity: document.getElementById('quantity').value.trim() || 'N/A',
        message: document.getElementById('message').value.trim()
    };

    // Validation
    const missing = [];
    if (!d.from_name) missing.push('Full Name');
    if (!d.from_email) missing.push('Email');
    if (!d.product) missing.push('Product');
    if (!d.message) missing.push('Message');

    if (missing.length > 0) {
        showMessage('Please fill in: ' + missing.join(', '), 'error');
        trackEvent('form_validation_error', {
            error_type: 'missing_required',
            fields: missing.join(','),
            form_location: formLocation,
            page_path: location.pathname
        });
        return;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(d.from_email)) {
        showMessage('Please enter a valid email address.', 'error');
        trackEvent('form_validation_error', {
            error_type: 'invalid_email',
            form_location: formLocation,
            page_path: location.pathname
        });
        return;
    }

    // Show loading state
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
    btn.disabled = true;

    // Safety: wait for EmailJS to be ready (up to 5s)
    function whenEmailJSReady(cb) {
        if (window.emailjs && window.__emailjsReady) return cb();
        let waited = 0;
        const t = setInterval(function() {
            waited += 100;
            if (window.emailjs && window.__emailjsReady) { clearInterval(t); cb(); }
            else if (waited >= 5000) { clearInterval(t); cb(new Error('EmailJS not loaded')); }
        }, 100);
    }

    // Send via EmailJS
    // Service ID: service_4byksa2
    // Template ID: template_hmvbvfs
    const templateParams = {
        from_name: d.from_name,
        company: d.company,
        from_email: d.from_email,
        phone: d.phone,
        product: d.product,
        quantity: d.quantity,
        message: d.message,
        reply_to: d.from_email
    };

    whenEmailJSReady(function(err) {
        if (err || !window.emailjs) {
            console.error('EmailJS SDK not ready');
            btn.innerHTML = '<i class="fas fa-paper-plane"></i> Send Inquiry';
            btn.disabled = false;
            showMessage('Form is still loading. Please try again in a moment, or email us directly: serafinalin091@gmail.com', 'error');
            trackEvent('form_submit_error', {
                error_type: 'sdk_unavailable',
                form_location: formLocation,
                page_path: location.pathname
            });
            return;
        }
        window.emailjs.send('service_4byksa2', 'template_hmvbvfs', templateParams)
        .then(function(response) {
            // Success
            btn.innerHTML = '<i class="fas fa-check"></i> Sent Successfully!';
            btn.style.background = '#27ae60';
            btn.style.borderColor = '#27ae60';
            form.style.display = 'none';
            if (formMessage) formMessage.style.display = 'none';
            if (formSuccess) {
                formSuccess.style.display = 'block';
            }
            // GA4: the single most important conversion on this site.
            trackEvent('generate_lead', {
                form_location: formLocation,
                product: d.product,
                quantity_provided: d.quantity !== 'N/A' ? 'yes' : 'no',
                company_provided: d.company !== 'N/A' ? 'yes' : 'no',
                phone_provided: d.phone !== 'N/A' ? 'yes' : 'no',
                page_path: location.pathname
            });
            // Show browser alert for confirmation
            alert('Email sent successfully! We will reply within 2 hours. Thank you!');
        }, function(error) {
            // Error
            console.error('EmailJS Error:', error);
            btn.innerHTML = '<i class="fas fa-paper-plane"></i> Send Inquiry';
            btn.disabled = false;
            showMessage('Failed to send. Please email us directly: serafinalin091@gmail.com', 'error');
            trackEvent('form_submit_error', {
                error_type: 'send_failed',
                error_message: error && (error.text || error.message) ? String(error.text || error.message).slice(0, 120) : 'unknown',
                form_location: formLocation,
                page_path: location.pathname
            });
        });
    });
}

function showMessage(text, type) {
    const msgEl = document.getElementById('formMessage');
    if (!msgEl) return;
    msgEl.textContent = text;
    msgEl.style.display = 'block';
    msgEl.style.cssText = type === 'error'
        ? 'background:#fff2f2;border:1px solid #ffcdd2;color:#c62828;padding:14px 18px;border-radius:10px;margin-top:12px;font-size:14px;'
        : 'background:#e8f5e9;border:1px solid #c8e6c9;color:#2e7d32;padding:14px 18px;border-radius:10px;margin-top:12px;font-size:14px;';

    if (type === 'error') {
        setTimeout(() => { msgEl.style.display = 'none'; }, 6000);
    }
}

// --- Scroll reveal animations ---
(function initScrollAnimations() {
    const animObs = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
                animObs.unobserve(entry.target);
            }
        });
    }, { threshold: 0.12, rootMargin: '0px 0px -30px 0px' });

    const targets = ['.product-card', '.why-card', '.step', '.af-item', '.av-card'];

    targets.forEach(selector => {
        document.querySelectorAll(selector).forEach((el) => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.55s ease, transform 0.55s ease';
            animObs.observe(el);
        });
    });

    const style = document.createElement('style');
    style.textContent = '.animate-in { opacity: 1 !important; transform: translateY(0) !important; }';
    document.head.appendChild(style);
})();

// --- Keyboard accessibility ---
document.addEventListener('keydown', e => {
    if (e.key === 'Escape') {
        document.querySelector('.nav-links')?.classList.remove('active');
    }
});

// ============================================
// GA4 funnel events
// ============================================

// form_start - first interaction with the inquiry form (reveals drop-off).
(function () {
    var form = document.getElementById('inquiryForm');
    if (!form) return;
    var started = false;
    function markStart() {
        if (started) return;
        started = true;
        trackEvent('form_start', {
            form_location: (location.pathname === '/' || /\/index\.html$/.test(location.pathname)) ? 'homepage' : 'contact_page',
            page_path: location.pathname
        });
    }
    ['input', 'focusin', 'change'].forEach(function (evt) {
        form.addEventListener(evt, markStart);
    });
})();

// quote_cta_click / contact_click - clicks that signal real buying intent.
document.addEventListener('click', function (e) {
    var a = e.target && e.target.closest ? e.target.closest('a') : null;
    if (!a) return;
    var href = a.getAttribute('href') || '';
    var text = (a.textContent || '').replace(/\s+/g, ' ').trim().slice(0, 60);
    if (href.indexOf('contact.html') !== -1) {
        trackEvent('quote_cta_click', { cta_text: text, link_url: href.slice(0, 120), page_path: location.pathname });
        return;
    }
    if (href.indexOf('wa.me') !== -1 || href.indexOf('whatsapp') !== -1) {
        trackEvent('contact_click', { method: 'whatsapp', page_path: location.pathname });
        return;
    }
    if (href.indexOf('mailto:') === 0) {
        trackEvent('contact_click', { method: 'email', page_path: location.pathname });
        return;
    }
    if (href.indexOf('tel:') === 0) {
        trackEvent('contact_click', { method: 'phone', page_path: location.pathname });
    }
}, true);