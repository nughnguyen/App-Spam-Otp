//
//  ViewController.mm
//  xcodeapptesst
//
//  Created by Đỗ Thành on 02/12/2024.
//  Redesigned with Modern Cyber-Glassmorphism UI.
//

#import "ViewController.h"
#import "mahoa.h"
#import "MBProgressHUD.h"
#import <WebKit/WebKit.h>

@interface ViewController (Endpoints)
- (void)tv360;
- (void)viettel_login_dang_nhap;
- (void)viettel_tao_tai_khoan;
- (void)sapo_tao_acc;
- (void)modcha;
- (void)vieon;
- (void)fptshop;
- (void)fptshop1;
- (void)galaxyplay;
- (void)Shine30;
- (void)Shine30_test;
- (void)cathay;
- (void)dominos;
- (void)batdongsan;
- (void)fahase;
- (void)shopiness;
- (void)viettelpost;
- (void)bibabo;
- (void)owen;
- (void)pnj;
- (void)f88;
- (void)heyu;
- (void)thecoffee;
- (void)dienmayxanh;
- (void)kingfoodmart;
- (void)ghn;
- (void)lottemart;
- (void)vayvnd;
- (void)vato;
- (void)nhathuoclongchau;
- (void)vinamilk;
- (void)glxplay;
- (void)shopee;
- (void)watsons;
- (void)tokyolife;
- (void)go2joy;
// 5 New Endpoints from endpoints.json
- (void)adiraku;
- (void)singa;
- (void)pinhome;
- (void)maulagi;
- (void)saturdays;
@end

@interface ViewController () <UITextFieldDelegate>

// Scroll & Base Hierarchy
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) CAGradientLayer *bgGradientLayer;
@property (strong, nonatomic) UIView *ambientGlowView;

// Header
@property (strong, nonatomic) UIView *headerContainer;
@property (strong, nonatomic) UIView *logoBadge;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *brandLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIView *statusPill;
@property (strong, nonatomic) UILabel *statusPillLabel;

// Phone Input Card
@property (strong, nonatomic) UIView *phoneCard;
@property (strong, nonatomic) UILabel *phoneCardTitle;
@property (strong, nonatomic) UIButton *pasteButton;
@property (strong, nonatomic) UIView *phoneInputContainer;
@property (strong, nonatomic) UIImageView *phoneIconView;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UIButton *clearPhoneButton;
@property (strong, nonatomic) UIImageView *phoneStatusIcon;
@property (strong, nonatomic) UIButton *eyeButton;
@property (strong, nonatomic) UILabel *phoneValidationLabel;

// Action Hub Card
@property (strong, nonatomic) UIView *actionCard;
@property (strong, nonatomic) UIButton *runButton;
@property (strong, nonatomic) CAGradientLayer *runButtonGradient;
@property (strong, nonatomic) UIView *loopContainer;
@property (strong, nonatomic) UIImageView *loopIconView;
@property (strong, nonatomic) UILabel *loopTitleLabel;
@property (strong, nonatomic) UILabel *loopSubtitleLabel;
@property (strong, nonatomic) UILabel *loopStatusBadge;
@property (strong, nonatomic) UISwitch *loopSwitch;

// Terminal Log Card
@property (strong, nonatomic) UIView *terminalCard;
@property (strong, nonatomic) UIView *terminalHeader;
@property (strong, nonatomic) UILabel *terminalTitleLabel;
@property (strong, nonatomic) UILabel *terminalLogCountLabel;
@property (strong, nonatomic) UIButton *clearLogButton;
@property (strong, nonatomic) UITextView *logTextView;
@property (nonatomic) NSInteger logCount;

// Info & Donate Card
@property (strong, nonatomic) UIView *infoCard;
@property (strong, nonatomic) UILabel *infoTitleLabel;
@property (strong, nonatomic) UILabel *successLabel;
@property (strong, nonatomic) UIView *donateContainer;
@property (strong, nonatomic) UILabel *donateTitleLabel;
@property (strong, nonatomic) UILabel *donateDetailLabel;
@property (strong, nonatomic) UIButton *bankCopyButton;

// Footer
@property (strong, nonatomic) UIView *footerContainer;
@property (strong, nonatomic) UILabel *footerLabel;

// State & System
@property (nonatomic, strong) MBProgressHUD *currentHUD;
@property (nonatomic) BOOL isPhoneVisible;
@property (nonatomic) BOOL isLooping;
@property (nonatomic) NSTimer *loopTimer;
@property (strong, nonatomic) UIImpactFeedbackGenerator *impactFeedback;
@property (strong, nonatomic) UINotificationFeedbackGenerator *notificationFeedback;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Khởi tạo haptics
    self.impactFeedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    self.notificationFeedback = [[UINotificationFeedbackGenerator alloc] init];
    
    // Nền tối Gradient
    self.view.backgroundColor = [UIColor colorWithRed:0.04 green:0.06 blue:0.10 alpha:1.0];
    [self setupBackgroundLayers];
    
    // Khởi tạo ScrollView & ContentView
    [self setupScrollView];
    
    // Khởi tạo từng khối giao diện
    [self setupHeaderSection];
    [self setupPhoneInputSection];
    [self setupActionSection];
    [self setupTerminalSection];
    [self setupInfoAndDonateSection];
    [self setupFooterSection];
    
    // Gesture ẩn bàn phím khi chạm ra ngoài
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    // Đăng ký nhận thông báo bàn phím
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // Ghi log khởi động
    [self logMessage:@"[SYSTEM] OTP Stress Engine v1.0.0 khởi động thành công."];
    [self logMessage:@"[CONFIG] Đã sẵn sàng 41 Cổng API Spam OTP."];
    [self logMessage:@"[STATUS] Nhập số điện thoại mục tiêu để bắt đầu."];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.loopTimer) {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Setup Background

- (void)setupBackgroundLayers {
    self.bgGradientLayer = [CAGradientLayer layer];
    self.bgGradientLayer.colors = @[
        (id)[UIColor colorWithRed:0.03 green:0.05 blue:0.09 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:0.06 green:0.09 blue:0.15 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:0.02 green:0.03 blue:0.06 alpha:1.0].CGColor
    ];
    self.bgGradientLayer.locations = @[@0.0, @0.5, @1.0];
    self.bgGradientLayer.startPoint = CGPointMake(0.5, 0.0);
    self.bgGradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:self.bgGradientLayer atIndex:0];
    
    // Vệt hào quang màu chìm tạo chiều sâu Cyber
    self.ambientGlowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.ambientGlowView.backgroundColor = [UIColor colorWithRed:0.24 green:0.35 blue:0.95 alpha:0.18];
    self.ambientGlowView.layer.cornerRadius = 150;
    self.ambientGlowView.layer.masksToBounds = NO;
    self.ambientGlowView.userInteractionEnabled = NO;
    [self.view addSubview:self.ambientGlowView];
}

