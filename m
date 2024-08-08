Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA4189F32
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104009; cv=fail; b=uAZmjTUtOSSM58eOldzLIzmsshZ/FIjZFd2jq9ifMWo3P+vjGz5EP7Ylpul3r9FkBAUsT3U4qwQQxX7QZCx0eS700y0IQ5GoLtkDzxNzKg8v/QvCcBDjjm25igqFiitx3YsjXiScO1kSQc/IeRmtK7XuNO6OWa6ls0VgZygTwFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104009; c=relaxed/simple;
	bh=Asn5gJues3R1SLli27SoyjF9+cBKe05hHHzn9bVHVIQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6vsfNEWfmyDrWH9qVjjZ03eeJ/gBNPPYo6TDKtubKt2E663E06HB/rsz6mmBUoQ/6jRCdfAKa7n5llO6jlDXJlXKFAsqx9qrlA4petRaQbfHS/DLr09nlLrY+LGw52K54mCsfADuZ3ZaJe/omgbg+k/2SumyYqDbdQFJFYheoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndctWXX7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndctWXX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723104007; x=1754640007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Asn5gJues3R1SLli27SoyjF9+cBKe05hHHzn9bVHVIQ=;
  b=ndctWXX7gaJ3uRTX2pfyLeYUmZu0sJv8wNN7NUMPX9KKTos51NRcTzlM
   N5XA3YJfF89lag3+RposoFW3+QLuyeXKKiBHpC02/YBQSYEE+VfIwQQ+9
   ap0l0pPAarIpB+z9hHN5GDRMh37Z0CV2RoTEKaNyoo8Y0hpA5h8MTiRAT
   3CLcFGyxUsmWGKekMfnk9kqDbJuK0pdhVGxavJ2thbjRHeduPosvONodg
   t0gepHoUiZnydQfNjhsCPp2VHGhhxM9nQtDKa3X8d7egoEDE9YFf4snfA
   pD7oeMABNLowJUAIlLE+KKRtrwVClrujrCMfPUSCUiHqlXKhrcyneP4M5
   g==;
X-CSE-ConnectionGUID: U//01wkmS6ij2eF+9vbukA==
X-CSE-MsgGUID: lRazzIluTSerFn5u42smwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21094278"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21094278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:00:04 -0700
X-CSE-ConnectionGUID: rEKN/DAPQHqIkDE/W9Iv+Q==
X-CSE-MsgGUID: MjjFgGv+QwCmcGyy8dGKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61534143"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 01:00:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 01:00:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 01:00:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 01:00:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeG7tSbsRDlVdoa/sOJdL9GiNPesCEhRk/Qoub8GUVxwlP69R5RxWU3wfOKenSIbL6SYNb9HQ/N30T/gWHTqNKr833Eib4Ydzg3rN0F7lXZ7dqtdsXb7xqzrlHQBZmc0M0gDzWZHXP2nQeH1u7Tp7PAyndqDoREr12Bwo7h+HI1VAJZVLAgNNxPO16tjh4cPBhoYVbc3vDHOQTwPPR2G3fDD+KCfeCneZi+w+S9sLb5tzCdpQJCbho89ivysvGvGz+SSB0b4ezMw3e0k5RugB6urPJ7DMyuM7OR4E5I8k53V9PwY/IP6IStGVa9CBmf1XZPFVjknwwVVklqPnLIxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGuPbTPGXAEWVmd877AIvtZg2e5ZUKxW3OF0RPc1XmE=;
 b=gAIeULzXhmC4mkyA29GwN05nrJBmthN5jC52tz0vG7+dXHRhwWWkaC+wcINE3FuUKanl3X64ebDZCJIUG3C7zfMQrPxgpd77kbBZSYPyNYWzTlin5WONtdI+jkAkz2ZE+G2gNda/aBtX5BdozlIO15MS9r4BXDMhIrraJl59bvtyqknGlG7G1TQOivVvKWAXdTv3MN2pHirSVSSbRS7CFp/h/zEH8x7zYK/0ghz7fBjdaggkakXIc7xwj8cyG5RLByTpDOkb91xDAO5pG6LuX3AelEZ5jKo7aK+xc71i7KmtZ1RDJrvehZfddiWPSyMQ9xXtuQkeAj9seBZWgwrqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Thu, 8 Aug
 2024 08:00:00 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 08:00:00 +0000
