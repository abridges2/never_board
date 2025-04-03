OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Address.destroy_all
User.destroy_all
Province.destroy_all

puts "Seeding provinces"
Province.create!([
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: "Ontario", gst: 0.0, pst: 0.0, hst: 0.13 },
  { name: "Alberta", gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.0 }
])

puts "Seeding Categories"
strategy = Category.create!(name: "Strategy")
family = Category.create!(name: "Family")
card_game = Category.create!(name: "Card Game")
role_playing_game = Category.create!(name: "Role-Playing Game")

# price_cents is an integer value and will be changed to float values later on by dividing by 100.
puts "Seeding Products"
Product.create!([
  {
    title: "Monopoly",
    description: "Classic property trading game.",
    price_cents: 2999,
    category: family,
    image_url: "monopoly_example"
  },
  {
    title: "Risk",
    description: "Risk is a strategy board game of diplomacy, conflict and conquest for two to six players.",
    price_cents: 2999,
    category: strategy,
    image_url: "risk_example"
  },
  {
    title: "Gloomhaven",
    description: "A campaign-based dungeon crawler with tactical combat and legacy-style progression.",
    price_cents: 13999,
    category: role_playing_game,
    image_url: "gloomhaven_example"
  },
  {
    title: "Wingspan",
    description: "A beautiful engine-building game where players attract birds to their nature preserve.",
    price_cents: 5999,
    category: family,
    image_url: "wingspan_example"
  },
  {
    title: "Catan",
    description: "Collect and trade resources to build roads, settlements, and cities to earn victory points.",
    price_cents: 4999,
    category: strategy,
    image_url: "catan_example"
  },
  {
    title: "Terraforming Mars",
    description: "Players compete to develop Mars by playing unique project cards and managing resources.",
    price_cents: 6999,
    category: strategy,
    image_url: "terraforming_mars_example"
  },
  {
    title: "Uno",
    description: "A fast-paced card game where players race to empty their hand by matching cards by color or number. Shout UNO! before your last card!",
    price_cents: 999,
    category: card_game,
    image_url: "uno_example"
  },
  {
    title: "Dungeons & Dragons Starter Set",
    description: "An introductory RPG kit with everything you need to begin playing Dungeons & Dragons.",
    price_cents: 1999,
    category: role_playing_game,
    image_url: "dnd_starter_set_example"
  },
  {
    title: "Cards Against Humanity",
    description: "The game is simple. Each round, one player asks a question with a black card," \
    "and everyone else answers with their funniest white card." \
    "The player with the most black cards by the end of the game is the winner.",
    price_cents: 4000,
    category: card_game,
    image_url: "cards_against_humanity_example"
  },
  {
    title: "Trouble",
    description: "Race to get your game piece around the board; be careful! A player could get bumped and sent back to the beginning!",
    price_cents: 2499,
    category: family,
    image_url: "trouble_example"
  }
])
