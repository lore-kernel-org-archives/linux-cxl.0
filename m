Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795227115;
	b=5rQrWplE4fNlxvnYrUE3sqSpVjHvGgGHeodRWU0YAkLIrBwFxHr3KmMqyMhtcR05ZQvG
	 nhbNL0KUlFY75qyBogyP+0IJbMjthZv+BxZGWW+D86t3lkkC5RemGurdNIV2lHPZ4cUnM
	 oOa9dtampG7A1cS+hIRi+EI30Bo0N0b2rStQNqY4VJ6k2TTvWzYHmZHiHaGXKg/MHKVi2
	 nGx1i5DXk5WebRXOyu8gcx57AD8MgAjRRlIENmDET35TAgjxny+brVMHXCixz/R/c+Azp
	 SNRzOmCfA+wdD437kEI+S1JurDtSvUv3DO2sgjnVnFtdamBenCRoAaTGyt1Iq5OzhQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227115;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=BvFgGIA+wyoj6m5B9zjDN4QgbLx3rLD0Cu6oQ+z8s2I=;
	b=FG/Cjw0bhKt/e5p33WnXHV7iwJb2iVV7Dw0ZRQTylRJyRMRmB+v7slio9Y3r1MBROZ/r
	 PIN1R/kaD21GV4RSfrxEsd0WJlfsDh5BUy/Q/0FBs1c+yvKpGc/Tln70nKs7QIRKbnXhH
	 7XGhFYxFy0vknxZlH8zIlW0BJac5UCorLjS3KzTxLfWyGWTnqSvWMKuVVg6xSZzYYX6bI
	 vE/M951546lo2LGCdu43kAqXNHyNX/wz3DKsXRWMUwGzLo4MbEZNe4BbMVdvCOcm6HFOj
	 Bhj4Xd2VXwlmL29SjfvSQ9eDS+CjV++56agNtueUV12plS+PBeVg6WRtdr5q1K29/ZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="V/fjwa0H";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ixRMoF1N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F83606A69D
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 02:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F83606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V/fjwa0H;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ixRMoF1N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795227113; x=1826763113;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bINsSHpNueMnYyWxMxIULI4JGVhve+jDT1VDz8T5wZU=;
  b=V/fjwa0HWiyV2fKvcm+rF5oYPGhX7DwxvUg2KfvIvbB1mvVaCPRhHUKV
   QT0fevGM1MOE5kuuh+P7owU5UeHhZ9R4WkE+QjepVBlx3cU1NAPZluAYB
   kqZIjqqJIs7QEGHe9xVYTnF+9eMJjHg6dwAPosAMU0LXMrCfh+s18Lm9p
   kzEX7muMcra6FaPPJoE4TWCYFv3iZxW7xLkwXOGxkftUJoI5nBg4zMf4r
   Q850JMRN88Y2+M3hQd6ijVFp9ZT69Yzb88Kv/kzJSNkryY1qowQOlOEd+
   QXQVD8JqmA7ETw4KkEW54etZt4Hbf5fmE2GjUlE5T9E5475eRkVDHj3xS
   w==;
