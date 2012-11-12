#language: ja
フィーチャ: 登録しているGitリポジトリのコミットメッセージの詳細を閲覧したい

  シナリオ: 登録済みのGitリポジトリに含まれるコミットメッセージの詳細を確認できること
    前提 テスト用のGitリポジトリ"gglog_test_repository"が登録されている
    もし "gglog_test_repository 10eec585427e6e55b5ba03786440e5c1be79a906"のコミットメッセージの表示を行なう
    ならば 詳細表示に"Initial commit"が含まれていること

  シナリオ: show サブコマンド実行時に存在しないリポジトリ名が指定された場合
    もし "gglog_test_repository 10eec585427e6e55b5ba03786440e5c1be79a906"のコミットメッセージの表示を行なう
    ならば 結果表示に"Failed: repository name or sha is incorrect"が含まれていること
