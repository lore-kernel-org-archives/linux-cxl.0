Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972A27C154;
	Tue,  1 Jul 2025 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386806; cv=fail; b=ijsjkPmTPStfR2cRlod7ng9zj6bI8yl9uQnn6LNtAve4X3EmmJwvTP4m10abcdnpjs5todF80KG9cpgn1DH3A8ODslPBfXeUvVu1fb2FbmWOcPXoakvlV2CFJoWBL39wWpxnNqynqozjPjKozkZC6LVqrbHAqNK74xllfjszWsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386806; c=relaxed/simple;
	bh=XCymMhu+LvQhtUrQwB2VYk0BjrTbcGSPsT6XgnZBw0E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePsXVwRH/xyKkGwbUIqfUYEapjvZN9zFufeJiF2w/z3sUOpekdMcAxZpGu5RFLcF5QKi1cQrK7Ydhhi8bf8JcVLjhEa/QvRe6J82Nu3R+4qbXUBpxWQ0z4W4xOzP8Tg4hSWyF9Fd9stVqQrsjDW5CWWaZ5SLRObr77mX9AhrsyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7nUJV4j; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7nUJV4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751386805; x=1782922805;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XCymMhu+LvQhtUrQwB2VYk0BjrTbcGSPsT6XgnZBw0E=;
  b=U7nUJV4jRUh6FHLqPlfitdm1isJ8lgNVeF+ATWZl1b+CXKctUXYTg66h
   JruRmHwkac0e8gfPyKH9QOg/au5riX0jH/ayQiou+dSLE6zaRDLgdpvyM
   gzHUrMUCa/8FSh7z9g92ztWKXQxwMMY0iMTqwA0gAUVFm6z91bouadh2w
   oRFKQ4tb0xXtHSMe2h58iaZnOIyRUaRCg4RqBKq0aZVDtx0unvqm+cOE6
   ASHJopn0xUWeJHojwjRjSvlz8seW90vjhPT3c4POvFviWCerMBHzj9R/1
   MLjGHlMa1a6XBnMR+JsaV9AvwFQJJo9O8Qpex0tFLlugCCbBiRQ6yQPyF
   g==;
