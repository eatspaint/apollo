class Room extends React.Component{
  constructor(props){
    super(props);
  }
  render(){
    let url = `/rooms/${this.props.id}`;
    return(
      <li>
        <a href={url}>{this.props.name}</a>
      </li>
    )
  }
}
