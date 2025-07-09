Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E41F948;
	Wed,  9 Jul 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024312; cv=fail; b=NDOENCCdBlbm0jddk3YtF9vMB3kqjWpzXJ1eVkF7ex/PBA5O4F7qVkdzPr02KaNLpfqkkjWBYRCKZYKCi37FK88xfVXsBs8WMx2gIQKrig+wZ23U2hrlvLu1mslH06K3u6by0zObKnl1/rOlb2w+KjfsBqexbOgC2M4yjHSEXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024312; c=relaxed/simple;
	bh=73Ke+nIbB3CLQLze5ohZl1vEbgYdkOX3vbWMEBbTHrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/qlvS2EksGGHvKwhngqz+J1u+XLbDk/FdI553saH8YjmXFmIfvyxI5mJbN6XMXvsxYRcSGBzAX5FNCwPvUFhu7ql/FvM9Vnf5k33k+9lg159TmvdSrsTBA/ZufartFbZNSejjP70Ta0oCSP1WeyXrtFGf3mY0dAO06f4vpdRKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPAgZkGP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPAgZkGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752024311; x=1783560311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=73Ke+nIbB3CLQLze5ohZl1vEbgYdkOX3vbWMEBbTHrg=;
  b=cPAgZkGPnSINs9JUhU5nD/6HvWp028u2DQVV88yVPgL31g3017gkKOhl
   gzARZx8AnVe6IvnIn5L436mogjxlBti6KlDAjjEHKOPRUPXHlJBhc7XOr
   0llSjuEmz/6HcYN9F6dSqYQUFrZkXoAHpNWNYq+DMwjfvYnH6qMqZ7gOn
   6hTMBLJ6zoF24oYa2yA+yUHOe/6k6df7YA5jXWzOJieknf3f+buNJNSy3
   CMGXtpVI6dhYpkNz5TuVWb9mnjWGB017qcHVmuhZyjJJ58WQoE2uJZAGt
   Ek47gu8btc9u3KDtUYLkngB4VfvEKt8HL27jeQLz9DUiF2JANQRGyoITj
   w==;
