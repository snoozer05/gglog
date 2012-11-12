#language: ja
フィーチャ: 登録しているGitリポジトリを確認したい

  シナリオ: 登録済みのGitリポジトリを一覧できること
    前提 テスト用のGitリポジトリ"gglog_test_repository"が登録されている
    もし list サブコマンドを実行する
    ならば 一覧に"gglog_test_repository"が含まれていること
