//
//  main.swift
//  sampa
//
//  Created by Brian Jordan on 2/8/21.
//

import Foundation
import AppKit

let loop = RunLoop.current
let synth = NSSpeechSynthesizer()
synth.setVoice(NSSpeechSynthesizer.VoiceName.init(rawValue: "com.apple.speech.synthesis.voice.samantha.premium"))
synth.rate=190
synth.volume=0.2

print("Loading your AI personal assistant Samantha")
greet()
print("I am your AI personal assistant Samantha")
speak(text: "I am your AI personal assistant Samantha")
print("How may I help you?")
speak(text: "How may I help you?")

acceptCommand()

func acceptCommand() {
    let r = NSSpeechRecognizer()
    r?.startListening()
    print("Listening...")
    r?.commands = ["goodbye", "ok bye", "stop", "help goodbye", "help ok bye", "help stop", "wikipedia", "help Wikipedia", "youtube", "help youtube", "google", "help google", "gmail", "mail", "help gmail", "weather", "help weather", "time", "what is the time", "what time is it", "help time", "help what is the time", "help what time is it", "who created you", "help who created you", "stackoverflow", "help stackoverflow", "news", "help news", "ask", "help ask", "log off", "shut down", "sign out", "help shut down", "help log off", "help sign off", "what can you do", "help what can you do"]
    r?.listensInForegroundOnly = false
    r?.blocksOtherRecognizers = true
    let dispatcher = Dispatcher()
    r?.delegate = dispatcher
    let mode = loop.currentMode ?? RunLoop.Mode.default
    while loop.run(mode: mode, before: Date(timeIntervalSinceNow: 0.1)) && dispatcher.working {}
}

// uncomment to identify other voices
//for v in NSSpeechSynthesizer.availableVoices {
//    print("\"\(v)\"")
//    let attrs = NSSpeechSynthesizer.attributes(forVoice: v)
//    if case let val? = attrs[NSSpeechSynthesizer.VoiceAttributeKey.name]             {print(" Name:   \(val)")}
//    if case let val? = attrs[NSSpeechSynthesizer.VoiceAttributeKey.localeIdentifier] {print(" Lang:   \(val)")}
//    if case let val? = attrs[NSSpeechSynthesizer.VoiceAttributeKey.gender]           {print(" Gender: \(val)")}
//    if case let val? = attrs[NSSpeechSynthesizer.VoiceAttributeKey.age]              {print(" Age:    \(val)")}
//}

func speak(text: String) {
    synth.startSpeaking(text)
    let mode = loop.currentMode ?? RunLoop.Mode.default
    while loop.run(mode: mode, before: Date(timeIntervalSinceNow: 0.1)) && synth.isSpeaking {}
}

func greet() {
    let date = Date()
    let cal = Calendar.current
    let hour = cal.component(.hour, from: date)
    if (hour >= 0 && hour < 12) {
        print("Good morning")
        speak(text: "Good morning")
    }
    else if (hour >= 12 && hour < 18) {
        print("Good afternoon")
        speak(text: "Good afternoon")
    }
    else {
        print("Good evening")
        speak(text: "Good evening")
    }
}

