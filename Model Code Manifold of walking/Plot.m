col = autumn;
for ii = 1:(t_steps/SegLength)
    int = [(ii*SegLength)-(SegLength-1) ii*SegLength];
    plot3(Data.NPCs(int(1):(int(2)-FreezeP),1),Data.NPCs(int(1):(int(2)-FreezeP),2),Data.NPCs(int(1):(int(2)-FreezeP),3), 'Color',[0 0 0 0.1]);
    hold on;
    plot3(Data.NPCs(int(2)-FreezeP/2:int(2)-(FreezeP/2-dur),1),Data.NPCs(int(2)-FreezeP/2:int(2)-(FreezeP/2-dur),2),Data.NPCs(int(2)-FreezeP/2:int(2)-(FreezeP/2-dur),3), 'Color',Colors().BergElectricBlue,'LineWidth',1);
    hold on;
    plot3(Data.NPCs(int(2)-FreezeP:int(2),1),Data.NPCs(int(2)-FreezeP:int(2),2),Data.NPCs(int(2)-FreezeP:int(2),3), 'Color',col(randi(256,1),:),'LineWidth',0.25);
    hold on;
    scatter3(Data.NPCs(int(2)-FreezeP,1),Data.NPCs(int(2)-FreezeP,2),Data.NPCs(int(2)-FreezeP,3),'filled','MarkerEdgeAlpha',0);
    hold on;
end
axis equal
box off
