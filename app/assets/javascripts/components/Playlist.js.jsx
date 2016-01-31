class Playlist extends React.Component{
  constructor(props){
    super(props);
    this.imageUrl = this.imageUrl.bind(this);
  }
  imageUrl(){
    if(this.props.images[0]){
      return(this.props.images[0].url);
    }
  }
  render(){

    return(
      <div className='col s12 result-'>
        <img className='col s2' src={this.imageUrl()}></img>
        <p className='col s10'>{this.props.name}</p>
      </div>
    )
  }
}
