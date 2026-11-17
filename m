Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953078;
	b=B/Z0QG6xv/f9XTJux0hoLOyn/HOV/VXO5jCd16EJ6PEgtc7HZwwab4PF//JB5IK74cj0
	 RazP/ppqokakSkt6ot/KONSaxC3Xl/Eaa0IKYwK9W3he5j7BCm2C48OoWYSkgaOvHGbmV
	 hfP6qkbQLwC4BorLULX5CddKKC+hXSl4f+WTMoMnuoPqW2jB257q1hZU8VqmvRtoxwx4y
	 LDM+WI+eelnp+gUWceixwFwT1Q7/oaxTbY9vOQkgoXwcBRUxHuyeJ92G1HK/ZBeg2nqWw
	 LPpFbkMeDo5ASMezcRB25TulSq4dhBD2xyWAawcnfXaakv/BlmFr5+hq6/NxaYr8QvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953078;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=xPv2cqWWzoab3TZx5O4paVY52RXnnc584WpWb/zdiYc=;
	b=1P8Nsx0pPmA4IprG/34/qOgZouoUuPMZ4z3OjOeokelxTbM5vKYAPGNjDy3PPHaS+ho6
	 WDdA6l5e+nMjZvVDOvN6Hk3+7dvhcDejgghXZs29wvrldCiZV8UfKRnpreBQcNvzVwj0j
	 lL5d3bZcdfDy+tllENITsG5CkHq21VxznZD3vGAZJshPiDJwPheCE1Ig814NYB1NSlKsW
	 EZptARbwr/8DVcSR4SMNivpXVfX3RXpGUr4FcES82um9R4gnoMi+GDN+ZY72y3DbO6MwO
	 VCpqWAJ2aQwtIElYigZWXbQZ7G3Dn/dw5iW6O57qz/k6AKnPTj6tDChSA9F5Fqs3UhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EoY+fir7;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=abCoSkWZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE5606A32F;
	Tue, 17 Nov 2026 22:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44EE5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EoY+fir7;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=abCoSkWZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794953079; x=1826489079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6cF96WX9MeYOwFXO7D8mO5Kl/ghwfScaZAtDrOVUlR8=;
  b=EoY+fir7xfg0AUHXbGY6GBDKeWN9XL3qEY0s9etwZgW8vMim4SJLAKrE
   zKxNncm1Lv4VJcSlwg2MSPl0Q39gmgVjcDOfgXN5hF10YffTz6Zt830uX
   83VAx9Q0qCyX3ZpHbc75fxA3noLuGiGROW2d//lMXj95ILqTvaZ1mNjU1
   Ftw3aE0wrcgAeQWip78Yvak2/DuvB+71N6EFZTVxPT0gl6wf13R9sOj24
   7xBrY4ksTFIPPUmnctbRIIn44Ea5ECAeEkzkI1rg8pdxXisS28gZeCUIZ
   WPkbAngZrpJ5djWZr1OSbQ8YDpzo4AGnl4JmHvTLX4g0RjYNJPx+hHuM1
   Q==;
