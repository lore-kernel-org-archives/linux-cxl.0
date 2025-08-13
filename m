Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79F305E21;
	Wed, 13 Aug 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111471; cv=fail; b=D4bI4fumZTXE7bs2du71h6c2TXtIWEH+MrKloLqOWmsw3GY8bJhRhn0hoA2CVBAg9d2zpz865LuJwPsmY1+DuuLbozN/lRnZxoNzxgz6ZC881bbSE/v7Xz5LcUDKWMgWzGKRdVfHMx6ZLlRMWT70f4s8N+D1PmUHgll6GMCRhb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111471; c=relaxed/simple;
	bh=c/gfpdN8bE18sVtzPViowJlKO8XRxWuj0r5midIZv6o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sVXcjuafJ85P1fbD/+hnwS3FkkTXpRmvHA51eGAlCxNWoYLdgvWdlK4tkqf7k1QvEh6MpDHd9Cz0IpHv0piAtRfkO5tWlLabWS0YMC0aivEkVdMqzwlH0cVW+TU7JeG40HkQWplDc2GWiPRWQqjPOm8tufJzjyQY6ZlQLTagIhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHK5AL2V; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHK5AL2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111470; x=1786647470;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=c/gfpdN8bE18sVtzPViowJlKO8XRxWuj0r5midIZv6o=;
  b=bHK5AL2VnT3gQ9Poig4XyWXNXUZpr3HwHK9NJhHq2sdVsGgNsD1D68bO
   Cluoj9GaLdDUnKmWffns6aSaSRJB4hvLnW5XPGFzND68Ald3JKDZc7Mcm
   kabvvvK+nsGzEwSBCPAt6Tt2yWzjkwPvjh9HoxKN2fqs15S/KbPXDH7nt
   hxn+/7Za6mRbOTLu6L47Xl3Dff1j1NOmNly/F4JFSkX88jKk2dMfpen86
   FxO6qIDkrsYblpYND435ull0pMOH5nw6X5vDrNhsl7DmB6DEF67uDXbEq
   HtJaBRgEdOJSLKOLAmlfzo2/o4y4qPWbBYT6fH6e9RmNPicAmu7AkC8kb
   w==;
X-CSE-ConnectionGUID: /Bm6R9HlTL+5oV36wFNQdw==
X-CSE-MsgGUID: 5KnRy/1oT5Kbyuq4Mpz2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61263744"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61263744"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:57:49 -0700
X-CSE-ConnectionGUID: COtGtR3tSuOYSHSBgwiO5Q==
X-CSE-MsgGUID: +w/a5A8WTla3UjVdTa9NzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171786815"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:57:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 11:57:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 11:57:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 11:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMkWDgAK/duDP/uYQ7knht7pb37ed5ATG/uyorRR2zwwfDStFFLLzTAV5nDrbzLCcvFg3ZdX9OrA5hGHR6ByDCcXQ7svLHuGDfIJa5Fkd3Whpwu9o3tApG4z5Cfjuelhg63uWVvkugf+AXlZ/AlV5V/Q8hVRJcJuawbmZ8z9+zqk2ZUm9YJCFJO+3+PdR4DMSb41h6sgjnAw+9A6T7RzOjoOkvA44tE/35hzpNX2fi2P6Dw0WgDXMw6yndVUAJdgLFAsdAjTmlFFYYQx0Rw35S+7/my+qoeCh06dL8i8nB6pPPChyLUZ9oRoF4aO3GvF1okZ2j4ccMpcddUsvL4loA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSFKRDlQfIsiy5YE9WiyWnkTGQfVOptponYIvF9aTnk=;
 b=mHVEFPtDPiqpTQEiAL0rZs/USozXIN3llhyJU87g5QstG4X9jTRGZ2aJJTVT0omAFUZ6KdPjsnxJYFUuAN1DYyA4dNgcOXTGXKP9ik9RTryOLpZ7KYTl6cH427tfJkbHDD7l6/0XyGj2tGbWQBjCsJw4UEy1pbQRC20f9+6VN/XFb9nz7MP9JVpOUG5Z1LyFoqseFxDjQyv8PguGw8GmQmyk57Hfgz4bGBTu9mqyfH5KuY5cl7b1tqYvYRCH8YgsTY6WV/R4QgZkCBbqSD9hoBF9TWOvScWcnabsiQfJrzyPELH5JTdsmORZBu8f4A026h+6vedC8q1DJiPhsT37DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 18:57:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 18:57:40 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 13 Aug 2025 11:57:38 -0700
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, David Lechner
	<dlechner@baylibre.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Andy Shevchenko" <andriy.shevchenko@intel.com>
