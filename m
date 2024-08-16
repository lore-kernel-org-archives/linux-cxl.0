Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D83823CB
	for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791417; cv=fail; b=AVPjr3HqRL8E+pIamsEkNXzDTAxVf9P3IpDMOXbgyWGFsCkwFMEymL2QrIL/1gw9/+G04UlzPT2Y5UvVeWdruYFEQemdQOCvlb6f+elm1Psb+V4jtDuWIZ+Vxqv/cxcCHn9p0Rg8GnB7N3s24JbTgGe1sVxFouFj7vrKOWhgXCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791417; c=relaxed/simple;
	bh=yz4TRadDBamRTygvjBM0JdoF2r/Hwp8MeG++DqHkG3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJygn8PaVp4kajw+bseNFH9cx8mQx+pRldHtYZJ5rIgW9LEl3leAC5DHoGiiSpsxLqyINXn1qXHbqhU2zFAzU2UsdQdRy8W0W+7PGYhzRHb8NZMT752xBtJqLo7nNhCv+0e3GBiHUEiWQh+P3JFTrieJgcb7noBD9VFukSTTMXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgBa2MX8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgBa2MX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723791415; x=1755327415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yz4TRadDBamRTygvjBM0JdoF2r/Hwp8MeG++DqHkG3s=;
  b=DgBa2MX8wxl5B3Z/lBrRBCprC4Yz47BDgi6rXjDXKqPyKsJpU1jiCiDD
   QSVwlZOXU+y4rz6W/BOTaLv0CfEKW8NweLQhbKXN6Q6bqm1INXClPTeMi
   fGqVxJ9B8SJWot1DhEO7riTECAbpyPTE2P1k+oqlRe7VAyHqenBSAzrcx
   fJeM0M1sHgXAVsPD631X51Eiq9BZjvgj9C4TX5FhO62OOlCeuGHVEEvxH
   k2hUy2tjVmV5+h6sj0lqppMncMBnwNT7sTrpVhRIvFPySmqHwxzq3MII7
   3Til16RC6GUrmTr9DhjflKwieKJ9Bq+EV+WzY/1TOq7/oROSOxtgUNXfG
   w==;
X-CSE-ConnectionGUID: +hEhao5TTyWRk+v8zFiTkg==
X-CSE-MsgGUID: ryNJy6R0Q4icHQNr45I4uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21957758"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21957758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:56:52 -0700
X-CSE-ConnectionGUID: UBYcvZglRLKhLpu2NW5INQ==
X-CSE-MsgGUID: MZFCIp4EQHO3fiXiZSVWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64266480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 23:56:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 23:56:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 23:56:51 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 23:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSThC52vEaJZVWr8rby4NElLZt/VUc5ECuL/6LVzPpVwEZW+vBn2EHREuDHPWJVy9k+EH/PS4eKD8WL1U94rQoGiy3RxPd2QFHWfY3cAHSLmMg6BQ60iXbao5liSlGReB7svnli+R0ccfP1D6NYL1qrwWhOm9asSyoSRVLT5TY9+oiN49WG/sJFZuDsvn15LXj4tuWG9RS5a6TvjMkxoNMlBve09tKdNWyQzhOjJP4PRTuiLTn4jwmLPZ5ujp/86f03PbDKsLp2MODdgMShF0BUkqOJpE3qMSrqi3ttpHXs3UNiinV5Zcb4gFPCEfwUQnpG/ny/oZiCYd2IC9IRynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoT9a3OJG4LlHhwijvKUVX6/wzSPMtrr8vBzMCRrYNo=;
 b=B2WopZCvH3UW13j3i39PvurHhahgzZkvqnjA5Bn9KP+VVOwJ5Kkjgllp5eqZFlm3SDJY/yCy30OkUJ6/XTmNMg/MNjUoiMHftiNq1axuDWAkInwitj5CfGc24OC3pHLMtQ+6sIcrAN4yTm7hYP1tubawSkXo78Q9OCz5G7VusPLVrg0aztpVcfC3Oh6wheFwRJMIAzsMadzBC3gjyqH5Fw1PvRQkia1BIJtg29wHTWX7B8ga8qM2maf4ivlOCBnxhX2rCLhGSr/kV0JmyWmnYnZNUojb6vm92Pe6oHt4TYt5xRh1nwWiIBNAydaSyxq4yg5EwwCzUA9kXCF756TZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 16 Aug
 2024 06:56:43 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 06:56:43 +0000
