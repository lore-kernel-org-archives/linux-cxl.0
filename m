Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06E21CC62
	for <linux-cxl@vger.kernel.org>; Sat, 13 Dec 2025 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765596993; cv=fail; b=Qqvn6tVe8034IPzl6NufVUUr3Gm6tXx/pKoXOfBMssCPP/xKrOQ139ND2DpRN0JLqxPx+tU9gkqkB5scXO552475aQvyJDXIMh7HLDsdm4joxLqHWaH6XnV6HLYY95r1RzwlsST0xSe62sFZSNb+7qXxUixhh0fxaWfOWCudn04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765596993; c=relaxed/simple;
	bh=s2/7nzQ5iJ7ER/XvskkkxPP2nYL8YQv0x2xX9jHQDi0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Rr5U1TYVS6GcmaiS7Bb+S70glVvd9cAYFyybqMnIfPwPQij8lycK8TyG6OPeYJUqfGEkuP3h4AX++JkwmTWCMNxBP97zIg7DN21cGoJh0Vs17It3uFaT3OxRXnZYM6BOpY2wlm6r46Lo++Vx73lzYWsWL9VUnpMsATr1wSfI4BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IleVQycH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IleVQycH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765596992; x=1797132992;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=s2/7nzQ5iJ7ER/XvskkkxPP2nYL8YQv0x2xX9jHQDi0=;
  b=IleVQycHVjNOQ7wiEL8l1tklU42qE2K2T/uFcd6rFObnZygQCqQ3Eejm
   UDpa/G94YL4qH8FGtJrtpTMaTZEKnq+y4I4zOgi0uMQjiZCsLUjrWcMQq
   ZOJ+g8Q3jL7Lsrs+ggnZc+tDmmwVXQEJmtrzuj/FGRhpV2apCYpI4bNsI
   1d/xkgOrnHn5EMCT8idYW835yjo3srxzWWuxFrtSvakkEs+Rhn5Wq2WFG
   bix+NjmUAkja06hL6wcoR4z/9zmqcE4wixyd77LIK9a1M2jtIbI1w5nN0
   vfeLUD2bxOfPWkTwkuw3eIk/BlqkiELDOH+28nF3XzvG5Sth+N6PRV/6J
   g==;
X-CSE-ConnectionGUID: +aOJPoajTVK1fzgnxvW46g==
X-CSE-MsgGUID: mY/qruJ+QlmTOhB9fXvcsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71456161"
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="71456161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 19:36:32 -0800
X-CSE-ConnectionGUID: faoDUTJWSi234guAjkQChQ==
X-CSE-MsgGUID: FuuT6t8dQmGb+LqEKsef8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="198068441"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 19:36:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 19:36:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 19:36:30 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 19:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfHgz7MKzPg42VQS0NhcPyVSL7fPlg+8AVWTbhL7cHhb9jVsUIV61WbbZq0h5Pa5nWgLq9ObW32eBShb5y1Ci+eMWQc9Rv/JI4rxkEC9W5/k8iYkgpedMMEFbEb+ONKr2x6Nf99cK0dBVA0GPdaNrRe3mwkNKYYYiYKUlZzwXCHZRHVERmKiVVrIlRQ7iR8oG2zmoBb7HwQdw3qbRDrZv2/bGqDHWdOcgjBnJIAjSya4wk5vfia8JWVCvOh1+TGgxcqjItux2RPrvYcw9EwnlaqK7ST5v9BD7L21RFqa+WlDGwJycZcxw+KkV6rIVszwOpQESl+M9WaEfXaPKC2qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlTanUOrUkYdfoYHFIM67HX847D0uHuNP6c8QJnFSnY=;
 b=WsdGaTiiPomvl374MnPYm8iLtKWlNnFerpMbdhBMakIOVLd7PIEUleNZ18xjwmpychT1IaWwBm+qbsYQiYAIuIRIwSKhBqGHdfXLY9Rxzb/bI3acsFHAQ3fsb02/G/d/+Xbwb6sAyOYi07rL9t7yNlNhP52lB1xK0Xrz0azsNVU/hEPXFwNY0a9++GggzxCY+0W/6uPy3Vou0LuSUxpHgvpys1p7bzVK1WYm6kiCvXOhnDGgiBmKbiQsjDt4N/dRRHsoiitQNsr8t+/Wr04i+iTpCha6N3fwFUcvc2taVd4OkoeyG1pTZjz9JOd2lGhSUe+juybHZp/KuDFqjCq6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sat, 13 Dec
 2025 03:36:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 03:36:28 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 13 Dec 2025 12:36:24 +0900
