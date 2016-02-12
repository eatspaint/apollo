class Room extends React.Component{
  constructor(props){
    super(props);
  }
  deleteRoom(){
    $.ajax({
      url: '/rooms/' + this.props.id,
      type: 'DELETE',
      data: { room_id: this.props.id }
    }).success( data => {
      this.props.refreshRooms();
    })
  }
  render(){
    let url = `/rooms/${this.props.id}`;
    return(
      <li>
        <a href={url}>{this.props.name}</a>
        <span onClick={ this.deleteRoom.bind(this) }>&nbsp;[X]</span>
      </li>
    )
  }
}
