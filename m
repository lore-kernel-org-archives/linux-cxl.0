Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1D15C3
	for <linux-cxl@vger.kernel.org>; Sat, 30 Mar 2024 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711763542; cv=fail; b=Wd/bNkMe7lwsvv09MESB4MgemoJiKgf11CFaOrMnlw/OGSS03XtkEW6D8TD3dS/2ghbo6+DRR10jg+muV3FiSpFEDHO33Rl/0qIeSkqei7dlhEjE0xleZAoDLOjihf1nFIhfe+NrPQ+JZjTNCCVHcFn0Ya/PQnjV/mCK5U634RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711763542; c=relaxed/simple;
	bh=Vwh+80qu31KjybI0O5wb+/K5CnoUz7Lo9wVBepNEY94=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwYH1KJyQ3zlCyOgLBKEGEyCa8eEqEf+9JUIbfS+9pwgbhofFPGbOAxPkXT25exNzDiSEVa2InbnIL/2ddO8pr3e5qV0fBgXfm66ZsInKM7Z5rvQMkOlFJvgFsrB5sCnib/StKnPSlwFiCTIBNiQHqNImzSkCcCl9J7F4p7Jn/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiXN1q/A; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiXN1q/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711763541; x=1743299541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vwh+80qu31KjybI0O5wb+/K5CnoUz7Lo9wVBepNEY94=;
  b=OiXN1q/AAa/VIk7jdqApxP/Y9z1i9kTSrYoDuLX5IMM2xxsT2mxH3G36
   Gp5/lsz2rqBnz730ynBI1hl7yH/t/Si4oFje6GPz9hWBHrnU3PHZTK2XH
   o6JPTWOBY8J0WD673Eebkufkd/5J89AuSM1dRm1Ycg3G8L8+xmIzqVj80
   avOKGrQwCG/Gi8S/VxKSbbV2KaoKZrjKY1ec9IYd4xDZkbFIXx3SbRMqR
   16+WfzIiCpUUVejbUzNYzmpTLf6L7l/hdKAQIuqG1bjb4AHoIzb4PIjLD
   SHLX25ih3SrEmnbTIX2zu9jRCObyGWroREOckZA+xhIJqcG2jilN2Botu
   g==;
X-CSE-ConnectionGUID: 7lxWHTs5SvqFuDCRSlOgSA==
X-CSE-MsgGUID: uiE7ctdmT++1BJ0AVmobxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7080921"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="7080921"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17535991"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 18:52:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:52:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:52:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:52:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEXG0NDm91jsq9SIChyUYHs5b6b3W0Bo7zmwE/aXO8rOLsJyFVwl2Tu6MCRn3qAepc6eeB4lC7DMab2z/aNlVTpcZR5md3EEpIiAoANsc3j9pFABWRJh4sabf8xmOJ0bKqPTMrWOEwXg+ftySNsPX2INCEqQudYepPPoRHMepSVIwfyMtlGz5WaL8m4W8rfUx9eCmB0ENBempp/paOzf5z7dZXYEO31iwviY9GfAUZfjCHqXVtXkYkprQOgpwpXQmLJOS7cn3MCMQ1+9PoPAxR1WRDis1n7moWhftGcgKyjQhEaN2Yjg/McfQGm3evf49bXVDwskVgj8A2Nu5eZeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjyh3qRG22nhDa2ysGY6wA8Lse9Quzjv1sJNwA7ZJ0Q=;
 b=HpIOPqBXlCplzTDzOwGaVduoEquowSUwYrcplBFcWoU6YWiLpVBO8XW6yzCfanY/PXBXD15DUyv3VxD8ZGc3QIK3zvLj32gGeHBY7MZQI7UWTFPs79ic2bxUo6egVPg8UxrNRI9Qpxc01ASgnZ/FpteoU63NcLs3SddJX5kM6mnGkyKUJnu9T0lZ7jw2MPld5WSOPPxwtKI/CdurjFnUcUQBDxdwLUtr4hGGW39nZMYnEjdMAuPsuUtO/Ygt3JKvZMbjFdfTQXmVQK88Vkj/i079gVuYr4D114prLK2dRNkkDSoY6WNrCRiAw9DXAuh1lzQG6+ep6/fTasSqlqG6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sat, 30 Mar
 2024 01:52:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:52:17 +0000
Date: Fri, 29 Mar 2024 18:52:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from
 debugfs
