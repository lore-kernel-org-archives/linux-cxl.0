Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B553376;
	Fri, 12 Jul 2024 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742856; cv=fail; b=LNhHigImzsHqmkNJ8jaUtzqzmg0YMAZ/prPe3BQQZ/t4Gr4w1XGwVYRgYRVXVXyB4kkwJyzSM1Bsb/jXwfRzAR1LsI2fWdd7HS5i/42LxjquHozOVjDgmTotxV5jnV01PYpAMfhI8aUhXPaye9cs6nSMmILazMjubYc/SCD3Abk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742856; c=relaxed/simple;
	bh=+YO6S4Ob5D9FWyVtvHJQcYBp8r8PSdCKatB1+C1VOfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UUbZwD3XcupwmLOx8wtsZuxWLADYNnzLw/dE+hftZXZQfgBcP/MPH0HJc64Rgav6/NLQhIP4cz+deynns7WMTdyoh5qhoyHtuD12nnW+miGQWyAm7vZsuALH6rZl0m+elTNZfNLNnxsuJAnZUorpWaqw46mYdakIcMMb/os42Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHaJMFcB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHaJMFcB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720742855; x=1752278855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+YO6S4Ob5D9FWyVtvHJQcYBp8r8PSdCKatB1+C1VOfg=;
  b=GHaJMFcB1lQGNVJ+joQSK8Pz8YJx+W5rcN1MBHEeV5PI/vazeo9vK/U3
   Rrt2lWKGpq2UR8HFdodz1178KxaQdgL1KZIk16xlTtd2cdBCKepmXWqy0
   mP0h6WKy3KgqY7RQEsLdmL3/SQIAfTbjY7akSNDXAk7aoQWWoifFj02X/
   hUUGcLXo54iBN7qi3JXNRbSUwLmLOWPJMVCYVlMp48gnRy0A1Z4wjiUoJ
   XfFpsc41cou7qAPx7xiD423BQE0aVf60tzXbbm/Pd9heJlKzPYbXZqLN5
   +0q8acWv2YKOOXvLHECFquAUWI/+UVfUn7b0TlSTGOUfcldm5mAXIvwXz
   g==;
X-CSE-ConnectionGUID: k+socyC2ScO8PCXHxj4g7w==
X-CSE-MsgGUID: cpDQlUVJQrO1EphNwEruEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28840212"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="28840212"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 17:07:34 -0700
X-CSE-ConnectionGUID: a8EjiY+ASaOsU6l1A7YdyA==
X-CSE-MsgGUID: 1sSapPgcSaS9ob4cf9qa6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="48825038"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 17:07:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 17:07:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 17:07:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 17:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo0prpRUxZ7syIElFSN9y/OIjtaui0W3MhaBbdn3jlNSPGzslpnTnhIpMJJdyCvOnCeg+Go830BbeSwDaAEEDEAoPvdjiH3u7iCuTBG2eX/5W5xNHHBCMQIqQstXxB6ODRJVMYest6ohXazCsjPCyjH84E4njmBZctofw1XC0/OcZ46lPK4FYMnZpV3KIabfUx6qYNrhdTTOnfjRxIWXGlJc0iyuuUQE6a74tgopYzn0C/GyjS6BiihpBgMu0WS7HZzT+mYnrfJmNK182+SLaQtp3yPEfdaljZiSzkvQJoRu4/fTmeC616vm+BvMTwRd2rxcePyU/oucSklwOjFHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHSNdIx+KNFKVWBXgYUqCar8xisokgV1T/lVrE4FPus=;
 b=BD7ulCkY0jVVhaCUim5dBkV0n7rXOip5N8WKNNHrFlXI/gMvKmVYy8kk3tXEQ1jqxTiOGr7du78ZdkkFZG0q2Se7Ii7my/8+dkqXHWnBC8wq6ThLRddMSyFpaEcBJCw4laIheQVRhvjOykJjYe/uvx6HCZtHgXdRSa0jslEkuvV7qn6XbnJtS7M2mibVHsM3g+S1zttPmONBrONWyPziLhTTWs4FKeUZV7RT9Hr6BeoMmQ3mo+8mxQzHASslaPdFthihQOVeb39XA1P7Xjpk8GaL9w4QeZGfzHvyK69bBxwQI/hv1E1Y7v7R1JzePJq8LWG+1CEnXxpY41x1TSNuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 00:07:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 00:07:23 +0000
