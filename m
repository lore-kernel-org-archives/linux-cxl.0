Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA8224B01;
	Wed,  2 Jul 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485182; cv=fail; b=XqXDVwqS3SM9zPAWSXeyVtg5AjOgg65c9NTRGeGT/tL6gtJGM9kDCaXmGfp/yn9eINaco3VpS/mXfYbbuGiNKRDwlVd4+OPrIubvMfZ7sc9rxtlsSuMr/NDm5DWQ7UdesSm0eW7W5o4quR89eLOO11KT5PHSvWM/qxvceWk2dUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485182; c=relaxed/simple;
	bh=x7PafHaSmjvBldamButS4KVjdCM4g3fahbLiBhp5n2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FopQP7cUkrFN5kN2QVr72mBOS6sXz9ZOPTonZ2Cv/+Xxde4b1e84yOqorciHfHotOlerObOmu4tJJpXtN9NOjbPrpPBNzEg/WmdUiyhW+/zVLrlk7ZbeEu8e8XqRyDNveWPJpDIzr3oZe1+N7xPOSfmeDnh9VJm7THCwYSqWrKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVE0TLP+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVE0TLP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751485179; x=1783021179;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x7PafHaSmjvBldamButS4KVjdCM4g3fahbLiBhp5n2A=;
  b=DVE0TLP+I2Qwl0NU5VH5TmEcbU9g6ZTS6gorQAtqMseW7p8GKBWdtgYi
   TfXBoc1eQRkWNQlvXb77qb8pmQZ7hHSwLZsW0F9WxAiydPToHLXVTfODY
   T7LdDxdT2sJinSMcUgObZkAaQj+i1lsDmYd0lOcOG5oDax6nkAZURQuz1
   7eAYIw85QFUtX5/yjgJerjLASRbgM8Lr65u/fW49E5HfC3G6RSE3suohX
   oYq1ATn0K3p8gbh54xaU8hLEnR906tIQg5BnO8DVFWHDtOu0DeHc2J9v+
   B8sNH80uIuF6UnbmGLMYdYc+/LuZHHJBLmLlz+Mtf9YhVFeNcrWmQdvrD
   w==;
