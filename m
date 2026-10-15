Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BB35E950
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040798; cv=fail; b=UOtLaVnHCOKGtzCHOpHeY13zFfVPmKzWaMSolzfIN1vsurQ2djE1n9ujWtSZlvzbXZtb9TgYSyvGdIl9Mg1MjRhGaOs13oc2cUZ6iDoULeAjosz1Jxi9MajvrnKIfjSEym+yxoyMc5vnmq8Wwqv3uOE66Edjbhm+cfVkzYgGt4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040798; c=relaxed/simple;
	bh=it8CKbMG1Nkcz+UqSKlMPHMulvTNHX30xBP0fYtAFHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FdzbuGZ97YxaXxVNBZSQ3Nt4DBTDxFV2cbZzfCsyTjE46NibGJRzQboo6+a4akSxvmTLDnZf2YTa/DTWk/I9kjgp/T0A9sK141o9du/l8n8AkgkQXuxJUz4xs3cpy+uY3HZuIDMq3sT6Lt4vTT9MsONJ5T4ct1aoVI+eulz9fzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhYb4/tC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhYb4/tC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792040796; x=1823576796;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=it8CKbMG1Nkcz+UqSKlMPHMulvTNHX30xBP0fYtAFHQ=;
  b=mhYb4/tC++JFj0Et6OyMyK3oV5ol7okw70QcWcLUbEyL8ZCfR5VbfM5r
   wAhY+2YIjy9kyGGQfN5nhRP6tLdmRwBCXDdr/WHsZSU5vy2PXU339pJZx
   xgEgEdAYcU7+o2PxZbbwyNwX9kOBozsz+GaYlrE4z54iwh1zCq4Yz/Z6B
   Zr6dBrlocIRrbzbIRelx+0+hK4t9YZc3lUP6jvHyUErSNehmfR91LkvaM
   naV6+uliyKRK1GgvAC2xL78PQT2g00gjFFuwe8Sgi8U/J+XVRTwZbtbpC
   MuCd8vwt4F8QOvN3SqIC3Box8SNqOWDYGap9K/FLtjXGdIg2b2xnaVQfC
   g==;
X-CSE-ConnectionGUID: aB9o8UlrTJi1SKxrO+h0Vw==
X-CSE-MsgGUID: IOUuRVOeQ6Wf82OYvoy0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="687162"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="687162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:06:35 -0700
X-CSE-ConnectionGUID: TLc8iUBnRhSRpltTv7Krfw==
X-CSE-MsgGUID: ZwQQ+sp4TG2K96Cdpz4KJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1525234"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:06:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 22:06:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 22:06:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 22:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLysI1dwRt/zgaDOidKXpeqK08cujO79N1Xg7xeIrjXjQosmYkI0SlnxE4rqHZR62pS9hGtj/zk1DBXxcOX5r4ErAhGs/hslkOHU2vgxDGkrMeUwX1A/XFzQqYZKWu2VYAAEGu3xDc+rpeLxrB9kTx314qc6caCeOiYVlaUy7mJ3YBeBXN7vXclS3DJvLM21rfB/+d53c58SlfBRQ2RgC9gougmx/dI/ljet7zTlglpNkrJWDxmezbM5APIOhUNcHhrTWHWVVgabMuFaxzbIfPJRKAbpuh77E6ZfDkco0S1TNTBRy8vLDLOFVpuN0ambul+WPS6ikgwDp8n49xFqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGSaPztkul42gZAGswZ6My2D0LFbypas6sPrMoY92kg=;
 b=bMJ142cYENPRwFiNtJ4paIlk5ziOAt90JJSTlH/jCiFrdF+SLgvZGCCGUiU600siTO7rnEc6PIDMxp+zdoz/KAZnW1SaWQSOZ3Xa3R5khQs/2+zIbnjfqtl/DQBNEv/FLc4+2mrfI1+JkeAoJVlp+ljegw6i47RJMXMBZb12+2RQnadZ/R5GRr6AUlWKs2aMKF5NHxXSCLoClklv1VI92zzmbsvyuzZCEaQc3HmVNi4wmE/Dg9aXaI7KAO3DaWrpwVmLmIPX8mlA2JZ+TsyVDRwTUoq3Q1akL1WNtsdd1VyvMES3X4Xjj6cj0Ygi3QXGmPby6dFtzGE1Y0wvWmEfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB831931.namprd11.prod.outlook.com (2603:10b6:806:589::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:06:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:06:32 +0000
Date: Wed, 14 Oct 2026 22:06:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] cxl/region: Factor out
 cxl_switch_port_add_target()