To: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>,
	<dongjoo.seo1@samsung.com>
Message-ID: <693cdf385657a_2e71710083@dwillia2-mobl4.notmuch>
In-Reply-To: <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7849fc3d-bc06-46e6-418e-08de39f8cc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5JNC9iR3VYNnpvcHhFTEordkg2Qys3K0xHR0VQczlhaGJGVWp6dnd0NnZV?=
 =?utf-8?B?ODlERVdLczQ0bDBiWVc4eW95MUJrMzBsbm4yYW9QbEFjR0lUR1pNcDNsbEdo?=
 =?utf-8?B?ZVdiZnRSTlBKS1VwWGgyc25VVkhMUy9NZnczeFNka0hMREUxVUxGclE1bHJ0?=
 =?utf-8?B?eHdUU0tyZ2lvN3U2dy9acjZLM0tmN011MWRibWpJNGR0bER0QmxWUDBxTm1q?=
 =?utf-8?B?WUJSLzBTZjVQLzVvdmxLZVlZT29uU1BFM0hqbmF0clBuamdQVHd6REo1amtQ?=
 =?utf-8?B?cHZzZnZzbkQyRWlGYW9rSUtMVHUzSXdTdS9sNHM2S1F1bUJoaVVPanlOaW13?=
 =?utf-8?B?aUxuZ2dkWkxvTTB5UGJ1Q284cVZwZWRMQkZMektqc3pyZGgrdDNHaTFwQ0NT?=
 =?utf-8?B?MEp4ck1mYnBXUXRtdTRyd0s4UGxNYXFmUXRYcWg2cnlYcml3eFlpZGo2MXV6?=
 =?utf-8?B?dlZvcisrTFRyYXhmU0lRdVBZS0hKaFZ5K1ZpNUxuRHp5UlFxRVZLR2I5K0pl?=
 =?utf-8?B?WlUzNjJoUGpaKzJDVnU2djJwb1ZiRUNpWk9pQVZCTlhBQ2RtajJPM3ZNcmtr?=
 =?utf-8?B?bHphWWx2TVh5OC9VazBvUkFZWFBrdGZSMUVxM21kbTdmWkJEam9VbzJrYVZG?=
 =?utf-8?B?OFZqSGNFV1FySlN1RU5iamhERFVCYU1DSUdyQmFsWkNiODFybVZnQ3dFTk1K?=
 =?utf-8?B?YmM1NzlJZnc4ZnJ2cURJRGtnemJ6eVhmTWE5YXFScFRybnZWUGw1VWdteFNk?=
 =?utf-8?B?UldOM0NLZjJQMHA1dTNHMmt1dE5rS2F2TExnK3RUYTZpaTNObExKbCsvbDhs?=
 =?utf-8?B?ejZvR1Bha2tSajlNVms1UGtaenk2QjhMbnJib2daVmFXaHV0SFZlRG1HNi9K?=
 =?utf-8?B?TjlodGpPdnVqUkFoSjgrdjJpODI0ZGM1d0JlK21SSFUrWDB3dE9LNDNIL0Jj?=
 =?utf-8?B?bHNmN082UDZreGEyN25MVGlRZ2J1SkE0ZGZGN2RUV1lYWXR4TGdhdEo0VVJT?=
 =?utf-8?B?bjZUNFNHWGlpZE1FbkNHNENZKzA0MUNTczBBQWJsK1NOSytyQ0ZMaWtHRXEw?=
 =?utf-8?B?MXVheUVhSVZvcnl2eHE3MEtaMVN0SWgzZVVZbXZ0TkFFTm5ZVUJYV1hGamRq?=
 =?utf-8?B?VDh0TXhobllQTi96QTZqUXMwc2VYUGxLZjdGdzJ1SGtwZXJENDdxUUttRVlT?=
 =?utf-8?B?QWljdEQvY1dYRis1ZXJvOHhhUDJUaTNFaURBdWp6VDBXc0ZaYTkxNkt1TkVr?=
 =?utf-8?B?Rm5jZWpDYWdmNG82eXM5RFZrWHlMUUE0a09LeDZoMHUyNklxR3U2N0VVc0xY?=
 =?utf-8?B?UW13dDYzUVE2YWxpcVNlVk5kZjNlZnhieEJCVmd5UzVFSFpHa2xMdUZrNzB5?=
 =?utf-8?B?dGVDeGdtMHVDdHdmNEllZFRsbEdudy80Rm1YWXFPTG5WK1lZOXdHK2Q0aWd1?=
 =?utf-8?B?TEpFK0VmYXBGamVjVlk1cThxN1l3NnFQSVNxMjgwRjZnT3RmcU80cUlEa0k2?=
 =?utf-8?B?MUVUUm9lWHJkbEVweTl4UkZPOWZ2NndHVlk5cHN0eStaZUtmM3c5L2NzRzhT?=
 =?utf-8?B?SG9sME50akN5MWYrMVJzTUdXY2Y4dS9uVW84UENXR2puMGd3TW9CS2JIbjkx?=
 =?utf-8?B?b2QrWkh3UWhxQlllNmdiWGZQVklEaE4vaWJGTDZiZk5Sam5BQ0pRbElaWWl0?=
 =?utf-8?B?N1Z2SGpraUh6R2MwdE5CR28vRHBKaXBGRUk5dnJDa3N6RlhrVXBnMHhoWTVQ?=
 =?utf-8?B?UGhoRXFLYzRBZ0xaR3RYRDVCcXZQYUdhNktPNENna25BU2x2cjVic1lseEJP?=
 =?utf-8?B?dWVSSDB5Z3Q4Q1FiWUxyYzIvT2U2VHFTWVBlTHc5ZVhwZER5VVo2UFFJWHBp?=
 =?utf-8?B?dTI2TXRrZlBSOG1sVlNFM0cyY05Pb3dabmtXSDlzWkxacjVkVmR5bkFsVnNW?=
 =?utf-8?Q?NFDwmUJp+esmSbO620Emt7mjq0E+L9S+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEV6L0pEWDA2bkVqMU0reG5oUUEvTGdPTjBJWEFKYzc4T3lic1VRMW9pY3ZP?=
 =?utf-8?B?RFBtL2tnR3J4bEhCSWJVYy9PUTBkMHFBVjhkTFArVkJiVXExcTdyT3pLM2V3?=
 =?utf-8?B?dUd3eVE1UnlsdmFpUE5LVlJPV2h2OWhBK3dXQTFWTDhkOHZ1eEdsY0s0KzY5?=
 =?utf-8?B?MkVoMUducmJ1OGRWQWlGT0kxWWxacnlGRkZLemFsaEZHdWxaRCt6NlJOYUlO?=
 =?utf-8?B?djRGY3hXdm9pLzA0OFJNcXRQdzh1aDZob0c3U0Frb3QvRE9vQXJVYjFBY0hi?=
 =?utf-8?B?VS9SUEh6MVB3S2NsV1VabENYNC9YVEphN0NVU2szeUlvUnFTNzNNZzJNV0pT?=
 =?utf-8?B?RnM1aTN1NGxPWmdDVERocWh5NWpFeVRQb2Z5cm5PL2x5b1pGekM5V2trTnFh?=
 =?utf-8?B?YVlEczNSdnphblJjMTZaTDNkMWNVMkhEaGk5cDNEWHdoZ2RDN1JtcHhBbXQ4?=
 =?utf-8?B?aXA3VzVlVFd4VVA4YnZwK2o1MEMwWWh3SWJRRlJiSTEzOEdPbEFQd25zclZX?=
 =?utf-8?B?QnJVQitDZTVvWm8yV2xCYlQvSjNuOVYrR3k5SHEzUWN0OXF0YlN0bXZXbHZw?=
 =?utf-8?B?VmVyN2I1NkhmQ2FxNnl2cStvOXJsUC8vNzl6bTZNYnRqSmZCSDZBcUgzS0JI?=
 =?utf-8?B?ZGZFSnhTUXpOSUw1UEZncXhRZmJYc3dxS01qSHlQQ0gwcEpqTEdFU3N2eThF?=
 =?utf-8?B?SnBDU2dkUDI5ekpGVGxjT3RHTW9KVkVoTzR4OUpSQVBNZ3NzRlQvbDkwNG5Z?=
 =?utf-8?B?Vi9XVGcvWmJxbUJTN3hrUzBDczM0UlFrNS9jTWVBdlV6QkFick1Wb0phbHNv?=
 =?utf-8?B?eDN4ak9xTHNTYkd4cTMvdFdQNDVIZFFJUy9XcmZka05wbXViZncyRUJWaitS?=
 =?utf-8?B?VWhOb0kvVE9peDFDa1k0SE1rSCtWSEhUcThaYy9LSytYeGFwYnoralJQeFZY?=
 =?utf-8?B?a0ZSS1VBeHhCMVdQWDhYOWE3WDVPY1o0ajlUaTlkVFg5NjJwY2Y3aUpxcDVx?=
 =?utf-8?B?ZHBUZEg2OGcrTUt6bVlmSXdmZTV1cmtMdG55REphVkV1aE1ZQlphWThNaUFT?=
 =?utf-8?B?Tnhmb1lhWG1iRjcxRHFiUlQ5SGhNdFB0d2lGSDN1aTdadkxGVkxEZkhyTEsw?=
 =?utf-8?B?VXphbjN0NytEcHEwdVJDWC9IcmZlNlhHckhFQ084Wjdqcm5xTlVZV05aZWFL?=
 =?utf-8?B?RjkxejJybGsrZkZyUndNUWJrM0RodE80VlNJb0dLNXYrNWdnSUtxREJ2L2J6?=
 =?utf-8?B?Sm1tSTB2YllROFhsM2RaNTdJVFNnNFVlWk5MOWZPeXhBMlh0MzZ1bm1ZV1d6?=
 =?utf-8?B?RHhkSVFEWldFMkFodEZyNWQ2cjdZdFQ5aEg4eUNYRkduWFlsS2FhazVTVU0y?=
 =?utf-8?B?ZitNc05MZkRYcVgyc1ZsOWg1Ymo4TXEyZEZxUWtyMklpeHA2Z05xZ2NXeG1R?=
 =?utf-8?B?UDhOZWxYQ1pQeVE3T0hqR25pb05Fb3luYXlneWJFWWVnZkVMa2ZBa1FYaDl0?=
 =?utf-8?B?cTNOdXBJS2JjLzk1aXlTcXVxS2hSeDBUMTdEQmtUenUvZnpPYTd6VFpQeXFG?=
 =?utf-8?B?UDNwSU51aURsaDlqTUlIa0U0bHJmUm9yUG9ydHdqNDZFNjR6MGx3L05UaXpK?=
 =?utf-8?B?d2I2b1NrZ2tNaFdyekNKbUtaR2d6Rndld2JlWmFxNUNab0ZPL2FENUl5UnBk?=
 =?utf-8?B?QmdKRC9jSkpZVUNBVFhUM3hMakYxcmZTcHZjcHhzWDNtbnZNQ2NvWjNENWxt?=
 =?utf-8?B?VnhQMDh4bmJqUTZ5STE0RmkyUGRuYjBsN2t5bDVibHZlUkJuSUtWT2hxUmVs?=
 =?utf-8?B?ajFSZVJkSkV1NDJIUW5rV0pUaG1PdDFoL1dPai9vREtqMDhPYll2UFdCV3lS?=
 =?utf-8?B?TWJ1U0xPZ0NqMnpBcFYyQXFCQWZZRWZqTDh1SDRoZzhSU3lJOUZlSFJQR1NH?=
 =?utf-8?B?N29BbHFjaXBtVDJ3OEpFbDVRZWU2RW5FcnIzZkZBcWRJNE5oUHBaZmtoN0dL?=
 =?utf-8?B?bXlwWnQ0RSt0OW9YdFRoSGdRaG53a2hQNnR1TElRZFdwYXhsZE9pQXZmT2Nv?=
 =?utf-8?B?Ny9FVUlGTDRSemlsNEcrSFpnM1JNa2pSM0NhWiszazZPa3RxdVV5TGRoTmpX?=
 =?utf-8?B?cnpUdjNERmFJdlFSamJsSGZGYkVseXJEbFNZMXhRd1o2UDZuNjFHTkdnaEVP?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7849fc3d-bc06-46e6-418e-08de39f8cc6b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 03:36:27.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x28Na9biGZZy9jBuarxfQ49NAMlnfDhEeneegHnD1nFv1vky+pn4QSsRC6J0cx4uSCXw/L4elBehVYWT8hENf9jMb0D15MTU4i5FaSoi5m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com

Anisa Su wrote:
[..]
> > Unfortunately none of the details presented in this cover letter really
> > show why the kernel needs this additional complexity.
> > 
> > Can you go into more details on the use cases of multiple partitions?
> > 
> From what I understand, the motivation for DCD as a whole has always been a
> blocker for the entire series. However, this year we've seen multiple vendors
> demo memory pooling/sharing at SC,25[1], as well as the development of a 
> controller that supports "memory pooling and sharing across 
> multiple hosts" from Montage[2].
> 
> The flexibility and control provided by multiple partitions is
> an important capability of DCD for enabling composable memory 
> infrastructures. IMO, adding multi-partition support back in from v8 or
> picking up this patchset would strengthen the series.

Can you explain the use case for multiple partitions per-device?
Describe it in terms of what Linux loses if it never entertains this
aspect of the specification. It significantly complicates the ABI for a
benefit to Linux that I am unable to articulate.
