Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C964A937
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974082; cv=fail; b=IJTzlxjVce5e0qBFPRpm/sEymd/+GalcX1QyjM7L6Z9yzVQRFKkCbOxCL5AuGCtUpASBWEECriQN7iLzxx1RtJ5njzVHK29HU4Kc3A4c8JhczLdvqyYvxKqz7ccZ8VrCfIYgc9IJGPBZ9bsR22KVMjM428klw0yyuMuZuQlU35Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974082; c=relaxed/simple;
	bh=7eNPR+P3oiDqgEnr6aNa5IJVgwzppAxRSQc3eSRq870=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWYu4yA0tyPcxrb/a4Gl7BXF+k+//Go33QxWA957On4xU/YreBKF6al8buZa410scDXOWWjWHXLCxwh/bFI6B8DzPuiqJ1xb8down1QsVRTumXnIEVsv9EcOtkw0AjZeg5V80RV+x94ZczK7VRwoZn4cs7i8YegmdYcciUHACAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvPfHWl3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvPfHWl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738974080; x=1770510080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7eNPR+P3oiDqgEnr6aNa5IJVgwzppAxRSQc3eSRq870=;
  b=GvPfHWl3AI5QV47spkKxACTaYoVLSaeznZkXnL1AMduoP128R4ZKLKCI
   hNaCJLOcZKJlxaMl6YdQXNNkKu2UTlri3+LIu4roi4llO78rlSXLKhlnc
   UGVUwEiUBjm01bracX9s8lcFsLbJXwWoZ/uLyyMAb7exDUzXB71jrlXFM
   CNWLE53+VtAgQCXzacsT765PbLIYA/E+/mqsC2sFarRxNhL+ynUnbZO6w
   PUoXpMorwb2ZG+Bcqz+SUGZ2VCXZJ9FlUBQlgslRUGbZ5IOt35TJPA57/
   nD/1E2AmP+yXnEqdBfR2JG/G7nogsC0D8UTZcZQhal+dREkEV503RZgT/
   Q==;
X-CSE-ConnectionGUID: 7CPoag+fR3+lUixnn7hJ6A==
X-CSE-MsgGUID: uXrEuvl+QcCVkBGaRhwV/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51058073"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51058073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:21:20 -0800
X-CSE-ConnectionGUID: /t/FTwxJSvWysttuVH3k3g==
X-CSE-MsgGUID: 86nGxU0UQoKYqq6j2wI/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111875931"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 16:21:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 16:21:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 16:21:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 16:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owhS7Xr6q0p9WsxgT+KB91nIwMUG2RvMRHoMvregQoPaMVL96S4tamcyyDYQUUFxs1PL+QNg+CJeB6Y1M+62R3By9750Ec+SOJcOYs/lr634r61gQgxtYj3L6lQ5t8HWJYPJFMfci8RRWpFw7DYkbPItFKrzgWhMJukxWo2XWnxHUTkMXIm9n74kfJGafjfqDFaAPD1QyuA+9Klkw4yKr3U9si6z7S4Fsb86nZZt81DMY3rTxrkYjjXRIeEHpc37mxv7Ru+IJUaCdl1RKJwUyva5Cccz10k6jYC70ec9OyQnTEF3iZ+l9iM7jp3Qe0AbD37VZKGEyCe3Z083460GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viKsESUBSZZmAUiEp8UQW+hKIrbM8VutNG9/zHDzqqA=;
 b=C66ZHhCpO3v/WopEU90Q+rpzNo297+KaI5MGNIVRRvRikPR+MAQaw9qvc++KBOiVS89GnpNdF0z+Cvl4tNFU1BH8XCK5aJcD2RIRBGiWqC3IIfQRF7jCGGxIROJBMM+F67tW645+VWqv3THojYgIOG8Kf+eh/JT9GDfsHoBdE1B2sX9wBEewzW72pRniznWgBP0Wna2Has6g0Ho9z7R/cTVCcIsA2OK5wb7a0RnKY5bCRWeaAG5AMlJ0LhuaKO6zSSg7Adct5Pl/heS2ZZFQnY7K77RZeCdUYkTeGv3EtIGa6Gzf/TVg9Nf1vHgjU8HtK4mb21uOylS7QfA2UQGBZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:21:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 00:21:09 +0000
