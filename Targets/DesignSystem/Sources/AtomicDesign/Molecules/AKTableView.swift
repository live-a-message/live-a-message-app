//
//  AKTableViewMessagees.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 10/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public protocol TableViewCellViewModel { }

public protocol TableViewCell: UITableViewCell {
    associatedtype ViewModel: TableViewCellViewModel
    static var identifier: String { get }
    func setup(viewModel: ViewModel)
}
/// AKTableView é uma table view genérica que recebe essencialmente 2 parametros completamente customizaveis
/// Para utiliza-la você precisará criar uma ViewModel para a sua célula, nela, você irá assinar o protocolo `TableViewCellViewModel`
public class AKTableView<Item: TableViewCellViewModel,
                         Cell: TableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {

    public typealias Section = [Item]
    public var sections: [Section] = [] {
        didSet { DispatchQueue.main.async { self.reloadData() } }
    }

    public var sectionsTitle: [String]?
    public var emptyStateView: UIView?

    // Use essa variavel para rapidamente atualizar o header da tableViews
    public var heightForHeaderView: CGFloat? {
        didSet {
            let size = CGSize(
                width: frame.width,
                height: CGFloat(heightForHeaderView ?? .zero)
            )
            tableHeaderView?.frame.size = size
        }
    }

    public var didSelectRowAt: ((Item) -> Void)?

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    /// `bind(sections:)` é usada para configurar tudo que será usado na tableView, delegates e dataSources
    /// é uma maneira de inicializar tudo sem ser pelo o próprio init.
    public func bind(sections: [Section]) {
        register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        delegate = self
        dataSource = self
        self.sections = sections
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: TableView Implementation (DataSource & Delegate)

    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = sections[indexPath.section]
        guard let viewModel = cells[indexPath.row] as? Cell.ViewModel,
              let cell = tableView.dequeueReusableCell(
                withIdentifier: Cell.identifier,
                for: indexPath
              ) as? Cell else { return UITableViewCell() }
        cell.setup(viewModel: viewModel)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = sections[indexPath.section][indexPath.row]
        didSelectRowAt?(itemSelected)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let sectionsTitle = sectionsTitle else { return nil }
//        guard sectionsTitle.count > .zero && section > 0 else { return nil }
//        return sectionsTitle[section - 1]
        return nil
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let firstSection = sections.first else { return nil }
        if sections.count == 1 && firstSection.isEmpty {
            heightForHeaderView = .zero
            return emptyStateView
        }
        return nil
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let firstSection = sections.first else { return .zero }
        if sections.count == 1 && firstSection.isEmpty {
            return frame.height
        }
        return .zero
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = AKColor.mainBackgroundColor
    }

    public func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
