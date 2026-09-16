Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA003AB260
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522256; cv=fail; b=Cyh5651fZ3f6ndk/XoxzFPwUmOdOC5+bkxbB88BEPOoDj/U8tutJicOy6E8yvpIHGoKgIEhzDhJoFgIfT5hrx9VsQIyCWcbRfqZTdWcqL9rgsifTD6LmngTgTUDDivCjjW6e8CngAKU3SoY0nrKkl4p68toso+XJ6o3UfV4JY7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522256; c=relaxed/simple;
	bh=yPWFgOTpt34x0un0Cw5SEBTv4l8Y1fImhXn+jbkbkNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7kIS5mCIfd0ubibZt0gDP38vRbH8+47QUtmmfZdM3QuP8v8aRnX2+W+YJ+zItr/2Wq2SOMSNN/4cADHSLewVCkDNVDWDxY0LFyIehkrXf9w3zqBnTubUQ38HAsxZFZn7v8pVCOFPyZ5U95lu7QC8QZu09qSYK+tgobTRB9IqJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut+I4R7B; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ut+I4R7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522253; x=1821058253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yPWFgOTpt34x0un0Cw5SEBTv4l8Y1fImhXn+jbkbkNw=;
  b=Ut+I4R7B5dhiD4BhNBPmcc9FoA3lIWNnE3+ZnuEnufHZoFD6hPVgM/kK
   gIUDbNaTi6tHXZMYJl+QoycuSGVbSM01P6HWDKL0lSJFcY/RuMp+iGBQ7
   Qt3OLnnznHyLyVyHGNPUhCqAupCp7jgcj0v7HzkVXSIqIpEhi/2rdG6Hj
   HkrogxpjpVz9Bwazt9BBnErL7xTsuto+R8hLfWMqR3J9laf4jVo03Xc0p
   RYoMQApRVy81t2yyshYaSBcjVAn9rbTs46IsHg/VpNULCuH+HOEy9LbzZ
   DtTj/ePFesF32qgGVxgkoFJBnUfOnMQY1TRD2Jki53u5/10JI6welN/hL
   g==;
X-CSE-ConnectionGUID: Ht9lYkC6SUe63/HUo02OWw==
X-CSE-MsgGUID: 0ljV7Hr1RyiQ09YCSGRRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101242219"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101242219"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:30:53 -0700
X-CSE-ConnectionGUID: kmAZBIeGTYes3sMBvQ2Bwg==
X-CSE-MsgGUID: m7KeICD5Qa+T25RRdpwRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1404265"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:30:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:30:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:30:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMLChwZzL1xEdmlZ8FFqrri7RfNFvghyBfjAvJL4zusBEr+y0apyTXPQjUNE0wNJAwPhpJrjr9OVAyJ6yt3ROdSYeVjOEeKnSvy0NcTLYosRB+P3UH0n9BwDRLGs1rx0A+e3Sc9qSSxnUiqKXa53jGmKVWClwifMDSlTLg8qF2CFbWRdH3U2ZKTsKRI5yf0Ca2wydGLAuV2CigQ2dFaU6/BEBFs+tnSLNxgEQ8HfIM/qG3npF01IZbNsQ/YIG7erW+govX2LtUgvwakLRPZuXG7fY4PIMvYLA4j0a+3IMhJXlxLiE9Dm0u3RAR5SleN0tA0foB92NxmteOjZ083HzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZPzKclHO9/zXKIubAlDqowJCX6B1s+D6P5LKnhAs44=;
 b=fazVJ5s3XCVmBI22EUJ+koP5bOthQLrSDsY7CroZ4QKYojISAHJMVWt9yJzE4CvTVQAUIjHSOF+lOq/72x4UHKis/1+0gvEJBiYZJXj0bOEvx2m0otMCK0KsuuVQYfFfWYt+8LOmhR6A2u6QOmoiWiAh6UZ8aPBqvTNn6D2m7tAJFqgRlOd2HBDpkSSrQ4EGy4rydfGy43JI4hADu5wKPBn/tPBQWkMm6gFyxOBxdSVUKBQqWA1EYtWph7K7Rg3JRmRvGcQbFkA9EUGujKcKql8EP1cGZB58Uu3eSBfBqAovTAPo86tpwONAa5BxLE21wcIrNl1guocx28GOZMyFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 01:30:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:30:39 +0000
