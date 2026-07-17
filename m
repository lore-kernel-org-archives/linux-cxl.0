Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA632BD033
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324420; cv=fail; b=nFXslkPgUnWKmxgnTdoQO0CVxv4E1nA9bMnRlCugX3Dg4k0DImoZgOD8PqusVh4lLxkspeVHtb/e1jcAaeisS22EnyxUP3qaLY3HPvIed6osI3sUkkgEO4sDuRsu9Ccs3R24ekCKs6dVjLsS5udk1Qf7wOH0oHbJHcd6WcWSuJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324420; c=relaxed/simple;
	bh=OtMzhyi9xh19FTvFhmrhrr3pKz9WDcc6vS9yDAx0Wkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N1HoclOZALt9QgH0WcCzM83Gs7kMeCunu/2EcSnZ59Cg4R18vpg9gpjrWzFaIgdOdUR7UuMt34cW+0AGIlFkudgCU7z57fPmupHLwULmOY072hTrqlWf3NLWHyMawMxCzyTzZB6H/F1dHUo/x+HFGYJar7NzWJiWENcUZv0M1gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ/1eLzi; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ/1eLzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324417; x=1815860417;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OtMzhyi9xh19FTvFhmrhrr3pKz9WDcc6vS9yDAx0Wkg=;
  b=KQ/1eLzi4Ly6z3XbxEScrQM1nm6Mur5mwPydftpz6ReS9BJw7BcmIgP0
   uywUyRJTLW8c9CcmoOBssW0eZBLhMGjjMmpP8vfmaLDsyRBF1biIPax/3
   5SU5+Av8ZR9awxDfa1ln8eHSz9UtbHzxTZtDU10WQx5oQs/q8JOJtji41
   GsfTfagycw/dWpQXknMZ46aghAUEf7AnIFgO0RSJpzr+AJY3ivOWNTGkc
   5KscUeXF+EXum+S7W0f4adquoFvTJDAMco1oIaJfjSYhwDM35+ujAz1wb
   moTXuXd7Io6nma4zNEs4eYdc6V/CMzu3ban+LTZtwxJ/XundePhWpRGmd
   g==;
X-CSE-ConnectionGUID: w3ksbHYUSrW31Q4i8PbI0Q==
X-CSE-MsgGUID: S3HG/OBdROWAEDbKHfmPtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95356368"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95356368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:40:17 -0700
X-CSE-ConnectionGUID: W5VMh1GdSU+f+aU15jMG5w==
X-CSE-MsgGUID: plgoNDvATmWndflj6UcoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="257532484"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:40:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:40:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:40:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhR8Alw4meay06LgstDvQjQISBqX1X4Y/HQIbxTKTUWCx193jO3yQtfPMXd1zqId/JS3rPc2WrPfHjy5L4MRtIDpYXM8iWLHKIvZWcFoBIkTfTNOkmVHd2kG5GuSNd7Fu+wgSlvk/bqjNB3J9XoBmY5c6OvGBwGOLYxt9ZuK93wG9EQwuUypxNM8KN1Ol0vL14OkVUigIpQ2ho7Yn3wN6uNqK3NIN/U76NK7Fb7lqpa4t8yZ7zXoWoJOFENtsVM70eXGLvQpJruNK4tIU/n+LWuaaW8wCHwdxo/NK/ViAuKDyDpIZrOawpRbFenwsXolwgAtcCCKC65miEbNKeTWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoupXDXW/8A46GadY/SCDNyGj3g2/TWz0VIQF2t6RPc=;
 b=WOZE2qC+imCcuf8HsCLCyYDdtAIe+8hCJQz943HZLk1ad0ZAyY+B3qUPLpg5OvlS088iccIQme+1FEaba0M9GxjF0BFKv4oVK+qOqLuH4eE9wYjanRDuGIasG9CvVtbfpIizQaCwotsPP+qSQGyRwtLSrSfPAG+EuBWIhH31ml54/L3WVLnV6dPeKm/jAFNjULlPPu4QIZmBJ0X1f4wgnbJajsJgSMWLaSs7Vzsa32FpMAfDMZUPOZGaNTRxd5Jh+CnyNeqYvjMVWfbUm1Xv6Yf8x5kcCMbmp0guC7x/xNPlNOXoV08BNgDu3NyhjAhXXl8WuPe8EoL7bEh8029bRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 21:40:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:40:13 +0000
