# Generator for 5 SEO product pages for YSFRP
# Run with: powershell -ExecutionPolicy Bypass -File generate-seo-pages.ps1

# ---- Shared SEO page directory (10 core products per sitemap) ----
$allSeo = [ordered]@{
    'frp-radome'            = @{ name='FRP Radome Antenna Cover';       url='https://ysfrp.com/products/equipment/frp-radome/';            image='/assets/images/radome-antenna.jpg';         short='Custom FRP fiberglass radome antenna covers for 5G, radar and satellite comms.' }
    'fiberglass-enclosure'  = @{ name='Custom Fiberglass Enclosure';    url='https://ysfrp.com/products/equipment/fiberglass-enclosure/';  image='/assets/images/equipment-cabinet.jpg';      short='IP65-IP68 rated FRP equipment housings and industrial enclosures.' }
    'custom-frp-shell'      = @{ name='Custom FRP Shell';              url='https://ysfrp.com/products/equipment/custom-frp-shell/';      image='/assets/images/automotive-car.jpg';        short='Custom fiberglass covers, housings and structural FRP shells.' }
    'carbon-fiber-shell'    = @{ name='Carbon Fiber Shell (CFRP)';     url='https://ysfrp.com/products/equipment/carbon-fiber-shell/';    image='/assets/images/automotive-car.jpg';        short='Lightweight, high-strength carbon fiber shells and CFRP enclosures.' }
    'usv-hull'              = @{ name='USV Fiberglass Hull';           url='https://ysfrp.com/products/equipment/usv-hull/';              image='/assets/images/usv-boat.jpg';              short='Custom fiberglass and carbon fiber unmanned surface vehicle hulls.' }
    'frp-speaker-housing'   = @{ name='FRP Speaker Housing';           url='https://ysfrp.com/products/equipment/frp-speaker-housing/';   image='/assets/images/equipment-cabinet.jpg';      short='Fiberglass horn speaker enclosures for outdoor and marine audio.' }
    'robot-enclosure'       = @{ name='Robot Enclosure';              url='https://ysfrp.com/products/equipment/robot-enclosure/';       image='/assets/images/equipment-cabinet.jpg';      short='FRP and CFRP enclosures for robotics and automation.' }
    'frp-fan-blade'         = @{ name='FRP Fan Blade';                url='https://ysfrp.com/products/equipment/frp-fan-blade/';         image='/assets/images/equipment-cabinet.jpg';      short='Corrosion-resistant fiberglass fan blades and impellers.' }
    'ev-charging-cover'     = @{ name='EV Charging Cover';            url='https://ysfrp.com/products/equipment/ev-charging-cover/';     image='/assets/images/automotive-car.jpg';        short='Composite enclosures for EV charging stations and cabinets.' }
    'custom-composite-parts'= @{ name='Custom Composite Parts';       url='https://ysfrp.com/products/equipment/custom-composite-parts/'; image='/assets/images/equipment-cabinet.jpg';      short='Bespoke FRP and carbon fiber composite components.' }
}

$existingCats = @(
    @{ name='FRP Radomes';            url='/products/radomes/' }
    @{ name='USV Hulls';              url='/products/usv-hulls/' }
    @{ name='Equipment Enclosures';   url='/products/equipment/' }
    @{ name='Automotive Shells';      url='/products/automotive/' }
)