X-CSE-ConnectionGUID: SmT4v2KkSNiFBu5LjNIjqQ==
X-CSE-MsgGUID: 0cGDzfA9T46sfN4lQSwo8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57472279"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="57472279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 12:39:14 -0700
X-CSE-ConnectionGUID: 96tm7PQAT4yH71C/wLmmSQ==
X-CSE-MsgGUID: 6Xag4VddQd2qOe7fgj33Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="153937238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 12:39:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 12:39:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 12:39:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 12:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh/oiDxHKuKPEddpN86sE89HSzN1tymf415k0mAaeI/u1Em9wQRGtEgTdRfPKnwJNStqe7VShHdQ32OZuRUbJswnM4LflpNYtPA879P1rZof8VQZn+kX7AhaLl7t6BDPr/2Y9VwA6bdNmejkei9dEla/cPCez0TX5Ss7c4hMYeefj1bk3Xkv5qAFjBOkJCYTGFeKePHAtG1EBqJQrLNB1fLbxUtmThJYG2CmuJycIndqRIqNYTsVzbqo62LUTWIErRShEvL5FtVtJr/djGVB2WAJNVKtnrGr/Ml4DR2dB4jvohbi5YSiCQ6Q4M0kfC/UYh0YxnYFW6c4yCpfNk98Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGcEv49RzWywGxJzw1NRy3c2vnEUYxmnNtgd1k7tq58=;
 b=C2Eg3boc4xkertOfch5k1PftUZjn5cbsHvCHqjDG9bfLJ/QDHS62+DEbcSTe9En2K0hs8OppBkZnsHcW/NIMRMjmbRspLVDMpC5i0P0boolioavj2DmJ9w3hD1dmaCklQJMtd/1j5V3wgbi7CdRZ6Pw1rNC4MWnJ/MHjl7H2V+xdcLM97yuciKAOzyhBF1jJd7MufwPoF6oL1OB6K3gEaAa4y/+xKpNWfhWA5Lpv2abaGtxRXp4WrrZS2FLHfjHD1TIPVILzBSU5fKtU112hjHBWe9lIo0GxoAx3I+OfZ6fs6LhqzX7im4EFPn1qFuC6IvbUWWCZhJV2/9h8Kxdvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPF2B323C540.namprd11.prod.outlook.com (2603:10b6:f:fc02::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 2 Jul
 2025 19:38:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 2 Jul 2025
 19:38:32 +0000
Date: Wed, 2 Jul 2025 12:38:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <akpm@linux-foundation.org>, <andriy.shevchenko@linux.intel.com>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Message-ID: <aGWKsBYX2kux7w9W@aschofie-mobl2.lan>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <20250702072008.468371-2-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702072008.468371-2-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPF2B323C540:EE_
X-MS-Office365-Filtering-Correlation-Id: 6459d9b2-904d-4bed-d995-08ddb9a00765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NDh1Q+Oyl7FwHLhoFIvneMVD2dZoZfWuPDSg+hfgx3+V9aZ4W3i4JEzyJ9TL?=
 =?us-ascii?Q?SX2fnXL24Z501RzHmplZqCVAA5lVPGmP+i1l3R6pvUzxIoANEFr4HiDGm4qF?=
 =?us-ascii?Q?HKxsFzQc2txh6B+wwlfrHa1nkY/SDcXunPjqvxjPZegRTaqPrEbO9U8q2W6Y?=
 =?us-ascii?Q?j4NUx+VGbIgL0IzYCPqsS3RCIS+LSrgLkJMCjo6oAJIQwmne2hljPJvwuBjb?=
 =?us-ascii?Q?j5lQi7co4oxINTYMssaWZt58nvQV3wo5o1V4EG1rwSS6ppGo3zBDpKuCuNHV?=
 =?us-ascii?Q?cuzuFDpQQ2ev9OCvWeJe5fZD8XZYKnSq7PICpXGNXuzyo5U3OOIxPJiKcF/7?=
 =?us-ascii?Q?+YjYbBHDngeAGe+/SiFsqqygE+ru8cB3dnTmugJfSu7dBdTFyfLpR2N1tLOi?=
 =?us-ascii?Q?5Ra3i2mBBPNzDYNK9Pl+F3J0LZlmf+zcsVqTf+P3S7KU9anM+rw5Qhn0itR4?=
 =?us-ascii?Q?hlXJxMKhoqTCn4GXwzQSCzRP0NvpQ+iAU07/52j6AdroGLsCqpzXv2O9nhwC?=
 =?us-ascii?Q?pAjkfzXqmcjkt1L9Pq5g5zvnROrYfswX2tZ+AhSc7n9m51H/Py0jGtMJ0lNb?=
 =?us-ascii?Q?UINEYJITi2aNl4Uacx5Mi+YhHMmVgDzo6Fkhzh0R7Pw3O17q76ZuqbK8rWVF?=
 =?us-ascii?Q?LWfNSNExb4iwzV0Hxt3l1ANY0lEAsiau992CPSja13RY6Z0xnGIxnEXwJ/p8?=
 =?us-ascii?Q?WIiA+w04DN79HCXXM3b3ccQKguPl0rZ0HMyzU7RJdaJKjwIeno6V98f9hj7L?=
 =?us-ascii?Q?XAUL6k3ZtXbS46enUI4qRIUQvV0iDk8VWf66ZQCMahOq8P0hC4OI47UFr5s8?=
 =?us-ascii?Q?k6mzETKcZLnpPQwwFbsV4S7RV0QEyXt0lYFL77GCROkgaBanFEek+0l/tu6l?=
 =?us-ascii?Q?8X1BnoS9YWsLiiP+25mrBlrSpmKsOzsbA+ogG/aZ7TY5zRqWRVXcLhiqkGos?=
 =?us-ascii?Q?FCxxeUNPZnAvwh7i5Ij/dm6ZWALg5eupN+lDZ7L3FNagGE3p37NIUyqDBore?=
 =?us-ascii?Q?VLUpsAX73gExyHPezbr4RSldj6TgOz945lElQ2z5AH9lCXuKVf4m9t8gVQxD?=
 =?us-ascii?Q?GfWAfW6sQCPr3D0v22uljTZ4gZXF3NGgFsIDhzII8tssvFxOVIDMjENHcX+S?=
 =?us-ascii?Q?RMP7jJjcQoB0AdyGYk7iYrouJngBE1b8hgG6tzBAWUTMa09GPiHaPjf6E2K6?=
 =?us-ascii?Q?/uPSbloHh/rSPmPukPN0T6V9PL5EvwhIljrJX4R6IpDs5IlpC+oylNz73Qmw?=
 =?us-ascii?Q?j54/b4xWhF4m2OmmJ9DYHuuaixPwO+JsmEU08Ft9AJCBFAaZV/Ftd4g44A/w?=
 =?us-ascii?Q?N6OzewWCfINIXSFbJFiHmlgV/DZBlOi/75/vGEDLClrbEQCRBDP05tME4jgI?=
 =?us-ascii?Q?ynS68y+HR42deCNfMYbpAz4ar+5hxOO+3nk6M6pkTjNNdXP+0urxWAQgo1SL?=
 =?us-ascii?Q?nVYjpX6DcjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xi1UvJjfmpubcajC2eFuQmgoL3q4pL3u6lz6eOX/iEO44roduEz81Q1Fg8u?=
 =?us-ascii?Q?5G/t0hgKvhgB8BqkXv+PHXGpUHVrVgyVVv5AUektKG3CR4CG7ob/HLf6je0p?=
 =?us-ascii?Q?lT527ceP0ukjvpVIsmLkNnVyRUkYtloWkwL6wcirfxDb4F1+p7+DyePI5mAy?=
 =?us-ascii?Q?sRpbZar4dmjmFvqMF0IFbnoUFB14slbP2DUY5dANKSeIjNaGK9nQQig5uk3i?=
 =?us-ascii?Q?ESToKFF12OToEadGyQcdRan7UWzwVJ/m1+O5epYkJ9X+8OtNPhWN93gxk1op?=
 =?us-ascii?Q?fcEopXKclPr2LXz/uG2gA+eXH2d/tW2mVhEVWnBN4s7ZXyqkLSHQobfdwnbH?=
 =?us-ascii?Q?qkcMbobUNPEftfHYdWW5uiyTxTyHMDTs+/V3RqSsTjVFGbc/hfqWdsaHt5T6?=
 =?us-ascii?Q?aYk35F+WhZfKGHqn86M0KB5sof5G29U0DRkyYo8uWnvPQDRuQBP7K3vWe2zv?=
 =?us-ascii?Q?u47SFQsfhj1/Z3VbpGkQ/9b4pgccGR1+T4LFU2PGDHc7oBPDp3LnjsfR2nOa?=
 =?us-ascii?Q?B1kqFku24SeLEMWmocF906VeSEGqW2uoFFhgtqoQA2MFochyf6aBLg9rmayp?=
 =?us-ascii?Q?nXpq3YWfHUaaRIr8EkcYnx+9L7VgMJWuiJoTJCeIjV1l0r8tgpSE52ZLMYWs?=
 =?us-ascii?Q?vnFnrhm4r/Ruk53z+GVyT57vg1j6aEXLIh8O8lGuk+zbuZfWGnfW69qVvQnV?=
 =?us-ascii?Q?RC3BwzlUuvSRn0U1jieNG5P+peE9JtDYgDbO6T7+0f1Tl9vdaIy5UQanBEMr?=
 =?us-ascii?Q?lwXkXfJVMHVVRx6fcBrBORvs+UzhXBeaSgjI3cCBOqw7XzpyhvQ6MgNoIztv?=
 =?us-ascii?Q?j7OLOPjDd9mqrDoV0/ReaQQawvH1IG97lQ7jY+Sf91jBz5LMZwjZ1w7lzndU?=
 =?us-ascii?Q?nzjGx6eV7Gz0ZfCL007mK1HREURdav6R5c5tlFFZUQtrfqtFUc2XuqEE6mCu?=
 =?us-ascii?Q?rjGPhcPgKMzzI//4+zYt/FELdQEorTakVjrG9LCYeQu7Yl3X0iZyNtp6NCsh?=
 =?us-ascii?Q?gO9ZcWNgd2TGGN++rROsU2fz66+JuWzZH5fY6js+ppWKdBkqCr0iIJAVwBUT?=
 =?us-ascii?Q?ff/XGwDiah0COR8z7GIc9PVYJwz02OxFDUYi50/BwRU3bQHhRAEMthZho95E?=
 =?us-ascii?Q?UmuNAuTxm6tzaKM4ylyGqinlwIoMuiV0dp/Wz8mZqBLqt6UoauFa3jgUMFZX?=
 =?us-ascii?Q?liu5IT/ceM6vV0B1wZokiSV+139jjIocYk4hpu+5o+xhopud8V4MBLjK+9mV?=
 =?us-ascii?Q?1vo5DMkaEfddoTM1R2SGRsUeuEEiZGEIsX7wNWGMPX9D0QDj8fRefwi2vSqi?=
 =?us-ascii?Q?Thd3BG5AQu1JeWX7T2/Ocl1DEt4QyM7cbIbaX5hT8iNMXbSS1LVriR5mAq1K?=
 =?us-ascii?Q?vuHRMZ/tIdcRhdVXco9S/hFel5ad5Nw79uD82t4pwdS91ySUlATy/bf+sSC9?=
 =?us-ascii?Q?lqFmiRYi5GmcTDHTFY8NnNpzsG4JRenHwneoe0Sq9gvSM8bFrTJATLYpVp1y?=
 =?us-ascii?Q?4AlzHo3S5HMCfzXwJWRpebsEgWJ3lVZgxu5bxdi6GDcJB1Ta2miopmzdxBCj?=
 =?us-ascii?Q?CzJ6dE9X8ZiGzDjbhJunVKrLrtJwfNDtav1RjZCNDYfwHateXQN1lfwXB84j?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6459d9b2-904d-4bed-d995-08ddb9a00765
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:38:32.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF04dlDR5JeJ7E2j+wMcQVVUFiiv0zuufa8kj/bRm9SVIPJFEUVwtI1lpG+89185kZLBwUKd9SyeiQXBNMpgE4tMzPYuj3MqXXgHHw38HwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2B323C540
X-OriginatorOrg: intel.com

On Wed, Jul 02, 2025 at 03:20:07PM +0800, Li Ming wrote:
> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
> of a CXL device. So the correct implementation should be checking if the
> DPA is in the DPA range of the CXL device rather than checking if the
> DPA is equal to 0.
> 
> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 623aaa4439c4..1cf65b1538b9 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
>  static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
>  {
>  	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
> +	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
> +	    val != EDAC_DO_MEM_REPAIR)
>  		return -EINVAL;

Hi Ming,

I think this one needs a user visible impact statement.

I'm hoping the broader helper gets accepted. That may be the ioport.h
addition, or maybe we end up with a CXL special helper.

However, if this patch is aiming to go upstream as a FIX in a 6.16 rc,
then we are probably better off fixing the check inline right here, and
then you follow on with the other 2 patches to be considered for the
next merge window.

Please share that impact and suggest whether it can wait for next merge
window.

-- Alison


>  
>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);
> -- 
> 2.34.1
> 
