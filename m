Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E67226D18;
	Tue, 10 Feb 2026 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765523; cv=fail; b=R9JBFm/8QFlflcZ/6qP2Ks59aUkPhCAzb5yjfGcnag4FKmRpKsmevUfL54ofCcGyuTYdbRzh0RQlydfPU3dhIW1o4Ye2pA48X/m71lhgloH0BzqRzML2XSeBrIvxBJokGiSyhwbsjvTq2nsDxDCH6kjOC9o3Gqbx2c6mncRzRwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765523; c=relaxed/simple;
	bh=LhWMR58yOWDk1YsIIxRtWvMKP7+QkfkBeqtFYEXDdrM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=F8FZOM0ezdP0LFQhQ3r4MW9+0tOq5fShvEQEIP6M/+hMvnZJosu65Q1jBw7YyvKM6gaDtyDGvIg/OM0TQ8yoO+DL/l0anE4iLH10o3OpjUvuQOqzntyhFTyxPuCNpg6lKD932ti+xGvBwLuQB6owxbCZnLnHa+oMKPTkAR7qctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIHAA2Yn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIHAA2Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770765523; x=1802301523;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LhWMR58yOWDk1YsIIxRtWvMKP7+QkfkBeqtFYEXDdrM=;
  b=SIHAA2Yn5CaJlXZ5Z4oDjO/6Dt9eXwEyeu1DdHHHqkqUBVfwgPWLiWHn
   NttzxfoQPe/hOgQy2BXzVd+EVqLOMYAaX1Xw4sfwunW3uScYPnjU6FyOf
   mHX8O/ecNrQMg9DWOQS1Y1rjfuFVTZ5gQZ4WfWdfcI4gIgqA5m15t5JAg
   UB/tBXrIYbRo8zaO+SN8X/8z5DfZnzwqsVMHnId/KDXmKclfkU3V+7L4u
   m8paOaQewqyZbgo2/eCfo1/lNaPOgBGUVQfdff80/sEzWbhsz20Ed9DSk
   oalK2oBOUALRwyAVDVHHWHVH/SGcRYi+zsEiLJITzPwLtErxAcF1fNOf7
   g==;
X-CSE-ConnectionGUID: HKdMeJ1nQguDgCD5+S9E9g==
X-CSE-MsgGUID: DRQUe3HvT9Ww7qgH/YoDxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83344687"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83344687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:18:43 -0800
X-CSE-ConnectionGUID: db9+SazyTuK+OCzHYIMMvQ==
X-CSE-MsgGUID: NFPNeyalT5mUYUfEadritQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211390656"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:18:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 15:18:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 15:18:41 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 15:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F04fkhkmR9jqvADtG4BzHhKvCuGgUL5j3o11LYUrSVSuhVH9bvHc5a0oDeTKmzbcOSHn4XHkx5fJeaDkIPNP5wyA0vs1N21mZdqhgr/lKp0/oqUScO0sVWsw6wv8gpluaLB7wWFUFeFucAmHVrhHHTA3MiqkG5joThbHogZ9car8zxl2Ki/eSHn9D0XOUiCjBBEH5akjyVhThxjVi8Uyu8LpgJ+TbdJVpqeGswiwJAMVA8wIKOjpAI6367ktPwDUXsyPabVxdKyPmNYxj+wwYx2e/1SaS2iBxYnemheU4T7OAQ+oUKF+zAIX0cQ5Q2Fm1GOgwhZaxTTGbw6TyM3SGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNe0TAshtGPFDluHVNcU7VSStvDnTwveS08+qshYUdc=;
 b=m0mcuNu5lYuX+fRPvbT0hvTSqXWQ2ujwbi6SJl/KKvLY4txMJ77SWsp2zplYseAUK3m7mDg9ghiC5v9edDNO+IrtzUiKEceqVkfJuCWn5UZ6misn+5tkp55gK7wDp8TZ0OCQst+zfv6jSPxQEupG8+MZwtF8c6s5pxIELYxYSXBVzakN/89vJLDzQk3JNFVLZSC20Nx0J+rqpDHutqxnQmJWU363HnAC+R71HgL1V4sX07O5sQIk/NJMmOg+STGZ7y7JsIzaKGSAWjmbV0nDSzX3lcEkvG3l3A3rxdv6UVF0IYSr0yjiBmYI/AF5jqPSLYguSLxPM+6qOOS3kLJl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 23:18:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 23:18:39 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 15:18:30 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698bbcc6b9e36_2e5710075@dwillia2-mobl4.notmuch>
