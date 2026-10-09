Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B63905EA
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579155; cv=fail; b=VWKuhGWJaIBg2pKfMm1kjMvbA1agiP84+Cn7AxloKz56FLnxaDd5cZiktu7sKBNYbUy5O3l+udUZzTx0S2lwqjce4xMOb2e9miM6MUYy3OFTnBjdfKKAsQGMO/n9CiGgxhe8F6Y4lfX4dCKnp+A9j5TpPdJsjNAHvEHzroTBbSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579155; c=relaxed/simple;
	bh=X9FRbiNMPAcf63YIbfS8mfArwy1cpewwps4MwdlsaeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKH7LLhA/6LCuGEMKx2xYaPeJijT1aY7CvHSpOzmIUEg5gVNoSrcpd9W7kFAb8sHK8nIXBHpT1PEeLa1e/EzZA6V67wJja7l16mBnkz7PRBkLQlIX0f6fdfeF/8X9WXeQO3GrHHBFnXpw/mqwOMTZPRiPKokXC48qg9Lm/F7+uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lhx/CwjY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lhx/CwjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791579153; x=1823115153;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X9FRbiNMPAcf63YIbfS8mfArwy1cpewwps4MwdlsaeA=;
  b=Lhx/CwjY+TXWPjKdMH1lZ2Ej7RERHwuyZVdfH7Atv4bc2a/c2XP2yxCU
   rkZcA9zjJExCJomiaKSRZbJee7Nd1CbkZDtu4CVC6dPflwX9Yi0quBtfg
   KjTC5yLtZb6dnHIzJTXY4gqLOil8WUJpLJhxtKl7qJFKBiXiCX/nZHYl2
   uik97sTsJX+0ZMkO97vP5LLIQC3SV+IvyDaUeZe8qtXZ5sSXgijLVz9cn
   rV35LCFqP4Gn5KmNX4Jhusvkz59e2btwMeq4EQsbsOs/11O5HbbR/McgG
   3O70oPQ30w/YpvEKjQYD2YhRKmqqNRS4oNTnIdz4Ioa9kJngl76rOEvQz
   g==;
X-CSE-ConnectionGUID: tghdYuYUSMKZ0zLDcXdbzg==
X-CSE-MsgGUID: owNd+1RWSlitiWWlHP3ERw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="389543"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="389543"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:52:32 -0700
X-CSE-ConnectionGUID: u5fBZ/VRRb6cpk2OP/YqXA==
X-CSE-MsgGUID: nYhM2/reQ6Sw5Y6eG0mP7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="422005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:52:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:52:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:52:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQOc/r+//l5lE2HY9NyZ6khUAMcnNDzj6bJfQ92pHvycslzKyjq2ipUC8IvwSHw5J91ui4sg0k8DGp9NJQeC1hURPOy7COcEasesshR0SGZlpEUTwuPTWQuYA6z0ZffMr3DUmMCWDGnC+npvr4tm8RWW2yFtJWQpG1QfZXrttA31dpV6R+I+fe4TBxeUJ10bBDnQzN9pwwNoFyf4l17/f6HBkqMS55uFpfcy5RUv+BS7sE/je07IdDRALWOg+kTEU4ziDoyZ1JbiB45linHeyMHFbocHkLu8ClzeM9gNh2m2ir5Zzp+XMca8QimWVmcgyH40ebAbRj4U20o9lFzDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck3CQeH2LiGbiEzZalQ8dPgj3etgUAuLF22qzUL/HPM=;
 b=xq1+/ChVAdV7LjTkNbxRYZJEHz532xQ0h8adAEwRHaFxY/bqELQwwzneClxvOF40WEogQFSw8wJ9M0q7OGK8hzc7ngOWJdpXSsmSqV7mJQgXlcVRT7aJ++sElUd9M9090hLUIXMt9yBj1drx+Jg0a2r4Yk1Sj5S6RYiiancby+AJV226rel+LWIUcMCNqwra+hS7/sBBys3uxnY/M67Ak6RvxSAOQ75tu+x+e5MNaLmzmVJ6ZBbBHXksyIvK61yu5GrHaqaKv0H/6oY29oS/EPQrEeWeCKjL3K9sYeJQx6JtEZ+ApPjFeTEz4kWvyb+AwDs3yaVotq9HPHx8+3139A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 9 Oct
 2026 20:52:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:52:29 +0000
