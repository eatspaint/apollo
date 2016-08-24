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

  private

  def fyf_lineup
    @lineup = [
                {name: "Kendrick Lamar", rspot_id: "2YZyLoL8N0Wb9xBt1NhZWg"},
                   {name: "Tame Impala", rspot_id: "5INjqkS1o8h1imAzPqGZBb"},
                        {name: "Grimes", rspot_id: "053q0ukIDRgzwTr4vNSwab"},
                      {name: "Hot Chip", rspot_id: "37uLId6Z5ZXCx19vuruvv5"},
         {name: "Explosions In The Sky", rspot_id: "1uQWmt1OhuHGRKmZ2ZcL6p"},
                     {name: "Hop Along", rspot_id: "3yYUV3hkJit05YIUEODqgp"},
         {name: "Oneohtrix Point Never", rspot_id: "2wPDbhaGXCqROrVmwDdCrK"},
                {name: "Museum Of Love", rspot_id: "2nIzOTNOvPxPlgzB4GQHPc"},
                   {name: "Gerd Janson", rspot_id: "4jLpm91Tyk2TRgv43bMfZO"},
                      {name: "Kamaiyah", rspot_id: "3XVpDdKav6C6zwlDXPhMEO"},
               {name: "LCD Soundsystem", rspot_id: "066X20Nz7iquqkkCW6Jxy6"},
                   {name: "Grace Jones", rspot_id: "2f9ZiYA2ic1r1voObUimdd"},
                   {name: "Beach House", rspot_id: "56ZTgzPBDge0OvCGgMO3OY"},
             {name: "Father John Misty", rspot_id: "2kGBy2WHvF0VdZyqiVCkDT"},
                        {name: "ANOHNI", rspot_id: "6VJZYivuYJGCrPuOAnI7Qo"},
                  {name: "Rae Sremmurd", rspot_id: "7iZtZyCzp3LItcw1wtPI3D"},
                    {name: "Young Thug", rspot_id: "50co4Is1HCEo8bhOyUWKpn"},
                 {name: "Saves The Day", rspot_id: "5gWhlJBlLQGLOgYWO8lwCU"},
                    {name: "Gold Panda", rspot_id: "6xS3zemJD9h94iueQvGqVk"},
                {name: "Preoccupations", rspot_id: "2bs3QE2ZMBjmb0QTqAjCj3"},
                  {name: "Julia Holter", rspot_id: "0bsV0sUjnCuCTYOnNHQl3E"},
                  {name: "Denzel Curry", rspot_id: "6fxyWrfmjcbj5d12gXeiNV"},
               {name: "Head Wound City", rspot_id: "5reIljEt4WbrjlIhyQB8GE"},
                    {name: "Andy Stott", rspot_id: "6BuDxEE5rfuYeyhxQsl53K"},
                  {name: "Julien Baker", rspot_id: "12zbUHbPHL5DGuJtiUfsip"},
             {name: "The Black Madonna", rspot_id: "2nNEvsyPzLwKVZrfkwLpNK"},
                           {name: "Air", rspot_id: "1P6U1dCeHxPui5pIrGmndZ"},
                          {name: "Moby", rspot_id: "33lBD3LO109JfRCYElo5CZ"},
                   {name: "Wolf Parade", rspot_id: "0XSqX2PB3C5dTMv7SZaxSm"},
                       {name: "Shellac", rspot_id: "6I8R5MFTlez7rHCsH4cx0u"},
       {name: "Todd Terje & The Olsens", rspot_id: "6JClxoCdn17qYJRwYDWDqq"},
                   {name: "Junior Boys", rspot_id: "39x9e2QDpAxK8xTuJDwRqR"},
                     {name: "Jagwar Ma", rspot_id: "6fEO1r9Y9TYL9O4w5kVPmc"},
          {name: "Peter Bjorn and John", rspot_id: "6u11Qbko2N2hP4lTBYjX86"},
                          {name: "DIIV", rspot_id: "4OrizGCKhOrW6iDDJHN9xd"},
                        {name: "Kelela", rspot_id: "1U0sIzpRtDkvu1hXXzxh60"},
               {name: "Floating Points", rspot_id: "2AR42Ur9PcchQDtEdwkv4L"},
                        {name: "Boogie", rspot_id: "5kmiEbZOlRRsPrkJmA1aI7"},
                        {name: "Alex G", rspot_id: "2WWTUZ3LpcAAPhSEz3H0rg"},
                  {name: "Blood Orange", rspot_id: "6LEeAFiJF8OuPx747e1wxR"},
    {name: "Uncle Acid & The Deadbeats", rspot_id: "16PcI6JjJuUfPlsX8Ffvfl"},
                    {name: "Black Lips", rspot_id: "35C0NSLogAwImm8HAMqEmG"},
                 {name: "Chelsea Wolfe", rspot_id: "6ZK2nrW8aCTg8Bid7I7N10"},
                         {name: "Bicep", rspot_id: "73A3bLnfnz5BoQjb4gNCga"},
                  {name: "Wild Nothing", rspot_id: "6NrkINd80slV25wkBu9mEB"},
                        {name: "Corbin", rspot_id: "3K40SMapVhc8PxyYFofHff"},
                     {name: "Ty Segall", rspot_id: "58XGUNsRNu3cVOIOYk5chx"},
               {name: "Charles Bradley", rspot_id: "462T0buQ5ScBUQCRpodDRf"},
                 {name: "Vince Staples", rspot_id: "68kEuyFKyqrdQQLLsmiatm"}
               ].sort_by { |h| h[:name] }
  end
end
