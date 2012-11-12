#language: ja
フィーチャ: 登録済みのGitリポジトリを最新の状態に更新したい

  シナリオ: 登録済みのGitリポジトリを更新できること
    前提 テスト用のGitリポジトリ"gglog_test_repository"を登録する
    もし sync サブコマンドを実行する
    ならば "gglog_test_repository"リポジトリの状態が最新になっていること

  シナリオ: masterブランチのないGitリポジトリも更新できること
    前提 テスト用のGitリポジトリ"gglog_test_repository_no_master_branch"を登録する
    もし sync サブコマンドを実行する
    ならば "gglog_test_repository_no_master_branch"リポジトリの状態が最新になっていること


