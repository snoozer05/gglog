#coding: utf-8
module ArchivedTestRepository
  def archived_test_repository_path(repository_name)
    File.join(File.expand_path(File.dirname(__FILE__)), "data", "#{repository_name}.tar.gz")
  end

  def decompress_test_repository(repository_name)
    dest_dir = Dir.mktmpdir
    system "tar", "xfz", archived_test_repository_path(repository_name), "-C", dest_dir
    File.join(dest_dir, repository_name)
  end
end

World(ArchivedTestRepository)
