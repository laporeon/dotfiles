#!/bin/bash
# Script para fazer backup dos favoritos da extensão Clipboard Indicator
# Data: $(date +"%Y-%m-%d %H:%M:%S")

REGISTRY_FILE="$HOME/.cache/clipboard-indicator@tudmotu.com/registry.txt"
BACKUP_DIR="$HOME/Documents/Async"
BACKUP_FILE="$BACKUP_DIR/clipboard-favorites-$(date +%Y%m%d-%H%M%S).txt"
LATEST_BACKUP="$BACKUP_DIR/clipboard-favorites-LATEST.txt"

echo "=== BACKUP DOS FAVORITOS DO CLIPBOARD ==="
echo "Data: $(date)"
echo ""

# Verificar se jq está instalado
if ! command -v jq >/dev/null; then
    echo "ERRO: Instale o jq para processamento correto de favoritos multilinha."
    exit 1
fi

# Verificar se o arquivo registry existe
if [ ! -f "$REGISTRY_FILE" ]; then
    echo "ERRO: Arquivo registry não encontrado em $REGISTRY_FILE"
    exit 1
fi

echo "Extraindo favoritos..."

# Extrair apenas os favoritos com jq (multi-linha seguro)
FAVORITES=$(jq -r '.[] | select(.favorite == true) | .contents' "$REGISTRY_FILE" 2>/dev/null)

if [ -z "$FAVORITES" ]; then
    echo "Nenhum favorito encontrado no momento."
    echo "Certifique-se de que você tem itens marcados como favoritos."
    exit 0
fi

# Contar favoritos
COUNT=$(echo "$FAVORITES" | grep -c '^')
echo "Favoritos encontrados: $COUNT"
echo ""

# Criar backup em formato texto legível (com timestamp)
echo "=== FAVORITOS ATUAIS ===" > "$BACKUP_FILE"
echo "Data do backup: $(date)" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"
# Também atualizar o arquivo latest
echo "=== FAVORITOS ATUAIS ===" > "$LATEST_BACKUP"
echo "Data do backup: $(date)" >> "$LATEST_BACKUP"
echo "" >> "$LATEST_BACKUP"

COUNTER=1
# Lê favoritos separando por NUL (caso tenha linhas vazias ou múltiplas)
echo "$FAVORITES" | while IFS= read -r CONTENT; do
    if [ -n "$CONTENT" ]; then
        echo "$COUNTER. $CONTENT" >> "$BACKUP_FILE"
        echo "$COUNTER. $CONTENT" >> "$LATEST_BACKUP"
        echo "$COUNTER. $CONTENT"
        COUNTER=$((COUNTER + 1))
    fi
done

echo ""
echo "Backup com timestamp salvo em: $BACKUP_FILE"
echo "Backup latest atualizado em: $LATEST_BACKUP"

# Limpar backups antigos (manter apenas os últimos 3)
cd "$BACKUP_DIR"
ls -t clipboard-favorites-*.txt | tail -n +4 | xargs rm -f 2>/dev/null

echo "Backup concluído com sucesso!"
echo ""
echo "Para restaurar favoritos perdidos, você pode:"
echo "1. Consultar o arquivo mais recente: $LATEST_BACKUP"
echo "2. Copiar os textos e favoritar novamente na extensão"
echo ""
echo "Dica: Execute este script regularmente (ex: semanalmente) para manter backups atualizados."
