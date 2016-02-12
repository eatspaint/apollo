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
    let imgCols = 's' + this.props.imgSize;
    let textCols = 's' + (12 - this.props.imgSize);
    return(
      <div className='col s12 result-'>
        <img className={'col ' + imgCols} src={this.imageUrl()}></img>
        <p className={'col ' + textCols}>{this.props.name}</p>
      </div>
    )
  }
}