Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB400482EB
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813401; cv=fail; b=cJKVQPdmqDOjSqL8iwmNpvm1i7YTfi7HWXkt9hkdSWU9V67HrWC1QohBKa3wDDNvnVoz0px0+EGjnu0kohbO0jhdK9r/TkI7kVhIkW80MBA1Dw1lZJtelCjZ6jxiU/UMLBYMJeX0G2TlC191P+g8LNLNYlSJ15Rj6EgO83hToCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813401; c=relaxed/simple;
	bh=RMyMeMtZ6XuaiYN2mUEG5577x/lpOhRW9mcSqm0EnFc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvyq15EXvp+IZdFQFJ97Imq/hhmsjWm6Duz5qi7UWZSHuwUyi84bog4ML9kVakJifSgf7m7LPfH3mG2MIqEMbRxQBRyuBPWDM/gry6w7Jq8K4cfZTq0FCU/570PEwYwIoYgQ3iuKjba+4m3RnHIcuuO2MSy3V9Zzdbq3rCjD3g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmfJl506; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmfJl506"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724813400; x=1756349400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RMyMeMtZ6XuaiYN2mUEG5577x/lpOhRW9mcSqm0EnFc=;
  b=XmfJl506Zo18ggcWVttjdZjLXiX9+vTXXUi1NFmP63D7cz8voTx5GotK
   U+gla8OFh+MT9h28NsD5cBefLtSsgnOuA7VBu6DTgwakiEezG5qWT2Yrz
   PME0sG0+qp+qNi9ZqQVWkAy2jUBs4zK7GJ7k7AefE4UJ5VVXqVmz3DRDp
   Fh8ucERUd/eiTy7r0qD8o1/X/lkmAofO+ziNpbfGlOsN30/aVYhEMeOFh
   xQUT4VLsSbI6EcOocPDxULOMp2cBDEaEEVKqJ36DiZp/4md2OE5SeK0EX
   NiSyiPpJUoWYkAj9Iz6rKOVZEjKF3C/jVYSvjH7CjjZGZqAtv+syk27U2
   w==;
