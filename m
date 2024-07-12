Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705A10E3;
	Fri, 12 Jul 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746203; cv=fail; b=foxvcOaT+ADq0w/lpMRL97vaRLaKRJTGpdmprQi0d27uWjiz1wjDqMFGJdaBqh2HIg4m2/wSqLJTzIALWMQEP/BW0CMlUQ2RVo+VEUgTWbkWa+k2RVUKqLqzjTx3S92Cd3Ysr5CYFIxpuY0L18Ht8tR4EfkzmFCx3lwFqPeXs80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746203; c=relaxed/simple;
	bh=qou70AsxI0lKZBJZIIkifnPbU1XyQrxpaABRJ0dk/OU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CfzkWsgjzu0QomToQAIxL069PUE38myQtppUTSVzTQUHQjIfueRY8aYiBwJrIdHfMvAvbe7Qs/7UpXlIabYQ3SDvvwXtwktjLOg4h7QBnBo/lpIjzCCkPbSxw9YMXoMT5M+jQ+RUIoaHjlDyIZg1FLiRpZrS4bXXUyIsMZ+6LBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6+Ws8Gx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6+Ws8Gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720746201; x=1752282201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qou70AsxI0lKZBJZIIkifnPbU1XyQrxpaABRJ0dk/OU=;
  b=D6+Ws8Gx5uGt6cq2c49OGWZoCN24oq5i9h4Zwa8CMlQgQLONE4qsDWTB
   w0jDZyypMAgN78FQwst2gV5qad9fuZPt9i4DWHR867vGgHUv8exfRQv+v
   4ndCrB8vdB5yXBFQF5TFxWuqznIZ5PM3pAEgr0aITPSE1GcGkB8+WYJiF
   wjWmX0BrMPPexRODUgbLsSu3VbgkMTvp7t89JcJY9UrxxQYkmJeSSX2ES
   jvcZF4G4F4qHpbMgGWpHUlXZD5NtBMKN4YaR+eXjo6xYlMGxb3Oe6Z3N6
   MB9chYOHfKNKQyd7eRnwpw2COcpC7JaiM7iHt8iRKZIp/f06M+jKW27/h
   Q==;
X-CSE-ConnectionGUID: xST4BImdQdme67tJUy4Ueg==
X-CSE-MsgGUID: KfMfcKb1Tk+zL/JhK/iosQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18309018"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18309018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 18:03:20 -0700
X-CSE-ConnectionGUID: DzbedKGlSc2isuE+DhccpA==
X-CSE-MsgGUID: Nz9fSpZ0QUGC7vqcUbUHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71952015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 18:03:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 18:03:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 18:03:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 18:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtGkmmR4AxsJNgZjAILAsiAO/dLckwx/esKMrRvbZXvfxOeg5rq3r739Aly4k1zP5NDccZ2GTU5gtWC7G+DQX4kvCgcnnaLSsTE1xFzTlAyPYLS5AXVnPMpktdI15GZV373lqu+AL2PeR8QoUB4tfBJEXe+2SEbtKQrwO/JiS0U+W1VI/Zd2SrowWdyptIDDZiUlAcH0tFxQj4xwGxPaQPZG2aI15tVvHD6O3+RnLFEI0fPOteS74kYUCrS4u/AzCMpzT8xXAFOmuqbyfMVgBYPBDu0u2jMTUOwlHJdTiKiI4F4TxbeoWFCitDQqwtgb12n0moZQDQ8W/D481UO6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUQl0rYUF4+UmznB56wkyI+K1YpNCX79hv5TR79E9rk=;
 b=UwXXtI5UF+JL9XpDpiFWoea+N6TMJNgC0T7mMgIJmxNYNpfeJxnxWxo4EVVYfpbe5mK5djIv/Uw/96ka69cvSerwuAGsJmtbxhzFhBuZ0Lmh+ghmQR8AfRztbaMeVTxc6CXLDNOExnTA8zhvmssjTjQku9yKY7xW7xavoH89vD0rKav2AIV0G98MfZS2TjJE0aBNX7G/tQ02LS6D+fqJO0Ro8pGPsdMeTDdCH1D16KJd3Xx+lJVBJhM4LUqjTRJ1FNpGSvjXu6gOdyFrCTGIMUVOm8dIhny5h1YNYtKzMNvS7f0FGYJQtKU2q06jHP9LgagUJwPvYMMpcNjY/cXgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 01:03:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 01:03:16 +0000
