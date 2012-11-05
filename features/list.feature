#language: ja
フィーチャ: 登録しているGitリポジトリを確認したい

  シナリオ: 登録済みのGitリポジトリを一覧できること
    前提 以下のGitリポジトリが登録されている:
      | URL |
      | https://github.com/snoozer05/gglog.git |
    もし list サブコマンドを実行する
    ならば 一覧に"gglog"が含まれていること
