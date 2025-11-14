import UIKit

class CalendarScreenController: UIViewController {
    private var weekDays: UIView!
    private var calendar = Calendar.current
    private var months = [Date]()
    private var calendarView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configurateMonthData()
        configurateWeekDaysView()
        configurateCollectionView()
    }
    
    // Этот флаг включает "липкость" заголовков секций (месяцев) при прокрутке
    // в стандартном FlowLayout для iOS 9+.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = calendarView.collectionViewLayout as? UICollectionViewFlowLayout {
            if #available(iOS 9.0, *) {
                layout.sectionHeadersPinToVisibleBounds = true
            }
        }
    }
    
    private func configurateMonthData() {
        let today = Date()
        for i in -100...100 {
            if let date = calendar.date(byAdding: .month, value: i, to: today) {
                if let startOfMonth = calendar.date(from: calendar.dateComponents([.month, .year], from: date)) {
                    months.append(startOfMonth)
                }
            }
        }
    }
    
    private func configurateWeekDaysView() {
        weekDays = UIView()
        weekDays.translatesAutoresizingMaskIntoConstraints = false
        weekDays.backgroundColor = .backgroundSecondary
        view.addSubview(weekDays)
        
        let dateFormatter = DateFormatter()
        let weekDaysArr = dateFormatter.shortWeekdaySymbols ?? []
        
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        for day in weekDaysArr {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10, weight: .regular)
            label.textColor = .black
            label.text = day.uppercased()
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        
        weekDays.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            weekDays.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weekDays.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekDays.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekDays.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: weekDays.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: weekDays.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: weekDays.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: weekDays.bottomAnchor),
        ])
    }
    
    private func configurateCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        calendarView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .background
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.indentifier)
        calendarView.register(MonthHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MonthHeader.identifier)
        
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: weekDays.bottomAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func daysInMonth(date: Date) -> Int {
        calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    private func leadingEmptyDays(for date: Date) -> Int {
        let weekday = calendar.component(.weekday, from: date)
        let firstWeekday = calendar.firstWeekday
        return (weekday - firstWeekday + 7) % 7
    }
    
}

extension CalendarScreenController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let date = months[section]
        return daysInMonth(date: date) + leadingEmptyDays(for: date)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.indentifier, for: indexPath)
        guard let dayCell = cell as? DayCell else { return cell }
        let month = months[indexPath.section]
        let leadingDay = leadingEmptyDays(for: month)
        let dayIndex = indexPath.item - leadingDay + 1
        dayCell.text = indexPath.item >= leadingDay ? "\(dayIndex)" : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MonthHeader.identifier, for: indexPath) as? MonthHeader else { return UICollectionReusableView()}
            let month = months[indexPath.section]
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            header.text = formatter.string(for: month)?.capitalized
            return header
        }
        
        return UICollectionReusableView()
    }
}

extension CalendarScreenController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 7
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 36 )
    }
}

//MARK: Day cell
private final class DayCell: UICollectionViewCell {
    static let indentifier = "dayCell"
    
    private lazy var label = { label in
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .textPrimary
        return label
    }(UILabel())
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateUI() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

//MARK: Month header
private final class MonthHeader: UICollectionReusableView {
    static let identifier = "month_header"
    
    private lazy var label = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .textPrimary
        label.textAlignment = .left
        return label
    } ()
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