Message-ID: <atBfVEwCUVlmUQ1q@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
 <ab1f937a-31b4-40ec-9c67-e1bb0221c310@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab1f937a-31b4-40ec-9c67-e1bb0221c310@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB831931:EE_
X-MS-Office365-Filtering-Correlation-Id: 73457c57-2ddc-4116-9ef9-08df2a7a13f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|261009223027099003|11063799006|5023799004|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ikSiiZn4pgskG1J8rWOxXCAMsoT8sAA3s6+HBA4R9LI5PJUEsZ9XaQZtEf0NyiPLb/HI8qE1/Iw31l+03t1A8NgTV/4foOecu/MKjheoCHrm4RliMVHmS3Q7YXI5YjLC/y3BBiRm4UMzVmk7jnIxx5qHFRST3BRfXe1I/jL3kWG517u30zIBn4MELPfCVpcoZqHS33RT4gkoV+5JzF3PhmVbXl7V6whqj80RjMdLQG6mR3lbDkwl2vzxQj2T19GL7LQC5Y+6X48J78y/E9AotzqYdJOTOFfYj8C1k8dkYrF0gZE0PEiDDyJLorMrSYhn7D4xDhzasnWuHOpIyXMQt1mgFRoJi24QIjjQHflpT+7QpRLGPa/tzb16IyBJ2WRh/pb0S0JgVcdWU1fhtrGYU06XJ4Yc1juMW0yVTHTVxM5J1N4C4AiOBe6pQzucYljYWr2NfiBLxzYiD8O37qLspZd/alX/sa2mz2kZlVjRU7QoBqoCWmGluUEbKvfSkQy3iUmx+9Z6+5C8jSDaX7vYiZTlzWU6w7IJlmv0bq4YJdC+UKhaq5oEyQczN58BkfXzyf/o5D1sip5vhY6hDUQw0CRmUJfJdC/uwAbACXKa7vfOmVaw5CkZS9Yx0c4KSP+1yNbMFe+hElAg0yT6w1UFuB4dFG6E2UT8aqECI2OTL0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhNWnhZM3dMOURiQ1JETmxuSmxYMHVxT3IvM1U4eXJYWHUzeDNqS1FHdDFQ?=
 =?utf-8?B?cmpyb1hUWklvb3RjSXRMTDNKclhoalR5dHdVSis1d1FjZ1ZxelBBcE01aWZP?=
 =?utf-8?B?NVlrZFRuQ1prUXEzb2FmeXNEWjhCVFV0MGNHc3lWbnlEVEZHd3VkKzBLQTVY?=
 =?utf-8?B?L2N4bVhMS1RNeVo3cE5aS0hOTk5qbVgreXpqOEVxUTVBa3RiUUVPQjVCLy92?=
 =?utf-8?B?cVI5bDJGMUwrc1lMZFRrSVhjWjlRMjZjdWJ2VUIyUzE5OGlBSFZMUkIrblRL?=
 =?utf-8?B?NTBPYjAwNnlVTjdDUFg4dkJwMWpyZ2lJWEpQc1pmdjRuUUN3NHB4TCtBdEZy?=
 =?utf-8?B?LzgyVWc2VWFzWXdtelVZTFBMeDVjdEJmQkJ2T1JsbXZublg5UExxQWNQa3pL?=
 =?utf-8?B?SFJHMWhlck9naDhUNzljY2JkcmxCMDNZWkdKdnRpSndCSVdacXpRdDJaVVo1?=
 =?utf-8?B?SFQ0WW80N3VuQUVWWHZFMzJGeWZoVHVPelYwWUI4NGRDUjdNUmJPWFNhdEZ6?=
 =?utf-8?B?RHBMaDIzRmFZMTREMTFvbElhaElNdExXQml6RmJORGxFejhnOUdmdHFKVmlS?=
 =?utf-8?B?WkRmV0dtVTVpS1A4VnJVMGU4aHpka2lLSHpQYytFU0V6YWNLYnA0Z3ByK0NB?=
 =?utf-8?B?L3IrTlVXUW9DM1hKOGw2MHd1TEpRUGpsYk4zMm1wUGYxZVdpbVJEeW5mbWl0?=
 =?utf-8?B?aTZTSDlOcllOVitlb1hXL0JpamtqYldCcjB3TGQvZGthRXNudkczcDdzVkl4?=
 =?utf-8?B?UnhlTjlDdG1lbnRIZkQrR3hTc0R6RjNRQzExSkEwRUtLRmV6RzB6OHBVSy9L?=
 =?utf-8?B?ZUl0a1M1bVQyUHdWQVNCS3dFSXRTS0VZNC9GdVBOQ21EZUF6RkZqenB0bmRG?=
 =?utf-8?B?UWNDU2pzWVlCMUlJUVNhQWNpZG9WMWFXcEZwcnJWZDBVdUhoajVIZnBSeGwr?=
 =?utf-8?B?WklJa0dMU0tIR0hnS2VXSFN5YnlQeVJrOWlaZWo1ZlZCY04rMndTNXZNaHY5?=
 =?utf-8?B?VHFpVUNPdlY5ZWtZNjNuTUJDZk4rZFhaQ1hmQ0M5UUllSDV1SjhwL0h1dWlQ?=
 =?utf-8?B?dWxoTS9nZnRZU21pdDd0QjFPUlFIeVA1RnBsSExYaHpaeU52dnVxNGtiQkcr?=
 =?utf-8?B?MXhVSi82YVdsUDI5S29WZWYySmVpK0N0MlgvbGZUcUdDQUhOdTFxMzJjUWZo?=
 =?utf-8?B?NW9oaWxlemFLb205OFRjZnAwdTYwYTR2U3d0LzlweXphb1NNaWJRK1AzMUJ5?=
 =?utf-8?B?SEwrcWoyN2hib2QyL0pwUUlNZ2l2amFOWUgxa3F1ODZFa1Vkc3ByYkpaRmpq?=
 =?utf-8?B?bjc2MEV2ckpVZzdNbjliSzdSV0creWMyZ3Vuek5WK1luVmFXZDFwZmFjR3Q1?=
 =?utf-8?B?d3BGZlVzWkxuQjZCT0U4MFhXbUlvVk16ZVdhUHIwSjY0SlNiLzR4N05FS3RO?=
 =?utf-8?B?M2ZqWDhCYitrOG15MnhHdmJqYTRMekYxVTEwTHVaVVF6REdDdFFMRnhKYXVM?=
 =?utf-8?B?dk9kekR3emNxYmhFMnRqc3B0V1RJOEFsSm9sY09CU0FHT2tjYUgzQ1pUTExv?=
 =?utf-8?B?Y2RMSXpOeERTVkpVTU9iZ1JOeVNvTzMzN3JLSnA1c2tHMytCOCtUWDNKSkJB?=
 =?utf-8?B?Tzg3K1hXNG1NQk1Ia2ZvU0RUa0hlZ3Q5QUpBdmw0Z2UwaWZzd2w1bnlBTHJB?=
 =?utf-8?B?TExnMWdGUUladFhvNmFTQkw3NnNvY1FkanBlT2lCQWlSRWp6Yko3NkZ0MVVW?=
 =?utf-8?B?ekxscHYzc2Q1VDg3VUlPWi9uekdlazRNWnNVS0dzaFlxb2Z1T2UwWE1VL3pL?=
 =?utf-8?B?YkNWUDkwVkxzSUdreXZKVldXWmZrWm56TmMxNjJlZTV5YlFOa0xNYy9VeCtS?=
 =?utf-8?B?WlVGOW5LNjFlS0ZUTEdOUmZqYTNGSm1rWEloNFhuZ3lJdEdsSGNnNzJEOFJ3?=
 =?utf-8?B?Wm1FU0VvL1BGT3h5dTM2T1B1T3hzeXZVR2srVC9oUjAyNG4vZFRWNE1vTlgz?=
 =?utf-8?B?dlhvWmVmTXFwTjIwRHhPWVR4a25kbmZFVUVHNnhta3BER0NibkhHbEFpMGo2?=
 =?utf-8?B?UUE5RUxoeTFTNWpRL05CVTNjcDV5UDZFOCtQcFU4SzliSFc4REFObnZXZEpT?=
 =?utf-8?B?VnJjcWxTTzNtbjJUZHhaZGdWOVMvcjFUamFoV3c2eFRVMEFlRVRjMmdLK2My?=
 =?utf-8?B?QzkvalBWVkpjWjJRNzZLMkpYakxDUlNOV0lEUGx1UTRYTWtQNEhRbVdHc1E2?=
 =?utf-8?B?QmYzOENDNVNLb2lmWmpoZ2dFME44bStxUFRrbTBDSTN6R0p5S0d1RVZwS2Y5?=
 =?utf-8?B?emZVU3pJUSt1aGx2ckJFY0twWW1pQWxtM1orcnVqYWlaYWl5NC9tMnY1THdt?=
 =?utf-8?Q?YPo6F9HjhFVHx5lg=3D?=
