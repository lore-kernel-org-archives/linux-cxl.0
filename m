Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793762408;
	b=ShW3Gn91bmaaqcw/eMRi5NeptbyGB6luUkv1pqrPLOJ7yYFi1UchZxQV8ytE2RwOWH13
	 SsjnzXNnR87T3DX9nPRWUFNnIU45gALPn4eaqcn8ByVxOwTRA6fTWsBKuEjzhvpEwlxPa
	 2tnXa7EOn5aKyOAND08R2w/hL3GvNP1sdjytpxtqLsE/5/VNinAyiJ5tPCyfZB4n3aGIf
	 2ta73C1zzjndBlhSoU7+mZRPJj7B+itlxq8obmxqCJLbHTeM6YCZS5aLV574eZ7Sw08cA
	 58Onzf2Tjc3tzg/hzMhUOzxoloyrVkTd30PV2qK6iKadyK6l6liEHVLVjd4QBZFKUIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762408;
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
	bh=3UXK1iuZWZOu56AceU3Mt9dMA/Fv2RfqEvE2ztU4Zrc=;
	b=vuVI1ArWV1BymvEcn36giGHC0ZWbCmPmwQUU8MMivD04oW89lWi5+BVSp6sO8dsdph+y
	 NcguNVe8JZrA5p3lLR1RxxP6n2PZJQPKttsmElf+FXruToK6MNnhwPpgk1mHoXO5eCOSJ
	 /GYKP6aSfoJO2Ok46jdwu/tsnZ0l1EUPPWcxqNvvEBom1vKCeesXUDesfBwTrKG8leoc7
	 qI+B4zUrjXfExljw0qwAsZyXQL+V+DWXo3YMygCt0t2chAo+K5IvxxiAKFE1cVOmgp5jL
	 GZCtZ1AQbzoAgZ4HhimTWzo0gowpq4oO738tdnEPsKLhhoAU9fgPYbrHSqfAYGnvbbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXR3btgM;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2F606A31B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 03:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXR3btgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793762407; x=1825298407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GWbP2eer4ZRmicFkDGXrYUWiRGQ/mNHo+O6sE3zVHqw=;
  b=OXR3btgMOGFfSrm0cfNKK07vluzMrEQNCn5aoTrbZZPikhOoXpMrOhjJ
   MIQFP1GkR5nq95vTWCGz0KryyOWbgHz1PCUgxoWSiAuKFVG9rGvceir9s
   ZHupg6voprIP3o1i8VtVphYN6w9ma4ixuHFjn8a9ExzeEI5V7hHXe05HF
   uvr3A2vUNOuZu2pXPIL69TzzGwsHeHZyL8hTCEArSJQ8E29pUR5E0RxkO
   mXwqDj0weVh7Aixi7l0YBl7f/XRyj65prQJiziFNqxZtx4cgW13Okjfnp
   mIN3HzwmlQMtMrOe0an7sPcr10/305pjdemxL4U2AlWyd8D5jY0OmU8CG
   g==;
