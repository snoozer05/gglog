#language: ja
フィーチャ: 登録しているGitリポジトリのコミットメッセージの詳細を閲覧したい

  シナリオ: 登録済みのGitリポジトリに含まれるコミットメッセージの詳細を確認できること
    前提 以下のGitリポジトリが登録されている:
      | URL |
      | git@github.com:snoozer05/gglog.git |
    もし "gglog a36acabd9495b4cf435752553a8524d9715bc5d9"のコミットメッセージの表示を行なう
    ならば 詳細表示に"Add .gitignore"が含まれていること
