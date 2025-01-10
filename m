Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278824B221;
	Fri, 10 Jan 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534935; cv=fail; b=S7zv8BYcaBdB1hbG8FrfoqMsCbwhKH6bLoLTnKGytwmct26uHEesBIC6RqS6YoZdXJPZAUOrXht8xtqcQlrsZ0KdqHPYT4UR3GWuiiK42PgScuq2X0ylq1g5rIDppODWKxKf6CK4ihXWvQ0Fd48JhPfvrYC3Bq/0pY3LKT1DSoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534935; c=relaxed/simple;
	bh=bu+VzWkoApF9xXC/uTlqH/yIchd5Ww85raypD1Cfisg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbMAvS5S0NxgoiTQxO9bohiS2b8Bk/T7rELa/MkLcVfdMY1FmJx/hwrAhHqSwz+XJDI2s28WT85XLPe7CLEjikoHzK3q+BZcefhw2Aq14XXh58quuIiBPD2n4E9+9uriXO+/28BvSTE1qztU3u0XqI36KwcFSLsuTA291/eGJWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5yuBvSR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5yuBvSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736534934; x=1768070934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bu+VzWkoApF9xXC/uTlqH/yIchd5Ww85raypD1Cfisg=;
  b=M5yuBvSR5ClzUWvK9ozBf2Erznywv2wSrpjjjPY59wGDwwwOAKQnKsbN
   xAZ6tc2FqM7LuyOXfOR+3Md2DciaLn816J8rZU//zDimGt/cNKAXU9hHe
   pdFtdAis5jNBroprfXNdNWmpnCNhm33TyX2b5+WgfZFwlzIr3ftw3iVwa
   k1adwBfIzQR2FufHAWJ03JKuymK42a7+bIa0UBx5xJ/rB9e52AJIUypmV
   oEz9V5UlQzIiZ0DUBmLCsvzlfVrCT6o7FMv44AAAen9E6ibKD93YbzIbc
   Eg3MaRw+EaFVCu9l99f9Uor9Bka/Wvu1j8cAK7gKs7EP4hLW4aPBOCTWZ
   g==;
X-CSE-ConnectionGUID: 8PBEDrBgRvmWcmKW+riyhw==
X-CSE-MsgGUID: +O3PbjVQTKeE4GWamVei1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="59319797"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="59319797"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 10:48:53 -0800
X-CSE-ConnectionGUID: PChSm707Qw24u1aRLmz0CQ==
X-CSE-MsgGUID: SowhValXSlCWpJluuXyhbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="104314864"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 10:48:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 10:48:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 10:48:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 10:48:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJw+3owDoL5zB6wDRIk9SP/7vJnD4YwNg2Ir7dkPAn5aN88PZ0I52N47VF6g0Ie8bbI2ryanp2muAfliQgQuYWj5+/YxYybEECpsBNef8CqDPWYJsu+s9g2SGGdUhhBQv0L2BsraeXW8bxD4G5qyjs2kwPIn975rE9rfUVmZCoYXeQMOgTiOdNRN4ZoQMRsie842OD5p+qIXSwvzATYlnVmwRgQnJswvRHQL6f2BXYBA1InEtX9vFrHGQw53kCrfJf4FXN2ZWvWZGmrbyjV0QPppB01tt24gv6xoMfsYVdoXOkmHlvMWBvPI2igqN8tQQzmtCh6cFYtAMlUVnvzURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcQ6E3guE1gnA8eGbFNxbYc/CrLALb0Kejntxjyz52s=;
 b=Y+khn41vKLlpjQ0BDbYqXeHwdoAsjWtx8OLBnyCaEeNainWseD2Xr6+FKN98yOCYwEYunbk+5ucEwIkMoJuM8Rfjvo5a8EjP4lpOZpdNB7728JAukyUk1SL9Nbx7FTxSVZ6riE86P5XSOpmo5nfICKFXQ2oSqn92Zj5yq0ilyre4USfbLOMADlpJhXmfVYuM8e19Jfl8CE6RP+rDDegf+IRYQGZn1nKiCDZYGvzCvJobnBbkkVoSqwu17Ii1PxhA7N7tnlAZIhrYqGHkACUpMo5XPU9Q85gz+TNd3G/ws7SDjE6L1wC+ZcBdPOtYrjJdc5SHgvpvKE1WeAWLthmaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 18:48:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 18:48:28 +0000
Date: Fri, 10 Jan 2025 12:48:24 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 6/6] cxl/test: Update test code for event records to
 CXL spec rev 3.1
