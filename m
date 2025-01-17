Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3419E7D1
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151746; cv=fail; b=JiJtVdUPkDYWbhVvlSCcKY+1x0BaRD3yb6KPvUgqZcZmj43IGJWCpxEL2kPG9kETFPfyJX9ba+Szqwmb1wnavJ6AV2swrEojZgcn8v1TqlA/YnW0JwMa8vcFYB8Q2wd4Lr0eljBN2ikZ9m7QWjJtBiS+td7AtBtroHKy6KIl/oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151746; c=relaxed/simple;
	bh=KwTGHIfsEA7xbfIfOGzlS7DA7R3sHcZcIss6fQYOCPs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=otW9c00R5bpWlrLmIsLyn8bE5EPsgL0LvcOp9pfovgfcDtFON+dl0PX2Na5OsHgMYNcn4tL7IV8Kx+wMpMoxQUv9zMEdT8fEj2tbwtIyOsBiKaoJHnkA4iO00EqCHVYM/upSdu6nWFtCbNJUKmydUYMmIn267jFUnfMPT8yf0+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtxQ73bE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtxQ73bE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737151744; x=1768687744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KwTGHIfsEA7xbfIfOGzlS7DA7R3sHcZcIss6fQYOCPs=;
  b=FtxQ73bEdF+cWTJTbOza78zT9oLKagknttshCVKBDN6VAu+w/lPg9lvG
   TUzv6EXj7dGVzByAVKADzxCtPMovUuGDlWWDEax5DxoNv2Bseg9bVc8ww
   jmF2L+1HB3hGkZlwiYS7QcuUHRWyLZtqpVCNV3Sw/Dd6qQJt1YSIOMZg7
   SvARIobzS9Mj9Ph2CI2U95GrYT8yResxcRXu1ySwPCZOqXWOiuJNr4JUL
   oq73I5xRsfHMNIOqniHtMU9eTtb6ngG6CNxKZjbXB6oKzJlQ1EQCICSca
   +xs3rpN3AhryjFNRQv3ZJgVVsr3LPtSOvg5Pa7BNP1Y+cgzfyLTyOsKuF
   A==;
X-CSE-ConnectionGUID: lmYR73fHQZeAKyewT0ajgg==
X-CSE-MsgGUID: pp+iC6h/Sh2te16cq7HE0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48264423"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="48264423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:09:04 -0800
X-CSE-ConnectionGUID: 9Rd23oZ5Qlu/1XNICTiDNg==
X-CSE-MsgGUID: +D9UatSOSu6Xlsel8g0fcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="110921009"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 14:09:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 14:09:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 14:09:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 14:09:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VooDFaB+hyQixFUEC4quu305q0YXQzwYZiJ7jJ0LOY/781qSXTD6weCStpfYJEVeVmpC0zHYjqvG4Az0P7zH39kflFxzg5P9J0Ke2Dq1xCRx1WfQ4kn57oUU5R0wItqaH5Z3Qn19VnpxFLAUWjUjMya25nakxP2OZHKr6YOhZ8tdInsM3osfiMvjsJx6we/2z19QcuCPKCC9IWLnp/qVymGA4T6aFZg+hUrNseVusYx6/DwPjmrqPTgMWo0YIWjsSCxMA812FqjDJTdBAqZbfHObJOdEqKXHl2V7WlD8PjWQgvLXktj6lrv4GBq5za+zk7B/guPcDwy8ksdar7EUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1LZDGpSiNlWCciMz8qXGGp3WTEnphDxz7PyVm/6qDc=;
 b=hJmE2cdHnV1DsRo7VNML+uVrNFiSxFIfrQv4sSXEVLSkX3cn439OCQb2qXxs3oL4SRRBUubyDlDBVJgagUyEwPIE1R02tIhEBTbCIaby3wsTPUvCE9lVPMcxGINM2bXSa5pHx0sNIuM4P5WNP0T5yIlYSVT9ws9vd81MBKR2GHxseC2ejEusyXUvnnKGMH7i0IiyR8V+IojtB7RGQX1jy6XE19fxO91zLjSV10rTIeFHvBDRfwtAqdtyJy98VvGZ13E9JOX4hjoNU9be74o6yZpw5P0uKafy+Aiw8iMG9P/MN+R368QnjeqnS2L45PGlsSSZJoendEXSf1qv0hxdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 22:09:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 22:09:00 +0000
