Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792444943;
	b=Yw70KUAq11tayy9FsVFc1XNtIxbXfQTToEw9O/+tRHnKjlMa2PXRAYgNlakMbKBz3+eJ
	 KE3bIo52B68SD0/DXWHCBVxbZzbNgJCtRVssPaNG/k4ilqfIl1tXyx8UoGUQqGwIIq32a
	 q5aNAVid+G7CNTNgQyRcYW7MSwGWhUHHPQcwYpqEwlzwkNG+ao5vp63dG8BOrnO5DFI75
	 n5T3R4cSed9yeDKbW+BqkVWsnTSd7JbjiWY2qU1eXBcJlGdel44A4x3KlC28N1H9Hsac5
	 3f6vTO9U3Gz3Zo20am6xlC5XACysG/T15IIY8uosZynSvFbG1PP+yAK+Jh8Oo/ek67Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444943;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=Fm7/en7wonLkPIDBbi1sX6hmE053ek74lWLi5IZ/qIs=;
	b=mOTfLu1y2Kxt9XglGiAe5R2DwiyKHPO0UIa9dA7nixEV/u4qKE5C/k9pDzS++dgx8P8a
	 8ZuoeooE0g2of4j12CmzuTQP5NoPEYoDznxwMEpigNrdTbxw/gmwoiGs35klhcFkMuTHd
	 +XGOUXCkLqnkd8ZUUNjach7RmtYxHW2bcS/ROvGpWuCN07NGcsbN6ZBIghXxkMNJ1i7kO
	 waMkjr7c/uLbnhaP28ynXJs/ZccVgE1XgdQCHXMMHsTWjP73V836Z47/FE6l+IbHjEw7W
	 qClS6/QxOpgZvXbDb2IKDxFmBdveS8GxkPPq9FjC6rvxhmqrspvjyPApYgNcWO8QuAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h+o2x1I9;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCB606A31C
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 21:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h+o2x1I9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792444941; x=1823980941;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uBEGXiovozFAzhLzmPR4R58E55BELAKYzfWYu7iRFuI=;
  b=h+o2x1I9Wo9TfOBiCzpiRxaXx7pCygE7FGrf3SKsuinTsUw8KGXweYTv
   DO/eI0n1DP2+OhQB7vy8gxlh8iYhamvzYXlneQyTNkXUlkWXXZTKPCTUw
   pOHii/eqKBpF5u9PtfxgPgn9VgMXKfVvdhCUFjhVa7aqMH7uhLSd9176R
   AXc4CuC0O4+9mLQ2J/plMa2xlA6cnkc177yEqFcOPambm4Au9drq6mPJF
   nnInyMCj1W6FxJqI30FxGGgyW6EpAqPu+kSt5lN3LU6qlsMRPZ1pM/nBB
   zgqCLDMTTEpWOlAEqFDMTbu05dMAt8C/dOPvrNzyIstK50vJDy2ftghNo
   w==;
X-CSE-ConnectionGUID: LIbkSfXsSV2YPfBGfFzwmQ==
X-CSE-MsgGUID: CWP7+IhiQb2ue2BTTT4JdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1168645"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1168645"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:22:20 -0700
X-CSE-ConnectionGUID: qvZV9YGLSx6A4M5/w36hhA==
X-CSE-MsgGUID: uug+cqd7QfyQ842wPQOcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3050525"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:22:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:22:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 14:22:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR5sGVCd/e7JC3pGuXk6hAqREwaPs/tSr2W+BSdtezWP0zXftyPIwxyCtkEtRirj8FzCPkrOh5QsUq5PvJ1XsVjQNGjPtRkch0YJhLLG1v13VQtomoXh9QpKWcAMM5PIvrr8pFv2WkhQr8T6SJEUHiNsAL6A0kb3PoEbQozAdGq42C819v/lcFd4K7/G06uuo0jqaah1CYtyn8xmoiPWlWIvhiP6Zensu5PJ02xJ7ZETsEh/ulnS/P8PFRL/bvg+PT9a+Pe+CDOMklvs+EkSvGaf6ltt9axqGH1BWJPPBBxl4Y8NNqM07jaCbS2AxpSxtL+bchTAHWLnqVprIFNghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm7/en7wonLkPIDBbi1sX6hmE053ek74lWLi5IZ/qIs=;
 b=YnOQghBJwkRxO+JrOJ367IoED3HvFWFIPQhtKBMoVTVL1SrC1PVYKiVIkosBGntNqES1/ecHJuqtdOoyvrDCWD+rTGBFT1PhI6TP3r6SbD9ZTgAmKqLIcvh+VxIMxY32ZE0vrwEpTdsv2/W6j5iakOkOv2O9RUEhiYCI/5Y/7VAl+DX2GA5SPQ1LnSVFpbxej7awd7tH1gnegV9qIrtzYFnBVhh5axyPXgTJpnx1qHnLRuhb4pzTzyrgjjo9g+E99MUCFcY3WY5vtwEIurPoL+Sda1liyFAQuO3qIk3uBCfMOfbLdfxz46r41dExa6DiNO/3pPcVv1GHA+A1UnRwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:22:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 21:22:15 +0000
