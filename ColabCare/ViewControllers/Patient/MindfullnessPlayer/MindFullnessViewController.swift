//
//  ViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit
import AVKit
import SVProgressHUD
class MindFullnessViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lblAllMeditation: UILabel!
    @IBOutlet weak var constraintHeightcollectionView: NSLayoutConstraint!
    @IBOutlet weak var btnInformation: UIButton!
    @IBOutlet weak var btnOkay: UserDefineBtn!
    @IBOutlet weak var viewInfoMiddle: UIView!
    @IBOutlet weak var tblInfo: UITableView!
    @IBOutlet weak var viewInfoBackground: UIView!
    @IBOutlet weak var lblRecommendation: UILabel!
    @IBOutlet weak var constraintTopAllMeditation: NSLayoutConstraint!
    @IBOutlet weak var viewNavigation: NavigationHeaderView!
    @IBOutlet weak var table: UITableView!
    var meditations = [Song]()
    var recommendMeditations = [Song]()
    var recommendMed = [String]()
    var arrData = [ModelCollectionFlowLayout]()
    @IBOutlet var collectionView: UICollectionView!
    var meditationName = [String]()
    var questionnerAns = [Int:[Int]]()
    var arrInfo = [String]()
    @IBOutlet weak var tblViewInfoHeight: NSLayoutConstraint!
    var arrImg = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
            lblRecommendation.font = lblRecommendation.font.withSize(18)
            lblAllMeditation.font = lblAllMeditation.font.withSize(18)
        }
        table.delegate = self
        table.dataSource = self
        changeBackground(view: self.view)
        configureSongs()
        tblInfo.delegate = self
        tblInfo.dataSource = self
        tblInfo.estimatedRowHeight = 200
        tblInfo.rowHeight = UITableView.automaticDimension
        tblInfo.showsVerticalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
    }
    
    func  setupCarouselView(){
        if questionnerAns.count != 0{
            collectionView.isHidden = false
            btnInformation.isHidden = false
            lblRecommendation.isHidden = false
            collectData()
            let floawLayout = UPCarouselFlowLayout()
            if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
                constraintHeightcollectionView.constant = 160
                floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 140.0, height: 160)
                constraintTopAllMeditation.constant = 260
            } else {
                floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 140.0, height: collectionView.frame.size.height)
                constraintTopAllMeditation.constant = 310
            }
            self.collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            floawLayout.scrollDirection = .horizontal
            floawLayout.sideItemScale = 0.8
            floawLayout.sideItemAlpha = 1.0
            floawLayout.spacingMode = .fixed(spacing: 5.0)
            collectionView.collectionViewLayout = floawLayout
            
        }
    }
    
    @IBAction func btnOkayTapped(_ sender: Any) {
        viewInfoBackground.isHidden = true
    }
    func collectData(){
        if questionnerAns[1] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Calming_10_Minute_Breathing_Meditation) {
                recommendMeditations.append(meditations[0])
                recommendMed.append(KEY.MEDITATION.Calming_10_Minute_Breathing_Meditation)
            }
        }
        if questionnerAns[2] != nil{
            if !recommendMed.contains(KEY.MEDITATION._10_Minute_Body_Scan){
                recommendMeditations.append(meditations[1])
                recommendMed.append(KEY.MEDITATION._10_Minute_Body_Scan)
            }
        }
        if questionnerAns[3] != nil{
            if !recommendMed.contains(KEY.MEDITATION._5_Minute_Body_Scan) {
                recommendMeditations.append(meditations[2])
                recommendMed.append(KEY.MEDITATION._5_Minute_Body_Scan)
            }
        }
        if questionnerAns[4] != nil{
            if !recommendMed.contains(KEY.MEDITATION._3_Minute_Breathing_Space) {
                recommendMeditations.append(meditations[3])
                recommendMed.append(KEY.MEDITATION._3_Minute_Breathing_Space)
            }
        }
        if questionnerAns[5] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Simply_Listening_for_Grounding) {
                recommendMeditations.append(meditations[4])
                recommendMed.append(KEY.MEDITATION.Simply_Listening_for_Grounding)
            }
        }
        if questionnerAns[6] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Sitting_Meditation) {
                recommendMeditations.append(meditations[5])
                recommendMed.append(KEY.MEDITATION.Sitting_Meditation)
            }
        }
        if questionnerAns[7] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Sleep_Meditation) {
                recommendMeditations.append(meditations[6])
                recommendMed.append(KEY.MEDITATION.Sleep_Meditation)
            }
        }
        if questionnerAns[8] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Walking_Meditation) {
                recommendMeditations.append(meditations[7])
                recommendMed.append(KEY.MEDITATION.Walking_Meditation)
            }
        }
        if questionnerAns[9] != nil{
            if !recommendMed.contains(KEY.MEDITATION.Mindful_Movement) {
                recommendMeditations.append(meditations[8])
                recommendMed.append(KEY.MEDITATION.Mindful_Movement)
            }
        }
    }
    @IBAction func btnInfoTapped(_ sender: Any)
    {
        arrInfo.removeAll()
        arrImg.removeAll()
        arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.smile)!)
        arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.sick)!)
        arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.hospital)!)
        arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.man)!)
        arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.twoman)!)
        arrInfo =  [KEY.MESSAGE.smilyface, KEY.MESSAGE.sickface, KEY.MESSAGE.sleepingman, KEY.MESSAGE.standingman, KEY.MESSAGE.twoman]
        tblViewInfoHeight.constant = 512
        tblInfo.reloadData()
        viewInfoBackground.isHidden = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if questionnerAns.count != 0 {
            let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
            let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
            let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        }
    }
    fileprivate var currentPage: Int = 0 {
        didSet {
            print("page at centre = \(currentPage)")
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.backgroundColor = .clear
        btnInformation.isHidden = true
        questionnerAns = getQueAnsArr()
        collectionView.backgroundColor = .clear
        NavigationHeaderView.updateView(view: viewNavigation)
        table.reloadData()
        changeBackground(view: self.view)
        collectionView.isHidden = true
        constraintTopAllMeditation.constant = 20
        lblRecommendation.isHidden = true
        setupCarouselView()
        tblInfo.reloadData()
        changeBackground(view: viewInfoMiddle)
        UserDefineBtn.updateView(view: btnOkay)
        viewInfoBackground.isHidden = true
        viewInfoMiddle.layer.cornerRadius = 12
        btnInformation.backgroundColor = returnThemeColor()
        btnInformation.layer.cornerRadius = btnInformation.frame.height/2
        collectionView.reloadData()
    }
    
    
    override func viewWillLayoutSubviews() {
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        moveToNextScreen(iPhoneStoryboad: KEY.STORYBOARD.Authentication, nextVC: KEY.VIEWCONTROLLER.ProfileViewController)
    }
    func configureSongs() {
        meditations.append(Song(name: KEY.MEDITATION.Calming_10_Minute_Breathing_Meditation, id: 1,
                                albumName: "Duration: " + "11:05",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.northen_lights,
                                trackName: KEY.URL.calming_10))
        meditationName.append(KEY.MEDITATION.Calming_10_Minute_Breathing_Meditation)
        meditations.append(Song(name: KEY.MEDITATION._10_Minute_Body_Scan, id: 2,
                                albumName: "Duration: " + "11:01",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.dubai,
                                trackName: KEY.URL._10_minute_Body ))
        meditationName.append(KEY.MEDITATION._10_Minute_Body_Scan)
        meditations.append(Song(name: KEY.MEDITATION._5_Minute_Body_Scan, id: 3,
                                albumName: "Duration: " + "6:04",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.flower,
                                trackName: KEY.URL._5_minute_Body ))
        meditationName.append(KEY.MEDITATION._5_Minute_Body_Scan)
        meditations.append(Song(name: KEY.MEDITATION._3_Minute_Breathing_Space, id: 4,
                                albumName: "Duration: " + "2:59",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.passge_river,
                                trackName: KEY.URL._3_Minute_Breath))
        meditationName.append(KEY.MEDITATION._3_Minute_Breathing_Space)
        meditations.append(Song(name: KEY.MEDITATION.Simply_Listening_for_Grounding, id: 5,
                                albumName:"Duration: " + "2:59",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.sunflower,
                                trackName: KEY.URL.simply_listening))
        meditationName.append(KEY.MEDITATION.Simply_Listening_for_Grounding)
        meditations.append(Song(name: KEY.MEDITATION.Sitting_Meditation, id: 6,
                                albumName: "Duration: " + "10:32",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.waterfall,
                                trackName: KEY.URL.sitting_med))
        meditationName.append(KEY.MEDITATION.Sitting_Meditation)
        meditations.append(Song(name: KEY.MEDITATION.Sleep_Meditation, id: 7,
                                albumName: "Duration: " + "9:54",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.alberta,
                                trackName: KEY.URL.sleep_med))
        meditationName.append(KEY.MEDITATION.Sleep_Meditation)
        meditations.append(Song(name:  KEY.MEDITATION.Walking_Meditation, id: 8,
                                albumName: "Duration: " + "4:45",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.tree_cloud,
                                trackName: KEY.URL.walking_med ))
        meditationName.append(KEY.MEDITATION.Walking_Meditation)
        meditations.append(Song(name: KEY.MEDITATION.Mindful_Movement, id: 9,
                                albumName: "Duration: " + "15:34",
                                artistName: KEY.SPACE.space,
                                imageName: KEY.MED_IMAGE.beach_chair,
                                trackName: KEY.URL.mindful))
        meditationName.append(KEY.MEDITATION.Mindful_Movement)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblInfo {
            return arrInfo.count
        } else {
            if section == 0 {
                return meditations.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblInfo {
            let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.InformationViewTableViewCell) as! InformationViewTableViewCell
            cell.imgInfoIcon.image = arrImg[indexPath.row]
            cell.selectionStyle = .none
            cell.imgInfoIcon.tintColor = returnThemeColor()
            cell.lblInfo.attributedText = NSAttributedString(string:arrInfo[indexPath.row])
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.cell, for: indexPath)
                let song = meditations[indexPath.row]
                // configure
                if UIDevice().type.rawValue == "iPhone 7" || UIDevice().type.rawValue == "iPhone 8" || UIDevice().type.rawValue == "iPhone 8 Plus" || UIDevice().type.rawValue == "iPhone 7 Plus" || UIDevice().type.rawValue == "iPhone SE (2nd generation)"  ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6" ||  UIDevice().type.rawValue == "iPhone 6S" ||  UIDevice().type.rawValue == "iPhone 6S Plus"{
                    cell.textLabel?.font = UIFont(name: KEY.FONT.HELVETICALBOLD, size: 14)
                    cell.detailTextLabel?.font = UIFont(name: KEY.FONT.HELVETICA, size: 15)
                } else {
                    cell.textLabel?.font = UIFont(name: KEY.FONT.HELVETICALBOLD, size: 18)
                    cell.detailTextLabel?.font = UIFont(name: KEY.FONT.HELVETICA, size: 17)
                }
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = song.name
                cell.detailTextLabel?.text = song.albumName
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(named: song.imageName)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: KEY.CELL.MoreInformationTableViewCell) as! MoreInformationTableViewCell
                cell.btnMoreInformation.tag = indexPath.row
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                cell.imageThubnail.isUserInteractionEnabled = true
                cell.imageThubnail.addGestureRecognizer(tapGestureRecognizer)
                cell.btnMoreInformation.addTarget(self, action: #selector(btnMoreInformationTapped(_:)), for: .touchUpInside)
                return cell
            }
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playVideo()
    }
    
    @objc func btnMoreInformationTapped(_ sender: UIButton) {
        playVideo()
    }
    
    func playVideo() {
        let video = AVPlayer(url: URL(string: KEY.URL._478_Breathing_Exercise)!)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        present(videoPlayer, animated: true) {
            video.play()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == table {
            if indexPath.section == 0{
                return 100
            }
            return 183
        }
        return 180
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == table {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == table {
            if indexPath.section == 0{
                tableView.deselectRow(at: indexPath, animated: true)
                
                let position = indexPath.row
                if NetworkReachabilityManager()!.isReachable {
                    guard let vc = storyboard?.instantiateViewController(identifier: KEY.VIEWCONTROLLER.PlayerViewController) as? PlayerViewController else {
                        return
                    }
                    vc.modalPresentationStyle = .fullScreen
                    SVProgressHUD.show()
                    vc.songs = meditations
                    vc.position = position
                    meditationInfo.startTime = Int(Date().timeIntervalSince1970)
                    meditationInfo.meditationId = meditations[indexPath.row].id
                    meditationInfo.meditationTitle = meditations[indexPath.row].name
                    present(vc, animated: true)
                } else {
                    showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
                }
            }
        }
    }
}

extension MindFullnessViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendMeditations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let song = recommendMeditations[indexPath.row]
        cell.img.image = UIImage(named: song.imageName)
        cell.img.layer.cornerRadius = 13
        cell.img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.clipsToBounds = true
        cell.img.clipsToBounds = true
        cell.img.contentMode = .scaleToFill
        cell.meditationName.text = song.name
        cell.btnInfo.layer.cornerRadius = cell.btnInfo.frame.height/2
        cell.btnInfo.backgroundColor = returnThemeColor()
        cell.btnInfo.tag = indexPath.row
        cell.btnInfo.addTarget(self, action: #selector(btnSpecificInformationTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnSpecificInformationTapped(_ sender: UIButton) {
        if recommendMeditations[sender.tag].name == KEY.MEDITATION.Calming_10_Minute_Breathing_Meditation {
            fillResourceData(Ids: questionnerAns[1]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION._10_Minute_Body_Scan {
            fillResourceData(Ids: questionnerAns[2]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION._5_Minute_Body_Scan {
            fillResourceData(Ids: questionnerAns[3]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION._3_Minute_Breathing_Space {
            fillResourceData(Ids: questionnerAns[4]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION.Simply_Listening_for_Grounding {
            fillResourceData(Ids: questionnerAns[5]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION.Sitting_Meditation {
            fillResourceData(Ids: questionnerAns[6]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION.Sleep_Meditation {
            fillResourceData(Ids: questionnerAns[7]!)
        } else if recommendMeditations[sender.tag].name == KEY.MEDITATION.Walking_Meditation {
            fillResourceData(Ids: questionnerAns[8]!)
        }
        else if recommendMeditations[sender.tag].name == KEY.MEDITATION.Mindful_Movement {
            fillResourceData(Ids: questionnerAns[9]!)
        }
        tblInfo.reloadData()
        viewInfoBackground.isHidden = false
        tblViewInfoHeight.constant = tblInfo.contentSize.height
    }
    
    func fillResourceData(Ids: [Int]){
        arrImg.removeAll()
        arrInfo.removeAll()
        for id in Ids {
            if id == 1 {
                arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.smile)!)
                arrInfo.append(KEY.MESSAGE.smilyface)
            }
            if id == 2 {
                arrImg.append(UIImage(named:KEY.MOOD_REACTIONI_MG.sick)!)
                arrInfo.append(KEY.MESSAGE.sickface)
            }
            if id == 3{
                arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.hospital)!)
                arrInfo.append(KEY.MESSAGE.sleepingman)
            }
            if id == 4 {
                arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.man)!)
                arrInfo.append(KEY.MESSAGE.standingman)
            }
            if id == 5 {
                arrImg.append(UIImage(named: KEY.MOOD_REACTIONI_MG.twoman)!)
                arrInfo.append(KEY.MESSAGE.twoman)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if NetworkReachabilityManager()!.isReachable {
            SVProgressHUD.show()
            let position = indexPath.row
            guard let vc = storyboard?.instantiateViewController(identifier: KEY.VIEWCONTROLLER.PlayerViewController) as? PlayerViewController else {
                return
            }
            vc.songs = recommendMeditations
            vc.position = position
            vc.modalPresentationStyle = .fullScreen
            meditationInfo.startTime = Int(Date().timeIntervalSince1970)
            meditationInfo.meditationId = meditations[indexPath.row].id
            meditationInfo.meditationTitle = meditations[indexPath.row].name
            present(vc, animated: true)
        } else {
            showAlert(title: KEY.APPNAME.CollaborativeCare, message: KEY.MESSAGE.internet_reachability)
        }
    }
}


struct Song{
    let name: String
    let id : Int
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

struct ModelCollectionFlowLayout {
    var title:String = KEY.SPACE.space
    var image:UIImage!
}

