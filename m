Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1717C220
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555498; cv=fail; b=QKULrCqMSZz4rBd4egKs0sXEhp6n6zbAzZ2JJG66dqymSLXuu6mz2EgSPPLSpDgTnpA1HpcUEY2nRPQegWvh2IIBoQ+FLAH5tz7pndpxUk2fCdRfNVi773nUboME5l5ApjBF+GRDEbTgETFBqVKzmO9J39L7hhmH2AvTHzviRx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555498; c=relaxed/simple;
	bh=zuxPM4jtN95ti9CpieMRTsTV6BoA61ArVTeqFxiYbiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uek+lBvPT3JAKH0JqjVkeAwoafnW5Apw3q/dd089ENNjNwnA9YS/lUYuLZHFfjkKu8E9pdqx0+iipEnP3XxiYI7DxfX3CIYQxO01fVgLGc/TqbOnyOzcJ+UtZ8tFcP1RcqCUEO9YOT8miYivfJ08rkq6FXLs7dIBnwuRkwCQSMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i60KVBXL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i60KVBXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737555497; x=1769091497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zuxPM4jtN95ti9CpieMRTsTV6BoA61ArVTeqFxiYbiE=;
  b=i60KVBXL1AONX5P+0gxF0wJGcXeA+lQsqcTdKmYIwjvryh1BJ/YEyRyM
   AxDm/hBljbh79tHsaqtTEj3arWrtMIn17DBJhvANP1A46xTZrQTSqiSPu
   sFhg2QZCTJdceLCx5tKJE0pIuAPikDwlgOLRHAh2B7CsGkI/a9V0BJIiU
   rLqjUSvKqBM+OADdJYZA38eSDWv/tTDTmiCUJXEK1+AMKPN/I3roOiNti
   LZgS7EVec+REma1+sEDRul9Tw8aIVin+i202zhBB2LF6270u62JrGaAlg
   XACFldyxGHQdRSc2BKlxpsU3Fqk/K8iubGYSIkJy1HOMbbg+ylL3tSVkR
   g==;
