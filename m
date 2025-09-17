Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3230BB98;
	Wed, 17 Sep 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151308; cv=fail; b=nxdR1yPEkwi7BCxhAWPfSiLv8fzxV8vF94sOfVHdIH0HrEf0kZRjzU4quWQ85lDv8BzhkPPOy2vuQICSg53IFdmVNth/W7ec5/+HgceEr5muIZMGjmthxwQOCulfB1C/4xVhrybBbRIL8lujWxojRp3SEIP0XkQFYTKADVqdnsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151308; c=relaxed/simple;
	bh=1nkiKurjUXNEPhQOahU8GpfuCtYlq48Hh82Uqx2hV1k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GqxN1gVDH6LWqilZJWhkTH06r01uRrdySyWv5oCsb9vvajtrybtdv9hu22+hgDFHB2xXeQSz7NtXAnCaWlcN7ZRTEvG21OiXK1XKHKKbXVUsKtR0K7xw9o8Ljj/HM/kP1qEwf0+f1M8tsKSmohzDGCBbXLwJrvCjmGpBKbo9vj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmW1rs7z; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmW1rs7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758151306; x=1789687306;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=1nkiKurjUXNEPhQOahU8GpfuCtYlq48Hh82Uqx2hV1k=;
  b=jmW1rs7zzezan2bq3YjwPajUiiRrX/YrzO9jO5Xp4fviUDhr2Z7R2wz6
   8/EbgalBMHQl4gvM5ck6RdQUjaU5Uhg1JjWe2b0+Ni+KpD/L7XRIamvDe
   RQ24zk9EcUkE1gGiIcbOiv02B+XWSE9PSiJjGbA2WwKznhmcfE3ED6eX+
   zt68FC/1hOwllV0nbRYbWxk0pIbFtY0GMYj5dB3YxPpn3HerN5GUYVEKi
   mM7NakHf0ByoFDzqQXToATLy8t0arjwEIb11YdhLAVtlOurVsbGr3P2r4
   qTb1akFKszldnuElpOkVlUOqx/afhDgXpD+S9IPvOFWpprIzAO97Erfgw
   Q==;
