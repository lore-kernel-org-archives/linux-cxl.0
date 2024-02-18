Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB271B33
	for <linux-cxl@vger.kernel.org>; Sun, 18 Feb 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285013; cv=fail; b=nlQkK1dEkzbgDECF2ZBsVaq8v7pYiWvt1h5hWUHYA0Ih+aaSD7LEtu6SJBDLK+EuoktI5Gy3vjEx2DsGMCUApoYlAby8oxuPBop5Xu1dTsIMdPX0Mht36+cArc9717eAnPPFDXad8pJxDZuO2EuhzMP5Aw0MYmbBCmkwfB73obM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285013; c=relaxed/simple;
	bh=xwGz0HDVFSkZCq2rYNFeh9rNkoAH1Bacj6LU2pymoSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t08jsY5vqRRpbNlv2vVldrHUFb/sIRgsGs03Vpk94DnZJu/TwTu2hVMXeBMMDJ07zFiCtJdKJ9DYqafwLYQjsgjr4jlE00FJBQ8T81t5w2ZT4fHuPR1EMFTb+tKSOQKXU1Ph7ZDuHhVf3bFZDzHGcEybBFFKb/UwAoKS48/MBTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJ0fe/1y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJ0fe/1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708285012; x=1739821012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xwGz0HDVFSkZCq2rYNFeh9rNkoAH1Bacj6LU2pymoSU=;
  b=hJ0fe/1ywmdqpOUYy0ARCwFYs5UdvC+sMkigyi6wOGMnmGtrtgoqi2I5
   XTE8Tc0dUCb7vWVoYlN+avGoLXAISjj1RNbeHq85sBhW29rVIZbwJGHH3
   K2liEhKud/gJLTltUxLLo+Q6kWuoytOIOnE2lqbTjCRe4GpvIs1PAO7KH
   mTOWyg7Pl3BtBolP3OzxOll+S+eVzr+h7E9ceDd4RKfQJP67ZnefWlQ8R
   +9HPMQRG4dmi6qyaa8RFMi5dU3bsP7y5M2scHTGNESG6beNG1BicCMqlk
   flMKtj+ziVqv7cxIeiAfRhImkT1fW7fGnmSAJ5Murj9XaXVTbjiSMgOXP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2484856"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2484856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 11:36:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936169390"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="936169390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 11:36:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 11:36:50 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 11:36:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 11:36:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 11:36:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7pz5K2nyIS2fzg4/QKqZvIUgHJhrn/+XRLS5Ef5slLa381P2FqYiiUpkSwYFqjHGCMGyoy+5o+NLIrDyZjxMTj+KZg/Trx06sdNEtkK/MNi9PZz3uT0HqQ9x5hu5ujySgKyokHpDd9fJfX1c2EVF9Oxi78M93yi+vglufiQbqnYlDjahATmEgQgffuXfJ1M46ogsA1AOEQ6Xljmcx9JNyW2qYoMmQTJGDsYUgXFxmuNNQR/iaWUNIIw80PSh9wp5e79jRbEYC56X+mqFLRKUNyJwMWB8uTaAlQtfrWSEBxTFGLerARupcMixCT41YOYd+ArUScKUaOU8YT6jR222A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhb7/YK7HWjkjBiRCd4vQtGMmMZ979dZa8tNPaHOaLo=;
 b=C1BB4/6FsU1ildzEZXzF7HGpx2/H++OHyWlXKwDvlJSaTIsB9Fv5+a/M9zMHiCPhekWJ6nLaia7XJqiBiwzu9WqstB6I7C60RnwJHpsL/FaaKwvRjIt/kwS4jPw4em3vVKJGZ5nqUW98u4fA5Nq0Yd1FqLXKCelmPfR7MfCr9hPiPU1JbW9fEN1UcdOa59or4v1TkhpeSrwIF/Ps5KtAnw77VaT5wYazrjNy3lbhf61Q4iqiBpH8fZ1GaqEtoHy8GaK3VKOFWRCCFqSzQx5IV5eaJH3lK8sf4AjcrcoJwc2MaxXjbWC8cxLccqypu67OYSkOP4u4mJBWAXhlYPMcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Sun, 18 Feb
 2024 19:36:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 19:36:47 +0000