Date: Thu, 11 Jul 2024 17:07:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dirk Behme <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <dirk.behme@de.bosch.com>, Rafael J Wysocki <rafael@kernel.org>, "Eugeniu
 Rosca" <eugeniu.rosca@bosch.com>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Ashish Sangwan
	<a.sangwan@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: core: synchronize really_probe() and
 dev_uevent()
Message-ID: <669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240513050634.3964461-1-dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240513050634.3964461-1-dirk.behme@de.bosch.com>
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f311b6d-8aeb-42a5-3330-08dca2069b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jrrj9e9jtN+V7wsniph/AYadZJZlh/BL2JjmsnksXTlomSnr4PnmhEZBuPkk?=
 =?us-ascii?Q?kLBphx30zd62U3XLueWAcZYJg6EFA8YrXDAb/1V4IovwCA5IQHueFopM9jzy?=
 =?us-ascii?Q?+wUQNNdxhmxB8loe/AEfk2XB5Zl/aKXyT2wrRgIxSI+TRdtH92FfGzAJPlSu?=
 =?us-ascii?Q?ba6J6sL3fVGNee36cLj8nSnw86nVA5vM3jFeHt/jGp2fp2iecDT7YPH1rGHd?=
 =?us-ascii?Q?rtHq6GOJNzj7RgSVb1J+D81hNNopvLivC+ZEEorgYcK+1nZi4yp0akPkxyvy?=
 =?us-ascii?Q?Zx3y8Z/8Yx6Bv6Ik+Aze4t/uXYrSxqa1L8Ah9NRDBnQhTk2KJLxhDXdGXMrr?=
 =?us-ascii?Q?AFgZyp35Biy3Psqui3upUvznp0kkQAfSAiZc+s62iv7dIk7f8REj/eyok3fR?=
 =?us-ascii?Q?sFn/Zg5IvxjIFA99MPvnR0PUZxqbLAr8y4FaP5gfJVrDbMQ8036o1qrf4tFk?=
 =?us-ascii?Q?g5TrtE8YwExmfv5DndfkwDHCmk341k2yGD7MplifMpkgb3tB+bvw1Vxixez/?=
 =?us-ascii?Q?VttgGhoco3KeLRGqashgKFP6QDCQddDJGEV+8xsHzWN+ZFH7vXHq/hly7c+r?=
 =?us-ascii?Q?Ot9/CNGMh2/NchtyJ1tPOOgsA8x82EzTWjLHV/1orbkCZyClmAf6sBsN3uf5?=
 =?us-ascii?Q?af1fbx2zfTPvepFl/lydhTWKNOj2R9W3XT2XDr3ANo+nj4pfPAO8hJ2Dz7zt?=
 =?us-ascii?Q?KqLR+Sv9xH2M2UWlgAzBIz6DfNr7a0/yeDrGTgucLQrHMwPmUVMXTwaPyWEc?=
 =?us-ascii?Q?Kx//dRp1FNkvDVkn959FVLXelrgkVGFPhREAv1FIwnLJF6S/5I8MgG/syOGM?=
 =?us-ascii?Q?XdoY3LKnBlwSIMxaAN/g9xvxPAzxFJYLfNZX77N7lepWbh7IRiSvxb8EIgtR?=
 =?us-ascii?Q?WmOwDVcEq7Qq1uuK/aCwqE7tCOjHl4DFdZw3s3VuoXCVmSQBXNo/UtQqUhFE?=
 =?us-ascii?Q?ky+TdClID6WwZ/MJR9j81tRpfW+OURRJ4gWVkbHDxp4E1+/nRAlCNFTzd7p/?=
 =?us-ascii?Q?Mij82w7dgbJJDqif8ccLcMc0pSpzuvI2BYtJGhfZjuwYZBhtvZBgDpId6ufn?=
 =?us-ascii?Q?rV8JPJCr7T92kM1rgnIT4H/X/27A4KVCPf0S21ZWqU2v105nyijb5QQxBU3j?=
 =?us-ascii?Q?d+vm9fkZTcGuaCIfXm/3XdUD2SvjSoTe/3BThRFEASh+oBVokfT1dGNvWkO5?=
 =?us-ascii?Q?igrG56NRwKvVgPiEmqHzKH/CvW7m4/GLe6JJdC7NBQ09Jl7Y//RQzqFAyXaT?=
 =?us-ascii?Q?yJ7PtuGoKyJrv//RlOVmKmYS5Jwznov7zW3QzyaTM7ZZg2uqAzZbMBBn+2Of?=
 =?us-ascii?Q?7WE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3R2ncbfjFVxs6M6J6gp2JYyzPtkUKp+jcUR9ElG5X565FYGd4UdjfuxYlkh?=
 =?us-ascii?Q?PIiU9CHyqzaGEbO4RtMF92WqcE549jpy/b+PMkaQlRRrinq9RE7qoA2IDeGH?=
 =?us-ascii?Q?PSZeb4ZeQav+3iqBsg0OxHSmaAGR5cR7uZ3CPsNqD732MkOJbnx/gKT0H7b9?=
 =?us-ascii?Q?DRhEbKxyp2IiFS7RGWK8K7B747GTSwewtTGwzwhYXUGBioOePak10WHGs+UD?=
 =?us-ascii?Q?y6ExgjbUiZNXzq2auAFic0VmkHcIKYYrjRoLalQIhqF0wDIGcQ1iqNXRL7D7?=
 =?us-ascii?Q?BdtLM/2R+6T9u0hVxE/IBg/nYzXTMt2PMzyuJchdTdHBf8IopO0n2uKBLvAx?=
 =?us-ascii?Q?jmK8OyljDwdYliw0C9CSB3fVnODbfykN8O0LbrM6UWssByPYKcSgjYEsVkNG?=
 =?us-ascii?Q?0BudfcYp105EUZP2jk/7Cpn+Dfu9oIO7O95nI1Vo271q/xpPDor5O387LrbR?=
 =?us-ascii?Q?V/yuGzucS4xgJ9KGCnhZdnUw+0UQh+sOoL0M0i9C3+lhzM//Mz4wAQlbhUEN?=
 =?us-ascii?Q?jTuEhhqPfFkb5/n2ZgZKYtUVX5jzZdldK22FGYY4MOQS7MyeCctFcy1VfY5r?=
 =?us-ascii?Q?JMjgck5K/Jy2QtHnLYtowwISEz4OBDW0vPGRToiny2BwUMkBqDX1iItGKiSp?=
 =?us-ascii?Q?QVjmv3aN6Pfcy9/CSrwKmVU4Ohw9IQkB+CtsqbrtdiS1juce3b7bgvTPzObj?=
 =?us-ascii?Q?fVpQ9pS9uQUhjriELcBa+FKRV0xKPd9td/5eXwnxsk9u4YmuSrWd1kJE0zpt?=
 =?us-ascii?Q?UybR55ssD3/uSokuuAyPGXGRHtvZx57dvKwn8UzykLoJABxgvqd9i2Do18HA?=
 =?us-ascii?Q?/0K32ue8wZzdzBzSRcVJmOz29Dl6r8kNz8kcxXLyuY5iDRzI9Wl3IyahkE8i?=
 =?us-ascii?Q?aZGqQMqZyiOfU7kXriSEiae5VAfWy3mTBt4PMzyb3h8CU/HytspyExYrZjBr?=
 =?us-ascii?Q?2H6RwR117lsA5kJmDZKb8K3CcThcDJSIXzSUFEcFLLxC8qtRsVpF45HlSwLT?=
 =?us-ascii?Q?L1ieoyigHrkIjszqoaeskrFRTQ9oSkdzUSGV2A+A+59kwnz/AJ+DXU6kgMSc?=
 =?us-ascii?Q?wm0V+abAk6ECtNffepnqXiw4ZXx7MR7I1nBOwvoQ9P2Dta6PSMeN/VhFH9In?=
 =?us-ascii?Q?Stgs8cH6qCQUvMItcr2GHkgOjhrqxbxbj6g8Z03uRrw861qbrlZHyZjL828U?=
 =?us-ascii?Q?52pvBXK2MPZlj9kP0KVdy9rvXKLB4Cy4cVAlkbhkpaqujmHTYTCA078WPdK+?=
 =?us-ascii?Q?/g35Gt6rffTWV/X3WN6Tmt3cSHnesbDUs1bOlgwmuO5pFTC8d6S0z5vUtBGw?=
 =?us-ascii?Q?NC8Ks9VhfGBUQgdwfQdfwYKrLTj8+7DU8n5z/+/yjnSLn6VLObQL4KqNr2rd?=
 =?us-ascii?Q?i5dp4wnPQBdFiCmKWddwiiiSBHkyWTh31xDWe7c44Vf+jbHDydkucfxJncOo?=
 =?us-ascii?Q?RdYP/y266BBZqRRj+dljGh3af6Rd8r9ZR7bXSrHKOeFh6gCTe7Ptb2tp+okI?=
 =?us-ascii?Q?9lzawns3vKTy5Yy6ROfjwoyHwI6CcAEEm8xFPXBk/Z90eF800LCj+VS3sxJ4?=
 =?us-ascii?Q?XVHyXzJJXcKhBWj6y6nReMQwovxxp8fXGjxFU2jnjYHIFqfxntbfwWaf8YO5?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f311b6d-8aeb-42a5-3330-08dca2069b07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 00:07:23.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmFXKUahjvkv9SfhaLdPwv93OIDR+sP6eRD07aNnvBllhcbwArnfciS7UfEPL/pXxPjh27UE9yzYC55eoX9i1mxhgEpFbA3Ym679wAcp/xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

