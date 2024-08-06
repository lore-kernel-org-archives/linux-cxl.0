Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631B1C6BE
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909996; cv=fail; b=hbzo0Sk70UBA+qvEQ66OA2qnWmSNvhgeK1DChhFBPj1uRShLvXy3tP0VZXXY2Xk1KqFoZtG+qDKAGnvquMh9I6WPRyWfA99Sh6FNY+gtqCKRrMsS4+16Obmy1S2Gb/S7y+3skVj2Bu0drgu351upWhgTzr/rH1unCNSl2ZQPNy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909996; c=relaxed/simple;
	bh=OgqveS1cc107cwApPxnYrBPaZt5CbfMQlKL1ye2cKL8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UBgV7QBJSPtbbbp3LDXi9z1kJAvBDlplzaPUTqvySlfAqisHViouzbZE9GAcosp2FjJ97dnNZ5CyfalP3DKpyXEL3uY3dxVwanyW0zQCf/ILR1pNI6nqt2m2fF+ueRGs3bvuYtPjNsrRilSQS7lIjOx/3wH7VxR2lLzB2cc1Q2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZlay80z; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZlay80z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722909993; x=1754445993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OgqveS1cc107cwApPxnYrBPaZt5CbfMQlKL1ye2cKL8=;
  b=KZlay80zUe+C5P4s3OrtLPZ2/eFUfor8s14TauszoxLPwa7IbwVa7e80
   z9fZHQTCbY8g/cPhLyRz/i9EoRtdJregxKHVe+UdINsIoH8LWJmTjYm9y
   vD8Wntr09fFjWAM9aRrOK3WtBVsq35lW/br/dsrmR3dqg9Ag/vLo0g+t+
   h2LUfTaU6mZvyPTqq1M4TGNC/l3e39QmDkJwMaUF2R5jx4Vo8Jrjx5Qql
   BlchHZA7vXYKXcv3O6V9BJTXhpB1ILwZF/FNSaAYc8AFwtU9y+0oRGBI4
   DZhJB+9lIF3gegRUscRxfygVolDg0a9AJdYLgqeCnGDc1Hm7+bypPnF9S
   A==;
X-CSE-ConnectionGUID: yXhUBE3qTAyeK0/ikVoQtQ==
X-CSE-MsgGUID: +8jAliAgTDWMaGsWdh6cfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32058069"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="32058069"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:06:32 -0700
X-CSE-ConnectionGUID: VpukMeB5QICF54m0xk4sTA==
X-CSE-MsgGUID: ENUGEEj0SJeLY/OPLBTjng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56026880"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 19:06:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 19:06:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 19:06:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 19:06:31 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 19:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odJjoMtPedro1x5tudtD6Mf3wVT96eqXLDbfEI+bNcdByJX+JEjRM3/2vjrgFZk3qRqXjPIcfhzhlD5qUibWewtrMzX51Vg1sX2Lx6UPxcd3qn6TV6C8J5SeKrj6H46tVgp0Ct6pxVWySjkoR52hjs+5DJAao6gBN8fhD7T41fAHojXcSCDXMsbxdTW7hJJ/e8GhK4OHra8TsMYiWfM9JUr0v6W6xO9Hvu8xneIxYSwwqF/tkz5qfm80uOoDOL0e5QUrLhh1BRmc6oSNL2AmLX29SH53swqLnjGkat3ttnsFlOtT5Ivd+rwaNN55ipjA+mB2hgfGF5Ixjpk41v2Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slTayU6EVElDtu+qY/b8WyD2LiBkRXyUtOZ9cQxhkzc=;
 b=MK1EeeZyqrcbC7wcAoMYTrQ7iSD51StBeIoyf5kl3WggstfzUgd2ERh7Y+C+AMGJsHK9MCrvVHKjopotLq/xwbzu8SAOKDdfi89YDU2VcZGzuX+1DlPknvBs2CfcpGmpYS3C9gO2e0QKzmBVOLmGZUAEdL528d9mGpG3AJxI+L2xHE0pQTusR4sfpt2RvQeU5PYNyuCm59Vz7PlX+4L5ER0ht+cTF6TbsnuyndkyfEuGVz/JGoSDlClaw4tU0s4Uif+t49eYuZXnl/OKakm++7ls+LvDh2nzhHSXenG2V3Mb0+xUT/C05aJQN9zuxUejvy6e4pm+2ZmIY6IV7JF31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 02:06:28 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 02:06:28 +0000
