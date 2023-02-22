//
//  PagedView.swift
//  Topuppin
//
//  Created by Giri Bahari on 22/02/23.
//

import UIKit

protocol PagedViewDelegate: AnyObject {
    func didMoveToPage(index: Int)
}

class PagedView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    public var delegate: PagedViewDelegate?

    public var pages: [UIViewController] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
        return collectionView
    }()

    init(pages: [UIViewController] = []) {
        self.pages = pages
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(collectionView)
        collectionView.backgroundColor = .white

        NSLayoutConstraint.activate([
            collectionView.widthAnchor
                .constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor
                .constraint(equalTo: self.heightAnchor),
            collectionView.centerXAnchor
                .constraint(equalTo: self.centerXAnchor),
            collectionView.centerYAnchor
                .constraint(equalTo: self.centerYAnchor)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as! PageCollectionViewCell
        let page = self.pages[indexPath.item]
        cell.view = page
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width,
                      height: self.collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func moveToPage(at index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)

        self.delegate?.didMoveToPage(index: page)
    }

}