Date: Fri, 9 Oct 2026 13:52:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>
Subject: Re: [PATCH v4 3/3] cxl/port: Attach endpoints to a dport under the
 lock that pins it
Message-ID: <aslUCUHuKpqP2uCq@aschofie-mobl2.lan>
References: <20261001154744.1095902-1-dave.jiang@intel.com>
 <20261001154744.1095902-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001154744.1095902-4-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a63ad2c-59d0-4dcf-2a63-08df26473b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|6133799003|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w9hSITjsQJz/PIp0GOFBtQjHjwdzjacQr9SeBqIiCjn6TySZRzjYjk/OutZKyAGx5+G/B+S2NGRbtOjegI4A4AOA4lmv+Qfo68zZojLqorKTxg4W1ndTAIU6nfPcckJ24bL/IiwWcQKYwduKD4u9RDinysPe07wjDLGXHGWwNhw225xhajqo1apFzhGXnigjC4ee7IwsHTIpSWUyTSJgTMvveRlZqVFa2HSqpPKAVKaXc0atHcXx1uGgWHcgb+7dafan9a9+jGYpqVHEUsfE1Eqm2ZVDTPJyVe0dJAXR6OLOkDIjiA/IMSUjrA6NKO/rqfhGdjPtm1a+1x0x0JdjlWoxwCEkXfWvUv9yoaUJIOIPBlQJJVlcdR53xbmpB9Z1xecstW3f8xvEi7B3szdkgxY83wKm/DLyNzymnAYf/CdvS/UMCoKvk35D2rAqQYoybyqMAXVGw+ic1k1TrP91DSkt4B5w9xM9+qlUhxz8E7psIaO3EuzUS0z5dbqO2+cKjnvk1Q6yikL/LQMcQXeQn/OYKTbu0u7/mIP8UzNmh0+PP/zwXS8YLzNozi1fZyTJS/eZEpzu4HNYHDGOJSehkD+2HkAu6ZnXqzwBhI7PipY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sah6thw/X8YEN0+E0hKdSM+JgTveqozRzZW1Iw83JVy4sHtMEzbvCDQRdeIh?=
 =?us-ascii?Q?tprDEZ+AUIt6eF5hSvHNbY9xfkU1FzmiMBqNUsukol5PRAuJZmrg9vC3OLLG?=
 =?us-ascii?Q?u8KYJn4lmla400DGC9HLTzJMYBM2o9jdN3NSgMg2l3TIyOjLxmcSCbpj+0rM?=
 =?us-ascii?Q?qReN/OvWTkwuWDO3ebdiImQZN4rvbsDVmpHPjffBfjPotGK0sYFObl6iPDk/?=
 =?us-ascii?Q?bqfuIkhYClUSYEu79AIpeiSY92ds0j4qxuPxF/FTmjoyUGIhfTn8FTTny3LF?=
 =?us-ascii?Q?zM68RrKu5byiuvXB3TIRts5tYvyVTadc0Vjhnbgu6FHbsQXTIWvCf//ZuqZt?=
 =?us-ascii?Q?Ex2NKsJxTN0DbCr0gVBK39mVtrSWb2eRQfCImM5RhDfjg2Hold8tAuZRt683?=
 =?us-ascii?Q?ocZ10j6q+O+TPqgcsQbuQWOSBqyWMgysWpDsk2LQOeWMN7M8GfsffhvcOMsk?=
 =?us-ascii?Q?0NVsT7fOKoXaTDKb8oLTvEwkE2KmhS3BMcjAgOxTzctbvy7sP8STU/mK7y4q?=
 =?us-ascii?Q?JJ/wqB6DTy1YGLIIT6wtPl3qS0ZvMKNV0evmDGv27/M12YKZVcU4c41ju4yM?=
 =?us-ascii?Q?vM0dxrsw1r2b2kQBz7h4bPUo1GAE04ic14PVg5ZKR43QykdQwd+a0WvQq8eH?=
 =?us-ascii?Q?r6NZj1FVKCkxM0B1nRFuseVM+ymwJuRM8xPCUDYGwREL3sgkU/UbgZmN2FwI?=
 =?us-ascii?Q?UrSSGhMJsmQhe1VdKbNsIECYO7NzPfZrFTdiwPjUcgUuVQPD7+Fz1jMPp6qP?=
 =?us-ascii?Q?Qx3kPXZknJNyNmE+W4ZQCR7kNTu1uNyTrDBYeCEU/6rT9B+LZRRjIkofmzTg?=
 =?us-ascii?Q?sSZal/1Fn6LWWGcotTyQWDphlvVdHM1jTPw8rbpvH8QDawRCVOJ6Lb7BPAkk?=
 =?us-ascii?Q?wvl4TdqlhpJhSSYq9vfykDYlhGycvZg2X/9QIcadyz+jEYCA/al5Bpr62Uv4?=
 =?us-ascii?Q?Att/xj8pAqeahV5Bl9LfnFUZcAbH6QIlhfZXG0priMyocNbWDoLgiI+5bUOV?=
 =?us-ascii?Q?YtbTmIqrPPa0rJtx1FdYLssPBplzx9NDvqmA/iD8v2lzoZJGfjv+oaovrYgn?=
 =?us-ascii?Q?yjDrzVR74U4y2MbzjovwwcCofas2SYb2LhvHrPPJwEUQPsvqrHpx2R9pUMDo?=
 =?us-ascii?Q?91vNCCxAERqGXZZPoTGBVQGuQxp6LU2GNUVos4Oa2a8voUN5kHLi9pVlP49l?=
 =?us-ascii?Q?GrmxKEMIeFO7pQZSvN5fpyiRRLGOek/AgwONMGrgWxLEQGqzlvZaOUuNPa5f?=
 =?us-ascii?Q?sHVX74gH7jDOPcI5vbofbPH7sajNUHTnmPWrJbeBa5WMqCbabCqn9lvOInad?=
 =?us-ascii?Q?DywNUqht2iiHpJEmKzFiAkcFBOeU4CMkdL97axjRGuOIOW28zYZGPY9asTQl?=
 =?us-ascii?Q?Wz1H5yxdUCNzhcPAA13vQvi7Hgu4i3ebsRwK72k3neeVENPKukhjzmpY+9qZ?=
 =?us-ascii?Q?89UmVPhzodQCukL8zqpEOahZTnZTOhM+/SRmrwmBgcqbvyEo2ZyFbHJzNHoa?=
 =?us-ascii?Q?5cwJRwlPdGjOjYKhslWVtHJb8u+U4n9NrhbuS7cCK4ax8EwYKaDgfixlYGhy?=
 =?us-ascii?Q?nu+XEqFCf1+YAjEO1xzGBI/mjTfAbXWdp/wMWAVH75dMI10K/+Tn9u7oD8cd?=
 =?us-ascii?Q?Mwxu+oGajJ1fIU6z6auuSUaULh9ufB8i5/PJERBBvg+KuiaJ9neEDFAeEd12?=
 =?us-ascii?Q?aapMQHEzbbpMYuwDj6UgVpHx7IJOpeey9PzTnIAyAjQqtBc637xTRH7vKkUL?=
 =?us-ascii?Q?/vdYXd8fs59trneGGK/8Jn2otipuQmc=3D?=