#pragma mark - Setup ScrollView

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.contentView];
}

#pragma mark - Header Section

- (void)setupHeaderSection {
    self.headerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.headerContainer];
    
    // Logo Icon Badge
    self.logoBadge = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    self.logoBadge.backgroundColor = [UIColor colorWithRed:0.15 green:0.22 blue:0.35 alpha:0.9];
    self.logoBadge.layer.cornerRadius = 16;
    self.logoBadge.layer.borderWidth = 1.0;
    self.logoBadge.layer.borderColor = [UIColor colorWithRed:0.35 green:0.55 blue:0.98 alpha:0.4].CGColor;
    self.logoBadge.layer.shadowColor = [UIColor colorWithRed:0.25 green:0.45 blue:0.95 alpha:0.4].CGColor;
    self.logoBadge.layer.shadowOpacity = 0.5;
    self.logoBadge.layer.shadowRadius = 10;
    self.logoBadge.layer.shadowOffset = CGSizeMake(0, 4);
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 13, 30, 30)];
    self.logoImageView.image = [UIImage systemImageNamed:@"bolt.shield.fill"];
    self.logoImageView.tintColor = [UIColor colorWithRed:0.38 green:0.65 blue:1.0 alpha:1.0];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.logoBadge addSubview:self.logoImageView];
    [self.headerContainer addSubview:self.logoBadge];
    
    // Brand Label
    self.brandLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.brandLabel.text = @"SPAM OTP";
    self.brandLabel.textAlignment = NSTextAlignmentCenter;
    self.brandLabel.font = [UIFont systemFontOfSize:26 weight:UIFontWeightHeavy];
    self.brandLabel.textColor = [UIColor whiteColor];
    [self.headerContainer addSubview:self.brandLabel];
    
    // Subtitle Label
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.text = @"STRESS TESTING & BENCHMARK TOOL";
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
    self.subtitleLabel.textColor = [UIColor colorWithRed:0.58 green:0.64 blue:0.72 alpha:1.0];
    [self.headerContainer addSubview:self.subtitleLabel];
    
    // Status Pill Badge (41 APIs Ready)
    self.statusPill = [[UIView alloc] initWithFrame:CGRectZero];
    self.statusPill.backgroundColor = [UIColor colorWithRed:0.06 green:0.22 blue:0.15 alpha:0.8];
    self.statusPill.layer.cornerRadius = 12;
    self.statusPill.layer.borderWidth = 1.0;
    self.statusPill.layer.borderColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.38 alpha:0.4].CGColor;
    
    self.statusPillLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.statusPillLabel.text = @"● 41 APIs Ready";
    self.statusPillLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    self.statusPillLabel.textColor = [UIColor colorWithRed:0.20 green:0.83 blue:0.55 alpha:1.0];
    self.statusPillLabel.textAlignment = NSTextAlignmentCenter;
    [self.statusPill addSubview:self.statusPillLabel];
    [self.headerContainer addSubview:self.statusPill];
}

#pragma mark - Phone Input Section

