# gglog [![Build Status](https://secure.travis-ci.org/snoozer05/gglog.png)](http://travis-ci.org/snoozer05/gglog)

gglog is your partner for finding a good commit message.

## Motivation

(Japanese version only)

>「コミットメッセージに悩んだときに、いろんなリポジトリを横断してコミットメッセージを眺めることができたらいいな」

「分かりやすいコミットメッセージを書く」ことは、[ソフトウェア開発で大切にしなくてはならないことの一つ](http://www.clear-code.com/blog/2012/2/21.html)です。

けれど、英語で自分が書いた変更を簡潔に表現することは、なかなか簡単にはできなかったりします。

ぼくもコミットメッセージを書く際に英語の表現で悩むことの多い一人で、そんなときには、手元にあるプロジェクトやウォッチしているプロジェクトのログを眺めて、似たような変更や作業のコミットがないかを探して、そのコミットメッセージを参考にしていました。

ですが、色んなリポジトリを辿ってコミットログを眺めるのはあまり効率的な作業ではなく、簡単にいろんなリポジトリを横断してコミットメッセージを眺めることをできるようにしたいと思っていたので、このツールを作りました。

- 参考: [ククログ - コミットメッセージの書き方](http://www.clear-code.com/blog/2012/2/21.html)

## Requirements

- [Ruby](http://www.ruby-lang.org/) (1.9.3 or later)

## Installation

    % gem install gglog

## Usage

Register github projects to your search targets:

    % gglog register https://github.com/rails/rails.git

Search the text related to the contents which commit:

    % gglog search "Work on"
      Add support for Object#in? and Object#either? in Active Support [# ... rails 635d991683c439da56fa72853880e88e6ac291ed
      Add support for bare ActiveSupport via config.active_support.bare      rails 39034997d1bd1fbaf33ddf1d6e3996b3c298a409
      ...

Show detail if you need:

    % gglog show rails 635d991683c439da56fa72853880e88e6ac291ed

    Add support for Object#in? and Object#either? in Active Support [#6321 state:committed]

    This will allow you to check if an object is included in another object
    or the list of objects or not.
    ...

Make registered projects follow origin/master and re-index.

    % gglog sync

## For Vim user

I recommend you to use gglog in combination with [Clam.vim](https://github.com/sjl/clam.vim).

## Todo

- Improve commit message filter
- Translate Motivation section to English

---

&copy; 2012 Koji Shimada, released under the MIT license
