require 'home'

describe Home do
  before :all do
    @kitchen_lamp = {
      :name => 'Kitchen lamp',
      :id => 1
    }

    @bedroom_lamp = {
      :name => 'Bedroom lamp',
      :id => 2
    }
  end

  it 'should have devices' do
    number_of_devices = 2

    Tellduscore.should_receive(:number_of_devices).and_return(number_of_devices)
    Tellduscore.should_receive(:get_device_id).once.with(0).and_return(@kitchen_lamp[:id])
    Tellduscore.should_receive(:get_device_id).once.with(1).and_return(@bedroom_lamp[:id])
    Tellduscore.should_receive(:get_name).once.with(@kitchen_lamp[:id]).and_return(@kitchen_lamp[:name])
    Tellduscore.should_receive(:get_name).once.with(@bedroom_lamp[:id]).and_return(@bedroom_lamp[:name])

    devices = Home.devices

    devices.length.should == number_of_devices
    devices.first.id.should == @kitchen_lamp[:id]
    devices.first.name.should == @kitchen_lamp[:name]
  end

  it 'should only hit the api once when calling devices' do
    #Tellduscore.should_receive(:number_of_devices).once.and_return(0)

    #Home.devices
    #Home.devices
    pending
  end

  it 'should turn off all devices' do
    kitchen_lamp = Device.new @kitchen_lamp
    bedroom_lamp = Device.new @bedroom_lamp
    lamps = [kitchen_lamp, bedroom_lamp]

    Home.should_receive(:devices).once.and_return(lamps)
    kitchen_lamp.should_receive(:turn_off).once
    bedroom_lamp.should_receive(:turn_off).once

    Home.turn_off
  end

  it 'should turn on all devices' do
    kitchen_lamp = Device.new @kitchen_lamp
    bedroom_lamp = Device.new @bedroom_lamp
    lamps = [kitchen_lamp, bedroom_lamp]

    Home.should_receive(:devices).once.and_return(lamps)
    kitchen_lamp.should_receive(:turn_on).once
    bedroom_lamp.should_receive(:turn_on).once

    Home.turn_on
  end
end