Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2342158543
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836244; cv=fail; b=HdC/Fuv7JjhkzoJkN3/4MzYMm84sx9lE+QVASF+xp/3khpnAaAv7n26c6mhwoEEvxhERMVFQOVroUi9AORPljTpEsn73WOGuyIxzglxyt1UHMLsFDl1Y3/wpN19kcR6rcM1g4+rij4k9NBzwhJe9cry7kxJW/WDRx36GoxdO+/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836244; c=relaxed/simple;
	bh=ibJ234PcbzSp9jBQ94oAt+CzryP2p+wTU8PTQPV+CeE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n65csvGuVXZjNXjPzS2jPDtgUGNvD0gkAW6mkrxMJMwgfMuS2PPTfxJkNalqSzHt+5X+ymigp84GjBxWt1efgLVLXHMot74KBTIXTwQ5t7Dr9S5B/ZtJC9Ubm4Q/t2WK9155n2tv011l3B/oNzd1MYCLTbhWaqPKX4J6ilzZFPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhxeNGUN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhxeNGUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724836243; x=1756372243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ibJ234PcbzSp9jBQ94oAt+CzryP2p+wTU8PTQPV+CeE=;
  b=lhxeNGUNqsDO8Rp6H1qgUc506GkyMeFzy0jF6CSfQxV8m+wBeJySxtKT
   TmRlEv4dIC2DbfkEy5+I37O6j+CHL+DNe1HR8ErW68JFxmjpE3OEHSJ12
   PKW9CwME3SmE1L5KOOHNbdAQC/8XQuq1JVFbGyiHXVBeKqPIb2D6T5LWf
   PQMpcjpXP4uYrzob3NBz4sneIELvdn+NwaNA9j4cAUvh34TbnPVOvS4x/
   pZk8Jg0g9nHhQD4RGGeLs+k8x+P+G4+o7IlqPJIssj1AN/vTsMJbBNnrB
   EQc7wubN4xITZDWf0bfd05HxDgkVGuNcS8pLfCPwuQjRUVUYwukL0Nsu/
   A==;
