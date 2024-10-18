Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8A205ADD;
	Fri, 18 Oct 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281932; cv=fail; b=uhaILBsveSUARF6DSgIBdicgdQFvLtW1HkphgsGgJ4oYJxy0qljYgonKZUkOJcMWmUMtM3BR+Jps3gvREyCvJR1bwALxkW2zLDflKrdRqaG7z1y3Ay0xkXQzkxkspuclRqRK+pOv8ZRcGWYMNVRDi1KPz0i9wgbaxvKNA5vx9zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281932; c=relaxed/simple;
	bh=N+T9Cnt9Y9ksE3CQnMDl8ybcEM7wWGpevaMzNh1J8ww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVvfLvcaoV9EjyF42x9hlLkKtF0725OzzyFjCnWy9G8VLnagEpGZspUMNhplwFsvk/m2ilU9oWEtgvOEYE0X3UEQkPqC/IgLxdHz+/MdW+PdChY89ph4vyF1jucU2gQfWNa5/AwpSgi5nQkQ44uXtbwfdKXTUyWsDV3FOuhxwUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dk3F0XPu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dk3F0XPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729281931; x=1760817931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N+T9Cnt9Y9ksE3CQnMDl8ybcEM7wWGpevaMzNh1J8ww=;
  b=Dk3F0XPuZtIYJ7u5BYNyg2I1NWXXKceSX7s90tSfB4D7/paRlBODCRYg
   n7pTyX4qhjNy4smDiUOoAUlBwDnk6KEn1SotAkDem5YUK/vfyjIhjvxPS
   EkXhlARaKEY/KiRotd/QDYhuYz6kHk2nEt/FQLT5MI9TOOkXS20M4/q8O
   D+cRCaCZ4QPq+TCnDSyE7nH/RyvcQQaqSavFofnmTCMAChX6KYiqnA4zL
   Ld81suUqQ+ehKimyN7CHLhTji8Q9zMuqalxizB0nLLvqsB545IO38x/0R
   3gPVhOKt8wQcmadE42HWDUUbIhyO0U1tnOsnLB8BeiLjGljzRKbrYfpLS
   g==;
X-CSE-ConnectionGUID: CTo0AZhlQmuUMmi/8Cd3nw==
X-CSE-MsgGUID: aoMB8ODAQdiGUEkXyEsJcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28987995"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28987995"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:05:30 -0700
X-CSE-ConnectionGUID: 3AFRx/2mSPqweCSSOkIgIQ==
X-CSE-MsgGUID: y0Q3qcEkSFmXeJ/jO1Zdng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79772576"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 13:05:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:05:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 13:05:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEV+7IPpTI4qoN73eRoSnmugi9H/fxNIAu8NSkKAo6vN4oDg+PJ0TgBSIO6opk7DQE/YTSWj7uSSD/3JZCZc5lFNvXAOAdyfTqNx3KhMFuL9ZJ1pmUhy1sQEIed7Xj7ZmeDMHk5q+NF6K72gq7vYidS60yMzgvemK1INSxt+6Q+olBCz/Oqg0gH8QWlGuiBSL+YO6gxuXSztRLwWt/cmcpEVOQmeobUa8/T6A4ySUjfb+JnaTpmILrwlxi5P950lrBKpdynSBvgqY2M9BeFILXNvKO3RbxZk6xMBCOtPeUc7DCEoDPhxZVUwIFWJc3RewxlYGfPKKvnhNuwhje1MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58Depf5Ll0PBNnZ0gaUMvolvQ8C6oWPHq1aIBrXcIuY=;
 b=OR3h3kOQHvOuQ7tKAA7RKPFX9vwwhJ2lyLiYvBgiGp3CCN/kNyve9xi959KSY0ug9Z25hV34lVtFCCvvv6YMc8uIfCFFZjf5qTXQwP0ORfwpX5KWz/Kzr8K8JTriW8oBxAi2EnLDaKZb3pROHvEbjogfy3BxRj8ldJFi2s7AtY3GLfrtnnpihC6ijD7F34EWD4YbjdSgVhWesLY0+8SVBOUx9kt5LOEG8Lck7/XU0llUoWrV4fEddCpMVG03OQInImPBvRxluDgh5nixkNMyb3lwqlXocsWq/18iz0u0oBoz1uMwttwH3K0vKVYcvbgVQkAu5iExGuva0OYvaqKFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 20:05:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 20:05:25 +0000
