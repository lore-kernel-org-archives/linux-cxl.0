Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13623F41A;
	Thu, 19 Jun 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309477; cv=fail; b=ml/pmp3Z0clpWU/R6LTctJ1B4MKhjlNh2ytCPnKXIiqIdL8WGfyL5ovPwqBqOUkv4qBADZmzqM0+rwfs2eWU19HJ+wH84ktj18M7P7w2bqiGNhFIWK7RsFOJfmsixieMeVv0QyKGEptbPjePNvjoLnRbkUKYL7X8L0YtiHc1Ma4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309477; c=relaxed/simple;
	bh=qqz99tpXxQ1FnaJimso3aN4G7/qT2fk17WTtawTwdZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHZm3jLv8MYN+nTusfC/M0nWUFTULhGhEX6bgoB1JLGDj2WZzX/iiOKq07VTWaCH27HkCogwEmFRy+TdwbHAflRqjrPkpP8qsrX+o0Y1Zk/uzJz2evZcZQVbr2s7o1ZhoJ7u/273fQjs8gLodFrFuTsmEfM5Pq2xl1lJEJ2WlYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbYMJf8z; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbYMJf8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309476; x=1781845476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qqz99tpXxQ1FnaJimso3aN4G7/qT2fk17WTtawTwdZI=;
  b=GbYMJf8zpgsr4v/6/NVUIFPh9VAYotw9aJHsBXi3BdiBrmbPgNeIDDHQ
   eZvhmP+gh5/TiLeXi56jBcOJz+Db6i9V+7mfm6Mi3N13EVdDDUO4ODZzi
   Kf7czXxYP2zT4ioRbZEZi2N6hjf6Dz257wexLRSkWan9IG78blyuuRqCe
   MYw9fMRn2fIwPishm/1chwa1kHX9+H7ujkdva6xw179ktnDcWBxOw3LlC
   2+7XXjM+D1onuTQBylTl51OrxDEziSsdT4oOfhbAZg4lJpt1cnmlD3IRa
   6IM5oByPw+tSDoJdFGaLXLDXJqdf/0Ij5oNY8nBKobHEHIflRfGSsRdtR
   Q==;
X-CSE-ConnectionGUID: nBF9m1T5S62xVmhWsmXzfA==
X-CSE-MsgGUID: fS9PDD2HR8a62Nec2/sRrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55181531"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="55181531"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:35 -0700
X-CSE-ConnectionGUID: 02zHG8G7Ro+FjjVP2t06hQ==
X-CSE-MsgGUID: tm6LYAICSjeXona6R7KDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="187666900"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlqGsgSKEHIRQFE15AVS80VVd50igFWbogqfGLmYVdA/TsGP1X4cKqJeugXprnJMUVOjeUUh6aMpGLx4NLQQNav9fWIeivHuQlAN1+x2VdejePeJTVa/Chax0hTq+EWiv2yFxOgDsnOQIppFlB+G/apvTToQQkDVrAVPJ6YoytyiGn/avzIPV6SH8yQoL/3WjlIY0baFK7LzKFmEbIiYOOeg2WQmNzD3Zx2Wbr/etN9yco186BVHLklHFc2WmOsPWJ6F/DLFhJVAUygQDt4Eh15qDXsC2cYXDjz6vJaYtrIJCZGcBE5gwHQ01VgZA2Y/qcipkewXqh6cbOd2Yp+G7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9xTOPKypWGU2HxVBxthpkxuNtnMXeObcTl34FnkjkM=;
 b=egGtq7lv5smF2EESiQgPUAK8zDfnRzWC5zUbppWbTEszFgw1JMwBGeYqNqXNIgZlO3erWIh4J3yi171m06uOCpa3MWt3v8bt/6C9emde1p1VaqVr8jEWnpTvZkR1cxdx3IrcDeHXw8XePhdA9EF8DgN1St/qoO/uyJx7pEcwRzzD8Xktwfd689Gskv0WSJfGDEQcgyACEeIoskLuqyeq3NjJp8Gev2Z0uE+iIAs3g7yEQ/Bdp5pTiC8bAicbFVLZMCTmlntLmhlQIeF75yxqZarZFmUIbFxrAs6uX8mM2B9VcqrivmZmJwlRh59HtBc8vz4TqvR8LeAMRW0foqteGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:25 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 5/8] cxl/region: Split commit_store() into __commit() and queue_reset() helpers
