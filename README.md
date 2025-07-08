# 3D模型展示器 - 部署指南

## 📁 项目结构
```
├── index.html                    # 主页
├── model-viewer-three-advanced.html  # Three.js高级版展示器
├── model.glb                     # 3D模型文件
└── README.md                     # 项目说明
```

## 🚀 部署方法

### 方法1: GitHub Pages (推荐)

1. **创建GitHub仓库**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/你的用户名/3d-model-viewer.git
   git push -u origin main
   ```

2. **启用GitHub Pages**
   - 进入仓库设置 (Settings)
   - 找到 Pages 选项
   - Source 选择 "Deploy from a branch"
   - Branch 选择 "main"
   - 保存后等待几分钟即可访问

3. **访问地址**
   ```
   https://luomu166.github.io/3d-model-viewer/
   ```

### 方法2: Netlify (拖拽部署)

1. 访问 [netlify.com](https://netlify.com)
2. 注册/登录账号
3. 将整个项目文件夹拖拽到部署区域
4. 自动生成访问链接

### 方法3: Vercel

1. 访问 [vercel.com](https://vercel.com)
2. 连接GitHub账号
3. 导入项目仓库
4. 自动部署完成

### 方法4: 传统虚拟主机

1. 购买虚拟主机服务
2. 通过FTP上传所有文件
3. 确保文件权限正确
4. 配置域名解析

## ⚙️ 部署注意事项

### 文件结构
- 确保所有文件在同一目录下
- 保持文件名大小写一致
- 检查文件路径引用

### 服务器配置
```apache
# .htaccess 文件 (Apache服务器)
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.html [L]
</IfModule>

# 启用Gzip压缩
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/css application/javascript
</IfModule>
```

### 性能优化
1. **启用Gzip压缩**
2. **设置缓存头**
   ```apache
   <FilesMatch "\.(html|css|js)$">
       Header set Cache-Control "max-age=31536000, public"
   </FilesMatch>
   ```

3. **CDN加速**
   - 使用CloudFlare免费CDN
   - 或阿里云/腾讯云CDN

## 🔧 本地测试

```bash
# 启动本地服务器
cd "Shared (App)/Resources/Base.lproj"
python3 -m http.server 8000

# 访问地址
http://localhost:8000
```

## 📊 性能监控

部署后建议监控：
- 页面加载速度
- 模型文件加载时间
- 用户交互响应
- 浏览器兼容性

## 🛠️ 故障排除

### 常见问题
1. **模型无法加载**
   - 检查文件路径
   - 确认服务器支持GLB文件类型
   - 检查CORS设置

2. **页面空白**
   - 检查JavaScript控制台错误
   - 确认Three.js库加载成功
   - 验证WebGL支持

3. **性能问题**
   - 压缩模型文件
   - 启用服务器压缩
   - 使用CDN加速

## 📞 技术支持

如遇部署问题，请检查：
1. 浏览器控制台错误信息
2. 服务器错误日志
3. 网络连接状态
4. 文件权限设置 