X-CSE-ConnectionGUID: nBPapdk9QJ+N0ShCNTxzoQ==
X-CSE-MsgGUID: FiqlmprAQhmtbM+JrRuI0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23483596"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23483596"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 19:49:59 -0700
X-CSE-ConnectionGUID: RW+8uUOfS924Dw0jolz1aw==
X-CSE-MsgGUID: SCOgu+qdQKuNvVoJkyZD8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63244654"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 19:50:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:49:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:49:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 19:49:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMYCUfbY+Z7wnc1kPJsuvmjiWrkZ79xDWDAVWErHWRg+DwpI0L0mNqNkScdvyOpqh56CuHLwBggAX2N9lkCCorq3KOClgSUc7u+fht95gYJufI3MCt6B1IsDNqLgTlGxrrT8gHCD+MDi2rl0z2vWSc3OiyAW6pXhRVbQfKzzZ0CfaQ/OMW93/GW7eZ8Y6Rk8t7bhJd00LqFfWY4EY2GEG8xv/7vHcjQxmy2Phvg9NpDOWM6gzlapumwk89kuuIvM7FZ7OXYKw+lerO6wd/e7q+ZOhxh0FnfhHVGYdCoUk8BiIp3B/ja3mEG9q4c0OB5sFMDFpUP0mw4Z7naEK+MVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX5Uvf5Fn89piTc/05gJQJntxGOc2CT+j5ROXV8mlCg=;
 b=rCGhKNXXv+CHGoIQsauZ5Xvlv1NrXbxFE2ChGuwaL084k7TNHPeC/C5zzE9J7p85ynMLSMICGwKtc1asLTosScb/OBitybY2DmnnCmccDvIFgFXT2LTeSw4WsPpevTZEeow4xUTiW6EcvPIVxLAIoN1uo7SkGNY6U4YKm3E87mshvKEORJChD7t5AUl6KCFMnQpphNFZcOe9PI9iFUdAPI4KRil3qYeihro9fOWKv7Ii+HxB+zajntpf6IXixKImvfYd5HcdJWyBgb7DD9Nibhvjw6J1hB71Mylz0nrJypKtVgcy0Ufh0OddoUC/Zlo86cm493jmMS9m197rAnZ1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by MW4PR11MB6762.namprd11.prod.outlook.com (2603:10b6:303:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 02:49:51 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:49:51 +0000
Message-ID: <485c6d87-6237-44ae-9317-5162d30e56f7@intel.com>
Date: Wed, 28 Aug 2024 10:49:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/4] cxl/pci: Remove duplicated implementation of waiting for
 memory_info_valid
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
 <20240813110532.870869-3-yanfei.xu@intel.com>
 <20240827171606.0000603a@Huawei.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20240827171606.0000603a@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba4f29c-a907-43f7-218c-08dcc70c1675
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFg3blVkenJ1THNDRHF2NWZUdnF3Y29Ud3NzelVmTWYvS3luYm8vZEw3OW5z?=
 =?utf-8?B?aE5mV29JQk5zVlJNa3ZObXZKNUpGMDVaRHRnOEF2bnRZcDh0VFdRaVNCYUNo?=
 =?utf-8?B?MThRamlFZ2ZOYXMvYU1yQXRsL2k4VDV3a3l3bk8wVXFwRStKc3dmeWprUk5r?=
 =?utf-8?B?Wkg3d0FuU1k5ODJXVER3SzVmQUJObnBjUEs4OHhtSkpoaHBxcVN1TjlHK2ZM?=
 =?utf-8?B?dUY1TmhQb3NuSzdiTjFaWjBVTTR1cW12aHE3NXhTcDFKRUJYZnVpWldnalo0?=
 =?utf-8?B?cXAvTkFtTVY0UW5Wc0RXa2NlM2NzN3RCTW5OZ2ZENzJISHlNSXd1dUF2bUN5?=
 =?utf-8?B?UWJ2b2p0VVg0WExHRUZiMVIrcVZuWWJ3dmM0VTZvU1RyMXZGV3U5aEpmQ1Zn?=
 =?utf-8?B?aExBYW1hOEZHczFpa21vbXB6cHh1NUlpR1g0U1BUTStoZHNILzRFQnp5QytR?=
 =?utf-8?B?UFV1TUx0ejd5K1Iva1JLb3JkcnlwY2Y1UUw5K2ZFZDdRYmo1V2JQUEdUMm0v?=
 =?utf-8?B?bmRQL01Vb2p3eTB0RklWVEIvellXSlp1QkNHZVZ1alN2eHlTQThiNHM2MmRO?=
 =?utf-8?B?eXlMbHdvZGs2aFc2RldTNFJzckdTbVRFK09lZmRrVHhFWmtPemgwMEl1QjNa?=
 =?utf-8?B?c25oN0tOR1hlL2toLzRaZEFkTFV0Q3lSNUw4bFkwdEhvMTRVM0NpbVhxZVNC?=
 =?utf-8?B?UlE3djJLaytFckdxRzNsZFd3RFhLZGw1ZjV1MWNtd0pRcGswd29NdElYZ1lR?=
 =?utf-8?B?M1h6S3NNWWZ6TXpDeTJxa3BRcm4wdVN6Q1Z3MzEyR0VTUytQVGl3MXc4eTJw?=
 =?utf-8?B?MjB6VnRUVHhxdFg0L2lPQUpxL3F1ZFFoa3Evb2p6UGpqL2RMSGI1NnlVbkd1?=
 =?utf-8?B?MjNYS1F0Yk5zSlRRblI3Z0M0dDZTTFZGQjNoeEMzSmIwcVBiaTdrT1dOejlF?=
 =?utf-8?B?elY3T3YvL0dGV3lQTUdtUnlRdU9Qcm1nSXhiYlFFaDJjcjcxMTcxREN6Uk1B?=
 =?utf-8?B?Y0hDdjZzcFpLdXVURk9qcFhnSHZ1ZUVsaGs0dERRalFqMlJiZ0VzcUxxUHlk?=
 =?utf-8?B?Y0d0M3BIcTFIWVBXanBWOWg3STl6VHhrSjNKR29MU1QrK0NqeVJ4YUtMWDYx?=
 =?utf-8?B?ZFN1bWM0WkZqckpjK0dXbVlWRE1iUjc1ZTZ3RkV2YkM2ZDFHYlUvTkRDaldz?=
 =?utf-8?B?SE9RVGpGTnBUaVMzQk1nMDhmckdmVktOaWJJUjBoVGtaZUtTRHVuSStnZ1NW?=
 =?utf-8?B?ai9uNExaY2dMZ1hGTm1KbkVNc0RabHcrK2E4RjZENlQ3Q0NEQnVZaVViWWxp?=
 =?utf-8?B?dDVESG52TVQ2cTAxTkxIc3BCV2hRQVVDekU2OGlKRHZjVWZXcjhkYjJXVEw2?=
 =?utf-8?B?ZnVMcVNQK0JlcXcwR3ZQT2tlYzhMeG5KMWNkN3Vzd1VxK05Da2UyUFB1RVlY?=
 =?utf-8?B?SEdPU1pNNEdONCtuUWxnWTVseUZhQVh1WTU4VG5yZHhxUmVhNUJuc200UHpw?=
 =?utf-8?B?ZUhXVVd3T01lYjQvZ0pXaVhuUm8reVlNQ1JwOTFRR21BZGxGWGlucHBxTlk1?=
 =?utf-8?B?MWdYaU80YWgrUWFzbE0zbE8ySGRUaWNkdmFnREUwbmJEN1dGRGdUbTZHMHgr?=
 =?utf-8?B?RmhUNTM0UXIwcktDaUtaSUh1MWRXRGw3WjkwTFpuZ1J4aW1nelIvbnR0MHZl?=
 =?utf-8?B?OXJUVVQ3MUFtaStGTFBKY3NTdjdVTlU2djM0WXdvT1BnTUppd2RpbkhiRWd5?=
 =?utf-8?B?SkpWOWpKYkFTWDJvVWtRVWtFMUtlZ3Z6S3F0d3NoTXQzcytaUko4dU50Qzhs?=
 =?utf-8?B?d2dFejlnbGlGbWVOUkRCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEtOams3cUo4OUprb0ZvajN4SmxWUmZRRUJmbjhiSVFRK3UwRE11aXdTS0Rk?=
 =?utf-8?B?cmtaZHAyZWluNGlmUk8rQVZCQUxlRXBRQmVQNnVpZGx6MUJjQzlmZm1kN3p0?=
 =?utf-8?B?WUg5Y0tSS0cwMEhWejVnQ1NlcVduRTBjKzhXbjF0ZXZET3NWZjlaTCtoMlVr?=
 =?utf-8?B?SlV6TXZxNDBoK01IRmljL1pZVzlQcWNIVXN6eVZrWnk3NFhYM2RyYWQvc3ZC?=
 =?utf-8?B?TDNKN25aMlgzbkJwczVwMHpWMDRDR0JMMXR1citYUG5EY0trOVZvWVJ0MkpN?=
 =?utf-8?B?bEI3dHZYVmhiK05FaEFJNS9XczRtcCsrcHJsZkFjT3dlRUlubWkwZGJZVmYr?=
 =?utf-8?B?anZpak5PcDNUeGFwdUUrd1NmMkcvZGkwMm1ja0xhNXJZdGtWeUo0aHNKVDJ1?=
 =?utf-8?B?V0E0SzljSGh5cVROSURmK2swYTJWWjdsNVh3Q21WeWdFREg1RGlnTXY1WDd1?=
 =?utf-8?B?MHFHOUdGTW1WcldsL1BoUGhudEdzcXZ4eW4zZEVJaGRNOFowK0xrakVEcXVB?=
 =?utf-8?B?MzhKRmFQRjVkM25iRDh6a3RWeVpvajIvVEJlZW4rTnJvc0Z1d09RN2NlTnp2?=
 =?utf-8?B?WGUybjBTNVE0aEd1MlZiQXZFTGlHSHV1UERUL3I5clBrM0JqdjY4Szd6b05x?=
 =?utf-8?B?dTZXcXhQUGpnN2kvMi9OTDAvTGdkcll1cEsvbkR1bkhweVRqWm9WbFh1dlgy?=
 =?utf-8?B?Sm1PNFdvUUdpV1ZoQVF1VjJ1Mjd4RXVnc2FjSTRPVzU4ZTRLdWJvWU5QaHdh?=
 =?utf-8?B?cTd2QWFnTE8vR2dsa0NVYzgvci8wRSttTE1CY3dWS3A4WlBHRUlRaTAyRlo5?=
 =?utf-8?B?L1Bhckt3Ni9PV2NPdDF6cmVDbEpMRCtQRnhTM2lhSkRTR2dSdm1qTUwvazFY?=
 =?utf-8?B?Tm1UU0hITGk3bk1ROVJ2TXRaYk5ZVzNra25reVhJbm5WMWQySGpSZHhZNUdv?=
 =?utf-8?B?OHRzdkpqVEMzRDkyUE5KaVZ2SzZ3SFh5TjBacFRiaXhVMjNIcjN1Q2x5cG1i?=
 =?utf-8?B?eTRMVElwZ1Zvak9GbmR3cnU2MklGWjZDTDg0TklldG9HRmVUNTl4ckF0b25u?=
 =?utf-8?B?UnJrc0Rsa3FyeEwrdGVLR1piTnV1SHFyendmSkRUdHY5aGpFQk8rRXRZMndD?=
 =?utf-8?B?bWI3KzN5ajh3aXlLbEdmMlcwU0FsOEN5UWFOalBxcnlVYUJvZC9SY09LSWR5?=
 =?utf-8?B?NDExSFBpVUowYU1qWXkvUUV2eEo2amtJTVV3K0VUSlYvT1FYTU9mdGc0NDQx?=
 =?utf-8?B?elpQQjVQZndFNUFNWi9MckNNQnUyeTRoNEtJZVN1d3ZQSEtXRGRObzdGUlNp?=
 =?utf-8?B?RzlIVzh5OEtYaHBpekxmR3FrUU5KY2QrVW0xM0loclFhQUNDSWU1eUVpNk5j?=
 =?utf-8?B?d0JSRGZJdmswcmM5NGlPTHErZ21Bd1JCYUVLQ1FQekVBcjVaSFNJK2V1ZEZk?=
 =?utf-8?B?bDY4cUh0VWpnaXorcHg2cElwYnRuSE1JMG81STYvZzRHWkhWbG9kOFcyYzVy?=
 =?utf-8?B?TFpkRSsxQSs1d2NKbGtyOFI3SUx3a3hLME5PQ2k0UmtzTVFUdWcydTVTcEhI?=
 =?utf-8?B?dk9tbDgwaElqWExQOXhtc1VhcVVhakp5dWw4YVZlSzFFVVRDY0ljcWpFQzJt?=
 =?utf-8?B?K0hYbUF5VGw5ZGFxYkFGMHh2V1BQK2VNcWd0Q08yU0R5UHpiSkc4SEtlRG5s?=
 =?utf-8?B?KzBkS1BVdHloN2VPbCtNTFZMeWlWUWQvc085Y2M3ZEdHVEtUZzAvNEZvNm5V?=
 =?utf-8?B?enc5YU01enQ0clFDTUFpTnBIZEQ1dktvWFY2VE1uWlh6dXJRU1QwUFQzSWxo?=
 =?utf-8?B?Mzd3eEgxdjIvd25LNlJiNTJpWEN5Uy9CY3BwamNZaU1Kc2QrQkEva0p0dlJP?=
 =?utf-8?B?MGw2cVZFd0NnRDhvdlVJYVJUTVV0Mk9TNVI2c2hWOUFKMUhCSTg0WWFWdlNt?=
 =?utf-8?B?UVo1RnM1MjRSaTdEMzV0c3BqeHJuTFZ1SncyQTVSSStjRVJzTnVDcWxONFlS?=
 =?utf-8?B?bTNSMmsyOXU1cnRwa2dKY3JVNHIyYXRDWkNjV2dZRk5BZ2lYYXp2Ri9FbHlq?=
 =?utf-8?B?ZGk2K1VjdTRmWEZ4bkVIb3N3eEZrRmtRbEIwVjB1VFhtUlhvUU91WG95T0Qr?=
 =?utf-8?Q?qqJcgdPQkOvJA5RTRp4LKKpoW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4f29c-a907-43f7-218c-08dcc70c1675
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 02:49:51.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9WgRCUGvHPVqyS8/mveAvAG++FBtuh5QugGLWjcreOtfj3cUc3qUaYJi4gVelDr5M9lRZG4PprDldCjswPmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com



