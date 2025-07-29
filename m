Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454913B298
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814948; cv=fail; b=DDAM/dsH2Efx2tC9C4zeteBf7BAYjhuqJ+PmmHhPNWIStMlyPVf7XIm5kb8KRHmvwf/22SqAzBKst4sPjv5r1BbstAfyggLjplSUpWVYDQt2Wt038902VoafndZBDGGE169Frqrq3aqCHh1fVL86w++P1R9ySAUpVIw+B5DFX+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814948; c=relaxed/simple;
	bh=qLgSBhgT+egk8Qf6NW95PmOif5CiX9+fHguPdpIldjM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=S4s3bh9JsRWfPl/fsu+dJz6prt9YrlZl0Ya6AqX3HbHP5mxS1TPvZHDodS9BdRRNVcCq3ZhkjWz14TA97/yma1BzB8BP/CSzKxjccZHJOXXerOY7k8RKiHbJdJXGqUfufO3pKeNF3gW1L5VBGzM/yOBx3KKSw3si4gE3hPoQMIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ke3qdWse; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ke3qdWse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753814946; x=1785350946;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qLgSBhgT+egk8Qf6NW95PmOif5CiX9+fHguPdpIldjM=;
  b=Ke3qdWseCNC9iB+8ZdFTiMINtl5sQNu+Ef8IHfRYzmrtmpk0AD1LEdKi
   rEVj3gz+nxBpumj1x8VYF4ILPxbLpi0qftkZbpkb7A0g+LR/Jl/KlUFVH
   olO0hicTaGpEyeezLD406t96Uf9khan7lzE5WhBgPM25gfsrzG8R0ZdY7
   4MDH6Xd0tGbMrWpFEHUNqU114kxEd2DuFI3khqTql4YzI39q9gG2IJreH
   WgEzJrbSOp0z+Sre32xoC9cvOc5geKXtWCx14asSyiqjpz3vbtbcfZT8p
   gOwKu0f51roJyCa0uWGcIXRZ/Tv8WpmIw7vbJ/rthruqDN0J2ire7p4nn
   g==;
X-CSE-ConnectionGUID: Nj36VfWsS8i/oWN2js0g9g==
X-CSE-MsgGUID: ciHFz0LKTo+gPat5Js+oPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56250789"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56250789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 11:49:06 -0700
X-CSE-ConnectionGUID: YFAthsxWRcSHrluBSRTPPQ==
X-CSE-MsgGUID: RIDn3ctERMuSsbGm20QTfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163557039"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 11:49:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 11:49:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 11:49:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 11:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3KfYI7oOTD2DeDxqGUA2JzpjQEgg3J2VKrt9rFNtxU2pQe98e2P6eEKuzng7J3rXzFr7InDoBKWpG1TJvZJoDHESqp1KxaqcF9Um7vBHNHzz1pFgBbk4tU87U7vlUsfeGeT6IBWoeZww8YQPTy8nA/jKtNtoeHBUeGXF1bZT/OEWf93YkLr/A6jUM8Yu7zO1oBvtIs/ZHq8j5ku2YoLP1yk89MLo0RGBMk3Io1cWTwjp6/AmMrxAixEMm2Xtv2mZbXDHL/0CF30jc29ugiysLUdajsGJm2NcY58tBFlzTJrXU8vKYakHYoSZnFYpD18EQJvcW8SVqf4VLirXR3KYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyMD6YDiex3F38ckZ147g6ISyY90wI77sURDssHAlI0=;
 b=PUgqYSlN8+LP1qn+5vx4lRlJxSrg6cXRVD+maxjrE2tEXVbvUFaWXo2oZl0Pf5ahuoLmf0pPso6rDNOKC6y1GfS8EMb82HFP6RdeEJxUUy0qwmhCKgkGG3dM0YxxRtpcgEonZUoKISrjyfZZNvxRz+OEQUpbZ4ShqtpVOXCoFMUGI4ZfByyHADtW0of0HYr6ZlfaGBcaZlHiL/EjYrvukCJaIu1vU6WY0Yf1Jkn3li7HUaU9Xg0zBRynU2oRKKHi3x7RFKz90QpSmKIkHsW3KkPO7QtBWlsSNcb29vKYtfj+HRZh3uLUqwAaGexuXlHdbGkKpUoCpsJ1cW9kmhLRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 18:48:20 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 18:48:20 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 29 Jul 2025 11:48:18 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>