Message-ID: <116108a3-f974-455e-b530-1e55e4f98758@intel.com>
Date: Thu, 8 Aug 2024 15:59:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
To: Alison Schofield <alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
 <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d17ea7f4-6f0e-466e-d299-08dcb7801a29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzZGbjI2azZqTFdiVTlLK1NqWEh6Z1VDUmQ3VkJtblpwUklzckZJRmhCWTJo?=
 =?utf-8?B?QlNjdUhaQWlWYnJpQ1JrVUJFQmpIaVhaU3hETE9KU21ZbUZlSUFrNzdCOHkw?=
 =?utf-8?B?VXdhTEpqTFZ5STBSQVJiMHNWNzN5MXdzdDJPUmZrTTcrdWppVTE1N043b0dL?=
 =?utf-8?B?VDgwdk1EMDZ4UHAwMWcwT2Ezd004NmdWa2dpNE5FZGtCMEtaZFg0Mmt4czc3?=
 =?utf-8?B?emJwU1pIY0RKcTMvN0RGdHdYOXIzdjRad3NqUGkwdER1U2tJa1ZnTkFZc1VI?=
 =?utf-8?B?M05GdW9mZXZuSUE4aFlGSGlCd2xLTU9aUXpkRENvSEQ0Sm9xdXFRTGNhM3hB?=
 =?utf-8?B?STVYaE9oOWh1VG9zSFdHSnNGVjQzaXd4NmZUcE42azBMYWlPb3dwWXdjNFAz?=
 =?utf-8?B?RUZKU1Y0MkVjczVaVkhCSk83RXFzK1lIMFRLZ1NraGRFaXByaWYrcmYyaVFo?=
 =?utf-8?B?eUx0UTJYNmVRN0pEZnNVUHRKby9BNkxBN0lndmRpUmMwRzd0UEJ2VnV1S2or?=
 =?utf-8?B?NVFxZnh6cVBsZGRQVngxQ3ZKQUsvaHJiZ3J2RWVva2ZhTm5UVHhUcDh4WGU3?=
 =?utf-8?B?RkpSOGlPMG9EK2FyU3VLRXlySjh3QWlHVWFVZkdkeTJlWjQvWDY1Uk9zMTZ5?=
 =?utf-8?B?UkJ4Y1NmRUNYSWlMNExtd3ZiUzgwbGNhYXE2MUpVb2pGT0FDVE5oUi9HNUh6?=
 =?utf-8?B?aFJhemx1eUhjNVBwemh3U0xvWDdvRE5zL2JIdEdtdG5jQitzamZVdU1jd2tJ?=
 =?utf-8?B?Ymp5eWJtaXdJeGcxait3cTN5VmZjWHk1YmJ0cFVGd0E4dHhsUGMvNUVYOXN4?=
 =?utf-8?B?c3ExQWMwQTNCM1pTUnBtdWczWXJ3R05LS0I3dnkvZWZyZk1hNndrODd1Qzhw?=
 =?utf-8?B?bzlHWUpQUG9TYmRJSDRESi96U3BGcllFVWNrTzU2T2N2YXdJdU9VV1FSSkE3?=
 =?utf-8?B?SXNaOHRTTlA4ampXVlNBSmxndkM2N3dGQlRyaExjWklzOHUvVnM2ZlR6WDh6?=
 =?utf-8?B?ZzRIUkxNLytObENUOG1JMzVZOWdncHZEWENDSW5KT1dUT3I1T2JpSFAxeVpN?=
 =?utf-8?B?M1BIMHpsM1ptWkd4TjRzYWgrK2Y3WUVzdFJsdTN5ZHgySmY3alFzR21FVDU0?=
 =?utf-8?B?Ni8rWlRRYm9PME5IQ3AyTmZpSURsQ0xqM1Rqbk90TTRsZXRQTHJseXA5Qk1Z?=
 =?utf-8?B?MlpOY3NEU2FMYXR1ZDhEK2liWDFEbm13bEY3QlIzYWwreTkvNG9KWW1iOWMw?=
 =?utf-8?B?ZnhMVG1YUFVSaU42M2Z5SlIyUlZLSFFHcGVwd1hGaDNpdEJUNWdKTC9zSkdG?=
 =?utf-8?B?N0hlb2NEaitPdkhSd09jR3RpUXlQMlQvNm1UQlJ0MG4yVlNaMS9ZakpFbVh5?=
 =?utf-8?B?WTlGNHAxU1dCL0FPSWgrSXgzbnRiSkU4LzZRS0o1bWl4RjFDNEpxNTVnVWly?=
 =?utf-8?B?Rmd2ZkVzQU9OdER1SXZOeks2WFIrcFFISlY4OXpkUmYxWTViWmYwcG5jOHNs?=
 =?utf-8?B?NXIwY1RZUE1najFSUXpYYThyMG91MEVNTTk0NXFmdzBwcWJicGF0TkhBaDd1?=
 =?utf-8?B?OS9NUW9RdnFqQmdXNUxVTzVSeGxhZWNuM1dZYXBaQ2Ixa1FtU3E5cnp0eDlR?=
 =?utf-8?B?SUo0Mk5pWG9hTEpXa0UyUk9LVlkvbFQyVXBSWVlIY0xHczJsUjFxNCs3Y3Ba?=
 =?utf-8?B?NXYySVkwQjlFRUhvd3NWZ2Urc05iT0k1Qk5rSzJsOUhrbDNud0lON1BUWUtN?=
 =?utf-8?B?TWNrdlVZTEZHVXlvNnJwOVdIOUVHaU81V2dxQ0FvZ3pLc0tyYW5zWjlkUkZq?=
 =?utf-8?B?Q204ekpzRCs5dFhMQjM0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRvNzN0K2VhU3N1RmV2c2RQeVV3dzNvOUhVZ29YZkhLNk9YcXMvRC9BQlJR?=
 =?utf-8?B?QVEydTZSdFpQT2c5WDlSV3d2dTErVEF6NDdqYUlZemlCOWNwbjNJOGszb2h6?=
 =?utf-8?B?Q08xVU1QN2RVcTFrYkZFbUlTS0I1YkV6cVhoVXVOMjJGZUhaUDl2SDhkd1Js?=
 =?utf-8?B?KzF6cGV4Nk5QMTdQTkNHbFkrRW5DQVFLcHlMRXp3em9KR0FkM3JwODlpSHdn?=
 =?utf-8?B?cVlrbXp1eU5ndHZ6MVh6a2VpT0RWeXBaN0lpcXJ5bUVoVi95OW1oN1dacHdy?=
 =?utf-8?B?TkhqUGpjY2VUWmM2TTBxSHJ1RG5sMjU2MU1ZaFJZQ0taZ293WTF4ZGQvZWFi?=
 =?utf-8?B?c1l5dXdka25HQWhSOUNrSjdLSzd6WTFtb08wOEs5MVplK3ZGUDgweXpsb3pm?=
 =?utf-8?B?RDAyR2FHQU96ZU4xalYrL3RFRDZReTFGNHZ2ZzVhaFRSaS94OGp4c1lRcFdR?=
 =?utf-8?B?UnBwaUhCKzBPUHFORU1WMXBpMTJsL01BMEZGNGNzL2ZFOXpBNTdjWmN0MUww?=
 =?utf-8?B?RkFRbzM4MkpLSXovUjhCTkQ1L1AvamhzYkR5YVRLeGV1ZzN0N0hNQ2VNaXQ3?=
 =?utf-8?B?dnlUY1N3SEZrZEoyd0xMa0l1WURPTHB6bndGd0F3UzhSNktXOHBjU0RRNFBt?=
 =?utf-8?B?aG9BYVNZOHBqQXJBb1JCR2xQdWN3MFRSUWNVTm5SM2pkbFB2TUtYZWpTSEZo?=
 =?utf-8?B?WllWUDZwazNjSlZQOU9Id0dqeVcvdHdpZktVNU1XTEdXQkZoR3hSejZwSm5C?=
 =?utf-8?B?eHRGMUZvdU1ubTh2bUFoUmcrUU05bGhiWlpSWk1mUnh2RzFmVXFVOE14Rmcr?=
 =?utf-8?B?NkJZTktwMGtXRUlKamE5TXR4NkQ1SG5NUHlXeFdlWExsYWVNSGcxVXNSeDVp?=
 =?utf-8?B?YXhNaUswNWtJQlJFM3gwZzFwTVlaUWNaTDhqY3ZoZUxjWUdROFgwK2Jla202?=
 =?utf-8?B?eVdlaEhwc1NNTUJ3emdGRTNramJHL2NVTzZyOE5YRjBRMXJZaHA4SXdUeGJz?=
 =?utf-8?B?ZElzRU1QWUhabnE0dEVIck52N0tMTWY2R0hiLzdoOHZRNzdBVmFDQVJvZDFm?=
 =?utf-8?B?YUlJWWdHS0I4bWxiRXU0N3IrdGFCaXlPOTZVZ0R5UkZrK0FBK0J4Q2x6SXh5?=
 =?utf-8?B?MHBDKzcxTEtTZXBMMnJCUm1DZEJUd2F1NE5ONE96TXNGSTJLTUo3M2FCLzdt?=
 =?utf-8?B?V1Q3ZVBNOGt0eGJXLzlWM01CVFVocHRTZUNlSHVmc3djNUluM2FHcUJkOTdG?=
 =?utf-8?B?amU1MDhiT3hzZldHUEUyMWlrOXFIcjBydWFqRTFnc0s4ejdGWUZEUHgza2o0?=
 =?utf-8?B?bk55YlhLNndmdTE1M3hBZzNKN042ZHRnZC93c2tNNVdyV2ZxK1BmcC9BNXA2?=
 =?utf-8?B?d1BJRmw1endJRC8rS1JkaFRtNGNBOS9yajhrcXIzVGE0UVB6TGZCQThMTm1v?=
 =?utf-8?B?KzM4SVE4OXRNTERBSkVhMkhwajVNY1JRcklmU2FJbGhOcURJRVFCNEZWTitI?=
 =?utf-8?B?ZXJnVjNrUjNvMWNUMEdYUVR0NXgwUzJESGJsTUV1L09mV0xOT1lweUJTVDBp?=
 =?utf-8?B?NXpHVDZjQjRDU09RRmlVV0hvN2krdyt0NHJhVUh0SXFTd3BnUWhINDVSTW04?=
 =?utf-8?B?UVlpUWdSd1hFa1BqaGhITDdPQkF4a21Yd3J5dmNQd1dJUUdqa0pFTDJhU2Uv?=
 =?utf-8?B?R243NUJYOWc5blBiaUtGaXVmS2ZyZ0RpSHJKeEtORmJhRE1pNzhtN2d1VmxP?=
 =?utf-8?B?eEMrREV4Uk5PdU5lTWN5ajhSQVd1aFd3QTVDRTFydGhrUnJ4U29ZWGdGOHZa?=
 =?utf-8?B?Znp6eHZBUCs0dVN4Z2lvaEFyVHhEcTZ0ZGJNVFlEcjROUHhoR0NCbkFyNGhI?=
 =?utf-8?B?a3pxOWVTcWlLVjllcUQyeWJCeXQyaUxtbTg5azAzMTJDRm1yRGZJT0syblYv?=
 =?utf-8?B?SmdtQkpBWWNNSjFOcHRwMnFuRnQ2MWJLMERaQmxWSGhvZjhlZysveGRPcDdt?=
 =?utf-8?B?aGxiZ042ZUxHeDliNmVFTGJOalpyOVVrcnRESU40MHhOUk1HaUNJd00wa1Vh?=
 =?utf-8?B?TEYzRDJncGJBNHJrZlhYWDJlNGRYOVJRK0dialJ4cktCdHR2RkxqS0JwZ2tV?=
 =?utf-8?Q?g1eZArkD/t0JOJTB8lxqwen3w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ea7f4-6f0e-466e-d299-08dcb7801a29
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 08:00:00.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuzs1QHHWT6e9xetOAnpxYAh2NkF6KyzrPRkMfub99HiKnaBI+KDw/ZSIfCoci3SRmP6ZdC90R3GR/fWJNmB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
X-OriginatorOrg: intel.com



