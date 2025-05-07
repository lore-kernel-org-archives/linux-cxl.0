Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD7221277;
	Wed,  7 May 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602616; cv=fail; b=PD35a8/cr/TTgxwa5mdugfFrmxteIr/EoFqdd/8w/1Idf8CdaY3wXHpDxQjyLG8QUjCFYoAxqa+GkzlOyVySqZCjV5/Kw6LiT1pfVVooC87Dj+kuuX4oMXs8vuj0o39fNWMe1//MAAPEAG9yXaME5Lho8w6WvHr6uqkLfExkznw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602616; c=relaxed/simple;
	bh=/6dlKX676CZIrT29LWTzVfWDIyfAhWgkM/nPEgBApVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZecqtVZyWG8fd0lA0+CI1qSfa2Ql6rwtFRnIMwYcpBN/ildi4E2uUIOeWz9u+uj2tkFPPovn264ISZIZGoJO6cvARzKAdR0XhrFT6lWrv3T5aIcQ8iLH354x+cPbLwKNmrH1elSuW96GcHbRT3LskJ5QhHzKWljiaP88wr7KKDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4Gicv54; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4Gicv54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602615; x=1778138615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/6dlKX676CZIrT29LWTzVfWDIyfAhWgkM/nPEgBApVY=;
  b=X4Gicv54rFXnYbwUa36QanHZW+dehkCtO5eeTAUlXiZKepFesg8nY+RO
   fyeNuk4q9tieibD2l+K8aY1Pc8xcmP5tbY+pd6sekl/I/iP/5qWGX5njD
   3+LZZI7A+hJTtzKs3vKTkDfni4ni94P6AcpKO1343xO+3PXUQFUEsSmI0
   vqkRopkefe9Vc6OpR4za0/G1+sXp6ONV0LW7oul2vdhoSvXUdd9j7GUnd
   T0lO/NpkN/OyWPukpB9ws3iuLKSnnrg6YxVoiLFpJN7jrPLKzmP+fHDT5
   cLJdEyGwxDAX5sKRJh00Z3xqpkqe4620SdacSLeRtmyhOrHJ1TWKe0AUm
   g==;
X-CSE-ConnectionGUID: glQSb0sxTqG1W5BFivomRA==
X-CSE-MsgGUID: Mdc6t8z7TiG/p9OVUblKHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47564262"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47564262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
X-CSE-ConnectionGUID: KvRAV5ZTQJ6HEWXWUfLvnw==
X-CSE-MsgGUID: /MOx9NVdTxSnPrpUrq1zQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140985001"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ7QzydT4ZLteAvDJZ1T7AUriUCdYJQIzDZkc874uuXGgctw3sohia6fBPlF3Tfr0tfzxMQFP7ZScRCqq8mvf6E+hAiCWVf+gJIC71ltcaYy32DRYsn5CPUP0Q6IyUhdDhf6Inl5Awo9lTavNGE6vLrU9w5DCxBadtLctjTSVIDdlEZdCBn0/OBiiLWc+dyvf+iEIQwBIwtVa596bovKY0aLCM/Uk1ViAUIof3UpOuJL2XkiHr+bhTR9X3zz7oJ1brGJYyrpcMivCtnFM15oYD+ZJvw0FAvXq0i5uv+degDoUYkldugLt5XkUeA2/NkJcN98Ei8Hi65xbc6nXMe/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bVI0CFZggPt2q4AOFQx3tYM+rpQJ3Gl5wynAuX0GeM=;
 b=FarWJKcLNPmYQrs3FdzzUt9YwOUUjS4LdVu502T3cqHmzSd4XcYS8iyq/F+qkhIcPIVQSDf9AE13Df3d7ENfet8H69bhBRegg6gcM5DoL1xJ8hMBUNtWlcfLVDyYMl+m7Ma5dGvXaXYiVhXfAKia99jkr3GwSlQaeQIt/aNoZmaIrgz6YDEQCx9/V9sVCiwlL0xBktK5Iy7XMZ+1TENAHR9hA5T4jDpqJrzPn/1Q4via+SuqUXoqk7Q5QakNqP1LAShRh6HnwMeoN9/a3k7zSBrfjf3K197gCwbStsk+BXgqqX31Cmt6yNrE3eRvoEXKoIhhpzVtZo8Ot4G/R60kfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:54 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 6/7] cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate multiple paths