In-Reply-To: <20260210154320.1748223-1-gourry@gourry.net>
References: <20260210154320.1748223-1-gourry@gourry.net>
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4fd5c6-01b5-46b6-3502-08de68fab94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1qZW05K2YwQ0x0YmRpVmhBUnd1TGhJYjBLajdXTW9hYWUrT0twK2l3MC83?=
 =?utf-8?B?Rzkwc2ROeHkvYzRaWXd4Wm5MQ2lkUlY5VW5UU2hVRnQ4MG5VQlpORU1UY2Rn?=
 =?utf-8?B?UldlZUN5UFhMN0VCbWdxblozWEdaaUcvTk1YLys0VTNJeDZJSU93NXBSNXMz?=
 =?utf-8?B?RjFBYXc4T0dKS2VmTW5nbkNJOWZnYlB2RWhZS3YvK01vM2ppT0lNQkNtMVdp?=
 =?utf-8?B?M2JzcWV2Y3c3RHp6OGZuaTFUU2QxWkFwbjUrV2FzRUxrNEE5MnZ6OHB0ZEVI?=
 =?utf-8?B?VksxQ0t5WGl3NnhxWXRWNjU3Qm5SQUN5NHEvbDVmcGdHZnRJSGIwT1lCNjN2?=
 =?utf-8?B?QjdBU3BGdHlyYTZGTERxdlNFeUpzWllQUFdOQjZrMkJuN3N4SERZYUZMeC92?=
 =?utf-8?B?blZhbDZ2bVh2MFh5M2tnMUtLb09VVGtHRmphdDB1dnJOcHJkU3Z1c2tEdFhK?=
 =?utf-8?B?VHNpWi9hYzlJYlcwNHZqUjlxeWNZNCtmd2tCSFpLNndJMzhWMm5DdGx4T1lZ?=
 =?utf-8?B?eVJWbGhkRWdYdUNtNTAyMm1aSEdFek01bUFKNW50cUhOdTlINlJ4YUw0VWJw?=
 =?utf-8?B?dHlyd1hyY1NBN1ZVejdmc3g0NXdjWE5rY2toRmtTTlIxT2N4UjN1eGZVYjJ6?=
 =?utf-8?B?MW8vTS9NVGMrZFhlNlZ6dFh4NFlxOUtJNEdOODdrSEgrL0JPNmRrQjJKWndI?=
 =?utf-8?B?aEtSajYvRHY1TTNGNHNvSFlNSE10dW5RYU9RYlRLbUNOOWpmYXZyWENSN202?=
 =?utf-8?B?dUY4alhqZm1tTzRoUXo1MzNOaVMvSmlQRW42dzB3ajFLTStXb1E5RlVXYWo3?=
 =?utf-8?B?OTVOSHJuWG5tZ2o4ZytGZkdTQXcyd2V2a255MWo1YTlmdlQvQmdqNkFocDJT?=
 =?utf-8?B?di95YWh2cmFjSmNZTzRObmNEc3M2TzNPUnU2RHVtL0FiaEVxUXlhU2pwb2hI?=
 =?utf-8?B?d0RkOURubmpuUVpsUzF3RVpXQW9QSVk5bmJpWVAzMzVkeWUvdDVUSEJaRkEy?=
 =?utf-8?B?M0RjR1pKOEl4RjZCdGV6VmxmWlgybG5hQ2lhQmhrUkVrYVlYNjhTdzYwSks2?=
 =?utf-8?B?N3Jka3ZXUXhESDdMQUZJemJpaUJIU3BiOUpBT0w5QVN0eWtJREhSVXNvV1ZR?=
 =?utf-8?B?a0JrbDlIQmZNY2NnMVl1ZlpaRjQrUzZDVURHTUc1a0pPcDEyQjRLbHU4NHl0?=
 =?utf-8?B?aWRSaWE4a0QvSVk4dlpYWjhoZ28vQ2RibzhxOEVEcnNNbHYrNUIwaTNDVXR0?=
 =?utf-8?B?bk54dHZpZ1RhN0prN3NiTm5lTUNpMVAxYW0rKzNySk9kdjEzbUxEV1o1WG9R?=
 =?utf-8?B?MXM0WEhPKzIwRVFqOWx3RUhpd3kvd1MrczN6U2JrQnRIeVY1TVA4OVd3UTVt?=
 =?utf-8?B?eWRCbk9vanhseUFGTGJBTTUvc0hieTBEZ0lxeU84OFkxNjFKOVlpWU9wZVFP?=
 =?utf-8?B?OHRid0VZbWlYWlRDTHk1R3pTdWJLK254WklnRU9EK3BIY3VRSGZZQ3dhdEtm?=
 =?utf-8?B?RDVpOG93MGttMWdzTUJhdVI3S256YWF3ZVdjTlZmb09XZTA1NHJlaFJ3ZnBY?=
 =?utf-8?B?c1I3Q0RhdmVwWVFzbWNQb2V0RGpRTWFabXp4Yjg0ME93aTBEZittSUZFV2Zy?=
 =?utf-8?B?bjY1dnFzVTgzUVFmYTNwSGpFWFBLbkNmS3IzTTk2SkhqV1B4U2lNellUQWJ2?=
 =?utf-8?B?ZjlldU9vL0ZtNSs1cC9Na21ERjhmQnlsQUVvcnh3S2w5MzQzOTQ2emt5WUdH?=
 =?utf-8?B?QjJML3Uzd1cyNE9UTGdJVEtBVUlaYlo5aHFnZVJmU0o3RWVrRnJZTmdVM1Zk?=
 =?utf-8?B?d1c2RUpaM1VwQkRUam1oS0xscFhCMUhRQzNKZDJpYWFIQTdPcDlWTlF3aDlt?=
 =?utf-8?B?a3VBa3QwVmpRRDhoc2h4dXEyVEJmMUNyeUR4bk1wdmZDSmkwRDc0cXVGcEdm?=
 =?utf-8?B?OEp4Z3lXc08reEJicVpKUjZieVp0eFR4dEROeWh2cnBGbXYyL3pWallJOUNT?=
 =?utf-8?B?RVM3MjBwWDJWY09WVS9TOHpheDl6YWM0S3F5d3ZraERabVlucWNWZG1KWjhy?=
 =?utf-8?B?aDkyV1JwWEFMNU1UeEdNa3FDVWpON3dyc0hnaGt3bVllbVlMTW5yQUdOV0Np?=
 =?utf-8?Q?x9m4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJ6NU1kVUxzRDJtVlRZcHBMWFRZcUdKd2dkalNURzRPbVNDOWxGcWx4dUR5?=
 =?utf-8?B?NmdxTEhxTmpzVXEvKy9lbHBRYjB3WXhuZkVDRkN2ZFV6d09pdGVTOC9xWXYy?=
 =?utf-8?B?ZzZ6Y3lITTJOcEIzdFZnbkhGMk0zeWFqL3NoUGw0SnI1TUFZR1RGYmkrZ0Mx?=
 =?utf-8?B?Qzd4UDhLZ211K1g1THpsdnRQbWJtSWtWQ1JLZmd6OFZjN3FhWXBYYzZEdERx?=
 =?utf-8?B?Tzl2K3k1d2FBNThEUW12TkFTNWREd3ErOEdySFlFaGxMT2tScUtTSkpuT2Jz?=
 =?utf-8?B?NXdrcjc1R3BZZ1FRZ2prd0hkUldoRUIyN3RRdGJNVnZra1RCY0t5alBXaFEr?=
 =?utf-8?B?WTNUang2S3hPbG9KL0ZBS29IZnhlejVNcHlpS3FlVkoyK0FmM0lPaWMwdzNn?=
 =?utf-8?B?ekNvT2wzenlyWmZ0K2FEMTdVcjh0eWcwRmtVRU1IQ24zMHBvejFmbFhleG4r?=
 =?utf-8?B?SGIyUktwNEgvNkdzOWZVNVhiS0ZGTVM1Qy9uTmVsNUF6N1FpU3pqSE1KMlFS?=
 =?utf-8?B?dGhxOW9lenpvaXlJWXMvd1Jxb0ZKMG9NTTFsQkxDZ09sY3hURU8vSWdwRWJK?=
 =?utf-8?B?MFJ6ZXdRMGVaZGt5a0doUUJGT3FXR0poWGJTK2k5NDBldWxkUkoxLzNpejR4?=
 =?utf-8?B?cFRyU3UrU2RkUHVSM1pIM1M2Z3FOUUFDQXRoZy9OZmJUS2w1dzBMMXd0RStF?=
 =?utf-8?B?VlFwODZoNXQ3OWdoSENiYzU4Wkx5MXdaY0puUng2Q2tsR3ZFZHRBQ2swMXdO?=
 =?utf-8?B?dzRSQ3RZRi83UnBBeFF0RXIrZER0M245V0xod3B4YXhhLzl0NzF5TUJVUHpK?=
 =?utf-8?B?RjZEWG1HTWUzQWl3a01ZOHZYQUpCMlhlRXh3RXFHRjcvSTd0U0dVTXB2NG1v?=
 =?utf-8?B?ODVjc2FFK0xQMEJqQU15TzNMM0lLakpFYTlsOHljQ1lxN1F6VzBSYXpzZzhL?=
 =?utf-8?B?VEdyUTZ2eDNCU0FQV2ZmeWhxMi9UZFRLZ3JUM0lRZGUxUnpLZnhuSTg3ZWpC?=
 =?utf-8?B?NGJGMHVYSElRWHBuOTh6eDJwNmc5ZURWYU81dU4vUlJzL3hGOVVpZHpsNDNP?=
 =?utf-8?B?OFRwVGhDajZpQ1BreUVLbGoyTnBVMyszVVhsOEkrcXhLekRkdU11ZTdiampN?=
 =?utf-8?B?R09pcytleVR0diszUFdRWU1LOUF0dXpEY2RPc3hMY3hmckRLUUIxZHM1SEFl?=
 =?utf-8?B?SmxuYWJWbkIwaW5McGozNDRMWXg0TDlQZmpRazVxRllFVW9aemIwWjVsWXdq?=
 =?utf-8?B?QzlFbFFES2w4N0xublY1MWNjM1JHUENyRld5QkVKTUdHSVhZa0ROZURDS3Yw?=
 =?utf-8?B?ajNWbGxFM1ZuV2JEUHFXTHVFRTczOWl0RjhIbXY1QjV5cUc5cUZicFZ2VElB?=
 =?utf-8?B?cDlEKzhWK2w3TmZ6aUpWK1o1QkFrS29EQXBxYzlneUl4ZG5pMUIvank1VkRE?=
 =?utf-8?B?Rm9wRDZJNUFZZHUxd2dVS1VUMVJvZUE0Tk94dGZmKzI3ajU4SVFJTkxQdGJw?=
 =?utf-8?B?bVJRMnhNRDNjQjBCWnl3TVAycWo3Q3B1ZVM1Y2c4emFKR0kxUHVkTFBNMnor?=
 =?utf-8?B?Z3VsK203OTRxT0IzcklOejBpbVIxZ01kN1p5OWdlR0VpR2FtMjhIb3pzWlo1?=
 =?utf-8?B?WEw3M0Q1S1V3TVNXR1A0OFpCbEV4dExGRmRJYVFJQzdPZE1aKy9uV2dwL2dH?=
 =?utf-8?B?dUhkeVhiWXZ5b3RxNUpsQnBmSElLcU1GOEVyODM1cUtEZVdDVk1VRm83VVRy?=
 =?utf-8?B?eFBDb004MDhOdFpXTHl5aUhac2NIUXZ1V3o3a3pkUldMWTFLdVB0ODhTZ0h0?=
 =?utf-8?B?WWpTSUJyZkk5YkVTOGhhQ2hCMXJTWXh0Z1M2d0tqVmNIWjVoUFlYL0piNDI4?=
 =?utf-8?B?dnRsa3VoWDB0Mm5mU0M3enRtVml2UFppdm5jd2Y1Y2lackx5Um44eWZFM3hk?=
 =?utf-8?B?eTJkcUxSd1RyU0wyaHNHeG9lQjZiYWtuRU8vL2xFbllvdHhWazhzT2RqR2Jo?=
 =?utf-8?B?dVdDbmVlMGdKSlB4ekxpODdOdDNsRG02eEQ4aVNvUXVoRm5xQW42azM2RGlG?=
 =?utf-8?B?bE0zUXA5Z0MxTUk3dFVtZ3V0K1BheUVhYmo3TkZ1Z0d1eENyQnBTZVJnajA2?=
 =?utf-8?B?TFhCc2paeHV4SG4ybk1zb2U1Z1laMjY1S0tMNGZLUytZZ2hWOFNXS0F2Wllw?=
 =?utf-8?B?SWNzVkhWMkduMFl0Q1U0V0V3aWpBTS9PeHZWVTI3Z3RCbTJmZkZFZlQ5QzdK?=
 =?utf-8?B?L0pweXNQUXZwV3BUeFB4Y3ZrY1VxS29TeldSZVJwVDNTYTA3cmIxZXNldlB3?=
 =?utf-8?B?VzJsRVZFaTdGQ0JMTnV3SGhQbG5jV3ZmM2k4NktFTGt2UXNiTllaVFVTNGhB?=
 =?utf-8?Q?MNzY+kH/R8BlOgxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4fd5c6-01b5-46b6-3502-08de68fab94b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 23:18:39.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtLBaQ5KPY77zHE3RkV2kbL6lqliCVdHnldMUX5/N1tkBO0Q/qsO+eIi8T+Lcx29yH/HHPAbCPXP+lQHbWpKQq/89ObXPM9w51VG75crmr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

