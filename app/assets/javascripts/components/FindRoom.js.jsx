class FindRoom extends React.Component{
  constructor(props){
    super(props);
    this.findRoom = this.findRoom.bind(this);
  }
  findRoom(e){
    route = this.props.here
    e.preventDefault();
    $.ajax({
      url: '/find_room',
      type: 'GET',
      data: { room_name: this.refs.room_name.value }
    }).success( data => {
      if(data.error){
        window.location.href = route;
      } else {
        window.location.href = '/rooms/' + data.id;
      }
    });
  }
  render() {
    return(
      <div className='panel'>
        <div className='panel-head'>
          <h3>Find a Room</h3>
        </div>
        <div className='panel-body'>
          <form onSubmit={this.findRoom}>
            <div className='row'>
              <div className=''>
                <input ref='room_name'/>
              </div>
              <br />
              <div className=''>
                <button className='flat-btn' type='submit'>Enter</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    )
  }
}
