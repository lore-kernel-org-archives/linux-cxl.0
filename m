Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C3154BFC
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936792; cv=fail; b=WJzErlBoRl7+VFgcrWWeQiQ9HKW3moRI6FZwmv0Z2NUQICoNZBwXWysWWufRMGguTPIerG1nnpYHWogZMZsuf+z/lAjY6ZDKp7Zm7zKmzjaHvb4Qs+Qnqsm+V45ViWmwW3wnBgo3bEUr9NzL8Kgk2umEN+sv2dwz/OFe8UVEhA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936792; c=relaxed/simple;
	bh=cDxqxvSWY+oOVGcGv5FQZoCO0cteY93/20t2LvzUUIs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stA6OfICY3kRLRzzrjikJetMZgIsxtQHSMzVF95JRg69qM1dGqGiEKcTYmTN5zzCmaZeOCZKJLhsu/xCrh+eYU2+PJKB8edfjTsdt1f5ktYIi0fb8Ly0x+d+IHcEBTHlyk9DaEqii9AsskRPJIKLiORAMLkWaC4VtpPfibhSf2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Okj34v9V; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Okj34v9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713936792; x=1745472792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cDxqxvSWY+oOVGcGv5FQZoCO0cteY93/20t2LvzUUIs=;
  b=Okj34v9V7lLKSRxhz70j5YW8F9oANVf3Y1IHlzBbKCfSHloMB174q4A0
   cQWNjXFH8oA9ZrdGDEe040FZDSXCVWV+8dEEDJykjSlYRvQBbmB3i9Lvv
   mR+40e2XqRUJn5hR3uJqrWAjKISjQ+DRDVNZrpPDSRcnyoQPSby0JJNNO
   L7Svm5Jd810w7pHjSM644p0l5Cg0tzS/KQfiP5I5y/91tmTNV1/3pMbeU
   /MgNC9T+LaCzO4zMvbDtLcJ4Bqa3dhOeBLTw0FNMM4yCQNis40f2tGRun
   ndDJu+pQzgtcCeEF53YutAKYYYrqbxiQgE4rVhDayRySIRUrmBa5T/FkF
   w==;
X-CSE-ConnectionGUID: urH3CyluQC6RHFapMs55iA==
X-CSE-MsgGUID: XhxvqkDLRWKnJV+iW54A/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13381787"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13381787"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:33:11 -0700
X-CSE-ConnectionGUID: I3fBXbLTTFysOnnqEOTyvg==
X-CSE-MsgGUID: BLcQ4D/gRume5MHp17L8ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25034499"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 22:33:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:33:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:33:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:33:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 22:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+BNCg6Z6k1h02Ap9vZiXsqBo4Jd6JsdnPHYwfoQjNZ1Mk7EyUuUN97bx8g6LIWHWXZMqe5ZDZO3Jy009cc9ClPn8SsF2Jj00NGDDuCUtx1QW/m5XtqhfbJKTiEEZkK6Pxfud1J3lMPcEHWwzn4Bs1Qo+sI5xgHdT5ENQwULj2yoaQWqlv3wI2SPtNDB0L/I0R/MeEHgOU6eU4FQcW1YaiatqRyi6XEA5mwtNGeHFqdUgKOJ7YQaeagEr80zDGy/K3Uyh6EYkwdaHzXV/JfnJBaoDQt7cZFPdWeW6pcGzN4vX8/gcSp+eibp/CdXkJIlRjkb/pIqJ6W8BiFHkzvYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF9lsJKinuY9DD0ELckYmvpoPt7zHgofKHzE72uqxEo=;
 b=k+9uB4i0Vp9W4/rMmbACWTvzx51MiMAfjGtLefvk2qyU27w0VxR7uppJSf1DHii6Im9qV/7R6bS/KwccofA2TUDIUFJzusj5OPXzdM+IZrWXdF33DGWmBxlIYDGKaATkoQslpHxSmycbPXGLcLmRGgxkAtc40nxdQtFindOEeyZ0P+NQXOf7W72YtCXY3vRFnKRwQtoLOZvxk2LhWsuUEUe4kQ+MlUx8RpgRFmDW7iU1IHS2E5Hfg7EB6fQMHdo3XADRxaX18Hlbef+3R9pHO5rDWND77RZVcIzAeNlcwULw2qbhSj14oupdoqPUNCgVPxAFJcQonPs4zTWB2SqNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Wed, 24 Apr
 2024 05:33:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 05:33:07 +0000
Date: Tue, 23 Apr 2024 22:33:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/4] cxl/core: Remove cxlr dependency from cxl_poison
 trace events
