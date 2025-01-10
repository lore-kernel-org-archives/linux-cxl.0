Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2D214202;
	Fri, 10 Jan 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530521; cv=fail; b=PtV0/cOcAE1q7MkIIZtxOlhKSJStgBnfyBNTdKmJIeKVsNJ5+qMYcDLA4WXxOm+UmFaqx4yKN21vjjRBw5E9UHl30rwnGviR1VcZIGcYZkHrRg1I4tZbjRMbSF8r8avF/eM874WyYJjZzugKf48dPuCxnE+ErwFLtgJFHCiIRgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530521; c=relaxed/simple;
	bh=0WxgVPmRFQ351d6Z3Sq/w3ESJ1+743PW6ke4pE6DAEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1pEyVlj9I5P0Nj++2+SAIiJRK0kyvEaO1lALSkMlFPG3kDeLJCbO9e3kZ2826C90j2WtoADKo4Q2kGpozpokVCQ5eV/Qjo2uZKwOsIDV2UV2Ou4CS8mA7ZDZpuBruJeRzfqaw/d4r/28EFPMcQCMw6/H0upyPeYCLxEqNh0k9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlmlAUCt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlmlAUCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736530519; x=1768066519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0WxgVPmRFQ351d6Z3Sq/w3ESJ1+743PW6ke4pE6DAEY=;
  b=AlmlAUCtxR1D32ygeuPMoSXfRsNANboCXI9RaJSvZgGfnZea69BmHYyV
   gYp63yppAfT8cb93CbDY0+R1fMkXWn5LoEqA3NSBxB7aI3iqlAKkksnZO
   exRXuGAGvEeWFlaVCGsn/KusOreZxK4fIG0BDxtb+dz3zf6Ab5+c8/ETx
   Xqx4jdtYWD7iEynZ2JWiVYneOfGZcI5XARTNZ8Bzkylatvja1ESZRSR1R
   YHUGTn+HTvXV9Q4TvG84Sln+rsAM0TNHPSdi15ZyuPMn4l2KRJy6cHdsC
   gPPoTUQsJJixGpIvJbGI/4OwhWLZnnXSoOVApHgzUFdGlFs8EJUKCfSHM
   A==;
X-CSE-ConnectionGUID: X1puT4hpQWavUvQMOHr/QQ==
X-CSE-MsgGUID: ZMvdbcyeS6iQ56p9G/PLKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="54371596"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54371596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:35:19 -0800
X-CSE-ConnectionGUID: R0fUV4KdRS6ACqw774GdJw==
X-CSE-MsgGUID: O20eQjvSTCuLAsDXuJG/gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104669809"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 09:35:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 09:35:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 09:35:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 09:35:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibsmRKfx7tvEjSLuz82oth1sY25L6CPPFC3wtqB+3Jmcg3UyW/AIiZeG0r35SklNwNaY1dcoD8hLP/fDjnKW+8GWk3s+G+V8os4jv0dPL4owE3s/xumJe3u/tLNtUa6q9U038zlk9D/NglVrClGikNnCBdfyvjjyco8oyyFMmuKOXwH8oBmR/3ggRMPxIa7hgdkERpsT4dUDUZ248PzUINAlVRUZF2cCxxtL01tB3LwIAiv9tX7TjuHNfNTZGONaPLoGrXdYYVWsbhFqojRol3xq62wFu2sTUI6BdpQdrkMqo3NcOlSeord5FJeawz62wg4UtiIhUGKV+VmYYeTfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgMmaT9mQg9Hra7iAx6Mo5flJl2wVDE6LYfnfxn5cNM=;
 b=F6mEDHoqXnEP3HE9LxAHtK2REZxaYqE5lMMr9peZCTHdX2fi1T1AL0sBEGXWN8i3h4aW4szn4sMxf+TOOUhC5ZAfOx+LrF5mPNrNyMHugWGzCb9oe6GnYa0FGnjzdExqkb7MFp5lDb0dJnt1qfqC4YRzqCX+lJzgV30nG32sm1Dlm/YfenBfg0C3CprHmJDYKn9f/uOW/Z68g+UbrjP+GCAZh3RWHvYCSkff8MNzexT1OsVMVNCN1IZhQ+qwqCpmj43kWWha7lsPT+ybBTVKMG0HFtwzpeo9a2eS5CU8UIbyCLhtl9KguHILzgliwWRxs+e8uWBmcBnRJXn4j7Iplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 17:35:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:35:13 +0000
Date: Fri, 10 Jan 2025 11:35:09 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 1/6] cxl/events: Update Common Event Record to CXL
 spec rev 3.1
