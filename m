Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F815278E;
	Fri, 13 Jun 2025 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837462; cv=fail; b=AfYoCw9kfNFgKN0wT7dmfl/b+6idNI7Lc7Qe/QFIJKVfeViHjQUaJ0j6hbQWP9NspmXJYEuyYj84ln91roBsQ9b+Zx/xu6q4nYbT3gDtVSeVhWSfv4Bsqmi4Wtc7QhSIWFGmq6tGcgEhIXsqG1/Q+MaSnF9EseOXfvutL+VajQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837462; c=relaxed/simple;
	bh=ycY+jDyNM6Ij47DKvAG3l3WW9zmJ62J1RfvPZvp5+Eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwiGoTLA28Zxl000sm7MP1emZsSSUUEJW1q5F83feWwisV1RI9iUcH0nupgxg95chY4SgHoaKJbBEu3uMglcHKRGU2Nn35tlgnLqeVMg58Ax0Ib+/c/K+pgXvvSuxmaJIqIfQycj42tkhCeSfjzx5SU2bEvfiWIMyidJn3JfyiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5bmrQcW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5bmrQcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749837460; x=1781373460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ycY+jDyNM6Ij47DKvAG3l3WW9zmJ62J1RfvPZvp5+Eg=;
  b=U5bmrQcWuK95F8wQ3Lw3JdcgKYe0KBl8K2lP0brO8jhfPJr4k60PAwbJ
   mPG2wrCIViDhhWHw3Nzw9YVNCvR0cXZkK0ONb3itHAfJ96hClf8JdC/+0
   hSYG7t5KHel666+qgolOqS9A5WWi50ypSVEUh6KYMKxrJnkTaLS3Sxu5Q
   Jtv9snuaFWBLymCdyz3pJGpH7KUTr3oYSqyZpeBBayVki93gBXBHE5gJw
   0Se+8MiSk4uXCQre06aX7HbthwUKYElsA1erTHJYeq8Pd3+MuKfjynErZ
   PciS4MRWM+p3mWM5sJrQYZ+F7plk+2pEa/ZN9Pym3GQsiUpUuVu1PCH84
   Q==;
X-CSE-ConnectionGUID: KzHT2i9zRRiA695g6VbZwg==
X-CSE-MsgGUID: 9x+H9lqFQzuUrWXnTIM7jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55861384"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="55861384"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:57:38 -0700
X-CSE-ConnectionGUID: fajOqGDdSYKGpwIXbcBivQ==
X-CSE-MsgGUID: RwDXGcT1Q+CAqVrP6AQTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="171070223"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:57:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:57:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 10:57:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeE2S6CrmVShEUA5F4n9PaR8MRCH+wfZ5pM+s5PfE506m8E5/uPEF/bB41BHteAO0frrIl26Gj/5H4ZWtNhqRwVWQwBhtJw2f3bBWzYsQ0wc9ihTxbIsicEMZb+Ip4CL2uIAHYkLzVUfgmtiDfZ8LIfldA8q0xsu11p8XgLkRRkv3Bex7K5fPgaRpMLn8Ph6Y9gPkJm8U2luVSv2AzypqDiF7vG+5ElURyybtZ3jUIJHRz0YGAlVB7vbsyW+xwi1WoJxYwTjfZ5ppFQCuw14+3qxXubVSNRsy8OF8TbxDjNh9qpYHuSsaS4xHzRImSvSm0fub+74nuooG/n4217nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUaf8PCwPOGDE2l3KBuZi+HuJWeZA8MrDElgcBSI2Ds=;
 b=xZ2raFuOVWkkdnrUJ6V8HrHiFT7W4eOA1bV11CCTYbpzFH341aaEvfR99KF0Ut5/5nbTUGK3sOmnCgN4SsIuwwU8V7rtUjajbEom/mAg2ISWv87+UpRKz4qcK+GYnzxmgq1nkfmEqrEuLMN0VXBKhpfg2NJp1Mm1jw2UmFInQ65aP5sLdXpHhfdHCoR3bpT/+lOR5txch/p1Fut5hjmz6SYwql1RIxoS0bGTiSZ2rz1fSdswJDgm0uQX0tsx9cynInnIwyTBhwIBuDKKKVvI0TGPs6hTKGVWSBxNcTfFW7+qjzZTjqlkkgzYQ8GX8LuuJM3TM86MZ9UGiy8fgzoyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM3PPFD83941681.namprd11.prod.outlook.com (2603:10b6:f:fc00::f55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 17:57:35 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:57:34 +0000
Date: Fri, 13 Jun 2025 10:57:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] cxl/core: Consolidate auto region attachment
 logic
