Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578C226CE6;
	Fri, 11 Jul 2025 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277791; cv=fail; b=cyfTLgmL4UpHz4A6f1TlQHkP/PNyb+VB1p6iIwT9c/15nkDi2qF5fPxb+4EimYQVr6ouuqavrvx3OkY5sPmlG3PXMWzBCoJArOCDpBffoG5Wia1ie0O7MFY0exX74v1QJ57Qq1kH1Z7oENxJS0OvgpoFG0tYSLmiKI2+i5cBKUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277791; c=relaxed/simple;
	bh=4yZAJZdaQtKCw2vFXAfD5dLe5SAV3b0ftGunalAmjVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3SKdANxDdl/gKQkjoH/GJv5n+pTH2iZd5SyFvpb19Tffqpurz0KzeAUT9ApMAmAof8c8IQrGVYQSEWke1rvJ4akXf9fUz2Q4eJREwXCktrGmpghw57vhxy7ICmJQzzzF/s9PJemno9U1BWFx35H4/RNwZSTIkqgYnXYBg7WbCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayi0npyg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayi0npyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277789; x=1783813789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4yZAJZdaQtKCw2vFXAfD5dLe5SAV3b0ftGunalAmjVg=;
  b=ayi0npygTf0rjPAst/rYojwg9mb8SD9WQIbPpCgfQbLhKaZl7m7D8ZNf
   oQDG8hY9/K5EOw1chYGNJgGxExkQLUZlR2uwvEL9OREdNCUt6IQ8CF1fO
   3PA+EQGj5c3OuI88fmb0cHake/Hzkyh8g494lGHMxX5tzPKZTm8GYCCuQ
   ofPx0UQY2zijdXmMn8b0aBBjDqwFrpRHG5gnYDJRybi86x3RJtvOLBkET
   3BR2yrCHRUQVFMMXB4dww4iAY5f66E80P0HP0Q0l5Aj6KNnnpl4ZeIzjF
   P6MxhdipZmHtNcqkTF0DUBVy0zd7BVUBkgyLmbRIP16VQ+/Bo47tJ0UhR
   A==;
X-CSE-ConnectionGUID: OStGs5d8Qpa/JPSyi1TE/g==
X-CSE-MsgGUID: mXXEO8rSRbirXBNRyr4dDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54547687"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54547687"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:44 -0700
X-CSE-ConnectionGUID: uK1cWUGJSWaaJAcGAY0fHg==
X-CSE-MsgGUID: 1wD5l/heRbiktdpcwdQT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162048563"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmXeXVUcRjHJTTxPDxP0W78NPpzJ4PrfuSqJ8sDOXlutGKw3ntjWp70zf6aU+X4vN2ekySeKwqleXmPkN321M9zd2Ra8Y2iGOCb5+OgPny9tgbKNMbtOmdt3tnfYs5HdY9aC+mAdpowoAOlLmxpUtfePMmRP22D1vl70hkaNhr9MoGizyDsPqxrfSX5P84DcVd/a3Ln0zTLsJtucOcWolcumDn9x760UEAVV7rk5nZlwWi9S0V/kSylzM3+V2B4e8FkYADOG4J0zaelpCE5rsl67KmcmBVmjZP3D4OEABEDbFCk3SAj+ek5LKuBAcsR3myb+huAG05k8e8/cDLsKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOul9Bvvpl/0FoxvtihmY3KqTgcO386YYMI6acvqcRM=;
 b=uzz57SAGkac3LsE/7BGSyd11y3w1fuu/HAUZwdk8Yu0VM5HrWkpX8MjN2ihFhH5dGw5Fe6EuxqKzc3ApFynnb/GdP1c5G39QZ4unh90ZxWhY9lrHYRpZWGZvwiscb0itinstzYiJY2EepeinRx+Ocfi8MCOzlWMDP5sAothTzao5vEgYAAOb42ol/e+Bx6W/O8zc4tytrDTG8k9Zghd0Rl4qyYYgXiGf5syhJHixICA7QJOJNsiB7RcpkDfCX+arpH3IQ4+s1IKXpYHR6u69JGSmCdtZ0MWOJyvtOv7Ftq/7s90pbNz7Ybd6rDSan9LUjA9UhB+dxyfMoRyzHpZxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9352.namprd11.prod.outlook.com (2603:10b6:208:575::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 23:49:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:40 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 6/8] cxl/region: Move ready-to-probe state check to a helper
