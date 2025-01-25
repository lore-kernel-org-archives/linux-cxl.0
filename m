Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D491DE4EA
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768413; cv=fail; b=DBfB3aIFHJ1HPAaj2NA5lBub7MvQIIA48tz4DtRfZGGRDJuyqp8JKcdXDtKLul8Kesb7ggfM1NrE6oyi4BbBwZI9bGyjyr1JMHvWy5UoV7J00LizY1j82dxUHFv6Tv4119IH0yRViuykXEV4DNGdkWfmTIKTnXgD3LxgHpeNQLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768413; c=relaxed/simple;
	bh=5mad+wd2sptYUFwzWF4rGUd17CrPc3XAR1xUUR3bPlY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DGT85GiKJufQvyaJez/rdjQfHBt33fH0msxr3KbxvoekQ1X41hVDxAaAwNwhbxqrCtHxSFRnA9/ilgiPRUv3b865fSUX3Pu6f9d5esVzkGUJXq025wifnjqoq62MHfwg8tbpFeA6k/RzkfYXP4/GJvYcXIKRIscAXIVmVuwg7X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlI68OJl; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlI68OJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737768412; x=1769304412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5mad+wd2sptYUFwzWF4rGUd17CrPc3XAR1xUUR3bPlY=;
  b=TlI68OJlhpzCVSMPpvx1LMEsjm3bntHAF6TnCN5N0iaVNIsyqShlerwu
   FjD+Ap9cIAYJKNNHtF18/W+0Tcstz1PbKPScZfHEoOewDX9KTe/McGTUn
   0khOLZXxh+tv/g3WHuo2q4kFvBprD0xeD3ISoFroM0RpxOwPxBIC+c5in
   pEeMOLKCG7HtLi7EN8jlI8vFIUmT8NrsyGEs4Qfwiqg6scvXsgE0n1HAg
   2EQHIOfbjPVnKF4ME+XG+DyahdJ7HtnmY4GzgCPrpaTHSle9ZR7gffmGN
   wwpsTZ1ysfS+g276Q8Dg8L8h6BtFmWytzbFb5p1hTy5XObYjjY4qs1rWP
   w==;
X-CSE-ConnectionGUID: yV4SxrdfTdeDidoHJ+5Vyw==
X-CSE-MsgGUID: iAPfcyNVQlav8rtwt/CHoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41154232"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41154232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 17:26:51 -0800
X-CSE-ConnectionGUID: HKUT+fdhT2Ow98pEL1r39w==
X-CSE-MsgGUID: jvLHPuRbRnuOpPW1MYX8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113058220"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 17:26:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 17:26:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 17:26:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 17:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWoonBqVk1+fDC2JN2CLL07FK6FiY0Cpn3zH4EYFn1IZvj2uzEPPYKdXjYWA0zKN8gm0RL3E3wPbEqU8ZBmwtcb9g6nEm3Z38N+gZoGas1EHY5fwOdtlkHYOem8phwhX6VkUkX2QRmBgZgBfCg4zj1kvRD06oQA86WN2CCAGPk8NdNduTVEi/H0E/jTmg551GfZMEYN/OVacZFJ5ADpCpKfFXzWIake2Lq3BTeReLbl+czY2QZL+6MKjiMXxFkHEIe/2X6Grj9TQiZRWfPXnUnm4NekByLVseyzMIfLhxYfV8bokZh5tDp4CUrSK3EXjQ7tIZQueJLU3ct1Y965dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBaJjFX6nHAyw4TwZJ6jrmJ+GyUZKd7D8l3t8TGp+Fw=;
 b=eZxwBysexnGI0R4ba6KS6p+qsDklnVOqNFAAHRD7QgFmldjkyFSGcYSwaDzrWe2nHgNPP58ZkKddP157YLYYOE5hBFvub1lv04UFCIY3G1qSV0eGR7JS0ljK6GZp/OTOa1GSNGH2K5boCoQWV7QeZPhXVHOCFiB5ewcXG7EamwFxfJf2RSAziiaqMHr1wgrLfE6I0aAk5DE4rcq0uyRg6Kae8x5xn6VPqbDtDo6rsKTy2lsfr2+uTAE+8djK4dT/NgpHMhw6eER2Ctria6xirO6ejp+O3TbUB/XwvkLSw2fogaMo7oh74SOmYI1UuUznFE4T4m1SVERInSDod0SHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 01:26:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 01:26:34 +0000
