//
//  AlbumDetailsViewController.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import UIKit

protocol AlbumDetailsViewControllerrotocol:class {
    func refreshUI()
}

final class AlbumDetailsViewController: UIViewController {

    let scrollView = UIScrollView()
    let albumImageView = UIImageView()
    var parentVerticalView:UIStackView!
    let titleLbl = UILabel()
    let nameLbl = UILabel()
    let relaseDatebl = UILabel()
    let copyRightMessageLbl = UILabel()
    let openInItunesBtn = UIButton(type: UIButton.ButtonType.custom)
    var genreStackViews:[UIStackView] = []
    
    var viewModel:AlbumDetailViewModel?{
        didSet {
            refreshUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        self.view.backgroundColor = UIColor.white
        albumImageView.contentMode = .scaleToFill
        
        self.view.addSubview(scrollView)
                
        parentVerticalView  =  UIStackView.createStackView(elements: [albumImageView,titleLbl,nameLbl,relaseDatebl,copyRightMessageLbl],axis: .vertical, alignment:.fill, distribution:.fill,spacing:5.0)
        
        for genre in genreStackViews {
            parentVerticalView.addArrangedSubview(genre)
        }
        self.scrollView.addSubview(parentVerticalView)
        self.view.addSubview(openInItunesBtn)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        parentVerticalView.translatesAutoresizingMaskIntoConstraints = false
        openInItunesBtn.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.setConstraints(for:scrollView, toParent: self.view, hasBottom:false)
        scrollView.bottomAnchor.constraint(equalTo:self.openInItunesBtn.topAnchor, constant:-10.0).isActive = true
        
        UIView.setConstraints(for:openInItunesBtn, toParent: self.view, leading:20.0, trailing:-20.0, height:45.0,hasTop:false,  hasCenterX:true)
        
        UIView.setConstraints(for:parentVerticalView, toParent: self.scrollView,hasEqualHeight:true, hasEqualWidth:true)

        openInItunesBtn.setTitle("Go to Itunes", for: UIControl.State.normal)
        openInItunesBtn.backgroundColor = UIColor.cyan
        openInItunesBtn.addTarget(self, action: #selector(openInItunesBtnAction(_:)), for: .touchUpInside)
        
    }
    func createGenreUI(genre:Genre) ->UIStackView {
        
        let idLabel = UILabel.createLabel(with: "ID : \(genre.genreId)")
        idLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)

        let nameLabel = UILabel.createLabel(with: "Name :\(genre.name)")
        nameLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)

        let urlLabel = UILabel.createLabel(with: "Url : \(genre.url)")
        urlLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)

        let stackView  =  UIStackView.createStackView(elements: [idLabel, nameLabel, urlLabel],axis: .vertical, alignment:.fill, distribution:.fillEqually,spacing:5.0)
        
        return stackView
    }
    
    @objc func openInItunesBtnAction(_ sender:Any) {
        
        if let url = URL(string:viewModel?.album?.url ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:])
                }
        }
    }
}

extension AlbumDetailsViewController:AlbumDetailsViewControllerrotocol {
    func refreshUI() {
        if let viewModel = viewModel, let album = viewModel.album {
            titleLbl.text = album.artistName
            nameLbl.text =  album.name
            relaseDatebl.text = album.releaseDate
            copyRightMessageLbl.text = album.copyright
            if let imageData  = viewModel.imageData {
                albumImageView.image = UIImage(data:imageData)
            }
            for genre in album.genres {
                let stackView = self.createGenreUI(genre: genre)
                genreStackViews.append(stackView)
            }
        }
        
    }
}
