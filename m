Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1154779
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198774; cv=fail; b=RZCwgyxRCb23EgTZosO5OVHh5oGo2d/ThzGleBIr1edjIsKxHae7ipXpWeFg/9SYPcHEmZFxL6dlHL5cuthk4VQvlJ0XGnxqxObY8CRPtCd84GksmLQDAaacXd7Y4Es7aBt7pBZVn/0L0L3N/5ejPjXSUvakli8Y+r2inNYMOPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198774; c=relaxed/simple;
	bh=JSfUW8yqv+C3DZgKXuav7VWSmU/DUy4DFUuF6cKqYPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9cx9qzZgGTeZtcyh3TJnvhSKchRqlViprCtK9tx62+zxVWf4a2KC+qX6BlXE+pewInMbrwVMEcYpoq0rgesqgeAfXTlw+vv69ggCI5qyakLQAWb2pJSQbc+7sInZYjoDIumvjTHw5b6uf6czuKQ/8C7d8r7BR2NeYK71JB9KQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+UlWIbB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+UlWIbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792198773; x=1823734773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JSfUW8yqv+C3DZgKXuav7VWSmU/DUy4DFUuF6cKqYPA=;
  b=I+UlWIbBPzl66UXIke6Rfhs+xkSux2xR2CEu7ye1hEmSBf4T2Q/yb2yU
   JBFptynM+86uJ/SqnaIKFPIUZMf4qmqfWgGX+XW6pbPAojxTLvggpQz/U
   djJ0yyTQ3+mJNCpRgGpKa3ghhus24C+GM924Nhdon2fURjug3T1iJoS/h
   /jXNtxWHA2u4KxSKjUams+v7NX1LJimxN9grU5BnlefRJJgBbiPM7oTC7
   Kf+oYBpXMpczUrOVcVAtUkCRvu+/JkLRuZrLaENPu/W/vRvAAuzSx4Bue
   /yEUrOlxsw/gOBSNHESJRXeVQz47gn/Jf9QnzocltCwAvvBo6gsvNpjVC
   w==;
X-CSE-ConnectionGUID: fYgzwzN6Taec3UpF3e8oWw==
X-CSE-MsgGUID: /tbrRXPVQri/jbuLA+6uJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1006719"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1006719"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:59:32 -0700
X-CSE-ConnectionGUID: dfoJcsMPT2SDGrCTs4ed6w==
X-CSE-MsgGUID: hTV3NbyDTSu5o2LIS7X4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2147420"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:59:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:59:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:59:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUpLV6TNHeJx5a7rjVBRgqRv5Xy6nxPM8vUlJGYKk5lF3ioIaal7dnswsrkBUY9jAwSYdqVdXs1INJAA4NYuPLifW1nxxTUZc7KRow3cCeU2O4L8yUqMSKtBo2GqOxIM0PDhcVFI4p54aHfkNlKAZNEzoh7fb2shwf3Yb4P0Ebe6Ny2BoFkSRBSgRPhR5FaCfQIUN0EAVke2ovz96VliHF2uWujBzFFZ8jbDf2bNOIFI2Av/prLtPCXxwY1auWHmqkrc22s60WS7EugsqhzkeTYq1GTUJZKBk6bkvWzlde54kgmSDU1d0Ld7D9gpPM3N4YExujVvQae7QRz0t049uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmjqxBCgfAPxeqtavxKoh7YyvA+JZceXtTwElahfKOo=;
 b=V06cPTV2CHMwIuYDKLl9fmkOCST9zDzoSbMt8UPyiaxMMcappVf+fgGwde4/JOzJd4/2O/LfSE8+ysODiaEWV3OxjpDo8cyojdVr12OqPDjVJSZhMP07R6APGu0mcFOLZ7Tc9fdK467VSfKLvCp8eXNFuwfCe3e83MHCfAPuuEIl+N5iTLERcwi6op266X3gsu/yS2t7MNR2gHkQgrbuSoy6hTdqIl/c/ErHlnueF2LsV7j3C8XU9ohcDz1H9qo82tv9QP96/maL2O+YcLBqNLerMg6zygMP/xb8BLyDZ3Ba0E62mVnhHk2wpd4WMgv0fknETMwUyflFCjBy8mpzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CC6PR11MB964443.namprd11.prod.outlook.com (2603:10b6:170:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 00:59:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:59:27 +0000
Date: Fri, 16 Oct 2026 17:59:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] cxl/region: Factor out
 cxl_switch_port_add_target()
