#coding: utf-8
前提 /^以下のGitリポジトリが登録されている:$/ do |table|
  command = Gglog::Command.new([], {"gglog-home" => GGLOG_HOME})
  table.hashes.each do |row|
    command.register(row['URL'])
  end
end

もし /^キーワード"(.*?)"で検索を行なう$/ do |keyword|
  run_simple("gglog search #{unescape(keyword)} -h #{GGLOG_HOME}", false)
end

ならば /^検索結果にコミットメッセージ"(.*?)"が含まれていること$/ do |expected|
  assert_partial_output(expected, all_output)
end
