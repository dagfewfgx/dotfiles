# 这个文件提供了一些有用的函数

# 代理开关函数
proxyon() {
    export WIN_IP=$(ip route | grep default | awk '{print $3}')
    export HTTP_PROXY="http://${WIN_IP}:7899"
    export HTTPS_PROXY="http://${WIN_IP}:7899"
    export http_proxy="http://${WIN_IP}:7899"
    export https_proxy="http://${WIN_IP}:7899"
    export ALL_PROXY="socks5://${WIN_IP}:7898"
    export all_proxy="socks5://${WIN_IP}:7898"
    echo "✅ 代理已开启 (HTTP: ${WIN_IP}:7899, SOCKS: ${WIN_IP}:7898)"
}

proxyoff() {
    unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
    unset ALL_PROXY all_proxy
    echo "❌ 代理已关闭"
}

proxyst() {
    if [ -n "$HTTP_PROXY" ]; then
	echo "✅ 代理状态: 已开启"
	echo "   HTTP 代理: $HTTP_PROXY"
	echo "   SOCKS 代理: $ALL_PROXY"
    else
	echo "❌ 代理状态: 未开启"
    fi
}

# a auto tool for avoiding GPU crack when use allama
model_detect(){
	if ollama ps | tail -n +2 | grep -q .;then
		local current_models=$(ollama ps | tail -n +2 | awk '{print $1}')
		local target_models="$1"
		if [ "$target_models" = "$current_models" ];then
			echo "✅ 模型 $target_model 已在运行中，直接使用..."
		else
			echo "🛑 停止当前模型..."
			ollama ps | tail -n +2 | awk '{print $1}' | xargs -I {} ollama stop {}
		fi
	fi
}

dson(){
	model_detect "deepseek-coder:6.7b"
	echo "🚀 启动 DeepSeek-Coder..."
	if [ $# -eq 0 ]; then 
		ollama run deepseek-coder:6.7b
	else
		ollama run deepseek-coder:6.7b "$1"
	fi
}
dsoff(){
	ollama stop deepseek-coder:6.7b-instruct-q4_0
}
qwoff(){
	ollama stop qwen:7b-chat-q4_0
}

# 一个可以把管道的标准输出放到剪贴板的函数 
xclipcp(){
	xclip -selection clipboard
}

# 虚拟环境开启函
venvon(){
	local projects=()
	while IFS= read -r project; do
     		projects+=("$project")
    	done < <(find ~/work -maxdepth 1 -type d ! -path ~/work -exec basename {} \; 2>/dev/null | sort)

	local count=1
	for project in "${projects[@]}";do
		echo "$count: $project"
		count=$((count + 1))
	done
	local choice
	read -r -p "请选择需要开启的虚拟环境:" choice

	if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 1 ] && [ $choice -le ${#projects[@]} ]; then 
		source ~/work/${projects[$((choice - 1))]}/venv/bin/activate
	else
		echo "选择有误,请重新选择!"
		venvon
	fi
}
	