Date: Fri, 17 Jan 2025 16:08:56 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <678ad4f8855f9_1f5289294cf@iweiny-mobl.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3188f5-15c0-48e4-775c-08dd37438bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVl+hS061iQGBwgIjdN8i7cj7a4oslg0hOW411lfddi1IcxjSOVjJkkVIkOO?=
 =?us-ascii?Q?TBW1uSB9jA40BPzg82SjaNYQ7WuGJvnu6g4YT7MRN84m2Xh3aGRi2E3kTKfi?=
 =?us-ascii?Q?jpz4f1k4uktOeelo1Nw7IuMUA3jj1o5l/CUliwxzCnliaihhWfGJIYLagdCi?=
 =?us-ascii?Q?wrd+PELgbTSREq7PrL5Tm2blrHZe0e5rOx9HG84B9pWwpTd7yaJjQEfy4A+0?=
 =?us-ascii?Q?Lm88l6grY0vl1pTnFnJXV03Mmjc08UBxi9WOtGVXegozmePwhvkrdS91aW6W?=
 =?us-ascii?Q?3UVgkjmDGfCFof1WH7YCxI0pHed5nr+GOd+KgLIbbrkCYRBdMKRbP/0uxqFi?=
 =?us-ascii?Q?Bd78Ps3gjq9B+uf1OTYZqnkrRrvA8dUTyV/RzE0Wq6OdRbijxAQY/OFEkdIm?=
 =?us-ascii?Q?6WR2nTPFRRsqnCSUiwBkEo5ZSmOoH7D4Jj3UNJBDWp9tJsyKzO892aFpW/qN?=
 =?us-ascii?Q?XthDRBTakzCC5hp+GN+jHTiG2mOCg0S5FyEgxB06WAiMnw6Eig8/l6L4w8kk?=
 =?us-ascii?Q?zxgNeLj2GFjCzeB+o820ozeAa2OZBK+QG+Q3zvryjD8vgDicCis9twFqCBge?=
 =?us-ascii?Q?Lj76QT2ZrWQOfZLwCpv9NjPWCctnwTxchHe0vFOxn/v2P6+bwXrCQwnEsK+i?=
 =?us-ascii?Q?PHumoXnk9Uoy/KTicgKgEP8sirj1C9RJKfq7qfb6u2Ymuefv9IG6aq6JV1l3?=
 =?us-ascii?Q?Q8TrdzAohfwLK7oZWoBR1f9oA5DwkCDhH8Sm4sg4Z60Zx/mOyqYW1UkkUYTt?=
 =?us-ascii?Q?7z3KQUuNKv7TEA/Ib81tBLAzwzGd16eAP5CR2fjbY6IxUr8pdPwbstbaNtrV?=
 =?us-ascii?Q?oqExA1Ig6jrbamKOlS8SWplNjPcPW7UGeQ/SPTacEsh//YFS8zerNobWH/AJ?=
 =?us-ascii?Q?DbEkjreh1l4PD+TcXAD1D0SbJl9O4E4YeNAp6BnnQggygZASRFKmbFz7tQz8?=
 =?us-ascii?Q?uBqflunO/jJ+qudRGBJkC2pgtV03Jt8MTNAchZ/Q8NOO9VEQL5AKdgyCvVWg?=
 =?us-ascii?Q?DJzA/6U9dn42Ha5K8hQjYbPuyuuSnrMGJXfy9CiGT8aSvjsl6W9g42EyBJ62?=
 =?us-ascii?Q?V3WlmsOo1JkAtxYH+czKBEoR3Lbec6hilkj8jBO/n78NEFYrPDQM3Aj/nK7U?=
 =?us-ascii?Q?AGEq5Ljn0rg61V+yuci3P1RgHVzYx5OSZUiDZJr5S2wfZ0NBER0ID3w6aYJp?=
 =?us-ascii?Q?OY58QPT2CK5uPgD9a5lBWoXGrSji/MzwWqc2BSN6FJYJr/ItSpoIvhlq+Jl3?=
 =?us-ascii?Q?ERKdYbDRVajBCXHNPlaeO9euIETweIGiblaxUTQ2fQKmFdNKl5iOM2fGSDdj?=
 =?us-ascii?Q?1eoBQCJPLnsl5jXLD3Xzr4x9rlInehJ9b31b6GHTK9g3mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2quU8DNDxa7QiHUNoom7/rrWBHYuyE1CsDfEuE1zPGxFF88FZYHrn2F7vbq?=
 =?us-ascii?Q?Us9daOHWfGzNYZPnohpT4xF07CK8SrZZme414+JDJmBUbNHlcw0fpyVkBUW6?=
 =?us-ascii?Q?loExo504rekdswL4m3Gi0kJcBh5OXeItRCNGzsGsJ3SdWN4KgzeyeynwbpS2?=
 =?us-ascii?Q?Egg2KK/BCzvVpKwwiLMG7gLFmI5EqpRsTXxhe98A0IgNPw1Y0y4TwcmqA3bH?=
 =?us-ascii?Q?P/fzjLTaFQfQ5ACNe73e6AZj9B17yfabEGgIc0nI4si8ieROYY3aA1YS1bsT?=
 =?us-ascii?Q?hHhNJARh3dsIOtB8DKhyIo2e8P/EKpm4MAHmjN68v3EtnFhZEQ9SQJaewbdZ?=
 =?us-ascii?Q?Y3ZT92J9phQXKX7hhdPOn8R2RKH/GWPi7QkiWFQHJ/okFpVSc5EyHJnsHw5I?=
 =?us-ascii?Q?GrHj8NQTa7sUXHyPKmTZGOiW0HQ9lWqNOehysaskNM+MhDET7NHCbJQe65CL?=
 =?us-ascii?Q?pZTENokij2ID3W+9P1n1+fyrB36+Qf/kYMihW5znWGg7SK6Qei54xt5xeLkR?=
 =?us-ascii?Q?jqelNBBv6n3e9XtGge4jZYHUtblbzNNRnzPj42ZkosCsiC6I7P+J9212kbq0?=
 =?us-ascii?Q?BqLVBNOhQMyrglyWqyWRq14a7hX+Aad40OGZSV1nTJqKET9h46jK8CQIi93V?=
 =?us-ascii?Q?MeIc3vpRBzf6cAJexHfeOfjo1Mc0IS4Ojhj/iaKilJXvOV6IzAsO7BepNJYW?=
 =?us-ascii?Q?EZYbcqK7By7Yds4B298AeA3uekjDTgOoxrpT4ta96XNHlvJrXgiBEhgpXJd6?=
 =?us-ascii?Q?7jZN3VQq7pf6CxUlPE0QLOca0mbCsG1wZ5uR38qafx7/QSYVhXFluNXgd+Op?=
 =?us-ascii?Q?4QqGX0FTI6zpY+0DAjyEbORksXqiE71ekkZ9ZZygnMOyn6uWszsG1naHRHZz?=
 =?us-ascii?Q?3uoK2/KuhqM+4uugLOe8z7Lhit4Jgl9aP14/ar4Q4cbxlYSMZ9cVaof8oiz+?=
 =?us-ascii?Q?zHQtTLwfxCJp69LXbfgOzqzKRJ67H1zhwery/PLdnqR6QhMDYtk840JAh23V?=
 =?us-ascii?Q?hoKCKniy85h/MWqWZPDUfKBdOFAElhnYOhXw8jLNBkwFix+uiu2w+kUOcfU7?=
 =?us-ascii?Q?pG/ZH3NZMbf4kQMOgDx9tevd9vmdzFOJ4btdVNGZ0olz1qCxvylWnPvL7xUB?=
 =?us-ascii?Q?EMIAsKmH2bsYQznmsPi972Vb1Bmx33APKgYmUGv21AP2dNqoja63TaQQcp4S?=
 =?us-ascii?Q?2LNao8z+2cejAPapCG6A/vbzudXyua/Iti66ei3Cvtwskg3aaelUsHlgHZtm?=
 =?us-ascii?Q?iEgiYZY1qy3rcXuk/n3oGq501psVQq/OZwucaXDQ7VcPkx8pI5+zAcyG4AoV?=
 =?us-ascii?Q?ifhHAOqwf99g4iHuJ07n8jl+d0NKzOBmVWmCmA+k3C9cI3sKNemziyWeOIuJ?=
 =?us-ascii?Q?BcanrZ8keeVVoIQ12hF4E2Zc/gr+EtzZWx+RL/1cjRP3QJ3Qfqkk6orY5tkF?=
 =?us-ascii?Q?2hICLNnDavS6Rk7FKeVswf+Y+6GO9klAF8ZK1XHt7aWppNr2PUzh4g8izQ0Y?=
 =?us-ascii?Q?idMwhD80i5hqTgi25pFQ3l5V9HqQhyP8Q5SZ2Y6Yg7prjWK0yrl3KYsjJKjj?=
 =?us-ascii?Q?3lfG7Kkb2d2h/ShJ3mBoUndk6yuIg4sjomNBjIG4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3188f5-15c0-48e4-775c-08dd37438bc6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:09:00.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLBscAKccA8H026RbI+4D8oWB4iJICOx96dIDdTPrMhU+YBI+gJrn0vUcvtvIh0U75+s3saqoUEwBbgVx1Kfxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

