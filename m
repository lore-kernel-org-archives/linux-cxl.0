Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48D3B1AB
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465407; cv=fail; b=ij8lRVAsv6guj4jkRlcrsFf7MjkuEfBf8yAoeCRXin1ihTX9MUaygqDyvfUhGglKrDifzjMY1n9q4kaajKvLm6p0hw2pV52SkYGbcsxCCdO8ZmahNDgmqussLdzX7rF64ckfPZwtBYurB0TgHYHmO/WgaaQ9FicQhQJwBqnEURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465407; c=relaxed/simple;
	bh=iBAabnOZraAgeM/PZ9SpOLygcv9OdKu/GbRLnkAAVdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjSxA82q4WM80nX115PFr4lujHy/Tkq4CogZy0UQdM0ohc+Xysc1izMdusTPXPqc2KTVAGb3O+4E+TC3/P88NKhJTqrEnSMbFszV77WmhHrwzNibPjYfC/w3hWaMAKbs8bHdoR+b6IcXOWrVAXwCerQy6Ffz7YwAmPmCmow6dKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRoI2IJa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRoI2IJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748465404; x=1780001404;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iBAabnOZraAgeM/PZ9SpOLygcv9OdKu/GbRLnkAAVdE=;
  b=NRoI2IJa+XoDl+1SFqdlpijmcoyRZCcv3QjcD4gw+pvk6V8w6iP6RFZc
   v1Ml82ysNwcTs1kNWnROhNZt8gScDTToi/lIRChZYLoeF7QlxSzTR9uDy
   uewRjkfpROPpcnZmtmg13eJAX29tQlf9iuVHmkDUleFWkzMWtJo+7XkH0
   FExeCPIE/pOs6XLP7Fn4CsWugAF9zl+OfKE14GHdFJWvprxn6Tdf2MCmk
   kT2b1+t6bUhKLDd72PvzGlVmuzChz2Xk88ANm4UXMoS/mvjQDDRR98cY5
   UaEYAOxvLf+ptSYc1ro9kDDssQBrHPhw+9U46ezQ6ObsNOcebdMhn0QB7
   w==;
X-CSE-ConnectionGUID: QwyYPUKLSGqVfL89UsDVrw==
X-CSE-MsgGUID: ixG282aXRte/9l/VUIgIEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49755702"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="49755702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:50:04 -0700
X-CSE-ConnectionGUID: iwijHysmTByyDr2P5aAVrQ==
X-CSE-MsgGUID: QUOtNHCUQqWeouxEfs7R5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143337199"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:50:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 13:50:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 13:50:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.62)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 13:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecbyUSBart2tk2YvHYzVitM2yXkq4TqpHV//Eipqc/QkMPrciOTp/TNeZZech8vfQ/quoec0euJEhUtlpZ8zjVOr9a/heHzTDQUB8Hm9RZtyTVoojRQt7rwHOE3sSm+YjXVbZThZiPENtiV2/n30r41Um3+XQAEsiLno4wzoEYCBINC1E/E9/0UP1ALX6LMikK3AceordWCeJAwQgFQw0n3yJU0CM2eJaO6d9POXxgYkxWgSIBWAYSEKKLnCiiUOz9vfaLRV4p5TRmPaGJenp2SHm8SMzwaZ+omxqQTNVwTZshIY+pIpyIADfKKSFWY/CcKOeSqPZhqnS9ZKbV6MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqfBMic1BKYkPPTw0aBtzbmz2igBCYlP2JiEcwj+lLA=;
 b=PWrI7v2jjm0JGkHM1BCwNN7SrBJUoBaSdGcaR8+84J7PN39wwsoPK55D0VVklTdJ8pUjtOvz0qTtx4FxQRMa/dUg1Odv7LM3EKrGx29Mh+iTxEJ2bzgHP98OQ8q09xcFxM215seq/gtmkbjSTdeWkzmWka+xJXPJlfhkWMA5D3WP6q47nmLj9oO0wpedn49gWmo+VAn1XMMuCifiNGIP7PTeC/Ff8WNi4uB5Lxmamdnbn0IaGHbK5Smt3hZv+fJT/rf/Xk9RsFpxCYYwC/2hcnZGVeVD6SyTSOyA0XcxLr3eOozHT9jwy8ue4gsVKT7nOQRPSRbwZ0ahM/ynK0TK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 20:49:59 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 20:49:59 +0000
