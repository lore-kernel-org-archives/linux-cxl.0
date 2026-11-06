Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793996926;
	b=DmQjiZy1DVx86iTiKYq+bw4JEMNOOp7DmejAPX1Ew9NMC7kJUv/VwbGtbjVJcWR/q0Qp
	 rILcir+vmHznBIt7OpDHILOKiOBXxtYFFBKDoq6dKVXIXp9lYI3nHpqknm9EY4N7EZboJ
	 XUHNwhLVQmzW7wiayMT+8O4KNwQSor4iwhNz683sG2pNfJdnTETkHLaO5RmCxsqDT3GBc
	 LlKj3L+cNswlih/BmeCGeQFq0r6Vk5P45kSyViGlgQdCN6SFznSS205bCgpHLfwxcjzyH
	 JUVG2DQECn2XEH3LcmPc6oxF0YijekfoTGpl/6VG0nynLTmOnR3ss5NvD+FHQxECJSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996926;
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
	bh=sYfU5YSeaUiihvWa8GFxExKM9s7oOLUwpEAsxZXGrQY=;
	b=R+7A6HSjKo+ulHLk4kWsfQNVWgjLNqepGyTGPPTrdu55NUgCrRGKpbHITrSlEBAYJH/f
	 CTOwZ+ukF4rKm1EgG3PnNrIoPfp6EMi/mFJrfa5gNQvgO8EbhnCyrtVj4Jo8RGWPNYaru
	 HbCCuTO2yPe/COfdjGthZxQel2xtQ7rM3DbCCEZVBQRVNuLUrBWzQVnyq03Hlf5naL8mH
	 2IK0sA6OXnFWajUqQgjWEqcBY9ALzFP0SMv0iwVtjiQtuHL5Kmk2Mj31b8ro7p4Z8OvEk
	 4BxURXnBXVcL6zv3f/i1nneJzULqW69GwuWiWpzMCjZIHEshBmu1vr7IQl2ftV+2RPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jBS1IGbd;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69583606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 20:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69583606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jBS1IGbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793996925; x=1825532925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hEc/ZzA7aSa52ukl95NeGbSEWRpxCB+EUBYy6Xff8QI=;
  b=jBS1IGbd7kdWhDv7wmcupeXB2c1pUao//M76AVLCpZynok23ZQuR82hX
   SHPSF6wwyffWj5iIE7EHNySJBLBJZMHUc9yp6n+D/4S3qIQ2xprIFD8iz
   02/l8RhlqW0EzgsBw99PRBvnim38LuAZ60uu047JcduKu58ZQtdpWHA0l
   dM8I2KCS0syUBjDilx6PSSbuG4l2iHMWXSt+821ivE1St25CPmq5yJ21F
   VJkJR8zzpl4lQLxPD+gPKHLbCEUJSMxlWpKyaq51V+R0a8DKAKMk7rZir
   whF0KSo/ptpsKEvAWSNDXOG6BRmtUp0xGQ+5Cvqe6tnl2TM6jvIr2ar5p
   Q==;
X-CSE-ConnectionGUID: aHYa0ZH4T0K5jm2uNefxyQ==
X-CSE-MsgGUID: YM7zzu4pSJSc/Bglqqs3Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2716792"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2716792"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 12:28:45 -0800
X-CSE-ConnectionGUID: KonkO/8WS92vnqmvzwKZmw==
X-CSE-MsgGUID: lVJ/zse+R0SrYxVoh7UYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7408587"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 12:28:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 12:28:44 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 12:28:44 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 12:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxTIzdUD3job4My6d+qEtL3BI2+8sTl4BtyQNyzPC0Cw5hM/EBYIKOA8fkTyhQsxvdC1TIoZ5OpEi+FxOqCqnlnt/LF9jDlTNt/HZrbKDVMVUARCF2IPSglNW4CMLcKMJrTq/XTuTdxBfVJZ2e2kH2pTt8d7fAgWIMVkhsCG5/S0yBFYZ32vZGoNiBLUMCWL9o9ugZNF+5YznAlhJw8yMinJvG/mdNJI9PV2/AD4PE9VXEmvuG/1huYQtctj2jRy0cfAlVrhiNTLw481U6jqL68c4vwbuJobCVVPH+yVFtPHc3UFXTzUKT+i/zxJnLyJCrnPsiJ9cCYCqjUFyTkpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYfU5YSeaUiihvWa8GFxExKM9s7oOLUwpEAsxZXGrQY=;
 b=zNhONLeaXHeK/FgKQsr95VDcpnp750c4IW/0ox2sLZYly2v9t3UVIc5erxftGC69FecRvjQhnPXOGkL9/Y4kxwzo55KE2zQM8Opn+cc01rmj2W1/ldr8JFbApVTCxiM/XfqzRXE+pswQQNwL1u98Jxhm1WEIOf9Ma5L/ZDJQoPuXYGbI+v9JdmJMiSjOeCODN3q4hBbfDWgNIPDCIZB0rDKZFG90sGOTWtq4InPFYhTA6/UbYgV6rZUi8MBVOp8qDcG/YJIkok8zqumfysABLok+fdfsgQYTp/+/Jb2YBH5dTOCBLXoYQYpni63PQFchfqV/F1LtYPYLbn/+LD0cFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 20:28:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:28:40 +0000
