Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65B4398E0;
	Mon, 20 Jul 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564885; cv=fail; b=C2Txmv4HngrVRGpuQG1/ouIOr8piTanvdaL5zfRqMsrMHUQEWCExYB7QFrTo8HvivVGlDrz/gja7N7P7Fk873k555nbdVrBWZxF4TYdouycqbSbxbO4J7X/RYQo/nU1ILn4889DfFGI6IWEJBgA4seoEDTf2Y6PRjo1KsYG/WFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564885; c=relaxed/simple;
	bh=cbV0zmiqCo+B7TDdYoIiHtOhERv10PVdme9+/ShmG8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HaXTZJjJqzYhN7SGkX5mbSj3oytAvfQKq1BsM2UzP2hn/iNc2B+qB/C+nI/9c+ZOPyL8kJvMNMHAYVHRuOOAOKJOV1ThKuqtK+HR4zjfD07USM+8da/A8d+7kobWFvZ+G2CPl6R70A1ll9qMHkbv+MxUWcNsQdwixDVOjBXFAGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkGctUZu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkGctUZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564880; x=1816100880;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cbV0zmiqCo+B7TDdYoIiHtOhERv10PVdme9+/ShmG8I=;
  b=TkGctUZuayKbwLHvhUcxWoutrPR43eEjPY+KEKclb0a/yfEzvbawy6xL
   PJdfp4FeVSEH0DedaDOFQS2Ipym5sHtp36JyLI1O3I9HGLswLcTFS1P3A
   YcCbPbn+0niAAHuCkfBQ0mP6aOcS6dNWjqOG8c/d0rL/l+fwx86367fE8
   vGs5MRzG8Do8ERS05ANAcf1l665c97Qx3iKI59J9mWGyRuRKicDnnHBtU
   MytC0MBveaASeEPgvgotsaK9SSxGibOfUrpA9OvDAgFX80afpf/qS6kcF
   LGbRYuQ+M9E0sC70mR2v3ivS/IPp+FHrV5heCClZoQZxxWbrq85i1s5fg
   A==;
X-CSE-ConnectionGUID: 360DIz5MSKWNxB7LSFuJWA==
X-CSE-MsgGUID: 9QSj9oW6SYGnOfXU7A6CSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87689991"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87689991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:27:53 -0700
X-CSE-ConnectionGUID: S8CE1JsGQcytmo4/UdNvvg==
X-CSE-MsgGUID: bQ2VacVQQSKSYHzbqtegXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256316614"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:27:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:27:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:27:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFpeGJ4wNT3SmfTv0rVhtR3DjkO3p6InXbjzMrunnW1rZf4ZO/MSi2cPRxeAkytBSvIdJS8/HUOXdAW+hmFythXH6ey+M5rFGFLw5Gj7rtxsdpU/yz5+Yx0Z5zsVGyKUpska4b98AKQFpCt7jaZdVLd1zY0xlLjttB89SiWu9NVA8GIavoxkRySQ0yZ6mbEQW4sDzthtxX5gtfKO5RwEeJhDwC2UiLozTWgSbmQBZk8HsvS4623dUYyJUZDF6VBuNtXJ25AkoDmwWtUUfXNnqOjQJx+tylNC2pWYDEJLKF7wB6F9Y4RVYVwvGMQaQ0Of9dug+mq9e4NV/FSta7fDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSHhiBakIORElF30S5KpyOZM7EFp/P2Co3bcIJpHlog=;
 b=GjxZ8aYpD0RUYUyt0zMAvF3WfrX8+NeWXvaF6fqwkiehQZLIMra7bG6fNWKvhu2R8m/h+lNQCU3x+lnzxc+eRAE4O3SVhf1sm1UHu0e18Qgs0jMDM6olpQNG2TQfehusziar2F1CkCmSgEfFh0YU2VqoLNYUG+tog9b/el5qlL7Lp4mFb43rhjYuPl4COd8h0HLCxbJ7G68WMx4mU4x5eHZL+A/n4gb6JCAwNUUINbELuV+BSZm6lrl07vmMXlD02RB3NTPLZQsqzrS8TnPuSj4wbsWM7p0ypHXfITJPpUhJXZjT4zFyLD8n7yJuZy+1BF+5kxLGkr7pu2RJK/57mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:27:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:27:43 +0000
Date: Mon, 20 Jul 2026 09:27:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER
 guard typo