- (void)setupPhoneInputSection {
    self.phoneCard = [[UIView alloc] initWithFrame:CGRectZero];
    self.phoneCard.backgroundColor = [UIColor colorWithRed:0.09 green:0.13 blue:0.20 alpha:0.85];
    self.phoneCard.layer.cornerRadius = 18;
    self.phoneCard.layer.borderWidth = 1.0;
    self.phoneCard.layer.borderColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.38 alpha:0.5].CGColor;
    self.phoneCard.layer.shadowColor = [UIColor blackColor].CGColor;
    self.phoneCard.layer.shadowOpacity = 0.3;
    self.phoneCard.layer.shadowRadius = 12;
    self.phoneCard.layer.shadowOffset = CGSizeMake(0, 4);
    [self.contentView addSubview:self.phoneCard];
    
    // Card Title
    self.phoneCardTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.phoneCardTitle.text = @"SỐ ĐIỆN THOẠI MỤC TIÊU";
    self.phoneCardTitle.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    self.phoneCardTitle.textColor = [UIColor colorWithRed:0.58 green:0.64 blue:0.72 alpha:1.0];
    [self.phoneCard addSubview:self.phoneCardTitle];
    
    // Paste Button
    self.pasteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.pasteButton setTitle:@" Dán SĐT" forState:UIControlStateNormal];
    [self.pasteButton setImage:[UIImage systemImageNamed:@"doc.on.clipboard"] forState:UIControlStateNormal];
    self.pasteButton.tintColor = [UIColor colorWithRed:0.38 green:0.65 blue:1.0 alpha:1.0];
    self.pasteButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
    [self.pasteButton addTarget:self action:@selector(pasteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneCard addSubview:self.pasteButton];
    
    // Input Container Box
    self.phoneInputContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.phoneInputContainer.backgroundColor = [UIColor colorWithRed:0.04 green:0.07 blue:0.12 alpha:0.95];
    self.phoneInputContainer.layer.cornerRadius = 14;
    self.phoneInputContainer.layer.borderWidth = 1.5;
    self.phoneInputContainer.layer.borderColor = [UIColor colorWithRed:0.20 green:0.26 blue:0.36 alpha:1.0].CGColor;
    [self.phoneCard addSubview:self.phoneInputContainer];
    
    // Phone Icon Left
    self.phoneIconView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 15, 22, 22)];
    self.phoneIconView.image = [UIImage systemImageNamed:@"phone.fill"];
    self.phoneIconView.tintColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
    self.phoneIconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.phoneInputContainer addSubview:self.phoneIconView];
    
    // Phone TextField
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.backgroundColor = [UIColor clearColor];
    self.phoneTextField.textColor = [UIColor whiteColor];
    self.phoneTextField.font = [UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightBold];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.secureTextEntry = YES;
    self.isPhoneVisible = NO;
    self.phoneTextField.delegate = self;
    
    UIColor *placeholderColor = [UIColor colorWithRed:0.38 green:0.44 blue:0.52 alpha:1.0];
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0xx xxx xxxx"
                                                                               attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.phoneTextField addTarget:self action:@selector(phoneNumberChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneInputContainer addSubview:self.phoneTextField];
    
    // Clear Button (X)
    self.clearPhoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearPhoneButton setImage:[UIImage systemImageNamed:@"xmark.circle.fill"] forState:UIControlStateNormal];
    self.clearPhoneButton.tintColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
    self.clearPhoneButton.hidden = YES;
    [self.clearPhoneButton addTarget:self action:@selector(clearPhoneTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneInputContainer addSubview:self.clearPhoneButton];
    
    // Status Icon (Check / Warning)
    self.phoneStatusIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.phoneStatusIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.phoneStatusIcon.hidden = YES;
    [self.phoneInputContainer addSubview:self.phoneStatusIcon];
    
    // Eye Button
    self.eyeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.eyeButton setImage:[UIImage systemImageNamed:@"eye"] forState:UIControlStateNormal];
    self.eyeButton.tintColor = [UIColor colorWithRed:0.58 green:0.64 blue:0.72 alpha:1.0];
    [self.eyeButton addTarget:self action:@selector(eyeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneInputContainer addSubview:self.eyeButton];
    
    // Helper & Validation Label
    self.phoneValidationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.phoneValidationLabel.text = @"Định dạng hợp lệ: 10 chữ số bắt đầu bằng 0 (VD: 0912345678)";
    self.phoneValidationLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.phoneValidationLabel.textColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
    [self.phoneCard addSubview:self.phoneValidationLabel];
}

#pragma mark - Action Section