On 8/28/2024 12:16 AM, Jonathan Cameron wrote:
> On Tue, 13 Aug 2024 19:05:30 +0800
> Yanfei Xu <yanfei.xu@intel.com> wrote:
> 
>> commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
>> related info") added another implementation of waiting for
>> memory_info_valid without realizing it duplicated wait_for_valid()
> Mention here the name of the other duplicate function
> 
> Also good to call out why you picked this duplicate to remove
> over the other one.
> 
> Otherwise looks good to me.
> So with that info added.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks! will improve it in next version.

> 
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   drivers/cxl/core/pci.c        | 41 +++++------------------------------
>>   drivers/cxl/cxl.h             |  2 +-
>>   drivers/cxl/port.c            |  2 +-
>>   tools/testing/cxl/test/mock.c |  4 ++--
>>   4 files changed, 9 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 2d69340134da..38c567727dbb 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>>   
>> -static int wait_for_valid(struct pci_dev *pdev, int d)
>> -{
>> -	u32 val;
>> -	int rc;
>> -
>> -	/*
>> -	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
>> -	 * and Size Low registers are valid. Must be set within 1 second of
>> -	 * deassertion of reset to CXL device. Likely it is already set by the
>> -	 * time this runs, but otherwise give a 1.5 second timeout in case of
>> -	 * clock skew.
>> -	 */
>> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>> -	if (rc)
>> -		return rc;
>> -
>> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
>> -		return 0;
>> -
>> -	msleep(1500);
>> -
>> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>> -	if (rc)
>> -		return rc;
>> -
>> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
>> -		return 0;
>> -
>> -	return -ETIMEDOUT;
>> -}
>> -
> 
> 

