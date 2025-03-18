Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BE143748;
	Tue, 18 Mar 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332608; cv=fail; b=fFZyDZy75nC8Ag7gcq7j9DO3ffBNIBV1eN1yt5ZpoqxYNOnjPriAgam4ngRarnz9xnQvTM2QERDH+yIjqxSH6q/OnlqM5/mOe7lNmydicbvuc1slrPFfultYFC7rzek6D0kJpj1tz8sVDtcNzHMAQ99ty2yw+dnMXlC7gwtfUxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332608; c=relaxed/simple;
	bh=8fKHnamm0cHVJnoMTQQn8TVg+GeC8Nx+xDS/lzUS2O4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BDycNB8UG8iChRMIVFgYiuQ/V6EtdfT9bWkVdnTNc+YeBmYNI1KCbJvW7Sh1BYoAC9pCUCIS+3O04Ce1pLV6tKCOzY1OC9BALbeB738PCNpG4+tFywjPaCBCPzHwtJowsGecZHZsYzEy8W9khxxvaZmoRsq6ocEsIEXrlcE+0d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQyUzI+P; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQyUzI+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742332606; x=1773868606;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8fKHnamm0cHVJnoMTQQn8TVg+GeC8Nx+xDS/lzUS2O4=;
  b=iQyUzI+PM7LrUAfKGtuN5wWKs9E2aBQH4LDvhW8RsxfO9JINKlD0i4FC
   klGYF5QOOWyOU0A8FeQHxdoEvAgHFUMu5ij4977w2DH3/wALJ28AoUHb8
   FuUfk1Ykk2//q8YNMB/eU++8sO929verSlfO9NszpBXqblBfZ+2bI/bfi
   xMyPGbnXMCKiFkBoO9fbCw5YarToAcBR6Td3v6+ECN4hz1mxqk0/XktfM
   0CqGTzLRp4FaCJ/8w1dPTLrmEg2qquNqEuosIrxIfE1VMk27WyzTSAFRc
   f2mV5KqvMntJVUR3cyhqxQagIkIulasdQyo/xLD/tVplX/yw7IL8XedaZ
   g==;
X-CSE-ConnectionGUID: YsfBNFqwSn6Vgz5IAnaX8A==
X-CSE-MsgGUID: PxqQcoTuRt+FZN4F76dvBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47276816"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="47276816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:16:44 -0700
X-CSE-ConnectionGUID: nzoP9kaiSkyyF839uZe5SA==
X-CSE-MsgGUID: GucEJRSpQVyo/G7pjgGzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="153382226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 14:16:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 14:16:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 14:16:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 14:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8SK+Kq77o1vw1xv3m+VFbKnfjS/2WMfIlj6x3FdMY3GUQtuc4KMod7cF51Nci+aUNAmyr2J0Df4xLEr5ViLG1TMv0To19fDgsQjbnQ3ZB6m11FkYRmPscb3LkrimHrxeFNmsMlAh92iPUVNvaANsm23bfcAMhzfPG9JDd4XdV9UScU1m+1mpwEMzbMbh6PeK6f0nYPHAinhBgvVipclRf6u0kUhVM8PnfyaAPlQxgczC7mgoVo+gQ6CEk7ZUnOHPQXzYSefdV0bQ3P7LA7fORVYeYsdXPIg2iRIw8/IurMv0ZprhVnsOXXNWsB0iVHSpB5C3EGNw+sCM2OcW6qS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSbaLxl0DHKnCKVfOMgvRwSGnK3RVGSiG0isEMb0aOI=;
 b=s3shNG/fyKX79BwCpnJkHxj05bWUjgfu6crGWX/gydAQprQpg10CHPvTbSS3W4M0zIgV9RrzRQrwD9p2XZbFfKTKKbC+jicW2esa5dRV3WvOji72Fj/zXdgC3clBhUXcKIO6Uv/VThsJdjwxn2KNoC7uREU6fmXq7ssqLot5B7AK55Q+Efv7ueEDMbox2fpEZnIZIVrg7AoYu91liJxd5hP843wJEmexXe1cswmvbyyrhrzB+tYd6qTV9qxl6WIhoNx2/QuLraw8RHiv1+z4XW4hvx+fFzGbj0Ohi2lviY9QCA2KzSYx7+O4o8av1nZP3yAqfuxikJ+p58J5nza6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:16:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:16:40 +0000
