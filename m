Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBC280328;
	Tue, 15 Jul 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599615; cv=fail; b=uZaDmxyhg1QDBe+vOJCavAkrePgfHeGV87iQmaUnA96BriPymS5yZApOdazCobglaS7pRauEx3zq5zfTCFc41Q9z5RQ8nIeF796gWx3JNGpDOpzXxO17eE1ZL/VaR0gGQxvytq7nLbB8HlnbrrWUKoO5J4xVZdd0sSd3DVCC8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599615; c=relaxed/simple;
	bh=tf8gMjNbt2AViiu2YPUfZFyjFopuuzz1qTx1v+8LRBM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=T4A4Ye2CdcDYLWx09xBRkZooP0tnjIwNdE08kUKMKlju7HG4n0XrE+h89IpnrBnBauZKkXIN11XVNZbxTf/jMmzIsu5bCpoyEJEydZuQTwMlpBfOZAt/S1KQPnRkrXBpiUtxv1P3BncjfL1/4Pm7lAyfKlmJH2lEEnlgFHfKF4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8kPFUfK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8kPFUfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752599613; x=1784135613;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tf8gMjNbt2AViiu2YPUfZFyjFopuuzz1qTx1v+8LRBM=;
  b=e8kPFUfKDZ43Cf63Y+Ckf5hNBTCVUBQHFJveKH49Zksq/IeKN7vpiucM
   nvhGj1q+qokkZlmPknEPZarbUruwg2sxHkRv4BfDNORax4Qeem+e/n3dY
   bYWOZ77LKiMmyvSBFy4bCh+sljO+EedosjMxN8h2WnuQRdLN/FHklW2ao
   ZjMvy6Ovjj8UL3TcFZwtTyksbC9hUFhg3IjBR2Dk22x+hP1BlTouSFDNN
   tZ8TE7R/Q+a0MLvQLmKZ9MKhtigtdXW4CQ+Xm9xQAVGs5wk3MiIxbuKui
   jU15hU/Lve4v8eJTbLL7VvLVriH5/al5Td/ddV3On/W2AIofWlGn2S8Aq
   A==;
X-CSE-ConnectionGUID: okQUT7fwTl+BggDT23zCbQ==
X-CSE-MsgGUID: P77Z4EU+RJKEsQdmJsPmpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58642715"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58642715"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:13:13 -0700
X-CSE-ConnectionGUID: xVvHPj0QQ2CBTJnIFVilTQ==
X-CSE-MsgGUID: XNekGIGgRpy3Ei0Hi+cNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156681373"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:13:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:13:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 10:13:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJsjKWg5G5KEI+Ng6pfjQ/9ClB8NUSqRHzBrueVWCCKAyVSKvZFBvayWXaF6ZVsHnFjbuls8kEo8oE8WI2dVO63RPxOzDN80s00OTNenHxeBxG8JMI49WbvIRza9SuR/oSfiHuGhSGF0L81d2EQGKEgUx/ECGFA31HJwmzoikuz09WO6ukeyAZgX0w8+Bp7fKdZmpFWX6+wB+FfJQUWGQaES/0FymMspYfgi7rHH1QdkYu5bZHJQiyykmtKqL5MR94YraazzE1WgAPxQAM3DbfbaphGu2VmZ/y7OdMp6duY7sMRrhAwdRani1/4XV/cE3/J/9pI/ZUal0mJmfN9k/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjP0FL4NyI6oyVouJ8mHPxB88e6CxgeRt0YbVulNgbE=;
 b=Ac+Kb8UdKXQwiVSmC3GTAmfJZZG1fY1BVse0MyEeZ/59jjnNxbeQxbLd/en+W2i0Xw79rGltolL6VHK5vWLcsyvg/HeGSO7uoEN12bji7EzHu4+dfAlrx94QWkLSPaPQugAniMSWKE41UWWbBB5OZi21GiFcuQ9V7Uliti6SbFIXLs2nymkiUstIWyHuN8VRH2QORKRT3nhI3er31SGuqJ7F0ScceJ4lTr0SpYx37CGSDih/sWW8xzeFPHtHcHqZc3ntWBZxX9IA4liuc6PJ7L8fcqORwUov1JUtCqNDb9Z0/9P/Vx03wHIPMuM9XuDPOfaEQRgWXgx/nzYKY5a6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 17:13:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 17:13:06 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 15 Jul 2025 10:13:04 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <68768c20640c7_2ead10081@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715172035.00007f96@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-9-dan.j.williams@intel.com>
 <20250715172035.00007f96@huawei.com>
