Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990221D3DF;
	Wed,  7 May 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602614; cv=fail; b=MN8LGjVaGaxtwXLqcZEWeaNvtq7Hs31BqPltj0qjxkSg3DVYZd2omdQGvzXLpysgJhzTjKBXlVx3eSkM/iO7t6EoreLIm/Ei5fIwEDU5V/K82Ft682AtL6l/R5Kjc0BFaw5EEJN3emKB0Bmm6PuElPwNiTYJlRkEu3MI5flnx+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602614; c=relaxed/simple;
	bh=RaY/4YopvKVewY1MJ7evHlw3H9u+09MEzGeWBWKrXbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixwaiZpoSLzQnPNedyqJQyWne/3H2GM7rNV7fFqJ+gmI9Iw+3i481ynyXEwNnS07Yw5Bkzd7CpAYFxhw2qq1xLOfvILoU682uut54BbCQ3iJxuohzwsbeepbhNf5A08oNZ90mZOgEvHRt6f10ubJiViWEJZozaC1qwcggHtikfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbByc1Vt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbByc1Vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602613; x=1778138613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RaY/4YopvKVewY1MJ7evHlw3H9u+09MEzGeWBWKrXbY=;
  b=JbByc1Vtdt9aODJ3Cs53tQB27BF4Vz/9BgjrnkW/rxeJXT9PoK36lq7N
   ExTAjG/xEyR7FOnWuwZlrBd5lzqnJjIkn6gqIvQbXC1LUFhNI9CVr9VJR
   +x6shl7NpbwjV+XMQoaGbL2D4baXHed49/HROw2ORuOxfQ2f+WE9wQH4e
   Cz4iEpxDmbU0SWjcjf0nYuplbUXpehnSfdK0AVvw8N01iqiXJpOIpmR3R
   cAPqAZpUeuXEpYKPDsO/dbqUYgK2o7YOmifIZdlRQuMI+EbDQhLdKjc3Z
   pPVAINKaXGSvbMYTTethlfo3eNAolM8DQ/x+GihIUQQxR2FHWsX9z8MLH
   g==;
X-CSE-ConnectionGUID: STbDlFsbTzuqe7AAQn6d5g==
X-CSE-MsgGUID: /r8hdUG2RdSaG5fB27GAug==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58510849"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="58510849"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:29 -0700
X-CSE-ConnectionGUID: +QFAPvEoRHmpLoaGUlVxQw==
X-CSE-MsgGUID: VFkhxBdpQbSZEaEjMxma+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140603589"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnH59RHtQ1KxqUrG14eWHKZN+Hsxw3o7peBcWu8ND4CF9C1V3ODO0bUDE0FxHjPD0o5H9/04xJKGZ5psOBuCfZzY+oSJcX+9kBc7+Py1WOZxeERhzcLUmRi6IWpk/pS0mfzhxUkxAY/3HONlORkELgv/u0pWDlRDSHpbylfenlvRIN/RKPhpxGe8luVEpDrW3+wfNTB2VhZdnBLaNDZ/H/SAcVJw0YS5BjiGL7U850lHLn9ixO+XCA2D98x9lLqNOid//lcgDSJ+42qGdlgvPkm6wZlYcz0S9E82mCGXEqVmhaz9vRUF3PHUlIApU0UArVPpUN/UlinoyW/LUEGZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAVbswtfvJJ3LD1s2j1n4TNxkKYSvT9wKY8XwxIaNRE=;
 b=zQDiUW67XqjTM72hRhcqaa1BpCfGiIk//2ynYG/AJM204bKJ5xU9rNwBkP1080UjX1x5nEEWbV6Zcq+W+aAWObmRHwHo1ttz3212eYLtxdVcvXzvCAHmpr72ycH77AedKNY/dH9u0tgGsbb/becDfzlbYM9+Mv7uiWcRxPNub2aTtRkUZJEjxqwLMo7a/JAUytADVbXHWGHQcL6WMpDHA6uI9MUGJh3G4+/JjGR4nHa9+bCoyoD0Ka0DkhwFwazm4nkhqPfPCzJZpXwmMcPQW/PtC1kuhjgAZ09BYPRhAa1JuJYR7RUG062HtgdV5MBWzCNDFnCMqIVdgT5dSCdprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:53 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 5/7] cxl/region: Move ready-to-probe state check to a helper
