//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/1/20.
//

import Cleanse
import Core

public extension GetListPresenter {
    
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGamesRepository<GetGamesLocalDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>.Module.self)
            binder.include(module: GetFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>.Module.self)
            binder.include(module: UpdateFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>.Module.self)
            
            binder.bind(FavoriteGamesPresenter.self).to { (favoriteGamesRepository: Provider<GetFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>) -> FavoriteGamesPresenter in
                return FavoriteGamesPresenter(useCase: FavoriteGamesInteractor(repository: favoriteGamesRepository.get()))
            }
            
            binder.bind(UpdateFavoriteGamesPresenter.self).to { (updateFavoriteGamesRepository: Provider<UpdateFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>) -> UpdateFavoriteGamesPresenter in
                return UpdateFavoriteGamesPresenter(useCase: UpdateFavoriteGamesInteractor(repository: updateFavoriteGamesRepository.get()))
            }
            
            binder.bind(GamesPresenter.self).to { (gamesRepository: Provider<GetGamesRepository<GetGamesLocalDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>) -> GamesPresenter in
                return GamesPresenter(useCase: GamesInteractor(repository: gamesRepository.get()))
            }
        }
    }
}

public extension GetPresenter {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGameRepository<GetGameLocalDataSource, GetGameRemoteDataSource, GameTransformer>.Module.self)
            binder.bindFactory(GamePresenter.self).with(GamePresenter.AssistedSeed.self).to { (gameRepository: Provider<GetGameRepository<GetGameLocalDataSource, GetGameRemoteDataSource, GameTransformer>>, seed: Assisted<GameModel>) -> GamePresenter in
                return GamePresenter(useCase: GameInteractor(repository: gameRepository.get()), request: seed.get().id)
            }
        }
    }
}
