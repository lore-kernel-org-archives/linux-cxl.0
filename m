Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793216447;
	b=Lc6/zof9S9oCQ5m85xbcy6cbve5071ZqM6pW9tb3njXYbPkb1cn4sA6SyyKW8D08GVoa
	 rG7VmmS/Nd4OcZIY8bzASMQVOcylTxO0pKZZyQcjUtrhgTjCTWIY+gSLKXBtr0RhkzIz5
	 fu6BqZiLS2ycRPGBh73XSsGI1UTOEd6HJc8Es1/EkXoPVvarXDS4mEu2FOSYwdTf5eCF3
	 RbO6Kh2WWt5r3G76ycayuHqLkXTEufGZdJ2H2/5rsUDUZgkED1bRUgzsk7JKx++gwmMtP
	 MYpuCk1rYFG6V+ABQA3JnU96TsTiRg7U8BOeN0B510pfgxWwOmX0K9LzUWQIk97yC/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216447;
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
	bh=mIEoAyskOM9wv914Ysk+lKrEVrzmmM+UKfXx2hrUSnk=;
	b=z6o+Hw3nCYcdC/HiN5WT+3rIlgen4b3B/D2Sci7FPwwaPnLItRWR48F+5z4pRAnQ9h9R
	 mcLL2xPIfXf7YilAiGEZFGI2nQGLds4JvaLsvSztCkYYyJyOPvbmU2v1YGraHsXUfJPga
	 LSmM3HoEjfMQyMQz6MFYJX0bU2P+1XwMV7MGx3sa1L8Kpb01mciGCkiT2Yox93A9QLD//
	 YTNcJ3Fzzy2CV15efK+WjFqjkO+yQstBJPNonGFuuhX+aIxK97RaDBVBudzSFGpp+lj3y
	 AeE6turQjlcuz+ibj0oU7vYFAXt3sHu/GzPpRZHEmmthjZZrWTdO6w9/Lrjwmk8bvSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CoQ4Mmqh;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF7606A326;
	Wed, 28 Oct 2026 19:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FF7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CoQ4Mmqh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793216445; x=1824752445;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Dr4ro+O/Jubvd3HboBRBO8zg2Kza32N9m543wpb9xhE=;
  b=CoQ4MmqhT5ILPlLMFeuIzWObZv1xRwdnW1NcYK4FH31jvbZIe5aDDrWL
   V/HqA0hhZC9TkByXA5njd/x3+ECM6sOunjy9lP7k2vcSCclh0SgKB6MiO
   SpVqOATnjkxVn0jNFWv4N/Ht9Qk5q4VxFxUgGze2VcRkysJyWcCxJDa3b
   QPfwCPatvlJXa33adIOXdull6VVg/nSya/TkZtVxX2Cj/t7Eg3lNTeuXX
   4qbCzVTnHkGtng5RgwCPG5A2CafuocF3dgDqBejqUnP9sZ6/2VDwkpSjO
   1p5fFlqDfSFgs0rjGv0bm/8SQiBs7yrXrkJawOyyNijBNNKwAS029g4ze
   Q==;
