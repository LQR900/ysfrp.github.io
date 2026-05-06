// ============================================
// YASHENG FRP - JavaScript v2
// ============================================

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

// --- Active nav link ---
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

// --- Counter animation ---
function animateCounters() {
    document.querySelectorAll('.stat-num').forEach(el => {
        const target = parseInt(el.dataset.target);
        const suffix = el.nextElementSibling?.classList.contains('stat-suffix') ? el.nextElementSibling.textContent : '';
        let current = 0;
        const step = Math.ceil(target / 40);
        const timer = setInterval(() => {
            current += step;
            if (current >= target) { current = target; clearInterval(timer); }
            el.textContent = current;
        }, 40);
    });
}
const heroObs = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) { animateCounters(); heroObs.unobserve(e.target); } });
}, { threshold: 0.3 });
const heroEl = document.querySelector('.hero-stats');
if (heroEl) heroObs.observe(heroEl);

// --- Inquiry Form ---
function handleSubmit(e) {
    e.preventDefault();
    const form = document.getElementById('inquiryForm');
    const btn = form.querySelector('.btn-submit');
    const success = document.getElementById('formSuccess');

    const d = {
        name: document.getElementById('name').value,
        company: document.getElementById('company').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        product: document.getElementById('product').value,
        quantity: document.getElementById('quantity').value,
        message: document.getElementById('message').value
    };

    if (!d.name || !d.email || !d.product || !d.message) {
        alert('Please fill in all required fields (*)');
        return;
    }

    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
    btn.disabled = true;

    const msg = encodeURIComponent(
        `Inquiry from Website\n` +
        `-------------------\n` +
        `Name: ${d.name}\n` +
        `Company: ${d.company || 'N/A'}\n` +
        `Email: ${d.email}\n` +
        `Phone: ${d.phone || 'N/A'}\n` +
        `Product: ${d.product}\n` +
        `Quantity: ${d.quantity || 'N/A'}\n` +
        `-------------------\n` +
        `Message:\n${d.message}`
    );

    setTimeout(() => {
        btn.innerHTML = '<i class="fas fa-check"></i> Sent!';
        btn.style.background = '#27ae60';
        btn.style.borderColor = '#27ae60';
        form.style.display = 'none';
        success.style.display = 'block';
        setTimeout(() => window.open(`https://wa.me/8619867335803?text=${msg}`, '_blank'), 800);
    }, 1200);
}

// --- Scroll animations ---
const animObs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) { e.target.classList.add('animate-in'); animObs.unobserve(e.target); }
    });
}, { threshold: 0.15, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.product-card, .why-card, .step, .af-item, .about-gallery, .cta-banner').forEach((el, i) => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(24px)';
    el.style.transition = `opacity 0.6s ease ${i * 0.06}s, transform 0.6s ease ${i * 0.06}s`;
    animObs.observe(el);
});

const animStyle = document.createElement('style');
animStyle.textContent = '.animate-in { opacity: 1 !important; transform: translateY(0) !important; }';
document.head.appendChild(animStyle);

// --- Keyboard ---
document.addEventListener('keydown', e => {
    if (e.key === 'Escape') document.querySelector('.nav-links')?.classList.remove('active');
});
