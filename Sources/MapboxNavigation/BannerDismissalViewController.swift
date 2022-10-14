import UIKit

// :nodoc:
public class BannerDismissalViewController: UIViewController, Banner {
    
    var topBannerView: TopBannerView!
    
    var topPaddingView: TopPaddingView!
    
    var backButton: BackButton!
    
    // :nodoc:
    public weak var delegate: BannerDismissalViewControllerDelegate?
    
    // MARK: - Banner properties
    
    // :nodoc:
    public var bannerConfiguration: BannerConfiguration {
        BannerConfiguration(position: .topLeading,
                            height: 70.0)
    }
    
    // :nodoc:
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        view.backgroundColor = .clear
        
        setupParentView()
        setupBackButton()
        setupConstraints()
    }
    
    // MARK: - UIViewController lifecycle methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UIViewController setting-up methods
    
    func setupParentView() {
        topBannerView = .forAutoLayout()
        topBannerView.backgroundColor = .clear
        
        topPaddingView = .forAutoLayout()
        topPaddingView.backgroundColor = .clear
        
        let parentViews: [UIView] = [
            topBannerView,
            topPaddingView
        ]
        
        view.addSubviews(parentViews)
    }
    
    func setupBackButton() {
        let backButton = BackButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let backButtonTitle = NSLocalizedString("BACK",
                                                bundle: .mapboxNavigation,
                                                value: "BACK",
                                                comment: "Title of the back button.")
        
        backButton.setTitle(backButtonTitle, for: .normal)
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(didTapDismissBannerButton), for: .touchUpInside)
        backButton.setImage(.backImage, for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.imageEdgeInsets = UIEdgeInsets(top: 10,
                                                  left: 0,
                                                  bottom: 10,
                                                  right: 15)
        topBannerView.addSubview(backButton)
        
        self.backButton = backButton
    }
    
    // MARK: - Event handlers
    
    @objc func didTapDismissBannerButton() {
        delegate?.didTapDismissBannerButton(self)
    }
}