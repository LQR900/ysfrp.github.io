// ============================================
// YASHENG FRP - JavaScript
// ============================================

// --- Mobile Menu ---
function toggleMenu() {
    const nav = document.querySelector('.nav-links');
    nav.classList.toggle('active');
}

// Close mobile menu when clicking a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        document.querySelector('.nav-links').classList.remove('active');
    });
});

// --- Navbar scroll effect ---
let lastScroll = 0;
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    const scrollY = window.scrollY;

    if (scrollY > 80) {
        navbar.style.boxShadow = '0 4px 20px rgba(15,42,74,0.12)';
        navbar.style.background = 'rgba(255,255,255,0.98)';
    } else {
        navbar.style.boxShadow = 'none';
        navbar.style.background = 'rgba(255,255,255,0.97)';
    }
    lastScroll = scrollY;
});

// --- Smooth scroll for anchor links ---
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const offset = 68; // navbar height
            const top = target.getBoundingClientRect().top + window.scrollY - offset;
            window.scrollTo({ top, behavior: 'smooth' });
        }
    });
});

// --- Active nav link on scroll ---
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-links a[href^="#"]');

window.addEventListener('scroll', () => {
    let current = '';
    sections.forEach(section => {
        const sectionTop = section.offsetTop - 80;
        if (window.scrollY >= sectionTop) {
            current = section.getAttribute('id');
        }
    });

    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === '#' + current) {
            link.classList.add('active');
        }
    });
});

// --- Inquiry Form Submission ---
function handleSubmit(e) {
    e.preventDefault();

    const form = document.getElementById('inquiryForm');
    const btn = form.querySelector('.btn-submit');
    const success = document.getElementById('formSuccess');

    // Collect form data
    const formData = {
        name: document.getElementById('name').value,
        company: document.getElementById('company').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        product: document.getElementById('product').value,
        quantity: document.getElementById('quantity').value,
        message: document.getElementById('message').value
    };

    // Validate required fields
    if (!formData.name || !formData.email || !formData.product || !formData.message) {
        alert('Please fill in all required fields (*)');
        return;
    }

    // Simulate sending - show loading state
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
    btn.disabled = true;

    // Build WhatsApp message
    const whatsappMsg = encodeURIComponent(
        `Inquiry from Website\n` +
        `-------------------\n` +
        `Name: ${formData.name}\n` +
        `Company: ${formData.company || 'N/A'}\n` +
        `Email: ${formData.email}\n` +
        `Phone: ${formData.phone || 'N/A'}\n` +
        `Product: ${formData.product}\n` +
        `Quantity: ${formData.quantity || 'N/A'}\n` +
        `-------------------\n` +
        `Message:\n${formData.message}`
    );

    // Simulate network delay
    setTimeout(() => {
        btn.innerHTML = '<i class="fas fa-check"></i> Sent!';
        btn.style.background = '#27ae60';
        btn.style.borderColor = '#27ae60';
        form.style.display = 'none';
        success.style.display = 'block';

        // Open WhatsApp with the inquiry message
        setTimeout(() => {
            window.open(`https://wa.me/8619867335803?text=${whatsappMsg}`, '_blank');
        }, 800);
    }, 1200);
}

// --- Intersection Observer for scroll animations ---
const observerOptions = {
    threshold: 0.15,
    rootMargin: '0px 0px -40px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animate-in');
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Observe elements for animation
document.querySelectorAll('.product-card, .why-card, .av-card, .step, .af-item').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    observer.observe(el);
});

// Add animation class styles
const animStyle = document.createElement('style');
animStyle.textContent = `
    .animate-in {
        opacity: 1 !important;
        transform: translateY(0) !important;
    }
`;
document.head.appendChild(animStyle);

// --- Product card stagger animation ---
document.querySelectorAll('.product-card').forEach((card, i) => {
    card.style.transitionDelay = `${i * 0.1}s`;
});
document.querySelectorAll('.why-card').forEach((card, i) => {
    card.style.transitionDelay = `${i * 0.08}s`;
});

// --- Counter animation for hero stats ---
function animateCounters() {
    const stats = document.querySelectorAll('.stat-num');
    stats.forEach(stat => {
        const target = stat.textContent;
        const num = parseInt(target);
        const suffix = target.replace(/[0-9]/g, '');
        let current = 0;
        const step = Math.ceil(num / 40);
        const interval = setInterval(() => {
            current += step;
            if (current >= num) {
                current = num;
                clearInterval(interval);
            }
            stat.textContent = current + suffix;
        }, 40);
    });
}

// Trigger counter animation when hero is visible
const heroObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateCounters();
            heroObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

const heroSection = document.querySelector('.hero-content');
if (heroSection) heroObserver.observe(heroSection);

// --- Print-friendly inquiry helper ---
function printInquiry() {
    window.print();
}

// --- Keyboard accessibility ---
document.addEventListener('keydown', (e) => {
    // ESC to close mobile menu
    if (e.key === 'Escape') {
        document.querySelector('.nav-links')?.classList.remove('active');
    }
});
