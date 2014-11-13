function ret = read_data()
    ret = readtable('data/latest.csv');
    
    subplot(3,2,1);
    plot([ret.accelerationX, ret.accelerationY, ret.accelerationZ]);
    title('Acceleration')
    legend('X', 'Y', 'Z');
    
    subplot(3,2,2);
    plot([ret.HeadingX, ret.HeadingY, ret.HeadingZ]);
    title('Heading')
    legend('X', 'Y', 'Z')
    
    subplot(3,2,3);
    plot([ret.motionYaw, ret.motionPitch, ret.motionRoll]);
    title('Motion')
    legend('Yaw', 'Pitch', 'Roll')
    
    subplot(3,2,4);
    plot([ret.motionRotationRateX, ret.motionRotationRateY, ret.motionRotationRateZ]);
    title('Motion Rotation Rate')
    legend('X', 'Y', 'Z')
    
    subplot(3,2,5);
    plot([ret.motionUserAccelerationX, ret.motionUserAccelerationY, ret.motionUserAccelerationZ]);
    title('Motion User Acceleration')
    legend('X', 'Y', 'Z')
    
    
    subplot(3,2,6);
    plot([ret.RotationX, ret.RotationY, ret.RotationZ]);
    title('Rotation')
    legend('X', 'Y', 'Z')
end