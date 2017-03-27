function modified_rosbag_extractor(bag_file_path)
    bag = rosbag(bag_file_path);
    topic_names = bag.AvailableTopics.Properties.RowNames;
    topic_messages_names = matlab.lang.makeValidName(topic_names);
    topic_map = containers.Map;
    for idx = 1:numel(topic_names)
        topic_map(topic_names{idx}) = timeseries(select(bag, 'Topic', topic_names{idx}));
    end
    save(strcat(bag_file_path,'_v2.mat'))
    for i = 8:13
        figure
        plot(topic_map('/imu/data_raw').Time, topic_map('/imu/data_raw').Data(:, i));
    end
end
