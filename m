Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7018F2F2
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194627; cv=fail; b=WK84CR1h2BpJFhidDCnAFM0mUAmS0YK1z2Qg9yGeuS5W7Ex17Mk3CEQShvt7tlKq1rbJcjAXz+hC9JgYMko3eJarGQ4AgNKwViuzKz/+CHZ9JAX0akUlSCwwWkmXiBB0IYnhUgMh5ec24KFv29wXX7BkZkDxYhWAuR3kyucXy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194627; c=relaxed/simple;
	bh=NUKEE0TQoBIbU5hLeCktxW0uq4j64GJCytrEAYoDyX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egb1FodezI1KFGkJUe1UjQQ8sttd0DaayrSKQK+fwS9skHWe0pGPYKbxmyJDXcx3AbKwz/bMUKf7jeEsbgLIchFU0xl82lM6VkM0bpPSt+QJHM9sUcBo1ps2QlGD4W8RtLs2LQAiWb7UmkNsUy20OBRY7+x6t23lGYbbIUwul+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZwKubu/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZwKubu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723194626; x=1754730626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NUKEE0TQoBIbU5hLeCktxW0uq4j64GJCytrEAYoDyX4=;
  b=JZwKubu/uTeLX38VfwIghkOw3hz8ARaggCTOBhwr2UbDZhj/ANjJJ/si
   9ZyeB/QgKqQIMNTyfpEiA0SbKj9na2DWTKvSEUHsbNDHs+pZ4dA/LzIKd
   B27YXckYhLshCFE+GIDPZ3lAT5HeWfL5+4Tr1e0SoJzAQY3RUyH1OQnvH
   AvG4K3dAN28NDNg6oybx7iPFifnb0q9Hqx06lEMX1kyYbsi8aZB55UIm+
   FoWXhSA9iQQne+He5FARrTtnPXpgRwyXpFNGE4xiP+VvBlItxYzDw4nu6
   FFBHKEqzxjxLgmZEkd1HErKm1L0nVKmhUH331a1LWqLv1fjoPIq3PuH2e
   w==;
X-CSE-ConnectionGUID: EV3kwiDeTkWpPPzwhD+M6A==
X-CSE-MsgGUID: t3rIx+brRfeccUWl7xAGyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21502198"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21502198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:10:25 -0700
X-CSE-ConnectionGUID: nuIhX2TLQYCa2DPmK/iXiw==
X-CSE-MsgGUID: X4hKow+ISdubB+oGWy3gMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57390111"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 02:10:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 02:10:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 02:10:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 02:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs8nQ+AhV5pl7UbD5bdjMZPIxG4iDWG/EHGUY/+o87yYWMC3ad249CxOC9pLRxJEL/U1hgsPpvJmVSCP+yF35vz3vHtIeZfJJaIta4svefZF9pfz20tCwjcoGv1jqHEiOyY1KC/Se4SQdXsuhyIAyt/HC7ltWWteHl2YM1dGvT7EIBXSyEyxNHabEEIgQTYfA2OYe4SHp2EhBcD/h2VuC2ucFTg6uohP+4HbezeOq3mL+frqVUfOwmTnZ6vTp8Zc8b8FL3GkKOjqrQGJusyRN+uo5OiTrf9uF4VvDZECh4M64eGt2YHYya4+0ZQZBGTrTwAA9XA+B+6yGKnoEv3J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyVLR3W7exykTyFlmgkvqVOzJPmNIw3TBkWt4QZKQOU=;
 b=w0CrGeRbASuwwjG9Q702sZNjls9+3Kx44BIcPG1wc5m2woP078ZAjgjVxbzeafGHSwiTkgtxXRw9yrCC+E+ml98eqrX1e6jsoSbdAHVg/DheEKCOMV7o9TFaPHbi/XCUy7z0ssu5e4kQt4AkrOeHW6E8KSfVw524xf1+nul1jC5k3EaGPbuyJio7/aSwgR3U9K57qczK1wI8N+gY922Bk/4CxscvFmxRzliQ+BZiaZAA7KsSvJBnOt5JTAx+ttyxOpdgx3kf2lKg9mpycgrQw/9hYViWFVqjnfkXOSG/QTst7hI1iu+/Q72NU/5v6B/sSebr60WEcFIP9S/T/U1hbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 09:10:21 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Fri, 9 Aug 2024
 09:10:21 +0000
