Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460001F9EAA
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663949; cv=fail; b=jcgcRPx7/rOtmtpaxIF1j8uQQN4njZhstCO6OoFyjfpUgP+VSaDrS0OVT93Ltf/BNs80HWDCM7XZL4e+ZLsvU+BB8iUESSDKCagq9L1dl2QU9Ml9/C3vmjMzI0ptD9oSmzVIpCFHgrCzVnBaMHhTVEvDQ8+EDNjS6ybNsRLgu0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663949; c=relaxed/simple;
	bh=4dc5ipFWQ/6LOmUvV+nwRIOyQVfVDOKwnDfX6r5lJsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=egXoevejMp31x9RZ/S2Uiv14UHf6bKgnyX8kk2qI5traH8Iy8YbCxNBSpofZUGym/Yz6MriATnUCwvot+jB5RqHfIq1h5Ww8fnbxoJ3rTzQQNEEOehEe/wvl2HlVUphuoNfHUMcS0zshPpGdyoTBWGnogINhPeFAQ+gWO2aqH88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWOMzIyF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWOMzIyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737663947; x=1769199947;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4dc5ipFWQ/6LOmUvV+nwRIOyQVfVDOKwnDfX6r5lJsg=;
  b=QWOMzIyFD3NVL17kMkWcRZqzRJz0pNya0keNe+eVvDHqEH+nZesnNUsx
   swSHoUn5HrWarUFXOQ6XTHU5euiwGrw1IRAD/N16BQ+ryrEM7G4HLS8iA
   n2v3NyO5ou3NwXBchdxglGdhVh8cFePgnwreirPOGnb+idsT0IG/7T46J
   AEj2L7hd+M0+hq7Pgj0l347kUBccPwIKaF1FrkRCbJUKNxBTVUlDjS3KQ
   ldwM0n3WdNMesaGMI8qp5Nzqckckt5Ty2iXoBMkLopAaqQlZtzpHLvT4t
   JXgKWHoJN/bWwM3NX0d3LGAgNUX0iIjbBxwIzp7Tx0Tx98ae4KMOjPP9M
   Q==;
X-CSE-ConnectionGUID: 11DY3eDoSUuKIymf4i4tOA==
X-CSE-MsgGUID: 4pT15hhvScezldFbtXqTAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41946532"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41946532"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:24:59 -0800
X-CSE-ConnectionGUID: p/lHn8JtSlS6yvsjbR4P6g==
X-CSE-MsgGUID: LJPo9mkfTjS/jJuyA+LNIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138438440"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 12:24:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 12:24:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 12:24:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 12:24:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r41Z++gycuFYtm8P491F238pYP0LGoAoqUN5GF3h0Aqa7E1ezhIFWn5HTsmQBFfAumyjHcOzC/zxvK2p3heIWgm/YSIR4ky+jCrUSwcNFF3TRQb75ERmcvxAiQedgVKz52MnzYKw4pKEJ9mBSz+xa4WqShJUUOJF0tYHmGCCd6YGZ4Zb+K+hkpfvRb8pH6VTAoQPw1H/J/FBlEUVzgD5C+GxJYvwwCxQh6diRGLTduEPJwuWi6z4AeEUQPrnCx+keLz4wiAKpKhWo+598q3Ht3Ywraxa96wfwcHJsh5r19i8StjOvHl47LmUTol0FqwuUtPdr1Zv9Vkxe66fXPxXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMoqspAz7sERd+StSfQ1uPC1qVlnyDy4KEjolMXYlwc=;
 b=ff2/Gq7add9qUjeLnuG53nYmTg0OHUYWCrd0Y2+V5TH0dXdb/eIDY7yOH1t56IDCbGJcbZHxhSSsIglIcT1jR6E8PzWtyGN+ymeal+098CT8pQm2yi+qdNm64/2/nGmwZnwj3f/WES6mVeOrTZcMAomNS99PkWjxmydO9sKRiCG+cQlwiDsFAHpqGmxJ0TfK2u8mg4xONo64ntYYo202vsyHUzxlgR716wXtIsIgnWmaJ3z5IFwyd7+4YJ5Ewlt8eliZO3Ytz4r73Ak6P5ZZEkMWZxSzT2vA9/X0u9jcLDepgSpKOWV2Zsnds3O+i5PxHylVINkUm4XlYNqGmLW5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 20:24:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 20:24:26 +0000