Date: Fri, 6 Nov 2026 12:28:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <ming.li@zohomail.com>,
	<icheng@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Restore a target's position from its slot
 after sorting
Message-ID: <au44af_m-9PJPeAU@aschofie-mobl2.lan>
References: <20261103232822.2482024-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103232822.2482024-1-dave@stgolabs.net>
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b88ec4-055e-4ca5-70e0-08df3c448b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|260925021311599003|260925021911599003|260925022911599003|261022115727099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8JSm7u4zdPwmYux/H/ZsGcCIfGd9MYS9FQHxmOqxDESSrX1kn2+HFkbVtpemIso/2wWTdOGcbLeJPHRLXbMCagQkGtnB2ju5dUu8uku1dcq/vDuLsQmJTVOXa6jHWlxAP//4Tr7XxmvhmZC+tyjfi+kMqunhHkWxrdPUXNRxnWzoUy2T+aGtoXXfykKNKbOnt+6Gmif7eBZDZgczvl8J19Pu1iyH2nX+BhQra5hbAOQSv1pSOG6pAsy//yKCsQDWQ1uyZTOjU/TuVsi45nScxdxvFpC+Niz5ofUQNmuLzkxQ06dlyNVc+6rC2fAA2/FA7EATqRQ55WmgqTO3cGXlI4SjfMdif+qvuCz8KfIQ1xbWibXdyqBnSMhPhfwxThKrXP1ukLqXyZsgz4z79ZxFcOuip+lRNvoA2KlkjrLE8l5BItNhB1QJmXekd8zVkdXTUIg5sfGQJtdlSYIyDRvEJGxnjV3QUEYcxqF4REkWmHZX6bLP8gVAyy1I4c3yTNwUOoepVov8xacF1L8Ns5WMnzkG22Uqln4UiMyXbrQJD97TOearhfLpO4LgnfmTDZXMxSsnEQ/ZFr74y234hBwWKfeNCDRrgGtRk08p4/Xsk5423q5vmBGsOm6lTLaVSc+K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(260925021311599003)(260925021911599003)(260925022911599003)(261022115727099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1aRLNOyAqxcvFV98POIHSXuxF5/hTG4pZKGXHDv3TqoJfsictQAsalC7av9?=
 =?us-ascii?Q?zLD7VzVjcXnkyig6blxnVZwAxJJPuR4Yi+PXgx7kdSjcy+usKGXHCzQVvMNN?=
 =?us-ascii?Q?c16iJ+4BME+yVscqT0DA4j1Gh/vJ/vBXMqU3oqr64ZkpBSpMlc9+k1r5n/fT?=
 =?us-ascii?Q?GXWg5IuUikS+ojwPr8YEzMizJWBNp8UPXFetfQ07zsxpgnRcn2FkjlxKUKlu?=
 =?us-ascii?Q?6dMrneUXu5r71MwXvNll8OME7qu9uJFGjynL36WpSWCIRa/DxJQOQKFSNxm/?=
 =?us-ascii?Q?Jqt950qHlckgdACerGxMQH4iX14eUcyES0tDsjtaekOkjpu0QMQhC/oR3fIX?=
 =?us-ascii?Q?8e1GhgcPkC04f6T+1typ3I64uDrIWI3WUS+phjx10Cg6R39JV2d/llzO+2ka?=
 =?us-ascii?Q?EWH54r2SwnoxNpA85+QDAAKa9rb1T9wiBejmzisV9XGS/zqjsA6Pa+m/UIUF?=
 =?us-ascii?Q?j3zyRO3X5gSw4pS8iieTWgtiH0Gmq8y7QciB3bztvhuVrx+3yDTd1GUmMgBR?=
 =?us-ascii?Q?5+kzwTxJNEFE4Q5UESx9R2CVWjO2EOSDyo9BqNVYS+m0TZZ9I1HyjlM4Cpv/?=
 =?us-ascii?Q?XaqqrV4OEtiPJL9YiyQWWoxcVbJfkwa/ooJTEt2WhuLXFDzJZm2NpTTjtoud?=
 =?us-ascii?Q?j8KQC0//brByL+KT+zcCUi5qp+IIKvn7bmeDIVjD1XYkvdcUaX65ctEkBIsH?=
 =?us-ascii?Q?1tQYXKhf+GlAvVTKS2YlIUEV/+rHaT+dM5AQhV0LqRUxEAcqnmpZpr3JEXuO?=
 =?us-ascii?Q?rGZCWpZghDSQsnX8r7yGAhrh0yqns+RTdIMCPTWLKWBo7fuhT8ysHfHnlgXs?=
 =?us-ascii?Q?rEKGthpD8yLlJDi9exMk4k5r6J/fpo4Vg1aoyRgS6sFgQEi0244Op/Fi3QOU?=
 =?us-ascii?Q?d5+HmjpRtFTvZt8DTqpHYsJTgA5rJqibm7s21rIqEFEcGq73JLLP0Hm9yKb8?=
 =?us-ascii?Q?7/H/yfK11hKIXnQuLpP8+v2RlTVURT8BQ+SxL4V59kF38mKhXE/fy9ME93HI?=
 =?us-ascii?Q?Xr/jknwUc4jdo7woEK0kwMGgoUNFUQpNGdmWho4tqNW6bke5zM5HJLRIV5B7?=
 =?us-ascii?Q?DCVijCbhN/zG2/mCeYRBwjpplHDZEoUQ2NnNlDSoLzlGcT8CaOfQ7jTSvAlz?=
 =?us-ascii?Q?tVufiU2gQLe7zBqKG4201jWurh8nr1wNquTSxXUrt7+z+yu4ZicYDXc1ZtmC?=
 =?us-ascii?Q?aKLSZ9OISSBcGA4Sh39aj4D59IZAPfsUEuuOEA3Nw5bPNqZGJGxO/rW1Q2Oj?=
 =?us-ascii?Q?3SxylG6JJUfBLY9kk+1KKMo6i1ZLS6ESi7EJpgsJKVvHCHatuClKThkZPzb3?=
 =?us-ascii?Q?6iGQ1ObW8RDWuPuE3+JfH+gzGin7JQDy6W9D9wJWnYe4Oq1EK5OKINNgwCJb?=
 =?us-ascii?Q?MlI0nkHMxi8qT1eAJ2gcvaaWH1Mh3fN6JaZ8mNKestLCVNxlYGgVGeYf69tm?=
 =?us-ascii?Q?AmDppyYJhg2XTdrozEeCCNp+jWN37BE/Zl1br8zEAcoVUJSBlS74/uv1oFIX?=
 =?us-ascii?Q?2fqy5rMzpIpeudpWB4e1u/ffTxei0URrcukhisl2jzSf6yyeRJ8C5Pg6NqEX?=
 =?us-ascii?Q?W+twjCvL8wupIur1NgXAruo5NfmGJLr1q5RQi8xlYrHmWDUhWMazw3iZqAT1?=
 =?us-ascii?Q?HOU0Dm97kdHxWuKCbaTJ+4tDqefBP5dvI/5xX1chjnZ008Uy5h0JHSsCJ7mE?=
 =?us-ascii?Q?xjXh5Sgn+1nhmNT+tKT3zuyCwtp1aiANSWFJ9XWMU/nml2JMSnnbHLerHb0m?=
 =?us-ascii?Q?TvSi5AG7tJkB44A06ir24ObdtZbLIY0=3D?=