X-CSE-ConnectionGUID: KlBPmERLRfepFIOdbdeT8A==
X-CSE-MsgGUID: Y5jijCbRScW/Fo2vD2GIng==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="63365543"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="63365543"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 06:18:16 -0800
X-CSE-ConnectionGUID: ZXOSasTXRgiV1L4Vcts9uQ==
X-CSE-MsgGUID: Bu6P4FdHTPe65A5qu6j/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107025602"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 06:18:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 06:18:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 06:18:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 06:18:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjAjGExaOZox6kcjAjGfj4X8RFM7gtxEi7CYsX/HIOtL+Wdao0ou2Ax4MJo2Wtgp9/2+cRr/WiNndNiAJT5LG6ZlykmhPzPXi6taEAPJEruhW7wvy4cr0S4JFwX5XlkyBu6zzb0aLhfmZLI7uaCDg33ZrWNlD65wpzRsnqlUB7kbolI29L1opD48r9p7/05ZHXzb0tNdeFDmrDvdJGKiPcL7zGTl6e0wgUeyUiI4mKNAmYN2x6DLxncB36OYH3Nk9ZXxq/R301bFz15Gp9TcSQOGON/FINj3BIUJFKaaoCmPfjtOEoC5RpExPTkZUTKXgdxvdIJ0MKLUl/SptyVYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgXPS6OqWl77iXL8PIZtkeIpQDqwkdJJxpo19qyCSX8=;
 b=cdsmr5JIk7StoBpnfA/JnIvPFzEa2inAt/ku+/rCLsPHh+LKTs0KUG9xdHnPjOfp1El5LbYPrxuahFZc1mIZX8xlsaIm9aSwXOXqjQI5gc8N0hoyFeE0pYbol/loplmmJn7gH1HrJzWZbVWSwCeb05fANIqDsj45/E95eHNdGzlkgDOng5ZNWqnxP2Mkd3s2McVZjX9uHBBn865OEvdPYc7o3aALbIZwTnd6UUYY78y0rdTJ5DKUTyzSgADsQ17tmdJUvrM+o9+ZzLTvN60luG5wlbMEwgXUSE7Va3EhxMxvbWcIKHn20H6iVD+x8FEcGCSx0cGFOWyG7tSO93jYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7148.namprd11.prod.outlook.com (2603:10b6:510:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 14:18:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 14:18:14 +0000
Date: Wed, 22 Jan 2025 08:18:10 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <6790fe2295879_1eafc29441@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ccb2ba-1366-415b-c6a4-08dd3aef9b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKqPgfhAIWpEqBXtvQyDt3tv5YN+kTVNbhMfBDMUExvFri2LM8Wc6uLxWrne?=
 =?us-ascii?Q?9dtm7hEuSdU/gU24Yv3K2fh60NoJP4z0+1HhPAS8RGp0YLYqr+s2eJiN9a2D?=
 =?us-ascii?Q?DKT9Hi6oFMAecgAtyrBfgsl1DtRCJxjGF2vxYosXXp45EMcRYEqjcPLwImbH?=
 =?us-ascii?Q?OZMG86jHSev7KLVIIhJ9EDI7TjKBBdqnYtNwIiU8ivUVBGgDpLOoHbXHmetV?=
 =?us-ascii?Q?5ziNk/tierNeJE1tOITB1+eRIe0gnNc0CVlxkKOTRNMQiGyHQzljLBwmrmfV?=
 =?us-ascii?Q?0G5FWhvlMYXsABplx4PPD2ejQo2ZzwIbWhaVdMNgMPrk4nuJdMCh2W9bZlwb?=
 =?us-ascii?Q?mvwsEPbKGRNADjoX22eATtwWjlJJkVbwA3mdxBsZ4yUfSRxpR2GZ59eWjUjp?=
 =?us-ascii?Q?5EllLM/m6QL5zbpsoUrXTYDrWqdJxi0rYvjXq6oFKbRuVD0QqDjCzi7IjTti?=
 =?us-ascii?Q?3lxSe3sj6ApaN24V/eqNV4aeELSRJ2phrnBgZMdDADA/8lWKc3SxdJWuqW9f?=
 =?us-ascii?Q?qdutxvudfBjzz325PYpfd7/g1AhtsL9Pe4VWr2epnVFAiC5mJRFG636V5WBy?=
 =?us-ascii?Q?hf8gkeRh7ItyUca0kVirTZfCl7GvSLOfs6BVGe0NyEeYRWjd+7jwL0BHugHs?=
 =?us-ascii?Q?BLrSmX/3NGMzn7HXAcZl0cXaPgPcQCi8ypv77I3SUg3wup9dNpt+UyhytU9A?=
 =?us-ascii?Q?CCrI8JGKNRZkD3o7bYoTzGtrtJjyg+VEtfAx6Ynq3S9RlR+kteQlahAv8DBm?=
 =?us-ascii?Q?icLoyBct27F093prUirURq7mUQrmGhqs3C5zw4Y4avwKb9XILGSE3ROMkC5f?=
 =?us-ascii?Q?PsDt9ygW8YVSUbgltJOtjPgHBWkwhGYaSwMEx35H353StRrAL7LZszXV/ZYL?=
 =?us-ascii?Q?eO9tWKesBL0cbkkeeUmvm69dhuUtWv+24uYxocs9NE6zp1GrpNMy4kvLvPvA?=
 =?us-ascii?Q?wLppthVMg1ev/A3DPjgbNiIBPJYo+LK7zwq8FfzBeL7joJMaeKnkZQzFw+HY?=
 =?us-ascii?Q?0FseF8W3avL7r+YH6WbmVMoW8vZSze6c81JY4NWlNfkXNYHSWMHLFwwLvLSy?=
 =?us-ascii?Q?Ioc6IsV7QSBojz5drKSVMZ+NElKJkjH3YEWg3iQpvhPvFUKxJ6l6zKUvKNnR?=
 =?us-ascii?Q?1v4crtMIruUrJbrTXxs7JJeh6OzGGnzHBEREeg6Y4PLApe6vF6mDhCdIQFUN?=
 =?us-ascii?Q?axMuDek1iC6MtezlhiOadCjmzb1q/qyXForTLKrffLEmvQMBcCIQNgDuy3sM?=
 =?us-ascii?Q?ZvgNzos1t3GdYpz5DzgCTrAXtQUiDBtz6pQ65qDO1+LpNLugKXAu2YAgIJVT?=
 =?us-ascii?Q?gi+LI+SZkjISrtnsDHqlFVoW6gbHGN44JyOQQgv0bMqBsJ0loow/0iTxvhbh?=
 =?us-ascii?Q?GUAhc7X1pUgtXscnMyg4R4UIg/s7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2m+ICJZmH7CmY36ZDjwfqNxfvd1RHX0pcgr6ch1hO4iVGtzqgANiSJpj/iP?=
 =?us-ascii?Q?hb3+a60OKzI6TrlJaJzIsM/jzMwsbtzEW5E6Ra77EVUO497dyO82vPqGAuDB?=
 =?us-ascii?Q?d/zdJEyQ1KIVgsRqGEe0Y7M92KBdhB0UQBAUZ4pKrtM9BJ2T5VZmTz3/iUQG?=
 =?us-ascii?Q?nXds8rR3pAII6CD5/EbHmWyiWM44v+BoIkrppKTawgC3XEVhKRIfzmQa+nXG?=
 =?us-ascii?Q?iH82K5mI0u5jdpcilKlj3vfT4aTJsRV+Z5sGRyBRYGQCK51+mJRBjtJPskBf?=
 =?us-ascii?Q?nn1cHuEa/FXKwXRxkZ1hI6sh16SjrVX1rhYdASpQCK/rG8r+w8mg/lwS20L0?=
 =?us-ascii?Q?a8T/M5B1TvIrZjTnPH+w/o6hr14hIbo0ymdGyymdR2T/5j5nVrRg/5UoyVJp?=
 =?us-ascii?Q?WPYOzpGETbKOG4vCAPj7srY5SMx8PQ959GBPtX85GBvJM09THs1LoIZ8FsDS?=
 =?us-ascii?Q?jMoBl1SNWdNECPCislyE5Ojc9N3LZ4P1pgNUP6Y5YWFKu+yTaDGyJKSdhyPh?=
 =?us-ascii?Q?0Eh8tIPfcOJuHmVuSfaTNLKFwhUWJkh8sw/lLE8hC7z+oOLWr1q7bIhjhGEI?=
 =?us-ascii?Q?Mvg2d0MJhWTFXYVKsPssry18MTUUm5h+0artOLQINoIFuyISs43Udzr/Dl9e?=
 =?us-ascii?Q?Psn/SBoSPEip/kDJjHxyZNRdb/1gAshpxkrIO4PO0YqyErkkOQjSew7KHuB1?=
 =?us-ascii?Q?WfbCputpcLq5J7KZernlJTnp7luenbVds6ESQDGIYFMRnC9Tu9F13QtVMW9E?=
 =?us-ascii?Q?Rao/Pl4qRwWGxQHwsbyj0BRTbSaJP1sFWu/gTxg3MWBFWeY6nnzeNCk0RVAF?=
 =?us-ascii?Q?Z8BqKlhtgVoumTMQTFldrei6houmzCw8xcEpRL///PS9q9HNZajJbahE4M5I?=
 =?us-ascii?Q?UQVQx2ci/hVveq+hvQoKzMkE+v/sFgugHtgrfPwJj2mwG+qIlLAdGiRXh3Zl?=
 =?us-ascii?Q?Kdor5w5RpUDdpAzUIUyomW4gPHPxfZW+81/dBZIdBjEW8piQHfCqrQiZVIeA?=
 =?us-ascii?Q?944tF51guD38YIVNBToOOC/iSzo2D6SsSysG95z/8L9yMxPq8L9lDsyeAACS?=
 =?us-ascii?Q?qgiCrMHn04Ss8aIRW5QwRgla7go4Lbzj3V9l0VtUWTmdR+3ENGf5hcF0wKeK?=
 =?us-ascii?Q?LlxTtX61k4FckjfY6/NFzplZeN9XzahzOWy+XC7BN4s10Y3bW/1zlrL7JRKo?=
 =?us-ascii?Q?PVF3RMNIEYVKmRUYaz8IQgWjNPH5mQPoQdlDR/wOT19u4kZVXNMphz8gGrNR?=
 =?us-ascii?Q?Ie09XslpF2jmHaaNAcCzGHiaYxzJepv9f/EVF7ZVBFPCMte18rJWMzyKB1G1?=
 =?us-ascii?Q?xd2Zkc1YxM/mz6ZmQj8yszAjS0r8lBnfxm13Vh0dmM4bB2McLqm+YlzftdNI?=
 =?us-ascii?Q?LQagSRQe+HqcORQNjuJsK+/ZNbKyBTGCDEWSegPeo9iGc292xBAfmpAKQRjP?=
 =?us-ascii?Q?/zxxbwNzbs1DSyluT8KtHkPc6JBk2KOtCdtVRp3KGBNAIhGeLNa7REBhWKVy?=
 =?us-ascii?Q?EqMTG5IoU1hnlUVgvmKLEXdzStLIiAJVym1FFg2F2VbWLd7siX2HAvjTAMKO?=
 =?us-ascii?Q?3cjenJpmXhcIp8WCikXRfzt0rM1rH5k03v8xd+07?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ccb2ba-1366-415b-c6a4-08dd3aef9b9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:18:13.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ys5bb66Yopko3LaoaK4aURkwFH+rswfK7ZfU/goWRzixv6PJa5sRablgvWwgPxAwgLXwuNlt6hA20Q3m3KwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7148
X-OriginatorOrg: intel.com

Dan Williams wrote:
> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
> 
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
> 
> Note that a follow-on patch also cleans up the temporary placeholders of
> @ram_res, and @pmem_res in the qos_class manipulation code,
> cxl_dpa_alloc(), and cxl_mem_create_range_info().
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