Dan Williams wrote:
> The pending efforts to add CXL Accelerator (type-2) device [1], and
> Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata. Trip hazards include:
> 
> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>   devices with CXL.mem likely do not in the common case.
> 
> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>   commands like Partition Info, Accelerators devices do not.
> 
> - CXL Memory Devices that support DCD support more than 2 partitions.
>   Some of the driver algorithms are awkward to expand to > 2 partition
>   cases.
> 
> - DPA performance data is a general capability that can be shared with
>   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>   suitable.
> 
> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>   memory property, it should be phased in favor of a partition id and
>   the memory property comes from the partition info.
> 
> Towards cleaning up those issues and allowing a smoother landing for the
> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> way for Memory Devices and Accelerators to initialize the DPA information
> in 'struct cxl_dev_state'.
> 
> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> get the new data structure initialized, and cleanup some qos_class init.
> Follow on patches will go further to use the new data structure to
> cleanup algorithms that are better suited to loop over all possible
> partitions.
> 
> cxl_dpa_setup() follows the locking expectations of mutating the device
> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> likely only have one hardcoded 'ram' partition to convey to the
> cxl_core.
> 
> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/cdat.c      |   15 ++-----
>  drivers/cxl/core/hdm.c       |   69 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c      |   86 ++++++++++++++++++------------------------
>  drivers/cxl/cxlmem.h         |   79 +++++++++++++++++++++++++--------------
>  drivers/cxl/pci.c            |    7 +++
>  tools/testing/cxl/test/cxl.c |   15 ++-----
>  tools/testing/cxl/test/mem.c |    7 +++
>  7 files changed, 176 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index b177a488e29b..5400a421ad30 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -261,25 +261,18 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  	struct device *dev = cxlds->dev;
>  	struct dsmas_entry *dent;
>  	unsigned long index;
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>  
>  	xa_for_each(dsmas_xa, index, dent) {
> -		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -			const struct resource *res = partition[i];
> +		for (int i = 0; i < cxlds->nr_partitions; i++) {
> +			struct resource *res = &cxlds->part[i].res;
>  			struct range range = {
>  				.start = res->start,
>  				.end = res->end,
>  			};
>  
>  			if (range_contains(&range, &dent->dpa_range))
> -				update_perf_entry(dev, dent, perf[i]);
> +				update_perf_entry(dev, dent,
> +						  &cxlds->part[i].perf);
>  			else
>  				dev_dbg(dev,
>  					"no partition for dsmas dpa: %pra\n",
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a85522294ad..7e1559b3ed88 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -342,6 +342,75 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int add_dpa_res(struct device *dev, struct resource *parent,
> +		       struct resource *res, resource_size_t start,
> +		       resource_size_t size, const char *type)
> +{
> +	int rc;
> +
> +	*res = (struct resource) {
> +		.name = type,
> +		.start = start,
> +		.end =  start + size - 1,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	if (resource_size(res) == 0) {
> +		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> +		return 0;
> +	}
> +	rc = request_resource(parent, res);
> +	if (rc) {
> +		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> +			res, rc);
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +
> +	return 0;
> +}
> +
> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);

Why is this semaphore required now?

Ira

> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const char *desc;
> +		int rc;
> +
> +		if (i == CXL_PARTITION_RAM)
> +			desc = "ram";
> +		else if (i == CXL_PARTITION_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 info->range[i].start,
> +				 range_len(&info->range[i]), desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> +
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3502f1633ad2..7dca5c8c3494 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return rc;
>  }
>  
> -static int add_dpa_res(struct device *dev, struct resource *parent,
> -		       struct resource *res, resource_size_t start,
> -		       resource_size_t size, const char *type)
> -{
> -	int rc;
> -
> -	res->name = type;
> -	res->start = start;
> -	res->end = start + size - 1;
> -	res->flags = IORESOURCE_MEM;
> -	if (resource_size(res) == 0) {
> -		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> -		return 0;
> -	}
> -	rc = request_resource(parent, res);
> -	if (rc) {
> -		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> -			res, rc);
> -		return rc;
> -	}
> -
> -	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> -
> -	return 0;
> -}
> -
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct resource *ram_res = to_ram_res(cxlds);
> -	struct resource *pmem_res = to_pmem_res(cxlds);
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
>  	if (!cxlds->media_ready) {
> -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		*ram_res = DEFINE_RES_MEM(0, 0);
> -		*pmem_res = DEFINE_RES_MEM(0, 0);
> +		info->size = 0;
>  		return 0;
>  	}
>  
> -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> +	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -				 mds->volatile_only_bytes, "ram");
> -		if (rc)
> -			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -				   mds->volatile_only_bytes,
> -				   mds->persistent_only_bytes, "pmem");
> +		info->range[CXL_PARTITION_RAM] = (struct range) {
> +			.start = 0,
> +			.end = mds->volatile_only_bytes - 1,
> +		};
> +		info->nr_partitions++;
> +
> +		if (!mds->persistent_only_bytes)
> +			return 0;
> +
> +		info->range[CXL_PARTITION_PMEM] = (struct range) {
> +			.start = mds->volatile_only_bytes,
> +			.end = mds->volatile_only_bytes +
> +			       mds->persistent_only_bytes - 1,
> +		};
> +		info->nr_partitions++;
> +		return 0;
>  	}
>  
>  	rc = cxl_mem_get_partition_info(mds);
> @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -			 mds->active_volatile_bytes, "ram");
> -	if (rc)
> -		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -			   mds->active_volatile_bytes,
> -			   mds->active_persistent_bytes, "pmem");
> +	info->range[CXL_PARTITION_RAM] = (struct range) {
> +		.start = 0,
> +		.end = mds->active_volatile_bytes - 1,
> +	};
> +	info->nr_partitions++;
> +
> +	if (!mds->active_persistent_bytes)
> +		return 0;
> +
> +	info->range[CXL_PARTITION_PMEM] = (struct range) {
> +		.start = mds->active_volatile_bytes,
> +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
> +	};
> +	info->nr_partitions++;
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> @@ -1452,8 +1440,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.reg_map.host = dev;
>  	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> -	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>  
>  	return mds;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..2e728d4b7327 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> +/* Well known, spec defined partition indices */
> +enum cxl_partition {
> +	CXL_PARTITION_RAM,
> +	CXL_PARTITION_PMEM,
> +	CXL_PARTITION_MAX,
> +};
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct range range[CXL_PARTITION_MAX];
> +	int nr_partitions;
> +};
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> +
>  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  					 struct cxl_memdev *cxlmd)
>  {
> @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
> - * @_pmem_res: Active Persistent memory capacity configuration
> - * @_ram_res: Active Volatile memory capacity configuration
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> @@ -438,21 +462,39 @@ struct cxl_dev_state {
>  	bool rcd;
>  	bool media_ready;
>  	struct resource dpa_res;
> -	struct resource _pmem_res;
> -	struct resource _ram_res;
> +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
> +	unsigned int nr_partitions;
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
>  };
>  
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_ram_res;
> +	if (cxlds->nr_partitions > 0)
> +		return &cxlds->part[CXL_PARTITION_RAM].res;
> +	return NULL;
>  }
>  
> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_pmem_res;
> +	if (cxlds->nr_partitions > 1)
> +		return &cxlds->part[CXL_PARTITION_PMEM].res;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->nr_partitions > 0)
> +		return &cxlds->part[CXL_PARTITION_RAM].perf;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->nr_partitions > 1)
> +		return &cxlds->part[CXL_PARTITION_PMEM].perf;
> +	return NULL;
>  }
>  
>  static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> @@ -499,8 +541,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> - * @_ram_perf: performance data entry matched to RAM partition
> - * @_pmem_perf: performance data entry matched to PMEM partition
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -524,29 +564,12 @@ struct cxl_memdev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> -	struct cxl_dpa_perf _ram_perf;
> -	struct cxl_dpa_perf _pmem_perf;
> -
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
>  };
>  
> -static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_ram_perf;
> -}
> -
> -static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_pmem_perf;
> -}
> -
>  static inline struct cxl_memdev_state *
>  to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  {
> @@ -860,7 +883,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0241d1d7133a..47dbfe406236 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dpa_info range_info = { 0 };
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -989,7 +990,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7f1c5061307b..ba3d48b37de3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1001,26 +1001,19 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>  
>  	if (!cxl_root)
>  		return;
>  
> -	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -		const struct resource *res = partition[i];
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		struct resource *res = &cxlds->part[i].res;
> +		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
>  		struct range range = {
>  			.start = res->start,
>  			.end = res->end,
>  		};
>  
> -		dpa_perf_setup(port, &range, perf[i]);
> +		dpa_perf_setup(port, &range, perf);
>  	}
>  
>  	cxl_memdev_update_perf(cxlmd);
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 347c1e7b37bd..ed365e083c8f 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_mockmem_data *mdata;
>  	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_dpa_info range_info = { 0 };
>  	int rc;
>  
>  	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
> @@ -1537,7 +1538,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
>  
> 
> 