Message-ID: <atLIbOE7kKmriBXj@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
 <20261016195623.59453de1@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016195623.59453de1@jic23-hlaptop>
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CC6PR11MB964443:EE_
X-MS-Office365-Filtering-Correlation-Id: d065d494-2d38-4c09-43ab-08df2be9e4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: hwF7RCM66cyq/jV0skqiSXmjZVNsZaym2/EWWNo2XrjubjCnBKRBP2h/tH4VlmQvczXjYX8x4Wpsi+AuOdnLRiSxIvdq4WWmk4vcvR3wha/v3jQmLOE/uw6hvX6P0zdO7rnaQyO6FRT9qr18vIaygFBx6hHnVDjjvIb3hv8VVwqWDukSdBxp7+w0aeqE+zjIyGGGKsZ4QjNzT29MBkg7jaAPwZOrT2WSlJHFUD08HNIyb4Om4wGgKbEz6oPHR5MA0jYxcKvsbIujRWFvMHK0MNE065rFidoQHpA5SWWtrarvhqTAHbbondyX25gG+ECAqUZEBE/fbLZI04zwWcoOV1qrxLBYtuPjQI+ubK/VJul7MIVgxRRroLfELqy1nHvOUssCPv+O2CIqSaSKRvmkREsgm7C8UM6KsCPVTh+hjuappJzuJ1AsWEzD6aHY2SJDIWqwS/XFe6ngduUecIftlERiYhLRARX+vqEdtLZzrhquTJ0BZTCBJmMro7fTKKNyelQAbdhTmCjCQMRcUtIw4oNtqoJVeo/9svwstGl6q+8Mj3z7iItymqNvOEy9f2QjFsWOyOKVqCowO5n+pzJqRAS6GKfUzL3z6+1ME4Zl0QfsflrV9aTZeZ64PSoQ6Ccn90UF4Rn6vbp5RBHT/NhRNzo6bZmjMTOcjWnF/X7Pb+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dLvbIMlF06k94KKxoUjvS37LutSWqCztUXy5xg9j7D60HZb/WSyh4Dd3TMw?=
 =?us-ascii?Q?sdJkQYLmuoDFtTbkvNuBYURBpcW/VV3gz9f8NwTMvIjHp+FHMgS2XOV3FmkT?=
 =?us-ascii?Q?aEnyEwW2AmaNVeovuwefEqY8vc8j9CeutzaR0/TGizJjbQT7RFkUn/hx3qFb?=
 =?us-ascii?Q?j4NqCmd95EXK/qUtCjKUwN5F3G4mPsYV5qmuE2axKfdALNtC1BpqXaeGbuoS?=
 =?us-ascii?Q?1/ZdNTuvdEbAAlb+BiGA0bY+Z3wLheDOTEv5mG0Rs9cT0s5oQxdfYosuGU/k?=
 =?us-ascii?Q?epvK4DjaJcQ32++eO9cmmzc4fEwRD7Fi41JpcjEQEet1zSanLSPaf0gJV5Gi?=
 =?us-ascii?Q?8OVKVJ5LKqrqL7pX45y2zXVRCoFWISdLFuBmiOpni2XjzUEPTmOssUoNQ0GG?=
 =?us-ascii?Q?6DCP4H1FKZ6U0Aujyaz9C5MvIQpjfME3vMuiXX0p6fX+EcKkPnk29eNivxVZ?=
 =?us-ascii?Q?G33w5xXBy0RBN6O/0GwYj/A2D/KW/xbExfbqBF889h6JihlK42uB1vbMNWlH?=
 =?us-ascii?Q?w7FYX2DGdHASfyy0Lc7Z22RpBUgHub7ml+JDnxYrqPIXV46hddYBqQMDWKZ0?=
 =?us-ascii?Q?ANxArDinrQwPMWl/be82ZKIZ5o92JEzYLVP1+wx/4rV1WTaAGtZ8ROfzl2sY?=
 =?us-ascii?Q?2kTcCX+4+55k+ZRo21TnsrUkfVnLuq3UdWMD+oeIzx+Sum+mNlsSBesS/Vjd?=
 =?us-ascii?Q?B5YjOC8lnkL12WgIwuBwrxCP5KIFo76O+g1mW5jEXUxF/xdzXSPr2K+nutMO?=
 =?us-ascii?Q?XwLIGEqTvVPtLBSPvYKSJg0ahkGc+z9y1ev21pUdgHElEG/zWz8EpXooxTdr?=
 =?us-ascii?Q?8qBw5iTwRtF7bDTzlhNZaZ4n35UTtK2gRraENVa89hVV01SwjEhcyLk/gD/z?=
 =?us-ascii?Q?fepL1sf7BlfFssEm38QaLw4ijdDrvWKK2n//S9fMPDP0KbhtJbKrjmQ77HgF?=
 =?us-ascii?Q?C6SnPkJWbCP+4ndUKhV+LOZgK1yVlxsryw3KgMnObLpi3vXa18kp48CnR1SX?=
 =?us-ascii?Q?ccaZbnXSTZdyE+uUCuiBlAeHnKMxLuzVkTN2C8pmLb+YvGKjiXYFMzb7RZ57?=
 =?us-ascii?Q?6EQ9xyHBT/vCDWAZoyRDZO2u3//MGpx/d4xcDWy77l1x5vSsgjZzUlwVK0uB?=
 =?us-ascii?Q?vL9jMyyvyqSvlojt6/F+ivIzEVU8N99SjWKAA6tbPgo6ytR+5AfqtUWwlzBA?=
 =?us-ascii?Q?hXDNEEiMXNNSiamSSweJU+HmIMQHn/EU1LKixxQmQzldvzLrWyRSM07Y19my?=
 =?us-ascii?Q?JotUFDzIaCJRvuxFP45Z7XJk0OsBk+yY3nTRGnUyIYKEF0IHHKbFUCQX8wO+?=
 =?us-ascii?Q?0U98YI4eBB4fNbnGGPKKheHUFPYwHLTvZ9HDJULN411QE9EwoJkTlJe+U/tv?=
 =?us-ascii?Q?OVUXdXwpS8Mh2afpxF0Ndf0WV8Y6VOgtj7AIvsgQ3ggSPbo1XzsNHneWd2K/?=
 =?us-ascii?Q?LQAzuqywk1iESRLjbw8dDaLswXqDextGrru/vcy5xEJanS475MVV4ghYH2rP?=
 =?us-ascii?Q?VtjgSVl9pH/72KHI+QyROxCByaPZro3/RCU5dSwEnAlSrFhCKfVqFMgFeg+w?=
 =?us-ascii?Q?LtBz9vgEnbxuFFqiye7M7WKaZ67n1kI8XxWAhSv74XcDEFBLPr+Gg+5P4tIb?=
 =?us-ascii?Q?gUu8Q7c07XtQIdRZMdue5J1F97ZhZhL33db3oPcrcQQ5K+dZwjs8SaFtR/oz?=
 =?us-ascii?Q?SpzxhKT39eHVxqrX0Rmw0O5RiDKo1C7LpCcfxPh8Zizt2yrLfv3BM1wfIWZu?=
 =?us-ascii?Q?6+V9/5Eptj7bKogOG6+xwoJdad0yneE=3D?=
