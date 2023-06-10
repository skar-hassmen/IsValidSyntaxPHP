<?php
@session_start();

$tmp = 'asdsadasdsd';

error_reporting(E_ALL);

// if (!isset($_SESSION["sort"]))  $_SESSION["sort"]="speed DESC";

$tpl = FastTemplate("./templates");
$data=getrow($t_info, 1);


function my_retrive_print ($subtitle, $sql, $color)
{
global $tpl, $base, $linkbase, $cat;

		$result1 = my_query ($sql);
                $last_ID = -1;
		if(mysql_num_rows($result1)) {
		while ($row1=mysql_fetch_array($result1)){
	  	$rate=calcrate($row1['rate'], $row1['votes']);
	  	$grants = explode(";",$row1['grants']);
	  	$ico="";
	  	$iconew="";
	  	if ($row1['insertdate'] > date("Y-m-d 01:01:01",(time()-1814400))) $iconew = "<img src=\"$base/img/ps_new.gif\" alt='new'>";
	  	elseif ($row1['newversiondate'] > date("Y-m-d 01:01:01",(time()-1814400))) $iconew = "<img src=\"$base/img/ps_updated.gif\" alt='modified'>";
	  	foreach ($grants as $g)
	  	{ 
	  		$gg=trim(strtolower($g));
	  		$gg=str_replace ( " ", "_", $gg);
	  		if (!empty($g)) $ico .= "<img src=\"$base/img/ps_$gg.gif\" alt='$g'><br>";
	  	}
	  	
                if (empty($row1['brieftitle'])) $btitle = "";
                else $btitle = " (".$row1['brieftitle'].")";

		if (!$cat) {    // select max by speed
               		$sql = "SELECT `subcat`, `intelspeed`,  `core2speed`, `amdspeed`, `fastest` FROM programcats WHERE `program` = ".$row1['program']." ORDER BY speed DESC LIMIT 1";
			$result3 = my_query ($sql);
			$row3 = mysql_fetch_array($result3);
                        $amdspeed = $row3['amdspeed'];
                        $intelspeed = $row3['intelspeed'];
		   	$core2speed = $row3['core2speed'];
                        $subcat = $row3['subcat'];
		  	if ($row3['fastest'] >0) $ico .= "<img src=\"$base/img/ps_fastest.gif\" alt='fastest'><br>";
                        
                }
                else {
                        $amdspeed = $row1['amdspeed'];
                        $intelspeed = $row1['intelspeed'];
			$core2speed = $row1['core2speed'];
                        $subcat = $row1['subcat'];
		  	if ($row1['fastest'] >0) $ico .= "<img src=\"$base/img/ps_fastest.gif\" alt='fastest'><br>";
               }



// Affiliate stuff

   $psw_regnow_affiliate  = "&affiliate=17066";
   $psw_shareit_affiliate = "&affiliateid=71547";
   $psw_passware_affiliate = "?196072";
   $psw_regnow_affiliate_ref = "http://www.regnow.com/softsell/visitor.cgi?affiliate=17066&action=site&vendor=";


   if ((empty($row1['orderurl']) && $row1['cost'] == 0) || preg_match ("/psw-soft/i", $row1['company']) == 1)
     $is_freeware = 1;
   else $is_freeware = 0;

   $is_regnow   = preg_match ("/regnow/i", $row1['orderurl']);
   $is_shareit  = preg_match ("/shareit/i", $row1['orderurl']);
   $is_passware = preg_match ("/lostpassword/i", $row1['homepage']) ||
		  preg_match ("/decryptum/i", $row1['homepage']);

   if ($is_freeware || $row1['directlink']>0) $orderurl = $row1['orderurl'];
   elseif ($is_regnow) {
     $orderurl = $row1['orderurl'] . $psw_regnow_affiliate;
   }
   elseif ($is_shareit) {
     $orderurl = $row1['orderurl'] . $psw_shareit_affiliate;
   }
   elseif ($row1['sponsored']>0) $orderurl = $row1['orderurl'];
   else
      $orderurl = "";

   if ($row1['sponsored']>0)  $homepage = $row1['homepage'];
   elseif ($row1['regnowmember']>0) 
     $homepage = $psw_regnow_affiliate_ref . $row1['regnownumber'] . "&ref=" . $row1['homepage'];
   elseif ($is_passware) $homepage = preg_replace ("/www\./i", "ref.", $row1['homepage']) . $psw_passware_affiliate;
   elseif ($is_freeware)  $homepage = $row1['homepage'];
   else   $homepage = "";


				$tpl->assign(array( 
					'COLOR'  		=>$color,
					'PTITLE' 		=>$row1['title'],
					'BTITLE' 		=>$btitle,
					'GRANTS' 		=>$ico,
					'SORTED'		=>$_SESSION["sort"],
					'PLINK' 		=>"$base/$linkbase"."_".$subcat."/program_".$row1['PID'].".html",
					'VERSION' 		=>$row1['version'],
					'HOMEPAGE' 		=>$row1['homepage'],
					'AUTHOR' 		=>$homepage?"<A HREF='".$homepage."'><strong>".$row1['company']."</strong></a>":$row1['company'],
					// 'ORDER' 		=>$orderurl? "<A href='".$orderurl."'><img src=\"$base/img/buy_eng.gif\" alt='buy!' width='69' height='26' border='0'></A>" :"",
					'PTYPE'			=>$row1['ptype'],
					'COST' 			=>number_format($row1['cost'], 2),
					'ISPEED'		=>$intelspeed? $intelspeed :"not tested",
					'CSPEED'		=>$core2speed? $core2speed :"not tested",
					'ASPEED'		=>$amdspeed? $amdspeed :"not tested",
					'OPT'			=>$row1['optimised'],
					'DESCRIPTION'	=>$row1['description'],
					'RATE'			=>$rate,
					'DOWNLOADS'		=>$row1['downloads'],
					'NEWIE' 		=>$iconew,
					'BASE'			=>$base,
				));
				$tpl->parse('MCATALOG',".mcatalog");
                        	$last_ID = $row1['PID'];
                       }  // for products

			$content = $tpl->fetch("MCATALOG");
                        $tpl->clear ("MCATALOG");
			$tpl->assign(array( 
				'SUBTITLE'		=>$subtitle,
				'CONTENT'		=>$content));
                         
	}  // if are any product
	return ($last_ID);
}


	
$catalog=1;
$linkbase = "category";
include "menu.php";
	$sql="SELECT *, cat.name cat, subcat.name subcat, subcat.id subcatid FROM cat, subcat WHERE cat.id = subcat.cat AND subcat.id = '$cat'";
	$result2 = mysql_query ($sql);
	$row2=mysql_fetch_array($result2);

       if ($row2[cat] == "Hashes") $password = "hash";
       else $password = "password";

	$nav1= $row2[overview]? "<span class=comment><strong><p>Overview of $row2[subcat] $password protection:</strong> $row2[overview]</span>" : "";

				$about = "<strong>";
				$about .= $row2[info]? "<span class=comment>Info:</span> $row2[info]<br>" : "";
				$about .= $row2[links]? "<span class=comment>Links:</span> $row2[links]<br>" : "";
				$about .= $row2[tip]? "<span style='border:1px solid #9EC3ED; padding:4px; background-color:#F9F9F9;'><span class=comment>Tip:</span> $row2[tip]</span><br>" : "";
				$about .= $row2[dop]? "<span class=comment>dop:</span> $row2[dop]<br>" : "";