X-CSE-ConnectionGUID: i46RATQ2TWS0tpxFwsKDSw==
X-CSE-MsgGUID: QA9xu++gQmiyAzC6h5Wkxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2504451"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2504451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 19:20:06 -0800
X-CSE-ConnectionGUID: mWmLLG5AQ3qG9qjbkdo+kA==
X-CSE-MsgGUID: /I+Atu52Qv6INwPRRpLiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6612547"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 19:20:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 19:20:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 19:20:06 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 19:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G90L009lmLAfV99RPSKLrnPiqnt7ltJEqX5/MOiSTbz/zFTNxYp0BPERUdEQUbjPr/gMuUcopACFV1t8oFBvUhqIkY0Xz+MTlexl+mgP41Jq7iv827ePUdIxhiH0SqWpEhrhxuT611OjksaSVU7jwkwmbPW1up5BHPMSgpZaAHbgkP5KOdNk/yOfMJOGiB4lHWebZjB5NA7vjpre4Ys1rq1y0XGNj8Y+m23wor7GRKb7E/uv6vhN7hnlhRR5bBygFnoQaWFqIv46wfdKs+WR3lWVxhLZV4REqhJdKj1L74XRytFFlr97lb9qIYWGs5rxx4Q0LjlE0gKlhB5b7MP4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UXK1iuZWZOu56AceU3Mt9dMA/Fv2RfqEvE2ztU4Zrc=;
 b=CcbiEyQdHCO9UyKvSKq77ZQ2drrFLV2tEaUIQyPjVhdOj6rXuevwGVdmAPSRTszvdmgHZ7WRH2Xg0pxeQ6mBeVWdvBQeo1EFpDyV2NgsDBlOoG3FubHxGTv3lKVpJgSIxbbm92CUVjrG2XWkIlAOMYP2A7AOIJg3voBOK4SSnLSxaK7lwyVQMkzZ14J14wrAqr2LrS72WChmUX1Sw2HmZxz7BRzW8a3wjaKOSPkVP9f41CkkjWMTU6UbaESkRIiQoOvpDi0g4A5sfy50TKKmU1m5BiUDalXKiy60l/mL8Plcx3uIgQQPKnyRCJo5P+RFcN72NCpzWq14L2pg9kI/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH8PR11MB914684.namprd11.prod.outlook.com (2603:10b6:610:707::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 03:20:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 03:20:03 +0000
Date: Tue, 3 Nov 2026 19:19:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] cxl/Documentation: Describe clearing a region
 targetN position
