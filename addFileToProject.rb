#!/usr/bin/env ruby
require 'xcodeproj'
# 接收命令行参数
#.xcodeproj 路径
projectPath = ARGV[0]
# 目录的相对路径
group_path = ARGV[1]
group_list = group_path.split("\/")
# 目录的名称
group_name = group_list.at(group_list.length - 1)
puts " ips #{group_list}    #{group_name}"

puts "parm #{projectPath}   #{group_path}"
project_path = File.join( "#{projectPath}")
puts "project_path #{project_path}"
project = Xcodeproj::Project.open(project_path)
target = project.targets.first
puts "target #{target}"
unityClassGroup = project.main_group.find_subpath("#{group_path}",true)
puts "group #{unityClassGroup}"
#如果找不到路径，就退出
if !unityClassGroup
puts("没有找到")
exit
end

def addFilesToGroup(aProject,aTarget,aGroup)
  Dir.foreach(aGroup.real_path) do |entry|
    filePath = File.join(aGroup.real_path,entry)
    # 过滤目录和.DS_Store文件
    if !File.directory?(filePath) && entry != ".DS_Store" then
      # 向group中增加文件引用
      file_ref = aGroup.new_reference(filePath)
      aTarget.source_build_phase.add_file_reference(file_ref,true)
    # 目录情况下，递归添加
    elsif File.directory?(filePath) && entry != "." && entry != ".." then
      hierarchy_path = aGroup.hierarchy_path[1,aGroup.hierarchy_path.length]
      subGroup = aProject.main_group.find_subpath(hierarchy_path + "/" + entry,true)
      subGroup.set_source_tree(aGroup.source_tree)
      subGroup.set_path(aGroup.real_path + entry)
      addFilesToGroup(aProject,aTarget,subGroup)
    end
  end
end



unityClassGroup.set_source_tree('<group>')
unityClassGroup.set_path("#{group_name}")

addFilesToGroup(project,target,unityClassGroup)


project.save
