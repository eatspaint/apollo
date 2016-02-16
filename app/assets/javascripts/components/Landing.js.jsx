class Landing extends React.Component{
  constructor(props){
    super(props);
    this.findRoom = this.findRoom.bind(this);
  }
  findRoom(e){
    e.preventDefault();
    $.ajax({
      url: '/find_room',
      type: 'GET',
      data: { room_name: this.refs.room_name.value }
    }).success( data => {
      if(data.error){
        window.location.href = '/';
      } else {
        window.location.href = '/rooms/' + data.id;
      }
    });
  }
  render() {
    return(
      <div>
        <div className='landing-header valign-wrapper'>
          <div className='valign full-width'>
            <p id='landing-welcome' className='landing-welcome center-align'>Welcome to Apollo</p>
            <div className='yellow-hr' style={{width: '45%'}}></div>
            <p className='landing-tagline center-align'>Your workplace music solution</p>
          </div>
        </div>
        <div className='row'>
          <div className='col s12 m6 offset-m3'>
            <div className='panel'>
              <div className='panel-head'>
                <h3>Find a Room</h3>
              </div>
              <div className='panel-body'>
                <form onSubmit={this.findRoom}>
                  <div className='row'>
                    <div className='col s10'>
                      <input ref='room_name'/>
                    </div>
                    <div className='col s2'>
                      <button className='btn' type='submit'>Find</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