Date: Mon, 19 Oct 2026 14:22:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
Message-ID: <ataJ_b397PDR6YwP@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <ccb2c0974781ec3500c56e82c61eb3026c73d183.1791949910.git.alison.schofield@intel.com>
 <4e79ef12-5873-43ef-a763-47fb062dc77a@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e79ef12-5873-43ef-a763-47fb062dc77a@zohomail.com>
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b53a11-8781-430b-8b2f-08df2e270bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|10067099003|3023799007|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: w8R/638ZZxIuOrOd/tqTruWk0uM/h0klIPTb16PSsc7hdnsgnhaWvd/eYIZJaZBa2CMNSrxZH1cLRteMhYpJTz7ZVaOww5XPH3h+EH3pqb6LjAm/JC8iwFkYb/OP4HXgwujb3C9AssaPsq8weKndaaybnntNcuXewswlKBBTLRC9po6+MSR3smO9Ot0xQ+rqknG5TrPKxBjeS8H8KGI23X+5wfJFxog9+uxVyVetY30iSGxxX9k1R1olhDbja6XbekQ5ojcT0nJqKkGlXdRApVPQK7IEhTU1mYco6HAaTZ1f3YKFqSDstH9SlJtxuRifQK3fJ8hSJ9EELEl9GR+uIBtSPGnUSpD5iHoksvJ5qa4OFsPQxaN5Fd8aLuGubfZY9al2WGit+FtgZP96JJ0LPQR9TyMKpBDa8TWUmI9l9uxjzKUmAr2NI2LdUIeXDY1sBc5dwNHc6HuhweEcpuuF7UpMHJuUqvkkUYK4+UOqfs3SymlAtsTg3MAYs2k2u1+JbvOiABJ+Sl95mE8ECfzjK8Hz5uf/yyDdvU0tVS5M9Qqxl8ZedPnIoyHXvhieTU52tmA52PCPjMUSuJX+UC3UkrfEh17uiUPqDPxTO5riyVjUaVSKpnMUs//P4Ahh+v+I7Y+mOl61MJx8FCv9X2i61M9d+ReLszeMOgXe1hYV3WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9JNTVDcVRGdXRjZlAvS0I0anV2NkZDNExwc0wycCtsMmIxNjMwcXBkRWwz?=
 =?utf-8?B?ak4zeEV0d0xmMGl6b2tXbkRNQ3NGd2NiYzlEQ0d4ZGkraW5VNytCcXpmdE85?=
 =?utf-8?B?dzl2dnZDTHhFNEQ1TldyZGpHOXI2RDdaM1czUjMyNmg5K2Z6aHV2Y2tpdzlZ?=
 =?utf-8?B?cndzNVMyRFpwYTZpZy9nMkhLcDNxMnRUVkJIMUdjWm9ubm1XVGFpRks1OFg0?=
 =?utf-8?B?ZmFSS1ZFdVVQLzA4NFdodDltVkFNTVRNK1hoT2VVN2FmRnhDVnRuQ0U2ak5L?=
 =?utf-8?B?T1h4OTB6TVE4VERkRFRkNG9lSXo3bXViMm1iQUpZdnJpcjdsMU1saTR4Y0pl?=
 =?utf-8?B?aytLV2tya3J6N0JGMzNzT1dNVlY5Z1FIbUVwelUxM2p0UEUwVUxKNVpTOUpi?=
 =?utf-8?B?NklzYlNkNEVJaWZKRE82RUVIQzJUWE16M2VvWFlJbjB4cTdlU2lrOWNnNGlY?=
 =?utf-8?B?dmVOSzNyUDlVa2xVczFPQTBIK3JNcXoxU25qTllvNWkrVXRxNXZ2YzRYZzJ4?=
 =?utf-8?B?Um1hL1JPTi9BTXl3aGdsSHhLNzRhaXJKaWtuNTdLZG1SdlJBSU1yUjhhQXlm?=
 =?utf-8?B?a2N3Y0lDeDF2NDNIUlN4dUZlOGI0cUVHRTdUR0tkY0FlaHY2bisxdlY4Tzhy?=
 =?utf-8?B?YThlNW5uVTBZVkdtc3RkaW94YkFYYlFCSmx6WG81c2tYV1J5YmRnZS9mZlFL?=
 =?utf-8?B?akU0eUlJVEJNVnZveHdlcTFReGk2OUlycVVoYTRyM2VFVFF3K2p5bXlmTmdF?=
 =?utf-8?B?K2FHNk14Ukx5K3dTYm1uVUI0UmhvdVlFeWwyUnJhb1lLbkpyZjFDVnYwbHZG?=
 =?utf-8?B?NWNCajRKWVIxRmQ1RWtZVzVqYS8xdHZEYTdoYlc3eisxcG9vODV5Qm5VQmNT?=
 =?utf-8?B?bzNHRFVJVlVBZjdHTWc1QWMrRjBEZHlreHRaaXQzeEVSeDZOWXVmRmtPU2hq?=
 =?utf-8?B?MEtHc2dCRG1YblBpYVVJMU9wb0RHbkdWZnRSamtKOTlTV3NXR3gzNnI3RWgv?=
 =?utf-8?B?MGFwb0tBdkhBbmhnb2F2Si9LbnRSWCtaeThHSXFqWm1RWXVWcXlXbXM1ZDln?=
 =?utf-8?B?VlA5S1JnTDMxcld2SkQ0WHd1ZWRSZFZjZVNwY2FYNzc2TXBQckNuWSsyaFo0?=
 =?utf-8?B?WTFiclE0WnpNUWNFS3pvait6YUp2ZXVKREdPblNqRHBhS2VDa0pXSFJyZWFU?=
 =?utf-8?B?QzhHTUE0dTJ1cDFRTXIydlRLRnlkYUt0anF2Y1NiQWxCR0VZcVJBLzZ2V2FC?=
 =?utf-8?B?Z1V2VjJwdjJGQ2dvNU80V3BFWk5heE5wRXFYMXc3dTcyeERVS3JickROTmxz?=
 =?utf-8?B?SDF3Rk9xVE5IVE90VzZNYmpOa1VEdGxySDdiZGloZ2xpUHlWdUlRU0JNRk5J?=
 =?utf-8?B?S1RBVEF2VVNCdkZlNWIrTTU0SzQwU29FRlM2b1F0YWplQlBrdngzZ0k1VEk1?=
 =?utf-8?B?bEZEelh6aTlJNll3eXFPOXgrRWxsSHVYZUx6SjNiZXRTRmlUMDNseUZvYUZF?=
 =?utf-8?B?My9ZSTU5d3ZhYWJMNSsrcnZDR3JEK2JsbkdnRVJweUxpNWwwTGZrSkkrRnU0?=
 =?utf-8?B?S3ovZHQxSWo1ZUFLSmZlcGdLWlpaZU13Q2g0N04wY0U4QmVwcHlTUVRXbmhh?=
 =?utf-8?B?VmVDWVRRelpwU2UxSEptWStIb0EvaE9BS2UxbGJoNjEzaUY0MURMYkRjYmxK?=
 =?utf-8?B?TW9GQnFJRFZ3b0szV0l5ZXI2WjRlaUpnd3JJVFFqOWNtMHhqRDlyWDMwV0tC?=
 =?utf-8?B?c0tYVUZUM3BVR3FZQWJqaFg5S0JhUWlqRVVLOUljTTdpM0R1cXZzTlNrL3Jt?=
 =?utf-8?B?aVhOTnhadFBETmNqQ2xLbStkNGlvWWNMaUszRkpvSG1kVEJzZTUxTGQwbytz?=
 =?utf-8?B?eDJvV3dwRXl2ZlVrQnAvN2MrUTlvaFVQK1NXUURlL2NETis3MkZRRFkwRlNB?=
 =?utf-8?B?V0FoL1B0VG1ObGRCQjkzZm1OKytFZ1k0SDF1bXlxTFhZS0VocWpTWlRsN0c3?=
 =?utf-8?B?Zm1FY0FmOUh0eXg4dHQwMGlSUmJnM2g2Ukg3ZW82WHFURVBjNk5oTVZ6TWlr?=
 =?utf-8?B?VmxVSXFhS3lqMlFXUWkyKytSK2lDN2kzTGZrSHFpVGlCeGJsazJLUFRhUll3?=
 =?utf-8?B?a2FhRlBSSTg0aUhVZWI3a1ZEK0VWZEZGNVd2NGtPdjdSRzBtcDlibU16ektK?=
 =?utf-8?B?b3AzbVhpamYzV00vZ1VMZGMvL0ZZdm5sbVc1NHVMQmw3Yzh5T1QvMjRaREtT?=
 =?utf-8?B?b2szZVhOREhjOG1UeXExMitidEJ1eHAwcWs4bmdiYStiYkJhbjF2M25JbWZF?=
 =?utf-8?B?UkdKeW4xbDRLblRtL0NYcUROYkJ1RkpNYmhZclpZMUVOc2tXc25uU1NMQmJo?=
 =?utf-8?Q?8IbFzlYxp8XzGyQU=3D?=
