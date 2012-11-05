#coding: utf-8
前提 /^以下のGitリポジトリが登録されている:$/ do |table|
  command = Gglog::Command.new([], {"gglog-home" => @gglog_home})
  table.hashes.each do |row|
    command.register(row['URL'])
  end
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

ならば /^検索結果にコミットメッセージ"(.*?)"が含まれていること$/ do |expected|
  assert_partial_output(expected, all_output)
end

ならば /^一覧に"(.*?)"が含まれていること$/ do |expected|
  assert_partial_output(expected, all_output)
end

ならば /^詳細表示に"(.*?)"が含まれていること$/ do |expected|
  assert_partial_output(expected, all_output)
end
