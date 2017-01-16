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
    end
    save(strcat(bag_file_path,'.mat'))
    print('saved')
end