Message-ID: <5181e123-44ef-43d8-926a-3a11cfec6842@intel.com>
Date: Fri, 16 Aug 2024 14:56:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
References: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
 <20240815005510.220835-4-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240815005510.220835-4-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MW4PR11MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: e8909b01-1d30-41b9-f79c-08dcbdc095dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czNsd1FUbjdITHVLOTB4cERHS2J3UHNwMEg1NVYwM094VHEzUnZoM0c5QjJV?=
 =?utf-8?B?WlR2WFRGQUFPdHJZNXV5eHlJYUVvMmJUanRHYm9mV0ZTZ1Fid29aaGl1UTZK?=
 =?utf-8?B?VHQ0enBVQzdzWEQ1R2hWVWpXb1ZKV2ZoNWJ3ZlM2TVprMUs0dFpJZWtnY29J?=
 =?utf-8?B?RlBibDNYVC9xMkhvLy8xbjBzcFJvcnNEb3gwYlJmR1JHYkJ2aE5GNGRNTTRr?=
 =?utf-8?B?ZnMzWHhtcEg1b0pQQkNFdjFrVVRVMDU0NUdGamRSS3MzN2NnRWZYSVBaN01G?=
 =?utf-8?B?ZERPcWtBRTVHUU9nZmFGTmNvc3ZLcVJscHJDVit4VU1uSC8zM2p2MitWT016?=
 =?utf-8?B?dDNwQVJYZk1PMUVaejNyM2tXT1FiSlJyVjU1aUU3SlJmMjUyREdEaEdnN0dY?=
 =?utf-8?B?ZnZDaE4vaU1JekRHQW9jemZEK2RBSk41RzFaSy8rcXZ3dWQyQTR6aVZycnp3?=
 =?utf-8?B?aGZFYXg0RGhXcmdwaGVZTjMvM20wZUdkdDN3WThyVmw2WHJ2dkNCeElNR0Vj?=
 =?utf-8?B?L01WWmdtSGxGSmh0alRVTGFieEt1b001QVAreWg3RW1MYnQ5K3RiRm40RkNT?=
 =?utf-8?B?VlR4UTQraXpwT0hOOFBwcThaQzY3YXNvbGg4dkZoS0UyVmdQTzh2S0dmS21a?=
 =?utf-8?B?ajRLZVFaanZiRFlUVEEzVFlyOTNlbUFKckZBOWxMSndjS1BldS9OUkV4SVB1?=
 =?utf-8?B?eEFPdGZ2dzgwdU1FVkMyRUhnVEs4MnIxcXpHM1krdkgyK1NFQ3JaQkZ0aWFV?=
 =?utf-8?B?YUo1ZXJTWTluT2lXT0VOSStoYzViVEorQ0FsOXcxbzdqTGVjN1NVUnRiL1pt?=
 =?utf-8?B?SUZPWlpKak9vdUkzWUNoY2VhSWxZTzVGbVM1WENyQ2JvSWo5RUFvdm9abUtp?=
 =?utf-8?B?NDdvRlIvZVZsL1hJTnNXQ3ZiNjF4NnlRRklpV2Y4TkVRVy9OdTBNdmFCOGJt?=
 =?utf-8?B?YzB0ak9yNVpFN0paTlp5SHlyYzhIaGhQMjYrTFR1WkpNMTk2anVIVnl4RGRu?=
 =?utf-8?B?NzczZEFxREt4UitsMTJyNmZ2NG03Sm9GWG1yVVJDeWVnTDlSU2NHVDIvaU1l?=
 =?utf-8?B?ek54Q2xDRHZkQ3ZEeVJjcVBOSStTaTh5N0xLYTBiaGN0VjgwT3l1anZ5RFpO?=
 =?utf-8?B?cUM1d1VlQ1lDK0I2YUh2YmxvSzhCcXZZcmVFc2RTakdVdkJ2MXB5M3dxVWNG?=
 =?utf-8?B?Rng0Q2ZTcFRnOXIxTEFEME45b3Jyc3l6ZTByaUMxTDExMmwvTUpCMGlVMHVi?=
 =?utf-8?B?QmxTcURZVEpGUmErMGZLd29kY1I1Z1JRUEVzYjFXaGM5ZnRIc2NDcWd2UEMw?=
 =?utf-8?B?SEtXbEJ2TDRuQmZVNk9lUVkyRFc4VFphYUNuOGd3eDFmcVQwVURjL01zYVhB?=
 =?utf-8?B?U2pMRmp6UWY4RmtDWlBrVVBadGN6RHFlN1g0RU1oUEhUOFBmOHlSOVpFTkVs?=
 =?utf-8?B?anFrZ2VtZ3RLMEdXbkpxR3F1QmVsVUNJTFJrb3RGWEJzcWhZdCtTdzJySWs4?=
 =?utf-8?B?cFdFbjF6a3FtRGJJamdaMUhEYnd0dlNqcmNuNnpYemJKZW9BbFVoaXltdGI3?=
 =?utf-8?B?b25Pc1JOcytQT1BJSUlIZWRCcDdHczE3QmxjQnRad2NzM2RCK0ZJUnRTbGw5?=
 =?utf-8?B?aU10NVkrMXdreFRUU1R3RXFlWWVwSGxabGx2Ujg1TjNXb1QrcG5OdUVmV3Fl?=
 =?utf-8?B?ZkpqYXg0VVpPb2cvbk9LNzBQcENrSjNwQVk3Z3BiNzVDS3BjTHhCd29ST1kr?=
 =?utf-8?B?OXpWdDljYUZCenhWVGt1dlhHOWxmdDl4dWNGWkVhTlNwRVJaQ24vcEU3eWlz?=
 =?utf-8?Q?VdQiEFn+Ip917pE0aJb7fxSiSt1tZvMRFejAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RnVGJ2SXEzdFpLbStLb1EwaDFRNlhESmFDaG9Gb25hdDN0cHpnd2ozMDhr?=
 =?utf-8?B?cndya1Z3UE9xRGd0a1RPV0ZnMSttKy9BZVVuNEZUK0FjWVBxVjlFVHlOcmw4?=
 =?utf-8?B?YUx0SGRpdVdOL0pxdFBxMC9kaEpibWdBV0lMdjltdGJOenRoUXJMZHJ5L00x?=
 =?utf-8?B?dDArcEY4TSs0K2tKdDJIdHBsVlhSdjAyL01OZGFoclltS2JuVWVnR0ZRRVF4?=
 =?utf-8?B?ZWVHWkdRdk1uV1QxZ1hESGUzMkN1aXliZzlBa29XYnVNZWdMVFl4REpjSmNY?=
 =?utf-8?B?R1B3VEFKUU1yTE9lVkR2L2g4M2xMcjhpSERKMWU2T2VlR0VEUGpSdUpXTVVp?=
 =?utf-8?B?ak1hNmdnNi8wcDMveXl1aTdwd1Z4YUZQRzcrMG1pREhUQjZNY1ZRQThJRWFT?=
 =?utf-8?B?SGp0NEt4VUx4L3dxNk81dnByV2VmaHlibHJaRW9SdVN4T1hWSG5TeElUaDVy?=
 =?utf-8?B?WFRpejNNWVlKbWptanFudnN4NjdQMEcwQzNieTVlOURJSGc2anllYWJIU0NS?=
 =?utf-8?B?Zk4vclpZQWhBR3Y4bzJGelBEeUtRYWJ4c1BydGk3bmpLemRFbHFINGJQVDFW?=
 =?utf-8?B?UEh2bElCVkZ0dnRsbXd3ZDNpQ0tmdmcySjJVK3QwK056d2ZSMjNjeFZlQnVp?=
 =?utf-8?B?WStCZnJXSXdObTJsUTM3b0JvL090YmxnK0pkYVk0ZW1OdzFkcXdPSDVkOXBJ?=
 =?utf-8?B?UnNtZ0haRnFYNUpEOUVJNDh3aklSdVg4RVJoOXhZOEhNTzZuTC9IMExIWEJh?=
 =?utf-8?B?SDJucUJYOTByNW5rcW9mRURlYUJXMHBlU09wV1VxUGRleTJRTk1DRFBkOEFy?=
 =?utf-8?B?cGVjSzNnYTVBUUdPUlJvdHZlWDFFUWsrcTh6ZWVobFpab1VxcHFwdXB5Q2J3?=
 =?utf-8?B?V293ZVBaY0VXa0xZOHhVRGVUMHRPaXBLOEE4YXZDT0N0ZzhvNG51Y1QxRnBU?=
 =?utf-8?B?ZlJQNjBPMjhPd1NHeUlrcXdscGR5Q0c4Y3AvMktSdTU4L0VJeExkbStwTElI?=
 =?utf-8?B?cmorYlNVa1JQRTlIaFVwckNpMEcyUFJiYklVOTY0dE9KalA5NlRqQWJTVzV6?=
 =?utf-8?B?ZGFKUTRHNXpXdXd5WnM2SnBLZUJJdXROd2pmSFVja2JwVHl6eXd1UEZXZjQ1?=
 =?utf-8?B?UDV2N3k3bSs0bVhUeUZDaFpKUFhNM1JuTFUwKzZUb09FazdrVUZtSTdLVFRk?=
 =?utf-8?B?Q25UZTl5TkhxdmFnZHZpN0FTaEpXemZlOUU5VXJUL0NTOVdCNGpXTmN0WHd0?=
 =?utf-8?B?TTJ0d3M1Y01rNGdySjFNWEhlZ3JITFhOQnZKNnE5VHVhcGxkQnBTSXJ0UENv?=
 =?utf-8?B?Tm9hL1JlM3lmWUdIc0pjdDZtajdPM0tyTEpQbXRJVVVvUklsZ2hraVVZQU5M?=
 =?utf-8?B?ZHFnRHZ4SE9RWmRxYzRwTmxPMCtmbTZyb1FYS0pDQTdVOHhYYnFBVGNBNWtD?=
 =?utf-8?B?TFhqcFE4UVY5T2wwQTAvaFJNVVNnWEFHVFZGazlTUmRPTGFLNHpiVE1vM0Q4?=
 =?utf-8?B?aGMxajdGY0FCeFhpT2ZMbjZwK2VKL3FBZmdPVVIvU3lrS09WajVKY2loczJE?=
 =?utf-8?B?a25nTmxDZXRDcmZGNDhHVHIwVFB2QUs2cTNyT01hUzh2NUQ3a2lwSHFGS1pq?=
 =?utf-8?B?d01lc1h3bGJCS0w3QWpTS1hXZnZqQzlXMXpmYXpObXFVWUtPaUp5aTlTWDdM?=
 =?utf-8?B?blF1MFNuNCtHeW0wMTdic1VmYmE4ZkEzby8ycUJoOTJDQXpjY2g2YkFmVlBR?=
 =?utf-8?B?azBGais0eWlUOGxaWUhpRzFGRmcvQ3Y4ME5ENWNJeEVWK3RuV0V5c2RqMCsz?=
 =?utf-8?B?cGpVdGdaWnpsVzhZSjE4Y3lOWDNIbTRUNVZkbjFscWxMMjUwbTVsK0NGbld4?=
 =?utf-8?B?bzVzcjB5NEFlQmRYWUlxQ25kZitOMEZxYnp5clRCWWJYN2krM3NmWll0OGIz?=
 =?utf-8?B?VnJlaUpGdHFHOEdjdjNyb1hoOHh4dzladHZhZlJ2UFFkdGFteGZXTnEwZEhR?=
 =?utf-8?B?YzBNTXltbGlicUFNbkh1NzNUM1J4RC9ZS2I0NzlPVlp3VzFjeURkODBiNTJ3?=
 =?utf-8?B?VjF5a1ZsU1JFY09OODQ0a0ZVamllTFFDZW5KZFM4OFpZcnBKT3MxRHV1MFQ3?=
 =?utf-8?Q?hDC5OwflgvbMioBfHLoLA58eF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8909b01-1d30-41b9-f79c-08dcbdc095dd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 06:56:42.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXcmMGVmo+u2z95XQt2Bfrl76LyMIbIdcVcRlYjWnNQS4wKjBAAQlHXCVzR9FQj/I6Cjem3wx8n0CE1He1UKxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5911