Date: Fri, 24 Jan 2025 17:26:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 11/19] cxl: Add support for get driver information
Message-ID: <67943dc81d9e3_20f3294de@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-12-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-12-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ef4240-33f6-4ea5-0291-08dd3cdf4e29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dswj4gk/3qQq4Flo/vRnnrvmiQO4BBHf1RqzsFuqItEzp1HH8KWeQsMv7uUH?=
 =?us-ascii?Q?pKgVKeL5H/7THnkmeL5P/VxlpoQshh4lLPicVWH6z+R2pRZIpVy6cH9hJUvA?=
 =?us-ascii?Q?7+dyhzMjZBO4MA9eYGMzOsutBaUdICrARlAI1ooFw+/iHJD1shQ3oyGZPcI5?=
 =?us-ascii?Q?KjqYLps64rY73Hn3Fxbl9LIVNKVcj+AwoA+gsillRZofP8lCKK1uuF6+l7Ka?=
 =?us-ascii?Q?crSdFcL4hmk2ebB6jyGBfWUWXZss6FumJZp1xeg1DQzqSaC/KP5N1MBB+UCI?=
 =?us-ascii?Q?VxgmPJXny4hQdISXo3q9ogw/JbAFe3mK7jXcJcEVC9luwF3h9s0QUdl1nDR8?=
 =?us-ascii?Q?HctlLrOmtXITLGyAIkWzF59pUZf/sQ8LfgV3WNFO7tHtctrWgIY6v5fn/7//?=
 =?us-ascii?Q?5XfPRF4P9ZD7KmCAAG9MskccLYHevqK/L7cZOLBnZrFs5xvKbG8N4mMXnD5V?=
 =?us-ascii?Q?VvppmFVgJwbua+zbp7zFxQoPXA77r+q95Gvh0BMKJQmodinAiFdLoz1b0kOA?=
 =?us-ascii?Q?PkBdvYz1wOhbjncctSj4LjGMo6swxwhX330vZ3v/Cyn3HgIXIYl96IStXKkb?=
 =?us-ascii?Q?uJS0MBeyRQi+rOmRwnIzYvIg8gUPHL1XAB8FqvPYb6KLu+Xm4VZr3qObAuN2?=
 =?us-ascii?Q?0/a8nRVuLVy0CMzjpZWjpzD+Hp1ONckJFxh+hLcMJS3y7mi00LNyJvHNQCYb?=
 =?us-ascii?Q?tpfxXdScdMExEN8Kt7aTqihivLB+Lv8H+/SnD45cQ4qas4b9qG+fLroghD3Q?=
 =?us-ascii?Q?JbAng1lMsg4QjOHagzi6WEXwB4XXc9csN88nGR/rquAanUIB+gEl4onblL76?=
 =?us-ascii?Q?N+lDo4/IafpikqJ8TuONeDTukdfKoO4vk/QKg1PORzU2lgW4HDoEvC3j6x5s?=
 =?us-ascii?Q?FbvgR0/zuPDkk29FaJ0Q8QUexkfE3bGf+cFneDz1YORwkPFG/wgdQm8F09Ym?=
 =?us-ascii?Q?xZg/Zf6ggjXDoM9pvpT3zQ9bagmyFl4XTyy6nzzgQRdUFUzDFTGMu+6AO9Hv?=
 =?us-ascii?Q?N6Of8KcyE+rXdbouEx/OQjZxFizJYb00mAOmkZ1dHw99UC/O+qNqZ4hMBOGs?=
 =?us-ascii?Q?XtxXX+zVfT1tX90rJFn2+k0xnkCg+D2p/m7vXxDwb2dLKh0c5NHg9nqrcCza?=
 =?us-ascii?Q?TQMmaBp+SkmlGpg6PRSDSwFU5QwZvkkwLkEGoxikzfXKgk/e/K1k3N6aSidY?=
 =?us-ascii?Q?/nVYDq/9nVZPLZEHm5oLBkOpnXbOjtj69v1NRluuZaRyNz4hOEb5lecLu5pf?=
 =?us-ascii?Q?FelQA7qEvX1j7Ixul5ajNlKD5KldJ+4FdSS0slZ0Mw7pZRw/tKPP7ybnJCTo?=
 =?us-ascii?Q?s0dK9s2wMt/J5hmeaPzfy2/u97Z6pOXTbM23ORfZtcI8ie7AckBNdHoHCkIn?=
 =?us-ascii?Q?9DFUr75teTuZhlYY52vj4VxKRACw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ffWiUdGx8dN/DBBa00JYvN+PxIVzmMgnBpElxHmqanW7f3ugT+43/3/yjLO?=
 =?us-ascii?Q?wevZjiZ15euTS3XRbDkCISOsm5VyEZOFShUlFKsG5jJM16DMXlQd+yuz0kcg?=
 =?us-ascii?Q?6idC60Aas/tAWMWismgCz4kK8ct4pg4muKwoKuP31eOISRcUlOvWTwruW5pi?=
 =?us-ascii?Q?zp8RQAvDqcfd8Rcnw2KCwqjrdIdCj+4l2ApEzYmG+34T4miD+8jBx/0bS2Wm?=
 =?us-ascii?Q?CyUV2BD+frzBnSYU+Urq6/JB8+ykSU3ERctQ3acddQdzuNr8XwPU/IzhtuSt?=
 =?us-ascii?Q?jRzjJDT3eKe1tege1xrmz2nTE1ru/pdABkrfK86l3rKiBqApz0RxT1qWYYcG?=
 =?us-ascii?Q?24gGZdlY3w71TbffrF+RFmFhFDHVIeDORso3Naam+yXQl1Y3O9f2zhpXvWGD?=
 =?us-ascii?Q?DGIeVRef0SpVf8QTDt+hRboNoMsRPk8YJJz+0E3+Ua+n8PHx8TPkCA7k+nxa?=
 =?us-ascii?Q?xQQESFfWFLV+wAd/uoTQvnC77rtFB6T2hYGQRofoqW9lerIRmW4M1AeLM0Cf?=
 =?us-ascii?Q?nqxadblz1fQsk2t59zfrBNDW6ZR8W3kwKoVa21qXOPlTQCgDdKcrQC+Bm4Kh?=
 =?us-ascii?Q?fWoH4zaC0ty4NGgwDpo13VOxIQxTLV07hFSqz07dSRBT4ae99K2dZM3iskVU?=
 =?us-ascii?Q?wg0T05ubABN+fFZEsbUlrTwMh++1ZqIAXQdNNdfy31R7X+4wwkyOGw93vPf0?=
 =?us-ascii?Q?w18IxNumIl/x8tVCqARGzETAiOZWVGq/KOaYQtsK8q2jWY6Q4ASEJK9i9oyr?=
 =?us-ascii?Q?8Z9zLrDnToD5HqQw7E4+8IbS3uazkoRFU0e4HKhI2JOGxWBznRxGI2wMcGNv?=
 =?us-ascii?Q?alr4uDdCyURk8/y4NSYEeI6y2XGySr1FxoOCwgL8tDjveV1Xk66nSDIieSUj?=
 =?us-ascii?Q?L7Fuhmd0wjDnQnCLZ/Hx4MsWUCM2mUnEn50vfzPoecUyPHo+vlebv9+kwMU1?=
 =?us-ascii?Q?GcjAT9qiAi65VK2q3jjUXUaoQKaeX9OFfo4IAKrP8+5IiueC8viXH3ccH2kA?=
 =?us-ascii?Q?1rFON6VBrQJJevPmQzplhwDJpdTCQgcQVwFSuNaes5EOp+EILWRGDaAn2TTo?=
 =?us-ascii?Q?kyGEhc48MuImdbcm6BbzGn4Y0hPFbJUlDTA8+GpWqzlm9nvlzZgHdbV76tgQ?=
 =?us-ascii?Q?nO6qqaYSiVj4f7eOwe3Jfrec0KAkfPvQ+MoJFXlH9e9mEcLHEx387dhCiliP?=
 =?us-ascii?Q?QepsU5Hph50eSt9IhGQdK56ER4zDLukHTNA8yYapv3c3QFNIYvprMLDuRzW5?=
 =?us-ascii?Q?woy5KWdiFyXgjZMRCXOfl5RjWYzsl6ATxXYGWoMjWouWujXggHrWA3U3AjK5?=
 =?us-ascii?Q?suJlO62Gc2/WgreBzlRkqXcYf7tpwsb5NrQcKfUd1HB1kCbf73rmQNQXcI6W?=
 =?us-ascii?Q?ONZDrCz4KoccOhFKPs/4cTpms0LZy13Z8yrk2cRiwqzgKl0TIcFl8zViQcnv?=
 =?us-ascii?Q?zPIWdnIb84lr3QbrUbPZVMniDAJqtzlobcFzW6+nq51ZWEUxCu6C9i1852Q1?=
 =?us-ascii?Q?F/WNgq7R8e/lAi9cNvYARXv1PPCjhjhWahJeH0VcscfMRTwoLtof/aFJH1/Q?=
 =?us-ascii?Q?vk8zgRKIdXpLOprhHWtPBsPTlHFuQ8waPflaWqdCMXHuglmSFesCX4kxd5in?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef4240-33f6-4ea5-0291-08dd3cdf4e29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 01:26:34.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE7n6Tvr/IQ47VepULfF762NdiwlM+WSioLXtYkMdybrzdFOhGaZU26qL045TBEldXDAeG+EAeXz++h3Yx9oOemuuKsITkVr+WnALsHEwn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add definition for fwctl_ops->info() to return driver information. The