X-Exchange-RoutingPolicyChecked: LMXwjM4CoXSG1H1cft8KKfBU3boXn+PwPtHIhPBU80/nX9p3f612DUkaUUnNhnzH6PnDKfk7XlE5+C8JuNK0RdRlp68LlJxRiDr2Nc6zttCQzVydVAnRhqfs9mMmND6C/CTnjQcGRe32/l5OETVc2902ErUYixViyt6zCepjANv3+9HR3X6txDH08zvKeI7MDvBJlMBE9o/Dkuaq4U80jW5tcK09qDgZTGCa07U2QeMlZ8/qdbb5IJyM1KEI2Bl3fDWNBsYnAk/ggMKcA/L4V6iBC6LKy+EfIDWGGsnL9B/O9jPwAAIEgOHMYAEcXYA5GjX70pu7PPcc3MbNg/9fJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b53a11-8781-430b-8b2f-08df2e270bf7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:22:15.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP5TeXqeXYoAxPFVqsTVi0HzQJ9PMugvmrglo+o8h8bB3OK6NXjP1v6mPvqGKRta0ZrnOSd5Z0UgexdOCAsbITZpoSjb5y61ONWf9QERfEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 05:37:26PM +0800, Li Ming wrote:
> 
> 在 2026/10/14 12:17, Alison Schofield 写道:
> > cxl_internal_send_cmd() validates mailbox payload sizes, translates device
> > return codes to errnos, and checks returned output sizes. Existing cxl_test
> > coverage does not exercise many of its error paths.
> > 
> > Add a KUnit suite that replaces mbox_send() with a stub transport, allowing
> > tests to control transport errors, device return codes, and output sizes.
> > 
> > The suite covers command forwarding, payload size limits, transport errors,
> > defined and unknown device return codes, background commands, and fixed
> > versus variable output sizes.
> > 
> > The unknown return code cases provide regression coverage for "cxl/mbox:
> > Treat unknown device return codes as errors". Without that change, the
> > tests fail and KASAN reports a global out-of-bounds read.
> > 
> > The suite uses the existing CONFIG_CXL_KUNIT_TEST option, allowing it to
> > run without additional configuration.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   Documentation/driver-api/cxl/testing.rst |   3 +
> >   drivers/cxl/core/Makefile                |   1 +
> >   drivers/cxl/core/tests/Makefile          |   5 +
> >   drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
> >   4 files changed, 258 insertions(+)
> >   create mode 100644 drivers/cxl/core/tests/Makefile
> >   create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
> > 