Message-ID: <67815a4d53115_177894294f0@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-2-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e95ac9-b2a0-47f9-0060-08dd319d23c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qyFmMC8Jrlb8SPmSIWqYg/744hlqtfTr7MydV/Soffx24wrF8bugMP+Q/sZe?=
 =?us-ascii?Q?mxG0+engPZa/P9b7XgJ1Igfz3QPkggT8dpuOIIzcm8N9LnMuKH310jyU0dGc?=
 =?us-ascii?Q?4SlhG3PjfAdRWRKybjAz81gAw0rWuwwN6L/YiPpsc1xdUxOzc+B1UEFxyiMS?=
 =?us-ascii?Q?rzMDh/+XRQEO7ifQ9Bkm2th8Ogq1UlsX6QpLsFlvJi/tvG1Me4Fw1P2kwlP9?=
 =?us-ascii?Q?4hyiNizEjpfLstXcBLBBzy2ZVZ1T75f0jhPtvOe/CovJKFNA50BKL3vX4g61?=
 =?us-ascii?Q?LKXSmqxXyMec7cc02NNCAD55ZfG7I6vqU/h/AlBtM6GRnmZPfr+CQLV4xL+c?=
 =?us-ascii?Q?i0CNV8t5NOf+WVW7ar1sC38KT7Axhd15JPIvvRXgQCR6fpID6ttf0TtrV1HR?=
 =?us-ascii?Q?LUQhCE3sCImLGimmRMjlOKgXW+Hy8O+luZ9+CQVaVV3pAZ/wY/LdZ2UIV5O4?=
 =?us-ascii?Q?9APRPvV2gyHa4Rpdw3045qf0H28PA7KMKsbIPEDpGd2Z3oznT8Ycd1LLf/0T?=
 =?us-ascii?Q?s740ydQIMTqoeu19PFgAizPMhMBn2+W8GXWy3yq4QcOhFilCwc2ghnOkyRhz?=
 =?us-ascii?Q?Vjdz5k/7CZG5J7oF53kg+vJ2vRdn2JHvkL7Fo3z1/PNehjySt9tOBEM9VDVw?=
 =?us-ascii?Q?EHEzAoZv8c3I3jzAiElBRtv0SVSLz9aT8HCCegfq9dGVEsW8z/Hb34R0Pf5P?=
 =?us-ascii?Q?faAZF7W+J2gc7KBI1KhZIqvz1ozCSbCMasYgpK1kT18K+6EtbfXOby/iiP/G?=
 =?us-ascii?Q?pC6Dh2WHkUn2XYjCwUt3CJuEeIXBOzZNRDPXImEjeHh5nwPQlF8Oy/zGfJo6?=
 =?us-ascii?Q?0WS/0kAFpXp3Tx9hKLbUFoz/aDlHOOMtBtiRmKh2u6zWL9zDO23irf2xA4SS?=
 =?us-ascii?Q?a2lrhr2cQNfMlynw8gZVfJYCwqOX41E6UbNu/lSMKqK3dfJqR4ioadaMk4YM?=
 =?us-ascii?Q?5Q+A3XTL1iOI832cs2m/VJyOSOySYBo50WZOUSpFp19i+U92I/AX26u8srzF?=
 =?us-ascii?Q?bqM1IR3dOvoV99tCu5rYQFA4UZyUZwfrRg6KjVfTOi8zXyoDtsqFsH9Rnb00?=
 =?us-ascii?Q?Z/d5H6gYV1sS5mjzlMb99Hz07htBB1uBLLNRDJ5/jTZXXCzA81k7lQflFNCi?=
 =?us-ascii?Q?StviLPBv2UHZzctj5fHANSprnrSJn//+969dQADsVqAdhlqzBddrTyUGpySl?=
 =?us-ascii?Q?pCJunzgtNe/5kXRVqk7ZSFsUWirc49ZucOvCf8mT2mkgrcMVViXe7EZhEw4e?=
 =?us-ascii?Q?s10h2raNxbtRkzv1FQRRpj5FtAa1Xb9f5A/ot3O+pSaOKbRtx+dvAiarzJPW?=
 =?us-ascii?Q?o20jdhTn//GuotrXbGwBkeq7sinkytIChszg6QU/uiPiV7+g50MN/I9ExHxy?=
 =?us-ascii?Q?+6xo2niny7vR12XzML/j3iRmWf87q5lmOTRmuLEcMUxzLspeP0e88F7CXwFz?=
 =?us-ascii?Q?L4vdfMaSOms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQ2OjabYh156PlLO2RgtRhQaYiNrS8QjUbpGguGDscXHYOFYCDYOby1IQ7ED?=
 =?us-ascii?Q?QVfF0zz6Ct+xnRSTXVqPVNAuAn7T3lhLDsKD91i5AIjLrbRUQJofVF3rsAzg?=
 =?us-ascii?Q?NvGWt+uwxOyC4joJbzljl0HdB2OpJgXFmHuWT4Ov0s0GQ/USOd8xH07t+pPN?=
 =?us-ascii?Q?RufJloSr9Z1/w7Zjwsmlb6Vtx1teotH4nESe3Gi0e9Eq1f24Q66UjlaEu7Y2?=
 =?us-ascii?Q?5WtskMZqcvfXJWrVSeewr8xOcGzIOBvHRYiUEgDDOooVCr6xxVWypf/c0nse?=
 =?us-ascii?Q?CJTSORgoFOf/INwC3sKVPIk7ZFJs5n2DJLSMnzXqANsCOgYRo0MntoaumnoO?=
 =?us-ascii?Q?6DKwwsm81JcQPthmkPrYtLVdMEAAOeWdZmhxajAtfSjX2fxukyKp1sgAKx1F?=
 =?us-ascii?Q?ob4eEdMk5xDsjsgI8lKP362oz+ztaB5LSZHZPncVIaxsKsACcxx9PLs1wIHX?=
 =?us-ascii?Q?ZGU9ibcas0ZImfl8d4058/Vg99dxVV37zUI1BO/hD6D+BwNX6x9h2dRHU/mo?=
 =?us-ascii?Q?NtVBJtMFEWF08YuucMrQ+Ccvs5wJyEy1SLVAQEhaBRA0PAkSn5P+szlt9z46?=
 =?us-ascii?Q?JnsxOrvWRNNjb6H7lA/pyUKxIoh1hs7zJw6wJk9cD0aWHTbcg+hB9hPIEedo?=
 =?us-ascii?Q?9+sHflbacuxHSYPGafnUMZ1enoSO3zMfOHpEoMvv6tuntyfIYY69LeudKmMc?=
 =?us-ascii?Q?S3pFJls+Np4n8535zRKOb2LXaXbVO4sgaK3s1iKP4Zao3bWWqGH8qAdx3JAY?=
 =?us-ascii?Q?Gwmxq8EGMFAt2kUBRkkQtQDGR81pjrR55N8uD709esx+/t4a6q0sc4674ejB?=
 =?us-ascii?Q?tuJ80yp7R/uFjK4LrvKy2S5PfeM8qKmLM94SdSGlRazeCOngpspkcN1VR/ZI?=
 =?us-ascii?Q?EEea6bt9YxdMN+oNInwlNgOLIeKhiPP7IH9SxCLK8D3pRZTIBIiA7KGGh5K9?=
 =?us-ascii?Q?JbmrUZWG4cOvwtuPYL3AFQXAfYlvnEIN3iXzAJFXOaCYLZCYQoEDSldzLC1M?=
 =?us-ascii?Q?DiuS77ntmqSrSgRdVfTs8ZGi9IwRfl6mlmJpO5vR0dFRmX/wRYLaPQgMv6Ha?=
 =?us-ascii?Q?xiGy/gfZZBuMTeYhA4Jq18faf3he06wD8sohraxvmKjhIHmKPRLW4yI9hL19?=
 =?us-ascii?Q?WQzHVsW0XjqE48kistA0l1wm9gFs672vMJcL5ayk50Hr/3/SAqZXcSA3D8S6?=
 =?us-ascii?Q?3Q52IMVV7OPNoGTm4K0UbwWy6FMVkWQrkU+0G7/ZLDpvbbpBQHN+dKm/IPH8?=
 =?us-ascii?Q?wTCP/FkarPLA/pyFvtEGuSAvNwXqdaYCBbJBDfoNMs6A9CapL3NIlU7VgrxW?=
 =?us-ascii?Q?CIzD4+A45idmqUYN/fi+poqaj04X87ZbwwA0SRO6YoAiVtMUNqV2ItR3Yvc8?=
 =?us-ascii?Q?/BvWNPTtdt4ZtnTQE0S6+uh2xJAwaTFyZ8aOthpLhb5N1VLGlCHRcJUNBWd5?=
 =?us-ascii?Q?kU6L22pWWOQJ4TQ/g8sE5JPdFfCTCCkAMLkCvxbQlcd8vzzKHKO5H03ojrTy?=
 =?us-ascii?Q?cbiuxx5VZ6KhP7nwOCdfv4zOPJOC+5x9hseTC14Hf+GBEgIy1gwEzWUdhVw/?=
 =?us-ascii?Q?MOa7EhfdM0rKPifZOGjoEWD65TzSDha6tlbamvUY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e95ac9-b2a0-47f9-0060-08dd319d23c5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:35:13.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+YTAW5+sV9pRxQjuuBcaoC1gJdXDdh8tZESgNwe5PsOCo4oibAl9yTLw5QzLaxYJXuraXt9jdjTd4Zp7q+Zvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
> updated with Maintenance Operation Subclass information.
> 
> Add updates for the above spec change in the CXL events record and CXL
> common trace event implementations.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
