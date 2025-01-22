Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999561C1F1F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557656; cv=fail; b=l+sXimIavQ+oPKchtn9PC6oW6vfUaKbaZjXTl0V0WZsQgTArWRbXQxQhAsoxTF5utHFMpeY4VYZijDVW5cCa4ib+N0Ihv61sXa2L+zZNkffHdfeJD3RQFJhbIEKhomJhHazC6P0PBtC8xT9ksgXiVT2vLuuMvFhM0c1iYJ9f4dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557656; c=relaxed/simple;
	bh=nsnpUP/hgLyCTKlnnqR4MkUYiGUQO5KKhm3M5iAC9oM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIHK1UoRkzQUaJ6SBA8Q8hlFQ9e0gTI1BdOekhvgefzEaiEfQ2WyD/eg25YoXWf+nXlSuPX7GjkPzJZW8iM5c9bv5EnDxmh7SU4x+pNqUSC91M7Nztweq2hF38WMXZwe+L9OALY18v2w+WsgXxnhujgpz2StB87d16gbFRIx8cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lbes0DXQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lbes0DXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737557655; x=1769093655;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nsnpUP/hgLyCTKlnnqR4MkUYiGUQO5KKhm3M5iAC9oM=;
  b=Lbes0DXQsCjdfQ/BLOGTOJ8qN8mzZ/nww5C72S0cov7yi5oTPCJ/R22A
   vrYysmu3VkFuC/ezq8puLc4yJYYnAlDjkpp1LV23W67LsIdgW3LFMFgJJ
   5oZuczK6xWuzLYKzaZljl61WH6XMNDhLzt6fg7y8TDIsm0iivDjP4nKlL
   sZUV2NOgnDTm2wPPWkJbBuIdzKRT3+ZfIEgECAlqHpy7UBxRgwTzUaRo6
   n+3cQUShYAfLjRggfK+Wmb9Bx/ZDzUg4DLUbmF9bWVSkJLcEFnb+09W0u
   Sf6O3X4bTF8EfkoFszZ8UJkT62L4AcEarHUwMq+RFjQgU3UxhhvQ0/kn1
   Q==;
X-CSE-ConnectionGUID: EpZjCgB3SBStMP6h+D3tHQ==
X-CSE-MsgGUID: EBL+eUF+T+6LSnVthJnwEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="40837895"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="40837895"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 06:54:14 -0800
X-CSE-ConnectionGUID: 2gsGZ+mNRP+23x49ceHDiw==
X-CSE-MsgGUID: nWR+ucoZSu6uheHaCDMDjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="107269993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 06:54:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 06:53:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 06:53:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 06:53:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLnuLpIwFpOa+RAoOmUWRxRSDiX4JArnXAxBD3bvZvU5lbQqY53sCDj3nmx9iNxAlOyrBr3ZvGop1QZI+E4vbzkzj2L/lcPS3OtNi347bjeBifoD8FNRf80eacve15xx966Wz/0lVXvjgB0BBmqO7JhtJZB04cbcs31ejbkwQs/h2xInfbLpW2LgfzoLjBz06ld8OCETLqYtLHK5zsPv4895NVAYFtS/AAPAvUteqYrLNCVsbga+X8HbyQLz+Lz6LA5XbekC19xMwr8P6iXTuE7tlrZEyE/lby5FM03X02JOcqcJ58mw03yKOBXpbuJO0+mJTSBRUuFKYNLoETk6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v2wDleADTQFYZf/nrUJR4RbK6/N8BXtpEAQo3imXkc=;
 b=Hsqq55H/OsYQvnc4uwiWyeCWo+r6BhBN2SFToYyoYIMPhJT/4ewYSp2YessP2O6xxSdcpiLlffqDilV+2JR1cV5pk8R66R+L+ZXhPQ0ezlW2Wy+yY7UNtMS4Lh7oRJTWGgX8sCM4St5QTxRw6fw5Z9/FYFXyoJbXNPKqRW/YYMgPguSHqkiDLBMGmDT1kZpII3YUjnStNkJzmaiH9fdlRYFjqyngwZjuQQaD6qAScuGMF5hKuSeVp+pTyEE1E03Go2hJKg49SDheFyij4G4bHkW5LokZbw52Dgb76uIjsjoNKFUTno7xUSiZKGTnZsNG8f044YCooQGwM+H3IoQ5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 14:53:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 14:53:15 +0000