Date: Wed, 18 Jun 2025 22:04:13 -0700
Message-ID: <20250619050416.782871-6-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: c27d6c30-46d6-42d8-7dae-08ddaeeec2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRyTXcYtT9EJYRkB8mA/gYqZK5b0l+v+3eNadoEK4lFWcGsQWCuOvPQr4d6d?=
 =?us-ascii?Q?m9L7EmQL7+QIblMeEjeZC0JV8KEZ3cMLjIjEHaz7RtTAhAo/2WEl0oxJWEuq?=
 =?us-ascii?Q?WKJED3mump8sbzpsSb4RSWyyHeAO36UB+G82g+nPuAmrF+V/De0x+CvMCZuR?=
 =?us-ascii?Q?F57Q+W1dKswd4XjNUcWrHWnoADYnYAloCMKnj6venf5tm+lrcWRpYwYgBE7M?=
 =?us-ascii?Q?j8upg2B1ZTsoHdyvFbfFnk0Yq/7wpiGsU/6OCGLz1wwwExS8U9BTBzVxGsYn?=
 =?us-ascii?Q?CWLQaj2oooGhLq20xrvf+g8KtUj/KXBJBX74GNL5By2WmEz88culJqqLglB6?=
 =?us-ascii?Q?WFGF839e9h99Sih+6a8gZGgUpbxnzKMBZAArSmx0VEumAoytgDsu1G7Y9mlA?=
 =?us-ascii?Q?kcMzFEVSUxikXV0irVWMUNx0LBVLw5cWAXJ9aiGqAr6FzmmbbCBlsD36sRsB?=
 =?us-ascii?Q?QfEuywNil4qQCpA6nWUKxZKnhsoNiU9OQ/i0FSbNx44WNoemSLIDrZx7U+9L?=
 =?us-ascii?Q?Jxp51KTkFMhMv1uGmP/t/dHOLwFqDyeWJQt7vWdfSougD+FjqrAmCHNu9y5A?=
 =?us-ascii?Q?sk3qWDgvaydBW0wpxMlgpJrFrFI/KWaOYtCZ/TA51fOjFslknoButE64sHjY?=
 =?us-ascii?Q?ClyVGS+mtZ2PuThqj2yMk0bOvZzew0rlWy50cNQEFkIU8kZKe6SZqdm5qnQq?=
 =?us-ascii?Q?GPeao1extfgWCZlQQqR6zKOXt728lN3d1/HxODKM7t0kCIPbatlljeQJ5euO?=
 =?us-ascii?Q?eUuQ39E4crY0li8D0DYGoWk5N2OOWzJJn1jFTHDtyYov3dS6Ws5h0MZe5A6A?=
 =?us-ascii?Q?8xWy1Bt31PoC30hlWe4Zrx4n9uq3B36uRUYlS+XS+s66cBV6CVjZRHHY++H8?=
 =?us-ascii?Q?SAYQe1KxcjqJTNIpcrnT9T3lhciizhgM7M2Otze3KFm9xnnFkGURBbe6zQUK?=
 =?us-ascii?Q?Mu3GlV72l+WcITUJaRPle4WCBPv08SnH4ggA7UHy+QcAob/plrKOLfrLCsyW?=
 =?us-ascii?Q?K9aOBJoaQ2VR/nO9G2WU+huKKJOLWziPe8pZnaC8XkmVcYbgHKE/iz/EWuS0?=
 =?us-ascii?Q?hIz/juVzzdLq3qPYBA15pyyKHDqQ0Mtw7ADjBgYZQbN9y+xnK9m2+PI9Yr68?=
 =?us-ascii?Q?n29HmeIh359W+BBpjKavftENl9+4Yad6rd81FCyzxZP9kFEkkN0OIQ8ChC6R?=
 =?us-ascii?Q?DXyc1KicoprShgMF+v2cL3Fsn1dxMoZRor5UngyZB/boBlKRsVvDquldLDQQ?=
 =?us-ascii?Q?oez3m864bdjAJhNUCB3XTeWkfusNNjwZIq5hHg+6YKaACdpul+a66/vdLSPo?=
 =?us-ascii?Q?6HXk7XE74LqkKP42BMHNTrec86r1Bl05gpz5nQG4n5yzirtSXhitwqLQ1LPo?=
 =?us-ascii?Q?kzU9osTuo5lCEshm2Ryz8RQaXT+1sIbuNy2Df/x7laGNheHBfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wq899Z6wLhiWgrHU9dzexnogQVeHlb3t3Fe6ffQzR9/vLIkT5y3tCYGmq8/M?=
 =?us-ascii?Q?GAGmtPY4toTZxyxgTcGF6CWkPjkm7WynR2PBQDzuIE11dNPmSJCOFc0M96//?=
 =?us-ascii?Q?JJLLHSpKS1ZbuHCtrWM5ObtZ+sabDHZszjy3RTXOGFXfu0GoxkFBGpe65oqz?=
 =?us-ascii?Q?1U05ZZOq8OCcloTp1H1NBztcSxtxTHKvOI7layIqoea4lYunQ11WIvlkeVXB?=
 =?us-ascii?Q?9Uybw2kG+nzscRrw3nNKFzflgrOK8sgTTTFSl+i/MJy3QMN1RVU1i5wMnQ0u?=
 =?us-ascii?Q?4J4JeyXF5Qnb7j3hdy+UXFUnsL4BgbQnoxrE4S+ROa7LpL7pz39dGWZOzExE?=
 =?us-ascii?Q?NsR/C/54BR6OJa5PVwXUd9/Ebe/8XHuCBFewKLXzY8yDLj4MAZYOVBCK/reo?=
 =?us-ascii?Q?7Wh+fRPpGziX7poLyR5iOr/EFO/ZUvcxW/ii8rDb9N69n7a8ihis2ADvb9EL?=
 =?us-ascii?Q?a9o84SqwkdMm+LBOP97afo0Mp1xWPQ1bum0ANAd+o2ictQL/ZV8kz9jyf94b?=
 =?us-ascii?Q?R9OgU5d//TDc5i7VuJKJBnNoSvwtmJfcnuJAV0yYOR1PjsbHtF03S4c8eHxP?=
 =?us-ascii?Q?NvlCB/LLy1nOqDGsCJfhauFX8gPeDm0eYBcOnVo59ckRhcLewPPGPizdQFHU?=
 =?us-ascii?Q?7SuZcg7EpBt4UUnwKxDPEaDOb7y6k+HKcI64uDe04IbzgXDtgddQUdp9+b0u?=
 =?us-ascii?Q?Dmrj8sH6tJ9WBIV0bNCtwr/ljd7Sql/MZrSwIP1vJL9hl6kpRPclm55PAaIO?=
 =?us-ascii?Q?pfLoy2piyflKKXkCgJ1SzUYp0mtFqHns0D1mEwoLIn+NXZcr8ELBHv1YGrhH?=
 =?us-ascii?Q?VB9Xl5s7NHi8x1lOF9b5JD+30D9E+guAEXaUnaJUsYUxx+Ly8vSDXwUJxhIi?=
 =?us-ascii?Q?KKQZrUR8Wb61HDrzj15RltFfqf8Qlo2yT4ZrqUy3V4EaKEjaBEHK6AnWjeg+?=
 =?us-ascii?Q?21DtSATGbsdIBMZHEnA7w48bCT0aXTFcJZlCF0ubnyHP6jfckE79A7whe4Fg?=
 =?us-ascii?Q?f8a6DkDunX0qGtV1g++dhtONheDQPHV7AI4xYhJOXnbzYwn/kJDoeY+QbNdt?=
 =?us-ascii?Q?7i2wXJasntLBk4WSzWcPjezUraMYY8Q04HKxLDs1RjrPW6A1vsW5aFR6tnSi?=
 =?us-ascii?Q?WIvDXePbO2gepWcEAMN5SV2Rw5ePOyTmzpxhYdsye5N54j22kRt+xRQ+qzVa?=
 =?us-ascii?Q?JadDdw9nVl3LfSeA4gUi7A9KLzB8w3zo0CtwwEAbVb0J7YbCl7x4vnQdPuxs?=
 =?us-ascii?Q?3E9wsblaKak5Z4I7sbxmAeBMC/D/GvBV85RwkddOQBOv3FNFQCPa6dHpz4pi?=
 =?us-ascii?Q?CuVkX6AWDPXrRAINzQUWh7pPyj7HD0dqXkiscJ6b55XeKVSgGTZY1bwa3txk?=
 =?us-ascii?Q?4oI4JDOL60exnPaebVpnxjAqlmup86fvBIpsH2WqfGhBG5jVZJiafaSO2ARr?=
 =?us-ascii?Q?2zu/yuxQOmiOU/U+zmQPq5VMRjk1F4x22tkn1ZTpYtMZyiOmILHxchcykkHF?=
 =?us-ascii?Q?6wTRbBccnv/aolS5z2LNBvr6ltvf9MNhqHG5Zj4K8SMXYZQLz38ac1ca5wI1?=
 =?us-ascii?Q?3+IjpipR4fIF8UmpHMkBTyUXANP4CU4ONe9Pp2c0fthPtCPBEwJoY9CNAdUW?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c27d6c30-46d6-42d8-7dae-08ddaeeec2b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:25.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz2BkbLbmFEdyIeglX+P2VMxO9VNcE9sAJxwpqSKgxWH9lwyHZRwasJThwfepYUXNWrPMjKPh6nZ2fp21Fbl4IG/BLA505g2INzDfoyBtjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

