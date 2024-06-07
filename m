Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB133EE
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723763; cv=fail; b=SG1gn8eCN4ECcvJgvAwdbG8LIM4a+0nOCdx1a9sHuN04y+yGoF0qqsS909ARV2umZjPTsRjjYMZLLsT0sdp33zROECeijh96kRU+KbEgiWrztGz/tt2sm3joKxhUxZg6JVP1QCoSB61QdwMWwbpHWR6e1mJXvJUZgU3pFHH2kGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723763; c=relaxed/simple;
	bh=JddUufQ3K3ATCrwDw4+4F3mFdrnqZfKrKG52OLPbmAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ugs6H8grCk2iq7YJG2YfxQUpGuzTvfg92q7/h5o89pPuXg/L5yxJagp6SglfMvb3TBP30Y9DfZTOCY58lR9jfmcXlSH3CTFeQWT59/dmryoIlFSHSFRIW56J+dgh+SVNyfvqmzEswiseUBnZi1TZNU+ShKtNpcHHsjCTkgHIW9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJjHrOyj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJjHrOyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717723761; x=1749259761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JddUufQ3K3ATCrwDw4+4F3mFdrnqZfKrKG52OLPbmAU=;
  b=XJjHrOyjmIroXZLNjhSS34nXenbzrkz8+Cz00mKAcDWphktETrgIGW/o
   AFYi1bXJ9BoMM3m4bCJgLawtTO4FWsFXOLKdWdXwbhSFAhfLLsPrVqpa+
   Wd0pfZXX4KuOPRScz9lqpkKFH08VYKOASXaXcJfllpWIOugRFq+CJ5sI4
   yepTbJt3Ds59MgTEBw5Gvg1uvpduL9uSOtiselV3R+TOxFMYS7F8mIIBL
   +nO9xVyoYPkToej+oinCfFvhl3iK+9v1J7kBdFRfWYNeTWRRLDzXxL1nI
   qp2TeV5v3M0EWBn1KC2B/TxuZKnNkxIFLt8ysQgajpM2QhXey1/4R3oPI
   g==;
X-CSE-ConnectionGUID: PJclBpAyQxCr7u8DAmBblg==
X-CSE-MsgGUID: txcY47upS5+/WSX/rsm+IQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14267318"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14267318"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 18:29:20 -0700
X-CSE-ConnectionGUID: 0z9F7owzSi+2C8Sl5agJAw==
X-CSE-MsgGUID: +xDUtuOZTAOmsuhpSMPSEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61366190"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 18:29:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 18:29:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 18:29:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 18:29:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 18:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxZSStm9nHXwRstMzi6v6AvLd8MniSRlLf7H3/5RWcFa/8MZOaNabECkJlToIxseP1rjTz0sfzW0tPA6Q6XdAELQzIMtc+YtNfUX+CjbUbFH5QXnwyHbbp+dR5A3vd35GBNS+mbXt7K0RPWTsBMoz/ERXHzt6PXJJI2CtRAQu0jLyDQVZRpXT6x7bKDAsy9UzYfDX1dVKf9HNGLtW1/MlW2ORxB+edLt3q/t463MNofK4EAGJzzzW50P0Mga6+F7gT3aSQIBgkD+hYy/0PJWpytjHfv5H3r/tq7IPBWtz75z9AirRH1tdc9Fyfg1UecvcciSgXns390xIBaABD8uJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB5RpGT4zvdJZoTZnRmQalMdpBJYbQXTsRCMeI0aJLg=;
 b=FS7a+1uJKfGrqiT8P8hQZpt9WOb+AwuZgwR2NQn6J/KTNhQSxKRtJVep7JqB0CdEmMshe41lO39BPb2X6SZaW8ghWsyKmRjcLxeCLfBJy91co9wSP1B1fTxWGoTXyDnNvFK/81NG5xMIgirGm/ZS500lIB4lnlrKprPz0M79J+WLrAuDsZFZ8WGBjnREcGP08UvZ4SDdczGSFaO5rMPevw82S1UFz6S+zPeS1P8aXQv5XrMv3qJZJsBK/bxG21e+F6vaU+witbZyrWiAsFPTCNzVPMZyqGeJyiP2dmxu6sxoZFgZpdLdOj+k/tZbizn5ativX3D8IqvBgQ/nB25ObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:29:17 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 01:29:17 +0000
