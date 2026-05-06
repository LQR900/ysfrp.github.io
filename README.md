# YASHENG FRP Website Template - Deployment Guide

## Files Included

```
website-template/
├── index.html    ← 主页面（首页+产品+关于+联系）
├── style.css     ← 样式文件
├── script.js     ← 交互脚本
└── README.md     ← 部署说明（本文件）
```

## How to Use This Template

### Step 1: Download the files
Copy the entire `website-template` folder to your computer.

### Step 2: Customize Your Content

**必改内容（必须修改）:**

1. **联系信息** — 打开 `index.html`，搜索以下内容并替换:
   - `+86 198 6733 5803` → 你的 WhatsApp 号码
   - `serafinalin091@gmail.com` → 你的邮箱
   - `sales@frp-manufacturer.com` → 你的邮箱
   - `Dongguan Yasheng FRP Technology Co., Ltd.` → 你的公司英文全称

2. **产品图片** — 替换 `assets/images/` 里的占位图（如果暂时没有，可用产品实拍照片）

3. **公司介绍** — 在 `index.html` 的 "About Us" 部分修改文字

---

## Deploy to GitHub Pages (免费托管)

### Step 1: Create a GitHub account
Go to https://github.com → Sign up (free, takes 5 minutes)

### Step 2: Create a new repository
1. Click the **+** button (top right) → **New repository**
2. Repository name: `yasheng-frp.github.io` (or any name you like)
3. Select **Public**
4. Click **Create repository**

### Step 3: Upload your website files
1. In your new repository, click **uploading an existing file**
2. Drag all files from the `website-template` folder into the browser
3. Click **Commit changes**

### Step 4: Enable GitHub Pages
1. Go to **Settings** of your repository
2. Left sidebar → **Pages**
3. Under "Source": select **Deploy from a branch**
4. Branch: select **main** and `/ (root)`
5. Click **Save**
6. Wait 2-3 minutes → Your site will be live at:
   `https://YOUR-USERNAME.github.io`

### Step 5: Connect your domain (optional but recommended)
1. Buy a domain from Alibaba Cloud (≈ 15 CNY for .top/.xyz)
2. In GitHub Pages Settings → Custom domain → enter your domain
3. In Alibaba Cloud DNS settings, add:
   - Type: `CNAME`, Host: `www`, Value: `YOUR-USERNAME.github.io`
   - Type: `A`, Host: `@`, Value: `185.199.108.153` (or current GitHub IP)
4. Wait 30-60 minutes for DNS to propagate

---

## What the Website Includes

| Section | Description |
|---------|-------------|
| Hero Banner | Full-screen intro with company tagline |
| Products | 4 product categories with specs and tags |
| About Us | Company intro + 4 key advantage cards |
| Why Us | 6 reasons to choose Yasheng FRP |
| Process | 5-step production workflow |
| Contact | Inquiry form + WhatsApp button + company info |
| Footer | Links, contact details, social badges |
| WhatsApp Float | Always-visible chat button (bottom right) |

---

## How the Inquiry Form Works

The form on the Contact page has **no backend required**:
1. Visitor fills in the form
2. Clicks "Send Inquiry"
3. WhatsApp opens automatically with a pre-filled message containing all their inquiry details

This means **zero server cost** — no PHP, no database needed.

---

## Customization Tips

### Change colors
Edit `style.css` → top section with `:root` variables:
```css
:root {
    --primary: #0f2a4a;      /* Main dark blue */
    --accent: #e67e22;        /* Orange accent */
    --success: #27ae60;      /* Green */
}
```

### Add more products
Copy an entire `<div class="product-card">...</div>` block and change the content.

### Change icons
Use FontAwesome 6 icons: https://fontawesome.com/search
Replace the `<i class="fas fa-xxx"></i>` with any icon class.

### Add Google Analytics
Add this to `<head>` in `index.html`:
```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=YOUR_GA_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'YOUR_GA_ID');
</script>
```

---

## Need Help?

If you get stuck at any step, take a screenshot of the error or describe what you see — I'll help you fix it.

Good luck with your business! 🚀