Date: Fri, 11 Jul 2025 16:49:30 -0700
Message-ID: <20250711234932.671292-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: e1948d06-1caf-40c1-a0cd-08ddc0d59a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eWvj7tNbZALnl/fChk/30oyU12d93uZeq1pFvImrqnLzUCJO8rvUsamV6yLl?=
 =?us-ascii?Q?PUW49pkkr0REiCyYpDvNjGjxl4ygQPjnbmVQjHYjQs8P8H6lg0O5/iK3ablU?=
 =?us-ascii?Q?SpLvCdvkJH+OK8B4huYpb2pf3Khrf1o/OB251aHfX5b3D2qXoJVW5YfZXGc7?=
 =?us-ascii?Q?tzGdbV275gnNSYtB6vDBk7n2OnhbtZYPxybXK7nhjVj4d/lO8kxsF7V/Ez7e?=
 =?us-ascii?Q?vDdSapmppsm1R3g7eCqOaK/yMZIwJWeiQi2+bWoQJ6tSYhqqsQAZRHjSlDHx?=
 =?us-ascii?Q?t0mWl3BlObWRXeSru7FU+/3RthKpe8YRPUuJgIjqEUoJEjhumJTulwbRU8vs?=
 =?us-ascii?Q?Biif0Z31TYCBMC7/4M8dK08Xw7pAn+oL6CXsOBMCGl3O2MePObNyDeB55sw9?=
 =?us-ascii?Q?cgzqkataWXuqFuLjcP7zYysCXGHtBrwRYSYnU5RO99pitjFS23e8MDoofdWl?=
 =?us-ascii?Q?X7hQK/9F5l2Zem3YGfgzgd6ZCsMGHfWkH9IP8CFtUc+VaDvGJEY3PSgBXLX0?=
 =?us-ascii?Q?dfNg9gqaOxqoLPQGwA/GZE9mCBVlbPH2yERG90YjPHQlp05U/UGMKiB4zND+?=
 =?us-ascii?Q?rslnPGVfysleXMlfjycludw9AhtyXmp4rG0Tu0kAWZJs+djMhISwMPBLqIJ2?=
 =?us-ascii?Q?v120Uu8ABpKZbUCHPx7yxZxc/pdOYE97wGik+axD6g29Pgm5Mux3v604uC4K?=
 =?us-ascii?Q?ulwJWQXMUpwdVkmxOTPMRwxt7K8TGb4+zjLRAJlK5iPGjKYKWyf8SFh23fBB?=
 =?us-ascii?Q?jOqx7ab50VFXQJP0qQhAa4jV6u2Gv0+OWQepCNTHQLdS88La0xfpyMGPgvxc?=
 =?us-ascii?Q?cATvAaNF5ndcDaf+iDTtWCg3cQJJpu4Z4UbbO2neOG56aC7DkDHkjhXMbX42?=
 =?us-ascii?Q?pFzEluPzXFOEW31BjbgkVUSxknGEyjIFYRMNFEDx9fU+kBZ7D7ikZNnkHD5X?=
 =?us-ascii?Q?5WlkYU2+D8uPGYxTdHJcCwL27WuMcFhK5Nyf3zSnXM53bqGwCch3eJRQ5fVy?=
 =?us-ascii?Q?FQ+9efYcCdX1jzCVu5fI3eToPKAKdQq/ZmapJ66L2PVWH3irEq4jU2zs3xgP?=
 =?us-ascii?Q?a21qSWd09F9JS2e/I/IqIPE3Ld32cz4CH5ViqMU5xb27QZqZQDBa2FySYHNh?=
 =?us-ascii?Q?0nQCECDZ9V+gaFF10qKJAluXeW0t60S3tDfzdaHzcC+3h/MVkmPrFVKA/ZCL?=
 =?us-ascii?Q?PjfbSM87x9x9otigQncH3IZwa3q8uv4zG6dDQtNaACQVefyeBgC+wKDOIVtb?=
 =?us-ascii?Q?ePc47cA64fQNpljXFkEioqUeYViXWNQyTDNvRgFpv/Zbpvm5fagWjAgOBT5E?=
 =?us-ascii?Q?eHNq5brC0ihTDRZDqjTW82R+4KWny8az/82lvgB7G5gmYzBXcTLJpIReh3tg?=
 =?us-ascii?Q?hLrkc5WQq0nLEsnv+LfSpLhqTu9t0N7a16a9oHtC5CBf/MxVJRXcKAQJHDch?=
 =?us-ascii?Q?Clc2/CJjMto=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YpqmWEKTQ4zJpq0OWpcJIYaFDexrXQTHvycdG2rNZUSE3xU+nefWVQRCBcW6?=
 =?us-ascii?Q?aSx6XIgHDs+4yvGj8zNaAS418rXfH6bYddYIWLg38aJVbW5Z5W8uTAp3jyuS?=
 =?us-ascii?Q?J0OTc509yGFZnVC4788EESCFQya0784t4/nWIZ6u/7dz7AegNM8hPqCBS+ZP?=
 =?us-ascii?Q?xSx1TdIt0+4OPzsh++4RdpkRy41tvwCYjS9G8gYB5LNzcZxbBYzz89KOHcU/?=
 =?us-ascii?Q?+3oaIH6bjBArMCcjFOCX8uZVQafcCdNrFqcOmWLl+TzS3kkICLxILDToJfOd?=
 =?us-ascii?Q?YSGC1xHloKRZtFPIkkiOepFTSuAt3c8kSz6WHZciu18C+ZYc+DgpuX3gZnr3?=
 =?us-ascii?Q?3gegk80hqqxh0F/37Ci3D8g8QUz4w4IHkOHkojzjdeDu8/aNjxSfS4Nxk2Yt?=
 =?us-ascii?Q?elnHJqMtmc6sZusr6x5sJ/8Vvz/l32ryCRTqpGMlqUsya7noHJXqSkXo/DxY?=
 =?us-ascii?Q?Ru5yCNKAvqWD84t9fA0y3QlckoHmo5WgKD1pbY5MUKkKnZS28KGNCx2Hbc9l?=
 =?us-ascii?Q?1tkvgh6cUXXKezhxd/WYX1kEOZvNXKffm+GFW3qb5MPscMBMUJVyWAZnahBJ?=
 =?us-ascii?Q?OTISzn0nhTXrOnjPlocIk0hVjFAUCvP/PIbGjLP3jAlxCbm8nDmywsIKjiFr?=
 =?us-ascii?Q?TPgYXJ+jCoD1ZYOtalU9ZELMQpoDxbN+9DNtdCqE4gmmo/EIpwnfMVUGE6j6?=
 =?us-ascii?Q?YUSnMIZ9lX9Qt7tkQPzbTSJ7nln5AQllohUKOsqdlDxkplbja6lh0b06Ljfp?=
 =?us-ascii?Q?n7lht59ARBKjdhb24DIKyZMXNcS/TuCKpAc4i2RRT9W1QeRbBa55+eN2UBJr?=
 =?us-ascii?Q?fog4mur2XmFN1911dt6sLpK5HxQfmue2TseSnZ5AcCgnT8Tdhl7EUJsz6u/C?=
 =?us-ascii?Q?vWMU+RCc13Xnz9e6zeLVkLcRgU5447A0k6TAU4NeTVVh6gB7potiBijaZqo4?=
 =?us-ascii?Q?8hSAqFal+PaT9TxHi9ZnIgW+VFiXfERsS1xDG6/hmJTtoRGinfUKcuCrrFmr?=
 =?us-ascii?Q?gxE2zuSrRMBZij1Md1NVAfhgQPaArV3OWRfE6mjDlcm0bEnMz3YaH5O0tqyQ?=
 =?us-ascii?Q?SU280nCba+3iU0FMMpiCHPcsdf4Gsurn4DVs9RayRLlCs6iEWb2MQknrqCZS?=
 =?us-ascii?Q?rhxoedp3HZ1YaX2tFdbbijY7EXcBSke3Meqhcxd16O/77PuhXuthWxph7VXD?=
 =?us-ascii?Q?b9nEuw5fzJzwPZ/uZCLSTepE76JVo8tIlhcYCxjpn2Np0Ua0Xm7keYJDnodY?=
 =?us-ascii?Q?5Bz273KcKl/gGSmnF/A4LtVNqZtNXqg6cW7p+YpmAIwpfKqDGhjf5U5kRFZs?=
 =?us-ascii?Q?WzEN31AYAL2JBP7aIwSKjZLVfF4nao6Ro8pY99kJtWEWIEJ3Mj4pOQK+x8+B?=
 =?us-ascii?Q?Ta7K0XPslytx4EsWgboXUrGn4/IjNVHfvEHAOJQDEvQPECHW8KZ0a52pzFPv?=
 =?us-ascii?Q?WvIM4DeIoC+nLNOqVvQpr6RyT1ec/8hPFAUCGMgACWfCoYj9IpXmjL+UeN/L?=
 =?us-ascii?Q?sPePkA/CfAuanG2z6OiLtk6/pvUeDe8h/2vA6WxYeNyxcfdskgI0yCjv+tWI?=
 =?us-ascii?Q?VnWRm3CaYRG2ti4t2xzYWtqFUtUZIKyQ5Rkih5PwTprNdb2pc9oJ8V+0z3Le?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1948d06-1caf-40c1-a0cd-08ddc0d59a6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:40.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNopK6KpORVqThVDy6Q6sZTcLBFxdTN6bIpdcKhGFdzubb+XNLymt3YM7/4tkSsz1N8ZSeVviPNkYElBma/DDJx5cLFgQSpgm8wotH+aPfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9352
X-OriginatorOrg: intel.com

Rather than unlocking the region rwsem in the middle of cxl_region_probe()
create a helper for determining when the region is ready-to-probe.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3a77aec2c447..2a97fa9a394f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
-static int cxl_region_probe(struct device *dev)
+static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
@@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
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
2.50.0