Message-ID: <56dd0615-b845-4aec-aaaf-05a17807188f@intel.com>
Date: Fri, 7 Jun 2024 09:29:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20240531070229.1596811-1-ming4.li@intel.com>
 <20240605125707.000064f8@Huawei.com>
 <2e4b2584-f1f3-4e4b-a604-b2db4a28b5de@intel.com>
 <20240606150903.00005730@Huawei.com>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20240606150903.00005730@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: f014e95d-b40b-4518-0ce4-08dc86913f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWw2MHdQYUtKbCt6Ulc0ektGZUFEK2RKdkdrSXVhN3IrdDI4RDNtQmJmV05F?=
 =?utf-8?B?bk5BYlU5SEZ6YkE5QnFRRXBQdnJZNnFpVitZVitJZ1hqblhCYXgyYWdOdWcr?=
 =?utf-8?B?YzVYVFpvTENFQmZHUThiZjNNRHFMMkpsWTRKSmJKQlJjRlZBc1Eyd0pkaUhE?=
 =?utf-8?B?amVpQWFza3dkUFZJRFNteGRxb0tka05KOTR1MDg3YU1NMHI2SDBSK2VtU3c3?=
 =?utf-8?B?SUFlSHgwQzhFelZLcGN6WDJtc0VMU3E4NkRZQ0QySXZLWGR5Unl0WjVSempM?=
 =?utf-8?B?VEFwY00yZDVZczNUN0RlZGRMMkdBM00zZkQyemtFUnN5WXdWYkYwTHhlZWxs?=
 =?utf-8?B?SWEyVzk2ejZ0Z0ovdzdPbnh4YVlIbncrWG1JdWsydlhKSndNUUNVcGFPc0Y4?=
 =?utf-8?B?RDRQL0kwaHBHN05ubkxoUWoxSmpObFFQUGdTUEszTENjajI0VHcxd3BCMWMv?=
 =?utf-8?B?Qmw0dkhnYzhPSzhaYklBbkRFeWQ4M2dGMWN1czkwZG1NYlpwRHd1QldVZDFG?=
 =?utf-8?B?RGllT3E3L1llV2xuemU0Q3RtcDJVVE00RmxTVTc2R09abEJRMXlIb2NFMFBN?=
 =?utf-8?B?Y1A5bDNLQktDR1VrK2VIWE5UVXE1ZkY1ZHdFOU52S09lYWt5NVdKTlZ6U09F?=
 =?utf-8?B?MEpoUGh6bkN1aXlVTW1WMEZGTjFqVGxSQURkaEsyaERjMVNxOUhGRUtpL013?=
 =?utf-8?B?b2NRZFA0b2IzSURFaUJ6UWwzSTRGalgwTE9SeDZ0b0cyYk9LaDBQUXVjNlda?=
 =?utf-8?B?RVdVV0RhTzNRQVgzTkxlczMzY2FIOWxzTnEzQlhUNEZGRnBDY1U3YzhTY3pT?=
 =?utf-8?B?Sk1wcjhMd3VHRGFTQ09UOW9JVUE1QlRobWpnNlZSYnEyTTAzTW9iSE9YRzV3?=
 =?utf-8?B?dzUxQkJ1NjhpUUJkeVp2RTNuOGV6TzdYM2dMcmE2dUNqY2FmRFR1eWZGeFNF?=
 =?utf-8?B?RlhYZllORTg1SUtYMjFkMzVjVCtMNzZMamx0U0F5Wmc4aHRSbkNwUnlVd1VO?=
 =?utf-8?B?UDFpUWZibWxlanB0a3VLbUZMWVpSOXVKREp2Ynd2QnVoUElHZzF1R2hySzVp?=
 =?utf-8?B?WHRLUEY0T0xkU2NNYitwYUFRNEpmK2prbEc4SEgwaXBWWjU0UmVPejJCR28z?=
 =?utf-8?B?ZW5Nb0RlWkI1SUl3SXJYdVhwVjFJYmpNVWJEMlMyNmFoTWlUZ1FEMjNtRWNX?=
 =?utf-8?B?YU9qU0JoendubDRDMnFNUEwxaHR4OExrT05pejV2eHoyNXNKeGNzZERUQVQ3?=
 =?utf-8?B?TnVrTlBDLzdQbGNsU0psK29EL21wbm5QMnprV0tjVkt2T21hN3hQZ2YxTXBK?=
 =?utf-8?B?RnBleWZTRHhsOWF0OVAvUjd6amJ4UVJubnk0SnZSbGdaeTBOMnJ2WVpuOWsy?=
 =?utf-8?B?aDN1QStMQktVMUFnZkN4RFBCWDJYRUhjYXN4QmloWjdSVXBHY2dqWVBweXo0?=
 =?utf-8?B?WE8vQXYrS0F4Z28zYlZ6Mk4yWXRYeWtCcW1KSTZxcU9ydWZNL1JNUi85WWgr?=
 =?utf-8?B?cG85WVg0eXZBdENJYlgrZXo1cEFUQkd2aGpaa3REUjY4UWw3NW02cDJHeW9q?=
 =?utf-8?B?UVdOeVBnYmRoNGlrYWxQWjhtZlE4NUI0R0pmSXFSMzh5cmEwanQyRTdBWWxa?=
 =?utf-8?B?OVJYOEFZYjRkMTl6ZDRhT01HSjhaQzl0RWE0TXFMYUNGN0xvSTJGRno2UkZU?=
 =?utf-8?B?M3U5ZzFoLzlXWEJ1NzRaQjBMYUlSbnA4VWdPcytRdTdJelJkWmVuRjFLWjVs?=
 =?utf-8?Q?hakp+rt7GTQcBDlhMnZzel8Hvl1uskIjm3Sno+T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2J0eUdiUmhEaW56WW1LMXhWSHA1RFBkMHJTczFWSjNKYlNUMXBad2hYSFBa?=
 =?utf-8?B?dWNhYmwyNis4UzlUV01CS2grNkVUSGZ5aTVJSVVFN3BXcW5CZ2pnWkhVc1JC?=
 =?utf-8?B?ZXN4aFhNMG9zNG5mQ3Ywa3RNS1JKbWJxN01kd1p1MzE1RnpST3M1WkpaVm1U?=
 =?utf-8?B?aUJ2VFQzN3hKa3pTSko4VUtjZ00vZytCS0UwcGpIdkQ1clBhYTE3aFJkeTdJ?=
 =?utf-8?B?OW9HU3RpTEE5d2tsQlR3UXVmY2Z3WmlFV2RKaGVqRWx0cUhreHJMcG0xSHhT?=
 =?utf-8?B?TVQ4ejI4Qk9CM1N1Nm5GT1A5bVd2Z2pTVkxJdk5GT0krYlN2T3JOSlZ0ZERO?=
 =?utf-8?B?dEk2Zkl3UkgyT3J4Y2dqdDBRU2V1Z2o3NGx6NDEyd3ZyRHJDV0tIam5EeENp?=
 =?utf-8?B?aEl5anN5RnhUUFgzaWJ3YVo1T0FSR2t5cDBEVXNmTEhPbWhsWXZ5VS81OXZO?=
 =?utf-8?B?T0MrVlNXcitiNjJ0WXNZSUJaVjN2dlQzTVA3QlBZZUJHUVliTjErS3A0S244?=
 =?utf-8?B?ZExZWjM4OFpCSFpmQnlNSnFVUHk0SnJZNVRSclpDa0ZtemtnZGgxMXczRjJm?=
 =?utf-8?B?RUt5bjZ0OHZJdjRCM0EyMDlCaEg4S3BhSjJSdGo4SWxnU29KcHBKVkZDQVlr?=
 =?utf-8?B?dE4xcm9HcDRpUGhZN1M4UVdja0ljMlNhMi9NbmdXeldXZHdBaWIzVDdWd042?=
 =?utf-8?B?dmoyZkpwM20rZGFUcjRjNWppQ2xCVUhiQVRUSWRyNVBnU3J1NjgzS0Y1TU1U?=
 =?utf-8?B?OEE4RGM1eHlNMkowOGFGcmptNkZLSlVwUkVaNTFlWDZGVVBUZHVkSWZSNFpD?=
 =?utf-8?B?SVpERjFvMWhJQUprenBKUHYzNEdFYWVacnVyWFJKY3Jsa1prMmhlVjNhMitx?=
 =?utf-8?B?UHVTSkwrOE03YkRoRDFLbkZXNGFDVFdmNU1YRFJXd0Y0NDNQYzk2U0dTbXpQ?=
 =?utf-8?B?SVFqL0tjLy9qem1Ec2UwbkxIK1BFTU5ud0hDSW94YjExWVdmOVJ1QmhFUVZM?=
 =?utf-8?B?TUJsNm5QNXRiTVRyUUNQcnY2ZVQ3aXBFSnNZM2wxSWhJQ09XTUlGb0p0QTI5?=
 =?utf-8?B?RlUvY2NHTzZycTdmUC80cEdQOElManlFclNQV2pteGUzNlFWQ0VQUWQ1ajQw?=
 =?utf-8?B?WTJ5Y3ZGOE9GMVEyZkcxZjBlOE5rQkMyaThqdzZVYXBRV2wxWkd5aXo5ZGF0?=
 =?utf-8?B?ZDBsdzFFNHRneEV1ZGF2alhSZWFvMnRyREtEVlJlRG5hYWU3QklYUjV6VjNr?=
 =?utf-8?B?RU1naWtYd1VOVXRPbUhaVkJEQmR6bmJid0d4dEJkbzhLZ3BVczliOExkV0g1?=
 =?utf-8?B?MXhPcXFkYkVybnE2Rm9EYyttdkhGMFYvMi93Unl2cUNQYVNxM3p2YTZUeHlh?=
 =?utf-8?B?dUtsa0VGRmRESUZDa1VYWDdGdURJQm9FM2ZYMFFGY2FKYnRUTEZqczZzTmV1?=
 =?utf-8?B?RzlaaXh6SmcwRjdab3d5VHZZOUlEcWZKM3ZmR2JUYmxUWDRuU0x3WjBnVUpX?=
 =?utf-8?B?eEozZkpnNk8wNHlWWEYzVVlPdU5lRThJbXRTT2NwV0lNVDl3ZXdzYzYybW1t?=
 =?utf-8?B?VnJCMlJud0t0QTRDVDJvdmpKL0FZRWM3MWFVY1l5eVBRK0x0bi9Ua0xTTEtF?=
 =?utf-8?B?QVk3dExMbkpaQk5pSXFEWnZ2bEU1NGVsVmZQU0RYUWwySERvOUtMbGtVWVpt?=
 =?utf-8?B?WFNVK29Oa3N2OXNMMEFvdDMyY0NSUC9YcGhRRHRPTm4xVm1rdmtLeVFKQmFS?=
 =?utf-8?B?MnpUc0VKUjJGbEI5bFFpZ2l4WXh4QmQ4M2tHUHA1anB5TjAwZ0xPS0VPUjBQ?=
 =?utf-8?B?czJHU09lRURXb1pJRVVVN2RaNmROVkVVY3pzYllwNVg3ZUlaMFRlRVpHYUVv?=
 =?utf-8?B?dzIxL1RxTVdrbEhYb0krd0xsTVRlclNPV3RSR2ltTWFaS3lzRGtlMjhDOHl6?=
 =?utf-8?B?YnRMVFk4c3kzSCtNMHM0N0xYbi9QWGhFVkpJZ1Z3Sk9BWmpHc0lWVlN3MnVq?=
 =?utf-8?B?cldsaTMweTB6NU9tRmxoclVKV0ErY1Y5ZTZaNW1VWWUzSDVMbTVHc2NDMkFv?=
 =?utf-8?B?VTVqSWxwMEJqaThpd3RNalZUZjdmZkIvaEtBdjV6OWJuRXhGbnZhMEFWYWN3?=
 =?utf-8?Q?ZUBlXiVPHAd4tmTWLJMKMq1PV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f014e95d-b40b-4518-0ce4-08dc86913f42
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 01:29:17.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3wD9o1MAnLO7jffivFbVIyxwpmuEQ9Kg79FaoLaj5xNzVxFtsQdlbjrkdcAH/1wufrEdVp/uuF1Ex6wfeEXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

