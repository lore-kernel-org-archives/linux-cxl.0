Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813A11185;
	Mon, 24 Feb 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422573; cv=fail; b=NlUv2RMfrYF8fT2GtC1chjtcRvvW+yOSj5XWS3ltHtBi7xIHu0T9qyOlBKJxVDZMQLeK2nWgtWqvSydhiRFPK8rN6cyhwvkZ+8bx2QmiFf1qiKByS98XvXftqrh59dhAa0DHyUUJaTWepe6PehQTxn4gCM0QYGYVuUd8E1rphCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422573; c=relaxed/simple;
	bh=ghqQpTI9Yqn/+PsJmG9N1129VoMA/visGfOoM4RUB1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sja8sZ+iCwV94HGPiWv+SIdutsrT518UNKTr6AUF9ZCnsukIU8ajx5hM9LVB0rBuf/Syu565DjAVuLh894BlAN3amEC2Oswp4KcLUNoGa5yFWJ6VYiCjnfSmeYYxq1TZQPYKOMtXomR8kw1sjtLMhmM0d6d5sYhFYKYDJxDmQoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG5/zN+S; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG5/zN+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740422572; x=1771958572;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ghqQpTI9Yqn/+PsJmG9N1129VoMA/visGfOoM4RUB1M=;
  b=PG5/zN+SgXmZ/ICWDuE0aueZivO3rJYFAQ1s05JDlcaMVuEEa1myAQIl
   MfavaRNNAepJtmneRYXTJ8933WgHUOuj95uM855ZuppRfPjOlZIgaRsk3
   DxjA3GZdSUnTrQuDhGboIRvNavMq8QWQq9VVTQeYLT3ZhaPvXa7lmb7Sv
   r1nWaOvHJ2Tuz3yAJVTjZ2oIkSTL6PzUBhLcBqf/wm0jbWkkXnv6+oD2U
   fLW0NlStH5jI7uo6StOfLR+q+Wk5R9YYMcKiXcDawWZi5At9NXxQDXOIf
   LV91S4i6SIFjDccPqRkYZdyqBoEGiOcQagQAFhFF29X9UbiZOcNRc0Nuh
   A==;
X-CSE-ConnectionGUID: U2R1hpRXQu+awgf2TtgaIw==
X-CSE-MsgGUID: kXNggrJUQp+UtY3H8gRLNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45106077"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="45106077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:42:52 -0800
X-CSE-ConnectionGUID: L5l5Etc4SfKiygcmNlzgZQ==
X-CSE-MsgGUID: jFInmMcMRMabOLE81CMZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116633286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:42:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 10:42:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 10:42:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 10:42:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTnEabTBDKRL4MoDWi4Z0+Hw+nXx/c3K0SdhkeQiMG03Iu48VQbW9R8Yi68bYuav3MEqxxyF5+7wh8joljRiedSuNAUCftZGZdP00J2lw8DgdM0d8ABJjmBY8ngTEZpt9RcnUxJzsecxaVBskVhWtaMuORM1nFZXezwD+qHWVt+mU8zyMGvT1OWXxPXI3yznttN2zmtoqg6j5O28LDftQnqwx26AdwyYKEp3N2p3WijXnKcCPJIL2A0kULwCGWbNDZwM4QkqEC+KRczr0LgL6+BEVXfG/zZTleQO53ulByKVTmVhxeG+zWYT2BVxxhjOpibOuIqfSf+u7Xlcj2aPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLwFma2Gyr+SyUDHMppMdRozLn5lBFpNTS/KOuFpBb8=;
 b=BAE4hz95P4HxQe0OJsSPjVSSiv1m20PYg8kPZQVOIbEile0UdHoNsUw1AN+kje4SGPM98WchhcbD1XG6Zae7ANiTMRyyBB02VPmzUbBEogsYEaIw4QZ1OkZftvW2oHzsuHLq8l0UF0VOCYne6AlHFDEZDeXYQlNV3LcJnPkTSgtfHFx/SFxhYi+PP9omp6qbfD2SRHySv2fcN9fChGM4jw67Ypo/z7E+6ePuMw6W6HJsqMUNpSe2c3ox7Igr8O15TmFiUONnO1bfZZHLn41U5UChWns1ar3sFF1cYMA4XbxNGBhNmpLq8HSrHGuF/Am22B8yWop7m3mv+gZijf9zXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 18:42:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 18:42:00 +0000
