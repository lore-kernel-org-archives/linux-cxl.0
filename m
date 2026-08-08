Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630992798EA
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149398; cv=fail; b=RO4Q/SeO/VvEoSTpiAMG/vetHyQsqq+igmZd0SPr845YjI9ZVCrWoe/y+C4pd6QqjmjfUDsIxy4NTKnidgmSRfddnbVLWso0PWlkc+S/NzFdFvH+1rXvvdYSWT0USJwIWGCTWP6SVaVupX85dkr4SBUBOVZInN6fIuHyL/w7658=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149398; c=relaxed/simple;
	bh=OmvygZMRHp7hYB3CyBqRLtIUHzKKdhPhcEQ3owh81Xs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nj8S4Jd5O/zrXCjN2gaxfjh2zGxlxbxuZVrCxWNDCqMwDUr3ksheQdwLfixtfnYHyP6OQ1wE3WcB5K6b2rQpfC6wv0dZlTffHbr33jdrbb6eSTYRRk91oqaTGAu3H2M2zVGmzPa4hukKHUbHxYrK1LjzKVnJuNTBfmE1THDsNPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh9WbHDq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh9WbHDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786149397; x=1817685397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OmvygZMRHp7hYB3CyBqRLtIUHzKKdhPhcEQ3owh81Xs=;
  b=Uh9WbHDqxRS3uH9SOa2dZYxXCzWoMqIN+Bi5XCzWiRE4UxTEuRHab2BU
   sUtWycZ+jjlAjyK65er8z1OxRHFoZUFtSrie3vUGeIWuYjlf5VVx3fbjK
   YQQIgTvAMSxBx2iBOTDIY39sRMpp1Kb2dfoMIwHns+H3iR3/9sWWtBxMj
   YomPUTNqglzBsP2iZ37TaFSc1SOjo5Kl4jHDgIlQOivAyu0+gyCnh6nRP
   Gjk42gkhVlK93e4gtRSLjf5AUfHRlKblqQ8MnwAy5yYkJHzymDSs62uJP
   S6qA7Bc+B9RqL0uSo9bW0ExaiJusUFYidGwKam8BVR7R9EQUfIbsPtt+N
   Q==;
X-CSE-ConnectionGUID: b7d4TMvdRL6+FVgpwHSLJg==
X-CSE-MsgGUID: g0chNppST3S3Ed1KyMfy3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="109555975"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="109555975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:36:37 -0700
X-CSE-ConnectionGUID: GqPtLDDUQKC29gMhkxZVQg==
X-CSE-MsgGUID: Mk8TqMiSRoitjRn0yiqpSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="258231819"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:36:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:36:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 17:36:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiXh6fnVdhApbERWRtZi5hFf+d9PZWJjrWGhBfKsn3u95qPox3u0O3mTocTFAulcm/bRh8c63wMk39RxYIr2kdOo2srwOau1G82lovKDjZsOGERabddTK0MJb1FHV7+JJE0f3s26o3qbxo7hm8FrEPI3yO1X/Ck0cjNCflOpFRsH5YxnqpkPzwIpiUqYEYcknXt5ane1JSRA4LEIiLTNe+jyo1RAGnwbvz2A0+ldfpQCXR6tkRjGh1vRuZfSjHAO+/Q1bPxxN/LQujc5gHUF2IBEnj8f7/iCJZZ/Mb1yLSDrB6zP+p5n5PdfWJ9XX4R4Q1a1aeRiHmam9KoUXE8wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF19XqVZDXuI2nMDSIGGhXfl905FKcTH3KetgHfWOUo=;
 b=SZyZd/YQe0FGH7WQFvSOWjIhuTSv6pp4d5v1FOH+SbJ4ZEKM1n+6AZ/4uS/XvIOuqU/+mmWZ5xLS4Gh+vuDN9ZajVquELqkQKzZ6BTDMhsiobeRQ6DtPtH7diuwteqtoByxyYrJfrcCBOu00CSo/bS9tKfVyOA+7ltzhss9wgf0NZ4+Tj6KJJs+OX6ucj3EegghZvnLiZHwc7uLnzYXh/QtTem8Jj92YC/THVkzbl8tKl8cVBsqr5Mmxm/gO21hW73kfdWvk8a/lzE4Z3lzLyKRBVgyN+5ze9BtSX3wSdrkDs3yr2wzoOwGqUH5hMYsQbP7xZ2hYp7yPK8yL61QI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 00:36:24 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Sat, 8 Aug 2026
 00:36:24 +0000
