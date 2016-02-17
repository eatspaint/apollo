class RoomContainer extends React.Component{
  constructor(props){
    super(props);
    if(this.props.playlist){
      this.state = { room: this.props.room, playlists: this.props.playlists, hasPlaylist: this.props.hasPlaylist, playlist: this.props.playlist };
    }else{
      this.state = { room: this.props.room, playlists: this.props.playlists, hasPlaylist: this.props.hasPlaylist };
    }
    this.removePlaylist = this.removePlaylist.bind(this);
    this.playlistClick = this.playlistClick.bind(this);
    this.updateCheck = this.updateCheck.bind(this);
  }
  playlistClick(playlistId){
    let id = playlistId
    $.ajax({
      url: '/playlist',
      type: 'GET',
      data: { user: this.props.user.id, playlist: id, room_id: this.props.room.id }
    }).success( data => {
      if(data.error){
        window.location.href = '/rooms/' + this.props.room.id;
      }else{
        this.setState({ playlist: data, hasPlaylist: true});
      }
    });
  }
  removePlaylist(){
    $.ajax({
      url: '/remove_playlist',
      type: 'DELETE',
      data: { room_id: this.state.room.id }
    }).success( data => {
      this.setState({ playlist: null, hasPlaylist: false})
    })
  }
  addSong(){
    $.ajax({
      url: '/playlist',
      type: 'PUT',
      data: { song_id: this.props.id, room: this.props.room, playlist: this.props.playlist }
    }).success( data => {
      if(data.error){
        window.location.href = '/rooms/' + this.props.room.id;
      } else {
        // window.location.href = '/rooms/' + this.props.room.id;
        this.setState({ playlist: data });
      }
    })
  }
  removeSong(track_id){
    $.ajax({
      url: '/remove_track',
      type: 'PUT',
      data: { track_id: track_id, room: this.props.room, playlist: this.state.playlist }
    }).success( data => {
      this.setState({ playlist: data });
    })
  }
  content(){
    if( !this.state.hasPlaylist ){
      let playlists = this.state.playlists.map( playlist => {
        let key = `playlist-${playlist.id}`;
        return(
          <li key={key} onClick={this.playlistClick.bind(this, playlist.id)}>
            <Playlist imgSize={1} {...playlist} />
          </li>
        )
      });
      return(
        <div className='row'>
          <p>Please add a playlist or create a new one!</p>
          <ul>
            { playlists }
          </ul>
        </div>
      )
    } else {
      let tracks = this.state.playlist.tracks_cache.map( track => {
        let key = `track-${track.id}`;
        if(this.props.guest || (this.props.user.id != this.props.room.user_id)){
          return(
            <li key={key}>
              { track.name } - { track.artists[0].name }
            </li>
          )
        } else {
          return(
            <li key={key}>
              { track.name } - { track.artists[0].name }
              <span className='pointer' onClick={this.removeSong.bind(this, track.id)}>&nbsp;[X]</span>
            </li>
          )
        }
      })
      let player = "https://embed.spotify.com/?uri=" + this.state.playlist.uri;
      return(
        <div>
          <p>Now Playing: {this.state.playlist.name}</p>
          <iframe src={ player } width="300" height="80" frameBorder="0" allowTransparency="true"></iframe>
          <br />
          <a className='pointer' onClick={this.removePlaylist}>Change Playlist</a>
          <ul>{ tracks }</ul>
        </div>
      )
    }
  }
  sidebar(){
    if(this.state.hasPlaylist){
      return(
        <SearchSongs addSong={this.addSong}
                     room={this.props.room}
                     playlist={this.state.playlist}/>
      )
    } else {
      return(
        <NewPlaylist playlistClick={this.playlistClick}
                     user={this.props.user}
                     room={this.props.room}/>
      )
    }
  }
  updateCheck(){
    check_against = this.state.playlist;
    self = this;
    $.ajax({
      url: '/playlist',
      type: 'GET',
      data: { user: this.props.user.id, playlist: this.state.playlist.id, room_id: this.props.room.id }
    }).success( data => {
      if(data.total != check_against.total){
        console.log('playlist has changed');
        self.setState({ playlist: data });
      }
    })
  }
  render(){
    if(this.state.hasPlaylist){
      setInterval(this.updateCheck, 5000);
    }
    return(
      <div className='row'>
        <div className='col s12'>
          <div className='col s8'>
            <div className='panel'>
              <div className='panel-head'>
                <h3>{ this.state.room.name }</h3>
              </div>
              <div className='panel-body'>
                { this.content() }
              </div>
            </div>
          </div>
          <div className='col s4'>
            { this.sidebar() }
          </div>
        </div>
      </div>
    );
  }
}