# ---- Navigation (copied pattern, Products dropdown = 4 existing + 10 SEO) ----
$dropLinks = @()
foreach ($c in $existingCats) { $dropLinks += "<li><a href=`"$($c.url)`">$($c.name)</a></li>" }
foreach ($k in $allSeo.Keys)  { $dropLinks += "<li><a href=`"$($allSeo[$k].url)`">$($allSeo[$k].name)</a></li>" }
$dropdownMenu = "<ul class=`"dropdown-menu`">" + ($dropLinks -join "`n                        ") + "</ul>"

$nav = @"
    <!-- NAV -->
    <nav aria-label="Main navigation" class="navbar">
        <div class="container nav-inner">
            <a href="/" class="logo">
                <span class="logo-icon"><img fetchpriority="high" src="/assets/images/logo.webp" height="50" width="180" alt="YSFRP - FRP OEM Manufacturer" class="logo-img"></span>
                <span class="logo-text">YASHENG <em>FRP</em></span>
            </a>
            <ul class="nav-links">
                <li><a href="/">Home</a></li>
                <li class="dropdown">
                    <a href="/products.html">Products <i class="fas fa-chevron-down" style="font-size:10px; margin-left: 4px;"></i></a>
                    $dropdownMenu
                </li>
                <li><a href="/about.html">About Us</a></li>
                <li><a href="/factory.html">Factory</a></li>
                <li><a href="/blog.html">Blog</a></li>
                <li><a href="/contact.html" class="btn-nav">Contact Us</a></li>
            </ul>
            <button class="hamburger" onclick="toggleMenu()"><i class="fas fa-bars"></i></button>
        </div>
    </nav>
"@

# ---- Footer (Products column links to all 10 new SEO pages) ----
$footSeo = @()
foreach ($k in $allSeo.Keys) { $footSeo += "<li><a href=`"$($allSeo[$k].url)`" title=`"$($allSeo[$k].name) - YSFRP OEM`">$($allSeo[$k].name)</a></li>" }
$footerSeoList = ($footSeo -join "`n                        ")

$footer = @"
    <!-- FOOTER -->
    </main>
<footer class="footer">
        <div class="container">
            <div class="footer-top">
                <div class="footer-brand">
                    <div class="logo">
                        <span class="logo-icon"><img src="/assets/images/logo.webp" height="50" width="180" alt="YSFRP - FRP OEM Manufacturer" class="logo-img"></span>
                        <span class="logo-text">YASHENG <em>FRP</em></span>
                    </div>
                    <p>Professional OEM/ODM manufacturer of custom FRP, fiberglass and carbon fiber composite shells since 2015. ISO 9001 certified factory in Dongguan, China. Serving 50+ countries worldwide.</p>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="/" title="Home - FRP OEM Manufacturer">Home</a></li>
                        <li><a href="/products.html" title="Products - Custom FRP Enclosures">Products</a></li>
                        <li><a href="/about.html" title="About Us - FRP Manufacturer">About Us</a></li>
                        <li><a href="/factory.html" title="Factory - Manufacturing Facility">Factory</a></li>
                        <li><a href="/cases.html" title="Case Studies - FRP OEM Success Stories">Case Studies</a></li>
                        <li><a href="/blog.html" title="Blog - FRP Industry Insights">Blog</a></li>
                        <li><a href="/contact.html" title="Contact Us - Get a Quote">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-links">
                    <h4>Products</h4>
                    <ul>
                        $footerSeoList
                    </ul>
                </div>
                <div class="footer-contact">
                    <h4>Contact Us</h4>
                    <p><i class="fab fa-whatsapp"></i> <a href="https://wa.me/8613113125793" target="_blank">+86 131 1312 5793</a></p>
                    <p><i class="fas fa-envelope"></i> <a href="mailto:serafinalin091@gmail.com">serafinalin091@gmail.com</a></p>
                    <p><i class="fas fa-map-marker-alt"></i> Dongguan, Guangdong, China</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 Dongguan Yasheng FRP Technology Co., Ltd. All rights reserved. | OEM FRP & Carbon Fiber Manufacturer Since 2015</p>
                <div class="footer-badges">
                    <span><i class="fas fa-shield-alt"></i> ISO 9001 Certified</span>
                    <span><i class="fas fa-truck"></i> Global Shipping to 50+ Countries</span>
                </div>
            </div>
        </div>
    </footer>

    <a href="https://wa.me/8613113125793" target="_blank" aria-label="Chat on WhatsApp" class="whatsapp-float" title="Chat on WhatsApp"><i class="fab fa-whatsapp"></i></a>
    <script src="/script.js"></script>
</body>
</html>
"@

# ---- Shared sections ----
$processSteps = @"
                <div class="process-steps">
                    <div class="step"><div class="step-num">01</div><div class="step-icon"><i class="fas fa-drafting-compass"></i></div><h4>Design Review</h4><p>Analyze your drawings, 3D models, frequency requirements and operating environment with our engineering team.</p></div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step"><div class="step-num">02</div><div class="step-icon"><i class="fas fa-shapes"></i></div><h4>Mold Making</h4><p>CNC-milled or hand-built precision mold created from the approved design for repeatable production.</p></div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step"><div class="step-num">03</div><div class="step-icon"><i class="fas fa-layer-group"></i></div><h4>Layup &amp; Curing</h4><p>Vacuum infusion or hand layup with controlled resin-to-fiber ratio and controlled curing cycle.</p></div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step"><div class="step-num">04</div><div class="step-icon"><i class="fas fa-search-plus"></i></div><h4>Trimming &amp; Finishing</h4><p>CNC trimming, surface finishing, gel coat or paint application and mounting point preparation.</p></div>
                    <div class="step-arrow"><i class="fas fa-arrow-right"></i></div>
                    <div class="step"><div class="step-num">05</div><div class="step-icon"><i class="fas fa-clipboard-check"></i></div><h4>QC &amp; Delivery</h4><p>Dimensional inspection, functional test, secure export packaging and worldwide shipping.</p></div>
                </div>
"@

$cta = @"
    <section class="section" style="background: linear-gradient(135deg, #0a1a2e 0%, #0f2a4a 50%, #1a4066 100%);">
        <div class="container custom-cta" style="text-align:center; color:#fff;">
            <h2 style="color:#fff;">Ready to Start Your Custom Project?</h2>
            <p style="color:#d6e2f0;">Send us your drawings, 3D models or requirements. Our engineering team replies with a detailed quotation within 24 hours. MOQ starts from just 1 piece for prototypes.</p>
            <div class="cta-features" style="justify-content:center; display:flex; flex-wrap:wrap; gap:18px; margin:20px 0;">
                <span><i class="fas fa-check-circle"></i> Free Design Review</span>
                <span><i class="fas fa-check-circle"></i> Prototype in 7-15 Days</span>
                <span><i class="fas fa-check-circle"></i> Mass Production</span>
                <span><i class="fas fa-check-circle"></i> Global Shipping</span>
            </div>
            <div style="margin-top:24px;">
                <a href="https://wa.me/8613113125793?text=Hi,%20I'm%20interested%20in%20a%20custom%20FRP%20project" target="_blank" class="btn btn-primary btn-lg"><i class="fab fa-whatsapp"></i> WhatsApp +86 131 1312 5793</a>
                <a href="mailto:serafinalin091@gmail.com" class="btn btn-outline btn-lg" style="color:#fff; border-color:#fff;"><i class="fas fa-envelope"></i> serafinalin091@gmail.com</a>
            </div>
        </div>
    </section>
"@

# ---- Head template (tokens replaced per page) ----
$headTemplate = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="preload" href="/assets/images/hero-bg.webp" as="image" type="image/webp">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{TITLE}</title>
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='6' fill='%230f2a4a'/%3E%3Ctext x='16' y='22' font-family='Arial,sans-serif' font-size='14' font-weight='bold' fill='%23e67e22' text-anchor='middle'%3EYS%3C/text%3E%3C/svg%3E">
    <meta name="description" content="{METADESC}">
    <meta name="keywords" content="{KEYWORDS}">
    <link rel="canonical" href="{CANON}">
    <meta name="robots" content="index, follow">
    <link rel="alternate" hreflang="en" href="{CANON}">
    <link rel="alternate" hreflang="x-default" href="{CANON}">
    <!-- Open Graph -->
    <meta property="og:title" content="{TITLE}">
    <meta property="og:description" content="{METADESC}">
    <meta property="og:type" content="website">
    <meta property="og:url" content="{CANON}">
    <meta property="og:image" content="https://ysfrp.com{OGIMAGE}">
    <meta property="og:site_name" content="YSFRP - Yasheng FRP">
    <meta property="og:locale" content="en_US">
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{TITLE}">
    <meta name="twitter:description" content="{METADESC}">
    <meta name="twitter:image" content="https://ysfrp.com{OGIMAGE}">
    <meta name="twitter:site" content="@ysfrp">
    <meta name="twitter:creator" content="@ysfrp">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap" onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&amp;family=Inter:wght@300;400;500;600;700&amp;display=swap"></noscript>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" media="print" onload="this.media='all'">
    <noscript></noscript>
    <script type="text/javascript" async src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>
    <script type="text/javascript">emailjs.init('T3oS6G5q0jXvDcxnw');</script>
    <link rel="stylesheet" href="/style.css">
    <!-- Google Analytics 4 -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-JSQ94Z5H4H"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-JSQ94Z5H4H');
    </script>
    <!-- JSON-LD: Organization + BreadcrumbList + Product + FAQPage -->
    <script type="application/ld+json">
{JSONLD}
    </script>

    <link rel="sitemap" type="application/xml" title="XML Sitemap" href="/sitemap.xml">
</head>
<a href="#main-content" class="skip-link" style="position:absolute;left:-9999px;top:auto;width:1px;height:1px;overflow:hidden;z-index:-9999;" onfocus="this.style.left='0';this.style.top='0';this.style.width='auto';this.style.height='auto';this.style.zIndex='9999';this.style.outline='3px solid #e67e22';">Skip to main content</a>
<body>
"@

# ---- JSON-LD template (tokens replaced per page) ----
$jsonTemplate = @"
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": "https://ysfrp.com/#organization",
      "name": "Dongguan Yasheng FRP Technology Co., Ltd.",
      "alternateName": ["Yasheng FRP", "YSFRP"],
      "url": "https://ysfrp.com",
      "logo": { "@type": "ImageObject", "url": "https://ysfrp.com/assets/images/logo.webp" },
      "description": "Dongguan Yasheng FRP Technology Co., Ltd. (Yasheng FRP / YSFRP) is a China-based OEM manufacturer specializing in custom fiberglass and carbon fiber shells. ISO 9001 certified, 7,000 m2 facility in Dongguan, Guangdong, serving 50+ countries since 2015.",
      "slogan": "Custom FRP & Carbon Fiber Shell OEM Manufacturer",
      "foundingDate": "2015",
      "address": {
        "@type": "PostalAddress",
        "streetAddress": "Room 1103, HuiNeng Building, No. 53, Huayuan Avenue, Xiegang Town",
        "addressLocality": "Dongguan",
        "addressRegion": "Guangdong",
        "postalCode": "523000",
        "addressCountry": "CN"
      },
      "geo": { "@type": "GeoCoordinates", "latitude": "22.96", "longitude": "114.03" },
      "contactPoint": [
        {
          "@type": "ContactPoint",
          "telephone": "+86 131 1312 5793",
          "contactType": "sales",
          "availableLanguage": ["English", "Chinese"],
          "url": "https://wa.me/8613113125793"
        },
        {
          "@type": "ContactPoint",
          "email": "serafinalin091@gmail.com",
          "contactType": "sales",
          "availableLanguage": ["English", "Chinese"]
        }
      ],
      "areaServed": "Worldwide",
      "certification": "ISO 9001",
      "knowsAbout": ["Fiberglass Reinforced Plastic", "Carbon Fiber Composites", "FRP Radomes", "Composite Enclosures", "OEM Manufacturing"],
      "numberOfEmployees": "50-100"
    },
    {
      "@type": "BreadcrumbList",
      "@id": "{CANON}#breadcrumb",
      "itemListElement": [
        { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://ysfrp.com/" },
        { "@type": "ListItem", "position": 2, "name": "Products", "item": "https://ysfrp.com/products.html" },
        { "@type": "ListItem", "position": 3, "name": "{BNAME}", "item": "{CANON}" }
      ]
    },
    {
      "@type": "Product",
      "@id": "{CANON}#product",
      "name": "{PNAME}",
      "description": "{PDESC}",
      "brand": { "@type": "Brand", "name": "YSFRP" },
      "manufacturer": {
        "@type": "Organization",
        "name": "Dongguan Yasheng FRP Technology Co., Ltd.",
        "url": "https://ysfrp.com"
      },
      "model": "{PMODEL}",
      "category": "Industrial > Composite Manufacturing > Custom Enclosures",
      "image": "https://ysfrp.com{OIMAGE}",
      "url": "{CANON}",
      "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "4.9",
        "reviewCount": "128",
        "bestRating": "5",
        "worstRating": "1"
      },
      "offers": {
        "@type": "Offer",
        "priceCurrency": "USD",
        "price": "100",
        "priceValidUntil": "2027-12-31",
        "availability": "https://schema.org/InStock",
        "minOrderQuantity": 1,
        "url": "{CANON}",
        "seller": { "@type": "Organization", "name": "Dongguan Yasheng FRP Technology Co., Ltd." }
      }
    },
    {
      "@type": "FAQPage",
      "mainEntity": [
{FAQJSON}
      ]
    }
  ]
}
"@

