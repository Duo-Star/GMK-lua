--没人要的💩山


local lambda_=g1:getIntersectPointWithLine2d_lambda(g2)
local p={g2:indexPoint(lambda_[1]),g2:indexPoint(lambda_[2])}
local dis={gtp-p[1],gtp-p[2]}
if dis[1] <= dis[2] and dis[1]*graph.lam < 75
  if lambda_[1]<lambda_[2]
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
   else
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
  end
 elseif dis[2] <= dis[1] and dis[2]*graph.lam < 75
  if lambda_[1]<lambda_[2]
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
   else
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
  end
end


