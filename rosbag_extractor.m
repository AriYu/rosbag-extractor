function rosbag_extractor(directory_path)

directory = dir(directory_path)
for num_of_file=3:length(directory)
    bag = rosbag(strcat(directory_path,'/',directory(num_of_file).name));
    wheel_state_select = select(bag, 'Topic', '/wheel_state');
    wheel_ctrl_select = select(bag, 'Topic', '/wheel_joint_ctrl');
    motor_input_select = select(bag, 'Topic', '/motor_input');

    wheel_state_ts = timeseries(wheel_state_select);
    wheel_state_time = wheel_state_ts.Time;
    wheel_state_message = readMessages(wheel_state_select);
    wheel_ctrl_ts = timeseries(wheel_ctrl_select);
    wheel_ctrl_message = readMessages(wheel_ctrl_select);
    motor_input_ts = timeseries(motor_input_select);
    motor_input_message = readMessages(motor_input_select);

    clf reset;
    for num_wheel = 1:6
        for idx = 1:numel(wheel_state_message);
            wheel_state_data(idx, num_wheel) = -wheel_state_message{idx, 1}.Velocity(num_wheel);
        end
        for idx = 1:numel(wheel_ctrl_message);
            wheel_ctrl_data(idx, num_wheel) = wheel_ctrl_message{idx, 1}.Velocity(num_wheel);
        end
        for idx = 1:numel(motor_input_message);
            motor_input_data(idx, num_wheel) = motor_input_message{idx, 1}.Data(num_wheel);
        end
    end
    save(strcat(directory_path,'/',directory(num_of_file).name,'.mat'))
    print('saved')
end
