#!/bin/bash
# 项目名称
project_name=`sh ../readProperties.sh projectName`

file_name="Podfile"

rm $file_name

echo "
# Uncomment the next line to define a global platform for your project
 platform :ios, \'10.0\'

target \'${project_name}\' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ${project_name}
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'HandyJSON'
  pod 'Kingfisher'
  pod 'RealmSwift'
  pod 'SnapKit'
  target \'${project_name}Tests\' do
    inherit! :search_paths
    # Pods for testing
  end

  target \'${project_name}UITests\' do
    # Pods for testing
  end

end
" >> $file_name