Date: Fri, 7 Feb 2025 16:21:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 05/15] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <67a6a37272fd0_2d1e294c1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-6-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb28947-40fe-469e-ed16-08dd47d67c3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95TYRyx6df4KsBQo9tiPVL4IgckomvsmAU71lOWJY9JyHX3Hud4e2CVQhcRa?=
 =?us-ascii?Q?dDgqGuJGVLN/Pm2ORUotc99sbSyGxIYEX7VVwdgnSkJRUdnV0/AxAAKX6Zbc?=
 =?us-ascii?Q?3TO7OFQcCwZW2a+J3bN+8r/CQNOxKeAtW1FryQUH6zmJIQRTvA0za7Ft4sFs?=
 =?us-ascii?Q?6UcfiNdWkn7G+SLIwwj8waHB2kJvlkrWU86PNfVtyvXnMblwuiGl1vMSzSmk?=
 =?us-ascii?Q?erpdLSe80wcWVFE3WzAamL3ojcQ/r1W9pb6uanPDGXwR5dgsjDsuWJqqTNw9?=
 =?us-ascii?Q?/xMLKXVixlXgLUlk2HM28AY//3rRUPbcMTU2xynNc5S+dA7Q/TVvjzvefQjs?=
 =?us-ascii?Q?TWD7ZHZja2srCn4gZB2so17YeE3PUNATB5SyT+hccfCZvflRdcqznxdo17fP?=
 =?us-ascii?Q?twFIMmkoUjWo5eW76+wQtAqSm6kfBIoLF6+0zH+I9QmulM70xgiwRhyOFw48?=
 =?us-ascii?Q?sqA7HJychl8jqWsNvX2mB8k6QrhPbnXBAIo8G1dVN1rdZIyAEqkB30i4UmXz?=
 =?us-ascii?Q?guVXoZIm461lWPeuzdeVvafCvjEOUEqZcjHlkucQ3bTu0YJEdChvu+KuEs5B?=
 =?us-ascii?Q?ZguA8WNxqYmKCPOAEzl3DTo1CX1pSAuAXfIiL+kgWiSHalYE2AeW54NCQBMv?=
 =?us-ascii?Q?6KmKJKHlpC4TO7xpd4HGQnfgv7SvHbCooBYy8dZrb9nyCV9OXkIulIcnG4Wj?=
 =?us-ascii?Q?tcCs/u23BOBczboNzDDcDruMeH6JgoBkVIReM/qBO3/4MdIk58L4KY1kfNBB?=
 =?us-ascii?Q?A2LA98wF7bh+gY/gBEeRHcP1ogsg8AKMDoVv3fS8CjAitXtkfj7DZhLtnq2r?=
 =?us-ascii?Q?XGgp/zlFKsG5l8pPT6YD5NkG3zAl8Zmgq5DwqIzuWjF517V8pXKcSKh2zZHF?=
 =?us-ascii?Q?H5FKf/e7iaHI8QYfODJXBMgeFwFxFKoeicLdAwOPYbHZKLtH1db6w6heM2sL?=
 =?us-ascii?Q?rZ8O3NYnQ/WmZhqJeKOXWQTHcpuGIO8MQZ9bALbQhCEWzLZoK93vEL5ULi7C?=
 =?us-ascii?Q?T7Ig7n8HtpsmBJ4mjdON17w5slGhk/qoaQerNjeZtI9rwvtC9Sub/6euB3kn?=
 =?us-ascii?Q?Nl3/ct/+B2NSPK9ewKjTJOpSgSiziW9bsYc7isxT013tzqbxwg5lDv5fKoQ/?=
 =?us-ascii?Q?zZPuMB187HrcCbUGN0ZI9fKTgcOpnxIVPfZ8+loRj+Xr/bxyiQ6lsk//efFa?=
 =?us-ascii?Q?i4PiOgF+/fT49lsauB80xui3Nem5VsRC82UYWA/j8Z9L1n1gvw7VbEAGQOE7?=
 =?us-ascii?Q?F57/oSVp1V9mtq9AN7OyZPLfH35jqJ3SoTgjUoKneSOBxBQWszF427jV0K6x?=
 =?us-ascii?Q?k+44ayE0K6+zpgQG+Jv0ZTPH+ZLSHItFTKYLi7F3noS3YkvV1aw5hbTSrJC1?=
 =?us-ascii?Q?Ou0ZIIPBt6tHv05hgR2frhGKnMW/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fwu7b2B+xGDZeOWHxiJzQ7OoO1NlLEt0JLi9UNiq7QsxGwxkKe3/Sz70hrFZ?=
 =?us-ascii?Q?rM4ZfWB2dcCZMFq0e0oSPQAgmdBlsYrGabbTtyC0t7bwCoQcuKI8YI924+pa?=
 =?us-ascii?Q?1aAfkIDrK5VlOK1V4UK+fPnBYl2rBPyPtS20VB4fRU2YLcnV4yZ2LZZFqbFh?=
 =?us-ascii?Q?2RnKtpKyy9aYgHfp2ciSZvupJetDa7ErzNjwNagI9OnaI3tJfcRXJkv2ijSy?=
 =?us-ascii?Q?XZ4PTb737mYhuexMmnQxD36K4hUGp1GC8pN/SiCCEf8geWLsjR3quv4+9u7t?=
 =?us-ascii?Q?ZjHYizxmRoaG4ZtFZOdAMuiPsm63l5Y11amxhYZPftwnTate6bi/Yq9BbBW1?=
 =?us-ascii?Q?BXPlBrav1hUGLa4mqc/zmz58e4G57RlarGIaxt2yt9WX3TF7EcPfrW+wwZcM?=
 =?us-ascii?Q?Wwig0uQxaGopiyVPd62W7N3084kc9UvyBLdJoeKOAwLWv7gnnoWtda3SoLlk?=
 =?us-ascii?Q?j4tzis0E/Fb+cbBiQuVEErvxYh+4A5ZI/isTXOSEiNJIVROsEyvcuxjSwBcC?=
 =?us-ascii?Q?YUYDUcU3x48LQ9EySpOkaSV9SK85F7qbtpb4zYZAKZmwcY5uHRw9XeBEIoZJ?=
 =?us-ascii?Q?bzlISbPCjDU8VFM4dCPmIWTJV5upgTmDuPJhl2jUZkkg45MQpfga3Z4yHy9z?=
 =?us-ascii?Q?0g3INPeCx9XwgNJae966oV9Z5J+/zGwQnJXc04qDV+u7hZy0h7IhXZ2asAbu?=
 =?us-ascii?Q?L99/cn1BhwUiNeW+6uPS6MsSa+M6p4UiGjSUhJ1Co0AO40M0uUk/BGR6B83z?=
 =?us-ascii?Q?EiQ5Q0DF/sJ8xgzaYJEtp6PV0AYub0WV8pwheN32AFpY9wd4fNStmkVrPvEk?=
 =?us-ascii?Q?uoABOzULE6/ZtfZn+N4rnxm4Oax7tjxUAGdc/XrcpeZSySUUvx1Avo9YnEvf?=
 =?us-ascii?Q?kXfcNa90HSu87DsEMTiTpPiJc70pM2tIqGIZJ71zAv9p5Go753rl1yDoXe8T?=
 =?us-ascii?Q?V6WSQ0x5tL1+RTaKcVczXvdV8KCZQoUpiTdMaTKem++GN7YVc00gq7hkJIz6?=
 =?us-ascii?Q?uVvDVZgnTPQCc4E8v+V+QMfiiqQs2AR6ZvfvPQf+8FlNGs/z2nsXwgjwc02l?=
 =?us-ascii?Q?1fQKNxnzxCnbgA/SM1P3cpvIbG+B52Nda5MAyXisXGeKgh39wj+hI0r1m3tq?=
 =?us-ascii?Q?dPdmsVMFylYCKpAPD+Hb9PLlsAlkwUqfimA+bywk9wpBewyvrSVoBQiPaLFu?=
 =?us-ascii?Q?FOmHMR8FvvPXqaOEbUDQf0Zx1J5h+48oIrujpK77u8/rI0gST2Tl1bAqWl7D?=
 =?us-ascii?Q?JDH+Wc3632qAfgKc2KP8V0xALTlAgmhdZr7Zl2vrAEmhNQfOiLHqTqa8RqpW?=
 =?us-ascii?Q?T19/IB7ta8hTDUMgMEKoMtnkMzlImlrJOwCoMr6bTjDY4Kmz/+P0uZnJqIAz?=
 =?us-ascii?Q?vQLc8xm7DHkMgrqAQu7jz5o3HsVr2CCsn/xyAI/4Q8b/zUXjltx4pAJpmJuZ?=
 =?us-ascii?Q?YKksk91LG+0QQ7lx08uEG23JIq5cgtvg1ycKYEg6IjlBmq1teNtmCSf0a34I?=
 =?us-ascii?Q?reO2s9gVMf00nEYqhVFq1zWn6G45ufiHEJ1JSuhJyW7y49nFipYBfvg35m+s?=
 =?us-ascii?Q?+eBI7MtJsHibzlQ9lLNsvOrY5q3amvB7RP1ebcLBt65cnmy4efCA5dXtfz6q?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb28947-40fe-469e-ed16-08dd47d67c3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:21:09.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+UUl+USxzn+19I2iJgN+ccTUU78PJ63iMjPBnGDhzMKftvHftxqEUVc1ZHrmzyTPZNLxqw98Hagp3Mc42GK0RQySA3IRHr7xxaoCYDrSDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec r3.2 section 8.2.9.6.3 describes Set Feature command.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 81 +++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h      | 42 +++++++++++++++++++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 262e4b1cb7fc..d337224158fa 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -227,3 +227,84 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	return data_rcvd_size;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
> +
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> +		    const uuid_t *feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u32 feat_flag, u16 offset, u16 *return_code)
> +{
> +	struct cxl_memdev_set_feat_pi {
> +		struct cxl_mbox_set_feat_hdr hdr;
> +		u8 feat_data[];
> +	}  __packed;
> +	size_t data_in_size, data_sent_size = 0;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +	int rc = 0;
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
> +			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);

Missing NULL check on @pi?

[..]
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, "CXL");

Same, "no need to export" comment as Get Feature.

Minor things to fixup, so feel free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