- (void)setupActionSection {
    self.actionCard = [[UIView alloc] initWithFrame:CGRectZero];
    self.actionCard.backgroundColor = [UIColor colorWithRed:0.09 green:0.13 blue:0.20 alpha:0.85];
    self.actionCard.layer.cornerRadius = 18;
    self.actionCard.layer.borderWidth = 1.0;
    self.actionCard.layer.borderColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.38 alpha:0.5].CGColor;
    self.actionCard.layer.shadowColor = [UIColor blackColor].CGColor;
    self.actionCard.layer.shadowOpacity = 0.3;
    self.actionCard.layer.shadowRadius = 12;
    self.actionCard.layer.shadowOffset = CGSizeMake(0, 4);
    [self.contentView addSubview:self.actionCard];
    
    // Run Button
    self.runButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.runButton setTitle:@"⚡  BẮT ĐẦU CHẠY 1 LẦN" forState:UIControlStateNormal];
    [self.runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.runButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    self.runButton.layer.cornerRadius = 14;
    self.runButton.layer.masksToBounds = YES;
    
    self.runButtonGradient = [CAGradientLayer layer];
    self.runButtonGradient.colors = @[
        (id)[UIColor colorWithRed:0.15 green:0.45 blue:0.95 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:0.45 green:0.25 blue:0.92 alpha:1.0].CGColor
    ];
    self.runButtonGradient.startPoint = CGPointMake(0.0, 0.5);
    self.runButtonGradient.endPoint = CGPointMake(1.0, 0.5);
    [self.runButton.layer insertSublayer:self.runButtonGradient atIndex:0];
    
    [self.runButton addTarget:self action:@selector(runButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    UIControlEvents touchUpEvents = (UIControlEvents)(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel);
    [self.runButton addTarget:self action:@selector(runButtonTouchUp:) forControlEvents:touchUpEvents];
    [self.runButton addTarget:self action:@selector(runButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionCard addSubview:self.runButton];
    
    // Loop Container Row
    self.loopContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.loopContainer.backgroundColor = [UIColor colorWithRed:0.04 green:0.07 blue:0.12 alpha:0.8];
    self.loopContainer.layer.cornerRadius = 14;
    self.loopContainer.layer.borderWidth = 1.0;
    self.loopContainer.layer.borderColor = [UIColor colorWithRed:0.18 green:0.24 blue:0.34 alpha:0.6].CGColor;
    [self.actionCard addSubview:self.loopContainer];
    
    // Loop Icon
    self.loopIconView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 18, 26, 26)];
    self.loopIconView.image = [UIImage systemImageNamed:@"arrow.triangle.2.circlepath.circle.fill"];
    self.loopIconView.tintColor = [UIColor colorWithRed:0.48 green:0.40 blue:0.95 alpha:1.0];
    self.loopIconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.loopContainer addSubview:self.loopIconView];
    
    // Loop Title & Subtitle
    self.loopTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.loopTitleLabel.text = @"Spam Vô Hạn (Auto Loop)";
    self.loopTitleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    self.loopTitleLabel.textColor = [UIColor whiteColor];
    [self.loopContainer addSubview:self.loopTitleLabel];
    
    self.loopSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.loopSubtitleLabel.text = @"Tự động lặp lại 41 API mỗi 2.0s";
    self.loopSubtitleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
    self.loopSubtitleLabel.textColor = [UIColor colorWithRed:0.58 green:0.64 blue:0.72 alpha:1.0];
    [self.loopContainer addSubview:self.loopSubtitleLabel];
    
    // Loop Status Badge
    self.loopStatusBadge = [[UILabel alloc] initWithFrame:CGRectZero];
    self.loopStatusBadge.text = @"TẮT";
    self.loopStatusBadge.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
    self.loopStatusBadge.textColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
    self.loopStatusBadge.textAlignment = NSTextAlignmentRight;
    [self.loopContainer addSubview:self.loopStatusBadge];
    
    // Loop Switch
    self.loopSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.loopSwitch.onTintColor = [UIColor colorWithRed:0.35 green:0.28 blue:0.95 alpha:1.0];
    [self.loopSwitch addTarget:self action:@selector(loopSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.loopContainer addSubview:self.loopSwitch];
}

#pragma mark - Terminal Section

- (void)setupTerminalSection {
    self.terminalCard = [[UIView alloc] initWithFrame:CGRectZero];
    self.terminalCard.backgroundColor = [UIColor colorWithRed:0.06 green:0.09 blue:0.14 alpha:0.95];
    self.terminalCard.layer.cornerRadius = 18;
    self.terminalCard.layer.borderWidth = 1.0;
    self.terminalCard.layer.borderColor = [UIColor colorWithRed:0.16 green:0.22 blue:0.32 alpha:0.7].CGColor;
    self.terminalCard.layer.shadowColor = [UIColor blackColor].CGColor;
    self.terminalCard.layer.shadowOpacity = 0.35;
    self.terminalCard.layer.shadowRadius = 12;
    self.terminalCard.layer.shadowOffset = CGSizeMake(0, 4);
    [self.contentView addSubview:self.terminalCard];
    
    // Header bar (macOS Style)
    self.terminalHeader = [[UIView alloc] initWithFrame:CGRectZero];
    [self.terminalCard addSubview:self.terminalHeader];
    
    // 3 Dots
    CGFloat dotColors[3][3] = {
        {1.0, 0.37, 0.34}, // Red
        {1.0, 0.74, 0.18}, // Yellow
        {0.15, 0.79, 0.25} // Green
    };
    for (int i = 0; i < 3; i++) {
        UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(14 + (i * 15), 14, 9, 9)];
        dot.backgroundColor = [UIColor colorWithRed:dotColors[i][0] green:dotColors[i][1] blue:dotColors[i][2] alpha:1.0];
        dot.layer.cornerRadius = 4.5;
        [self.terminalHeader addSubview:dot];
    }
    
    // Terminal Title
    self.terminalTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.terminalTitleLabel.text = @"TERMINAL CONSOLE";
    self.terminalTitleLabel.font = [UIFont monospacedSystemFontOfSize:11 weight:UIFontWeightBold];
    self.terminalTitleLabel.textColor = [UIColor colorWithRed:0.65 green:0.72 blue:0.82 alpha:1.0];
    [self.terminalHeader addSubview:self.terminalTitleLabel];
    
    // Log count badge
    self.terminalLogCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.terminalLogCountLabel.text = @"0 Logs";
    self.terminalLogCountLabel.font = [UIFont monospacedSystemFontOfSize:10 weight:UIFontWeightSemibold];
    self.terminalLogCountLabel.textColor = [UIColor colorWithRed:0.20 green:0.83 blue:0.55 alpha:1.0];
    self.terminalLogCountLabel.backgroundColor = [UIColor colorWithRed:0.06 green:0.20 blue:0.14 alpha:0.8];
    self.terminalLogCountLabel.layer.cornerRadius = 8;
    self.terminalLogCountLabel.layer.masksToBounds = YES;
    self.terminalLogCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.terminalHeader addSubview:self.terminalLogCountLabel];
    
    // Clear Log Button
    self.clearLogButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearLogButton setImage:[UIImage systemImageNamed:@"trash.fill"] forState:UIControlStateNormal];
    [self.clearLogButton setTitle:@" Xoá" forState:UIControlStateNormal];
    self.clearLogButton.tintColor = [UIColor colorWithRed:0.55 green:0.62 blue:0.72 alpha:1.0];
    self.clearLogButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    [self.clearLogButton addTarget:self action:@selector(clearLogButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.terminalHeader addSubview:self.clearLogButton];
    
    // Log TextView
    self.logTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.logTextView.backgroundColor = [UIColor colorWithRed:0.03 green:0.05 blue:0.08 alpha:1.0];
    self.logTextView.textColor = [UIColor colorWithRed:0.35 green:0.80 blue:1.0 alpha:1.0];
    self.logTextView.font = [UIFont monospacedSystemFontOfSize:11 weight:UIFontWeightRegular];
    self.logTextView.editable = NO;
    self.logTextView.layer.cornerRadius = 10;
    self.logTextView.layer.borderWidth = 1.0;
    self.logTextView.layer.borderColor = [UIColor colorWithRed:0.12 green:0.17 blue:0.25 alpha:0.8].CGColor;
    self.logTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.terminalCard addSubview:self.logTextView];
}

#pragma mark - Info & Donate Section

