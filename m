Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF23F9FB;
	Sat, 24 Jan 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213806; cv=fail; b=gL4TVk82eOhM6Kmz4mMiIT5eJjU9S1RhNurBMTOQuHpG/VqBgfsklkZDXuWFbOyUGgYeuqVOCpW4IlcyuXaCUigOnt9p8Vtz04GxZ+LRXbuSg6bFfx2Wa3CHISGUP2CRBFZ5Www7/b+GXeMI6IWFbodO1dyYigkHWXGbt73J1Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213806; c=relaxed/simple;
	bh=pmcrmRl1fspWhjyb5ribB4SJWMvdMJfN+hMKqO2/s6E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cA9jWKs3pIDgomMQhoq65yjKqh/eQm9zNuJHCQxWZ0pu9OV8jjMq3flhUrGsxFKP1YxlDaFUwbKXMOycNEqBJQSCZz1sQtI1yr86B3aoETdJ4RAACfLkJrUsva+2CF1ofz+zNror9MkD+RTh7P04i+MxqZfRIGbDQarjSrw9nb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtRabT+U; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtRabT+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769213805; x=1800749805;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pmcrmRl1fspWhjyb5ribB4SJWMvdMJfN+hMKqO2/s6E=;
  b=CtRabT+U8yEkM6mMjufxsC/r/L67IX95ET/6jnfW26WOSVFbKQtQRcYC
   ELa/HtXflMzFmqlojf4wtsv9e1gu5kik4D6DAv5peo8V7moWs7C5mU0bT
   ww1pcvx0zUKRcJr3OR3rzTTPgwcme7+NUt5KM878e532nHl1jH/P155Le
   dodXAc4AS8TVT3WLjBDXuHf4LNv/uppuFhp75oelFzYmhk8YXvaWWsH9E
   cpG84v36LwlwuKP6WXc9Py7VdMEzMLFCCrAFw+POYz0QGcMYmu/Xq78Fe
   PhHwEsCJkgs5eoE4oIZmIySUvMvVB7Iv6QoSG10LvI3f+SgcFYROYtkmi
   Q==;
X-CSE-ConnectionGUID: 8KDLKWysRDGE07/wsHnKPQ==
X-CSE-MsgGUID: 80uzKwSMTC2rTndGSmLeAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70191232"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70191232"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:16:45 -0800
X-CSE-ConnectionGUID: AHsY5CFLT3OPrWGT4EfjUA==
X-CSE-MsgGUID: prqeFoQJQ8CK9Prq6oP1Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211276749"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:16:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 16:16:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 16:16:44 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 16:16:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1/4dRDQR+hyXq4bARWXTHaToHJMzu4Ui3wGLV8s2tjCvPi5FrRTMGvfM9Nc32FT5+9RhXnXhtHz21Du/uxNyOlXM+VvuEsEVyXVsL4k7wCBuPaZ1xUMLhtTq0gd5sVGpgtcPu+/jdQHOxE0csoN7AwHlCVpNCQcVwBg4DUhyhdwD6C/faZL1TAz3GjINJr6hB493HYHQF7rJCKCiYk5YPZ8RtguNmT5ZMmNaX8xlP9btqyIyAJQNKi66zS5lfdYEs9Af1I8Z1vqxVqki2pQXCUyq9MHQRd0rHHcPyI1liFu12gVqgrEzpTBf9z1ifdpzzCQ25NcbJmqxGZedms9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+jKDcmti5LAyprlr/1DmrfFLrvDkWqt/AihfkNb6Kc=;
 b=QRDh0/tSzyQIsvsS+f5+vP8QZqcsLvzrpFNU2w70TkyKipKL3bsfwNiSPD/pUS2mLaRDopgyhbl3cXUAJxMNfak+vByXewOe6eoxmVegDFw5Sf0s1AP9WhqfbLu7KZ2pH7FF95WeZoXbUHL3r+iyYQ/YdNa6arA77ynjCyg+v0rIQa0mtjwr/uIOigTraULRVXvFg7diMkR0L/QNxj9BTnvVVA4xyp2lIeb8vO0Rjo7soR0FFoFAYXRfdDeeIeLhBd9yfdfeVPC2iM7Zrtj37HPfPZc3Izcvvqzqf9K1PNxz23QtlZshjZqSG8995KMM0KtvWlmeV8W+SYwh0e5gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 00:16:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 00:16:41 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 23 Jan 2026 16:16:40 -0800
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.hansen@linux.intel.com>,
	<peterz@infradead.org>, <bp@alien8.de>