X-Exchange-RoutingPolicyChecked: wh9GQLsC9zRWXT/bjaP8WsRat9hk7YkgI98QrJb+d4/nqzwGo7HWSpXQlu1qJiA9NfEFG2DbSnVQ3U43G6UuYdtAKrBLnJW99u5fVSOQ9X9YsI7fKOykhmcTwgWmAYDvzmvusgpPLUINbbjGqEWdOzAl8REL/skijQCm/oUomZM3heq+JbxEYlHBCSp88xe+0oOPgmsrfjxpbKY6LJcZAAwPTVDFHGUKWqFQJ+s+CY1IPXOYxJa9zHVZH/r4fUFFrnkK0FNgAO2B1YG0nBbUZ0E0Bda28iJTQS14JkGIRUlxbBD263ju4GTSwnifkKK2F3GS+eVCjkAFGB9YUYFU6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a63ad2c-59d0-4dcf-2a63-08df26473b42
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:52:29.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCygzcKE6CiR4LQqrmGsmFhZ2w8h5DHNLIvOZl36EBGO9UE/232nm9Pa/XQBOb67zlUT3rW0VwKTo5fFG5UzfVI0kPvBZXMNr2oATa/R/8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 08:47:44AM -0700, Dave Jiang wrote:
> devm_cxl_enumerate_ports() and add_port_attach_ep() look up or create a
> dport under its port's device lock, drop the lock, then pass the dport
> to cxl_add_ep(). add_ep() reads dport->port before taking the lock, and
> cxl_gpf_port_setup() reads and writes the dport with no lock held.
> 
> A concurrent cxl_detach_ep() for another memdev below the same port can
> free the dport in that window: it calls del_dports() under the port lock
> when the last endpoint leaves. The enumerating memdev then dereferences
> freed memory.
> 
> Attach the endpoint and set up GPF while the port lock from the lookup
> is still held. Make add_ep() assert that lock instead of taking it.
> Under the lock, a dport found in port->dports is still live, since
> removal erases it from the xarray before freeing it.
> 
> Fixes: de516b40116e ("cxl/port: Record dport in endpoint references")
> Reported-by: Li Ming <ming.li@zohomail.com>
> Closes: https://lore.kernel.org/linux-cxl/0c68324c-cfc7-46b2-9344-24ae40e88923@zohomail.com/
> Assisted-by: LLM
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