X-Exchange-RoutingPolicyChecked: 5LXRVIOMOb2ExdYius46dn5oC7mYI+zyqOl3hsh73APrQpL/7vLsTN4Jk3sAe2W7IYW479gfbihQoM54gO0UjdufNUzlYvIZ8TBeQkyKBw/URf/IgWAuBOM31qRFCHBtvHQAUXno2DrzfLdZew4oiHQmjgGx5arYooCXUMOgdzVaU8dOW7dfWS0mboGE7B51J8ciIwoyspcTWmSQNCx55Ns1OAD2J9Bc3xtd9dvChx4iCau46e2BkZJVMrPEC21pAfiU2E/11caDdUdv0W1S+E9lwAB/04XzBwCTuY3gv/HrO2s8sjVq9FC0weJebcMUwOD8zAdHkgE6K6pXDHEopw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b88ec4-055e-4ca5-70e0-08df3c448b2f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:28:40.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz3Q6GP6O99RwaoMZF1KFgQ71B0c3vMjzPWw8skFPd0e2+srYCXi9pHipdAqs0aGJ1KoABuqeRfguf99mPeqRIl1P3rv4STu/FMftWxx7iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 03:28:22PM -0800, Davidlohr Bueso wrote:
> Region auto-discovery records each arriving endpoint decoder in the
> first free @targets slot and sets cxled->pos to that slot. Once every
> member has arrived, cxl_region_sort_targets() calculates each one's
> interleave position and sorts the array by it. The original version of
> that function then restored cxled->pos from the member's slot in the
> sorted array, so that follow-on code could rely on
> p->targets[cxled->pos] naming the member, failed sort or not.
> 
> Commit 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for
> auto-discovery") dropped that restore. cxled->pos now keeps whatever
> cxl_calc_interleave_pos() returned, which on failure is a negative
> errno. A member that could not be placed is left in a region it cannot
> be detached from by position: deleting that region runs __cxl_decoder_detach(),
> which finds pos < 0 and triggers:
> 
>   cxl region0: expected mem0:decoder3.0 at position -6
>   WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910
> 

