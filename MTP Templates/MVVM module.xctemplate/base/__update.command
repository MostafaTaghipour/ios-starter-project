#! /bin/bash
cd ~/Library/Developer/Xcode/Templates/File\ Templates/MTP\ Templates/MVVM\ module.xctemplate

#*************** make option directories *****************
mkdir -p None
mkdir -p NoneBase
mkdir -p NoneLocal
mkdir -p NoneRemote
mkdir -p NoneBaseLocal
mkdir -p NoneBaseRemote
mkdir -p NoneRemoteLocal
mkdir -p NoneBaseRemoteLocal

mkdir -p Storyboard
mkdir -p StoryboardBase
mkdir -p StoryboardLocal
mkdir -p StoryboardRemote
mkdir -p StoryboardBaseLocal
mkdir -p StoryboardBaseRemote
mkdir -p StoryboardRemoteLocal
mkdir -p StoryboardBaseRemoteLocal

mkdir -p XIB
mkdir -p XIBBase
mkdir -p XIBLocal
mkdir -p XIBRemote
mkdir -p XIBBaseLocal
mkdir -p XIBBaseRemote
mkdir -p XIBRemoteLocal
mkdir -p XIBBaseRemoteLocal

cd base

#*************** make base links for each option *****************
#api
ln -f api.swift ../NoneRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../NoneBaseRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../NoneRemoteLocal/___FILEBASENAME___Api.swift
ln -f api.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Api.swift

ln -f api.swift ../StoryboardRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../StoryboardBaseRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../StoryboardRemoteLocal/___FILEBASENAME___Api.swift
ln -f api.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Api.swift

ln -f api.swift ../XIBRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../XIBBaseRemote/___FILEBASENAME___Api.swift
ln -f api.swift ../XIBRemoteLocal/___FILEBASENAME___Api.swift
ln -f api.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Api.swift


#data source
ln -f dataSource.swift ../NoneLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../NoneRemoteLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../NoneBaseLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../NoneBaseRemoteLocal/___FILEBASENAME___DataSource.swift

ln -f dataSource.swift ../StoryboardLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../StoryboardRemoteLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../StoryboardBaseLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___DataSource.swift

ln -f dataSource.swift ../XIBLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../XIBRemoteLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../XIBBaseLocal/___FILEBASENAME___DataSource.swift
ln -f dataSource.swift ../XIBBaseRemoteLocal/___FILEBASENAME___DataSource.swift

#DTO
ln -f dto.swift ../None/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneRemoteLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneBase/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneBaseLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneBaseRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../NoneBaseRemoteLocal/___FILEBASENAME___DTO.swift

ln -f dto.swift ../Storyboard/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardRemoteLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardBase/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardBaseLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardBaseRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___DTO.swift

ln -f dto.swift ../XIB/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBRemoteLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBBase/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBBaseLocal/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBBaseRemote/___FILEBASENAME___DTO.swift
ln -f dto.swift ../XIBBaseRemoteLocal/___FILEBASENAME___DTO.swift

#entity
ln -f entity.swift ../NoneLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../NoneRemoteLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../NoneBaseLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Entity.swift

ln -f entity.swift ../StoryboardLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../StoryboardRemoteLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../StoryboardBaseLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Entity.swift

ln -f entity.swift ../XIBLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../XIBRemoteLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../XIBBaseLocal/___FILEBASENAME___Entity.swift
ln -f entity.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Entity.swift

#json
ln -f json.swift ../NoneRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../NoneRemoteLocal/___FILEBASENAME___Json.swift
ln -f json.swift ../NoneBaseRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Json.swift

ln -f json.swift ../StoryboardRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../StoryboardRemoteLocal/___FILEBASENAME___Json.swift
ln -f json.swift ../StoryboardBaseRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Json.swift

ln -f json.swift ../XIBRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../XIBRemoteLocal/___FILEBASENAME___Json.swift
ln -f json.swift ../XIBBaseRemote/___FILEBASENAME___Json.swift
ln -f json.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Json.swift

#viewController
ln -f vc.swift ../None/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneRemoteLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneBase/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneBaseLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneBaseRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../NoneBaseRemoteLocal/___FILEBASENAME___ViewController.swift

ln -f vc.swift ../Storyboard/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardRemoteLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardBase/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardBaseLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardBaseRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___ViewController.swift

ln -f vc.swift ../XIB/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBRemoteLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBBase/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBBaseLocal/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBBaseRemote/___FILEBASENAME___ViewController.swift
ln -f vc.swift ../XIBBaseRemoteLocal/___FILEBASENAME___ViewController.swift

