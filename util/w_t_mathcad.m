function [rmass, resangle] =  w_t_mathcad(z1, z2, fmass)
% Copy-paste of MathCAD code. Do not recommended.
    if fmass < 0 
        d = z2 - z1;
    else
        d = z1 - z2;
    end
    rmass = round(abs(fmass).*abs(z1)./abs(d), 1);
    rangle = wrapToPi(angle(z1) - angle(d));
    resangle = round(rad2deg(rangle),0);
    tangle = rad2deg(acos((abs(z2).^2-abs(z1).^2-abs(d).^2)...
        /(2*abs(z1)*abs(d))));
    fprintf(['!���������� ����� ������� ����! \n', ...
    '���� ����� ������, ��� ��� ���������� ������� \n' ...
    '���� � ������ ���� ���������� ��������� \n' ...
    '��������������� ���� (�� �������� �� �������� \n' ...
    '�����, ���� ���� "+" � ������ ��������, ���� ���� "�") \n', ... 
    '����������: %0.0f', char(176), '\n'], rad2deg(rangle));
    fprintf('����� �����: %4.1f �� \n', rmass);
end