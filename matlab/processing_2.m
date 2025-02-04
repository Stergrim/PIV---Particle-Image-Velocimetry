function processing_2(Storage)
% Трехпроходный сценарий

preprocessing(Storage);

pass(Storage,[32,32],[16,16],'type_pass','first');
validate_outliers(Storage);
interpolate_outliers(Storage);
smoothing(Storage);

pass(Storage,[16,16],[8,8],'type_pass','next');
validate_outliers(Storage);
interpolate_outliers(Storage);
smoothing(Storage);

pass(Storage,[8,8],[4,4],'type_pass','next','double_corr','xy');
validate_outliers(Storage);
interpolate_outliers(Storage);
subpixel_peak(Storage);

end