- (void)setupInfoAndDonateSection {
    self.infoCard = [[UIView alloc] initWithFrame:CGRectZero];
    self.infoCard.backgroundColor = [UIColor colorWithRed:0.09 green:0.13 blue:0.20 alpha:0.85];
    self.infoCard.layer.cornerRadius = 18;
    self.infoCard.layer.borderWidth = 1.0;
    self.infoCard.layer.borderColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.38 alpha:0.5].CGColor;
    [self.contentView addSubview:self.infoCard];
    
    // Title
    self.infoTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.infoTitleLabel.text = @"HƯỚNG DẪN & ĐIỀU KHOẢN";
    self.infoTitleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    self.infoTitleLabel.textColor = [UIColor colorWithRed:0.58 green:0.64 blue:0.72 alpha:1.0];
    [self.infoCard addSubview:self.infoTitleLabel];
    
    // Detail Text (successLabel tương thích ngược)
    self.successLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.successLabel.numberOfLines = 0;
    self.successLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSString *instructions = @"• Nhập đúng số điện thoại (định dạng 0xx.xxxxxxx).\n"
                             @"• Nút Chạy: gửi 1 đợt kích hoạt đồng thời 41 cổng API.\n"
                             @"• Nút Gạt: tự động gửi lặp lại liên tục sau mỗi 2.0 giây.\n"
                             @"• Miễn trừ trách nhiệm: Ứng dụng phục vụ mục đích kiểm thử bảo mật & benchmark dịch vụ.";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:instructions];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attr.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:NSMakeRange(0, attr.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.75 green:0.80 blue:0.88 alpha:1.0] range:NSMakeRange(0, attr.length)];
    self.successLabel.attributedText = attr;
    [self.infoCard addSubview:self.successLabel];
    
    // Donate Highlight Box
    self.donateContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.donateContainer.backgroundColor = [UIColor colorWithRed:0.18 green:0.08 blue:0.16 alpha:0.8];
    self.donateContainer.layer.cornerRadius = 14;
    self.donateContainer.layer.borderWidth = 1.0;
    self.donateContainer.layer.borderColor = [UIColor colorWithRed:0.85 green:0.25 blue:0.45 alpha:0.4].CGColor;
    [self.infoCard addSubview:self.donateContainer];
    
    self.donateTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.donateTitleLabel.text = @"❤️  ỦNG HỘ TÁC GIẢ (DONATE)";
    self.donateTitleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    self.donateTitleLabel.textColor = [UIColor colorWithRed:1.0 green:0.42 blue:0.62 alpha:1.0];
    [self.donateContainer addSubview:self.donateTitleLabel];
    
    self.donateDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.donateDetailLabel.numberOfLines = 0;
    self.donateDetailLabel.text = @"MOMO / NGÂN HÀNG: PSP2602016500000627\nCHỦ TK: NGUYEN QUOC HUNG";
    self.donateDetailLabel.font = [UIFont monospacedSystemFontOfSize:11.5 weight:UIFontWeightMedium];
    self.donateDetailLabel.textColor = [UIColor whiteColor];
    [self.donateContainer addSubview:self.donateDetailLabel];
    
    self.bankCopyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.bankCopyButton setTitle:@"Sao Chép STK" forState:UIControlStateNormal];
    [self.bankCopyButton setImage:[UIImage systemImageNamed:@"doc.on.doc.fill"] forState:UIControlStateNormal];
    self.bankCopyButton.backgroundColor = [UIColor colorWithRed:0.85 green:0.20 blue:0.42 alpha:1.0];
    self.bankCopyButton.tintColor = [UIColor whiteColor];
    self.bankCopyButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
    self.bankCopyButton.layer.cornerRadius = 10;
    [self.bankCopyButton addTarget:self action:@selector(bankCopyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.donateContainer addSubview:self.bankCopyButton];
}

#pragma mark - Footer Section

- (void)setupFooterSection {
    self.footerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.footerContainer];
    
    self.footerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.footerLabel.text = NSSENCRYPT("@YoungGumballZ");
    self.footerLabel.textAlignment = NSTextAlignmentCenter;
    self.footerLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.footerLabel.textColor = [UIColor colorWithRed:0.45 green:0.55 blue:0.75 alpha:1.0];
    self.footerLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerLabelTapped:)];
    [self.footerLabel addGestureRecognizer:tapGesture];
    [self.footerContainer addSubview:self.footerLabel];
}

