Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23B2FB6;
	Wed, 29 Jan 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168371; cv=fail; b=Usql4Hs7Ub3Mves9ev/gVvWR6PDCMbJW8RRGZQ1UXKe7c3YBpIKBxCd2qFeRklhHeBLf5IMQdfF8ijG+0rfKALoyKrE5ngJPvRi6LTNJqEtRyPk+QursUoXl8KnOE3+KBwA4nBV7yIFQZ66EMED76CM/6GWG3c4AhIO5GXx/Ciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168371; c=relaxed/simple;
	bh=Uc12RLyRBAOfna5MBrClWgKXl4opzbsFgV+VYWhc94Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7DLDoio4ZPTl3EvqPpdlhCYS+jWFMpCUOsp+cF7Jg8iyzIuwwpOtOxjnDU0z93ezSs2bR1814G/lKw/a7vBPxrAUMKmRnmeiWSbWmnj++WpHkCWqzLxKZAJb+t6E2G+wa4rpZQdSeZWnHqM5C/BTokDPLOC1qJy6AcvzLJ310k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aD9Jkslo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aD9Jkslo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738168369; x=1769704369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uc12RLyRBAOfna5MBrClWgKXl4opzbsFgV+VYWhc94Y=;
  b=aD9JksloVHiOUpsx9ErWSAFCjU+qSAbMmcT2pC0ZAB9opZwOGiAM1GKb
   z857zem0MRNEErfdSMDAytwTe5FBF+QvAGUmzIBI5rbVrl96TSwqK1h6k
   JJbaKMy+g3tZSCEVIwAfaPOdU5g+JhMBuz1gxNcFgTpk5XinDq0kCCvWY
   q/n0zRKaXHG37vpXP+uGKSJ9hCx76bzrycPBe0CKXnHC7/pzXIcHgRC4+
   rnbWQIooOTgclDdAAJattOHvRp2EMKcayM9OYPypKqCQGvzU8aZzrQQk/
   7G8JjD2/cBrQRNuUuJxFOYhgpB2Y6mghFdWL9EexPdE3QRLvEjjs+FRnQ
   Q==;
X-CSE-ConnectionGUID: VkPaGXErR8yDOi+EOVS1/w==
X-CSE-MsgGUID: 8KAuvhw3SOSadTf6R75zhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38595491"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="38595491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:32:48 -0800
X-CSE-ConnectionGUID: spNz8IC+QMmDuS2Emv0O8w==
X-CSE-MsgGUID: kzej9S4SRJ+qEtMeypqkmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132343884"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 08:32:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 08:32:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 08:32:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 08:32:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAC1VS8NtzhiYbt2M8fgxsjDeAqNErXWasIvpJ6oxoo68/xu5fODVdY5AofKT0+4+Vo5ymDJjffTCBmZFVLdNihMzpvOjhdbYBVjpvRPhOHiZNeRXD4bNM5JM3wV64v80JgOIbm44tq74lSM7k6vEIMZTvgwl4GOS9YRSPt14LIvgwZpSKyTXZ2cNOLLWLGIq+NIO6iNxfnTj3oeZ8IExV64n7tCEbhmXIs2V1SSzrTwEkprkNuGgIwdP0YCKTVpMjED6DXfH9NSdrp4hexJIJYxgukF1y+xC1/iT/A0q1+jmt58s1I12SkHGGcBcY1+oGId5YIMshq28bplMk1eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUvSkFrqVIIrYEKrZxy9kiHEfvESarq0HEw988r79Kw=;
 b=IPs0Ar0K6jNz5P6jiPcqtCUrBDDHXW+BlRGWy02Ka4YNAZ50EdFD2qTlmfITGQl3bpFhho1J3kV8GObM8fV2jHZivet1Sn0ene+XBAeyQzgSa4bUbabEYHg50Lle1Ysvbv5L9+vDvh1N8I4Q+mNZvmJiX4iQydnatq9Fi7APueWst3TcBqQRm6c48enGmK0HYDz9yMyPFbqmWmSjm9PiLuPx6auGoS35CrJ6gm4fUZMi8hyBC6vMja7SSEyvrhw+mXn1xDeW4UHCytduKON88gQIZA/agAluoO9JhypdJ95P/OmDS3bt3LJcdPuVOiiiYTCR9rU8PrEDrg0OcWsfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Wed, 29 Jan
 2025 16:32:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:32:45 +0000
