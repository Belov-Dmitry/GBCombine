import UIKit
import Combine
import Foundation

let subjectString = PassthroughSubject<String, Error>()
let subjectUnicode = PassthroughSubject<Character, Error>()

let dwarf: Character = "\u{1F385}" //гномик
let gold: Character = "\u{1F4B0}" //золото
let search: Character = "\u{1F50E}" //искал

let cap: Character = "\u{1FA96}" //колпак
let se: Character = "\u{2717}" //свой
let lost: Character = "\u{1F926}" //потерял1F926

let satDown: Character = "\u{1FA91}" //сел
let cry: Character = "\u{1F62D}" //заплакал
let trouble: Character = "\u{2753}" //как же быть

let arrow: Character = "\u{2794}" //выходи
let go: Character = "\u{1FAF5}" //тебе
let roundDance: Character = "\u{1F973}" //водить

let unicode = [dwarf, gold, search, cap, se, lost, satDown, cry, trouble, arrow, go, roundDance]

let subscription1 = subjectString
    .collect(.byTime(DispatchQueue.main, .seconds(0.5)))
    .sink(receiveCompletion: { print($0) },
          receiveValue: {
        for v in $0.unicodeScalars {
        print(v.value) }
    })

DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
    subjectString.send("Гномик ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
    subjectString.send("золото ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
    subjectString.send("искал ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
    subjectString.send("И колпак ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
    subjectString.send("свой ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
    subjectString.send("потерял! ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
    subjectString.send("Сел, ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
    subjectString.send("заплакал: ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 2.4, execute: {
    subjectString.send("«Как же быть?!» ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
    subjectString.send("Выходи! ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 3.2, execute: {
    subjectString.send("Тебе ")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 3.4, execute: {
    subjectString.send("водить!")
})
DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
    subjectString.send(completion: .finished)
})

let subscription2 = subjectUnicode
    .collect(3)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })

for item in unicode {
DispatchQueue.main.asyncAfter(deadline: .now() + 4.2, execute: {
    subjectUnicode.send(item)
    })
}
DispatchQueue.main.asyncAfter(deadline: .now() + 4.4, execute: {
    subjectUnicode.send(completion: .finished)
})


//--------------простое объединение и группировка массивов---------------------

let verse = ["Гномик ", "золото ", "искал ",
             "И колпак ", "свой ", "потерял! ",
             "Сел, ", "заплакал: ", "«Как же быть?!» ",
             "Выходи! ", "Тебе", "водить!"].publisher

let emoji = ["🎅🏻", "💰", "🔎",
             "🪖", "❌", "🤷🏻‍♂️",
             "🪑", "😭", "⁉️",
             "➡️", "🫵", "🥳"].publisher

verse
    .zip(emoji)
    .collect(3)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
