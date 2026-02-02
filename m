Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4628F948
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069645; cv=fail; b=tPgEgLXsFSbymk+jxCFwP7fUTtvVViq44K+OIClyrMGMoj9LtKp11L3bEVoOWySvOfd0/iWi81pNPAk7GHGx0DkBBeYsVDFrSKmChP7f78a6hYuAGGf/D3y43zF8cyLQLnpq2OCB9U/+e2g2InAA08cQ0VzgI1GzJxCg2+QvoQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069645; c=relaxed/simple;
	bh=Te/C43g0ZgaA6HitoXcArnpU5rUgYpp0e7Pl677cDEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TWcIrVbRKDRAC/bmq+Ha/YrBaYZpYQ37IaGkGJzTD+9ltS3IAOonbHorV+n4WNOnCuyZjdDWD2wby87YDYPkgBQP8PJga8xsIhjQFVhPxwBy4b6GkRq9coQXGjBw0il6l8jzLDDcdxgovgbZ5kOHVi41AHK9Y9oXtrYb+bDLhMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfeQBWg6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfeQBWg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770069643; x=1801605643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Te/C43g0ZgaA6HitoXcArnpU5rUgYpp0e7Pl677cDEE=;
  b=BfeQBWg6qU2jGZ8CES7o/6QCtSEAUBiMNe2bLq0Xw2kGv5t24yzGedv+
   ReM1V5Cd/UjRjotGePr4eDokB74dbuIB5GE9HPoFnj6ufqoUNOd3EHT64
   thp9eXFvAueSf5+DqsG1tP0FLI4UJpBcrdjKyj5lDM3y6K9nqYYBFD3IM
   gacFdWxr3IxIMLzXAFVz0u4Y3pUiVSYD5zlH/WOoXycm2SI4bheh9r/Lw
   gXae+ye7MZVvQ0rdxyFAN9rKo65qKOXiVwsuT1q6CAB40uYCEdyWB9IXe
   XS/y+i10KckaNP2aBgH/tGTSWZBtDhOEvymdd6RijEr7aisTPs4cdvMlF
   A==;
X-CSE-ConnectionGUID: 5xx9El3nSF64Dwosey/9zQ==
X-CSE-MsgGUID: D+s6VdYYQKeBPFKiSSEB9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71318349"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71318349"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:00:43 -0800
X-CSE-ConnectionGUID: +aFK7injSGewYAK7ZsDDPQ==
X-CSE-MsgGUID: NmX761v8RlSIKZk5EmqlRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209865083"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:00:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 14:00:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 14:00:41 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 14:00:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKNVl0Te22Cq9bYzFAEC0Ulpdb9pZAReDny8zyicPrp3IWhKrARaNkwRT57GFgjo7j2T9XX+mFhCua5fns/MH4cvGhfxIyfxyXTBymQO9mVK42mMc2rNW6ly/gaGGMCluqSCe1LdqKFM4pelUrIfbBTui8Vr43QT8/IA6TnbKY0/D+E+dIuVdpwS6jfxT5pHOCLeQaViqL8EFNYu/BfDkSY6ZjND0//LOGYpz1LV3iTwmBgG+JMm5FOYOkRenHZziSG+hUOJVYpbJu5VfOasxVWhOigmkUgTtVner4nAZgMsayrf91bv8OLSoz7KiwUiG9kLjXAkD41aX9PnvPRPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um7bYu08rMfDhPI0nUwPteax95vwxxrnTkCkJjhCck4=;
 b=jBY6uyLUnq6pBYxyfirt0DZa4fm1ZCL5lr1Ai4S5Q+IYDdzdf4KGBzCdO+9yhR++r1oAuIca/8TcXuP/+jZ6wb/Nac39kuhRtfXPeBk2I5KtInJfsYYafeL9rkQVdrZt7YjzQ4LnFQmODI//kuSUwOwJVt818cyKBSKUkpoIGp3AVmc4E0E//N5MyBanZISEtN5lk5g7VHQteb8VH+Th7EgSSwmEETqTw3J5IH0/s6XJk7kDAPW1qVQtCITmI46Ph+g9gLm69lorJFwOMiJIK7dSCUkpxu1jjfoDvvwusY7z3DMu+pZokuP8wDnsUbYyOcBZdAIuJRfqVuIMYKYrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 22:00:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 22:00:36 +0000