# ---- Helper to render an app-grid from items ----
function RenderGrid($items) {
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append('<div class="app-grid">')
    foreach ($it in $items) {
        [void]$sb.Append('<div class="app-item"><i class="fas ' + $it.icon + '"></i><h4>' + $it.title + '</h4><p>' + $it.text + '</p></div>')
    }
    [void]$sb.Append('</div>')
    return $sb.ToString()
}

# ---- Helper to render spec table ----
function RenderSpec($rows) {
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append('<div class="spec-table"><h3><i class="fas fa-list-alt"></i> Technical Specifications</h3><table>')
    foreach ($r in $rows) {
        [void]$sb.Append('<tr><th>' + $r[0] + '</th><td>' + $r[1] + '</td></tr>')
    }
    [void]$sb.Append('</table></div>')
    return $sb.ToString()
}

# ---- Helper to build FAQ JSON items ----
function BuildFaqJson($faqs) {
    $arr = @()
    foreach ($f in $faqs) {
        $arr += '        {
          "@type": "Question",
          "name": "' + $f.q + '",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "' + $f.a + '"
          }
        }'
    }
    return ($arr -join ",`n")
}

# ---- Helper to render FAQ HTML ----
function RenderFaqHtml($faqs) {
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append('<div class="faq-list">')
    foreach ($f in $faqs) {
        [void]$sb.Append('<div class="faq-item"><h4>' + $f.q + '</h4><p>' + $f.a + '</p></div>')
    }
    [void]$sb.Append('</div>')
    return $sb.ToString()
}

# ---- Helper to render related product cards (4) ----
function RenderRelated($currentKey, $createdKeys) {
    $others = $createdKeys | Where-Object { $_ -ne $currentKey }
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append('<div class="product-grid catalog-grid">')
    foreach ($k in $others) {
        $info = $allSeo[$k]
        [void]$sb.Append('<div class="product-card"><div class="product-top" style="background-image: url('' + $info.image + '');"><div class="product-label">YSFRP</div></div><div class="product-info"><h3>' + $info.name + '</h3><p>' + $info.short + '</p><a href="' + $info.url + '" class="btn btn-primary btn-sm mt-16">View Product</a></div></div>')
    }
    [void]$sb.Append('</div>')
    return $sb.ToString()
}

# ===================================================================
# PAGE DATA
# ===================================================================
$pages = @()

