Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06B16EBE8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563449; cv=fail; b=NLq0/p6OdaadlJNJSLzhYba0o0kEmhzdOpn/vUbTcFNZjdbrqM0M+gpBmr9NhGRUX3+tZP4ZorV+PGdTNHFW5tIfkURJdaoWWG3VwLWOgogvJhufaYRAwiDURdGRjxKYUcn0U0bf4M7dzl/Ej9tU4eYOUX0w2s9QTkmPGjvOuj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563449; c=relaxed/simple;
	bh=iQlu283CTjWpBwp/hg0DuRmeOL+q6f5BQ/EHwrRrHzk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CNFbupCDIyH2VvKdFWQUACVGyEKA/ee+nofdLbWmKiAefrTmDeiNnti32Vbt6iKvlIOwbvmKrVqKmucUrnej44MgywxjsgVm7s/LJWa0KVkOkwE5+SeQpF7nyudTBMouBf7pZYbRltA+9dEOUuce6t5hO6WhFcLJwiYp6lSU6mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFqvNECW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFqvNECW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737563448; x=1769099448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iQlu283CTjWpBwp/hg0DuRmeOL+q6f5BQ/EHwrRrHzk=;
  b=DFqvNECWROpIiUhywfRQ+VoSqw9WyBhT/BquduxGN3833fBrkrFhneUX
   4zMtgsGvXy8f26vjQlug/jgRt0d/czrqXSuMO+8njA6L9uX+zhfmUX/LT
   ORJ4nSUJ8n+Nfd0TE+Q7ATncvYTXJ/4yuV9hWggYb7/5GPXtj0VRl9TB2
   k4vBKcqqo86HkoR7iHgT9Bx4Qoscmo59OoZ4SQvhQfRC0+DLSJsmrGWJ+
   XI+SeD6B5Gza8+AgGU5TcjsCHLX9gjr4+XaJNUtwfk4hunquhwf+MCcfE
   vFn6LS31uftqNfCIZt0T921SkLkyRQ04JW+YpNN1sx8+SxwhCHR28NBtn
   g==;
