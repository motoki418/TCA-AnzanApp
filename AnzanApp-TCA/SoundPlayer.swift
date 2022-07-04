//
//  SoundPlayer.swift
//  AnzanApp-TCA
//
//  Created by nakamura motoki on 2022/06/30.
//
import UIKit
import AVFoundation

class SoundPlayer: NSObject {

    private let correctSoundData = NSDataAsset(name: "correct")!.data

    private let incorrectSoundData = NSDataAsset(name: "incorrect")!.data

    private let resultAnnouncementSoundData = NSDataAsset(name: "resultAnnouncement")!.data

    private var correctSoundPlayer: AVAudioPlayer!

    private var incorrectSoundPlayer: AVAudioPlayer!

    private var resultAnnouncementSoundPlayer: AVAudioPlayer!

    func correctSoundPlay() {
        do {
            self.correctSoundPlayer = try AVAudioPlayer(data: correctSoundData)
            self.correctSoundPlayer.play()
        } catch {
            print("正解の音で、エラーが発生しました！")
        }
    }

    func incorrectSoundPlay() {
        do {
            self.incorrectSoundPlayer = try AVAudioPlayer(data: incorrectSoundData)
            self.incorrectSoundPlayer.play()
        } catch {
            print("不正解の音でエラーが発生しました！")
        }
    }

    func resultAnnouncementSoundPlay() {
        do {
            self.resultAnnouncementSoundPlayer = try AVAudioPlayer(
                data: resultAnnouncementSoundData)
            self.resultAnnouncementSoundPlayer.play()
        } catch {
            print("結果発表の音でエラーが発生しました！")
        }
    }
}
