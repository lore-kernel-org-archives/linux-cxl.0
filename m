Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6D2F7CE7;
	Wed,  2 Jul 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483796; cv=fail; b=MTxHfvM0Nl/pjMEv5J0h6Sk6ec9wGeuPEvJU6XlX656CYhcYe8y63lfCyDakjKfYdXxrMl3uLEFyaneLQb7fmfQ17DOHKAsFul1SF5+UpodEfmY1lvrze3FjwIOD0h0zt0/TQdJVijh6vzdiX+fS5+GnCzIEia76CE2TB1MROJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483796; c=relaxed/simple;
	bh=LaLJ/AsA2y7GVd7/hKIQuC4YC9tgjYLkyqVmD/LxEYY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=opNj4onCj9yI9lxKls0EUZorCbZGGvE3JQnms/oIMj3Fajvco6iRoW25ljiDOGaBR8R5CKIF0W3N/Y5/KVFgda7ZOq1pSCmOwr2LLprPqZOlfnDLueew2JhxljTAzOdOPJxpdofWFXG+Mo05KKB2mYcFmnQOsG4Pz3XNI0gBgn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKtV4rcd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKtV4rcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751483795; x=1783019795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LaLJ/AsA2y7GVd7/hKIQuC4YC9tgjYLkyqVmD/LxEYY=;
  b=lKtV4rcdre9aw+TQNO95HQxtbt//8HexPFYb6dPvkvZBd/kFrSQ8YwXJ
   MHlBm9Aif3v73sX5VXki3/qLz/UMRnxC/yw9vdihn1FIzfjHf2+0faTCY
   9iT4lGObRHDdhFJG3YHrMFZAc9y5Rgn4dX6LL3Dmy7MiyKKcs9Z17F7Bt
   7t0xcWMnU3qLu/n0TrMAI6PlcwCTf2PKlmfedy4+91gY8+QxhS94setcu
   d0xTzNlb0g4oIorRVGkrv54FLYDlSg0QfLMnVUdKu91a7/jP+CyMPI5Nm
   RKzp1aKw9smaxvjDi2Lj3hZCA7rLw7/dcqlVnxHehHN//RtG3ssXcVVq1
   Q==;