Dirk Behme wrote:
> Synchronize the dev->driver usage in really_probe() and dev_uevent().
> These can run in different threads, what can result in the following
> race condition for dev->driver uninitialization:

This fix introduces an ABBA deadlock scenario via the known antipattern
of taking the device_lock() within device attributes that are removed
while the lock is held.

Lockdep splat below. I previously reported this on a syzbot report
against nvdimm subsytems with a more complicated splat [1], but this one
is more straightforward.

Recall that the reason this lockdep report is not widespread is because
CXL and NVDIMM are among the only subsystems that add lockdep coverage
to device_lock() with a local key.

[1]: http://lore.kernel.org/667a2ae44c0c0_5be92947e@dwillia2-mobl3.amr.corp.intel.com.notmuch

One potential hack is something like this if it is backstopped with
synchronization between unregistering drivers from buses relative to
uevent callbacks for those buses:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..dfba73ef39af 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2640,6 +2640,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
        const struct device *dev = kobj_to_dev(kobj);
+       struct device_driver *driver;
        int retval = 0;
 
        /* add device node properties if present */
@@ -2668,8 +2669,14 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
        if (dev->type && dev->type->name)
                add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-       if (dev->driver)
-               add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+       /*
+        * While it is likely that this races driver detach, it is
+        * unlikely that any driver attached with this device is racing being
+        * freed relative to a uevent for the same device
+        */
+       driver = READ_ONCE(dev->driver);
+       if (driver)
+               add_uevent_var(env, "DRIVER=%s", driver->name);
 
        /* Add common DT information about the device */
        of_device_uevent(dev, env);