#pragma mark - Dynamic Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.bgGradientLayer.frame = self.view.bounds;
    self.scrollView.frame = self.view.bounds;
    
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat contentPadding = 16.0;
    CGFloat cardWidth = screenWidth - (contentPadding * 2);
    
    CGFloat safeTop = 0;
    CGFloat safeBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeTop = self.view.safeAreaInsets.top;
        safeBottom = self.view.safeAreaInsets.bottom;
    }
    if (safeTop < 20) safeTop = 20;
    if (safeBottom < 20) safeBottom = 20;
    
    self.ambientGlowView.center = CGPointMake(screenWidth - 40, safeTop + 60);
    
    CGFloat currentY = safeTop + 10;
    
    // Header Layout
    self.logoBadge.center = CGPointMake(cardWidth / 2, 28);
    self.brandLabel.frame = CGRectMake(0, 64, cardWidth, 30);
    self.subtitleLabel.frame = CGRectMake(0, 96, cardWidth, 16);
    self.statusPill.frame = CGRectMake((cardWidth - 140) / 2, 120, 140, 24);
    self.statusPillLabel.frame = self.statusPill.bounds;
    
    CGFloat headerHeight = 152;
    self.headerContainer.frame = CGRectMake(contentPadding, currentY, cardWidth, headerHeight);
    currentY += headerHeight + 16;
    
    // Phone Input Card Layout
    self.phoneCardTitle.frame = CGRectMake(16, 14, 180, 20);
    self.pasteButton.frame = CGRectMake(cardWidth - 110, 10, 96, 28);
    
    CGFloat inputHeight = 52;
    self.phoneInputContainer.frame = CGRectMake(14, 42, cardWidth - 28, inputHeight);
    self.phoneIconView.frame = CGRectMake(14, (inputHeight - 20) / 2, 20, 20);
    
    CGFloat rightElementsWidth = 100;
    self.phoneTextField.frame = CGRectMake(46, 0, (cardWidth - 28) - 46 - rightElementsWidth, inputHeight);
    
    CGFloat rightStartX = (cardWidth - 28) - rightElementsWidth;
    self.clearPhoneButton.frame = CGRectMake(rightStartX, (inputHeight - 28) / 2, 28, 28);
    self.phoneStatusIcon.frame = CGRectMake(rightStartX + 32, (inputHeight - 24) / 2, 24, 24);
    self.eyeButton.frame = CGRectMake(rightStartX + 64, (inputHeight - 32) / 2, 32, 32);
    
    self.phoneValidationLabel.frame = CGRectMake(16, 42 + inputHeight + 8, cardWidth - 32, 18);
    
    CGFloat phoneCardHeight = 42 + inputHeight + 8 + 18 + 14;
    self.phoneCard.frame = CGRectMake(contentPadding, currentY, cardWidth, phoneCardHeight);
    currentY += phoneCardHeight + 14;
    
    // Action Section Layout
    CGFloat runButtonHeight = 52;
    self.runButton.frame = CGRectMake(14, 14, cardWidth - 28, runButtonHeight);
    self.runButtonGradient.frame = self.runButton.bounds;
    
    CGFloat loopContainerHeight = 64;
    self.loopContainer.frame = CGRectMake(14, 14 + runButtonHeight + 12, cardWidth - 28, loopContainerHeight);
    self.loopIconView.frame = CGRectMake(14, (loopContainerHeight - 26) / 2, 26, 26);
    
    CGFloat loopSwitchWidth = 51;
    CGFloat loopTextWidth = (cardWidth - 28) - 52 - loopSwitchWidth - 75;
    self.loopTitleLabel.frame = CGRectMake(50, 12, loopTextWidth, 20);
    self.loopSubtitleLabel.frame = CGRectMake(50, 34, loopTextWidth, 16);
    self.loopStatusBadge.frame = CGRectMake((cardWidth - 28) - loopSwitchWidth - 70, (loopContainerHeight - 20) / 2, 60, 20);
    self.loopSwitch.frame = CGRectMake((cardWidth - 28) - loopSwitchWidth - 14, (loopContainerHeight - 31) / 2, loopSwitchWidth, 31);
    
    CGFloat actionCardHeight = 14 + runButtonHeight + 12 + loopContainerHeight + 14;
    self.actionCard.frame = CGRectMake(contentPadding, currentY, cardWidth, actionCardHeight);
    currentY += actionCardHeight + 14;
    
    // Terminal Section Layout
    self.terminalHeader.frame = CGRectMake(0, 0, cardWidth, 36);
    self.terminalTitleLabel.frame = CGRectMake(70, 8, 140, 20);
    self.terminalLogCountLabel.frame = CGRectMake(cardWidth - 130, 8, 60, 20);
    self.clearLogButton.frame = CGRectMake(cardWidth - 65, 8, 55, 20);
    
    CGFloat logViewHeight = 160;
    self.logTextView.frame = CGRectMake(12, 38, cardWidth - 24, logViewHeight);
    
    CGFloat terminalCardHeight = 38 + logViewHeight + 14;
    self.terminalCard.frame = CGRectMake(contentPadding, currentY, cardWidth, terminalCardHeight);
    currentY += terminalCardHeight + 14;
    
    // Info & Donate Section Layout
    self.infoTitleLabel.frame = CGRectMake(16, 14, cardWidth - 32, 18);
    
    CGSize instructionSize = [self.successLabel sizeThatFits:CGSizeMake(cardWidth - 32, CGFLOAT_MAX)];
    self.successLabel.frame = CGRectMake(16, 38, cardWidth - 32, instructionSize.height);
    
    CGFloat donateTop = 38 + instructionSize.height + 14;
    CGFloat donateHeight = 90;
    self.donateContainer.frame = CGRectMake(12, donateTop, cardWidth - 24, donateHeight);
    
    self.donateTitleLabel.frame = CGRectMake(12, 10, (cardWidth - 24) - 24, 16);
    self.donateDetailLabel.frame = CGRectMake(12, 30, (cardWidth - 24) - 130, 50);
    self.bankCopyButton.frame = CGRectMake((cardWidth - 24) - 114, 34, 102, 34);
    
    CGFloat infoCardHeight = donateTop + donateHeight + 14;
    self.infoCard.frame = CGRectMake(contentPadding, currentY, cardWidth, infoCardHeight);
    currentY += infoCardHeight + 14;
    
    // Footer Layout
    self.footerContainer.frame = CGRectMake(contentPadding, currentY, cardWidth, 36);
    self.footerLabel.frame = self.footerContainer.bounds;
    currentY += 36 + safeBottom + 20;
    
    self.contentView.frame = CGRectMake(0, 0, screenWidth, currentY);
    self.scrollView.contentSize = CGSizeMake(screenWidth, currentY);
}

#pragma mark - Keyboard Handling

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = [self.phoneCard convertRect:self.phoneCard.bounds toView:self.scrollView];
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark - Actions & Validation