second look, see inline...


> ---
> Found by review, not from a failure report.
> 
> Tested in QEMU with cxl_test, PROVE_LOCKING and KASAN on: 6 module
> load/unload cycles, 12 concurrent target_list readers, and each cycle 20
> rounds of every memdev unbinding and rebinding in parallel. No KASAN
> report, no WARNING, no lockdep splat; debug_locks stays 1. Both converted
> paths run under this load, so the new device_lock_assert() in add_ep()
> never fired.
> 
> Enumeration is unchanged against the same test at patch 2: 11 memdev,
> 8 port, 11 endpoint, 158 decoder after every load.
> 
> The races produce transient -EBUSY cxl_mem probe failures (424 with this
> patch, 407 without) from the pending detach_work check in
> cxl_mem_probe(). Memdevs left unbound rebind on the first retry.
> ---
>  drivers/cxl/core/port.c | 115 ++++++++++++++++++++++------------------
>  1 file changed, 62 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4cc29433216d..25e582718c06 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1349,7 +1349,7 @@ static int add_ep(struct cxl_ep *new)
>  {
>  	struct cxl_port *port = new->dport->port;
>  
> -	guard(device)(&port->dev);
> +	device_lock_assert(&port->dev);
>  	if (port->dead)
>  		return -ENXIO;
>  
> @@ -1365,6 +1365,9 @@ static int add_ep(struct cxl_ep *new)
>   * Intermediate CXL ports are scanned based on the arrival of endpoints.
>   * When those endpoints depart the port can be destroyed once all
>   * endpoints that care about that port have been removed.
> + *
> + * Context: Caller must hold the device lock of @dport->port, which pins
> + *	    @dport, across the lookup of @dport and this call.
>   */

I found this a bit confusing, since patch 2 establishes that root port dports
are pinned by uport_dev, rather than &port->dev. As written this sounds like
a general locking rule, but it's only true here because cxl_add_ep() is never
called with a root port. (and that took me a bit to figure out)

How about appending that to the above kernel-doc comment like this:

* Context: Caller must hold the device lock of @dport->port, which pins
*          @dport, across the lookup of @dport and this call. @dport->port
*          is never the CXL root port, whose dports are pinned by its
*          uport_dev instead.

Maybe you can do that upon applying -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


