Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133839;
	b=NDmvPzFPKWcfExvlr3jxKgO3jcfFHJ7hN8Xy3zxzVTOKRV/5/JmmZ4uw6QS/dimJdmzm
	 Dmr326IrnY5NCdt9y/bGY7jzoahqMVKszAmZMgdr5SaTMyGpAYX5I1Kp3dBknYdye0gW9
	 KDoLDG/NGfYY0dYgk6mu78qsx9n168CgeFE/pN/9UYGdroFmg8qXnsYeIb/twZbN5yrQ0
	 1m9kVC3XL/FcU9GOB4FRB5QI/4+5XBXN0x5YWnyGoIiortcSGJYqatWQir0o3+siB4CZx
	 3yRh+k606du1Q1LfvgEOmusFymTpxid8E0A5s9nVRqheOZyPsk7IAEs+Yn6czVORM1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133839;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jVWjsdnaq9izJ4a0KllJmHuVWgjFg68UmEbGvx0oEvE=;
	b=oPH1R00kb3qWgeot2iyq7srPtgt6U2bSbckXP9RVic6rgunHSBttBXBPCum7sviGLdjO
	 L/X4v+bsUiJM7V+Qs464nVTeDZbEjFmBVJtzGVyzE9OtN0fHgNyaSsmC+QNW7IFzMaRnS
	 4QScJx2hNPodWO/anezcf9LoBU1dslaULpRJAiTJBG5eC9PaP0ONqxrvaQXDj5pmMVETF
	 fGy14j8uSyh5iSJ1SnpCTRZ/jmojBaedawnMPRPS57CUC1uhRQ+58Gv5runEQ2S4Gj3lq
	 bOduudEuVLZNQrAun3yXSJL+kIQOlk8v4CG7hmeUpJ1c4rk3WdUmCeiqqCnFe9K7obA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ld+PxKOs;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jRk6k36v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592D606A325
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 00:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5592D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ld+PxKOs;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jRk6k36v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795133840; x=1826669840;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nOvtrC0LS6SyuXZfS+hPeZii3vdaIG8QmEDfOmgizfU=;
  b=ld+PxKOslEN94IOjDVruGgPiUn6l5VZjOQTs+sl63BhStMNNpJMiCe/E
   QQIJPALrNa65zvCBqEQ95Y7nnaxNKyrha8ezHyM5w8Q/1R4HXW0P+9JGv
   9MdiiYq4UtopdMFB2hgL/O0ZwTYlEKflCDCElVeNMiX3addiEzgwkgei7
   f9fwaqjCwOjxGVLdCS9umEJYLzHsfd9hMBez4RPcr9Nwi4dHFtdn0P5Gc
   oYkiZDwFmIEMRa0SYI+RQ25JCINAsg+Y7kGcF2d4jOzxR+kkkHINu9tjh
   Q8DEoHtuW5IlIhAPk7S3iUB4eCcLbXD7DnN4ycXMRFXsJMsl9a7+JL8Ft
   A==;