- (void)phoneNumberChanged:(UITextField *)textField {
    NSString *rawText = textField.text ?: @"";
    
    // Cập nhật nút Clear (X)
    self.clearPhoneButton.hidden = (rawText.length == 0);
    
    // Kiểm tra định dạng số điện thoại Việt Nam (10 số, bắt đầu bằng 0)
    if (rawText.length == 0) {
        self.phoneInputContainer.layer.borderColor = [UIColor colorWithRed:0.20 green:0.26 blue:0.36 alpha:1.0].CGColor;
        self.phoneValidationLabel.text = @"Định dạng hợp lệ: 10 chữ số bắt đầu bằng 0 (VD: 0912345678)";
        self.phoneValidationLabel.textColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
        self.phoneStatusIcon.hidden = YES;
    } else if (rawText.length < 10) {
        self.phoneInputContainer.layer.borderColor = [UIColor colorWithRed:0.96 green:0.62 blue:0.04 alpha:1.0].CGColor;
        self.phoneValidationLabel.text = [NSString stringWithFormat:@"Đang nhập: %lu/10 số...", (unsigned long)rawText.length];
        self.phoneValidationLabel.textColor = [UIColor colorWithRed:0.96 green:0.62 blue:0.04 alpha:1.0];
        
        self.phoneStatusIcon.image = [UIImage systemImageNamed:@"exclamationmark.circle.fill"];
        self.phoneStatusIcon.tintColor = [UIColor colorWithRed:0.96 green:0.62 blue:0.04 alpha:1.0];
        self.phoneStatusIcon.hidden = NO;
    } else if (rawText.length == 10 && [rawText hasPrefix:@"0"]) {
        // Hợp lệ 100%
        self.phoneInputContainer.layer.borderColor = [UIColor colorWithRed:0.16 green:0.80 blue:0.48 alpha:1.0].CGColor;
        self.phoneValidationLabel.text = @"✓ Số điện thoại hợp lệ và sẵn sàng kích hoạt!";
        self.phoneValidationLabel.textColor = [UIColor colorWithRed:0.16 green:0.80 blue:0.48 alpha:1.0];
        
        self.phoneStatusIcon.image = [UIImage systemImageNamed:@"checkmark.seal.fill"];
        self.phoneStatusIcon.tintColor = [UIColor colorWithRed:0.16 green:0.80 blue:0.48 alpha:1.0];
        self.phoneStatusIcon.hidden = NO;
        
        // Hiệu ứng nảy nhẹ của icon hợp lệ
        self.phoneStatusIcon.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
            self.phoneStatusIcon.transform = CGAffineTransformIdentity;
        } completion:nil];
    } else {
        // Sai định dạng
        self.phoneInputContainer.layer.borderColor = [UIColor colorWithRed:0.94 green:0.25 blue:0.25 alpha:1.0].CGColor;
        self.phoneValidationLabel.text = @"✗ Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0";
        self.phoneValidationLabel.textColor = [UIColor colorWithRed:0.94 green:0.25 blue:0.25 alpha:1.0];
        
        self.phoneStatusIcon.image = [UIImage systemImageNamed:@"xmark.circle.fill"];
        self.phoneStatusIcon.tintColor = [UIColor colorWithRed:0.94 green:0.25 blue:0.25 alpha:1.0];
        self.phoneStatusIcon.hidden = NO;
    }
}

- (void)clearPhoneTapped:(id)sender {
    [self.impactFeedback impactOccurred];
    self.phoneTextField.text = @"";
    [self phoneNumberChanged:self.phoneTextField];
}

- (void)pasteButtonTapped:(id)sender {
    [self.impactFeedback impactOccurred];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *copiedString = pasteboard.string ?: @"";
    
    // Làm sạch số điện thoại (bỏ dấu cách, dấu chấm, gạch ngang, +84 -> 0)
    NSString *cleaned = [copiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    cleaned = [cleaned stringByReplacingOccurrencesOfString:@"." withString:@""];
    cleaned = [cleaned stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([cleaned hasPrefix:@"+84"]) {
        cleaned = [@"0" stringByAppendingString:[cleaned substringFromIndex:3]];
    } else if ([cleaned hasPrefix:@"84"]) {
        cleaned = [@"0" stringByAppendingString:[cleaned substringFromIndex:2]];
    }
    
    // Chỉ giữ ký tự số
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    cleaned = [[cleaned componentsSeparatedByCharactersInSet:nonDigits] componentsJoinedByString:@""];
    
    if (cleaned.length > 10) {
        cleaned = [cleaned substringToIndex:10];
    }
    
    if (cleaned.length > 0) {
        self.phoneTextField.text = cleaned;
        [self phoneNumberChanged:self.phoneTextField];
        [self showHUDWithMessage:[NSString stringWithFormat:@"Đã dán: %@", cleaned] duration:1.0];
    } else {
        [self showHUDWithMessage:@"Không tìm thấy SĐT trong bộ nhớ tạm" duration:1.5];
    }
}

- (void)eyeButtonTapped:(id)sender {
    [self.impactFeedback impactOccurred];
    self.isPhoneVisible = !self.isPhoneVisible;
    self.phoneTextField.secureTextEntry = !self.isPhoneVisible;
    
    NSString *iconName = self.isPhoneVisible ? @"eye.slash.fill" : @"eye.fill";
    [self.eyeButton setImage:[UIImage systemImageNamed:iconName] forState:UIControlStateNormal];
}

- (void)runButtonTouchDown:(UIButton *)sender {
    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(0.97, 0.97);
    }];
}

- (void)runButtonTouchUp:(UIButton *)sender {
    [UIView animateWithDuration:0.15 animations:^{
        sender.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)runButtonTapped:(UIButton *)sender {
    [self.view endEditing:YES];
    
    NSString *phone = self.phoneTextField.text ?: @"";
    if (phone.length != 10 || ![phone hasPrefix:@"0"]) {
        [self.notificationFeedback notificationOccurred:UINotificationFeedbackTypeError];
        [self shakeView:self.phoneInputContainer];
        [self showHUDWithMessage:@"Vui lòng nhập đúng 10 số ĐT (0xx...)" duration:1.8];
        return;
    }
    
    [self.impactFeedback impactOccurred];
    
    self.currentHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.currentHUD.mode = MBProgressHUDModeIndeterminate;
    self.currentHUD.label.text = @"Đang Gửi 41 API Spam...";
    self.currentHUD.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    self.currentHUD.bezelView.backgroundColor = [UIColor colorWithRed:0.08 green:0.12 blue:0.18 alpha:0.85];
    self.currentHUD.contentColor = [UIColor whiteColor];
    
    [self logMessage:[NSString stringWithFormat:@"[TRIGGER] Bắt đầu kích hoạt 41 API tới: %@", phone]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self sendOTPAndNewOTPRequests];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentHUD.label.text = @"Hoàn Tất Đợt Gửi!";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.currentHUD hideAnimated:YES];
            });
        });
    });
}

