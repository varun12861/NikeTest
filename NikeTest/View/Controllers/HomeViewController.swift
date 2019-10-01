//
//  HomeViewController.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol:class {
    func refreshUI()
    func refreshTablView(for indexPath:IndexPath)
}

final class HomeViewController: UIViewController {

    var homeViewModel:HomeViewModel<Service<MusicFeeds>>?
    var tableView:UITableView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        homeViewModel = HomeViewModel(homeViewControllerProtocol: self, service:Service())
        homeViewModel?.getMusicFeeds()
        configureUI()
    }
    
    fileprivate func configureUI() {
    
        tableView = UITableView()
        if let tableView = tableView {
            
            self.view.addSubview(tableView)

            tableView.register(HomeTableViewCell.self, forCellReuseIdentifier:"cell")
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            UIView.setConstraints(for:tableView, toParent: self.view)
        }
    }
    
    fileprivate func moveToDetailVC(for indexPath:IndexPath) {
        let albumDetailsViewCtrl = AlbumDetailsViewController()
               self.navigationController?.pushViewController(albumDetailsViewCtrl, animated: true)
               albumDetailsViewCtrl.viewModel = AlbumDetailViewModel(album:homeViewModel?.getAlbum(at: indexPath.row), albumViewCtrl: albumDetailsViewCtrl, imageData:homeViewModel?.getImage(url:homeViewModel?.getArtWorkUrl(at: indexPath.row) ?? "", indexPath:indexPath))
    }
}


extension HomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let homeViewModel = homeViewModel else {
            return 0
        }
        return homeViewModel.getNumberOfAlumbs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for:indexPath) as! HomeTableViewCell
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        if let homeViewModel = homeViewModel {
            cell.titleLbl.text = homeViewModel.getNameOfAlbum(at: indexPath.row)
            cell.nameLbl.text = homeViewModel.getArtistNameOfAlbum(at: indexPath.row)
            
            if let imageData = homeViewModel.getImage(url:homeViewModel.getArtWorkUrl(at:indexPath.row), indexPath:indexPath) {
                cell.albumImageView.image = UIImage(data:imageData)
            }

        }else {
            cell.titleLbl.text = ""
            cell.nameLbl.text = ""
        }
        return cell
    }
}


extension HomeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToDetailVC(for: indexPath)
    }
}

extension HomeViewController:HomeViewControllerProtocol {
    func refreshUI() {
        tableView?.reloadData()
    }
    func refreshTablView(for indexPath:IndexPath) {
        tableView?.reloadRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
    }
}