# ---- PAGE 1: frp-radome ----
$pages += @{
    key = 'frp-radome'
    path = 'E:\文档\ysfrp\frp-radome\index.html'
    url = 'https://ysfrp.com/products/equipment/frp-radome/'
    title = 'Custom FRP Fiberglass Radome Manufacturer | OEM Antenna Cover Factory - YSFRP'
    metaDesc = 'Yasheng FRP is a professional custom FRP fiberglass radome manufacturer in China. OEM/ODM antenna covers for 5G, radar, satellite communications. L/S/C/X/Ku band. MOQ 1 piece, global shipping.'
    keywords = 'FRP radome manufacturer, fiberglass antenna cover OEM, 5G radome factory, radar dome supplier, custom radome manufacturer, satellite comms radome, GFRP radome, antenna cover factory'
    h1 = 'Custom FRP Fiberglass Radome Antenna Cover Manufacturer'
    breadcrumbName = 'Custom FRP Fiberglass Radome'
    productName = 'Custom FRP Fiberglass Radome'
    productDesc = 'Custom-engineered fiberglass reinforced plastic (FRP) antenna covers for 5G base stations, radar systems and satellite communication. Supports L, S, C, X and Ku bands with signal transmission above 95%.'
    model = 'YS-FRP-RADOME'
    image = '/assets/images/radome-antenna.jpg'
    overview = 'Yasheng FRP manufactures high-performance fiberglass reinforced plastic (FRP) antenna covers engineered for optimal signal transmission across all major frequency bands. Our radomes are produced via vacuum infusion or hand layup with a UV-resistant gel coat finish for long-term outdoor durability. We provide full OEM/ODM service from prototype to mass production, with MOQ starting from just 1 piece.'
    specRows = @(
        @('Material','Fiberglass Reinforced Polymer (FRP / GFRP)'),
        @('Diameter Range','200mm - 4,000mm (custom sizes available)'),
        @('Wall Thickness','2mm - 8mm (depending on diameter & requirements)'),
        @('Frequency Bands','L, S, C, X, Ku band (customizable)'),
        @('Signal Transmission','>95% at operating frequency'),
        @('Operating Temperature','-40C to +85C'),
        @('Wind Load Rating','Up to 250 km/h (155 mph)'),
        @('MOQ','1 piece (prototype) / 5 pieces (production)')
    )
    productSections = @('Antenna Radomes','RF Window Shells','Satellite Comms Radomes','Weather Radar Covers','5G Small Cell Enclosures')
    applications = @(
        @{ icon='fa-satellite-dish'; title='5G Base Stations'; text='Low-loss radomes for 5G mmWave and sub-6 GHz antennas with minimal signal attenuation.' },
        @{ icon='fa-radar'; title='Radar Systems'; text='Weather radar, air traffic control and maritime surveillance radome covers.' },
        @{ icon='fa-satellite'; title='Satellite Communication'; text='VSAT earth station and satellite dish protection covers.' },
        @{ icon='fa-wifi'; title='Microwave Links'; text='Point-to-point microwave link antenna protection enclosures.' },
        @{ icon='fa-cloud-sun-rain'; title='Weather Monitoring'; text='Meteorological and environmental sensor antenna housings.' },
        @{ icon='fa-shield-alt'; title='Military & Defense'; text='Tactical and secure communication antenna radomes.' }
    )
    advantages = @(
        @{ icon='fa-broadcast-tower'; title='Low Dielectric Loss'; text='Engineered composites minimize signal attenuation across target bands.' },
        @{ icon='fa-cloud-showers-heavy'; title='Weatherproof'; text='Sealed construction resists rain, salt mist and UV exposure.' },
        @{ icon='fa-industry'; title='Corrosion Resistant'; text='FRP does not rust, ideal for coastal and industrial sites.' },
        @{ icon='fa-feather'; title='Lightweight'; text='High stiffness-to-weight ratio reduces tower load.' },
        @{ icon='fa-sun'; title='UV Stable'; text='Gel coat finish retains color and performance outdoors.' },
        @{ icon='fa-cogs'; title='Fully Customizable'; text='Shapes, sizes and frequencies tailored to your antenna.' }
    )
    customizations = @(
        @{ icon='fa-shapes'; title='Shape & Profile'; text='Spherical, hemispherical, planar or custom contours.' },
        @{ icon='fa-ruler-combined'; title='Size & Diameter'; text='From 200mm to 4,000mm and beyond on request.' },
        @{ icon='fa-wave-square'; title='Frequency Band'; text='Optimized for L, S, C, X, Ku or custom bands.' },
        @{ icon='fa-palette'; title='Color & Finish'; text='White standard, RAL colors, gel coat or 2K paint.' },
        @{ icon='fa-bolt'; title='Mounting Options'; text='Flanges, brackets and pre-drilled holes.' },
        @{ icon='fa-layer-group'; title='Wall Construction'; text='Single or sandwich wall for structural needs.' }
    )
    faqs = @(
        @{ q='Can you manufacture radomes from custom drawings?'; a='Yes. Send us your antenna technical drawing, frequency range and dimensional requirements. Our engineering team designs and manufactures a radome that fits your antenna system precisely, from a single prototype to mass production.' },
        @{ q='What frequency bands do your radomes support?'; a='We manufacture radomes for all major frequency bands including L, S, C, X and Ku band. Custom frequency optimization is available based on your specific antenna and application requirements.' },
        @{ q='What is your minimum order quantity for radomes?'; a='For fully custom radome designs we accept prototype orders starting from just 1 piece. For standard sizes MOQ starts from 5 pieces, with very competitive pricing for larger production runs.' },
        @{ q='Do you provide OEM radome manufacturing services?'; a='Absolutely. We are a full OEM/ODM manufacturer. We can build to your drawings, co-develop a new design, and supply white-label radomes with your branding for global distribution.' },
        @{ q='How long does radome production take?'; a='Prototype samples are typically ready in 7-15 days. Production orders take 20-30 days depending on quantity and customization level. Rush orders can be arranged for time-sensitive projects.' }
    )
}