Date: Wed, 22 Jan 2025 08:53:11 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <67910657b96a5_1eafc2947c@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 422d7e62-3ad4-43fd-7fd2-08dd3af48022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ShZ7z+VSMVNJ6Mwu3hKNJOGepO9vtd5UgHUW9/sMVylEg4x0FQqo7U3U+AXW?=
 =?us-ascii?Q?j+N1DgHBhgHVG90nt7HHkbdsoH/MVyHhR1ovpb15ofWkEL0P4yHJz7FZzdGX?=
 =?us-ascii?Q?t3xBWCNMx/4lxZyTruA5wwEK9efydtz0IFvrXuIHrY3tDPkn0rd3hHcOy9pi?=
 =?us-ascii?Q?B6ha4iFrw1EjDGd5RCBeNWUrlk62iCqYw6miOIlwpgL8u0JJF8p0DJxyAaV+?=
 =?us-ascii?Q?lCdeCIKF3T4WhleYPTQX4TxOsKNvxVvAz0sDZ74u0cnUMU26QhRgPtN7nGs6?=
 =?us-ascii?Q?dAsxlk2OGoVw6nwzQ0sm0/P8QICpHSXzyc0LF9VId0ydK5f76ONf9jxUQEVX?=
 =?us-ascii?Q?5HOH2wX+gECjGFBZViWA9km8jgaC1F7wzQo163HHma0BR3srRePijs3+iB7i?=
 =?us-ascii?Q?/Bh/ykGeISh7Cy/KwYGk+yniZJB5BoAePchGXNnZrAfQqIRpqmh2T9SdDpc4?=
 =?us-ascii?Q?PZ6zexaFY6uS53PbaRqNEusk1bAsceiqjDWPJpzuv7m8cL0lDaV331boLgjy?=
 =?us-ascii?Q?9ffXoHmpDdKbxEyfhGXIcDsv1WegtRXXoaMeFlFl26JgN2VwdxHhXx8VGhQo?=
 =?us-ascii?Q?rlrzfNX3rFcuM88LIjmEDoJBmoyOP5A9DIkQc0ngQeGulIZ21vQx7SKciX3E?=
 =?us-ascii?Q?R28S/PP5wZh7LZMA1SIfeNSjsgNj+4RjJcmhcp/stnXSsHxi2my0MmYOElcu?=
 =?us-ascii?Q?0dtAZMqqkPnEd4F7K18AxTI9P/alJp09vIWWoh+dj3cIUiD4zTrf32x42yb7?=
 =?us-ascii?Q?yFwhQ5Ec3csPWoVCEKDfcAUrbR+h2xWnNHumUo3jErXlX3K9B0bjQWaUHiCO?=
 =?us-ascii?Q?QJVkhKVuFpJsDSHGR/vyuxQ/UTCCk4vuaHIqb790MIAA38Pyj/r3Zv+amMDU?=
 =?us-ascii?Q?ZWEXsbTT5k5JjJpUo7cMVzTBoI7MVKkFcHqNEC3ZTbhZPW1P+aEgKPB1eFDq?=
 =?us-ascii?Q?NhF5Fn2cTQUCsHCUheQD6y3XBS44YOXj6JUAgxedF81bTHmAtwzXwmED/5eL?=
 =?us-ascii?Q?sdVai8sb2HpkrHqDq1/TwSIr3ZK4Qtrxs7cQQgDDEPJ9ctBqZZWf3EH7IlSR?=
 =?us-ascii?Q?SMNaJeDNVgKKLiifGBHtFXebcotDwECqPRL0Rq02avIZWtsM+BwV6OzETYgy?=
 =?us-ascii?Q?vWdCNmWXl0uR/MCPnZ285oKbkVcG9/Nl6TD6P8i7zC8dlOCAM8C3O/z4b8N0?=
 =?us-ascii?Q?pNxumszNuey3whRDeAvbbeK96fOPDmR7zj8QlT1cYhHit0PCuas4hxU4qD7T?=
 =?us-ascii?Q?Eb35y8QbJJnZwW0zulxgNELo0LVmFsqHcNvtnH+ARj2KGpbFQ/ctBbH4u5DD?=
 =?us-ascii?Q?LDiLcCvTggKaUXM/5+y3Jg5HxKadFuS8BcQrOwcbxOF0u87NiGuvUKSGUekL?=
 =?us-ascii?Q?gvYyFmsFwxlNNi12XYPP6BY9s6Gp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71W88F2zUT+BuXRULAgA9aAle+MWNO1fAl3S7AbJS/EBXI/NHBOETB0VIxCl?=
 =?us-ascii?Q?K78vtvrbHIpqo6Ml2QtlEgInVNtjHMSu/vixBdKt4cosU/ymOpN9nTai6NL3?=
 =?us-ascii?Q?wEAi767nFYEnnP0ePmJ82ISnAvtCZulILodmqMqzwBSzYK9kAbNabrY0xIbX?=
 =?us-ascii?Q?6SNbF0wUZ3tDA2FYvmSd2KnQqK5vuR2qHtFBN7q6ddJQnT01jtAemPgGfhl8?=
 =?us-ascii?Q?3IbkDgLBUlkoQRqVz1YeneF0fwkId6pwDwSzr1E/s1dpBgfoZfHAtv/zdPw/?=
 =?us-ascii?Q?bGEx32C339tMVjcLIUjwWFUN5Nrk8ZNEDBe+nHTbm4C7UN35BcGhfgl8ewIP?=
 =?us-ascii?Q?jaWpQqr2bqYHW+oPL7PSnOwvcnFsIk2YZHAC8jirHKs2WwV4nBdeEqbHjOhm?=
 =?us-ascii?Q?V3N8i2VQGJSDsWdeo24LedqBHAEnjwpWKYrzOCCbDhxc8T609SHpvqlC3nGz?=
 =?us-ascii?Q?FnHrXXjyFjpsVZ8cEcwPwb1Obewd89ngz506EnSJATBtaU+myHo2oHg8w3Fa?=
 =?us-ascii?Q?dB0XxZOl0ifkIKV2PgmOA+sDO+0+BOVMnOI35+id8lYlZM+KBSSkbu+iCUir?=
 =?us-ascii?Q?otOIZArzPXmK/YJQ+4hdBTebQZFtE17ZpDvqOI5oNMORtXZ7iKXpRDCXII2k?=
 =?us-ascii?Q?YG01k7Qw7IKRAVirO/uQLHlfhCMtcojALcx3UH/nANdZa0waT00CIBVnxri5?=
 =?us-ascii?Q?p4DRKiy1K8RnAfxkKYxb2g5Qf9RE8G6BFYhnDTr3ayLCdybQhlS34kqkXIs8?=
 =?us-ascii?Q?ka4muX2GhJzqWAjKpYdIWNzFz4QrxQqASqwHUV27suR74GHJ35cegoa/GfKq?=
 =?us-ascii?Q?YcU4q15KIGODionjxTCZ0wIYhDw3purza0iG/DlImRA5xatWLYxqAToROCq0?=
 =?us-ascii?Q?mzVnxxxT1oNtW1iyLPrBs9wr4/Q+hiRsU8fFkmEV8vGUOlNQe0Lankj/nMRx?=
 =?us-ascii?Q?1uK9Hx81xa254PB7/PjzhQwwQRjul706xYlAq4K5fP3jgRxFGzcO7hXicJS8?=
 =?us-ascii?Q?4KAcxy3Upqjt/B8+K49GfZjd0YGeiCkuwEMIlXsuJuCOJ2bPmSsDuLa36i6Q?=
 =?us-ascii?Q?BcMGhODUlEnpaO+R7QogIfPyoiqgIqAMA4gL/g8n/UcvqI1EOjXBOSuuiwcU?=
 =?us-ascii?Q?H7KUGFDayhkmx5TWj34z8d+D6Q0P10EldwLfu0YCaJS1c24F8lVaJB8WJrdz?=
 =?us-ascii?Q?aGzdCwIDQTP6IcU/jE2ZiNe7PPPvlX5QZjPqKu0ERVUIYRCXOoSME9B7bw/x?=
 =?us-ascii?Q?9IziSi1imOhwlLY/DHeWrzG8JBmMLj5Y2ZBuLq0lrGXLyCcxq0EB5xLl5ZDC?=
 =?us-ascii?Q?t7QBH5qvNTABywEnK1sSNXkqdzpwDRZcBD343eKJp/WgHKBy2HKnfSOXZpZ5?=
 =?us-ascii?Q?NuM8ekvQVWpdFXcfqPSJ16Qe7J2I/tBYpoazElCRMOhDAt6yHUHw8QhwjP/Q?=
 =?us-ascii?Q?LYWplmCqUdKZFDWc5b0WhkSHKPkR4QUhxfo7X+VKIFTbXe4Mx/y457oPal4d?=
 =?us-ascii?Q?/lcnQn8aCdRACm1YJywvv+UM/xiOf3f0mNfE57cdr/KmVG9bzZMMPDapaSIk?=
 =?us-ascii?Q?Wji9JxFzUhaNXIRDVCRcz2YrYS+9AOo2thvYSe+Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 422d7e62-3ad4-43fd-7fd2-08dd3af48022
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:53:15.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZNRsJhQJMddyhjWyPZBvYKdiTOJWurOOUTQWBGItmSQq34VJ6bQysxeXaAcNHlDUqB2qZbb8KBElUc8kQQJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

Dan Williams wrote:

[snip]

> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const struct cxl_dpa_part_info *part = &info->part[i];
> +		const char *desc;
> +		int rc;
> +
> +		if (part->mode == CXL_PARTMODE_RAM)
> +			desc = "ram";
> +		else if (part->mode == CXL_PARTMODE_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";

This can be a follow on patch but why not allow devices to name their
partitions?

> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		cxlds->part[i].mode = part->mode;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 part->range.start, range_len(&part->range),
> +				 desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> +
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)

[snip]

>  
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +
> +/* Static RAM is only expected at partition 0. */

Is this because the spec requires RAM first and the partition array must
remain in DPA order?

This could be in a follow on patch, but unless I'm missing something the
partition information must be specified in increasing DPA order.  Perhaps
that is accounted for in this series later.

Regardless for this patch I don't see any brokeness.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
