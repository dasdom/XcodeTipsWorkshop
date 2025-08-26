//  Created by Dominik Hauser on 28.07.25.
//  
//


import UIKit
import OSLog
import SwiftUI

class TipsListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  #warning("Can I change that to a let property?")
  private var tips: [Tip] = []
  private var shownTips: [Tip] = []
  private var dataSource: UITableViewDiffableDataSource<Category, String>?
  private var isCategoriesActive = false
  private var keyboardLayout: KeyboardLayout = .us {
    didSet {
      reload(with: shownTips)
    }
  }
  
  required init?(coder: NSCoder) {

    if let url = Bundle.main.url(forResource: "tips", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        tips = try JSONDecoder().decode([Tip].self, from: data)
      } catch {
        Logger.tipsList.error("\(error)")
      }
    }
//    resetButton.isHidden = true
//    tips = tips.filter({ false == $0.id.hasPrefix("author") })
//    tips = tips.filter({ false == $0.id.hasPrefix("hidden") })
    shownTips = tips

    Logger.tipsList.info("Tips count: \(self.tips.count)")

    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    #warning("Should I change that to UISplitViewDelegate?")
    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
      self.splitViewController?.show(.primary)
    })
  }

  func viewdidLoad() {
    super.viewDidLoad()

    keyboardLayout = Locale.current.identifier.contains("DE") ? .de : .us

    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in

      guard let self = self else {
        return UITableViewCell()
      }

      let cell = tableView.dequeueReusableCell(withIdentifier: TipCell.identifier, for: indexPath)
      if let tipCell = cell as? TipCell,
         let tip = self.shownTips.first(where: { $0.id == itemIdentifier }) {

        tipCell.update(with: tip, keyboardLayout: self.keyboardLayout)
      }
      return cell
    })

    tableView.delegate = self

    update(with: shownTips)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    transitionCoordinator?.animate { [weak self] context in
      if let selectedIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedIndexPath, animated: true)
      }
    }
  }

  private func update(with tips: [Tip]) {
    let snapsot = snapshot(for: tips)
    dataSource?.apply(snapsot)
  }

  private func reload(with tips: [Tip]) {
    let selectedIndexPath = tableView.indexPathForSelectedRow
    let snapshot = snapshot(for: tips)
    dataSource?.applySnapshotUsingReloadData(snapshot, completion: { [weak self] in
      self?.tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
    })
  }

  private func snapshot(for tips: [Tip]) -> NSDiffableDataSourceSnapshot<Category, String> {
    var snapshot = NSDiffableDataSourceSnapshot<Category, String>()
    if isCategoriesActive {
      let sectionsDictionary = Dictionary(grouping: tips, by: { $0.category })
      for key in sectionsDictionary.keys.sorted(by: { $0.sortOrder < $1.sortOrder }) {
        snapshot.appendSections([key])
        if let sectionTips = sectionsDictionary[key] {
          snapshot.appendItems(sectionTips.map({ $0.id }), toSection: key)
        }
      }
    } else {
      snapshot.appendSections([.none])
      snapshot.appendItems(tips.map({ $0.id }))
    }
    return snapshot
  }
}

// MARK: - UITableViewDelegate
extension TipsListViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let identifier = dataSource?.itemIdentifier(for: indexPath)
    if let tip = tips.first(where: { $0.id == identifier }) {
      let details = UIHostingController(rootView: DetailView(tip: tip))
      let navigationController = UINavigationController(rootViewController: details)
      splitViewController?.setViewController(navigationController, for: .secondary)
      splitViewController?.show(.secondary)
    }
  }
}

// MARK: - UISearchBarDelegate
extension TipsListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      shownTips = tips
    } else {
      shownTips = tips.filter({ tip in
        return tip.title.localizedCaseInsensitiveContains(searchText)
      })
    }
    update(with: shownTips)
  }
}
