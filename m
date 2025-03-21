Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EF2F43;
	Fri, 21 Mar 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576548; cv=fail; b=YA6hiYpr/+7S3e/5D1cMjrSIvAjJbHwpDmOYW9STjWQt7PlI72UsweZq5P2/hCozfOjSpP9hhDSDLOhV65r1FbRKDbEoiHLgtVcpnilkAKgGJmbdQa8JEWm29t0PjdI/pp8iI1YEKqf2lacf+QSuqUqeAgGPq+0kpjUFzyZwqGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576548; c=relaxed/simple;
	bh=e4hX+4ARFCJDcC+vdBiDWt4yyqoS3NKZCbPFmWl8uFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDP0hL2y5H47p5K8l+MWNJFJtByM+TSSn1rZuQ4MaKDRVIRpu0MzTZgJx/vjJwfg7Zoit2umuhvPMic1dx5LiPpYu/Oo4A6oQYcCllT1EJwpN6Mz2CQoIWg5DI8T7zWRRGNmUth9bzkZ3zAnJhggf+7G8QILfME5sNUbizAGA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKeqjrgl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKeqjrgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742576546; x=1774112546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e4hX+4ARFCJDcC+vdBiDWt4yyqoS3NKZCbPFmWl8uFM=;
  b=kKeqjrglCeU6rfAhmVTvdXd75Og7+xD+xu0vbRWH0c93bHol5uki02qq
   qnlIxNKfgsx01SRvShpCyL8dF9ncQVu3TejdF8lhrA67wEmj35XyUt+Wd
   eX0XLAAzFIk367ON3+PTSmolJcF4uC02BCCvPHhWIOYA9nmAaNpdvqZVT
   f10Q8K9b34k81jNBh3+n8tW7TgjKWUVFsAr9jSgM2BukH+I60IhQZYKH7
   nQuI2wg3Gvki60HHHqxzVDiJ6/W8+ev83+FI2hyJiene4YvugQ9oJfVEe
   xXU2ZfIJ/wF7tNO6DGC1mBFQuTSgxdiZXrfx0JrqhrJjSsehkmkcc8NWL
   w==;
X-CSE-ConnectionGUID: PQ970VYdSxSmlO6b4WxJXw==
X-CSE-MsgGUID: HvCDQjpWSIaLOHZc0e+a9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47727645"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="47727645"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:02:22 -0700
X-CSE-ConnectionGUID: GoSeWfYASU+QsmspvdbbMQ==
X-CSE-MsgGUID: VVQ6AmkeRmGoA9UBOrBKHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124403244"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:02:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 10:02:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 10:02:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 10:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI2NbnJfHYqnuHu8iebz+6cJg8TVVJI3IWygg7+Pz6dDNlyvXlQxPSCzaJYLsU25A8G3ZsIR4dE26HVLOJgjFFnvtT/Y7yfNvnVrWgU9vWGxKaV0so+DNSiehcsGxjtETOqU1E7D8Fizc/6ZbaZaQ2UwRnfSIkWkyrK1+lk5pAs2H2gapEOzwzj71cSM4V/snOIIG6ZTAf3SJAJjscqaDV3FsbQ1bVhMtBfem1FK1UgMQxq0huJnAoqhi2k/WJYFsRCemZBCVW7I+mKvWl0Z+SNqJr2kb7fCdimEODUnTs5Xucc44hq9Qj1T4OMt3D6WyIUTOo06Xctmk7KDvqsPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQn2CerlckoCa1QwEvzTAm377X2jzQuqEhclimpAbCs=;
 b=Wj9IxW3UBIgoXxmDwiOgKgr4dGqcYLycgoiSFkTmm8w0yzLUmyUwBQnSI3bIKq7Sa7Aa2sqkUw3JtfWAWy28+tWvReZY+OYDZa2NMcDIMTkoAE6qMvt2GEtTYdO+tEH6OhY8jjQpJpXpwPJ1Y33QnEqao/KYoEPt9rq0rEhQexWywmdFeU7lNqfyJqWEf/oc9801NbocRp1PzuPu24tlFGGULHo7huCDquv5yk0JmDfxiKeiJTFurRvL33POpyazPGIg2Xq/entFRJxKzxIh7QN4KA/WtNukMrcTgp14FW9nOC4B7J8ZJzFXwVkExEmBk9BoVNioz9V86Hc5HxMACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 17:02:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 17:02:19 +0000