Date: Fri, 18 Oct 2024 13:05:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 078738db-e9d8-47ed-9e7c-08dcefb0347f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DsDjj0yBiGgB2NBEWb4BLAuSnEUyWPzNHZvNStiJO0MAYwLAt5vUAXfcAiX4?=
 =?us-ascii?Q?hl68b3bhT1qLoBLie9Rzg9s3+tpcKChV1eJYsNggVJjCyiNdUz3a7sXjuNzx?=
 =?us-ascii?Q?bsAKGuSyFKILEScECGVcnHQbI+uBQiGnIU82lfTiLO5N+8Q5YPgPN2Egbvcn?=
 =?us-ascii?Q?mxwIz1lL6anj6HHDeW1P/SpLr991louMujHm+5w63mGHbP7PedLklJc5J2eO?=
 =?us-ascii?Q?COni4VfE8a6iOSmPk1N5C/o/Rdq8A1uIeqK8YpU0+GEJDGTeM4JqTKPMerD3?=
 =?us-ascii?Q?vKYNFKRiGinc57zcqg3vHX+DJb5jbJMHhP+S8PqHdwpF4a+H2as/kXHl9aQt?=
 =?us-ascii?Q?O1z+U0f7JR6YlcbUiEwoxqybADJDqXjfTRUHp2sXidixM7iPfv04/EteLZJW?=
 =?us-ascii?Q?wWI4xBumxHElB2zTnWgOo54gzuX0Ip/KRtkVkHaPNZpft9tRvsHphpa5wo5z?=
 =?us-ascii?Q?6Y/j+zSm4bFjoNwAMTUQFAwAc5/SQg9I3nRJ/HlWGTbW5CD+Q5gYt5IGqkvl?=
 =?us-ascii?Q?DLNPJXxvYePQN9sQPWgtvnNeUuUj/a8dh4+diclccxCEzpWPukv+JbareGV3?=
 =?us-ascii?Q?TKxrzDXrth4OdPslDyXGVpxnQD+hjSK5WYXJwMILF0e/A757+NWYAxgCMFDV?=
 =?us-ascii?Q?pO2cR+gcaj4T2KXUE7Ao1rIG6BMcz6dpRfTpL6/XmsMgm5HVt7md5BQYw6QS?=
 =?us-ascii?Q?qcaX4gu80D01RFXwg8oBGBVXT/dVz9Ip935FDdv9BQTvQ5sb+KeI4RFGOpOr?=
 =?us-ascii?Q?Df3Gzg5+T5mHTt4A7YZyTyv35mo7TDLThnzLMjKoiX4UXcURmQ5qyAkpfDNZ?=
 =?us-ascii?Q?iXUgyOBhmdyfMv5ygoz33D7ZctVzvZohYnsHmzgw2qPVn/sIrztlbDqCk1m6?=
 =?us-ascii?Q?p9cAWx2mYk10tjr2jf9l3IJqpGvr1ltFn0njbrKuo1zHp5n3aqxVXfR3+MK1?=
 =?us-ascii?Q?thWtLm1e06tLB2PZiigRoYebxY6Xy4+Ajx69360ph5YCUm1atcvpMrlGXkXz?=
 =?us-ascii?Q?pdY0atjtiFwENWNPmEQvq4TtPh9w4FFd/IFL305MNE3w0OLNwQKb+8QJDsZh?=
 =?us-ascii?Q?FUve0kDCsGDA2IUbagAppOJU6kNxt3wRsZ0KeHI11HGhgO9umBdoWmXymsFW?=
 =?us-ascii?Q?r/U+ZkJpwoHGnu/gp8pP7FB1tn86I8GvQxdrk1yAkIGws9PkIB5GpKP/T1YY?=
 =?us-ascii?Q?4zDyUGjY/Mq+xaMWpMMdif19+WMTwzZ+EYQMkeHqT7Qti7UF78jJzmPdikKU?=
 =?us-ascii?Q?Dg6D3eHTUuqOxZfSqjroy0X8CvM0j65erVtwLHNHDvhiX8tMA9rCVXnTlKyb?=
 =?us-ascii?Q?42XzzlPGHZVGjnf4iyCnpekHIos2ftlHfyaR3VQV3aFFgOBbeazeG/BscQz9?=
 =?us-ascii?Q?bCAFLZyzDfl9ACedLUgcw/797fh9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LP6yx9Gkl0WNAieAcWD0rBfbY8hZzo9bFSPExeaL8CpRkBSjuwkfBGtob6eA?=
 =?us-ascii?Q?a3xR76KXMdX6bjgOw56J63nghENAYt1NU0Ta/JEl9k2xAKZXjQshT5+hin9j?=
 =?us-ascii?Q?ZyW7uEecYbPkWCIT6zWH1+72YQNIZH8y+peJeY7VlLaTv93wmENiNVaGLdcp?=
 =?us-ascii?Q?vBU8LyxS+tEMHa2fYOATu6HXfW2LWrhc5CFqTe9SC6IKxf36ppt76nMOJ8yI?=
 =?us-ascii?Q?f+wk2mznetLW0HYnSWzCuwse3nVQExWav8DLSboJrwsn1scvYnQJDDIhbUwl?=
 =?us-ascii?Q?PKh9Xy4pP5cvl4oOH+u5jyB5uaEqLqeZ9NbmuoLxAU6npo+L0nynTU1/tvac?=
 =?us-ascii?Q?6gF16vGFLYIL28/up4ynqDmfJ7EfnTXW8bwP8iwhLHFruYGMgOY0xxDwafu/?=
 =?us-ascii?Q?8fdetZGo44uhf+9K6yZJPdf5ygIU6nwWHHwZeXd6L1vEs3Yls6At4xXlLpHw?=
 =?us-ascii?Q?j8Y/9Ijdh+jva7r3k5l9+jTqVtvJGwm1vKXzr9TEiTrGCExTODQgPBU3FMER?=
 =?us-ascii?Q?yzLuSbXtQuVu20fWvzvfWEGKbzi3t42ldNY5OKLBNme4fyw/f5VE2ptfXsiT?=
 =?us-ascii?Q?/tgFQO4Q2fr/dJSEJZ2lRCWMfJbYfklVmaTvoO/zdoMWIS2hsz70fRqqyhcu?=
 =?us-ascii?Q?usZIB3fXcBwnRQVSr/GPwAh/fYuKivpxYJBXZlH3JOZJp1tO530GExW/9Vnk?=
 =?us-ascii?Q?btrh/5KivYL0ofhGIzK5K8+ZxpYG6Pf89cW7irYyRJJHa1no2KjxvTE+hV2Y?=
 =?us-ascii?Q?9phn4rKzGiRQHMrkwh9bzQI7jZpTqW9aQidRyP3lTyVBMIv54/uHRh0l5dY9?=
 =?us-ascii?Q?uOk9pRrv/CtlRRzHacVISjE5N0KJ7m5QoCYX4+Ca8nkCfx6ZtTEIGhLXIPVh?=
 =?us-ascii?Q?Xg4zedxdya1BK+fowFd7cq8fSHyHvtbxvDrMmQ5TxbQVHt3xJdKurHYek1k0?=
 =?us-ascii?Q?u2XGdrIO+ATvc00HdMAVHqNs/OUAAI2z46I3dIOAB5xg28mvIpXhFyNtMGpd?=
 =?us-ascii?Q?9Q6avtDdS//NsL5i32JAOR/o9p46j4XaPjzrYN47VKgsvFXyG1/p4XsfzEbF?=
 =?us-ascii?Q?HRdOPyNoJU4fEqExJYZPjYsJZsBpnu9pMjnX+d+pwh9ij3La07fn+Jw5t2re?=
 =?us-ascii?Q?1DUPhJqie/5WFDt4OUeHBLCLEj+FK897gfyM33tFvi4/MiK6s9Efs1WbOjLB?=
 =?us-ascii?Q?jNCdu/mrbOHfCyhc5sZICZhnjVT1ikGbqQNgGFj6EO1Ojr334A8IivQzYgg+?=
 =?us-ascii?Q?DK5GUOA78f3WV4yFHq7PmQ0/aVDNGVU2lyMeYcBbN6XeDfWUcRrqW+BCyPli?=
 =?us-ascii?Q?c9hwFC95VsGeK2ZWsFRk1V4sJY2FGksFZAPrjXKNdrbmiYQ5OtetWrp1SoQK?=
 =?us-ascii?Q?dB9S6LOQWcMw8pKSDM2AUeZnjXGsYvXlvs4pFK8UvED8ZnrrIrR09IfYLuKb?=
 =?us-ascii?Q?NKYzYXTDXyGRKHmRMXn0quYPoRMpe3UrxUsIMWKAEejJOSYD6L+j5bbDZfX5?=
 =?us-ascii?Q?akMOfqP0P3T5qGhSoeBd46UvXe7Y6b4KWHvfTpcUg8MxUwOMVG8iRh5a/VTi?=
 =?us-ascii?Q?2Q0kUY3b6g5zdYKnKD3Rd2DAiOlRlSxGtxe2PVf+rD+hFJDB3j36aPt6g3ei?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 078738db-e9d8-47ed-9e7c-08dcefb0347f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:05:25.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fONymBTZNjW7Izxjk5D0foV2EmyQRk3kAft37EInRW0JRWnneJ04eBWJ25nZ9jE+dWD7GUAew+jScB1n46OCCslccLKqnQlWj4c15CqsRVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> The use of struct range in the CXL subsystem is growing.  In particular,