Date: Wed, 7 May 2025 00:21:44 -0700
Message-ID: <20250507072145.3614298-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7fd0be-6378-48ed-4bbb-08dd8d37d7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+WAwEDAcwImbEwYx7Nqc6fCtHYG6rzZkl/QGMwbAnUsWwe2F2ZLKYbQArhT?=
 =?us-ascii?Q?nat0F8MhAf7/89oE2B/4IA3iGwrcehjNudBJUM2CUcNLqkr37y194uP5LW3v?=
 =?us-ascii?Q?lk0KtXXe4vMcH/ioQ2M9F3M7Dz4ADzyfh3hw/LpigV+arrCXfqIh9xiuP5N2?=
 =?us-ascii?Q?zeiQlinn1O6j4svCiaBRWLYzbB5+x/65QCZczuGPl8eFloVtwNWIqz6GdMbl?=
 =?us-ascii?Q?SpogELstjR2FAbKe8bwiNUmzm9Dpa0rCaiIMj05Jx1ot/cJggv3DzSbxUgfz?=
 =?us-ascii?Q?wdNKMTDTrs7JQ0BKEemtGhJPYnymSYOKy8EVEGltZ0nDVhHS3yn6/Cu1H0sK?=
 =?us-ascii?Q?Zz6kmwgql6w4ShqessecCqyAzgi+26PhhU4qWphdhUTnQw7TXino9LCo4YYF?=
 =?us-ascii?Q?5sx7TvjmKPc78dNx1vwh/zovGzNWJtswYaD6HfxVXT2TC3g6xqBZzhDfBKkt?=
 =?us-ascii?Q?sNziLRnAYC4hfLxGay9tA6F+hhMAh0X/BO4befw32U90EJi9yQKtG0dyHeD1?=
 =?us-ascii?Q?ONFJa6+d64MMgvC59dmiNqXEOeMqcnsLojfNlWUf2aGn1H+mq/a49GU/rwnu?=
 =?us-ascii?Q?oI1jAOs8wwcKv3RNE8Ry5zkm14IPU7F0UzhXx7EYY3A+5TaOMwoTsHWfjEHG?=
 =?us-ascii?Q?B3jjhImlixsNw0ssYpSMyYJNO1ADIqUB5JriMaBSCFJzQPMtffV8fTf3qEaz?=
 =?us-ascii?Q?QQtp6paQfJ9/kseQ/gQNVuXYUvYGYAI2LpemgSy4Ncjw0pVRIuZrgG1RhyTr?=
 =?us-ascii?Q?FxtH3a3E5rSQzvl+qY8lVtdxA01tYHQwF107TVWENYDQNM5o4o1QBKVk+KD5?=
 =?us-ascii?Q?d/MvizpfheINxtloBvyJRXFyOhez5yICoG3jug4ZhH39IGLw31vP/v0JDxeU?=
 =?us-ascii?Q?bJNtzCP5mubOzZrxbgM1jfv3ogR9QPlC6VvRyHYYNd8y+/EVk8vG/YvhGLCM?=
 =?us-ascii?Q?kYq8jZLsRllw2hceRYtfBV3NgWrqcWUP/tnrWaX7H/01FP+EXueV0kaFJ/OV?=
 =?us-ascii?Q?ny4AFcJKrn1bZVhObsoi1fj+5iqtBWswfPKhI2qPjzERmsFSstLuGasPG1QG?=
 =?us-ascii?Q?yRIRomuQ916uxNhshh5azYb2IzSjZJiHp0VRlcAvvtgUTfElgknpUXlcO/XN?=
 =?us-ascii?Q?UfMgnGErdlXf//gazvvvuBXYdWBomzlZtjzqTitVRegJ8Aj1G+biKPYES3DP?=
 =?us-ascii?Q?IkgT8WZQ4VMrL/Xzhmy37HFBdmdbn+4an5kjE9sQEKWyqD33DLaJouEFoc4H?=
 =?us-ascii?Q?anbwA5sh8KzLyYz5VGtZULtU9HYrFhd7x2gTCndQcCGvZNzTNGbmWnt6Bc+h?=
 =?us-ascii?Q?WyLcGRUxrsBmjffrWDjBGZjCR7qKv92BwOHJ9V7kLp0CBUvvxhhq3wobYt5X?=
 =?us-ascii?Q?zgorIw5GTkN07ZmhKuF6vA5qTmo3D+7S2NtuPfzq/khZ6OXEfs5Ee68/fgeN?=
 =?us-ascii?Q?MQB6zQoLyTY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8/Yqp1N/GtjO29HsoQDZv8RcStj6XlO99z1V2QmlMYewgdlQOPxysQmYgLT?=
 =?us-ascii?Q?wDm45crpDSSXwUiZu4C0I7sbyoxLvnNtnHaZ557tMkid3MFL7wcAxs4t+sLK?=
 =?us-ascii?Q?72/ydfqnzSrMZ9lJ/XXSde0wMpE6niU8eEnQeNXBJikH/GBFjKCQqIlUwgTb?=
 =?us-ascii?Q?aFIWhrC2AUOOE4eqX/AGa+0cQIN34SY8hgSq0tf176nRGPgW/7oJUFRaZebN?=
 =?us-ascii?Q?KYmCFzldCOes+00wmCoz+x9C+Ypth+rKPG05tX+ahDnwe9aqxhfHX7svT4Lq?=
 =?us-ascii?Q?VDwGgmFd/94xUruY04g1j/yFTFYknOxPGlGTOJU+6o3ujZW5F9C7T/ROukEK?=
 =?us-ascii?Q?nQaB5PLjMY2u/qMbOfh45p2CbAWjaA1ekG5yBTP7t1e5DJpYoewcOQTs/ksG?=
 =?us-ascii?Q?SFgMT7TaaCz92GBl6yjeK8zBsZF4qtbj3Uq9OEAdYZzB35awQaDOZXyeQAiC?=
 =?us-ascii?Q?sdbLkuqmzF+xM0WRK+uJ6iGG6z0LdG7FuacvvaAxlc2HnD8W1db1CyCjroDL?=
 =?us-ascii?Q?m85nDuyOS4QEiCtmSUqeAzHXmnfBZEWYEMkSeO1oJ4NBziS2+MWekcAumwqo?=
 =?us-ascii?Q?DFRCGG7dsrpC+f7kAa21wzEbYLmCtbBn5rF1dHH92P8KQM+rRXO127ewq9cQ?=
 =?us-ascii?Q?t20Cs9K+tzW/gTjTHj+3qgXmil8Ln1E+ApPbP3o7+rLgC665ja1Tqrq7MVOd?=
 =?us-ascii?Q?8DMjIxALJLIh426hrkOPJEp+tiULM4reLzoVF4CsBr3hMloTBl7YRwSi+5RV?=
 =?us-ascii?Q?jQH+UQzYtOx6NwqrPlOl7iaAyxec2O8IXlKYMvEW18fisgktP+Xc7WpNrgJY?=
 =?us-ascii?Q?C2W/bNOlnhtSJADmac8J4hGQ+Z/j1Js3DigoYIe1X9MbMt2QTveTOKSUqFsv?=
 =?us-ascii?Q?RqVDotlvCuBcR1Cs2nPmzArh17RZ9ljekPqNs3OTBb7Dd7C2yy9BCqlthqrK?=
 =?us-ascii?Q?3jKdUbgOx6gmYXl2h8dtKfFMAWWz69n5DmAUeOXmOyHcOq8WiwcPcNH+9qkF?=
 =?us-ascii?Q?/AHoSSPYPhBY9PDiJfhO087OlcBSFZfjbqnOe0fAqMQS55r7OnMVD8b7AW/6?=
 =?us-ascii?Q?rbYcMcS0oaJbrSyWFX6XvZl/cG5NSMjjPGqe6Uo1By0P6QL+GRXGKzBMb6Ka?=
 =?us-ascii?Q?Hff6pawuQbPLhlLzNIu+yPupTAJtlGeK3afkPIt9bYM3VgXaIAewhirwzWSz?=
 =?us-ascii?Q?+E9D96E5oe8fFil8QymFK4QWrgpSy+qavO52xgQXhbh93sZ1lrZkZorH5mpn?=
 =?us-ascii?Q?JCwHJCk4HM9PgTT+gIrFFaXH6/2SCxa+fVIJyY4QHZI90ggwzJJvfehR5rdI?=
 =?us-ascii?Q?m74rAK3bpAAbeaIlF4A9rfSSFxAfjxblGYbbICqSMLBZHNW4fKR9dbwlGsfZ?=
 =?us-ascii?Q?gTgoYujm4c/WEKdAEFVeVsZn/4/mL+3W4EPIhveWkCRld9TvUSeEUqLvKV6Z?=
 =?us-ascii?Q?pacwMTmR7P7FmkjGbfqlOv4n4wrBfGnTt0aFGrrVRBHWr5KHI8gRsT9W3B4c?=
 =?us-ascii?Q?76nCjJ5wFMShzo7RruiBTnH8+DmMWj2LofJeaeJvBsfB4HmW3ksdlKg/IcOP?=
 =?us-ascii?Q?+yNse1hmPtmLLJsX9PDe38YDgkHwMUKvuzN573JYw+MB+iSfq1nIvunvvRIt?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7fd0be-6378-48ed-4bbb-08dd8d37d7fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:54.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tzbLUI8ExqWf9Hm+OV2dWmHgRAa7oxKVHKQsPGmtso4sAv+pe5EKzSHuSOveg+KjIl2nDAA5ZOGUMlv6ouXeqPHFLV9iGPs+KuL288KbDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