X-CSE-ConnectionGUID: C37FpmuLQdCqUWCGg+cSrg==
X-CSE-MsgGUID: FG/jnLxYSca+UagVGugJBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22936459"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22936459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:10:42 -0700
X-CSE-ConnectionGUID: Bf0OJQJ+RICQoHoYHUVhkA==
X-CSE-MsgGUID: ISGx68CJQNubWbux892u6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="68015843"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 02:10:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 02:10:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 02:10:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 02:10:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 02:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoDu4NYz2REMlf3qLvQvS5tKGfyXC9l79Ts1DNoFKB/4cZqCdkIXTocIrJFFttBaS7mCW5HgQ2pz8+JjivOpkCMr6Hqkg9m4Y4lx8Gbs+4FkZi+jVagNezsO+6ERRiw7HrpIDX68+G758c8X/tzxHf/9Cw7j1+jKrKM/Elzip8xs2Cp94YCExR0ePe3eV2x0suC//aPrCkOOVzhRKxb58ionwOZHFT7mnDJSINBVOrU/CfpSiuUMhqlLeg42JaF0wyF+zka9hNWEVHeDwD/yijMHspSbfpSLtp5x0oo2j/cw6BvgjVtZzKzdFGbraIfiVjx66QVWsNxQxf/QnV5R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAOSjwnw3z+c4nev1BLpn85mZYh+YC+eWt8549DVaY8=;
 b=JEJmCNjPHcCVYM1QCFCN2GlHryX+BaMKfa9Jo7wUo4Djfh/jWL3hkeba33OkzRJahRS12bHOyku1YXCIT1Ud8qbdmhzliIvoa8JtyA9MBeu+PQPoZ84+OIR/Kf7CHdaB8Gy2ZnjkvChRQV+a7MivtfyhBNZPTaNUGh3BBdAW4uzUR1xiRKm/mXB+APhEp2WApBS1l5KXR6pvsUKA40TqD4J/Rq14qDxlFcVToyJYC5OUIk3eWyf31a8+ifiT/glJ/DZuKxzy2fz8b+BisoA0wWmzIFyzswvRdG2hzjS1UG4dK4Xwq9uCAathE113+/57Ji4r4da5KRIhqO0Hr2fluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MW5PR11MB5812.namprd11.prod.outlook.com (2603:10b6:303:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 09:10:38 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 09:10:38 +0000
Message-ID: <29717d33-43f4-4a74-81b0-ce80f8e5f804@intel.com>
Date: Wed, 28 Aug 2024 17:10:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cxl/pci: Remove reduplicate host_bridge->native_aer
 checking
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <20240827045755.1837473-1-ming4.li@intel.com>
 <20240827045755.1837473-3-ming4.li@intel.com>
 <20240828092130.000032b4@Huawei.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240828092130.000032b4@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MW5PR11MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7741d7-20e2-4ab7-d9b9-08dcc7414867
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmdLL0psaEN3QUpGV0FpeTF4VGtiR2Uvd1dTdHFkMnY3UnFpTVJObFJyRnU2?=
 =?utf-8?B?bHRJZ1JhRWJNaE43aGMwc1h3S0FmN05zTk5GVnViUW5vNjlHOVFhUmhkK1ky?=
 =?utf-8?B?ZnptU1JJMjBaVk4vdWM1cWttU0tORzdvQUR1dThJdG1rQ3g2ZFIxRFZWbFor?=
 =?utf-8?B?MjRkZ0lEQmJlMDkxVmdVYi9OdVNabkVTR0ZQQ0Y2OTVIV0dVclRMa3JJcTZy?=
 =?utf-8?B?MXVBNHJuNUpMZjlOVUxKTWg5V3dtUjdUUGlOdEpBcldsSGRQM2lNTFJMSEp1?=
 =?utf-8?B?bVpCLzY2Z3RxRndEdHU2QkZKZnRNT2tjQUgrYWVSM2t6NUFIVmNYeDhHR3RG?=
 =?utf-8?B?dUs4cmQwUUIyamtoK3lFcEdVZFk4WXR2OTl3SE9IZ2VvZTJhQWlRV0lnMHBR?=
 =?utf-8?B?TU13a0hkTWtvRVhYTkhiWWtuYjBsV2NuWE5KWVh3ZE5NN1NXUi9tdGtTc0NI?=
 =?utf-8?B?OUtnQUlud244M3JtOEVrMmVKK01HYUpOajZVYmk0b3ZZV29MNlNqVjIxQ1hD?=
 =?utf-8?B?NWNybXAzZU5zSXNQMk4xelZqMytjWEdoNEdPOW5RbWREYnRxVkdDOXhGM2ZD?=
 =?utf-8?B?S2d4a2pTMmNBRDlQS0tETkhORVFDNmZucnA1eVZ3aG5pRTZaSjZmN0hFLzh2?=
 =?utf-8?B?Qy9oWXg4N1FLS0tlbzc2NTBGcEZmbnVwZjMvMDYrb3JQZWd4WlEyZ0h1WHNV?=
 =?utf-8?B?NGJyOHdRWG56M3E2Q25pWFVtL3BuaXp1ZVBkdnJDQk9qcFpVdXJROG93dndt?=
 =?utf-8?B?dTlXMExUR3lXa3RrRFVrNnVmWklXN2FFMzlFTmoydk5tRlR2M2F6cW5lbC9u?=
 =?utf-8?B?TzBzRFFSSVpYTHNYQnUxQUlXbjRxdnR0U0F1YWdydWlHc0tkSWF6RzZiVmtj?=
 =?utf-8?B?NEhlUXlvRHZXQjRNanlGNHhGbm9STXBDL1hGZXRybDVkNy81bnJQSmY5VlRn?=
 =?utf-8?B?bHRWdnhzSG9mQnBWdVZzVlFveFh0aWU0T2IvRmVmTUpySDhKTTU1MlQ1ajRY?=
 =?utf-8?B?QXNaY1lxYlNmdnBzMVJoOTNpQ0xpY2lFM2R5ZXIwWklqTDc0UVJaNlA0ZHpT?=
 =?utf-8?B?Q0hGc3FONXhKVXZxaFpGaUgzTUU0KzNkTnVrVndNa0FBRHVQZmNXVkg1dW1w?=
 =?utf-8?B?RE5zVS82R1ViSHNEQVZHRWhrMU8xazVGUUtYZXVEa1FSSnYwQ0VOUXp6bzRR?=
 =?utf-8?B?eG41VlRVMVBuaWpmeXAvVlB1dlJNV0hvR1VHNWQ5L0JZSHI0Wmpzalp1cXA0?=
 =?utf-8?B?a2s5UUkralVwdjVLTElJZkdzWHZzZU9Udkh1RGtNZ3hrZlpkTWFuTWgxWml2?=
 =?utf-8?B?WUdOY2VqOGRhelVQejZ2V3htdGtXNHVCV3dEcHlHak16U3RhbG54VDJaazNN?=
 =?utf-8?B?Z0xqU1Iyb2ZlWUx6ZWMvZzhTNEpxamV3NFEwdEpmckdsUmYyNE9XMDJQVy9T?=
 =?utf-8?B?d3dtUFl5Q1cwNjRKdysyMkE0VUR0SDE5cFBuN09Zcno1QmRkQlQrQWN2emdX?=
 =?utf-8?B?cExxR291UmJ5Q09QeGtkYjY2M2QyRGNLVjlCeWJKTE5YcU8ya0JDZVgydjJR?=
 =?utf-8?B?MlJDTkhmNWhwTjF3bGxURmoybVJha1RxRFlsQkVQYmxJb3hXUTNpdy95U3Zp?=
 =?utf-8?B?WkkyTkNTRk1DU2tIZnRkWDFTVkFINmtXK0gxaHQ5MXhmTnR6SDBRSWdFMFoy?=
 =?utf-8?B?aXVOR29rYkZCVnJMbCtoZWI1WEdRa3Fyb1R1c1JwNmRZeFk4ZUF2ZFB0Tmg3?=
 =?utf-8?B?Y1pERjMya0tBSVZyYkJaWkNhR2JESDVkODFnQUxJQjRyaWI5T2hGUUZqcDFl?=
 =?utf-8?B?Sjk3V1FpYTVMZit2SFZzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpwWVVISEpuSGZtT3lwSjN1c0VXUTNFQzZhNndFbkpsSzAxdEJTelBZS3pJ?=
 =?utf-8?B?cEtHMDFwaTR0YU8xbitVZXlxOXRyaEh0QzVJeFZOS2JHUENEckdOc09xK0VY?=
 =?utf-8?B?em01cXpraDJGK3YwdW9vdGc2bTZlYUw5Qmt5bDBqd3UvN2xqWitzeWlUUTVx?=
 =?utf-8?B?amdHT3FDQXNSQ1pGT3RWSVRvN1ZIelRaR1A3RnBYOTZmSFdmcTF0dWJqYTNq?=
 =?utf-8?B?Unh3ZUYxd2M4TVNuUUkvMTRjcmVQWU9kUnNPR2lVV3ZLSlEwV0JlMmU0UUZV?=
 =?utf-8?B?ZzluOWdaMlVXYmlkOVpReFhIbVVvM1B6TXpUN014d0hBKy9iZ3c5UTg0aEVW?=
 =?utf-8?B?bnhGM1ZzU3c3YXBzTWVlKzlmdVRhL1JyY1Fub0FpdXVhVTV0UnJXWitjNUM3?=
 =?utf-8?B?ZnVHUzlkOURoOTI4VnNFbjAycUkvN0VaMkZ6MW1SSmsxVEJCRTdVNnZlcWJO?=
 =?utf-8?B?d1hCd25nTjlDbWtKWUVaOU83Ylg3KzJLVzRoYXFKSktPbHdUdTBvRUtmZlhW?=
 =?utf-8?B?SENBUnNlS05JdWZNYkl1Z01XTEIzNUQwdHRaU2hUMkRucUlzWUdVZjVzVVVD?=
 =?utf-8?B?ZkpPNmpaclY2RTh3a0k1NGhXQ2N6dy9XZURrZGJpN1RPVm1pakd1WDlVbGM3?=
 =?utf-8?B?eStCeEFmdzA1S3NsektNS2R6YWdVMjhOM0oyeUtWMERrbU93YmZ1N2RKQVMr?=
 =?utf-8?B?bm9vampVeUNGVFNwVVUvWVk1bTNmZThtVjE5Qi9XaldPUnovOXNQQjZaVzNP?=
 =?utf-8?B?elZVZCtyS1BtZU1iRU8vdFhMV1NsV0Q5M0dDR1FBTVIvTmNid3pLQXAxek9H?=
 =?utf-8?B?THBCVXNGYzBXTDZLOEp4ZFVVNm9sVitoMlZZT0hYZmp6Z1IzaXF1bk9SOGt6?=
 =?utf-8?B?WUwxOVIxbHFIMWdrV01OUmIrL2puQkI2UWtJV213enVyRFNIZi9oWmMyS3V5?=
 =?utf-8?B?YWgyRlJFTG15NDdmUzYzWE1SdUpVVUFjNFhnZjVxRnZEcmlMdERBelc0Njli?=
 =?utf-8?B?cEYzMGdHSXNHNWFsL3oyVndFZnZvVVZoQVJKOGJ1TVZMd0poQVlRRXIyQU9Q?=
 =?utf-8?B?SDdvVEdCcVFqR1BSYkl1TURrakNWZ2NsSmQ3TnlXdTA3Q3Z5ZXlsN1c5VVlX?=
 =?utf-8?B?ZGVjTG5Xd3RlK1FIYXpMNXcyQWRiaktNS1kwWXVuMlY1eG5kVFZUTFpnYVhv?=
 =?utf-8?B?ekF5Nit3ODMzcGxKTWMzUXl4Zmd2YWZ1MjJrbXpIanFrcG4rTU9QVkpZZit5?=
 =?utf-8?B?dHJGc3NHbWVnL211UytaYUx4ek5LUjluN25WVnAycFo4UWIwaU5yUlYwOGNE?=
 =?utf-8?B?RDRhYW1mTFFtQzRsQWJZUTFpaVV3QWpJZU9teS9qUzQxRTdFdnVDd0xFSUZs?=
 =?utf-8?B?M1ZrcFZOVTJ0VE1Oa3RLbW1RSkNJWUVYYnZuR1Bob3NuT1lNN2d0WS9GdldM?=
 =?utf-8?B?U2tQaHF5U2dtdi9BRGJ1b1EzRHl2TXh3MFk1QWhnOVNoZ3lqSDBVc2p1d1Aw?=
 =?utf-8?B?cmpMYUtFenhpby9HYWhZYXNHWnhRNnYvUDd0aERvT2xHZVMycUNSYzA2QVB4?=
 =?utf-8?B?aGFPZ2RLWFBDMDIrQTlxL0tEdU93a215NEpCM2xtZ3RPYk5tQnM3WVc0WFFK?=
 =?utf-8?B?ankzUFNkYVV1RkJDb1NITnNJeHd2YVAzVGdVQVRQTzdlV2RBeVFWYkhrSVU4?=
 =?utf-8?B?cjlzNWFxNGFGYVAyek8xY3l1djR4L1dyOTFHT1k3aEV1clNWck9YOEdCRFdr?=
 =?utf-8?B?a1l5V3lkTmlxS0h2YS9jUWplbWtHZVQ0YWo1SDVzU3M0K0x6SlN4Y011dzA1?=
 =?utf-8?B?TGJSdHNpa1BMOTd4a3ByTURlQ2RjTzJyMXdlSlo0dTZoaytiQ0N0K1VMZXJr?=
 =?utf-8?B?d3g2c3JuVHNsUnk0cUVVQmZ1eFZRejZhVDdjYWYzclRhcWloQUZmeWJUalJ3?=
 =?utf-8?B?b3pRcU9mdm8rV3hQR0F1dXQ4ZGZHNVJURWZ4TTJZcFozRmFLWmFwcVgvV2Qv?=
 =?utf-8?B?NkNldmZzc0hLM2o5ZEdqZlIwUkN1NUlKdkhTYTAzdWRxVVM1MW9ERGt0MEJ1?=
 =?utf-8?B?Si9KdTFRN3RncXFLR0I2ZTUyUmtWOG5ROXlUOFRnRjhBNjcyZi9teGV1eUdZ?=
 =?utf-8?Q?i59ZDu3Y3OdHTjFIaIG7vWPAI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7741d7-20e2-4ab7-d9b9-08dcc7414867
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 09:10:38.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoBqx+w7hSqf4HlQWzFh9+Gxb5bnGFRHsCTSJV0cuxY24oiARGTs29F5gX+wcsOGh+MNMV92mc/WQQ4tZXEUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5812
X-OriginatorOrg: intel.com

On 8/28/2024 4:21 PM, Jonathan Cameron wrote:
> On Tue, 27 Aug 2024 04:57:55 +0000
> Li Ming <ming4.li@intel.com> wrote:
>
> For title, just duplicate (not reduplicate)

Got it, thanks.


>
>> cxl_dport_init_aer() already checks host_bridge->native_aer before
>> invoking cxl_disable_rch_root_ints(), so cxl_disable_rch_root_ints()
>> does not need to check it again.
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/pci.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 118db6a577d7..7234166df0df 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -800,14 +800,11 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  {
>>  	void __iomem *aer_base = dport->regs.dport_aer;
>> -	struct pci_host_bridge *bridge;
>>  	u32 aer_cmd_mask, aer_cmd;
>>  
>>  	if (!aer_base)
>>  		return;
>>  
>> -	bridge = to_pci_host_bridge(dport->dport_dev);
>> -
>>  	/*
>>  	 * Disable RCH root port command interrupts.
>>  	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> @@ -816,14 +813,12 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	 * the root cmd register's interrupts is required. But, PCI spec
>>  	 * shows these are disabled by default on reset.
>>  	 */
>> -	if (bridge->native_aer) {
>> -		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> -				PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> -				PCI_ERR_ROOT_CMD_FATAL_EN);
>> -		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> -		aer_cmd &= ~aer_cmd_mask;
>> -		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> -	}
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>>  /**
>