> the addition of Dynamic Capacity devices uses struct range in a number
> of places which are reported in debug and error messages.
> 
> To wit requiring the printing of the start/end fields in each print
> became cumbersome.  Dan Williams mentions in [1] that it might be time
> to have a print specifier for struct range similar to struct resource
> 
> A few alternatives were considered including '%par', '%r', and '%pn'.
> %pra follows that struct range is similar to struct resource (%p[rR])
> but needs to be different.  Based on discussions with Petr and Andy
> '%pra' was chosen.[2]
> 
> Andy also suggested to keep the range prints similar to struct resource
> though combined code.  Add hex_range() to handle printing for both
> pointer types.
> 
> Finally introduce DEFINE_RANGE() as a parallel to DEFINE_RES_*() and use
> it in the tests.
> 
> Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Link: https://lore.kernel.org/all/66cea3bf3332f_f937b29424@iweiny-mobl.notmuch/ [2]
> Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: split from CXL patch set]
> [Andy: Define DEFINE_RANGE()]
> [Andy: rework hex_range() logic]
> [Andy: Don't use fallthrough]
> [Andy: clean up help comment]
> [Fan: clean up printk comment]
> [Rasmus: fix buf processing in hex_range()]
> [Rasmus: simplify buffer sizing]
> [Rasmus: add '[' to string]
> [Bagas: Clarify the start == end print behavior]
> ---
>  Documentation/core-api/printk-formats.rst | 13 +++++++
>  include/linux/range.h                     |  6 ++++
>  lib/test_printf.c                         | 17 +++++++++
>  lib/vsprintf.c                            | 57 +++++++++++++++++++++++++++----
>  4 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 14e093da3ccd..e1ebf0376154 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -231,6 +231,19 @@ width of the CPU data path.
>  
>  Passed by reference.
>  
> +Struct Range
> +------------
> +
> +::
> +
> +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> +	%pra    [range 0x0000000060000000]
> +
> +For printing struct range.  struct range holds an arbitrary range of u64
> +values.  If start is equal to end only print the start value.

I was going to say "why this special case that does not exist for the
%pr case?", but then checked the code and found it *does* do this for %pr.
So if you're going to document this special case for %pra might as well
update the documentation for %pr too.

Alternatively, drop the new %pra documentation for this corner case as
accommodating the U64_MAX size range case is arguably a mistake in the
caller.

Either way, just make it consistent.