Both detach_target() and cxld_unregister() want to tear down a cxl_region
when an endpoint decoder is either detached or destroyed.

When a region is to be destroyed cxl_decoder_detach() releases
cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.

This "reverse" locking pattern is difficult to reason about, not amenable
to scope-based cleanup, and the minor differences in the calling convention
of cxl_decoder_detach() currently results in the cxl_decoder_kill_region()
wrapper.

Introduce CLASS(cxl_decoder_detach...) which creates an object that moves
the post-detach cleanup work to a destructor, and consolidates minor
preamble differences in the constructor.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   | 43 ++++++++++++++++++-
 drivers/cxl/core/port.c   |  6 +--
 drivers/cxl/core/region.c | 88 ++++++++++++++++++---------------------
 3 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 17b692eb3257..44b09552f44e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -12,6 +12,11 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
@@ -20,7 +25,11 @@ extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
 extern const struct device_type cxl_region_type;
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
+
+struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
+				      struct cxl_endpoint_decoder *cxled,
+				      int pos, enum cxl_detach_mode mode);
+
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
@@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
 {
 	return 0;
 }
-static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+static inline struct cxl_region *
+cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
+		   int pos, enum cxl_detach_mode mode)
 {
 }
 static inline int cxl_region_init(void)
@@ -99,6 +110,34 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
+DEFINE_CLASS(
+	cxl_decoder_detach, struct cxl_region *,
+	if (!IS_ERR_OR_NULL(_T)) {
+		device_release_driver(&_T->dev);
+		put_device(&_T->dev);
+	},
+	({
+		int rc = 0;
+
+		/* when the decoder is being destroyed lock unconditionally */
+		if (mode == DETACH_INVALIDATE)
+			down_write(&cxl_region_rwsem);
+		else
+			rc = down_write_killable(&cxl_region_rwsem);
+
+		if (rc)
+			cxlr = ERR_PTR(rc);
+		else {
+			cxlr = cxl_decoder_detach(cxlr, cxled, pos, mode);
+			get_device(&cxlr->dev);
+		}
+		up_write(&cxl_region_rwsem);
+
+		cxlr;
+	}),
+	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
+	enum cxl_detach_mode mode)
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..20b65f13bded 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2008,11 +2008,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
 
 static void cxld_unregister(void *dev)
 {
-	struct cxl_endpoint_decoder *cxled;
-
 	if (is_endpoint_decoder(dev)) {
-		cxled = to_cxl_endpoint_decoder(dev);
-		cxl_decoder_kill_region(cxled);
+		CLASS(cxl_decoder_detach, cxlr)
+		(NULL, to_cxl_endpoint_decoder(dev), -1, DETACH_INVALIDATE);
 	}
 
 	device_unregister(dev);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 11448824ddd4..17e69f6cc772 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2122,27 +2122,52 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+/*
+ * Cleanup a decoder's interest in a region. There are 2 cases to
+ * handle, removing an unknown @cxled from a known position in a region
+ * (detach_target()) or removing a known @cxled from an unknown @cxlr
+ * (cxld_unregister())
+ *
+ * When the detachment finds a region, the caller is responsible for
+ * releasing the region driver.
+ */
+struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
+				      struct cxl_endpoint_decoder *cxled,
+				      int pos, enum cxl_detach_mode mode)
 {
-	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
-	struct cxl_region *cxlr = cxled->cxld.region;
 	struct cxl_region_params *p;
-	int rc = 0;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
-	if (!cxlr)
-		return 0;
+	if (!cxled) {
+		p = &cxlr->params;
+
+		if (pos >= p->interleave_ways) {
+			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
+				pos, p->interleave_ways);
+			return ERR_PTR(-ENXIO);
+		}
+
+		if (!p->targets[pos])
+			return NULL;
+		cxled = p->targets[pos];
+	} else {
+		cxlr = cxled->cxld.region;
+		if (!cxlr)
+			return NULL;
+		p = &cxlr->params;
+	}
 