Date: Wed, 28 May 2025 13:49:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: ruansy.fnst <ruansy.fnst@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <sunfishho12@gmail.com>
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
Message-ID: <aDd29HN3R1HzaQ1w@aschofie-mobl2.lan>
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SN7PR11MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6c8b5b-8ecf-487c-6bd3-08dd9e2935e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tS6GR29nJromyx2dcomv+d0tNhgTc1AKuM9Ar3EYLH14OxUIkJdA8UeJX8hR?=
 =?us-ascii?Q?gMaB7qE9KgxxSbN5p3PbH3i79IPEj+qMtOlvcIyTreyJ+L3blm0l5qsKtJ6r?=
 =?us-ascii?Q?l+kbKiBYEqZSMNwLxu7TIPMn5AMGuTPOjhL9GU7kAJ0kOQT3QtvpgQxzMz1D?=
 =?us-ascii?Q?IszeY/OvbBdssRlVu8o/ZDpELojp8BUMiy34M8k4rXv3jHFzhiwvoEfrSy1S?=
 =?us-ascii?Q?dbwiiSTISbu/IyVB32pHegF9Mnr0cBlVFp+IG3yj5r87J84JzBbewhZZa2AN?=
 =?us-ascii?Q?LW2E5BREjDGN2l4Cow5xGwoLP00faA2F6yOiJ+PiwrH0+nQ0pVEpmk871c1q?=
 =?us-ascii?Q?tsgS6K2VqX3Ed+M59/bKz5JW/2rmYdysXmR1VYV9V/a/qDt+y+lLIinRAgrJ?=
 =?us-ascii?Q?ZEHZs1VySpECeClFaFkGnWyy5tXSxX/LF8bNnkmhs7oDbh3huDZsM87/kluH?=
 =?us-ascii?Q?XcAkpdxylpNHRT2XXCRXpRwxs1tSNbH3cAnLZqT7du9ZvFLWDAPGBK8HWIe1?=
 =?us-ascii?Q?9RlaaoolwVkt2htwnlxCHRL8FnL3MT47+s12sxZyiyTjEBCvYucJXD1mNY9N?=
 =?us-ascii?Q?sXXtIcjX5NFm4xRJKPb3e8MOaFNW9kLdjw2A/X4Es/iY6BFlssRrItf5qRdQ?=
 =?us-ascii?Q?4LNw8Y+DI04TtkVOa2mNK/dVPP1wZOFuTdZ1TUWMLYoi9NAQbBVz2wZM7X+B?=
 =?us-ascii?Q?Zjq0u1v+obPGnhwl1OhZpIJ28WrhaFTPCMUZ21DGtbiKrBWVGDJVGm9lE6pd?=
 =?us-ascii?Q?yURjXyCp6w9kUrpFGYdwQxf+HI9Qaxtt1OqOR5RwC9zs/LfIg/r4RuljAKmm?=
 =?us-ascii?Q?W6Xod5vQCYkDuocxkr220bgSmm7IsoOlXglFLr/vdS65iisRP6adIylmhV5J?=
 =?us-ascii?Q?uy0fg2rMd8T3eJfnm5YqnXpdTzMaS4r4XuI9t/6UTP08i82i1YkWDBnAEsJt?=
 =?us-ascii?Q?LeZUxWIc7PolK1szx40Z3iCY+3U06wmvmjanVld9LKnSakPRW/jHIA01oyP3?=
 =?us-ascii?Q?x66K5sETQVigi35RaiacPrH+wzTBrqclAMYEXCRwSCtKS/HDfWq+GPn1MXQD?=
 =?us-ascii?Q?wlxV1hPGZzP5jGdbelVGYBWLQdHwLrcX6fat6j5J3iIJIuxDrUDciQamsYlw?=
 =?us-ascii?Q?5b6gdcklTHkkwrUnowgOSdAQcJkqEcFP2KlL47AP4tbvdXUdo6Ab2FWMfYbw?=
 =?us-ascii?Q?6Ghvd2VN88s5tyZXx19uvMX1h426tP1EzqvpFUE0JPVZDsKLKVrFh47hrupt?=
 =?us-ascii?Q?qKVN3vruo3QVjQ8+jbzCsgCHal8g2fN/HCrv5tb7X0BV8OeLKBD9wQpZBQmH?=
 =?us-ascii?Q?t1vuh27k/t5p8gUg3gYU8KwQwohd45ySQgAD3r5Uem5BwqzQ6aWVZl6gsU3+?=
 =?us-ascii?Q?kuj4AYRscbuH47+LvY3rVp0IU4ngxVp48ja3lYMrdZw/ckTASsRL/1+69d1+?=
 =?us-ascii?Q?aNJxqdxpbmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDg01x4sYH0X9f8Y3JcdhqY+UQd+/mseclCAaSDbDpJx4JEEXpwuKCft+gN7?=
 =?us-ascii?Q?HH+c0L4UdrRiroqHea7JVJwziyZ95+mB7XOJMjx8oc7sn3m7yvz+iiHH/DK0?=
 =?us-ascii?Q?WN3ow03GKAlGgr8OkFpZU9heJ1F2+FibNeeMOtxLAxovepqOpwyNNV3y+rDm?=
 =?us-ascii?Q?gAUBQdt9B9rqgHh4xXgm4zis/vC7jFOxkxLGIeJWX9YnQLv+c43jZ1zMP3Ro?=
 =?us-ascii?Q?JeRdHiKq/egJiB+JSp8D2x+ceva+h4kfIk6ZyvRRCi21iIQpkY/uYeTh20IZ?=
 =?us-ascii?Q?68QkYCoUq/ooVV7yuf+8MFiwdrp5Ms73kCS09/6ikzBPzUBdpWa6a9yGZ1V7?=
 =?us-ascii?Q?9r089N+ZoO4lp8r0DXciwTQHpwa7U2z9GqWUQCRV8VnzDKt8qxO3kQn67SH3?=
 =?us-ascii?Q?+rEtJ3F1M2btUDasVd7AZFSEAb8gdZFFbHbhvNGZrOZxssONGll9nYjZNQGS?=
 =?us-ascii?Q?mTxK29Qk+4RY2GFyWF1zTdrD03Giu6M9Ol4kXxSGl+J7+2t7MOrjGJoEWMph?=
 =?us-ascii?Q?Rw8L9A5kgQGVBUYRF8a8TKxaeKRbUr0lDFOi3w69DVcvRWwTuo/198FcJdcq?=
 =?us-ascii?Q?pUD+/bsBHg3jO+uejt/ovT7ezz7kt37w5hh2R+KSJPKlLGxQZvu2kcfGpqXf?=
 =?us-ascii?Q?7gmJdeI4EUS5vF5vUQrz8ayY4O+F47xBHaC6len4hLI57MWpah9kDaUxMEZM?=
 =?us-ascii?Q?iu7MhALLjm3Gx+qIb4BsFdFeZCbekxEAlikgnJbdOmhOGJsQLOrrRUH3rS/F?=
 =?us-ascii?Q?2wx7oxXV4yEA7XPogIEUfyfZrSzuEIhJH0kg6IOpqjslY+PAoR0w/qbFmTz3?=
 =?us-ascii?Q?JIohqwo7vyEOyxU4jQP51MZl5YlBJa2jDMbUfqYhoavX0sqaeoa+Uanrblrn?=
 =?us-ascii?Q?6bFBe8r6gV9onxJ3vdiMF+CCkbhGBCYMz3JCCD+dfmFvQB1+T7DkUa4U0cjv?=
 =?us-ascii?Q?YY78fD4NAH0NpEI0KSpp5/S2ScZdOGCwRK4tHjYIEpQyGg3AVTRQrJ0vOqzP?=
 =?us-ascii?Q?yXYtS+SDoUw+6N3Y/yWJQbeHBsA4ieTo9tYsLqY3q2nSe6ECeKjry/q5s6nn?=
 =?us-ascii?Q?GAqa8zcG/bfcwgB4c3i3DNxacrvpYetVXIVWc8FChqRdzWB7iY0KvZJ/rxVw?=
 =?us-ascii?Q?LhxRJ/cjxuvmSNUD9NbsdaPPrYhfZdMkpwrYFN/oIVslBByYO1paCmobd9f0?=
 =?us-ascii?Q?Kw8suMpzdIpjg1zBC273MvVUEuIJ2z68LqOjAyNIGO2a8uYEi/rlVEDs7Ihp?=
 =?us-ascii?Q?PxKfsdWPFDaU+/ao1VFxs/CxKH/D3pe6TTQGy8hvkYMAbne4pV/igcfkVb67?=
 =?us-ascii?Q?H3SmOlMXxWVK7xxQc/Yc44SYMaYWoT3E8HR8HqxOfHdhTrpd9zRpuvc6lSfz?=
 =?us-ascii?Q?U0BLDTdeOpuYZarHQNLXstdx1fFYvZbQWUChpM6UidUjsYBG3TijJnS8vHXq?=
 =?us-ascii?Q?6hemhHc7XU1oCm4s62fKeojcXA/q76sRICAs5uKSfnZnjvsuCJfT4xDbRO5F?=
 =?us-ascii?Q?SnqLC1KlpOsUdcSP2Q+FadLP0Qupx0SzWVddNG9yyyMtmRfDqPUTlklCU185?=
 =?us-ascii?Q?e0Ede6l4/1LhkMb9YOd5FTZAKdct5kAbwxwUv+NZ/mdK8KsLKhC4gz7uPR63?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c8b5b-8ecf-487c-6bd3-08dd9e2935e8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 20:49:59.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHKfU/vDacl5EpfDfzkaS5IagRN2nnFYlOicxwIutcfYYg1OPdwFX3Z2C9OaKWKI7oPoUOXoChCwnpmg0kYrmPrhzi7yC6hvnA9rogVzAQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 07:20:03PM +0800, ruansy.fnst wrote:
