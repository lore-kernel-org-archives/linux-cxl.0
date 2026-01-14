Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564841E25F9;
	Wed, 14 Jan 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412435; cv=fail; b=dTEWLmMRDzV5R4Ud1ZF5jti0X9mjJxi5oZh+sV36PIy29CaQGmhl4X7VKE1SgGv2DdPZ4R4A+ltMM41BG4Oigsu+2/NuTtyCWXpUsaeQeDbWQ//QnC24i3hP7C0WURu74jrpsXC6Rulrk4+VG8QIaTD2VehISZBZ3Cmmc6sMlRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412435; c=relaxed/simple;
	bh=VI1S3jwMEhpiaHFO6Lp7+dzSAS22XA1XDmOgpUYkF2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ThujcLtRBIp6PApU1so0ncKkoyaoPZmClyJ1/2IhQ/cXgBeGw/tCCknyiw1UqF7iPHHdd5190hWGFBEZbMmSn4w1Q+N4zxx0opcnDVUqhGWcLdjTxcDznWU3RB0+EuUHI6nA1wZgH4dNSPiYamNy9eOcwxd2IctCf4jAwh8qrhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kk3mZayW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk3mZayW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768412434; x=1799948434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VI1S3jwMEhpiaHFO6Lp7+dzSAS22XA1XDmOgpUYkF2E=;
  b=Kk3mZayW4mgQCeUGMm/LrwllHlqvr4QII6VIC/rK/M1NzqK/Hbe5LpYL
   qPq+TsKJofyO2fkiEY4D9Nm6vxNEtJ76tkQlQt10t0BjR9UQ3CHayhURO
   1kdJdhboyL9Z6KwPeWERriwoLyR3v82+cJeki3fuZMmQhFurLJg8Vpuzf
   TOszJM2lbLCaW/Cc8ViiLL8Blo9b8SECt3SbthiQaAwB7Kyz/R0U8tidy
   NLyHtGaMv23TA71Ye9kxUrg9LNHdYFEkQBZ9EzlkqMQ6RXpG9csKJG/a0
   IPjJUPMKqwIdSKrpMzxhgpZzS9myq+DYdp1dV1bwrVSNVlc7tMPlMlbZm
   Q==;
X-CSE-ConnectionGUID: P9fgzeJhR1GJaMQxE4TwJA==
X-CSE-MsgGUID: avIiTyxmTiSL8M6wrBYBUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80016458"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="80016458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:40:33 -0800
X-CSE-ConnectionGUID: sBGDjafSQZKY7HO/f+MEmQ==
X-CSE-MsgGUID: YCDtb4dITpKUYnSmv3Ql6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205006739"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:40:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:40:32 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 09:40:32 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:40:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2NQ5Z3WvP0jwG+XGCGG0j6rQckzKD/ppv5zKDvlZb1eg8BiIAEZG+7rmEHhhxZt2wiMI3D+E4eYTeGzc4h3Mq+gTQrYw+XTsDu95/2MMM3BCODlq9Y4PI3gaAMf938qo8hCpkbd4XfERg5jMPXjX36fRNZN7Bno31Bx1rqfIFZi50jg+v4V/lKXansR3iE21DdkDbjfEewtA0Z1r0VM/zO+fp6tsysghlgoC+TQmZOZ/H6JfsE/s0lgcMM68sgavuCzVE5FJawypFSDQNEeemqtVvbC/PCUw0xkIBD3vuesEdzfkB4kVO7wz5qMgaQexQH/Zktx148C59AEPXZPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moCJH1Y+GRqCvIUVvStBKcTg3CYQ21KgHaI/mx7YZgs=;
 b=ECPBjmpDeSPMJfeTZELGICvc9PTBwrzedVYx58gjoJA1wRzRH97iPtyslo9uJg71reb+KsygKOKdVx4444JmQeQRctT4wPKlYSc5EE1dLoxmOUETwCyIH+Z5Pnv4eiRTXWqV3gmXmUZ+YJJmhSswVBgv4Mvgm/sKq+pKl5Qm3THdgnqs0X630v78gQM0nrJvQ8+u/jSHrpX7/11wAnpfVexRLm+dE6LAponM1IVpvFHRPl4ath2Qug4mYNVODq6atZn6UUTwjjDSmRuEpbPfi3+0f0RWn1VNDCPEA4QwyBoNh8nKPsIAEz0hfOzV/cVw9soQMEEkHd4y0SnToFEllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:40:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:40:24 +0000
