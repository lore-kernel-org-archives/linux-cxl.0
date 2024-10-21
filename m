Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22951CF7C3;
	Mon, 21 Oct 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542077; cv=fail; b=eT+at8+VIyXKXkGmtM/2+CP3ReTYNs5RcQlWQmGFsCjytgck3DVc4oZXd3it8fOeakthxKIC5bxXLCptkIqgMzCNcho/qcwLsXmWL8PMtWLjGZ1f9mH/2zBVNGfarnv2OUZ19UvHFsJ2A6NSaM2rQ8bunxNfTXp1OX/56rsn5z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542077; c=relaxed/simple;
	bh=gWAHN8mvRlY+gzcYOb2Er1/hpl0jrHgv8p0jz8bKYDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7Gqpi4bkMsew9hCl7SF7b242dvCrlSTvQ1Lfc5UE5thFsxSrmfQoWgy1aTLNQEjDY+vpJwx0m6Uji0Vhz0/7RAEAAcQo/0DttombtE1ELLAMhMcFZ+jaMdwPtP95mc60EZOZUk5Okgmh9wSLfh5U3t/UzPn0BPlUp+h7pn8abM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxVxkm2X; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxVxkm2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729542075; x=1761078075;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gWAHN8mvRlY+gzcYOb2Er1/hpl0jrHgv8p0jz8bKYDE=;
  b=NxVxkm2XD3B/CHxU8DDn4fbfIEKfut10Ml/YhMFEFOn6t2qbJoLBWKdP
   aNgBmVx2rH2Al4+Ls4Ey1Kvc3/9cWOKm3RIiuk73RB3gKWFvDwICcg23L
   283xnm01hVaY05R1rZ9Y6S/FGlccdR0mP7QDagGNA7bKuaGF6tIc4FdtS
   ImCkBZ+9ZIIG/UHkjv9a3fvFY8+hbtnIub9EwKK71TK14z5N9z+1vMO8L
   vMCm/1i2Vn1eRNzYSXvqC29zS2KKwVomwCdC58/X53A8DkXYYDSBdH9ID
   iQ0FJFyLwW1UuRl4cjdiVuPpu7EkAdsJsF8hk6Vi7ahMc5lM02jagW4GQ
   Q==;