Message-ID: <689ce0227a044_50ce100d7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: b64bed61-8a73-4034-8a18-08ddda9b46db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEltZDdOd2xOZE1XaUJhSnZFMVd0QVFqNkdrenAxOXdBUFFVcXhNbGM5dXo5?=
 =?utf-8?B?aXhkdnZET2FsZVRVMzRGY1dDZTFlTVcrSUhDb2x1YjlQOVBMMVgrMXEycWR4?=
 =?utf-8?B?YWFacEI0cGNyRXRaSXF2blMrNlRiTXQrbEE4ZHN1YUNhbGFETjU5Zk5CdkIr?=
 =?utf-8?B?Nyt0RTlPMkFmVVJHL20rejBxOExselhBTlBnWE1pRmQ5Y1dLOHFrTUQvcm1N?=
 =?utf-8?B?T09ZcEkvcFM1bThPc2Z1ckR0SzdpbzVFM1hrblhNZWpXaXVKWUE0b1Q2K2NZ?=
 =?utf-8?B?RDNHSlJlNGIwUmJpTTVsZTlsSGt0L05oUU55Q2hxYjVkUXpxSzFDQml2UGE5?=
 =?utf-8?B?elRKWFFtUXUyVVFuem9FM2xpc24xcitxbTNXbW9LNWNRZWJXbjJQVjhFbkZB?=
 =?utf-8?B?WGtUVTJxL1ZPVW9jZjhTYkY4bnVUZEhoMnVURFNvcmZkcTl0QlVxUDFjVTNK?=
 =?utf-8?B?VjhCOHpKbFNVZmtoT1FpSXNJZlE2Rmk4MWkweWFxeDRzWGZ0WkNRM2c0SHFT?=
 =?utf-8?B?cDBabVpQVlQxeHZZYlNSME5nZjZ3KzNZTUFUT1puSmxoa1FBME9GSUhGMGZU?=
 =?utf-8?B?bFlNSUhvaEVVUEx4Z241aUZKSFc2L2VNc2VrK21nOXF5YjZndUpoa2VqYlVm?=
 =?utf-8?B?WnlTbGxxT25XU3Rkd3BhMjV6L1NndG5lK04zUzQrQ1RQVUJJTFVQaDJQaFR1?=
 =?utf-8?B?Y3BJWHRIOEt0d2JKWklKM0RSZVV5TXFISFlqdDVGSGtpVFdrcVNmWVNQT00z?=
 =?utf-8?B?aHBtR21iWHUxb3pDYnhFSjExN3FONlN3WUFoVVBOcFROSUxXQkd6QzZPRGpr?=
 =?utf-8?B?TyttayttZyt2OG1STFZLK2lGUHFIcXRyNlRhNGFmTHVPU1pCeHRkVmFGUStv?=
 =?utf-8?B?LzlyOTlRendSWW1xVURGQVdTK2V5VVNmU1RRY0VCL1pWaGwrSE5YeEQrTCtX?=
 =?utf-8?B?RXltUnp4UHozN1dDT3g1eEtTa0NJNy96dHVpSldzcC9PQUt3MjE5OUE1Skcz?=
 =?utf-8?B?eHNBRS9YRDVSTGYwY2IrcjMrdERQdjg5eW1mSEFSQllMeFl0b0hCUzJBaHdK?=
 =?utf-8?B?WUlLMHM2Uy9TcU1JdkIxamV1QXMvWWlsWDVvZi9LZjlhNGRVT0JPR1hKZUdS?=
 =?utf-8?B?NERNUURZV1lrbUZZaXgvTmZxUkZWTkNFa2pPM2RyS1l4aGowd1JqNkRIZDdj?=
 =?utf-8?B?TXYxbDF3dFJCbjU1VTUvZWZ0NDdQN1ZUYktLV21iU1NlcCtNa21Bd1ZCQXcv?=
 =?utf-8?B?Rlh5RHpIUjh2Uk5OS2R0dHJaeUdxTEhWcU1aM3UzN0ZNeUtrVGVxTkpLbmZQ?=
 =?utf-8?B?MWdPYXJ2UlJxalVRUmUwaGZaNEpXQnhUcnpHVjhUZm41bEVJQ2toT0k2d3cv?=
 =?utf-8?B?WEpTMS9PUnUwL0xrOW8vbGlscWovWlh5UmNnMUV2RzYydDVYUWNNSVFudm80?=
 =?utf-8?B?amQ4RVRjNHBvbTVGenozU3E4V1REWHo3NzF1aDdEek9IZldMSFhuZUJweFVS?=
 =?utf-8?B?NDZhaUJEV2hpUm83bXJFZ0UxekJ6UkEzdmluaEw5OXFwbVIzZFpoKzVOVWNE?=
 =?utf-8?B?eHc0QTBZVS95UzZrN3c5M09VTGZwdkE3eFRXcEpXSk1obXlPV3FHZXZqbHd0?=
 =?utf-8?B?a29oald3MW9uTXhwRWR1N0g4QUdaZ2dtbGJvYzJNOEM0czBid25pSnBpaHZX?=
 =?utf-8?B?U3pJdlFCKzEzZkQrN2gvMjhUN01EMGs2REhSckRCNElqQXZHWTVkVjBEbUdr?=
 =?utf-8?B?UGk4dEovWmNXaDg0dlVrZ3BhWGtBU2VKb29UOWJ5NkZuRzJCdCtIZ1ptY1I4?=
 =?utf-8?Q?s8wXF6aeuYIDfeDWeDBLrVdedBg7BiI/eKpXk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktGUXZLa09nMVZqZVdjYmRZdFdjOCtsUDE3OUdxS3FidHd6TVN5Y0xDeVhk?=
 =?utf-8?B?aDBjVjBwR2FZNUZ1SjJJNVlRYnoxWVdpTkxSOU9iYk1tbWVkT21XUFpNWjE2?=
 =?utf-8?B?N2Zqek03SUh6KzdlNllSZy9wWEptZE10NHhGN3FVcmE5U09QZDZFcVp5b3Vi?=
 =?utf-8?B?L3VMQXNEdGtkZHNnQlZFcmpIcTRjeG81QVFaVUpTN3loZGZjL0d2aStkUXpH?=
 =?utf-8?B?WTNUYURCcnhEQ3hGQ2lmc0NMM2hpSjRsSmpjdkFWQzJUL0ZyTlBmY2ZEOGFl?=
 =?utf-8?B?TUdxZTY3OHlqZVNhRWhybm9KWThGcnNWYnFLYkFNcTlSbzRmN2NtdlRqdE1y?=
 =?utf-8?B?RHh5akdBdnlqRlJTcUkwb3I0K3hsUEc5Tmp3dDlHYnZpSHkxeWJWL25yelRx?=
 =?utf-8?B?WUtwMEdBTEJqNis3YXFaWkdPWUd1K3dDWXZ2eFRxalFuanEwankyQzduSnRk?=
 =?utf-8?B?WUdmNEJtaVNZYTMrQXNjdDgwMmhGcHR3SlQrRGVnakRsZ08zVkpaNTRPQUlV?=
 =?utf-8?B?c1BVc2xCRjI4Ylo2MHRtbDY5Zmk3TE1oVWpRVEtnN25oZVdqdURPMW5XVURL?=
 =?utf-8?B?Q3RweVpEdGJYY05TZ1VsbXl1eW4veXpmY09mTkdEMHNGL0VWYUlyUTFPbGdu?=
 =?utf-8?B?MUw1VFI0ODVhVDdTZ3EwMlJGTGQzVWZjRjhic05Vb0VaM1NnOGF3MFFZaWpP?=
 =?utf-8?B?Vk1MRndkdk1FOXFIL29XdkZlNkI5QWE3WVV1Q1VZNGlMRm9HbXBsZEFmU2hn?=
 =?utf-8?B?Yk94WlhCVWdBaXdxV0FsTmhRYVVsaVZad3Q5VnUySUcrODJTZDdJRmttSmMw?=
 =?utf-8?B?K1k4dHQ2aUdGVGliR3N0RW5Zd1hudzUyWkF6NlhmUlV3VzNOWHoxeDhWTHly?=
 =?utf-8?B?VVk1b2FmbmNxTVF4bmhrTUlueVZHd0ljbFp0aXNXTGtVWXRoY3BReE1MOUV2?=
 =?utf-8?B?QTJTSjhFSzN0SVZDL08rMzJYM3krU3FqZ3RtTEtrbS9rWHlGY3F3OFNhVk5V?=
 =?utf-8?B?YllFNnlyUTVFUkpsV0JqNUFncXhJNlRBUkwxdUNocCthN2hWaWZMQ1drTnhr?=
 =?utf-8?B?N0NIMlBPVE9BeEwyaUNLTE9tOW5YenVhYzdaSHFWOFV5YkRGNlg3eHRMTmdW?=
 =?utf-8?B?MGhpMVdWQ25Yb2N5ellLVTBiQjRtSndxcEFjeUhNNFVZK3dmQ2EvTWhscThx?=
 =?utf-8?B?S1VjZ0V2V3ZWamtUMnlSbHlCdHFCUVM5czVTV2pPbW5lNnE3VmtMQXF4K2wx?=
 =?utf-8?B?eUNwMTFzZlp5b2JGRVhUWDAvblJTQk9SYVNIbVJ2d1NGZVIwVTI2QzVCUWFw?=
 =?utf-8?B?V0FWME13ZWpWMmhncDFxbkdGSGpuM0NBYVBQVjFDNmE2QlBPZUZrazVYNXc3?=
 =?utf-8?B?NHB0ZjZMLzl4Qmd2WTl3NVlnL0VYbW5FSjdEVmdtcXRJUDV0ZXJwalFGWXo4?=
 =?utf-8?B?RlFocUJ3Z2RyanIxbUlUZGkveDJObHFNNTlDT1RYcFhncmExMVNENTIxKzBr?=
 =?utf-8?B?cXZRMEJDY0pJbEQwTUNKR3FXKzBlQ21yRWk1Mkk1NFViaitrbTdBZ1BBZFVN?=
 =?utf-8?B?amJKRjFPWUE0ZmJHdmFBRzRUZkgrRHI1bXNRcHpJQ0FiZ25FdEhhMGxkV1k0?=
 =?utf-8?B?OUo3M0ZUcGdnUWIyNy9zWXdtRjF0RjVzcUNtRTVJVHdRWVd3ekNkMk43TUNv?=
 =?utf-8?B?TkprTHZTaDhDQ2xiN3dHTDh6THNsYkh0Q1FLOUROeFI4MElWV0VwWUp2bGF6?=
 =?utf-8?B?MFZPRVhtcjU0U2VXUkVHbE5kbTRTN2w5TmJ5Y0tkMjY5YzZhc1A3RXZGbkhS?=
 =?utf-8?B?V0U2TTQvbWhlam5EN3FTNlM3M3JKUVUrZ2habUg0VU5ON2FxdXFyZWNXR3RR?=
 =?utf-8?B?U2dJelNVcXZoem5xVThHSEN6WWlSeTVsNW9ZUEk2VktVUmlUL0dPN3JvVUVI?=
 =?utf-8?B?Y3loM3RhQWNKR2hmMnc2UHpaUHJNMlJaalFhQWUyN3Z0RHhkdklKYXV2eUw1?=
 =?utf-8?B?VHkrVU1sSXZRUVFyc3NRTXNuV01SNDBzMGtOd0R3M2FnekVqTHVLc3dlY3FG?=
 =?utf-8?B?VlJnZTFTYVEwTlBoNEE5bkhucXpFbVpNV2ZYdnBPQzdyQmdRZWhVcm1CSVR4?=
 =?utf-8?B?SExzVnNWOFQ3MnBieHdMWkFVT00zMUE2dGNPVWc0YUN3V01jbzNtVCtaNUc3?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b64bed61-8a73-4034-8a18-08ddda9b46db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:57:40.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dr0v9Ff70PwLMgsUMTAbIiGHmU8Kmv/Fb5K/6uKSg7UPBYzTfnVY/turEuS7dRqX6ylqDE0a+72UXXyVradNxlAsgOa4rL7e1RIPCwbDas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> > Andy reports that the "lock_timer" scheme in kernel/time/posix-timers.c,
