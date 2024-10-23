Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065C17C77
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643604; cv=fail; b=PJg0PliUVIAcFf5Cv0eNHMpp1iz8TNlGCljxvXOsUFLtnNlcobgK6C7p8IMVeao87Qwq0y2BuY87YQuAzFQk0j/nnaHJPIMHH9aRLwr9rVBvSBV7Oi9MW4poyR0BTvyzI3OXZt8HvAd6JIgCbvYvq6gWjmfbPDY6VDlSbJeYnVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643604; c=relaxed/simple;
	bh=vGJR5Q1XTSmx7NUX2Z2uiThyl0pBCFFpEKbQcu8vV30=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fWanzWUqZhB+flC7D9HpOIqt2AMV1BcRZX/0LzbJc7OE+ODIF2yxjINZCJZwXAokijeM8LcGvwwYZhyKmEuR5AycTPqcq//Eg+tFWAXL3tH5273w+Gj1e/uF5ToUjatwBLTXtZDn8tfz7gPtMJ/coEHJPu22hpmRWzgyunCybaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+mwmNc7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+mwmNc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729643603; x=1761179603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vGJR5Q1XTSmx7NUX2Z2uiThyl0pBCFFpEKbQcu8vV30=;
  b=h+mwmNc7PCdANAsw44tDJCrfxLsJ2WrtRvQBEow+kXR3A4nz/rOkQSlK
   04ltqty7EaxFb6Bip4xdD47DiXtpPfvX3W9K+jt1KtdFkARP3MfaL/KTz
   POdwstYdMKDhZ9gZtbMwzTL0oi1EvHMTCr8KCcNgV+I99cwgPxO+N4D3a
   SAUddzK6SJf7HwsP992ifz2bWR1xWzP+vFCArUsNFTzpTw5mYqiWxd9XD
   aBtCXDKfkMtbF4wvasBKTWELtRGedjdyaFEtqCxErrK7s+5Lm3BoVG+4i
   7Ni2IHGWu3/KS4/89K6dUX7JYXy5+kIy5cnCzXnTRcIoupk0OedNbaP2A
   Q==;
X-CSE-ConnectionGUID: WyBOBiRNQPi1bJhN085q/g==
X-CSE-MsgGUID: RxaC4grVSC6RsU3sEn0gnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33025453"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33025453"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 17:33:22 -0700
X-CSE-ConnectionGUID: b69MrBR6Q2m1Jhk9z7v2dw==
X-CSE-MsgGUID: 07o9YmU2SqqHFn8HYVxc7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80449342"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 17:33:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 17:33:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 17:33:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 17:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8ejXrdETHdBq3eiMiZE8HtLOIwekqcJ49lWbmN1LW3g9rhSZiSM0jEcYu9dCw2/PSwy3dMlxYgLoopaZuAgL7KBa+3MDMRuZSvZwU96J7+t0YAPOu6RsdX/ZyPmeArLBfaUKFsOzakXzesTAIEL55uEV+HVt6rcIMsZHgAeI8fgL4MnPV1u4sSnd9zVoWTeB6iIGMWpChwF1/5wlLrgK8l2YLJ52dzh/pQbj6Ea738Tj8BwJgJzhveCtZqvCbqOPMLzvkVbZ5AWoiN0TJGrecswREq/LbQLf58hAHZb7onnTs7D6uhh96Ru5YGAJZYfubpDNxk4khLIYprQkwqb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCZP15R6LIKV6v2PEWrtiEr7aCWCwUJXJWw8MFojON0=;
 b=eqe1+J1zoCbWNSovVQLoWwV0EleFuxGIq14o5FHjE7jV7k4vX1tl5XNQ578P0fL1kQQ4ABOQEOMjDrYk1GKnYJ+CtEIIg/CA28AxwKGtHPYMoXbakb6gYNx6l4aR+6E4ITsFZcsfpjtW95SoTwgE7lBl/x4gYOiGkBpsfiEZq+VBLf5F7QrX/EaLXNwNFSfdtWWW8YN/tLBBNhWNpskQ67qMoOwWwlzwtWfg169aDPhgAljOyzTZGMplMHM/cJ3Spuv1W4v3UvdSU3NoJ1tqJNpOXujFSlDgbFYto/uBTBTNWwNpD2otuAPFuUoKugtpVICDb+AQ8uYczAbUuqupuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 00:33:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 00:33:19 +0000
