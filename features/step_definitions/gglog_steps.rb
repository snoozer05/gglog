#coding: utf-8

前提 /^以下のGitリポジトリが登録されている:$/ do |table|
  command = Gglog::Command.new([], {"gglog-home" => @gglog_home})
  table.hashes.each do |row|
    command.register(row['URL'])
  end
end

前提 /^テスト用のGitリポジトリ"(.*?)"が登録されている$/ do |repository_name|
  test_repo = decompress_test_repository(repository_name)
  git_url = File.join(test_repo, "#{repository_name}.git")
  step %Q{Gitリポジトリ"#{git_url}"を登録する}
end

もし /^キーワード"(.*?)"で検索を行なう$/ do |keyword|
  run_simple("gglog search #{unescape(keyword)} -h #{@gglog_home}", false)
end

もし /^list サブコマンドを実行する$/ do
  run_simple("gglog list -h #{@gglog_home}", false)
end

もし /^"(.*?)"のコミットメッセージの表示を行なう$/ do |repository_name_and_sha|
  run_simple("gglog show #{unescape(repository_name_and_sha)} -h #{@gglog_home}", false)
end

もし /^Gitリポジトリ"(.*?)"を登録する$/ do |url|
  run_simple("gglog register #{unescape(url)} -h #{@gglog_home}", false)
end

もし /^テスト用のGitリポジトリ"(.*?)"を登録する$/ do |repository_name|
  step %Q{テスト用のGitリポジトリ"#{repository_name}"が登録されている}
end

もし /^sync サブコマンドを実行する$/ do
  run_simple("gglog sync -h #{@gglog_home}", false)
end

ならば /^結果表示に"(.*?)"が含まれていること$/ do |expected|
  assert_partial_output(expected, all_output)
end

ならば /^検索結果にコミットメッセージ"(.*?)"が含まれていること$/ do |expected|
  step %Q{結果表示に"#{expected}"が含まれていること}
end

ならば /^一覧に"(.*?)"が含まれていること$/ do |expected|
  step %Q{結果表示に"#{expected}"が含まれていること}
end

ならば /^詳細表示に"(.*?)"が含まれていること$/ do |expected|
  step %Q{結果表示に"#{expected}"が含まれていること}
end

ならば /^登録リポジトリに"(.*?)"が追加されていること$/ do |expected|
  Dir["#{@gglog_home}/repositories/*"].include?("#{@gglog_home}/repositories/#{expected}")
end

ならば /^"(.*?)"リポジトリの状態が最新になっていること$/ do |repository_name|
  repo = File.join(@gglog_home, "repositories", repository_name)
  Dir.chdir(repo) do
    run_simple("git pull --force --quiet origin HEAD", false)
  end
  assert_partial_output("Already up-to-date.", all_output)
end