class Dispatcher: NSObject, NSSpeechRecognizerDelegate {
    var working: Bool
    override init () { working = true }
    func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
        print("command: \(command)")
        if (command.starts(with: "help"))
        {
            provideHelp(command: command)
        }
        else {
            provideService(command: command, sender: sender)
        }
    }
    
    func provideHelp(command: String) {
        if (command == "help time" || command == "help what time is it" || command == "help what is the time") {
            print("I will tell you the current time when you say 'time', 'what time is it', or 'what is the time'")
            speak(text: "I will tell you the current time when you say time, what time is it, or what is the time")
        }
        else if (command == "help goodbye" || command == "help ok bye" || command == "help stop") {
            print("I will leave and no longer respond when you say 'goodbye', 'OK bye', or 'stop'")
            speak(text: "I will leave and no longer respond when you say goodbye, OK bye, or stop")
        }
        else if (command == "help Wikipedia") {
            print("I will open Wikipedia in Google Chrome when you say 'Wikipedia'. If you say something after Wikipedia I will search Wikipedia for that.")
            speak(text: "I will open Wikipedia in Google Chrome when you say Wikipedia.  If you say something after Wikipedia I will search Wikipedia for that.")
        }
        else if (command == "help what can you do") {
            print("I will tell you what I can do when you say 'what can you do'.")
            speak(text: "I will tell you what I can do when you say what can you do")
        }
        else if (command == "help stackoverflow") {
            print("I will open StackOverflow in Google Chrome when you say 'Stack Overflow'. If you say something after Stack Overflow I will search Stack Overflow for that.")
            speak(text: "I will open Stack Overflow in Google Chrome when you say Stack Overflow. If you say something after Stack Overflow I will search Stack Overflow for that.")
        }
        else if (command == "help youtube") {
            print("I will open Youtube in Google Chrome when you say 'youtube'.")
            speak(text: "I will open you tube in Google Chrome when you say you tube.")
        }
        else if (command == "help news") {
            print("I will open USA Today in Google Chrome when you say 'news'.")
            speak(text: "I will open USA Today in Google Chrome when you say news.")
        }
        else if (command == "help google") {
            print("I will open Google's Search page in Google Chrome when you say 'Google'. If you say something after Google I will google that for you.")
            speak(text: "I will open Google's Search page in Google Chrome when you say Google.  If you say something after Google I will google that for you.")
        }
        else if (command == "help gmail") {
            print("I will open Gmail in Google Chrome when you say 'gmail' or 'mail'.")
            speak(text: "I will open Gmail in Google Chrome when you say gmail or mail.")
        }
        else if (command == "help weather") {
            print("I will open the Weather Channel in Google Chrome when you say 'weather'.")
            speak(text: "I will open the Weather Channel in Google Chrome when you say weather.")
        }
        else if (command == "help who created you") {
            print("I will tell you who created me when you say who created you, duh!")
            speak(text: "I will tell you who created me when you say who created you, deh")
        }
        else if (command == "help sign off" || command == "help shut down" || command == "help log off") {
            print("I will shut down your computer in 1 minute when you say 'sign off', 'shut down', or 'log off'. Please be sure to close all applications.")
            speak(text: "I will shut down your computer in 1 minute when you say sign off, shut down, or log off. Please be sure to close all applications.")
        }
        else if (command == "help ask") {
            print("I will perform calculations when you say ask. For example, when you say ask and enter 2+2 when prompted I will say 4 and I will say 239_184 when you say ask and when prompted you enter square root of 57_208_985_856.")
            speak(text: "I will perform calculations when you say ask.  For example, when you say ask and enter 2+2 when prompted I will say 4 and I will say 239,184 when you say ask and when prompted you enter square root of 57,208,985,856.")
        }
    }
    
    func provideService(command: String, sender: NSSpeechRecognizer) {
        if (command == "goodbye" || command == "ok bye" || command == "stop") {
            print("I am leaving now sir, bye baby")
            speak(text: "I am leaving now sir, ciao piccola")
            working = false
            sender.stopListening()
        }
        else if (command == "who created you") {
            print("Brian Jordan authored version 1.0 in Februrary 2021")
            speak(text: "Brian Jordan authored version 1 point 0 in February of 2021")
        }
        else if (command == "what can you do") {
            print("I am Samantha version 1.0 your AI personal assistant.  You may call me Sam.  I am programmed for the tasks 'youtube', 'google', 'gmail', 'stackoverflow', 'time', 'wikipedia', 'weather', 'news', and others via the command, 'ask'. For help just say help and one of those commands. In the future, I hope to teach myself new things.")
            speak(text: "I am Samantha version 1 point 0 your AI personal assistant.  You may call me Sam.  I am programmed for the tasks you tube, google, gmail, stackoverflow, time, wikipedia, weather, news, and others via the command, ask. For help just say help and one of those commands. In the future, I hope to teach myself new things.")
        }
        else if (command == "stackoverflow") {
            // todo open stackoverflow in chrome
            speak(text: "Stack Overflow opened.")
        }
        else if (command == "news") {
            // todo open USA today in chrome
            speak(text: "USA Today opened.")
        }
        else if (command == "google") {
            // todo open google search in chrome
            speak(text: "Google search opened.")
        }
        else if (command == "wikipedia") {
            // todo open wikipedia in chrome
            speak(text: "Wikipedia opened.")
        }
        else if (command == "gmail" || command == "mail") {
            // todo open gmail in chrome
            speak(text: "Gmail opened.")
        }
        else if (command == "weather") {
            // todo open greenville weather at weather.com in chrome
            speak(text: "Greenville weather forecast displayed.")
        }
        else if (command == "youtube") {
            // todo open youtube in chrome
            speak(text: "Youtube opened.")
        }
        else if (command == "time" || (command.contains("what") && command.contains("time"))) {
            let date = Date()
            let cal = Calendar.current
            var hour = cal.component(.hour, from: date)
            if (hour > 12) {
                hour = hour - 12;
            }
            let minute = cal.component(.minute, from: date)
            var prefixMinute = ""
            var pmin = ""
            if (minute > 0 && minute < 10) {
                prefixMinute = "oh"
                pmin = String(format: "%02d", minute)
            }
            else {
                pmin = String(minute)
            }
            var min = ""
            if (minute == 0) {
                min = "oh clock"
                pmin = "00"
            }
            else {
                min = String(minute)
            }
            
            print("\(hour):\(pmin) \(cal.component(.hour, from: date) >= 12 ? cal.pmSymbol : cal.amSymbol)")
            speak(text: "The current time is \(hour) \(prefixMinute) \(min) \(cal.component(.hour, from: date) >= 12 ? cal.pmSymbol : cal.amSymbol)")
        }
        else if (command.contains("ask")) {
            print("Enter the math problem")
            speak(text: "Hit me with the math yo")
            sender.stopListening()
            var result = 0;
            // todo read the math problem from std in
            // convert to variables
            // calculate results
            result = result + 42
            print("The answer is \(result)")
            speak(text: "The answer is \(result)")
            sender.startListening()
        }
        else if (command == "shut down" || command == "log off" || command == "sign off") {
            // shut down the computer in 1 minte
            speak(text: "Shutting down your computer in 1 minute. Please be sure to close all applications.")
        }
    }
}