//				$about .=  "<hr size=1 color=#9EC3ED>";
				$about .= $row2[extension]? "<span class=comment>File extensions:</span> $row2[extension]<br>" : "";
				$about .= $row2[algorithm]? "<span class=comment>$row2[subcat] crypto algorithms:</span> $row2[algorithm]<br>" : "";
				$about .= $row2[weakness]? "<span class=comment>$row2[subcat] encryption weakness:</span> $row2[weakness]<br>" : "";
				$about .= $row2[attacks]? "<span class=comment>Possible attacks against $row2[subcat]:</span> $row2[attacks]<br>" : "";
				$about .= $row2[complexity]? "<span class=comment>Attacks complexity:</span> $row2[complexity]<br><br>" : "";
				$about .= $row2[articlesub]? "<span class=comment>Arcticles about $row2[subcat] encryption:</span> $row2[articlesub]<br>" : "";
				$about .= $row2[tipsub]? "<table cellpadding='5' cellspacing='0' border='0' style='border:1px solid #9EC3ED;'><tr>
						<td bgcolor='#F9F9F9'><span class=comment>How can I recover $row2[subcat] $password?</span> $row2[tipsub]</td></tr></table><br>":"";
//	$tpl->assign(	 array(	'ABOUTCAT' => "$about"));

	if (!$cat) {
            /*if (!isset($_SESSION["sort"]))*/ $_SESSION["sort"]="newversiondate DESC";
            if (isset($_POST["sortby"])) $_SESSION["sort"]=$sortby;
        }

       $about .= "</strong>";

	if(is_numeric($pid))
	{

// Program card

	include "guestbook.php";

		$nav ="$row2[cat] &rarr; <a href=\"$base/$linkbase"."_".$row2['subcatid']."/\" class='stream'>$row2[subcat] $password recovery</a>";

		$sql="UPDATE $table SET `views`=`views`+1 WHERE $table.id=$pid";
		$result1 = my_query ($sql);
		$sql="SELECT $table.ID PID, $table.*, programcats.* FROM $table LEFT JOIN programcats ON $table.id=programcats.program WHERE $table.id=$pid";
		if($cat) $sql.= " AND programcats.subcat='$cat'";
		$result1 = my_query ($sql);
	  if($row1=mysql_fetch_array($result1)){
	  	$nav.= " &rarr; ".$row1['title'];
	  	$nav.= " <span class=\"comment02\"> modified:&nbsp;[<b style=\"color:#CE2020;\">".dateMysqlToString($row1[modifydate])."</b>]</span>";
	  	$grants = explode(";",$row1['grants']);
	  	$iconew="";
	  	$ico="";
	  	if ($row1['insertdate'] > date("Y-m-d 01:01:01",(time()-1814400))) $iconew = "<img src=\"$base/img/ps_new.gif\" alt='new'>";
	  	elseif ($row1['newversiondate'] > date("Y-m-d 01:01:01",(time()-1814400))) $iconew = "<img src=\"$base/img/ps_updated.gif\" alt='modified'>";
	  	foreach ($grants as $g)
	  	{ 
	  		$gg=trim(strtolower($g));
	  		$gg=str_replace ( " ", "_", $gg);
	  		if (!empty($g)) $ico .= "<img src=\"$base/img/ps_$gg.gif\" alt='$g'><br>";
	  	}	  
	  	if ($row1['fastest'] >0) $ico .= "<img src=\"$base/img/ps_fastest.gif\" alt='fastest'><br>";

		$rate=calcrate($row1['rate'], $row1['votes'], true);

                if (empty($row1['brieftitle'])) $btitle = "";
                else $btitle = "(".$row1['brieftitle'].")";

// Affiliate stuff

   $psw_regnow_affiliate  = "&affiliate=17066";
   $psw_shareit_affiliate = "&affiliateid=71547";
   $psw_passware_affiliate = "?196072";
   $psw_regnow_affiliate_ref = "http://www.regnow.com/softsell/visitor.cgi?affiliate=17066&action=site&vendor=";

   if ((empty($row1['orderurl']) && $row1['cost'] == 0) || preg_match ("/psw-soft/i", $row1['company']) == 1)
     $is_freeware = 1;
   else $is_freeware = 0;

   $is_regnow   = preg_match ("/regnow/i", $row1['orderurl']);
   $is_shareit  = preg_match ("/shareit/i", $row1['orderurl']);
   $is_passware = preg_match ("/lostpassword/i", $row1['programhome']) || 
		  preg_match ("/decryptum/i", $row1['programhome']);

   if ($is_freeware || $row1['directlink']>0) $orderurl = $row1['orderurl'];
   elseif ($is_regnow) {
     $orderurl = $row1['orderurl'] . $psw_regnow_affiliate;
   }
   elseif ($is_shareit) {
     $orderurl = $row1['orderurl'] . $psw_shareit_affiliate;
   }
   elseif ($row1['sponsored']>0) $orderurl = $row1['orderurl'];
   else
      $orderurl = "";

   if ($row1['sponsored'] > 0)  $homepage = $row1['homepage'];
   elseif ($row1['regnowmember']>0) 
     $homepage = $psw_regnow_affiliate_ref . $row1['regnownumber'] . "&ref=" . $row1['homepage'];
   elseif ($is_passware) $homepage = preg_replace ("/www\./i", "ref.", $row1['homepage']) . $psw_passware_affiliate;
   elseif ($is_freeware || $row1['sponsored']>0)  $homepage = $row1['homepage'];
   else   $homepage = "";

   if ($row1['custombuild']>0 || $row1['directlink'] >0) $programhome = ""; 
   elseif ($row1['regnowmember']>0) 
    $programhome = $psw_regnow_affiliate_ref . $row1['regnownumber'] . "&ref=" . $row1['programhome'];
   elseif ($is_passware) $programhome = preg_replace ("/www\./i", "ref.", $row1['programhome']) . $psw_passware_affiliate;
   elseif ($is_freeware)  $programhome = $row1['programhome'];
   else $programhome = "";


				$tpl->assign(array( 
					'PTITLE' 		=>$programhome?"<A HREF='".$programhome."'><strong>".$row1['title']."</strong></a>":$row1['title'],
					'BTITLE' 		=>$btitle,
					'VERSION' 		=>$row1['version'],
					'RELEASE' 		=>$row1['pdate'],
					'MODIFIED' 		=>$row1['modifydate'],
					'HOMEPAGE' 		=>$homepage,
					'PROGRAMHOME' 		=>$programhome,
					'AUTHOR' 		=>$homepage?"<A HREF='".$homepage."'><strong>".$row1['company']."</strong></a>":$row1['company'],
					'OS' 			=>$row1['os'],
					'SIZE' 			=>$row1['ksize'],
					// 'ORDER' 		=>$orderurl? "<A href='".$orderurl."'><img src=\"$base/img/buy_eng.gif\" alt='buy!' width='69' height='26' border='0'></A>" :"",
					// 'COST' 			=>$row1['cost'] == "0"?"<span class=\"price_cent\">Free</span>":"<span class=\"price_cent\">$&nbsp;".$row1['cost']."</span>",
					'ISPEED'		=>$row1['intelspeed']? $row1['intelspeed'] :"not tested",
					'CSPEED'		=>$row1['core2speed']? $row1['core2speed'] :"not tested",
					'ASPEED'		=>$row1['amdspeed']? $row1['amdspeed'] :"not tested",
					'SUBCOMMENT'		=>strpos($row1['core2speed'], '*')?"<tr><td width=54>&nbsp;</td><td class=subcomment><sup>*</sup> - on 2 cores<b class=techtable></b></td></tr>":"",
					'OPT'			=>$row1['optimised'],
					'DESCRIPTION'		=>$row1['fulldescription']? $row1['fulldescription'] : $row1['description'],
                                        'REVIEW'		=>$row1['rpcreview']?$row1['rpcreview']:"No review yet", 
					'WHATSNEW'		=>$row1['whatsnew'],
					'DOWNLOADS'		=>$row1['downloads'],
					'ATTACKS'		=>$row1['suppattack'],
					'DOWNLOAD'		=>"$base/download.php?cat=$cat&pid=".$row1['PID'],
					'RATE'			=>$rate,
					'GRANTS' 		=>$ico,
					'NEWIE' 		=>$iconew,
					'BASE'			=>$base,
				));
				$tpl->parse('CARD', "card");
				$content = $tpl->fetch("CARD");
		}	

	$meta = "<meta name=\"description\" content=\"".($row1['title'])." - ";
        if (substr ($row1['ptype'], 0, 4) == "Free") $meta .= "free ";
        $meta .= strtolower($row2['subcat']) . " $password recovery. ";
        $meta .= substr ($row1['description'], 0, 80) . "\">";
        $meta = $meta. "\n<meta name=\"keywords\" content=\"" . $row1['title']. ", ";
        if ($row1['brieftitle']) $meta .= $row1['brieftitle'] . ", ";
        $meta .= $row1['company']. ", " .$row1['ptype'] . ", download, ". $row2['subcat']. ", $password, recovery\">";  
        if ($_GET['start']) $meta .= "\n<meta name=\"robots\" content=\"noindex, nofollow\">";
        $title =  $data['title'].": download " . $row1['title'] ." ". $row1['brieftitle'] . " " . $row1['version']. " - ";
        if (substr ($row1['ptype'], 0, 4) == "Free") $title .= "free ";
        $title .= strtolower($row2['subcat'])." $password recovery software";
 
		$tpl->assign(	 array(
		'TITLE' => $title,
		'META' => $meta,
		'HEAD' => $nav,
		'CONTENT' => $content,
		'ADMINMAIL' => $site_email,
		'COPY' =>	$a_copy,
		));

	}
	else
	{

// Catalog 

		$nav ="<table width=100%><tr><td><h1 class='stream'>$row2[cat] &rarr; $row2[subcat] $password recovery</h1></td>";
                if ($cat) {
        		$sql="SELECT servicedata.ID PID, servicedata.* , servicecats.* FROM servicedata,  servicecats WHERE servicedata.id=servicecats.program AND servicedata.submit=1 AND servicecats.subcat='$cat'";
        		$result1 = my_query ($sql);

        		if(mysql_num_rows($result1)) 
                            $nav .="<td align=right><a href=\"$base/recovery_$cat/\" class='stream'>$row2[subcat] $password recovery/decryption service</a></td></tr></table>";
                        else $nav .= "</tr></table>";
               }
               else $nav = "New and popular $password recovery software";
 
		$tpl->define_dynamic ( 'sponsored', "catalog" );

		if ($cat)
		$sql="SELECT $table.ID PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 AND $table.sponsored = 1 AND programcats.subcat='$cat' ORDER BY rand() LIMIT 1";
		else
		$sql="SELECT $table.ID as PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 AND $table.sponsored = 1 GROUP BY PID ORDER BY rand() LIMIT 3";

                $last_ID = my_retrive_print ("Sponsored", $sql, "#E8EAA7"); 
		$tpl->parse('SPONSORED', ".sponsored");

		$tpl->define_dynamic ( 'groupc', "catalog" );

		if ($cat) {
		$sql="SELECT $table.ID PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 AND $table.ID != '$last_ID' AND programcats.subcat='$cat' ORDER BY ".$_SESSION["sort"];
                my_retrive_print ("", $sql, "#D5EAFF"); 
                }

		else {
		$sql="SELECT $table.ID as PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 AND $table.newversiondate>'".date("Y-m-d 01:01:01",(time()-1814400))."' GROUP BY PID ORDER BY ".$_SESSION["sort"];
                $not_empty = my_retrive_print ("New password recovery software", $sql, "#D5EAFF"); 
                }

		if ($not_empty != -1) $tpl->parse('GROUPC', ".groupc");

		if (!$cat) {
		$sql="SELECT $table.ID as PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 GROUP BY PID ORDER BY downloads DESC LIMIT 3";
                my_retrive_print ("Most downloadable password recovery utilities", $sql, "#D5EAFF"); 
		$tpl->parse('GROUPC', ".groupc");

		$sql="SELECT $table.ID as PID, $table.* , programcats.* FROM $table,  programcats WHERE $table.id=programcats.program AND $table.submit=1 AND $table.votes > 9 GROUP BY PID ORDER BY rate DESC LIMIT 3";
                my_retrive_print ("Best rated password recovery tools", $sql, "#D5EAFF"); 
		$tpl->parse('GROUPC', ".groupc");

                }
		$tpl->parse('CATALOG', "catalog");
		$content = $tpl->fetch("CATALOG");

                

        $ext = str_replace (",", " $password,", strtolower($row2['extension'])) ." $password"; 
	$meta = "<meta name=\"description\" content=\"Fast, tested $password recovery for ".$row2['subcat']." with benchmarks and review. Download freeware, shareware and trial $password recovery utilities\">";
        $meta = $meta. "\n<meta name=\"keywords\" content=\"".strtolower($row2['subcat'])." $password, ";
        if (strcmp ($ext, strtolower($row2['subcat'])." password") !=0 )
           $meta .= $ext. ", " ;
        $meta .= strtolower($row2['subcat']) ." $password recovery, "; 
        if (strcasecmp ($row2['subcat'], $row2['extension']) != 0) 
           $meta .= strtolower($row2['extension']). " $password recovery, ";
        $meta .= strtolower($row2['cat']). " $password, " . strtolower($row2['subcat']). " $password cracking, $password removal, fast, fastest, optimized\">";  
        $title = $data['title'].": fast " .$row2['subcat']. " $password recovery software";
        if (strcasecmp ($row2['subcat'], $row2['extension']) != 0 && !empty($row2['extension'])) $title .= ", " . $row2['extension'] . " $password recovery"; 
        $slogan = "Best, manually tested tools to recover passwords for almost all applications";
	$tpl->assign(	 array(
		'TITLE' => $title,
		'META' => $meta,
		'HEAD' => $nav.$nav1,
	        'SLOGAN' => $slogan,
		'CONTENT' => $about.$content,
		'ADMINMAIL' => $site_email,
		'COPY' =>	$a_copy,
		));

	}


$tpl->parse('MAIN', "main");
$tpl->FastPrint();
mysql_close();

?>