Message-ID: <688917724ab56_48e51008e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729162126.2427348-1-dave.jiang@intel.com>
References: <20250729162126.2427348-1-dave.jiang@intel.com>
Subject: Re: [PATCH v4] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da30046-7407-4eb3-a0ae-08ddced07d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnVtYm85VkhRTVJSeWUram04OVowTUFQRjJCWDg3Vkh5ZFc0VXRaNG5wYVRO?=
 =?utf-8?B?MzU1V2RXL0pxMFB2UnJNeEptbkxhaDJsVVdtSDFPUEYzZVdnTThWM2JBb2xo?=
 =?utf-8?B?ejl4U0dOUk80TG5maGIwS2pmWDBZSytIZW9HbUxib0N0MW1qMWdtZ0FvMkRU?=
 =?utf-8?B?bmI3SGdFekowN3A3TFcrRGhLMzRQR2dQalNyRXZMSDB3M3lEVFFxM2RyR3o5?=
 =?utf-8?B?NE13bm9hZklFa2daRUxSVG9FVkdIZXpxdnh6ZVNydSsreTNURWJuS3doUjMy?=
 =?utf-8?B?TTAvWTRsVEV4N09hZ010LzBqQkZ6SmVUTnNwSFZMZVRVUGdFT3hNL215QjJp?=
 =?utf-8?B?MlhGUXZiMXVXV240WVBXN1REOWdOQjBoQmlIVXdYc05zbEJsQWhTQXVXQjVj?=
 =?utf-8?B?bDdnZGdrN1FvVmpTam5UUCtxc3hzeEpvSXFLQXhjbUdxbzd0ZkVpaVIwcVl1?=
 =?utf-8?B?cHNYSWZVd2s1QmpFNjRZYXk5ajhyc2JjRjdVZHg0YVY1SWdNT0xKQjY4Q0ly?=
 =?utf-8?B?NGNHREhkYmZqbFpMWEt6TTRtY05SaGQ4bElwamdyZjlIVWFXZHB3bEFqdHNr?=
 =?utf-8?B?bFFvaU1TeS9EL0tOMkRxVHA3UkkzaG5GWHRyMEsxQ1ExNEkvKyt4Y04vNDlD?=
 =?utf-8?B?L0hnUXBEK2RoZmY2NG9tK0dCRUtKN3JHbTYxVUZLb3o1blV2Y3YvNDhXTU83?=
 =?utf-8?B?UDN5cHpZdFNOa2s0MitBcnZ0eTl4OW0vMk1ZRDJ0b3Q4YXV6ZzdTZmpGVmU1?=
 =?utf-8?B?SEtjRFBGdWNhNVV5WGNISXB0cHVXSVljeG1GUjgxZ0hVdlUySjNpOThjaUlu?=
 =?utf-8?B?WmwxQS94SkhpRVdra280Y2gxcG9pYzgrZE9ZbWNWVVI3UHZCbUxuSk1oeVNF?=
 =?utf-8?B?WWFsL3FsbEdEVktrQlFLZWc0NDVDbWpoZkE2RDZZb0VzNlprcE1SV28xVjZY?=
 =?utf-8?B?d2hjUkhyU2hRVzJHOWFpWXZZbTdpbnZBVzFoMzVuclNiaDJCQTdRYTlTUUQ4?=
 =?utf-8?B?bzNQSStJOTJJNDR2SHlPTTJxeUxML0o0ZitGdWJaWi9SYVhLSXcrdmNyZEto?=
 =?utf-8?B?TVkxekZtL0d2Y1RxYjdSTVhyc1pVd3NXeHhLYmthUHJkUkt2VklxQ2lRQWMz?=
 =?utf-8?B?dTQxWHdLdktBRE12aTRja0xEYlgyRXlWZWxtM0FZN2xUQUplTHhZSWdGdVNt?=
 =?utf-8?B?SWpod210WCt1MTlsS2tScG44R3l6Z1VmejZqR1hSTEJpNkQrOHZPY21mSDc2?=
 =?utf-8?B?VVVCM01yalpnNEVFZlBIM2xIT3hFSzlwbmUzS2xqOXo1NTRoZDZONnlyZ2c2?=
 =?utf-8?B?eHRobEVmRWo3V1pQb2xzNy9EL25VMFZqWWVhclp6bU1DendnVlhzRWQrTHp5?=
 =?utf-8?B?MXVNNFZFdjBZK2hLN3lFL2U1dGZHZ3lYL0o2ZFVUUlBNYWZwQ3dlVjVsWDdF?=
 =?utf-8?B?cU1jUW4zTVZ2dXkvdjNhOEhnUVVTV2JDdldUdE0xOFY0TEVxbndPTkdJa216?=
 =?utf-8?B?NHFSZWoyYlVHREpWS1FMeWdTVjdmdEh1QlB2QWFEZVZ3QVZyay9XYWFnSVl5?=
 =?utf-8?B?YVgvd3drY3JCeWRjbkp3SWl0eTlaRi9ueTEzQTN6TG5uWm9PY3p2TmhlSFJ5?=
 =?utf-8?B?bmxudXdPTDlQRW1MNmcxcHA1TXpHUEVaRWJubHdaVTFyZWt1aHZTU0ZYWkp0?=
 =?utf-8?B?QTIwWEJuRVkxRmcrOWhMWVF1YVNCVU9vV0tuZVpqSEE1YU1oMzJVTGdFWVVC?=
 =?utf-8?B?MmVXZHlIVStMR0YzY1ZSRTFhWXVOZ0RVWDBZeWVDYXFWL09IeGpoQTkzRVVl?=
 =?utf-8?B?TDZSbmNiMzc4R0VmVFRJa3dIUjY4QWREWThtblhuaWxna1dZMzFkQmJBUVZT?=
 =?utf-8?B?T09TR2kwMm5QeTNHMjg0RlZRbUN4bEt1U3VMUlFsK3JudFNzOVVVdlB0RDR1?=
 =?utf-8?Q?UP3HXCKIcp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhFa1BYMVpGT3BWcGVSVWhSOWpOUWZaVVZLRWZnbWxDQ1FlWTJiZmI3VnFE?=
 =?utf-8?B?cWVsMVhnei9FOTFzOS9zRGpvWmc2QUFSR3E3YjRhVlpUVFZYaWlsNElQZk5n?=
 =?utf-8?B?MEtJR1ROU2U4OFNYQkc0OVM5MVhNQ3YzTGF0Q3lZSkRoVWs4VWgrcjVVUGQ2?=
 =?utf-8?B?L0o5OTMzejlCZTN2bXpGZWlzbWtEQ1hRbisvVjFTdFNudktBTHVrWDhzWlFl?=
 =?utf-8?B?czFUSUxxblh1cjRudWRQTEJScktBK3BRMkJoWDBrZGIveGRZbkE5YkJUb2I0?=
 =?utf-8?B?WHJmVE0wN1R1VjkzUERBeDVCR3RHTzd5eFRodEJTTGp0MXB1ODdaOUd4bnY3?=
 =?utf-8?B?UDlYTmVaV09rSnpRYW5PNlVyOXh2UkMxRmk4K0lFQ3RES1RtWFFJRmtkbTd5?=
 =?utf-8?B?VTB5clU5eFRNMms5RENkVUVoVTVEWXRreURVNWpCODAxblhJNlN3cldGVUVs?=
 =?utf-8?B?T3lQSDNpRkdrbEdMT0NhVDBGTU9PYytEcXdSTXY5UDRCZzB3WDJUek82Zkpu?=
 =?utf-8?B?Vm5UY3R1Q004LzN6emJpTXk5UjlaRUsvOEVvWmdsWGlzTEdBNWRhcm5jKzNL?=
 =?utf-8?B?QjRiRk00MEVUQ2lMNFlBM3kwclFQcE9PNTlhSmNiajlNOXRGcGt6QktCc1hx?=
 =?utf-8?B?dm05UGxwcFVJOHlBWE1jVHhkRlJ0R0ZSNGFQVFlkMlE3ZTNWMjNwZ0JXdjVI?=
 =?utf-8?B?ZlF6NHdHTGloR3RDVmQyOWthTmtoMXQ1R0NaU1g5U2FIejUvd1RvYW0rU1A1?=
 =?utf-8?B?cDkyaEVpNWh1bHcrZ2NKM2k5Mjl6WUpoMVdnaVc1RzNYV1pPcUxocE1GT0t0?=
 =?utf-8?B?Z015RmwrRGVzR2lESC9rc2NXdFVtNXRnWDA2dnhOMmhIQ0s1TkN1ZFRKVnlX?=
 =?utf-8?B?TzNoN0VBaDBob1VkZ1FDY2hxRlZ4dDZVVGZEOGN0blpVSnIzaExHQWpqbHFH?=
 =?utf-8?B?RkdlVDNZWDBBNGUwbng1OUovRit1VEZtZStYRXY2aS9ZTnJEaUZqaXdicCto?=
 =?utf-8?B?YzVnMjE0ckloTTZLS2xqNzJ5cHVDclhCVWJQeEFucTgySGsxUi9YZ1FHb0xU?=
 =?utf-8?B?YkRtQWpYZjBLSnQ3ZE91cjRXZ1pDa0lOdHVmY2VUSEo0dVNMb2k5a3lNTHl4?=
 =?utf-8?B?cXlMbnY2aDZGeE5rVGVOYUs5TGhxS2d2TnNFMnN0S1ZaQ2ltVWhSQVBaRmVn?=
 =?utf-8?B?ckwvaGVBYkZYMHlOSVg3SnFqMzA4eTRMdHUzR0dxV1VtVWRIOTJwWktub1VB?=
 =?utf-8?B?Y24ybVl6emdQbFd5bFB0MTQ1M1I2c1JSd0Jmakh2TSs5RURpRXJCWjdjdUJI?=
 =?utf-8?B?ejFGUW0zSjl6NmR4Z2JnZ3J5UThWVkMzdkc2OWNQNkt0NTArSDU3bTRRYzl0?=
 =?utf-8?B?YXpRRVNjNnVCMzB5TUFRMzBqZ012OEQxL1Rjd3g4aVppVWpXWnZHQnhSU3dY?=
 =?utf-8?B?YjBBWThFdlY0b3VHN0hycDhDcTRrb3JLcFNxc2ZBejJsS3lsQmY2di8wNDg4?=
 =?utf-8?B?Qmtia3p2TEwxaFdzNUJ2eCtlZmhtaHM0YXlHRjg0Rm83KzQvbnR4VTRuNlM2?=
 =?utf-8?B?SVhmbWJnUkVjMWFtUklhd2syYkxQNHptd2ZTSllqVVAxVjkzc0JFak9uWmh6?=
 =?utf-8?B?em8xTE5VWGJiTGRZb3RadDhsZFNVUEtOV3lkN0VMNTZNZ1MwUWo3dWxFTnJ3?=
 =?utf-8?B?a0hMMlk3VjA0M1JwTTJGcWRkdkdCRkJmSEZqcmMzWWRTRWZZcE5URnZYWFc0?=
 =?utf-8?B?T3dWNi9odGEwMFR4dmcrR0QxMVFxNDhOQXZ6T1FYek9xbmxvcW1pbzZlNk41?=
 =?utf-8?B?NVV3WldUT2RsbnhzN2JXdXJ1YUNXa1pNZkJyRkhDM2xmeUNuZGRUTTkwaWR3?=
 =?utf-8?B?Z01Mei9ySVd6eTFuZEoxRmpkMXVUU1pvcGlBQVdXSVJXSSt4c0pSV0w0NkZH?=
 =?utf-8?B?czdWTjhpdnkyK0dsMWwvMHZGV0ZlUjVtbmQ1SkFGNEVDM1Z0NnA2c0JUWDJj?=
 =?utf-8?B?MnhQNElMcFhOYWw2MmpLUUZSWXd1cTIyL1VOc0gydjFnTkF1U2ttVlNHVjJG?=
 =?utf-8?B?KzF5VUxtdG9XWHlZZkVIRllCaGhjcnprYTNCdUFWZ1NMNkZDanFpUUNOYUdo?=
 =?utf-8?B?ZkJEL0JHSkJWWm95TFlOQ3RRMzhuK2prUmxhNVlscXZTTjdLWUVjNXF5TjRn?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da30046-7407-4eb3-a0ae-08ddced07d1e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:48:20.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOJCYQUI+qklENrH4TbE+7lDzHcwIEQGRcdn0oFutcgOBgkg+ZgDYZNtq5pwgDRjln3nLaBWoYWK9qrmlTiqZ3yK/QoagikRIgQ9W5/44PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Drop PCIEAER dep. (Dan)
> - Drop header prototypes that can be static. (Dan)
> - Use PCI_ERS_RESULT_NONE as return. (Dan)
[..]
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..e9fa8b8e45f5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -136,4 +136,10 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +#ifdef CONFIG_CXL_RAS
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +#else
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
> +#endif

...but the only caller moved into ras.c? So, why not the following too?

-- 8< --
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bfc05f95f1fd..f796731deedf 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -160,10 +160,4 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
-#ifdef CONFIG_CXL_RAS
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
-#else
-static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
-#endif
-
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index da301f5e163c..6adc52abd0af 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -331,7 +331,7 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