Message-ID: <auqkX2FO-sJ3VXb1@aschofie-mobl2.lan>
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
 <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
 <c93ac992-a797-4779-b618-c2a5d4e03288@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c93ac992-a797-4779-b618-c2a5d4e03288@intel.com>
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH8PR11MB914684:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b00fc7-855a-4c11-080f-08df3a228411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|56012099006|261022105027099003|261009223027099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PbPmVZV1VmkVgyADwWqAuQYhCH4SavePf9R9ZinodDfr82Bl7rgPREiD+XQXaWO8mJ0JgRid+4sS8KN2Abz+RPB6ZKCjtHaPADPbbqralaTecmjV/Q5CUut66tiaStZoLgfHTafXXH7OiTmqimLsLpgqtvTNegWavEn0bSYxe52rigtzLl1YL907Zh/+vscZ2klleUfikJD8NiW0o92Nu0jcPD30WSOuH/Qel6bHBfEpQWcXQvATNzFcjT1dR05Z81D+KpX3OECKUaQh037O2zZHOB15ahdJXThURU+hpWI8hFK0LB7sYmnjdL8DPgLOpc3AVi062R/i45GX8xXkgBWQGuCiyaaAK2azQOGQYaXl5B8mSN+Hz5Sq4pGUtU5lcT6MnGZNcuJekT99d+0iZmeGoPNJxCYubo7jjDCQYZdogWpFUUufmGMBnJCK052Y/6QE+utF0XAmfMcl8aoZ2ZuFDFqol4WLKwjIRUwgQ8/CJDy/O99xrzwJL44QwDE2/ftsaD2K401eNDe5lR3mWk6IR3Ff1EheCBrt6zsuAdzE/SnRo6FKrysI+DPRHznJKHBUgmz+HQeDN+9Z/QX935SY+taSz+isluCAi2FZ60tDET7VZhOKOFFyDO/GNkz/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3A7A7X/8dyIX/8jfEeANMgqNH/JNWAC4ZgDNLyaMFG6saC3bbpXWeAZ57AlF?=
 =?us-ascii?Q?P7WLbQSY38s88QhLmEJ7b17AnynxLjFE/9+6r0UTAjnMJPN8gLNyHYGBRks/?=
 =?us-ascii?Q?ioNG4vn5c7o+5iUgJXiAn/FHS0cC8HiSjhCLZ2w9geIJN9G2OIZxToMOpyuN?=
 =?us-ascii?Q?eTK+2GL1d94+EfzdPtoxsAeNFuqzYVm7aEiTFfuIjIwGHzj1QlUoPy/wX0kW?=
 =?us-ascii?Q?j5tQx+sBvZJXVgX6D7XAHcTEt9IGPtRQO671TAU8WMh8rdQSKeBkZ4Qslvul?=
 =?us-ascii?Q?ia6Ctto0mvO4IWloLkvHKjrqomg0qWuvy6J04RJFocfxDFnI/EJH2EHB7Hcg?=
 =?us-ascii?Q?6HKRxCo/3qz11ulKqYXGiZ8YYMXscYDguZ9o1oJjPlvK73PaKU48Gq0hLyOW?=
 =?us-ascii?Q?c12yeMRlwVuEY+zak7leR9sz+eTjhyI+qj0pur3RbfoVFW7DvhncQr3i60Jn?=
 =?us-ascii?Q?kx+RQAhl2XKlAtBdZIQOGOVfpm+WCwkNisZv+hXhs5tTh9L5W/ReRwaz75p5?=
 =?us-ascii?Q?u7Hr0/OnyVtNueV4+eQCJMqIWasT95qH1u6u2/n3jVa2k3wCNxN/CncPk76x?=
 =?us-ascii?Q?CSfSiki+L/xDharHYwH1olUAlOGhzMgRUj7mmiwqs5xWiWTTy0K4JSuAZhh8?=
 =?us-ascii?Q?QBJMU+tWqP91bmWaN8fiXEPApJIIiFpoceZF33WdswJgHhFPMNJh4HELBKfd?=
 =?us-ascii?Q?CJBU6YwmuF3o5cNMVo3uCXHs/8Q1wEAL22QWoef+rH0I+OcNqMc9aeV+qqVE?=
 =?us-ascii?Q?ybTfQ4PxrU86VUk9XHyMyl5t4aQRcmCcxc+twc3grNHKipMU2fjkzvBM6UxU?=
 =?us-ascii?Q?igOpavSNvl8OixGlk0eM8uHc5Uh/2gvxHGgJxTHeU/yigN7ja6Iyf9CCduLC?=
 =?us-ascii?Q?9dj2r55shJFYurAF1nrX40LHCanRLZHf+p0CsaJTfJgBDeCHuLcX4wqmi69a?=
 =?us-ascii?Q?KJF/rNy/+Ig82VgyO2wezW6ItVEtktIdtEhWORQNf7zKowLZ6LRAosnfb9RY?=
 =?us-ascii?Q?GNBKuQ39gT6zPVcyGceR7ZzPAx3JirKVELzJWzWpBFC3Kl+puSfSrFbcgNGy?=
 =?us-ascii?Q?LCa9U2B98XrgRmxMUTmw3MyUKyCgaMdBGSx4OFxa+3KpVGAVxo9aVV4eCfcy?=
 =?us-ascii?Q?NusXUS3OtSp7TFkS+WLFv61ilX+Te6bJBlR1f1mXLTO8P91Vk63nSKCZsVfx?=
 =?us-ascii?Q?dsvnn2MGPrbG5yzfpqjHtmmC2/ibbOIw6KJZ3BDUkdJrj3i2uYzK6EBpUigB?=
 =?us-ascii?Q?IKH5v2iTCw1yi9jxfn/FJhAUUgL3yhwpr5zFBadhy+/X7UGbfmN4R+9UWMc/?=
 =?us-ascii?Q?B65tM7czM9FTgEz+TQNBf3LSEtg5nvvpRPwYwkUDjBPpz6PszSCd5UGstvJk?=
 =?us-ascii?Q?tFLacz8FOyc52eEIxbasNZnJYMH6g7NL3Q18Yc8f6ueNb8EPCPqe62PgduUN?=
 =?us-ascii?Q?pbWtVODi3kAV+377e/yV0QyjElQtlEevkAh0uB7nb4F7upHnwoQbEnpkhVZz?=
 =?us-ascii?Q?ljUwjTKxKPVnXXUercEZmSYa/Sw8hPMA1vaYGE8Vx93mTTpzPDKFoDDUlxMN?=
 =?us-ascii?Q?4DMGtF27kL/0/c8devNNmqpy7XFPKbTgN0dQQCki0bQzGoX5MfhMiuYUZ0pq?=
 =?us-ascii?Q?uDVX9KGYxnM2yJVi3MI3hF50dSUCYlZto4EBhscMnKTjj9g4tm5WJobrQAn3?=
 =?us-ascii?Q?XDuP9tnXADrcVoG56DeZt/X/eWgv4HOo53U82Qv/CVUR/xMGF4hDBZwG7SZf?=
 =?us-ascii?Q?MRtDlIYri9ZXus1OnJzz/yOKdjjiW3Y=3D?=