X-CSE-ConnectionGUID: tqSQmmkPTraLephylL0DIg==
X-CSE-MsgGUID: C8fyTeMLTU+/SSxfoeYvPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4105612"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4105612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:11:52 -0800
X-CSE-ConnectionGUID: rDbfmSndRequA+b1CNzqYQ==
X-CSE-MsgGUID: Dn459r+mRqOE9YEA/iLRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11248853"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:11:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:11:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 18:11:37 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:11:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIK7mC8IJfhSYsm4mYAHKHNqdxZpILz52uom4oDb+oaU/J+r8o5KncqbBbJVwQwvb7ZrfFU2zU4Hn59lweoKuE4/KGCFV5j5vIJnn+bKKktpp04+SZpXGX/f7qngk7ZNDQpoJk3fBBlhjhmSm38KGsEZ4yc/TyUBH0Iffyv/aLhNqgWeT40FQaTgIk31JJ54eTlJWEt/etxWbPIzJm6VWwG8AHQFzinpUlnqx1TwHDbFGBiERt9pxUKHTibaQPqrY9fukJdxbBiEyBWs2pVX8r0ennZ9GueFcUOEEnfwzFs0Xxrx1sgD66FafUvBuSbijj/P6bnMUij+XsEbXECl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvFgGIA+wyoj6m5B9zjDN4QgbLx3rLD0Cu6oQ+z8s2I=;
 b=NNv+0T7uO5Xv5zHBVBNIcpbvXRjtwsJRHxVIFEbY8724GcZJA0lAXt4s0Jvrn+wSnSUDx+ABWjtHgCrmcjcxLxVFE8xs6He3ayZmpNHy1792figz2EKEBHiD2d8UCmHasn9R0Ry5sYtMGfP8uFrP5Ifghd3ZusjiitCU2Q6YWhuakx3gquYJVWWVFxpcmbmYg3xurtbNGvZLc6R4tU/rkYbbYBZhXaN4+wAP6TOxAQf6YDlMxmznowvDCBWfTRf7CuEhTUtbjJvFXusyB1oHLIhuQDM1NPgUn4tjSfrOlB9SDZV4M4ugjsF6CexhRovfWFYBkSzKyaRHUYP807jwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvFgGIA+wyoj6m5B9zjDN4QgbLx3rLD0Cu6oQ+z8s2I=;
 b=ixRMoF1NTBFfDcVkNIMt9PxuZ/B9fkdob2RuXWE6A/dpq077TLKwJGsXfooWUh1UtbEGy1/5nLrP1pIvtlcIdBfJJSudLNnF1bjkCCxrCYr4nP9UKjcq9T2/zEIVKhaI6YEY6Dxe1/WhSwmslme/3c+yqwcz/EExCIEkJApOTG4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV0PR11MB9840.namprd11.prod.outlook.com (2603:10b6:408:383::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 02:11:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 02:11:29 +0000
Date: Fri, 20 Nov 2026 18:11:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH 1/2] test/cxl-translate.sh: Wait expected log
 before checking result
