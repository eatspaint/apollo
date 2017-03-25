class Fyf extends React.Component{
  constructor(props){
    super(props);
    this.state = {selected: null, topTracks: []};
    this.lineup = this.lineup.bind(this);
    this.selectArtist = this.selectArtist.bind(this);
    this.selectArtist = this.selectArtist.bind(this);
    this.saveLink = this.saveLink.bind(this);
    this.savePlaylist = this.savePlaylist.bind(this);
  }
  lineup(){
    return(
      this.props.lineup.map( artist => {
        let klass = this.state.selected == artist ? "fyf-artist selected" : "fyf-artist"
        return(<span key={artist.rspot_id} className={klass} onClick={() => this.selectArtist(artist)}>{artist.name}</span>);
      })
    )
  }
  selectArtist(artist){
    if(this.state.selected != artist){
      $.ajax({
        url: '/fyf_top',
        type: 'POST',
        data: {rspot_id: artist.rspot_id}
      }).success(data => {
        this.setState({ selected: artist, topTracks: data.top_tracks });
      });
    }
  }
  mapToPlayButton(){
    if(this.state.selected){
      src = this.state.topTracks.join(',');
      title = this.state.selected.name.replace("&", "and");
      return(
        <div>
          <iframe src={"https://embed.spotify.com/?uri=spotify:trackset:" + title + ":" + src} frameBorder="0" allowTransparency="true" width="100%" height="380" ></iframe>
          <div style={{textAlign: 'center'}}>{this.saveLink()}</div>
        </div>
      )
    }else{
      return(
        <p>Click on an artist to the left to view their top 10 songs on Spotify.</p>
      )
    }
  }
  saveLink(){
    if(this.props.user){
      if(this.state.selected && this.state[this.state.selected.name]){
        return(<p className="flat-btn" >{this.state[this.state.selected.name]}</p>)
      }else{
        return(<p className="flat-btn pointer" onClick={this.savePlaylist}>Save this platlist</p>)
      }
    }else{
      return(<p><a href="/users/sign_up">Sign up</a> for an account to save this playlist in Spotify.</p>)
    }
  }
  savePlaylist(){
    $.ajax({
      url: '/fyf_save',
      type: 'POST',
      data: {artist: this.state.selected, tracks: this.state.topTracks}
    }).success(data => {
      message = {};
      message[this.state.selected.name] = data.message;
      this.setState(message);
    });
  }
  render(){
    return(
      <div className="container">
        <div className="row">
          <div className="col m6">
            <div className="panel">
              <div className="panel-head">
                <h3>FYF 2017 Artists</h3>
              </div>
              <div className="panel-body">
                <div className="flex-container" style={{color: 'white'}}>{this.lineup()}</div>
              </div>
            </div>
          </div>
          <div className="col m6">
            <div className="panel">
              <div className="panel-head">
                <h3>Listen</h3>
              </div>
              <div className="panel-body">
                {this.mapToPlayButton()}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