- (void)loopSwitchChanged:(id)sender {
    [self.impactFeedback impactOccurred];
    self.isLooping = self.loopSwitch.isOn;
    
    if (self.isLooping) {
        NSString *phone = self.phoneTextField.text ?: @"";
        if (phone.length != 10 || ![phone hasPrefix:@"0"]) {
            [self.loopSwitch setOn:NO animated:YES];
            self.isLooping = NO;
            [self.notificationFeedback notificationOccurred:UINotificationFeedbackTypeError];
            [self shakeView:self.phoneInputContainer];
            [self showHUDWithMessage:@"Vui lòng nhập đúng 10 số ĐT trước khi bật Loop" duration:2.0];
            return;
        }
        
        self.loopStatusBadge.text = @"● ĐANG CHẠY";
        self.loopStatusBadge.textColor = [UIColor colorWithRed:0.95 green:0.35 blue:0.35 alpha:1.0];
        
        [self showHUDWithMessage:@"Đã Bật Spam Lặp Vô Hạn" duration:1.5];
        [self logMessage:@"[LOOP] Bắt đầu chế độ spam lặp lại mỗi 2.0s."];
        
        // Chạy ngay lần đầu
        [self sendOTPAndNewOTPRequests];
        
        // Hẹn giờ lặp lại mỗi 2 giây
        self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                          target:self
                                                        selector:@selector(sendOTPAndNewOTPRequests)
                                                        userInfo:nil
                                                         repeats:YES];
    } else {
        self.loopStatusBadge.text = @"TẮT";
        self.loopStatusBadge.textColor = [UIColor colorWithRed:0.45 green:0.52 blue:0.62 alpha:1.0];
        
        if (self.loopTimer) {
            [self.loopTimer invalidate];
            self.loopTimer = nil;
        }
        [self showHUDWithMessage:@"Đã Dừng Tiến Trình Lặp" duration:1.2];
        [self logMessage:@"[LOOP] Đã dừng chế độ spam tự động."];
    }
}

- (void)clearLogButtonTapped:(id)sender {
    [self.impactFeedback impactOccurred];
    self.logTextView.text = @"";
    self.logCount = 0;
    self.terminalLogCountLabel.text = @"0 Logs";
    [self logMessage:@"[SYSTEM] Đã làm mới console."];
}

- (void)bankCopyButtonTapped:(id)sender {
    [self.notificationFeedback notificationOccurred:UINotificationFeedbackTypeSuccess];
    [UIPasteboard generalPasteboard].string = @"PSP2602016500000627";
    [self showHUDWithMessage:@"Đã sao chép STK: PSP2602016500000627" duration:1.5];
}

- (void)footerLabelTapped:(id)sender {
    [self.impactFeedback impactOccurred];
    NSURL *url = [NSURL URLWithString:NSSENCRYPT("https://www.facebook.com/hungnq188.2k5")];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - Helper Animations

- (void)shakeView:(UIView *)view {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.4;
    animation.values = @[@(-10), @(10), @(-8), @(8), @(-4), @(4), @(0)];
    [view.layer addAnimation:animation forKey:@"shake"];
}

#pragma mark - Logging System

- (void)logMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logCount++;
        self.terminalLogCountLabel.text = [NSString stringWithFormat:@"%ld Logs", (long)self.logCount];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSString *timeStr = [formatter stringFromDate:[NSDate date]];
        
        NSString *formattedEntry = [NSString stringWithFormat:@"[%@] %@\n", timeStr, message];
        self.logTextView.text = [self.logTextView.text stringByAppendingString:formattedEntry];
        
        if (self.logTextView.text.length > 0) {
            NSRange bottom = NSMakeRange(self.logTextView.text.length - 1, 1);
            [self.logTextView scrollRangeToVisible:bottom];
        }
    });
}

#pragma mark - HUD Helpers

- (void)showHUDWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.08 green:0.12 blue:0.18 alpha:0.88];
    hud.contentColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

- (void)showHUDWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = message;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.08 green:0.12 blue:0.18 alpha:0.88];
    hud.contentColor = [UIColor whiteColor];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - All 41 API Requests Dispatcher

- (void)sendOTPAndNewOTPRequests {
    // 36 Legacy Endpoints
    [self tv360];
    [self viettel_login_dang_nhap];
    [self viettel_tao_tai_khoan];
    [self sapo_tao_acc];
    [self modcha];
    [self vieon];
    [self fptshop];
    [self fptshop1];
    [self galaxyplay];
    [self Shine30];
    [self Shine30_test];
    [self cathay];
    [self dominos];
    [self batdongsan];
    [self fahase];
    [self shopiness];
    [self viettelpost];
    [self bibabo];
    [self owen];
    [self pnj];
    [self f88];
    [self heyu];
    [self thecoffee];
    [self dienmayxanh];
    [self kingfoodmart];
    [self ghn];
    [self lottemart];
    [self vayvnd];
    [self vato];
    [self nhathuoclongchau];
    [self vinamilk];
    [self glxplay];
    [self shopee];
    [self watsons];
    [self tokyolife];
    [self go2joy];
    
    // 5 New Endpoints from endpoints.json
    [self adiraku];
    [self singa];
    [self pinhome];
    [self maulagi];
    [self saturdays];
}

#pragma mark - Import Endpoints Implementation

#import "apiotp.h"

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Chỉ cho phép nhập ký tự số
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string rangeOfCharacterFromSet:nonDigits].location != NSNotFound) {
        return NO;
    }
    
    // Giới hạn tối đa 10 chữ số
    NSString *currentText = textField.text ?: @"";
    NSString *newText = [currentText stringByReplacingCharactersInRange:range withString:string];
    return newText.length <= 10;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
