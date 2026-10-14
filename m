Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A26305688;
	Wed, 14 Oct 2026 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941830; cv=fail; b=ox+fFy+hWA4b0SyEPr3oMtLJkZ8URUw6DAXvsQxaM/Z//If4v+iz0mbJpxtA6nNX6iiXjpDU2Y0blrYMHZPA3ZbknQxLhy3x/vaz/D+Yfl/evV1mU+lbvejSIjwT9rhzMcclrpD94j2x+PhCXcASUrHysbLxB/nihvWSC1yurfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941830; c=relaxed/simple;
	bh=h4G+rniavnr3KHdLAHeB9zqEHgPjxNUgNv/RYHbl8rc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aCf7iKsT6gDfHBtwDwpYG2SneA1HpzYjcHN/PSrHJgWz8BBYVAYaGWUsFDXe6bVa3zcbkR8+z2ZlQHkZT/1zQzonHm2MsyD1VQ/nI/9KXqZ9TPICSUUElPJQRSUGubtNHbSKLH2wgvaeO3U6gCoqfLaQMoYRFgRAG6MQN5VW58k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVGEN30f; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVGEN30f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791941827; x=1823477827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h4G+rniavnr3KHdLAHeB9zqEHgPjxNUgNv/RYHbl8rc=;
  b=EVGEN30fv7FsRmDZ6eBJATlIGBd74e5rtwn11vjTzh/+faX9HlBF1Xr3
   eoIqwgEygUyqUbM1YkSa9wuPDh2HRshiNGwfQZc11BRc4Po1Vbo49r+wK
   Oyat8mgHHvo+sejHaxn9lwlL/X1SEdp9HlRyqn4wbrqgnRz2MV/ZFlupc
   TrZgw1osqOxPP0c9SPkid3jRKYrJxWn5UGihl10fM8szaixR8TMnd7Abl
   NL1jNBoYNDhpZ4ihji9v8YIpmDqpjJtuPXtZxj5YBb9foP3AEv0JgoSN1
   UuP1AyNrswRl7hsNKvU/lx6L4ro34YebiSRrTytITI8HauLRPubWPuibM
   w==;