Message-ID: <66289991202c4_a96f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <9a125b4bbf6556b9dda5727a4fad3e7ab25a1e1a.1713842838.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a125b4bbf6556b9dda5727a4fad3e7ab25a1e1a.1713842838.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d8d214-012c-4b73-54e6-08dc642005b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SOJYX2iFnqZ9WsVyqBtttFbhqQvkOikpZYBuO5ydnEM2ofIFQvGlJme89EWq?=
 =?us-ascii?Q?0Az4DqIYh6ICkr5BRm+pufXnQpk+yV6/ASssRgRDvw2BtmAURBdoytzgzho8?=
 =?us-ascii?Q?HhKmDgfmIIT84dP62VicYWfM2l1dULkVLIUQpsaCseLbHHEeCIGROVNDryV0?=
 =?us-ascii?Q?uWgmCjghh2XW6Td3hERwFIdlp2zVhh4ZjC0FLziiU/vDVuUZtfaUS5I9vZp8?=
 =?us-ascii?Q?hpFWmK8br1sl19o9teFNPxvVtOt23RA90wzuyJNEnGZbIcEFadWvL4OYZSuF?=
 =?us-ascii?Q?ijCea47M6TE32LdR0FF0+R+bajYySNmLXiV8EpBU6JJOKHwKEUBD6miLY+T6?=
 =?us-ascii?Q?F1QM5z2qvNApd2l8GkQbIntMk1Xs7PBrnH6T6jO0zxSLLiE6sD9EHYGNmZZR?=
 =?us-ascii?Q?p/s8CL/Qk5UyIQDN37sLKyAcuOVFlkHRZYHday9pmGehqfom8Xnr/ThGsKNJ?=
 =?us-ascii?Q?k0NeUPLDtDvp4CfDp+qYw/Bea1Ge8NPz/g9qF7oYsUvFf23+ih1RYKRqPQeF?=
 =?us-ascii?Q?YoQrrjXjflMKpzGK2PkqHrOt9WLDwBSm7/PMvSvIktjJs8eiVEsYZpIHMhPD?=
 =?us-ascii?Q?4JOMHpj16JxaHhFUhat4ym1ptp1pmqrdZhSe6eP+9byrrKRlcCWs7TAjDU2L?=
 =?us-ascii?Q?gJwUXDwXnUJ/DTqEpgvWZZsuR2M5PyrKtEHVMgxV6dhi0YgUbsq+foiCReJi?=
 =?us-ascii?Q?3XMwwsD/2jjTt8SAekpEd9foiFMzfzZbPPTqn0xWmCkP78zEuz7+FYDcMBqT?=
 =?us-ascii?Q?v15YgE5GlZ1pIS9ZZUtM9ik7M08N7bQrh0Nnj4MHmvSKeh8KelX+0fgX8xxC?=
 =?us-ascii?Q?oR4Hnu6oH/a3G8AKBbzguIOe28CXeSVxL1Cq5w0+m7YFPuPKyXy+ngtR168i?=
 =?us-ascii?Q?tYFfztQXlOJvsNUmG5wk5cnzBPY+jGrtyhQypFRmNwM7mm5GTBFxuMJ0M+kH?=
 =?us-ascii?Q?QSCwU7oVSfJFV2crYe+MqQERk+RKQ5pEmA56us+9JX3gITiSpihp+zn9c077?=
 =?us-ascii?Q?y6t1VTkd3n/8YTht4Gj1vAeChYXgEaM37MMHho8bCUVSm7myTx9CY6ePrVgr?=
 =?us-ascii?Q?2F0d+AEGWARhdUOJFShjuyPsWchGwhSHwlxlxnLD3D6tj9XyGQf1IYxw+SeC?=
 =?us-ascii?Q?3c6hTR/r/PD5ht1ObB5TUVMb668o3ng1VWvmgBoAugaiKSN2dgl+dbA2Y/hk?=
 =?us-ascii?Q?X0Qiw8e1Z1Xzl72qK9rUiuJpNgUMw7l1PT/lDRH1IBjshC6UJZX4nG0VDh6h?=
 =?us-ascii?Q?9dvNcvfpGkRcA6ON3UXSFAx2KQKvOu4A4IfSmP+OPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6TTUAhNVp9DiEjDZlqicW0zhIbuhXHWKNFHn4aeEcGQ2zPi8N+M/kR+XBj6N?=
 =?us-ascii?Q?IIxNejQJ7ftu1hg2KaS/dWqas+wRAxERDQxy2Rw9E0V79xOiL5r+sIlbYU7E?=
 =?us-ascii?Q?q2MiorUZTNSvBP14T019Jus3mLf5qcF9victb5ETevGsJ4PhWe/I0spcdEB2?=
 =?us-ascii?Q?dyUSVl5Q83a/PEu7ujxNWrRtSb3auWqY6GgnYPpcckQRuK1snM3SGaU6JBPC?=
 =?us-ascii?Q?d+JFYeUG+bFOPObWZhSJFwcZXnYm+OFNzWFTo9FI7gmXK/rF+7cGYAoizLPq?=
 =?us-ascii?Q?vgn02QAD+mk2kJK8wPNTF1nVJpi6hGmlzcBEu/F5NPv0MkbQgFGFNMRbFqBH?=
 =?us-ascii?Q?HVUeAGJ3OAThLWBmGaYRMnl1ISqXdmCGAWmMJgTraajRKlIZ9eks64H+XIYm?=
 =?us-ascii?Q?DykAB9zHlu6ov1KQvF2881a8xcWRyj8ZKR8MJLGx/A/McuC+2Hn/7Rm4eQvR?=
 =?us-ascii?Q?XqqnT98ZNJ4MTh+9BbHNPy/u863gySbBS37bGsX0rjiJl5DyuM1Ov5eB22hE?=
 =?us-ascii?Q?tEAePtPY/1t9z49mUjIZcIFpomGf4S5N0q3OgfF07xUI3NDtIk0XK6xywCS+?=
 =?us-ascii?Q?C/SBSpW3THmhc/OBUtu4GZJj/s8BDIusPdVYjpja5yWweTeG5O94EBUpfJdf?=
 =?us-ascii?Q?6aI/huDmzvXxTIFsT1gOeRfsTsIhh+oJlXQ7QdZz4dVhX0HOtYlIXdLTGRe6?=
 =?us-ascii?Q?i2WDxIGGhwS1eG/iQ7a6qsZ3qDA/lH+2yJGKgeKKWXYN8Pu1SyTRcLrIUfsA?=
 =?us-ascii?Q?x+fqs27Iww2g85nWKvqXPxkoOzR8g63a7oJtycbw4EOrj+ZA2CkE8L0+XH7w?=
 =?us-ascii?Q?iMHu7SWJ1AAcq2MaV+Xd4qnBKhp/1yGLpz5V7Jg2eByoaS25AaEZpmTjba4m?=
 =?us-ascii?Q?6M3kr25+ZymXi4XlKJJB8IXDSsU+dOC2t94qvkVRddqdTwfwRU/+rtLEvEOP?=
 =?us-ascii?Q?Ek5Me3niROBD+DvOQZlODp6mz6Y+4NiUrFoEP9SD45iq5nToH/iHW1AcjxqL?=
 =?us-ascii?Q?EESdFYYDPzNy+9oJX6VSBaQuICbiiPE2DV6V5KMYmh6JkKkxxICJCyryu9bx?=
 =?us-ascii?Q?TcMaMtBvvlGbA3WdV4e+XZscLkQ7AXTwedF78bajHHheaO5Kj/KGxJbHGmFi?=
 =?us-ascii?Q?6ipid0HLt8h9JIYN46PKss6ZayoXZGyx9cbERS7yIPAStgbig1qWl1PaqYMs?=
 =?us-ascii?Q?ewMDousWLe5BR5Q40Ku+0omzvKrs+y0oMSnXcqL74M+rYWT3ypt56Vh/ZPMP?=
 =?us-ascii?Q?g/EICIV0IKtEXpy7v6XT6THL9N46eFs0R0L+0V6OltA9zLP/Vdlr3pjhlOJh?=
 =?us-ascii?Q?orz1GsESaQGIYUsvkomcgdZEItFkeciM6aIJd15GkIZMql9x4HQq+ibyJFGV?=
 =?us-ascii?Q?ONtwtd5y20Vi63jYHrRsGn0+733t3TRmauMmTzOqMl4e2bjDlAX24wpRhjED?=
 =?us-ascii?Q?yyy5My4FoEjCQbf3XaLPBDbx0yd24AkUFwppTzuMvSXLj6zxOVNu0NvxmfKa?=
 =?us-ascii?Q?AyX80tjmwaIV+R8Y5xORnjCHCDLWOMDCR1Ss8yBVXXXsX+jec1uU9MgJ00wZ?=
 =?us-ascii?Q?Ji8m151Qt8Lx6hbP1FQD49UqQGm4ElsQORUFfeAAYfljXg+Ogfbg0xV/kx+E?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d8d214-012c-4b73-54e6-08dc642005b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:33:07.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26PUCZ4fBpyFyqmBHqaBKoRDG8IfjXIIU5tKd1eqCGmMNCo4ZnNjN2JWGSN14HT+/2IRwYrdi4B8tfjtrutflJzvAXOV8jwC2Lw/qGexmpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_poison trace events pass a pointer to a struct cxl_region
> when poison is discovered in a mapped endpoint. This made for
> easy look up of region name, uuid, and was useful in starting
> the dpa->hpa translation.
> 
> Another set of trace helpers is now available that eliminates
> the need to pass on that cxlr. (It was passed along a lot!)
> 
> In addition to tidying up the cxl_poison calling path, shifting
> to the new helpers also means all CXL trace events will share
> the same code in that regard.
> 
> Switch from a uuid array to the field_struct type uuid_t to
> align on one uuid format in all CXL trace events. That is useful
> when sharing region uuid lookup helpers.
> 
> No externally visible naming changes are made to cxl_poison trace
> events.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/mbox.c   |  5 ++---
>  drivers/cxl/core/memdev.c |  8 ++++----
>  drivers/cxl/core/region.c |  8 ++++----
>  drivers/cxl/core/trace.h  | 27 +++++++++++----------------
>  drivers/cxl/cxlmem.h      |  3 +--
>  5 files changed, 22 insertions(+), 29 deletions(-)

A lot of the thrash here is about removing cxlr as an argument, and per
the comment on patch3 I think it is cleaner to go the other way and
always pass it in.
