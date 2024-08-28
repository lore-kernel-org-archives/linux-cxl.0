Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE31EC2
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808844; cv=fail; b=B/lbk0E9cUR/TCdB54PhZTGsgpoYGgcYXAteqzZWcQmAy912keMqr8W6n41BrXyLuvbIN/CyVGiGVKi4+eHjNr1GmlauX8JKiG7lhvKkg+H5Zim34qnvMBS7VlRlf6S+FrT2dk5JG8M5Yyvr8+khDENnWnRUvv1bclY+7dwSENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808844; c=relaxed/simple;
	bh=8po6z1ixq0fO4Do7Y9PJMpUgp/5nd/jplw40Ekpnrmo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYXg9mVpGNoIKkYrWVloxn1OUv0rPW7E6AchoFaqp67LPyVwsgZ4AirY4DwRgcTZVsdCHs/uWXq9wXlsMKH8yJNPPKtWaBKPuADLcSSk8RaJaIuICTJ2hvqFx9p2FdtRGjRJBsBM6TJlm1UdqQUgVRirytjyVqCdFOvag6uIrV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHJRu7kz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHJRu7kz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724808843; x=1756344843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8po6z1ixq0fO4Do7Y9PJMpUgp/5nd/jplw40Ekpnrmo=;
  b=NHJRu7kz+maCz+DlAkkGGse1Ql4FZyuRXklu95WJWTI4LVu3b3LAgB1u
   DV+Qyhs7Vd2P81yO4fZ/nTMLY7kQOLJEUv349tyA/0e6JNS0Ym2UcsV8G
   83ZGIwUriKndloThYr5KtoLP2IkF1U6CSf1lVIRl+hnQ/W5ccD4cnkS0o
   +XLvbAVuMezMXAtfSDwtyDm8BrAjZTR1FwK+EHJP7O6RzXNuYVb8HEDYp
   cchOA3ebV2jVlHrlAyhkjJklerbySnm9yYDmj44pWRe7gimnvryzDiNNq
   nkGaVwi1NYnYn14focC8Tu0+vi7hpz8zk00O0hhM8/TLPnVm3x0tDjXYo
   Q==;
X-CSE-ConnectionGUID: QLTlCR/2RNaMHpCiGFgbZQ==
X-CSE-MsgGUID: V/o0ahXTQJGg3bx8q5xaVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34691713"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34691713"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 18:34:03 -0700
X-CSE-ConnectionGUID: zTaJes6hR9OerKrR8dW0zQ==
X-CSE-MsgGUID: yg2m02DDQIWQDvI/9I3kXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62718860"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 18:34:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:34:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:34:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 18:34:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 18:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VemtaEDwZ6Xj8dD3BOe2t0tBE5X+ToAu27q+ITmin9m9Q2RhU+Maxjb9Fov06OHPb1zEs3yteAMPz8WF9wEVKggiwaraJG3AzZXSrOp2zv9rM33bed4KN0gmhBaUL4EdUMK6Bl6nVgAx29svf1nEQ4pkvcYXNhVdmFZUpMI36JXHSWUdEOAQ5x0WwqDukPkbSiqgDaTgFxehROf1Bemc895g3UyjkxXyq+O+JWT6KAzLmDaaYtgeNjq3v6bB9G6P8xPcjngaLd/KaKQYJwhG2Yf4p5IAOGKtU6NufNN8jyktXwyVOHLgPPidMemn5MYZf9uxLNi/Y7Cyqe6pNINkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L3x81zVDRvlfn6NmprqGbwWFtJoFchhHRLswrmNldk=;
 b=MyKBmmIy8DwBjsALFIOhn8D2ejvHV3hK/v4O4rfz9TnCLBiSe18/qYbO6G2AsHdS7VFGNq3uELT1X52ESI3qFT5QZL6zHwaidnxeFz3al/XSZfM+5te6obxoZA2lNpdl5x93CV5jw0jUx27dr6YvKdv0suLNgOlhPDVprfnsr20JGQvqv5LYg+o8o7dTApADfjIdRTC+CGp0CKElR9F+YMSPh5DJPxIGwewP41diUd+XANah1g6zkr0Hf9nJ92Can5By8bf+vdmJ4QrQS8V8UclDvVG6kv3A5pkUos5fxSZaty5lfVxZTvZjJTCnci4gc2B210zZKkaZYPae9aziOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 01:33:53 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:33:53 +0000