On 6/6/2024 10:09 PM, Jonathan Cameron wrote:
> On Thu, 6 Jun 2024 10:30:01 +0800
> "Li, Ming" <ming4.li@intel.com> wrote:
> 
>> On 6/5/2024 7:57 PM, Jonathan Cameron wrote:
>>> On Fri, 31 May 2024 15:02:29 +0800
>>> Li Ming <ming4.li@intel.com> wrote:
>>>   
>>>> When CXL subsystem is auto-assembling a pmem region during cxl
>>>> endpoint port probing, always output below calltrace.
>>>>
>>>>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>>>>  #PF: supervisor read access in kernel mode
>>>>  #PF: error_code(0x0000) - not-present page
>>>>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>>>  Call Trace:
>>>>   <TASK>
>>>>   ? __die+0x24/0x70
>>>>   ? page_fault_oops+0x82/0x160
>>>>   ? do_user_addr_fault+0x65/0x6b0
>>>>   ? exc_page_fault+0x7d/0x170
>>>>   ? asm_exc_page_fault+0x26/0x30
>>>>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>>>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>>>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>>>   really_probe+0x173/0x410
>>>>   ? __pfx___device_attach_driver+0x10/0x10
>>>>   __driver_probe_device+0x80/0x170
>>>>   driver_probe_device+0x1e/0x90
>>>>   __device_attach_driver+0x90/0x120
>>>>   bus_for_each_drv+0x84/0xe0
>>>>   __device_attach+0xbc/0x1f0
>>>>   bus_probe_device+0x90/0xa0
>>>>   device_add+0x51c/0x710
>>>>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>>>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>>>
>>>> Because the cxl_nvd of the memdev is necessary during pmem region
>>>> probing, but the cxl_nvd can be registered only after endpoint port
>>>> probing done, that is a collision dependency, so adjust the sequence
>>>> between cxl_nvd registration and endpoint port registration to guarantee
>>>> there is a cxl_nvd in memdev during the pmem region auto-assembling.  
>>>
>>> Perhaps call out that the root above a parent port is the same as the root
>>> above the endpoint seeing as I think you are starting the search from
>>> a different location after this change.  
>>
>> Hi Jonathan,
>>
>> Thanks for your review.
>> what do you think if I change the description as below:
>>
>> "Because the cxl_nvd of the memdev is necessary during pmem region
>> probing, but the cxl_nvd can be registered only after endpoint port
>> probing done, that is a collision dependency, so adjust the sequence
>> between cxl_nvd registration and endpoint port registration to
>> guarantee there is a cxl_nvd in memdev during the pmem region
>> auto-assembling. For that, change cxl_find_nvdimm_bridge() to use a
>> port to query the ancestor root port, it helps to find the root port
>> of an endpoint by using an endpoint's parent port so that cxl_nvd
>> registration can be finished before the endpoint attached to the CXL
>> topology"
> 
> Perhaps this wording is clearer?
> 
> "The cxl_nvd of the memdev needs to be available during pmem region
>  probe. Currently the cxl_nvd is registered after the end port
>  probe. The end point prove, in the case of autoassembly of regions,
>  can cause a pmem region probe requiring the not yet available
>  cxl_nvd.  Adjust the sequence so this dependency is met.
>  This requires adding a port parameter to cxl_find_nvdimm_bridge()
>  that can be used to query the ancestor root port. The endpoint
>  port is not yet available, but will share a common ancestor with
>  it's parent, so start the query from there instead."
> 
Sure, will change it in next version, thanks.