Date: Tue, 15 Sep 2026 18:30:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
	<habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqnxOpLO5_pnieGV@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-5-anisa.su@samsung.com>
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: db2f05b1-5f63-4d84-2ff0-08df13921d4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|10067099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cbG9CgD1sfLvYqQYfp6vVTtX5cR3EvnGWA7woqH9+N9iXBVDmiHnWzwEn5xSewg4NPxL2omrdkXXcysU7/uapuaCi4LYG8gzmbamRaHIZIq/vAKVE/tRJXOvQuZU9i5Q1eYLNV6ei1bytfovkaA2ln3rGVVD05tPdQpSJnpOJ9LCE0dFFqVrSWRGkaNtiWJr6mQ6LBlMSb0sCErp6o0eM0Ju7/wdRqb7tg9NAVLDYnKLQb2pbZwiOkxTQXqHFiR+NhfULfUxvRGfWkI4hTrJQNg4FfvUXu8BgxSmhY0s8UpAvkoiLaEFCrn1tBWs+YBi4e37wgEgeF/eE6ImSuCL81wiTOyg8tbSBSpqTCXFFJbKFcVgb6kINkMx6LDI3NQrZN/KezGt4zOa/0uOzNlKoyThay4r97cP8DUCuaaFYvDf4+ZN0NzY1HdbuzCh8/XvdVuwc3q/wk075ZjDp6DuBNwgavkPKmgKsI5tOERnHH/JTtsYs9/KPko+aRPsYnrZ1g45tbwEATHA7bpqUq2eFXDM0X4OG8WPg9TqIJkNYhoZz4AEqAfwYR8q0F4GqfHnPDwGvP60/SFFetfoH44KOSSpSFP+vr2aE5OJg4nnzXIHK5DJ/k+cel39fvpwxIPJtbCCVuB2mTitunpGjKTSqU/L+PTzL4+lisw9tW4OWXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzJnEi9NM7GhJaDwShIJ1sz6WldNryOf4dc/Ce2LxESNJfaDgBZbsQ3seiaG?=
 =?us-ascii?Q?Rzh9BsCn0ayIFcKMgGZvVsTQMyKmFO3uy2TUJ4GVUhkcKNVir2eeNv+0pi7P?=
 =?us-ascii?Q?MKs9UBGj8HYVc+NN/jw4GWfgrdH8sGKH+CAgUPwOsMl81OdWbzZqPSkTkEkO?=
 =?us-ascii?Q?h05neT2+yCfgSEr18lEYrLYH2qfr8LJkY4a905eJNAeg0q3f0PrJMIhG0igG?=
 =?us-ascii?Q?QhnnlG6PoJorParYeMnF8mII6wnVxitf0BdOqV/9jIG2VfVbuFa3lvAL7K5H?=
 =?us-ascii?Q?U4o+DDRHCOvTcb7WCnvhRfFMBUQ2ueYo9rhTzlz5mfCwD5YF/3A8tPBNl40N?=
 =?us-ascii?Q?agHnKhcdBr9vojT3zFstOg/Rpiy/LEGgoLzXRY3ge9fmYOKmMcYbg0EdPh6I?=
 =?us-ascii?Q?UUAqB9k7tceANXatJ7GgcKaud5xhBVmbv9/zgT1pWPyElyUA1y5eErg+vvux?=
 =?us-ascii?Q?bmnouVvNtYHMfncen9oHNqD9g9J20A492WnnR/069B6/whLBiW/jE5kCmYCW?=
 =?us-ascii?Q?5QiLsu/YbskbE00CBqHijHR9tnqhpRH9gLyrpHbtiKLNKbhcsewAaRgFXk8t?=
 =?us-ascii?Q?Jt5j1e4K6Tb81hlGjO0W9PtLP/VoQ1UW/b2YegBbf279BgS3lSKh80dlhLWR?=
 =?us-ascii?Q?sa9dxcqrfMC7Ahb/uArtiwKoOD12OHT8RxIy8TkyyNM8u4C0k+7Zt8sPA2jv?=
 =?us-ascii?Q?is2r+i7GY5cKuwX+W9kQXCH6BkcuCXdzre16l0H27nD5GhplgfS0c6Khy3yH?=
 =?us-ascii?Q?3R146FqujSdPR3XTPnpKeG554tCLk5FmpVYECsWS+ucduU2kqtf+rwNz5G3V?=
 =?us-ascii?Q?n+1EOX0KmLIIUh4qqnLhIkCGYvxLJEiQ6mcDtcXBWlOkLYOf3wn0+GRb45e2?=
 =?us-ascii?Q?k/d9vAFwuDB/si/HwKyPWDryntHiOhJLX8Eq0iR0FF5YFYS5Lnmg+2p/qUWt?=
 =?us-ascii?Q?xcdkCusek+6qDWqiJapq9LKA7HS5KMYRgS5oZ+xfIjfqUPTcbmP+rX9fsMFG?=
 =?us-ascii?Q?6dYD7g3NobqOrGDh4qYgUphirjUNqFGPTlUfBViE+myfwYJlwguomI0seReH?=
 =?us-ascii?Q?zQ5+uP4DtDZo7UJKxJNi0sAlSCfRqvNDxQkr1ivIoYs4RUqobN2Qb8sRmwC8?=
 =?us-ascii?Q?ka1yTQQ6TOX53FxQDdYqNglpL1QVTGWc5inSEKoNPLKOKN7Y3v6NbrUK9Yyh?=
 =?us-ascii?Q?IZwFKWPZiD4VNJyzRj/HL+8+MXRRD+9AFkdvJ1lm6EGDny+/gw+2/rikF1MF?=
 =?us-ascii?Q?ejZVHGnw9YGp4R7+mbq+uZn1arlhsDiHGjQ6D8JsmrIU9UQlJvjFPnldVKmC?=
 =?us-ascii?Q?UFlbpmyOoosrrUS7gJDLmVZrqlDmhZ3yspUjy/Ir4JR4NjkZw/IP3UA9U7+5?=
 =?us-ascii?Q?dLZhUaCza1tiVPp3gqYmlMjFyk0cH8u7QnafSBZ7dbGk6BOcSI4lm+9jxno3?=
 =?us-ascii?Q?AXSO1VjXj+T1R86ByNCj/O5w3v4Qcn6kSErTCsnYkDeX+WHPpRtXEF1esrlw?=
 =?us-ascii?Q?wREbgB1bJwkIXTakFnbuuC3qiz87vpCgnS2UX4sg9Fybut/8GaL1EPtYrj3h?=
 =?us-ascii?Q?ASLW7hccfGtrNKCz7lhyQdqVf1SPjZax4Y71w1GMjk74BzdzL/N8qFfePYmJ?=
 =?us-ascii?Q?kM52g5ZjFUL9ph4SAeB82GI9baShh29Z8f/jVXN9jc/yTwDn7EPkqLStYsnm?=
 =?us-ascii?Q?GljeY6YWmcjxOMldZEQWmHwaV/3LmD9A+vMcIWOyiBcTDXo1y+MnurebPC4l?=
 =?us-ascii?Q?eoxS1w2EbUhE82JSlfKT6eRrqN5xUrQ=3D?=
