INSERT INTO presenters(name, email) VALUES('Stefan Coetzee', 'stefan.coetzee@uct.ac.za'),('John Keiser','john@johnkeiser.com');

-- Conversion Commands --

INSERT INTO converter(extension, command) VALUES('.pptx', 'jodconverter "%{IN}%" "%{OUT}%";'),('.ppt', 'jodconverter "%{IN}%" "%{OUT}%";'),('.docx', 'jodconverter "%{IN}%" "%{OUT}%";'),('.doc', 'jodconverter "%{IN}%" "%{OUT}%";'),('.xlsx', 'jodconverter "%{IN}%" "%{OUT}%";'),('.xls', 'jodconverter "%{IN}%" "%{OUT}%";');
