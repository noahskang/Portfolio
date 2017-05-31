require_relative 'Board'
require_relative 'Card'
require_relative 'Memory'
require_relative 'Players'


game = MemoryGame.new()
game.play
# game.play

# p game.board[[0,0]]
# p game.board[[3,3]]