#viewModel
ln -f vm.swift ../None/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneRemoteLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneBase/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneBaseLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneBaseRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../NoneBaseRemoteLocal/___FILEBASENAME___ViewModel.swift

ln -f vm.swift ../Storyboard/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardRemoteLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardBase/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardBaseLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardBaseRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___ViewModel.swift

ln -f vm.swift ../XIB/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBRemoteLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBBase/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBBaseLocal/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBBaseRemote/___FILEBASENAME___ViewModel.swift
ln -f vm.swift ../XIBBaseRemoteLocal/___FILEBASENAME___ViewModel.swift

#base viewModel
ln -f baseVM.swift ../NoneBase/BaseViewModel.swift
ln -f baseVM.swift ../NoneBaseLocal/BaseViewModel.swift
ln -f baseVM.swift ../NoneBaseRemote/BaseViewModel.swift
ln -f baseVM.swift ../NoneBaseRemoteLocal/BaseViewModel.swift

ln -f baseVM.swift ../StoryboardBase/BaseViewModel.swift
ln -f baseVM.swift ../StoryboardBaseLocal/BaseViewModel.swift
ln -f baseVM.swift ../StoryboardBaseRemote/BaseViewModel.swift
ln -f baseVM.swift ../StoryboardBaseRemoteLocal/BaseViewModel.swift

ln -f baseVM.swift ../XIBBase/BaseViewModel.swift
ln -f baseVM.swift ../XIBBaseLocal/BaseViewModel.swift
ln -f baseVM.swift ../XIBBaseRemote/BaseViewModel.swift
ln -f baseVM.swift ../XIBBaseRemoteLocal/BaseViewModel.swift

#base viewController
ln -f baseVC.swift ../NoneBase/BaseMVVMViewController.swift
ln -f baseVC.swift ../NoneBaseLocal/BaseMVVMViewController.swift
ln -f baseVC.swift ../NoneBaseRemote/BaseMVVMViewController.swift
ln -f baseVC.swift ../NoneBaseRemoteLocal/BaseMVVMViewController.swift

ln -f baseVC.swift ../StoryboardBase/BaseMVVMViewController.swift
ln -f baseVC.swift ../StoryboardBaseLocal/BaseMVVMViewController.swift
ln -f baseVC.swift ../StoryboardBaseRemote/BaseMVVMViewController.swift
ln -f baseVC.swift ../StoryboardBaseRemoteLocal/BaseMVVMViewController.swift

ln -f baseVC.swift ../XIBBase/BaseMVVMViewController.swift
ln -f baseVC.swift ../XIBBaseLocal/BaseMVVMViewController.swift
ln -f baseVC.swift ../XIBBaseRemote/BaseMVVMViewController.swift
ln -f baseVC.swift ../XIBBaseRemoteLocal/BaseMVVMViewController.swift

#viewcontroller + viewModel
ln -f vc+vm.swift ../None/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneBase/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneBaseLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneBaseRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../NoneBaseRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift

ln -f vc+vm.swift ../Storyboard/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardBase/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardBaseLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardBaseRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift

ln -f vc+vm.swift ../XIB/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBBase/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBBaseLocal/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBBaseRemote/___FILEBASENAME___ViewController+ViewModel.swift
ln -f vc+vm.swift ../XIBBaseRemoteLocal/___FILEBASENAME___ViewController+ViewModel.swift

#strings
ln -f str.strings ../None/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneRemoteLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneBase/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneBaseLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneBaseRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../NoneBaseRemoteLocal/___FILEBASENAME___Strings.strings

ln -f str.strings ../Storyboard/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardRemoteLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardBase/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardBaseLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardBaseRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../StoryboardBaseRemoteLocal/___FILEBASENAME___Strings.strings

ln -f str.strings ../XIB/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBRemoteLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBBase/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBBaseLocal/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBBaseRemote/___FILEBASENAME___Strings.strings
ln -f str.strings ../XIBBaseRemoteLocal/___FILEBASENAME___Strings.strings

#storyboard
ln -f view.storyboard ../Storyboard/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardLocal/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardRemote/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardRemoteLocal/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardBase/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardBaseLocal/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardBaseRemote/___FILEBASENAME___.storyboard
ln -f view.storyboard ../StoryboardBaseRemoteLocal/___FILEBASENAME___.storyboard