Hi Davidlohr,

I am getting AI review complaints that this fixes as I prep my next
version of the finer-than/mixed-gran patchset [1]

So, it's jumped to top of my review queue :)
The fix works for me and quiets the bots. 

> A decoder committed by firmware behind a switch whose own decoders
> were not committed for the range is enough to get there

About this statement. I believe that if firmware commits an endpoint
decoder without the matching switch decoder is bad firmware. ie on a
shipping platform that region wouldn't work anyway. So this shows up
during bring-up, pre-production BIOS, and test setups - right?

I'm only saying this to scope the problem.

That said, I'm leaning towards asking DaveJ to pick this up as a 
fix for 7.4. And to be honest, that is mostly because quieting the
bots sooner rather than later appeals to me.

> 
> The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
> out-of-bounds access in cxl_cancel_auto_attach()") had to work around
> by walking the array instead of indexing it.

So this had me doing some spelunkering and there was a series of changes
that led to the above commit from Ming and I think that walk should
stay. Just saying that so that it doesn't get considered for revert.

This patch has hunk header issues so I think we need a v2. See below.

With that fixed up -
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

[1] https://lore.kernel.org/linux-cxl/cover.1791863201.git.alison.schofield@intel.com/

> 
> Restore cxled->pos from the member's slot after the sort.
> 
> Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Found while battle testing BI changes.
> 
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..d344bc4b5aab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2045,7 +2045,14 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)


This hunk header counts 7 preimage lines, but the hunk carries 6, so
the patch does not apply as posted. With -2045,6 it applies cleanly.



>  	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
>  	     cmp_interleave_pos, NULL);
>  
> +	/*
> +	 * Restore cxled->pos from its ->targets[] slot so that follow-on
> +	 * code paths can reliably do p->targets[cxled->pos] to
> +	 * self-reference their entry, whether or not the sort succeeded.
> +	 */
> +	for (i = 0; i < p->nr_targets; i++)
> +		p->targets[i]->pos = i;
> +
>  	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
>  	return rc;
>  }
> --
> 2.39.5
> 
