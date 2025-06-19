Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D308241661;
	Thu, 19 Jun 2025 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309481; cv=fail; b=hcorh09LolzlfS3HaU2N/aGAECKQkw3znRq6tgB7XYfk3zrmpF5dJOJ+cgMtleI5cP/i3pu8NGYms/FJtmmDNayLsrXuFoc6XBp4Aos0XiKwPGAu2aV1XPLdYeSdbf/wP+VJwlSNMaaKa/giUqkNqovAMo8AQ3QTOGCTrc6nX7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309481; c=relaxed/simple;
	bh=3dsT5yRV3iHQQZ6L/IqDQhSqhj0PHvUGHLWj3jVtL1U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oX8PwGp1BtCYmqTiTYpvqa2x/RNPH/lEgJ8V3+Grn0H5Vlb9Eu3YmcP6V99Vl4QgcHFA63MH7JFCSxILJe2Qzc3iSFasQJyEMMpvwPEwJj60vySegUkHtSco3/7DoM0W6SyXrvP0bXmZeFEretj1Rb/j+hdUAE9t8A1KOSXj4Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPbYVyKu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPbYVyKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309479; x=1781845479;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3dsT5yRV3iHQQZ6L/IqDQhSqhj0PHvUGHLWj3jVtL1U=;
  b=mPbYVyKuwQQyuMrQnAIWXtKJmyXND54t1vGvdLlpr8BPv/ZNUkaOYdIT
   U24Ufvt0StDZEzO1hKVMpTRNTtVA3iJsKggL1ojJ58mXYCDdmlOmwRJYP
   dTjkXKXLXislfLdxubOpRu5eKJy0inip+SjRVlqRmemEdci0SFLfFkjXy
   YcXULwFjGwiJA8t3wolCFCChheMNzl+OO+pbZ8EUKKEsqU4dXMqUslZ/z
   UJUgDPGPdsRW9mMnlWS/cxR8XIGH00jAsM2z8+HgSfWDzAKeEb3rXx5/L
   h9/JKx696oB6+UbssQZbOLR8rGhPKHLtfpbBMGxUHK3wVTqAqB3/iVgd4
   g==;
X-CSE-ConnectionGUID: Kfd1uj2XSwaAI97PKbv0aw==
X-CSE-MsgGUID: g9JTs9fjQU2APyxMhndzIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702169"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:33 -0700
X-CSE-ConnectionGUID: uxf1hVKUQseGtjP4O15Oiw==
X-CSE-MsgGUID: pXjGop4oQQGU4EB20hPcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181373527"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdRliAM44HHdZlLQJ8LgHefhBI3Ic5FTue8XprIfjTLqwfY5x3Xl/aHIr/kvdoxj0RMBwhZKy8ojyFY5GJLzpHfYXa1P8V+DM/KOjjHoD3WM1Wr7/AcASfm65lwm2mv2a5cdIYHY6RoApj0wLo8IiqJkdDqNCovNJ+cidK4AT/wU8KaVqkBiWj6gls00i/NajaJIWHvKcJypZYqQsfiV+L/RKwx5IlkjDYm8A1+e+UmC3AYXsbaAeCx+vmjKGzVdH3a1dOf1IR/zcdWS+I1cIu03TH4IRonkQrBsByyW99rfFssA9aVrImAHausWDD2E+B2g75K8brtVnMKzG2T+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPn4D0+p4TVO8vzSz3TBhFi++3aGd9enQZIZjfa9+Zc=;
 b=hbq7A5gx4AoB35xdC1C2SysVznCw2AEkVIutH91zzWZlnghNr8EW8xTWLvj6pY/xsGOtALZ3gRPENTYbVlskc7pdXXQPrfALtSYyzrorOBx1s7h9t+wr0gstbh7A0/2G6E4pIsQs1x/J0KC5+y7XcLNP/gdXOj+Je7Sj6FfKJ98+L72GJJdpKcgWT3c/7Z6KP/ec5cMbWfo6pzDU1g9nV4+MN3hSb1ikblivFHXs2ybwAmmN9NdzNAtlsqPq61sKo/M664PWR93E7dSv3VkttdOl+xmi/Ek3UgM8EDK6zjmBjxB18nZnuJifBY+4MwHxU/c0NgeOLw5k7twn7aqRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:20 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio
 M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	"Shiju Jose" <shiju.jose@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/8] cleanup: Introduce ACQUIRE(), a guard() for conditional locks