-	p = &cxlr->params;
-	get_device(&cxlr->dev);
+
+	if (mode == DETACH_INVALIDATE)
+		cxled->part = -1;
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
 		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
-	for (iter = ep_port; !is_cxl_root(iter);
+	for (struct cxl_port *iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
 
@@ -2153,7 +2178,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
 			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			      cxled->pos);
-		goto out;
+		return NULL;
 	}
 
 	if (p->state == CXL_CONFIG_ACTIVE) {
@@ -2167,21 +2192,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		.end = -1,
 	};
 
-	/* notify the region driver that one of its targets has departed */
-	up_write(&cxl_region_rwsem);
-	device_release_driver(&cxlr->dev);
-	down_write(&cxl_region_rwsem);
-out:
-	put_device(&cxlr->dev);
-	return rc;
-}
-
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
-{
-	down_write(&cxl_region_rwsem);
-	cxled->part = -1;
-	cxl_region_detach(cxled);
-	up_write(&cxl_region_rwsem);
+	return cxlr;
 }
 
 static int attach_target(struct cxl_region *cxlr,
@@ -2206,29 +2217,10 @@ static int attach_target(struct cxl_region *cxlr,
 
 static int detach_target(struct cxl_region *cxlr, int pos)
 {
-	struct cxl_region_params *p = &cxlr->params;
-	int rc;
-
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	if (pos >= p->interleave_ways) {
-		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
-			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
-	}
-
-	if (!p->targets[pos]) {
-		rc = 0;
-		goto out;
-	}
-
-	rc = cxl_region_detach(p->targets[pos]);
-out:
-	up_write(&cxl_region_rwsem);
-	return rc;
+	CLASS(cxl_decoder_detach, ret)(cxlr, NULL, pos, DETACH_ONLY);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+	return 0;
 }
 
 static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
-- 
2.49.0