Message-ID: <al5Me1ODagCCwMWX@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-8-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-8-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 5478890c-4e26-46c7-c30d-08dee67bd2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: UHpFhIWfrdygHd3IEVdInoCvwc3hI18TDRpC4Ovdfd6potC9IRLsd1s3zDxquZfOqxX9rEyMEA89JuICld1epBMzXt4kAKa4P40dwEJfpO0oYHSxUpNDygVaX8RclBgKp//9D/1k3KpXYd3oLGINzx+FurNviaobypCap5ZBNJ6R1+cOlLXruP4bIfPuRUanSXnFwCy7gaIiMWR8aDa/E7RARv/HAclvTAbCeUU+W4r5vS3EmQ8ug6JIcD85BXvxoNzuLtVAFQJlcBOyfk37aVZeHi4eNXCGYF2DxWA0HIZGm5avT6Q3nqvliIMnoY2KDB99YtqOmUFEqc0c5aJ8LQAT++170T4XN7pY9YL837YSdvtr9UqwacFghNO1o+xgPG5K0+W9XNfDk73jnoEeYWYEjsebkplKRvse29XufxfHSHNE7V0nNI8R2lsacWt9+jY5yZMUmbMrHXVViwtzM6hVihQU5XlyJ1aoEmfbsnump5MsTHfeCyLSAtKHf2LwDr1nMOejttQpFpgPS900U0TUu76Pq/7E+xusN2Ph4lyBMhwrfDpD6jHiTFX87vjZB3uVzrH2/zt49Yyntm9jC+JXpybi/idI+L7uXqQGCbviUq0b/PlvF+Kw2iX7He4XkLUPsIgXyUNqTT38uTtAl/vyC0XVeyjzxn+ajtlXq74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhemOVOeJInTtkuAtGBVGMIIxxHuaRqlVqEqX7ReN4pOJ+RvLqWiLU1I0GdT?=
 =?us-ascii?Q?+8YpPmoi8kD3HNUe39gDFujj5GyjOXomRPowWifSuqDyKclZY4mwaxI4niXC?=
 =?us-ascii?Q?t4t+iIFo7sns1h1ppRd3To4hlvSeRS3B2gqFWVfd7dLMaUkiQYYA1JmwDn/c?=
 =?us-ascii?Q?TuOKb6Ajg2qzymWB5Opo991CkLiwp/4ImNr2lUWgGhMvER5TT9g2NT9WXYOk?=
 =?us-ascii?Q?UpVhvmhi1Q7FTit2H5ecSoLGSavS0f8roHXlBrpG+11FWj3KRKxkz9/y5Q2r?=
 =?us-ascii?Q?QMjkp+k5xFS+f2HT0kvzNVfIG+zil8yBoyj4lGj12bB9SULOmAl62r7oC0IL?=
 =?us-ascii?Q?9g65nj0XaJjPA/CWP2n7hosMrXrCJaMI8/+Joo2PlWPLquSBDZhUlxmIZMPX?=
 =?us-ascii?Q?57wufrSxndn7rVJPVVi2iiii3AVYYNCXLmFXX5K9Bd0FGBBL/VnBNSZy+u0B?=
 =?us-ascii?Q?vjyYWI2VO8fTqNZl/EyVdEOeoj7T6XOZLuRNZRk4I7JJGQ1Q/xD1JnQygoy4?=
 =?us-ascii?Q?50CFOX1S5kiRVLVt/G3Cku/9yLnL5oQGNK0J57Q8Muijs73uE8jjnRujES8J?=
 =?us-ascii?Q?W0jIpSlk/SuG+rKG2NlT9vFl/YJjWxegp4r4uMQWR5mt9kyhseTc8Ut+h2Au?=
 =?us-ascii?Q?uYV5nkNriVSXoAUzRErQ+9MhtuaBanW/TJqmtvg+9GESMXL1vos4Hu/1yWMP?=
 =?us-ascii?Q?Xj8ovc0p+ZpWMSlcgsQDwZ/GUyZfG0vXJjjHnLztvfZWBESgjr28S9rmdicP?=
 =?us-ascii?Q?rrpt4sWtON+xKGyzbLHTSi61WnlBnsFq2x6hlERcBKd26OZZoGPZqiTF9Iq+?=
 =?us-ascii?Q?nrfFIx9qreC6w6pJ85ZmOC8jCD4QVmRx03ui+A8vpgnLx4qqhQo/FORwtxz9?=
 =?us-ascii?Q?QVXk8q9vUbHWF4R4dsJw4HLu6XW1ssa+MYaULC74VuTnuQyf+MhQtZoVdqID?=
 =?us-ascii?Q?ZTldxOY2eCBdzNUcMEYWMLPep7kp1GzGjnWO7lGl0BexnMiqvnZcz5LYb6Xu?=
 =?us-ascii?Q?9ppqtSF1UNuv0CjOzV/Da5Uyj/NfWKqLlcBvxiTXPpqRi0cjzewrKQQENxk5?=
 =?us-ascii?Q?tFtug1W4xoQVa8yCQsNAbX8tScUaFbe39GUm8q7zFm4XU27qcRuU9vr7bvk3?=
 =?us-ascii?Q?9CGNTODOuUZ5pNciuHvlZHMy1ysJQnN7pQ4HKWQqZ/JDTSxHqQCfUAZeRGq9?=
 =?us-ascii?Q?CY7cAdjaxqDM06RGU63Do9VLU/QJXb7SbiOp3I8/F+4a1ZtRLbp0qMvire8u?=
 =?us-ascii?Q?594REL175M9sXWQjZz2F5atCDe5O+JjhEVs8W76/kKZIVhDA5tbUJ5/YtR++?=
 =?us-ascii?Q?BjeeImKfRIX4oLNbZ4XKz1DoM2abnCLQ8LQIbx3zVVgHimIg34CGUTINXKSO?=
 =?us-ascii?Q?D6c5RNLKRrUmdsvbReSn0E9DzJECk3EOf4VlqnuK+Su/a2t/ZEgK30Rz3yod?=
 =?us-ascii?Q?bXScnl73ay2TR/0Xp0rhN3QIc/d6cK09H4TAnJONIXqvLUZXO12rozc/xpSq?=
 =?us-ascii?Q?7vwEaBo5CT9aRKJPa/iQDqOBt1U8ARWrRhOhPM4XQFvqoQYKZxbzx/N1cZyB?=
 =?us-ascii?Q?UEIvzEYDYgJV3PaocYWnKn2CIuSa0F7OuS4t73y6lzsIcS5x5UVZTtGjHm7z?=
 =?us-ascii?Q?6Ybayuv0lwMA5WM8dS9rgPDKgPKkppb+27LUdwLymXgnuCHlSEkOd/IzVxzN?=
 =?us-ascii?Q?9iZ3QX9mMOl8oOZ57c/st4ZddittIHfeJL7rPLMxDbgTqKhXKLzSGmTZpy4z?=
 =?us-ascii?Q?K2lNVhOwfHJs8edwgNnMurpkv76fJsM=3D?=
