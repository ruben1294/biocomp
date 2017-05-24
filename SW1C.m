% El contenido de este script es para realizar las corridas de las distintas configuraciones neuronales
% además de realizar las 20 iteraciones, guarda el Excel con los distintos MSE's y R's
[FCN,F,c,HOV,t1,t2] = deal(['trainscg';'trainlmh';'trainscg'],['SCG';'LMh';'BRh'],1,1,5,1);
NumNe = Neuronas1C();
p =(xlsread('NF.xlsx','Tesis','A2:J3976'))';
t =(xlsread('NF.xlsx','Tesis','K2:N3976'))';
norm_data = mapminmax(t,-1,1);
z=zscore(p);
for HOV = 1:2
    if HOV == 1
        val = 'T';
    else
        val = 'F';
    end
    for c = 1:3
        switch c
            case 1
                [v,testMSE,trainingMSE,R2,rMSE,IRGT,acc5,acc1,nena,pred] = deal(1,zeros(1,300),zeros(1,300),zeros(300,4),zeros(1,300),zeros(300,10),zeros(300,4),zeros(300,4),cell(1,300),zeros(1,4));
                for l = 1:15
                    for i = 1:20
                        [tr,performance,testPerformance,net,r,testTargets] = RedValid(NumNe(l),z,norm_data,HOV,FCN(c,1:7));
                        save(['N1_' F(c,1:3) num2str(NumNe(l)) '_' val num2str(i) '.mat']);
                        % Calcula los parámetros de validación.
                        [testMSE(v,1),trainingMSE(v,1),R2(v,:),rMSE(v,1)] = Parametros(testPerformance,performance,r);
                        R2(v,:) = r';
                        
                        % Calcula las contribuciones relativas de las variables de entrada.
                        [IRG] = Garson(NumNe(l),net);
                        for q = 1:10
                            IRGT(v,q) = IRG(q);
                        end
			% Realiza las predicciones con el modelo.
                        [acc5(v,:),acc1(v,:)] = Accuracy(net,z,norm_data,t1,t2);

                        if l <=4
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:3) '0' num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:3) '0' num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        else
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:3) num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:3) num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        end
                        v = v+1;
                    end
                end
                EW1C(nena,testMSE,trainingMSE,rMSE,R2,IRGT,F(c,1:3),val,acc5,acc1);
                clc;
            case 2
                [v,testMSE,trainingMSE,R2,rMSE,IRGT,acc5,acc1,nena,pred] = deal(1,zeros(1,300),zeros(1,300),zeros(300,4),zeros(1,300),zeros(300,10),zeros(300,4),zeros(300,4),cell(1,300),zeros(1,4));
                for l = 1:15
                    for i = 1:20
                        [tr,performance,testPerformance,net,r,testTargets] = RedValid(NumNe(l),z,norm_data,HOV,FCN(c,1:7));
                        save(['N1_' F(c,1:2) num2str(NumNe(l)) '_' val num2str(i) '.mat']);
                        % Calcula los parámetros de validación.
                        [testMSE(v,1),trainingMSE(v,1),R2(v,:),rMSE(v,1)] = Parametros(testPerformance,performance,r);
                        R2(v,:) = r';
                        
                        % Calcula las contribuciones relativas de las variables de entrada.
                        [IRG] = Garson(NumNe(l),net);
                        for q = 1:10
                            IRGT(v,q) = IRG(q);
                        end;
			% Realiza las predicciones con el modelo.
                        [acc5(v,:),acc1(v,:)] = Accuracy(net,z,norm_data,t1,t2);
                        if l <=4
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:2) '0' num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:2) '0' num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        else
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:2) num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:2) num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        end
                        v = v+1;
                    end
                end
                EW1C(nena,testMSE,trainingMSE,rMSE,R2,IRGT,F(c,1:3),val,acc5,acc1);
                clc;
            case 3
                [v,testMSE,trainingMSE,R2,rMSE,IRGT,acc5,acc1,nena,pred] = deal(1,zeros(1,300),zeros(1,300),zeros(300,4),zeros(1,300),zeros(300,10),zeros(300,4),zeros(300,4),cell(1,300),zeros(1,4));
                for l = 1:15
                    for i = 1:20
                        [tr,performance,testPerformance,net,r,testTargets] = RedValid(NumNe(l),z,norm_data,HOV,FCN(c,1:8));
                        save(['N1_' F(c,1:2) num2str(NumNe(l)) '_' val num2str(i) '.mat']);
                        % Calcula los parámetros de validación.
                        [testMSE(v,1),trainingMSE(v,1),R2(v,:),rMSE(v,1)] = Parametros(testPerformance,performance,r);
                        
                        % Calcula las contribuciones relativas de las variables de entrada.
                        [IRG] = Garson(NumNe(l),net);
                        for q = 1:10
                            IRGT(v,q) = IRG(q);
                        end
                        
                        % Realiza las predicciones con el modelo.
                        [acc5(v,:),acc1(v,:)] = Accuracy(net,z,norm_data,t1,t2);
                        if l <=4
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:2) '0' num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:2) '0' num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        else
                            if i <= 9
                                nena{v} = ['N1_' F(c,1:2) num2str(NumNe(l)) '_' val '0' num2str(i)];
                            else
                                nena{v} = ['N1_' F(c,1:2) num2str(NumNe(l)) '_' val num2str(i)];
                            end
                        end
                        v = v+1;
                    end
                end
                % Crea el Excel con todos los parámetros.
                EW1C(nena,testMSE,trainingMSE,rMSE,R2,IRGT,F(c,1:2),val,acc5,acc1);
                clc;
            otherwise
                disp('other value')
        end
    end
end