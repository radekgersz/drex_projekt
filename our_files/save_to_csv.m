function save_to_csv(output, columnNames, filename)
    % saveToCSV_legacy saves matrix output to CSV with headers for older MATLAB versions
    
    % Check size
    if size(output,2) ~= length(columnNames)
        error('Number of column names must match number of columns in output.');
    end
    
    % Open file
    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file %s for writing.', filename);
    end
    
    % Write headers
    fprintf(fid, '%s', columnNames{1});
    for i = 2:length(columnNames)
        fprintf(fid, ',%s', columnNames{i});
    end
    fprintf(fid, '\n');
    
    % Write data row by row
    for r = 1:size(output,1)
        fprintf(fid, '%g', output(r,1));
        for c = 2:size(output,2)
            fprintf(fid, ',%g', output(r,c));
        end
        fprintf(fid, '\n');
    end
    
    fclose(fid);
end