Message-ID: <642b5a1a-4e0a-483d-871e-6d440a68102c@intel.com>
Date: Wed, 28 Aug 2024 09:33:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop
 goto pattern
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <20240826083058.1509232-1-ming4.li@intel.com>
 <20240826083058.1509232-3-ming4.li@intel.com>
 <20240827130554.000049b3@Huawei.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240827130554.000049b3@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: f6074dc1-8782-4c14-456d-08dcc7017a03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elF4TU04SHg5VzQ1NUVvMHI0UVJvZk5XU3h3MXRVdE91dk82enVkREdUMWk1?=
 =?utf-8?B?SkwxTzZOWUNTbmNabWhCRnVTdFpvYU9qbXlxTFhFMzJzRFp4cVBuVEZLNEdn?=
 =?utf-8?B?dDhYaG83bjQ0VktMRGpSK2VNd1Q0OHRoN2g5a3l3THN2bmxIZDBhcTBGekxH?=
 =?utf-8?B?M2dZV0E1Z29GTnY5d1l4YVpmdmE0L1BYWFBBT2cvTVBBc0EwNU4yNS9xWEc3?=
 =?utf-8?B?QVBmZWwyREZORGZGQVVMbkVBc2ROZXo1eDRYNVYxbkF4VUFHdTRpM0VGeW1U?=
 =?utf-8?B?SVZJN25BbXpDZmxFVFdXU1h0ajdkYWhrNkVSTnhHTlV4TUtSTzJuWnhjTVNx?=
 =?utf-8?B?UEZzT3NRYzRCc0RGQ1dEWDV0K2hWRkhHb29YK1J2VnZjMGd6NnZFS0lJL2dh?=
 =?utf-8?B?VWtWRURjN1o2ck0wck5VWXNiOVJod1VsNGt4ZVRnMVpaYnZwRmJMV1JCc1B1?=
 =?utf-8?B?OE04WXR6bDVQMnhKRUhFODIwT3lBWXRRTjdGZGdFK25sOUFGQ0ZjL1NQRUJB?=
 =?utf-8?B?YmZWTWREYjNtYkhCMzBCb0tCdHd3VkFxMmhpbFlUT0xiYVBPS0grWjNGWnI5?=
 =?utf-8?B?U0lEa1hkMktNcFhRNmY2NVVSOStPaDZETit6WTdFOUNkRE5ZWXljY0U2cXhJ?=
 =?utf-8?B?Y21lTWN2S0dSek5VWm9tWG9Fcnd0QkhiZmJRVGhoQ1REUVVBOU5xSkRjdjIw?=
 =?utf-8?B?c0VwN2xnVHNYUHByQVFYeWVENnJCY2JhUWkxcHg1bDJhZXZqelVDMTh5em5x?=
 =?utf-8?B?T0VjSTcya1EyamtXNVU4bVFocC9RQWc2NUdXakViZURMVVd4d3JZTmpySExS?=
 =?utf-8?B?cVFyWmZMbmwrOEVCMU4xUEc4a0R1N0NiZW5Ja2l3eXFwME02TDNCemZObzVq?=
 =?utf-8?B?RkN5KzBjeWQ4SWlXOWVrNDZJVlNaMU16eU5pVzIzWFlZQ1lCZ0t0eXdPYjdh?=
 =?utf-8?B?K201ZU56djlNSWlTaXgvY0V4TDAxL0dHdTJobFR1bi9jRHA1TWRlekVTV01N?=
 =?utf-8?B?V0gzK2NtUkVGRllNMFBhaktVVkJvUUl3R2M4ZVRzSElhRlNBN2ZDQ0oyVzNz?=
 =?utf-8?B?WWJXcEd6ek5yVjd0Z0JNNVNuS1p1UXlhbDNyb3YwaGxtWjB4MkhtbXpPUG1o?=
 =?utf-8?B?U2tncnRpUFhKWEp3b3c4UnNPQ1dhRkx2RUhKaVlrTlBmQTlIUUJiMVVKcFVB?=
 =?utf-8?B?SUpBd0ZkbkFnV3NmZERZMldvRGZLNzZXWW1LaEJkbDRPcjFzQ24waDFENmNi?=
 =?utf-8?B?OWs1TmVtUUJORFk0eHJjUUtFK2ZPaDFtdU5ER05OWkxtSTczbE43RkdzY2pW?=
 =?utf-8?B?clRRVVpldkhWMVVDZkVaQWN5aXUrYTE0L0dHYnZKeUZWSHYwanNheXdIckRF?=
 =?utf-8?B?VzhRTU5nTGpMNFVHeEVJUFhhclhRejNGcDJLR1NJZFlHZUl3ZEQ2UFBiaXZ1?=
 =?utf-8?B?TEN0S2gyR0RVdUZ6MzFwZ2xrOHlKdnZqbC9DbWNRR3d0SUJRRGZXU2t4NG9X?=
 =?utf-8?B?UmtFVlhObjB4b2VmKzhqZzJxWjI4Zk54RngzSVF6R0J0bDdDZDZqTFJWQm4z?=
 =?utf-8?B?cXBuV2Rsd3ZMaTRJbWM3M2xRc2g1a3l6bFRIeVI5QnJFTUxYRS9nQzN5US9H?=
 =?utf-8?B?QnBJUVA4VHMrYjhTd01PUDYwNFAvemZ6bVMrRUFWZGZkTitHaVoxRXdrV1pW?=
 =?utf-8?B?d1RXTWh4SDc0cnFGMEhGSkdtR2RoNnVkQzg4ME1nNHYwRlAvdlVFUHFMSEJ5?=
 =?utf-8?B?QlFsTW5PQ2IxSU5tY2xwVStzMTFSOGZCNVpPbCtzNXE3dGM5OTdDMU9wQnZX?=
 =?utf-8?B?dXpVdFBYU3FqeUg4bGVjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpsdnU5azc4aE9xdFZZT29vZERjaEh6OTVNTWw0QmFuek5vVWxiTlNUVTZX?=
 =?utf-8?B?VzdsRnRMSGpCNWxWNjBHeVV4SGFLY2xFTHJDWWo4NDRYeld3VWk4ZkI0QXFK?=
 =?utf-8?B?WS9QUnhPMDcweklTV0oyclhwVC9nU1VuT05HTWZPSmxCcmJJTmN4eitEdW8x?=
 =?utf-8?B?RWpOQzNhM3dqWEZuVlN0c1gxelV4YUlYcWhrMHZZQWxObFVyNFBUQ2ZRUkJs?=
 =?utf-8?B?M09zSmxvMXRIRTB3VDdYd1NISGsxZ3l6MjBVNm01Yy9BTFdGL2w2eFdvU09q?=
 =?utf-8?B?TGVPd1N0bVR0YjNpcjRoQXJsTWVGZTZYVktPYTFQOGpmek9xQ25aY2w3R0hp?=
 =?utf-8?B?N0NJckgxM3RmazdrVUdDa1RxZHJyckxwWHRyTkFyY21hcjhBRHpjcW11SHFS?=
 =?utf-8?B?UEtobFRXQjlWTDFpc2s2WE02NGJlREs3NjlPVUdrdzBpR3prMkIyV3FRY3BM?=
 =?utf-8?B?K2lQMjRRRmJUdnBmTXpJbGtjeTJmUHJpZU0zQ0J1OEV2NS9jM0piOEtTaGNm?=
 =?utf-8?B?c25INGV0TC91Mm1ocHhYVXNoOGZOVmFhTThLdWZ6anM3S3N1Rlh0VEN0MGpj?=
 =?utf-8?B?VzhiNnVyMGt1WFVLcjROT3d3Rkt2N28xQmhPZGV2eXhjS0N1a3NoUkFIK1Rn?=
 =?utf-8?B?RW96amtZV2RMcHI5bU1KaFNuSmw0WHVmV25jMHpNZ1l3dmhyemZTakg3TUxt?=
 =?utf-8?B?QVh1VXBtbUo3OTJGczdiK2wvdDJqa2ZQVy9XWnRTSGhWa0hvTkVKa2h6Q1RP?=
 =?utf-8?B?QVdCVVNnUkVJaGh1bVcwS3JENmhISUd1bGsxYUY1UENvZHB6akxEd2dTYXRi?=
 =?utf-8?B?dnAyYzJLREkvVVpnRzRMVGdFVExSOHZZY0ZTREpTd2hFY0wxWTRvTnNSWFVD?=
 =?utf-8?B?VDE3bmVPRWV4aXZhS2U1L2YvMXVyTzRQVUhsNk5VeTYybDNSL1VHWmVpTUJk?=
 =?utf-8?B?cWFMTHVOd1hEalR6WmlIQ08vODd6RTZrM2FRQ2RHb3hXUHpJaXhFVk4rQ1d0?=
 =?utf-8?B?b1pyaHVLVlhYM0lwNFZBVTVRVmJyK3hCWUpua1ZLN1VqN0NvY2MvR01yR1FM?=
 =?utf-8?B?cDFTeUdZR1pHdHJIM2ZnREllWFNQNzdRVkIzdEpzbFovK0cwd09xc0xGYlNG?=
 =?utf-8?B?Wm9Rc2s4MytoVE1wN0JTUDRuQVZmVWw2bGd5Z203T3p6REZFeSs2cEdtMWIr?=
 =?utf-8?B?eHVwb2d5bjc4UW1zS1J0UWNLeE9ra1FFTjJoQml5VkVIVGY3MWFOakhDbWZv?=
 =?utf-8?B?R3kxRGZ5L0FsSlpONDBmUWdrNHA2TjF3U3ZlTzhOWDFZOUtMeDMwdmVNcUFy?=
 =?utf-8?B?dG80enZqUWNzOExlWE53VElVcjhwekRmNyt5VmhaZ2ljeFBRZFVUOXhUVWYz?=
 =?utf-8?B?ZkZUczNHb1pBWnl6VGVTSTlLbGZwOWd3S3oyalowOElxWlhlN3MvTHVxaHly?=
 =?utf-8?B?YU5zVmNIRmVsMDB5ZmFKR1NDNE5pOHc4NGJGYXdUSWdWZENxcS9sd3BFUkJs?=
 =?utf-8?B?a2FXYmwrWUl1TVZaUXk0UFFkWUlaZThHV2R0T01KdmU4WlNSSXRKNmlXQVNo?=
 =?utf-8?B?UmEweFI4UjBBWmx6VWo5TXBXK08zRjVmaWwrUW9GYmtyQStmbDFCelJ6QTZy?=
 =?utf-8?B?RFV0bk1RQnl2SldXbzJIQ016N3U0ellvMU1jYjZnUkdBNE5ycGNEeWtYTUVF?=
 =?utf-8?B?aUlFRlA3MnRDTzkzMlRGVUQ2N250YUo4dVMxQzFiRFdTdnNrdmdOell1Z1pR?=
 =?utf-8?B?aXVvU1FQRUNBRjg1N2JWSVZibmY5VlpMZjJtd0libkpnQXF6YXdmeUpPcW9D?=
 =?utf-8?B?aUNQTVg3YzgzWWkzYjQyNXFrc21VRDNlRDhqcWdaZGtmZHNpUmFWbXRrOWE5?=
 =?utf-8?B?eGREWDZjVnBqZ2hiQ0tTTnNNM1FFNUZlazN3dTdvUElwemROaXYrNWY1dk0x?=
 =?utf-8?B?QmpHLzU1dnBnRm03OUdBWGNuTVhDaWo0NE5IWW9DZytXbnIrRVRQZ25kS1cr?=
 =?utf-8?B?TGVYd043NHd3SGt1QXdhRnhOR1JjWlhIVzlCcHZQOGY2aHRGNWtuZGRlZk9P?=
 =?utf-8?B?SjV0N0xJNldWMHRlRjdaN00zYkR2QjlUczExSEJnZGhueTAyYkVQOHF3YXZx?=
 =?utf-8?Q?drlyFVUw1KKkktPwieFJm9zBX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6074dc1-8782-4c14-456d-08dcc7017a03
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:33:53.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/o/CK5oBBIqw5JFRoafynN/zqe4SToAd3hAVQpQOREDRnxY5esTTjr9XS78NNA58LPYrIasIWlA5il+E6mL4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

On 8/27/2024 8:05 PM, Jonathan Cameron wrote:
> On Mon, 26 Aug 2024 08:30:58 +0000
> Li Ming <ming4.li@intel.com> wrote:
>
>> The "goto error" pattern is not recommended, it can be removed via
>> refactoring.
> I'd avoid this first comment.  Goto error is fine, but not when
> it is not used for all error paths after the first one where it's
> relevant (which is what is happening here)

Sure, will remove it, thanks.

>
>> In __devm_cxl_add_port(), there is a 'goto' to call
>> put_device() for the error cases between device_initialize() and
>> device_add() to dereference the 'struct device' of a new cxl_port.
>> The refactoring is introducing a new function called cxl_port_add()
>> which is used to add the 'struct device' of a new cxl_port to
>> device hierarchy, moving the functions needing the help of above
>> 'goto' into cxl_port_add(), and using a scope-based resource management
>> __free() to drop the open coded put_device() and 'goto' for the error
>> cases.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Nice.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwaei.com>