Date: Thu, 23 Jan 2025 12:24:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <6792a578374f4_20fa294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <20250123160915.00002012@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123160915.00002012@huawei.com>
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcab80d-2324-4a05-c5eb-08dd3bebeeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QddmDkGmy9yEy52yFRDVeql9fm/HdPgHKirmpfKraK/TNQw6eLkdfmesFnAn?=
 =?us-ascii?Q?YGRP8yq4AMvqhPFBHx731wMiT1++sICmMapv/QJB4JQAmNe0M36H5yzGAj05?=
 =?us-ascii?Q?xsJs+EEWhsYOU0bAO/3Ca/bjSm3np+tokpeExUceXLS6UhgCqKFrLg2Vd8M+?=
 =?us-ascii?Q?RBpox5WkTIr0pxAKwoUb56P/02CDD7du0MyUrMi2YSOyT/lv4iqJRuOOVeUN?=
 =?us-ascii?Q?oMgV7zv0jFQn9HTyUpFUcKsNQyERpcx0YYKnUQw01jfva3b751f4hqMqe6fo?=
 =?us-ascii?Q?p3bUPpH3M11tFBchqjCSHcbNM+25SZiYVv6XPwpD7nUmMTJwxIiD8sfr7WeP?=
 =?us-ascii?Q?yI1iNcwDnsBoIiOlvhIW7o3vuNCR8DAk441XphKLuLGHBtEOg1pxSexJFv+M?=
 =?us-ascii?Q?2ZEM50qTb+6kWUebF1NdPyrUuTwRPQmBRgGnRbqY4EbkRNV+dD0iJBl1Pj5H?=
 =?us-ascii?Q?6cbkbX3uFwKImY2jwNSAl8i3ITRz1Uv0JGh4cF2nb7BvocQY66aA2NxF/2lX?=
 =?us-ascii?Q?DrFjzFwJsBe+LPuwEK6Z4fOz4fLs/JujGIz2btGT+fs3qjxEikY3O6TOnhTc?=
 =?us-ascii?Q?G73gHmXlmal1rD86Kun0h3RGpDAZqztUuEkocGd4pJFHg/bJeqyrAwyiYlb3?=
 =?us-ascii?Q?3+D/tC80nXHohOxGlKnBICsYk0dy1DLj90HdzeD6+GieUYD3MSm9jjYESMbT?=
 =?us-ascii?Q?wJWskEf3YRw5BHdmTY9xiBZh8H+6MV8TNfKTg0N4B8eO/0eM5fY5CINzRZQc?=
 =?us-ascii?Q?stnSgFQDQxnBz+L1t3n/UZ/Fx5Wm9ca24RycPNZ8qrAgLFmb6poyc2BbM+CA?=
 =?us-ascii?Q?DiUVLjBPK03zxxVcukpZ5pywoRVNiPhSojEUdlRVx1N65r6WhjQkb62zkcH3?=
 =?us-ascii?Q?gIOHh7zJs2LmcqDsXYeocUOIMZ64F5bjAO2bXDpGhB00uGl0gb7XR2oV+da6?=
 =?us-ascii?Q?N1YPxlMT3xh01Z+UgiCcndfZQDvZs+AsvJb/jhTYDrF6pxmnJfair5Te1g9m?=
 =?us-ascii?Q?pwjPrV1WkSV5H+nczZlPsWY3Zlj5wT0MZUXVTiPkmaTP4I4sbL3OiPHFym6k?=
 =?us-ascii?Q?ECbiNzgbdLXy0z1POU/DhX/3xEeDwMdhBukD4t2xgCFykMdTW+FW2Pwhj2Ms?=
 =?us-ascii?Q?qvTh84mw3g1NULSs+NY12GQtbXIVRaOI1B0x44FjQ67hLWSBswzD07W7zIFZ?=
 =?us-ascii?Q?aOXckI3XGbnYqZGAtje3GF3Rrcgpj8SFAOy7XdjyH5w2wygKVPpCeQkVYyWt?=
 =?us-ascii?Q?ZXDD4ae5ypEUkfXpG3A7nICAxG723vyAsoVXUNu1SUY5G1eEMCfjWhT+Myjt?=
 =?us-ascii?Q?ZylKnzJLGrmRxeaR9QWEkWoYpp3KwEJL0CkQX0erlCYwBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyNGMW1mRlH/RYPwGW1nd2HsXkw8kaDX0BNS/3R+f2tjRhOg7Hy6vMg94QGQ?=
 =?us-ascii?Q?C8wnpf+Zhb/I7847OQ5CKRXK2tzfvXGxnNPjTXpnDciig1lnWCGDprrlH2bB?=
 =?us-ascii?Q?w7Txg6SwX58F0PAnnmqorFrlLDpxVlACQbyOA/QhbMFTWXGbHEct2s8m+TSf?=
 =?us-ascii?Q?i2BMUPWUfutDxl2fXQqB3AntKiCVDW6HKoMe5MfhQ71tYTjfHi4c5mzS2yRA?=
 =?us-ascii?Q?MK6ZGwzZtSOSifS9FYVoME0cbcjfpGyxSBH5G+eV7d+bkg3YpiHfOeUNxTk2?=
 =?us-ascii?Q?z/zlwTwK1p0mnm1rzOL18x0c++QMoNxIGBKwmvseZagBcZnVTfDapA6I78EP?=
 =?us-ascii?Q?EGb5ICpYN+X71zmEBMhGhCC0mEUFZEXcSQIZUXEj+hVkEGeR5UBxxfKZ02xe?=
 =?us-ascii?Q?Uu6FRBpA2Q9cQhW4akOCsbBFpsxh7Wx9gptwoQRizEW8E4fE4uRCuTtbwlLK?=
 =?us-ascii?Q?49lzQ9dshSdDNPMtm/KTDAOcYB0/x+tN/eicZ4rTJQCj5wvBlPmC7KwfTnkr?=
 =?us-ascii?Q?AM+f+At6WYOfnW4nKFtHmAecOL4MmjXXnVLTvNl/RXbnUhonoDlksjKdk8iT?=
 =?us-ascii?Q?Zqp8szI/jVX2OdbsIVZACs2RHDgqaaKNw4jENbuuCxNNSTDxez+y38Mlh5hZ?=
 =?us-ascii?Q?tM+IMGuYw/nMKP6ts56uoQWctB8RwneifonzqK8VtDA9H28Cod+wCaOoF8U1?=
 =?us-ascii?Q?ewLjmHwED4NdUZaBi+0gVLmUXXyiCvMFmitEnio79SgLRN7zwx2ZmjqfCgwf?=
 =?us-ascii?Q?KD7xWi82lnEqGw/fC+N5c5TKmcCZn/55XDZjQC6lVMpdZUlA2njlZuCrzSNy?=
 =?us-ascii?Q?3/FxpuuJFtMbvSNwylUqjIQpFxBEInqaYlrnuCmLIg1G8ZTezNr6qGg6PphE?=
 =?us-ascii?Q?GvvjEVy1kxA2VHPOBiGT451RyW/d9c6r7dn4GMggU9qqJ3JSNg0+QE9vy57R?=
 =?us-ascii?Q?/Cvqacqj+iz0P0SxyAwVMpp0TyEpBnxhEwnyMxRGOy2k6ojj9R2MMY9Jcrki?=
 =?us-ascii?Q?SscdcIpsVDcTavzmxDxq00PPjghj1bXuwI34JytEGP8ICkA4Tn4/iEak80IC?=
 =?us-ascii?Q?EGaX0Tbm1rbhWg58p7/dYQoOgqosfppFZZVD6GznPOypnBoRmm5o6UAR/Nu4?=
 =?us-ascii?Q?lIePgdAEyu403cXxMg31ZgZiHt3a+6GNMZSUaruPcOWeSQD5pb0ecgT+/hhG?=
 =?us-ascii?Q?atFECfg+LdplJgHpo543Em4TFo3Wpv51XeCHG7QGb1vk0QPwMVfyt+9LPMJ8?=
 =?us-ascii?Q?3D7nsNPNyrvsCNhQmZ6SdesdcRU/++4agtgi3PJqkrKp3FDGCDe8Gb33psOM?=
 =?us-ascii?Q?imVgqSfvVXnpkN48mPcYySNv6qcjL0pt8rzoWWoM5VuafoYSi2oWjew6y5jn?=
 =?us-ascii?Q?odzFmCZzUHXsaXKWjkWNtpFs8UGBKkN3tolR6H1sb6Q5dpjTgAyujATYjfxI?=
 =?us-ascii?Q?R9ANCTlFkzYphs2ApwR/lVpkwe3v9ZLTIXuhhoD3epHd2oU7jSbH9tyd0nRE?=
 =?us-ascii?Q?GQez88qZZOjOF4BxkWAxyTvi5+QzlVlLucOIO+WK1wU3H0ZE63kVyTCufLUR?=
 =?us-ascii?Q?OvaxvGjXpAyGj8vE7ma9637FP9FMZTq51p6WW16syBDFTmE08YuoW/+YiY+I?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcab80d-2324-4a05-c5eb-08dd3bebeeb6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 20:24:26.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbC6cbUdnyem29mpHpxkx8bLKgQIgbKhPGjJO0QarhBQ2J9DndXPMDcQGEdf+ZG8PYSoxdLgpdkmgFC1TpiLz/Chsrh7xdIMe+NwRUO6Liw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 00:59:27 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The pending efforts to add CXL Accelerator (type-2) device [1], and
