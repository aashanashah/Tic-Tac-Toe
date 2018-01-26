import Foundation
import AVFoundation

class MyAudioPlayer: NSObject, AVAudioPlayerDelegate {
    private static let sharedPlayer: MyAudioPlayer =
    {
        return MyAudioPlayer()
    }()
    private var container = [String : AVAudioPlayer]()
    var player: AVAudioPlayer?
    
    static func playFile(name: String, type: String)
    {
        let key = name+type
        for (file, thePlayer) in sharedPlayer.container
        {
            if file == key
            {
                sharedPlayer.player = thePlayer
                break
            }
        }
        if sharedPlayer.player == nil, let resource = Bundle.main.path(forResource: name, ofType:type)
        {
            do
            {
                sharedPlayer.player = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: resource) as URL, fileTypeHint: AVFileType.mp3.rawValue)
            } catch
            {
               // error
            }
         }
        if let thePlayer = sharedPlayer.player
        {
            if thePlayer.isPlaying
            {
              // already playing
            }
            else
            {
                thePlayer.delegate = sharedPlayer
                sharedPlayer.container[key] = thePlayer
                thePlayer.numberOfLoops = -1
                thePlayer.play()
            }
        }
     }
    static func mute()
    {
        sharedPlayer.player?.volume = 0.0;
    }
    static func unmute()
    {
        sharedPlayer.player?.volume = 1.0;
    }
}