X-CSE-ConnectionGUID: fZNbXEOzRVC9DNF5vtxvZg==
X-CSE-MsgGUID: 30eWXIdBRs6V15gUcKUo9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3895965"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3895965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:17:19 -0800
X-CSE-ConnectionGUID: oDVcysXWTiu4CMwu/9So/g==
X-CSE-MsgGUID: csv/HXSfSXKHxnPinQN3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10827538"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:17:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:17:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 16:17:15 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:17:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lupnnjirpvy2Jed4ZN8Rf8wmc0Rl6QznnZ4cOrlor5kMUbhNELjGvoA0SkJuEJG0Rish0RvkPk8V2jcoVFX1fEdGBWDYGOc0dfnGG/yqgEO2I6d6pezoXHJsZp3/E6MGbY3FZRFQFJ0p6UK87aMBjlTqIm1LgKBh6OzYDUHrF61i0ovtVUe/J4n3L3yvqf9nOCDmvxq4XCRAhzm2tSto45NWXfpgpFk1vPNBYVBdyMgZY0EsRITHwf992FfqYpFVZTwFCNVrizcFy49uHuz0ixyo/gluECNiRrSv2q8fEBZTXiIQ8py/IAhiTSGFwg2z2ytuLPkbXQxYKKgRT6izyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVWjsdnaq9izJ4a0KllJmHuVWgjFg68UmEbGvx0oEvE=;
 b=evwC0qgkcjnC9i1IEC3juMC7u0D2ZkxPWs6zZqT0cpXeo0zqYFdXWIZXLUhAYF2jUZzjR6+X7WO4CHUUX+2dBwkfr+THboVjHl7/fV6mEmbcQoBbWYipIknIyMNANG5RWRPirlF+e16Xd7eZsZqPcTT8isU6j27exOQ1gjoF7ODLWqlRrPt9MxnRGmdrqOpuwr0+7oJlhUq64wbl6sXdCVjWjXQgGJ2Ilr8i86kFku/OOlpkX7jCUccx8dCWu2wfmKs+TmxyWlGx75sfP2y2Y4ZA4fEk+mVknElwMmfza4z0XX9KFyOo6/01KSKi8CzA/YMmA7Q6FMV4AnLq+1WqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVWjsdnaq9izJ4a0KllJmHuVWgjFg68UmEbGvx0oEvE=;
 b=jRk6k36vUgawdMR1Nu9/C+6H6jfjp4uLselxGA7hItftrUmt4be5ZzgVnA8nBpuCDr9DVYXUoWlwHWF4/8aLVcAieR0UJQEuWJgR+Sm8f8Zd/8a/gN1zhLuhRY9R7cYR76UtXvy2jJYW0x8bkY7Vvt8L9j/WurUhErprby2P+H8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV1PR11MB8852.namprd11.prod.outlook.com (2603:10b6:408:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 00:17:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 00:17:06 +0000
Date: Thu, 19 Nov 2026 16:16:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <ming.li@zohomail.com>,
	<icheng@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Account for locked decoders regardless of
 commit state
Message-ID: <av-Rdu4k9alDszsE@aschofie-mobl2.lan>
References: <20261029201327.1119231-1-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029201327.1119231-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:303:6a::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV1PR11MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ec8812-fe2b-471a-daec-08df469b9be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|18002099003|22082099003|6133799003|5023799004|261022105027099003|261021123027099003|11063799006|56012099006|261028144727099003|261102123227099003|10067099003|261021121427099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: daT9ke1SadiHkWW0J96fQ+KoeHECkG15+fzf1vc/PEGW2jg/6w3Mu0njENTR2sjfCkDqf+eaS3bAb3kdvpmC68sU2/JG2JoJkw5ou1lkSOyogfyOr8eG4fDCBmFhH0nuWzl3HTVJhCwUiaBHYwBgaxRaEGveUpN1pg48lbWijrQq4R1ZvmfRERvkKeLwmrDBocCLsvvhtFGj0CH0fBMjfnFPYwG2dyCoCi9EGTOPRzVtLZk18ANqAOAs0OdzMXuu3cQsrOf8+cviWgfIwuXXOeSJLt7yCkWzW/2ExtjFtzX+5Z5hXPx8jgTMADAd1eizEtI5XfH4q0iG4QOb830X9Ediah5c0uhaLu/tYX+kUczUVe/qsEPClWn2UQZkMKZbX83eAOw6MuxVRwYhWzOOGe+c4A03gI3cc1SBy39wJAh5LdQdQg56bs1w9NeRLmiwPepBqabIgrNCJlKUIjRz2/b2y+eB1khB4u6HzdLat+K8IqegVEXzQyLCbUF931Xz9N8V7KfFqWUesoqpZchn+BNbzjRJDwrPp/UWvR6SAPn4dcbu52Zij22ykfuMEKPSYxj10aiSNxUmWpbNLezXgh5kI13q8vvafHqrAqhUiLaSoHCRE4vgOAjXPAvlN0OgwLu2Fjo0z97+IEE6sWotBhBBvfOISvga41SJK8hho/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(18002099003)(22082099003)(6133799003)(5023799004)(261022105027099003)(261021123027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(10067099003)(261021121427099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o173gDpuL1l14JmeQAWEMDmaEvx81TWygvqCW+s+p9qPl7XubZho92QBfZ8y?=
 =?us-ascii?Q?6nW2r69mxKNbbBGPXYX8PcMj49l13g/VqWmHZpWB1yZWwNcSNDc8qLMRC+Jn?=
 =?us-ascii?Q?ercMAufzBax5CrqyzyilGeO5z2uOR4brcM5F+NHMdZdTbEVEbMcwq7hpBmJq?=
 =?us-ascii?Q?nH/3bDLHmSfXTRUmik7qPzZ1lKTHDy7Y1YFJ/OK0BGeiLBGWIgXJ4uxfRY7r?=
 =?us-ascii?Q?0qp3Pmrfki1nMovGJ5hVsnZQ4SJ89oLjvBsIOaax8jLasYtg0kppiiPfYdve?=
 =?us-ascii?Q?BG6DZ8q/Jvvc7yFpbXmL0OXZHqc2TI1phlE4EHZTPX2tDsnShoVDhwOH/iVk?=
 =?us-ascii?Q?++zl7Lwf9un0yK76wApxS3kUpshdGCZTSCLIlExJclGySZxIVoGlJPzQVpPj?=
 =?us-ascii?Q?SbFMnYKN5wnBeUhEkUvMD1x3vFebcSaqrCjBkAwVehNmYrjFhAKedDg7Ifn3?=
 =?us-ascii?Q?WG6BCKFvvz1n+lpZ4v7aVYnAl26GTjsdg+W84NWNtDsaVzS3i12YKEuyhT5B?=
 =?us-ascii?Q?2WiI42ZN+2VRyQXW+/vO+j519MiojvHTCeg6Se23rjQn/T4r/r3yS+C0ZZdz?=
 =?us-ascii?Q?Vi4q7fOv9gvnAv2EJ+Jx+qbHZARGKOxk8xUg2b+bPJH2D7IpZJOIzykgec9T?=
 =?us-ascii?Q?aaRF7sh+IHL1MCmnCI5Hnkr6i1oAJFekJcYEcKE0cUEuL2fMLS6gSp4gB2ku?=
 =?us-ascii?Q?gTl3arpn6jhrd32qPF7PIMSS+YmYtGkIUSBW12PzxeCL13075bt2zT8Kp5m0?=
 =?us-ascii?Q?P8f5NJASstEYeQCDjnQHGbomKEd5CfIyiEmORgat3d7ujtlztSMciIjp6nUX?=
 =?us-ascii?Q?qYW8hwjKlUqBAn4CZ5iNlBauF0LkBuFdXWR+dgrizobK+esyVzjgzNX7ZdeZ?=
 =?us-ascii?Q?E3RfOmDGE2WgXZXWS+FOplp72T3xJsIxLQYLewglXEmSNvA9ZEL2Yo24f21i?=
 =?us-ascii?Q?Cs2VbJIbbs6X/GHFfcBRrPN9R1Dy02kynfHSFaw1bQInmcsRxI++b2Yjl5jQ?=
 =?us-ascii?Q?TUY/0PLRsuCaNt3RpmyRFe5NCPetRWWMlrqE6hRYmSEAqV+mqMxIGuv2cACf?=
 =?us-ascii?Q?BcRlPnJtDzW4ZIHX56MkOTPZDY5RnBmT0Lcm8lXsPV7+9Bw2gZ5SOjpKZNfR?=
 =?us-ascii?Q?GYdC/ulOABdorIhqhGFbgu7neNREuzJz6yul3WPjAFflYL8yBc1XR0dQY3EY?=
 =?us-ascii?Q?FFQw2r8IhAd6PNRXpZ3Gza8dPz5uZO3Kjr/XA0hGjM/j0UTnvOXIgNBf5kMX?=
 =?us-ascii?Q?7t7W5fKg3JDmwjaQR1Xl+ATuCLmMsLwaP8vHjQylmhbWmX5N5jB+vbeHM0FI?=
 =?us-ascii?Q?B/T1IZWRhMgNze3xPhUqzfhWTpXWRl4SzbSLPIMr0k2rahHj/bjLqe7vn9Tk?=
 =?us-ascii?Q?xpJUZQ/seK0LeHXaK3ijnT0NbowCiL3eoHFO15iWFrxLtXcJwrzAztnSjyhv?=
 =?us-ascii?Q?oWmrV2bip+K1Bk/YkfOWBSpZKrdackzXcCQo229Bfm1Ma/waWHpHUhzb0wAJ?=
 =?us-ascii?Q?88aTzkEsC75KY+Jt0SZiosiAog/ltLbUIGyl9Y1PfPdRR3FxHLGss2EbllIS?=
 =?us-ascii?Q?a+xxC8TqLr6Eq8N6CIZV6fK3+HQ1A5KaAHzzCIR3y2I6xeNYuqmk64kJnj9o?=
 =?us-ascii?Q?4qnLhiGV1+sBUliFtUi5cO8VGGINrUmlWhzZ1sL+ZWfKDYYx/0YiUNwiIWq5?=
 =?us-ascii?Q?31SERxBOiTxmmgUiSQdHXVQorkVv9DS5LfCPhZzUygp2VahKqy++W/660Omh?=
 =?us-ascii?Q?RC0TJ9A7A2j+ozKOlrkehKTYTF+LCZc=3D?=
X-Exchange-RoutingPolicyChecked: RLJHTYYCgTzVmG964+U/kWBGFLBAFQLB4/zPFwDNTdnPfEh4nVVBn3r/WUse7p2Of08aZfKkVS01UpEIbhNSYcZkpTygv/GDO8GoO2R2PKNj3THjmomk5T81RU7YR3eaH3BMlBzu1In6dizZ37jlDa67/2OzCz3NkOGhX2J80WUsRg7//RXjg+iPMa6MXfaICbULazxQNEZr9BVPrSaEqlSnev2Z5FYS0y2xU1JYOUnXDf2ODkPF52okFdaMYVCuX+EAXjFxRu9IWNF2l/3gel/GJXt3zdTKFo4tf5ymSaumGzZ1/suCmKyqZs+0Q5yFh3jD/TqUaJrrVTsOCnsr7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ec8812-fe2b-471a-daec-08df469b9be5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 00:17:06.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbzSnjstWPAkVqycGJHv71fvVHsY2NN4SWs/cZ/LwErk4C9x/el0zqOu0mQ/QzGFJFzePuJBPqLKnZJAU03jeFGf7ZOAZ7YyO6nVGwPMUXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8852
X-OriginatorOrg: intel.com

On Thu, Oct 29, 2026 at 01:13:27PM -0700, Davidlohr Bueso wrote:
> Firmware may arm a locked decoder it leaves uncommitted, a corner
> case albeit a valid one. Enumeration only records the bit for committed
> decoders, yet setup_hw_decoder() carries it through and the driver's
> own commit triggers it read-only.
> 
> A later region teardown then writes a reset the hardware ignores and
> clears CXL_DECODER_F_ENABLE anyway, so the decoder looks free while it
> still decodes and releases its DPA.
> 
> Record the bit regardless of the commit state, such that the decoder
> then reads locked from probe, and a region built on it is locked at
> attach.
> 
> Tested on qemu modified to enforce locked, arming the bit on an
> uncommitted endpoint decoder before the endpoint probes, then
> committing and deleting a 256M region on it and creating a 512M one.
> Before, the decoder and region read unlocked, the DPA is freed and the
> second region reports committed while the hardware still decodes the
> first; after, both read locked from attach, decommit fails with
> -EPERM, the DPA release with -EBUSY, and the second region cannot
> allocate DPA.

Hi Davidlohr,

This does fix the stated problem. When firmware sets Lock On Commit on a
decoder but leaves it uncommitted (armed, below), the driver's own commit
locks it. Region teardown then marks the decoder free while the hardware
still decodes, and its DPA can be handed to a second region while the first
still decodes to it. Refusing that teardown is the safer way to fail.

It calls attention to a wider cleanup of the lock tracking. Lock On Commit
doesn't lock anything until the decoder commits but the flag is now set at
probe, the region picks it up at attach, and is never cleared afterwards.

The problem with that is the driver treats a region as locked before
anything in the hardware is, and keeps it locked even if the armed
decoder never commits. A locked region skips all decoder teardown, so -

- If the armed decoder is detached before commit, the region stays
  locked. A region then committed with only unlocked decoders can't be
  decommitted even though the hardware would allow it.
- If a region commit fails partway, before the armed decoder commits,
  the unwind is skipped. The decoders that did commit stay committed
  after the region is deleted, and their DPA can't be freed, though
  none of them is locked.
- An SBR clears the hardware bit, but if nothing was committed the
  decoder keeps the lock flag. The driver then commits it unlocked, yet
  the region on it can't be decommitted.

Could we record the decoder lock when the driver's commit actually locks
it? The region handling would then need to cover both a successful region
commit and a decoder becoming locked before a later commit fails, preserving
the locked decoder's resources while unwinding decoders that can still be
reset. Locking the region only after the entire commit succeeds would miss
that partial failure.

Your modified QEMU is the only way I know to test it, since cxl_test
doesn't go through the real enumeration or commit paths.

I didn't prototype anything of this at all, so nothing to concrete to
share other than my words. 

-- Alison



> 
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/hdm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fdcef20e01ba..a34f3509ab1f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1064,11 +1064,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->flags |= CXL_DECODER_F_LOCK;
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
> -- 
> 2.39.5
> 