#xib
ln -f view.xib ../XIB/___FILEBASENAME___.xib
ln -f view.xib ../XIBLocal/___FILEBASENAME___.xib
ln -f view.xib ../XIBRemote/___FILEBASENAME___.xib
ln -f view.xib ../XIBRemoteLocal/___FILEBASENAME___.xib
ln -f view.xib ../XIBBase/___FILEBASENAME___.xib
ln -f view.xib ../XIBBaseLocal/___FILEBASENAME___.xib
ln -f view.xib ../XIBBaseRemote/___FILEBASENAME___.xib
ln -f view.xib ../XIBBaseRemoteLocal/___FILEBASENAME___.xib


#assembly
ln -f _fullAssembly.swift ../NoneRemoteLocal/___FILEBASENAME___Assembly.swift
ln -f _fullAssembly.swift ../StoryboardRemoteLocal/___FILEBASENAME___Assembly.swift
ln -f _fullAssembly.swift ../XIBRemoteLocal/___FILEBASENAME___Assembly.swift
ln -f _fullAssembly.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Assembly.swift
ln -f _fullAssembly.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Assembly.swift
ln -f _fullAssembly.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Assembly.swift

ln -f _localAssembly.swift ../NoneLocal/___FILEBASENAME___Assembly.swift
ln -f _localAssembly.swift ../StoryboardLocal/___FILEBASENAME___Assembly.swift
ln -f _localAssembly.swift ../XIBLocal/___FILEBASENAME___Assembly.swift
ln -f _localAssembly.swift ../NoneBaseLocal/___FILEBASENAME___Assembly.swift
ln -f _localAssembly.swift ../StoryboardBaseLocal/___FILEBASENAME___Assembly.swift
ln -f _localAssembly.swift ../XIBBaseLocal/___FILEBASENAME___Assembly.swift

ln -f _remoteAssembly.swift ../NoneRemote/___FILEBASENAME___Assembly.swift
ln -f _remoteAssembly.swift ../StoryboardRemote/___FILEBASENAME___Assembly.swift
ln -f _remoteAssembly.swift ../XIBRemote/___FILEBASENAME___Assembly.swift
ln -f _remoteAssembly.swift ../NoneBaseRemote/___FILEBASENAME___Assembly.swift
ln -f _remoteAssembly.swift ../StoryboardBaseRemote/___FILEBASENAME___Assembly.swift
ln -f _remoteAssembly.swift ../XIBBaseRemote/___FILEBASENAME___Assembly.swift

ln -f _noneAssembly.swift ../None/___FILEBASENAME___Assembly.swift
ln -f _noneAssembly.swift ../Storyboard/___FILEBASENAME___Assembly.swift
ln -f _noneAssembly.swift ../XIB/___FILEBASENAME___Assembly.swift
ln -f _noneAssembly.swift ../NoneBase/___FILEBASENAME___Assembly.swift
ln -f _noneAssembly.swift ../StoryboardBase/___FILEBASENAME___Assembly.swift
ln -f _noneAssembly.swift ../XIBBase/___FILEBASENAME___Assembly.swift

#contract
ln -f _fullContract.swift ../NoneRemoteLocal/___FILEBASENAME___Contract.swift
ln -f _fullContract.swift ../StoryboardRemoteLocal/___FILEBASENAME___Contract.swift
ln -f _fullContract.swift ../XIBRemoteLocal/___FILEBASENAME___Contract.swift
ln -f _fullContract.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Contract.swift
ln -f _fullContract.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Contract.swift
ln -f _fullContract.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Contract.swift

ln -f _localContract.swift ../NoneLocal/___FILEBASENAME___Contract.swift
ln -f _localContract.swift ../StoryboardLocal/___FILEBASENAME___Contract.swift
ln -f _localContract.swift ../XIBLocal/___FILEBASENAME___Contract.swift
ln -f _localContract.swift ../NoneBaseLocal/___FILEBASENAME___Contract.swift
ln -f _localContract.swift ../StoryboardBaseLocal/___FILEBASENAME___Contract.swift
ln -f _localContract.swift ../XIBBaseLocal/___FILEBASENAME___Contract.swift

ln -f _remoteContract.swift ../NoneRemote/___FILEBASENAME___Contract.swift
ln -f _remoteContract.swift ../StoryboardRemote/___FILEBASENAME___Contract.swift
ln -f _remoteContract.swift ../XIBRemote/___FILEBASENAME___Contract.swift
ln -f _remoteContract.swift ../NoneBaseRemote/___FILEBASENAME___Contract.swift
ln -f _remoteContract.swift ../StoryboardBaseRemote/___FILEBASENAME___Contract.swift
ln -f _remoteContract.swift ../XIBBaseRemote/___FILEBASENAME___Contract.swift