X-OriginatorOrg: intel.com

On 8/15/2024 8:55 AM, Kobayashi,Daisuke wrote:
> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
>
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
>
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4eaf64d92541..4e51b6a0a97b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -792,6 +792,83 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size_t width)
> +{
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *root_dev;
> +	struct cxl_dport *dport;
> +	struct cxl_port *root __free(put_cxl_root) =
> +		cxl_mem_find_port(cxlmd, &dport);

It is not right to use put_cxl_root() to dereference a cxl_port->dev here. put_cxl_root() is used for a struct cxl_root rather than a struct cxl_port. I implemented a put_cxl_port() in the below patch which is under review.

https://lore.kernel.org/linux-cxl/20240813070552.3353530-1-ming4.li@intel.com/T/#m07695675435bf702311dfc40f64289b9623afa16


> +
> +	if (!root)
> +		return -ENXIO;
> +
> +	root_dev = root->uport_dev;
> +	if (!root_dev)
> +		return -ENXIO;
> +
> +	guard(device)(root_dev);
> +	if (!root_dev->driver)
> +		return -ENXIO;
> +
> +	switch (width) {
> +	case 2:
> +		return sysfs_emit(buf, "%#x\n",
> +				  readw(dport->regs.rcd_pcie_cap + offset));
> +	case 4:
> +		return sysfs_emit(buf, "%#x\n",
> +				  readl(dport->regs.rcd_pcie_cap + offset));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCAP, buf, sizeof(u32));
> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCTL, buf, sizeof(u16));
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKSTA, buf, sizeof(u16));
> +}
> +static DEVICE_ATTR_RO(rcd_link_status);
> +
> +static struct attribute *cxl_rcd_attrs[] = {
> +	&dev_attr_rcd_link_cap.attr,
> +	&dev_attr_rcd_link_ctrl.attr,
> +	&dev_attr_rcd_link_status.attr,
> +	NULL
> +};
> +
> +static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (is_cxl_restricted(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group cxl_rcd_group = {
> +	.attrs = cxl_rcd_attrs,
> +	.is_visible = cxl_rcd_visible,
> +};
> +__ATTRIBUTE_GROUPS(cxl_rcd);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -975,6 +1052,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
>  	.err_handler		= &cxl_error_handlers,
> +	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>  	},


