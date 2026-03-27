Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CC17B418;
	Fri, 27 Mar 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630388; cv=fail; b=fLDXILjh8voENCMKqs1anGV5uy+QK2F1vdH7UrPoyvYXgDw62bjsX0VwVv8ka5eH/7WnlgqHdnujqyLn/acps7j2jnHHZDtK4kwgFAmUrNGUY8WwYZZap0UaF2CPlZJh1bRrO3romEZCUSTwVX69ByqVmhZoUfTWHcjIG8GK8po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630388; c=relaxed/simple;
	bh=569fipP/y6e/fDkgbeAKYSF5mBCB6Ogdzs+Q5eUaQKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gdeD4lqIt2YhwfIuCKaAcyGkcwqhLVrEzStS4KeC+O84SzWD0g/Bxwp8BS0xwZiCv7THD5o13FQKvfj6FxXXxHASKPsW/c5sN5Ae93ej1p0hUwR2y3AShUk5CU3G6Md+LdV6A0Oi+fSf/P0c8zPX5p2PmdQZdUlfT0j4nPqtQ48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTxEc7Kk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTxEc7Kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774630387; x=1806166387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=569fipP/y6e/fDkgbeAKYSF5mBCB6Ogdzs+Q5eUaQKU=;
  b=fTxEc7KkbEZcL7sLaovHGYFPDsK41GMTXhY+DxIDp7rkaAnWZ7J4SMn2
   vbDhWVF96dtlerhIHyCAPOj9m0KjR6dKicbirPW8JTMmlM/HjxEwrKc1B
   vubVVI7KvNvSBppVEsc8mX+oKVNmbSkXJvPRaEdmaulyp8Ppll0j4rN/4
   3zgs2Q/7QLLKpwLPL6LoQzUdYeh1bJIFhYBhZPWPI5XtleYDHP+9hrjzt
   YS3z7EkbZkN5fu28KFqe2iMFQjzc7XTkj2vqwIaH+ped4ESN2HmE0Cw9e
   QcHDyrWUW0sAYzN7F77W/i39yFEz0XcOgxSVbu65XZ7SnCB8Nixfe0dTp
   g==;
X-CSE-ConnectionGUID: Zvaa4/0xQhei7wf3SmQdEQ==
X-CSE-MsgGUID: vr0S3K42RwKmpgcUGufNGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="79614663"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79614663"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:53:06 -0700
X-CSE-ConnectionGUID: cUkqQO8cScmUB/XObq4Ixg==
X-CSE-MsgGUID: vnQsPWUfQ+2huS1uLW2rjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="248400304"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:53:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 09:53:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 09:53:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 09:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGknLxG3NuINYc4RbtqyvfKUXmBuBo/p9IN0qYIgQQXvYPjvLd5QVROLQ5uE/HD7XhYiJRllkAkAGqx8Y1ntuhM3y3IkJejWgxnfBAmVyWGmtY0mgbP1Jc6gq7jR7M+r7Lq/kan1gf6G0JGoU9lh18A65FYI2zwEP81KHue4FiGK//4rCxlg68WfCWvW7grctK7piliIyfF4gEU47PJSVTdc00AkdReFZppwPC96+rh29HzN/kmirbNZqsCY0r9pXC3XnzXZTZhpR/+K/feUwyOl2xYNp5gFGF+O5MNXD7MeD0hPwrlsiKu7qf8sqScuBQK8V2iDp0SLs9tigBNFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7trNzinj0JzivQKZk6NDSQXaKQO8UzZZRX31vqaRMN4=;
 b=evS2+vOda2pz4v/MaOhjLOrmrrxjf5V5pCM7LWeH2eYqmnddaBe8ZQIKQp5MOU3P9DeYrZD2lR0BpLCihsvdAyYQTqeOuExHWFZIIYxshjMWmeNgQy+tVttZS/io5buRdoewIHiz6y5Mwj2iYPaJXR6+q33MiNLyKKcGrYDNv5oiama/bsRnz9Mywq/2o0lLC51DFHHy+IjvAklW/wP+ZvIo5GBfBO+lplYiHwHRyS290QVe/fYKhSrXYOTbFkf+7ym4CzpJR/L509PavWaiSoCFE2K8g8w18P1DvyGc6sgrz6YQ9WQY1THfaRWwWwTmkkowgEbuNKJOwXZxf05xVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB4825.namprd11.prod.outlook.com
 (2603:10b6:806:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 16:53:03 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0%8]) with mapi id 15.20.9723.018; Fri, 27 Mar 2026
 16:53:02 +0000