> From: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> 
> Now that cxl_wait_probe() has been added[1] to wait for udev queue
> empty, the `udevadm settle` here is no longer necessary.
> 
> [1] b231603 cxl/lib: Add cxl_wait_probe()
> 
> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>

Applied to pending branch:
https://github.com/pmem/ndctl/tree/pending

> 
> ===
> Question to Dan:
> 
> I understand how cxl_wait_probe() work, but I have some questions about
> the motivation of adding this function:  Firstly, is it function added
> for simply waiting for new added CXL device been ready before cxl
> command does the actual work?  Just for replacing `udevadm settle`'s
> work?
> 
> Now I am facing a problem that cxl command takes a long time to complete
> when I run it in a udev rule(do some configuration when CXL memdev is
> added).  I found it is caused by this function: waitting for udev
> queue's endding but itself is in the queue.  The cxl_wait_probe()
> function does not seem to allow me to do that.  So, the 2nd question is:
> is it against the spec to run cxl command in a udev rule?
> ====
> ---
>  test/cxl-xor-region.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
> index b9e1d79..fb4f9a0 100644
> --- a/test/cxl-xor-region.sh
> +++ b/test/cxl-xor-region.sh
> @@ -14,7 +14,6 @@ check_prereq "jq"
>  
>  modprobe -r cxl_test
>  modprobe cxl_test interleave_arithmetic=1
> -udevadm settle
>  rc=1
>  
>  # THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
> -- 
> 2.43.0
> 
> 