X-CSE-ConnectionGUID: psTMgQDcTo2xPDfDnes9Yw==
X-CSE-MsgGUID: rcPip0EqRGSvZKX9arjlRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="667290"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="667290"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:37:04 -0700
X-CSE-ConnectionGUID: lcoh2uuTS4aAnaI92MzG+g==
X-CSE-MsgGUID: IHFTbbM3TouMknlx8i0lPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="3151279"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:36:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 18:36:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 18:36:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 18:36:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSevTgVVMtLlhtSlMJnmVJoITGEfu/0CXiT5+5sdCY8A6sDBSt4g/YMySTLGIQDXOg3bQ70IzzByU+2bzgeyJSX4A2qC9r89YrzKs5HrC/tDYIOVsL7SuD1X9QPObDtujwmNfQcts1GLvXpt7WtVYrY2PGEYgBLQRHMr3irvsDT613w1zIz6vc9IKTeUa9a2QJ6w+ZBD9+5C0crOQNSZl5pvpuUTY8oZE2mPhJfqF+1IFV+UkKBSNnvGzuI2tECiuf4nXG1qcI/MEySGCtvUbTuhBiDCSmCq+LW/DRqy8t+x4H4zzWz5RBh8G+u45sFFhbE6Ee+I4DeNHvLJpPWO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTSEeOVB2qVc4Y2HsSMW5DlZZVnTYRS/JByQ30Ff5BA=;
 b=cg6i1DxiO1C58jyMgNfxnlqQjkZDXe2YcpuJ6rnKcKkUUcrne4USOcXrkImgFx1wzObJll77GPJQss3lnODtt/Q2CvilYFlb6Unnp8j/gk7mubGkT+EaiuLP/f2BAI6YJ9m/I96T/b2UVwgHf2CIFH0muzsyaLZTijn9YAsSi/RZSXws8oZ13kPV1W2O9odIqc9e0TFvPkAMxI3kzIh1RsYC0HdbPEPQXyuzrzktafzOkSLqlpgU2ENgZn/NgyActY7RhklD30T3fP6pCMEBZmDtEYQ0NBSxnQZAMoYb0MyBirsae4fOIhs+2vQka4WLWYWJQ2Wtdlfsr173/Ix6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7071.namprd11.prod.outlook.com (2603:10b6:510:215::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:36:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 01:36:22 +0000
Date: Tue, 13 Oct 2026 18:36:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: bound the device-supplied command return code
Message-ID: <as7cid_6QQS5gBI-@aschofie-mobl2.lan>
References: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ba4e29-66a5-43ed-9af8-08df29938d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: s4Mc64KI+4yBG+E/MHaHTQlrTh7IVbF2uV9MZJmLXkXzoRz7f9XJIf3YzUIRfNS2mOwPOqN6JVE/QScSHUqOgFPphyo5jc4qtG2JmQlLbjR61ETw9JfLLT734McqmJDY9elgCzmeACUqDK966qsUg5xV0WTGKLw+93DQWwPRHkxRPqgwKUZW1pdpNzEn8L+ik8VA+rJS0wn8ygrUSXhLj6GdKrfn5pdJo85+eOR/Mrd6V+Gyl9iekiIuORUouYKckspCQSzUqc8GcZBOUHyEn7dwhxyJmfLIBNQUFkVR+YtAjpYryJfUngkpnfVA4SI3IlSX2jUR6sLbHKFZo5bHq+LxNQYin+FlyX9HXcKVJSils2GGv9ppOkhwgz7GOSUwtn7cG5oFWYVzHQ4qU2775g5H1WmQr4DKd6cBAY6yFCWZTYWgmMbFgFmEiTmK30m0MYOV7D+VSUY3H6G29M4e6pFdXllDTIYaMC4VK/9CY2oCYRlXqS+jAd/8NueWJ+ouOmvIck6VmnM3RR5Vz8/y6BE5F1qNpi3eenw+5yKJaPXgQOO1Exr6ZnuHCsFoF3kjI+NyM9Fiu2a+WQY9a58CxYCtDtGzE1CQwsfAwU0Vs6jjTHQRnlRTd3UghzYhH6aPCCX0tBkdv0eJXczbzca4yis4Fw6ndxR9M7KI8S2MK64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kWv1O6KjvEim4y4yTKe2HVUPCMV8aw5mTdDR3s0aWmm4ahAt4+ktD8jgqs+?=
 =?us-ascii?Q?S2qsPweZzHpmuNOaa+cz542WtFfwck5+yhcdeDrOyn9O/S0D1XIwCxlcNY61?=
 =?us-ascii?Q?kltGoL9MJENUNsSlyyA/0hExvPYoNera5aEhNok/jAnj9BduDNllsm7gJ8lA?=
 =?us-ascii?Q?spgrHChImzDSpovF+DJzEnLnMTofnYF+jsmKYmc4QwX98pEhUezhjqkIMw+r?=
 =?us-ascii?Q?tP7x6vezyZ23LA4XZmqMkEwCenWJoXYWvfSnmFahioM5sQcKExY2m1l+v95I?=
 =?us-ascii?Q?vXB8T0aWsW3Gpl0IRF5iVsV8oH+dbgvyv6pIisx/R1fzfhqmdU1Cy2J6+Wa2?=
 =?us-ascii?Q?kWfXnuvShz7EXfaOEDcbDW7v7GbkhKkR67Hqlh6HVLcF3o+X0eL0CJ7FUvoA?=
 =?us-ascii?Q?xsHKIRdFtTc9LXxgX4xg1+fRtCEvy2INs2c+yn9XltBx8DFK8TsWSD4YlB0u?=
 =?us-ascii?Q?AtROmXJIJl8HY/X5+QQROaJTC6tLmKqDGNrwz6az62VLr39ZeErpIr2Em9EL?=
 =?us-ascii?Q?Vg9cp80CVt6aAwHFcbg8QQhiQYXA8cW/vuKX5rgRW3HBZ4C4WIPMopgxe/u8?=
 =?us-ascii?Q?SPusogEkfHJgJ+mJk9q/VZiIebnwPow+edK9lJzUxEg7vXn5k5kw8ksxjfY1?=
 =?us-ascii?Q?gBffxJH66m+YqcJecqv4x/Im1cqu0KYg7etJd29kDxVjbgn7CeE+ycxqQIsW?=
 =?us-ascii?Q?Z+dUZOR/JGC7WJggP4YOvSOa1ZOzNoVRLJFPvclHIj+ZruzZNYGF4sZ08psj?=
 =?us-ascii?Q?Awn+ZpTsblC/+Im3exuL4XHjz7xWnKKVW+LUxCOjt2wImyrsET6fCPGF5PSB?=
 =?us-ascii?Q?gcmaFHl3Atz1r+9yorQkzNkvKj9DYi3rHiU6jVJhxIeLwE2tWPQU+yRqbSNH?=
 =?us-ascii?Q?GTIcFi701DT9Fq+kyIz9BbrMZcI5xwlP72lnYT3R/NX2XaN1qs6Ktmk8HCNi?=
 =?us-ascii?Q?+htzMOmbNwnoID0bB3S5bPdyFYX+W+K8al5ZOFprypluzQLFSqO5HtssCJun?=
 =?us-ascii?Q?mrNuJ21qpOUVQWT5Y2C1yRSU7dfHAlCbwn2NLlsXM7PHXMeR4Xp3wKBLoGi3?=
 =?us-ascii?Q?iFTLwxjPACPd1DPzoAO+ofBe9AXhchKdVbBy/xLkCj1xjhMBZVum/E5zrnbG?=
 =?us-ascii?Q?LdjU3MwvOKUfpYxohFnfho9m7iTcrv1weuq0flCC0TcUnTAzCTr8qv/eFogT?=
 =?us-ascii?Q?RjIUjMt5wwJALYUo/ELK+/zcc9Emi8J36sAQjN+tBU8Em09fdEuRDvoCV/lU?=
 =?us-ascii?Q?ygJnoxpP3VPquzLZ2O+xQXGJB4ks9wO7AHmbPUpFGxnf5sliTspM7NoMO+nX?=
 =?us-ascii?Q?vB3nGJ3K4uej+V0p+tl1YlKxKfFy2ngcn3kR8KGoxhyis038LfVtYvAPErpr?=
 =?us-ascii?Q?i591Snr5t++H7oNqCeGl453+8Z9V9WRpBKLQxbAapa3rtEhj/TBun2nCzQvl?=
 =?us-ascii?Q?XL/pdLIqavF1hJMVLJ7JCX0DEutMWTtyvrVC8O2UZwjsBD4KESos0JmjLTuh?=
 =?us-ascii?Q?hdU6CflncS/vWmvKuu9WwrG4zeybLgf+tKcpOuWHzmMsQB5MvfSvy9JgRmiu?=
 =?us-ascii?Q?2gmpdcbI30mJaFIu6p5WyEnPd0tmEn/UVh2iZC3YTa8iU0p2Zi9s7beh6H/Q?=
 =?us-ascii?Q?tARX4EJwgECOhMTT1NUI+1EXEWpYrKIpXGDYh+kna4GkFf392WjsKnKfvSnq?=
 =?us-ascii?Q?pcikJfBD+19j3XmsWnQcqZ2tB1eG/Q8YwURWo0bB7P/qJgXNd+aGWD5WQUHE?=
 =?us-ascii?Q?R9b0etvk//lE8D8lDLbp8HeE22HkFwQ=3D?=
X-Exchange-RoutingPolicyChecked: EzBHrBNe5TnIaDF4wrB1oIkpJZLQOFsoAuj/iaiKLLLi/w9tGO3IEf+E11r5qbHTKqcOTaMdRQ8Ujk3rELCd44ZnajCqL0G8mFyjzsdDGziruijklC0tRrFkpweAcjujD37DvfA66vGZi2Ig5RvvZFec0wvLOX6vd3vPrvYpJQ9PObqSHDEnjFox5+xFMWTlFpqxlFmc+jmRQ7x6rZD5VQwpLcMREADgzEQL1VSPffAI7mU5nI+o/82+vLW9TNIz38qdnckcoR8mI7/3JtZRlhdarPkZstCrnrSpjwRdwOGSoGO39DxDhY0P2IUGRRbTE3CtZWoD5m6mFH4OaAvCpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ba4e29-66a5-43ed-9af8-08df29938d98
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:36:22.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRkkNG4x7zCvT2x9odbnPRfm3v9GY+TP9XfuepwUyGRVzQ8xB8I4o0hgndP0XjPWF3425rlHAqwlwcl7Xi8TBZ4kJ5dTWgFq/zIO+KzK6+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 02:07:47PM +0800, Gaobin Huang wrote:
> cxl_pci_mbox_send() takes the command return code straight out of the
> mailbox status register:
> 
> 	mbox_cmd->return_code =
> 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> 
> The field is 16 bits wide and nothing validates it.  It is read the same
> way from the background command status register when a background
> operation completes (CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK, also 16 bits).
> Both consumers then index a table with it:
> 
> 	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
> 
> and that table, built from CMD_CMD_RC_TABLE, has 31 entries (SUCCESS(0)
> through EXTLIST(0x1e)).  A device that reports 0x1f or above therefore
> reads past the end of a global array.
> 
> cxl_mbox_cmd_rc2errno() is called for every non-success, non-background
> return code, which makes this reachable during probe with no host action:
> answering Get Supported Logs (0x0400) with return code 0x1f is enough.
> 
> Reproduced with a QEMU Type-3 device that reports a chosen return code,
> against this tree:
> 
> 	BUG: KASAN: global-out-of-bounds in cxl_internal_send_cmd+0x11d/0x190
> 	Read of size 4 at addr ffffffffa5212c10 by task kworker/u8:2/37
> 	Call Trace:
> 	 cxl_internal_send_cmd+0x11d/0x190
> 	 cxl_enumerate_cmds+0x12c/0x980
> 	 cxl_pci_probe+0x84a/0x11e0
> 
> Return codes that are in the table take the ordinary error path and
> report nothing, which is what makes the out-of-range case attributable
> rather than just "the device reported an error".
> 
> Validate once, in a helper that both accessors use, rather than at the
> two register read sites: the same bound then covers the foreground and
> the background path, and any future consumer of the field.  An undefined
> code is still a failure, and -ENXIO is what every non-success entry in
> the table already maps to, so callers cannot tell the difference in a way
> that matters.
> 


Hi Gaobin,

Thanks for the patch!

I'm taking this into a series that adds CXL KUnit tests, including a regression
test for this table. You'll get CC'd when it posts and I'll need you ACK it
since it has your original authorship with changes from me added.

(Sashiko is right here. PADDR and POISONLMT don't map to -ENXIO, so the comment
and changelog claim isn't accurate. -ENXIO is still the right fallback for an
unknown code.)

It looks like the return code you saw is valid for CXL 4.0 and just not added to
CXL driver yet. I don't think anyone else has sent a patch for that yet,
so you can if you like.

This is what I'm looking at:
CXL 4.0, Table 8-208 "CXL-defined Command Return Codes" (section 8.2.9.4.5.1):
001Fh and 0020h

-- Alison




> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> ---
>  drivers/cxl/cxlmem.h | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1a..7f89dc4fc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
> +#include <linux/array_size.h>
>  #include <linux/node.h>
>  #include <cxl/event.h>
>  #include <cxl/mailbox.h>
> @@ -205,14 +206,39 @@ static const
>  struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
>  #undef C
>  
> +/*
> + * The return code comes straight out of a device register: the low 16 bits of
> + * CXL_DEV_MAILBOX_STS.ERRNO for a foreground command, and the same width of
> + * CXL_DEV_BG_CMD_STS.RET_CODE for a background one.  Nothing validates it, so
> + * a device that reports an undefined code would index past the end of the
> + * table above with both of the accessors below.
> + */
> +static inline const struct cxl_mbox_cmd_rc *
> +cxl_mbox_cmd_rc_entry(struct cxl_mbox_cmd *mbox_cmd)
> +{
> +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
> +		return NULL;
> +
> +	return &cxl_mbox_cmd_rctable[mbox_cmd->return_code];
> +}
> +
>  static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
> +	const struct cxl_mbox_cmd_rc *rc = cxl_mbox_cmd_rc_entry(mbox_cmd);
> +
> +	return rc ? rc->desc : "undefined command return code";
>  }
>  
>  static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
> +	const struct cxl_mbox_cmd_rc *rc = cxl_mbox_cmd_rc_entry(mbox_cmd);
> +
> +	/*
> +	 * Unknown codes are still failures, and -ENXIO is what every
> +	 * non-success entry in the table maps to, so the caller cannot tell
> +	 * an undefined code from a defined error in a way that matters.
> +	 */
> +	return rc ? rc->err : -ENXIO;
>  }
>  
>  /*
> base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
> -- 
> 2.34.1
> 
