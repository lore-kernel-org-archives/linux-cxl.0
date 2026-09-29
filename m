Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B451DE17;
	Tue, 29 Sep 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705341; cv=fail; b=OIBWwSOJIK4U0qOYUS3ZOEaB+0ZgjaRBEKIHRz32XSTQ0c/4NiIwLVfAeC39YRce/W8/Q6THAYJZnRnhF0+GCk97sHUCvZ80NJ61whUQHRRb4A1wJIunWVhTkbQeI1/S6GBTz9g68tYEYHf9Uo4KflKnV62GGO8f1WH9MwFONdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705341; c=relaxed/simple;
	bh=aYT2QZfpwLaw9GeOB19PBw4Qce6ZynrTezlCmW8BXJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDt928CjatLSu/vi8KbcigayvdU5Zu0jLDjfjxge9mV/zSWUTHPdm4r8mAdHr4XzDGKAcXS01GwjEXH5MODL0tc+fOoj/TOgpWJP4UdNcU9BYF/+Ygs8uaQXLKtqvWwaQxJckb+bLHTrhYSvtktQWvYfxFmSekemisrozl2O2hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eX6++q1v; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX6++q1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790705340; x=1822241340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aYT2QZfpwLaw9GeOB19PBw4Qce6ZynrTezlCmW8BXJA=;
  b=eX6++q1v83spLKw9o39FIAE8O0Y9ugcSsTpFlA70Psq8ex+5n2N/wROv
   baU7d8duVjOPby5SC16T/y1onnijA0H0n/QLLymFwH6SpjKXgeB3lPBYc
   rO0m/8RPbZDjQqQhwbZWk8J2/R2HaYbx4OhrOx43xvJWtsWTkbFUneQWc
   S/86D7i+d2EvdGDZqrjZRR5Zxb/AQ58Jhtzk5wH+n0GvCwsqhQAhTTu39
   EgFeXJxRq6+qqUowRq3e3hYA6rbWxiMfXLL5JIAKQfFgMicN2AGbrOGet
   O4ZCPPv3Q9/MlxRbUio4NhieWmZnV5VIKqS6SQOfsj+edvMfvSphyezWU
   g==;