Date: Fri, 7 Aug 2026 17:36:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <anZ6BUjep72GZ0jl@aschofie-mobl2.lan>
References: <cover.1786143520.git.alison.schofield@intel.com>
 <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
 <20260808001733.52ACD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260808001733.52ACD1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0634c770-0591-4aad-82c1-08def4e5137e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yGceVLefKUIXKrEovIB/zzFfSo8Wo1E3iRsAVyWbaqzAak2UPilGkumw72ogfBjkGiaMnACHIvO6HuzSvygz9icLw27T0AUHwuiGt0Wxk+s5hmfeDm06saDQHQqObyhLbXFWazkf0K5rPn2/PciLb4c4pqnJQzTiqaM5kgXJDPl329eG1yE/yAcPtf8tOFv0qPxx29qZTuEmzaqLX4e1Rc+r4Pcv2JJTFKukGnLyw+sLwq2oqKOzwvnDYkMq2j5ZRXZYIMD2HuUgzWpDL6FRet26gEVwDeKQoAh0nY2E1dZiYoJUcKKs6y3HEcXRCxF6QSlsmX18St8+J18iJPHSVjN908stYJQKO/8w6/sjl823ByUr9kfYkagT7iOmboOv1YTTb80K1UIWhXBxz+bgPbhiS1o5QvaLWm6EUkd3Xo4/18/xiyIJaS+o64U8l8E3z7/KQ8W2QItUwYGCwUYCFNZvVqEbw30P9oLXiip/qQNL52c89iyT31yk1sLjIOPWUahVcRN2h/BIpwXqcOQka8l50fmwEzy0i66xuDz1Gr9rqnnpoty22CcfXgfW8QtpTGLCus3c39ON04rjzuJX5qTqCDCd4qe4YpMUzlTrt3dz/hdOgmnEL92UE90E/vJVNyMWCVD4ocnBM4pb2gh3jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94NfJ/nKtetiDkXdOgZ/tPaXzkW2vleJMVTM2W9XX87jMQsJ5YwIgKLIqkc9?=
 =?us-ascii?Q?hqwZZ6OCoOg6JcW2M4Apz4YtHUDnXEhHfAGaE67f5wHZvH7FcSadoTPrHr9u?=
 =?us-ascii?Q?RZBR90hlVqZINzl0c7aD4eKCw74lr7R1frkCuQfgvS4MAdC+U1+wjv5vpMm9?=
 =?us-ascii?Q?iRwSzXQvJXPfxWK/gMANuc+AjubZhi1KFb6VXY2KTXQoJPmdUHTvWHQJTEQl?=
 =?us-ascii?Q?ca8F8ZIU3/E16m2WmPQb+kchZRbyk5/ZcKjVhcyOCJMAqjrriQ/E59E/ImWu?=
 =?us-ascii?Q?boXCEafmWXPcO3jfRlfZy8W/NU1dq73nDBMuZQt8hTpwRyeqG0z/mv3u9w/p?=
 =?us-ascii?Q?YqNhDA2UL0I5iX5UPSd3xIEjeDo9Tq2OBOViy7WoBUrxX9tlv/pX7zxCnmCI?=
 =?us-ascii?Q?HrHMHRmwxUifL+mgnKrkIn5nY7SMETeXa+tZxF5q+ZK2JVx4au5u9mmTcpeR?=
 =?us-ascii?Q?FOcAUDJ/C5xTCAMtbWJ3IdhL5OqKxWqkhHMQcoPPNft/rN7cYNYWBU86IEwI?=
 =?us-ascii?Q?BTJ+OY/IYCdJ5FgfWtUufdODmxHvQ/k2wi47MMBKg8l8FwyroX7Cbj1+ZUS9?=
 =?us-ascii?Q?p1E5KM78Xl4EsGaZ62v4Oi1oIn2ZiC9SKhCgHuxpohB4nct/tDIPpan3Y4Xr?=
 =?us-ascii?Q?HiKwt6PilIAIkafNAEgLw0nlq1o1hnr13fcAvslYnb0XfmXzo6nkSWp3I3yB?=
 =?us-ascii?Q?EBJonCLe7g9gS+LkIhC3rqIn0OZE8Qh34Otx1tRRKgE8D1PLty+E075gv82R?=
 =?us-ascii?Q?oZ3A1naphCZ1PE8zk8GlkePGU4J0QwgFdk4F6yGwU2jaGtNs7925GJJNfRoK?=
 =?us-ascii?Q?/3cau6VE32PyL4xNmBZS0+GncY75YaqdZbrJt16uA1MwY8HlsEz46e0pxwtN?=
 =?us-ascii?Q?d186sAWPRdF7Hc2TNwMRelvA4dpy/qrnY50hHZ021aLXuIq0mQLf3TYs/n2b?=
 =?us-ascii?Q?4NnxwYG/vqz64Jc8yKRKMMv3rpb7A+EExtSK1lJ8DtcB2c9JwABSpA7RF1mJ?=
 =?us-ascii?Q?YTsqBKYcqACRhpW6gSu8ep6E37ZvqVfmEVdZQ/Z8ZAxrGeV40vbTuzKa2OBd?=
 =?us-ascii?Q?QSLeatWnmN26qWFQDBMQpy3AM6OOvHXEP5DG07kFooAwbA/bkgb1ONqUESxj?=
 =?us-ascii?Q?Okd3TCw1BzGQHycgYk096DNkJcaPjvzP58xAQScblct3tVkw8wm68zPG29C1?=
 =?us-ascii?Q?fSsPjjYGA2838zh0kBWPutIpORVjIwEgszKfMaWhVvT2wLN52UHnKuLS1+TT?=
 =?us-ascii?Q?zSYbGqRQdLtiEPzPbRCF8x/3x7gppZRHb2n9us0XT8R4aOrlarOn9KF1w/u0?=
 =?us-ascii?Q?W9cUdOJkysUq7jjQ0sU82lNic/v5GG1rOVxdueH4O/oBKqYpzCJGHgpk0aMR?=
 =?us-ascii?Q?Q7MsmU+d6/zKRqtHbY6cRxKbAzkwkAjiCl5I/AFyo970Bz2/Wf+m6zERHmSB?=
 =?us-ascii?Q?/xl+e9fG7lMCgusUwZVhlycJbep5zoTyyW430tdExnzki4G3zgTKjB6dMHLe?=
 =?us-ascii?Q?wQ720FYKnatn0fX3l9BXE6uoFYuaR+VzVP1gzB7gHULa8EYoOCoOye8nRbu4?=
 =?us-ascii?Q?FuOrZDhwD3w4WpSsvPn0UFycBOJkEBwde25lO0RCVtHa1QNnWH88pb5RtYKI?=
 =?us-ascii?Q?uZ+1Na1ZD9heI3GRKz/oKrxNmGcKmw+78HkqK1+sVafpD9fxq6Z6j43a2vjF?=
 =?us-ascii?Q?qvUh0/jUrQyq/+1lGr9o0sEQLYqyE68PilnXw/TmqbnEk7JI/CRnqmGrfsl0?=
 =?us-ascii?Q?SpZpm438DV6FI0KNBSaHTYIHdOwri2Q=3D?=