CC: <hpa@zytor.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <linux-cxl@vger.kernel.org>
Message-ID: <69740f683fc0a_3095100fe@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122015825.873904-1-dave@stgolabs.net>
References: <20260122015825.873904-1-dave@stgolabs.net>
Subject: Re: [PATCH] x86, memregion: Avoid big hammer from
 cpu_cache_invalidate_memregion()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaeec70-02e1-4d19-d140-08de5addd96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDROTFZHc2VNYzVpZlM3eGgrdkRlWUR1QlZQRHNxVGVPQTlvY1hjVHMwV2Z2?=
 =?utf-8?B?bW05alBCWW5Odjk4YTcxL0c3ZDhoNjlFZm1GYkxaZzFHQ0ZDczhGT24wd2FT?=
 =?utf-8?B?SnhWVDFEcGpuSTdSUWJQSTNXOUtyOW5oaWZSR2wzUkdLQXhaM1J1cWVKS2NC?=
 =?utf-8?B?N2xvYnNjdlVBTnZSdXkzV2crVHBpQW5UbXB3RTNndEg0TGlpLzlCQ1NEczlQ?=
 =?utf-8?B?dFZQOXhOOWZORXVXOXhYTnJuU0UybXZsd1pNbzNkdzFRdWxQclRXQklVbWVa?=
 =?utf-8?B?N0xub3ZMU20rNk9hQ2JhMzErVmR5cDEzTWVOV2w1UXE4N2lQM3FYaTB5ZDky?=
 =?utf-8?B?a0hjVGN0ZFEzRnVKTEZSMmVWWDNYcTJNb21ZZlA0VlpKMFdVNmNqN1o5bUZE?=
 =?utf-8?B?MFBacjR6dW9COWoxalJQTFl2SnIyRG1ReXVGVXJBWU9YcTBSS0djT25TMU92?=
 =?utf-8?B?YnhYemU3VDdMalNIU1F1ZEhteHlzeGZ5d1V6MkJNVGZVTEVFQ2pGTDRGMUlk?=
 =?utf-8?B?N3FMWndDV3VpdFpXVTlBbm9XYzE4M1R1RTJIRjVUQ3RQV2R6dmRlM01yaXFX?=
 =?utf-8?B?anVraEF4VmxYbllXbEpMSkVHcTFPNHNTOWVFclZ5UlA3UGYvQ1NrMndFazlD?=
 =?utf-8?B?STQ2Mm1ETDRFQ3NPQTlVbEZhdGlGSE01V25EaVBCM3dnV3FJR3A0Qm1LSTVU?=
 =?utf-8?B?WThjeDA3ZmN0dXBzNHIvWGpGTllJMjl5QmlSU3pTVVZPaVlHOEdJNm9Hc3p6?=
 =?utf-8?B?MWFlVXNpSmVTZzREd3JPOHFscnEvemc0RzgzR291NFA1YTRhUFZJc0hyWTdp?=
 =?utf-8?B?TFo3ZlV1Y0Q5ZGdLaGltVXh2SnFqZ0Z5S0xIWFJDOGxkblIydEI3VEQ4bEJQ?=
 =?utf-8?B?K21Kd21MOFIzT0VtbEx6em5JY2NqaDd0T2RsdS9nVGJaMS9qcng0OTE4dlpu?=
 =?utf-8?B?V2ZYMEZRbjU1QTZwZHRJU09NN0JEOGhva3hTbi9vTnRzZFQrUHViU3dDKytQ?=
 =?utf-8?B?aHBmUTRZcFRSN1FyeVIrSHcwM084UW1zaUFPeVZTcXA1emdzM1UvbS85azdu?=
 =?utf-8?B?Um5qcjFLS1NySVhEUW1aTWNaK0tOekFlb2gzRi9uV2o5S1ljY2F2ajdLU0hX?=
 =?utf-8?B?bC9QekVoeXlDaHJDTEVDTW4vamJxK1pRQWYzSXZKbjlMTHhPd3liTXRJRDlm?=
 =?utf-8?B?akVJL0I4Y2s3QnRGaTZPZVlvV1Y5ODRML1RtNXVSclRTb3VBSWt1Yk9mMGJk?=
 =?utf-8?B?Z2FLRTVyVXRpOFg5VXhISm1XanhwSVV2K1VPWXBWWWxoOVVjNlVkT2hrZUVP?=
 =?utf-8?B?akxROXRWU3U2SDZyTkFoMXpnbldKNDEyQ0xHNHBNb1ljb2J4Y00rZEIzckxT?=
 =?utf-8?B?Z3RRcUdFYk83aGhPbi9rT21VR2daN2pabnh2d2hqYnhNTStlMWlTY0dWMEF3?=
 =?utf-8?B?ZTdXTEY4K2NGRGFvZHFIbTNnMTU4aU92ZlNyTjlWbXMxeE94bmtwODVOa0Nq?=
 =?utf-8?B?SGVLYm42ckpUdmwyWURoN29WS0twanYva05IRURMNStNNzk5V0ZZRmViODlH?=
 =?utf-8?B?dnlPZnY1SDl2NGI3OFJpeVhzbyttUFNhQ2I4SHROZXZpVFJoQW4ycDVHejhS?=
 =?utf-8?B?UDMwMVR4NjZ4dkU5RkhGbXhOMlpTNzl6c3ArdEpaMURJMHNLeWluV013citX?=
 =?utf-8?B?NFhSRzVKem03T1Zhc01tWm9pNTdkOGJwL2dXcFEzRUFDOXpGSWxLMlFUTHhD?=
 =?utf-8?B?cUNaZXRidTFVVjJXSk5TS2s4L05sczNvOFFOQU9pOG4zS244K01vcVgzMDNU?=
 =?utf-8?B?eG1yNHd0Ny9YczZJMUNFd2JzZnBWb1ozT04xWDUza2pmL05iS2VxbHNQRjBh?=
 =?utf-8?B?cGd1TlNFRnJSTUFkODFSdGl2eE1DUnA2T0ZDcnpVaU05S2VYMHQvU292NTlU?=
 =?utf-8?B?TUh6QU9SOTVmbE4yQ3luczJtQ2xQb1lPVHJvNFNvZjJlODh6QWRrM2Z1U0Jl?=
 =?utf-8?B?ZlFFVTIxcE83ZVBqdFFDTmlKVXQ0UkoxdFVWTzIyUSs3NjM2YTZJamlQSjVK?=
 =?utf-8?B?cmpTejdNWFRtMERSR3k4cEJyb1lxNEFaME5ES21jWDFiT1JPVmlCcFNSc2lo?=
 =?utf-8?Q?zVNY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1TRjRicmJrbHZQK0VZdVBBZWw5dHM1bnFsZDNyejZLQ0xEbndsQ1RaZlJB?=
 =?utf-8?B?VjBTYnJlZ3E3bXNNNHNiZjFUZ1MvWXVjeEdKcmdTOGE1NjQ1enF5SitzaVY3?=
 =?utf-8?B?OEMraW9QTnNXZWZiTE1xdkNmRlJPemYwSFV6KzZPejNyeUh1NnhZNHlPMzNv?=
 =?utf-8?B?ZjFLLzRkMFZlYzQxVEpSdUdFSTY1a3pjckdtSmxJZ084V0FLMFFERmsxL2xB?=
 =?utf-8?B?aVUvN0FFWkRpTTlmU0ZkZ3M3cC9sNmE2SHFud1ROeDA4ZHFuMGpMOXRjQURj?=
 =?utf-8?B?ZXpEaUltaUJBV2c5cFc3cUh1T3JDcFdoY3pkR1IrZ0R1RU1uelRac2tXcE1P?=
 =?utf-8?B?b3JOTWlLK0FOcm16d2NyMk5zM3RUTlNqdzVsTVo2N1JEOEl5Zk5DRVNUa2wy?=
 =?utf-8?B?YThIT2JNL1ZUeVdCdkJYVnR4RDhPL1pSYkhPYTEwZFIrWjFWWmhYTitjMU5j?=
 =?utf-8?B?UzZFcE1aRmlZN3JFTVNaRloxck1iZXhjSzRLMkRPSEt2MzVJc2htVkdhL2o2?=
 =?utf-8?B?Z1M4UnI1VjFDR0FsUkl0N2s4UHgrRzRHUVQvZFhMUGUrMi9Md0lXOXhOMCsr?=
 =?utf-8?B?SGVYb0Vxem1qc1NQYVN2amFGdWZGeFc5NzUvWjRmcUtkNWNlcUxWNGt5WWxN?=
 =?utf-8?B?dElZVDFiemoraDRDc2xZOXRFWUw1ZWh0TER2SGJzTnlWU0pLU1g5NUVoSU92?=
 =?utf-8?B?NUxUajRvcmlsRmZRT2dYR0tvaGhESnNTQXlpWS9DSFRLU1NlNmNQYmNwR1Bt?=
 =?utf-8?B?aVNmc0VTYXNjU3hUQXJYek1FV29OeTZvT1lGb0xESExaQVZzeitVNUUxcW1i?=
 =?utf-8?B?bEpRemhnV2ZxUkJLMDNDeXYxT0VLOUFZeURZL3pvUENBdGU2cDROZWs0UEE5?=
 =?utf-8?B?Q2JDK1ZMZG42VlRsUGFLMVVYTGxEOExPZk43UThwcjQrVXlMWGdIMUhKeGdZ?=
 =?utf-8?B?ZCswQ0JIblV3V1gydnY5dmZ5UjJqbEZYVWYxNld3MFEwSVIxOW1LTUFlR0c4?=
 =?utf-8?B?WWdKVjM0cXRiblg2Vld1VGtQTUIySDFqak1EcHJxV3JFTVByT3NMUmJGZnNi?=
 =?utf-8?B?aHlaUG9LMFY4eFY0bFpiOFk0MWMvUC9NdVNsWmRMMWNSeUd4dTRrQVJTU09i?=
 =?utf-8?B?ZmZIWFcwdXlybFFoLzF4RWRYNm45aTkxWlVjMnVIMjdlSHZrMmJMMGozNTZa?=
 =?utf-8?B?V0FEN25mOStINUhDWnoxT2RqMFExOHpPN3JBaVh3RFR1YkpmbzBMaEljYXRr?=
 =?utf-8?B?SW0vNTlyMnpYTWEvcE9tUUJwWG1rbG9HZXdUT1BldFRacWpOcUkwOXF4enZq?=
 =?utf-8?B?blBaOStjRkUxQkRRdy9wS3VYMk03TFFMcCtITWVRQjB6bGhlTFRHVDIwVDE2?=
 =?utf-8?B?cE9DUTVCSGkzTTA3dGpKNlp2bU1yMHY4czFNS1poZ1ZGWFVCc0t1YUFJbmxL?=
 =?utf-8?B?SFQwY01hNk5saUxmOUJzTENYSEpOTlZjRXdrL1JGRW1RV1k2cDdIZnRiZCtt?=
 =?utf-8?B?V2RUUTRnMlRtSFpOUWZIMXlFYzl3ZHYvdkhIUklZOHRFM3ovbEU3REVOdkFG?=
 =?utf-8?B?YnZMd0UwdnkxQVh3WlVUQ1dxaUI5Z2x2WnhDS1dqT3YyOEFuYjNFK05penpo?=
 =?utf-8?B?S0J4aURsazJGWGN5MVRSWVJ0OEljNDdib0svMXJMb29HbGJhTkJ2L3Z5RElB?=
 =?utf-8?B?S1FkLzEycHg4Q2xkRW5PUEZTcEdiN1daa1RnV2V1bEEyaDhIbHAxdUNSUkNu?=
 =?utf-8?B?TExCV2ErUVQxOTlLZzBVY2ZYMWpsbVFLMXZCWDNiR1NzY1djUlFvenpIdWtG?=
 =?utf-8?B?VmJUencxV1kwOVFjUlMyaHVEa25nUXg1dC9HaTJ2RUVwZklJOUZjREYvYW9y?=
 =?utf-8?B?L0wrbkFpakF2bnluTkdTcnEwQXNwQS9SWTNUSW12SXV2WUc0U2xqSG1HWmNu?=
 =?utf-8?B?QzhUdk5TRW1rbUgrUTEyKzlBVGp5cUNqMVJENmZzVjhGZVhEMnhtOUNEZkpZ?=
 =?utf-8?B?UmE0NWlsQzBkR1R2SFFEa0JMMS9jY1dUZW15MldVclgyNnVmZGk3ZTVYc2gy?=
 =?utf-8?B?bkxxN0lUSjRWemtlQVk1cUJZTU9iVGNJQ1ZsMFIvdVIyUy9KbDlmbkFqcE0y?=
 =?utf-8?B?Q3lCRnN4MVFpNkRucGw1cU1RalJSaHd2WHNBMUtvNFR5KzhBZWRqMmltNmhX?=
 =?utf-8?B?dHR2UkI4UGwvUXVGeEE5OCtMeG1XaE5Sd2NvNVVDWGZXRmpiU2pCbkhIUlVO?=
 =?utf-8?B?Z2JNWDRJOVVBV2Rkd3hVR280TllIV0VPeGF3cnJZWCtaUEoxcFgwVVFiSmdz?=
 =?utf-8?B?L0NEL0I3Ykk3SjZaUHhlYVMzVGdrYisvSHdOOS9SY1pHZmMzeFRFbnVhWXBV?=
 =?utf-8?Q?SBrpZ+15Inj8gvLg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaeec70-02e1-4d19-d140-08de5addd96f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 00:16:41.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzTvECeBRPkef2NWtb4F2P1DFUfN6ZoPcvqJ1mD39VHqJ30hplIxswHNgqptmQccWIxKVaf8qHR0tcvdS6G3nzhr1A28Ba4zRDJpju/ZfW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com

