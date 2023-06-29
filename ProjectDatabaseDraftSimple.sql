-- -----------------------------------------------------
-- Table `Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Books` (
  `ISBN` INT NOT NULL,
  `Title` VARCHAR(45) NULL,
  `PublicationDate` DATE NULL,
  `Price` INT(13) NULL,
  `UserReviews` INT(5) NULL,
  PRIMARY KEY (`ISBN`));

-- -----------------------------------------------------
-- Table `Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Author` (
  `AuthorID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Gender` VARCHAR(45) NULL,
  PRIMARY KEY (`AuthorID`));

-- -----------------------------------------------------
-- Table `BookCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BookCategory` (
  `CategoryCode` INT(4) NOT NULL,
  `CategoryName` VARCHAR(45) NULL,
  PRIMARY KEY (`CategoryCode`));

-- -----------------------------------------------------
-- Table `Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `User_Type` VARCHAR(20) NULL DEFAULT 'user',
  PRIMARY KEY (`CustomerID`));

-- -----------------------------------------------------
-- Table `CustomerContactDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CustomerContactDetails` (
  `CustomerContactID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`CustomerContactID`, `CustomerID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    );

-- -----------------------------------------------------
-- Table `AuthorContactDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuthorContactDetails` (
  `AuthorContactID` INT NOT NULL,
  `AuthorID` INT NOT NULL,
  PRIMARY KEY (`AuthorContactID`, `AuthorID`),
  INDEX `AuthorID_idx` (`AuthorID` ASC) VISIBLE,
  CONSTRAINT `AuthorID`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `Author` (`AuthorID`)
    );

-- -----------------------------------------------------
-- Table `Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `SupplierName` VARCHAR(45) NULL,
  PRIMARY KEY (`SupplierID`));

-- -----------------------------------------------------
-- Table `SupplierRep`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SupplierRep` (
  `SupplierFirstName` VARCHAR(45) NOT NULL,
  `SupplierLastName` VARCHAR(45) NOT NULL,
  `WorkNumber` INT NOT NULL,
  `CellNumber` INT NULL,
  `Email` VARCHAR(45) NULL,
  `SupplierID` INT NULL,
  PRIMARY KEY (`SupplierFirstName`, `SupplierLastName`, `WorkNumber`),
  INDEX `SupplierID_idx` (`SupplierID` ASC) VISIBLE,
  CONSTRAINT `SupplierID`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `Supplier` (`SupplierID`)
    );

-- -----------------------------------------------------
-- Table `BooksSupplied`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BooksSupplied` (
  `SupplierID` INT NOT NULL,
  `ISBN` INT NOT NULL,
  PRIMARY KEY (`SupplierID`, `ISBN`),
  INDEX `ISBN_idx` (`ISBN` ASC) VISIBLE,
  CONSTRAINT `SupplierID`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `Supplier` (`SupplierID`),
  CONSTRAINT `ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Books` (`ISBN`)
    );

-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Orders` (
  `Order_ID` INT NOT NULL,
  `OrderValue` DECIMAL(19,4) NULL,
  `OrderDetails` LONGTEXT NULL,
  `CustomerID` INT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    );

-- -----------------------------------------------------
-- Table `Order_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Order_Items` (
  `Item_Number` INT NOT NULL,
  `ItemPrice` DECIMAL(19,4) NULL,
  `OrderID` INT NULL,
  `ISBN` INT NULL,
  PRIMARY KEY (`Item_Number`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `ISBN_idx` (`ISBN` ASC) VISIBLE,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Orders` (`Order_ID`),
  CONSTRAINT `ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Books` (`ISBN`)
    );

-- -----------------------------------------------------
-- Table `CustomerContactAddresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CustomerContactAddresses` (
  `CustomerContactID` INT NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerContactID`, `Address`),
  CONSTRAINT `CustomerContactID`
    FOREIGN KEY (`CustomerContactID`)
    REFERENCES `CustomerContactDetails` (`CustomerContactID`)
    );

-- -----------------------------------------------------
-- Table `CustomerContactEmails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CustomerContactEmails` (
  `CustomerContactID` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerContactID`, `Email`),
  CONSTRAINT `CustomerContactID`
    FOREIGN KEY (`CustomerContactID`)
    REFERENCES `CustomerContactDetails` (`CustomerContactID`)
    );

-- -----------------------------------------------------
-- Table `CustomerContactPhoneNumbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CustomerContactPhoneNumbers` (
  `CustomerContactID` INT NOT NULL,
  `Phone` INT(12) NOT NULL,
  PRIMARY KEY (`CustomerContactID`, `Phone`),
  CONSTRAINT `CustomerContactID`
    FOREIGN KEY (`CustomerContactID`)
    REFERENCES `CustomerContactDetails` (`CustomerContactID`)
    );

-- -----------------------------------------------------
-- Table `AuthorContactAddresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuthorContactAddresses` (
  `AuthorContactID` INT NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorContactID`, `Address`),
  CONSTRAINT `AuthorContactID`
    FOREIGN KEY (`AuthorContactID`)
    REFERENCES `AuthorContactDetails` (`AuthorContactID`)
    );

-- -----------------------------------------------------
-- Table `AuthorContactEmails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuthorContactEmails` (
  `AuthorContactID` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorContactID`, `Email`),
  CONSTRAINT `AuthorContactID`
    FOREIGN KEY (`AuthorContactID`)
    REFERENCES `AuthorContactDetails` (`AuthorContactID`)
    );

-- -----------------------------------------------------
-- Table `AuthorContactPhoneNumbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuthorContactPhoneNumbers` (
  `AuthorContactID` INT NOT NULL,
  `Phone` INT(12) NOT NULL,
  PRIMARY KEY (`AuthorContactID`, `Phone`),
  CONSTRAINT `AuthorContactID`
    FOREIGN KEY (`AuthorContactID`)
    REFERENCES `AuthorContactDetails` (`AuthorContactID`)
    );

-- -----------------------------------------------------
-- Table `WrittenBooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WrittenBooks` (
  `AuthorID` INT NOT NULL,
  `ISBN` INT(13) NOT NULL,
  PRIMARY KEY (`AuthorID`, `ISBN`),
  INDEX `ISBN_idx` (`ISBN` ASC) VISIBLE,
  CONSTRAINT `ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Books` (`ISBN`),
  CONSTRAINT `AuthorID`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `Author` (`AuthorID`)
    );

-- -----------------------------------------------------
-- Table `BooksCategorized`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BooksCategorized` (
  `ISBN` INT NOT NULL,
  `CategoryCode` INT(4) NOT NULL,
  PRIMARY KEY (`ISBN`, `CategoryCode`),
  INDEX `CategoryCode_idx` (`CategoryCode` ASC) VISIBLE,
  CONSTRAINT `ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `Books` (`ISBN`),
  CONSTRAINT `CategoryCode`
    FOREIGN KEY (`CategoryCode`)
    REFERENCES `BookCategory` (`CategoryCode`)
    );