X-Exchange-RoutingPolicyChecked: H9cCFjoeLYX+GvYvUXhcOOk5Lo5LE4bhGqKI4GNpYWCtg76KRMiODYyIrucrh8/oxxYaEITKq+28PiBJzeNU0cs0f+k2K1RUp75rxJSdvKPHveWyqGG7LTkUwov172bvdhBW0j8LhDOpTMIIpYXOlyoPJ1MUv00Zdn8qhBunMQ1yCHflqBN6lQfcErAnvIDZvBEc2d8hUfLj9nI3LLbTRTV0tuektcp4GcN4d0YEipPqBggOMdjfBwj2+kvXqnAqPoGjDEStNXacMlUkMKI3SFO5Ze8LFHm6ZA8QcL3gLDjvNFBDGFtRrKpxxIQImLoDcX/uxkQ6+ugZA4mW4ebldA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0634c770-0591-4aad-82c1-08def4e5137e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 00:36:24.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cW7y1pFQGS1+T9CFIrY8jx9mC1WekLNxtpmz+0/1X30R/WxNRSM2atFLsHQJCGU7IYeq9Nl6X8PxhCc6BA7cO2axnicP3n8nFja18FdOH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com

On Sat, Aug 08, 2026 at 12:17:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect parsing of the target list register on Big-Endian architectures.

Fixed in patch 2 of this series.

