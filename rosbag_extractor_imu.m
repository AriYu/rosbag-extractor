function rosbag_extractor_imu(bag_file_path)
    bag = rosbag(bag_file_path)
    imu_select = select(bag, 'Topic', '/imu/data_raw');
    
    imu_ts = timeseries(imu_select);
    imu_time = imu_ts.Time;
    imu_message = readMessages(imu_select);
    
    clf reset;
    for idx = 1:numel(imu_message)
        imu_data_angular_velocity_x(idx) = imu_message{idx}.AngularVelocity.X;
        imu_data_angular_velocity_y(idx) = imu_message{idx}.AngularVelocity.Y;
        imu_data_angular_velocity_z(idx) = imu_message{idx}.AngularVelocity.Z;
        imu_data_acc_x(idx) = imu_message{idx}.LinearAcceleration.X;
        imu_data_acc_y(idx) = imu_message{idx}.LinearAcceleration.Y;
        imu_data_acc_z(idx) = imu_message{idx}.LinearAcceleration.Z;
    end
    T = table;
    T.time = imu_time;
    T.angular_velocity_x = imu_data_angular_velocity_x';
    T.angular_velocity_y = imu_data_angular_velocity_y';
    T.angular_velocity_z = imu_data_angular_velocity_z';
    T.linear_acceleration_x = imu_data_acc_x';
    T.linear_acceleration_y = imu_data_acc_y';
    T.linear_acceleration_z = imu_data_acc_z';
    writetable(T,strcat(bag_file_path,'_table.txt'));
    save(strcat(bag_file_path,'.mat'))
    print('saved')
end