Date: Mon, 24 Feb 2025 12:42:01 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
Message-ID: <67bcbd7976783_3b2c6c29455@iweiny-mobl.notmuch>
References: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0059f319-a9d6-49ce-4d9e-08dd5502ec59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vgkmpjBGw16H8Y+IiKQtOhcoShQpXZW1357bsd9QAnOmaUXAl7BgS5mcIuei?=
 =?us-ascii?Q?NsBgf5HpT0W8Hm5tpXvD0muVoCH/o+lx3O3S6u4CvKQnmFY4kAwsr6+qf1n/?=
 =?us-ascii?Q?mz3zEPHZxqM715naiVCsSbGUjb6qfbYWg6Beh/2e5/i+h96qD2pUe19/UBNm?=
 =?us-ascii?Q?RV2TRGkg78BUBMDCdx/nNSaDBvqicnLTYf1nl9ML0Xp6mpFG4LQNGTz5TyT4?=
 =?us-ascii?Q?iFUbERdBBCX6v0BSv9ljIkaFBR0YFbj6u6t/eRWmMPa/K7mCnJ+kjToXqLaU?=
 =?us-ascii?Q?uJxB6W7/GNf4pY49KGrj4+rJUNg1OgTiLoqsyspmGhvHgyl4CyvRiOzCDcUr?=
 =?us-ascii?Q?DVuxtMEnBtqeMn9EIU7yFEk0h2rJv+0nEdbzjWyTdxsuDKEBs2/C9usimAfv?=
 =?us-ascii?Q?hgB5kue5OF9PcOczHrjMAYfVTsFoNpOR2SvKPIpHJyzd/wZnUEnOSdWJLr8P?=
 =?us-ascii?Q?r+vFjRsyww4vxkScsSch4Z6gtVdYnevQGMwdnpFKSTlsLVC3BuBNGx1H2itP?=
 =?us-ascii?Q?4UwYfCtRqebsSOLEm4iKjWOvaZ4a876kxE42nRlz31yJA/CFLL97FEZupqjV?=
 =?us-ascii?Q?bFs/7+KxgdzEVYYs4ibaKbOT1izDByhXTM//R0UgQrIa66y/5NUKND2ZUN23?=
 =?us-ascii?Q?KTfd619AQiTkMy/55FRdHtG+nWOeEjFz9mEusAqIpbQDpFParNyHGCK77+6y?=
 =?us-ascii?Q?GreMAPQSFlJfkm+u57D7AB9pTXzd2moXsCQ+yHdXmfpflvEtloXo7jjBApGb?=
 =?us-ascii?Q?Q1MfyK3aXpmMoaeQ+GDW1x9oP3rvTJzgoMkUVcdR3BK5WCzi0dziJq6Z5Bo9?=
 =?us-ascii?Q?4D+MjAVUKVP6Db3iFKox4Oz0WdGev1TKWsH4suabdKUFtfq1lxA8omOgJTLE?=
 =?us-ascii?Q?C7vz2bd6ptvVnmi/VW5h3M1qPKNHbgPHW4/xXJCPMccEI3J3pjLBaqz0FQgD?=
 =?us-ascii?Q?MHZtklr7fL678GC3w7yoQPrvzr5FkCZy0u4yfLpjTI8hEUCYYc1fAjYg/lBF?=
 =?us-ascii?Q?v1EQ+rseRfsEdm/E93S8AEAmcGqd3zBl9HPeZ4ICaHaSezvTj7Kv0e6hRUXN?=
 =?us-ascii?Q?fFgJSbZ/AFD/QFwtSvoNTqaGV3hIr2VpQIlYL8h6BeQwgnq7hRUG/Z+9cbRV?=
 =?us-ascii?Q?j1+LIwP4sy7ql4oimEQTI8hesLs/uH+fW/fq1mPUqfN11WBTEbnCMeuJWmMd?=
 =?us-ascii?Q?oVF8AB5FUCVYMrxnzH3tPeznjyBWkDAr7axVhoiMMbxaa0mTOuVztL1A2rA1?=
 =?us-ascii?Q?vMpyIsUbZ3g22X+rUCQGAwwjHghdSaZUbcNZS0qLFjYi0UnwwLu6cRuNwNY2?=
 =?us-ascii?Q?oKVpSrcCQMYGq239ccdVV8E7hRbPEnKuVcyYcBudT2yNXkRnr8cKCzNgZJyn?=
 =?us-ascii?Q?5tY5A0uzq5DWNVUneVxS7nCGLnxV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMiXxAeOmUdqIZi3foWHvUAY7kz9dIYDmZQ47pZhiccRVj2xc3mcWPYqoFLf?=
 =?us-ascii?Q?OXZ0e+VMiaVL/QL30muetJPMSk8eXXurYsWPch05LAkbGHLrDV+QeSWFZQT/?=
 =?us-ascii?Q?WNbQVT3WVhr36RCX0ATiqe+CxFk0omuN0A+pH4XlQ+GHhaf/OGEkkRjL/8Mg?=
 =?us-ascii?Q?3piGGZCLk01vGxxG+dPX9IZS4bEKL+eqXRJqSRtwiuw8/mhjQGRtS3+jUwKT?=
 =?us-ascii?Q?EQ3UPDIxX8MnuoP0ZiutCcPQEJ4yoCaDgLRFRRzFQlilyxaL8Y+r9IKImVUg?=
 =?us-ascii?Q?gTULwohMnwKcB/gD/w9ysDLnFALhq+yFBFP0VicVEWjgVdDj31PXCVT6vQLn?=
 =?us-ascii?Q?nwSZXphoc5wmoG449Ba3rGulfI0ymWXxy4nqQc95RxvM7chQwTFI539vF8wh?=
 =?us-ascii?Q?vl6ocTMuNGvg3cMLQhngSlnRFbVH7aQQpRdrP7HQ+udA9+X+G+Mx4C0wrPSs?=
 =?us-ascii?Q?Hz/HNS1Zvn8s3ELLrsMyXqlNx/s5csJX2sKNemE57xVo1wUPb93YrOsIBTv+?=
 =?us-ascii?Q?QooEE3qIa5VVnDLOfdsowFfyBDsSaSVwAV88oUwnFw8WE5JKZg8J3w+zCYFH?=
 =?us-ascii?Q?hgkQnA4LzvS9zzWZd18wAJoysxBvEyEClyPY4cwxlB9iT9+CuNrSILLSD2Kc?=
 =?us-ascii?Q?CqjTMqTLPO+qHs9cmd05dnhdFjZzUGfhpgBn2njx0DN5q9Zxr5GiXwPtF2R+?=
 =?us-ascii?Q?D/P1jQAE7a4c9V8dWUULILcz7rh83+NhnCBmFOJa6yluO4MXgZggSIBpZBDr?=
 =?us-ascii?Q?msuIDjuF9DXnRIVA+z1bsrX8t1EoJ4zI9ZJxNUCIXiB27IVfP2Pj15FyH7d2?=
 =?us-ascii?Q?vHIZVV63BFeZILt5bogKw8RgEMj+lvBdwN9qRBgiHn+VGsrHcDQMNKdzcdvq?=
 =?us-ascii?Q?/gVzo0ms8mzo1aj35ycope3VBHBM4j124WqNI1EcjKkZufW+0H8YReQF/8Cl?=
 =?us-ascii?Q?I52cBeS4WuVHZbA2ZreTN6PlX8ulPabgCb8jOm7nQR4yiz8mV9kqiLL3qJdX?=
 =?us-ascii?Q?LmfhdclBz1tcHOBgrjiwk3osbDqYgchXBc2thqCrccDr4SC1L7GPSByVZw4b?=
 =?us-ascii?Q?H9pUVt/a6AVO4oLNZuszvLZKKdryLnVAHTEClYvoFCBEtbw9Mr9chKnZabHU?=
 =?us-ascii?Q?Y8rqjT9e9JtqPPFfrgCNALliVABtENnkF20APeXVW5K+P5p8YDeXV+lKjlZq?=
 =?us-ascii?Q?9AJQUa+FZjMmbGQZIXQEWxGkohlozShgrlQ3A2opgo2QxfGsXUwPRhql+APb?=
 =?us-ascii?Q?QUniiO2RHd2G5XPFSpQ7d6ofaI+S6Ruv63lAhCAaVnRIRM3oxptKyAM7vR3R?=
 =?us-ascii?Q?1F5qBMfcCO0VSuMV4Ru9Dg0e6tmqujsxYz/UbSLgFEUiGpoLJVYU3jZs0cyX?=
 =?us-ascii?Q?wNls0TF7mu/pXS3gVJLhNO3N69R7enWedEz7caCH3Xb2JvEU2/9IIJHoWIWK?=
 =?us-ascii?Q?LV6CUrzAk+42pq1sRh0oi7RU8or2IwFG47cYMjhQrRFrbS+Y33zWgzcPBg0q?=
 =?us-ascii?Q?9q2o5HXvIJNlBfPAzG0qm2ZliC86QCIhB58loNO1whYf/l+3KLVUpGmn8FR/?=
 =?us-ascii?Q?T4W0KnDF7tjyMooA+2Lm3UEP22nw2/2by1UdS8hI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0059f319-a9d6-49ce-4d9e-08dd5502ec59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 18:42:00.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrcI49eDsEmhfxPQxcPOBw81Tn3qRS+hF5X4kZyVBCaXnyxUoR7f3Gme1dIRvRq2CnbMBayWRZVacRC8l47pnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5059
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> removed the mixed mode.
> 
> Remove it from the sysfs documentation.
> 
> Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")

I should not have added this fixes line since this patch is just in
cxl-next...

Dave please remove it before applying.
Ira
