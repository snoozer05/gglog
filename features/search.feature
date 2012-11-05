#language: ja
フィーチャ: 登録しているGitリポジトリのコミットメッセージを検索したい

  シナリオ: 登録済みのGitリポジトリに含まれるコミットメッセージを検索できること
    前提 以下のGitリポジトリが登録されている:
      | URL |
      | git@github.com:snoozer05/gglog.git |
    もし キーワード".gitignore"で検索を行なう
    ならば 検索結果にコミットメッセージ"Add .gitignore"が含まれていること