Date: Tue, 22 Oct 2024 17:33:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <6718444d93a40_4bc2294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
 <20241015173642.00007d1f@Huawei.com>
 <670ead2735632_3ee2294df@dwillia2-xfh.jf.intel.com.notmuch>
 <20241016155129.00001d22@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016155129.00001d22@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cb3357-578a-4447-1df9-08dcf2fa4b29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ien3L1Iz0yPH8q602zULZKEFdF3V8b36ZVqBAjXVJAS9SiRTyzgInlDKDnN?=
 =?us-ascii?Q?U9WE0GTn06M4c4X2YnkLCWVjxqPS34wsnMZxV/jK5YFQEuQiu1RrFtfzbn0F?=
 =?us-ascii?Q?+ph0N6fVeeCa0TBDOBBCBdgn7ApK+CX6iJ7XCUq0BEU4pXB74jHucNqNWbzp?=
 =?us-ascii?Q?5zwoiqlFUyvL7MyRtgeFVrsOfIKstetpdIjUCCwD6Tv3e6vV+MMH3HcK6YF1?=
 =?us-ascii?Q?HQGKDP3OPooCziXC3Icfg5lkngYCG3PmwODK9+TorRdTSSGDvlNqQMB2s0np?=
 =?us-ascii?Q?Xuul24NQ587MbTO/LrrV7HEbD8T8VcSsJobvCVNB5sUnkkpGOpvVwa15Nig5?=
 =?us-ascii?Q?VHUaW2clfUPrmASqOevy7RsQMLmkpBt7UcyMdhxarO1LxViqduXbfAfUCgKl?=
 =?us-ascii?Q?TCZ89RlF9mB5mjEv/hbaWtn1RQg3fKShGbfRxI3/2H/KDtWLb/GC3kzYYFtK?=
 =?us-ascii?Q?ZjjEFDXhP4bGkwXB/CCGueAemTXxHs3dyS3lXd5Ag0xuDkfPR2L6eqH6ad+o?=
 =?us-ascii?Q?BiPQPE1YO16ggv2XhAKI7b9LdPDQg9xgKMhgCcvjr5l+rtXc2BTpGmIa/OZG?=
 =?us-ascii?Q?27KCq4iw8MSA6FhS6h/olaJP8Ut6U7Ggnuwcn2z9REJuJLhPUmmJQ85iZNQi?=
 =?us-ascii?Q?qcCfMPlWM7+Jr7WCjzYNpOxgvHPT3H97pU7lgedubku9MAH5Yhx52QAADZU0?=
 =?us-ascii?Q?VKZYJY736eBz+/U/yhqDlMdvnBV/r8W3rQfG9kP7TJj936ov6sOfzSXxAq1P?=
 =?us-ascii?Q?aSuqlkrQoPGsHldF+C3duUxgzTpXAw+S4RfiNamJO4ZAZAhBaJCPpiF6dqHN?=
 =?us-ascii?Q?XsErn4fWneDy86U7nL/WW2DxpB0jHMFvF0M/iwBr1tytnDizJpExCQJhUFMo?=
 =?us-ascii?Q?LxEOO8bZFkbNEozwoTdOLAw1goRlFtOggXL6ne03rPeqSujRHQiUiBzThz+V?=
 =?us-ascii?Q?r0m3y7wcWyGrG8Jsctq8bUgQFzFxdMRqvPw/eJLpy2nAJsD/YZPD5NuO28wh?=
 =?us-ascii?Q?kanAXczWnr9ILynE3WTVMNltKJmxwAHFgUFbkllGpQeyWed9w13EKWSk+Y7e?=
 =?us-ascii?Q?Dtz4pClZaOp7oBY554i/COnXfAlOhlUyWYFTtVpUhoQ7QGribPqaxVMZH4pK?=
 =?us-ascii?Q?qEs6qH2Ea8fQTWkQ9vzRG0tWPLiTQBdtevfNwquYznIHbZuUkcz8bjQxpO7v?=
 =?us-ascii?Q?OAm3cjDfkNmqYynJwXcTZXBQ+s1sc+064IOMGEqZyenXvPkSLOwCmxj8bP/C?=
 =?us-ascii?Q?PqAIFalG4CTz8Tp8GzxG54hNxJQ3Zd5Wt6HvqMBiUaWbOJdX/cawQIRnjyAk?=
 =?us-ascii?Q?lntNkEL98c5FAy00rA4FP2X2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQR0PWA1VwjAWPm6JUvl1LZRgoIfAVB3XPOlDcWXoRKYbvY7CxwRQ8BoRnOC?=
 =?us-ascii?Q?bq4kY6FZDjX3CuJlTW4yf9Cjpl6tCusEhXEiMyg2/aWR4Gs0JaudlcrcHCHl?=
 =?us-ascii?Q?ZTV8HsDvaM9ylEwELA73Q7aqQeKXRnxpkQ1xf2wEMSaf1Pzq3sU/kczWGWgE?=
 =?us-ascii?Q?stWGM9dTyoBbLXFkzyxHPSNsDVM0Ov2A56vc4MqUO3jNDPsnsh/5pVx9hxb0?=
 =?us-ascii?Q?10iShdPL1vqz9F70Z61lJZ/psEWTDCpRCkO/T41F28TWJ9IydjCwvWpe8NqO?=
 =?us-ascii?Q?1IvumtjgXKDi5kQhDwUNOe3SWROsp9Ix8k3vNeZBX/8zm/uZMFs3T8UoD09d?=
 =?us-ascii?Q?3w9A95V7nq5SdkonVgiA/x0mNTk6s6QHQKHnV8AZSc1tbR8JT2N5g1MmBT9i?=
 =?us-ascii?Q?Mt0lPKmZba5OpuJKTbAvrwqTbOp3oRLbsmTTyTRYiyz/kzn5ZPnMgS1sd5uY?=
 =?us-ascii?Q?ASxQp/Ilox/yJSN7JnCt5LSaIqI96YMf0vQBSqYheWh7wzcsq+bay/sBcQkL?=
 =?us-ascii?Q?d7Cc1q7DR8AQBXogaf/bIwZuwQ6x9fDjTPBS9nE+rEvoJTUeyjBMZMcIUrXs?=
 =?us-ascii?Q?71ne0/0c+bidiq4Zeca8/riR07NpuICNTtYdCskauxVYMbbEewh9o1WUDGjm?=
 =?us-ascii?Q?G0BP5vLmlCKGJ3KquTs09R+cfWWZrKGu51r2gJWJr8iwHh57XwqkziSV9zEw?=
 =?us-ascii?Q?/wJNF1d80oWUJ694CBm0/L3d961GpaNpIrj3kTQ79t7DEkearJjmOw5FViU3?=
 =?us-ascii?Q?bPKyn5dmiceP3fzlaf6KPGFGEaeyvuAvHPrcis7inYZlYVyWD3/WFfoDH7oW?=
 =?us-ascii?Q?UZ3L8fqCBmaaH0iZNTS56kPG7kcu/99EloFc8AwTli8eMvDEjimSweUbb/ZO?=
 =?us-ascii?Q?AxZhnZawLcHkoiyOVXzlH5x9EbeoShthkAhJ9Z9zrvJu8xBlF9/pDAIW3dee?=
 =?us-ascii?Q?8CED7RcJC0YhUCalvdQ+EkjsCYzEsKqzG8lqwJCRyCxKiuSaOgYiTdE3OgP9?=
 =?us-ascii?Q?l/7/ZPlaO5d5FjZ8aXpQOCvL42wserfe1xRqBDMmG9O+AA/MDOglzZNxvGAz?=
 =?us-ascii?Q?nVLEcfE8HbGZjyoKPMLnfaKQKg+5k370GD4sxjuW/YTNfv9QBtEB0ZSQSx0d?=
 =?us-ascii?Q?GiCSoBnAI7IyK8RdZWAQTASRSzkdEO1WQ0gUeF5NZDi7BZ3rAxepvCVcQht8?=
 =?us-ascii?Q?76PxTDmHotfn6LR6sKWwsifT8N05wJJsODGse/iXRj81GUfexzkouPDlTQYH?=
 =?us-ascii?Q?AVQvkrBz3YJymxa8el0HoNTa4L2luSDdiDap46PT2kjGjvP6Tz281J1idbJj?=
 =?us-ascii?Q?CfeteNBIxn7+z72YFW8cK17Afl7EvHvv5W+o+vP/smR15EK6nrRw17TmZIB3?=
 =?us-ascii?Q?GaB6i1g/BIC+Skvw66eKxwxwynsn9wyoCRw/t0Qm5sCugE3kSnkYGUiGrQ4l?=
 =?us-ascii?Q?OP4KR1jUpgBUJ8VJem77ok3iYo4AjU2QKr1FBQg8CyYjYm616t98nv5rsCHw?=
 =?us-ascii?Q?38K3daXm6DGjlqFecrrcOd4CZ7kqEcqHMC1RX5XE2vCOJMkfDi8avn7/EYOP?=
 =?us-ascii?Q?bgNkh95fLTLfkxpPzDznO+BI6doRE5MhokVD5zsfeFQce/eLgOi3RTb/FCpN?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb3357-578a-4447-1df9-08dcf2fa4b29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 00:33:19.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvd+V5lcwzchQpa7RacQ+1knHgeTe6xknmFlPfUb4Fm3Yalfiq1PgrmfaQUrRcbQWf6AGKtAn91zM6QCkAOXv3vfgCCBHTUh3pihB4voExk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> > > >  
> > > > -static void cxl_bus_rescan_queue(struct work_struct *w)
> > > > +static int attach_device(struct device *dev, void *data)  
> > > 
> > > That naming is never going to be a problem :)
> > > I'd prefix this with something more specific  
> > 
> > I don't immediately see a problem since that symbol is private to the
> > cxl core. Any alternate name ideas?
> Not an immediate problem until another attach_device() shows up
> that isn't private.
> 
> Ah well whoever introduces that gets to rename this I guess.

Since I am going a v2 anyway went ahead and called the helper
cxl_rescan_attach().