X-CSE-ConnectionGUID: yMzJf52XTRmyHapWs3Q3EQ==
X-CSE-MsgGUID: AW545AbYR/W4w1kWfrBjzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64262915"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64262915"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:20:04 -0700
X-CSE-ConnectionGUID: YzF5c9CrSNCSwVl4PtjpEA==
X-CSE-MsgGUID: ZML1GxoaQ42B5rQt7vlOMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="157851104"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:20:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 09:20:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 09:20:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 09:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn8Sq7ficV3ACXenI5aPRXKGmZOrdzKogFScvV35zSeCBxyvrXhGmqe13hQjX1l8LWlOCMSm6Kfe/tU2N0PPnBc0Mih5EPkrfAtZENCp8u4mUDd9A/2TZZZuNSPTttXkDmxnK8EPRwzGQk6gcuauiEWsmAX3v1g+E91CgUIf0Cj8jxsU45TbV60g4IBke2q8EkVz2ozuKp1uRToeO2w/4lTHp6NhMTnivEN/ILjxG+3MsDCBUpDUWhj15cs2EmbeqUX2qIhICBQUtk/+reVSmypeUfLmPvhlvqgAtAE58TxOGkYVxfCLi6zmdF7Z6ijTpoRaNrPjQdXwwzeMWwXG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiSQmWg4zko1vqE0MMyFeMhwFRQWqfFnWe6R7DuOzDY=;
 b=nqiL5YC+tZqWI3LX8qMyGRxoTd3xo+kA8ikKmWj91K+HuoodiOKThMvS0TJ1/e55OAMYyrHkuMzoTMPRl5n7OoXSYJUGTAdnncWx5/KMzSr2cn9W5dF/juFaXHS5TTrwMn+8PYIYiaURxwtcdMaVY4Ksl15jQqxe44FziQ01U0Z+9efz6TPvfEyBSCdQa6Xwmx1JQCbTbo8hGUjQFxb3pbJ1t7DTNVg+B5W2ozCDhnq17qnd3b45ID85XkFbrwYmd+tEZsFR6ku967tebIDh61h6JzVr4ugNrhaBScpdIu8yxVB7jk9hWmRJUMkbTDpUkrzhg6AJhLfEsVO8z9DMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA1PR11MB6196.namprd11.prod.outlook.com
 (2603:10b6:208:3e8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 16:19:46 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 16:19:46 +0000
Date: Tue, 1 Jul 2025 11:21:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Nathan Chancellor
	<nathan@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <68640af98630d_3083e32949b@iweiny-mobl.notmuch>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
X-ClientProxiedBy: MW4PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:303:b7::19) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA1PR11MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3442b0aa-b7ad-4906-9b57-08ddb8bb1892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UDChpcDyUzp5A3ygHE4UILxnyEaan4TLCbZPZBU91dtQna0yt/TCx6vYK8qH?=
 =?us-ascii?Q?B9flZUkUnAn6r2BxOTNGU8lOZRjjczv68Y1ovJROoTrstP8ohVEgnYA1QSEf?=
 =?us-ascii?Q?xpW5/eL1fMgxbJnF4PDqaVv3YfPXOqQNw11wwC1M5k5z8pm6EocdIKpZrGcV?=
 =?us-ascii?Q?OsNE3W08VSZOemRPGelTiAHx9ep8+hSJWDMDM71JVJRo9Ean9j/IXuE3r83o?=
 =?us-ascii?Q?C/IBblmcIHSrd1W79BWurwqcKC2dS/LxK+TIS7qcMh6GH+ZN0/Vkio+IG7jd?=
 =?us-ascii?Q?6YaMSaxFLfguz22xUToRJcjOofoCE5IB7xx7QXNs3tCs6UgNouwV+2Xdj/Mc?=
 =?us-ascii?Q?5rBCsRyNwXPYOq2Go8b6dFGCoFyV3/phQnVoj2jAeeui3a6oQwBvmZwhOTM5?=
 =?us-ascii?Q?/JRfqwsTx9pqpFLJoiSw9BUMt20nBvr7QUe/B01bPBnp+qqgHB+PrL9tYKoE?=
 =?us-ascii?Q?1fqcx3Z1qKo08IXmMt99S8AQYZoPEvqgDYd7un+CFXgewr8ks6l+smMZovrw?=
 =?us-ascii?Q?T3GEtu8wK3SGoGqGkRntoMLG3xKMlJK4hXhibfj729oBaGUT07aqnA7vzeky?=
 =?us-ascii?Q?UdZpm1gfqT4ekmWcesWOMxYZQ4O6Ime3967hiHXvV1l4H6T9s/z/QuVQFHFI?=
 =?us-ascii?Q?z5W55VHUjhp6n5HnS7CSvS+HTQCt3MYMIYawjEv+wukpbtT+GAINvjhSnL+D?=
 =?us-ascii?Q?hSwxG4NWV45QuOH6EkszBSjf3OFsNNchc9LDDNyaQ4RLhWnKGNWOejrVDK60?=
 =?us-ascii?Q?rkSL9amqBiaYmOGFy3O409yOx/CXjAwHu2NYYNhiDvxQG3FlVbPBV0kdScgK?=
 =?us-ascii?Q?lJaweo+o0OXsayD7Ujl2KOnXRcYbxrLFcT5KT7KsexdE3Yv67eDU8OjtTC+j?=
 =?us-ascii?Q?4DGl0vNN4J+zO5FwAl3xHBKRUPI8Jsf0OTCjUexZQTcWnWjzSIQXDqShXXou?=
 =?us-ascii?Q?KF9ldfRjOsAOBugf6uHzToEMflJXVF2gPT34YrimmKp1EbT+G4TKdYWf1qq0?=
 =?us-ascii?Q?VJ3qUZdSuEDTzh4ig1+05FnkxExX/ngPQZvjOpZSJkWdkzqIHy9krwJiKLSS?=
 =?us-ascii?Q?AF6aI1vavEZRB0iqbSk5USSJmJVdh7GBI5ReUFoOAp+b6AJQ5ZGYsKvl0DMU?=
 =?us-ascii?Q?5z0IXDqDpDUQsqdlQqvJhYQdwZDCP4sVTL2rs4N86gmj1K9Ada3cVdawDyrT?=
 =?us-ascii?Q?0orNoeeX8m0jaeviGplKoY64OCy596hCN3gHCiOYViJgySncpmZVKidHWUaO?=
 =?us-ascii?Q?G61I9REdFgin5ouYyJ0Jo8Bx3GvxkJLrpvObc/2BxtFw1GKTl/hVgT9zD/G2?=
 =?us-ascii?Q?MuqnhFYMgYulmFkLMefbvKR0teT9XZKZJBlT2CiYM0pQ2CdN8TMZ+aKhTqiS?=
 =?us-ascii?Q?5kCakVaIsZQ+bONWA3mXiOAMvqkiQtdpxlgGMUMYrD5yz0fpUcLgO+icXgsF?=
 =?us-ascii?Q?EZKeqjOzzXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mrhGXfSAk5m+0uWDeUANnlpGEYc2Vyvi2uuR0ZK08fTmD7XZ6iGl0j7Yfjxi?=
 =?us-ascii?Q?i285l2AZzjcUujE66yMpODoDslyvR3IVpOi4hH7lX9Gio8xJClWPrRq9CjQl?=
 =?us-ascii?Q?ETRcc2JigFnlBOH3FwoIaJhFbxoTcPNacvB2HTXTE38NSrps3dkTwpqm8Anh?=
 =?us-ascii?Q?9jySUvCMqaIEeZ8jnJV4UcKuZVgohX8YwNKmSt/vmHzfBGbV6PkbXyqOjUVw?=
 =?us-ascii?Q?n8vI2b3Gd94AfNS0Y6PdWjBNXPtHvHNV9CjEmXDuawQv4nSRYjZcM+JutmQ3?=
 =?us-ascii?Q?TcMBo00jdJ+hOK9d18vh+9Ia8DBSyhNul2s3LYEHHZKmipTGMcSN63V7h5sN?=
 =?us-ascii?Q?vrbkbTD7Z3p6mKQJ6S1dG5H0SUw/oZ4Em7mImFf2R3s40j0Y2c2po6dI8ixs?=
 =?us-ascii?Q?WYSIHK9LVRO5ma1Bvw8hO+qEy6aNeiyV1eg+hV7GDDcW6aYh51E2cJPVIPiP?=
 =?us-ascii?Q?QcmdGP6qXguAhzTufqkw4gaB93Hp84NVRw4rvgTz6qHJWzb7DtvFR7rSYzVU?=
 =?us-ascii?Q?yvKcT7wJXB+AT3+5Cd0mbIPrlMkjvh2hf2jiMvoRsk6o9Mg0BSmO0RjKakyU?=
 =?us-ascii?Q?kakEi5aDVIFOcfjBZ9+no3R/KkkHZE2vZy8S873XPEEaB7CNzg2s9cwIgiNU?=
 =?us-ascii?Q?/2KkxbttAXnELVOlp6pQRO3t+rZ6/VRu8pegcPY9JvbSjHBCWcJ0YyHQnATy?=
 =?us-ascii?Q?NLHiCckDDMiuuFdXmZwvWe/VgN+oxM6BqmFNo+EJ4osPtObyqW1f9V2FfiQm?=
 =?us-ascii?Q?PfRaPOEeWrcKf/mN+aHN1MAlHFL5vmrq0bCZjHrKoVpswes5GpD1LgehHico?=
 =?us-ascii?Q?CHN2DY8sW+xzZOGOfNMYzDc9If6YtnxH9xE4uMRPOkEA9J+NtRhThuJB+lxl?=
 =?us-ascii?Q?3Dg9e0tvUrgJdcIPZru7wNF/aNl/BKPvivEjTxS0teiB/F/ciLpWGKchX3gi?=
 =?us-ascii?Q?PaADel1Y7LscvFmpBuAe120htknDN+ln/siufI9xo15oBcY6nS7FLN7K8TF9?=
 =?us-ascii?Q?UzYxGaazBbDQMKdmQhAFxsTmGOqmJftLJ5hZ5XRSoSaRBcPi1IgllaW2NE/o?=
 =?us-ascii?Q?FNJzrKh+nzw38DNiTSMtlzTHbOv9FfKqq8qKrxPMKEM+4Vw7/M8oVC4It8+U?=
 =?us-ascii?Q?1y1a1jgYQwwycVDqlPWowOYHnoIbncHIM+EBUrIPFraMKqdacZW8YTS7BviA?=
 =?us-ascii?Q?JUtFKjqJ2OQ2SjtDPJDbDjQA2ORI7nNUeEnc4jT55kFKbf9sPFm3G6PllKvb?=
 =?us-ascii?Q?A41ERRi4W24TCH21vwDuCqtznwNzs5gJoeL1kJRC6RCM7kZPFDyDCvZ/fYi+?=
 =?us-ascii?Q?vV7qiINsr4ruWu2sd0aN7c3vZJSXpuLaNXd7LADnR/tv2IOIYKTBCh29Ab4H?=
 =?us-ascii?Q?UjaCKXNcOAIEjWQ7df6FRX28gpvEpOfmSe2jtnVvepPAvx5Cq0+63PvfCYRp?=
 =?us-ascii?Q?/4sWVw4nAtQOczNJMJda6g3Shw6izAksHekb4bBs7X3+biyKCNnvLj2IuTz2?=
 =?us-ascii?Q?t6UtqEPqRl8I5Ad4WEixithnVIe7M3QQIEaYmEGukFLm/qHkJrP9tkUhHDZN?=
 =?us-ascii?Q?tVJMg7BJSDjTENPfTm+c9nCSjhFtHqA2iyFwyq+D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3442b0aa-b7ad-4906-9b57-08ddb8bb1892
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:19:46.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7oXro5pHyZQNhQ7SRBosX8zANltkc9hvQjAG79CX+fj7WzYUncTD7IEVp8o288txjCr73eGjyvdVoltnT7Zcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com


On Tue, 01 Jul 2025 07:33:31 -0700, Nathan Chancellor wrote:
> After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> range.h may not be implicitly included, resulting in a build error:
> 
>   In file included from drivers/cxl/core/features.c:8:
>   drivers/cxl/cxl.h:365:22: error: field 'hpa_range' has incomplete type
>     365 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:562:22: error: field 'hpa_range' has incomplete type
>     562 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:570:22: error: field 'hpa_range' has incomplete type
>     570 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:803:22: error: array type has incomplete element type 'struct range'
>     803 |         struct range dvsec_range[2];
>         |                      ^~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] cxl: Include range.h in cxl.h
      commit: 9f97e61bde6a91a429f48da1a461488a15b01813

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
