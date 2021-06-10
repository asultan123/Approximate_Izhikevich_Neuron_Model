pattern = containers.Map;
ipattern = containers.Map;

pattern('A')=1; 
pattern('B')=2; 
pattern('C')=3; 
pattern('D')=4; 
pattern('E')=5; 
pattern('F')=6; 
pattern('G')=7; 
pattern('H')=8; 
pattern('I')=9; 
pattern('J')=10;
pattern('K')=11;
pattern('L')=12;
pattern('M')=13;
pattern('N')=14;
pattern('O')=15;
pattern('P')=16;
pattern('Q')=17;
pattern('R')=18;
pattern('S')=19;
pattern('T')=20;

% ipattern = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'];

%   evaluate exact behaviours
exact_behaviours = iz_20;
etm_error_nrmsd = zeros(20,1,5);

pattern_reduced = zeros(20,1601,5);

max_fractional_bits = 12;
min_fractional_bits = 12;
max_etm_upper_bits = 16;
min_etm_upper_bits = 12;
error_nrmsd_at_precision_index_reset = min_fractional_bits-1;
index_reset = min_etm_upper_bits-1;

%   run sim with differ etm upper bit count
parfor etm_upper_bits = min_etm_upper_bits:max_etm_upper_bits
    display('evaluating ETM');
    etm_upper_bits
%     error_nrmsd_at_precision = zeros(20,max_fractional_bits-min_fractional_bits+1);
    
    %   run sim with different fractional bit count
%     for fractional_bits = min_fractional_bits:max_fractional_bits
%             display('evaluating etm at fractional precision')
%             fractional_bits
            %   maintain model precision at 9 bits integer
            pattern_reduced(:,:,etm_upper_bits) = iz_20_reducedprecision_with_etm(9,12,etm_upper_bits);
            
            %   evaluate mse error for each pattern
%             reduced_precision = pattern_reduced(:,:,etm_upper_bits);
%             error_nrmsd = ones(20,1);
%             for i = 1:20
%                 reduced_pattern = getPattern(reduced_precision(i,:));
%                 exact_pattern = getPattern(exact_behaviours(i,:));
%                 mse = sqrt(sum((exact_pattern-reduced_pattern).^2)/size(exact_pattern,2));
%                 error_nrmsd(i) = mse/(max(exact_pattern)-min(exact_pattern))*100;
%             end
            
            %   append mse errors to fractional bit aggregator
%             error_nrmsd_at_precision(:,fractional_bits-error_nrmsd_at_precision_index_reset) = error_nrmsd;
%     end
%     
%     %   append fractional bit error rates at different etm accuracy levels
%     etm_error_nrmsd(:,:,etm_upper_bits-index_reset) = error_nrmsd_at_precision;
%     
%     display('done evaluating etm');
%     etm_upper_bits
    %   update results on disk
end
%     save('etm_error_nrmsd_etmAccuracy-12-16-_fractionalBits-20-_','etm_error_nrmsd');


