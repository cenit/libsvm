% This make.m is for MATLAB and OCTAVE under Windows, Mac, and Unix
function make()
try
	% This part is for OCTAVE
	if (exist ('OCTAVE_VERSION', 'builtin'))
		mex -o ../../libsvmread libsvmread.c
		mex -o ../../libsvmwrite libsvmwrite.c
		mex -o ../../svmtrain -I.. svmtrain.c ../svm.cpp svm_model_matlab.c
		mex -o ../../svmpredict -I.. svmpredict.c ../svm.cpp svm_model_matlab.c
	% This part is for MATLAB
	% Add -largeArrayDims on 64-bit machines of MATLAB
	else
		mex -output ../../libsvmread CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmread.c
		mex -output ../../libsvmwrite CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmwrite.c
		mex -output ../../svmtrain CFLAGS="\$CFLAGS -std=c99" -I.. -largeArrayDims svmtrain.c ../svm.cpp svm_model_matlab.c
		mex -output ../../svmpredict CFLAGS="\$CFLAGS -std=c99" -I.. -largeArrayDims svmpredict.c ../svm.cpp svm_model_matlab.c
	end
catch err
	fprintf('Error: %s failed (line %d)\n', err.stack(1).file, err.stack(1).line);
	disp(err.message);
	fprintf('=> Please check README for detailed instructions.\n');
end