Date: Mon, 2 Feb 2026 14:00:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <aYEegA8hNKF0NxuE@aschofie-mobl2.lan>
References: <20260202191330.245608-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260202191330.245608-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6b309f-931a-422d-a18f-08de62a67e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aKBK9A4TTBawmKBk9TPJ+GiQ1CKWXohcAyqr7H+Q2ffdZazLim2OuuqDZaNn?=
 =?us-ascii?Q?AJJQ40bVR4WpvaYiNmugKDAlfqfJEX/3L+DBbRcC8s18lGR+zxMWTanEsJzf?=
 =?us-ascii?Q?VaNgkMMGBunsJ3EVYl7S9gOgeSMq9h1x4tItqPFfELAf6AW7QwJSWIcqhCMT?=
 =?us-ascii?Q?8A4V1J02M/fZE/dMlbqWUWLT9jdJuTmk2M4mbTS5mFWIwVZxnL5T41PTvaCK?=
 =?us-ascii?Q?r1l/uvdDNda5OfzdC+lchqHoVo5kDqwMfulaqjIfjXKDPqfKUSWcIVfhuhyO?=
 =?us-ascii?Q?oGFlukR/gixquEtcjd8BwYklfThkU+OPE9TFxoPwLd7XBeN8uilPqQhCUVjP?=
 =?us-ascii?Q?dmfzzKLPRUYuewlD2vBRX3MoCgplYY0XzktxzE1byMV57cRjCmtWEl8ghyJR?=
 =?us-ascii?Q?OPJtqK5LNTmQSXPsk1FG5OEW0e3600KyU6Q2ig0nAVPPxrP8O0jzyj0OqvD4?=
 =?us-ascii?Q?TBPcohg8gmKrHobRFrXYn5HkihxYibp6GraKnKhkMaPkZREocRTSy8blq0C3?=
 =?us-ascii?Q?doQYPz6KCZlXZfx5dlcsSzC602fPkfnV+ELoGhFKXWLQRu5h+y48u75YVWsa?=
 =?us-ascii?Q?5A6zFKKWKaqLOWD+5r0i1YJurksiwn+1owhfO1JUsR/n3ul758iHKiuRuWTs?=
 =?us-ascii?Q?hcIdLiHGcG7ZG90eA1dLWGjQ7hjZz3oj5Bz5LYFkDDzELhycxrIoZcLr84h8?=
 =?us-ascii?Q?m0XsXcGwd8nfKGGeN3jnb6p8dBY/MxRUTK6gJCPZNEe0zL7ya9lYIOyfrur5?=
 =?us-ascii?Q?6IXuYgnvviu1y/ksgK5nryxJ5Z7LxaiGFGzm9pFvd93PU4btWBd9X+f9430h?=
 =?us-ascii?Q?NRDXMizno1Jwynhx8ZHkEIc1HbIXATVk1p32VuLwXuGHnk2H/5bZ88OtGQtp?=
 =?us-ascii?Q?GuNLIVWRWLmEbu18UQ/1VnA4P8PI113jQQGpFU8RUd5C59Bx4azfmBMWSWiy?=
 =?us-ascii?Q?2gJ/ohDoADKuWxY5xS8qTM/IwPwlHHAhv0cyI2Oo/f82HyhJNzt2dvwTU4jQ?=
 =?us-ascii?Q?51mPuNjHj0E6nRXmOuox6bW2jeQZ7m8DuagIU+kneUcbVJLEO/CIUC8ZjWgw?=
 =?us-ascii?Q?gQYvFYZg3Ei/WgAODYOUp75f6tyibimr9UTHp8NEjLyyvU89AVIR5VNqVbhc?=
 =?us-ascii?Q?fhkPIqA8HY5bb3DxO/bzD5YAQPi7ev40UW4TS0qi6/dVOfd2mZC95ODG4vLt?=
 =?us-ascii?Q?fDhCECTA916CFS5b9CkHkiEnONsI7OP3SXtdnJ8oLWSOwBV4Hzj48iqjz3R2?=
 =?us-ascii?Q?lsXVKnhjrf0mq80a/N7f5PCiJIecTcZOS7TOAKRf3yRxZwm8WcHIuXlCtUQg?=
 =?us-ascii?Q?AWeCEfDY+zXSGRgWgbUHytS6sP26UWB7GvmGZnddxR1i1A+j3UVfX7Ce/04y?=
 =?us-ascii?Q?SHv3b1fJsAkax1qF8Uu4ukuKjsEToBedwT+77u4cXmDg8TgcrLaynKHG9OhN?=
 =?us-ascii?Q?wFbVD1Xu4nJ1HruvsIu6B60cJ0O92+14XvpWCuGc5CuP04zXmgLDe1rNgSnV?=
 =?us-ascii?Q?v+UCeLQ++WlMeT8sNoBz48XC7UTEiKNuiOI7Dnoju51iRCXkXgvHteIujc8w?=
 =?us-ascii?Q?dO6VXuR13uZMBccFuAU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTqPB1CG6+0MUVyUy09agcFklJJfLpABmfo/I7fYaC6X6ojc9ZyCNBuPTRt4?=
 =?us-ascii?Q?io7Gnhm0Itc2PoIj1SnKfWo+r21nPQC+khhCMKLV4xWoQwHWFweJ/n2Fs5AG?=
 =?us-ascii?Q?GBeXhVU0owi9QtH9ZnAljPNRrKqmOV8WzF/dl+r0svtvo8sKbSoUi8egUin2?=
 =?us-ascii?Q?IiZnXOgBg+RodH0S3QleZ2NRmvbJwDWFe7FsVR/OsgJcSJ2zCN6a/0QoX3+i?=
 =?us-ascii?Q?gfZ1ViRc7xnTJOFVCXRXBxosWwYrSvN4YD3b2O4UXbgR5+NKIZJOvrcw0rlu?=
 =?us-ascii?Q?hfjd+FPM6B/8S1wo56fjsLIpSAMcFxoIks/V8ji0jOJl56u3ZUPqu0Wjyv2R?=
 =?us-ascii?Q?Nj4XLm1N+tiHODgVuDpmtYlk8dyVoHAd35xybE7HsyC78JBRYUs49Ni9Na/t?=
 =?us-ascii?Q?Tr6qnSZZMRor3Bjfe42MaoK/C5AODVYAfZVGshJBe3fzfgfyDadMD46Zea/M?=
 =?us-ascii?Q?QXNYnXkFUyYBbBCpVO4rSiuAyrT0cce2yPTae7ziJT5bbDh236/PSqUFMgB3?=
 =?us-ascii?Q?YdIGIohBpcCg2dDrJpyDodS5bR9KDuVolB7nuKXE4vU8FsLZf8FQ7cn/k30D?=
 =?us-ascii?Q?X9PwO4Bq5cGyrI4p9aRa9nOtDYAQVpOB/Dx2j1HBEVI2yVyDuimfZXquCjZc?=
 =?us-ascii?Q?xyaF/tSL1LyR0fNxvKrVqGUnzTB4B0d7ecssaoez8x5F0ynBZDl2LDlFhTdY?=
 =?us-ascii?Q?W35t++JTMkna+fKOiVHAhDfB1g1uyvzEkm3L6V1KIi8lhfjA922FkOGN4F54?=
 =?us-ascii?Q?vPXdpNG1bKaVbwj9tp0t3SCJPjmmWlpZSXdWlHCWcPgADob/S0Z8s8ivOt+i?=
 =?us-ascii?Q?PoD+LLrI4flYxnxTyioAEW+awBVjBgbRGGIeBge/ZDOpHnhwgGdrbOJTgq6y?=
 =?us-ascii?Q?swztCR5rwaSQp5hXMJxRCsVLFdifznanUqpvVhqEhm34zb6wemktyJDyhgKy?=
 =?us-ascii?Q?O+FXRTe7RQWmlNqPeIuzMI6KFTYXndwLN7tbzvNMazCJwOydPHGZ49J/pH3D?=
 =?us-ascii?Q?lP6iD3N7o4WoqrTEm72yfvi7VafdRB2UyXmSP60hh+OeT/CKQ/AOeTI/0lEZ?=
 =?us-ascii?Q?tIaMAT+NL/r/SqmqacVsbfiEiPAqyTmzMmotXVvm7tN3pSgn7SYC7IVZD/KY?=
 =?us-ascii?Q?LeXLx8xl5f/FS/77jZReRsMiXfE3ZQC5Dw902b/bnXV8bzOqsjU1AmiqRlPL?=
 =?us-ascii?Q?i89UOEndWQ+zkvXWqMpYZ4i8cjMw+Co/MyD68q90v0aYu35SnFkBj1lWhwAx?=
 =?us-ascii?Q?esfobGmIRkjYuwnp2YgiwvwyBDS6P+xlrNpcTb34Ctj3HiXBxoE5cH+wPH1+?=
 =?us-ascii?Q?Hagemf7bAPqqlbCcc1MX2Lj4OpPd3fYma7ZKOTAmlCANaJ1oCeTQSohMskAB?=
 =?us-ascii?Q?ODy7K9Ozr9PC/WTD+CV3EAjD+bhsFUjDRmS0/wfUMqanBlNzysOo4QR67hjz?=
 =?us-ascii?Q?DXDroEoj3zt8aqalqEI6QITaoZPJZ6QHzu+iJfr2bXBMAb9HpWNITHyqtzH5?=
 =?us-ascii?Q?8HGtD/zGL/keF0LRchoJFQvdCPkZcTG6xjWeLh7drj3OMa6xkk/yWPdQKaDD?=
 =?us-ascii?Q?JBFnyMbUiAaOueHSCtwGTOCERZjxTGGMmdz3ZJ5wptX2ppBGLN93sw33t39K?=
 =?us-ascii?Q?hMs31Hg9iUIOdiSH+cO0bYBJm0H5mSPr1N1HJGmxDtkWijqIja0JbKhWEv2B?=
 =?us-ascii?Q?6r8W+aCwJokLjfNLj6NShUc+sW+gFWyGMU3ozvQbHFP4AhV0SrTP1JCHvqA8?=
 =?us-ascii?Q?g1OZNkekKY4o7Zw42vepc9xwBcBrLfY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6b309f-931a-422d-a18f-08de62a67e6d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 22:00:36.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xyv6AJ7WXZ4sylrw9hQliq75owIlZCirtn/9kOIcTIMivAWHmcCCcH3xiU4DtxYU34ZNwybjM+Mmr/vFwbbKFM/iOWZ9PVDKmGCrs7OqZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

On Mon, Feb 02, 2026 at 11:13:30AM -0800, Davidlohr Bueso wrote:
> Failing the first sysfs_update_group() needs to explicitly
> kfree the resource as it is too early for cxl_region_iomem_release()
> to do so.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 96888d87a8df..28d70497283d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
> -	if (rc)
> +	if (rc) {
> +		kfree(res);
>  		return rc;
> +	}


Can sysfs_update_group()  be done earlier in __construct_region,
before resource is allocated?



>  
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
> -- 
> 2.39.5
> 
