import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - Storyboard

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    // MARK: - Music

    private let tracks = TrackLibrary.tracks
    private var currentTrackIndex = 0
    private var audioPlayer: AVAudioPlayer?
    private var progressTimer: Timer?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        updateTrackInfo()
        updatePlayPauseButton()
    }

    deinit {
        progressTimer?.invalidate()
    }

    // MARK: - Appearance

    private func setupAppearance() {
        view.backgroundColor = UIColor(
            red: 16 / 255,
            green: 16 / 255,
            blue: 24 / 255,
            alpha: 1
        )

        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 20

        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2

        artistLabel.textColor = .lightGray
        artistLabel.font = .systemFont(ofSize: 16)
        artistLabel.textAlignment = .center

        playPauseButton.tintColor = .white
        playPauseButton.backgroundColor = .systemBlue
        playPauseButton.layer.cornerRadius = 28

        playPauseButton.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 24, weight: .bold),
            forImageIn: .normal
        )
    }

    // MARK: - Track Information

    private func updateTrackInfo() {
        guard !tracks.isEmpty else {
            titleLabel.text = "No songs available"
            artistLabel.text = ""
            coverImageView.image = nil
            return
        }

        let track = tracks[currentTrackIndex]

        titleLabel.text = track.title
        artistLabel.text = track.artist
        coverImageView.image = UIImage(named: track.coverImageName)
    }

    private func updatePlayPauseButton() {
        let symbol = audioPlayer?.isPlaying == true
            ? "pause.fill"
            : "play.fill"

        playPauseButton.setImage(
            UIImage(systemName: symbol),
            for: .normal
        )
    }

    // MARK: - Audio

    private func loadTrack() -> Bool {
        guard !tracks.isEmpty else { return false }

        audioPlayer?.stop()
        audioPlayer = nil

        let track = tracks[currentTrackIndex]

        guard let url = Bundle.main.url(
            forResource: track.fileName,
            withExtension: "mp3"
        ) else {
            print("Audio file not found: \(track.fileName).mp3")
            updatePlayPauseButton()
            return false
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            return true
        } catch {
            print("Audio error: \(error.localizedDescription)")
            updatePlayPauseButton()
            return false
        }
    }

    private func playCurrentTrack() {
        if audioPlayer == nil {
            guard loadTrack() else { return }
        }

        audioPlayer?.play()
        updatePlayPauseButton()
    }

    private func changeTrack(by offset: Int) {
        guard !tracks.isEmpty else { return }

        let wasPlaying = audioPlayer?.isPlaying == true

        audioPlayer?.stop()
        audioPlayer = nil

        currentTrackIndex = (
            currentTrackIndex + offset + tracks.count
        ) % tracks.count

        updateTrackInfo()

        if wasPlaying {
            playCurrentTrack()
        } else {
            updatePlayPauseButton()
        }
    }

    // MARK: - Button Actions

    @IBAction func playPauseTapped(_ sender: UIButton) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
        } else {
            playCurrentTrack()
        }

        updatePlayPauseButton()
    }

    @IBAction func previousTapped(_ sender: UIButton) {
        changeTrack(by: -1)
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        changeTrack(by: 1)
    }

    // MARK: - Automatic Next Song

    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ) {
        guard flag, !tracks.isEmpty else {
            updatePlayPauseButton()
            return
        }

        currentTrackIndex = (currentTrackIndex + 1) % tracks.count
        updateTrackInfo()

        if loadTrack() {
            audioPlayer?.play()
        }

        updatePlayPauseButton()
    }
}