ln -f _noneContract.swift ../None/___FILEBASENAME___Contract.swift
ln -f _noneContract.swift ../Storyboard/___FILEBASENAME___Contract.swift
ln -f _noneContract.swift ../XIB/___FILEBASENAME___Contract.swift
ln -f _noneContract.swift ../NoneBase/___FILEBASENAME___Contract.swift
ln -f _noneContract.swift ../StoryboardBase/___FILEBASENAME___Contract.swift
ln -f _noneContract.swift ../XIBBase/___FILEBASENAME___Contract.swift

#repo
ln -f _fullRepo.swift ../NoneRemoteLocal/___FILEBASENAME___Repo.swift
ln -f _fullRepo.swift ../StoryboardRemoteLocal/___FILEBASENAME___Repo.swift
ln -f _fullRepo.swift ../XIBRemoteLocal/___FILEBASENAME___Repo.swift
ln -f _fullRepo.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Repo.swift
ln -f _fullRepo.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Repo.swift
ln -f _fullRepo.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Repo.swift

ln -f _localRepo.swift ../NoneLocal/___FILEBASENAME___Repo.swift
ln -f _localRepo.swift ../StoryboardLocal/___FILEBASENAME___Repo.swift
ln -f _localRepo.swift ../XIBLocal/___FILEBASENAME___Repo.swift
ln -f _localRepo.swift ../NoneBaseLocal/___FILEBASENAME___Repo.swift
ln -f _localRepo.swift ../StoryboardBaseLocal/___FILEBASENAME___Repo.swift
ln -f _localRepo.swift ../XIBBaseLocal/___FILEBASENAME___Repo.swift

ln -f _remoteRepo.swift ../NoneRemote/___FILEBASENAME___Repo.swift
ln -f _remoteRepo.swift ../StoryboardRemote/___FILEBASENAME___Repo.swift
ln -f _remoteRepo.swift ../XIBRemote/___FILEBASENAME___Repo.swift
ln -f _remoteRepo.swift ../NoneBaseRemote/___FILEBASENAME___Repo.swift
ln -f _remoteRepo.swift ../StoryboardBaseRemote/___FILEBASENAME___Repo.swift
ln -f _remoteRepo.swift ../XIBBaseRemote/___FILEBASENAME___Repo.swift

ln -f _noneRepo.swift ../None/___FILEBASENAME___Repo.swift
ln -f _noneRepo.swift ../Storyboard/___FILEBASENAME___Repo.swift
ln -f _noneRepo.swift ../XIB/___FILEBASENAME___Repo.swift
ln -f _noneRepo.swift ../NoneBase/___FILEBASENAME___Repo.swift
ln -f _noneRepo.swift ../StoryboardBase/___FILEBASENAME___Repo.swift
ln -f _noneRepo.swift ../XIBBase/___FILEBASENAME___Repo.swift

#transformer
ln -f _fullTransformer.swift ../NoneRemoteLocal/___FILEBASENAME___Transformer.swift
ln -f _fullTransformer.swift ../StoryboardRemoteLocal/___FILEBASENAME___Transformer.swift
ln -f _fullTransformer.swift ../XIBRemoteLocal/___FILEBASENAME___Transformer.swift
ln -f _fullTransformer.swift ../NoneBaseRemoteLocal/___FILEBASENAME___Transformer.swift
ln -f _fullTransformer.swift ../StoryboardBaseRemoteLocal/___FILEBASENAME___Transformer.swift
ln -f _fullTransformer.swift ../XIBBaseRemoteLocal/___FILEBASENAME___Transformer.swift

ln -f _localTransformer.swift ../NoneLocal/___FILEBASENAME___Transformer.swift
ln -f _localTransformer.swift ../StoryboardLocal/___FILEBASENAME___Transformer.swift
ln -f _localTransformer.swift ../XIBLocal/___FILEBASENAME___Transformer.swift
ln -f _localTransformer.swift ../NoneBaseLocal/___FILEBASENAME___Transformer.swift
ln -f _localTransformer.swift ../StoryboardBaseLocal/___FILEBASENAME___Transformer.swift
ln -f _localTransformer.swift ../XIBBaseLocal/___FILEBASENAME___Transformer.swift

ln -f _remoteTransformer.swift ../NoneRemote/___FILEBASENAME___Transformer.swift
ln -f _remoteTransformer.swift ../StoryboardRemote/___FILEBASENAME___Transformer.swift
ln -f _remoteTransformer.swift ../XIBRemote/___FILEBASENAME___Transformer.swift
ln -f _remoteTransformer.swift ../NoneBaseRemote/___FILEBASENAME___Transformer.swift
ln -f _remoteTransformer.swift ../StoryboardBaseRemote/___FILEBASENAME___Transformer.swift
ln -f _remoteTransformer.swift ../XIBBaseRemote/___FILEBASENAME___Transformer.swift
