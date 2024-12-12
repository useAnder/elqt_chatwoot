#!/bin/sh

# Função para substituir arquivo
replace_file() {
    target_path="$1"
    download_url="$2"

    # Verifica se o caminho de destino foi fornecido
    if [ -z "$target_path" ] || [ -z "$download_url" ]; then
        echo "Erro: Caminho de destino ou URL de download inválidos"
        return 1
    fi

    # Cria backup do arquivo original
    if [ -f "$target_path" ]; then
        cp "$target_path" "$target_path.bkp"
        echo "Backup criado: $target_path.bkp"
    fi

    # Baixa o novo arquivo
    wget -O "$target_path" "$download_url"

    # Verifica se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Arquivo substituído com sucesso: $target_path"
        return 0
    else
        echo "Erro ao baixar arquivo para: $target_path"
        # Restaura backup se existir
        if [ -f "$target_path.bkp" ]; then
            mv "$target_path.bkp" "$target_path"
            echo "Backup restaurado"
        fi
        return 1
    fi
}

# Executa a substituição de arquivos
replace_files() {
    # Lista de arquivos para substituir (caminho url)
    replace_file "app/views/layouts/vueapp.html.erb" "https://raw.githubusercontent.com/useAnder/chatwoot/refs/heads/develop/app/views/layouts/vueapp.html.erb"
    replace_file "public/brand-assets/logo.svg" "https://raw.githubusercontent.com/useAnder/chatwoot/refs/heads/develop/public/brand-assets/logo.svg"
}

# Chama a função de substituição
replace_files     