Message-ID: <aExmhi5MAVupXaYe@aschofie-mobl2.lan>
References: <20250603053645.3099299-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603053645.3099299-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM3PPFD83941681:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c2d39a-950c-4e07-71a2-08ddaaa3c6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wQQZvr8Mqx7Yu/IoiC3EucEEJrVOz85R+pWlVYklkjUlYt16MQVPbA5CfEGN?=
 =?us-ascii?Q?qyG+82ytDghz7kjyZBTHUFGI8b1vbRhMzopuCeMbTP4PP/PDx7FmzVwZ9kkK?=
 =?us-ascii?Q?g4UmhRD33vvtUnELS1a20Fzf1onh0iX3dyyp5DQzwxVveuLd1lWSZLr2Lh+E?=
 =?us-ascii?Q?j5ihk2a+XX4/c0s058nOob4kWwwmiY14ll5qkYv+3dQT88F2hbYM7Esxkb9w?=
 =?us-ascii?Q?gb9GDxuBWwgZKDoEWVOWm2r2jwg3R5ZjQyuSFBbQ2hNWpFCFYy4O4VRJeT+l?=
 =?us-ascii?Q?vDKdsIf2D1N5npr5ereLRsUsEWr+h6R0MOe9tNOaHB1wIk8hUf3MYBdg9Eg9?=
 =?us-ascii?Q?2wyeomXC7rOob2Q2hPaiPF54BUmsBABxJkTZ4f1v1iJuTkELg7xdBE9dvM2T?=
 =?us-ascii?Q?tYf6rdVTuf4yz5CN38bJvQ+AYR3Y73t2BtdFMGbZUBoQnzJvs3PqcdvnJyt0?=
 =?us-ascii?Q?LYck8uDLc/gadqImVWzawTtd+PNAZUdbKb00YPyKDyx6Dooo7fWaGJTGspHg?=
 =?us-ascii?Q?3jcOLcdDIaNshUOFnYPc8XgaWpa4HMVzoSwbnW+Ge1Jt1nwahc0vFpnOIsM/?=
 =?us-ascii?Q?VOqoqCdbLJCCLVdO/bXgnxRFViomDeHAAohaGlxEGn8t34s8sBLZpmvu5er6?=
 =?us-ascii?Q?dqtTKFtUaAcaV0WwA1ecnWurmfP4gtrFDk7TApm8nHgD4V4fSZmIsGiHHY2M?=
 =?us-ascii?Q?PxMBd0Cob3dQB11zQRfa57ow65y1gSEGgZEgH/Qn8azAS6Epp0nJ/NTst9Jj?=
 =?us-ascii?Q?YJKCE4Wz909zgW0D5+SWS8xC9QVYMF8yShAgnGJyAfolCo91QPRw0RsxVTmf?=
 =?us-ascii?Q?jfAwnDA1eUG5MsZ+ZIKCcLOjA62QuaWfwEo683eRHHm5jHcJspb7CAfjDMiG?=
 =?us-ascii?Q?SXc/SWXSuQCqMYqtmSuzK2X0OJulo/eVzMpPt6y8FHvp1OrUVVCo0MJfN0Ux?=
 =?us-ascii?Q?W+25CDreafr0Nz3Ngxb08zWMgDcx7wuo0EUUX74WqGUDc+cA81AcCy9ftvkR?=
 =?us-ascii?Q?dlZaGdrz56HYF1uBf0NzIqx74q8nTcbldVYzNpwS2O4SPjM05AIHYBZtCe9F?=
 =?us-ascii?Q?MLy5ju2JOy3A3mZCI4YfMNtOIDZBYodpJ2iD9VxbgRuEXT/i6zewSiPbdWlk?=
 =?us-ascii?Q?7LFMxiY/nDRsszVdLO+VlsMunYT8KvZZorPGFPm1NfE4NCPG/on39Gxyscnp?=
 =?us-ascii?Q?meXAxxI5r62VMrzf2x556FZJ+V0unHcooMbQarE9plu9nyBKdOwr8a9vGJGX?=
 =?us-ascii?Q?rKMC4znSsOS8kumcv/oBrnnbLWGWd+q/WckQTWHU4FtvtkPOBNSFBqJUq79s?=
 =?us-ascii?Q?xXiZbrkfZ4Fi7ACMkIs/bVUCGZf8bby3bnTkMVxwT1cpM/keqoaGeIylJZXd?=
 =?us-ascii?Q?9JxINB6mIENWYNRvWOHu5pK8NSUQm/kS4P+UINBQh8tRO3jtTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDjeIeCdHp45wlJkHDOBCEFgAWfmOsE1PDywalNbj1W53Msk0efKlJq/Vs70?=
 =?us-ascii?Q?YSSP4DmZeGG4xMFQAchzz/wn1K3hYo8nvFtuXIHWrH4e5tpnZtAQmDMSVhJc?=
 =?us-ascii?Q?oOAIRyfCIFNNycRDJ3QnoloOsNz16hWN3VIIhcDVQvaclgjIxiTqtx5K3Hr8?=
 =?us-ascii?Q?+Z2453KiGtxplRW8PMzbNaEwCux4xPXVvob2TvFdXVIlgAb7YuSSsDj6OYDT?=
 =?us-ascii?Q?REk1nA/JfpKeLQfigUWdsw8sPy5/BF1DGv0BM4ZWYHJ4GEhhPiDTmK/lNWAh?=
 =?us-ascii?Q?iHx/b8m/kJsG63ZM2GquBC4saZj/BsFBKdPDlhLfOEaTb8C/SjvHnee1In77?=
 =?us-ascii?Q?94BMbaDnc6ZR2dINfp9vlgP7nOPJ3NBi0tCam+k9m216YMwno/YGiQ6kvgVD?=
 =?us-ascii?Q?8UQDSTZDP3e47DsBbkeOKNwQNFPCD3VPedawnzsM6XrMa3Qo/d3b7NQj/cV2?=
 =?us-ascii?Q?O3HElvhjs6kgPaqEailMy70BeIt/ZEhzAkeuxLQNYwWpBDPrWeE3xQ2klFB+?=
 =?us-ascii?Q?ycXaVMI/CTZQyBTwtxzmO94Aeec+3N9qxYqcJ9e8TJVscLzFr/3OJia5G+Nz?=
 =?us-ascii?Q?5z1rSjXs/2HfNIdbnA/LCryZvDUKiRCteZVKPWFSB22d84MRp/JpC8BHRVGA?=
 =?us-ascii?Q?dRIRcGg7BOx/2Fuq+nao+xndV4FSwMrN8YcVeYznwAI/MpLXLDjiAlV4LF7s?=
 =?us-ascii?Q?sTkHSrBfdxTeDTTHg2Swo/+Bdb7G62mJ3Agg7P6aNyynD7oH68cTJThHxUR7?=
 =?us-ascii?Q?jWrOXmVYgfBX/f5x4bIbmcx4JJZ/j+8H7YugXRwuVQX4M63oJJCTK7YWuEfJ?=
 =?us-ascii?Q?s7zSwzV3aP24VWBLOx0gFPmfMc3WHzu2dWLil0YG1H+5H5Pc4Sb2rifY0vtx?=
 =?us-ascii?Q?6P4+h/HlwxyzsagF/QYDEZbVTt/iBb4pd1NMl4g6PXvKk3SSSWf5MhIPd4VX?=
 =?us-ascii?Q?Mq1Ar+ENlb11Fz+VFBvKvWT2y6TU/hdPsMQp4srWAOL22Fc7AkYX2Un8Qup/?=
 =?us-ascii?Q?O99XVLsLnkq1d+tl4nx19C27MugfWaSNeDfka7OXbRY4hiCHns5zsc50E29v?=
 =?us-ascii?Q?gELm8PXduAf8ot/32SRyUPIbIjWAihlDLT8gqdOZVZcwK6IpLfCA0OA1RuPt?=
 =?us-ascii?Q?fVbJrEFxRXnUflAWOJbRAWCU5PY08026HlIhQCH9DYHWmPBqpUlLMwo7DJu9?=
 =?us-ascii?Q?nL1kJbt6uJN2fWtBPxNAZ25wqiO2Jz6nMan5ZCXHloKjqa6GjP9btPhk8gVt?=
 =?us-ascii?Q?Gr0FtlAyc1zGHJcZT5yfoJ1vuu4lxA7KXji3r3AgfyPOUP2vuEx5LvKtmjGF?=
 =?us-ascii?Q?9JMEr9qQu1l9n8yAHA1OlZSU2G/nMdaZVX2Dj6w2Q4JEPx4nUu4W6TtfW0ru?=
 =?us-ascii?Q?SILE6FJsDAgtzSnndFdsBw6SGsj66w4fxuzBMcE4VLP8gwluDA7FN4Q7vR+d?=
 =?us-ascii?Q?LExuCovYoHPJA2wsowU8wOMjDO2YwQSsmXmuhr8+fSEHzuTw9nZ8O+8zGRpw?=
 =?us-ascii?Q?rtERA+R8XeGuP6/vpJeJVeXoEAAoi/l7oVXwj/w93SJF2pCaFJ5TS7AQnqci?=
 =?us-ascii?Q?FpqGvx+xNmbN78VZSI00Ec7vMYKfduyS0McXrPsL8TZ2XfXeBYoAajtdoxjY?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c2d39a-950c-4e07-71a2-08ddaaa3c6b2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:57:34.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knXTelf74wB71SiS6yHdY7u5O1rTUtijLGsXXKdtHIC4z3fPeZbbZWl2bDmnVZvPz8K2FXLyUQaKCN/mD12LmKlPDcLPro8FwtP2jn/Ou4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD83941681
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 01:36:45PM +0800, Li Zhijian wrote:
> Move all auto-attach handling from cxl_region_attach() into the
> cxl_region_attach_auto() function. This combines the partial handling
> previously in cxl_region_attach_auto() with the remaining logic that
> was directly implemented in cxl_region_attach().
> 
> Specifically, cxl_region_attach_auto() now handles:
> - Adding new targets when in auto-discovery mode
> - Waiting for all required targets
> - Sorting and validating targets when ready
> 
> This improves code organization by:
> - Keeping all auto-attach logic in a single function
> - Reducing complexity in the main attach function
> - Making the control flow easier to follow
> 
> No functional change intended.
> 