X-Exchange-RoutingPolicyChecked: Dn8C6z5m9oBmI3IDjDEcqTJrNvqJeCZ1tg+w5DDd34IY4h+CQW8/nKG+hPGp1S7rh8K+cvjXFon93i/cgePLVuSbRAnec5B5phz9y46datEsD6mfxRHitiUEs55mT/Nl5NiiZZwKYKPwxCH18+piNIDm5bu71MzaHDnjksR4tCFWWUzSd0gSnGfmncbhGYpL4/5NCXbjk9ZpgY/If7hBKFN/QRHo5Kkl9vUb5ikM1oXmlLmsqakMNxl/g9NFzuai0s70awt4TvA8Lr64vUf9cmKOuCYXFPOu5r+V/PTvjuGBJEiPL8UzdgCoRBPBwbFnd1/Xh3I19+Oal1mJ5N7mGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5478890c-4e26-46c7-c30d-08dee67bd2f4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:27:42.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE1a9gdb4j4LnLlxvvgFqSQ2D3C5UjAoXcAVM2kd344PmA2GpVDnXvBP8gZs8W3OeoikIiLRDOjZKq1rgukCK+Wo7PzDb6sEzAXdfBjqRS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:44AM -0700, Dave Jiang wrote:
> sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
> CXL protocol error handling entirely.
> 
> The guard reads "#ifdef ACPI_APEI_PCIEAER" instead of
> "#ifdef CONFIG_ACPI_APEI_PCIEAER", so the wrapped code is always compiled
> out. Use the correct CONFIG_ prefixed symbol.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
