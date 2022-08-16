use portfolio;
Select * from nashville;

Select saleDate, str_to_date(SaleDate,"%Y-%m-%d")
from nashville;

Update nashville
SET SaleDateConverted = str_to_date(SaleDate,"%Y-%m-%d");

select * from nashville
order by ParcelID;

select PropertyAddress from nashville
where PropertyAddress= "";

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress,b.PropertyAddress)
From nashville a
JOIN nashville b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID  <> b.UniqueID
Where a.PropertyAddress="";

update nashville a join nashville b on 
a.ParcelID = b.ParcelID
	AND a.UniqueID<> b.UniqueID 
    set  PropertyAddress = IFNULL(a.PropertyAddress,b.PropertyAddress)
    where a.PropertyAddress="";

Select PropertyAddress
From nashville;

SELECT
SUBSTRING_index(PropertyAddress,",",1) as Address
, SUBSTRING_index(PropertyAddress,",",-1) as Address
from nashville;


ALTER TABLE nashville
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING_index(PropertyAddress,",",1);


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING_index(PropertyAddress,",",-1);

Select OwnerAddress
From nashville;

Select
SUBSTRING_index(OwnerAddress,",",1),
SUBSTRING_index(SUBSTRING_index(OwnerAddress,",",2) ,",",-1),
SUBSTRING_index(OwnerAddress,",",-1)
From nashville;



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = SUBSTRING_index(OwnerAddress,",",1);


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = SUBSTRING_index(SUBSTRING_index(OwnerAddress,",",2) ,",",-1);



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = SUBSTRING_index(OwnerAddress,",",-1);

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From nashville
Group by SoldAsVacant
order by 2;

Select SoldAsVacant,
CASE 
  When SoldAsVacant = 'Y' THEN 'Yes'
  When SoldAsVacant = 'N' THEN 'No'
  ELSE SoldAsVacant
  END 
From nashville;


Update nashville
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;

delete a from nashville as a
inner join nashville as b
where a.PropertyAddress = b.PropertyAddress and
a.UniqueID <> b.UniqueID;

ALTER TABLE nashville
DROP OwnerAddress,drop TaxDistrict,drop PropertyAddress,drop SaleDate;