X-CSE-ConnectionGUID: R+2yo8IiTAqmZ1NJ1HEJGg==
X-CSE-MsgGUID: OkBQXVaPR4mw8bDi//LXiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28924540"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28924540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 13:21:14 -0700
X-CSE-ConnectionGUID: pUsLcEZ9ScC6KDShOumnrw==
X-CSE-MsgGUID: D/6xjwRiRRK98FaQpmrXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="110474281"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 13:21:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 13:21:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 13:21:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 13:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpUXAiJfRKzmHzVx9xntST3+E2XOIAuuR9hlUBsxWE33HHspoEYEw/e3E8yWwWAFZDzJWDN1HUK7o+BlXiFK+H7m6PvmSatUGfkSg1t/DrX6Z0XTZrs8w/WJH2UOgN72/70WawS9bXeemw3VXkD8oZEkHMBr0lqS24jh3h7LZZMLQSGWFPVUVh6aQ3QRt9f5XksjOmj2VCfYnbb/bhJ33z06IoInHp1Sr69+Su1l+sFqvElS7ZTaT0LcoHj7xdUnlr4ZGrUSAL7s5ji5PZUgr+NU2ASEDchYfLJ+I9TDMjIxBUybZGFPEAZsKO9OzIDF6nNot+h2ZJuCbKoE5dhtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDMpuWA78Ym3jkV9Cgz8DGijDORXhBqNxJRmiFAHPC8=;
 b=UuCrU9qnukyXeVRQChK6VP0aTNSEosTzsicRN20JXSrGiFGwbtPeSDGRNdG6Bye6ZDZvmcG4dpNEL/9F36GD0n66e9eTCbiq8GuoX9IOK0an/qEbsBqPejTtwdu5UgB60TIOL7RfbPH5FRUutjlIoe35+3ekVYKdEjmefiZxiokRsZmBF37Bacezc1ewiCTb19rL9QhPrDpZ+NosSHH734PvKeBmbarNtuW2XnxlGOIsDh0xv2lFL/pqb9/uWc9ZXybMFRVQUbq2kFMkHYy6apmdReU2+uYi8E+9MgrPbFI6yYaah0VCmE/GW3EdeLc2fNDcS1hJYMw9yuh94v3M+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7625.namprd11.prod.outlook.com (2603:10b6:806:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Mon, 21 Oct
 2024 20:21:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 20:21:11 +0000
Date: Mon, 21 Oct 2024 15:21:05 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <6716b7b18a1c4_b8f1f294aa@iweiny-mobl.notmuch>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
 <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f54c20b-5dfc-47e9-ed39-08dcf20de79e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6iTOxLiPezNFgB1Pf7iaxixmxYXK5sFEZ+Ccho/uvPsNab9Xhhg9xJ9XteF?=
 =?us-ascii?Q?YZsd6hchAVv7BAyuiL98GxZ16PC32wdqg+ittWIN3TRFFt3/n4OzRVEi4CxV?=
 =?us-ascii?Q?q4koKy9L+ZMqH/CRsABwtaYizIl+ybuT6Zji/8HGdGXUNkqRp/WS2IBezChK?=
 =?us-ascii?Q?4z5Kt1NT+hBsEq+pSpHQ5HFOi9n2qmfEorBAzoc96BsKsz4JisaOmNy2+VLN?=
 =?us-ascii?Q?GVlda1iPT+Blhfg124ep+n7Ppel45cdyh/7gXvLHGEkmzDvpWszO/8S2LE5R?=
 =?us-ascii?Q?Li1BLO/G5BmdVtdze336ISr9/KxwBFoJ53EQfPGtwGMsCSoIH/bx1EcHV5VX?=
 =?us-ascii?Q?IdZiG2sGL+JedKb8P25/YSQfZ2xl3bqwTJYqauSfkbT624t+6AhQKl1uswEN?=
 =?us-ascii?Q?r96YFHXlWXdT0uzsnkAwD66sZqFH21B1u5V+0IGl+HORyGox9z8UxS5qxNYh?=
 =?us-ascii?Q?CpoQQxhqo6KbjV5yJKaayxWUk8CC4/O1IZdE0f39xLgL7Fah54lGq/KnB1VO?=
 =?us-ascii?Q?VZJDTY1o4BbuAfecPOQS8wlbOTFrcR+R+eT5sdYHQy7dMuudmVzj2JhikorG?=
 =?us-ascii?Q?23RxJnGx7okqRNHqrWr5eSKC/u0U0F2m92yrZF7oeMFM+EWEOgopvzHzjW62?=
 =?us-ascii?Q?jkRuEBt1PdhnY1YZbpWetVo1b6kWhnavWQavxTD4dY69WYNJRYSuYkPx1xf7?=
 =?us-ascii?Q?jrPPPxv1L2w09bX9ABuN/YeSKdN2CELYenjVI5Q02czzC+g/yjznBIesPvkW?=
 =?us-ascii?Q?n0dKC8wI1PUCr7nhz4K/h5kg3ISW61QlJBEAcvmeH8/y99uWBWBLH2mzHib8?=
 =?us-ascii?Q?KdBuTlI7iajzEaiYiA7SzAr1B+czqMJSjOnxYvVvkCc6w0eFDsYQkGGS5N/M?=
 =?us-ascii?Q?Pxkovvt+IN2KkPIfmoC/hid/B6OsIEfC32sfUU/ioNuWFR+efMh2aprS/IgU?=
 =?us-ascii?Q?xSmCEFJx9yy5n5P1uOvgpba+2fb4+x17QxHH++IY4bNlpVNM+89TvBabjKH3?=
 =?us-ascii?Q?h2ryyVcMiDXeGQbPNBbnc+ayX1dTK7QuRRwoVCMR169FM9K/vDnjhvezwjdV?=
 =?us-ascii?Q?1zJ4i8x4PSf/7LPKk3uQTXkIrXxMd1Jj/g9jfXPGBlz0GJeBCotZlb3iyEMd?=
 =?us-ascii?Q?VUDdAo8a4CHLui6hxstcu5KZgkXXNKlrF08hhdfyhMIAr04XHqnefVh5zFJE?=
 =?us-ascii?Q?auts5QptjdDya7o1VR1OWKzgYTNcnvrGrY9o0bb+utm2/JRb+9PR8Q6xf6LL?=
 =?us-ascii?Q?B3QWKmPLuO8mJadAc0zi79kZ6UnRKHBeUNJYrw468J3crUMFVyyhvnY5uOBY?=
 =?us-ascii?Q?kXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/aJngY2xl8x9TNED4FJF+VZZTFXoBJoYgeLnqOeP9EvjpRg1DFqRAbTDRN3?=
 =?us-ascii?Q?d9pIL//guS5CWx4RKGcyNiZx3xGwwH2YKHNIze0LRnNIeiWJWMP07Apo5m0W?=
 =?us-ascii?Q?wZaMcqYFKmowbVPwoV15jPigjFOjLMTNpc4rVQcnVrRqkZLEnWWPEk2a4s3d?=
 =?us-ascii?Q?2YXyd7Q/GQFKWx2dFQPlA7Is0xRzSIz9/oMjNLvc9GpaB/pubogoboq0VKSb?=
 =?us-ascii?Q?FJuhmZucBwvcfPafZu1K8JCZW2pRIpMnkhB3TDAqYuXXwrB16+/Dy5cG6o01?=
 =?us-ascii?Q?bUBtAZ10K2/OHCyAtWut/Cs19ECkb8c5za6kBYUIYmlsgGxVjJofrXiA1zXn?=
 =?us-ascii?Q?PGg/Qep+Ay8mjbh/ueLdjPuDXiRboGgalEdgSgnhTz8/pkjTNPk4FahLTb9n?=
 =?us-ascii?Q?bkEi7yRNq+WjccYVJn5EYKmoMCZbyjBR/wFzscnPYUH0CKaId7b6IfIoQX1/?=
 =?us-ascii?Q?XYfjCLtYXLK+Yuei7XQMJhEXFKqjDmguiYHwwYiI7SnkozrGGZvknYVCr6XV?=
 =?us-ascii?Q?16vCSXI3bbCBDI6zWsZLdWwffh4UgkymDjJaeymRFsA/9dXfkwt5XBXMqywF?=
 =?us-ascii?Q?PjZMSVXfb5Jwcj3ITb5SMX8Eulfcj83rV73w+qDzUkB0VdJut7iUVDXRr2PD?=
 =?us-ascii?Q?WkatsXL4OEupXu+YiDQn5NVMl+TNAM87VEkbyCqa3fy5/5Pw3YlPX0ojYeYu?=
 =?us-ascii?Q?ue9qV9wWFrDmTsMgMIJi3J6QzTvIGY8Pz1D7Wac7qi9zJCD8IlD2cGTJGgFm?=
 =?us-ascii?Q?+djtadaDnO84U1RdEKrHHhWz16tuACSZv3zepEBCw+7g28EUI6GpznqdVb/p?=
 =?us-ascii?Q?XZpAl59lL7jJ5KfPgGgfxqfyPGPFg1R/YaROl3GJIJKEYG5zxAX94uMNxYPf?=
 =?us-ascii?Q?lKuX8RnGVcOQ4lfthBfC21B65CUjQQCEHwQ/BIHSfRKX246PIGicTYwuf46S?=
 =?us-ascii?Q?6ssMz6gp0YZZ/lWYlNh8YTsLJ8lfApF8jvA8wVVQaibS6TlK4d/aTMg8Xd3e?=
 =?us-ascii?Q?A4kCfOKQTp8UYsex4Xf9Z0iWL06zerI6YnIq7SOjEiWIm4LSQYi5pyoasRLG?=
 =?us-ascii?Q?YIERI2rrZwOEflXW3Suzv6s7WZ3/kAbOUOWAWf7Q3ez+dv3ze+FB0YR84feF?=
 =?us-ascii?Q?LlYRbxacVSFMv9BO9fVTwe3WjeTiprRQsI/t7Yj4D+22/JSWEQL4z+NwZmkS?=
 =?us-ascii?Q?KZAT3FHk8KaqzUXwxsF56TSHHqi29KyeXB9tWzRT9u1adLjWlu0o8VwojpPM?=
 =?us-ascii?Q?GYxhD8grD/e0MHy58gKRoodrqnIZKsnOtAaCQoXXNrFaCrvOwn0Hen6vsMjX?=
 =?us-ascii?Q?8Wg7j+l2lRJrUushm0AxgY8iPWqDsgLpOHMTtyFqMDdkB+DVrKwlY+Nfdiho?=
 =?us-ascii?Q?Z3PIRNwu9dcGS7HWztMx+H/ePOx3wfxq9662c3sp+U6YeB3duFmD+LAjbbu4?=
 =?us-ascii?Q?8O8bs8oCPIrSmJu/VIoHsRhhoRiTNpHSSx56BRaxzLfPnIAl1mOcziwqsQi6?=
 =?us-ascii?Q?PuCcnlMTXZI5BzevR5EnQIcv9a3+9uCIp8fYdAlQDmLPiSqm93writJHUe3N?=
 =?us-ascii?Q?viIP4NV0A1GfYFB4XI0fCEL6AexTzkJp4OjwxU9d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f54c20b-5dfc-47e9-ed39-08dcf20de79e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:21:11.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex76ff9xiR3jwoA8QdRQdUIUXhdluFB8KdSNbOm/MYFzWvr39G2n1oKh4zHcNOuQZgd/Z81m3Ndx4LJv9U02gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> Hey Dan,
> 
> Thanks for your review...
> 
> I want to confirm with you
> 
> 
> On 18/10/2024 09:20, Dan Williams wrote:
> > Alison Schofield wrote:
> >> On Wed, Oct 16, 2024 at 09:52:13AM +0800, Li Zhijian wrote:
> >>> The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
> >>> PCI/PCIe CXL device only while cxl_test was implemeneted by platform
> >>> device.
> >>>
> >>> Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
> >>> for cxl_core so that the cxl_test goes well.
> >>>
> >>> Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
> >>> will cause a kernel panic with calltrace:
> >>
> >> snip
> >>
> >>> ---
> >>>   tools/testing/cxl/Kbuild      | 2 ++
> >>>   tools/testing/cxl/mock_cdat.c | 8 ++++++++
> >>>   2 files changed, 10 insertions(+)
> >>>   create mode 100644 tools/testing/cxl/mock_cdat.c
> >>>
> >>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> >>> index b1256fee3567..ed9f50dee3f5 100644
> >>> --- a/tools/testing/cxl/Kbuild
> >>> +++ b/tools/testing/cxl/Kbuild
> >>> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
> >>>   ldflags-y += --wrap=cxl_rcd_component_reg_phys
> >>>   ldflags-y += --wrap=cxl_endpoint_parse_cdat
> >>>   ldflags-y += --wrap=cxl_dport_init_ras_reporting
> >>> +ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update
> >>>   
> >>>   DRIVERS := ../../../drivers
> >>>   CXL_SRC := $(DRIVERS)/cxl
> >>> @@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
> >>>   cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> >>>   cxl_core-y += $(CXL_CORE_SRC)/pmu.o
> >>>   cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> >>> +cxl_core-y += mock_cdat.o
> >>>   cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> >>>   cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> >>>   cxl_core-y += config_check.o
> >>> diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.c
> >>> new file mode 100644
> >>> index 000000000000..99974153b3f6
> >>> --- /dev/null
> >>> +++ b/tools/testing/cxl/mock_cdat.c
> >>> @@ -0,0 +1,8 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/* Copyright (c) 2024 FUJITSU LIMITED. All rights reserved. */
> >>> +
> >>> +#include <cxl.h>
> >>> +
> >>> +void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> >>> +{
> >>> +}
> >>
> >> The addition of file mock_cdat.c made me wonder why this wrapper couldn't join
> >> all the other __wrap's defined in test/mock.c. I tried, as you probably did,
> >> and see the circular dependency. I mention it here in case anyone else has a
> >> way to simplify this.
> > 
> > Yeah, unfortunately symbols can only be mocked across EXPORT_SYMBOL()
> > boundaries, but since the caller of this is internal to the CXL core it
> > is not amenable to the wrap approach.
> > 
> > So, unfortunately what this patch does is break the expectation that
> > cxl_test can live alongside and not regress any production flows. I.e.
> > what this patch does is replace
> > cxl_region_shared_upstream_bandwidth_update() for all use cases, not
> > just platform devices.
> 
> Yes, that's true.
> 
> 
> > 
> > Compare that to tools/testing/cxl/test/mock.c which arranges for all the
> > mocked use cases to call back into the real routines in the real device
> > case.
> > 
> > Given that I think this puts the device type check back in play.
> 
> Just to confirm, do you mean add device type check to drivers/cxl/core/cdat.c
> 
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -5,6 +5,7 @@
>    #include <linux/fw_table.h>
>    #include <linux/node.h>
>    #include <linux/overflow.h>
> +#include <linux/platform_device.h>
>    #include "cxlpci.h"
>    #include "cxlmem.h"
>    #include "core.h"
> @@ -641,9 +642,13 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>           void *ptr;
>           int rc;
> 
> +       if (dev_is_pci(cxlds->dev))

Did you mean...

	if (!dev_is_pci(cxlds->dev))
???

> +               return -ENODEV;
> +
>           if (cxlds->rcd)
>                   return -ENODEV;
>    
> 
> or
> 
> tools/testing/cxl/mock_cdat.c
> 
> #include <cxl.h>
>                                                                                  
> void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> {
>          for (int i = 0; i < cxlr->params.nr_targets; i++) {
>                  struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
>                  struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>                  struct cxl_dev_state *cxlds = cxlmd->cxlds;
>                                                                                  
>                  if (!dev_is_pci(cxlds->dev))
>                          return;
>          }
>                                                                                  
>          cxl_region_shared_upstream_bandwidth_update(cxlr);
> }

Couldn't this be done on the endpoint call?  (Making it non-static?)

int __wrap_cxl_endpoint_gather_bandwidth(...
                                         struct cxl_endpoint_decoder *cxled,
					...)
{
        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
        struct cxl_dev_state *cxlds = cxlmd->cxlds;

	if (!dev_is_pci(cxlds->dev))
		return -ENODEV;

	return cxl_endpoint_gather_bandwidth(...);
}

Ira

> 
> 
> Thanks
> Zhijian
> 
> > 
> > However, instead of checking "dev_is_platform()" check "dev_is_pci()" to
> > be consistent with all the other CXL core internal functions that exit
> > early when passed cxl_test devices.