Date: Wed, 29 Jan 2025 10:32:41 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <679a582927d8b_1e2dd62943e@iweiny-mobl.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <783abee1-e06d-45bf-2dc9-920c729978de@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <783abee1-e06d-45bf-2dc9-920c729978de@amd.com>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: ff128bf2-4dc4-48dd-566e-08dd40828f87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FG3LfBXaKSSNW1KSln3DzvgFHrA0InujYNX0AtuhdVzGzR/eePGwiu7Vk7zo?=
 =?us-ascii?Q?NUaTLCILTayLxjGCAEFDjikeyQ2OWtIitk0heF39cdjcs1U7BzXT2LUFYeTK?=
 =?us-ascii?Q?M7GFFhvF7tRjqFHW7fTRJdLhq/WNEnVe9l5bkT1WsYe/i/8g+izGs1XNoIzM?=
 =?us-ascii?Q?uIJCrTMDWwfrNsMa/ImEGO29Mep2Tr5cUi+mCU+wBdFXA1OaHG/12R/FP1Ta?=
 =?us-ascii?Q?FutlhbsubZ7PWSp8DQQKsH6lCLxr1E32BcwbMPbAY9DcWbhQvgNKl/xEgSNl?=
 =?us-ascii?Q?x/c1c/bvAD6i8tpik4D305+6ComQtaI96Zl6HoTE2sbtybKRPxKQP4sMUHAG?=
 =?us-ascii?Q?JHqjCbekUlKMIZlLLWLBM+jh3UEAz94+RAMyNJn8WpWZ6UTooH8hHcL6R25V?=
 =?us-ascii?Q?qEM4BgucNQimtFdZYtYpIRb5ZvJTufxcxucDmccBv3MLwP4h/T1egXbIXlPN?=
 =?us-ascii?Q?BNTpmKl2pQwHMhFeC9snwg5i6mNfniJmOx3AsuH6EaavAa1ZHsA3I6ZuoTEx?=
 =?us-ascii?Q?l3frD3gCXPTU38tkrC/uU5dUXUQoisIH/XewwaH49lqO6z2AIdvrQj/YmnPK?=
 =?us-ascii?Q?B4DsMOl1P1mwyRZt5b756wazbrdFRvC2Eljq5l4fcLUm7uI/zx6dIYqDJJkN?=
 =?us-ascii?Q?IoRrW36y2vFBNPYSmfzJOJVO1APQr7y4d1ADTA9ILzw6NudGHXdwEHnoMwPl?=
 =?us-ascii?Q?p/rdL7R/bT0g7KEpzEe5ss8Gt1mSXvz3uHB/GDxkT/mx//1TYsRCi8IWt6HO?=
 =?us-ascii?Q?Bi5UfP0LERbDrAfYcsnHWUYQXiSj40AUFV2MC4fJyiVWmfKcwJDc2+gUIXxF?=
 =?us-ascii?Q?w2VxB7ypjmOt/nj+tT/fJrYeYTq+HugYQe7i5nGzHoQ8zs10KB7ZedbRupYZ?=
 =?us-ascii?Q?u4ZGEUAdPyn1762cc5hQa22dWB2ThtsaFbpShHw0O2+CKt9VS6/jsJwXV75A?=
 =?us-ascii?Q?63sHEgD32pfsCKGCyf1y+allF/5g9WA71Tgl5EVTXdf/82gcmie6YiOtcK7y?=
 =?us-ascii?Q?s3HfkBE+JTwKSFYnAAFXwLO8zwQYRQtdLwxwKT0ZVdM6nt7Jn8tcBeygROcU?=
 =?us-ascii?Q?ZO9Be93tgzHKOppXlnwGYYP33zpScsc9VeTEp7OjpJx56xe3gydetHF8Dxuv?=
 =?us-ascii?Q?8A7i8Zvb3BDq+lB0geB0l59qtUay6+/pzDXKF+mPDjARdPjIG0JPVRnF9RRg?=
 =?us-ascii?Q?3LXLPVOi+nbLWuDKW/xMBZ+8NvUQgAJYdOULAY45sPOaz/2DMzseqLwCiuND?=
 =?us-ascii?Q?/Qveau4/3aYQqz1NmhymsnlX5didIPXZFfZMN8cxblVS++DZ0i0L8AYq2izN?=
 =?us-ascii?Q?zAhEgATD/fK95Cy1SxnnYX4ppMyEIp1z0L08Aa6HnPy5GQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoMLK0ae+tbKU6m1ZTDWyzFIrHMsXreo5Ooc8bz+/jusmAnVlCBQ2mMhl2X4?=
 =?us-ascii?Q?JQLCCoqWlO1coGmHap4MERGnPy742kvgCMqrb5PkR9tfBNGPUb7nirNAI12f?=
 =?us-ascii?Q?RE4ElhWhOZMJJdZ7jGhoc8l3DOb9pTdY8yFNP3ucS2iBmIt/N/yRNtLGfwP1?=
 =?us-ascii?Q?epQKxZEEBx8/qe/CkYDOXWup9aVAOPVmE5RUrP3TdCFOqEmUiBElGP56KD9m?=
 =?us-ascii?Q?w2nZvJhoNMPW5z2dPVrvA7or90KC6nn8Xhi33Ny1DdNIVsVdANIDnUdz5xk7?=
 =?us-ascii?Q?R/9VUrTrvJ/XYfAD/o+qWLIPTq1suH3KukgZuV7wK8ZMT3cL97cxmk7l7LrY?=
 =?us-ascii?Q?t90I8VidiqU+dD3E+CLYXGjUyKVheH8nXFl9B1hgZFclL5zAV7G4/g219fMP?=
 =?us-ascii?Q?u8aKwxr/ytHBew1Q02k29xukN8UyHrDGHCriw81iVdK/XVog/GvFE/xv4C+R?=
 =?us-ascii?Q?w9aIQAYK46UU4taO8Kns1aRDmXGJIjbNtUKNZe66jUTcv4I5VNy616yKkCAQ?=
 =?us-ascii?Q?BDP0/MZpg156rN57lyMarTgJf3gcZ1ot82Qeq2OagZzrm2xIzTyS1Yzctd/G?=
 =?us-ascii?Q?2zHM0ocfN7pG0B2aWAj+tZyiaBRBvCbsWU+sdwd30fGIMhy6/Wqh+70ZSs6v?=
 =?us-ascii?Q?Zynkrg8WzBI66SptKVsJrkMe6kW9KMi5aweRFut3ONRCYBHYCSJB8Md7WRV6?=
 =?us-ascii?Q?8xkzOqUgEXFZmaL8AbFWRCR/6tjB02qQVoaxJTPyiRW/s3i6zqWGjIAjx4y5?=
 =?us-ascii?Q?Gb9GHns7HyWFu7n0ADtfk2cxrWk7/JN36kPvzpTihVcW3XKgmhGQHza39cB4?=
 =?us-ascii?Q?6sQtfm3X7XZcgQT+6Nx5LYbrYgl5wv8W4dyU578tOlJjENZoec9vVHYORqD0?=
 =?us-ascii?Q?wp7fBwSFUFnJcoFj11tDAtiMpTaT6VP6glFsfcIurwMY0quRSFotJgZv04sI?=
 =?us-ascii?Q?CcZ15/yCth9M36tsO+FRNmRaEzf0AZK8n6UAkLIj9140rEBN09AT4p6DgLiC?=
 =?us-ascii?Q?pFJHbF7UEOkhmatlaS4uXbTZn/EjEim+Ayc5op4aRDRmpDaMrN4IjWhVw/f1?=
 =?us-ascii?Q?Qbi5c15ftJ9z/LByCap2UTzOcEzB0eL1V3BG0bEX28oQJHigKR+LkEKmA8O8?=
 =?us-ascii?Q?ErqUvXjFwD55IU0f2mc/1hBEyhN9LIQaLlavt/cCnD8u7ytFd0jxvskwREkB?=
 =?us-ascii?Q?JIPEbTP7QtIQ68HKAfshVC8H8T3QwVyhciDojWpO8ZayU0qd6nZ2QHiQEdsO?=
 =?us-ascii?Q?GYRNk67zsALjg2M1O/OeAsvEWwoWg/93AY35DZEquCGqCvN4SSajB89AqLPG?=
 =?us-ascii?Q?GeUUMfepBXLFCEJCwtKWW1uRTZpRB2okE3/Wid0dZr0PcdEXNa7JoksoaOMe?=
 =?us-ascii?Q?KsySzzDIn4XPLl6faON0it89oK/Lc/RXQyktsJoSW8I+jPVZScR4susUz5Xr?=
 =?us-ascii?Q?4HJz5YK0C56rnmHIjuiC+LHtnH5zZVKlEceABatzh6jDUSRg25rpQ4j9bwO2?=
 =?us-ascii?Q?cOUNwR7SYNRInpixd5mmE5EGpGta1tdC+wMzaxv1iDDhU2WBIRnwUnmB1aXt?=
 =?us-ascii?Q?dLWnkPKcHd86R+Jh80UxdWUq2Mcf/MtO0T2FOcUj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff128bf2-4dc4-48dd-566e-08dd40828f87
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:32:45.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clmC1dfqIKOY26y1RpNX/YNhwcbPMufleqoE0vHrVNZr15NDaJLaUR+Vhs/Rl4KaThzw6Z7OS1r8JsIteQ6VCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/28/25 18:51, Ira Weiny wrote:
> > As was mentioned by Dan[1] cxl_memdev_state stores values which are only
> > used during device probe.  This clutters the data structure and is a
> > hindrance on code maintenance.  Those values are best handled with
> > temporary variables.
> >
> > Adjust the query of memory devices to read byte sizes in one call which
> > takes partition information into account.  Use the values to create
> > partitions for device state initialization.  Take care to separate the
> > mailbox queries from the initialization of device state to steer the
> > mbox code toward taking mailbox objects rather than memdev states.
> > Update spec references while changing these calls.
> >
> > Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> 
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> 
> 
> FWIW, I had (as part of current in-progress v10) similar struct than 
> used here for Type2 initialization when there is no mailbox.
> 
> 
> I had added a specific function for initialising that struct, but my 
> idea now with this change is to have cxl_mem_dev_info initialized by the 
> driver before calling cxl_dev_state_identify,

Why is the accelerator calling cxl_dev_state_identify?  I did not see that
in v9.  My idea was that was a mailbox only call which is only needed for
memdevs.  And cxl_add_partition() can be called by accelerators as a
convenience function to aid in creating cxl_dpa_info.  (This and cxl_test
needed that function shared so it just got left in mbox.c)

> and inside that function 

I'm not clear which 'that function' you are referring to here.

> checking if total_bytes already != 0 for avoiding call the mbox command 
> for getting the info. This will support both cases for Type2, with and 
> without mailbox.

I think I agree with you except the != 0 to avoid mailbox commands.

Unless I am miss-understanding Dan we need to get to a place where mailbox
commands stop filling in structures unless those work for both type 2 and
3 __and__ are optional.  Because putting in special checks for the type
within a cxl/core/mailbox call is wrong IMO.

Ira