Date: Wed, 14 Jan 2026 09:40:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aWfVBEnwlcqHZiYj@aschofie-mobl2.lan>
References: <20260112111707.794526-1-rrichter@amd.com>
 <20260112111707.794526-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112111707.794526-3-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 36601ec9-f3a4-4cbc-e84a-08de5393ffa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dXHdCcUBgnOpl4XHx2LxxnQaMXrS1FSIFtJ+pD1Slcgb+hQz/AySGn3l4WD?=
 =?us-ascii?Q?Y9SzuJ6gieqU/VFA7Cc+I6pgbCy/At5gV2uMNIgPjmmGxxSXirq9t1XjhTri?=
 =?us-ascii?Q?gFkhSVNOBJ6uzccMP64E16hMQSNLpKAAM//apROUMYfr78jk1rlc+q04yeAn?=
 =?us-ascii?Q?ONDuOVeqwutV3vzeBPSaHGFx2lCNNGd1Nd9hMukdK3hOOHO1c5dVdIxdNtA5?=
 =?us-ascii?Q?9awsTBoJUYOoNL4vIsWCc3Ov5VKt/DZmavnwPA6IvbU9k8WCH24Zqeu7a7ZL?=
 =?us-ascii?Q?/S5Xs602UiEw2363fGLjsmELE4sHvoqiJMc4sh3ZnX7dUyrL+fzzMrVMwLxL?=
 =?us-ascii?Q?8avZZdUPD24CW2Tdyg5YDbcBxyhE7FdkMlHuRkbDPFNMHjB57sOdHX0Fm7zz?=
 =?us-ascii?Q?zftkWtWy+wA6SSKWmFOu/UJfBACxmnColBiKMX8w8mphRn9PMb9tsa+LhEXt?=
 =?us-ascii?Q?VTyyntyziGxII7O7jYs0gSJD+YR2mNFQkSrSGgZsUl2LCnq57AngvU/8zCoo?=
 =?us-ascii?Q?cX33yek6jPVy3g0A8TBos/gA0QHLgBPZ2Jp1VnX5ydUCrjD3DfzgWWYSYw1m?=
 =?us-ascii?Q?ZxpW9hrQqDxsDl8XnbTE3USkC8igX6hZcm9mkN74W2mlTZJIDDD/xANN5/8m?=
 =?us-ascii?Q?Rr9ez6h4ZrlXsSgd6k0jCyvG9DEXxwwoBmleyk9IXrlSxGZu4tD+DxUe58rs?=
 =?us-ascii?Q?VLY6fVyMIYXWfjkzYKKRPp8N35n7CwYVueKgwYJnt4LB0RqjpRNW4saqyw8A?=
 =?us-ascii?Q?PAzoXO3g2AScr3753LxzsDmGSHl+gR1gSTKahCThF645XJU0ZLVpgMeaxYdO?=
 =?us-ascii?Q?MRbyCPe1VGaQJig4WEkGuj3HsKgMfLqwokqXu+m6PkseY3M1ZTpOAE5HOp5Z?=
 =?us-ascii?Q?GEmYoO1ruvifU8+PQNtR2JwbWyqhkNG2mnmxoeS+a1u+5H1flHeZwsOraLUI?=
 =?us-ascii?Q?FqQda6i/hiuML8kLhtLFLrHGVPQl/JddvnOlSVIcaPXqPsGrxvqROGGY2iI8?=
 =?us-ascii?Q?TOdu8MhWO465jn7JWSjmp2r0Fx8Yahu8C8iC0xa5KyrTfTK3vC1OvxbFF8l5?=
 =?us-ascii?Q?Tq1FRg3arg9ERWKt5RowVB6aXS0MdDAHh3flobwCuHtYo1v2fqKCqMdS+67S?=
 =?us-ascii?Q?4eD2TvQhdADTQOLkeY+JT/CSaCR//G6WOKdnXsyFVtX9o286Yw76m3gj0etv?=
 =?us-ascii?Q?pm2E9FEQ2GDzQrZ5U7o9U4lxjD8UJqm/zYxWp4LU2Ycw9wCDbyriy5rPffof?=
 =?us-ascii?Q?l8C4RpmCNHJUvkTuUOFedpYCz0CfgvJPDUWVUYr01yoGEUMcjHvE2mYK8pQd?=
 =?us-ascii?Q?KzMDbAcFMh8gXuA/CkKu2g+D5QZdgXpSQOWNoc8b93fnjghmdp/nHg4NM1GN?=
 =?us-ascii?Q?73IDr9CvGNzMT+UmUMfI+mluWEDF0Gzgeg1X4e2UBINS/jkD9GVQp47ICUBP?=
 =?us-ascii?Q?X/3E9ANY1EGb0LdsyxyvHbCLVf4DzaCg+0kZ03HbA0Y9L/APJBjWTCMoKPJx?=
 =?us-ascii?Q?//Zwug1gHK0WPRVFym/WS6U8MbpmwD/M572BuIX+URS+ZVkmR2zbgRaQCjEy?=
 =?us-ascii?Q?62t8dsOlD6j1/glg9VqyFt4vvfQ2dV3Aw4R2ekOn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zb2UWmpvT2zyM3pIBiG9gU8/dOpEyU5WTMTNzp/Hht+P1zRplihaACW3EBAh?=
 =?us-ascii?Q?hHE1YJ+4S5OF4eUW+2SCLHRHid7WPqZLWtz+Q0ddoBqgl8XYLOX1XGXdOZl1?=
 =?us-ascii?Q?y0+1xswn+mdphPUI+Rryu2cHXLPELfRgB/5Rx0R75eUa9fJsGhWK3ipXzotT?=
 =?us-ascii?Q?ooumNko6Px7tW84gr0oBdRef393Y3txs2ovw9flIiAnArYzPSyjoWSH/RDqq?=
 =?us-ascii?Q?qdkFGJBfLTiCIPNa0Ko1ECMe9PHkhfBqXqQJ3hp+sv04WT6xqFokIM5I1ZBJ?=
 =?us-ascii?Q?+V3vEOozbanIBZQI1nyA1OjIvMwqF8od/jMbR+5muen7tqjDO79UlhFTzwRd?=
 =?us-ascii?Q?+al09QTQkwaZyJJG4FLrMBNNucawTn7BpGNJIwUYZ18NWVwSm27ddwyCuLeR?=
 =?us-ascii?Q?QWI5jhH1XzAStlnoSRuQzIlFel/HKsyc4tOOmgxNKgSNDlEO9s8vwVoVgS37?=
 =?us-ascii?Q?NKS8ycxekQtyKTZk5jgy4P3izIHbdYCPZpv07ytX21x9S5WiB8Zlz1e7HDhJ?=
 =?us-ascii?Q?vmn66FALN/RkKEumQAzHyV4PIMtHgHN0Qns+1EJho9E9AQ46CcoD0ci2U+N7?=
 =?us-ascii?Q?vh0XPT5DbZ09bAbf4FFsh46L9UB0hsf10D0zahDZ5ZbAGbhvqW0/rcBtO9qa?=
 =?us-ascii?Q?PQqHfODWNBFH+68umQ7OXpwlmcWtPNMLVx6dQKEw9GLz6E+Ie9njKElajEv2?=
 =?us-ascii?Q?qVmcJuGeiR9muQIwyZEiR/kUnROOoAoN+dX5mTyZaU/Cuo+Uk1H8wUoWk4hQ?=
 =?us-ascii?Q?JYj3wNdaqL3/9gg6+KLTuZeBJgpUqOO8r46eGma6TUKcSOgJz5IkDJpz0JXz?=
 =?us-ascii?Q?7YRYO5FLjizL08Q6pla0JXJPVqVfY1OYV9lyoeK2brkLTiFaiFNnuoz9325y?=
 =?us-ascii?Q?mL83qNErndB5SRoHKW+CTziPlGos9imfGHD5sQHK01R6j+ZPlBNwZ45jXPJ2?=
 =?us-ascii?Q?Iu5iKr8/BOJsFL4dyEx1eRPUDbdpONt2TcsF+ziYc3XCB1Y8Y66CmsweJQZ2?=
 =?us-ascii?Q?/gGaq8UtFE0Va/OPkixfs0D88XRh+QQrcKE/570apDjbcO+43xq+VP0A6fCN?=
 =?us-ascii?Q?wy3Pxm5lZgLnnaCBR8+UUSR0drrOHQcP87YNO58gLVulXMqDUno+sty4JsZw?=
 =?us-ascii?Q?+PUHDMRZHu6Rf5ZQgGoHKLspUH45L0Hyfyi01oVzaCErXtNPZtyMXhd2qTax?=
 =?us-ascii?Q?LamVwJ7QqSo+pBt8yKnmq1GKs0M27bCcxeEvQ+9GHG6V40QKoHpy35T6kL2d?=
 =?us-ascii?Q?8eir8tR9L6gon6Zz0yZlGnZwWKgVPe+eJtBxgFIVpYDDx9pN6Bnfp5HPaOYg?=
 =?us-ascii?Q?VnwZkrxQjf8wtIqAVZ9mp9go921e6eQ1SEVl3//abiglRB/QwOh92CVtg1iK?=
 =?us-ascii?Q?MBkFGjH48CR691q7Kq1Xceh0pPxg4Hi351ygfRSIXhYUHGxX4yqkXRIrtpig?=
 =?us-ascii?Q?pZ7gjllr91h5wirQa0YDK+3rbZE/OrlOOsuKyTm6uSThXWWXxvOD76WsClC0?=
 =?us-ascii?Q?TZQ0ZfuwLB+R2fAd5onPIFXOk2F1WUH6O1n53DjoXmKuzs3qToiTgzYVKjLW?=
 =?us-ascii?Q?TuuDWYYZgvzQwJlawKRIav17PZbYYaH9GPAWf4ueV0ZRf5BWJyKbxko9canO?=
 =?us-ascii?Q?lRSz4ieWxxFrDwz9LJfVnUWHqK/qWvcuyPnFr7cBSJqi2KEeC6A10UzEoLdY?=
 =?us-ascii?Q?nGoeJa73TTDwcZxOMdfWwIDu91slYuOnStP0SVv+ww61DF0KN557w6Cikec3?=
 =?us-ascii?Q?5icfjPQtDRen2Qc8vh0Za9mAw6vGFH4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36601ec9-f3a4-4cbc-e84a-08de5393ffa8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:40:24.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnkoKWOm4ojAcyMHl5aMRG9SOWlA3oTkpsqOxB2UxZPQi/KgDCpLmtwh+X4P+uN4r1qzjsjNokqxmbqLpTnjBb3DS20eMwWp9yfVvUd329o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com

On Mon, Jan 12, 2026 at 12:16:45PM +0100, Robert Richter wrote:
> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