Message-ID: <673f2ca0-d6ab-47e0-9de4-494c6c1cd984@intel.com>
Date: Fri, 9 Aug 2024 17:09:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming4.li@intel.com>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
 <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
 <116108a3-f974-455e-b530-1e55e4f98758@intel.com>
 <20240808100810.00005f5d@Huawei.com>
 <aabdadb7-0281-46e2-8b52-6c87f1d8a49d@intel.com>
 <66b4db4ff3730_c144829418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <66b4db4ff3730_c144829418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To CY8PR11MB7106.namprd11.prod.outlook.com
 (2603:10b6:930:52::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: f9042f4b-206f-4c16-09be-08dcb85317af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dUMWt2QjNjck9KSDBGS3lzK2p2cUFXbmo1bitnVEdua0JWcmJtcGt5Mm5O?=
 =?utf-8?B?ZjIyTWU2anFJVHg5WEtvQ29abVRRL3gxSmJZNnV5cmZOamtwK0VidS8xSW9B?=
 =?utf-8?B?SkJJMVV3ZWs3RXIxMHA3dFUzUlRRZEUySEh5UVhvMHMxTU5ZT2dvbnlPbE1G?=
 =?utf-8?B?c1RDeDVkcGNaVHBvT1pqdngzTXR1NnByK2MzNy9DdUowZEl2czlHRzE0czlP?=
 =?utf-8?B?NXk5V1R2VmxLTzV5MjBUS3hXbEdmUFk0OWJ4ZUZ3OWJzd0pIUjJEelJpeFQ5?=
 =?utf-8?B?T2daVlMvdVdWYllaWWNnOVptdkdnY0pzdVRIYzVoTExCMXIvVVRCZFlVc3k1?=
 =?utf-8?B?NFo3RWdWMVBjVDArTDBzWFhpOEI2RDVYVXVOTDcxQVFaWG16M2VhMkdWeERp?=
 =?utf-8?B?SERobkt5dDZUc3hNcXNacVhxMmV5NjRkeVN2STlTcVZONmxoMGZqaFlraWtP?=
 =?utf-8?B?WHAzY0tmMmEvNnpGRFNsTzMzdHNjc0JOTTVlZTF5WnM5Mm5LL2ZoRjVoVG5u?=
 =?utf-8?B?WWQyNHRHcjRPUXdTOGJEOVIzbzRpVGNxb0VIMVV5Q1Q2VjJTcTJLKzRkMkE5?=
 =?utf-8?B?R1gyWlFxOVVXRTJ4TjU4Q2R1c3MzSlRHRk1NZDJrYVhKT0hFV0pXakRHajN4?=
 =?utf-8?B?MFlLSXpCdkFsaUlwK29XRkRxdTVlcVdkTjkzaDFNVnh0V3ZZbXpTRzJSOGZm?=
 =?utf-8?B?OVVNSDhUN09aVm1LNjhMU1NqTHZGcno2bHM2dVEydnhFUVdLbkZVc2tSMVFa?=
 =?utf-8?B?ZlVnT09BbmRtUTRxeTluaDFhMUpyK21UR3RBRUc0YXNLMG5idFpVR0NDeWdh?=
 =?utf-8?B?UnRyb05ndlppRnkwTXk3Y3RualdyTUc2MGtWSVM4c0UwZXZvVEtZd1pxMHUr?=
 =?utf-8?B?VGREd1RxMlRUcEZxV0NhejJhZHZsajNYZGhSTHZqNDB6dHhFWU5tRVhtYk8z?=
 =?utf-8?B?N2YvT01oeUVya0FOSWVMR1pEd3l6dnZKTVVLMnRjMGpTTy9aMlBhTjQ3MVkx?=
 =?utf-8?B?WVVWZ3VDaEV1ZGZqVFVlZ1h5VndJYU5DRXZsYmc1TkRHMFJoOGIveUpBWjhi?=
 =?utf-8?B?SHI2OE9yRjFGdW5nMlIxZjAzMWNEKzJjanRDWkRoTis4RzZldm8vQ3p6NWNN?=
 =?utf-8?B?d2F5TjBNZVo0SXJKb04zeDluU2xZazdRcUZ0U0NLRjZZZU5GcUZvOXBiMDJJ?=
 =?utf-8?B?VGRBRWZhc25YREV4K1M1ZnpmZkdXWHlYQXBDUmVSMG5rUFBpaTVEclpSVzhC?=
 =?utf-8?B?bFFieUl6c2hqZ21zWTNITXFhOEl1c044WklUclNhUTdYMFMvTXNuUHFjc2pv?=
 =?utf-8?B?cW8vZFhORWNVVHZKR0l2azFoVW9iaUliei9JUXNFcUVBYkVncEtMNHpOdHhX?=
 =?utf-8?B?QzRyK3ZRUVlBdkd3UzlKdEozemNsVWkrYThvS3hKZHFUK0ZmakhuL292SmZj?=
 =?utf-8?B?NGEyeE1RSzlQTnVFS1cyMkwyY0I0YWluTmtJTkl3VlU1VWQ2K1JGamxvVVFq?=
 =?utf-8?B?cVRjdHpxNk5rbjh2UldwWFJBS2ZDa2pqaCtJKzBCRG9XQnlMK25xd1czZVEz?=
 =?utf-8?B?aFAzYVAzeGJ3SUlMaEptT1NXTVR6S0lzUHIzdTB4MVJDdE1uNllvUW5ZVnc5?=
 =?utf-8?B?d0hKS3kxdlA3a0k4bGdORloxMVZueHQ1bkFZODdHckF2NXVMakZuM3k2RlNC?=
 =?utf-8?B?MVQzc3YyVDZiamxoYUtzdUswd0R3Yk9oTHlUVDZ0ZDBYMUNhMEV0RG5kZmJz?=
 =?utf-8?B?dXMvRWNjUVl0cmlJVUhqczlMNGxMOUVYdkhwQlJ2VnBFZmYvMEV3aGlMaUJ1?=
 =?utf-8?B?TFdRVk5hMWNIak82cHd0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01qdHRkS0RzSndDVzF1Z1MraGV4K3NzcER3TWQ3dVduc0s4UGw5bUZraG1n?=
 =?utf-8?B?RnljVW4xR2JOZEJ6WWFESFJ0bFNxVEhsRWk2VTdNSmgwY2N4MXhIMzhYeVI2?=
 =?utf-8?B?bWg5NFpHN0JwRjcvMUs1dUdRMktlU3ZjSDlRWVp1L1FoMlJJa2l3OHB3bTVK?=
 =?utf-8?B?V09nWWhyMlpwSTFLdjR1MkpaYWQ3eGN5NXc4M2hHakZEQUpOOENDVHcyRlpj?=
 =?utf-8?B?UjBwb1YyQ2NlMjBVc0hEam5oYjhjYWkwTVpnUWxGbnV0NzkzSGlPRWQ5azJC?=
 =?utf-8?B?ZFhEQTRxc1NmakhHblU4Qjd1emtBSTlLSDdPbVV2ME56S2xUR1I4ZnVhSWZQ?=
 =?utf-8?B?aEUyOGlyMWxIdlhLeTNGbFJ6aEliVHZDRExVR0xrbVM3THF4YUxVZWxtcG51?=
 =?utf-8?B?WnNoQW9ja0NmOUpTVFdrVThWL0hPU3luUTgxTTROUzFVU0hodmVsai9yZjh3?=
 =?utf-8?B?bTlWc2Y4M3lOWXVoemFHSy9KSGVBNExtTzdWNlN4cnA0WW5XVUZ0cGVROGtu?=
 =?utf-8?B?aUplSE44MEJjT1NpMXgyN3lMbDIwOHlsYmc3K3drREdhY3ZtT2N6ZHpOT01v?=
 =?utf-8?B?WWk3VzFnQTBBT0hraEFOWjdIeXUvNE9qZWZNcDYyZFo5MHptYnlJOUhxcGxi?=
 =?utf-8?B?R3dTMXdvRlI5QWlFUTNJWVpuSS9sdTJ5Z1hFak1rQnNWQzJ5Yk5MQTNQb1BO?=
 =?utf-8?B?cS9GMGx1aDk2ak5venBub01sdVoweUtxemNpeW5WdjN1amlteXlKYm82dFVB?=
 =?utf-8?B?aWIxUXRiM3hvTWlPZEMya2xGajNxS2lzMG55WEk0L0s1U0lMMW14eWRISXk3?=
 =?utf-8?B?RmxqSDZHTUk5cTI2ZlAySW4vVFZ0cVQrVGQyTFFnWmd4YUhLWGlsamM2cGVl?=
 =?utf-8?B?Y1ZUQVFId1hBenFXMWE2clpxeWVUVXRnZ25DUCtnWHpEcVNSZjJ3QmZqTXhV?=
 =?utf-8?B?VXcwK2c4Y2phQVpqZUxGaGRhNkNYYVhYLytxanI4QVFaZlptcnF4akNxTUh6?=
 =?utf-8?B?TWh5MURPNnZhV1dsTlBVNEhHM25IMHNuUjZOaEdKZ25YcXF0OE5CT3RsU0Fu?=
 =?utf-8?B?V3VtRTBGSHFNYmFOaTJKRVNrSytGZWQxbnVQYjJOZTA0elRVelZ5d1R4bEh3?=
 =?utf-8?B?VjZVMVF0OWNKSmhIaDh6cDJzK0ZKa2dvTmFmblFzQjdzWUQ1YzRxdnIwd1FV?=
 =?utf-8?B?UGVmeDRxcExVbFhCQ2pNT2pHMEdBK3JOK2ovbEN5dVJLR1o2cGJ2OFB5WjYz?=
 =?utf-8?B?ZE9POUpSazl0ZUNBTnFWZEVPMDkxbEhBNHJqY2JQN0FKdnp5VllyQVduZXBt?=
 =?utf-8?B?c0J3ZGdoa2tKQzZhTXl0QjJOd1RmTEhLZjA4TFgvOE9GdTcvUi9iQnVDWGts?=
 =?utf-8?B?K1hPdlVYTC9KK0U1cFpaMXVqWHpEUk1ZYzh2VTZuenJPbWttdHJ6VmFIQkNE?=
 =?utf-8?B?Mm9CNGQ1VHE2MmhnRitmNEp5ZE5mR1FpS0Zld2pkVTllU2lUamU4WElHK3Ba?=
 =?utf-8?B?dkdWUmpHSkFLUEJhMGplejNqZDBJNjEva1V1R1lBSkUvQWpCUVloQXRkSy94?=
 =?utf-8?B?RUUvbmtIa1RuWWorN1JVT0pDNFpBTTdNNTU0Rlg5WEZ5ZS9DbExaZVVFenpo?=
 =?utf-8?B?SDhNeWlpMHJYS25TSHJxZ3p4ankrVzlHemplSDU1cXlvTytsOWhubkVkY1Y3?=
 =?utf-8?B?MWt5MGJoWm41d2p5NGE0VTFMWEh2SDFZR0QzaVZFMHRKNUltUC9obCtpQnAr?=
 =?utf-8?B?cUxoRDBlOFFXN0dNN3IxcTdxTDdJdHVjRmhjZjhocGdlYWpWZnNlODVYYi9S?=
 =?utf-8?B?SmtWbE1uWmxkUnI1MlZYMGttSGRDZGk1azFaSHlweDY3WmFCdEpqMlRWQUs0?=
 =?utf-8?B?VnRuQ0o5Z1lOVVhkTkMzYXgwUW5oMGtFRW5Pc1JoYk5HU091cTU2THVBWnhJ?=
 =?utf-8?B?bVNJemhKaDFCMUU3NmtIRmhGZzV3dkJVU0VjdU5abjJoRUxzMkxpeURvWVp4?=
 =?utf-8?B?VXMzUlY2c1RlYUVjNERhcldudUpzajVNZ1NiZkpHaldOVnVyRnFPMm1aeVlP?=
 =?utf-8?B?WW9UMG5MTnlsYU55UFUzdmdHRnNOQ0NRajJObm93WEl5OU1NaTd2UHAvbDU2?=
 =?utf-8?Q?77zezazxzzUQqk4khvNcwQh6Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9042f4b-206f-4c16-09be-08dcb85317af
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:10:20.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmjo/+8uzcrQ3HrSZa3I7ETmgo1H4ABqY7/RlJ6cfWD1Qe+8w7dYxxxOwx2K49R0Vigud+3wnAUGp5aA6Zw1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-OriginatorOrg: intel.com



On 8/8/2024 10:50 PM, Dan Williams wrote:
> Yanfei Xu wrote:
> [..]
>>> That way we can use the bitmap iterators (even though it'll be very short).
>>> Alternatively carry a info->range_offset through all this code
>>> and iterate from that not 0.  That only works because there are only 2
>>> range registers though so is non intuitive. I'd prefer the bitmap.
>>
>> Hi Jonathan,
>>
>> Yeah, bitmap can work. But how about only recording the non-zero ranges
>> into info->dvsec_range[]? I think it's no need to match the index of
>> DVSEC range with the info->dvsec_range[], as the "struct
>> cxl_endpoint_dvsec_info info" is temporary variable during probe. If we
>> only record the non-zero range(even allowed range), the meaning of
>> info->ranges and info->dvsec_range[] can match.
>>
>> The patch is like:
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a663e7566c48..afef524e8581 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>
>>                   size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>>                   if (!size) {
>> -                       info->dvsec_range[i] = (struct range) {
>> -                               .start = 0,
>> -                               .end = CXL_RESOURCE_NONE,
>> -                       };
>>                           continue;
>>                   }
>>
>> @@ -411,7 +407,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>
>>                   base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>>
>> -               info->dvsec_range[i] = (struct range) {
>> +               info->dvsec_range[ranges] = (struct range) {
>>                           .start = base,
>>                           .end = base + size - 1
>>                   };
> 
> Yes, this is the minimal fix, because the range indices do not matter.
> The code never considers the range index after this point.
> 
> I would go ahead and make that second hunk:
> 
> @@ -411,12 +406,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>   
>                  base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>   
> -               info->dvsec_range[i] = (struct range) {
> +               info->dvsec_range[ranges++] = (struct range) {
>                          .start = base,
>                          .end = base + size - 1
>                  };
> -
> -               ranges++;
>          }
>   
>          info->ranges = ranges;
> 

This is more concise, will do it in v2.

Thanks,
Yanfei
