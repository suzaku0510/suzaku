#!/bin/bash

# Claude Code 自動コミットスクリプト
# ファイル編集後に自動的にgitコミットを実行

# カラー定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# プロジェクトディレクトリに移動
cd "$CLAUDE_PROJECT_DIR" || exit 1

# git statusを確認
CHANGED_FILES=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

# 変更がない場合は終了
if [ "$CHANGED_FILES" -eq 0 ]; then
    echo -e "${YELLOW}[Auto-commit] 変更なし - コミットをスキップ${NC}"
    exit 0
fi

# ツール情報を取得
TOOL_NAME=$(echo "$CLAUDE_TOOL_NAME" 2>/dev/null || echo "unknown")
MODIFIED_FILES=$(git status --porcelain | grep -E "^[ M]M|^A" | cut -c4-)

# コミットメッセージを生成
generate_commit_message() {
    local file_count=$(echo "$MODIFIED_FILES" | wc -l | tr -d ' ')
    local first_file=$(echo "$MODIFIED_FILES" | head -1)
    
    # ファイルタイプに基づいてメッセージを生成
    if echo "$first_file" | grep -q "\.py$"; then
        if [ "$file_count" -eq 1 ]; then
            echo "更新: $(basename "$first_file" .py)モジュールを修正"
        else
            echo "更新: Pythonファイルを修正 (${file_count}ファイル)"
        fi
    elif echo "$first_file" | grep -q "\.html$"; then
        echo "UI更新: テンプレートを修正"
    elif echo "$first_file" | grep -q "\.md$"; then
        echo "ドキュメント: $(basename "$first_file" .md)を更新"
    elif echo "$first_file" | grep -q "docker"; then
        echo "設定: Docker構成を更新"
    elif echo "$first_file" | grep -q "\.claude"; then
        echo "設定: Claude Code設定を更新"
    else
        if [ "$file_count" -eq 1 ]; then
            echo "更新: $(basename "$first_file")を修正"
        else
            echo "更新: ${file_count}ファイルを修正"
        fi
    fi
}

# 除外パターンに該当するかチェック
should_skip_commit() {
    # .claudeディレクトリ内のみの変更はスキップ
    if [ "$MODIFIED_FILES" = ".claude/settings.local.json" ] || \
       [ "$MODIFIED_FILES" = ".claude/hooks/auto-commit.sh" ]; then
        return 0
    fi
    
    # 一時ファイルのみの変更はスキップ
    if echo "$MODIFIED_FILES" | grep -qE "^(\.tmp|\.cache|__pycache__|\.pyc)"; then
        return 0
    fi
    
    return 1
}

# コミットをスキップすべきか判定
if should_skip_commit; then
    echo -e "${YELLOW}[Auto-commit] 設定ファイルのみの変更 - コミットをスキップ${NC}"
    exit 0
fi

# コミットメッセージを生成
COMMIT_MSG=$(generate_commit_message)

# 変更をステージング
git add -A

# コミット実行
if git commit -m "$COMMIT_MSG" >/dev/null 2>&1; then
    echo -e "${GREEN}[Auto-commit] ✓ コミット完了: $COMMIT_MSG${NC}"
    
    # 変更ファイルリストを表示
    if [ $(echo "$MODIFIED_FILES" | wc -l) -le 5 ]; then
        echo -e "${GREEN}変更ファイル:${NC}"
        echo "$MODIFIED_FILES" | sed 's/^/  - /'
    else
        echo -e "${GREEN}変更ファイル: $(echo "$MODIFIED_FILES" | wc -l)件${NC}"
    fi
else
    echo -e "${RED}[Auto-commit] ✗ コミット失敗${NC}"
    exit 1
fi