> function will return a mask of the feature mailbox commands supported
> by the fwctl char device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Add missed setting of *length for ->info().
> - Use BIT() instead of enum directly.
> ---
>  drivers/cxl/features.c   | 30 ++++++++++++++++++++++++++++--
>  include/cxl/features.h   |  7 -------
>  include/cxl/mailbox.h    |  1 +
>  include/uapi/fwctl/cxl.h | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 9 deletions(-)
>  create mode 100644 include/uapi/fwctl/cxl.h
[..]
> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> new file mode 100644
> index 000000000000..79b822dbfafd
> --- /dev/null
> +++ b/include/uapi/fwctl/cxl.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024, Intel Corporation
> + *
> + * These are definitions for the mailbox command interface of CXL subsystem.
> + */
> +#ifndef _UAPI_FWCTL_CXL_H_
> +#define _UAPI_FWCTL_CXL_H_
> +
> +#include <linux/types.h>
> +
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX,
> +};
> +
> +/**
> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> + * @cmd_mask: Mask indicate which commands are supported based on 'enum feature_cmds'
> + *
> + * Return basic information about the FW interface available.
> + *
> + * nr_commands is number of hardware commands the driver supports. Use
> + * FWCTL_CMD_HW_INFO ioctl to request additional information.
> + */
> +struct fwctl_info_cxl {
> +	__u32 cmd_mask;
> +};
> +#endif

I do not understand the value of this. If the fwctl device shows up at
all for CXL you already know the device must support Get Supported
Features, and Get Feature. Set Feature could be optionally be supported
by the device but Get Supported Features will already tell userspace if
a feature is writable via Set Feature Size in its output payload.

So cmd_mask is vestigial information.

I would just do this for now.

struct fwctl_info_cxl {
	__u32 reserved;
};

Make it zero so that we have place holder to provide future
meta-information about the interface, like an empty flags argument for a
new syscall.