# ---- PAGE 2: fiberglass-enclosure ----
$pages += @{
    key = 'fiberglass-enclosure'
    path = 'E:\文档\ysfrp\fiberglass-enclosure\index.html'
    url = 'https://ysfrp.com/products/equipment/fiberglass-enclosure/'
    title = 'Custom Fiberglass Enclosure Manufacturer | FRP Equipment Housing OEM Factory - YSFRP'
    metaDesc = 'China OEM manufacturer of custom fiberglass enclosures (FRP equipment housings). IP65-IP68 rated, corrosion-resistant, thermally stable. From prototype to mass production. MOQ 1 piece, global shipping.'
    keywords = 'fiberglass enclosure manufacturer, FRP equipment housing OEM, custom FRP enclosure, IP65 FRP enclosure, composite enclosure factory, corrosion resistant enclosure, outdoor cabinet housing'
    h1 = 'Custom Fiberglass Enclosure (FRP Equipment Housing) Manufacturer'
    breadcrumbName = 'Custom Fiberglass Enclosure'
    productName = 'Custom Fiberglass Enclosure'
    productDesc = 'Custom fiberglass reinforced plastic (FRP) equipment enclosures and housings with IP65-IP68 ingress protection. Corrosion-resistant, thermally stable and lightweight for indoor and outdoor industrial use.'
    model = 'YS-FRP-ENC'
    image = '/assets/images/equipment-cabinet.jpg'
    overview = 'Yasheng FRP produces custom fiberglass enclosures (FRP equipment housings) for industrial, telecom, marine and IoT applications. Our enclosures deliver IP65-IP68 ingress protection, excellent corrosion resistance and thermal stability. We support the full OEM/ODM workflow from prototype to mass production, with MOQ starting from 1 piece.'
    specRows = @(
        @('Material','Fiberglass Reinforced Polymer (FRP / GFRP)'),
        @('Ingress Rating','IP65 / IP66 / IP67 / IP68 (per design)'),
        @('Wall Thickness','2mm - 10mm (depending on structure)'),
        @('Operating Temperature','-40C to +85C'),
        @('Corrosion Resistance','Excellent - suitable for coastal & chemical sites'),
        @('Color Options','RAL colors, gel coat or 2K paint'),
        @('MOQ','1 piece (prototype)')
    )
    productSections = @('Industrial Equipment Enclosures','Outdoor Cabinet Housings','Telecom Shelter Shells','IoT Sensor Enclosures','Marine Instrument Housings')
    applications = @(
        @{ icon='fa-industry'; title='Industrial Equipment'; text='Housings for controllers, drives and power electronics.' },
        @{ icon='fa-satellite-dish'; title='Telecom Shelters'; text='Base station and small-cell equipment cabinets.' },
        @{ icon='fa-microchip'; title='IoT Sensors'; text='Protective shells for outdoor sensor nodes.' },
        @{ icon='fa-water'; title='Marine Instruments'; text='Enclosures for navigation and monitoring gear.' },
        @{ icon='fa-bolt'; title='Power Distribution'; text='FRP cabinets for switchgear and junctions.' },
        @{ icon='fa-train'; title='Transport & Rail'; text='Signal and trackside equipment housings.' }
    )
    advantages = @(
        @{ icon='fa-shield-alt'; title='IP65-IP68 Protection'; text='Sealed designs keep dust and water out.' },
        @{ icon='fa-industry'; title='Corrosion Resistant'; text='FRP withstands salt, chemicals and humidity.' },
        @{ icon='fa-thermometer-half'; title='Thermal Stability'; text='Low thermal conductivity, stable in harsh climates.' },
        @{ icon='fa-feather'; title='Lightweight'; text='Easier handling and lower support load.' },
        @{ icon='fa-bolt'; title='Dielectric'; text='Non-conductive, safe near live equipment.' },
        @{ icon='fa-cogs'; title='Custom Geometry'; text='Any shape, cut-out and mounting layout.' }
    )
    customizations = @(
        @{ icon='fa-shapes'; title='Enclosure Shape'; text='Box, cylindrical, curved or fully bespoke.' },
        @{ icon='fa-cut'; title='Cut-outs & Ports'; text='Cable glands, windows and connector openings.' },
        @{ icon='fa-bolt'; title='Mounting'; text='Wall, pole, floor or rack mounting options.' },
        @{ icon='fa-palette'; title='Finish'; text='RAL color, gel coat or anti-static paint.' },
        @{ icon='fa-layer-group'; title='Wall Build'; text='Single or insulated sandwich walls.' },
        @{ icon='fa-fingerprint'; title='Branding'; text='Logo embossing and labeling.' }
    )
    faqs = @(
        @{ q='Can you manufacture custom fiberglass enclosures from drawings?'; a='Yes. Provide your drawing, 3D model or dimensions and we will engineer a matching FRP enclosure, including cut-outs, mounts and seals, from a single prototype upward.' },
        @{ q='What IP ratings are available for FRP enclosures?'; a='We manufacture enclosures rated IP65, IP66, IP67 and IP68 depending on the sealing design and application. Tell us the environment and we will specify the right rating.' },
        @{ q='What materials do you use for fiberglass enclosures?'; a='We use fiberglass reinforced polymer (FRP/GFRP) with polyester, vinyl ester or epoxy resin systems, selected for UV, chemical or fire-retardant performance as needed.' },
        @{ q='Do you offer FRP enclosure OEM/ODM services?'; a='Yes. We provide complete OEM/ODM service: design review, mold making, production and branding. We regularly supply enclosures under customer labels worldwide.' },
        @{ q='What is your MOQ for custom fiberglass enclosures?'; a='MOQ is 1 piece for prototypes. Production pricing becomes highly competitive as volume increases, and we support both small batches and mass production.' }
    )
}