Date: Fri, 21 Mar 2025 10:02:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
Message-ID: <67dd9b9873189_11987294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250319035516.222054-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319035516.222054-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: ab01c82a-731b-430d-f78e-08dd689a23a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZKmRzphuVYHLGZaQVwNagjmEdKZeyxemO/mLKRH9kZT2h1LReRo8QO81GZ8B?=
 =?us-ascii?Q?R7Zr3y6BUcr1R/RD1NTRRQoeS5N//bm7YxxwOpC8VqI4dLLqTb5PaakAwqJ6?=
 =?us-ascii?Q?XPbENRpyieUaC5rzJV6j2ns3vrgzrJbpKiJgUW5G0xPJdw7cbBibNA0yzjkb?=
 =?us-ascii?Q?/Ex43a5p8eQ/NhF0xvbwmiF2JQ5kTAVOiVx61cUmgwmLuCCz9EbvqLjLpAOp?=
 =?us-ascii?Q?uwY5R0ixPxf1D6HDnSiLgvkv3XMCVtqRTnT3cHcL4sBhxudmbeoAdNaCZmxM?=
 =?us-ascii?Q?dt6WrC21iCbwtfllfPXY5i214YcQQlWC6qHq9QvZHD/VzIu/VLwwanYrLEmD?=
 =?us-ascii?Q?qo5HYjUcr07T7oAqSs+FAdVDiTA5I0p50PMZmwaZTZ6vZQdr9CeJ5vetBve+?=
 =?us-ascii?Q?KXV/8WcCS1gQOus5Rc2tl2RCjFUzA5/HSOZ+QAwgPThXNkobzHpk69TcqBl9?=
 =?us-ascii?Q?IZKF0SrXL48uK41BRGO2+JzJOWbKnbfpmKBoKDadzajzuIMstx82TIqKbLeD?=
 =?us-ascii?Q?9E+QMi32xZ/Z4ZTS2PYzjcBJnM3k8clG+ib5hnp51CADOnoyXynqmrEShkxw?=
 =?us-ascii?Q?o+7Jeas/p3CievfD8JX6/dTgXQIY2vSTumInz3cNFUpBX7ypwyCXQ35mJ4wP?=
 =?us-ascii?Q?TCJg+F08GoG1cP7PoO78iq3AZ5SMCFqzLpeVIhLU6/xUuClU3Mwd/OQXEwNT?=
 =?us-ascii?Q?MQi3FUcHyQZFu+LiS1XglXDuitnHsOElF85wIJk1n74zoNapGYontK9R17HX?=
 =?us-ascii?Q?jF8Q0hcISrnQWfwRGA8KnEB331Ou8iARkhY4Kzr7PyTv6pexBu8kK4qgPqw6?=
 =?us-ascii?Q?XCVqP0U5IzZ/hogXl1XL1kgtJJalRHLFuym9kQY+LbdKTo4KMdWDmZJa7Nsa?=
 =?us-ascii?Q?ZjoxX2deF/etChsxDesgU3SOWR0YzDDLt1Ntudml8V051BrFg2abXODW3VFs?=
 =?us-ascii?Q?Ql7TX/antVSw0kYm2f5RaSewOFzitzqNx/5eumEk40mLu6G5R0Uu/fofZB8q?=
 =?us-ascii?Q?kBMk3kgkyuM82jlT1dKjWU7BEW+HVmIjOUJwMLwXXMB0yTQPw5locGbaE3z7?=
 =?us-ascii?Q?+NXF5mmsh33uzNO8Wwpjgt1MCVH5r6lx9Y7s4B/AMJtGukhJh5Pv3Xfkehbx?=
 =?us-ascii?Q?SAyPR2MMTVV6+ajE8XklGSN7Yj4areURAu8GJjkOazJvaUvQJzyGn3KaHOG1?=
 =?us-ascii?Q?07qB8RyK//49sLXkfZyWL7WCB4U7jE1vQzZAVOCGzDvlyMspyB90aeRiPpxB?=
 =?us-ascii?Q?ufTZ4/IAURgaOfgttQyi3all4O02lilOTsU05crhNJQCuE0WRW4LyglVKOGJ?=
 =?us-ascii?Q?Iu4jPXKSmhY/wdWgXpUsHKcnE9IQkB4rNKa+54bercM5NljYVd9JslVGqqZN?=
 =?us-ascii?Q?++NQAMhgQAPzZ423Crs/GTSGT7/h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zh8xrqp2/f0K2uizCZZiToMLiq57pfuLsUsBAtUhQ65enwQk9+0kJkTPPbTT?=
 =?us-ascii?Q?4GfCFWXsAQFvKhJOAdYtSe4IgqtU6+IHkuEpaGRp9vkDYqeuYRIPkafo90Dz?=
 =?us-ascii?Q?RUop9XxKcYIw51vIoZQczOqikpVtR67xq2uT1LVQlECawWTjYhlgJFBvutbc?=
 =?us-ascii?Q?UxZCjBJjOBs4hrrgRRaJQkdsd2jxjgtdGgSEDZu2i/CUKpWdKMs+24/7OGwe?=
 =?us-ascii?Q?7ufQi2Amk+Sz7m7vkrEuJhmX9DCwG/JryuB1eQo6KEI7lHSVmVNHI08NZU2X?=
 =?us-ascii?Q?/15f0brg31x5z0ol1aZqw7j2c0sCLX4A8AhtolHbDB+hMLOsX8+4EXHutRBv?=
 =?us-ascii?Q?E6BHECQpfbGLVqIrw0MTzAZQzYB47biynNeahgGWrGPMkYsxC2J88FS6PETT?=
 =?us-ascii?Q?8zz4qI8pdCywSGCfu44nAVmmpkU3tQuqdZTlOz8/RZQGUS5q24xTOTrPc0V4?=
 =?us-ascii?Q?QqjyStE8qSu194fzpaGbZuyOuCAVTqHZdoDi7An8DDUcyGfLH417czO3Xwig?=
 =?us-ascii?Q?0+RUN5Jyjg1TXY5w2Jk3yJk3UHebM3pIpmSpU7USJU/bWxhvyizm7wcLBCsS?=
 =?us-ascii?Q?3zxr3Qlt/iNKxxpg72qmw3s9C6ZdPn8mhTLcUiTA63G9aOxf+ako0ACDgUbE?=
 =?us-ascii?Q?AStR5JiLnsi64rk3fR0LdzbCSlDUXio6TykLcNVKQCrqabHysC7F+gpKWzhi?=
 =?us-ascii?Q?a3w6RKU2U1aGG6Ap/oKMIvvuZbq3DBzfgI+F6ClMnmotlSkegfGiiJETNvZg?=
 =?us-ascii?Q?EPC9VMgu/PlPj2KXvh1CRvUGTr8LoLwxiiJJm0CphntqvJ17XHqe16BsRY1a?=
 =?us-ascii?Q?ScHqylP3n5EylO86bVVNjxULX1P8me/96YAQNabEgKeNQLWYaA0Qedetpb9I?=
 =?us-ascii?Q?pe8jBUg2uhUmoA7LJIkfcJ6fJ/ImP6GE9Gph8K+p5M4M0ZhaQ2TPv8DdzK0H?=
 =?us-ascii?Q?0H+iOjtL5i1wH6+7sehNYXZlstTbU1dEmtRhMl2FJ7vaDK9tfXg/2YQnhS1i?=
 =?us-ascii?Q?zZMAQTLWg3VDakoo5cvG1bZeeQaA+WuY3VczvOdKsy4wgJx1tmlG3DMsz9ap?=
 =?us-ascii?Q?i2TmZU1pvLzTaG9eYtSSRv7shhMNicBC0Wp5emi4C0YPo0wX0H5Mass2n9UW?=
 =?us-ascii?Q?MkBgUOyBUrVWBbBfNuE4Mo4G+ui23FUEpgvqmx0FlQ7UKCycuEzYlnFrtsXc?=
 =?us-ascii?Q?YZ+/BZFtWqwyFv4oOeGIZDQ7VBCuaP1sPdVJ3K2DJXvw2VxFVN9EW2PU7NnW?=
 =?us-ascii?Q?0vBj312oRzMwl0mqFeVT7Th9dY4p8oZ8Gy3681z0NdRjjlghqYlwqvtKMB8G?=
 =?us-ascii?Q?Wl/muPvfVZgY53Uq8Y+PGLe3GXkh+GdPlaRp/4HCX4ILpcYvzZjZnR8m/Q3s?=
 =?us-ascii?Q?TEN3OY9FGkj0YNzB8twK3MWk24hDWPxojf2AYs12+/W/ef/ysZjiiFZzHuv5?=
 =?us-ascii?Q?R5Vw5Mwa7AdI5Fo5ZzmL72e9Ukkd5Ml9NpacWT310GfQ0efHNeGlipziog2C?=
 =?us-ascii?Q?l1p8Km85PGmzS1gZLaBPr8MGP8RCivmf45/+inhXRShb961GznYGfMez8N43?=
 =?us-ascii?Q?cddw+ZHN8m544umN5x0dmbNrnSPnVyoPvSVI+BU7+9IEwDJ28FNcvbQCzPws?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab01c82a-731b-430d-f78e-08dd689a23a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:02:19.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ2909FxXtoUBheYwmWrm4bkfe4FKpZUiuVzuUAhDC7K64rjmd6nGPjfiDW7qJTqgYBVYT89MZ854Y0zp2f4KWfwiPzlGNujwtl/0hUl3n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com

