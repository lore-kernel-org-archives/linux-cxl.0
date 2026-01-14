Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C725228C;
	Wed, 14 Jan 2026 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360397; cv=fail; b=s/0KHVZXPHkgfGq0uQAar5QVPG/4AQ1BWwrSlgWetYP2xcRt/va6Kw3pN/UBTVAoyHso6IYD3rNznlwIR9fqQ+Q6rrcTqhaNrpTEf46kMZ2b8t9QeXKTQTZqX8N1hZAG0JOx9CNFOe/vYYIXeKnd7+q3ZMQAKc9hpt9UpcrV6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360397; c=relaxed/simple;
	bh=4cpsnLpDWJS/rvNgLS/ZCe14rTPVe7qTmCZYlQ5ajHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLz/cQifjq28Jbo9Un29Owld2JQ2YjGNeZUIB2ly7P+mrSQ3QulG9jJ+7qc1Dgl3flLE6LvIVRD+vtF+zzuyFbNNjwDoT0ODF3eyFlcTCHTA2xSQBs5fR2JuBdNM8vXzvz7Qw2or2ERDA/CZ6jQk37aTiQRARQytnwxZ0R+B9nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6Wa7D3m; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6Wa7D3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360396; x=1799896396;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4cpsnLpDWJS/rvNgLS/ZCe14rTPVe7qTmCZYlQ5ajHk=;
  b=D6Wa7D3m8QZThc0466lECdL9MgI4RjjhJEj64Go9uj3sq9HBUklIc+uZ
   EYwR6HRwLNLdbjtwG7eR4IryrBWK1k2aeW0BtWqmmM1qNViUZClUEzQNh
   2KA9+Wibv8piHpE3q/lJ2DVugId/lXSN3XSk0FEwTmbE9yVxfyNOzagM7
   TQyHKcUYEp3ewnvyU8UOf4s5gWyIakkO0VU0DCdUs6NE65Z3fOQsxKIUE
   xbbimhn6K7SdbHrpRD3RcyYXhoLVB9JS1mR/QsidgGrOAvh2UHCGvoN/L
   CFWUmeWwxoVl9a79u43y6vHI+lka6QSes6ZpU+RRPzgV0k0wnKvXv7wDe
   A==;
X-CSE-ConnectionGUID: eqv7VVCnTgyKZ7U34sjO/A==
X-CSE-MsgGUID: lT6WQuZNRw2Y8N2x67UbRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69576159"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69576159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:13:15 -0800
X-CSE-ConnectionGUID: oMdNq/F9T8uND8D5se+kwg==
X-CSE-MsgGUID: BoQep/FRTqSIPJZiRkkcSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="235807304"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:13:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:13:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:13:02 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:13:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt0xUud+UvZb0ylqwf1cQ75zK8THjk2y7+SzRoPe851dZNCpn0lgbSqB6WadFm0zz7ZR1L7lZNOriUhFPCnHE5XB7eRurAp2crI2pBUD15iKBcttU0oFwyAjh5EwcQ98HpnzlRxODIft72ZgVOGtQ6/NFtcifMCtFtBF33P2MwoAbAehbhN8E5T4XiVepmjopLx3zA46rRZtBkYs6rKNaZLTV/TlYRGOpMA8f9cMAob1twV1c6VDTTecCoUGLUJhcYSCM7xxXQZXZEpCEW3ESXosOWc6nMOs6PqThlw6Ms2Swr1iIo80WZCiJ5mjvD4VrOmjSKHfg2L+YEEy9yyfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cpsnLpDWJS/rvNgLS/ZCe14rTPVe7qTmCZYlQ5ajHk=;
 b=VlmaYMkMK7FvvArM9KWiPUEUI1gr3Y8zKt7bmBE5QKdLykMVQQb/dLcUYA3RXwuDGRj2gqrkBNYBF7o1nkMRrNMZf7SdGnQS8sfUufR99PsYJbRs23V3v7BhX/LINJDe5VIrDMArX9WxxcuiiaEesDG6E2G2KGI8OKoa+zKwX/CiHCFBJ1HYnJdj3J0cZC5vBu7X/d672mFWmzblGg673XniIPrO3b/MYB0+91RCXYnrFEYQOKblIJbhIf6Uh69M2Laxzkg9zgoBvzySRhqlk3oiORAun+Xt88XlXiIwNQL5eZsHqOF2CdLlEC3VjKFysbSE8Yx4XOHAojupV20OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Wed, 14 Jan
 2026 03:12:56 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:12:56 +0000
Date: Tue, 13 Jan 2026 19:12:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 01/13] cxl/region: Rename misleading variable name
 @hpa to @hpa_range