# ---- PAGE 3: custom-frp-shell ----
$pages += @{
    key = 'custom-frp-shell'
    path = 'E:\文档\ysfrp\custom-frp-shell\index.html'
    url = 'https://ysfrp.com/products/equipment/custom-frp-shell/'
    title = 'Custom FRP Shell Manufacturer | Fiberglass Cover OEM Factory - YSFRP'
    metaDesc = 'Professional custom FRP shell manufacturer in China. Fiberglass covers, housings, and enclosures for any application. Full OEM/ODM service from prototype to mass production. 50+ countries served.'
    keywords = 'custom FRP shell manufacturer, fiberglass cover OEM, FRP housing factory, composite shell supplier, custom fiberglass enclosure, FRP bracket manufacturer, FRP cover OEM'
    h1 = 'Custom FRP Shell Manufacturer — Fiberglass Cover OEM/ODM Factory'
    breadcrumbName = 'Custom FRP Shell'
    productName = 'Custom FRP Shell'
    productDesc = 'Custom fiberglass reinforced plastic (FRP) shells, covers and housings for any application. Full OEM/ODM service from prototype to mass production, serving 50+ countries.'
    model = 'YS-FRP-SHELL'
    image = '/assets/images/automotive-car.jpg'
    overview = 'Yasheng FRP is a professional custom FRP shell manufacturer. We produce fiberglass covers, housings, structural shells and brackets for virtually any application. Our full OEM/ODM service covers design review, CNC mold making, layup, finishing and worldwide shipping, with MOQ from 1 piece.'
    specRows = @(
        @('Material','Fiberglass Reinforced Polymer (FRP / GFRP)'),
        @('Process','Hand layup, spray-up or vacuum infusion'),
        @('Surface Finish','Gel coat, 2K paint, matte or gloss'),
        @('Wall Thickness','1.5mm - 12mm (per design)'),
        @('Operating Temperature','-40C to +85C'),
        @('MOQ','1 piece (prototype)')
    )
    productSections = @('Custom FRP Housings','Fiberglass Protective Covers','Structural FRP Shells','FRP Aesthetic Enclosures','FRP Brackets & Mounts')
    applications = @(
        @{ icon='fa-car'; title='Automotive & Mobility'; text='Body panels, covers and trim shells.' },
        @{ icon='fa-robot'; title='Machinery Covers'; text='Protective shrouds for industrial equipment.' },
        @{ icon='fa-building'; title='Architectural'; text='Decorative and functional FRP cladding.' },
        @{ icon='fa-plug'; title='Electrical Housings'; text='Insulating enclosures for devices.' },
        @{ icon='fa-leaf'; title='Agriculture'; text='Durable covers for outdoor machinery.' },
        @{ icon='fa-tools'; title='Jigs & Fixtures'; text='Custom FRP brackets and mounts.' }
    )
    advantages = @(
        @{ icon='fa-feather'; title='Lightweight'; text='Strong yet light, easy to handle and install.' },
        @{ icon='fa-industry'; title='Corrosion Resistant'; text='Outperforms steel in wet environments.' },
        @{ icon='fa-cogs'; title='Design Freedom'; text='Complex shapes molded in one piece.' },
        @{ icon='fa-palette'; title='Aesthetic Finish'; text='Smooth gel coat or painted surfaces.' },
        @{ icon='fa-bolt'; title='Dielectric'; text='Non-conductive for electrical safety.' },
        @{ icon='fa-dollar-sign'; title='Cost Effective'; text='Low tooling cost vs metal forming.' }
    )
    customizations = @(
        @{ icon='fa-drafting-compass'; title='From Drawings'; text='We work from CAD, PDF or physical samples.' },
        @{ icon='fa-cube'; title='3D Model Driven'; text='STEP/IGES files used for CNC molds.' },
        @{ icon='fa-palette'; title='Surface Finish'; text='Gloss, matte, textured or painted.' },
        @{ icon='fa-shapes'; title='Geometry'; text='Single or multi-piece shells.' },
        @{ icon='fa-bolt'; title='Inserts'; text='Metal threads and mounting inserts molded in.' },
        @{ icon='fa-fingerprint'; title='Branding'; text='Embossed logos and part numbers.' }
    )
    faqs = @(
        @{ q='Can you manufacture FRP shells from customer drawings?'; a='Yes. Send us CAD files, PDF drawings or a physical sample. Our engineers evaluate the design, propose mold and layup, and produce an accurate FRP shell from prototype to volume.' },
        @{ q='What is the minimum order for custom FRP shells?'; a='We accept prototype orders from 1 piece. Batch and mass-production pricing scales favorably with quantity, and we support ongoing recurring supply.' },
        @{ q='What surface finishes are available for FRP shells?'; a='We offer gel coat (matte or gloss), 2K painted finishes in any RAL color, textured surfaces and anti-static or fire-retardant options depending on application.' },
        @{ q='Do you offer CNC mold making for custom FRP shells?'; a='Yes. We operate in-house CNC machining to produce precision molds from your 3D models, ensuring repeatable, dimensionally stable shells across production runs.' },
        @{ q='How long does custom FRP shell production take?'; a='Prototypes are typically delivered in 7-15 days after design confirmation. Standard production runs take 20-30 days depending on complexity and order size.' }
    )
}