On 8/8/2024 3:01 AM, Alison Schofield wrote:
> On Wed, Aug 07, 2024 at 09:19:08PM +0800, Yanfei Xu wrote:
>> cxl_endpoint_dvsec_info.ranges means the number of non-zero DVSEC
>> range, and it will be less than the value of HDM_count when occuring
>> zero DVSEC range. Hence using it for looping validation of DVSEC
>> ranges in cxl_hdm_decode_init() and looping DVSEC decoder initialization
>> in devm_cxl_enumerate_decoders could miss non-zero DVSEC ranges. And
>> we should only create decoder for the allowed ranges.
>>
>> Initializing content of all dvsec_range[] to invalid range and moving
>> the check of dvsec_range_allowed() in advance to cxl_dvsec_rr_decode()
>> could address that.
> 
> Hi Yanfei,
> 
> This is interesting but a bit much to review in one patch.
> 
> Please separate the fixes patch, that you comment above, from the refactoring
> and the drop of wait_for_valid() changes. That'll make review easier.

Thanks Alison's suggestion and review! That make sense and I will split
the patch to make it easy to review :)

> 
> For the fix. I understand that you found by inspection. Is the impact
> that the driver will create decoders for NOT allowed ranges?  And
> forgive me for not looking further into the code yet, but I'd like you
> to lead me on that and explain the impact in the commit log.

