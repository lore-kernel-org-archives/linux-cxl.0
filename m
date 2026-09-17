Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E945563C
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685056; cv=fail; b=TO3yBU+/4zK1Jy9u+HKGkYmWaegGJc4jlWcEqzQVUoau2i1tw1+ac6qZTvUvQvUBePh7P/6SMygtJ7U7271lHHYDN7mUqY3KpAv0/awCCsfCjc0jV7Td1bRJoB+dIrsdhc9acTvFUy2EMZX39FdMHIulyDrAdlFCE/v+BFuMj2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685056; c=relaxed/simple;
	bh=wkqv4pDTyWrRVbuVQHUtcZUDU5gG5R9fKGRPDqoYt1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Io0TDJfhlrna76jI+iTRK2t5u4mml279W724nE6QgQaXSWtIfqKlHcY+AZCxT5yzcwbzmK1uGctAsTUDCyCHueR4LEufvqmNsMgl46KGu9M6qV2A1q5jxVH/U6oWSfUY/PdFuu3HrFqxRELB9zx3lAexfVm7AWDFPps6C4VNiRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLo0VS4e; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLo0VS4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789685054; x=1821221054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wkqv4pDTyWrRVbuVQHUtcZUDU5gG5R9fKGRPDqoYt1k=;
  b=eLo0VS4eHgcIEzwPjPM7SozVttYFQPsMQsS9gmkQkb4dS7wgjCxC/5G1
   Tl5IjEtGASmBizBGqWQ6/ggSpi4lwKbXps7mGrBjqCPMK6AjfaprJG+rG
   BEEVcgtI/1YxOpo5pGZlTQFRnum3fdwk3JAMX4XgU/KuPVmEMpbrNGgnd
   /Jpch6As7SuW5c99xe4QMnfwyEG7IJdMT4zzVrG8NkAw6z7gRl/86ozlQ
   mIdXjr/E3jAJ4k3XdclqnRhl2dFsuvcrSsx/oKXDVz4uVRBKNsUUo4jlr
   28oln1YX9QVVwlx9Siwgq560Ppqy9NMmFyrKZuV6MChlYryqDrZvADiSA
   A==;