Date: Wed, 18 Jun 2025 22:04:08 -0700
Message-ID: <20250619050416.782871-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: b4292bdc-b296-4c43-4308-08ddaeeebf8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QmGBKEXa1GCsSgU//eELACmRZQIUyDAjiNYybs070lK8DFGFd3vJT4gGnvFj?=
 =?us-ascii?Q?NbtoI6dcNaT4HSiyjAPfjQLewNquMb/Sd23nm0MQ0lxxDqSqFi/IlGeaGgJW?=
 =?us-ascii?Q?lhbOLhd7hvl5s0T21FrKPpm6t1O20FuEggO+g0HXbJzPeBmhtlWyd7FhXSGE?=
 =?us-ascii?Q?LUNAht8WrHe0R3VhQgjAU480/wzngj/3UFJOhsd6smL0tUXdyXhwVmq9xXMD?=
 =?us-ascii?Q?MFNckSLBtgksxjJ+X78hiR1fL86wZpXzUDsKMt71/eCPb+nTtvpkC5vOLH1O?=
 =?us-ascii?Q?ne7zmIPGXrczxWt/qHKXyOS/WRfUBv2Z20SYitkhNoEBSIF7GYRksGD+AKN3?=
 =?us-ascii?Q?uYh3giv3xVdwkfwoj1tng4WIigItoI7tIVGC0yeNL1/G4RUCGCmna7sjc4ZB?=
 =?us-ascii?Q?Es9eSq4ClJMsqWkMUi2Mkj3ItoOLgDSxWnZBe5pGQBbtv11HANRNADpeaDk2?=
 =?us-ascii?Q?CDRC7IJ1TDPSs0e4SXCjsv6EbVvxXZyLTwCdrEPbQKXmI92MzvgDutCe/91q?=
 =?us-ascii?Q?TSH55O1fn6EmWnweGDmIk7yhuHjt1Zzl2yhuu+mvHQFg/4HDIuGIRGQCzA9B?=
 =?us-ascii?Q?GYNW00VC7y8ZdslcDqHITDf9479UKWM5onGDbJEj7v0iWByUxQRchzNBk0X6?=
 =?us-ascii?Q?4D3TJFqlkkcZ2yL8A6MuIU7W9rRLM0YPFgmkYvWiUvhoihIfAA6riLqC6xXt?=
 =?us-ascii?Q?xbY7e1R86B3aQb2bnve2XKsoKYynnbLXzzc2Wn9LvuJfTa9a44DawHBslKST?=
 =?us-ascii?Q?BZXhKcDiMgoq8Of/GxBTScvWuSlLaZU+zIBMKq5e6pN3X/P1szjNdnOwX/4L?=
 =?us-ascii?Q?vOVQYWhYGUsrFYVKlEMvrE9DaauDhjJ6biskzdP8XnU8pG8lZWkkjLepTTFm?=
 =?us-ascii?Q?83hpTNwK0W4kCy0VlIJPSgp8WWnJP0mGV5LwqIcjFuEL45ifA5J7pwf4GHhI?=
 =?us-ascii?Q?HsCzCxqGbh9vnTZODAIR9trnJEyJ6HnJI+gJKBv/RUsn1KBYMVK+HtV+GQ+C?=
 =?us-ascii?Q?8ntB78VdOzy5Ur5xPL6zef0onANUI0usIhUjHDhOy9Z1KwUE4f7jVQ2MNxUu?=
 =?us-ascii?Q?y+TWaMqmQEJ31nx1gmgwTHkIv0lSgH4UQoL8nWLeau+0i8SGFuz5NHqFW7T/?=
 =?us-ascii?Q?DAkRO7fkQW70QwbRgEyLSvQw3SMX47nzlcRt6wNOQu6I4qOBg5FPT2+i22cS?=
 =?us-ascii?Q?mtDWQ5ysYGwtn1VbDPe5Gpi2notK9J1R3zjCwuPWHMgP71jTl3ka1Z8NQllJ?=
 =?us-ascii?Q?wO3zhT4JqMiXam6LjEq3qauxYAE3vJ80IVzVawWozDS0UTpAnr+9qgEUUyjV?=
 =?us-ascii?Q?9HgmkJl6lT34wJbw9ILCsCEomf6QhXJxkIe0+pJEmpQUU2g8NDvG3YzxXiMi?=
 =?us-ascii?Q?Q5MsjR3FI+joOI7PMbnLSKxpSmK7qNV6NF2/PFqunybSsg0CJ4Sv3/V7OKct?=
 =?us-ascii?Q?S035+6RY5/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPsN5AJGfENRZ8nr6ZFkswfcTpj7jEsnt/IWL+qaWIakPCo3gX9NGlr0iJIu?=
 =?us-ascii?Q?2JgHjhMV6Y4tI/im9Z7D28aX4mDkkEEcQMC0UP1FfWMK/Woed4q5S8eKcQEK?=
 =?us-ascii?Q?/bDkCyOwOyDKrfBWkBlESttX8nbGwPz/TPlwm6bP0AZbUPdv+N0CE8ZztM89?=
 =?us-ascii?Q?y0xzWDWq1iPth2jNbMPOs4SwyGAzHn0L/320iSHKoKNbz9GCbWKZ0Sa055AE?=
 =?us-ascii?Q?Ign1E8U1hCKoUY6vJPmyOTUnaRefqk/bDlzzVJXuxCGUNUuRg8tCmzknng1B?=
 =?us-ascii?Q?JNWs+R8MAB9NKRI8pulkuRw6Y98dB1cuWV06BpDleizZlLHZvtM3UpTeTnlr?=
 =?us-ascii?Q?V8CxA7bfJHREZzISBNrO8UjuLE/ELSdAzSuNhzoASnIc8b8CheI2/TqMLRaG?=
 =?us-ascii?Q?O8UO7Qe5O3HA06hcqbSE2e8YRy6O+cD/LkJ+byVmJH5TRygIo+B/O/0K3di1?=
 =?us-ascii?Q?IdPx2cL2u78uS90kUB9C98qK4wh8aO27dK7tkwGvTk4ozSsPX3XDM9L0yOSX?=
 =?us-ascii?Q?Up13QGTZ03KDsYAnKKfKKhAcRcVTPxbkj+dwkcVM3QCBWlXOA+7UMxRmbmz2?=
 =?us-ascii?Q?mS0VDwjmkdXXdY2I0xph4snr3HJete7hiQ98kkrUghOmfNKh/1q4QPnAiCY+?=
 =?us-ascii?Q?fg7+zQHxRFOU7Z5tc9ELGEmm8K2zctggFagODAIPyPw+zep1OYfCWbVq5Z3d?=
 =?us-ascii?Q?0SGyXAnsrywE+dB/jMA4KBdXuOr3cqWToUMrTedTb+XIDdW6iECqMzFX1yKe?=
 =?us-ascii?Q?vOHR6B2jFu7GKsn8AzkFtrSmp7k80yDjohXRYUdZXBPYFinBtV2E0jO8Ppeb?=
 =?us-ascii?Q?GLnY3Cs4/eC7NldLMD86tWI7eMsSAgG5vnxC3+OE2HASZcwPVBAGyRYHuneo?=
 =?us-ascii?Q?itYN3iWpLakFIb7QYN7yBU4sjm8GTqxYx6MpRI+jrXJdjSh17/ALEsrgUYLO?=
 =?us-ascii?Q?A/4mBPMreVytqGMfjIoIFHk6OiHjHvLF+UvRa3xal8DiCcfLVe2wCjlFhVq8?=
 =?us-ascii?Q?/67CqmXlOwbzGrHDIaeXIiqRP22BYL6cJancaeH3Bn83b8yNW9mo4u7gR66s?=
 =?us-ascii?Q?re8e4Yw0vi0biLxTq/nyctxJllUUI5TduVOmRpDKETufF8PDZKOFQDkQnt0n?=
 =?us-ascii?Q?U2hghz9pf67JQlMyXLSn9EAh0gT9tY5CuuyR/oq0Mdn0FYVJrq1IP8/jm/sp?=
 =?us-ascii?Q?YWt8qAjDSrULKEjUuqDBLELPtKQqqwjAvt6jWigwORF6Fi/5CQQGe2G0U4F2?=
 =?us-ascii?Q?M6S2QCrItj+WRjwyAsMJSHQpCpiZW+FRA083FJBtes86lhhhsgQt6AWG7SmT?=
 =?us-ascii?Q?nfiAKpiGW5/v8E5AjeCXxb/Q1sl19i1b3H0auhA4x+p/NAR6zf2cYl2rAmka?=
 =?us-ascii?Q?zGYeO3e8qUJlPqsf6bt+vLM5gjRk4YAEcBbdoD8LXCDAhVixMtRA+mUUklnZ?=
 =?us-ascii?Q?Igf3+NMCnKrIJHaWYV+jLTK/SiQNwIqSieJ1ky0YBUZHxjxAW0eB2FlvIcl5?=
 =?us-ascii?Q?ubc5gQ8B9MnhqseM84kF4kpThE1MLxqx7PdjnowjfdnBDW13ZXbEyztw4LqU?=
 =?us-ascii?Q?C9fkMhbnwFFJOb54bit0WRk1xTpXNnliUhKigVahKiHRpKCbRwq35dJHBAtU?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4292bdc-b296-4c43-4308-08ddaeeebf8d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:19.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPKHJCETg5GdGoXC0GKHT2WXwBlvc2WpW+5FJsWmVXaPeqZae8CjJkHRTailxAwEUV66J2B/tqgNMuAm2RF9U10dTp/G51RVuPzAOZd2UuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

