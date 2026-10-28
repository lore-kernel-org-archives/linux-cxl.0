Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793150101;
	b=yIgSw3qDmctdf0vKtb/L1tox9fpfoZpiiu/07QPKq3tpa4P04aaiRuT74ru350SL36Ks
	 yKGBzFVVUExY9oVefBgmKRBnPujvngqNOPhFpCmWYtPrhKjed7AZGHm+kFvPSw37Qisd4
	 +/oaQJ4J3Uepw7/pPhJjwRO1bqZBW+ZqmEph6sClW1gFliRShlKxawTdG9zlTYOxecpfr
	 ovny3lBwtFnTAGgq6nMb0daEVOBMPsxAvmZCfqayos9Xjn2KTYkh+/sa5LlA5lZtg/vXj
	 WcdRa+PYJT7/btkDFUXl9JWUY2eUp7AeNGST8tE3CTPUySi+zq/jLOIPNlBJpfOgXag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150101;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=C4fGrLlEGOYJtsXAPJZdirRbBI0XzlxQQoLCBBSyb2s=;
	b=wLckRS17bBumxpgB1UIvWMrxaiebnNkIHZ5HMwhvrQyGqxceXLdRaH0oZLRhpdFqMoGB
	 q5MJDsiVgIUPZqoNIwqixrXEjKvWpuf5BShzChFcLmqxzUas7tObl3GhRWwyo2M1b3KDw
	 KYD6WdTs+NxIBU9xUwjWBiMraaZpeBDMRPBu7rKw7DbGNj7aaO7NNKMUD8cY0YAp0Vh+p
	 IWPeFAfN1ie9C7p2ZH4cZhq8s0LaRA7/l0fD9Fvh+ZgOK1BudDKDb467TO0gBhGaJzWwK
	 hjkzMKkOJtHiy3u+98qFA56LCtZjBEq3bR1UutjRic7gXJ7fqUTTCKBYgzw5h1Qrmgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d9ZmHrna;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA949606A334
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 01:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA949606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d9ZmHrna
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793150100; x=1824686100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=14bqg245wK5Z39zxpmi2VlwzOr5FBoi6LLWVdF86PjY=;
  b=d9ZmHrnaNSsfHNvQ5Hb1xbfgNCyscKvmDtcP04W/vHa3waIeYF1lneUk
   wgoVUtztoKRQcKfGMjTY5bHDUYKc8ygf/jPmapz4X9BvXUf8p1lOSILVa
   3A+cJPrLY7b87dvjeDSwk4jp5cYtlq8yR19DPC5Jithb5dseTyPAbRxYp
   SUJF3mQQhFon2UqV7aDtElTYIDDC4VGC1/lSM65rPyyMNwyeyj/ahgcjh
   3vbAlF7oDE+kLJd85qzd+WitCAndRjw5uxsUUybRpSrL9QKPXfk4uUgvc
   vZIeqKOcbWBazw4OO8kWbShYkjJQZs7KT9ZBqpIiIeY7O50dNjQpjaOit
   g==;
X-CSE-ConnectionGUID: qXErCFk6QW+r79XHpIxsJg==
X-CSE-MsgGUID: AlMLoAW5RoeEdZAOlZCffQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1771469"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1771469"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:15:00 -0700
X-CSE-ConnectionGUID: rn0X9tt9T+e22+2LfhgijA==
X-CSE-MsgGUID: bYa1QuE/S6CpQlL64RXLlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5090388"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:15:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 18:14:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 18:14:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 18:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPaIwGpIVszyJPFskTl9QOhgTZHvEExadCzNgXwLf1/NO8LG6iBx6TqGRodXLZxRG6lARBiUob9i4YBO29MGyQDiceN6V4jlnZaRIt9OumRdJBcsAnMs7C7WMWcGsEhzVDyQ/wtsLiPxqCmO9enzYKQljAKXbWKJOyP9KBOmvaYI6mEj5DicewBz4vNVPweWsDXrVxE7eyaK+aE5oSdFLmoXAdfCXNFVuMOiFKYsLsRXRys6tCzhvHey2Ga4V3/zbi9LLuummSOzQSulmXT84DjB+bu4U23kAhDVCDJPjO9OVjzwwA63zJW4AlJWjzaCNEJ+LPVFt5vht2F6q9T+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4fGrLlEGOYJtsXAPJZdirRbBI0XzlxQQoLCBBSyb2s=;
 b=JHjq2GEbh9R0Wr/xM4LddP7mu3i6MgJQUF9UBWrPiBrxY8gP20+gMh30XiWfly6GrBA5ThrCdS7oe8cLvBxpcpKG0enrOrUjVVI2IKtWGOCYej9IalLQU0BEhabK0Y/AX8owOTGRpPqcuVXcjEjopuqFsWcv0OtuOBZzMmNnojY4HJNjPj8Aj7zs2rWDl0kosSwPIgDaCuhg54OQERGMS13ddc3iYiZRNOU4Zpki2cmQgxJV25+teS+7zWm3JMBRlyvp6lO1NCPxsjdcsB2wv0LMhJSBdO6zEqDqLQDizj0sva7tLbQNgFN/SoFvfiUS8FKOUJyVPcSuBf1GP/p45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 01:14:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 01:14:56 +0000