> > with its custom usage of DEFINE_CLASS_IS_COND_GUARD(), results in:
> > 
> > kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
> >    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> > 
> > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > find unused static inline functions for W=1 build").
> 
> I so loathe that warning :/

The only case I can think of where it might have some value, if you
squint, is in catching cases where someone defines a conditional guard,
but then somehow fails to use either scoped_cond_guard() or ACQUIRE().

I.e. guard(lock_timer)(timer_id), does not generate a compile time
warning.

However, if someone accidentally mixes guard() and ACQUIRE() in the same
C file, then the warning will not fire.

> 
> > There are 2 ways to solve this, either mark the class_##_lock_err()
> > function as __maybe_unused, or make sure class_##_lock_err() *is* used /
> > gets called to disposition the lock status.
> > 
> > At present __lock_timer() only indicates failure with a NULL __guard_ptr().
> > However, one could imagine that __lock_timer(), or some other custom
> > conditional locking primitive, wants to pass an ERR_PTR() to indicate the
> > reason for the lock acquisition failure.
> > 
> > Update __scoped_cond_guard() to check for ERR_PTR() in addition to NULL
> > @scope values. This allows __lock_timer(), or another open coded
> > DEFINE_CLASS_IS_COND_GUARD() user, to switch to passing an ERR_PTR() in the
> > future. In the meantime, this just silences the warning.
> > 
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Closes: http://lore.kernel.org/aIo18KZpmKuR4hVZ@black.igk.intel.com
> > Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Dave, I am sending this to you to take upstream since the warning came
> > in through the CXL tree. If anyone else wants to take it just holler.
> > 
> >  include/linux/cleanup.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index 4eb83dd71cfe..d8e7d1e5561b 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -423,7 +423,8 @@ _label:									\
> >  
> >  #define __scoped_cond_guard(_name, _fail, _label, args...)		\
> >  	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
> > -		if (!__guard_ptr(_name)(&scope)) {			\
> > +		if (!__guard_ptr(_name)(&scope) ||			\
> > +		     __guard_err(_name)(&scope)) {			\
> >  			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
> >  			_fail;						\
> >  _label:									\
> 
> What does this do for code generation ?

size(1) identical:

   text	   data	    bss	    dec	    hex	filename
  54648	  20439	     64	  75151	  1258f	kernel/time/posix-timers.o

Within that same size it flips the test to a negative branch and reorders the code.

Before:
        scoped_timer_get_or_fail(timer_id)
    1246:       44 89 ff                mov    %r15d,%edi
    1249:       e8 d2 5a 00 00          call   6d20 <class_lock_timer_constructor>
    124e:       49 89 c7                mov    %rax,%r15
    1251:       48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
    1257:       0f 92 c0                setb   %al
    125a:       4d 85 ff                test   %r15,%r15
    125d:       0f 95 c1                setne  %cl
    1260:       84 c8                   test   %cl,%al
    1262:       0f 84 85 00 00 00       je     12ed <__ia32_sys_timer_gettime+0x15d>
    ...
    12ed:       48 c7 c3 ea ff ff ff    mov    $0xffffffffffffffea,%rbx
        if (likely((timr)))
    12f4:       4d 85 ff                test   %r15,%r15
    12f7:       74 0c                   je     1305 <__ia32_sys_timer_gettime+0x175>


After:
        scoped_timer_get_or_fail(timer_id)
    1246:       44 89 ff                mov    %r15d,%edi
    1249:       e8 d2 5a 00 00          call   6d20 <class_lock_timer_constructor>
    124e:       49 89 c7                mov    %rax,%r15
    1251:       48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
    1257:       0f 92 c0                setb   %al
    125a:       4d 85 ff                test   %r15,%r15
    125d:       0f 95 c1                setne  %cl
    1260:       84 c8                   test   %cl,%al
    1262:       75 21                   jne    1285 <__ia32_sys_timer_gettime+0xf5>
    1264:       48 c7 c3 ea ff ff ff    mov    $0xffffffffffffffea,%rbx
    126b:       4d 85 ff                test   %r15,%r15
        if (likely((timr)))
    126e:       0f 84 94 00 00 00       je     1308 <__ia32_sys_timer_gettime+0x178>
