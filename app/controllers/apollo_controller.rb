class ApolloController < ApplicationController
  def landing
  end

  def about
  end

  def fyf
    fyf_lineup
  end

  def find_top
    tracks = RSpotify::Artist.find(params[:rspot_id]).top_tracks(:us).map { |track| track.id }
    render json: {top_tracks: tracks}
  end

  def save_playlist
    if user = RSpotify::User.new(current_user.rspot)
      name = "Apollo: #{params[:artist][:name]} Top 10"
      playlist = user.create_playlist!(name)
      tracks = params[:tracks].map {|track| RSpotify::Track.find(track)}
      playlist.add_tracks!(tracks)
      msg = "Playlist added to your Spotify account!"
    else
      msg = "Could not find your Spotify account, did you link your account when you signed up?"
    end
    render json: {message: msg}
  end

  def error
    respond_to do |format|
      format.html { render status: 404 }
    end
  rescue ActionController::UnknownFormat
    render status: 404, text: "nope"
  end

  private

  def fyf_lineup
    @lineup = [
      { name: "6LACK", rspot_id: "4IVAbR2w4JJNJDDRFP3E83" },
      { name: "A Tribe Called Quest", rspot_id: "09hVIj6vWgoCDtT03h8ZCa" },
      { name: "Andy Shauf", rspot_id: "5mFKYdmiYwNJTDtSzgFyQx" },
      { name: "Angel Olsen", rspot_id: "6mKqFxGMS5TGDZI3XkT5Rt" },
      { name: "Avalon Emerson", rspot_id: "4yrO1N273PlTaixa4BNwBz" },
      { name: "BadBadNotGood", rspot_id: "65dGLGjkw3UbddUg2GKQoZ" },
      { name: "Beach Fossils", rspot_id: "1bwUhKRmEkOZ1wuTnV9XjC" },
      { name: "Big Thief", rspot_id: "5QdyldG4Fl4TPiOIeMNpBZ" },
      { name: "Björk", rspot_id: "7w29UYBi0qsHi5RTcv3lmA" },
      { name: "Blonde Redhead", rspot_id: "5isqImG0rLfAgBJSPMEVXF" },
      { name: "Cap'n Jazz", rspot_id: "3JhEcBWSCPXkRMt1VK14i4" },
      { name: "Cherry Glazerr", rspot_id: "3pIGm1omCcHIb1juBNHspg" },
      { name: "Daniel Avery", rspot_id: "1EULJuDFWpZ9xg4YwtUGGt" },
      { name: "DJ Harvey", rspot_id: "4LSAINMy65w69vnT4xUq1b" },
      { name: "Erykah Badu", rspot_id: "7IfculRW2WXyzNQ8djX8WX" },
      { name: "Fatima Yamaha", rspot_id: "7eZRt08LoDy0nfIS6OwyMP" },
      { name: "Flying Lotus", rspot_id: "29XOeO6KIWxGthejQqn793" },
      { name: "Frank Ocean", rspot_id: "2h93pZq0e7k5yf4dywlkpM" },
      { name: "Grandaddy", rspot_id: "3W4xM5XYtUp4ifYYPVKVdk" },
      { name: "Hannibal Buress", rspot_id: "4GIqbOr0FgE9qmJ31kVYdD" },
      { name: "Helena Hauff", rspot_id: "1JcefSOP7bcWEluL0iEIaN" },
      { name: "Horse Meat Disco", rspot_id: "5MnToV7aAt2Zy9ag3DAsna" },
      { name: "Hundred Waters", rspot_id: "108ugtkRFQzP9nGgNiyERO" },
      { name: "Iggy Pop", rspot_id: "33EUXrFKGjpUSGacqEHhU4" },
      { name: "Joey Purp", rspot_id: "1ewyVtTZBqFYWIcepopRhp" },
      { name: "John Talabot", rspot_id: "1YvN5uOGQkHVUUlZUcnotD" },
      { name: "Jonathan Richman", rspot_id: "6hkch2KhRl0tywpeVK5xR5" },
      { name: "Julia Jacklin", rspot_id: "12fRkVfO2fUsz1QHgDAG3g" },
      { name: "Kamaiyah", rspot_id: "3XVpDdKav6C6zwlDXPhMEO" },
      { name: "Kehlani", rspot_id: "0cGUm45nv7Z6M6qdXYQGTX" },
      { name: "King Krule", rspot_id: "4wyNyxs74Ux8UIDopNjIai" },
      { name: "Kirk Knight", rspot_id: "1nSpOxq3pcgomrfpXudQuq" },
      { name: "Little Dragon", rspot_id: "6Tyzp9KzpiZ04DABQoedps" },
      { name: "Majid Jordan", rspot_id: "4HzKw8XcD0piJmDrrPRCYk" },
      { name: "MGMT", rspot_id: "0SwO7SWeDHJijQ3XNS7xEE" },
      { name: "Missy Elliott", rspot_id: "2wIVse2owClT7go1WT98tk" },
      { name: "Mitski", rspot_id: "2uYWxilOVlUdk4oV9DvwqK" },
      { name: "Moses Sumney", rspot_id: "5W10uJRsbt9bROJDKoI1Wn" },
      { name: "Motor City Drum Ensemble", rspot_id: "4TlzX7s6kuZDtiBpsopcBf" },
      { name: "Mura Masa", rspot_id: "5Q81rlcTFh3k6DQJXPdsot" },
      { name: "Nadia Rose", rspot_id: "0Nc09HuPN9ELmbTCLyNKnO" },
      { name: "Nicolas Jaar", rspot_id: "5a0etAzO5V26gvlbmHzT9W" },
      { name: "Nine Inch Nails", rspot_id: "0X380XXQSNBYuleKzav5UO" },
      { name: "Noname", rspot_id: "2dTLb3X4Zim5rRpx43E0BK" },
      { name: "Omar S", rspot_id: "3vPTaNyxNLU9CvsjqrPhkN" },
      { name: "Paranoid London", rspot_id: "0KyUH5WmspOhuIQAnw42Fb" },
      { name: "Perfume Genius", rspot_id: "2ueoLVCXQ948OfhVvAy3Nn" },
      { name: "Princess Nokia", rspot_id: "6lay1nwbE6hTx1jivysUAL" },
      { name: "Royal Headache", rspot_id: "01Jsi7Q2a1GdLvNShahaj1" },
      { name: "Run The Jewels", rspot_id: "4RnBFZRiMLRyZy0AzzTg2C" },
      { name: "Seun Kuti & Egypt 80", rspot_id: "6rKUtTPAvqDFvZQYz28WEY" },
      { name: "Sleep", rspot_id: "4Mt6w4tDGiPgV5q6JWPlrI" },
      { name: "Slowdive", rspot_id: "72X6FHxaShda0XeQw3vbeF" },
      { name: "Solange", rspot_id: "2auiVi8sUZo17dLy1HwrTU" },
      { name: "S U R V I V E", rspot_id: "12cKwxUl6Ku3VpSB3LjrM5" },
      { name: "Talaboman", rspot_id: "0w1RQjkLFHpokbFNikYbPN" },
      { name: "Temples", rspot_id: "4ogwGU9VPWrnVBs1GEwZVV" },
      { name: "The Black Madonna", rspot_id: "2nNEvsyPzLwKVZrfkwLpNK" },
      { name: "The Drums", rspot_id: "0p5axeJsbtTCXBrRVoKjwu" },
      { name: "The Faint", rspot_id: "4A1yfFuBmBOgzv4Oe3fFHk" },
      { name: "Thee Oh Sees", rspot_id: "3qYfqdVwX0fil71onLpLkh" },
      { name: "Thundercat", rspot_id: "4frXpPxQQZwbCu3eTGnZEw" },
      { name: "Tiga", rspot_id: "5l9wiTZVfqQTfMDOt0HtwC" },
      { name: "TR/ST", rspot_id: "64NhyHqRKYhV0IZylrElWu" },
      { name: "Ty Segall", rspot_id: "58XGUNsRNu3cVOIOYk5chx" },
      { name: "Whitney", rspot_id: "32aUoW94mJ7xTJI7fG0V1G" },
      { name: "Young Marco", rspot_id: "7zpN81tVvPwlHcJSkSCyRa" }
    ].sort_by { |h| h[:name] }
  end

  # def fyf_lineup #2016 lineup
  #   @lineup = [
  #               {name: "Kendrick Lamar", rspot_id: "2YZyLoL8N0Wb9xBt1NhZWg"},
  #                  {name: "Tame Impala", rspot_id: "5INjqkS1o8h1imAzPqGZBb"},
  #                       {name: "Grimes", rspot_id: "053q0ukIDRgzwTr4vNSwab"},
  #                     {name: "Hot Chip", rspot_id: "37uLId6Z5ZXCx19vuruvv5"},
  #        {name: "Explosions In The Sky", rspot_id: "1uQWmt1OhuHGRKmZ2ZcL6p"},
  #                    {name: "Hop Along", rspot_id: "3yYUV3hkJit05YIUEODqgp"},
  #        {name: "Oneohtrix Point Never", rspot_id: "2wPDbhaGXCqROrVmwDdCrK"},
  #               {name: "Museum Of Love", rspot_id: "2nIzOTNOvPxPlgzB4GQHPc"},
  #                  {name: "Gerd Janson", rspot_id: "4jLpm91Tyk2TRgv43bMfZO"},
  #                     {name: "Kamaiyah", rspot_id: "3XVpDdKav6C6zwlDXPhMEO"},
  #              {name: "LCD Soundsystem", rspot_id: "066X20Nz7iquqkkCW6Jxy6"},
  #                  {name: "Grace Jones", rspot_id: "2f9ZiYA2ic1r1voObUimdd"},
  #                  {name: "Beach House", rspot_id: "56ZTgzPBDge0OvCGgMO3OY"},
  #            {name: "Father John Misty", rspot_id: "2kGBy2WHvF0VdZyqiVCkDT"},
  #                       {name: "ANOHNI", rspot_id: "6VJZYivuYJGCrPuOAnI7Qo"},
  #                 {name: "Rae Sremmurd", rspot_id: "7iZtZyCzp3LItcw1wtPI3D"},
  #                   {name: "Young Thug", rspot_id: "50co4Is1HCEo8bhOyUWKpn"},
  #                {name: "Saves The Day", rspot_id: "5gWhlJBlLQGLOgYWO8lwCU"},
  #                   {name: "Gold Panda", rspot_id: "6xS3zemJD9h94iueQvGqVk"},
  #               {name: "Preoccupations", rspot_id: "2bs3QE2ZMBjmb0QTqAjCj3"},
  #                 {name: "Julia Holter", rspot_id: "0bsV0sUjnCuCTYOnNHQl3E"},
  #                 {name: "Denzel Curry", rspot_id: "6fxyWrfmjcbj5d12gXeiNV"},
  #              {name: "Head Wound City", rspot_id: "5reIljEt4WbrjlIhyQB8GE"},
  #                   {name: "Andy Stott", rspot_id: "6BuDxEE5rfuYeyhxQsl53K"},
  #                 {name: "Julien Baker", rspot_id: "12zbUHbPHL5DGuJtiUfsip"},
  #            {name: "The Black Madonna", rspot_id: "2nNEvsyPzLwKVZrfkwLpNK"},
  #                          {name: "Air", rspot_id: "1P6U1dCeHxPui5pIrGmndZ"},
  #                         {name: "Moby", rspot_id: "33lBD3LO109JfRCYElo5CZ"},
  #                  {name: "Wolf Parade", rspot_id: "0XSqX2PB3C5dTMv7SZaxSm"},
  #                      {name: "Shellac", rspot_id: "6I8R5MFTlez7rHCsH4cx0u"},
  #      {name: "Todd Terje & The Olsens", rspot_id: "6JClxoCdn17qYJRwYDWDqq"},
  #                  {name: "Junior Boys", rspot_id: "39x9e2QDpAxK8xTuJDwRqR"},
  #                    {name: "Jagwar Ma", rspot_id: "6fEO1r9Y9TYL9O4w5kVPmc"},
  #         {name: "Peter Bjorn and John", rspot_id: "6u11Qbko2N2hP4lTBYjX86"},
  #                         {name: "DIIV", rspot_id: "4OrizGCKhOrW6iDDJHN9xd"},
  #                       {name: "Kelela", rspot_id: "1U0sIzpRtDkvu1hXXzxh60"},
  #              {name: "Floating Points", rspot_id: "2AR42Ur9PcchQDtEdwkv4L"},
  #                       {name: "Boogie", rspot_id: "5kmiEbZOlRRsPrkJmA1aI7"},
  #                       {name: "Alex G", rspot_id: "2WWTUZ3LpcAAPhSEz3H0rg"},
  #                 {name: "Blood Orange", rspot_id: "6LEeAFiJF8OuPx747e1wxR"},
  #   {name: "Uncle Acid & The Deadbeats", rspot_id: "16PcI6JjJuUfPlsX8Ffvfl"},
  #                   {name: "Black Lips", rspot_id: "35C0NSLogAwImm8HAMqEmG"},
  #                {name: "Chelsea Wolfe", rspot_id: "6ZK2nrW8aCTg8Bid7I7N10"},
  #                        {name: "Bicep", rspot_id: "73A3bLnfnz5BoQjb4gNCga"},
  #                 {name: "Wild Nothing", rspot_id: "6NrkINd80slV25wkBu9mEB"},
  #                       {name: "Corbin", rspot_id: "3K40SMapVhc8PxyYFofHff"},
  #                    {name: "Ty Segall", rspot_id: "58XGUNsRNu3cVOIOYk5chx"},
  #              {name: "Charles Bradley", rspot_id: "462T0buQ5ScBUQCRpodDRf"},
  #                {name: "Vince Staples", rspot_id: "68kEuyFKyqrdQQLLsmiatm"}
  #              ].sort_by { |h| h[:name] }
  # end
end