Message-ID: <awD9yaArrOKP79Re@aschofie-mobl2.lan>
References: <20261120071415.29279-1-ming.li@zohomail.com>
 <20261120071415.29279-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120071415.29279-2-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV0PR11MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b760147-180f-472c-05bf-08df4774c155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|3023799007|11063799006|261022105027099003|4143699003|261028144727099003|56012099006|261026121527099003|10067099003|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261026140227099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: XKG94wzTdPdb1I3vFo08gu6wRGP8ByFqSgsg7bt9XBNtmt9hJDRI/T6pdAE6naT7RGKAsZuERfI/Zx2KQ8qXU/o0aNDfMDGABShVku17NOFKTcF1VBSF4djYNw5PXW5Dl89G9xS6FGuA2XbmiYal45jYXiVGpiKmp8VTKrtcjhUyNA1I5Hv9CNW2+gOGUUqWoovnNZ1KMFit4egPmAsH2R20w2Pi06Jblnk2l5N3H6JpFeNGxXwKJurOelELjWNniXN69b3QEBaUvoZgD/+FhZj8WQDS+2tT6xB8mmg+IBHOmhtux80Je2bJwQ03HC4Fskh0UAbAHS2WcVvnRigEaTA85cUeX3JpLJ6bO+YEwl7Gs7wmeDFOPurGkpTxP/f3CaVAstigxkRfUTXCLEBQnEO595JvE4Go+wtNiNyuwjUYpD1uEn1HY7wIKiv8YnAozM4rzftFfsml0zwuv1bQMW0Iqq+DfZhN9a3twDj6u09tOn3WFYy+VYGIcoUq77bCsBJjVGaGUdoEu4HjSSrZMY7YclhhoQ7S+W1D0mKW8/mkslFtZ2qhv4svKa6xzupG5XkgGIVLJOhEPTGByL3JX5ZKEiBlUmFH5r2Sma6KGsnINUvwjsSFb9I9DSVhOqv47UCUFFw1iNOtfwzKrIfCYj9YCHxYOpMNhFWoRhUKN4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(261022105027099003)(4143699003)(261028144727099003)(56012099006)(261026121527099003)(10067099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261026140227099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9jT0xRTzQwUDV1L1pYR0lHdWkzL1c1VDBpNFhPUkRNR1o5b3pPUXFSSnNC?=
 =?utf-8?B?WkVWV3lHcEtkSzl2OFl1N2tETHp4aGVQdXNjbG15R1pvbGk0dTMxaXhlZ2lk?=
 =?utf-8?B?d2taRlJCZFBJcVQrbnRDUW5wUGpuU1BlcG5OK2dWNmV0NUhGU1JPRTNxRUJ6?=
 =?utf-8?B?Wi9haVlod2taNTZTWlgyclY5MnN5c1Q1WEJWbm9wMDJ6UU5odGQxK0JNK2Fl?=
 =?utf-8?B?L1p2cE92OXd4R2dBMktsamt4anovZFRvZ1JGV1ZURXJ4N0Jwelh0UTEwaDYr?=
 =?utf-8?B?dmtHV2FDMlA0THVTbVBXcUM2ekdhemJGYjZONDN6d2RyLzc3U1o1L0FHL0hp?=
 =?utf-8?B?ZEt2QmpXMlRRN1BzQ3VGYk9qZlZmT2lLQmJNUEdyTjBCZHlIRG1KTTV6NWZX?=
 =?utf-8?B?QmFWYVRScGtYd2ZEblNNeU9IeVNna1lJeGp4c0ExQzExTCtDLzJaMEVDYnk2?=
 =?utf-8?B?cGtDTGs4VlZEaDBCU2Q1S0JpRGw1U0pmRENhejFjeC9wdW8yaVpMWUdRN3pT?=
 =?utf-8?B?YWRzVHRkYUhoSE1LdkhIbjZSZXk2RWJ2MC92MWlTM0wvRHdsMi9WQjJtQ2x4?=
 =?utf-8?B?Vk9CZlY4QjRneThJWEVkc1F3RDhCUHZXUmhCRUR5UmJYakU0L25CbDFsdjM1?=
 =?utf-8?B?UERodWlhMkJUcGxMQlR2QmNDd0xPcklDWStrd3U2Q0NvUE5iS25hYktySU1q?=
 =?utf-8?B?c0xFSjFNU3picXkrc1VubFY4Wkx0OUlNUkNPaEtxQ2lZTTk3WW1YR3Z1dlhD?=
 =?utf-8?B?REg0cnZIT0Q2R0FxVWNZa0o4Szd2QWFrM2xvckMvWjEzaXNNR3hDbzBDQ2Vw?=
 =?utf-8?B?anNSNHpKTUlOZXhSUHNUaUgxTERWZDJ4UDQrT0RzZTVSSFN4ZldqV2xKRGhM?=
 =?utf-8?B?Nm51T2RoVFVzU0t5eVdrdzh5c1praVlxOWJsZS9DMklzWVNHZzlCU3ptY2hk?=
 =?utf-8?B?Z3NUNVZhUEhKQ3I5aGMzSzRXeXhxMnA3K2U5cjRXL0pLaVB1KzQ5WVpiVUVx?=
 =?utf-8?B?Uno5d2l1R2daWlM5RElRclJCcTNidjF1QVVxVHk4RDRLWkxCQjJTMVpIYWts?=
 =?utf-8?B?aWlWTXF0RWZ0dU5iSTNJeWNCdnU1aGpuZ2YvYm1tYmtKMUkxVHNUZjRBWXdq?=
 =?utf-8?B?WjZnSXluVjhJNTNyR1ZSVnV5M3hmZG1STXVKcUJlTVYweExGUGRHdmJQeVY3?=
 =?utf-8?B?bFNnOFRzNmNQMGlpcys4eTZiK002dW1SY1hMd2QvalN2YUkxSDhPOGlCMGtV?=
 =?utf-8?B?dUJMbElscG13c2Q0Zllsc3A5ZnZVQ2ZYMUNEZTZCbWRqYWxySmp6REk0bUwx?=
 =?utf-8?B?RysxdzFrckhmWnFYdVRWSG5pZ3JzYmcrZDVNR3NGMnEwSS9kUXNFcDBDa0VG?=
 =?utf-8?B?THM4ZnROUTBGQjAzc2xLNS9HdkV1WTd6Qm1aRmtOYzlUTy82YTA5M1J4dG5j?=
 =?utf-8?B?YnZHbFJTWUV6bG4vbVpCSDVPZzAvYUVIQmJIVjVoUlF4d201WFoySENJYUNW?=
 =?utf-8?B?MnhWcmtYRXJMcm0yaUpDTzRNSm1rdGdvOFRId004U3UxY0hnT1pVZmJPQU1U?=
 =?utf-8?B?RElteDNPQzg3WFNTS2gxamJmVGtTdEpnRU5wVUJ6QkpIc0x6aFpuSDRGWWcz?=
 =?utf-8?B?YnNZdGRDbGEzdlRaaDBMallLZC9FbVdSdkowRzdwdGc5NmJ2TEl6R3pPUW5J?=
 =?utf-8?B?SWludVY1UXAwd3lwVWRDekxMRlljcENFSzNuRmdyc2xZVFRNNWI0d0dFTGtQ?=
 =?utf-8?B?QXpRMzNOQVNTZFlINDFpRGFsR1RXS0REZzN3dEtZTjIxYUl5S0VyV1NTRFNr?=
 =?utf-8?B?VXljaGJWb2RSOW44VE5iS0xzUHFNazNQMDJFeno1YWVZaGdOZXVrMnNXMlNK?=
 =?utf-8?B?eklqSDBieUpnV0ZOL29rTng0V2owbll5WE4xYSt0cFpUUHBSZ0lyRDFOSU9W?=
 =?utf-8?B?NUtESmZuWFdzMU5uYTBjVU5adEQxVGhLc3REWmovWnFGc2MvQlZmQ1JacXIy?=
 =?utf-8?B?TElQVEFaTyt0YllLZlR3OGZHK3FmRzBROVJKZG1PRklNYW1TaEdWbllmS2ha?=
 =?utf-8?B?alNyaGVuYmNpRjJmdXVRUmk5c1BZZGRhS0lod252R0hNVzdRTEQ2ekg2S1NS?=
 =?utf-8?B?SnpYaVRVNy95STIvUUpmMC93ZlZxeFpseS9SWXFrMHE1YjQvVmRuanpvakk0?=
 =?utf-8?B?VDFjVVBlejkxcG1ocVA1emhDdkdVS1pHVkNxaDFxMlpta3I4Y3NLQ2NHRmtT?=
 =?utf-8?B?aE9XMy8zUytaZ1k3T296YTAyNTBDU3R5MDJ3T2g2dmtpUXdkWFNzTVBzT1Rr?=
 =?utf-8?B?eFVUZHBzQld2bHpKMmtpNExIbXRiVldIdmxmVURQSHQ5VFcrbEUrL3BKWll1?=
 =?utf-8?Q?UXbzLQRjksGzt3m4=3D?=
X-Exchange-RoutingPolicyChecked: xWjkyi4hCn1kOYGBwG6mE4Um7S1DbIqQYSfc1RFZQTcBPOX/yf2Sn35k1KNpTOtGSkpSdCHqwLRSoSgD2tvKlRmbC83UZ0NM3UoQ4pVkGMKT6eexI6yZaJLDTGgFdOTLVDCHcm9C7D9hMYoP6DUwDFZkHP5JN2ppRruoQie3brm6WAjzfYtdaNyESEjGJIHNkZwzz0yvp/gFTe1bOxnVuFA1J2ic/irmkp1K+bze56MiTsQ0Go6Z1t+lKa3gdDkY/pV6AsGR035yGM2ge3OCQ+ufoNMdJYyGVIzq+JofXjtNJLWeg6XdQYR550dDwc0GUI6LIyPxxwuPCqdvFOihQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b760147-180f-472c-05bf-08df4774c155
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 02:11:29.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIqJo7w2P4em3cTL5/TTlBMe1uR2eqMXUlJBs0WwFI9jr98ieCcOkr+7uwE82TXzuve3aedtQ7mFUQ6Un+apE1kIDaK2JIRpcJRR3MM1n3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9840
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 03:14:14PM +0800, Li Ming wrote:

For the Subject, ndctl uses lowercase after the prefix. With patch 2 folded in,
how about "test/cxl-translate.sh: wait for completion messages in the
journal"?

Add nvdimm@lists.linux.dev to recipients list.

> The cxl-translate test occasionally fails when verifying kernel log
> messages immediately after loading cxl_translate.
> 
> Although the expected messages have been emitted by the kernel, they may
> not yet be visible through "journalctl --reverse --dmesg" due to the
> delay between kernel log generation and journald processing. As a
> result, log verification can run before the required messages become
> available and report a false failure.
> 
> Add a helper to wait for the expected completion messages before
> checking test results. This avoids timing-related failures and makes the
> test more reliable.
> 
> Fixes: f643715 ("test/cxl-translate.sh: add new cxl-translate.sh unit test")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  test/cxl-translate.sh | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/test/cxl-translate.sh b/test/cxl-translate.sh
> index b839179..2fbc310 100755
> --- a/test/cxl-translate.sh
> +++ b/test/cxl-translate.sh
> @@ -41,12 +41,31 @@ set_log_start_time() {
>  	log_start_time=$(date '+%Y-%m-%d %H:%M:%S.%3N')
>  }
>  
> +wait_for_expected_log() {
> +	local pattern="$1"
> +	local timeout=5
> +
> +	while [ $timeout -gt 0 ]; do
> +		local log=$(journalctl --reverse --dmesg --since "$log_start_time")
> +
> +		if echo "$log" | grep -Eq "$pattern";then

Please declare log once above the loop and assign it separately to
avoid SC2155. Check the journalctl status explicitly so a failed read
is reported as such. Please also add the space before "then" to keep
the script shfmt-clean.

shfmt -d test/cxl-translate.sh
	That one was clean before these changes, so keep it clean ;)

shellcheck test/cxl-translate.sh
	For shellcheck we are excusing SC1091 (sourcing common) and SC2034 
	(rc is used by err() in common. I've also disable sometimes for
	shellcheck complaints without nice fixups, like the namerefs.

 	I think for the one you have above, tidy'ing it up by declaring
	log once above the loop works well.


> +			echo "$log"
> +			return
> +		fi
> +
> +		sleep 1
> +		timeout=$((timeout - 1))
> +	done

Since the first check is immediate, the last check happens about four seconds in.
The loop then sleeps for another second and exits. Can we check once more after
that last sleep to catch a marker that arrives during it?


> +
> +	err $LINENO

Could the helper return a failure status on timeout and let the callers call err "$LINENO"
so we still get the usual failure output?

> +}
> +
>  check_dmesg_results() {
>  	local nr_entries=$1
>  	local expect_failures=${2:-false} # Optional param, builtin true|false
>  	local log nr_pass nr_fail
>  
> -	log=$(journalctl --reverse --dmesg --since "$log_start_time")
> +	log=$(wait_for_expected_log "CXL Translate Test.*(PASS|FAIL)")
>  
>  	nr_pass=$(echo "$log" | grep -c "CXL Translate Test.*PASS") || nr_pass=0
>  	nr_fail=$(echo "$log" | grep -c "CXL Translate Test.*FAIL") || nr_fail=0
> @@ -310,7 +329,7 @@ test_internal() {
>  	modprobe cxl_translate
>  
>  	local log
> -	log=$(journalctl --reverse --dmesg --since "$log_start_time")
> +	log=$(wait_for_expected_log "Internal validation test completed successfully")
>  
>  	if echo "$log" | grep -q "Internal validation test completed successfully"; then
>  		echo "Internal validation test: PASS"

Now that wait_for_expected_log() checks for the success message, try letting test_internal()
use the helper’s return status directly and drop the second grep and its else branch?

-- Alison

> -- 
> 2.43.0
> 