Date: Fri, 17 Jul 2026 14:40:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <sashiko-reviews@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Message-ID: <alqhOsrokyGrt1_1@aschofie-mobl2.lan>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <563095ff87e66b72651c15248a1a6dd6f5ddc3b5.1784150131.git.alison.schofield@intel.com>
 <20260715215706.A76341F000E9@smtp.kernel.org>
 <aliYaE7AMyHfF791@MWDK4CY14F>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aliYaE7AMyHfF791@MWDK4CY14F>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: c5263900-8bab-4387-b1ed-08dee44bfb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|5023799004|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Teb94FT5ZmvEr8funE1e3lPhimzpaUJ/wMbGwplzhwzsqF376q67INcP8L2/HiotVtvbRmLO1orNTCLfADkUeLW03z6N9rYnZfaiElnDJIxqo+7q4z042/W6QWxzXZIc85mb0vq65OkutK8ktBip11vKmFBmm4isa3/PbxTv5J9koIWGhclp9qDIU4SEf8eraS5DfzfSSo356ToaYQVTVnSBbz0oUqkuHea5sXzHTwwPxjt99/suosT7paXdFV94tnQSQKBk7c4XxpxUKQpDUKE2+fAtBKjmTNxfILE3dEhzA/hoSkggtQvtGv94nhZLCGFwBpGDyyZDCrez0zAVPCGxSK+5HVGArLyoG/yAeUBEYnKXp4HDhnoK47neXJiTRdr/N7EXklapre6LSZOl9cV1mIC5GHI9EmuvEpSQtKWGkzF3PV0rQs4r64xf6R1QRwjARDHluoHuov85cst1nmIJ6pfQjPWEGx2ZIoS2hAnlJ9jxQjyRELfBHbEhbNFa4FZkbXaYGuCNRkgJOMxTH59NL6rePrkhnKN/XOibOloyVDUgm5h3R4hQmtpZDocmo6/gclgvex9+TbNWNhkOOLDt8vUgtlr3wFduzSHpyXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bSijd4WtNHMIBjMXMGVn87HTmLRIgMGkgcD+gClCqmKYdx2T8wottWds10?=
 =?iso-8859-1?Q?YaieO72QM3JKMvAB40zZoq0f9Q66sAH/fy+XqVmrJ19+k6qRBlXUDumxX/?=
 =?iso-8859-1?Q?ld4VdsQGvrHoCBxWJ66PkOOeqlmJEaGA7zPs51ETx/cQ73oWC8V7m5o6Qh?=
 =?iso-8859-1?Q?5ojfy7oCj8vOhHzNfKUo5XHZRlHzlC61sc70EeFd9Ojr9jNyHw6e3D9krK?=
 =?iso-8859-1?Q?/wBOX/eDqfHFrD6dRJZsnytg7The2eobZ5cjyMi6ajrIyMvVDjo07EsgXJ?=
 =?iso-8859-1?Q?cmGcIBJ5nTEqWQOcH7JabUF5pLvR/yzE6Y69thT6Zp/WGGhiCXgQNnOEeW?=
 =?iso-8859-1?Q?02UXfLRXnPG3IHQBPs6r/1kCmltKubut+FA80JF0LCYV3U9OM9DwwtkEkR?=
 =?iso-8859-1?Q?ZsplfHISoJVjuhJBTh/JcAwfrj79cjbDO5Z8zHw0ZfjToxTVJKBmbpG9/a?=
 =?iso-8859-1?Q?NfoYvJejzaviFhSM7LNFxt5iyxzWpiLf1cvqv8b1qyby++QH1Xh+EPHwYh?=
 =?iso-8859-1?Q?/CNfeEYKC3Npzn4rpSSInxbzCoQimO2UbZTpba1QhWa1nPICIpU0tY5V02?=
 =?iso-8859-1?Q?myTMdL9f7/K1y/ise0AUYAfL7cwk3Vj54cNqlolqq/DQk6glsEpXE8zbii?=
 =?iso-8859-1?Q?2x1ba73efrcpQtdJtE/3rVzz0z5je9SneqpD8pTI2zS83D80kmLWfYfCfF?=
 =?iso-8859-1?Q?dgmtrni2B9Wxfiw29XRQNyrB1wlyvm0JEFAmFc6zRclxG+wN41mb8Bu0FI?=
 =?iso-8859-1?Q?zDme8+a3qixwUOZcRYoyi40paasiNxKqzGhlDEyqxDuFwQAYrWsnvrNW9j?=
 =?iso-8859-1?Q?W5tHe/jrRAArwY904nJtAtV1v6OYcW9eBSHTiONlU0Bptjp/r3Kogcq4Uj?=
 =?iso-8859-1?Q?sE6m04IfC7T2mi3ctQFXfQBTIKb6oZwIvmiH68oRp4WMNdR04ntTOXlxCn?=
 =?iso-8859-1?Q?9KJeci3NRN3ba7mb9RrRnZw9DfKwAyALwMw+wxgKv+eSTyJJ89ln8pP95B?=
 =?iso-8859-1?Q?a9DuxLkj92A/NGgOB067J1YHn5GEMN2nrkEd5/jeiv+OXXD4w/DeRmkCTI?=
 =?iso-8859-1?Q?e/nOotwQ98qs7nqkdwcjvlKjI1XDp/WmvrBOBAzTZxgCqJX2HSvD/zpSbp?=
 =?iso-8859-1?Q?1+7dcD4IKUlUCTMggbXVNuYfzzbO+FtrOoStAZpwipElwwY7eZ27xgszj5?=
 =?iso-8859-1?Q?Sd/DrdKY+HEWfxW9tu9mhS/qn7ZHYxe/rfr6gTV4jZTFSq2gGDY8eFnZcZ?=
 =?iso-8859-1?Q?Niq2P9mNPp8gWiN1YeMahh8t0gQ85Skgr6NXf9Xf3+ZK59As1du22lwWRH?=
 =?iso-8859-1?Q?DWR8GRv2NVuQlO593SJ4FpnbzNig7ywBiaRja1wQ75N2feiG8qx0w9cvWT?=
 =?iso-8859-1?Q?LxKKsOlTvJBkYAo692+7F97Ik5XDqHvmisnp9OIKbnq4uYVFHtrF+Lewxt?=
 =?iso-8859-1?Q?sfrPo6UPKIuIlwUmfKSvs4qIEctxfu5qOnHp8aZvgDPbMC7HQ0R2iZ9j2a?=
 =?iso-8859-1?Q?vR72JPcniATggnCLgkX4x8qtiDf0vV0mmz+qbuBBTbQXwfGnbgY3qJ551o?=
 =?iso-8859-1?Q?5bZ99dTsknRVFPSBRcj23LYY4rYzgz2HYoXTKGMxqAbxGmdU5xBIQOe0Mv?=
 =?iso-8859-1?Q?3ic8WwlBz4euYOZSUkDatlO+1WE+JznEiSCFG/YhjNxjkisIm/bg2/bKHP?=
 =?iso-8859-1?Q?rmHgU0JPAQOpTiHNenXP+nO4+sheCfUTi7xRtReeud7YX37i9DbOWAwHTT?=
 =?iso-8859-1?Q?eEAy3xEiIxh7Bih3o/J7wRV/BpLcJYyL/5Jsdfz3CpZI8VjWJW66eRSete?=
 =?iso-8859-1?Q?6G1fO8WwThho7cVJsTSlsON2zb9nHwU=3D?=
