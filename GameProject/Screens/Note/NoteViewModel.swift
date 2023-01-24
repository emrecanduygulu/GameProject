//
//  NoteViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//

import UIKit

class NoteViewModel {
    
    let detailModel: DetailModel
    var note: String?
    var output: NoteViewModelOutput?
    
    private func getNote() {
        let game = Current.coreDataManager.getGame(slug: detailModel.slug ?? "")
        let note = game?.note
        self.note = note
        output?.showExistingNote(note: note)
    }
    
    private func addOrUpdateNote(newNote: String) {
        if let game = Current.coreDataManager.getGame(slug: detailModel.slug ?? "") {
            game.note = newNote
            game.isNoted = true
            self.note = newNote
            Current.coreDataManager.updateGame(slug: game.slug, newVersion: game)
        } else {
            let game = GameInterface(
                backgroundImage: detailModel.backgroundImage ?? "",
                descriptionRaw: detailModel.descriptionRaw ?? "",
                genre: detailModel.genres.first?.name ?? "",
                slug: detailModel.slug ?? "no-name",
                isFavorited: false,
                isNoted: true,
                metacritic: Int64(detailModel.metacritic ?? 0),
                name: detailModel.name ?? "No Name",
                note: newNote
            )
            self.note = newNote
            Current.coreDataManager.saveGame(game: game)
        }
    }
    
    private func deleteNote() {
        guard let game = Current.coreDataManager.getGame(slug: detailModel.slug ?? "") else { return }
        game.note = ""
        game.isNoted = false
        self.note = ""
        Current.coreDataManager.updateGame(slug: game.slug, newVersion: game)
    }
    
    init(detailModel: DetailModel) {
        self.detailModel = detailModel
    }
}

extension NoteViewModel: NoteViewModelInput {
    func onViewDidLoad() {
        getNote()
    }
    
    func delete() {
        deleteNote()
    }
    
    func save(value: String) {
        addOrUpdateNote(newNote: value)
    }
}

protocol NoteViewModelInput {
    func onViewDidLoad()
    func delete()
    func save(value: String)
}

protocol NoteViewModelOutput {
    func showExistingNote(note: String?)
}
