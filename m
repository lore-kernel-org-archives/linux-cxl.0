Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3119B3EC
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139537; cv=fail; b=qYGXCLKAI3mTbLhbFkj8UrUZFsiyqzWcoCxmRYhT9koWmwU45tZboKOiVPa1eNLNfmaDoG4uxY8ZoGBNR45dXBHm5XQzE0qKp44USF7L4D++iFCEA7gqFWcCmdD9ppiJSPen9bDRTd6wXfCWZmrYrbvYPuZSIjRwUllQB62vz9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139537; c=relaxed/simple;
	bh=3uqDUUseyh6XlJMxh1+dbRLEeezJ4KL0KNIWPCFL8H0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EczJ9zOEudb8yj8JMVXhJBYRDpH3W2k6DPs4ghMlpKkHDITOyWSwoTSjqwco7gODEq6IDLWRK6OEOc9kzjv6RadQuzV3oqIu3tuteI0FjMu5dTLeTcHo40iTZ+O/XE4jpFXNkwUcajF07f717T9sf5XXuO8ykigkWBJPncMFFtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MT5HxB9S; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MT5HxB9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737139536; x=1768675536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3uqDUUseyh6XlJMxh1+dbRLEeezJ4KL0KNIWPCFL8H0=;
  b=MT5HxB9S7jrvlzWkMbPB8L2jKP/p9uWsprmuM0FzXYZyTz59zhMhdN+1
   EiKPxtzLoBBGRb4uJrFIRYc0x/adVClExxlbSfQKnvoPZnhh5R/qSjaXg
   3COH0rWI1YtiOY/AqSSn18MlOk+YZtPytuA7HOJhdz9kZzS1G+afwOrB9
   XN38uUsQPrA27KQlbBhy0JUmWltUSvpi/BYvP1mwxotvNMTBdoXY11ZZ0
   TmLyQUzq2dYWUN6Ff70q4dbq/SVHis8HDrst6f34s08y8LNx7B8bg64zI
   dFDb7RGfnVoSHt7uCjsx7oX+eQJ/A0Whzz6Eb1DiSntfiLRj/FRe/7lkR
   w==;
X-CSE-ConnectionGUID: vujygM+cTpqXiQvLaXP3MQ==
X-CSE-MsgGUID: W/eOnWGxRV+B85Y95mIPJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37463908"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37463908"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:45:33 -0800
X-CSE-ConnectionGUID: AzNcwj3qScKQLR7O1310Ng==
X-CSE-MsgGUID: D9imJjRPS8y2dmvA1Z0TOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105675709"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:45:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:45:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:45:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:45:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7BxtZk1E7x7Hz7wMrjCURwc3q/ZT/78sc6D3YX3QSA3iw+ziHSQstbGod/idQZdSz7S0KFMlSOxpuTJ2Kkv9WYlIztcCtuBf+PfzJQnWXfnWUNn1knwEeRtFJX5KOjaqhXaXd0FrKniNsEYeTLF//QE8GO9aeziUWn21boDgiX8SDCzNpdHkeuoiispZbUPiYQjCOKCXhN4TJxSIesWpHP+lpPsQrXrWlG1aUrMExFC80KFLJPQgUiUjsQxM8xfwWvM+kVrcFHOFTy+2u25FxSiKXiHCYx2Z4k700GaKudDStYWltCZYNPc1sU9/Wvp43rppb3gEYQ72l3ngJjEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWmFQKk7BCxSEYAWbwy0Be3soYh4Cuw6iqQY6hWjk2I=;
 b=TdVoLfracHZZjdS+LWOGUVBtlmR+697qIh6DWZfovM7vTsyuArJL1ck6hnQldfpUCXJGoBn56OC4u5rXKsSw9l6s5F2WGuR+W+o9FIIO23JjQJvgmwkajXaUVr1jQgSjqEKQypYpkxmUqhKEyZU3xY957RJ1owhGzcCOEeyfcj//qxrg5lbkJlZbSyzQLVg1tLnAVVEb99NXPq/ZTv6t9DOs7sTH97KeDqBi8b+AtlIiGuvJN6O8dYMzJzWY2Gt9fA3szmivo/X1Y1KumXcknSXUlWC6sh5VkQMae6Nc4pjPE6jwFlqc4thJMF4Xc2dMo/27ypKPwY/TWnqWeb1LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 18:45:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 18:45:29 +0000