Message-ID: <6607704e65437_19e0294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ap0FFh8zq76cPHPFY6BjcTUc+8g+PiAOcQMx8gmZQInz0GzRqEW5nFAO6m3DZ49uoazibeuV9Mhvw6wi495U8sicXVyEfkQnD4mxKWjQFoESkAiBCj9oRY83+DekwIRLj+S4kjdX4WRh3uu9IJ5qj4JtnIYlOZWlMx4Z1VEpj50tUwcPQLPINeLQ/F8QtnYfSVblTXXPG0XfoR18oJyrUfGjaS0URHkT/KTINKIbZEk7+CFja4dGg0xOVUsdenoVdxe7BsbMUfXiwamZ++psr41sjuJtZC642R37x7J2uva+iZboEEQW56bHTVhE0e2XWNXpYrxdND5V+uNWoq0XPKHYXbfJc4Rqp+Ys0oys49QBR5aAVsoTdBVp+fyOxdw0T0tQt+bACBFQABLYl1JBIsljlBbVMygcKif00zQxp2inGcT24hX7EiXLhVjihdGQX5BxIXLPA6p3hxKNyU+ZbNdTbDBmW9AJmSLMOR3hzMHQUITHMitAMkRhOsSJIIj94RGlWOVmtkTaIQOMg4e1P2xH1fL+MuD9MMuMndAZ9elsE56Q+H7s4mdd/kdpe6xJH8qbbpzoxPeVXGkr39lwjbku2GWDW1Y1vxQoazgmYgkOA4AG73HG8FMxL9UKRD1LaBKk81m7uco/8PhSBn61vESLTnZwTE9ditnOT8Shic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8zgce2Obi17vJ1SAhbojD4tJv/5kErwfJhdNUUD6YR/foXfoOy56gu8RG2/?=
 =?us-ascii?Q?nOi8aBu8VZj/9z/cq++L/61TIAiR+LIlmI8zaal5MmVXoSn+4o5F1qwIQ0El?=
 =?us-ascii?Q?4JmnFYNhkmjsT6nGmFf5rG5IZsooxOu5ySAWUqYFKSVFqh6zQIqfEXlTzbYc?=
 =?us-ascii?Q?siXC1p7Ec7G4P+G2YCZqgbrPHLp1VqTywe8axSMDBznyKqVldwI1AiTqNLsR?=
 =?us-ascii?Q?w57X/VnlOQLwKEDBKiXZzhnJX6b/Ylt7i5zquQ5WOOoRu32LfSnsZ+kEosqx?=
 =?us-ascii?Q?/vN6rokR3HHZtBnoBTiH47rvlZYm9OJIeKEUk+81Nh9nor8Qgy7ehtcIEshh?=
 =?us-ascii?Q?CR2+0NMUAAY5n7nAx5HZI/4cZ/y+/fWaMkOqM77GH2DWoZCmXhmMkDisDeD6?=
 =?us-ascii?Q?xWoX3HUmZKz2P1NKDT19D2JCm+i71lXiz/Epshqrc9eFDhHVw4TlTPT3PtFt?=
 =?us-ascii?Q?jjTktj6/FDcrZ1rFPongMVRVWZ2nExJMdKexbWH40NXg9yYT+K0ahltMh+n1?=
 =?us-ascii?Q?pvuHV16nM3tWzknsV4Kvw0Im3NX9KfH88JtHwijJegCeT+wt7dft0+IMhFTV?=
 =?us-ascii?Q?tag4i8XaazHugD7RkSVhVDN1Nz986o30ELJtE0qwGerh5MjO6FRqjLrYQ64e?=
 =?us-ascii?Q?fZ33siPNdRYjwcTA2rn8wrBYDEtWvSxNkgYJQ/1dKf8CPGFORjbnGpP3zUQw?=
 =?us-ascii?Q?EbOVEVc/+poxhrxGXfjGfwyq9ESpuYEH7sk/LNWWfxN4dq+EsTWFcMvQUMad?=
 =?us-ascii?Q?KwNpicsbKiN2IUqu2Zj5JJDTSRBVTPWZ6u6/sBsH/BbtOYlkhu39iDFtOVkT?=
 =?us-ascii?Q?W304TOMCY/KJRYM9FctyAPdQj4SVtHICUr7UxVTmufzT8OgtlcOIGchSTa/w?=
 =?us-ascii?Q?VIYLm0ZmyHD+oPTRFF1Fq0byKV1dQe5xFy620CZkz4QpOIBC847trOcL1mbH?=
 =?us-ascii?Q?mZu9Mi41Ux+25JpVJwZWZnuC+dRGiSuHkjd/p85MVxOWlPN9v2GHoAOa90UQ?=
 =?us-ascii?Q?DfNynIwU5wkElrQ/cJC5fQIOWQ4oeV/agtidVUN2/pnLgNJFecakmmTNIloc?=
 =?us-ascii?Q?bEs6C+qC+yTz5BdQVdKpWkzJapv3j4nEyoSx/2sGTwILGp+uYozFHDWQSzqH?=
 =?us-ascii?Q?SXMAMWOPEKKAiuaW3KddabcrKChcXE6PWkXP649HXyY+Oy1APU2KRy74dSK7?=
 =?us-ascii?Q?QnoMJWrFjan9a9L7aw6kFlrObSoPrbNauAQp1WiI44sowQeNU9KqVk43bcXk?=
 =?us-ascii?Q?jdsp2WOa5WIz6V22W6tt6dM24uHe+XM3C5BB6souSWuN80qQZoLuq0RPBxSR?=
 =?us-ascii?Q?cEmpO7dLMjHla4+3rlcNAGYneUfqgawx3C/egEQz2r9wLRzQojRGRseLGqRF?=
 =?us-ascii?Q?oBWrdY9i0oKSKky+RiPI1UULPU+7ewrAFtmlfgwTe9X+gG/MKcU+xjl5xvY3?=
 =?us-ascii?Q?z6o+Qnj/CI5xwaCT2GGWsPGSFe7pchSU/c9R8aeD0sieUjKUd25GXPDo812W?=
 =?us-ascii?Q?0wGwWSL4BdRYeJoaxqQXTe7g5s8cuS93LhTR8tsxOH7TdkXE0GFmH3WIXtLg?=
 =?us-ascii?Q?h4z56uhZ3ZaieneCy2FUbHC39A7pfqIix2tP2A+nt/voPtAFJOGIEWSfaeV4?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5682e35-8676-4e9e-4378-08dc505c073e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:52:16.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxYERfxrVSLw6nvr/fqP/dw4DlwUjIqMbAQJRBoWhEKMalRNNry3MEQII+I14G41EM5bhhNRbed7asDjuy1zVLbOPIQOEXscsVONQrsU/zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> Poison injection from debugfs is silent too.  Add calling
> cxl_mem_report_poison() to make it able to do memory_failure().

Why does this needs to be signalled? It is a debug interface, the
debugger can also trigger a read after the injection, or trigger page
soft-offline.