Date: Fri, 27 Mar 2026 11:56:54 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <69c6b6d625cd2_1771f41004c@iweiny-mobl.notmuch>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-2-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327020203.876122-2-gourry@gourry.net>
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d98d190-423a-4d74-dc9a-08de8c214f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zPRIsQvukiJhxwNmLMPpmUUX0JhgBT7c346oTkB26kRG6F1JQjgPLWp3kqtIMALEF2h0YeUsu4hyhY8zp6KEBLQJWaIqZGN6NSjzlxqxq6eCSfI9isyZVV3yRBqjk6e1GR5v99XY3We+gXI1jm6dG8viUF9z8l3gX9j8xBd370OyeUvckyE6NmWQj8F+xHJqV5mc7AyuXJ4JTVAuf+8lFf1FKInMZHaeb8qC2DRC93nnE9F+o/YKHbc7yYLB4doCOpU1EmBjQe13wcogKJbBUooPfK4Aoo/E3nJSyxtjb7qo2+2cVfLDVhN7a4FSC1tCv2rtWEq3OpMrBjrQS3JWIoeL63Xibcm2Jnk8nOdBQg1mdn7trlx4ejya7lJkYGl3F9yHLAiwaIlAFHw7LaTGWgTzi9c6jphvk7bnxTpRWBo+4fx3svrM34Uv/0KHjkJ/xplTnGVjHaSUVV26mzuAyzPuC33Ta/IqKRjG1YGZkWAb3+eAZy4uZO76aXK2uTWVU/tx70dKHuFmOt1ysqCRT6ZvbQsCyjPesDGOsIKY/t1hasWfQxZkXIQG4zKYm7uyQkNv+5Q1zfNtYbjlulQ5S7ATon7cww3oMLl/VK/ijltXt0CEOuUoSuTsWlNioNGEw0e1AoPFfCxDxk45WRW4FvJKkzlvJ6P/LnPU+YqfzH5AzAHpR/NNDm9N5MsBy1d4YL0/sdQWQp9C548AmLiFKziMtxSeX61KNY+bhwuZQ14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9MICGeq4rWxcQeUCnqLpekADSDweNY1cLuAfWl9Du8EuIZ1IMGOTYPtJo0jW?=
 =?us-ascii?Q?DJQ+CLUVCzt4EIQL3qdcZPgACaL47Dx2X7a+mKMSBMgiYVcSax8BryZY74Oh?=
 =?us-ascii?Q?C7JPjEWfkW0MvCDcKLtQ6yk5yBGMCxIRrZDunjP8fxcbeJs3uYv0rFiq3R4h?=
 =?us-ascii?Q?UAIqKcUjnCknWZYm5j/YirZRVb8XSCabCOi+Q+aqdD5Dh/T8qw0ye0LL4J1U?=
 =?us-ascii?Q?xMVgEZ25XaQ8oZsAQVvmxBEOSaQdXOgWzTAqFFgacaZamLOmmcX8nJZhJEp1?=
 =?us-ascii?Q?vakO0+BS8jrKyEuibieLuwgdiDafM63G4BqsUbNbtK4/WIIxa0yvr5vKbQAb?=
 =?us-ascii?Q?VlBvoY0kJ4SPKaM98UVzjBJUgGeMK/gfkRaJIcv5fC1thBwW0fTCcKO4Q8c/?=
 =?us-ascii?Q?GFmzFMIVw8OwciIbBdqNFCXoJgd3w5/f1izqJPVbqHiaHf/3VjK3MN4DrMZH?=
 =?us-ascii?Q?nFrtN/x2I5VXw06CNw/OX/791kgdCKBD8K5foCrIX6eoUF0B43Tgfshi+I1J?=
 =?us-ascii?Q?AtJkWYIHRINlbrwx4erdKDBcjN6dR1DrC2XKmCHsIKJXkcW6reXs934OKGW5?=
 =?us-ascii?Q?rYRq7yNwJ21yoXvy+v8uSVB67+nDN1Essc8ljvyqI1aUqa2a2qZF+VmURizy?=
 =?us-ascii?Q?86Zi6NR/WRpaty/A3bbxK9aokdL3edGvlHWy2i0CRyqMfVBdcXRkz/r3iYGA?=
 =?us-ascii?Q?uKeb20UABkBMsqCUNrIUfOetKI/kTgDsKDIz/gIT/I+zKhHeVHxh1ts2hDV/?=
 =?us-ascii?Q?4UcEvUlmNForqE4A6kLgRkXyrNm86TXmRjYR0MSniCtXDbnbHkD2ExZcCZTW?=
 =?us-ascii?Q?7kHgr3zM6/U2LSB1s0hgwmePrIZa+AQvF7S7fsRsYPJevWmGVxZpirbx9nME?=
 =?us-ascii?Q?JRpjjSY5wTeaM5qNjzq488cr4kyRcmnYkc9NHhPbVeTIFV4Xm51Duto32lBB?=
 =?us-ascii?Q?qFxJRtGvwXmIu1gy+QoiznzUsdhvUMK/q3l+64B2m7azSNAH4oJ1EGGRW/eK?=
 =?us-ascii?Q?0UPEGeIr3v4YnGjhkOSOisE93D6A5At4UxLcv4Z7uRl8/9NDhk8UT17cIwX7?=
 =?us-ascii?Q?tq3q41znX4+xAV9x8byBhCA4w/hLUlmuciF82kNfJTrxDgnjw45H/VQkBRuq?=
 =?us-ascii?Q?wjXOKipYElxwZP3+XBBJDhfdNkffFozpXSNlfCCH815pRXP3X6K5vVpGvhXl?=
 =?us-ascii?Q?F9m2nGWjEkq+fMnEdWWUPSLkt89CRuQxn6bLTGqwIg7JMvWwM4G43FkwyZVl?=
 =?us-ascii?Q?tqwMKuRyvQtY/JPQ14Kg/4lzOSNW204+u3HJ2DcxOAqWBWyuaVf2EngBpVLr?=
 =?us-ascii?Q?ffp+3/rusnB1GL/0R/S9sRZm5+XgGJWCUj05cxQtv1MZnSNdDOWYcx2sfkSj?=
 =?us-ascii?Q?dAQyEoi4/Vacj5Umtjf5ZB4nlzUtnwHG5idZnttKezxaak/wLWiorjZofvJl?=
 =?us-ascii?Q?5DXlDQjpUYKA0VQRn1bGkjfLsQZ7um1tOsxdM988vw4xahOyVADGiaysQYl1?=
 =?us-ascii?Q?rkWfAORq9s3juCr8eWm8Rhi22Bgscdvbe0kaZdrvn+PKkdLvhqKeXgc6zgKi?=
 =?us-ascii?Q?vw9jzDbPvfxtVzHgBIwkxUUALOB1JfzRiKLmFFGtF/yDclpjA0XZ3rZr9T/r?=
 =?us-ascii?Q?AVFVComdKibF4M6lg5oBR7cILBZ25th0RJIX7S3ryW2o6nKr8iUH0v6A18Ap?=
 =?us-ascii?Q?7i9H4j4lpcVgJ/xpnpZeVh4EvMFxt02eaqwfjir9D0Q/fLG1aF/wBOtcAnXW?=
 =?us-ascii?Q?kPxWtjN76g=3D=3D?=