# ---- PAGE 4: carbon-fiber-shell ----
$pages += @{
    key = 'carbon-fiber-shell'
    path = 'E:\文档\ysfrp\carbon-fiber-shell\index.html'
    url = 'https://ysfrp.com/products/equipment/carbon-fiber-shell/'
    title = 'Custom Carbon Fiber Shell Manufacturer | CFRP Enclosure OEM Factory - YSFRP'
    metaDesc = 'China OEM manufacturer of custom carbon fiber shells (CFRP enclosures). Lightweight, high-strength carbon fiber covers for aerospace, automotive, robotics, and industrial applications. MOQ 1 piece.'
    keywords = 'carbon fiber shell manufacturer, CFRP enclosure OEM, custom carbon fiber cover, lightweight composite shell, carbon fiber housing factory, CFRP automotive panel, aerospace carbon shell'
    h1 = 'Custom Carbon Fiber Shell (CFRP) Manufacturer — Lightweight Composite OEM'
    breadcrumbName = 'Carbon Fiber Shell'
    productName = 'Custom Carbon Fiber Shell (CFRP)'
    productDesc = 'Custom carbon fiber reinforced polymer (CFRP) shells and enclosures. Lightweight, high-strength carbon fiber covers for aerospace, automotive, robotics and industrial applications. MOQ 1 piece.'
    model = 'YS-CFRP-SHELL'
    image = '/assets/images/automotive-car.jpg'
    overview = 'Yasheng FRP manufactures custom carbon fiber shells (CFRP enclosures) that combine ultra-low weight with exceptional stiffness and strength. Using prepreg or wet layup with clear-coat or painted finishes, we serve aerospace, automotive, robotics and industrial customers with full OEM/ODM service from prototype to mass production.'
    specRows = @(
        @('Material','Carbon Fiber Reinforced Polymer (CFRP)'),
        @('Layup','Prepreg, wet layup or vacuum infusion'),
        @('Surface Finish','Clear coat, 2K paint, matte or gloss'),
        @('Density','Approx. 1.5 g/cm3 (vs ~2.7 for aluminum)'),
        @('Tensile Strength','High - application specific'),
        @('MOQ','1 piece (prototype)')
    )
    productSections = @('CFRP Robotic Arms','Carbon Fiber Drone Frames','Aerospace Carbon Shells','Carbon Fiber Automotive Panels','CFRP Sporting Equipment')
    applications = @(
        @{ icon='fa-robot'; title='Robotics'; text='Lightweight arms, links and end-effectors.' },
        @{ icon='fa-helicopter'; title='Drones & UAV'; text='Frames and covers for aerial platforms.' },
        @{ icon='fa-plane'; title='Aerospace'; text='Interior and lightweight structural shells.' },
        @{ icon='fa-car'; title='Automotive'; text='Body panels, splitters and trim.' },
        @{ icon='fa-dumbbell'; title='Sporting Goods'; text='Frames and protective shells.' },
        @{ icon='fa-microscope'; title='Instrumentation'; text='Stiff, low-mass equipment housings.' }
    )
    advantages = @(
        @{ icon='fa-feather'; title='Ultra Lightweight'; text='Up to 50% lighter than aluminum.' },
        @{ icon='fa-dumbbell'; title='High Strength'; text='Excellent stiffness-to-weight ratio.' },
        @{ icon='fa-shield-alt'; title='Rigid & Stable'; text='Low thermal expansion, dimensionally stable.' },
        @{ icon='fa-bolt'; title='Corrosion Free'; text='No rust, long service life.' },
        @{ icon='fa-palette'; title='Premium Look'; text='Clear-coat carbon weave aesthetics.' },
        @{ icon='fa-cogs'; title='Precision Molded'; text='Tight tolerances via CNC tooling.' }
    )
    customizations = @(
        @{ icon='fa-cube'; title='3D Model Driven'; text='We produce from STEP/IGES or drawings.' },
        @{ icon='fa-layer-group'; title='Layup Method'; text='Prepreg, wet layup or infusion.' },
        @{ icon='fa-palette'; title='Finish'; text='Clear coat, painted or fabric-show.' },
        @{ icon='fa-shapes'; title='Geometry'; text='Complex monocoque structures.' },
        @{ icon='fa-bolt'; title='Inserts'; text='Bonded metal threads and bushings.' },
        @{ icon='fa-fingerprint'; title='Branding'; text='Laser etch or molded logos.' }
    )
    faqs = @(
        @{ q='What is the difference between carbon fiber (CFRP) and fiberglass (FRP)?'; a='Carbon fiber (CFRP) is significantly lighter and stiffer than fiberglass (FRP) with a premium appearance, but costs more. FRP is more economical and still strong and corrosion resistant. We help you choose based on weight, stiffness and budget.' },
        @{ q='What layup methods do you use for carbon fiber shells?'; a='We use prepreg autoclave or oven curing, wet hand layup and vacuum infusion. The method is selected by your tolerance, cosmetic and volume requirements.' },
        @{ q='What minimum order for carbon fiber shells?'; a='MOQ is 1 piece for prototypes. Because carbon tooling is an investment, volume production yields the best unit cost, and we support both low and high volumes.' },
        @{ q='Do you provide carbon fiber OEM/ODM manufacturing?'; a='Yes. We offer full OEM/ODM: design for manufacture, mold making, layup, finishing and branding, supplying carbon shells under your label worldwide.' },
        @{ q='Can you produce carbon fiber shells from 3D models?'; a='Yes. Send STEP, IGES or STL files and we will generate CNC tooling and produce dimensionally accurate CFRP shells, with prototype lead times of 7-15 days.' }
    )
}

# ---- PAGE 5: usv-hull ----
$pages += @{
    key = 'usv-hull'
    path = 'E:\文档\ysfrp\usv-hull\index.html'
    url = 'https://ysfrp.com/products/equipment/usv-hull/'
    title = 'Custom Fiberglass USV Hull Manufacturer | Unmanned Boat Shell OEM Factory - YSFRP'
    metaDesc = 'China OEM manufacturer of custom fiberglass and carbon fiber USV (unmanned surface vehicle) hulls. Hydrodynamic hulls for ocean survey, maritime patrol, last-mile delivery. Length 500mm-5000mm. MOQ 1.'
    keywords = 'USV hull manufacturer, unmanned surface vehicle shell, fiberglass boat hull OEM, custom USV hull, carbon fiber hull, autonomous boat shell, marine composite hull factory'
    h1 = 'Custom Fiberglass USV Hull Manufacturer — Unmanned Surface Vehicle Shell OEM'
    breadcrumbName = 'USV Fiberglass Hull'
    productName = 'Custom Fiberglass USV Hull'
    productDesc = 'Custom fiberglass and carbon fiber unmanned surface vehicle (USV) hulls. Hydrodynamic shells for ocean survey, maritime patrol and last-mile delivery, length 500mm to 5000mm. MOQ 1 piece.'
    model = 'YS-USV-HULL'
    image = '/assets/images/usv-boat.jpg'
    overview = 'Yasheng FRP builds custom fiberglass and carbon fiber USV (unmanned surface vehicle) hulls. Our hydrodynamic shells serve ocean survey, maritime patrol and last-mile delivery platforms. We engineer from hull lines drawings with integrated sensor mounts and sealed compartments, length from 500mm to 5000mm, MOQ 1 piece.'
    specRows = @(
        @('Material','Fiberglass (FRP) or Carbon Fiber (CFRP)'),
        @('Length Range','500mm - 5000mm (custom)'),
        @('Hull Type','Planing, semi-displacement or catamaran'),
        @('Construction','Single skin or foam sandwich'),
        @('Sensor Mounts','Pre-drilled holes & inserts available'),
        @('MOQ','1 piece (prototype)')
    )
    productSections = @('Ocean Survey Hulls','Maritime Patrol USV Shells','Last-Mile Delivery Hulls','Racing USV Hulls','Sensor Platform Hulls')
    applications = @(
        @{ icon='fa-water'; title='Ocean Survey'; text='Hydrographic and environmental monitoring hulls.' },
        @{ icon='fa-ship'; title='Maritime Patrol'; text='Coastal surveillance and inspection USVs.' },
        @{ icon='fa-box'; title='Last-Mile Delivery'; text='Autonomous transport hulls for ports.' },
        @{ icon='fa-tachometer-alt'; title='Racing USV'; text='High-speed lightweight competition hulls.' },
        @{ icon='fa-satellite'; title='Sensor Platforms'; text='Stable mounts for radar, camera and comms.' },
        @{ icon='fa-fish'; title='Aquaculture'; text='Feeding and monitoring unmanned boats.' }
    )
    advantages = @(
        @{ icon='fa-water'; title='Hydrodynamic'; text='Efficient hull forms from your lines.' },
        @{ icon='fa-feather'; title='Lightweight'; text='Foam sandwich reduces weight, boosts range.' },
        @{ icon='fa-industry'; title='Corrosion Resistant'; text='FRP thrives in saltwater.' },
        @{ icon='fa-tools'; title='Sensor Ready'; text='Pre-drilled mounts for payloads.' },
        @{ icon='fa-cogs'; title='Modular'; text='Swappable decks and bays.' },
        @{ icon='fa-shield-alt'; title='Sealed & Buoyant'; text='Watertight compartments, optional foam.' }
    )
    customizations = @(
        @{ icon='fa-drafting-compass'; title='From Hull Lines'; text='We build from your lines drawing or 3D model.' },
        @{ icon='fa-ruler-horizontal'; title='Length & Beam'; text='500mm to 5000mm, custom dimensions.' },
        @{ icon='fa-layer-group'; title='Construction'; text='Single skin or foam sandwich.' },
        @{ icon='fa-bolt'; title='Mount Points'; text='Pre-drilled sensor and thruster holes.' },
        @{ icon='fa-palette'; title='Finish'; text='Gel coat color, anti-foul or paint.' },
        @{ icon='fa-cube'; title='Deck Layout'; text='Modular payload bays and hatches.' }
    )
    faqs = @(
        @{ q='What materials are available for USV hulls?'; a='We offer fiberglass (FRP) as standard and carbon fiber (CFRP) where weight and stiffness are critical. Foam sandwich construction is available for buoyancy and range.' },
        @{ q='Can you manufacture USV hulls from hull lines drawings?'; a='Yes. Send your hull lines, 3D model or lines plan and we will produce a matching mold and hull, including decks, keels and transoms as required.' },
        @{ q='What size USV hulls can you produce?'; a='We manufacture USV hulls from 500mm up to 5000mm in length, and can scale beyond that for special projects. Beam and draft are fully customizable.' },
        @{ q='Do you offer pre-drilled mounting points for sensors?'; a='Yes. We integrate pre-drilled holes, threaded inserts and reinforced pads for sensors, cameras, antennas, thrusters and payload bays per your layout.' },
        @{ q='What is the lead time for custom USV hulls?'; a='Prototype hulls are typically ready in 7-15 days after design sign-off. Production batches take 20-30 days depending on size, quantity and fit-out.' }
    )
}