Date: Wed, 7 May 2025 00:21:43 -0700
Message-ID: <20250507072145.3614298-6-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80bdfc86-e3bb-4ba9-17dd-08dd8d37d771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgbUAbAVH6C1m+hAdw3HO8ejfqVn1f03etDrNnnG9Gj3BmxDLZ+e5eGQRcqU?=
 =?us-ascii?Q?QFCTS0sjFIPuTge/6EJR6bhM9E1pTg2azrtvZlc8ZC6uBxFTTGYggeT/5+v1?=
 =?us-ascii?Q?UAurTu+H9McGhGvcWJ8s18o1LfXuSOy3vUW3X7vFItKjsAodslcOLRPAjNqO?=
 =?us-ascii?Q?/Lm4lAbTj/jyQvRLvvOHeg7dN/f6FhgBvMpzHiqxLDtjY4at1yLkiur+VU99?=
 =?us-ascii?Q?WUYUncWyq2b9OmfyYXtf16AH4AQDuNAgfI/J7v8wadvxpGw3l7rsExRQBaSv?=
 =?us-ascii?Q?9y2QiEGmv82eRlFf9xfG5q0NAAmKfdyuoM6/u23BGW+BZrfO9eFOkHTT2rir?=
 =?us-ascii?Q?MTfyHnvEjY0KXnYK3+zhMoWP0YUiAp7rFbhjI6dKywp2lOZKmZ+DYz8mqiR6?=
 =?us-ascii?Q?iC3X25bgdTOLKDmVBs3Mun1LHIWUO0wUYC6VTcqdbnEsFHy9jTOBbA0bn5Lt?=
 =?us-ascii?Q?qAamWQsBKUKLxLtiosA0gZ13ufxpbsZ6XVurCSbLXmMvFioEJHLEdO5tZlfl?=
 =?us-ascii?Q?gmOE7bNybz9zOpFToDhKrOPP/J/HQv0Svzn8A5PJkFOguHUaE9mZEZfpCAzX?=
 =?us-ascii?Q?oDt337nw5uoTiIkGMA3bN+E5CDfw/DjTuB3t1puO1v73+Rz09z77Xw5PHVl8?=
 =?us-ascii?Q?4SkV1zpKUFUwprqPt+KVtBNAirGbJkA58jJUbtuCrHPCjnHXX55sprfjWKOo?=
 =?us-ascii?Q?Otxv+CiQnhj5r7j+bnaFoS5XRVFs6RRzERATB/d66Tm1DfSolT+rdECUHfuV?=
 =?us-ascii?Q?gk+/s/zaU7kU442H5LHK7v8bFo2LJ2VuAgiUP5N09oZXAFMFsEo3pOSljNF/?=
 =?us-ascii?Q?APbv+GnRkLZGMEy5hgieppM22aem2FXJzT0ED85lxAMV4uRJSEvGeEXDBQet?=
 =?us-ascii?Q?zWBpytqCzi7Fs3queoYK2ORizCiviu4NBEjBzE0mAIUgYwnqpqitknUdwtIt?=
 =?us-ascii?Q?lQ0l4jYHKHFkwgtsvAyxTeRex2Yd2nWM9msNPPhDP2YuXVW8Keefi9MBRJoG?=
 =?us-ascii?Q?DS8k6kIdefEexCWYWgBpH7EsjyTKzs4RrWwxJ6qe3MjOYeSBO6Aph0RATRf3?=
 =?us-ascii?Q?4/PT0rLQNIy6Xk4iLcZ6WNnGd/Yxq7Tz9XcJyrNpsDyecS2320YvJN2Kh1pV?=
 =?us-ascii?Q?zMvb/Mz8MkEDSStnenILLDiKFRj1vWdmsaoocfID2Mk5DrCHMXt3WVmDmY58?=
 =?us-ascii?Q?C0ybO3CGXvFMrrWbSqICd4hn0CktM+0pcDqI6/qxm1V7bKcyvMh/cbfU8Hj7?=
 =?us-ascii?Q?JrJDQMBCp63bIrVQUwsyIcAbWRvNstH+SIR1Qup6mWmknsTrhO23v6VIvu+W?=
 =?us-ascii?Q?efNP5gUSMwSM5+je4l5fbQnfQyrlSrsSRqJw4t+Er4k04+2B4Ic7qlT8RM7x?=
 =?us-ascii?Q?P1N/qI7kxlqJNanX3lBT/524rMl8nUt9mIsEMJUutIKc6Gw12to4ahN9aBas?=
 =?us-ascii?Q?ipWPV3KsHtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8h1foyN35hCXTorvTFF1F9DFekEPvHha5TjT+sh50BWZFQkLcrWA2BXP05qV?=
 =?us-ascii?Q?iW3O2n8F5PYGNlycuIjgWUKO5A8VB1FnczWbBPxYV/bmGDKR8VM15sz/9ewQ?=
 =?us-ascii?Q?tIRnoBmxJ+RKrYGt3OHiDRcF/LnqjW9UtjGfE9/wrtqRSJzHOxOkvBQvtR+z?=
 =?us-ascii?Q?dBNHGub/H5D3KukPzLWeAnxHzJLMs5/zr3J2h/cJMWuQtooCd5I8pt7ZP5B3?=
 =?us-ascii?Q?A8Y/EZawLT+0M4Kk6d1ywNiZXNOob+0x+ceLTi7uFZOMOZm10xE/pKWkid1E?=
 =?us-ascii?Q?Gf1AI7CL5e+eB3F2osJzpDmJ4+tTFXyyknOQ7rZHVpo5keHAr7MIUYUGGX17?=
 =?us-ascii?Q?9h7Fh7MuHdgpFJ9h7WJx0mtebowKSHwedhii40yvcjiQSCEknu+JX7fTuJGj?=
 =?us-ascii?Q?LsumxBWfZCgU5jvFZ0DWCn1nRWTvwSYtN2bF05Q6TBvFOHOS1D544fcvmS23?=
 =?us-ascii?Q?pDWbyZM6QsdfoNDp8U2SOpox8Z12aSjGGKqQIoGYAYDjZNpgwGLPNcjskNJT?=
 =?us-ascii?Q?XGcGEyEJBwV86AhkU8DEaXW5p+tl2zvbML83Z72rk8VyDysg7nGzK4NvLVNF?=
 =?us-ascii?Q?JYWeJMx+rm9GAMaiy7JzgsrEMletmo2TIEk/YEaFVIXMZong9E4MG1RQKOHd?=
 =?us-ascii?Q?2Lf6tDF+IXcgdedJpNDCoyvghgeFpvgqrAB4rV4VJfa1SQC3fpXlDdqttY3G?=
 =?us-ascii?Q?svFPwP+jt6GL4v9li0PePcsbQMix6hjpH7zcsOqEKkEVO74A4uR3KsATgfO1?=
 =?us-ascii?Q?/TYk4zwB+sSAtDdceMEci0fLnlVpI1NyPKauiI4sz2Qb6q7h6Id2r+JSJTL7?=
 =?us-ascii?Q?hxbddHYOb3PBIYr7fCKGmYGtppfz/5N4PTzz/TnwJA0pTnkN0/LyvDVStAYa?=
 =?us-ascii?Q?W6u2htKW0ChsC3TX76baTGPdXsE+aSKoV2UwCG879f8ikNOAKRSmP9f3RGqV?=
 =?us-ascii?Q?4SUisFuCDEbP03t+yiJ1pvu63+WIvkmtH2ACoVQB59HHax+gIrwD0DOb5+t/?=
 =?us-ascii?Q?YAm1UtyDaoZ5VHoASqiLo9sm5WDsbiiryxd4baMPYtEq7bNLUjeqechIX3qr?=
 =?us-ascii?Q?z1d/ozxxdxxXdejyHxtacpfV6tYPKGx+jGh2xbouGskFwqhctKI4JcowDq9+?=
 =?us-ascii?Q?sIUVSlOX80W5h/iSljkJpemD5UOx/tcBUct2Db67flqgw6GAwF2HqTIFdvTN?=
 =?us-ascii?Q?o+h20pdT4PRnuu9moP0XWI0YhM243dmpBkM5WI6VH3hTf5IjedbocJgVIWNy?=
 =?us-ascii?Q?wlWF/LLdXznVfzCMGbQHl2U1i87cnnERgklYC8/E/e8j5goXUxTLcui2rM1h?=
 =?us-ascii?Q?xfL483mho9K3miYUkJ+3I+WL8X0LCGYc0vcOCDs5ULecFOlZozHC0o6KNCXK?=
 =?us-ascii?Q?L4CGHsmHePpRwo9TDOn0hB9XpWs+1oMX19DjS7+LJKUbvfqeF0AjymNt2PFK?=
 =?us-ascii?Q?hj2TFJVpc/zL1PM1LEVMa55GmOlyFzenCEtyBO2XoBZBVJTMIwy8ubd7lngO?=
 =?us-ascii?Q?7VbJgS89mQgitGmuCOAdpAn40ifk0UhWb/CPXIURXTALlO9rbbuHlAMZGJlA?=
 =?us-ascii?Q?V40pAWfRaZ8VgfF5sJmHp3WDq8G8A7B0X5OkQwfx4ZlvlPcuM5RvBYlRr84v?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bdfc86-e3bb-4ba9-17dd-08dd8d37d771
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:53.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBo9SEtfha/boj3Bhf/fzNdHNRjQmiV3GQk6IBt1n/9FSiNjKj6p54SRogpMuMDs8NF3h9RqwDHYabhS9EsRY2cMKZKKZgZsEoas8Tq8T6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

Rather than unlocking the region rwsem in the middle of cxl_region_probe()
create a helper for determining when the region is ready-to-probe.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d52e98e2f7a3..11448824ddd4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3529,9 +3529,8 @@ static void shutdown_notifiers(void *_cxlr)
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
-static int cxl_region_probe(struct device *dev)
+static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
@@ -3554,15 +3553,28 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
-	/*
-	 * From this point on any path that changes the region's state away from
-	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-	 */
 out:
 	up_read(&cxl_region_rwsem);
 
 	if (rc)
 		return rc;
+	return 0;
+}
+
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	rc = cxl_region_can_probe(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * From this point on any path that changes the region's state away from
+	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
+	 */
 
 	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
 	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
-- 
2.49.0

