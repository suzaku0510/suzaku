---
# Dynamically load all subagents
# All .md files in .claude/agents/ will be automatically available
---

# Flask Enterprise Development Team (Full Configuration)

As the CTO, you oversee a team of 100+ specialist agents.
Based on project requirements, you can summon appropriate experts to build optimal solutions.

## Available Expert Categories

### 01. Core Development
- `@backend-developer` - Backend implementation
- `@frontend-developer` - Frontend implementation
- `@fullstack-developer` - Full-stack development
- `@api-designer` - API design
- `@mobile-developer` - Mobile app development

### 02. Language Specialists
- `@python-expert` - Python specialist
- `@javascript-expert` - JavaScript specialist
- `@typescript-expert` - TypeScript specialist
- `@rust-expert` - Rust specialist
- `@go-expert` - Go specialist

### 03. Infrastructure
- `@devops-engineer` - DevOps/CI/CD
- `@cloud-architect` - Cloud architecture
- `@database-architect` - Database design
- `@kubernetes-expert` - Kubernetes operations
- `@docker-expert` - Docker/containerization

### 04. Quality & Security
- `@security-expert` - Security specialist
- `@qa-engineer` - Quality assurance
- `@penetration-tester` - Penetration testing
- `@code-reviewer` - Code review specialist

### 05. Data & AI
- `@data-scientist` - Data scientist
- `@ml-engineer` - Machine learning engineer
- `@ai-researcher` - AI researcher
- `@data-engineer` - Data engineer

### 06. Domain Specialists
- `@fintech-expert` - Fintech specialist
- `@healthcare-expert` - Healthcare specialist
- `@ecommerce-expert` - E-commerce specialist
- `@blockchain-expert` - Blockchain specialist

### 07. Product & Design
- `@product-manager` - Product manager
- `@ux-designer` - UX designer
- `@ui-designer` - UI designer
- `@technical-writer` - Technical writer

### 08. Business & Strategy
- `@business-analyst` - Business analyst
- `@project-manager` - Project manager
- `@scrum-master` - Scrum master
- `@solution-architect` - Solution architect

## Quick Start Commands

### For Flask Project
\`\`\`
@backend-developer @api-designer @database-architect
Create a Flask REST API with user authentication
\`\`\`

### For Production Deployment
\`\`\`
@devops-engineer @security-expert @cloud-architect
Prepare Flask app for AWS deployment with security best practices
\`\`\`




# Claude Codeでの Git 運用ガイドライン

## プロジェクト概要
医療機器リモートモニタリングシステム
- Biotronik、Boston Scientific、Medtronic対応
- 患者データの管理と分析
- PDFレポート生成機能

## Git運用ルール

### 1. 日常的なコミット

#### 作業開始前
```bash
git status  # 現在の状態確認
git log --oneline -5  # 最近の履歴確認
```

#### コミットのタイミング
- 新機能の実装完了時
- バグ修正完了時  
- 大きな変更の前後
- 作業終了時（最低1日1回）

#### コミット手順
```bash
git add -A  # すべての変更をステージング
git commit -m "機能追加: [具体的な変更内容]"
```

### 2. コミットメッセージ規則
- `機能追加: 〇〇機能を実装`
- `修正: 〇〇のバグを修正`
- `リファクタリング: 〇〇を整理`
- `更新: 〇〇を改善`
- `データベース: テーブル構造を変更`

### 3. 変更履歴の確認と復元

#### 履歴確認
```bash
git log --oneline --graph --all  # グラフィカルに表示
git log --stat  # ファイル変更統計付き
git show [コミットハッシュ]  # 特定コミットの詳細
```

#### ファイル復元
```bash
# 特定ファイルを過去の状態に戻す
git checkout [コミットハッシュ] -- [ファイル名]

# 作業ディレクトリ全体を特定コミットに戻す（注意）
git reset --hard [コミットハッシュ]
```

### 4. 便利なコマンド

#### 変更内容の確認
```bash
git diff  # ステージング前の変更
git diff --staged  # ステージング済みの変更
git diff HEAD~3  # 3コミット前との差分
```

#### 特定ファイルの履歴
```bash
git log --follow -p -- [ファイル名]  # ファイルの変更履歴
```

### 5. 注意事項
- データベースファイル（*.db）は意図的にコミット対象
- 患者データPDF（bio_pdf/, boston_pdfs/）は除外
- パスワードファイル（password.json）は除外
- 大きな変更前は必ずコミット

### 6. トラブルシューティング

#### 間違えてコミットした場合
```bash
# 直前のコミットを取り消し（ファイルは維持）
git reset --soft HEAD~1

# コミットメッセージの修正
git commit --amend -m "新しいメッセージ"
```

#### 特定時点の状態を確認
```bash
# 一時的に過去の状態を見る
git checkout [コミットハッシュ]
# 最新に戻る
git checkout master
```

## Claude Codeへの自動コミット指示
**重要**: Claude Codeはファイル編集後、以下の条件で自動的にgitコミットを実行してください：

### 自動コミットを実行するタイミング
1. **機能追加・実装完了時**: 新しい機能やコンポーネントを追加した後
2. **バグ修正完了時**: エラーや不具合を修正した後
3. **スタイル・UI変更時**: CSSやレイアウトの変更を行った後
4. **リファクタリング完了時**: コードの整理や最適化を行った後
5. **設定ファイル変更時**: 設定やドキュメントを更新した後

### コミット実行手順
```bash
git add -A
git commit -m "[変更種別]: [具体的な変更内容]"
```

### コミットメッセージの自動生成ルール
- 変更内容を簡潔に要約
- 日本語で記載
- 変更の影響範囲を明確に

### 例
```bash
git add -A
git commit -m "機能追加: カレンダーの確認済み表示を改善"
```

## リマインダー
- Claude Codeで作業後は必ずコミット
- どのファイルをいつ変更したか追跡可能に
- 定期的な `git status` で状態確認