The complexity of dropping the lock is removed in favor of splitting commit
operations to a helper, and leaving all the complexities of "decommit" for
commit_store() to coordinate the different locking contexts.

The CPU cache-invalidation in the decommit path is solely handled now by
cxl_region_decode_reset(). Previously the CPU caches were being needlessly
flushed twice in the decommit path where the first flush had no guarantee
that the memory would not be immediately re-dirtied.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..3a77aec2c447 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 	return rc;
 }
 
-static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t len)
+static int queue_reset(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	bool commit;
-	ssize_t rc;
+	int rc;
 
-	rc = kstrtobool(buf, &commit);
+	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	/* Already in the requested state? */
+	if (p->state < CXL_CONFIG_COMMIT)
+		goto out;
+
+	p->state = CXL_CONFIG_RESET_PENDING;
+
+out:
+	up_write(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static int __commit(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
 	/* Already in the requested state? */
-	if (commit && p->state >= CXL_CONFIG_COMMIT)
-		goto out;
-	if (!commit && p->state < CXL_CONFIG_COMMIT)
+	if (p->state >= CXL_CONFIG_COMMIT)
 		goto out;
 
 	/* Not ready to commit? */
-	if (commit && p->state < CXL_CONFIG_ACTIVE) {
+	if (p->state < CXL_CONFIG_ACTIVE) {
 		rc = -ENXIO;
 		goto out;
 	}
@@ -385,31 +397,60 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		goto out;
 
-	if (commit) {
-		rc = cxl_region_decode_commit(cxlr);
-		if (rc == 0)
-			p->state = CXL_CONFIG_COMMIT;
-	} else {
-		p->state = CXL_CONFIG_RESET_PENDING;
-		up_write(&cxl_region_rwsem);
-		device_release_driver(&cxlr->dev);
-		down_write(&cxl_region_rwsem);
-
-		/*
-		 * The lock was dropped, so need to revalidate that the reset is
-		 * still pending.
-		 */
-		if (p->state == CXL_CONFIG_RESET_PENDING) {
-			cxl_region_decode_reset(cxlr, p->interleave_ways);
-			p->state = CXL_CONFIG_ACTIVE;
-		}
-	}
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc == 0)
+		p->state = CXL_CONFIG_COMMIT;
 
 out:
 	up_write(&cxl_region_rwsem);
 
+	return rc;
+}
+
+static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	bool commit;
+	ssize_t rc;
+
+	rc = kstrtobool(buf, &commit);
 	if (rc)
 		return rc;
+
+	if (commit) {
+		rc = __commit(cxlr);
+		if (rc)
+			return rc;
+		return len;
+	}
+
+	rc = queue_reset(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * Unmap the region and depend the reset-pending state to ensure
+	 * it does not go active again until post reset
+	 */
+	device_release_driver(&cxlr->dev);
+
+	/*
+	 * With the reset pending take cxl_region_rwsem unconditionally
+	 * to ensure the reset gets handled before returning.
+	 */
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Revalidate that the reset is still pending in case another
+	 * thread already handled this reset.
+	 */
+	if (p->state == CXL_CONFIG_RESET_PENDING) {
+		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		p->state = CXL_CONFIG_ACTIVE;
+	}
+
 	return len;
 }
 
-- 
2.49.0

