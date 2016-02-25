class Song extends React.Component{
  constructor(props){
    super(props);
    this.imageUrl = this.imageUrl.bind(this);
    this.state = {showAdd: false};
  }
  imageUrl(){
    if(this.props.album.images[0]){
      return(this.props.album.images[0].url);
    }
  }
  render(){
    if(!this.props.selected){
      return(
        <div className='col s12 valign-wrapper' onClick={() => this.props.showAdd(this.props.index)}>
          <img className='col s2 valign' src={this.imageUrl()}></img>
          <p className='col s10 pointer song'>{this.props.name} - {this.props.artists[0].name}</p>
        </div>
      )
    } else {
      return(
        <div className='col s12 valign-wrapper' onClick={() => this.props.showAdd(this.props.index)}>
          <p className='col s10 pointer song'>{this.props.name} - {this.props.artists[0].name}</p>
          <div className='col s2 pointer valign song-add' onClick={this.props.addSong.bind(this)}>
            <p>Add</p>
          </div>
        </div>
      )
    }
  }
}
