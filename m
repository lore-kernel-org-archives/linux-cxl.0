Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C708EAF1;
	Fri, 13 Jun 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824976; cv=fail; b=heQLvLdB9Mt+qqpNzjviN1zdtpfxGTuDpoGMuGORqoBSj9b2RN2E5XSFG6kb5x2k3PfHFHw9KIyseHCKSWmh41khXlrzIhDjlrBaAueUuwxerZbb5RUuWPPCb/VjAwXnWylVG16/mQtecHa2xTTUocF5vgtOSk42xL8VkawsM5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824976; c=relaxed/simple;
	bh=fw8m+7TdTp24J2v0w5wZmXW61zFUktn2P8Us6JIyHMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFOcO+f05cDah60W/LZ/g95A8MMerTPsr+R9SODIO16uzOB+AfZTMILIQgd+jkHLO5QSCJgOuEXn3YnKnZAMdPzL4H0D1zyWeu1UV9U/YwtufAkx7D6vi9RNeD30Uqrzp5A36kn42AMx49kFi+4Q7QYq4HBPzqq59FpFkugsTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVTQexvX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVTQexvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749824974; x=1781360974;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fw8m+7TdTp24J2v0w5wZmXW61zFUktn2P8Us6JIyHMI=;
  b=CVTQexvXxvrSEbeBu+/WgaxrNSbPCjy95vEHum7Hh7vJLRynr25CjtY3
   reoaisEnAWVccdply0rkQsGkSj2LFvnS8lduwYwjFgoIDKEXtUSVHEQfF
   rl+Mdo3mjk7f6h3k493qtWHwm+JfXh/6mXy06bJs4MVO2kicFVAmdillt
   fuiMwTogaeCsfApqxXZ/EE2FGz88F3l/wHUy5hLotZu5riG63xaheMAFw
   3PbKkSVqwQfWtstMdNX5gy10C0NNhhuCPfpNWU7UCv3LYXjtrsOJHlQdy
   6EUUkoWavQuiaxvrkUoFoWRB5/ayyA0Gid0ypxtCy8fJrYO6Ol3mipir6
   Q==;
X-CSE-ConnectionGUID: c1Yd3wpqQjuiJWVCnvMJag==
X-CSE-MsgGUID: QUmelyQATxSx753aDAFtCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52136556"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="52136556"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:29:33 -0700
X-CSE-ConnectionGUID: 3+JA9g0gTWaDYRXu1NQrTg==
X-CSE-MsgGUID: F6dGBt9rTfChpAmOFmB2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="153130556"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:29:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 07:29:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 07:29:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 07:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTJiUB0SmkJt541nmC19c8zOWYhZLgTRMBeT59Uv9ETQ0KDVOoyHKr4A8twe8C2EhNEjzAEFM/14QTbuhmKbB2OjSSved9nYj1zDAJUYzo8IvloGiWD22ARWt3hRANM+aRAUPt2IfqIwCqSMU/mkB7RCc7nnlOXHDMFh+N/pUN4gQzQcSEWJgBIEBrRFxO3AOgi6dugUPeByUeHrgeMWwf8as3A6jaYhZpfZgwOGyjRnp6bjJzx5PXOKiisJn8coLB1MwbfUyCBvlaGD5a5pjq/tT+8CsRds1YWE5eZo5xUhPjx73RHFbu/FEHgu55RlvF0SlKP582qqG140Hxm61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ep7Yeludjg8ij5LPYg5QcDUFMIRnZNqy5ZlVIKgbgk=;
 b=kZrKi1t9cJPz98jGIfMl6GmGAgquWEw8HyMWC/LkTgcWdmXk2rkEHWu4nmExweLG1PN0cEKd4dRn4zBBV3qWjDaurKuIpnNbnOubTKWH6MTlKKJoeBiVVlCpDSok0ubiG8eYdnlo6muvJqMawNgmIIgCSfOXaDyh/UFLIjcyOfyiTztk88FNpeHRRGenjVpjrFVxDFD+rbnFtl7PazdBvxP90FVlIrg8V41Xe2QxVyF2QhfgvZIbaYoGtdnWw532C/FAbejPUj7uc+6M8CITBYx2DH6G2CU9399Q87MMltb1asltnsqoMBv1lkXA7VMSTgyc7Rp/k36ArHuF5vkMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH3PPF7708D4D9D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 13 Jun
 2025 14:29:29 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 14:29:28 +0000