X-Exchange-RoutingPolicyChecked: KkQU0hFicr2YgzTw+dFgLyKo8JwyN+ZrDA1bQED7AivjnHXik1NFPmRPdEqCEchgoTCiOzfk83zekiTWG5/VR6w12np+y1aDw5CAbogNbOXBI6P2gz1A8ORqeM6EQ65reoIGaivnsctoEQ4Ld575jJVKH/zMb7wlG5H4VXkqbnI7nT1CSBVgLwkfESsNmSkowcTx4wt4P0588AcumQVT7Mxmh6u9Cy3Hz1YGikDFJOKPKjCEqzvMWvOfSahpeRdO/yUniTLy4h3eqmVDiwfj4cZVZnJY+Kg+Tiv1DLsk7DixwSDctj3rpjnz2rVHgohbeRUibpmZkNrG6Meo/G5oiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b00fc7-855a-4c11-080f-08df3a228411
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:20:03.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvarMyyfMChO6kRaAaL51IOGwWjN/gyVTRSsTUOOXYKBb25//d8oQS+JcId6xhBbCpbP2gXoX6JQBZFZpOYIQhybJQOukKJUcqKZE8R0XDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB914684
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 04:07:38PM -0700, Dave Jiang wrote:
> 
> 
> On 11/3/26 10:07 AM, Alison Schofield wrote:
> > The region targetN ABI documents that writing to an occupied position
> > returns EBUSY, but does not describe how to clear the position after
> > assigning the wrong endpoint decoder.
> > 
> > Document how to clear a position by writing an empty string, how clearing a
> > position decommits a committed region, and how the region can be committed
> > again after all positions are filled.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> this change for the most part is unrelated to 1/2 right?

It is independent of 1/2, but related because both are about the same
sysfs attribute.

With Patch 1 we've upheld the original ABI that writing to a position that
is already occupied returns -EBUSY. It doesn't matter if you are writing
the same decoder or a different one, if pos is occupied, you get -EBUSY!

So, with that, the user might ask, how do I make a change to a position?
This patch gives them the directions. It always worked but just was
never documented.

-- Alison

> 
> > ---
> > 
> > Changes in v4:
> > - Minor wordsmithing in commit log
> > v3: https://lore.kernel.org/linux-cxl/e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com/
> > 
> > Changes in v3:
> > - Restore the original entry text and append how to clear a position
> > v2: https://lore.kernel.org/linux-cxl/efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com/
> > 
> > Changes in v2:
> > - Say that writing the endpoint decoder already at a position succeeds
> > - Split the entry into paragraphs and drop the v1 error code reordering
> > v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 7352dbd70bc7..3629c983f05c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -568,6 +568,10 @@ Description:
> >  		not an endpoint decoder. Once all positions have been
> >  		successfully written a final validation for decode conflicts is
> >  		performed before activating the region.
> > +		To clear a position, for example to replace an endpoint
> > +		decoder, write an empty string (echo > targetX). Clearing
> > +		a position in a committed region also decommits the region.
> > +		It can be committed again after all positions are filled.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/regionZ/commit
> 