Date: Tue, 27 Oct 2026 18:14:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Make repeated targetN writes no-ops
Message-ID: <auFMjN0Pnd2tgvGg@aschofie-mobl2.lan>
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
 <1f08a647-0d24-4103-9382-61eb9b7517a5@intel.com>
 <20261028010657.2d95c3a9@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028010657.2d95c3a9@jic23-hlaptop>
X-ClientProxiedBy: MW4PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:303:8e::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: c6af1853-08bc-4c20-4634-08df3490e0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261022115727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|261026140227099003|6133799003|18002099003|22082099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Kx8GX7grkendZi6TfTg4M/N9KHjXCaL8z/CGBO/t1dEEcENmAv8AKjVAu3rsxC05x3o8jFtHZBl/aYsrF2J18MGore+Rq0Y870yPRm7xE1K2/kZj6Q7+66ip1tfFn1FhLQAblLfYe/rUiTrMhE/n4YPiW11D3bzppHS5njp17+p39/f96mSmCLr6NGBqjiMAuCTo8kUOOJQyoZYA2a7PadvXJ0K1Boc0t9VTLGdhmA/y6/qauDDWdgnPQrfvrGLkTrnSpjQqdPuhdSkIenhiKfDTRbiYhk4yVXMlaRbXKXse+LZj//r0I33TuC3Qby+GSlLI3GMWQXoEbLDpa8I+6zcxxE9kvxHaRMjWtnDoG0BgL+KU+aOdSql/fsnJ87liyWDuCCTzHNd+OOf6g7l+ylxEiAvcn1O6Wez4C6WPlCneBGQQJsCn7q4r7CmFp4uVUZL6hYXrqR4gPLtA1bBzBNecoqKZE7sJHbsi+IqvktgAr6yGmxE+c/Qoe6FFrBMCs6OFmjPAtMs15wE/8Gj/rYnkkTNd8PufclxbURtSjNTj1XB09bkNeoXb1cNs4VBhu9eu+Eb5Fv1kgQggvbn9MZGDuAbcYKgK5r2VNwN+rl6dl2pDlOsy8pE0pxOJjdXB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7iRaQ+SyIfNWWmI1nrDd+6nxFkTeJuYwR6kNpQkv9y36cOELWmtV7WnFdLKa?=
 =?us-ascii?Q?POndQT7oUQZzK6F8IoDSJUzr7ByS0DaqWRyFplbu4NWkXb+yP3fnCzYj/z+s?=
 =?us-ascii?Q?jOFEWwXIdTEKh3mYiAGTJZuG7bPhB6F2RiGAjmfMidbg7JSRUjpjy7PVhbcD?=
 =?us-ascii?Q?9FW1hPSBK9QUDPz2yEiIXPxNEsEidt4Uggm3oCFc/eUPh6q9+SRQGaJ0SZMl?=
 =?us-ascii?Q?bs33un/CCR5Os6BCAox48pgfASN5urnz23Q4blPRUzMUAjOU3ULmUW18Wigu?=
 =?us-ascii?Q?9a6Cgr4ZYeI8XXvKr88TcqQgW+vmtn4931EcscGLsHvFv/PjgoKfNvnic+wi?=
 =?us-ascii?Q?hppnck3izwAyO+bizLsOowToRJyur26FfyctArrRgDQyaFnXDqVn8r5/sE8j?=
 =?us-ascii?Q?0i2wsVoIO/Fw29Az70CPO4okEaX0TU1ebSziM/OWCGVeJxE8Ij98ynKI2DP/?=
 =?us-ascii?Q?YW0oSYrOVDO0Rj/UIfdrpkkKUtTQBYvxYH+z4dP1bNTczZLD5vKXUG6kNk/o?=
 =?us-ascii?Q?ED/iFbgQITqQMn0Lh1srLTwy5G9BmvTzwAYqmi8MaaI0fWXKRb814z2SS7f8?=
 =?us-ascii?Q?t2XXLS8V3uBcRW8mQbb+ierwTFdR25fTuE5lH3sMoa68EGpqBToQfnEBd3AJ?=
 =?us-ascii?Q?EA/0itrvdNJp81IXA3IS3DPkm9V6p6Tf2al/08DXm0Ffq/IYJ/tiB2LcNXky?=
 =?us-ascii?Q?yoSIaxJCNSk5Q3b2oJta4Rmav59c02GQOwKv6bKvGTCiQpTtKDE817XCozJI?=
 =?us-ascii?Q?ahN1zc6IZTSuH3a0jWVvYLKPMHUIgD3cfh9ymbT3uEZlmJEW5Cc29iDkeyp8?=
 =?us-ascii?Q?UfbBWbrcQup5qQXjKcoP4EstKP06obX2xTgBT+6tgKaIBSK45o9WL0shWhGC?=
 =?us-ascii?Q?cTSkJ/QQ6wEcPyjXOC6NZysYFI1P91RjIuMuDFayYmRqEKWjmUTGDAH/e+mA?=
 =?us-ascii?Q?yIcm/Gtb2ADJ2WEO2UnJsuiArHVmui6K0CSxZ/PXx+i0bCpSLbyKSQBcdxE8?=
 =?us-ascii?Q?EeCfc0T7wzPDfPB+trmNOYFqXgshHz752Kyk3duVL/ISw0TP0w74/sOOy47H?=
 =?us-ascii?Q?mUBv2VR9npmtNZrzuEPaYk2e68bpE8EZi7/EBZn2SQUvtbNrI11EOka9qgfp?=
 =?us-ascii?Q?9+d1M8XlyrLiymfJU+eUMjQnpT0xjnOMTB2vm9Tsk3vguZ+6YlqMqmjttuZi?=
 =?us-ascii?Q?8hxn5aKFwm7XKqDvhPFU2MZnBvTP3vt0ss6HXlhmqp963dKybgHB4ZqhtvVe?=
 =?us-ascii?Q?QoKT4S9lKnoei5UaN1bXdrXqIaGjYTgLcie4aKHhfdL+kpprQX4ilYfwN7EV?=
 =?us-ascii?Q?iSX9YLRoEQljFn8clBAIpmAqzoKpZlLAi2+JPuloQTRt83oOtOjpfxUD60H4?=
 =?us-ascii?Q?y4+v7gGVGPppfjYhALCrzcgfGXnfxM78JecJeedpxOuSXhvjPZ72mjHji2Gq?=
 =?us-ascii?Q?ac3BP2Fj4nQFhgsgamalA9v/B+WAgtGIp397yVTsEUn1yFLiu/aQDiQKjaMz?=
 =?us-ascii?Q?Ba1couohW2VIOXIdsijV8Z/wE9JvhlSjJs7wq3SxiZWX9E7GWptCS1t1T4VY?=
 =?us-ascii?Q?nrIODXBADOJmZT2I+GwXbpAdniFk3Z1fJk8bJJCqe6fX7CiKlvtcm2ySPB24?=
 =?us-ascii?Q?5nmtLcXhIJeHUWt7YGdUNI65nrRhxNN6zs9PpYzBV3oycoKH/A4vK/mkgprh?=
 =?us-ascii?Q?hZ9dPEbVo+58ybmh+PChCGGpTQFRR2TNMFpPasqPn3I3K9vqU0c1L5+QInuG?=
 =?us-ascii?Q?xw/II12oiS9nLqZENMonS3j1YSTKISg=3D?=