X-CSE-ConnectionGUID: v23Q9JcoSJirEYoEQDv04g==
X-CSE-MsgGUID: CvVqF7BPTrOw1E8mqIhelw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1847508"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1847508"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 12:39:13 -0700
X-CSE-ConnectionGUID: W4AphmNoS6SWNH8QkdZqvg==
X-CSE-MsgGUID: 34NLVYqYScqPSjZu2gpKxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6764108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 12:39:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 12:39:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 12:39:12 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 12:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebY16d/J8B9qD0yMOtaLoS7kkOmxRfh2uYT1CPVQseMHu6GJAILuzZdjo9KbJWxXdPoKGzXVDjxMlQ0rRsoxQrRMEn+wEtt1HjLaVvjrEb/sYxaLGbXPYepwPGQO7SBeGiZ1ONL7VH+WG4SwdbvijxRXBD+7TbYARPzhUOrbq5IQCcFM6sMmMxfqjHysu1WHX98A511R2qQV0kSLGubCEyGAFIDopgpT5m5JLTQ6sevj7UaxHuKzSB7a95zz5hL1YCJI9G0Q/Yn/Iel5aj9PI0FCl3dZ8lgQTIqxIKKpyndYR+bTePeCyyhDcwLJLjYuigq3kll5DFG8Ce5G7/g7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIEoAyskOM9wv914Ysk+lKrEVrzmmM+UKfXx2hrUSnk=;
 b=xRn4cw3pYBUgbA3dNWPnCkaGm8w2BNMaAM9cOMwKEVwamOLG1DFE2kzHau4mVVxU6w60UQ35lOPDYTIhqoKUMRA+MVZ571FAzXBfz+YoPQ1ogJ+3Q2H6hKCru5EMl9W6+SydBIMD2vxG1FGTV8J8lX4o10D6zGzA4isgDfIBhN76apq5Ozow3C31BfPmuqO4c1old04fsKV0WZGk29nrNi+fJg6OhAYwHnrgBmLnKA3Map+xtLiprJ89K7ie+rDvDnWvB4RtP+0jwMjePcVJ3PNKQZ1f1IP3NIgnrsl3zo5EeEcbwM9wYL35Tb71PZOeIywEgpgj7EIx42+iG5BlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH8PR11MB403433.namprd11.prod.outlook.com (2603:10b6:610:32f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:39:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 19:39:10 +0000
Date: Wed, 28 Oct 2026 12:39:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in
 if conditions
Message-ID: <auJPWlYt2Pn8MRoY@aschofie-mobl2.lan>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
 <6595ac9f640a3796f34f58ba6d97d61bc0c07558.camel@perches.com>
 <b42c1849-8998-40d1-a433-2b4077374074@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b42c1849-8998-40d1-a433-2b4077374074@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0355.namprd04.prod.outlook.com
 (2603:10b6:303:8a::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH8PR11MB403433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdee1bd-d365-4611-42d1-08df352b2332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261028144727099003|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: 0ApKQBCNF8I1FKHz+TRfie+TyxtW1BuXnI1YAvwXydSiKAeL0B+rZJ8oij+tjIfmQ9IkwVCmH530uR5Usr8rD2A05oy1F6a4BZQGCxyw1MqbydgifNelPsYZBZd2BS2Gv0ozPw1PnLBaG/UhAcbNk4g86/VRxKngErWqzQXxl6RRKs+VleIF/Yv63j5wFykzignMk3Qxo6ajw2IJlhwF2b0zbr43ArLpjKxP0l54CxtMSLgiNXXpDWTl86j2aDIS/m7RURU8qu9ZjK3RScVNQ8vaEVULxS5OYf1jY9ZFyru9iR03It5Sp7niCjfwSD/VpZA1yqVG+uu9MqJwbYqosoY5HN++xX4mh9kPcUdzNxVMxT3ht4vXTEbnLCUwusBU0pzhD84sprxz7hufibP4XcoP4gL7E6IkNtK14TFSBLK+98VDQ2+G7SwXlj3zTflP5cD7cyxtgFfNnP5+OX2svXlApoGVXxYBMz0EK38jsEm5Xs9M0wxSXlzUP94ybIMlbT8UWDXuO6+CkBc6/YRA49/26ISOUTGnG6cm+BcDX+qbICklyR+1v7m4a7v/m4hcDCDCcWLyRuiEYttr0tHFVVqCg67sYH19QsOPBI1lEzbxNruP9frSW+bsZIJqgXne
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261028144727099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1gxS0tLbnAwL1UyK2JueFJTdVZhVWZVME52bjZ1VmQwSFgxa2pIVjRxTFVF?=
 =?utf-8?B?bmtTUndPbzhva1ZNOUJCM3BaSkNNU1Q1eGkzTitvMnNKeWVVNlpNSE15WmJz?=
 =?utf-8?B?K2ZwcjZITjVPKzZHdGd6dW9jaEpTdXU3TGZveDNjQmRrY0hlZ3c4U0djKzdB?=
 =?utf-8?B?c0JLbkhmaHdudWY4NEN4OUZTVmxqeEpoN0x3Y3BLS041SFQxNVV0NjZLYXZy?=
 =?utf-8?B?eEZwd2F3Rk9MVEU1TG8yTDkrQ0RFQVVDTVMxK2U0emE0eHlLT2Rzd09meXlE?=
 =?utf-8?B?akpOdVNUUUhBbkkxV2N1RTd3UExNYXJ2bWZHQmk5dnhrWVB1UnBJSXN5QWtN?=
 =?utf-8?B?ZEtJd3k1d0trU2gxT1Erc0VDUmZVSVhYbU5ReUhIMjA0VW5uRzhncjdwQS8z?=
 =?utf-8?B?SCtQWG5oVHZvdXlyakVDTmNIY2tmWGZXYTJ6bUdNNWdyUHdvZTh4NUJ5THE1?=
 =?utf-8?B?VExCd2lVV2VQMzdxRTZVTGhkTjhhRHQ3VVB4MzVETkgwNUs1U0JVcEdCTTZU?=
 =?utf-8?B?ZVd4clc4aUZSZDEzUkV5amVuckEwSFNNUlQrdXZFQi9tSWhFVEVjNFhSY3BK?=
 =?utf-8?B?TEliZ1J4K25XSWJQckpNeVdRdUxvZWhYWlpnY3h6bldyWGpYcllMOFRMclJt?=
 =?utf-8?B?Sld5Q1pHUGpLc2FyU2VvaVdHT3NFNzhvSDU2OTlZZWU2SkxqS25HSm14dlp5?=
 =?utf-8?B?Kzk0a1VhL3plTXF4bmQrZFdYU0oxRFJYa1NOUU9uQmMzdGNLc25na0M1NUtv?=
 =?utf-8?B?bnRYeDM4UFV0ZldlNFd1R2ZNZzdaTWgwL2Z6M0RIdGYwclFYS1VJM0FqeVVh?=
 =?utf-8?B?Z0thSjhnbE12bFBWL0Z5RXk5Snl4NzFwaFh3TmhZbWNMNkZUQ2hXZXY5NG9w?=
 =?utf-8?B?QUdvb0dxV0pndlVVSVZOZkovWHB6SGtRLzhsQkVIY1FWMDNoODh1UzZzNE9P?=
 =?utf-8?B?TW02V2JmVHJRSWVwY2FFWVQwYTFLZDdwbVRpR2dhRExvYXlCUkJxYjJKVFBj?=
 =?utf-8?B?WlVQaSthWFRORUFwdWMzNEdNRVE4THZRdytCTGdBT0JNNnJoUk9pSlZhKzJo?=
 =?utf-8?B?SElEbnhadGx6U3owRVZKM0QyWHUyMVM0NmFEcmVMYUg0UUY2K2R5ZkJIV1RE?=
 =?utf-8?B?emUvQlE5VzlmUTZLdmxQWXNvZ0tab1NtT2kwQ09GOC9yS0NacE1FQWJuL3Rp?=
 =?utf-8?B?R1ZrR1ZnQ2FXNWVQVjA5NEZqcFk5R01wZXhlN0xZRXFPdWVuUHcvVE0vQzhs?=
 =?utf-8?B?VFRQbGE4d1lPNmZpbnRTOGNaTGxsZTFKM0hFeHkvOCs3N1hmYlNBeHhGMHpp?=
 =?utf-8?B?dVBhcDNsaTRuRkhNSm0yRDhFeGZLWlNOU2xxK1pxanFCckxLdERNUGFMZVNR?=
 =?utf-8?B?RGRoSkVyVHdZay9haWdCbGxIQUMybkl5NTFtSXNPRlNidU5ZRkJJK1RqbDRJ?=
 =?utf-8?B?NGQ0NEpuTGxZM0x2eU9oUHd3S1lvWE14cEduT2hIalZSMHJVV0kvU3FIelZz?=
 =?utf-8?B?Tzl4R21zVHBFcHVweVN5ZVpzM3V6SzVzSHBYOU1yVkZvVlZraDdBcHBIZkZt?=
 =?utf-8?B?R29lZjdOMUExU1BtY0VRNWNJMDRJMTlPY0FIQktXVkF6UEo3WVIwbXFIWGs4?=
 =?utf-8?B?bDc2SUdPRkdQU3U1cTc5Y2dTNjdBajNWSGZCemVIc0c0NWlja3VRK0ZtY0lP?=
 =?utf-8?B?U1BXRXcyVnRuWlFsZjZxeCtYdXdoVFVTcG9WaVJ3M1gyMDEvVE9SNXJ2WVpT?=
 =?utf-8?B?dEc0VlVyN2ZxSEJwNVdZVmFGNW9RUXlncEhueWEwRVhFTW5zKzhmUVUyeStH?=
 =?utf-8?B?dXRaWktVMG9xUlUzTjdLbnhmdVVac3ZJU3ZlbStVbTJFY1ZOa1o1SDZCdFZx?=
 =?utf-8?B?YzNIWVl6b3JObHF4ZEd5SFNzTUtWRFN0TlFDNkpDWDlUSWY3US93clpaNEx5?=
 =?utf-8?B?dDl3SnVLNUpmWWVBanZzYU1hbU5hODVVRHNacXRYV0kzMlJjU3RIWCtGc2Vw?=
 =?utf-8?B?K3Vrc2hLTXBOMWdaaVg4aFlqVW9qazY0d29zV1Y4d0xKcE00VGltanNyOXkr?=
 =?utf-8?B?cU1wWk4wVzRZMjFXaEt3SXVnUDFZMDdJRDBCMHZQVC9lVXF5dnpqNXF4TWxT?=
 =?utf-8?B?OGFBSmNLMk1Ub1VBNTFRc3ZOc2krNXRMZWkxU2I0TXhlZEpoYkRzdDR2VHpq?=
 =?utf-8?B?cUl2MDgwcHRKd3BFdktWcjBLM1lnUHZxQlRMaFY5b3E3bVZmclorTDNVZ2w0?=
 =?utf-8?B?NnhtYnpLdVJpM25SU05mUnY1bUZaWjVLbUJvUldWK1VjYlI5WUtHbUNxSnlL?=
 =?utf-8?B?UkJsQUhsbWxHRVQ5VWRvRGd1WVY4MjExTFZESFNMNHRQWmlyQ0ZZczNoSkZ3?=
 =?utf-8?Q?WDS/j1ja96IZs/n8=3D?=
X-Exchange-RoutingPolicyChecked: brFAGlwPbYzkCGTE9L4TIUzNeT70+MTGwkJxi/UpukUK5wEQ8ibMcQYXaEwLeDj96BV3YK+w5LTHmOrITVyXBGK4gpmr/CtZbKuqZrUJSbzSYDVwlejAqDBF57ovpJ1LT/k8qRhlzfzDFKWuBaejzDqCSicofXiQjlFfvDbSLqrIRlAptVJM4PCpD6Vwve1EtOVyOY7bKcbSAE7kj23TXgs0dd/mYE58H2MwKpRSHJ2fz4rdosVq9wrVct44NorQjZdWELQgkfziWuUsEBblRJ4Ukcx7vV2hiwdCeEvArwcdeC5vvNwPN9WbtR8Wr0Zy6aEy60gYbbuEptNOKOTI3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdee1bd-d365-4611-42d1-08df352b2332
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:39:10.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtVFZlOkJtnNSfv5u4hGw33akJTYrhiu2AGv6syZzaMSCvLgD4yMHHNmzfpO2YZohZdheUe+SRdhxQo1ei6qel1lnsiP/cqJvaCd+/e4fa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB403433
X-OriginatorOrg: intel.com

On Wed, Oct 28, 2026 at 10:21:51AM +0800, Guixin Liu wrote:
> Hi Joe,
>   Could you please apply this patch to 7.4?
> 
> Best Regards,
> Guixin Liu

Already applied by Andrew :)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d25f15a76c7a7f0e20a2b4b36f5108ef115a6d1f


> 
> 在 2026/9/25 01:09, Joe Perches 写道:
> > On Thu, 2026-09-24 at 11:39 +0800, Guixin Liu wrote:
> >> ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
> >> IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
> >> was acquired, and drivers consume the result directly in an if
> >> condition:
> >>
> >> 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> >> 		return rc;
> >>
> >> That combined form is the established style at the 49 in-tree call
> >> sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
> >> there only as a false positive, and every patch touching those lines
> >> carries noise that reviewers have to wave off manually.
> >>
> >> Skip the check only when every assignment in the condition assigns the
> >> result of such a call, matched by the *_ACQUIRE_ERR() /
> >> *_ACQUIRE_FAILED() naming convention of its wrappers. Plain
> >> assignments, mixed conditions and near-miss identifiers still get
> >> flagged.
> >>
> >> Suggested-by: Alison Schofield <[alison.schofield@intel.com](mailto:alison.schofield@intel.com)>
> >> Cc: [linux-cxl@vger.kernel.org](mailto:linux-cxl@vger.kernel.org)
> >> Assisted-by: LLM
> >> Signed-off-by: Guixin Liu <[kanie@linux.alibaba.com](mailto:kanie@linux.alibaba.com)>
> > Acked-by: Joe Perches <joe@perches.com>
> >
> >> ---
> >> Changes since v1 [1]:
> >>
> >> - Check each assignment in the condition instead of the condition as a
> >>   whole, so a mixed condition such as
> >>   "if ((rc = regular_function()) || (ret = ACQUIRE_ERR(...)))" keeps
> >>   getting flagged (Alison Schofield).
> >> - Match the assigned-to expression with $Lval, as Joe Perches
> >>   suggested on Alison's earlier attempt at this exception [2].
> >> - Cc linux-cxl, where most users of this form live.
> >>
> >> Two deviations from [2]: the assigned expression capture excludes '=',
> >> so an '==' comparison in a mixed condition is not mistaken for a bad
> >> assignment, and the check requires an assignment the $Lval match can
> >> see, so compound assignments like '+=', which it cannot see, are not
> >> silently allowed.
> >>
> >> Testing: ran checkpatch on a test file with the allowed forms (bare
> >> macro and both wrappers, member and array element lhs, multiple
> >> ACQUIRE family assignments in one condition, an '==' comparison
> >> alongside, no spaces around '=') and with 14 cases that must still
> >> trigger (plain assignments, near-miss identifiers, arithmetic on the
> >> call result, ACQUIRE_ERR in a comment, indirect assignment, mixed
> >> conditions in both orders). All allowed forms pass, all 14 still
> >> trigger. The 49 in-tree call sites under drivers/cxl and
> >> drivers/pci/tsm.c no longer report ASSIGN_IN_IF, and checkpatch output
> >> is unchanged for fs/namei.c, kernel/sched/core.c, mm/vmscan.c and
> >> net/core/dev.c.
> >>
> >> [1] [https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/](https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/)
> >> [2] [https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/)
> >> ---
> >>  scripts/checkpatch.pl | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >> index 8a7787d228a6..eee06ac6737f 100755
> >> --- a/scripts/checkpatch.pl
> >> +++ b/scripts/checkpatch.pl
> >> @@ -5777,7 +5777,21 @@ sub process {
> >>  			my ($s, $c) = ($stat, $cond);
> >>  			my $fixed_assign_in_if = 0;
> >>  
> >> +			# ACQUIRE_ERR() and its wrappers, e.g. PM_RUNTIME_ACQUIRE_ERR()
> >> +			# and IIO_DEV_ACQUIRE_FAILED(), are meant to be evaluated in an
> >> +			# if condition, with the error assigned in the condition:
> >> +			#	if ((rc = ACQUIRE_ERR(name, &lock)))
> >> +			# Allow that only when every assignment in the condition assigns
> >> +			# the result of such a call, so that a mixed condition keeps
> >> +			# getting flagged:
> >> +			#	if ((rc = regular_function()) || (ret = ACQUIRE_ERR(name, &lock)))
> >> +			my $assign_in_if = 0;
> >>  			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
> >> +				my $has_assignment = $c =~ /\b$Lval\s*=\s*[^,)&|=]+/;
> >> +				my $has_other_assignment = $c =~ /\b$Lval\s*=\s*(?!\s*\w*ACQUIRE_(?:ERR|FAILED)\s*\()[^,)&|=]+/;
> >> +				$assign_in_if = !$has_assignment || $has_other_assignment;
> >> +			}
> >> +			if ($assign_in_if) {
> >>  				if (ERROR("ASSIGN_IN_IF",
> >>  					  "do not use assignment in if condition\n" . $herecurr) &&
> >>  				    $fix && $perl_version_ok) {
> >>
> 
