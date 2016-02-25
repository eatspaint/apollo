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
      <tr>
        <td><a href={url}>{this.props.name}</a></td>
        <td><i className="material-icons pointer delete-x" onClick={ this.deleteRoom.bind(this) }>close</i></td>
      </tr>
    )
  }
}