X-CSE-ConnectionGUID: i/ZG52m7R42bR5nWFUyOFg==
X-CSE-MsgGUID: Sn1q9wn0Q8KMKIqeoT6efw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79712011"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79712011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:25:10 -0700
X-CSE-ConnectionGUID: V19V9980Q/q3d6u+vMcZ/g==
X-CSE-MsgGUID: 1/mrsMGKTTuqmJ9Ruhf1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159903432"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:25:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:25:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:25:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9cQB8RYIC5DY16sfTbdL9AQX4BKrT8Oxc5HgtwbO9w1E4f0ua0Szt6ytln+z9BtYwRs/VOiA47ncXOGbs9YAN3p00Pw4b2TVlcIiU7+xdKE+59RKksdEuKpaxcYVY6LaGgSKA7IxRCz4lzzWOTJdWcrGb4XBZNMc/3RA8HVT8tmwGGM/TuEjDDaMqI2/Z1Fy8fv9+QAIfxxvxqm6YlxxkbrcIDs64mIFtopP2XAAMIO97wlnKYYws4NJ0RCVjhyB4VHIieavc85zHhijP7oTay4QNciguFBuQSx2RHmMhCAZO9Ln/m0FDAdInirfROgX0zRHDCO+fFPJCpHAatQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73Ke+nIbB3CLQLze5ohZl1vEbgYdkOX3vbWMEBbTHrg=;
 b=VAOCKrpKNy42NFlSIKfT8T6KYNtFz2lkj4CTWGbWIvrsSwMPpiK4IMy6aa2TQ72TKBW7AIVZfTHn+XzEzUYZNiqlPVIZXZbDCuR3ijqVJBF/k5hB6jMovvgb62uokXnaCogteO5+dwFIL5Y9N06HV9LY8oJ2fA2JEgvk6SYmkTeuhkcEOXizX9Igj8yR7Rb081QSXW0k5yeIkjLFttoQ/hCT0gAsydhPeNe+6Ks8qLGp79TpBY2axjgbRhGvqYA5X09ioA6tGdDpwbg7Yom3xRZRGvLjF8cM6LVssTB+s8HiuBZrfTpQPaO8YBx1RLQpPkdKj5Mg9tu9/U5CF4pFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB7436.namprd11.prod.outlook.com (2603:10b6:806:307::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 01:25:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 9 Jul 2025
 01:25:05 +0000
Date: Tue, 8 Jul 2025 18:24:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cxl/core: Introduce a new helper
 resource_contains_addr()
Message-ID: <aG3E6ly0uFZhJZIr@aschofie-mobl2.lan>
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-2-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708051536.92119-2-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f982a2a-b648-40e7-4b87-08ddbe876f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5y1oszNpaty08nYglNE8qmqQN9scLGpZLB4HVMf29/UIPWvYffijCn0sqTKE?=
 =?us-ascii?Q?GrZQhhKVvaNOG7QJq5PKUaBp8x/mhZNxC/Mfg1/vJWdUF2waiUGkh5+YaplG?=
 =?us-ascii?Q?Cea50h5AsuxRejJsNRJ8rkkCRVNjKB0PONKaGGpcn/Y3Q8JCD5V2h3B0x8c1?=
 =?us-ascii?Q?FmTl8Gc+hNfvjDICm2e2A9HFawwIUTQnT5jdN/5AL+IoIIcOjKtU8OC50aqa?=
 =?us-ascii?Q?+XE3wPmVwsbwucKNppeNFS/mpnVvJCbl8snGm55OQ7ZnQ0sDV0xG0QjM5mgU?=
 =?us-ascii?Q?IWe54c8UHxHP1TwNe2x2lkhA3NYV6HIOjD8MS/zxvZGtPIR6yKIa3nJEYI5T?=
 =?us-ascii?Q?B7O1vJcb5WrAyRudyegaMeWbVTy/N75Zgh0PZLkJ7cW2MIjpje4i8z0U+/cp?=
 =?us-ascii?Q?dQ3bAOS0ULmSTuZ5CX9B+DX1EoTBrLvo1kBYgVXaensvxdz8HiyVC/g3O/pv?=
 =?us-ascii?Q?KKMUrmOt8mSANA8z8PRD4Xk30AsjIThm+R7sT/kGCt1SDL1S5YyzYRZL1MY/?=
 =?us-ascii?Q?62RGL1Yp8NFkMHX/do3+vQbuEKTDoY9C300VlXzJ9ACdVjU0qapADPWhdaup?=
 =?us-ascii?Q?ujTsNUOAymiQRIDdoLb7wCoRBF9fgcMwbmBpK6aUVA9VvPIjF3ad96LJRqsM?=
 =?us-ascii?Q?yAFaaxelcL4hUb2lISB1WcDQZqTq813hSpU8ovjqbQK60jRFzPH/yBWxdfWS?=
 =?us-ascii?Q?KZveNU6rXuAxOXJ69dpTYzzRFMLA5HANEpYzdlw/GteKtiDlgzLqwFmYHFvM?=
 =?us-ascii?Q?yFxxjIb0ZkkKGaL8OuXXMeJilFidH4UgmqmfVLf3bPS3sFXIyAsgYw9xs6fh?=
 =?us-ascii?Q?tot3zXx8Wsq/RceOypXdFOLBiZ6zJ8FDPAxVl1HVzSxUin8ConuOOBENjYOX?=
 =?us-ascii?Q?nKKav51dAP3ehQ7KKt1H7yeYereuSGAZvORIwzGGke3pHVhnaZ99V8d5knxE?=
 =?us-ascii?Q?pB9VLoc7S4okANWwueQImENMQU9ux4U2UoZBL/np/shw0BVTDUS6XZPjtCtE?=
 =?us-ascii?Q?cEPehAAxUlRAQP3CX+zeGdQjs0zXa9uTU4GXpB/OcxdP7IUTF2JJiTZVCtVg?=
 =?us-ascii?Q?6fbAgii7LeyCpcb9QTRK1gXpw40dzYDvf7AVrsG/1c1PFpEWEtkN6+7jnGQd?=
 =?us-ascii?Q?wGzdMiYKBF2B1KC46iaw2ibdVLv5OSrR7syQXxQJMlP/dZatTO0pzj7DoVmV?=
 =?us-ascii?Q?iuFZ4PVuh7PE+ZhTZIk0r7+fX+AzcIh+v9cnZXpgeWX/sJfJyvDgzq5zu/gz?=
 =?us-ascii?Q?ceSJDyUBjB0dGRkqHCpafNZ0nmIwIBA6bycjCyF5Da6wWquvi2QUvnulflu2?=
 =?us-ascii?Q?MkuNyhDEn2h/MAuXu9ZBJXb11c22qisd0+kmBlECZaJdPJwv+n5tAKNcJ7z4?=
 =?us-ascii?Q?QZKpk7eUgauJDhFReu0tKfD9jnjXhfR+p3pfnk1Nf4kT1u23KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtumUU/esQgyXM6oBoW+OcxZm+wgGeF9XLKWZWZENOe64xiK1cXgBXxu2c3i?=
 =?us-ascii?Q?w7ZMYWlBkyOr3hFRMvqbWdNUFqUVs43LRQIXz70umDeIhQinAAOWvsCpCzhN?=
 =?us-ascii?Q?9x/m5bZULxTGi6/iD42YsopJCn3aVNgHPlm9l2JjSWA0emZAQkf/UlgwmPWE?=
 =?us-ascii?Q?SZAk5ykTz6sOwvK9zSt9kwok8qoqQUZsyeyPYm1Qb6z47/ks4Vk+UQ/KeQTC?=
 =?us-ascii?Q?9YOVATJCv/eEaKdkM7Od8Yu7d65t8FJutE865qjVX2zjueoKUp7/SXJBesXa?=
 =?us-ascii?Q?3fHCrkfcllqj5R+mnGwZdzEkRK97OI6h8oDb8N7/nF2peLDdtrxO/qp8jrKA?=
 =?us-ascii?Q?UfffPavSIrMR8HOMd3FPSDE+P8Q6ZrFwilo9hqClTBSyZeRMlR+KXC/1ol+H?=
 =?us-ascii?Q?la5virmVk30gijvmBTDSfA0Y96XXInWoxtN4YSFsBsyGfvPbqb/XA81VWGXU?=
 =?us-ascii?Q?vFqXu405SdY0eVomfj9UGQ8G9AOmnCcjCA/f6JAt88UgW8J4rSgednUSNJr+?=
 =?us-ascii?Q?YDB670KB9S8Ltqg1PiBu9oGl1+wR+uFz3LyG7qjP/wa9tZk09cG/TTJJG3u9?=
 =?us-ascii?Q?kIdGXC8FY+dPdl+ULUg1f77Ysv+fsBWYe1S7x6Bu8jRhBsnGUsXSrQ0gnSrl?=
 =?us-ascii?Q?S6LZ+QgzcVS9ousNlcEN/VHDzp5LOuUMiah64jJWsiSdu5KPPeUm+GD0Ulqh?=
 =?us-ascii?Q?0gd5vHebKCEh2d+bUC1QDeVT2ikzgBnSDkH3qbgLa0/iRBUIyf1akqZ96+Uz?=
 =?us-ascii?Q?ONZC9oS3j7HTTgESCbEH5vIhX88udpPMNJXzWWRsYEZbK6fEzPD6cwvWZ6VW?=
 =?us-ascii?Q?ryoXGJzb5SU6bZoF3Jobhw+iRpMnvhRM1Vaoyqpg6km64XsRmwscSj0QcQIl?=
 =?us-ascii?Q?xeZ1FRQetu7knLWWdCKZMOwP9ExkHWg3iozGCqzlflrsRv27tVHxuE3KfOMb?=
 =?us-ascii?Q?pdGa4bDQX3aESA2OKiJHuEc1WiyY67WpTqH83NHhknJ04NWk7CjBea0dhMhN?=
 =?us-ascii?Q?CSxLo/D2puMsWQwwfTywLopncrDdQ58H9N+Q6pzySvkEl2N1qrmQgUk6JT6U?=
 =?us-ascii?Q?JjbRoO8FnGUzc//96g3H5X9nRLbVKin2tccnGklCE3MTXKJRiMrsrm7TIlhr?=
 =?us-ascii?Q?33lHAR37+YE3drElNxFdtSmailNEveJ/LA2VFyMJVQG0jpBqbsI1ChJWbNuN?=
 =?us-ascii?Q?DNiGvhJqUaypGTvt6Us/zRwlVUiZ/CNY6/viUSkNsYyDGrqIcBdQPTnobcgj?=
 =?us-ascii?Q?r+BtN3Z8SNeOYEo3taHdfbD8aPtfnF1ueLxO41ymcy9h4hfWijWrsyeVuys2?=
 =?us-ascii?Q?7r+CbcuFF3sRQfNU40uc27dTwkLdvX5srRLJZHorN9CvbK2xxwLh02wA0YCE?=
 =?us-ascii?Q?sIAg4ZYLK5j1nU/vH5ou+z+7m83HMh0zsFmj9/Y3TT25kPCBy3DpEnTIUDCY?=
 =?us-ascii?Q?XrxOcnpyg/hte3x2kX+AjciC+RG81JvG9xO3nEZyrcl0IE3tGFs5r774st5q?=
 =?us-ascii?Q?U0d4kRzhptttP5BLqtO1BkxzQLOYDa8Ma/4/Zk3I+q8b+FvDoR8BHUE5JsxW?=
 =?us-ascii?Q?CaieHhm6yxIF0/+djnl6s1uORtWRGhJHKV4Sj7viYirVGpk9QigfU3TGjtp8?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f982a2a-b648-40e7-4b87-08ddbe876f18
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:25:05.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY+1V73ZXxhiYxHjqV/tcVJpN50MxJbDyTUfqwWx+GQGmxT7j4eB3JS1pZZuY2nPT16DsUbWnvfNNfPqZcoluUsNZ8jeJ3x+b1RkvpN5L/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7436
X-OriginatorOrg: intel.com

On Tue, Jul 08, 2025 at 01:15:34PM +0800, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function resource_contains_addr() to check if the resource range
> contains the input address.

with the cxl_ prefix added to the new helper, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

--snip