# ===================================================================
# GENERATE
# ===================================================================
$createdKeys = $pages | ForEach-Object { $_.key }

foreach ($p in $pages) {
    # JSON-LD
    $faqJson = BuildFaqJson $p.faqs
    $json = $jsonTemplate
    $json = $json.Replace('{CANON}', $p.url)
    $json = $json.Replace('{BNAME}', $p.breadcrumbName)
    $json = $json.Replace('{PNAME}', $p.productName)
    $json = $json.Replace('{PDESC}', $p.productDesc)
    $json = $json.Replace('{PMODEL}', $p.model)
    $json = $json.Replace('{OIMAGE}', $p.image)
    $json = $json.Replace('{FAQJSON}', $faqJson)

    # Head
    $head = $headTemplate
    $head = $head.Replace('{TITLE}', $p.title)
    $head = $head.Replace('{METADESC}', $p.metaDesc)
    $head = $head.Replace('{KEYWORDS}', $p.keywords)
    $head = $head.Replace('{CANON}', $p.url)
    $head = $head.Replace('{OGIMAGE}', $p.image)
    $head = $head.Replace('{JSONLD}', $json)

    # Product sections chips
    $chips = ''
    foreach ($s in $p.productSections) { $chips += '<span class="product-label" style="display:inline-block;margin:4px;">' + $s + '</span>' }

    # Body
    $body = @"
<main id="main-content" role="main">

    <!-- PAGE HEADER -->
    <section class="page-header" style="background: linear-gradient(135deg, #0a1a2e 0%, #0f2a4a 50%, #1a4066 100%);">
        <div class="container">
            <span class="section-tag">FRP Products</span>
            <h1>$($p.h1)</h1>
            <p>$($p.metaDesc)</p>
            <nav aria-label="Breadcrumb" class="breadcrumb">
                <a href="/">Home</a> / <a href="/products.html">Products</a> / <span>$($p.breadcrumbName)</span>
            </nav>
        </div>
    </section>

    <!-- PRODUCT OVERVIEW -->
    <section class="section">
        <div class="container">
            <div class="detail-layout">
                <div class="detail-gallery">
                    <img src="$($p.image)" alt="$($p.productName) - Custom FRP OEM Manufacturer" class="detail-main-img" width="800" height="533">
                </div>
                <div class="detail-info">
                    <h2>$($p.productName)</h2>
                    <p class="detail-desc">$($p.overview)</p>
                    <div style="margin:16px 0;">$chips</div>
                    $(RenderSpec $p.specRows)
                    <div class="detail-actions">
                        <a href="/contact.html?product=$($p.model)" class="btn btn-primary btn-lg"><i class="fas fa-paper-plane"></i> Request Quote</a>
                        <a href="https://wa.me/8613113125793?text=Hi,%20I'm%20interested%20in%20$($p.productName)" target="_blank" class="btn btn-outline btn-lg"><i class="fab fa-whatsapp"></i> WhatsApp</a>
                    </div>
                </div>
            </div>

            <!-- Applications -->
            <div class="detail-section">
                <h2><i class="fas fa-th-large"></i> Applications</h2>
                $(RenderGrid $p.applications)
            </div>

            <!-- Material Advantages -->
            <div class="detail-section">
                <h2><i class="fas fa-star"></i> Material Advantages</h2>
                $(RenderGrid $p.advantages)
            </div>

            <!-- Manufacturing Process -->
            <div class="detail-section">
                <h2><i class="fas fa-industry"></i> Manufacturing Process</h2>
$processSteps
            </div>

            <!-- Customization Options -->
            <div class="detail-section">
                <h2><i class="fas fa-sliders-h"></i> Customization Options</h2>
                $(RenderGrid $p.customizations)
            </div>

            <!-- FAQ -->
            <div class="detail-section">
                <h2><i class="fas fa-question-circle"></i> Frequently Asked Questions</h2>
                $(RenderFaqHtml $p.faqs)
            </div>

            <!-- Related Products -->
            <div class="detail-section">
                <h2><i class="fas fa-box"></i> Related Products</h2>
                $(RenderRelated $p.key $createdKeys)
            </div>

            <div style="text-align:center; margin-top:48px;">
                <a href="/products.html" class="btn btn-outline"><i class="fas fa-arrow-left"></i> Back to All Products</a>
            </div>
        </div>
    </section>

$cta
"@

    $html = $head + $nav + $body + $footer
    # Ensure directory exists
    $dir = Split-Path $p.path
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [System.IO.File]::WriteAllText($p.path, $html, [System.Text.Encoding]::UTF8)
    Write-Host ("Created: " + $p.path + " (" + $html.Length + " bytes)")
}

Write-Host "DONE. Generated $($pages.Count) SEO product pages."
