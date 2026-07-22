import UIKit

final class ProfileController: UIViewController {
    
//    private let profileService = ProfileDataService.init()
//    
//
        
    private let profileService: IProfileDataService
    
    init(profileService: IProfileDataService) {
        self.profileService = profileService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var profileData:[ProfileData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: ProfileInfoCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchProfileData()
    }
    
}

//MARK: - TableView Datasource
extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell.init()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.reuseId, for: indexPath) as! ProfileInfoCell
        cell.update(with: profileData)
        return cell
    }
    
    
}

//MARK: - Setup UI
extension ProfileController {
    private func setupViews() {
        view.addSubview(tableView)
        
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - Business Logic
extension ProfileController {
    func fetchProfileData() {
        profileService.fetchProfileData { [self] result in
            switch result {
            case.success(let profileData):
                self.profileData = profileData
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
                
            }
        }
    }
}