Date: Fri, 13 Jun 2025 09:30:40 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 1/1] cxl/edac: Fix potential memory leak issues
Message-ID: <684c361017c6b_2230d9294a2@iweiny-mobl.notmuch>
References: <20250613011648.102840-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613011648.102840-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH3PPF7708D4D9D:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbb8a18-8f55-4046-cb5a-08ddaa86b48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SkbiBfOXnRVpH8xj+CiqJHalsnKwPRs0Ts4j5EkwBOsIsPTTCSAiyFdw4ZqQ?=
 =?us-ascii?Q?Jw96CX/+sBV9NwoR7YMHWdKHVAG42l4lfxZxZxlB0+zsOF+KLFZSReYfqNdb?=
 =?us-ascii?Q?NBd/YYTbpIHEyhFIaztH13/9qrMF9RqlzdpULDn2LcJZcxL2nWOWbz5orVuQ?=
 =?us-ascii?Q?Ow+LOWfgm2i1H2OsjuCCx4JEE3bVYwzwdH1Vt+ByVUQUblLU6u87Dnfcgj/S?=
 =?us-ascii?Q?CN5elNg/sABct4NfTEIKuJGGR1k8Rw+24oKb0xuEZYG7Pgmf4spO0ed9Qoql?=
 =?us-ascii?Q?it4leqYyjYqwd9VBHPr+doO62hxOLUsh8dK1cfU3uFipkgaRQoIt2cIH/6TA?=
 =?us-ascii?Q?0ZQjnJCjzp8UYOLhsUh/HEG6+5IrNipwxzlcRicSRIcb/F4MRT2IXCqlK9PI?=
 =?us-ascii?Q?7sjTZCPh0LiksTlUkJbm2JvCpVAZd3U/PPMsZJEiAqxKaZ1722MSGbRJkh6M?=
 =?us-ascii?Q?x/Va2aOsktDU2svT0+cYxajNk0Il1g5uYGNEO2TT1HapSHgbAtHquNlWDp9W?=
 =?us-ascii?Q?9OVM9G0r3NmTx+M8qkIsDtKHo/+38pWm1ZmH1yd9YG+DsdIXWZM4zn0aoUwg?=
 =?us-ascii?Q?YJnsqLCz/Nz5BW1RvcORpeezSv5NBACJPgwbbxR6Xo6jvF6F7tb8ZvLRAyRw?=
 =?us-ascii?Q?awg0wgnAg37kqUX2j3B8FGw7xAFt4QCZ3bqA6db3NF+NCl4X61TcmxIysOa6?=
 =?us-ascii?Q?dRKm+xhIjzUfl9GakvWb7/G8cWmufdWl5w0iZfG1SUE7t5sknrkkOqfSzeo6?=
 =?us-ascii?Q?+CAotS37YwvrCCYPBGCwNeWKu0kaVQKS4K24oUTkPZpHIfKnZ+30ysR1hB6B?=
 =?us-ascii?Q?L/p9sHoA1A7R5CXgmKSicswP4d2g62lRJYHlmR/Po7ZKqSRcIVb9fkFDi7WD?=
 =?us-ascii?Q?I18ZR12pyiyeQIEuPYuJWhMmKC1jQC+SgakTqZ7qjXDrEoeNCbs5bjTM0TwS?=
 =?us-ascii?Q?tLSJHcqbZH+ZL1s7xJmBSjbvz28vOZ/MpZdNK66Bo9jOiFjjTmj1HcqmTvcx?=
 =?us-ascii?Q?zbsFhu45tzSzWeONJhb8D5aX637gxltAxEOguFmB1bJSqLDR9XOy8Plku3qr?=
 =?us-ascii?Q?xarwZOjUan1li/MmY4TkNhkyv9A5uBVMkHSLPD9F9+QwNiXLtCflU89PV84k?=
 =?us-ascii?Q?dUXlDVTgYJzB0tmG5VZjAVVMGL0Ie0oiGHdWSyZIo7YJY2+CRYzqt8cexBFu?=
 =?us-ascii?Q?NzPsJ+fJzogXJeDfrN6qtne3IarlEgquodgpWqTSweDLzBQ9bu2t8ilp0r7x?=
 =?us-ascii?Q?jAZQuuB+JUfH3egiNa9jqal5AnYw5LmI2UEKgjZnmk0fR593mek914BHy8p4?=
 =?us-ascii?Q?6sdwsHzePHD55iAIHTU55vEAL65Qatnb1p/QqTDQ+UimU3IL/pN7uXA0SHJI?=
 =?us-ascii?Q?J5M5uspiKUlgBTHnKqN7axOnTyNnaDf/PUXG7kFjdklirCFovpQ3Gqs7vu7g?=
 =?us-ascii?Q?DDuciCP9siE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Mb4SSX7z2tLKGiNUFGNvzbXGG5GMD3aOL2PsXTSxiWE644AnjqRbzIIU5mu?=
 =?us-ascii?Q?HH99N3MGfRsbRviVXAt1KA/D4sJXmJGmHLgb8jGy5rP5xCtgqiW+P2gN8OBZ?=
 =?us-ascii?Q?ybFaGdvv4e5ydVPGu/DRhgRCRle4AZa6XVPeFDugITdRBO+VfXrzWxryK6FS?=
 =?us-ascii?Q?phdymtZSTY/3VnflZ2vw8EW5pA61mOSAaeQA71C/sEEjnKhOG7zjq5sz/VPZ?=
 =?us-ascii?Q?EY/dtn9y9y2aUbtz+80VT1kgSBoFzLD4gNoD0SJXkCtckUmnkvMv9+4B+1ye?=
 =?us-ascii?Q?yh68biSXE1gBzu/O/sicpDYknKo9qEh95dK1OSCvTCrad9AdoVOUph61PUoz?=
 =?us-ascii?Q?jSt2l6AvaMwl6Uymj0BsMNdkaX1xljURs3mtgC/su6clvtfzIgQoSah+W7VW?=
 =?us-ascii?Q?HuidXWz63JqFDW9/pufuBIi6bHTzgmRyJrthK3CLqBo+eblTwTncAL674NZE?=
 =?us-ascii?Q?X7OtWUBIwzodRHcNKd6dCnWug+o3+ZrVWX6DKkFh1PeNP+8vot3wuhnC5TU2?=
 =?us-ascii?Q?ANxdk4CfTc6/RaGVQBasLEqJ5nmQhjuRvGHfOBZqIOIJteg1RGx8c5W4Xiz0?=
 =?us-ascii?Q?7mqcBUrXJv3/lntwU9NSZsk3G+xO89pz+uY5R2AiGaEgd+rnC4gDxPYMAB+V?=
 =?us-ascii?Q?OieHLfPMvmVO/LLqLl9FhNhb/OoZe3VK2+blGX8pt9Is+dXxiYVti0R8k+zB?=
 =?us-ascii?Q?PAZ0lMU8G/mrzoY5ZLBdkRCDZXe6muI3d3B1dNdaExlefo8e+QO6J/isqwot?=
 =?us-ascii?Q?hdS+LXC1cFWUpZc2UZCK2BFzaz1yp7mhWj6ymPACqbl4XpWP9Meou/GZPASe?=
 =?us-ascii?Q?8XzanD7HIvAVXigYUky9yv7w1SnoZDzUfvAlzuIqTbEyx01gUY+bo8XsGql4?=
 =?us-ascii?Q?S6Y287quDHOaba/sX0zMahd43zA9Pg17B3IdIVTKWUKhMUKBLOaVNJfRymZH?=
 =?us-ascii?Q?YjJ/aVK1FKXFgDpn23rQUrOW1KAmOsN+VAPBDD6pCwV1Pgo2h5pRatNAQZVA?=
 =?us-ascii?Q?fCPZlVFEF7EDfLuKjJMXNg9PxX7N9iGvf8nJzbQMj43ik7sItovIGO8pl5xE?=
 =?us-ascii?Q?LcZ78+zR1lCtcpg5MayZdPZDydVub5rRltcZwQJLdwixea+mi3XjDce445dj?=
 =?us-ascii?Q?Tq6V7A2Dm583iaf/bJGSC46MJEHIEDJdItmi1fHToGKE3tC6qjHZsDXrThab?=
 =?us-ascii?Q?kXxBx0NsY2ZQQ2kp9sc/JhuW/CNQKKMlPWtbfapIaRZ1m3Mbhwgipw/p+gUd?=
 =?us-ascii?Q?Q8BiUel6i5P/eU5+IMQ+z+0V5VunS0phnAfBM7FuHT4GKrIdiH8gDZjdWsaK?=
 =?us-ascii?Q?qlkOOtG8DeM8gY+D0gUrumJtRIYKMXHbHyQeEzV+n9ZmHCV9Q26HVMMz268v?=
 =?us-ascii?Q?YXuObPTvg8o9fh9Az4EpjfwWC7FJ9b+SQXz0nTbSL3rEfsje1hgTrDBlKrhJ?=
 =?us-ascii?Q?KNnSp9nm1SMTjY6wsEL245JmtzWojW4i9bZFI4d+u8JD5wLDuu0cDCUaIFR9?=
 =?us-ascii?Q?cYPmSjmhe8E4pfWMi1xP4VPNfK0UMFXw0ptKbKDQtJ6odZUdopyKo9Summhd?=
 =?us-ascii?Q?8+vkW9NsScOOrF4bn5d71bgMcT9zs21bRRxMGie0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbb8a18-8f55-4046-cb5a-08ddaa86b48c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:29:28.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqR8Pd3eEpMcUXFMXN5Eo5mSLMS7ARKdn0pp6ZFre06zvaBRuVEsQYNcXwaa4DPJ4FOaVnN8T3q96lJaXcoWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
X-OriginatorOrg: intel.com

Li Ming wrote:
> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
> duplicate a cxl gen_media/dram event to store the event in a xarray by
> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
> be freed in the case that the xa_store() fails.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