X-CSE-ConnectionGUID: O+GIV3UjR+KmiCuB2nkRCQ==
X-CSE-MsgGUID: JhAr5pWdTkO/gpOkpr33xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="83068253"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="83068253"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 16:21:46 -0700
X-CSE-ConnectionGUID: x10taHPsSiuLqJDCVRxONQ==
X-CSE-MsgGUID: o0lTPTESQ7eMNFjBQ6ewfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="175460208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 16:21:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 16:21:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 16:21:45 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 16:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXfs/D5S3a3mrTIpUU+8Qb1ai8ZaPuBs+1SB3Gr1+WUvwY343afJYMSH5Qxy6mON5CNyNLs4xGQ01ru3LsL6GNuPpJG3KyCsBNOO/yjbI6W2OvV86vvxsyYwBqtrRs35u/FbFfe7QX7esfuE4Sv9Z97KXnNdFrPf0P1oU+byE1AOPlG0QJHY30cFMTzjyfbKFauOmAgDMfJEEGWVYbZCgpg3dJREYHaQrhspxq/RXwRzWAknAPirzd4aF5KjNRHd49S4aaASAcUiGiRaH4HOMaYnrEwlnteLdHILy8z7Xyjb6J0J9IcIf2kUDJWovV+hu7WZJI0NwKnd4qKcBqDYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiA8+JiAFD254khyuB8ai3VcPf7L4zLSyUhkeFLo+Mc=;
 b=BaO0b9572EmAO3e+o4pnGActHm8q9AqjflyguhOxmqMIkegXbIkZcZEJnKq8H4jem7pCwY/3EiLENM/c+1EHMUW6C5i8+j52rPayyN3KQFtu8X4J+PHdUlXyuOvoB/sYQVYRf9ezFkccxZ26BTzo/S5ILU45cqV9pQ6/oPfDbr7HXPe3OmtaIkWPmSsrgzrUKjfeF6/7IN1oDqncGSOjnoPYvzdVNvAO8Dpd1XUxh8BVC6qNHj7+b+67skR/Oo1Z2UFZsjsJSILxdfrincNyr/EP3bu8fmdLVjZKet+k8f37hIW4nKEdGTasiLqfWZ9cdM24IbJTegP+reJtmnGaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPFC852EF225.namprd11.prod.outlook.com (2603:10b6:518:1::d4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 23:21:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 23:21:08 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 17 Sep 2025 16:21:07 -0700
To: Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>,
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Message-ID: <68cb426324810_10520100fa@dwillia2-mobl4.notmuch>
In-Reply-To: <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
References: <20250904225010.1804783-1-dan.j.williams@intel.com>
 <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
Subject: Re: [PATCH v2] cleanup: Fix "unused function" warnings with
 conditional guards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPFC852EF225:EE_
X-MS-Office365-Filtering-Correlation-Id: dd689c91-c987-45d2-095b-08ddf640e202
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGpad2RhdjFpMkNXY3ZMVjZWdjlta0JkamtvTURsTlZRWkx5VWg3ZmhZM1I2?=
 =?utf-8?B?VmNoMHRsOWlhNTFpd0ZxZXppKzBaZ05oSWlibmUyRGVmWHhQS2ZJNTA1SHBY?=
 =?utf-8?B?d09QL0d2ODl4dGtoRGE5dDVPd1JVR0cxeFFwcUZDdElJR1E1RWxRZnRzTnlh?=
 =?utf-8?B?V0RuTUZNaXJVeEZYRlp4eThEQnRDUkRqaTZjcXNxSmk2ME9ES3NYcHN2ZGNz?=
 =?utf-8?B?OHNPb3M0K0FIaXpmWkF4WnprSXc4Sm04NWZJRnlVY0VEaU8vQVpYL2tGL2tw?=
 =?utf-8?B?Y3E3ekRyOHZBZFZKbkRncVhOU2t0T1ZURTRiZENiRHpUbllZUE9STVdEOVZx?=
 =?utf-8?B?aE1ld1ZXeGJMV3lsT0pKZlRLeVN6SHptZ3laSUkzQXlMSjkvOFNiNlFqQ2pa?=
 =?utf-8?B?VEUyWWYvOGJzd2NSajFIOXU5VWFlQjhPZkJsVkNObGVmNlV5a21pNVNCTGFa?=
 =?utf-8?B?YlJVK25ueGkwcitlK3Jicll4TGxLTGJJaSszSGFpMVVXZG44eEFyRk9BZTBU?=
 =?utf-8?B?SzI4R09TaGthYXpxdmJVNStTVW5PUnFwVFJiaW8vL0pCY1JoT0lkVjBqNDM2?=
 =?utf-8?B?TVprOW1FRG05UVIxWlhQS0Z2dWgxSGdMZkNjdG1sQzRjL3J3M01PWFkyMEE5?=
 =?utf-8?B?dEFVYVcvNHhWRXR0TW5QOWdMN0ZvbVJRS0JzN28xbjlETFFucDdEbnpkT2g2?=
 =?utf-8?B?V0djOGN5Y3c3THlNZGVuZk9Qd3F0ZDE4VlV5U2psNk85cHgxZGV3R1F3TVF2?=
 =?utf-8?B?TXpPYlhYNmxsYlhHWFdyb0hLMXVublZoQ1lSTjFNU21lYklNL1ZGWG1MazJv?=
 =?utf-8?B?L2o4MFozaDNFeFBXM3FUOVcwclJCcDBxZGVUK2FWUHJwbitWVkpyZkZKRDBP?=
 =?utf-8?B?WGNvb1BDcWlMRzBUUVlwazYzMStsdm9DZlNGMVNJQm8rRS9TOGNZdG9NdDY3?=
 =?utf-8?B?R0V0YVJOdXdNWVhYeTJmWTdHYm8xV0VnVVRlV3dFRVZhTjlpdVp1RFJ5Mzk0?=
 =?utf-8?B?TldTRnZnUjlzR1lCbExFQmU4L09LRkwyNGRpMnhtT2dUSzFqbFhaTGwrN2wr?=
 =?utf-8?B?MkFCbDNITVVTTnFBTGpVbkRvSEh2cU1mUFdkblVmT0lEME9jZHBNRFBCOE5C?=
 =?utf-8?B?YjJvaGJ5aVJYeGtkMytabGdWMVAxWWJyQm1HTWYvMGYzMmVSZzN5Vmo3cXRj?=
 =?utf-8?B?djU0OU5OK2hHV1A1d3JidUJ1NlB1MFJhK1N0ZUR6bSt0elZqMWpNdXIzZEEr?=
 =?utf-8?B?UE9aODU0Y0JFb1FpV0lEU3lNUVhHZlNQTkttTnRpVlRWOVJCQjFkaXlpdkhN?=
 =?utf-8?B?dVdZczNMRURvMUFaWjNTcVlOdTNUWGFKT0JMVXI5V093aFk0N2VUSWdnamhT?=
 =?utf-8?B?dEpVd3NOdlJsaFNGT3lCZVBmZDA2TkEvenNXUG9Cd2JCcEYyWlQ5bm9EaVdR?=
 =?utf-8?B?dXNkZ0MrMVdJZHhNY2F3bmpEMHBMelFSVkU4Q29NU0xhYnNEZnlLcFZKSkpx?=
 =?utf-8?B?cnoyRkNVTGEvK3U0MFJmSkc1N1BIWktWTlF6ejRnRTJlandQd2lTWHlQZ3cx?=
 =?utf-8?B?TjRzWjlHK1BlaHkrS3Ftek8zMmo3SmdrSXg2bWVESENqSmJiVjBYcWpSNzJS?=
 =?utf-8?B?cjhZTTN4QlVieGhpZENwd0dGVTNocU9QOHFXYUZEMnl5NEJ4YjloVjF1Qm9o?=
 =?utf-8?B?U3phNXNLQWRlajFFdFVGSHpINDIxYXVGVUIxUkpHVzd5ZDFzUEYwQmpwNnhI?=
 =?utf-8?B?U2ZjbmRaMDF0TjBrZ1M1ZUNrZ2ZKNUF1VHhaeWUyS0lBYm5JdjJiaWp5MUNa?=
 =?utf-8?Q?N9dLBC1Xntj4hkuHs2i2p7ELMLSV9zln6IX3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1czdXd5bE1iMkZmMStwWk1PRG1FWUlsQnhiSHR1K29xQzM3QjZIR2UzM2pj?=
 =?utf-8?B?WXZjN3FOYUZleFhZdjR3RjZZSDlzNXBEdDl1WTBXVktwVW1ZM2IxOGFPOTBL?=
 =?utf-8?B?UDdUWThkcExseklGd1p1Q1dDVEhldzFsNk8vNVNrZEVPUkZEd1k0ek05bTlJ?=
 =?utf-8?B?NytEZ1FSTGZrYzVKQ3FZYjFRSWl5bnNDcjRZWlgwRWxneFRvUDRUdkJBOW80?=
 =?utf-8?B?MGVWbEdTUjBOYVdGR0JzRnRWY29OS3M5UUxKSE1FS01MazQ1ZDUvR1dkM1pB?=
 =?utf-8?B?M3dRdDlTR1lHdkJUYzRVV0lDTGFpeUJrZVVsRlBRaTdiSFZPUnFqMmFKNk1p?=
 =?utf-8?B?L0ppdytaRzFFS1M0NVVubHQ0bENka0pRTmRycDFpT1hIenZZZEdYYkJncmFO?=
 =?utf-8?B?TlZhMFNPYnQ3VEttUFVqQ1VuMy95R3ZFd2hMSFdvWUgzV2Y2czBxNDU5UnVl?=
 =?utf-8?B?L25kUVh1MHEwQ1NreG5xQnBGSkkzOVBuVm0rT053TVB0dGZGMkVDNjBmcGRv?=
 =?utf-8?B?eWR5VmtXeSt1L095L2tESVZ2dXVGUGlJY2hQLzIxY2YrVVlZbm11cnFuQTVF?=
 =?utf-8?B?OVlsZ0V4aGFscmR1U1kwQTJBZlhFVEthbDlsb0UrRkVsS2ROM25kMUNYOXBF?=
 =?utf-8?B?enBrWjE4cW9lTWp1Wk9meFIxTFR6QUhPbE1rUXBKZkZSSm4zZ3o0RVhHVy9T?=
 =?utf-8?B?SWlOZ1VXSlZQb2lyVTVVNWNUU1NwOEl4dFdKYTdZRExSVmluUVgrcmw2b24x?=
 =?utf-8?B?UFJkU0FOVHNIbGcwNDYzMDlYeDFvUXZqelJJMkdPWjVRb1huTTVUNEZwMXpL?=
 =?utf-8?B?RnUzaHhxb1pQMmFGOGlONVNGWUE3VVJwUkMyOGxaTVg4QmZkYkdUNHNQTmFS?=
 =?utf-8?B?YnA4MGRDMTlGTTFDQnZMWDlwdW51bzRSckFzY3VDdE5RZitZS2d5UDFIbTR2?=
 =?utf-8?B?MGw3Zmt4blFvNmxtUmszNTJUeGxQY1ZtRERIVEh0aDBoVThsKzRFem9WcmNk?=
 =?utf-8?B?blRoZUJWYnd6b0VsRU5lNEpmeCswZUVRaElJM0RMdlU2WXJzVERYRUs0RkNl?=
 =?utf-8?B?MDl5UEc4L3RUVlpqOXBHTjhtek1RWnZMdnhtR25kNllxYy9xbGdnOHVMVEdt?=
 =?utf-8?B?NFNlcWNFMTRRc2JaME1OSTRydTA5dlI4UDBEQnd6OCtlcHV2dzQwb3dBZVFB?=
 =?utf-8?B?R2xWNUJYMFF3emRadzNiVVVCZi91VWVVMG9SZVB2ZENiRDJDY005akxNaDVG?=
 =?utf-8?B?ODM5OXhTSFM2U2RqVWpZV1NvK3UwRTYvV1ZiOUY5VHYxdlljRDdJRVJqeEpB?=
 =?utf-8?B?cUU2Q3FUOExTeEFRWWhLMUxYQWp3RVdiTDZyYjJBZ3VidjBzWWRiZUpmOFFu?=
 =?utf-8?B?eGdrK2lMczBFWFljNHlGMjEwaFNJMWVrc0NCQVpPNlBCMzRzSitrMDZiM1Zn?=
 =?utf-8?B?QUxWQTBEQ1FyRWh5L2c3ZGIyUC9vUE1jVGRTZzB0UGc0VGFCN2tvSkVlMUkx?=
 =?utf-8?B?UzgxdFQ0b3hpWWFyQTdQZHhBOTR3V3QvZE5sS0owN3g2SXFxWXVXQTM5eHZQ?=
 =?utf-8?B?UytINGRiZXh0Ti9Gc2xrNXZYYmdIS20zNDQ1NUpmL0NDL095eGI3ejF5dXF5?=
 =?utf-8?B?QjFuNDErMjVGNHBTSE5jb0NlNHFEVDliMUJBR0pNTmZQemVuUWV2ZTFVMmcx?=
 =?utf-8?B?NTYwQiszdjcrczRhaUtCZkJURFc3RlJrenZnWVAzLzdKbzVSelhIYUJKMERh?=
 =?utf-8?B?S09Wa2NsV1RUYmNudGpTWlB4c0k5dGtwcW1MOWVCMFRTbmUvNzdVeFc2MzlR?=
 =?utf-8?B?RWZwcG9kZHBudVJFS3NTaGdHSWw1NlR4K3VnaDZ4cGZ0T1RKVkFqaHNDZFBT?=
 =?utf-8?B?aWtBZHdkNU5MTS8rOUhvbU5xNlNHUUgxdlJUeWg0U0g0UUROQU9nOTVHbzV5?=
 =?utf-8?B?c3h5cDU5aklHV0ZSdnkwd1B2Vm1UYkZLcEVuYWwyTDZTb0VKa0RpNWx1akFq?=
 =?utf-8?B?OXBVcWZRT3ZwOGQ2bG5qMTFwRnUyaTFORXNIY3k5Nk9LR1BuTkJVVDM4UGMz?=
 =?utf-8?B?c2MzUnhxR1RtUDB5QWw0T1crN1BPSkI5MXAyOXJCU1k1eG9WUDByK3RTTmE4?=
 =?utf-8?B?WVlmeVE0T3E5ZGdESUd0NGVNUnh6bFpRaG5IQ3gzSFA3V3o2S3Y3TzhOQkNG?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd689c91-c987-45d2-095b-08ddf640e202
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 23:21:08.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7C8l03lCf9mx+4wshubzczf48B8GKC76SGkgKJbYMkwEqANp1eMmnPJCSfEJ7bJmqI8DGMMd7xNX6ae2q8oXh5GrEZ57P1x84VDHw+dXfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC852EF225
X-OriginatorOrg: intel.com

Andrew Morton wrote:
[..]
> > Alternatively just merge the suggestion in [1], and call it a day.
> > 
> > Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]
> 
> lgtm, unless we think this (your) patch improves the code for other reasons?

The tl;dr above is that the warning could have small value, but probably
not greater than the overall benefit to Linux to stop bothering folks
with this low-value warning by default at W=1.

So I am over the sunk costs, and moving this warning to W=2 is the way
to go.