Subject: Re: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c196b8-2d91-45dc-6b49-08ddc3c2dd33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUZ1bGs2N0E5SlJQSnFFUUM3RVhCK3JvWFBQUTBpajlQSVVsQ2NXNlhJd1NY?=
 =?utf-8?B?d1dxREVLb05obEttT01jTm15OTRwbWlnMkEzaDdpZDRGRVpWQnZ6d2ZkL0RQ?=
 =?utf-8?B?ak5oMU1SRnBxUWtlNnphaUlBTTdyNnBRMklWWjM5bTFVMDZabWxtdkxCOURX?=
 =?utf-8?B?MitnUysyV041UHRXbUJhbG4vOWZaOFV2bGFCUkJjbzd2RVFBTUpmalV4M3R3?=
 =?utf-8?B?bmpVT2xsQy9ySzdRdzE1ODAyMzAwRkxHOHl0cmVyV3pWT0FEMjJucHAvenU0?=
 =?utf-8?B?eFBsV3A0c2ppWmhLMmZPWGpiK1JhMHFrblR1MDljekU3WHFTdmJJU2RVOUhj?=
 =?utf-8?B?czYxUjh0VytnaDdJUEdFamU4Y1FBR09hd25KSDZieEZwYXlRUjUzL2IzamlM?=
 =?utf-8?B?UVBVVHVEYXVNMjdUdjBxWlZZZWdrZWxqT2g3VXQ4UVFKZ0JGZmI3LzgrOU9R?=
 =?utf-8?B?ajI1dVZRWkdIWWxtakU3bURhSkJERjBLbFg3cU4wek8rbHcreVJCN2E1SlJa?=
 =?utf-8?B?cjZyRGNmcU1Xa1o5MnhXVG5DOEVISWwwRGhBSSt6am9LWXZJNkVwcWFoYWxa?=
 =?utf-8?B?dmgyVWxaRWNnQVR4YjArMHlrL016ellTakJMRGR6dUJ2TWk3T3l3SllpTDhr?=
 =?utf-8?B?VnBUaE1NL0NFVHdKVjd3UEdrdjFEYW8zdVlqcnBaRkcvV01KTXFEV3hTTndh?=
 =?utf-8?B?S29QQ1R5MFoxYWQzc1FGY0xhb1dFblcrbmRXUG0rWkdLMVV1V0tKcWFNczNs?=
 =?utf-8?B?aHpEcS9yS3pUbjlZWk9jZm5LUkQ1eWV2dERKdThDNzB3enFmemwrQlVSODE5?=
 =?utf-8?B?WTBLRzZjTjA1ZnRQbHFtaUVNanNLTnp6SUwrcUlkZEhiUWEzckQza2t0SFJT?=
 =?utf-8?B?Nlh4Q0lhSWpOaTJvVi9FTGJkYVFLN3VKcnRRQllIalpPbi9SQ1lSM3dZOFZr?=
 =?utf-8?B?N3FIQUF6MDJHNXdEOEZSN281aUFjSjRGK0toYWNWanJCOWlIMGhCU0NMNnhU?=
 =?utf-8?B?T1BOZWpya0tLeG5OU010Y2RsdGEvcUsvVGFpNjJEakhQWDNGb0FEZ3lMWnZw?=
 =?utf-8?B?N3VLYms5M0JCd2JjSHFnSnBtVTNXeDlRT1UyZ3hPamYxQVQvbWZHdTA2US94?=
 =?utf-8?B?U0hsb1BkdFVVZ05mc2M1TWEzUStYK3QvZDVhMXdneUZ4R1NEcUg0K0trbUNQ?=
 =?utf-8?B?Tm1SbVpPQ1pXNlg3MzJ6TUFJTE5TVmlUaENSSUxVOXh0M2N1Y2dhM3R4a3BI?=
 =?utf-8?B?V0NqdU14NjVyaC91K2pzeFhmcmxXMlFnRStScDR2YzliR3ZKMnljSjJyakFF?=
 =?utf-8?B?NXAxbkIwaG5XZ2VBRWN2ZXBSSk9WV0FQemZGQkJ5bHBzcFBEejYwZFBtZE1O?=
 =?utf-8?B?by8vMlZ6amVBbDl0YmdaaUtXc0Z3SFY4d0llRlhRdlhkM2dpRGdDOUVwemkv?=
 =?utf-8?B?VHZ1VFJvNW03K2VhM0FwaERtV3F3T3FHaHR2c1dLNjVBS1BGVHFSbFNkaXJ2?=
 =?utf-8?B?YlJIbHJTcVNTdVkxZ0VTZ2JpaDJSdXphbXhuckFmWDhWQ2V4MW82TDBzcDBH?=
 =?utf-8?B?TzJxMmJHb3lWR1ZGdjI2WDFoS1F5dWVHOEREd0w2UFpMdzF0QXc3SFFvSXFv?=
 =?utf-8?B?S2w3QWxNbzZ2SFNRaFBadG9jNWU3M1JQcTNka1NKY3E3empCMy94Nnp2d0dl?=
 =?utf-8?B?Q1ptM2xWbytsbUdhT0dEL0NieGhEYXFKdFl0RFM0N0pSODA2dVBiU01zaGdH?=
 =?utf-8?B?eGtVVS91T2c0enBWREhDM1lFeG9zZG5mdUJ2R0dselJZclBvMHo1R21RZWRH?=
 =?utf-8?B?bnRQT21tSi9YdnZqZ1Y0RkVTOEJycS9hMTkvU0U0VGxxZ2w2OHJ3aEM0WW9K?=
 =?utf-8?B?OTFFVVhNTFhTTmo5Q0hCTXpXVVpPdngvRDZSdXR2MWRSN2RYVE5rUGd1WU5a?=
 =?utf-8?Q?SOBienKRBxM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThSQVF2dzJXVzBrRGNoeWtQUEhlUXdOdzdZVkRoRzEwaTA5TTVlejVNQjMx?=
 =?utf-8?B?Y040RTZ3WnIxRUo4SlJSdHJkVE0yVTZhTzN5OEFFQURVT0JuZTltUVJwOGda?=
 =?utf-8?B?dHR3clVKVHVybk81WkhlczhsajlYRHRrelYzVUZqbDcwdVgwcVlVbHRKNWpZ?=
 =?utf-8?B?UklBbzlIRkpBTXROVjM5MnNGbU5WM21xVGpRWElNM3hJSTdxdUhlcnQ3c1By?=
 =?utf-8?B?dThueTNYdmEzckN6ODZIZjFFREt0WVh5NHE3WVJjZTh1N0kyZkErRXIwaXdx?=
 =?utf-8?B?SWx2UDJzSEVQOE5lSFBkdkI0bGltVnMwU2prSTBuT3dWZVRWY2EzQzVxR1Rk?=
 =?utf-8?B?V0pyV3VPTVE3c1Zqc3Vwck1qM0QxaVhESUc1SFl1di9XS1l1aE1sNmNLMlF6?=
 =?utf-8?B?Q28yUjlGSXJRRXhEb280ZWpyc2s0TzM5eTQ0ZzQzOFpKMWw5YnJralE4bnN5?=
 =?utf-8?B?d0tVaHhNbkY4UVhidTY5ZmFUSEpPb0tZY20rVzF5QVR4L2tqUTZySnNDeUdH?=
 =?utf-8?B?TXVPMUJ3dmFVYkdzTmozL0lxUzBTd2xGclFicVVOSitjZmwxdzFWUjE1YXRo?=
 =?utf-8?B?TDR2RDFQaVdKa0lzQnQrNmRkYUEzM3FUWkRuL21USis5NFcxQmE2d2MrM1h0?=
 =?utf-8?B?aE1nSjI1VjBGcENORDAvTkZ4S0FZUm8vMUF0VklDKzg0VGovbGwyTGtHMzhY?=
 =?utf-8?B?SStRV1ZzUGp6RXMwRS9Vd0cvOEVNUGg3WGk0M2dia1VsZXZVdkVYVlJzNW5R?=
 =?utf-8?B?WGhRTmt1Rjh4bUhwdHlsVXJEWWVFSFhreTdqeW9rZ1djbDVUVUt6eGdWSlN6?=
 =?utf-8?B?Si9vOUFuaFpWUHhTUG5hTW10UlN5Nm9YV2dFSnd2WjJLbC9manJTMFZ5eXo5?=
 =?utf-8?B?dWtkdmZVQ2NHaWtYL1VyWENnN2ZlQWs3M1V3Z0J2L3JFKzROTlFMN0dzNWpR?=
 =?utf-8?B?dmp6QWFHeXk2MzV3QjZhUGI5bGNNS2xjdzhlVURTdjkxNEhhT0VVa3VyS09Y?=
 =?utf-8?B?RXk5RFU5U2dSaVZJWkJiTkozOWZxQ1pRN1VMWnFpZ01RTzhBSTRwalVVVzdT?=
 =?utf-8?B?T1N6M1A3Z0JZcEtaaTBORjBMVFdaRWZwMmdLMTh4Z0tCcnRweXM2VnEwWUZG?=
 =?utf-8?B?Vm1US2VObkt2ZkpvdlAyV09zVmdhSSt2NG1DbndSSGNLbWoxcjJsbldDSkVT?=
 =?utf-8?B?SGw2YnU2NHdpZEpRa2Nyc0FwWnJGVG9qeW9pVnZTeTQ0eUpmeUdVaWlZc3Y0?=
 =?utf-8?B?WHE4QVVKSWtKWnhFR1VSTUdZNlY0Tm1YYVpJMzFnREhLc3c0aFdKZzUwYWxt?=
 =?utf-8?B?YmFHSlhLYnpueTFoNDVqa3MyV1oxRytFM2Zkd3kzZTlQcDVyVUVUR0JLRTc1?=
 =?utf-8?B?WVUxL3owU2orcmRBbkVJMUxPM3FXRHJUS2hCZ3locU1xYXQrYjlsZGlxUjlO?=
 =?utf-8?B?V3JBR2M5MHBMVmlLYk4wT0xJMVFFM3ZuSzUwR1RJVEcwcnlBVGxodWVNOEhs?=
 =?utf-8?B?WUI5dU9lb2p3ZW1KVkQxbDV6OFVScmtnQ0RGKy9tTVlmOFQ1RUxja1NWMS80?=
 =?utf-8?B?YVFnaDc4SzU2em9jdHVIVW53UHh2SnZ5VVhiQXVaL2pxRENxaWowZnVHVnNj?=
 =?utf-8?B?c3djWFFSSjRuVEJJQ0xFNjdaajhIV0NnYkd2QUhHVjB4Mk5ISmtreVg4cUw2?=
 =?utf-8?B?UXJSRmFUYUhSWm1WUmlvMW9Bbkl5Rno2RUJJSHgvVGZIRnoyOVE3T2RXdGtN?=
 =?utf-8?B?ZFBmSCtZVk84WXhFdUFSc1ZVTGlEWWlhUFpLTmRMdDYxQ3Z1SnFxeS85blFx?=
 =?utf-8?B?aG1TRVVRQnhQUWsxSzFvR0h0T3VsS0RHQ2dNbHNKazEveVZGazF6WURlTC9j?=
 =?utf-8?B?MHBQK2wvS0hUUERBV1l4UkhoTHJ1Z3FYSGIza05MUVV3WGUrUXJSb2lKckRY?=
 =?utf-8?B?Yzh1bVVvMEFwNkgyelJ4WHVuRlJCM25PNVRiTUJzYjF0VXhPK2NvNERQUEdU?=
 =?utf-8?B?NHM1QXVhdHBjWmo1SUVQcGpjQjAxajdxRjd6Q0tzc1FlOVUrb2ZFdTBXY0M1?=
 =?utf-8?B?QndRZmFwRFBkamtLUjB0TDRzbzl0UEh2VGNqblFxUTNCYTEzVk9QbHBUNWdw?=
 =?utf-8?B?aXBOazNtMUlLUDdEUkdVU1FzdTduY0tESG1ORndML0h5dUhRN1VUWW1lZEt3?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c196b8-2d91-45dc-6b49-08ddc3c2dd33
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:13:06.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xM15GhVdLjqEIrC2/oNE+pJS4Dw+No4F4n8wcn82X+j8XFidthZDmtuX/o/d8wn5Mxy8KCHZdySMyRZD52JqeeHX8awrf/HyvVoxb5Dvu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 16:49:32 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
> > The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> > scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> > scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> > representing the state of the conditional lock.
> > 
> > The goal of this conversion is to complete the removal of all explicit
> > unlock calls in the subsystem. I.e. the methods to acquire a lock are
> > solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
> > unlock is implicit / scope-based. In order to make sure all lock sites are
> > converted, the existing rwsem's are consolidated and renamed in 'struct
> > cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
> > between old-world (explicit unlock allowed), and new world (explicit unlock
> > deleted).
> > 
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Two trivial comments inline. 
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4314aaed8ad8..ad60c93be803 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> >  static int attach_target(struct cxl_region *cxlr,
> >  			 struct cxl_endpoint_decoder *cxled, int pos,
> >  			 unsigned int state)
> >  {
> > -	int rc = 0;
> > -
> > -	if (state == TASK_INTERRUPTIBLE)
> > -		rc = down_write_killable(&cxl_region_rwsem);
> > -	else
> > -		down_write(&cxl_region_rwsem);
> > -	if (rc)
> > -		return rc;
> > -
> > -	down_read(&cxl_dpa_rwsem);
> > -	rc = cxl_region_attach(cxlr, cxled, pos);
> > -	up_read(&cxl_dpa_rwsem);
> > -	up_write(&cxl_region_rwsem);
> > +	int rc = __attach_target(cxlr, cxled, pos, state);
> >  
> 
> ... (start of block for next comment)
> 
> > -	if (rc)
> > -		dev_warn(cxled->cxld.dev.parent,
> > -			"failed to attach %s to %s: %d\n",
> > -			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> > +	if (rc == 0)
> > +		return 0;
> >  
> > +	dev_warn(cxled->cxld.dev.parent, "failed to attach %s to %s: %d\n",
> > +		 dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> 
> I'm not seeing a reason for this change.  I prefer the original
> with the error path as the out of line case.

I prefer the out-dent of the message. I'll let Dave tie-break.

> >  	return rc;
> >  }
> 
> 
> > @@ -3592,30 +3552,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
> ...
>   
> >  	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
> >  		dev_err(&cxlr->dev,
> >  			"failed to activate, re-commit region and retry\n");
> > -		rc = -ENXIO;
> > -		goto out;
> > +		return -ENXIO;
> 
> 		return dev_err_probe(&cxlr->dev, -ENXIO,
> 				     "failed to activate, re-commit region and retry\n");
> 
> perhaps. I always like the cleanup.h stuff enabling this as it improves the patch
> line count no end ;)

I think that looks good, but perhaps as a follow-on cleanup?