---


 ======================================================
 WARNING: possible circular locking dependency detected
 6.10.0-rc7+ #275 Tainted: G           OE    N
 ------------------------------------------------------
 modprobe/2374 is trying to acquire lock:
 ffff8c2270070de0 (kn->active#6){++++}-{0:0}, at: __kernfs_remove+0xde/0x220
 
 but task is already holding lock:
 ffff8c22016e88f8 (&cxl_root_key){+.+.}-{3:3}, at: device_release_driver_internal+0x39/0x210
 
 which lock already depends on the new lock.
 
 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (&cxl_root_key){+.+.}-{3:3}:
        __mutex_lock+0x99/0xc30
        uevent_show+0xac/0x130
        dev_attr_show+0x18/0x40
        sysfs_kf_seq_show+0xac/0xf0
        seq_read_iter+0x110/0x450
        vfs_read+0x25b/0x340
        ksys_read+0x67/0xf0
        do_syscall_64+0x75/0x190
        entry_SYSCALL_64_after_hwframe+0x76/0x7e
 
 -> #0 (kn->active#6){++++}-{0:0}:
        __lock_acquire+0x121a/0x1fa0
        lock_acquire+0xd6/0x2e0
        kernfs_drain+0x1e9/0x200
        __kernfs_remove+0xde/0x220
        kernfs_remove_by_name_ns+0x5e/0xa0
        device_del+0x168/0x410
        device_unregister+0x13/0x60
        devres_release_all+0xb8/0x110
        device_unbind_cleanup+0xe/0x70
        device_release_driver_internal+0x1c7/0x210
        driver_detach+0x47/0x90
        bus_remove_driver+0x6c/0xf0
        cxl_acpi_exit+0xc/0x11 [cxl_acpi]
        __do_sys_delete_module.isra.0+0x181/0x260
        do_syscall_64+0x75/0x190
        entry_SYSCALL_64_after_hwframe+0x76/0x7e
 
 other info that might help us debug this:
 
  Possible unsafe locking scenario:
 
        CPU0                    CPU1
        ----                    ----
   lock(&cxl_root_key);
                                lock(kn->active#6);
                                lock(&cxl_root_key);
   lock(kn->active#6);
 
  *** DEADLOCK ***