Message-ID: <67816b783c894_17789429450@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-7-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: f414f900-c57f-44e8-f23a-08dd31a75f75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uQujGloqhbAzBxJe4o1LT3eBqiizyuTrvtctMXJykK6HPvj9FNekISAnPFJe?=
 =?us-ascii?Q?XjDaptU36kx/bsSI7kOq1cQk0zPc64SgtQ5i9mTu29f5cQ3Dnxs3LueOGCNu?=
 =?us-ascii?Q?wt4uBw7CV4m4yXgt9J2Y0vO4Q/BESL4vwg9brQO9iCU1mxaqD012eyGwNa77?=
 =?us-ascii?Q?YMDVuE9+1XHLvpmiE2JLP2BqTl2lGxr2mCLOu6dnzNJ7BuV/Hnpzqx5lRE0F?=
 =?us-ascii?Q?CGBI2ZMJVSt+RzFrfvH6HjoXHahaAlH90FFUGZ6B8mM9FW3JJbr4oBRMMQBw?=
 =?us-ascii?Q?pDdQNNV7dgFNOaYEi9wIztXBn4a49vfwrqiZjHi4A+goAQEdbCU+V4l5Wtsf?=
 =?us-ascii?Q?PD+XnjG8pXqZfEfO4RkXn9pdvnq8o+0zgs94Yl+DQWed6G+A+pqksKMyYJie?=
 =?us-ascii?Q?avIwH8I78D9JL7c2vTfzW3I5luC5g1P7S84ebzIVPcuoBNKNub20Iw3rHVA5?=
 =?us-ascii?Q?ZUXQ8G/t+v2sLK9qXE9oCMyz8O4vBnhgoiyqxw8Im5kiaYXvT1ekNIz7WHeG?=
 =?us-ascii?Q?/fMVNxNtUS8NV67ATRqitns9J98icne48tPx7OetxEjrr5uC/DOhj/MrfdCt?=
 =?us-ascii?Q?Ogp881xq41D/tvML3MLKEqqk+OQ5PqPox6cp/TxRWk9m7BeVzaGKoRhPa6V9?=
 =?us-ascii?Q?dnegwPAWpbNYmjiIJfyRgsd9Mk+/i/Q/aOU1B/zFFQtbWKtjbbFTOA9ToqK8?=
 =?us-ascii?Q?2O91PXbaMdjpH8/mFovpNAPSZmTb+9f18yBWozgrQOFkqGQciXJ5BwG3Obow?=
 =?us-ascii?Q?ujrJlLzvXVs4za1AFG73Rpunscz1dgWIqCG5KSfLrOUeCGgULTWTKtXJkhMp?=
 =?us-ascii?Q?EXY+8jNNu+FrfSvMIg3Rdff3iaNyU6rPeqrJcD9Wn5czLemJGExQfvDKIOYm?=
 =?us-ascii?Q?yqy8s/QNUcKWCCIbyzvbkeVAvRI0ScQIsAf7n0wz63DgvrjaazuS5tH10DEB?=
 =?us-ascii?Q?QKhmVa/ubuteb6/E7r0lAfUbo+iG/Al99HD3SkrypWojFj2h4JQqAmxdtvxY?=
 =?us-ascii?Q?JbPrbXwEpCcrUALYIhP4jCHfzHH5nYgLYBBCQEVMjvGjq4aWxqBySXfCnbbP?=
 =?us-ascii?Q?O7uSdZRgSOjhwnAFctwAj1rf11faDmuMu+W+l42YywgfRGoehBQJDpKE5mWG?=
 =?us-ascii?Q?aMVSlJgy3r4jhPzoTPmZXT/X4k7NgnNzKQGK2k5Cl80gUtVUdCldFGz+0lwC?=
 =?us-ascii?Q?hGR6fIkBr3ToEiDNMaJ/zlH8BfA3EP7bTeXW0tyKn0l9WaqXKhXfZPzUvPn1?=
 =?us-ascii?Q?c9cEodGr5qiS19D2xD/qoxISrx5ggKugGrSZCA/5wIK9k+E7fHcAztCmVG9M?=
 =?us-ascii?Q?61zhdg81cGlGm8PRE1lvVTDOc18xxNKvkIOaY7xw+xo9fOdZKVSPhR4xMCa4?=
 =?us-ascii?Q?fLZD54GTbubE3h/N2D8uGr3q5TWXQAGYkNgQn2Vp8wkbBildFIzfBbgsUuWf?=
 =?us-ascii?Q?yr4uC7i+1jA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7O/kDQV2DdXko5HCHn3p09cNVKoCi5Dfc1Xh007pgZnzzmj4Nr/jGfHy24tq?=
 =?us-ascii?Q?yLXsNlouwsfH+ig5AhIvVNPaGZh/2luHVW8anExa6V/OT4UArSc3mm0N2KN9?=
 =?us-ascii?Q?rfdYlCHmdC9+gZA2I1+uVWzEouzZKJbTegu5fV+Xaj7SZqZaNVwhXpEayfwI?=
 =?us-ascii?Q?QEddEbg4biPKS2rTmh5pj8biAl9tldPYq+FI4QUURQpJLzDbppIa7i0+IhZ9?=
 =?us-ascii?Q?vlKolTYi7kCySyvCnK3Kv9rzXsX57HA1DMPZu3/cFJspNkBQs64EymmyeRm6?=
 =?us-ascii?Q?Tjj35tkboFEp+UCmXQatb3knZ6kAI3HDsKWwhHbc6JN0moCMEYHw19g+x8v4?=
 =?us-ascii?Q?SZiUML0f/PHAtRAzclshlLTUnJruzSKYk5ltLFluaf4a5ji2538pk8WG6dW4?=
 =?us-ascii?Q?rpVgjnGxVrdKgOMwVgw+gpZWMSGWvCbKqL5/7hQIg1cD2ecGxWgU6Y2GpH3H?=
 =?us-ascii?Q?i9TcKaVHf0Qvm7qNHncNYUevM/Z3AbGJBDS4AtPjMcXS533wmxPtdioc3jQd?=
 =?us-ascii?Q?4zzi0XzLAGioq1/h7DoA8yG+vQ9kI8HQ2sDzEhznIoGfFFzT9l9FOfxCZ3qe?=
 =?us-ascii?Q?97fHOfTV225ncIRCCBDUdElBHWN0HHsY8kodv/ZQB3DrqQkOdVORPoKmfIgA?=
 =?us-ascii?Q?2/JmJ0h7nv6cfKr0BvsS51QLCEhck6+HNMz4F4oeOVDeP4RGPt6gTiqnil1A?=
 =?us-ascii?Q?uVyL8+Od8mdrMhpMVhIeHCYMNDCnMF5sm3IhdY+XrshF0aarPGFEI7vSLCfb?=
 =?us-ascii?Q?uXdEgnnUx36Pkp3hFMt3auPNjKsjA0CFgM0HrsFzjCtKyPcgO/bP2Vi+Ou2l?=
 =?us-ascii?Q?OyvM3940ePsPEjCjUOISZJERwj9gE6FUSnPeu+Ms2SX4Et3qAPgHQnZwzSDw?=
 =?us-ascii?Q?12tkAcveTPsOLGKwj1SHmrfkT2pnh86CYIq3nE7iZmiIuNwVLv51wZnho1gA?=
 =?us-ascii?Q?OlagBvC6vE+FoL2owkS5mvioUXiGwH8QikaltNmkKC5PC+ImDWReysFtEYIT?=
 =?us-ascii?Q?IistYGCa+25Ku7BrwdqYO7L+P/iuk1a4dyhgnGa0vISFW8AnAotK9AmdDlEy?=
 =?us-ascii?Q?arBTMaMmPtZsrN/NzjvFjRv2GlBOo2aDl045sO1+ETJcj7FsCi0dKC4LoSUe?=
 =?us-ascii?Q?ETBmKImIteco0ZvNtIZK/wwN4DxndXz30Jiyaf2arzwQfcE2NWyN4efEP+8R?=
 =?us-ascii?Q?MHT0czFnLlCKle9XWmFkABE9pc7HGy9LxN9TxuXvKXdEou4p42Ehaum2mT/P?=
 =?us-ascii?Q?S72366uINzdXiFRnQp+Vb9YKixPwgBMFhad7EBufOzKlLNJbNVF/lB4ziiNY?=
 =?us-ascii?Q?3DxFaouO09eS7RxCgsuzYpOXyB+2SXbD9oU/TaUvN7eXKfZILTS/9f1ggxRE?=
 =?us-ascii?Q?Ezxq4kUmIxofFwsk1XqkjN/YGOWbWKOzEdT9YbZt5oKgeqfd6MM5ea+X7Y+C?=
 =?us-ascii?Q?D6zRetpRgk7nzWpJD0kcYWpGmY90YKoB8ZXxQ2Qt/JrdZtqaGs4Y/GFFO32m?=
 =?us-ascii?Q?xhEy1kgG9EZU1tiWDkc2CWh/ta6Xg/KDrLYRlSmDn1+hjoM/FPIh3SgEgDNw?=
 =?us-ascii?Q?dKcTplDfqKgOYAM3cNArx45s6JSRBYFIe6m117ON?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f414f900-c57f-44e8-f23a-08dd31a75f75
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:48:28.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kN1g4YHu2EpJiYI3o4sLR8IHqAbzSXTsbDQhFtx9fEQn5etgSC9yFamDKH19OgcNqU4rkeNqbC4/WfidH7W5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update test code for General Media, DRAM, Memory Module Event
> Records to CXL spec rev 3.1.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
