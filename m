Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75792641E3
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204341; cv=fail; b=kkKtvyIxN8zbj0WN74wuu7E3r5L2B6xj/yv0tbnRfg3VnXl088WAO+x3BcH5Mpu0veiITePboKhUYclEZw5sCo7XZLCI53ySqMwlL1L8hN4QJEf9/6eIB81zTLnt7M9wmMW/gqQrZ5jc7II56W+4O152+fWfD3dx2N8unTmaWxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204341; c=relaxed/simple;
	bh=X8l5d9csh3qK5W/LX5mqrDSBn+lhXGpwteiV5o4wEkU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AyHPOUXsbIxkQGmw1NDwGPipGwvp+YaYpe2g8P3VK4idBVcjuShpfA0Vq0pO3xKJZi5Pq+DXn77eCxNj3BtnbkqWispQirjTVak/GfqNtyT7DxM556HXbxWBIC9YIGR0MR6CnK9WkC1JUwrQwN7eZ5IhWeB1z5YjWBl0w33M8pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co/3U9ez; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co/3U9ez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753204340; x=1784740340;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=X8l5d9csh3qK5W/LX5mqrDSBn+lhXGpwteiV5o4wEkU=;
  b=Co/3U9ezWtxvkrnfvyOUPhNec+jT+69mXrgBC+SAlR8CZMAtRQY11TJh
   9iKL5IgOKXpi558COYgBBj7TyjZwps58xuwPNYtLplZ7wzAKyONOAM792
   SAVHeNvWtYT6rK/r+Wt/yRNi+JXTQ/7hjVGHniaXgUj7Vcr8gljKi93ru
   7YEwaRSQXJDu6cIpsabtiDdY7yKlwjy7pbJG71S2M5VKomAcJD8MQnLPm
   6XSNRy0byQMRk9zr2sFixn0xsxxAUhzMwW37ExNz7a5LyboyOql03m0Z/
   K+l+AA8Jff6cWuW7NeupMZZ6n5hp3ceZsKMac63CEcqXlBd+BJrl0TlRH
   A==;
X-CSE-ConnectionGUID: tNWrzqg1TJGkVNzVHQzE2A==
X-CSE-MsgGUID: fcUwVOF5RVOkKN3bWbTVtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="72922465"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="72922465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:12:19 -0700
X-CSE-ConnectionGUID: Cv+WKEDnQDO2r60mYPAXVA==
X-CSE-MsgGUID: tuzVW0MCSzyiYuRFO+Ba1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="190161318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:12:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 10:12:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 10:12:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.78) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 10:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQo61a9BdH6b6v66Hktv1fFe/6s3AztrvU76iD2LFu2yrPlH5vbn05uqD0vMIRcS6Y3qc6YAhurpp/wD73mwwRP2SgXGtiptdPjQmR0FrQsHveoQJtDfD5R3gtwBqMg53y9GxQZrXix4i7tOfkQHGhvOv/mlY4tOkbUzMEWHmpjtsXmtXQN+lcro8Xgd2onShANA+XsL1thlS3iaWcn86BIYtlrlzSMXXbjp3aopygPggbDRVX5RVmK28pZOsGHGMldibel2LMvHae+Muj2w88ONxnYhsTTpWTwxwwZk5WYtOHDL6RCwCtCmuifFbZExOA5Qf+x1cf+cPrQFRQYbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NTtuy/O4qQC9l04fQnVzDunq0g9rQu8uaj7M62zoMo=;
 b=IciLufbVRRfh+B7jvUsysdd+3Fe077rOq9TM+YCGa2LXsDlVYGa0aeupuEA1NyAKqgQsyUXaK3IJ7RnaC+11zLAuPHZTLT9zqqQ4YtnrxivEgMYslM6llUcSjR3+DOYZpew+Ll2YdMFBTx1c44aabDh8/72C/plx/pS3Id0ABnttf9lm8NK1h0LIcf01XJ4Lhe8a1rs6egvJzxZNDOVPCCfDduhDMCKduzCrcB13HZQ+2sSpD6yjBHI2DNVMVRXQvlO/k7Ll+zRZ5oviL6jdHTGHpmB1PNxt9vDTWnt535DpQnjZZ4n5dQXHrvRCGJhqB74lFp0iYfClQsfVlVnSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:12:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:12:17 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 10:12:15 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Gregory Price
	<gourry@gourry.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687fc66f5cf94_134cc71007a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-8-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-8-dave.jiang@intel.com>
