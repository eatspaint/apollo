class Rooms extends React.Component{
  constructor(props){
    super(props);
    this.state = { rooms: [] };
  }
  componentDidMount(){
    $.ajax({
      url: '/rooms_index',
      type: 'GET'
    }).success(data => {
      this.setState({ rooms: data.rooms });
    });
  }
  rooms(){
    if(this.state.rooms.length == 0){
      return(<p>You currently have no rooms</p>);
    } else {
      let yourRooms = this.state.rooms.map( room => {
        let key = `room-${room.id}`;
        return(<Room key={key} {...room} />)
      });
      return( yourRooms )
    }
  }
  render(){
    return(
      <div className='row'>
        <div className='col s12'>
          <h3 className='center'>Your Rooms</h3>
          <ul>
            { this.rooms() }
          </ul>  
        </div>
      </div>
    )
  }
}
