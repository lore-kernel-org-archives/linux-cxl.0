Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F615E5D4
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470979; cv=fail; b=D5J8Vp0hX5UxKVhMvWqohMb0HWIW1DEzhJ1CtuJYjlY8Dc5tDeseXXhYWviaNbOsioxs3rAYqDRqH1Qz0Ggmv0LdRNqqkHGwwltvZEfz5mwPJneTN1oXpyLE//ZEwuQSxUZ0joOwiEOhxD7G/l374eTIukK4CY6NXG1dwAXKSUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470979; c=relaxed/simple;
	bh=Cwr6PwL68jiIuL2TKH3WawilOU9E4YGzqVBJTDFQ8cM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ecpR7aKIBsE0LvP8soHhTovL1EYtvwTuDhnWxuNaXuHWTvr8h1hg0DvUk+PSbc2fFTwlWkZYO60+Ya7Yg2Ezn9NChOK7GEtxgdxylY/202Y7FULoopvzPRF9Xle85viWLFNw0a2G48ldxZYa/5sFXTL8wnFcJR7Tdx+3xDrPFXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTSyjc5t; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTSyjc5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757470978; x=1789006978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cwr6PwL68jiIuL2TKH3WawilOU9E4YGzqVBJTDFQ8cM=;
  b=BTSyjc5tUdYmn+cBOjQ8CIls/aWfUL6kexwg5fHZIQQw2y28t6Yplmsp
   PZoWOgNopsFUCDqAwb9w80H3Ezdn0+hvtyIppBrv7wrHYwAuISkxjIEgE
   NeI0NcG+tWf2jcPom26VWSky28ocGxVo/qJ6qBIWEzE6oOwAhxas/Z5IT
   VKpJFj7M5QpzrsalgC+9JjFhHKPvO3eiR/Ev5yPWY6aipD3kzkABOcP45
   jaeFBwP50vwZK3+IUTKCA80FO7b0rvIn4WI1x/Mr1BewPV/Z3Phwr5B9+
   QZJgJ23TPsIRNkTl0Gx3vlmzSMNuRfyQTamy+QUgqCzbE+wlfBfqkQ1a2
   w==;
X-CSE-ConnectionGUID: AJNCoqrOSxm8mDTU4Snybg==
X-CSE-MsgGUID: 0NAXmvEJTKWEcicETo6u9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="71150487"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="71150487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:22:14 -0700
X-CSE-ConnectionGUID: od3mbMGES2WbXbS2L7ovdw==
X-CSE-MsgGUID: hKx7Dq7aR4iZiyvSV7HpSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172848102"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:22:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:22:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 19:22:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxKWbc/ireaju7y8Kr54+t9P9hnRltIP9lBtG+YDDsbF8w060qHA068uXkTLEjbO61MCl+G2bezGwqEQH2CSay3P7p7Zul1mwa4EKNwMTxzV4eO/WtBHPIsBmoYexfEIMySDA1p7amMMnuXiiComI4ik4xu6w6PateuHBSULfOcfmO6aC7Dg7uVHhb828mLYLhPdlt+nZFnBwV13mgklCCGvASUcnN8VvzkNp/O3Mb4rasPXs3QaTkfXdFjqokPoCUYJ0Rx07XS2O10axcDXaGC87SIlAao9O0lwtx6gBwqRWa8xE599dvwgaepctHIN4Ax7YwUrKXQLFdJEW/WfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwr6PwL68jiIuL2TKH3WawilOU9E4YGzqVBJTDFQ8cM=;
 b=SnbSxoi/kN5rn4w8kAHp7h6UH29trfQ7p/9Ewn0i3+BfzPNJPJDc6wBnF5LlHOEVcytCdtF/b3tEiUFWWbRYb9jfoG3EHB0ZIy3ezaUVvhbWYgvXAGGa+7//Vhfp31E9DkzqqoDCj6gdg1ntiWiEFdaVkX7rRf0CEBqyXsaMony0SjXqL+Gnk210+pXyTL+QNsDK3ijw1GHGy9/Refnhah7twkkTkmbe7vAknIMaXnmhAMOwB9yIfq9LqalNVNBuQjDmWM7YYpgOhtOS0jfB/ocx0TjRO/I4ahdLSl4ndKUemaPhhYf2mBdXWtuP08zW+uAVYNyirIFX7fkWB4yRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 02:22:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 02:22:11 +0000
Date: Tue, 9 Sep 2025 19:22:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 03/10] cxl: Add a cached copy of target_map to
 cxl_decoder