snip


> > +static int cxl_mbox_test_init(struct kunit *test)
> > +{
> > +	struct mock_mbox *mock;
> > +
> > +	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_NULL(test, mock);
> > +
> > +	mock->cxl_mbox.payload_size = TEST_PAYLOAD_SIZE;
> > +	mock->cxl_mbox.mbox_send = mock_mbox_send;

	mock->return_code = CXL_MBOX_CMD_RC_SUCCESS;


> > +	test->priv = mock;
> 
> How about adding a line "mock->return_code = CXL_MBOX_CMD_RC_SUCCESS" here
> to explicitly initialize mock->return_code? It makes easier for readers to
> see the default return_code is SUCCESS.
> 

Thanks and agree. Done like above in v2.


snip more below...
> > +
> > +static void send_unknown_return_code(struct kunit *test)
> > +{
> > +	static const u16 codes[] = { ARRAY_SIZE(cxl_mbox_cmd_rctable), 0x100,
> > +				     0xffff };
> > +	struct mock_mbox *mock = test->priv;
> > +
> > +	/* Codes the driver does not know are still device errors */
> > +	for (int i = 0; i < ARRAY_SIZE(codes); i++) {
> > +		struct cxl_mbox_cmd cmd = {};
> > +		int rc;
> > +
> > +		mock->return_code = codes[i];
> > +		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
> > +		KUNIT_EXPECT_EQ_MSG(test, rc, -ENXIO, "return_code=%#x",
> > +				    codes[i]);
> > +		KUNIT_EXPECT_STREQ_MSG(test, cxl_mbox_cmd_rc2str(&cmd),
> > +				       "unknown return code", "return_code=%#x",
> > +				       codes[i]);
> > +	}
> > +}
> Since we already have cxl_mbox_cmd_rctable here, should we also cover the
> existing return_codes that we know?


The known return codes are covered by send_device_error(). That iterates
thru the rc table and checks the expected errno for each entry. SUCCESS
and BACKGROUND are covered by their own tests.

The unknown return code test exercises the new out-of-range handling, so
I think we have the coverage we need here.

-- Alison