X-CSE-ConnectionGUID: 2+jDVoMfRcyHI0/WuefHaQ==
X-CSE-MsgGUID: tCy7//JnQLiCjQ4KCnXOIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3734587"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3734587"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 14:04:38 -0800
X-CSE-ConnectionGUID: 8cR5eLBWTwapOArgvdwt8g==
X-CSE-MsgGUID: DThtcng0QMST8EeYtxrCZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10323137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 14:04:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 14:04:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 14:04:36 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 14:04:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+yljxYMETOs7NIhcdnFWxKgzo2584cUfnG3eI/XryuezJ8cnh36EHR3ZLlz6YikqMaOSO/m5DpL8ltIQ85CcjkWusYfyGFUDE2PCO5h3DG5LAWuxmJU50gD9RwTVKOsJUuxa1vBwe5EK9ZlGHiUZIPA9tXvL/abXOhAU2C+h2ywhZYY1ccuy+RcqyAPd9rzvs67q9uK5AJkYr3TRSS6rMwT02m3BPcjnrMfPmGq7VB38NplMQJateKCvOo2vE0O1Mb//rLmR0aW3OiEXUSIitGGE7C4+IUXoH2J8t1naAi1Z2fk+FhE3QpJVKudnFv3kQ47eG7Vc8p4Mk/Rd4x9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPv2cqWWzoab3TZx5O4paVY52RXnnc584WpWb/zdiYc=;
 b=TOu2kexCbbVvmmgFM0nmuF45v5Z+jnwPr0Atfu8Yce7ty2w6ZpZDlIBGPYBNYP7spYIHWJKNJbsCkILY7BFH1b7iksQ3TFOMbZxaGvBsB3AIGdDIfwNj/JlFPrxF8Cw8SApLCsj4HEb/M3UR3zJfLFDBVdsOri0fsaAqs+UozZ+r3iImZ/Xeh/t6YURCaTQ7SY0Kaej6LIHNu/f1yKXBIrzD7q2JgEtafd7eKTwsxhG+/CgrgVPj/SEoQSff4gQNJch2A3GQnIgJm1oySjShPIddje/g9XKT6t6J3UAJOQVXkYuEp0y7VsEBXaj5PbR9lTTqNpaTBVtF3AsAl9Lgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPv2cqWWzoab3TZx5O4paVY52RXnnc584WpWb/zdiYc=;
 b=abCoSkWZ3KrInaGgZtOU2xfPWYH7YediGOm0Pyly12DOTHSJRgQN6UK51uZJjxRP0BdaHz+BOGtVl0N+0ujC3NAJ217J7/fIcmbcO2fyzbdPR5NSr7s3GwYX/6tMeIeIfsaFrrZyNzNB9MpRW1XVPtRWzP5QPSg3h/7Gbs5BV4I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB379370.namprd11.prod.outlook.com (2603:10b6:208:61f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:04:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:04:35 +0000
Date: Tue, 17 Nov 2026 14:04:30 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yongxin Yang <yangyongxin@kylinos.cn>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, "Len
 Brown" <lenb@kernel.org>, Li Ming <ming.li@zohomail.com>, Robert Richter
	<rrichter@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] cxl/core: Create EINJ debugfs files regardless of
 EINJ init order
Message-ID: <avzPbtCq9CedwCZt@aschofie-mobl2.lan>
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
 <20261104061256.1449275-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104061256.1449275-1-yangyongxin@kylinos.cn>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB379370:EE_