Message-ID: <aWcJtayaNnycExVX@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-2-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: e2182bf3-dcea-46e7-9061-08de531ad021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BlDgbPT8qIsUL8JIR7oLzYppSEaK+dlv+fdzpb2lAYw6JWjVWULSq013YSHt?=
 =?us-ascii?Q?3OZRq7f63oWE4xyg8KksMAZJLw+P7j+spwpesn5Glba2KmOTurInExlTyBq5?=
 =?us-ascii?Q?jeb3lB3fDZx8x2KsxNelgVEB9hkIxDDwKKcsglWUgHuVY/QhsKRRy1BU48VW?=
 =?us-ascii?Q?yT/EEKwb+0koVl3j46GqtGUlF55yE3MwBYGAO6tRHqECSpZ8PCKNt153JMg6?=
 =?us-ascii?Q?FmLzGFyLKtEYtojXHIvaySloygnB+DCPKgbjMLmPiv7B4IR0i58f1+T2IKJP?=
 =?us-ascii?Q?lWE9sMND1Se8tsyqK/9wLPW0/HaUaMBgDPu8KpzzHGTIrLGo+Pcz/XCa/8W5?=
 =?us-ascii?Q?vagmS9DA0h0YpVUiWY9PshPEt3W6RQbQcLUP0DBa6HnnaB8aiJuyBFG1yH8b?=
 =?us-ascii?Q?MY0FxgHQ19MH8tkqgFwbM+IvWmM+EQMjCvswKcN+azan7qe3JYp8QfGnmbob?=
 =?us-ascii?Q?vNyqPW5lYMu8Wx5yGYduKsFyyir1NlP1GkCAeiFzE7wm9nnfj08mbcrgQy6g?=
 =?us-ascii?Q?EXDU4aoNxFY3f7OwP5lZXwS3gw6DbmI2OATtpVC02NIe8Iu1YwERvf/Ovjo+?=
 =?us-ascii?Q?2VB3b+mMGT5TujFQijUT2su7HPKXmMhcCkNTRasbJ8i3AhOLK35pYyo0d+Dy?=
 =?us-ascii?Q?ruJSZxNnkWFVWgmVFVP6zPs7oDjyQH3/rcm+CtGcMMyu+AT/GEhTeR/gndh5?=
 =?us-ascii?Q?5B1xKqiNn6uqJhVOamCa587Z4xvjxP1f8e7T/oOw23/4OdpeVCmuSnJctwIF?=
 =?us-ascii?Q?s8doHO5SRCJ8lA93f4Qa6aqZGW767JqaHCp76B1cDtNrnOKi5gKCs8KnkxOG?=
 =?us-ascii?Q?+e5QWF0c5Jkyil7Cke731sBoLtwcU74DQuN1UgcDHzMAxuVj/XHm9+a13BX/?=
 =?us-ascii?Q?SOSFmKaOSjUvHJVpd2Athvt3QkR2EotVMo1BLm1LE0lk5PbuF9vOlSlEP597?=
 =?us-ascii?Q?FG/s4wVuiUd6locti3iP1TmdMthxEeOmoEILS9ZoKv9HKuMPMzRwRStNEY/Y?=
 =?us-ascii?Q?o+7jFx8ZN+68IPaWJTUpwEh6E4agyrVA7F36GKs1zP6kjBSCRHyaLJTL901T?=
 =?us-ascii?Q?JWwGO2xa1u04FpdQ3Oj48EHrA3pTPj/73rxGFcRDHHXKv+BJjQjlJiUUuAax?=
 =?us-ascii?Q?KDU/VaWN2cygMqhSxFN7uH5JqLaok/84HiD3d+v7O7UKxsO/8W7yu68dKB4a?=
 =?us-ascii?Q?JiTlOHj8gahW5paEDKa6fe+X9kymqma+64bv4f1/cgmomzdlzFM+vb4ctipz?=
 =?us-ascii?Q?X0xhN3DHz56Vb89cFQwcoBbdaLSf85q34c4o7/zkM1z00QdZMJ8oTuhkbCfw?=
 =?us-ascii?Q?BrgNMzN7SFq6iprpnooKol8sogcoOSycKQIsq0SWXK4ZX6SeVafhk8oL5Gya?=
 =?us-ascii?Q?hB+Ag4RFRrWTMsCq1cmvisVVtfVZ+PkKIqwDBedaIqIsNTyNuMfNSjqwdMwu?=
 =?us-ascii?Q?4d7kEpOtnJQoBfw7WhCdj4EL3ck/ETBh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzGa02pdMMA3Okh/AoCXWKmZWi6rAsypYuCx0+afeUrsYsnWgTLTHFVgomfv?=
 =?us-ascii?Q?BzjgbGivWF0xmXYib5BuLwkapfyupbmax8TWa31zcTGHqq1us94zomXDY9GI?=
 =?us-ascii?Q?/FaIIdggSxr5FxJ5Yy2cCZsTkbcCJoIIdtayoqg2a/F8lOx3tx3862U2Ex4u?=
 =?us-ascii?Q?NQbmgQMO6K1TIq2SW0SGZP7PFG0jzVHy50a4kCVbwnZOvlc+n0yUI7QYOcyj?=
 =?us-ascii?Q?e7zhnbpKpVlitrWvkCqFnTbaUgMeMRGrIDcm4Ps1u7oBlD0ZX18SiOksHmrn?=
 =?us-ascii?Q?wcap/58Xnp+chH9PMPWshQvGiBlaI/AtfHr8LyA2uQ85kn/3QEkQKC4urQrs?=
 =?us-ascii?Q?4wKKBT3eAFyH0qTg/mgCrF/VHKZ4GLTWc5PWXaEZfXJ67XY4y1aH6CE6yCIa?=
 =?us-ascii?Q?gsZ7JQht+tHRvgRzMYsuA17RNPa57ndtyTU7BMbxj6QoUjyg8ZwirJkFyItB?=
 =?us-ascii?Q?6DiZQKgGSbmFxXYWPmYssUTcBJsziEI9QU7pqAPpEU8t67SSXfd/eI07hQv7?=
 =?us-ascii?Q?qghqzPVuqiBG+tjdsQ0SklJGuKBANfDb6kxY/8HqwStCPBMzmGxpDqWG6d8s?=
 =?us-ascii?Q?OzoF3x3CIpVv27I0SsjBs8l/6W052J4FnJenlfuX9MNTUXHUEYGkujzYNnpD?=
 =?us-ascii?Q?9E14h278kryGi+HkhvtzvAPFr7Sox3hoUF6MX2VTu9q8uTISIsS/SFhlMrZe?=
 =?us-ascii?Q?sD2+/Y/p6CtAGj6RBx9vuK9SdzGKrgKxbzoIF4iEwOxNw+n6buHC9oZODjtr?=
 =?us-ascii?Q?GgvB5iax2b4DGzmFsqDCcq3OPiXZwCvIKffe2JwxsC+zN+VhEYYy6s4hGmD0?=
 =?us-ascii?Q?cB0dfeZQOQytqEgiochgbgrCP7JijBmOuqCmuL0fjYiyhNse5u1FlDCPOL5+?=
 =?us-ascii?Q?b+Gljrbz/NsyLwSFL+XeTqYkthYDUICjRMMkPDTSZAStJ5/tGIdlr6uaA45L?=
 =?us-ascii?Q?o/oBgU3SxpOppv3gJBME5aUiXzbSQQu9/bbuBHjjuk/UEpZBPiMisyntFz8e?=
 =?us-ascii?Q?zoh8KAqJ7GgQ1jrG0sFdbg/Irbcwp44UDeKov6mmoB4MBPyRWQEAver0rJgt?=
 =?us-ascii?Q?JidmBS9AFL6g8Owi/+NXuriSYuFqDM5tnwUYZ4pR9YZzoZm2OBSaKqRgOWLd?=
 =?us-ascii?Q?Wu5sUur1M2wmhz3gMHcKONVHsk8JLeiHIvBjCcO0JWMCO4JEiQ89i4G2V2fI?=
 =?us-ascii?Q?6pOvJ69BjeiEaJ6/yhjqTvK3Ae/uK54sIqHmnG/HouZtn2TCTrq86wtp6TbO?=
 =?us-ascii?Q?OHN0o74li5ur9eSPiH5XvFGHzLWoWqOqfFv5ZuYLq1AGSFFnTBgctin2Pjc8?=
 =?us-ascii?Q?pTJLqSeTWF+4iIFLv/hxuHyRh50LeXqZNY9UcP6DTOI0KOHNrFZNqMEPm+/I?=
 =?us-ascii?Q?F2o29b/oTvEFi3Zd100JGnYM6KMXCuEQwyOTxeHLLcIvrstxIIWi3+5R1TVC?=
 =?us-ascii?Q?iQR/vlp9stzQePgidSDQtCnKEDfBC9yeV4LKxkpSkeGinWtwltA67F6Qw1wx?=
 =?us-ascii?Q?ZUt15tYZde/j+QZAvmo7EnSDmzKS36y6KLup5Xc8YqnJiWR2tdgAWT3EpLFd?=
 =?us-ascii?Q?6TE11wiXgcDrMj2rkjTXoEdp+Q263LjyLNuRo4kbalEHZhfHF/daWd+tc6IN?=
 =?us-ascii?Q?sqHI5T8f7MpYERoDCgb5RrrIAPW0rgclTs5Gv4/RGx7WPXcmkmLt5PNj0370?=
 =?us-ascii?Q?9LlqVDxio2DutR29EyU+lJ2wVWREv0P+XBBmtIHa45F5moHgh4wpS6YjiNrg?=
 =?us-ascii?Q?vYFbWHHZjQ7EpFuuOVoP7zIRTYrkwd8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2182bf3-dcea-46e7-9061-08de531ad021
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:12:56.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH9mzH5fWOgSIGBa1B6rnaTtuM8iuFdkpvGslRwGHgiNXUt835NkTNVQlrkKSRKUqIFfJt81iYqCEGSCEQH+vs66k9H8NP117i50BIdDiA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:46PM +0100, Robert Richter wrote:
> @hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

