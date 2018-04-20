datasize = size(amazonjobsdataset);
n = 1;

while n <= datasize(1,1)
    splitTemp = strsplit(amazonjobsdataset(n,1));
    tempSize = size(splitTemp);
    if(tempSize(1,2) >= 3)
            City(n,1) = splitTemp(1,3);
    end

    n = n+1;
end

UniqueCities = unique(City);
NumUnique = size(UniqueCities);

finalData = zeros(NumUnique(1,1),3);

n = 1;
m = 1;

disp(datasize(1,1));
disp(NumUnique(1,1));

while n < datasize(1,1)
    while m < NumUnique(1,1)
        if City(n,1) == UniqueCities(m,1)
            finalData(m,3) = (finalData(m,3) + 1);
        end
        m = m+1;
    end
    m = 1;
    n = n + 1;
end
%%
m = 1;
while m < (NumUnique(1,1)-5)
    locTemp = char(UniqueCities(m,1));
    locTempSize = size(locTemp)
         if locTempSize(1,2) > 0
            CoordsTemp = geoCode(locTemp,'osm');
            finalData(m,1) = CoordsTemp(1,1);
            finalData(m,2) = CoordsTemp(1,2);
         end
         m=m+1
end
%%
CSV = zeros((NumUnique(1,1) + 1),3);
CSV(1,1) = "LONGITUDE";
CSV(1,2) = "LATITUDE";
CSV(1,3) = "WEIGHT";

n = 2
m = 1
while n < NumUnique(1,1)
    CSV(n,1) = finalData(m,1)
    CSV(n,2) = finalData(m,2)
    CSV(n,3) = finalData(m,3)
    n = n + 1
    m = m + 1
end

%%
csvwrite('file.csv',finalData)