Date: Fri, 17 Jan 2025 12:45:26 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <678aa5466bca7_1f0d81294d9@iweiny-mobl.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 562cbcb3-df05-4720-8b24-08dd37271d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YinrSxA9bmtcpeaFwlO53SrBMkTBlH2ir6NWKZNO6x+rMwBwvQWeQcI3qvfR?=
 =?us-ascii?Q?1ZErF9EwqpWf5PpOAIYzNwt9Uxc8ZgheIZYI2mBdayd7oaGQHDKnhiGQuqOe?=
 =?us-ascii?Q?4A8HxAiT5yaBXC1cm40jYl0r/it+j+EYfBDJxhwm7W8iwhPWhKeeaIIPFoDu?=
 =?us-ascii?Q?sU8BCoU6kWiZU/3noGDJYBtldWvuQ4rhrTegLcWdDLjceddJW0FUp7wOkLc5?=
 =?us-ascii?Q?W087K0AXkBiHaMvg6VNlFY9EHczDT5bjIlcKG4jRJLG3Wh9jIGOBCBHIEB00?=
 =?us-ascii?Q?/Coq2jiCqoIbyuml6dnsB6UShhAM7h7+askqJ9Ve8HZv/inRPUU24DIPv65e?=
 =?us-ascii?Q?U+ONvQQyP8km507txwf1TMLIztP66DJ1/8+wJmD4Q3icOGYnMtgdCCI/7vyM?=
 =?us-ascii?Q?VAyFftwLqwv1/A46+e6fLh7P8iTUGcbgfJfoyYNllhONSwE2j4dL+FzBGk0l?=
 =?us-ascii?Q?eIDramYmt9C+S89defMpYsZQSFko/r0wMugDOSu6MR9QB8NjD2bmgT7I7JWD?=
 =?us-ascii?Q?XmVF/L96RJgBQBG2QckhyuGAItO395zjngRuJdc4mZYWSEhO6+6x50bN5SCF?=
 =?us-ascii?Q?t3nI6g4LnS09QdkgI9cEfMRsTjWdFi7KaVMqWrcGa+on9tNCTyQ/8yO/a98d?=
 =?us-ascii?Q?W1R47tUa83AZ/I1foGeDbe3TuA7tH8k1RhJt2Gnr58Fsjw67UW7XcpAL/UJe?=
 =?us-ascii?Q?6xOMgktg2VLeNYpDgI0C4PgcF/OSel5WVCxZ87v3tVWMHpZG7/KzCprvPFcr?=
 =?us-ascii?Q?7gEU+mrkdy00FUpp0bpK+wbzgVk5nx7tkweChbnT0helw32di/UDjfryeI4u?=
 =?us-ascii?Q?zTeT38NhZ9bTxmqNzr4ehE5fWr3yJmRQooCMmRL7aAcipZyaCxnQIQ8G5q38?=
 =?us-ascii?Q?o/WKQXtYv8iIh5sN5E1rZarLH8UVon2+1MJZm4jFWQ2B+ompklhGQGnKS3dY?=
 =?us-ascii?Q?ywb161JoIdVN9zK59wHNo7ITNJluieDe72lbLPQsy9G0udh0ZNf40gp5BmYs?=
 =?us-ascii?Q?jsh58MoND+F5o+z4hOan3gviGluRCH0utqbqPvXHwrwNdZHvtvzXzzgaj62F?=
 =?us-ascii?Q?m13fhyGfRe5+wgTKmwldYuOAy7Wi8NKZXy7F5ajN7r91cjm3cE7EkfQbdiIy?=
 =?us-ascii?Q?0yjxBqE7J2xcbcIHoqXXhOKKCmR9wS7ORVk2cqcfglwA9ZIKP/5NR22lkWtK?=
 =?us-ascii?Q?UmeOpEKfpH0giNGFRsJdhHF0OX/NiiJ5oPfcZDaD1Iic9b6UJfOxn7x56+SW?=
 =?us-ascii?Q?UUXpDpv7GWjD/mtub/URfC1H5NgceT+hX4v69svuXwb6rAGJcFiZQ/N9zLwJ?=
 =?us-ascii?Q?J+hMBsw9k4xprZkBNJrR2GcEguIcCIT/phlHyRPs3w+UOvVSgVnNMuMjhTVG?=
 =?us-ascii?Q?74lts+GnOS0onDSiHmrRmEQ3vx54?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnXKN9GoILN3CleOGQyfsdzyn+60fGQQT/7/7PlpMVtDDUf6kyQvMllhZF39?=
 =?us-ascii?Q?LcI3bTMVpBfFUoDbgKhHBWsZeyKaOsnSysm83Xx9W23tQCjnBhE+ZZTQdgUX?=
 =?us-ascii?Q?N3GmLaGIn5PaGSLocFfrwEngyqVIz4MJypPJhuIbc/KVILr8/nRDS8VDbsyx?=
 =?us-ascii?Q?7oGMAVafe1jAhWe0qm2+zoEFIO5BZ+GWxLcr0T8Aql/PtgpO+NdO0K8FnUgp?=
 =?us-ascii?Q?kope/T8mAfR8rouJKeqhPcbOmt4WMABVWVS/ewyjs/6v9tYpUB3hseIqnD7A?=
 =?us-ascii?Q?R+agzms2GxsKdrhJuaLUxjIYheHA+fD1FX6BTW8gM1uvLE40Na4dRNOCWk9e?=
 =?us-ascii?Q?rovfDAVVQa8nXPKk6O3PyOHvt3N5Zcrjs9YlwMXedse038SIociBrzd+WTD+?=
 =?us-ascii?Q?psnUzvnNyQv76//YhG47amUM8rl1usbM1SJ9V1fNry2POU+3a5mrmFYDpHSg?=
 =?us-ascii?Q?3EuDgO7nGHnBJgiMoEkO4xa8LWdaE3gNY1KQ3PJKZiv40LylnCFMvXHpZDZg?=
 =?us-ascii?Q?U/jCbedjn4l1NyAzQ+3rYZxkBE23LLQfXD9AGCjiTqPIHXm4BY+d1jhBXOWu?=
 =?us-ascii?Q?KmSutlbvWhcCVevSaxngj4kpxj8Y7cS/6N8J2vAYLq/fghBafz33ymvUC8nu?=
 =?us-ascii?Q?VRy4l4MQIraEwnAzmn+mHi5lN0gOKmUYlGHwv9Q/wy1KkVmxA2m/WFvzNYpq?=
 =?us-ascii?Q?3x6EDbhBpMF64cTbm12RB1nROtZjEHGbcvkIVLl6v64wU9sZroAeq8XSWvr0?=
 =?us-ascii?Q?+NUNvSvFe9r6Qa1s59dwO+q2bqBAQPljpBqMIdNbs2qGJf+c4WGLjCd6lHvc?=
 =?us-ascii?Q?eQdTOukSMaqfRyJmY1s1izA5NRZgk49EUklLkzv9X2IA6YRJFtRuFUR2pg1A?=
 =?us-ascii?Q?5nNvSb7E5XXsng3hGzuTTeokRD0JzjFERRN8DGSx2g8GC2kx6el8zkoEWOLO?=
 =?us-ascii?Q?1SR9FQ7q4qzfleOuwLO3onTAuAo6ucNWd2NLR2ppeVCWBuSY1B97yiZBgNFo?=
 =?us-ascii?Q?9ACYepNXZ/EZ8jyV0xmD5Z9Ze8JiRwS+S0QLA03LozwPnpcSgp842UcPKlyX?=
 =?us-ascii?Q?JIqS7ANGf4xtf2KpjY+8mO0QctWuq+M9d8D5R/2OXMO3Tomf4meMnbWXFWnK?=
 =?us-ascii?Q?TlkVLQCvIctILhAGRcKPx8A0nmZsemjYFVkXw9TfWzfIFfxjgBZd2mL52pe3?=
 =?us-ascii?Q?kFmd3S4ImhVfCml/vpBeLPHiD4uqnLsUIZaxKpBBpNR/FivqFILHmMPKPaxm?=
 =?us-ascii?Q?I7SXiv1dB/EP9lf/Tj7t7D2XuKVgIIHHsJpKtkJsXrtzvDm48M/yWZy2Cqgl?=
 =?us-ascii?Q?tf0w0asyCihRIqOpOt0gPEoil5YKjgHfZVybl2G7T+JpYkmfX7L8DmEO2sOa?=
 =?us-ascii?Q?R3orhxUhK/xmm1yhFU0ZQDFV4g9y6VG8xT5Eg3T4uJHYkTEdFUntxCWn7swR?=
 =?us-ascii?Q?dSfatKWBIhvBpyIpdi5Qsk4dIb/FmExl9HjIr48I/JAdGk6BJJD2b+GyTXLT?=
 =?us-ascii?Q?SZxeg3/SmC7hg0wlWS3HbOqhd2YUs9ZKXdtTetFdle4oftCWF0cyfMUF2mwp?=
 =?us-ascii?Q?v/i5Nhfgk8RamrqmnK2UJ1GkPiIvw4k2G4mr1dpw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 562cbcb3-df05-4720-8b24-08dd37271d65
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:45:29.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/EXqzpKQi5kv1+9PrSWAuYKQLn3/otxlKsFjQHyT4WMSMQr44u4pjU77Zj4/TYdl9PcjU8q4Xg2GK5sDXCACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