X-Exchange-RoutingPolicyChecked: 1OgDidfYMQszjy172ZRkjLEnyEaiFmCpRb0+Kb+eIz1xRdjMSnqtmCE/VF04mqsHMBakbzqkOhi0klw9FDe0Sf+gJf3uY0YUTRvcRn2+UpIvOGbDJwADERWwgc73NGnK3JlbP2zwXh8l3F46dgK4IQ/mSu0Szc1Y1df4Opxtgox0neZdTWOKdCClpHD4INFw2SC4EJbL406x9us2PMUqmwvMBSetnqdGLXVclCaa+oC7wxW/tAQhZbfnGtuIQOfdkeFFC1jwjJXimnNo5dBqyCEtrh73Nj50Ngd/uJQS8n+62fwlqyVYsHq8Zvd6z4NKo+uAu54inlP6PKGlbx3g6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af1853-08bc-4c20-4634-08df3490e0bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:14:56.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGiQ90xHE28J8cuHhJ7G3JN6v5x+662KlQ1j8eNXfosh24psvCsOi7xHXr4ENbhMHaW9brzdq6KF3EM0AQYETYceDftZoAe95G2cyn5Pyvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
X-OriginatorOrg: intel.com

On Wed, Oct 28, 2026 at 01:06:57AM +0000, Jonathan Cameron wrote:
> On Mon, 26 Oct 2026 15:38:25 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > On 10/26/26 9:16 AM, Alison Schofield wrote:
> > > Writing an endpoint decoder to a region targetN attribute that already
> > > holds it returns -EBUSY, but leaves the partially populated region in an
> > > inconsistent state. The targetN attribute still names the decoder, so the
> > > failed write gives no indication that the region was damaged.
> > > 
> > > Filling the remaining target positions can then trigger a NULL pointer
> > > dereference in cxl_region_setup_targets(). This can be reproduced through
> > > sysfs:
> > > 
> > >     echo $decoder > /sys/bus/cxl/devices/region0/target0
> > >     echo $decoder > /sys/bus/cxl/devices/region0/target0
> > >     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> > > 
> > > An existing check recognizes when the decoder already occupies the
> > > requested position, but does not prevent the attachment from proceeding
> > > and modifying region state.
> > > 
> > > Move the check ahead of the attachment work, so a repeat write succeeds
> > > as a no-op without modifying region state.
> > > 
> > > Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > > 
> > > Note: cxl_region_perf_data_calculate() currently updates region performance
> > > data before attachment validation completes. This is a pre-existing issue
> > > that will be addressed separately. This patch places the repeated-write
> > > no-op check before that call, so the issue does not affect this fix.
> > > 
> > > Changes in v2:
> > > - New Subject line. v1 as 'Reject a repeat write of an ...'
> > >   v2 does not reject, it treats as no-op and protects region state
> > > - Keep repeat write as a no-op instead of failing with -EBUSY (JonathanC)
> > > - Check before the decoder's bandwidth is added to the region
> > > - Correct the Fixes tag
> > > 
> > > v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
> > > ---
> > >  drivers/cxl/core/region.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 27e63e6dab7c..c8dbd9b29899 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > -	if (p->targets[pos] == cxled)
> > > -		return 0;
> > > -
> > >  	if (p->targets[pos]) {
> > >  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> > >  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> > > @@ -2128,6 +2125,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	/* Already at @pos: succeed before changing any region state */
> > > +	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled)
> > > +		return 0;  
> > 
> > I think we probably should do -EEXIST here. As far as the user
> > visible aspect. Previously when this happened, the user just finds
> > out that the region is broken later on. If you add an errno here, the
> > user gets to find out earlier and it allows them to figure out what's
> > wrong with their setup script. Given that there has never been a
> > scenario where the user set an existing decoder and successfully
> > configured a region, I don't think it's necessary to preserve that
> > original behavior.
> 
> It's not a 'creation' type command, but rather an assignment.
> To me more natural to just eat it and return success.
> 
> However, given it isn't something we expect anyone to rely
> on (and currently broken) I don't mind that much.
> 
> Jonathan

