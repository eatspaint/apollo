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
        window.location.href = '/rooms/' + this.props.room_salt;
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
      if(data.error == 'rickroll' && this.props.room.rickroll){
        alert("Very funny.");
        alert("Don't be that guy.");
        alert("For real, stop.");
        window.location.href = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      } else {
        // window.location.href = '/rooms/' + this.props.room.id;
        this.setState({ playlist: data });
      }
    })
  }
  removeSong(track_id, i){
    $.ajax({
      url: '/remove_track',
      type: 'PUT',
      data: { track_id: track_id, room_id: this.props.room.id, playlist_id: this.state.playlist.id, position: i }
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
          <p>Add a playlist or create a new one!</p>
          <ul>
            { playlists }
          </ul>
        </div>
      )
    } else {
      let tracks = this.state.playlist.all_tracks.map( (track, i) => {
        let key = `track-${track.id}-${i}`;
        if(this.props.guest || ((this.props.user.id != this.props.room.user_id) && (this.state.playlist.owner.id != this.props.user.rspot.id))){
          return(
            <tr key={key}>
              <td>{ track.name }</td>
              <td>{ track.artists[0].name }</td>
              <td>{ track.album.name }</td>
            </tr>
          )
        } else {
          return(
            <tr key={key}>
              <td>{ track.name }</td>
              <td>{ track.artists[0].name }</td>
              <td>{ track.album.name }</td>
              <td ><i className="material-icons pointer delete-x" onClick={this.removeSong.bind(this, track.id, i)}>close</i></td>
            </tr>
          )
        }
      })
      let player = "https://embed.spotify.com/?uri=" + this.state.playlist.uri;
      if(this.props.guest || ((this.props.user.id != this.props.room.user_id) && (this.state.playlist.owner.id != this.props.user.rspot.id))){
        return(
          <div>
            <p>Current Playlist: {this.state.playlist.name}</p>
            <div className='row'>
              <iframe src={ player } width="100%" height="80" frameBorder="0" allowTransparency="true"></iframe>
            </div>
            <div className='scroll-table'>
              <table>
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Artist</th>
                    <th>Album</th>
                  </tr>
                </thead>
                <tbody>
                  { tracks }
                </tbody>
              </table>
            </div>
          </div>
        )
      } else {
        return(
          <div>
            <p>Current Playlist: {this.state.playlist.name}</p>
            <div className='row'>
              <div className='col s12 valign-wrapper'>
                <div className='col s12 m10'>
                  <iframe src={ player } width="100%" height="80" frameBorder="0" allowTransparency="true"></iframe>
                </div>
                <div className='col s12 m2'>
                  <div className='valign'>
                    <a className='pointer flat-btn' onClick={this.removePlaylist}>Remove</a>
                  </div>
                </div>
              </div>
            </div>
            <div className='scroll-table'>
              <table>
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Artist</th>
                    <th>Album</th>
                    <th>Delete</th>
                  </tr>
                </thead>
                <tbody>
                  { tracks }
                </tbody>
              </table>
            </div>
          </div>
        )
      }
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
    if(this.state.hasPlaylist){
      check_against = this.state.playlist.total;
      playlist_id = this.state.playlist.id;
    } else {
      check_against = 0;
      playlist_id = 0;
    }
    self = this;
    $.ajax({
      url: '/playlist_check',
      type: 'GET',
      data: { room_id: this.props.room.id }
    }).success( data => {
      if(data.exit_message){
        if(data.exit_message == 'exit'){
          self.setState({ playlist: null, hasPlaylist: false});
        }else if(data.exit_message == 'guest_exit'){
          window.location.href = '/';
        }
      } else if((data.total != check_against) || (data.id != playlist_id)){
        // console.log('playlist has changed');
        self.setState({ playlist: data, hasPlaylist: true });
      } else {
        setTimeout(this.updateCheck, 5000);
      }
    });
  }
  render(){
    setTimeout(this.updateCheck, 5000);
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