Gregory Price wrote:
> cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> and then calls cxl_memdev_unregister() when the attach callback was
> provided but cxl_mem_probe() failed to bind.
> 
> cxl_memdev_unregister() calls
>   cdev_device_del()
>     device_del()
>       bus_remove_device()
>         device_release_driver()
> 
> which also takes device_lock(), deadlocking the calling thread.
> 
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Fix by using scoped_guard() and breaking out of the guard scope before
> calling cxl_memdev_unregister(), so device_lock() is released first.

Whoops, yes, good catch, but...

> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/memdev.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..c0de767b24fb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  	 * return. Note that failure here could be the result of a race to
>  	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 *
> +	 * Check under device_lock but unregister outside of it, as
> +	 * cxl_memdev_unregister() will also take the device lock.
>  	 */
> -	guard(device)(&cxlmd->dev);
> -	if (cxlmd->attach && !cxlmd->dev.driver) {
> -		cxl_memdev_unregister(cxlmd);
> -		return ERR_PTR(-ENXIO);

...please just make a helper cxl_memdev_did_attach(), and move the
existing comment there. No need for the addtional comment that just adds
narration.

> +	scoped_guard(device, &cxlmd->dev) {

In general, I feel that scoped_guard() is almost always the wrong choice
for existing code and a helper with plain guard() is preferred.

> +		if (cxlmd->attach && !cxlmd->dev.driver)
> +			break;
> +
> +		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
> +					      cxl_memdev_unregister, cxlmd);

Just for completeness, no need to hold the lock over this. The helper
can just check ->attach and ->dev.driver.
