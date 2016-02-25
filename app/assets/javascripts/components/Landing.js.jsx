class Landing extends React.Component{
  constructor(props){
    super(props);
  }
  render() {
    return(
      <div>
        <div className='landing-header valign-wrapper'>
          <div className='valign full-width'>
            <p id='landing-welcome' className='landing-welcome center-align'>Welcome to Apollo</p>
            <div className='yellow-hr' style={{width: '45%'}}></div>
            <p className='landing-tagline center-align'>Your workplace music solution</p>
          </div>
        </div>
        <div className='row'>
          <div className='col s12 m8'>
            <div className='panel'>
              <div className='panel-head'>
                <h3>What is Apollo?</h3>
              </div>
              <div className='panel-body copy'>
                <p>Apollo is made for those who listen to music together. It is the digital age's answer to the jukebox. If you listen to music at work, school, home, or anywhere in-between: Apollo is where you and those around you can decide what's playing.</p>
                <p>Apollo is free to use, and only requires a Spotify account from one of the people playing together.</p>
                <p>No more sharing the aux cord.</p>
                <p>No more copy/pasting links.</p>
                <p>No more collaborative playlist settings.</p>
                <b className='apollo-pink'>Just music.</b>
              </div>
            </div>
            <div className='panel'>
              <div className='panel-head'>
                <h3>How Does Apollo Work?</h3>
              </div>
              <div className='panel-body copy'>
                <p>Apollo lets everyone play DJ. Getting apollo up and running is easy:</p>
                <dl>
                  <dt><b className='apollo-pink'>1. Sign Up</b></dt>
                  <dd>Somebody needs to set up an account. Apollo only needs one user work in your space. Go to "Sign Up", enter your information, and allow Apollo access to your Spotify account. More users = More options.</dd>
                  <dt><b className='apollo-pink'>2. Get a Room</b></dt>
                  <dd>Now that you have an account. Go to "Rooms" and choose a room, or make a new one if you don't have any yet.</dd>
                  <dt><b className='apollo-pink'>3. Pick a Playlist</b></dt>
                  <dd>Once inside a room, choose a playlist that you own (Apollo won't work with a playlist that you can't modify) <br /> -OR- <br />Type in a name under "Create a Playlist" to start from scratch.</dd>
                  <dt><b className='apollo-pink'>4. Add Your Favorite Songs</b></dt>
                  <dd>Now that your room has a playlist, anybody can add songs. All that they'll need to do is to visit Apollo and enter your room name to join.</dd>
                  <dt><b className='apollo-pink'>5. Press Play</b></dt>
                  <dd>At any time, clicking the play button on the Spotify playlist shown in the room will launch Spotify on your computer and begin playing that playlist from your room.</dd>
                </dl>
              </div>
            </div>
            <div className='panel'>
              <div className='panel-head'>
                <h3>Who Can Do What?</h3>
              </div>
              <div className='panel-body copy'>
                <p>There are three ways for a user to interact with a Room in Apollo:</p>
                <dl>
                  <dt><b className='apollo-pink'>Room Owner:</b></dt>
                  <dd>If you are the person who set up the room in question, you always have the ability to remove the playlist from the room, no matter who put it there. As the room owner, you always have the ability to remove songs from the list as well.</dd>
                  <dt><b className='apollo-pink'>Playlist Owner:</b></dt>
                  <dd>If you have signed up for an account with Apollo, you can add a playlist to any room that does not currently have a playlist. If a room is playing your playlist, you can remove it from said room at any time. As a playlist owner, you also have the ability to remove songs from your playlists, no matter where they're playing.</dd>
                  <dt><b className='apollo-pink'>Room Guest:</b></dt>
                  <dd>Whether you have an account with Apollo or not, you can always enter a room that currently has a playlist. Once in a room, you can add songs to the current playlist, but you cannot remove them. Only the Room Owner & Playlist Owner can do that.</dd>
                </dl>
              </div>
            </div>
          </div>
          <div className='col s12 m4'>
            <FindRoom here='/'/>
          </div>
        </div>
      </div>
    )
  }
}