X-CSE-ConnectionGUID: h3MjiEn/TBqPPqiEu8JmUQ==
X-CSE-MsgGUID: ufVK1HObTU2dgFgLREHBCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48524106"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="48524106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 08:30:46 -0800
X-CSE-ConnectionGUID: mI+zyVLBTO2y69Wrg8aVMg==
X-CSE-MsgGUID: F1P29HHaSj24Km4LI94ENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="112213154"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 08:30:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 08:30:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 08:30:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 08:30:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeOV6uHqCB1oGw5dwQFwVFMUcAD99LLkOY+Iv2sPSX4RMdFYTWqAuV13mvhq6h+AbfVQBkgMpbTgYsg8u3Dl2CW+j62a9SDOpRBHZ5EtQhkUNkAHSN1AbxAwJ9odIDvkFTPpfSmehIrUoAKUuNgerozQtll9vJ4kBfDMWex2ojvIyzIBkV+m7rM04rnuXy/xCKtGNyixSpAjF7V0c/Ko0MSKX3abDklFtEG8Me+On+BAK/tvm6cJagjoAR0+49b2Td2yz4wpfIWbQ5Ub4VjseT7pqJLYvtADriPWkqi0Uoih0/1G/Zvl5tLR3/l1gdEn574PJC2S9BnswOLKLKj4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br8oHlcU5S6yMexwxncOBIBHSBWMjNftfdPK1LNLl/k=;
 b=fw4LMC6Ax10rHg7PBsHSC5ymUI7CsC6GXXcR5CUeZSPeJcJG7vxlwcTEYj54wE+wApBpC0uxDfkMRub7vrLDD3BLod9xTUtz8GosmyzRovpgLSzAWgPcKfhpqLf5K7cFM7fiAoF/ZqhevK+0KFkPdW0s6Ln7u4wqB+0qYeHFH+M5dLWCHoECeuqXmz1l1GvgALw8mSTgRleM26CjmPXOLxUVBggpn0267G1S3wetfz7yqF6b1q/+ORM5vjP8o+GD28ErYbRQqRlHnYvxmHq7kzIbsIcYDYDPVFO0NE6wcZ6ib3OSDoczIgxZ0/mJtE4tgFzlueMo+6/W124QdyHDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB8045.namprd11.prod.outlook.com (2603:10b6:806:2fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 16:30:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 16:30:02 +0000
Date: Wed, 22 Jan 2025 10:29:57 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <67911d0578ce9_1eafc29428@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: fa99eb5d-5de1-4eee-6e90-08dd3b020546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rp/B59Zquvri1z7ByWq7G5DHudRI0blDGqJJ6QHVBvfVi9EDMXZFGx8cGI/M?=
 =?us-ascii?Q?4wJNR8+9rrqsMGVSyt8G3fMTopqPxeldmAOnaZ7QDRjKcAapJ2xiIf/yfU2A?=
 =?us-ascii?Q?/+F+E7IQ9lPAXAIFqCZdCiFDPb5sMfKLpJhovmTMQOhpXcajr2lTvZuclPTo?=
 =?us-ascii?Q?PnXc7Wm/Lgw1aMTAaYe8PCcEodz/LJV4G5Oru6h8WK9Gr5MBl+B2kDApkbi+?=
 =?us-ascii?Q?PXZ3Km4iuWie5d0LN3C77iIqmhVjH7upujCt7QPoyMovKe2RhQf61RwrJqO3?=
 =?us-ascii?Q?yi4+aQ/Rq08sNaR9ZQTPwmHoybbpDI3i1EbXiyFS9NyEOVCisk/hu9WZ3GxU?=
 =?us-ascii?Q?TfRGY9ou0Ao/OHT01emBrZpQthUQDTDnuMjY2CbVvtQuEhAU9VtpNyweEPet?=
 =?us-ascii?Q?yHWlrMGOWDP049xAKq1mm29C9vG3eOuVA9fTvRaMiaW1e0e4Yb+1H86Q7cZC?=
 =?us-ascii?Q?/Mty5joePAdkDD6h4P1RMvQvwL1k4WwurGrL+6oxv/uDja9yTeKqte7qxxf/?=
 =?us-ascii?Q?MgfbRlPjUoQR/Kna1KltMsOsWh7CNo8fusdJGzhqm75qGDmlN3NPijgGTvJi?=
 =?us-ascii?Q?FeU1fOnQA5GYcp4KNBzfiJfGk2jImrKVY9eO9uYqwUU63E033aRvDXehRKNt?=
 =?us-ascii?Q?vwfrwre4ggjaKoT2ltAhNvbC5s5blUf21PBgfQ2fBggRDzyCJiYJ/D52g07G?=
 =?us-ascii?Q?ZBMrKcrrpKgm8I9us40mfy02yIk/4WlivwMYYhKyE+luYxcMRWRCMNSQwLE+?=
 =?us-ascii?Q?bit4cC4BccTS8NZxLtVK4KwWPjuqn9Qd9LnvoQCjbzhy7flYxxZ6j6Qy2kUx?=
 =?us-ascii?Q?mu8s5mYeTxK4BALir8y0SDK1U+ik8x2X7itvL5rH8x8VWYtCWvHgk13vgj9W?=
 =?us-ascii?Q?OqSQ1xsZMmskvwiF3W7UR7V4uz7iIM79TMxRCIe7npF+SXTVki8CL8ZRX6oX?=
 =?us-ascii?Q?qlOMckFVJFgm5r9dTzVNQI1WePz4fidwJMu9PKVA3LtciOfn74SwBIy7k78I?=
 =?us-ascii?Q?LU7LcyiHRpamPmrNezX3tHGRlEvc/XqTWrOLCwNGgzufqupAF3kbfAFTHRHa?=
 =?us-ascii?Q?sWf9CujJuHBQL2FX2Jj4sf2pjXEwPzzC10KWzaeBRvgMla46Yx8o5Q43ZEb5?=
 =?us-ascii?Q?MGLLvFzrBex8JdkMPlB6iJpryp6cDCyEnDwSuIzjXkaeuaN7RrEejaivN6Cf?=
 =?us-ascii?Q?gwPo0DTTIXRKWr/TvKBrH5WUTq2fhL8AMH6fGJhtMFLg79l/8aRnHqSGpAE7?=
 =?us-ascii?Q?ccYSYwSjao/YFa1/7vtnNXk6baOr3gVxJUpWaeM4B/L9651JpxKwM6waxVuF?=
 =?us-ascii?Q?CxBHC276FmC4ZNoOtqHkoLQM2FCtc08fKX50mxuU0LNS1etcuI19zjGbJkbT?=
 =?us-ascii?Q?H65MbsKziANNGcTUhdWZkS5wZtUM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+qzV6LffAvk/jTC+OQrmRZwHGXkitNpmOnwGjgEzWJU2OeGR6vA0FYtU+tA?=
 =?us-ascii?Q?8lC6YKiIGpxnDnSPXvdGNJSyNfbW9D+hlFLg0jcRmowIhGI/HyXKYbP8gy3a?=
 =?us-ascii?Q?IejHvc8fVEs0Al/EXKdjwY+NA7aThVf0HM7bZGlWuVZjpkJzwvqtDR1oX429?=
 =?us-ascii?Q?Wx7OssRVTdmp6uiTVXGAiIk9u9ogx1Q4dgxBUROJKiY7Mz+U1hROzfAOaHvQ?=
 =?us-ascii?Q?ekXaYANTwmNuqyHJ6vEPfKMa0YFYJDjoYvKz1iwvbNXPvNLgPQmU4lzZRT8x?=
 =?us-ascii?Q?hG9u6A7eTpDD4HrwaebWQC4GBhIkmezL9cLuRZuP7dOANnJorily95z8j+L/?=
 =?us-ascii?Q?89L48joTEdxJwwKLkyYiBA8gEStON5F6O/JzFnbUcdSfTohpupYHOS8s5y5X?=
 =?us-ascii?Q?IgSfAA4BG7qA4QkmvGc4rWrzsesnawayqFXA6PGxQciRhffD3w5MNkPhOPjs?=
 =?us-ascii?Q?DGqXXwMS4t6KPS22xsH/ItYipMW1QIc2+LsbVs8kLeJX3pxTSO8BM+hdECGS?=
 =?us-ascii?Q?b+cqUuT2ePng4BmypafkVR+/lfPybAsF8XrvfFoWSUePQ1XT+sNurr5+CBNs?=
 =?us-ascii?Q?6f5qHX8mXUZiZCsCQb4vGckwFS1irj5kv2DOnts9PEdEGInLCnYsX5Nz6TqY?=
 =?us-ascii?Q?luwSnubwsnLFOxYgmx/4zcgfV2SPX1wt7SQLxhqsMSpmG8zDZfXY9ohqCp4n?=
 =?us-ascii?Q?/Zp02ZoHkp0Qi4B7Cyd1A31fJjIoFDuVjNSXrFswahEVnafoxYbtLbqhhiEh?=
 =?us-ascii?Q?ZOI306dWDlGkEsAtznBygYqKsDGzMaQnWdSqvmHBABiCMJpF22mOXdTNg8aR?=
 =?us-ascii?Q?3iUxDuIe8W6tpKuVBSySCXOHYWmumU7fk3DHkMNbir09dTmSvPuGgv0UwczL?=
 =?us-ascii?Q?rrZ3pp6HLgGROqRn7h/sr87XzKEN2GqRcvG/j2eThjzFZfbV9Nnu//E+c+5d?=
 =?us-ascii?Q?5UODUHVI6LqL4uRDpq/UcJyaouCNV9UG/UpBRHQtoumZxHcm/V+DKE4vEO71?=
 =?us-ascii?Q?KHQ+juFk/ew7KlAVOtqwoi7lhu/h48yj5O3BddSrqN49OUrjEUSHG3Ktmn1N?=
 =?us-ascii?Q?nh5VY268B+Tb1e2JvTWWFCnVrlP4+31pJU9fMw20q2WqpGthInY/Dr/0/JHa?=
 =?us-ascii?Q?ox0W1nTl+U0dpFfexneq1pdvRvWaVchgDv+xpgHmZPG/i9l8TLOF1xKrGARc?=
 =?us-ascii?Q?sBgJZVg/lRMjY6H9BHU8IkTnzVWRiTAwtKSONSLejsRkavZJ2YQgFN4kWsfA?=
 =?us-ascii?Q?3pIBCIBA0+V8EZu3RlUBn8wO1LzxQrzCe2foepWyJhSLw0VYq4oFk4mhD+xz?=
 =?us-ascii?Q?wZu4QfAIn2JlefxoxGGA85jItXlOxYVY0pl933LjCe6ICqEbK+GOt9Zv0gMX?=
 =?us-ascii?Q?rZGtdSaeIQz2+sJzkzsLel3P8nV8eS+KVQfoNbhmL8m7bZSc+6KHk1RzhxM5?=
 =?us-ascii?Q?7P2eesV+PPnY4T1RDgVE/zHnsVISEmwduROr1A4LZo6JcdWLJ8KytyXMWi6i?=
 =?us-ascii?Q?jH8SqW9WO9LhxOf9GzjTUANUniO5afsWL/qeyW8vwy0H42/E9U1DbgUp9J7q?=
 =?us-ascii?Q?+3+hdSmaHPPizBtpAmLpUoZiQVOS/Ch1SeBFuM4a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99eb5d-5de1-4eee-6e90-08dd3b020546
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:30:02.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzDVHNP8h57u1GS7WliHXcij1jSlkq/156TuENqIZ5iVq9Kq2UcKC9rFeYLorqJv3EVElCMqsyehl4U8+NgFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8045
X-OriginatorOrg: intel.com

Dan Williams wrote:
> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> allocations being distinct from RAM allocations in specific ways when in
> practice the allocation rules are only relative to DPA partition index.
> 
> The rules for cxl_dpa_alloc() are:
> 
> - allocations can only come from 1 partition
> 
> - if allocating at partition-index-N, all free space in partitions less
>   than partition-index-N must be skipped over

I think this is a bit deeper.  The partition index must also correspond to
the DPA order.  The DCD code verifies the partition index's are in DPA
order when reading them from the device.  Therefore, that code will add
them to cxl_dpa_info in order.  But general device driver writers may miss
this point.

[snip]

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3f8a54ca4624..591aeb26c9e1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>  
> +/* See request_skip() kernel-doc */
> +static void release_skip(struct cxl_dev_state *cxlds,
> +			 const resource_size_t skip_base,
> +			 const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		resource_size_t skip_end, skip_size;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +
> +		if (!skip_rem)
> +			break;
> +	}
> +}
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -241,7 +266,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	skip_start = res->start - cxled->skip;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
>  	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
> @@ -268,6 +293,79 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +/**
> + * request_skip() - Track DPA 'skip' in @cxlds->dpa_res resource tree
> + * @cxlds: CXL.mem device context that parents @cxled
> + * @cxled: Endpoint decoder establishing new allocation that skips lower DPA
> + * @skip_base: DPA < start of new DPA allocation (DPAnew)
> + * @skip_len: @skip_base + @skip_len == DPAnew
> + *
> + * DPA 'skip' arises from out-of-sequence DPA allocation events relative
> + * to free capacity across multiple partitions. It is a wasteful event
> + * as usable DPA gets thrown away, but if a deployment has, for example,
> + * a dual RAM+PMEM device, wants to use PMEM, and has unallocated RAM
> + * DPA, the free RAM DPA must be sacrificed to start allocating PMEM.
> + * See third "Implementation Note" in CXL 3.1 8.2.4.19.13 "Decoder
> + * Protection" for more details.

I think this is a great comment here.

> + *
> + * A 'skip' always covers the last allocated DPA in a previous partition
> + * to the start of the current partition to allocate.  Allocations never
> + * start in the middle of a partition, and allocations are always
> + * de-allocated in reverse order (see cxl_dpa_free(), or natural devm
> + * unwind order from forced in-order allocation).
> + *
> + * If @cxlds->nr_partitions was guaranteed to be <= 2 then the 'skip'
> + * would always be contained to a single partition. Given
> + * @cxlds->nr_partitions may be > 2 it results in cases where the 'skip'
> + * might span "tail capacity of partition[0], all of partition[1], ...,
> + * all of partition[N-1]" to support allocating from partition[N]. That
> + * in turn interacts with the partition 'struct resource' boundaries
> + * within @cxlds->dpa_res whereby 'skip' requests need to be divided by
> + * partition. I.e. this is a quirk of using a 'struct resource' tree to
> + * detect range conflicts while also tracking partition boundaries in
> + * @cxlds->dpa_res.

Another great comment but it does not actually cover the DCD case.  This
is because in DCD the partitions might also have skips between them.

That said the update should come with DCD or if type 2 devices may have
the same loosening of device partitions.

This is a good clean up though,

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
