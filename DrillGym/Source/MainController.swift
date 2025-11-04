import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configurateTabBar()
    }

    private func configurateTabBar() {
        self.tabBar.tintColor = .primary
        
        let calendarVC = UINavigationController(rootViewController: CalendarScreenController())
        let historyVC = UINavigationController(rootViewController: HistoryScreenController())
        let workoutsVC =  UINavigationController(rootViewController: WorkoutsScreenController())
    
        let calendarTab = UITabBarItem(
            title: "Calendar",
            image: UIImage(systemName: "calendar"),
            tag: 0
        )
        calendarVC.tabBarItem = calendarTab
        
        let historyTab = UITabBarItem(
            title: "Progress",
            image: UIImage(systemName: "chart.line.uptrend.xyaxis"),
            tag: 1
        )
        historyVC.tabBarItem = historyTab
        
        let workoutsTab = UITabBarItem(
            title: "Workouts",
            image: UIImage(systemName: "square.fill.text.grid.1x2"),
            tag: 2
        )
        workoutsVC.tabBarItem = workoutsTab
     
        viewControllers = [calendarVC, historyVC, workoutsVC]
    }
}