X-Exchange-RoutingPolicyChecked: MwipzTC3uJIGpHUdOTAsE5Ge3+cbMedUSWFTVR5NpeWNfwDx9jeJmLZCp8un3T1GgTzYTrbROcf1pEeQazRDWWt1GXdIQEnjaWVvWkBbW0Tjp3Gi6+ARnYMTbt4HilLrMirH5WLfKlPmhYNORg3Tsaa9B+ijxNTXN7sO34njJ/3/dsZEmD7RyTT+5MzhVOw3mPPGtEMX+ZptyUU7p3u93gXkEyNJVE7Pk8dVPbVKLospj/dIy1wsh/hez6F5Ueu1u0sp/X9aM2YUYt1KRmrglUW6w545rIrj3PQAeMq8RY7/dS6YwuO8acW17bviSmfkR4lMg6iN2tzwtIM72FEEdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: db2f05b1-5f63-4d84-2ff0-08df13921d4a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:30:38.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2MUDkwWFD9yQ/C0yCyc5AElqlis31/zShDhpDbbi8DnIxEIeqCP8tBTE2BwevD8jkkCFT974y8wtwHOPXvY8Acph8ruDredFgMx3rzCazo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:07AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Additional DCD partition (AKA region) information is contained in the
> DSMAS CDAT tables, including performance and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.