While you were writing your reply Jonathan, I was off digging for
clarity on this one, crafting this...

Thanks for the review Dave. I did think the EEXIST sounded like the obvious
match (when you mentioned it offline) but after doing more digging, I'm back
to the original EBUSY return, albeit with updated reasoning.

The deciding factor for me is that the documented ABI has specified EBUSY
since v6.0:

	Documentation/ABI/testing/sysfs-bus-cxl
	What: /sys/bus/cxl/devices/regionZ/target[0..N]
	....
	EBUSY is returned if the position in the region is already
	occupied, or if the region is not in a state to accept
	interleave configuration changes.
	....

That ABI makes no exception for writing the same decoder to an occupied
position. Returning EBUSY for the repeated write of the same decoder
brings the implementation into compliance with the documented ABI.

I also revisited Jonathan's concern about changing existing behavior. The
original implementation did allow a repeat write to succeed as a no-op in
v6.0 through v6.2. However, that behavior got busted in v6.3 (hence the
Fixes Tag) and repeat writes have failed ever since. So I don't feel a need
to revive undocumented behavior that has not worked for 21 releases.
(No shade on Jonathan BTW. I didn't give him that info in v1!)

Dave, I agree that -EEXIST would more specifically identify a duplicate
assignment, but it would introduce a new error code where the ABI already
specifies -EBUSY. I don't see a reason to make that distinction since 
userspace can read targetN to determine which decoder occupies the position.

I'll plan to update v3 to return -EBUSY from the early check, before any
region state is modified. 

-- Alison



> > 
> > DJ
> > 
> > > +
> > >  	cxl_region_perf_data_calculate(cxlr, cxled);
> > >  
> > >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > > 
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222  
> > 
> 