Yes, it will create decoders for NOT allowed ranges.

> 
> I'm confused when the above says ranges 'means the number of non-zero
> DVSEC range' and then says we should not use ranges while looping
> because it 'could miss non-zero DVSEC ranges.' Is the
> dvsec_range_allowed() callout in cxl_hdm_decoder_init() not doing
> as expected? And why is it a 'could' miss and not an always miss?

My issue of wording.

For example: 2 ranges, the first one is a zero range, the second one is
an available range. In this case, info->ranges = 1.

1. In cxl_hdm_decode_init(), it uses variable "i" which is less than
info->ranges, is used as index of info->dvsec_range[] to validate the
ranges.

for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
     ... dvsec_range_allowed
}

Since info->ranges is 1, so i will only be 0, validating only the first
zero range and not the second avaliable range. As a result, allowed==0.

2. A same issue occurs in devm_cxl_enumerate_decoders(), where
cxlhdm->decoder_count is assigned the value of info->ranges to loop each
decoder while invoking the
init_hdm_decoder()->cxl_setup_hdm_decoder_from_dvsec(). Due to "allowed
== 0" in 1., it returns directly and won't run into 2.

But if ranges could exceed 2 (though the spec defines the maximum as 2
for now), it would encounter the same problem in 2 like 1. What I mean
the appropriate approach would be to store the only non-zero and allowed
ranges in info->dvsec_range[].

