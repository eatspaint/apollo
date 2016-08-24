class Landing extends React.Component{
  constructor(props){
    super(props);
  }
  render() {
    return(
      <div>
        <div className='landing-header valign-wrapper hide-on-small-only'>
          <div className='valign full-width'>
            <p id='landing-welcome' className='landing-welcome center-align'>Welcome to Apollo</p>
            <div className='yellow-hr' style={{width: '45%'}}></div>
            <p className='landing-tagline center-align'>Your workplace music solution</p>
          </div>
        </div>
        <div className='row'>
          <div className='col s12 m8 l6 offset-m2 offset-l3'>
            <FindRoom here='/'/>
          </div>
        </div>
      </div>
    )
  }
}