Changes since v1: [1]
* Peter took one look at v1 and rewrote it into something significantly
  better. Unlike my attempt that required suffering a new parallel
  universe of lock guards, the rewrite reuses existing lock guards.
  ACQUIRE() can be used any place guard() can be used, and adds
  ACQUIRE_ERR() to pass the result of conditional locks.

[1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.com

Note, all the code in patch1 is Peter's I just wrapped it in a changelog
and added some commentary. Peter, forgive me if you were still in the
process of circling back to this topic. I marked the patch attributed to
you as: "Not-yet-signed-off-by". Otherwise, my motivation for going
ahead with a formal submission are the multiple patchsets in my review /
development queue where I would like to use ACQUIRE().

The orginal motivation of v1 for this work is that the CXL subsystem
adopted scope-based helpers and achieved some decent cleanups. However,
that work stalled with conditional locks. It stalled due to the pain
points of scoped_cond_guard() detailed in patch1.

This work also allows for replacing open-coded equivalents like
rwsem_read_intr_acquire() that went upstream in v6.16:

    0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature

The open question from the discussion [2] was whether it was worth
defining a __GUARD_IS_ERR() asm helper. I left that alone.

Lastly, this version of ACQUIRE_ERR() matches Peter's original proposal
to have the caller pass the lock scope variable by reference [3]. My
change of heart came from looking at the conversion and wanting
ACQUIRE_ERR() to be more visually distinct from ACQUIRE() especially
because it is accessing lock condition metadata, not the lock itself.

E.g.

       ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
       if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
               return ret;

Yes, checkpatch disagrees with assignment in if(), but cleanup.h already
demands other expections for historical style, and a compact / limited
idiom for ACQUIRE_ERR() feels reasonable.

[2]: http://lore.kernel.org/20250514064624.GA24938@noisy.programming.kicks-ass.net
[3]: http://lore.kernel.org/20250512105026.GP4439@noisy.programming.kicks-ass.net

Dan Williams (7):
  cxl/mbox: Convert poison list mutex to ACQUIRE()
  cxl/decoder: Move decoder register programming to a helper
  cxl/decoder: Drop pointless locking
  cxl/region: Split commit_store() into __commit() and queue_reset()
    helpers
  cxl/region: Move ready-to-probe state check to a helper
  cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate
    multiple paths
  cxl: Convert to ACQUIRE() for conditional rwsem locking

Peter Zijlstra (1):
  cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks

 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  60 +++++-
 drivers/cxl/core/edac.c   |  44 ++--
 drivers/cxl/core/hdm.c    | 118 +++++-----
 drivers/cxl/core/mbox.c   |  13 +-
 drivers/cxl/core/memdev.c |  50 ++---
 drivers/cxl/core/port.c   |  24 +--
 drivers/cxl/core/region.c | 443 +++++++++++++++++++-------------------
 drivers/cxl/cxl.h         |  13 +-
 drivers/cxl/cxlmem.h      |   4 +-
 include/linux/cleanup.h   |  77 +++++--
 include/linux/mutex.h     |   2 +-
 include/linux/rwsem.h     |   3 +-
 13 files changed, 460 insertions(+), 397 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0