Date: Thu, 11 Jul 2024 18:03:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: Re: [PATCH v2 2/5] cxl/hdm: Implement address translation for HDM
 decoding
Message-ID: <669080d1753f1_5fffa2941@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240701174754.967954-1-rrichter@amd.com>
 <20240701174754.967954-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-3-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 031dc100-c036-4442-718b-08dca20e6951
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fmWyoBo4oql15QlZYxQ4pFiDsMeWviGI47DQUx4tzY6D5Sed8Hie309vP0YC?=
 =?us-ascii?Q?ToCjoIDT9VZDCfQmz7DY3QSqqM1jKpB3F/L0Yrb+xetjrLwNymFHluUR6Tsb?=
 =?us-ascii?Q?JRKUNJySgEMMpewM70zI/CkahBQp6AtQuJ9DxUiO/fvWq4wjC3fhM4TOCaCc?=
 =?us-ascii?Q?qh5TImYCTBgxx/P3Hv/DO66TpGk3mPfKSST5wxvaRBWNkRjdFHd6qRbqoP28?=
 =?us-ascii?Q?yyt4iWxTqxQ6UUvpf+UzHEJoa9DzQgZ2dob+Rxh6JzOstdPFI9VK/9YhbvUj?=
 =?us-ascii?Q?LWq7OLQpeSqjhZSRergGbyqNGIFlBePWeFGveHDgaOkgX3B0N9vnZUAxTk98?=
 =?us-ascii?Q?OS6gWToZsbQyefsrwGZbc5/vv2CVRKjQHorDgRzGGoYJwvaYg50UzG86TDGA?=
 =?us-ascii?Q?iZwr6Jl+Pf7UrtB3BVKpEkvp/ImKRAv3/uJUsZfOW9CJsxBD3qO/3tIKmhe3?=
 =?us-ascii?Q?2PsOE47oXrGnNbm/KondM4+SLF6nDvSps86OCjhJUj7JTHiV1PU02efjEmHc?=
 =?us-ascii?Q?y8ZcoDGDZVWnxGEKUDMn2bueDCX3qKvIly7cTl2jp3oyEFX3FalVKL8mgRGT?=
 =?us-ascii?Q?jRgzKa3jMSACfHS4F8iAc7YLNW+PMlNNFvCOzuzdmcX3lk40dgHb2lmiF/dM?=
 =?us-ascii?Q?L46ygjwYHeUTo0lx+jLLOAEXBVXFY+RP+HiLIa7rVT1mR1kutnQv+ucUOAK9?=
 =?us-ascii?Q?WS+NOBl5W5lr91hz0U33ojzJrbUlJXhq2S7+5ov4G5RoBMEhwuUgUGBjDeHY?=
 =?us-ascii?Q?lwIY1skCyDDw5+WO/8bBlRfV3Wq0YEKVXxdnZGspzVQhD7GW+Raa1Mm4mnFg?=
 =?us-ascii?Q?+LpFBVLZz0Lsokd0hKNmJ6HzAmfsDNrDCWfZG9ou/BY0Ola5Iyb/VnYObNXB?=
 =?us-ascii?Q?CDzTAEKEeRdeAoMp28AMA99SbHqquAmFEI7s2chsxdIDFEqdRWi9lCQkZ3/m?=
 =?us-ascii?Q?zSGWs/QGrGKxfouB1BpFF8ca7BO3rL23h0f2q7tvyq5v61eXC2ThH10e6rYF?=
 =?us-ascii?Q?naUxUIAkqV0dD36FbWfs0UpLX5Ym8LgFBXDRLAOQvbciDYMXdWyBcnfLuxNg?=
 =?us-ascii?Q?DcM2U+7CBrfsgZqLL2ZrkJnMaw/QqRWuWOWRAEYAmiXhTvn06EAyNRhGRVzN?=
 =?us-ascii?Q?BkjFpH9oilw1jaHOdGDwV4m03giNU5Cinf0bfb/P5PLo7gHAHN1TuxHDnKeK?=
 =?us-ascii?Q?T3FcsHdg4cA8EXAD7wLcm0jynbI6zekTWTOTrUYVzLLWF1MI01IffwztwQgH?=
 =?us-ascii?Q?Q/yrhBjU0Povf6T/ugXArNdi7EX6hJYW75F29cdjbwg/OzDtwD3/SkN2JdPE?=
 =?us-ascii?Q?llM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTzyJaDS4eyeNeZfJuFLuK0wMz+u0V7pWKg4DAUgnZWVUuh/mU8YENKm+7+8?=
 =?us-ascii?Q?rEDW9jHGt1IX2Omi4xnXw8MBcecxUFvET75SZeQVJvXxu+F/caqKN5m+vREq?=
 =?us-ascii?Q?MKbN3PNPqCwRVLjXnot3ffEkXubA6X+qHE36LdGMkopzSHDYn3LvUKu2J0SD?=
 =?us-ascii?Q?FY09szQIpO+BTGQOjAqL6EYn3Z2v0tGKZcwIj+VARqUEw3D32f6erA3VES9j?=
 =?us-ascii?Q?W/JHuIfMVDv9/Uy26roGxNASHxap+uRHdnWRQUnQjKzBx/4gBe/Bl3+x7ENi?=
 =?us-ascii?Q?8G5fU2U3x0csxk9Kl6ProGrwquUIQpmkR/PYzCtZNhihlkxZDaTSFJyvMIbk?=
 =?us-ascii?Q?8X2HHN4cCRCYOdEWSFu2Ewom4ukfc4jMqlxOdOa6iYlPV+aIL0Eop+8/oesq?=
 =?us-ascii?Q?Y+5GMY0OZwiC4J2gmMCXDhFN3pZ2iu4/OFoK6rpO9cqbpzdajUIzLLDb5RSO?=
 =?us-ascii?Q?I9TkSmseZK8eRoZ1HfLXHVqCLD8VjNexpgDApP1g/GN90qyiK6OIp+TPYy5M?=
 =?us-ascii?Q?K2jI97ZHekZCW49z9gSXkAygs31wdi8gUFBy5R2TVSCkv089iaKcqQDDoPiO?=
 =?us-ascii?Q?CXWrmeq8TT+cpZAzXbLNgqLlxz2FdlgZdJeQMvIJY7ZLd40uLl/JhWJXh42W?=
 =?us-ascii?Q?zX6JvNctkwjmzplKaXkoQIN9r7HzVtfnb07J6bR1eDlIIJuRG+dUhnBJQfNl?=
 =?us-ascii?Q?ecNLyrrgmH2Zu9OCd876Pxs0oRKDJxTMhuv3lXA4C4eLI3xrDWsYtXumEdj0?=
 =?us-ascii?Q?6O2LGdr2DRNX0TCbvFGh3eCPz4uVHqmHmzUNjsWGrAAzg8Xg33lfYXEfamkn?=
 =?us-ascii?Q?U/KapexHD9xQZdQ3dZfSTPPhQ0+ApDzS2mZ1+K4J0vWFBLVifaHsdzJdKU7w?=
 =?us-ascii?Q?J4dKwDBnCCgvcKm1Bjx9EuRw/DauaEhWb23WaJBocgsUy0Jp4EB2xHCY7mkO?=
 =?us-ascii?Q?iplo4eopIszRqZMCE7tGVK2uiucDyIkRpNzeRzeGw3P0PtU3UuG+qiONU7rc?=
 =?us-ascii?Q?MskCP32VcwcuU13KHkHsdbXK03G/ehrkriOBcPBKwvdjvLyOYQprDKnsP1su?=
 =?us-ascii?Q?CxE4IqbZmLmpoOkggpRP3n3U+qVB5NirOUKaTlAFcpfM5tYGnQM+KNzlhslQ?=
 =?us-ascii?Q?Y0RZO41y/+1zX03MQjiXbG/nUNg9U8WCSz7Rso14VIdJAj6wdlPJE/m/xc8L?=
 =?us-ascii?Q?kAiYS9OFK3fgoP6JqXDNXdsc+V3lAOxQYeKVtWoF7OaSBt/tVm69Hf9cIhX6?=
 =?us-ascii?Q?07QtkcqSR20J9FxmrlrrK9gMPcPeCuOPVdMtkVctgZzffcD3A+dBXw8RgtNs?=
 =?us-ascii?Q?HjQdomxI0SVUxwM5EJROeO/B9SAIuDEsiNf9EHquVT8L+B/TeBD403D2lCKl?=
 =?us-ascii?Q?NmHjmIO+sggzi3E5AJCqpY7F0u89Uc8RvFnM1dKlCQbsFbEP2v6+5xO+ILNg?=
 =?us-ascii?Q?+56UF3jNTwAOLi4HOd8qFCpwuFwyvXL88VErPfdAo2Y24TRKRCL73KSc5ofn?=
 =?us-ascii?Q?phXUwHlce5n/8DaiTqxJQGv7h4yuRbFhISqWEkmaOuGcLYxwN1DvOPd+SrZG?=
 =?us-ascii?Q?sYCV0+mj8VGPRYVP9qMMKqVXEt8XJ/8T8+ftOEzHRfyytRW+4Bwn1oA1jy1t?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 031dc100-c036-4442-718b-08dca20e6951
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 01:03:16.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4r+JUzbFB8aBX53nO/UqhiZyFrBdexMNQ8uP7bgpHrvXu2FR6brjYEOd8AnNqXEkrTow8J9ElxVfA1juI/1QZG29uJBW6RQ42SeyfRIrryE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> The CXL driver stores all internal hardware address ranges as SPA.
> When accessing the HDM decoder's registers, hardware addresses must be
> translated back and forth. This is needed for the base addresses in
> the CXL Range Registers of the PCIe DVSEC for CXL Devices
> (CXL_DVSEC_RANGE_BASE*) or the CXL HDM Decoder Capability Structure
> (CXL_HDM_DECODER0_BASE*).
> 
> To handle address translation the kernel needs to keep track of the
> system's base HPA the decoder bases on. The base can be different
> between memory domains, each port may have its own domain. Thus, the
> HPA base cannot be shared between CXL ports and its decoders, instead
> the base HPA must be stored per port. Each port has its own struct
> cxl_hdm to handle the sets of decoders and targets, that struct can
> also be used for storing the base.
> 
> Add @base_hpa to struct cxl_hdm. Also Introduce helper functions for
> the translation and use them to convert the HDM decoder base addresses
> to or from an SPA.
> 
> While at this, rename len to size for the common base/size naming used
> with ranges.
> 
> Link: https://lore.kernel.org/all/65c6b8c9a42e4_d2d4294f1@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 69 ++++++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxlmem.h   |  1 +
>  2 files changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 605da9a55d89..50078013f4e3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -125,6 +125,17 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	return true;
>  }
>  
> +static void setup_base_hpa(struct cxl_hdm *cxlhdm)
> +{
> +	/*
> +	 * Address translation is not needed on platforms with HPA ==
> +	 * SPA. HDM decoder addresses all base on system addresses,
> +	 * there is no offset and the base is zero (cxlhdm->base_hpa
> +	 * == 0). Nothing to do here as it is already pre-initialized
> +	 * zero.
> +	 */
> +}