>>
>>
>>>
>>> Other than that looks correct to me.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>>   
>>>>
>>>> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device
>>>> registration, delete the workqueue") Suggested-by: Dan Williams
>>>> <dan.j.williams@intel.com> Signed-off-by: Li Ming
>>>> <ming4.li@intel.com> ---
>>>>  drivers/cxl/core/pmem.c   | 15 ++++++++++-----
>>>>  drivers/cxl/core/region.c |  2 +-
>>>>  drivers/cxl/cxl.h         |  4 ++--
>>>>  drivers/cxl/mem.c         | 17 +++++++++--------
>>>>  4 files changed, 22 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>>>> index e69625a8d6a1..31b398c13be9 100644
>>>> --- a/drivers/cxl/core/pmem.c
>>>> +++ b/drivers/cxl/core/pmem.c
>>>> @@ -62,10 +62,14 @@ static int match_nvdimm_bridge(struct device
>>>> *dev, void *data) return is_cxl_nvdimm_bridge(dev);
>>>>  }
>>>>  
>>>> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct
>>>> cxl_memdev *cxlmd) +/**
>>>> + * cxl_nvdimm_bridge() - find a bridge device relative to a port
>>>> + * @port: any descendant port of an nvdimm-bridge associated
>>>> + *        root-cxl-port
>>>> + */
>>>> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port
>>>> *port) {
>>>> -	struct cxl_root *cxl_root __free(put_cxl_root) =
>>>> -		find_cxl_root(cxlmd->endpoint);
>>>> +	struct cxl_root *cxl_root __free(put_cxl_root) =
>>>> find_cxl_root(port);  
>>>
>>> This is a different port in the now earlier query (not the other
>>> path you update). As you say any descendant is fine though.
>>> I'd mention this subtle change in the patch description though.
>>> (noted above)
>>>   
>>>>  	struct device *dev;
>>>>  
>>>>  	if (!cxl_root)
>>>> @@ -242,18 +246,19 @@ static void cxlmd_release_nvdimm(void
>>>> *_cxlmd) 
>>>>  /**
>>>>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and
>>>> an nvdimm
>>>> + * @port: parent port for the (to be added) @cxlmd endpoint port  
>>>
>>> Would calling it parent_port make more sense?  
>>
>> Yes, will change it, thanks.
>>
>>
>>>   
>>>>   * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM
>>>> operations *
>>>>   * Return: 0 on success negative error code on failure.
>>>>   */
>>>> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>>>> +int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev
>>>> *cxlmd) {
>>>>  	struct cxl_nvdimm_bridge *cxl_nvb;
>>>>  	struct cxl_nvdimm *cxl_nvd;
>>>>  	struct device *dev;
>>>>  	int rc;
>>>>  
>>>> -	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>>>> +	cxl_nvb = cxl_find_nvdimm_bridge(port);
>>>>  	if (!cxl_nvb)
>>>>  		return -ENODEV;
>>>>  
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 3c2b6144be23..f0cafc7ffb45 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -2847,7 +2847,7 @@ static int cxl_pmem_region_alloc(struct
>>>> cxl_region *cxlr)
>>>>  		 * bridge for one device is the same for all.
>>>>  		 */
>>>>  		if (i == 0) {
>>>> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>>>> +			cxl_nvb =
>>>> cxl_find_nvdimm_bridge(cxlmd->endpoint); if (!cxl_nvb)
>>>>  				return -ENODEV;
>>>>  			cxlr->cxl_nvb = cxl_nvb;
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 603c0120cff8..e8fca6c6952b 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -855,8 +855,8 @@ struct cxl_nvdimm_bridge
>>>> *devm_cxl_add_nvdimm_bridge(struct device *host, struct cxl_nvdimm
>>>> *to_cxl_nvdimm(struct device *dev); bool is_cxl_nvdimm(struct
>>>> device *dev); bool is_cxl_nvdimm_bridge(struct device *dev);
>>>> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
>>>> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct
>>>> cxl_memdev *cxlmd); +int devm_cxl_add_nvdimm(struct cxl_port
>>>> *port, struct cxl_memdev *cxlmd); +struct cxl_nvdimm_bridge
>>>> *cxl_find_nvdimm_bridge(struct cxl_port *port); 
>>>>  #ifdef CONFIG_CXL_REGION
>>>>  bool is_cxl_pmem_region(struct device *dev);
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index 0c79d9ce877c..2f1b49bfe162 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -152,6 +152,15 @@ static int cxl_mem_probe(struct device *dev)
>>>>  		return -ENXIO;
>>>>  	}
>>>>  
>>>> +	if (resource_size(&cxlds->pmem_res) &&
>>>> IS_ENABLED(CONFIG_CXL_PMEM)) {
>>>> +		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>>>> +		if (rc) {
>>>> +			if (rc == -ENODEV)
>>>> +				dev_info(dev, "PMEM disabled by
>>>> platform\n");
>>>> +			return rc;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	if (dport->rch)
>>>>  		endpoint_parent = parent_port->uport_dev;
>>>>  	else
>>>> @@ -174,14 +183,6 @@ static int cxl_mem_probe(struct device *dev)
>>>>  	if (rc)
>>>>  		return rc;
>>>>  
>>>> -	if (resource_size(&cxlds->pmem_res) &&
>>>> IS_ENABLED(CONFIG_CXL_PMEM)) {
>>>> -		rc = devm_cxl_add_nvdimm(cxlmd);
>>>> -		if (rc == -ENODEV)
>>>> -			dev_info(dev, "PMEM disabled by
>>>> platform\n");
>>>> -		else
>>>> -			return rc;
>>>> -	}
>>>> -
>>>>  	/*
>>>>  	 * The kernel may be operating out of CXL memory on this
>>>> device,
>>>>  	 * there is no spec defined way to determine whether this
>>>> device  
>>>   
>>
>>
> 

