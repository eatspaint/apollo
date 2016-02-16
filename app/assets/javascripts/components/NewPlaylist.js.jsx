class NewPlaylist extends React.Component{
  constructor(props){
    super(props);
    this.newPlaylist = this.newPlaylist.bind(this);
  }
  newPlaylist(){
    $.ajax({
      url: '/playlists',
      type: 'POST',
      data: { playlist_name: this.refs.playlist_name.value }
    }).success( data => {
      this.props.playlistClick(data.id);
    })
  }
  render(){
    return(
      <div className='panel'>
        <div className='panel-head'>
          <h3 className=''>Create a Playlist</h3>
        </div>
        <div className='panel-body'>
          <p>Build a new playlist to start from scratch.</p>
          <input ref='playlist_name'></input>
          <a className='btn' onClick={this.newPlaylist}>Create</a>
        </div>
      </div>
    )
  }
}
