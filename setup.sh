#! /bin/bash
read -p "   <<<<<< Enter Your Project Name: "  projectName
read -p "   <<<<<< Enter Your Project BundleId: "  bundleId
read -p "   <<<<<< Enter Your Project iOS Deployment Target (default is 9.0, minimum is 9.0): "  deoployTarget
read -p "   <<<<<< Enter Your Project Development Region (fa/en, default is fa): "  devRegion
mv starter $projectName
echo "   >>>>>> Initializing project... , please wait"
mv $projectName/starter $projectName/$projectName
mv $projectName/starter.xcodeproj $projectName/$projectName.xcodeproj
mv $projectName/starter.xcworkspace $projectName/$projectName.xcworkspace
cd $projectName
cd $projectName.xcworkspace
find . -exec sed -i '' -e "s/starter/$projectName/g" {} \;
cd ../
cd $projectName.xcodeproj
find . -exec sed -i '' -e "s/starter/$projectName/g" {} \;
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/9.0/$deoployTarget/g"
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/developmentRegion = fa;/developmentRegion = $devRegion;/g"
mv xcuserdata/starter.xcuserdatad xcuserdata/$(id -un).xcuserdatad
cd ../
cd Common/Common.xcodeproj
find . -exec sed -i '' -e "s/starter/$projectName/g" {} \;
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/9.0/$deoployTarget/g"
find . -name 'project.pbxproj' -print0 | xargs -0 sed -i "" "s/developmentRegion = fa;/developmentRegion = $devRegion;/g"
cd ../../
find . -name 'Podfile' -print0 | xargs -0 sed -i "" "s/starter/$projectName/g"
cd $projectName
cd 'app'
find . -name 'Production.xcconfig' -print0 | xargs -0 sed -i "" "s/Starter/$projectName/g"
find . -name 'Staging.xcconfig' -print0 | xargs -0 sed -i "" "s/Starter/$projectName/g"
find . -name 'Development.xcconfig' -print0 | xargs -0 sed -i "" "s/Starter/$projectName/g"
find . -name 'Production.xcconfig' -print0 | xargs -0 sed -i "" "s/ir.rainyday.ios.starter/$bundleId/g"
find . -name 'Staging.xcconfig' -print0 | xargs -0 sed -i "" "s/ir.rainyday.ios.starter/$bundleId/g"
find . -name 'Development.xcconfig' -print0 | xargs -0 sed -i "" "s/ir.rainyday.ios.starter/$bundleId/g"
echo "   >>>>>> Project initialized"
cd ../../
echo "   >>>>>> Installing dependencies... , please wait"
pod install
echo "   >>>>>> Dependencies installed"
echo "   >>>>>> Openning project... , please wait"
open "$projectName.xcworkspace"
cd ../
mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates
cp -r MTP\ Templates ~/Library/Developer/Xcode/Templates/File\ Templates
rm -R MTP\ Templates
echo "   >>>>>> 'MTP Templates' moved to Xcode templates"
rm -- "$0"