With Richard's comment addressed, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. cdat.c: set found=true as soon as a partition contains the range, and
>    break out of the search on a DSMAD handle mismatch. Partitions are
>    disjoint, so the continue could never match another one; the search
>    always ran out and the entry was reported twice, once as a mismatch
>    and again as "no partition for dsmas dpa" even though a partition did
>    cover it.
> 
> 2. cdat.c: only assign shareable for the dynamic ram 1 partition. It
>    was set for every partition the DSMAS range fell into, while the
>    handle check above it is DC only. The field describes a DC partition,
>    so ram and pmem have no use for it.
> 
> 3. Commit message: drop the claim that the read only attribute is
>    gathered. Only the shareable flag is. Nothing in this series or the
>    follow-on DCD work consumes a read only flag, so storing it would be
>    dead state. Implementing read-only (reject writes to RO partitions)
>    applies to any DSMAS described range, non-specific to dynamic capacity and
>    belongs to separate patch.
> ---
>  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
>  drivers/cxl/core/hdm.c    |  1 +
>  drivers/cxl/core/mbox.c   |  9 +++++++++
>  drivers/cxl/core/memdev.c | 17 ++++++++++-------
>  drivers/cxl/cxlmem.h      |  2 ++
>  include/cxl/cxl.h         |  4 ++++
>  6 files changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..05058d4520f2 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -17,6 +17,7 @@ struct dsmas_entry {
>  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>  	int entries;
>  	int qos_class;
> +	bool shareable;
>  };
>  
>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>  		return -ENOMEM;
>  
>  	dent->handle = dsmas->dsmad_handle;
> +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
>  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
>  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
>  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  		bool found = false;
>  
>  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> -			struct resource *res = &cxlds->part[i].res;
> +			struct cxl_dpa_partition *part = &cxlds->part[i];
>  			struct range range = {
> -				.start = res->start,
> -				.end = res->end,
> +				.start = part->res.start,
> +				.end = part->res.end,
>  			};
>  
> -			if (range_contains(&range, &dent->dpa_range)) {
> -				update_perf_entry(dev, dent,
> -						  &cxlds->part[i].perf);
> -				found = true;
> +			if (!range_contains(&range, &dent->dpa_range))
> +				continue;
> +
> +			found = true;
> +			/*
> +			 * part->handle is from Get DC Config, dent->handle
> +			 * from the CDAT DSMAS entry.
> +			 */
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> +			    dent->handle != part->handle) {
> +				dev_warn(dev,
> +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> +					 &range, part->handle,
> +					 &dent->dpa_range, dent->handle);
>  				break;
>  			}
> +
> +			update_perf_entry(dev, dent, &part->perf);
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> +				part->shareable = dent->shareable;
> +			break;
>  		}
>  
>  		if (!found)
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0ef076c08ed2..7f63b86887f4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>  
>  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>  		cxlds->part[i].mode = part->mode;
> +		cxlds->part[i].handle = part->handle;
>  
>  		/* Require ordered + contiguous partitions */
>  		if (i) {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a484e23b2b3a..efc3bf3563a5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1365,6 +1365,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  {
>  	u64 blk_size = le64_to_cpu(dev_part->block_size);
>  	u64 len = le64_to_cpu(dev_part->length);
> +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
>  
>  	/*
>  	 * Not an error; leave the entry empty. A partially zeroed partition
> @@ -1376,9 +1377,17 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  		return 0;
>  	}
>  
> +	/* The CDAT DSMAD handle this refers to is 8 bits */
> +	if (handle & ~0xFF) {
> +		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
> +			 handle);
> +		return -EINVAL;
> +	}
> +
>  	*part = (struct cxl_dc_partition_info) {
>  		.start = le64_to_cpu(dev_part->base),
>  		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> +		.handle = handle,
>  	};
>  
>  	/*
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fdd6b395dcdf..4a5793fa3cbf 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
> +		     enum cxl_partition_mode mode, u8 handle)
>  {
>  	int i = info->nr_partitions;
>  
> @@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  		.end = start + size - 1,
>  	};
>  	info->part[i].mode = mode;
> +	info->part[i].handle = handle;
>  	info->nr_partitions++;
>  }
>  
> @@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
>  		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
>  		return 0;
>  	}
>  
> @@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  		return rc;
>  	}
>  
> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
>  	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> -		 CXL_PARTMODE_PMEM);
> +		 CXL_PARTMODE_PMEM, 0);
>  
>  	return 0;
>  }
> @@ -674,7 +676,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size += dc_info.size;
>  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
>  		dc_info.start, dc_info.size);
> -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
> +		 dc_info.handle);
>  
>  	return 0;
>  }
> @@ -693,7 +696,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>  		.size = capacity,
>  	};
>  
> -	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
>  	return cxl_dpa_setup(cxlds, &range_info);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4fac65dbb808..9fd5af2e41d4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -140,6 +140,7 @@ struct cxl_dpa_info {
>  	struct cxl_dpa_part_info {
>  		struct range range;
>  		enum cxl_partition_mode mode;
> +		u8 handle;
>  	} part[CXL_NR_PARTITIONS_MAX];
>  	int nr_partitions;
>  };
> @@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  struct cxl_dc_partition_info {
>  	u64 start;
>  	u64 size;
> +	u8 handle;
>  };
>  
>  int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 4ef9511fbbdd..43edcde5bce3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -141,11 +141,15 @@ enum cxl_partition_mode {
>   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>   * @perf: performance attributes of the partition from CDAT
>   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + * @handle: DSMAS handle that represents this partition
> + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
>   */
>  struct cxl_dpa_partition {
>  	struct resource res;
>  	struct cxl_dpa_perf perf;
>  	enum cxl_partition_mode mode;
> +	u8 handle;
> +	bool shareable;
>  };
>  
>  #define CXL_NR_PARTITIONS_MAX 3
> -- 
> 2.43.0
> 