> > Dynamic Capacity (DCD) support [2], tripped on the
> > no-longer-fit-for-purpose design in the CXL subsystem for tracking
> > device-physical-address (DPA) metadata. Trip hazards include:
> > 
> > - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> >   devices with CXL.mem likely do not in the common case.
> > 
> > - CXL Memory Devices enumerate DPA through Memory Device mailbox
> >   commands like Partition Info, Accelerators devices do not.
> > 
> > - CXL Memory Devices that support DCD support more than 2 partitions.
> >   Some of the driver algorithms are awkward to expand to > 2 partition
> >   cases.
> > 
> > - DPA performance data is a general capability that can be shared with
> >   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
> >   suitable.
> > 
> > - Hardcoded assumptions around the PMEM partition always being index-1
> >   if RAM is zero-sized or PMEM is zero sized.
> > 
> > - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
> >   memory property, it should be phased in favor of a partition id and
> >   the memory property comes from the partition info.
> > 
> > Towards cleaning up those issues and allowing a smoother landing for the
> > aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> > array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> > way for Memory Devices and Accelerators to initialize the DPA information
> > in 'struct cxl_dev_state'.
> > 
> > For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> > get the new data structure initialized, and cleanup some qos_class init.
> > Follow on patches will go further to use the new data structure to
> > cleanup algorithms that are better suited to loop over all possible
> > partitions.
> > 
> > cxl_dpa_setup() follows the locking expectations of mutating the device
> > DPA map, and is suitable for Accelerator drivers to use. Accelerators
> > likely only have one hardcoded 'ram' partition to convey to the
> > cxl_core.
> > 
> > Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> > Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> 
> A few trivial comments inline but looking better to me.
> 
> One question about what smells to me like our next MIXED mode.
> 
> 
[..]
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index b177a488e29b..5400a421ad30 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> 
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +
> > +	if (cxlds->nr_partitions)
> > +		return -EBUSY;
> > +
> > +	if (!info->size || !info->nr_partitions) {
> > +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > +		cxlds->nr_partitions = 0;
> > +		return 0;
> > +	}
> > +
> > +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> > +
> > +	for (int i = 0; i < info->nr_partitions; i++) {
> > +		const struct cxl_dpa_part_info *part = &info->part[i];
> > +		const char *desc;
> > +		int rc;
> > +
> > +		if (part->mode == CXL_PARTMODE_RAM)
> > +			desc = "ram";
> > +		else if (part->mode == CXL_PARTMODE_PMEM)
> > +			desc = "pmem";
> 
> I'd go switch statement now to save having to fix this up later, or
> an array of strings with a bounds check.
> (not important though if you want to shunt that into another day)

Might as well do it now.

[..] 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 78e92e24d7b5..15f549afab7c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -97,6 +97,25 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			 resource_size_t base, resource_size_t len,
> >  			 resource_size_t skipped);
> >  
> > +enum cxl_partition_mode {
> > +	CXL_PARTMODE_NONE,
> 
> What is NONE for?  Given you are now packing the partitions and
> counting them when would we get an 'empty' one?

Looks like another thinko during the conversion. It gets used later on
in the series to check for endpoint-decoders that have not been assigned
a partition. However, that path also guarantees that the endpoint
decoder *has* been assigned. So long CXL_PARTMODE_NONE, we hardly knew
ye.