Date: Tue, 18 Mar 2025 16:16:55 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <67d9e2c753a44_422c1294f@iweiny-mobl.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9d8962-ef1e-4a8c-b295-08dd66622cfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ILhZ7MSc5qml7wS03RCcY1aw9amt9AL62891o52zwSolBXTW/05WZYXlr7UX?=
 =?us-ascii?Q?mvscx74HqNE1uf11ZwyaoTVayXoTPH8lSeIOKqv3cc/YcLVJEVQ9R0ehkdSH?=
 =?us-ascii?Q?DCiP/JeG1dZDmHaRZ5f0YQ+x6yO6Hak9lsBKxIUR//n1ercAogCLaObP4+H0?=
 =?us-ascii?Q?1HVH/OojoGg5Zg9kpZykWDnlTo0+NdbR+nakOie5+A2z9WPkMR6xvydghDYW?=
 =?us-ascii?Q?9cxQwJTnmp409u1EexffUhYXYtWD/lNR37weKdag28WcB0DK0N9RgFs9kXmD?=
 =?us-ascii?Q?G1qRphCFgpogCAKRn8TYJipZAH7FZqTLXXJ6WRZeeXaD2lFNeosYgLHXxvl9?=
 =?us-ascii?Q?xFgKUom0QStdghHiH/rTHB9uDCUhU1/aEwYc3uHdjvETLEPvPLC8YdJjCKMo?=
 =?us-ascii?Q?q85JkVzqviZKyFeuy7NmE2hCRD2VriACcuD08t68mvMZ7xwuLoAn3rRQbg1Z?=
 =?us-ascii?Q?tootGN0j2RlrTlVhWF8cSTVLMbWOJZrgMv2kVGe9CDSEymgjwr9n9LjMVp2u?=
 =?us-ascii?Q?MyNYks75Md3Z+Nd/lIDqTq4hwcoinDfEAqmnFEaCADfIH/UlCB/p3vKvkYb4?=
 =?us-ascii?Q?oR0HFiSliWSPZnMahUhaX/icLouGmgd/dUtO8TGj5PTCx09/YWW5I5hPDQMD?=
 =?us-ascii?Q?Vd7lIQmVdARkWfMCPyXsPliVUu0RqEBHOmHNWVTo7dAs64Nc7O8AmfesmKa+?=
 =?us-ascii?Q?+2PHMAFKVC6SxmhkJiPc/+OoSDtxSM2TyIDBJr7vRW0B5n+FOMiO7vKi48+m?=
 =?us-ascii?Q?8pl7B2qyqQVUHg4oWredho7N0EP/OR1q9ElqGw1vXQkQLgArc9T1UVzfX0Ug?=
 =?us-ascii?Q?8yaN618hz1uNL2vLGtVR04Go+3iiZ3PEwV5GgA6I8w+wHJ5xhkiQpDo7ixke?=
 =?us-ascii?Q?naqR9SBMBTt28BRQHnRbFxK8vcKst/+15y1FsWmgV+R+4x/DRoVoCGYcytXr?=
 =?us-ascii?Q?WdqELlKsu/hApAuLEI634v00mHHBDKaQQFZ4pKH0iFOQqomTC4XjXGB4UK/v?=
 =?us-ascii?Q?+NdVKMF6GCQQHs5exRtIarly0ZwF/AVXFiRfp+a0tx0jOZiD4IpmXO1DTNgb?=
 =?us-ascii?Q?ZjbunPe3eJfkGjUk8FaX1Y1XqRMIJCQxptMq9jxFoZ1kvPU+NYK7GFDbjMio?=
 =?us-ascii?Q?JVX516Ga9+w5XZPQsvQvsARjQvXXypp2YZgkeBepsslXHFPRfGCO/6SFBvTa?=
 =?us-ascii?Q?zmfr/SXLSKWOQZDV7yWfCzpt646EBOrueuCePaOVR+UT2NnbHeX5yhRbqafB?=
 =?us-ascii?Q?PG6POyaKvPp3IGvRveJzi/xdLi82FLPupXCGkny+M6XqZBa9MV61HoxP+vfI?=
 =?us-ascii?Q?ra1zvIbOJlHEciiXF6G8uKk7C4HAiSlu3d4kQHyLZCqJAYWX7l7w6EmUOETT?=
 =?us-ascii?Q?IpuPHRBAu90zjrpquh/EWC3yfFFH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DueiTnASkx3LhS+BkILUqVeiw8GCCMTWHEgCh74AMzytVOvXs6ta7wPpT/h?=
 =?us-ascii?Q?3FmIdEfT6RXXARbzx2KS7RK4W6u+19l8S3946kEXXYQdruuVcp0EzjoATaIf?=
 =?us-ascii?Q?pWv+KjpF2oglm5vK9Kc9kUyJCMFxreUEL6jqpNC0EnSjFE3atP6IXT6jmn3h?=
 =?us-ascii?Q?SW1T9KnFmovVRgulCn64vH4q9uDnfoWoRLJPMJSFzOfm9TSNXuCheYZb0MHu?=
 =?us-ascii?Q?NHilE9Tk+NdKHPCa5rHl9Uwb2EVuwpuvvAhG9x5Z8pvz3w/Z5E5tv0M7CwW/?=
 =?us-ascii?Q?XDSTn3B+aduInZxFw0Rv/7ku4tI9ECl+8oUhcPuIW2UdXLBYoSq/cRUTj2rM?=
 =?us-ascii?Q?sGWZH/JiXWDFpPEQKJR9o4HBaSCgtdTkFuoLNGcWD/R4kA3EWm2DtvIWKdZ2?=
 =?us-ascii?Q?kx7Fi40G5rH6jXfx66aGabKvIM/CzTivpv1FgkgUvZFPmjNXaJ4e59SWvBRe?=
 =?us-ascii?Q?nS0agEt27zC/k0B+Nd8d9CeTjv5+4JJP88E4sEvIwh56oQBSUWSuHndX0HeY?=
 =?us-ascii?Q?+uKBW+pRdouj8P+QXldiSEiH0R44VGf8Li0l29IQYLZ4Pk+I80Q3sVEf6Lwm?=
 =?us-ascii?Q?tt4ZO0i5PwvH/MSxzG4dSt8ue7oQvmJ9jtdm8nPo1mB0p5VAbNeHTjlJv0Ws?=
 =?us-ascii?Q?qpZn6X7xchmKq/izzg71jDm7qZGbzCrB8ej1HC5GUVFe8GikE8zhI3tAqyeM?=
 =?us-ascii?Q?cnb0IH3Z21RLtdh6CPCAhCF4HkQ8I4Ss7CuV7VgB0Jri+hTd4znYMzsLluGA?=
 =?us-ascii?Q?KsfvzmzDpPn46EIdU47OVb/8tCLd9aR4dyTbNl3L+7jo0OdQzS91octMixcI?=
 =?us-ascii?Q?B47lYSZHoyPLHdEgDNqdB76inw0dfaKgE6jidpXA4bg/TFSi7KPL/r6vyi5Z?=
 =?us-ascii?Q?UVD7ZmkqLZEhpon3NqbzTB5uKUtREe33BiIn7WQ2CaYFohl4f27jV3QSj11P?=
 =?us-ascii?Q?OcUy1LbUEG9G/yQ7JEh90UO9DxmURT/VNiPd1kg/QPh5iBF5MwnIUkoK7Uab?=
 =?us-ascii?Q?y3N7K9IpSuXxAq7GELZD6HBjyBii/5vT7gaTR8F2nL7dEyH8ZO5iSqxGJjoo?=
 =?us-ascii?Q?fe0JaEZyWBQVGBet8yepz0JzjA7xIPNo9zFqpXN4V12u0n8SCXkJ/1yCjf6l?=
 =?us-ascii?Q?nNI2It8CfX/xpYtRm71/x9YPcCfrNnWpfBQk3WuqjGdNNanv/7GvDb2WfkKi?=
 =?us-ascii?Q?Ea705ma9WRHXjIVNLeSvkdQ3cG2Skdvy6sxbVbTPkUv8ZFV+p/LIOhC5pYFu?=
 =?us-ascii?Q?5yHIR8pR6U6GnrGW+x8hws5J8J/ek0lbXEQoagKkvfsMY33LhgTXW5AnAHHY?=
 =?us-ascii?Q?hSn43J3o3jQ0eHk+etqMHYNT7SplXK9ljjVdFzA7G0JRyXSPlKF0scTwnR2z?=
 =?us-ascii?Q?246iPHCiRrPqlx75v4KlYoaLUGGgl4j4tsEvifeQdJnKLd1ekMgVcJmq84LJ?=
 =?us-ascii?Q?5xZmQDrwhHG0HOBSFxMRSad3cY/A9nbNaBZZhLZGZQjyp+7OY9KQxuSwGyaH?=
 =?us-ascii?Q?lJYaU5bxasLKFadTW3OjYCFiDvAI3BDQ+xSlotlj9AEr+ROtLktuw4NUbGru?=
 =?us-ascii?Q?lPW6ZZbZTBccuoIN+gGYFdbxVSUbwilqY/dOWACs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9d8962-ef1e-4a8c-b295-08dd66622cfb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:16:40.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cuj/Mahulug8rC5/vM7tFpH7ovuaYnatofELMZuh1EHYiLi2PrS7ZOvLk8DJVkroaciuIw30uZWjOwhu9RP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> to 1GB.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
> base address is typically different from the one published by the BIOS on
> real hardware, the driver would fail to create and attach CXL Regions if
> it was run on the mock environment created by cxl-tests.
> 
> Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> Root Decoders and Regions with Endpoint Decoders when the driver is run on
> mock devices.
> 
> Since the auto-created region of cxl-test uses mock_cfmws[0], the
> LMH path in the CXL Driver will be exercised every time the cxl-test
> module is loaded. Executing unit test: cxl-topology.sh, confirms the
> region created successfully with a LMH.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
