class Rooms extends React.Component{
  constructor(props){
    super(props);
    this.state = { rooms: [] };
    this.refreshRooms = this.refreshRooms.bind(this);
    this.newRoom = this.newRoom.bind(this);
  }
  componentDidMount(){
    this.refreshRooms();
  }
  refreshRooms(){
    $.ajax({
      url: '/rooms_index',
      type: 'GET'
    }).success(data => {
      this.setState({ rooms: data.rooms });
    });
  }
  newRoom(){
    $.ajax({
      url: '/rooms',
      type: 'POST',
      data: { room: { name: this.refs.room_name.value }}
    }).success( data => {
      this.refs.room_name.value = '';
      this.refreshRooms();
    })
  }
  rooms(){
    if(this.state.rooms.length == 0){
      return(<p>You currently have no rooms</p>);
    } else {
      let yourRooms = this.state.rooms.map( room => {
        let key = `room-${room.id}`;
        return(<Room key={key} {...room} refreshRooms={this.refreshRooms}/>)
      });
      return( yourRooms )
    }
  }
  render(){
    return(
      <div className='row'>
        <div className='col s6'>
          <div className='panel'>
            <div className='panel-head'>
              <h3 className=''>Your Rooms</h3>
            </div>
            <div className='panel-body'>
              <ul>
                { this.rooms() }
              </ul>
            </div>
          </div>
        </div>
        <div className='col s6'>
          <div className='panel'>
            <div className='panel-head'>
              <h3 className=''>Create a Room</h3>
            </div>
            <div className='panel-body'>
              <p>Setting up a room allows other users to connect with your playlists.</p>
              <input ref='room_name'></input>
              <a className='btn' onClick={this.newRoom}>Create</a>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