While the intent to clean up and consolidate the auto-attach logic
is understandable, I think it's best to avoid refactoring purely for
structural clarity unless it's in support of a bug fix, new feature,
or needed to resolve a real maintenance burden.

If we accept pure cleanup patches and move things around for no real
reason, it just makes it harder to read diffs, find bugs, and maintain
code. It also consumes reviewer time.

NAK
-- Alison

> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 164 +++++++++++++++++++-------------------
>  1 file changed, 82 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..e7618d59b548 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1702,44 +1702,6 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> -static int cxl_region_attach_auto(struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled, int pos)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -
> -	if (cxled->state != CXL_DECODER_STATE_AUTO) {
> -		dev_err(&cxlr->dev,
> -			"%s: unable to add decoder to autodetected region\n",
> -			dev_name(&cxled->cxld.dev));
> -		return -EINVAL;
> -	}
> -
> -	if (pos >= 0) {
> -		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> -			dev_name(&cxled->cxld.dev), pos);
> -		return -EINVAL;
> -	}
> -
> -	if (p->nr_targets >= p->interleave_ways) {
> -		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> -			dev_name(&cxled->cxld.dev));
> -		return -ENXIO;
> -	}
> -
> -	/*
> -	 * Temporarily record the endpoint decoder into the target array. Yes,
> -	 * this means that userspace can view devices in the wrong position
> -	 * before the region activates, and must be careful to understand when
> -	 * it might be racing region autodiscovery.
> -	 */
> -	pos = p->nr_targets;
> -	p->targets[pos] = cxled;
> -	cxled->pos = pos;
> -	p->nr_targets++;
> -
> -	return 0;
> -}
> -
>  static int cmp_interleave_pos(const void *a, const void *b)
>  {
>  	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> @@ -1905,6 +1867,86 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_attach_auto(struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_port *root_port;
> +	int i, rc;
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO) {
> +		dev_err(&cxlr->dev,
> +			"%s: unable to add decoder to autodetected region\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -EINVAL;
> +	}
> +
> +	if (pos >= 0) {
> +		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> +			dev_name(&cxled->cxld.dev), pos);
> +		return -EINVAL;
> +	}
> +
> +	if (p->nr_targets >= p->interleave_ways) {
> +		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Temporarily record the endpoint decoder into the target array. Yes,
> +	 * this means that userspace can view devices in the wrong position
> +	 * before the region activates, and must be careful to understand when
> +	 * it might be racing region autodiscovery.
> +	 */
> +	pos = p->nr_targets;
> +	p->targets[pos] = cxled;
> +	cxled->pos = pos;
> +	p->nr_targets++;
> +
> +	/* await more targets to arrive... */
> +	if (p->nr_targets < p->interleave_ways)
> +		return 0;
> +
> +	/*
> +	 * All targets are here, which implies all PCI enumeration that
> +	 * affects this region has been completed. Walk the topology to
> +	 * sort the devices into their relative region decode position.
> +	 */
> +	rc = cxl_region_sort_targets(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	root_port = cxlrd_to_port(cxlrd);
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_port *ep_port;
> +		struct cxl_dport *dport;
> +
> +		cxled = p->targets[i];
> +		ep_port = cxled_to_port(cxled);
> +		dport = cxl_find_dport_by_dev(root_port,
> +					      ep_port->host_bridge);
> +		rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> +						dport, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = cxl_region_setup_targets(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * If target setup succeeds in the autodiscovery case
> +	 * then the region is already committed.
> +	 */
> +	p->state = CXL_CONFIG_COMMIT;
> +	cxl_region_shared_upstream_bandwidth_update(cxlr);
> +
> +	return 0;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1986,50 +2028,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  	cxl_region_perf_data_calculate(cxlr, cxled);
>  
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		int i;
> -
> -		rc = cxl_region_attach_auto(cxlr, cxled, pos);
> -		if (rc)
> -			return rc;
> -
> -		/* await more targets to arrive... */
> -		if (p->nr_targets < p->interleave_ways)
> -			return 0;
> -
> -		/*
> -		 * All targets are here, which implies all PCI enumeration that
> -		 * affects this region has been completed. Walk the topology to
> -		 * sort the devices into their relative region decode position.
> -		 */
> -		rc = cxl_region_sort_targets(cxlr);
> -		if (rc)
> -			return rc;
> -
> -		for (i = 0; i < p->nr_targets; i++) {
> -			cxled = p->targets[i];
> -			ep_port = cxled_to_port(cxled);
> -			dport = cxl_find_dport_by_dev(root_port,
> -						      ep_port->host_bridge);
> -			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> -							dport, i);
> -			if (rc)
> -				return rc;
> -		}
> -
> -		rc = cxl_region_setup_targets(cxlr);
> -		if (rc)
> -			return rc;
> -
> -		/*
> -		 * If target setup succeeds in the autodiscovery case
> -		 * then the region is already committed.
> -		 */
> -		p->state = CXL_CONFIG_COMMIT;
> -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> -
> -		return 0;
> -	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		return cxl_region_attach_auto(cxlr, cxled, pos);
>  
>  	rc = cxl_region_validate_position(cxlr, cxled, pos);
>  	if (rc)
> -- 
> 2.41.0
> 