X-MS-Office365-Filtering-Correlation-Id: f60be111-acaa-4ec5-87b0-08df44f6c3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gMiCVpP6qTImLFZhiqLUf1Sb/C1eB/nm26oo1ON4a+qDj1vxKLRvcGkfKjXw1c3PaPqkf8Zzx1LlMw5ycRlVTLmcSL3wYNhq5ubSJ/rMESFR8bPfjmXSm/xcwPxVXvN65KujIm0GGJtONvGa/osxoGLEOefu85uIoJQ2wNMXWERfbd1RcM7QUe62yHNbSIcRlbHHWDUamHZv3RQ3vca+yra/FyN6RJeWUbjZ1Uv9ji+ES56g8Alt+IECcrBy08PQMiRDlhYJoHZ5eLpOxdtMGtX0X4/JFBFi4XzUvvMJoKbiBYdA8AxTOwQeHVkvGONHPbU9GsUCDazQRldDSSe6bVT8RAJQ0CU1QuzRJT2ybYEYVBcvt/WdVKSQiGUN0UYz6K8lQvzpB5aROzSeYQjrRjp/kFpQJyG8AZhR0cXRyFzRoxp1ff195wPZsYDrQuDJdimIg6Izdk/FLVCEMmYcFHuFI+0GaLIWtdNiQCueYJYQFzO+BlbmBJCJb1Wassb9vfdDdTAYO1VY6HNpTWkEU9++7gPMS6vjrF23ArxXDaj3yRhd6gh9r0SRmn2ekHbe127tvsodmPULxXTr2LGonlDzbqQow4e/hKFGl3jmi0oy4IN+h4sqfhPNx4Ff7SKK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8agRACI497XLVZpkRE7LZklSIC/6Vr1FpWeidJnopI/4jmGsZ50ra7w5oi8?=
 =?us-ascii?Q?T8xXKqAs9Ax6r811rgB6jK4rX9epfdG1mv29/vuM/lweqdhIERrKqGj0WEde?=
 =?us-ascii?Q?JK0cIb37udtY8QrOMKF62rzyDtHrwr2x9A3WIfN4zSrkD1mGMGIfWgZ1J8/s?=
 =?us-ascii?Q?7C+T5e24dl5DEzXc20zeWOyaTlA011EBdpsPwrtHCTWTbwF8SzkKEUbkqdVo?=
 =?us-ascii?Q?DpZR/9H+zk2j7LbGjw2Bzn7oEgnDbEG9WqxPLJa0LlM4FepGetCRIp+zUIEE?=
 =?us-ascii?Q?K+Cg6SYotNxqrR65A0PXQPTlV6ICb8BxV5Hqht9zDS+oSC6/t1jBT/CyQlQY?=
 =?us-ascii?Q?MoTpKKiSAHiycMb9eI53uopU7PLkUhE2t20HhyFuCrzAXccIqOTx+tqKTO7b?=
 =?us-ascii?Q?KyMiXk7g4nNQB6MiBa4SDO59n3lrliYCCH+wDmVrDwsAtwhfK8Xy2NjT5Yyz?=
 =?us-ascii?Q?5ft9vVNb7p7zJZRhj4oYl5yFB4uES3+BUgoxZ/V2WC9ZFhw72sHGjEmpPd7B?=
 =?us-ascii?Q?u4B67kKvHJL7tqSdJGbep86SJ3FfNm1zYkutlK2PDSWoe8oMsip9fVOmPdul?=
 =?us-ascii?Q?xn6OD0jaArdtFm8P/1jOHHebhA350UAfSqUlSSbDFiu89GFdkFluLL1oXcXf?=
 =?us-ascii?Q?NSmjdE/nlGemuo1yA/qlUXSN+OBfB72FwgsKSHCtUqRdeOSXrvy7Ltl20Q3W?=
 =?us-ascii?Q?lSDLMmb9L1jp5/zFxSRwe1T5cqo0Y62H9xXcaLG85cK2nrfDZXh2QkEfDV8L?=
 =?us-ascii?Q?lMZBGTJz2lG/2iUuv9YZBcu7fhPhVydDzqtvcs3ORWeeZhxiNxBm2EtkjSWE?=
 =?us-ascii?Q?POjU9y4rC+OV5cpafWC3+1eiLrHCv/ZZQ+d/bSPVIdN+6JFIVgcSUz1bJ25E?=
 =?us-ascii?Q?NJYZ7fnxMka9gZhPWe1ln3G2ii7eDFyjwWtxHu9BtM24tlKnAbWKEESvYS4q?=
 =?us-ascii?Q?HiQY8EE9EE/TcKJLKDi3wh7lFQRkpN6Poy4QT3tFEZdC0VDsGv777gi1oPM2?=
 =?us-ascii?Q?xcincaGvJZyOmWHcFR+2UBmcZYtV9MGMkQPp1Ed97RoYoGtCulAyn7tSg+2I?=
 =?us-ascii?Q?6gzb8roGUsEAtyORRaNC34HFBVppv6zKDEcXcM52xeYDbYaBskAIjlr/Hpnf?=
 =?us-ascii?Q?SbA/cmCD1hYLuZ7Hk9mei2kKzRR6IKk3NwO9rjA0B05cJEEsnpwuQbG7jpLn?=
 =?us-ascii?Q?ZOkjsY9Y3t8kQbmYqC+R+AeiYJHv/BKL7BMpQYZhkWNj7Y10ekBaoRcRbyIc?=
 =?us-ascii?Q?3XN7RllbiSKOmKFqAAWqjQTX4qTBKiP0J6Yt4cQxGTStySq/FWQKBg7T/jUh?=
 =?us-ascii?Q?TiXrqxgmF/niKZP1V15GrSbVlMaBcsuWN51M/UfUzNlkhvxE96icXWgDVON2?=
 =?us-ascii?Q?CF35WObzGqNStplFN0VIV16TmOd4oMc/KTNRt3Vimol1Ls4oHDr/5WC27gQA?=
 =?us-ascii?Q?hqrHr9qbBjaab+LSN+ESiEyfWkpwpUAT9FMizYATGNvMw0kIcIdPDrj6ZmRQ?=
 =?us-ascii?Q?4o49Wwx6VRY7GRxjzVEG9uuuixv/wXabl2Yrf0T7+YWU6ChcPL9A4qeuqC7k?=
 =?us-ascii?Q?6wrXbc1zBEcbNKnDjth/BTajh49hB3INZZ2eO1oJM1IGyZ9o14wXIOVnQOJD?=
 =?us-ascii?Q?wTGaIjDcTDGUbjz0B3yjt9Aw3AvsQeMn7r8hxmGjGPQXQUwkANlhTiG3HJPi?=
 =?us-ascii?Q?XeH9wXz/7wXRwWu1McrCl5khFGXK4Cp4WQxuTuzsYuaXNi2kByrs5GN3okMs?=
 =?us-ascii?Q?w+n7me80yKfyTxY3O9QH2GAMbMgI+0s=3D?=