Hi Davidlohr,

Davidlohr Bueso wrote:
> The reason for getting away with wbinvd_on_all_cpus() was originally
> that the users at the time were a one time at boot occurrence, so it
> mitigated a lot of the effects of the system-wide disruptiveness and
> cache destruction. This has now changed with users such as provisioning
> memory through CXL Dynamic Capacity Devices.

Except the kernel does not support CXL Dynamic Capacity yet.

> Lets instead use clflushopt and only invalidate the range in question.
> The performance of course scales poorly with the region size but is
> ultimately less invasive.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  arch/x86/mm/pat/set_memory.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 6c6eb486f7a6..4a1c4f6bec17 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -372,6 +372,19 @@ int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len)
>  {
>  	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
>  		return -ENXIO;
> +
> +	if (static_cpu_has(X86_FEATURE_CLFLUSHOPT)) {
> +		void *vaddr = memremap(start, len, MEMREMAP_WB);

How much of the cost is in the mapping management?

I was not expecting that virtual address based flushing would be
reasonable to call from all the places where
cpu_cache_invalidate_memregion() is called to do physical flushing. If
the concern is increased frequency of flushing due to dynamic capacity,
and that dynamic capacity updates have a chance to be finer grained,
then I would then expect some kind of tie into memory hotplug that can
invalidate cache using the direct map.