Message-ID: <aMDgzyDRLaMF3Mcn@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-4-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: baa9d7ed-d48e-4073-e9c9-08ddf010d96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrXebG9oRRdZjpT6kkBM8akvdfqsyTjLk/1oQvW+1eSqAXvAVTevbtvlCODe?=
 =?us-ascii?Q?Ras+zUzefx+EFUWQqzk/cEKz2W8eg3+7cPzEbIu11YA82UdRkHGeoPfynW2/?=
 =?us-ascii?Q?ZuysWgXu0vvav2aDUxQ3INeY4tBy1QToPp2IlcIgPap3ACF2N2E7IKxfLtfx?=
 =?us-ascii?Q?W30XcNMQz6iRM4/FiLmFwbycBVml95RMfHFa7xSODh9/i8UhA42gvn+m8hEX?=
 =?us-ascii?Q?AJM/Idrar+S33ooEz1J56lJTzbuuNIeIbsy7EM5Y5yn9Cmy3KM1tAHFLx++3?=
 =?us-ascii?Q?LDuXyxE+z2vXNtEZO6CK0ovtK4OP/hPlmEsVRzkvZiHfuOSLm+0iTRVhfKW1?=
 =?us-ascii?Q?9LsZP3jH01uuLFPzVKlAmeXWN+A9dzNwQtn9+pm15V1NPXKfvl3vSiyEd0rC?=
 =?us-ascii?Q?KUne8YQTO7yoUKQyc2+ZqHdtbwYGgCmZBDTyCB0tFCIue9LpLXPQSOx9AKaF?=
 =?us-ascii?Q?/hZXT22ecfJ7gdpopqIfDuE5y9tza0YYQSIhkb9+7BAf36/CVzW/Bb6Wzzes?=
 =?us-ascii?Q?IyE3hjOPA+a78zoP9LzOnKdhhyzOM1b6IE1eFuouSWHBuEpLn2MEP7MhxqKy?=
 =?us-ascii?Q?S/JEKcJEKzFhT8zUTq+cs5LsEosUuHj0U3DR7nLa3cF/Ld+rzkbL4MemBliP?=
 =?us-ascii?Q?eLC8GIowpEFRpPzYTXrk/5Wq9n0KoKm02Hjc6XzHMT2Crwjr1QgpFDFhQCLp?=
 =?us-ascii?Q?uDYl23HleAJcCNnRAg9BOY7/SC60iZH726X3QkwTqBJd1pzZgQ9N3J6K8Ru0?=
 =?us-ascii?Q?2bhMDF8m+fqhvww8grT4jRqzll0HDuZNYmjYOCZbvBzq5OIVFbY1z0vlLSGC?=
 =?us-ascii?Q?43bIvEny95g4wtNBwvvlFg9BTA0DUG6PumwAucJKIU1UMGK0hu+Zt3tzgCsJ?=
 =?us-ascii?Q?SLVnbZh3XZICfwo/dSK8i+svVP9qOUTSAakvX3JRj4tzGNj8txwr5qfoH+7A?=
 =?us-ascii?Q?zRWYfbylxMBHdeoY3Y5pD47+6C9phaCRHJqQblp1z+N1JoxLWXA9KmG3rmyj?=
 =?us-ascii?Q?Z4DdM8uWldbi8GyEdY+WmcImbff/3nXnpufdV52YBNL4Qx0PwxQhJLMCjCxI?=
 =?us-ascii?Q?X34TnUHrJFXBlIqYBqLZ2BtIUHT0WzIGBLhzPqTkqG3sBebqwZl/dvLkhony?=
 =?us-ascii?Q?cNMu7CFeKmhet+sOh8U0EffRaz6/CmyU6SWuNP5b78F76tSpMWuH0jolVKTK?=
 =?us-ascii?Q?K7wZoKGUBCuQAtOfsN/9yli7FGQT/tZQaPfbKC1nM0/A641ZPn1/sOW8fWbU?=
 =?us-ascii?Q?FJZ5Md2+5d3UIqZ6473t+1KATIb8IkEmPK1Lbwkfy2XZ2AH7Qg+UwL5qTxRu?=
 =?us-ascii?Q?yU9417men4zel/bqegAxp/uMAdL6hycR2/1lc2txHy/WyJpCavLjRiefkpz5?=
 =?us-ascii?Q?RvbNqpHT5uztKhjtVFs1xcJCF5wTwQKSJQtauzYmAnSWf/aWO5I/TSStuvDt?=
 =?us-ascii?Q?K9aSv0QYSq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LuVqTfTBrtTYztKTzWwb0ZgV2V7HFgfmISHL+s1+N93ixNt1WTO7RuB8krzQ?=
 =?us-ascii?Q?qazcL7beLUrnW8SDNSC+QXtn/q8caAt3xz1i76LMvuBNUsyhsCR3qMuY0RMd?=
 =?us-ascii?Q?rA+4TKx3sgtIeF9u7DZZlb/+MbRJIYPrifQXQaDCLZU2O+JCC79XnbuP+mp2?=
 =?us-ascii?Q?Jg7JPWfiYL93nb/FrUu3vzViQ8XAnGE/09ZPemhf/k6cynw4/OaGxUs9IXzN?=
 =?us-ascii?Q?PTxl8q5c+ccYkffV0M7XnQyumE4XEqgOccwD30dTG12ucx1zBjbq/Asx8cMF?=
 =?us-ascii?Q?VbY2PoweFLEpq8tKPOaWMaFUvyL0gdOpF0KtEhHXr8lMUH/ABOsW92RLhpsV?=
 =?us-ascii?Q?BBjRqLz42mStzVyF/Gflf7kX8qpBcj7LUGlPZVP9p/aFsHhVq1ofXrqV3/Gi?=
 =?us-ascii?Q?X88hwD+H5FJS6yvc3YflQ68CqG0cwTiP//9ITvFZNd9uU/E0nbTU4KqtlltW?=
 =?us-ascii?Q?IZJMZbVUPsaYUnVgOzM/ruKmIh2lrnKU0raPJHeOmF65pdnqlngOyN96adEI?=
 =?us-ascii?Q?vNb0Kjdj0TLveBrqASr45MjOY8GktGuGQvoGDsPN5apxvUSAiOx0zNVwTDmP?=
 =?us-ascii?Q?1mooyMJ7o65gHy7CQIaJv+ehLpdvrDsBuddJ+fVbbhd0yUpIAMFca/8e0Aiq?=
 =?us-ascii?Q?EqTo1w8jPSGox1ubSkzAcisnflP1g/OIe0FwizvAmjz5dq3VbCIxbPC8itWz?=
 =?us-ascii?Q?bCatoyLb8izZOsVQr3p8Uy6ajesRSP7ujdmlVwS5nHLd5IAYMvDKMobT1v0Q?=
 =?us-ascii?Q?ZvRiZTAMNRVScY20r1acxMiPtTDq65LkmTU6rmui5W1asQs+jpru3ZI0LC2f?=
 =?us-ascii?Q?EQugeTKroAcp8Id3hQE+orNtQjnUZ9AkHxdGstveL0okxIja2i+EHsufvTOR?=
 =?us-ascii?Q?MuwYtO1cfONqfJZX94/TixeYO2eqOTSO6HFiWbL7kgrWcgwj56kEakHiXVN1?=
 =?us-ascii?Q?1RO3Uns+fOGFAkOGjhv2GFLn1ikNPzcJrkNkPUGpIxyBBxzjNdlIW7SSE6PX?=
 =?us-ascii?Q?CUsHbkinY23axqYLmvnahwSAKVpJAgHquH95h021/aTjDPZyUdN5CqN932/R?=
 =?us-ascii?Q?+fJAwP9nm30Fj5GtOeXydFLBI2yMioG1QGGlbnp4BQogxDgNjjMxvIxZIJoa?=
 =?us-ascii?Q?xNBtR63pDeeAalBxr9uydgF9nO4BeU4F8xnLuxg15if6D/uTKiVZqy8Dw1D2?=
 =?us-ascii?Q?2biBjoOESGdBhBLZ76A420x7rQ2/JSrWYNuLXKaG+iny8jo3Gn2H8FeFLPAt?=
 =?us-ascii?Q?6bGKIg5PJzKQKmoADiz5wTy+QmLh/IOH42EAYnMJC86iC0NS3NxSfR82zpk7?=
 =?us-ascii?Q?66cgGN3mFwNgz/pzsP65YkgQokGFsPLXz6SvChjem+PZGOMDLk2tp+czr4ex?=
 =?us-ascii?Q?r2gnHarc3cFOJiAnKcEFuvASpX3qrvQZTqaFFq3SjqhFLavl/jcnE0+1d30V?=
 =?us-ascii?Q?GQXfGUUdmNDw41H/KgjimUzyEERwqPDvGM9zfz9rMW83AxYeRGV3SB2IJIxl?=
 =?us-ascii?Q?Nb2PWELGmRqUVodaLkkGlZt0UxbkoF+FoTyFgQ8U7Dnc2Mzq3XKBQslD/qyW?=
 =?us-ascii?Q?4rXIkM4oNMx5h7RK3HlnkqOrTeMVrJxfaa9DYh1VXdpo4JYeosR8GFGrJt3y?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baa9d7ed-d48e-4073-e9c9-08ddf010d96f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 02:22:11.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23Hn1JRgy8zDQDa4SmATdaMrB7BVnffCYVO3TYZAp3IegnQTebCDb5FF44OVnIdYeCxiDyW0TDCtHhrz7PwP0jRf7FIgQPPNMgO6oRileUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:21AM -0700, Dave Jiang wrote:
> Add a cached copy of the hardware port-id list that is available at init
> before all @dport objects have been instantiated. Change is in preparation
> of delayed dport instantiation.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

