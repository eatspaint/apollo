class RoomContainer extends React.Component{
  constructor(props){
    super(props);
    this.state = { room: this.props.room, playlists: this.props.playlists, hasPlaylist: false };
  }
  playlistClick(playlistId){
    let id = playlistId
    $.ajax({
      url: '/playlist',
      type: 'GET',
      data: { user: this.props.user.id, playlist: id }
    }).success( data => {
      this.setState({ playlist: data, hasPlaylist: true});
    });
  }
  content(){
    if( !this.state.hasPlaylist ){
      let playlists = this.state.playlists.map( playlist => {
        let key = `playlist-${playlist.id}`;
        return(
          <li key={key} onClick={this.playlistClick.bind(this, playlist.id)}>
            { playlist.name }
          </li>)
      });
      return(
        <div>
          <p>Please add a playlist or create a new one!</p>
          <ul>{ playlists }</ul>
        </div>
      )
    } else {
      let tracks = this.state.playlist.tracks_cache.map( track => {
        let key = `track-${track.id}`;
        return(
          <li key={key}>
            { track.name } - { track.artists[0].name }
          </li>
        )
      })
      let player = "https://embed.spotify.com/?uri=" + this.state.playlist.uri;
      return(
        <div>
          <p>Now Playing: {this.state.playlist.name}</p>
          <iframe src={ player } width="300" height="80" frameBorder="0" allowTransparency="true"></iframe>
          <ul>{ tracks }</ul>
        </div>
      )
    }
  }
  render(){
    return(
      <div className='center'>
        <h3>{ this.state.room.name }</h3>
        { this.content() }
      </div>
    );
  }
}