X-Exchange-RoutingPolicyChecked: rphDedretXUKcC/Iu+BOU7iWEl0DauTgIwX9lakLebRoJvnmKrOTf7HLvDvPvfI9+mZf/jwhEeemhRnihbpYS36CsAO8o2ImD6lwGcz63ee4MMu9yIRXdXCmZ72OLcRrMM+lKY/KdsT26e/qXbxLiNQR0NVCpE9tuyce6zFFqsrgI7TUlvEyBjQ8lVC6XOTVUR7FXJfhOC8xtD/MdtBT8tMXWBzQeirnrH+AwWGrSd2idiVofW3RY9dX4+KeB9/y0zb4vODaUyKBfw7jEg7TEZXSN9RkL26NB6NzUV4dkEhBdVZpu2S0Uvsngbhh/lBmEJU4klb7oyIcsxJpoAPjcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5263900-8bab-4387-b1ed-08dee44bfb96
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:40:12.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRxc9WmUfBlBfftou/ccNrmhtOENSLvEmu1Y0xkQ7MM0C7k9I+nd3Uep7XMqvD+m97mhGAM99LQtP3t4ge35d04b9GOjOWdyrL4J38lpx94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 04:41:30PM +0800, Richard Cheng wrote:
> On Wed, Jul 15, 2026 at 09:57:06PM +0800, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Mixing goto-based error handling with scope-based cleanup helpers (`scoped_guard()`) in the same function.
> > --
> > 
> > --- Patch [3]: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails ---
> > commit fee00b887a5dc8f3c4c335d03db77d2ecce10947
> > Author: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl/hdm: Restore commit_end when decoder enumeration fails
> > 
> > This commit restores commit_end to the none-committed baseline on the
> > enumeration failure path so a subsequent probe can enumerate cleanly. It
> > also protects the commit_end advance against concurrent readers in the
> > DVSEC emulation path.
> > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > 
> > [ ... ]
> > 
> > > @@ -1198,7 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> > >  				dev_warn(&port->dev,
> > >  					 "Failed to allocate decoder%d.%d\n",
> > >  					 port->id, i);
> > > -				return PTR_ERR(cxled);
> > > +				rc = PTR_ERR(cxled);
> > > +				goto err;
> > 
> > [ ... ]
> > 
> > > @@ -1220,17 +1223,23 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> > >  				 "Failed to initialize decoder%d.%d\n",
> > >  				 port->id, i);
> > >  			put_device(&cxld->dev);
> > > -			return rc;
> > > +			goto err;
> > >  		}
> > >  		rc = add_hdm_decoder(port, cxld);
> > >  		if (rc) {
> > >  			dev_warn(&port->dev,
> > >  				 "Failed to add decoder%d.%d\n", port->id, i);
> > > -			return rc;
> > > +			goto err;
> > >  		}
> > >  	}
> > >  
> > >  	return 0;
> > > +
> > > +err:
> > > +	/* Reset to the none committed baseline for a fresh enumeration */
> > > +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> > > +		port->commit_end = -1;
> > > +	return rc;
> > >  }
> > 
> > [Severity: Medium]
> > Does mixing goto-based error handling with scope-based cleanup helpers
> > (scoped_guard) in the same function violate the cleanup subsystem guidelines?
> > 
> > The documentation in include/linux/cleanup.h notes that usage of "goto"
> > and cleanup helpers should never be mixed in the same function, because it
> > creates confusing ownership semantics and can lead to bugs under future
> > modifications.
> > 
> > Should devm_cxl_enumerate_decoders() either be converted entirely to
> > scope-based cleanup, or avoid using scoped_guard() in the error path?
> >
> 
> Hi Alison,
> 
> I think this finding is real, at this point, decoder added by earlier loop
> iterations are still registered until the caller's devres unwind runs.
> 
> So resetting commit_end here will create a window where those enable decoder
> objects are still visible, but cxl_num_decoders_committed() tell us it's 0 there.
> 
> I think the commit_end reset should be ordered after the registered decoder are removed.

Thanks for reviewing! 
Agreed, that's a real under-count window. Resetting commit_end on the failure
path leaves it at -1 while previously registered decoders are still visible.

v3 follows your suggestion and moves the reset into a devres action that's
registered before any decoders are added. Since decoder teardown is registered
later, devres unwinds them first and resets commit_end last, after all decoders
have been removed.

To verify, I instrumented the cxl_test mock enumerate path (which mirrors this
fix) to fail after decoder0 commits and confirmed the ordering. The failure path
leaves commit_end unchanged and the reset doesn't happen until teardown:

endpoint11: DEMO: failing decoder11.1, commit_end=0 (not reset here)
endpoint11: DEMO: devres reset commit_end=-1

-- Alison

> 
> --Richard
>  
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1784150131.git.alison.schofield@intel.com?part=3
> > 