X-Exchange-RoutingPolicyChecked: IOeooszzpjiF3tj4Y/JvyRh+wgstkIuljtZXRBWsAXNX0oGn/QPAgtjkhoU3XQIKAdN8RPuTUVnc67pD0uicM3W0GW4QdgP2KeTspt60riwHC6AsK6uz8vhuyeiD+0OWxB2wYMLraiAlhMoeuEtx0ZmEcBjIW0ZDRWaTOHM1e/mcD5MSiPds0UI7sX/6PdxSO7v1aIgOMMMj4vGoDQUoPVcmCUOSn7N4YGnaQapdINeLPI1V6nkfwQmElseCsQ7BOaSmUDL4plKmc750oxr35d0SkHjRU92zrFL8AkmrR9A72PJV+cx1IWrEgIncK/GWPpZu4bCFWD7CjrwJ4UgAPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d065d494-2d38-4c09-43ab-08df2be9e4d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:59:27.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpRJh4SmglfrDdRpOsOE3V2Sh10PiVF9VWXVIkAAVMMwoJMpjpvo1xu6XqTAIf9D41hQpO4KYYqCtocgdQ1QXTm24V+xSB8KI1poZxngUFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB964443
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 07:56:23PM +0100, Jonathan Cameron wrote:
> On Mon, 12 Oct 2026 21:26:03 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> > port's decoder target list. For an auto region it checks that the decoder
> > already targets that downstream port at the next position. For a user
> > created region it programs the downstream port at that position. That step
> > is open coded behind an add_target label that the target search jumps to.
> > 
> > Move that step to a new helper, cxl_switch_port_add_target(). The helper
> > takes the switch decoder whose target list it updates, rather than the
> > port, which makes its scope explicit. With the decoder setup and the
> > target add now in helpers, the path for the first endpoint to reach a port
> > becomes an else branch of the target search, so the add_target label is
> > no longer needed.
> 
> That else doesn't really have much to do with the helper I think?  It is
> an unrelated change wrt to the helper added in this patch.
> 
> Maybe I am missing something but to me looks like you should split
> that bit out.
> 
> Otherwise, LGTM
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++---------------
> >  1 file changed, 49 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 229372123271..50f4830c225d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
> >  	return 0;
> >  }
> >  
> > +static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
> > +				      struct cxl_region *cxlr,
> > +				      struct cxl_region_ref *cxl_rr,
> > +				      struct cxl_endpoint_decoder *cxled,
> > +				      struct cxl_ep *ep)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *port = cxl_rr->port;
> > +	int pos = cxled->pos;
> > +
> > +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: targets full trying to add %s:%s at %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> > +		return -ENXIO;
> > +	}
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> > +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> > +				dev_name(port->uport_dev), dev_name(&port->dev),
> > +				dev_name(&cxlsd->cxld.dev),
> > +				dev_name(ep->dport->dport_dev),
> > +				cxl_rr->nr_targets_set);
> > +			return -ENXIO;
> > +		}
> > +	} else {
> > +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> > +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> > +	}
> > +	cxl_rr->nr_targets_set++;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> >  					 struct cxl_endpoint_decoder *cxled)
> >  {
> > -	int iw, ig, rc, pos = cxled->pos;
> >  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_switch_decoder *cxlsd;
> > +	int rc, pos = cxled->pos;
> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> > @@ -1641,38 +1676,21 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
> >  					return rc;
> >  				goto out_target_set;
> >  			}
> > -		goto add_target;
> > -	}
> > -
> > -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> > -	if (rc)
> > -		return rc;
> > -
> > -	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> > -	if (rc)
> > -		return rc;
> > -add_target:
> > -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s:%s: targets full trying to add %s:%s at %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> > -		return -ENXIO;
> > -	}
> > -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> > -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> > -				dev_name(port->uport_dev), dev_name(&port->dev),
> > -				dev_name(&cxlsd->cxld.dev),
> > -				dev_name(ep->dport->dport_dev),
> > -				cxl_rr->nr_targets_set);
> > -			return -ENXIO;
> > -		}
> >  	} else {
> > -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> > -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> > +		int iw, ig;
> > +
> > +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> > +		if (rc)
> > +			return rc;
> > +
> > +		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> > +		if (rc)
> > +			return rc;
> >  	}
> 
> Smells like two patches to me.   First one does this else bit rather
> than the goto, second adds the cxl_switch_port_add_target()
> helper.

Hi Jonathan,

Agreed. Split that way in v4.

-- Alison


> 
> 
> > -	cxl_rr->nr_targets_set++;
> > +
> > +	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
> > +	if (rc)
> > +		return rc;
> >  out_target_set:
> >  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
> >  		dev_name(port->uport_dev), dev_name(&port->dev),
> 