X-CSE-ConnectionGUID: Wj8l3Mi0TnGm3K7u5tmaeg==
X-CSE-MsgGUID: DdryN/NHTgepeAkpB2NwnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64845714"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="64845714"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 12:16:34 -0700
X-CSE-ConnectionGUID: 2+Uz7WjDQfW7gEh3K7DB/w==
X-CSE-MsgGUID: xdNcGbuzSH68J2KRfhmdHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="158539330"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 12:16:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 12:16:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 12:16:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 12:16:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPzL0VqArJRW0l9umEHydlPZqL4Fcd1olBlLT7m8+FKCKZhPPZwNhn8diZOq4QQKag7Uu3JGRUe8MSLh/SjeXIPEuG/Hw9JStp55ghdkLOMIeghTg0sJHdGIEF44c1gPPacfRvTCGBmgyFwj/pUwr6GADA9Fx3vOlmSAWlCEaGcvQ7XD06NAKUYnuI4G2ZdjkO14lH7MmHKMMXwQs1A9aG1s+Yl7TEuE0iBPyM2qlBrymsFovnHDmJizBGnz7Y5kTNSAYO2T0owHmBU9yC0whV6vA68W2FTKrJTZs9k7VXKBOxqcPRhZGDEJGF5zCmcIcyvOmO9vSVMrZGLmxNd45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5JMKR8piLFEU4bOEzFKFqjfy7k86KoR5NKJUddgFjU=;
 b=KUYzauSOk3wHW7WrnL5QEgJmdWNMAORnl1iWfRJRKp/0CcnEMVp3lZ9KqQLEpRS0Y2BdBopgi/dIhC5smSKUZ0jnW4BWhKFwdLI4U9NPb/NER8w22g1wFHBIDkeP8me3as2qL5CKPkHCWe4RehNV60qvPPPOHvm6unLNpLwHrc7hxTzCMqJy2vId93QUPrbnvWUBYJSkGw74UJ6CyeWZ/DfE/z2xUash1S7V+gOMEyKXmt4/HUJmv6f7MG4hYJXHeE3muQk8QcZUT3QD/BPAoMOTnjWIkzMeBiKPlHvQinzZcNDKw7Qz7ATuWLCXeFk7yzgzkBKx0IP/tt0kQJiyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPF213267FEE.namprd11.prod.outlook.com (2603:10b6:f:fc00::f14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Wed, 2 Jul
 2025 19:16:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 2 Jul 2025
 19:16:16 +0000
Date: Wed, 2 Jul 2025 12:16:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Li Ming <ming.li@zohomail.com>, <akpm@linux-foundation.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Message-ID: <aGWFdwla54b-98-x@aschofie-mobl2.lan>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPF213267FEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bef597f-f4bf-4c7e-6cab-08ddb99ceadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J6lELfYcPA1mMrCFquSIpTp0fDOwLAE1zk/YXxyMka7RShTCzn+AiiXMpkHr?=
 =?us-ascii?Q?rEDTtqJW22l/TAO/7Km90jls9s4sMvE75u0PxLaEsC3rXdn2Ee2B1gJHb9yy?=
 =?us-ascii?Q?WdnJDX1f07D5Udw+gAIa/E/hXW9VjgFJiv8WkXRXgL4Z4V8dj69FO3fhqHXn?=
 =?us-ascii?Q?RDjiZIhpyu+a7ZCPjqFRgm5Bj5hj+5X+VPhLyKtXlA0GRNVGU6nG4MTgVkzP?=
 =?us-ascii?Q?texLH/hzYZ+L/j5C8efyADxm5IGc6pBo64gJdlmdkd6RUVoG59T9ySUQpGY7?=
 =?us-ascii?Q?pG1MzYCuT1qvx6jg4XPJS1r58HoiRx3M6VwcEJWNray7B+rLytvKrVdnU4Ik?=
 =?us-ascii?Q?EE0AJBnmjunZ8HkIreko9a+wmJA/Z3EnNlRRpbazLTRLEmLakw672UxA5U7h?=
 =?us-ascii?Q?/5SEJrhY+JQQc/KFIkYJ1MoOCnYG2Zcwd077M+VbC06Rf9CFFfW9tjEFWs0p?=
 =?us-ascii?Q?91z15PkJ0TfQIysI5Sk0kxWWGGlLXOACYcBhPvBH4UrS+a0Hj0SJEk0F50a2?=
 =?us-ascii?Q?gs+NDQD6wef4jA4hWLI9fz2kY1jjZvEzq6Wzk4cK54IPVFDlv0ydofvbNq/Q?=
 =?us-ascii?Q?ONm58ma10BOxGFolq8GrACo1QI0hglkFlpfPgBgtGeCb2MI6aiGTTC/XvUBp?=
 =?us-ascii?Q?NVw5olTqYd04Vn3e5rzWfBSdNrfRE02VRdyafHhI8gqXX/dkG73kg0QVJZK4?=
 =?us-ascii?Q?N35yr3Wc+qrtrS0apOOD17WXu/5CoQ6S4NGhT8DnMmRSl2af5Q2tmWjDkYRs?=
 =?us-ascii?Q?mjGF5nqm9igFdqN4U4PM7Kt02dEnMpJjr6BGUGJAbyNvv0CbmMDhl7+B6Xcj?=
 =?us-ascii?Q?fdJXujiVMWIpIXl8yOsktFwQAa97o8T6y/k5ElX2WjqyEVVGLPq2AX818lNk?=
 =?us-ascii?Q?kAMoVcrOY7zIQAVMnSW6NzMVkd7iGe9uQ6cYsR0SC7Jdsqg8nT8K4Dvk6Z0w?=
 =?us-ascii?Q?BW371Yjla78GNuLWhqy4WK5zQ8kpuX7xpV2R1KMz5yFJiOocYQe5BH+FnX9A?=
 =?us-ascii?Q?ScqYHpWSf3rp7Dp0OOcF95nOBboShejGKH3t4Icm1nUM662s81+eTz5XPjqC?=
 =?us-ascii?Q?/kZ30ZgP0tjtU+gUqrUWvUikI5Pkk2ZpJt9nnkHg+IfV/fLU0J28+8cjUTL9?=
 =?us-ascii?Q?OJvyHHQcROegbhVBNzvd88LTyuE1LuaEo7I4MWPL+gV9GgSdL+mcSnGrm8/v?=
 =?us-ascii?Q?g5TSgfhCDWuiWJl3YTH2hm+90aQfjQG+8O9mfwghFKnG45l/2RSf+JuNQ7Mc?=
 =?us-ascii?Q?ELUH0ROzw9dIXokiL43OltKQh//E0H52kYGaG2BfIoMUGuTXucv+GiagUJN7?=
 =?us-ascii?Q?udsX3Qvi5Goqt+OMIwMPAsGj/cd4bhUpWCfdlH3zUSl9kj/cztT4SqpgY3O/?=
 =?us-ascii?Q?AkBf4wvn3zEcxizdfQezDZbb6GigISBVwbcPs4pCTO1oaA2245vstGIjhh8K?=
 =?us-ascii?Q?dhRk7gCI1j4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7CPqyYXeG4ix/Lb3y7NcduN7QKOQOWa4/9upoY2HLu3j3x3j+VDBC37U5E2?=
 =?us-ascii?Q?F0+s22GhuIdCoSY+FUpa4AOp5TD1Tut97u66BHR/1eKyk6bILRl2w5l4jto0?=
 =?us-ascii?Q?+zxmNlo869F/QR10XXYn9aIouqW6xY1CvsZSFnQNUM0rLc2g/MmnRs14gUEp?=
 =?us-ascii?Q?SlIvx6DoaKjF1a+08Qq/+RgoyCbpP+/fPdQzCxVOwxDin6Bi64yjzJwZDmIm?=
 =?us-ascii?Q?vinYywrt2kEBsMu1DGw5KPqDJQaC0uYV/T43abHmYLI7nhFFhBdFRwNBXh0q?=
 =?us-ascii?Q?baaEBIaFR9Bh34XZiolhMCWLpK1xU/WahLn2KFnGba3yXUICGuzNltyC/Eu/?=
 =?us-ascii?Q?uaSCAJlrfnXt6Yc/VZKsfnHNzyYQuRKUT3SuVq7vhAYm5+dAu/ZiNZpSCBS4?=
 =?us-ascii?Q?//Ex0znM3SOfA/HOwd39J4FZR1wUGoE3hKVHlvidX3Yu0UbHy5alnyF1D5zt?=
 =?us-ascii?Q?1bSOQBSWZDY4xmKlbEDrPFFJabf/ewAABC7KvHpNIfogREz3gG0Te5yS4nMq?=
 =?us-ascii?Q?6LO4xEAKQ1Te02Pk4oEGU/rMM9lM5fjb8xPXVrB+tlLhyVJz242FokkGgNT2?=
 =?us-ascii?Q?wjxKPbakhtTjIubX7SUxmmv3bKWz9MXeEiNJAUPX5ydaFdOsW9AXMswTHl1q?=
 =?us-ascii?Q?swzEDcI4tjqiA8rkA0iItmxnk0i8HWQM+mG7yC5nKEuOj/RTU//g86gg9NSA?=
 =?us-ascii?Q?hx2Vbx9/RjC1j02TdLDGWz45lOV8oyNJ2OlKMGjD0C0L9MwvcqIdENq5iNP6?=
 =?us-ascii?Q?y4COULCZIGjWt4StyQ8ghKEtl0NxK00gOgsUkeF0v52IqE/bO9DnPX7oHWW+?=
 =?us-ascii?Q?0RWy0ZJJBGDAlnWdEm9OpgFiQU1ZzWVhsNmOsCXHITXE6rry4H80ELb87IwM?=
 =?us-ascii?Q?R6RIRwrqYawec2cerkFiFrB5T5DB3UMQFMLD0TWv6uNONF8ZPaBsDUedWIH+?=
 =?us-ascii?Q?D0B7X35DFDzC8asyfySq1UxexnGgwyup3ytU48ikT7sSGIZBmQKXQo5u+k0A?=
 =?us-ascii?Q?xtBJnbSMfnkVCBTRDGpJUz8hwd1HOXP4h4nQjEgXV1AffwbMcEjwnWRAmAle?=
 =?us-ascii?Q?OH4An310wrla1hFgGZfB/5Iip47IjVdYuWlwnNNYJgGkyiPdsQHtpmW2VzYD?=
 =?us-ascii?Q?QhzoyimWNjuLIDQ2uCyW7tHts9uns9Zj+/BNDw6KU/wcT+Uvx3kFJUt2JUL1?=
 =?us-ascii?Q?SstV67BJZ6+FeFW/9vylpH/XqyqAimBtNomKQhFvrRPPyd9TZ+20ykotmSbr?=
 =?us-ascii?Q?yjIBJ5Awo8XgiiFsyxEL50Qe6QoxsLoYalAsgDNuiU3XJny8yU74UWBN0eCp?=
 =?us-ascii?Q?Xht2dlWlfPqElGJ+8tRxXGISlOfjJXt+X41B3aCfTvfplu5LIGhFayPueNnK?=
 =?us-ascii?Q?5pLP6fkvmwYH0OtxTVQFFnRFKo5kQj69z1gEmDy5vuMmtu52ypXWAbJaqDzx?=
 =?us-ascii?Q?K6/5EDKCx5EfETHCvf/dSHTbdbEBM8AuVfHqALK5c2LfxtuhWOJ88JHAL5uG?=
 =?us-ascii?Q?Av1eJJXRHk+nTnNS6eW3MESy94NaNrUz/8PrCgyNc5ZRV7aa7p9eD+uErbKC?=
 =?us-ascii?Q?kiW3z9L4VP2tMeB2NUZjP/7Tov//u/Io2/m7mLcW1DRXka1booHFOS6LULc/?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bef597f-f4bf-4c7e-6cab-08ddb99ceadf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:16:16.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3NEqlpbm1Q8GeaymeNbMCboefHBkJfwOfNq/aXY9gYdpRr2dMQe6THeiXFt9zWIdNFlMh89KlkNBy8B53/WU8RQ6i6+wBI+L79l1tP8pqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF213267FEE
X-OriginatorOrg: intel.com

On Wed, Jul 02, 2025 at 11:16:36AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
> > In CXL subsystem, many functions need to check an address availability
> > by checking if the resource range contains the address. Providing a new
> > helper function resource_contains_addr() to check if the resource range
> > contains the input address.
> 
> resources are about ranges and not addresses. At bare minimum naming #####
> here. Also there is no symmetry with the intersection API. But I would argue
> to use resource_contains() and just provide necessary parameter with both
> start and end to be set at the same value.
> 
> 	struct resource r = DEFINE_RES...(addr);
> 
> 	if (resource_contains, res, &r)
> 		...do stuff...

Hi Andy,

Thanks for the review. Two alternative approaches were considered:

1) A CXL-only helper with direct comparison:
This duplicates range checking logic that's already common in the
resource API. We'd end up with CXL specific when the resource API
already provides the semantic framework for containment checks.

2) A CXL helper using temporary resource + resource_contains():
While this maintains API consistency, it's unnecessarily heavyweight.
Creating a temporary resource struct just to check if a single address
falls within a range feels like overengineering.
(This is your suggestion above.)

This patch proposes, a new helper in ioport.h, provides a clean, reusable
API that follows the existing resource_contains() pattern while being
optimized for the single address case. I guess I can agree with the lack
of symmetry with the existing API, but that's only if one thinks an API
cannot be extended. The new helper actually complements resource_contains()
nicely: one checks resource vs resource containment, the other checks
address vs resource containment.

Revisited the name, I can see how extending an existing name, like 
resource_contains() is a poor choice because then one might expect the
pair to be resource_contains_resource() and resource_contains_addr()
which it is not.

Do either of these fit better, or something else?
- resource_includes_addr() 
- resource_has_addr()

The new helper would immediately be used 7 times in the CXL subsystem.
What are you thinking the bar is for adding to ioport.h?

-- Alison

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