I am not grokking why this is per @cxlhdm? More on this concern below...

> +	base = cxl_xlat_to_base(cxld->hpa_range.start, cxlhdm);

Would prefer this operation is called cxl_hpa_to_spa(), which is
different than the cxldrd->hpa_to_spa() in Alison's patches. This is
about an HPA domain per-host-bridge.

The cxlrd->hpa_to_spa() is after the address exits the host bridge there
is a translation to a Window interleave. Both of those are "SPAs" in my
mind.

>  	size = range_len(&cxld->hpa_range);
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> @@ -746,22 +776,27 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
>  	int which, struct cxl_endpoint_dvsec_info *info)
>  {
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 len;
> +	u64 base, size;

Please don't include renames like this s/@len/@size/ in the same patch
that changes some logic.

>  	int rc;
>  
>  	if (!is_cxl_endpoint(port))
>  		return -EOPNOTSUPP;
>  
>  	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	len = range_len(&info->dvsec_range[which]);
> -	if (!len)
> +	size = range_len(&info->dvsec_range[which]);
> +	if (!size)
>  		return -ENOENT;
> +	base = cxl_xlat_to_hpa(info->dvsec_range[which].start, cxlhdm);

Wait, the dvsec_range addresses are read from the registers, they are
already HPAs, shouldn't this be the "to SPA" flavor translation?

>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->commit = NULL;
>  	cxld->reset = NULL;
> -	cxld->hpa_range = info->dvsec_range[which];
> +	cxld->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size -1,
> +	};

