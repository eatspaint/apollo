class Song extends React.Component{
  constructor(props){
    super(props);
    this.imageUrl = this.imageUrl.bind(this);
  }
  imageUrl(){
    if(this.props.album.images[0]){
      return(this.props.album.images[0].url);
    }
  }
  render(){
    return(
      <div className='col s12 result- hoverable valign-wrapper' onClick={this.props.addSong.bind(this)}>
        <img className='col s2 valign' src={this.imageUrl()}></img>
        <p className='col s10'>{this.props.name} - {this.props.artists[0].name}</p>
      </div>
    )
  }
}