Li Ming wrote:
> During review all new patches in branch cxl/next. I noticed there may be
> a problem in below commit.
> 
> commit a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
> 
> There is a new field gpf_dvsec in struct cxl_port to cache GPF DVSEC for
> Port(DVSEC ID 04h) location. When the first EP attaching to a cxl port,
> it will trigger locating GPF DVSEC on the cxl dport which the first EP
> is under, then the location is cached in port->gpf_dvsec. So if another
> EP under another dport is attaching, it will reuse the value of
> port->gpf_dvsec as GPF DVSEC location for this another dport. The
> problem is the cached location may be a wrong location for other dports
> of the port.
> 
> Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, Each
> CXL Downstream switch ports and CXL root ports have their own GPF DVSEC
> for Port(DVSEC ID 04h). So my understanding is that CXL subsystem should
> locate GPF DVSEC for Port for each dport rather than using the cached
> location in CXL port.
> 
> But I am not sure if all dports under a same port will have same
> configuration space layout, if yes, that will not be a problem. If I am
> wrong, please let me know, thanks.
> 
> base-commit: 3b5d43245f0a56390baaa670e1b6d898772266b3 cxl/next
> 
> Li Ming (3):
>   cxl/core: Fix caching dport GPF DVSEC issue
>   cxl/pci: Update Port GPF timeout only when the first EP attaching
>   cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()

These look good. I doubt a device would build different offsets
per-dport, but the real risk is more in confusing future code readers
that dports are uniform.

For the series,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

A Fixes tag seems reasonable.