Date: Tue, 6 Aug 2024 10:07:21 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: [CXL] There is BUG: slab-out-of-bounds in cxl_setup_parent_dport in
 v6.10
Message-ID: <ZrGFWYKwxa1ld9Iz@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA1PR11MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c16aa5b-b02f-4485-ff37-08dcb5bc6240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEW6inSATrhMpWjtSpAvZwKB+Ef2DlS4yiwFYGWsj4louyRf1TOupW/WEQmH?=
 =?us-ascii?Q?iA+lYNnnPpd1TVY0kNBESMpevZCs8zsJnms+WqYMADaST/WvldoNnWmqnnmx?=
 =?us-ascii?Q?9NXmtQwmfQAYt91Pj30OgZ+ktoHV1B9cSFHTZFy/2VvUJk2OR/Z9K9JVLZBp?=
 =?us-ascii?Q?6CciKRuBpQZRGiHmYkkjeSi+N8jAOmtiDTyv0XrRmuWCTPhOpo3M65kOVuCS?=
 =?us-ascii?Q?hsd3wUIgNvvyAYrhjy5CTLopLeGfNjIlSDnDJLLl7W/c1zhYBqpE9laDggcc?=
 =?us-ascii?Q?HePsV/fWFp8VQNGacUmeyYh2VuPkx9tU29P4UO4YHvw1ZHyJ+HybE7o/CwAc?=
 =?us-ascii?Q?mjBprobWVgA/ioXePe53f2g19NODFUR/2kE0/U11LElyLxhAqXMZnX98oJdc?=
 =?us-ascii?Q?//bO7sD7IvdobQJBs35bIbeJ6h/1qBMVdyyQrDu7Gx1igphg7eCF6Sg/bfru?=
 =?us-ascii?Q?gD1DLuJ4LQiUm9GQJVTZ0iZpb04904Z0d4/pU99Ou0NfmfFNICbH74G1UTz8?=
 =?us-ascii?Q?w+eqCZDbWNQ6EGJZiUPQHmEljvcIeVI+1GW6NnPn9Kv1R7gcC2eypRUCikP0?=
 =?us-ascii?Q?34hgzbK6KtFAEiGmC99bwFb4arQtNiKuuWiGRY8/k8qyVBEC1R1Ms2vy04nX?=
 =?us-ascii?Q?KEktBfyQgheA1g2E2PtguZ5VFMikeoag2exnkwZFV5zzCbGQhGrY3zz43VBd?=
 =?us-ascii?Q?TfeTZLd4YSa47F1Ld0SsZLFIUYm7pc/qJhwRn++pUuNH0sdxYB07X4jiwM8w?=
 =?us-ascii?Q?p28gBU2FtS5eM9mJnJLK/3beETG6+NQd/cAs+1i+P8faOyiTXYV2CpKEqj0H?=
 =?us-ascii?Q?9IxioCYFMiYQhFPIYuPXVNdNtn5GlpMEbuMx9L3UhL4C7QhLC880PipYc/z+?=
 =?us-ascii?Q?lX9SMKbWmscyUqBo949mHMr53EH6ow2sCAvAh7sfwjxHaPIxky1LxVlujvy1?=
 =?us-ascii?Q?MJBnoEoUXG9hMWb4XjPKTB0dPOsgz/LDKeU9SS4yhrzHh4Om3qdTWnTxtG2f?=
 =?us-ascii?Q?TwiswWzSxpphx6Lhyh+G72Xc402ibWhxP7kYy7ISs11BPt0eMKSbP7SXITRo?=
 =?us-ascii?Q?EcxM/UhddGqA6rtpdlta3uZqqzhZygwf+Bftc0NBdaqyoPm8MrlsOuf0DVLx?=
 =?us-ascii?Q?A6DEb4Av25iuD79SvwqRORTARh7zFGPJFRvCZuW9xbSklsN5IX3oMcxNl6SK?=
 =?us-ascii?Q?G+2yeHtM572bEdkLs3pP6sOzKcQcKF1vVxOX3xxlSOzM12k+4wFppmx1ngac?=
 =?us-ascii?Q?RiaiBLkzmAC1Qy9JFFEvpY9W6T4tFpx/x8E0ncsA39+LUCAMIbq5aFrHFW3N?=
 =?us-ascii?Q?I3A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2y4/7UuMOzy3/UDVZDp0w+mG1FntIKLMcNGf1tEDbKYJzwtGbBBa3gJByfd?=
 =?us-ascii?Q?iCPVU35CInb1DwaW2luglL9jqS1TQ9Aa1IuK8xkIyCriTj2m6j/t6n98wRB4?=
 =?us-ascii?Q?vcQkNUZ+A2J+bQQ8W3UUKZVfa2F9kmyw2XzzDZPzbcx9k60rJMjB1yF3ytMi?=
 =?us-ascii?Q?7g4Q10EAKvibhJ5YCdpgIbNakYy6+HjsCM5r4vMAFCmzthtZ+H4lpy/Er4Su?=
 =?us-ascii?Q?qR0H+0t5bproO3SsyBdnAxfg3M5hGuG2GpUFpRyL0dAie+yuvNun4wSOIP6U?=
 =?us-ascii?Q?Cwr2qbc8fKd04RdVpE6lNX5wyUJ2PNARdh4CiAc8EoXyNRI+AWQYTsWyCNmU?=
 =?us-ascii?Q?4pzM+V4WYjKVgmwv9lr7GsNh3CtKWN8nqt8N+JQIcGNBUcQD3EKVKqHuIKCc?=
 =?us-ascii?Q?SDRMTPMWstbxdw0kHuVaiGT/iwk/qCuEQP8MWXbqK2be+QjIn5TPf83LzqVh?=
 =?us-ascii?Q?CFSBovrlKcN62BAYMYqhdAsybU7YfQG+mCdNO0meu7+BUfMiIMKgQyT2oW+d?=
 =?us-ascii?Q?L/BjGFJaBRsAWVY+nbKuvfGXDD8Go6Mpcy7Fu5i88Xx441aPXpIZYAxgkOt8?=
 =?us-ascii?Q?/Egsxfkwwg2i1MU6Z4USwGYWfdwnGHB15gv8JaQPeb10c6Er8f9NajjBWR7E?=
 =?us-ascii?Q?euoiMEsezjcWyTOge8AiiJrO+TRIWcy6bPblcYt8vkAqlTCKtWyWkf6NNIAH?=
 =?us-ascii?Q?6GWWcnPqMX64/kJeNY6K1Xso5nYFl0/U7yVYrrfPVVCrTpGyzW+rtQmDp95B?=
 =?us-ascii?Q?2iqCpcKV3S5Muu8kRScZ2ctGJ7Ex64CGKCyRuZidZUGnml63n1VLinsaXbnk?=
 =?us-ascii?Q?hRqHQobF54yXI+lOO8yNE7kAmYNhziuj6czAe4EUikmpkKtyGKMZYrc8LSDi?=
 =?us-ascii?Q?wpcFAAOKxghcsX9H18qcbZZrp8LOsUjsCGm4w5z1EIKo6eJzan7x9Ue1Swtl?=
 =?us-ascii?Q?HAbwOTd8dQxH10DNRj925hUjfeAqRMrEmz9naKoDtMv/PWoK66sHlaPjlRAt?=
 =?us-ascii?Q?VKmQmFuH3PmZUKaTinKkytXlOaJsBuVZx8RKZtHZAAGe6fWas95+WRNgdOpF?=
 =?us-ascii?Q?xcfjgYoISkoL1uAcnW7W92tRPCREEAMyOsFntBM4txBHLi8KjBp9yXY6wn64?=
 =?us-ascii?Q?xcW//KqgJBnaPN9ga3ZXPAQWs4ityPm++Qzwizx6yJdhbKDZbM3MqrRX5wha?=
 =?us-ascii?Q?wYD6PxtTBmiPou0ymaYmXxlOmV8uME9ExJyd+uHVVyWeNnVc0FMgauYRgbRo?=
 =?us-ascii?Q?EV3yspAB+LnVZaCWaeW8WP+9QUIU4/qRvEHDPcxCYNgIpgA3PeH3wpD2wRIH?=
 =?us-ascii?Q?ARzV9F/HVOpRiery/Pd6jL4vQrtFRHjoEpN6D2xiZmXFZpL+3HqCuOloGYk7?=
 =?us-ascii?Q?kFikg6bQpw4YDQpECUNX4e3BQH1buOc/y65QYBqsIfiSUL/zmv3VfNxPj+G1?=
 =?us-ascii?Q?5OY5tE3aA7utLzTI/UexFBi0wxDzUEjESrg2XrNgkwY0Kh48bBorityMt46g?=
 =?us-ascii?Q?TU1q1JJ47kyOZ8+OYnEkFMKZg7Z2FUIeyUr8gjhcWlzXEJARjk5qb06praKM?=
 =?us-ascii?Q?l4iC/WBtSxkeBI8CgrgL+q7v3PDPeSY1BpGk8cme?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c16aa5b-b02f-4485-ff37-08dcb5bc6240
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 02:06:28.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOGBqpiRR/UKjmDdoX+cA5G0uTxEJvUS/dnFZdVmAbnuDJjZA/D60mVoL+9li9NITPiT99pDtuyqBmIOl/9sjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