X-CSE-ConnectionGUID: 82DbKiUGRd+Zrg5fFcdaOw==
X-CSE-MsgGUID: cRBqRQP1QqSS5XUm3kWECQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95246589"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="95246589"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:08:45 -0700
X-CSE-ConnectionGUID: AcyeKwQ9TRaMyj3tnplmuA==
X-CSE-MsgGUID: D9mtGYbrRuKazC4NPsz+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="273218963"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:08:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:53:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 10:53:16 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZa2rbIx3lJAR2VNhlbKVk1d/nsFdC8PcyMu8/xgMlZ6j57P6ci65mZ/eAiyornox6lBxeVJmlgS9PEHfZZVH8x6dvxAPPkM3N9URuijyHaZDbnO3vmERkJOlwRmRxHB0v8fEbpY83wcGHr62K27DPWRSvFXzbkADwWiT0fvKW0vaYRbZZFZnDSvxYPaAnbW/LbdVf1ohUmzMXuIhSKCEVD6bPGDqpwVsJXs+zvEVt1VzFzjDCWc4BVd9ZDEUkitt4gD2ytgMIBFjNXbQDbUEHN8zh/ZNvFs5XJBcHEH+NnIhfomv3kmaPPxr6+PmU1x2SdSWtJ3hYCVz5oQJNF3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoE7gc8kwG/bI9y4snN372Wt7xEXb6VZpA/rGXFMe3s=;
 b=wdBPeAsv/g/8ssA/UwzOEewgsarpxX/Am++IPZ/J60PDu5WU2l0zDHO6upx9ToV+yytQ8gZL86BAoWLzY0rb3kfoeUBOQ9FehtJGsMauo/0o3DoDOTNs2dDRn0OcPFuMqa5TyqQwx3Tb8ij7Cn/3GnjmZ6IpbmBBN+j7XL1WZJH/GKkuyFAcmtZ8H0505PodVtpeel1S+9ni8HR2xU+vSAXYl+u284RMauJgvm9wmdDlCSGfDf9cJ3KsL+DrJJx+7o0xFJTtoscDbM2wsTA6TKTqbc2EX6kf01STR90KeBLqN064aLi+ypAaQu+spqbp4tvVHSC8CzzhE5UIKZPTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB9524.namprd11.prod.outlook.com (2603:10b6:510:3b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 17:53:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 17:53:14 +0000
Date: Tue, 29 Sep 2026 10:53:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yili Zhang <zhangyili01@baidu.com>
CC: <dave.jiang@intel.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shiju.jose@huawei.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/edac: Bounds-check ECS threshold index from device
Message-ID: <arv6_znTtwN4JExY@aschofie-mobl2.lan>
References: <51e4cfe6-b3c7-43ff-8b1c-512cfb23b9be@intel.com>
 <20260929031742.14302-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929031742.14302-1-zhangyili01@baidu.com>
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c806ba-1d1c-42b3-4db3-08df1e5288fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xt5nrrVSJvqMASPIND4zA2MKViTOolu/UjqayGb/HgVb8HyRKesXDd9Nk8rbZ5wNv4bl5o1X7X1mQj0yHILSDPHlKyhqzE+g6eNjDUW80Ba0M8Js+hicGPjD3Slp38TkJoY5O25GSbeSJs63VIgzbmDvDlcmeY7ZYy32OUo83SnQtE3yK0c5zc+O+m/ZDjIyd2a3e52hbPSFH9VFfjibY6G9cjnKgRl8xvpVqIebYzO857hdWlJvFYIyBEgwvutOmaqFvkCK6S0bz/rPVmYz+ZbqgxTnpy+QqBCsPAMpl4JpzJJUbWT5rh2eSYRQuEi3DtXCaySvjpymAAsFA35xAjn5qlE9XVcw/ewiEo6MLDNyUO82jIzzQpehA2/4slQAAMmsI4mGJE+sc3BJ+rbAKW7zdURXyfolLu0EOkB+kXu+H0sJU0HocRWnzTIzWGUPBpGjksNg1DyuNzQKNUYaqty3QGL6OSwrI3dUHWWPZZM6rass+bGbnTtRDjzuzCk7/yTy/0iEV7pxbJQEzVtwVW81uzdiTpZTlHTbO+U+g27KL0I0sdN173wPodL233ZhfYu74dAaUQh98cwRqmqcYeVHFekEj/kKRHTOxur7Ldvf99aNr6s929LLO6QXUMp7XxoGgFqMOPgtBnNJfajRGiZQ1Fp9mf698qOQwAox9bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXMJr64jkL2y8PVIvy8PB4g5BAbPxMbya/n5Lv439W+3XNBpa3teeyXFhkpM?=
 =?us-ascii?Q?Ef6aalQ5F37vAjLYqA7FHTIo+k/caklMsEbNQ0fJTC1ejScCgAxfqsEkx/+a?=
 =?us-ascii?Q?uE2JTgK7Y6Xw9JEyGSnZhmGiWBX4XqtyzM+Z3wJ2cfN3IidwJdOYYSPUZjso?=
 =?us-ascii?Q?W7xFNY8Up9FHTg7InR2M4knz7Wej2IdBV8ocrEVMr69DP0zlV3ZBcD8AbKB/?=
 =?us-ascii?Q?vzNa7UZZJZWARj5tZG1n8ewFEbkGkh9j1CYH6JWfo2TbnZYxIgAM2Y9F5/lL?=
 =?us-ascii?Q?Q24xMudPwKKZJwd9cy0HhlrI0nwyOKIro2heP1nhZC05AgezlJyyZ/DAbE9B?=
 =?us-ascii?Q?09UB8VdCkU8nkFgBLEyZAc7+nT5dvckOtwKzJOo65UD6KdC33Ar/kG3yVPFk?=
 =?us-ascii?Q?+munUGbyNF3y+7RV1/H/F3dYCNGE1ecJFqQp0nBQCjsuPdae3e57QBhL+mVh?=
 =?us-ascii?Q?hZbO8yV3PYyvVP3Y/8dy3rf/Dbk1I8s8w5ZPGfU75VtGRlhn4/Uh2UTVklMD?=
 =?us-ascii?Q?44bGiseR880UjD2NPErwG7xPvuJPlussNo3azq9gK1ZaMaU5fF8CHzcfCYcZ?=
 =?us-ascii?Q?cCoV7iHlUnfjLbHg3+7aYGpF4dackACLRoOuO+jGcsao33Bll1A9v9Zqqjp4?=
 =?us-ascii?Q?yceGF01n84ZFF9bFFOT+/i18vaCu1KuokThO0ICJzYDMsiHcwUz8vMDITsq2?=
 =?us-ascii?Q?xxLgnMlxo3eBIdjdmNb9qJpJLhNlf9dxB4M5usEFQjsONC6Gl6CSBWd3QC1B?=
 =?us-ascii?Q?FBqY/IHroH5BANnK7CtxolMgioS2cxntcucS3mMM6S/WtxVnzCmzDGkHtmx3?=
 =?us-ascii?Q?tXe/tLE7+LVXRjsnkktJc+EBfOn/aoWhgx7MRPXx50A+LsOi/B5QcvcPh+8n?=
 =?us-ascii?Q?5Fd/LQzjdZXT0ogQfhgMPNDDJvwU4JHG8HDkrU4y+pQNWwLHh1NOsx6Gne/0?=
 =?us-ascii?Q?ssoCu2KkfD3+28SzAeQR81B/+3GyBkwMZ13aRTTWFRCf2BbkhfTANJiZfLis?=
 =?us-ascii?Q?jKryto7zZSvMOupFD7HsSEetG9JrITS/iUaKvTvYoTMYSeTgiFhQBbixKxZK?=
 =?us-ascii?Q?NI4WsHDplVM8+p6BoE3jjQV3/uZ1nhDo/e5b6DCytoIpFXsc4IRsPGJmavWA?=
 =?us-ascii?Q?LvGb8HN1N4Gy3CtV4eJNuaVv41TU8EuEvRN5nNUsgouk+C568SUorh6KN6k9?=
 =?us-ascii?Q?pAuQXkleeQ10uOeqadVUUihmGfeO49r9ViL3R6gKl1xh5j3N7XbHXjvqMaPq?=
 =?us-ascii?Q?PNtvCTD5Wphrpgz7ooe0SvA/kGUhUIZ9My0OU+xgIvnt8UhbB81lCkgun1sM?=
 =?us-ascii?Q?qyoGk/xY28wyZBuvwLlb0Ol21aMaYL2bJqOryWcrByqBXxoyx3WfOGybNWQc?=
 =?us-ascii?Q?for5mvTqK1jxIGdVXBIuKlVeWdgpcztBUj+rUU7Dk4DS06sTkjK7F9Acr6KU?=
 =?us-ascii?Q?YYNLd+IS+hGqtI/p76m3eo2opWCsEscuMceJ3Nzayn9RsonsJ0cVT7iFtHk+?=
 =?us-ascii?Q?9mSifx3/gZVi5X+PoVJ4DjUcj6JVqFj4hUQSFvk9MI+A7c4Yk4NkwZGp0lAS?=
 =?us-ascii?Q?fEQmFW+EZCy5EI77LYQX1w1+KpidpzDFoB2lJwz6ZKyADn3pyV/3IH2RRCbx?=
 =?us-ascii?Q?94P9DvuKgzsD7qI592fWmCuhP+gHxOX4610R2tyadMVzZ7J9UU6FRCrt84Md?=
 =?us-ascii?Q?Cb4NbC+6rOIhbd6F+P1FF3n7w5ttYKSKkQsF4EGJtVmelmaSWFMg6skARPtu?=
 =?us-ascii?Q?ajWMWoJkTT8nIcf/Xap7GbG88NryNHo=3D?=
X-Exchange-RoutingPolicyChecked: F92hk1pUdAYxjM5vrAK4g5oYpWLtlWJaFWXvwcv5y5q9leQ1m4t3yS9QI5YtenFUBA+lGS9TjG425YJM/7FRYm6M0TNEOo4cIN5P0m3vqsoYu4y8zytODvHJy5CFhrq2CIS0D+WgK1htlW1rMDsMmbM3E0bqBe3WOcKSSPS48bFXzsz83JumASscaaACQ9vCdvRByo9Umo4E+ne/rc2OAe2kjAlg/Q3DoJGs+BJWwg5oJJogbrpHfjKtEEW7PCCr9M3qC3ONHkKSmZPFp0eIZH+jMyamAdRdMwNt4PfPXXglPJZEo5xRMkFVRdMyGH7S0LicQlHsoDQu/EEZJ8e+BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c806ba-1d1c-42b3-4db3-08df1e5288fc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:53:14.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeMMZWc2I0pXJQuqqO3sSQyirXpwynw6V6HFRgFqTqR62xYEsPQC2SNmFk0Y/SHe9YhCI9hdsrZ13DAtquMRliqB9jyVKjl4Yczxo4tVUxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9524
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 11:17:42AM +0800, Yili Zhang wrote:
> On 2026-09-28 11:21, Dave Jiang wrote:
> >
> > On 9/28/26 12:35 AM, Yili Zhang wrote:
> > > cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> > > device-supplied ECS config word and uses it to
> > > index ecs_supp_threshold[], which only has 6 elements. A device reporting
> > > index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> > > value is then returned to userspace via the EDAC 'threshold' sysfs
> > > attribute (small info leak and wrong reported threshold).
> > >
> > > Return 0 for indices outside the table.
> >
> > Why return 0 instead of errno?
> 
> The threshold count field is 3 bits wide, with encodings 0-2 and
> 6-7 reserved. ecs_supp_threshold[] is a sparse array that only
> initializes entries 3-5 (256/1024/4096), so when a device reports
> one of the reserved encodings 0-2, the current code already
> returns 0. The patch just extends the same treatment to the
> remaining reserved indices instead of reading past the table.
> 0 is also not a valid threshold value, so userspace can tell it
> apart from a real one.

Hi Yili,

I see the appeal of keeping this as the smallest possible fix, but is the
existing behavior for 0-2 something we intentionally want to preserve, or
just how the current implementation works?

Documentation/ABI/testing/sysfs-edac-ecs lists 256, 1024, and 4096 as the
threshold values. If 0 is meant to represent a reserved encoding, should
that be part of the documented ABI?

> 
> Returning an errno would additionally require open-coding a
> separate getter for this one attribute, as it goes through the
> shared CXL_ECS_GET_ATTR() macro, which cannot propagate errors.

Does CXL_ECS_GET_ATTR() itself prevent that? It already has an int return
path and can return errors from cxl_mem_ecs_get_attrbs().

Is the real limitation just the interface used by the cxl_get_ecs_*()
helpers? Would something like this work:


static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u16 *threshold)
{
	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);

	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
	    !ecs_supp_threshold[index])
		return -EINVAL;

	*threshold = ecs_supp_threshold[index];
	return 0;
}

-- Alison

> 
> So I'd prefer to keep returning 0 here.
> 
> Thanks,
> Yili
