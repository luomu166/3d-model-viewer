#!/bin/bash

# 3D模型展示器 - 自动部署脚本
# 使用方法: ./deploy.sh [选项]

echo "🎨 3D模型展示器 - 部署工具"
echo "================================"

# 检查文件是否存在
check_files() {
    echo "📁 检查项目文件..."
    
    required_files=("index.html" "model-viewer-three-advanced.html" "model.glb")
    
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            echo "✅ $file - 存在"
        else
            echo "❌ $file - 缺失"
            exit 1
        fi
    done
    
    echo "✅ 所有必需文件检查完成"
}

# 创建部署包
create_package() {
    echo "📦 创建部署包..."
    
    # 创建部署目录
    mkdir -p deploy
    
    # 复制文件
    cp index.html deploy/
    cp model-viewer-three-advanced.html deploy/
    cp model.glb deploy/
    cp README.md deploy/
    
    # 创建 .htaccess 文件
    cat > deploy/.htaccess << 'EOF'
# 启用Gzip压缩
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/css application/javascript application/json
</IfModule>

# 设置缓存
<FilesMatch "\.(html|css|js)$">
    Header set Cache-Control "max-age=31536000, public"
</FilesMatch>

<FilesMatch "\.(glb|gltf)$">
    Header set Cache-Control "max-age=31536000, public"
    Header set Access-Control-Allow-Origin "*"
</FilesMatch>

# 设置MIME类型
AddType model/gltf-binary .glb
AddType model/gltf+json .gltf
EOF

    echo "✅ 部署包创建完成: deploy/ 目录"
}

# GitHub Pages 部署
deploy_github() {
    echo "🚀 准备GitHub Pages部署..."
    
    if [ ! -d ".git" ]; then
        echo "❌ 当前目录不是Git仓库"
        echo "请先运行: git init"
        return 1
    fi
    
    # 检查是否有远程仓库
    if ! git remote get-url origin > /dev/null 2>&1; then
        echo "❌ 未配置远程仓库"
        echo "请先运行: git remote add origin <你的仓库地址>"
        return 1
    fi
    
    # 添加文件
    git add .
    git commit -m "Update 3D model viewer"
    git push origin main
    
    echo "✅ 代码已推送到GitHub"
    echo "📝 请在GitHub仓库设置中启用Pages功能"
}

# 显示部署选项
show_menu() {
    echo ""
    echo "请选择部署方式:"
    echo "1) 检查项目文件"
    echo "2) 创建部署包"
    echo "3) GitHub Pages部署"
    echo "4) 显示部署说明"
    echo "5) 退出"
    echo ""
    read -p "请输入选项 (1-5): " choice
    
    case $choice in
        1)
            check_files
            ;;
        2)
            check_files
            create_package
            ;;
        3)
            check_files
            deploy_github
            ;;
        4)
            show_deploy_info
            ;;
        5)
            echo "👋 再见!"
            exit 0
            ;;
        *)
            echo "❌ 无效选项"
            ;;
    esac
}

# 显示部署说明
show_deploy_info() {
    echo ""
    echo "📋 部署说明"
    echo "============"
    echo ""
    echo "🌐 免费托管平台:"
    echo "  • GitHub Pages: 完全免费，支持自定义域名"
    echo "  • Netlify: 拖拽部署，100GB/月免费"
    echo "  • Vercel: 自动部署，100GB/月免费"
    echo ""
    echo "💰 付费托管服务:"
    echo "  • 阿里云/腾讯云: 轻量应用服务器"
    echo "  • AWS S3 + CloudFront: 按使用量计费"
    echo ""
    echo "📁 部署文件:"
    echo "  • index.html - 主页"
    echo "  • model-viewer-three-advanced.html - 3D展示器"
    echo "  • model.glb - 3D模型文件"
    echo "  • .htaccess - 服务器配置(可选)"
    echo ""
}

# 主程序
main() {
    if [ $# -eq 0 ]; then
        show_menu
    else
        case $1 in
            "check")
                check_files
                ;;
            "package")
                check_files
                create_package
                ;;
            "github")
                check_files
                deploy_github
                ;;
            "info")
                show_deploy_info
                ;;
            *)
                echo "❌ 无效参数"
                echo "使用方法: $0 [check|package|github|info]"
                ;;
        esac
    fi
}

# 运行主程序
main "$@" 