> 
> Please v2 with this as a set. I'd prefer seeing the Fix first, unless
> you think the refactor and wait_for_valid() change are required before
> adding the fix.

It's not required, will send v2.

Thanks,
Yanfei

> 
> --Alison
> 
>>
>> Other non-functional changes, refectoring cxl_dvsec_rr_decode to
>> improve its readability and droping wait_for_valid() to use
>> cxl_dvsec_mem_range_valid().
>>
>> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>> Background: Found this issue when reading the CXL code. I didn't encounter
>> the discribed issue in real environment.
>>
>>   drivers/cxl/core/hdm.c        |   2 +-
>>   drivers/cxl/core/pci.c        | 121 +++++++++++++---------------------
>>   drivers/cxl/cxl.h             |   5 +-
>>   drivers/cxl/port.c            |   2 +-
>>   tools/testing/cxl/test/mock.c |   4 +-
>>   5 files changed, 53 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 3df10517a327..65f5fd2e4189 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -768,7 +768,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>>   
>>   	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>>   	len = range_len(&info->dvsec_range[which]);
>> -	if (!len)
>> +	if (WARN_ON(len == 0 || len == CXL_RESOURCE_NONE))
>>   		return -ENOENT;
>>   
>>   	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 8567dd11eaac..c8420a7995f1 100644
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
>>   static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> @@ -322,11 +291,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>>   	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>>   }
>>   
>> -int cxl_dvsec_rr_decode(struct device *dev, int d,
>> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>   			struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>   	int hdm_count, rc, i, ranges = 0;
>> +	int d = cxlds->cxl_dvsec;
>> +	struct cxl_port *root;
>>   	u16 cap, ctrl;
>>   
>>   	if (!d) {
>> @@ -357,10 +329,19 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>   	if (!hdm_count || hdm_count > 2)
>>   		return -EINVAL;
>>   
>> -	rc = wait_for_valid(pdev, d);
>> -	if (rc) {
>> -		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
>> -		return rc;
>> +	root = to_cxl_port(port->dev.parent);
>> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>> +		root = to_cxl_port(root->dev.parent);
>> +	if (!is_cxl_root(root)) {
>> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
>> +		info->dvsec_range[i] = (struct range) {
>> +			.start = 0,
>> +			.end = CXL_RESOURCE_NONE,
>> +		};
>>   	}
>>   
>>   	/*
>> @@ -373,9 +354,15 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>   		return 0;
>>   
>>   	for (i = 0; i < hdm_count; i++) {
>> +		struct device *cxld_dev;
>> +		struct range dvsec_range;
>>   		u64 base, size;
>>   		u32 temp;
>>   
>> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>> +		if (rc)
>> +			return rc;
>> +
>>   		rc = pci_read_config_dword(
>>   			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>>   		if (rc)
>> @@ -389,13 +376,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>   			return rc;
>>   
>>   		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>> -		if (!size) {
>> -			info->dvsec_range[i] = (struct range) {
>> -				.start = 0,
>> -				.end = CXL_RESOURCE_NONE,
>> -			};
>> +		if (!size)
>>   			continue;
>> -		}
>>   
>>   		rc = pci_read_config_dword(
>>   			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
>> @@ -411,11 +393,22 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>   
>>   		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>>   
>> -		info->dvsec_range[i] = (struct range) {
>> +		dvsec_range = (struct range) {
>>   			.start = base,
>> -			.end = base + size - 1
>> +			.end = base + size - 1,
>>   		};
>>   
>> +		cxld_dev = device_find_child(&root->dev, &dvsec_range,
>> +					     dvsec_range_allowed);
>> +		if (!cxld_dev) {
>> +			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
>> +			continue;
>> +		}
>> +		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
>> +		put_device(cxld_dev);
>> +
>> +		info->dvsec_range[ranges] = dvsec_range;
>> +
>>   		ranges++;
>>   	}
>>   
>> @@ -439,9 +432,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>   	struct cxl_port *port = cxlhdm->port;
>>   	struct device *dev = cxlds->dev;
>> -	struct cxl_port *root;
>> -	int i, rc, allowed;
>>   	u32 global_ctrl = 0;
>> +	int rc;
>>   
>>   	if (hdm)
>>   		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> @@ -455,30 +447,16 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>   	else if (!hdm)
>>   		return -ENODEV;
>>   
>> -	root = to_cxl_port(port->dev.parent);
>> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>> -		root = to_cxl_port(root->dev.parent);
>> -	if (!is_cxl_root(root)) {
>> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
>> -		struct device *cxld_dev;
>> +	if (!info->mem_enabled) {
>> +		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>> +		if (rc)
>> +			return rc;
>>   
>> -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
>> -					     dvsec_range_allowed);
>> -		if (!cxld_dev) {
>> -			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
>> -			continue;
>> -		}
>> -		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
>> -		put_device(cxld_dev);
>> -		allowed++;
>> +		return devm_cxl_enable_mem(&port->dev, cxlds);
>>   	}
>>   
>> -	if (!allowed && info->mem_enabled) {
>> -		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
>> +	if (!info->ranges && info->mem_enabled) {
>> +		dev_err(dev, "No available DVSEC register ranges.\n");
>>   		return -ENXIO;
>>   	}
>>   
>> @@ -491,14 +469,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>   	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
>>   	 * Decoder Capability Enable.
>>   	 */
>> -	if (info->mem_enabled)
>> -		return 0;
>> -
>> -	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>> -	if (rc)
>> -		return rc;
>> -
>> -	return devm_cxl_enable_mem(&port->dev, cxlds);
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>>   
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a6613a6f8923..6d9126d5ee56 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -790,6 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>>   }
>>   int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>   
>> +#define CXL_DVSEC_RANGE_MAX		2
>>   /**
>>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>>    * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
>> @@ -801,7 +802,7 @@ struct cxl_endpoint_dvsec_info {
>>   	bool mem_enabled;
>>   	int ranges;
>>   	struct cxl_port *port;
>> -	struct range dvsec_range[2];
>> +	struct range dvsec_range[CXL_DVSEC_RANGE_MAX];
>>   };
>>   
>>   struct cxl_hdm;
>> @@ -810,7 +811,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>   int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>   				struct cxl_endpoint_dvsec_info *info);
>>   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>> -int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>   			struct cxl_endpoint_dvsec_info *info);
>>   
>>   bool is_cxl_region(struct device *dev);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 97c21566677a..a8c241cb4ce2 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>   	struct cxl_port *root;
>>   	int rc;
>>   
>> -	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
>> +	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index 6f737941dc0e..79fdfaad49e8 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>>   
>> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>> +int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>   			       struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	int rc = 0, index;
>> @@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>>   	if (ops && ops->is_mock_dev(dev))
>>   		rc = 0;
>>   	else
>> -		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
>> +		rc = cxl_dvsec_rr_decode(dev, port, info);
>>   	put_cxl_mock_ops(index);
>>   
>>   	return rc;
>> -- 
>> 2.39.2
>>
>>
> 