X-CSE-ConnectionGUID: JdDogm1oSX25mfpV4eIkrQ==
X-CSE-MsgGUID: /cw6H5c9QJeDgatkWniCLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93991388"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93991388"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 15:44:14 -0700
X-CSE-ConnectionGUID: +zdaf3FXRJm1u3uNOnW+WQ==
X-CSE-MsgGUID: 1Lh2fAelTiaRYUVxQwkT6g==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 15:44:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 15:44:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 15:44:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 15:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9sFWsuEauMmZQ8+F7+r33lJfZEI3Elky6UBISEfBbdGwqKwt6E8rzeVGuHxlGzqM22q2XSiikfIz+rEMStwIZpD7PXzC2YAc2EX4Dq3vl8kEJ3myaH1hDqltyLeZEXSCss21wV4xpeGVwOQ2Uq0jWmsVsSiGgVFXsnxJcgPzF5sBvCatxiQfzjGh27W9+50Pcyi/TnxCuyqBmnS8NissOHmCVy8+dYz7OKYbNDliQvp1esIwW3A0qJJvO10ZG4rkLjVMbeEaVgtQGMdFSz2I3sIL4vf39YKMImeHLjS9Yq4uHunB+7uwqltLYN83lU29TRNPYqS+lrdOF4McKofqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24j3gyphIFtS0BykPzMAJJWz1Ss4nYEHmsxBzCigdPk=;
 b=O3fDfVeXNuAy4Zo4zS9+Oxy/kPPGrn77ECfFQiRysD9CUtWjM8ou7Myh1U3pVoOHb/8N7/artouMb0u2o53vb9Ve7usZRlw5cSYEylFn6bPzWAS5DcRPZUIyuk5RCDvDfFs7ZQ2aEHOQMUiZBiXec5BJs+phoBphI+/RimMsPcUOIie0I99kCxapaZOp28aSEhWTdb6f3b8EVEr9K9L1YcrSw3svlr9aKF1i0PHVDOnRAgx6nXPN3YxD1IL0LfE+yDYHO28QIitglWnyNKOJljgDc7PK7ahVnXhGHvslvUjvsZayWbPfAXKueAqTD8sNfklvcwbmxjug9ymv5159dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9376.namprd11.prod.outlook.com (2603:10b6:208:570::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 22:44:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 22:44:09 +0000
Date: Thu, 17 Sep 2026 15:44:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Message-ID: <aqxtNHqcq8QH8wRu@aschofie-mobl2.lan>
References: <20260917024632.1397380-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917024632.1397380-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a9c872-759e-434c-01f0-08df150d2fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|3023799007|18002099003|22082099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 8wcA5QRGUG3TPufjx+NgD3MYhVJD/beH5182peJSlzz1KLu6+BwzE4AiAYEe6H85f2v9t3J1zxv9lA2TwuJVv9agc2B4+992NWbY7yiHs6fb/DLmLCwnYBl7kfDL7+WDqYoA2yeOjpHF9dj3pGTZ2jNW6JlmN30QqpqF6sAG3SuSweQerIdVvWTDZcEVFMCCm7NjNyvpQ5uosDqiiSpwJ/FYCbzVAIQDiC1fATFg3Q2A2FYJpXchS+QHzEXLD1QgBWZrQJNT+FsQhutsJVYJMAf7losECYLB/TaPHhkpCK6O7HPB02Cg5tkHd3LTiF+hG6pwxemBpyqISTDH/dnSHWFPGNYc2e3W9fiA1JOwxFhgiG8OYvbaBBnKCGKkGsPrmIrOFJ0Alq/iKNgBd2WQYH+TsBK2xmcMBEX5ZTGK+7gZCJ0gfw3ZJT7wvzX/oHXfFb2rwkSCtG0Sm76v+go8On1T2l6pcBMdnGnS16dbZ5qSPlBphtUe3F1TcJDMbtcr5/KkvSIPldr1AkutSGNj9/g6jl5CaLSzUzM5y0ThvTdT7N5doETj6C0M/Zbz4eoydcSBExpjoW4JkDqTTYa5INIEqTq+A8U7RA4L4kpll9uOfld7YhSDnf+UYbWX6SSOpl8mGGB/zv+MipJUkm+j05MhIfm/rczNtNaYtLqfUCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(3023799007)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkxHo2rB7lPZVz5ydOAnwX8BBrqXqn+icMNcbs+ICNg6XVFJoQ6AIdPGLB8p?=
 =?us-ascii?Q?Gk2T5lWpeM/Lk9OsRUIggeCRP9pE+fcPhIzNqaWF+AIIKOCizaqFTAjgiofb?=
 =?us-ascii?Q?TjU7IRcN6fnMv5ILmVqWwHbtlpI4Lzw3O9YY1QRnVuLYSj1/oI8gkD8J4hFH?=
 =?us-ascii?Q?OXZRRGijlK3GpS8UXy0l8vZIOAywrH4eso5yPKPzi36tGvGHJKDxrTY10Fl9?=
 =?us-ascii?Q?hS5s60qsWe77alGXOV/3k8z6UHQiZ+Vgo6qs7kSSVjqoXoYZSGxawF1gHXKM?=
 =?us-ascii?Q?l33FdSxSYJM24diR7qEuvNK0KcVhB5KWhJh/5+b7o3j+Cs60Cbhvu1DSNv2u?=
 =?us-ascii?Q?Y7e4TIQRsieJMBPGp1NC9SJgvfjD8yaV5Mc7MTUkAqoRiKvvMOYcnGMTYGGw?=
 =?us-ascii?Q?EKUgSwt4rz/3MwQSvAlUGupdSMutwNa80OBZVRiRTXUEoiOLbtS/BPDufN7a?=
 =?us-ascii?Q?ZJY1gJMua63fgtWNiWhG1hejcHYq/4/j9w9xqhBWqPlwmkGy2b3LUYx/O5u0?=
 =?us-ascii?Q?OiQL5izk4RY/VgpHfMI/M4Mi73QVAdrwOncIiutZcdAPjRhWM98Lb/lwgZCO?=
 =?us-ascii?Q?EJezyU7yNN5OJnslFEfuHwziDP9g/nbPeU+6GisVVjVFwUrNd4BRc+NlJB9v?=
 =?us-ascii?Q?S/JDGSZ6b8Ou52Ut+MZgYy8McrehzExsZSVw2W+mJl6BwBo8tNS45cMkYsWp?=
 =?us-ascii?Q?z1nI9GrHiZe9tv0wWMWfH2CSt8yNIVOfBneq2uPE6XNuC9P8fdWAp/NfcUUZ?=
 =?us-ascii?Q?6xW1PFxQcL4AamBqeiVgybfpJulK3CPQ6QNkY7/yhTb1au6IVLYVE/wJZUyR?=
 =?us-ascii?Q?UdZes4xjORtBUL16n5lU+2TIxP5UXGpX5GxehVCBnfmeynayNosO9sO5Nogf?=
 =?us-ascii?Q?dCYRQ6AwOhhBIM4QtSSjDr0tiE1Xkkgqrba8EARSrfuRnIb1vsgL0DymlYLF?=
 =?us-ascii?Q?Aa/J1k5x/DF5ZpSaOC7pBrlj8canK02Jilma+Z4ihmyhcdmlyqkE0zYYFJmW?=
 =?us-ascii?Q?N08otuQHUpNTL3fgij7q0PP1U4wEw5uSkEPa0CYdd/7t0MLpMzq8Qwg8e5DG?=
 =?us-ascii?Q?KXr8DjEXsXoc9dJtPvtPT0YrnOd2ptS8nldLlFOQWP4FNgJ06lIsYz1Y4Zn9?=
 =?us-ascii?Q?gQzQc59Dt139bOumGMRnbMAGZzEIvR+SrrdqW6K7+eC1REciNSHin6N6nu/N?=
 =?us-ascii?Q?442LPSHyXzD29NKAqQpE3Ka03OvYwCNTdkA0nThc13v2HuCdWMk/6as7do+V?=
 =?us-ascii?Q?38CoorrsdJ97Gdr2/sZMnL9tamC5mGU0zedDzZQAGP8PXo9REad+jmm2T4EO?=
 =?us-ascii?Q?vV914QjBbfY/CIK9Pv3Yc1uYmktUOPDlErQV30JkSQoeByxEQ4DDYVtEQ/mo?=
 =?us-ascii?Q?QrQvkSC3t61dLp1eT/q9BkkZQgp0hXisi12b/Qhhrj13UjrPFylo6q16/sY9?=
 =?us-ascii?Q?DS5pkniOiNkEI+e61SQxlLYzaGG5TwnTh4fzLWcS8ijwWA0lOKakkQcEgjPt?=
 =?us-ascii?Q?f2GX2blcElip7KVtPuEaXRwJ7/S6DRS9LIfERiPEATS84gSX9++vkH7073qL?=
 =?us-ascii?Q?8MKup+WUbnP4U44Hpr76YNdKUgCKXIHes58Zffbi4Blv8AxkmhhcO27/JPsX?=
 =?us-ascii?Q?I8crwewmrwMHD7gNuskBVMFcrJA9C2DQw9uXkiIb+LzJFUkOGNqMH5w5WbRv?=
 =?us-ascii?Q?43uGllGZkQxX1mHUXFuSUtNZBfXmsnwhX6lQV5IajmUbnWrxQjgADtLayBTp?=
 =?us-ascii?Q?msm5Gc7POCZc65MjQMZ1fGkwcgiZfOo=3D?=
X-Exchange-RoutingPolicyChecked: 2uohQ4+dz+UvPPUnnmQTlsg17RRbVmFu90Q8hJJ8NrvkHcttnHxhhGxzYLB7R+FQMTO77hZ9Oqt5KbrdFJuTeQy/XQCu0BBHzk/xnqvrNHv+L3SK4VOahUebsBrYpuYPm34IwtChfUz1m4LJnt8ej2lfNXFwwZ/kzOl8rrW8OCpL9F5Ho17B5tH6WM+2ph+mNZe0iiOgQXLrYHwy0axP2RQhuLSLd8jOAhqpGd1CQt0A6aZPJVYcDLUErzCfRQdi4MGRtzrW3H5k52DXgsXgtpc1bs2A/iE+JmaGh3jixxRIi+CetWYNoYGcCl5CKRljvdvUgHCCGtW9eWODxekM6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a9c872-759e-434c-01f0-08df150d2fb2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 22:44:09.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIlgEawPB371WmW5HBSsIvr22/9Y6Q5Sk42NMm2LXAP3ewRmuUKYkB5h6PCGrthxrUZh9oKZI3OeZ/28ljLtV8jfIjkqr9GhIRP4j52ejRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9376
X-OriginatorOrg: intel.com

On Thu, Sep 17, 2026 at 10:46:32AM +0800, Guixin Liu wrote:
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code, so
> hmat_callback() exits early at find_mem_target() and never creates
> the node's accessN attributes:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") had the CXL region notifier call node_set_perf_attrs()
> directly for such nodes, but commit 2e454fb8056d ("cxl, acpi/hmat:
> Update CXL access coordinates directly instead of through HMAT")
> replaced it with node_update_perf_attrs(), which only updates
> attributes that already exist and thus does nothing for these nodes.
> 
> Create the attributes with node_set_perf_attrs() when the node is not
> backed by a real SRAT pxm.
> 
> Tested on a QEMU CXL topology with a CFMWS window not described by
> SRAT or HMAT: node1/access0/initiators/{read,write}_{bandwidth,latency}
> appear with the calculated coordinates once the region's first memory
> block comes online.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