Hi Robert Richter and CXL experts,

There is BUG: slab-out-of-bounds in cxl_setup_parent_dport in v6.10 when
boot up CXL qemu environment.

It's a kernel tools/testing/cxl testing in qemu simulated CXL environment.

Related kconfig and dmesg are in attached of link:
https://bugzilla.kernel.org/show_bug.cgi?id=219127

It seems to be related to commit:
f05fd10d138d cxl/pci: Add RCH downstream port AER register discovery

KASAN and CXL kconfig could trigger this problem:
"
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=y
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION_INVALIDATION_TEST=y
CONFIG_NVDIMM_SECURITY_TEST=y
"

Dmesg info:
"
[   24.413405] ==================================================================
[   24.416332] BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
[   24.419291] Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
[   24.427232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
[   24.430089] Call Trace:
[   24.432534]  <TASK>
[   24.434891]  dump_stack_lvl+0xea/0x150
[   24.438131]  print_report+0xce/0x610
[   24.440498]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
[   24.443129]  ? kasan_complete_mode_report_info+0x40/0x200
[   24.445602]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
[   24.448221]  kasan_report+0xcc/0x110
[   24.450527]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
[   24.453140]  __asan_report_load1_noabort+0x18/0x20
[   24.455455]  cxl_setup_parent_dport+0x480/0x530 [cxl_core]
[   24.457986]  cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
[   24.460285]  ? __pfx_cxl_mem_probe+0x10/0x10 [cxl_mem]
[   24.462592]  ? sysfs_create_link+0x75/0xd0
[   24.464775]  cxl_bus_probe+0x5e/0xc0 [cxl_core]
[   24.467153]  ? __pfx_cxl_bus_probe+0x10/0x10 [cxl_core]
[   24.469632]  really_probe+0x27c/0xac0
[   24.471750]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   24.474087]  __driver_probe_device+0x1f3/0x460
[   24.476288]  ? parse_option_str+0x149/0x190
[   24.478435]  driver_probe_device+0x56/0x1b0
[   24.480543]  __device_attach_driver+0x1e7/0x300
[   24.482682]  bus_for_each_drv+0x159/0x1e0
[   24.484818]  ? __pfx___device_attach_driver+0x10/0x10
[   24.486935]  ? __pfx_bus_for_each_drv+0x10/0x10
[   24.489037]  ? _raw_spin_unlock_irqrestore+0x45/0x70
[   24.491097]  __device_attach+0x215/0x4f0
[   24.493055]  ? __pfx___device_attach+0x10/0x10
[   24.495032]  ? do_raw_spin_unlock+0x15c/0x210
[   24.497020]  device_initial_probe+0x24/0x30
[   24.498922]  bus_probe_device+0x18e/0x1d0
[   24.500732]  device_add+0x11b6/0x1b60
[   24.502485]  ? __pfx_device_add+0x10/0x10
[   24.504275]  ? __pfx_exact_lock+0x10/0x10
[   24.506063]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   24.507931]  ? kobject_get+0xc5/0x160
[   24.509619]  cdev_device_add+0x13c/0x280
[   24.511319]  devm_cxl_add_memdev+0x547/0x6f0 [cxl_core]
[   24.513287]  cxl_mock_mem_probe+0xf1d/0x1d30 [cxl_mock_mem]
[   24.515133]  ? __pfx_cxl_mock_mem_probe+0x10/0x10 [cxl_mock_mem]
[   24.516998]  platform_probe+0x10a/0x200
[   24.518813]  ? __pfx_platform_probe+0x10/0x10
[   24.520638]  really_probe+0x27c/0xac0
[   24.522340]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   24.524194]  __driver_probe_device+0x1f3/0x460
[   24.525972]  ? parse_option_str+0x149/0x190
[   24.527763]  driver_probe_device+0x56/0x1b0
[   24.529555]  __driver_attach+0x277/0x570
[   24.531278]  ? __pfx___driver_attach+0x10/0x10
[   24.532912]  bus_for_each_dev+0x142/0x1e0
[   24.534474]  ? __pfx_bus_for_each_dev+0x10/0x10
[   24.536094]  ? _raw_spin_unlock+0x31/0x60
[   24.537676]  driver_attach+0x49/0x60
[   24.539220]  bus_add_driver+0x2f3/0x6b0
[   24.540781]  driver_register+0x170/0x4b0
[   24.542334]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
[   24.544104]  __platform_driver_register+0x66/0x80
[   24.545782]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
[   24.547579]  cxl_mock_mem_driver_init+0x25/0xff0 [cxl_mock_mem]
[   24.549362]  do_one_initcall+0x114/0x5d0
[   24.550991]  ? __pfx_do_one_initcall+0x10/0x10
[   24.552593]  ? __kasan_kmalloc+0x88/0xa0
[   24.554089]  ? kasan_poison+0x3e/0x60
[   24.555511]  ? kasan_unpoison+0x2c/0x60
[   24.557076]  ? kasan_poison+0x3e/0x60
[   24.558573]  ? __asan_register_globals+0x62/0x80
[   24.560188]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
[   24.562019]  do_init_module+0x277/0x750
[   24.563556]  load_module+0x5d1d/0x74f0
[   24.565124]  ? __pfx_load_module+0x10/0x10
[   24.566656]  ? __pfx_ima_post_read_file+0x10/0x10
[   24.568235]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   24.569875]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   24.571521]  ? security_kernel_post_read_file+0xa2/0xd0
[   24.573189]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   24.574851]  ? kernel_read_file+0x503/0x820
[   24.576441]  ? __pfx_kernel_read_file+0x10/0x10
[   24.577887]  ? __pfx___lock_acquire+0x10/0x10
[   24.579390]  init_module_from_file+0x12c/0x1a0
[   24.580988]  ? init_module_from_file+0x12c/0x1a0
[   24.582575]  ? __pfx_init_module_from_file+0x10/0x10
[   24.584234]  ? __this_cpu_preempt_check+0x21/0x30
[   24.585831]  ? do_raw_spin_unlock+0x15c/0x210
[   24.587460]  idempotent_init_module+0x3f1/0x690
[   24.589126]  ? __pfx_idempotent_init_module+0x10/0x10
[   24.590808]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   24.592513]  ? __fget_light+0x17d/0x210
[   24.594058]  __x64_sys_finit_module+0x10e/0x1a0
[   24.595643]  x64_sys_call+0x137a/0x20d0
[   24.597160]  do_syscall_64+0x6d/0x140
[   24.598688]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   24.600350] RIP: 0033:0x7fbac6f3185d
[   24.601923] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
[   24.606145] RSP: 002b:00007ffd13414db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   24.608143] RAX: ffffffffffffffda RBX: 0000564200192ca0 RCX: 00007fbac6f3185d
[   24.610130] RDX: 0000000000000000 RSI: 00007fbac758707d RDI: 0000000000000006
[   24.612106] RBP: 00007ffd13414e70 R08: 0000000000000000 R09: 00007ffd13414e00
[   24.614112] R10: 0000000000000006 R11: 0000000000000246 R12: 00007fbac758707d
[   24.616113] R13: 0000000000020000 R14: 0000564200159890 R15: 0000564200195a20
[   24.618182]  </TASK>[   24.621370] Allocated by task 615:
[   24.623062]  kasan_save_stack+0x2c/0x60
[   24.624851]  kasan_save_track+0x18/0x40
[   24.626603]  kasan_save_alloc_info+0x3c/0x50
[   24.628411]  __kasan_kmalloc+0x88/0xa0
[   24.630155]  __kmalloc_noprof+0x1dd/0x4a0
[   24.631899]  platform_device_alloc+0x3a/0x230
[   24.633595]  fq_codel_reset+0x6c/0x370 [sch_fq_codel]
[   24.635477]  do_one_initcall+0x114/0x5d0
[   24.637164]  do_init_module+0x277/0x750
[   24.638818]  load_module+0x5d1d/0x74f0
[   24.640483]  init_module_from_file+0x12c/0x1a0
[   24.642214]  idempotent_init_module+0x3f1/0x690
[   24.644013]  __x64_sys_finit_module+0x10e/0x1a0
[   24.645772]  x64_sys_call+0x137a/0x20d0
[   24.647459]  do_syscall_64+0x6d/0x140
[   24.649117]  entry_SYSCALL_64_after_hwframe+0x76/0x7e[   24.652407] The buggy address belongs to the object at ff11000067601000
                which belongs to the cache kmalloc-2k of size 2048
[   24.656105] The buggy address is located 23 bytes to the right of
                allocated 1249-byte region [ff11000067601000, ff110000676014e1)[   24.661503] The buggy address belongs to the physical page:
[   24.663371] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67600
[   24.665505] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   24.667605] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   24.669656] page_type: 0xffffefff(slab)
[   24.671471] raw: 000fffffc0000040 ff1100000d83d200 dead000000000122 0000000000000000
[   24.673568] raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
[   24.675767] head: 000fffffc0000040 ff1100000d83d200 dead000000000122 0000000000000000
[   24.678014] head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
[   24.680121] head: 000fffffc0000003 ffd40000019d8001 ffffffffffffffff 0000000000000000
[   24.682313] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[   24.684465] page dumped because: kasan: bad access detected[   24.688127] Memory state around the buggy address:
[   24.690046]  ff11000067601380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   24.692171]  ff11000067601400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   24.694384] >ff11000067601480: 00 00 00 00 00 00 00 00 00 00 00 00 01 fc fc fc
[   24.696415]                                                                 ^
[   24.698485]  ff11000067601500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   24.700609]  ff11000067601580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   24.702598] ==================================================================
"

I hope it's helpful.

Best Regards,
Thanks!