Date: Sun, 18 Feb 2024 11:36:44 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <65d25c4c43c29_16949a294f4@iweiny-mobl.notmuch>
References: <20240215232307.2793530-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240215232307.2793530-1-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a279ab-d0fc-4b6c-503d-08dc30b8f204
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YohPlrMiLmZTM/LTGQBqAxg3U80wsCBa0CVbAbS3ofhFvBdZeAwqg50sdSP89vDrjaO+88bzGejiAAok24QdyCNVUO5owb3aVEO4BleSXB/D1EnxFSDXqgOsNP2eehKxxpW5bzFpkjlzJTdKTy0fYlktybng31Ei/FUyD1d3Cap3m2HF9O7SLopNBgQavtxpB0jxOTRT+I94DbF+siYUpRaquzV4cAZhte979yMXRjMpw0pGg5/yFajXRv2GQvkwsbD0DX6nuMXUgPHx6tlSXBUpLbP9IB8yCOO2TA5Vl6fj6oScnATTW5RfP0UO8rQjo//3B0MH3ZbBHZ0xhT1FUm8M/4kMCE7DJ+XiHW3iB0a5+UKMtvlaQbc9SamePv5mzPCA1ZmQUUs5gatMZSb00lrGxL4jx0rZYjtyMUnLwIC2FGziqiunV9j3SwXGF/mbixfbYj/1HlX1taR+M/I/ga8+L3S+IVs9FwlX8Db6oaGYngCG8uO5hOYGb9iaxbO02zmq8PKMmFOr91lCRdw4B9u1in8uQkXf+yv9qzN9S0vykPbgZWVkYjFDlhpU3t7H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(44832011)(26005)(478600001)(9686003)(6512007)(6506007)(6486002)(38100700002)(82960400001)(83380400001)(86362001)(66946007)(8936002)(8676002)(4326008)(66556008)(66476007)(41300700001)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHfEy63EanJ4OEVbxl4eMO3MfdTJFDUUQ92wldkSIsCeMy7xwDNV7LF/+K2A?=
 =?us-ascii?Q?LoNs0ifUtlv/IOTBvIuqQGvdhfwjoBS+T2ERAHFAkhdZyLl1LPoOLL8GuDpu?=
 =?us-ascii?Q?BVAHdL1JwfVPM3anou4bsQ2Z948o7O6dW9eO9UC508KUp4kos6A+NuWat4PG?=
 =?us-ascii?Q?FC8zmoiawkj0Clt5ztOuygPL7/CtWsbX/UkBlOWMRUxdyY5vP4tssjEIdsg2?=
 =?us-ascii?Q?mberdiovD5vP0blvixBajI6e0sNvJXrknBU14BZTE2oMaEdk+TyQ8mbkBvfx?=
 =?us-ascii?Q?oijmmRfBBskMZG7nduQuV83/x0RlqZo9VwLc45MxV0ms5oB/eZ02nyNNweyc?=
 =?us-ascii?Q?v9NXENM4KbJA9RCFwyReDTZGfdGGrXPXOip7vEOroBj2NfDhhycrgubaFJyK?=
 =?us-ascii?Q?hsLw5OMmIGKwNbYg1NoUcnYOuY+p0Bre+CfkW9tmG2sutCQ7JyYv3T4nGQKP?=
 =?us-ascii?Q?6YwXWEvYMkEKYidNDM61ul14sZIdVM9y2MGN+cHOoraMtdOxX5QMEBAIDfia?=
 =?us-ascii?Q?24py4qFWINAudhh41tZ/pbTQjog3SjZkTlwJ/050fWwBh7PpDD4ljRaR0lm8?=
 =?us-ascii?Q?2YHKDloxtrBzAXZVPlMY1a1opyp0fUt4AOq2J78uhRZMeKL7/6z5/txIjN0K?=
 =?us-ascii?Q?IvD4XovBACdNuNoVfVS4UduPyNvkv+3riBsDrLfQwZULuW+zy2jcyfa1NZyG?=
 =?us-ascii?Q?QUkJMnxBd07b/NoR86y0+Lms6ZuwPF0iaT0YV4FR8veyxpeMq4pDpEOcY5nK?=
 =?us-ascii?Q?1St7IgIn6f9Jk6OVV4swfZO/+zQYjkRIvg/mEQoHf+dtb0tmfn+58aTGcHzF?=
 =?us-ascii?Q?niyJ6xHHgHv6Q+jVIn4Z8bebk4ZW+ZgAoe4fS3PSY9tMuk2lVB+M2xJNMWwi?=
 =?us-ascii?Q?YcIBtmycw0vYKwQ0luVtyjPV5UZxN4OQgIYKsyGVTa93ZhSgggz9XbaSFwTz?=
 =?us-ascii?Q?ThgrY8LuecRtt1ngsZEuS7nixQeoyu0cxSUQx6BgvxAcEY2yts5mhYKB9fhW?=
 =?us-ascii?Q?KZdYve9lVTWjOrdJ5HU66rn08ahcfYPXNjWNvPZqu+e5SzkjB6QatxiO6GTI?=
 =?us-ascii?Q?4H9sr+oca0XjgtGQI3zt4eBK4aHUVy7GQIwJ4llmVvKqo2JlnqVkXPOiihdl?=
 =?us-ascii?Q?E3B8bGtkQ4GmsVr1OCVmFyojVVUL6hF4C8B0EzVgImq1VX2blkePwu900vCV?=
 =?us-ascii?Q?vovPgLzSc8CPlnqlP/4FzaI0Ooj2RBkQ8h1wKj6Tq4VCTqvKoIqUB8OXSvKI?=
 =?us-ascii?Q?Hok4msXbZPJjOz2LOuCkmlGAdEj2wyvK5v5Tbk5PoX/r51XETl++wfJoYEdd?=
 =?us-ascii?Q?qpGK6cQhBgyMyBFfbG9sBymEsDqE0aDZlBaDhhqT+0DFDGAyneKlQ2uekw2h?=
 =?us-ascii?Q?bjXud0ociEpZfiifSs2XtHOA4mhrPIwl7emVQhgRx9Pthp4VyX+aRF2oPaIu?=
 =?us-ascii?Q?juAUuvPV23h1I6sS78UADfbcM0SFxdYqWq+U5Ju+uoLcMUwLAb0D1G+FtUA+?=
 =?us-ascii?Q?J2VEOskm3sr19+li3VhiJ6tpfnycqvnnYzfT2O2rdvF76VB6Ruh3XSeQcojF?=
 =?us-ascii?Q?P8Ku2wqXfvd6KzsNJlOXghlLIdWGP2ZFK0cfMDSw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a279ab-d0fc-4b6c-503d-08dc30b8f204
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 19:36:47.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+e7SgNgraJwl4cRFE+Js7wngjelvHaSr0Lih6G+iWQWVDTKtPVr28uLrZC4ORgEcmtcf89Y0SAF+UPqGQwtlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if there are active decoders before the reset and check
> if the range register memory active bit remains set after reset.
> 
> A helper function to check is added to detect if the range register memory
> active bit is set. A locked helper for cxl_num_decoders_committed() is also
> added to allow pci code to call the cxl_num_decoders_committed() while
> holding the cxl_region_rwsem.
> 
> Add a err_handler->reset_prepare() to detect whether there are active
> decoders.  Add a err_handler->reset_done() to check if there was active
> memory before the reset and it is no longer active after the reset. A
> warning is emitted in the case of active memory has been offlined.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
