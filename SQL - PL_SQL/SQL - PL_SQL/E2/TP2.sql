SELECT LPAD('  ',5*LEVEL)||Nom FROM EMPLOYE
START WITH  Nom='Ramirez'
CONNECT BY PRIOR Empno = Chef;




 
