import React, {Component} from 'react';
import Calendar from 'react-calendar';

export default class UDCalendar extends Component {
  // state is for keeping control state before or after changes.
  state = {
    date: new Date(this.props.StartView)
    // the things you want to put in state.   
    // text: this.props.text //un comment the line to use state insted props
  }
  
  onIncomingEvent(eventName, event) {
    console.log("Request reccieved")
    console.log("date:"+this.state.date)
    console.log("eventname:"+eventName)
    console.log("eventthingy:"+event.requestId)
    if (event.type === "requestState") {
        var data = {
            attributes: {
                date: this.state.date
            }
        }
        UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, data);
    }
  }

  onChange(e) {
    this.setState( { value: e } )
    if (this.props.activeOnChange) {
        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + "onChange",
            eventName: 'onChange',
            eventData: e
        });
    }
    
  }

  onClickDay(e) {
    this.setState( { value: e } )
    if (this.props.activeOnClickDay) {
        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + "onClickDay",
            eventName: 'onClickDay',
            eventData: e
        });
    }
  }

  componentWillMount() {
    this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
  }
  
  componentWillUnmount() {
    console.log("Unmounted")
    UniversalDashboard.unsubscribe(this.pubSubToken);
  }

  render() {
    return (
        <div>
            <Calendar 
            showNavigation = {this.props.ShowNavigation}
            calendarType={"ISO 8601"}
            onChange={this.onChange.bind(this)}
            value={this.state.date}
            onClickDay={this.onClickDay.bind(this)}
            />
        </div>
        )
  }
}