X-Exchange-RoutingPolicyChecked: o86bPL7+vPBQwkUkSp13mX+s1Yr5lsKrcp1KtmN8oOfhx1Nun4Exg6O3tr2mOR7dEZAXdytqjOj1IsUYjZZAxRvo9CWbnwiT2fHi9/Jba6OcZ3uJ6GWJd2rvCuSWU7LeSXCJfhIbf+O7C3kdZR9Tokap9CMWGC026ivqQZq2pJH008ErztVKeJ+2CxqmQItleCzSrg+rx9TxgOwDbtWKEsE3BJIUeJUaoT6dHUEWw48PHcc5K2132ptRsgcWga3qgLMC8wr/qNnUaqhZm1IYVvDS9bgQqQogBMHD7kgvl8sFFwMki35sGFnB5OscuEj/hpqdUqeZzH34fT6zH3Fo7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f60be111-acaa-4ec5-87b0-08df44f6c3a6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:04:34.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB8805gPKHjrFQYv3z/mMN1II4ZZWL9/1S4vlOxPgzTmC1o/T6yvvnHrwJroI7d+DDVB9HEPM89DX/tbyZNOXWgk4SysGB+IsVifSaqf530=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB379370
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 02:12:56PM +0800, Yongxin Yang wrote:
> The einj_types file under the CXL debugfs directory is never created when
> cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
> einj_init() registers EINJ at device_initcall level, so the
> einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
> up yet and the debugfs_create_file() below it is never reached.
> 
> Change the file creation condition from EINJ being initialized to a compile
> time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.
> 
> The same check also guards the inject files under every downstream port
> directory.  Gate that directory creation on CONFIG_ACPI_APEI_EINJ_CXL as
> well, and check einj_cxl_is_initialized() in cxl_einj_inject() to reject
> writes until EINJ is up.

I believe this is changing user visible behavior.

On a host with no EINJ table, einj_types and the dport einj_inject
files now exist even though EINJ never comes up, and every read or
write of them fails with -ENODEV. They should not be there.

We last visited this here:
4ed7952b9e87 ("cxl/core: Fix cxl_dport debugfs EINJ entries")
A file should only exist where injection can work.

Can the built-in fix keep these files absent when EINJ never comes up?

ndctl relies on the files being absent:
  - 'cxl list -v' shows "protocol_injectable": true on root ports that
    cannot inject
  - 'cxl list -B' prints "failed to read .../einj_types: No such device"


An implementation question below...

> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
> ---
> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
> Link: https://lore.kernel.org/all/63e782a6-e33a-46ce-a455-5d207a60661f@amd.com/
> Link: https://lore.kernel.org/all/1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com/
> 
> Changes in v7:
> - Drop the RCH mention from the third paragraph, as suggested by Ben.
> 
>  drivers/acpi/apei/einj-cxl.c | 3 +++
>  drivers/cxl/core/port.c      | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index e70a416ec925..22a7eb4dc75e 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,6 +30,9 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  	int cxl_err, rc;
>  	u32 available_error_type = 0;
>  
> +	if (!einj_cxl_is_initialized())
> +		return -ENODEV;
> +
>  	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..a949228de936 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -806,6 +806,9 @@ static int cxl_einj_inject(void *data, u64 type)
>  {
>  	struct cxl_dport *dport = data;
>  
> +	if (!einj_cxl_is_initialized())
> +		return -ENODEV;
> +
>  	if (dport->rch)
>  		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
>  
> @@ -819,7 +822,7 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  	struct cxl_port *parent = parent_port_of(dport->port);
>  	struct dentry *dir;
>  
> -	if (!einj_cxl_is_initialized())
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>  		return;
>  
>  	/*
> @@ -2515,7 +2518,7 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> -	if (einj_cxl_is_initialized())
> +	if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>  		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>  				    &einj_cxl_available_error_type_fops);

Why are the two new einj_cxl_is_initialized() checks at different
levels?

einj_cxl_available_error_type_show() checks for itself, but
einj_cxl_inject_error() and einj_cxl_inject_rch_error() rely on their
caller, cxl_einj_inject().

Can all three helpers check, like the !CONFIG_ACPI_APEI_EINJ_CXL stubs do?

-- Alison

>  
> -- 
> 2.25.1
> 
