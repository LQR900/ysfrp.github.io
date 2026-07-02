// ============================================
// YASHENG FRP - JavaScript v4 (EmailJS)
// ============================================

// --- EmailJS: dynamic load + init (local, no CDN dependency) ---
(function() {
    const EMAILJS_SDK = '/assets/js/email.min.js';
    const EMAILJS_PUBLIC_KEY = 'T3oS6G5q0jXvDcxnw';
    const s = document.createElement('script');
    s.src = EMAILJS_SDK;
    s.onload = function() {
        if (window.emailjs) {
            emailjs.init(EMAILJS_PUBLIC_KEY);
            window.__emailjsReady = true;
            console.log('EmailJS loaded and initialized.');
        }
    };
    s.onerror = function() {
        console.error('Failed to load EmailJS SDK from local path. Form will not work until this is fixed.');
    };
    document.head.appendChild(s);
})();

// --- Mobile Menu ---
function toggleMenu() {
    document.querySelector('.nav-links').classList.toggle('active');
}
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => document.querySelector('.nav-links').classList.remove('active'));
});

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
        return;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(d.from_email)) {
        showMessage('Please enter a valid email address.', 'error');
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
            // Show browser alert for confirmation
            alert('Email sent successfully! We will reply within 2 hours. Thank you!');
        }, function(error) {
            // Error
            console.error('EmailJS Error:', error);
            btn.innerHTML = '<i class="fas fa-paper-plane"></i> Send Inquiry';
            btn.disabled = false;
            showMessage('Failed to send. Please email us directly: serafinalin091@gmail.com', 'error');
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