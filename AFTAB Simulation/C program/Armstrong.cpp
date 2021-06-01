 int main()    
{    
int a, n=371,r,sum=0,temp;    
    
temp=n;    
while(n>0)    
{    
r=n%10;    
sum=sum+(r*r*r);    
n=n/10;    
}    
if(temp==sum)    
a=47;
else    
a=89;
return 0;  
}  