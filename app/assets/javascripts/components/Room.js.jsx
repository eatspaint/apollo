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
  rickroll(){
    $.ajax({
      url: '/rickroll',
      type: 'PUT',
      data: { room_id: this.props.id }
    }).success( data => {
      this.props.refreshRooms();
    })
  }
  render(){
    let url = `/rooms/${this.props.salt}`;
    let guard;
    if(this.props.rickroll){
      guard = <p className='pointer delete-x' onClick={ this.rickroll.bind(this) }>RRGuard: On</p>
    }else{
      guard = <p className='pointer delete-x' onClick={ this.rickroll.bind(this) }>RRGuard: Off</p>
    }
    return(
      <tr>
        <td><a href={url}>{this.props.name}</a></td>
        <td><i className="material-icons pointer delete-x" onClick={ this.deleteRoom.bind(this) }>close</i></td>
        <td>{ guard }</td>
      </tr>
    )
  }
}