Subject: Re: [PATCH v7 07/10] cxl: Change sslbis handler to only handle single
 dport
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: ac70ef0e-ec8e-46b0-f89f-08ddc942e910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US9XVW5GR29kRjhVdFhUcjh3ck9QZDhsK0toaXg3cVNDMFc2VVI0djluQmtl?=
 =?utf-8?B?S21yRElJbTliV1ozUGczM2pCS3pMSlJOd1Rad3dJZVJCK0U5bk9sN3d5dHR6?=
 =?utf-8?B?VWZUWmo3MXNwWFdCNU1makx2UzV4clhYSW1KNHBuaDdGOHZWa3BDUFpMbk93?=
 =?utf-8?B?OXZUYi9JTW1BTGpmT2V3Qk1LSUovNHRTU1ByblZkNUprRmE2VUZ3Zy8wYjM1?=
 =?utf-8?B?K2Uzc2J2TUFlSStscjJsdnU3TzdtM2tiWjAreXBGM1hkeXpva3A5aUl4U2Ex?=
 =?utf-8?B?RWRsS3VjY0c2amtWNkE4Q3FTVUJPcGpGU041ZmVvU3Bkc1ZsalRpQ0JEbTNB?=
 =?utf-8?B?bkV6WEFIOFJVQXVuc0RtSzAwcWQydlF3NnQyNnYzVkQ0K2YyaVNCczVKU1dv?=
 =?utf-8?B?dUw0amhFc2tPc1Z3ZXhkdnhZeERWZ2VhZmZMVy90bmgxZ0ovMWI5SjRlVVhZ?=
 =?utf-8?B?OWx1U09rdnBldC8wTFl1ZklSZUx4ZjdkRWlwYUZocU1jV0t1YlZMWEs3RHlo?=
 =?utf-8?B?YlJpbnZKeGJMczU3R0FWS1YyTVVicnpycG1BWHBBWSsyTEl0cWJxNmhhL3Bh?=
 =?utf-8?B?WW9OWWk0WVdlY29tRDFCUEpsN0hvYmpETkZRbzVzdC9ONXVtR25vM0lPMFoz?=
 =?utf-8?B?bWxjTUZBK0ZTeW9sbU5jYWRXWis4dC9LVnYzNHlYZG5NUHgyR2c3aWVFYUpw?=
 =?utf-8?B?RXF6T0ZtQ1VkNHVzQWJoS3VMTk9ISndYVEVlS3E4MXFUT2orditOZFhtYWhR?=
 =?utf-8?B?R3lIODRreTNpNHl4VU5paGwxVGJwbzE3TW5wVUlnWUhzOUtJNVlySWR3Wms4?=
 =?utf-8?B?TWVXZmp5eEJnVXZBQ3dKRmF3TERIWEpITk5hVU16L3RSdlZuWGJlU2RRN3p4?=
 =?utf-8?B?Q21FVmtzNkdDbElKbVEzc0F2VVBzVE9LTW4vK1QrMC80Z2xOTmlVODJBSXpR?=
 =?utf-8?B?RTJhL1dMZkw3ZDRwYzlSSDcxVFhzakU4QTdxQWJxdEd1Zk14bkxoZnNRc25N?=
 =?utf-8?B?TThMQmI4Q3lac0N0NDg1QVpHMDVvNEV1SEk5SmVRMzNPREdKUnoxczllc1hP?=
 =?utf-8?B?akJza2xPaE9FQXI1UEFHTDFaUE9oZDNTcWt1VHdCRnJRRzJIVEdmVkppMEt2?=
 =?utf-8?B?VGZ4Q2V3VnIzb0ZDK015SGxpLzd3MlVUS1dmTC8vR2swcTcxTXZiRjBqcU5u?=
 =?utf-8?B?YXozc2JxNjY1VnJ6SVZkMjZFVVE1azZMZzRHbjZMRmZjS1lVWEFoNUVqVFRn?=
 =?utf-8?B?WjY3ZktJOHUwemtCdW8rYVk2ZkMyenZ2c0x6UEE4TTRialN6ak9sb2ttK0xS?=
 =?utf-8?B?dk5iMFVmWFhrNDUwMUVId01BNkR2eHAxcDFwTUVKUUY4L2VQV3ZKTm44WnNY?=
 =?utf-8?B?ZUNXZEZxUC8ycDhMTVgwTkRCLzh6SXp2TjEwQzZGYUpySHN3WXE3OEQvelJK?=
 =?utf-8?B?bUx0VU1YZzhVWnFpNE54YkN4RGJzbjZ1eVo4WGVWY1kvcDNYWjdrU1BZMkRT?=
 =?utf-8?B?Q2tVNkVRRk1Ed3pzazBVdjA0Z3Z3elZGallHT3k0WUF0djVkRXRPTDJUak5p?=
 =?utf-8?B?MkNvTGdzdVRvazd0MW9ydnljODU0ajhWYktXL3R1b2lSQ2F2NFR5eVZNeUwz?=
 =?utf-8?B?OWQyVWFRYmpjSG5IcGZ6djRBTjBRRVlZNlVmN21OeG5tazJibWdoNk1GZjZ3?=
 =?utf-8?B?RjZOU2JhUlBOQWNMZFNlbitEQWtXRURrTy92ZEZLVGY4dmVRQUE5VHBNVDhK?=
 =?utf-8?B?Y003UkdhZzJBSmhlM3V6V3l4VXhzSUZ3RUY2TmFjRm1nOThoVDRoZ3FhNkhB?=
 =?utf-8?B?VlRkTlZxU1VVY3VBTUZZdUcrQmhHZjRpb1lXY2gxNnl4dXZIdUlQNld0NEJY?=
 =?utf-8?B?bS9WMm1XbEU2Um5YVFc3Zk9lRkJJY3hybDBOeW9rb01LRExKYzkzcDZrU3o2?=
 =?utf-8?Q?pVPzpqQ9bk4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWgzNk1YZHA2aXZ1ZGRseEVUU3lOQUxXc2VqZC83SkJQMTVqVmozUW9QcnBl?=
 =?utf-8?B?WWZlaVBpWUZhSmFDY3NqN2pMRWZnZmFLZjd1am5xSnRvMzkveFh1dFJBVlRj?=
 =?utf-8?B?V2I5MnFUSjRqT3ZCSER3R29LTzQvWTBienZLR0lhbGIrZmE5aGRWZzdvMll3?=
 =?utf-8?B?UkY4WUoyMGpIb2cwTHdOaXBBZllpeS9vRHNGVW93SUd0WjI5dDdrN0tYUm0z?=
 =?utf-8?B?QzNiNmtRWHBhZE5MMXp1eDFRSEM3d2NmMUlGcFl3QVN4RTQ1VmNoVnpFc0tM?=
 =?utf-8?B?by90Mm5xRlNEdkJxT1RlWW9xcWFxeDFrcysrbjlDK1BaNWZDMjAxN3V3UHFy?=
 =?utf-8?B?d3NRblJvQ0xlUEFYdzU1MVFicEVqRXlyVnVCWXZ4QVpjcmYreGlYOUxkMDFX?=
 =?utf-8?B?L0Z0RXEvcUtTcStoTXZCMURnOWt1QVFSRXU5Vkd0Z3ptWVkxWWFFTXFpUlZi?=
 =?utf-8?B?ZW9tQWhyNlJlK1dZUW8wQnVTLzd2cEg1UGVjSWlUNGVCYk53Q1gzWjlIcnRI?=
 =?utf-8?B?QlVBMTQvT1ZHSXdiR3pvN3NheXFJUk5WYlZQV1p1V0w0YVlXK2xyTklGRi9D?=
 =?utf-8?B?UC9kck5CS3doR3owdU9YcUNDZ3ZOeDBSVFBzeVRLR2R5R2pEbVhvYnFjYUdl?=
 =?utf-8?B?b0wweFVmWVZZajNTcUwyZ3BNUHdaWituUXVVSEgzRVlWMlpOQ1Y1MEwvUy8z?=
 =?utf-8?B?VzVCdmQvdXZYemo1NGhnWnpLUEpSVDFCbElYR1Uzd0RvTWVCeVJmUFNML3Z6?=
 =?utf-8?B?ZVNSZmxyYlJNc0dDaysvRXFNdDlwSEwrVU4zRXJla2d3UmhhY1JnUFgya0RI?=
 =?utf-8?B?YmhCc0EwS0J2S0Z1bWU3KzhmM2dXVmlTVnZ1M3JZQ3lIUGJCRHR2akYwVGFG?=
 =?utf-8?B?VWlxTjV6RGpJZDVzZnQyajRmUWlIbFE3NG1LeXVPM2VmVVVjUjhXVjdWMmhm?=
 =?utf-8?B?R00wb2JyWUlIdlhhYWxCLzFkRDlMR0RxSU1RRW1RU2E1eEpCRWx2V1lObDNB?=
 =?utf-8?B?c0lIQlVvVlRDRnM0eFNmMUhlRUVrNDBnN3JjRnVkeU56Q1RCSE1GR2NyZFMz?=
 =?utf-8?B?QkJrL3UweDI5bGs1MlFRVkZQNjY1MjZ3NFZWTjRndURsUEpnMzJTUVE4Wmpt?=
 =?utf-8?B?aG01VEg0NzBwekRzTWI1OWR1NEZPMjJJT0xkeUdUT0JTMVM1RTh1OC9qNk85?=
 =?utf-8?B?cVREaEt2VEJQK0dzMTRyYjJ0ZTUzZDgxMUJHUThwWDFVK2VTbWJSRk1SSjl0?=
 =?utf-8?B?a2hoNFR3RWZuZXprbk5GcERubko1U1Z2SjR5VGptcTFYakttQnZ5ZTlSbVU5?=
 =?utf-8?B?UCtDK1AvZjZsSk5SRUJzOUpPOUxCOXBOK3g4aGFHUWRaNHR3clBFNWlrN0xm?=
 =?utf-8?B?RktEQzVrMk52MU5xSXduSkw1dXhsNjFSWXpLbitzVXdIZUJrZnc1eWNoOG1G?=
 =?utf-8?B?ajVjaDZrMm9FTVdtMXNmWW5WRjZ2UUtOVlJ2N1NWT3lRbURkbm04VDlZMEF0?=
 =?utf-8?B?cFZQeEtVMjYrMjQvTzRDV1NFbThBSnpZWFVuUU9xOHRWc1dLTlA2S3hjaVd3?=
 =?utf-8?B?Wm9QcHVEbXE0d3E1dG1MOVlrbENkT3VHbFNHK1FyaVR3TWVWc2xGOElZc05K?=
 =?utf-8?B?VVplWUhQVEgrajJzYWJJc3lWa1JWanRGL3krbUtHYm5ialFpajBmZmt5UWNT?=
 =?utf-8?B?OXgyUmJVN1Jrc1B4QjRsenFoeWlpUVRMSmtETnp1Z0lveWcxb29GMmh2c3Yz?=
 =?utf-8?B?WFFNMDN2UVZmcmZYWlp2dWdGRi9uNlRxelNWdCt3VkNHUjVTVnA2UjY4dnpC?=
 =?utf-8?B?cFNjRlQ5bXZwL3dsU1BFVUJJbnBmQjlSMDNZMTlkMXYrb3ppWFM4a1lWa3NL?=
 =?utf-8?B?dUpndXFYeCtUSEtUeDBWRkRZQllkSThvK2JPdTVUOHpzalNFZDFGdEd3Z29s?=
 =?utf-8?B?QVVtTFdSblNhZFY5dTl5Q29kRXRBYWx5WjQraFRZc3RPaGZ5MmV2dlh3YnZ2?=
 =?utf-8?B?V1RtTko0VGd6a0ZHUjg5L0t5MFlZNm1TZWdPUFh3MG5lL0ZnVnA2RnlwaUNR?=
 =?utf-8?B?d2F6UXc1UElEOVVxZVVsbXBvUGFDSmoyYkl0aXErL1AxQVlPY0hhTkFVa3U1?=
 =?utf-8?B?bmpoRERwOVBncklOR1BVWUdlMVc3RXJsN0JxMzBhMXhLZWVSV1NLeUZ6S1px?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac70ef0e-ec8e-46b0-f89f-08ddc942e910
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:12:17.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgLEBx29rjwkEkSum2Q0NO+YIeaE+3TOHQh6Jy9qUV8umUFueUtG9cFQkXrjF4gGl/r5WyI4QcFYSZ43vuPBvpGIoyX74ocD0CHCG/v+waY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 23 ++++++++++-------------
>  drivers/cxl/core/port.c |  2 +-
>  drivers/cxl/cxl.h       |  2 +-
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 0ccef2f2a26a..58c21a2f22c1 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -440,8 +440,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  	} *tbl = (struct acpi_cdat_sslbis_table *)header;
>  	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
>  	struct acpi_cdat_sslbis *sslbis;
> -	struct cxl_port *port = arg;
> -	struct device *dev = &port->dev;
> +	struct cxl_dport *dport = arg;
> +	struct device *dev = &dport->port->dev;
>  	int remain, entries, i;
>  	u16 len;
>  
> @@ -467,8 +467,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
>  		__le64 le_base;
>  		__le16 le_val;
> -		struct cxl_dport *dport;
> -		unsigned long index;
>  		u16 dsp_id;
>  		u64 val;
>  
> @@ -499,28 +497,27 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  		val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
>  				     sslbis->data_type);
>  
> -		xa_for_each(&port->dports, index, dport) {
> -			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
> -			    dsp_id == dport->port_id) {
> -				cxl_access_coordinate_set(dport->coord,
> -							  sslbis->data_type,
> -							  val);
> -			}
> +		if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
> +		    dsp_id == dport->port_id) {
> +			cxl_access_coordinate_set(dport->coord,
> +						  sslbis->data_type, val);
> +			return 0;
>  		}
>  	}
>  
>  	return 0;
>  }
>  
> -void cxl_switch_parse_cdat(struct cxl_port *port)
> +void cxl_switch_parse_cdat(struct cxl_dport *dport)
>  {
> +	struct cxl_port *port = dport->port;
>  	int rc;
>  
>  	if (!port->cdat.table)
>  		return;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
> -			      port, port->cdat.table, port->cdat.length);
> +			      dport, port->cdat.table, port->cdat.length);
>  	rc = cdat_table_parse_output(rc);
>  	if (rc)
>  		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c1de6872e57f..afeebb0ce4ab 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1614,7 +1614,7 @@ static int cxl_port_setup_with_dport(struct cxl_port *port,
>  {
>  	device_lock_assert(&port->dev);
>  
> -	cxl_switch_parse_cdat(port);
> +	cxl_switch_parse_cdat(dport);

Ah, I now realize I misread patch4 where I asked about the ordering of
this function relative to the update. The dport is already added at this
point.

>  
>  	return update_decoders_with_dport(port, dport);

More delayed realization... cxl_port_setup_with_dport() should be
"void", it never fails.

As for this patch, looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