X-Exchange-RoutingPolicyChecked: rhNhDmi4r9YcrnNFwRqAxQUM9eQGvrgKTVSg7Gysv77dKN0D7TyKIEGEopD9Bnh4XE7bo5AjHLfq/HuPocSwrd13JqoiKhqmZ8fpO3Cna6ZEmJJZIB38upGUe8INyN3dMKJYLqvCgh/o/K8FL53LqhImuwI5yLPyuiFYUZGV9lhGBLS41IRS7NHgDc/ODliNcngLfQdUGNuLuuFo5FTfBbCKdLwDrfNJqNuatsEnJH53UidepRiJOX34vy88gBzTx9ob/33ZPNDNxzc66MsJ75vQ0o6cznU4LfJAOSi67WUSHRTeBluplae8oHBT1maJj7Yrx2A9bNIFjgG50o8ymw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d98d190-423a-4d74-dc9a-08de8c214f4b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:53:02.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAZiVdcAR/c+WLpW2jJkUVP6HP7HQlBQ7UHTwLX1XaySREVk22eCeWbuvIb789WKJTgaqTm6XvFdEEF4F9FvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the pmem region driver logic from region.c into
> region_pmem.c make it clear that this code only applies to pmem regions.
> 
> No functional changes.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Gregory Price <gourry@gourry.net>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

[snip]
