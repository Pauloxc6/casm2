program testmenu;
var
  nr,nf:real;
  ni:integer;
begin
  writeln('Write a number: ');read(nr);
  writeln('Menu');
  writeln('101 - Number square');
  writeln('102 - Half');
  writeln('103 - 10% of the number');
  writeln('104 - Double');
  writeln('Choose the option: ');read(n1);

  if (ni == 101) then
    nf = nr**2
    write('Square number is: ', nf);
  else
    if (ni == 102) then
      nf = nr/2
      write('Half of it is:', nf);
    else
      if (ni == 103) then
        nf = nr*0.1
        write('10% of the number is: ', nf);
      else
        if (ni == 104) then
          nf = nr*2
          write('Double is:', nf);
  end;
end.