I think it is confusing to change the software tracking of 'struct
cxl_decoder' to be in SPA, can this be kept as HPA tracking and then
fixup the locations that compare against SPAs, like CFWMS values and the
iomem_resource tree, to do the conversion?

>  
>  	/*
>  	 * Set the emulated decoder as locked pending additional support to
> @@ -770,14 +805,14 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>  	port->commit_end = cxld->id;
>  
> -	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, size, 0);
>  	if (rc) {
>  		dev_err(&port->dev,
>  			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> -			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
> +			port->id, cxld->id, *dpa_base, *dpa_base + size - 1, rc);
>  		return rc;
>  	}
> -	*dpa_base += len;
> +	*dpa_base += size;
>  	cxled->state = CXL_DECODER_STATE_AUTO;
>  
>  	return 0;
> @@ -787,6 +822,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
>  	bool committed;
> @@ -823,6 +859,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +	base = cxl_xlat_to_hpa(base, cxlhdm);
> +
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + size - 1,
> @@ -1107,16 +1146,20 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	}
>  
>  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> -		struct device *cxld_dev;
> -
> -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> -					     dvsec_range_allowed);
> +		u64 base = cxl_xlat_to_hpa(info->dvsec_range[i].start, cxlhdm);
> +		u64 size = range_len(&info->dvsec_range[i]);
> +		struct range hpa_range = {
> +			.start = base,
> +			.end = base + size -1,
> +		};
> +		struct device *cxld_dev __free(put_device) =
> +			cxld_dev = device_find_child(&root->dev, &hpa_range,
> +						     dvsec_range_allowed);
>  		if (!cxld_dev) {
>  			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
>  			continue;
>  		}
>  		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> -		put_device(cxld_dev);

Jarring to see this cleanup in the same patch. It deserves to be its own
standalone cleanup patch.

>  		allowed++;
>  	}
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 61d9f4e00921..849ea97385c9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -856,6 +856,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	u64 base_hpa;

So, per the concern above, each @cxlhdm instance exists within a port
hierarchy. It is only the top of that port hiearchy that understands
that everything underneath is within it's own CXL HPA address domain.

So I would expect that only place this value needs to be stored is in
the cxl_port objects associated with host-bridges. The only place it
would need to be considered is when comparing iomem_resource and region
addresses with decoder addresses.

In other words, I think it is potentially mentally taxing to remember
that 'struct cxl_decoder' stores translated addresses vs teaching paths
that compare region address about the translation needed for endpoint
decoders.
