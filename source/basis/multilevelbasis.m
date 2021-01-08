function [transformcell, ind, datacell, datalevel] = multilevelbasis(tree,coords,degree,polymodel);

% Construct Multi-Level basis in R^{d} described by random projection tree
% degree - Hyperbolic Cross, Total Degree, degree level
% Output HB basis in transformcell

% Change tree format 
[leftchild, rightchild, parent, datacell, datalevel] = convertbintreetolist(tree);

% Sort datalevel
[sortdatalevel, ind] = sort(datalevel);
[dummy,unsortkey] = sort(ind);
currentlevel = sortdatalevel(end); 
levelcounter = size(sortdatalevel,1);

% Data
transformcell = cell(length(ind),6);

% Process finest level first
while sortdatalevel(levelcounter) == currentlevel 
    
    [transformcell{levelcounter,1} transformcell{levelcounter,2}  ...
     transformcell{levelcounter,3} transformcell{levelcounter,4} ] = ...
        leaflocalbasis(datacell{ind(levelcounter)}, coords, polymodel,degree);
    levelcounter = levelcounter - 1;
    
end

% minlevel = currentlevel - numofpartiallevels + 1;
minlevel = 1;

while currentlevel > minlevel
    currentlevel = currentlevel - 1;
    % fprintf('Current Level = %d \n', currentlevel);
    while sortdatalevel(levelcounter) == currentlevel
   
       
        % Check if it is a leaf
        if leftchild(ind(levelcounter)) == 0 && rightchild(ind(levelcounter)) == 0
            
              [transformcell{levelcounter,1} transformcell{levelcounter,2} ...
                  transformcell{levelcounter,3} transformcell{levelcounter,4} ] = ...
                  leaflocalbasis(datacell{ind(levelcounter)}, coords, polymodel,degree);
        % One child (left)  donothing
        elseif leftchild(ind(levelcounter)) ~= 0 && rightchild(ind(levelcounter)) == 0
        
             transformcell{levelcounter,1} = transformcell{unsortkey(leftchild(ind(levelcounter)) + 1), 1}
             transformcell{levelcounter,2} = [];
             
             transformcell{levelcounter,3} = transformcell{unsortkey(leftchild(ind(levelcounter)) + 1), 3}
             transformcell{levelcounter,4} = [];
             
             % Clean not needed vectors 

             
        % One child (right) donothing
        elseif leftchild(ind(levelcounter)) == 0 && rightchild(ind(levelcounter)) ~= 0
        
            
            transformcell{levelcounter,1} = transformcell{unsortkey(rightchild(ind(levelcounter)) + 1), 1}
            transformcell{levelcounter,2} = [];
            
            
            transformcell{levelcounter,3} = transformcell{unsortkey(rightchild(ind(levelcounter)) + 1), 3}
            transformcell{levelcounter,4} = [];
            
            % Clean not needed vectors 

            
        % Two Children    
        else
            
            
            
            
            [transformcell{levelcounter,1} transformcell{levelcounter,2} ...
                    transformcell{levelcounter,3} transformcell{levelcounter,4} ] = ...
                localbasis(transformcell{unsortkey(leftchild(ind(levelcounter)) + 1), 1}, ...
                datacell{leftchild(ind(levelcounter)) + 1}, ...
                transformcell{unsortkey(rightchild(ind(levelcounter)) + 1), 1}, ...
                datacell{rightchild(ind(levelcounter)) + 1}, ...
                datacell{ind(levelcounter)}, coords, polymodel, degree);
                  
        end
            
        levelcounter = levelcounter - 1;
    end

    
    
end

% Transform last level
           
            [transformcell{levelcounter,1} transformcell{levelcounter,2} ...
                    transformcell{levelcounter,3} transformcell{levelcounter,4} ] = ...
                localbasis(transformcell{unsortkey(leftchild(ind(levelcounter)) + 1), 1}, ...
                datacell{leftchild(ind(levelcounter)) + 1}, ...
                transformcell{unsortkey(rightchild(ind(levelcounter)) + 1), 1}, ...
                datacell{rightchild(ind(levelcounter)) + 1}, ...
                datacell{ind(levelcounter)}, coords, polymodel, degree);



% Add information of locations of basis functions in sparse matrix
% Add level
[nmax,mmax] = size(transformcell);
for n = 1 : nmax,
    transformcell{n,5} = sortdatalevel(n);
end

% Add location
counterscaling = 0;
counterwave = 0;
for n = nmax : -1 : 1,
    counterscaling = counterscaling + size(transformcell{n,1},2);
    counterwave = counterwave + size(transformcell{n,2},2);
    transformcell{n,6} = counterscaling;
    transformcell{n,7} = counterwave;
end


% TODO: Process last level where degree of Kriging model is less than
% degree

end