X-Exchange-RoutingPolicyChecked: 4CPO1gas0tylxm5HZ5zIk9vXYiQji77gEqCrhzi3KCeBZ02wEkVpWtyfipTi36RbXYk5CISdzom1Xdbj9Fjyl7+0ySrWKLaF6rUQXSg43gAmNKfgs+Zc+6AnqDxeWcuM+Sxo4htqErzBe5rT5sqedDVSB8Qo1RfDoJGtUvRSxjOIgeZ1F8TrcaCkmdDGxnFAxvz8Q+2P2aQx8Sm8UJqEGuVBoDoLQHm9IEZxzNb7LCk+X7oHWgWhrqjYYmHGm1s+aCBvpda4C+6D44W8pSJCYnB+YOEEd6tMSfiS3P5MjAhXVsAtNEdbyPKeCiohOvZhMrvgyvWefDbOYoTt0bxwGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73457c57-2ddc-4116-9ef9-08df2a7a13f3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 05:06:32.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgVVLLCteNp8GkcNaUM0SVifP1GpAK8NmnibsSqGjQUuducsZ15E/bmH2TI4zV36b3r5uPrm0XtCuSTnzh85T20Qo6oCRG8bw7b1EaTFcDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB831931
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 02:53:01PM +0800, Li Ming wrote:
> 
> 在 2026/10/13 12:26, Alison Schofield 写道:
> > cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> > port's decoder target list. For an auto region it checks that the decoder
> > already targets that downstream port at the next position. For a user
> > created region it programs the downstream port at that position. That step
> > is open coded behind an add_target label that the target search jumps to.
> > 
> > Move that step to a new helper, cxl_switch_port_add_target(). The helper
> > takes the switch decoder whose target list it updates, rather than the
> > port, which makes its scope explicit. With the decoder setup and the
> > target add now in helpers, the path for the first endpoint to reach a port
> > becomes an else branch of the target search, so the add_target label is
> > no longer needed.
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> Just one minor comment below.

snip...

> > +
> > +	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
> > +	if (rc)
> > +		return rc;
> >   out_target_set:
> Do we really need this "out_target_set"? Seems like it can be removed too.
> Once a new target is set up, this function outputs the following log, if
> this function finds a registered target, I guess we don't need to output the
> following log again?


Hi Ming,

Thanks for all the reviews and this catch. Agree this is ugly!
Will fix up in next rev.

-- Alison



> >   	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
> >   		dev_name(port->uport_dev), dev_name(&port->dev),
