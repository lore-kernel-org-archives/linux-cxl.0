Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129F1804F
	for <linux-cxl@vger.kernel.org>; Thu, 22 Aug 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292477; cv=fail; b=geaaHtVpQIMZtHpGZ1WpM9tH76zeIV/dMADHW5BTKUf503NlELblkEGOg9QqDtO1ks04FQQc81RBPjbrrF9A/IzuLXw/Bkl5pz+JK5aI+52Eds3Jb11i1VQn08xJTSdrPaKW24BmTPQIbKZjCg4PXOtCBmSNst8MlsiNtm5OTUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292477; c=relaxed/simple;
	bh=xBHzmB893XOBh8ZVbsStoqrSL7G8Dxsn0Ngx/Kr6roI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBaCmTN82HBbrjzq0ppN4/dqR87W4sXSEhiWrjMO9TOHsFTKjBhe4JLHGj2yjAjWCtlZ+2ZbG1Z78iZFZzwdXBm1RX64Ip232x07I6HN5Sbe8qiyn3aSV8HvGsve0mNfEFNpHL1SKwEuC1QL6pxnRawpw0LxqGSWwQ9Qqugnpts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPabIuhH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPabIuhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724292476; x=1755828476;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xBHzmB893XOBh8ZVbsStoqrSL7G8Dxsn0Ngx/Kr6roI=;
  b=DPabIuhHhrUhppFtYxfF/stu0YWEQW0KWpPpht8BVhMQ4ZmCHeo/gapj
   QomOSJN475uEO3ebxZnlpBeo5aQ25JMwXlTvxAcOsvVUt3IKCJ+ICynRa
   p6U9dLUgTmQj9wA95N4qnKDXzR819IxTo01zdyiDHEHDW3u/9oCvxGsZV
   r6+CB/q1ChJKkvQK2h2vHFdIoqt8oGLA/yMgLV41J1HMRip3hnpRNk7sS
   vDlIk4Elly4tWQPQvpUoIiKu4LJWJyUo9ZhlVwSFDUNuRNN62A9Uq1xJZ
   uc17zQ8G3ITHIuRs+LY7vfUx7QkkNXgdETwrFSFyb0TQ7JQZMdIlndQ1C
   w==;
X-CSE-ConnectionGUID: +SUMJaUjQ6CnHLVOtueF0g==
X-CSE-MsgGUID: yPx99IJbT1+B1kb83/+8IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22555091"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22555091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 19:07:55 -0700
X-CSE-ConnectionGUID: WndmNr91Rjq3Y7zlH6yZgQ==
X-CSE-MsgGUID: CrFWg9tRTm6pN0Xk5zfRnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="92083750"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 19:07:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 19:07:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 19:07:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 19:07:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 19:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/QHAAUZSftwvqh/xsebKFtFHyit3DmYSSYou3Yz8+tV7tQx6l/rAtw4NPH2XlPanK1PJ+vGPVcRLKj/XIws+l/nRvg9UEaQ3w84F8+QGar5sEoV/rkuaZWBQXuVmfR+LcrcIrScfPQsL0smiU/2xOVUk2+sHce3eRhplNRYvrqtRolbPSUzTZNgwE/Qn+zY92QGJPK4uV7RAaFh0xSzOoN2Avdr8R8BFz044Cv9AfGdG1UPGh/uXG3pjSRdYIj00/zZweMJUGJj/yNsyBfUeyaXMY93+KA3dkqHLTBOI4irA+WHhbHhWxbh1cEM191OlHcBpGXdpLISaIBIT+Mv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=769p7I4etfpPHEWEgPHQ9kQ1ouNAhNM6GIB9bq+pZIw=;
 b=qCqjTaPkiN0hT5y7REFl3kUvvTZL149D+unll+Br/EuL/I1qL20WcvPrhWIxBtqZtrVL+8f4aZV/T4WIivd1S8uuKUe4jPp5KBD1XBbLIO1zBSPrnvebAyc5aisc7c+2uvQnW8l4H6bvyyFEEETLWO84SGVawXMAiTNgkd8t5FCkwK02W1952ZZgdaGTiO0lbF9Fgf5ssbmRJO4LY4Qj8P8uDi2DaAvgtyU09y0yAaRpN/K70nnwn9SLjIcz5n1idExiZzlrIvLND3Q3ndDGKKIbsHIxKjjp1E43pHkikezeexE8LcsqE2K13RWlkVninDoFICvbLAJ0Y8hpBzVk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 02:07:48 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:07:45 +0000
Message-ID: <7110897b-d8ef-4918-ab58-705d76bf24f4@intel.com>
Date: Thu, 22 Aug 2024 10:07:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop goto
 pattern
To: Ira Weiny <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20240813070552.3353530-1-ming4.li@intel.com>
 <20240813070552.3353530-3-ming4.li@intel.com>
 <66c6639d14237_1719d29489@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <66c6639d14237_1719d29489@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ff609d-c596-4d18-c29b-08dcc24f36b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjVUc29oK0ExQWFEY1BlYmVBRVZOQzZCcjd3VUxWdHhXZ0pVOStINlVHVE9B?=
 =?utf-8?B?aGFndFdOMjM5V1h3ellZTlZkQU9YSkl0Zi9VTis1S2loa2tnTzlqempNOWQ1?=
 =?utf-8?B?aStydlpCcFBteDdzNDZIL0R2NmxzUTQ1SSsvM21NSmxaOXd6RHFaT25mek5s?=
 =?utf-8?B?aW5nTW8zblkybis2blBSSTVWaWNQSktFUlFzT1psTVVIenVSeW1yaERLNW5w?=
 =?utf-8?B?bjhsbmZqbExLMFliNDVaVnVBeStTalR4Y0JVbUdaT0wwak04ZFdMU2xxZHJr?=
 =?utf-8?B?UU1FWjhmWndKakQxcXRxTGd4ak1pWnpuOFM1d1RqamlOWnNwUzlIL1pjTDhF?=
 =?utf-8?B?ZldheXpWOUJtWWpoeXJ4bWhQSnFtUXdDcTg0Q3V5SG9kSGhqMTh0ckY1TlRW?=
 =?utf-8?B?eUlJZTV4SUt5ajY4dFdFUVRXWVJnYm9rU3hCT01uSVloN3VrMWovWGFpYjJS?=
 =?utf-8?B?dm92WGJSd0N1OFROdXBZN2ZLZ2FOTEpNTFozTlZlTmZSYjJwR05Vekk3dUxX?=
 =?utf-8?B?T1B6QVNqZDlpd0hmdFJaaDNhTzYzTTI0enpVc0dhZnl0VGc4VVFEdUxqWDlM?=
 =?utf-8?B?YjlBRWJYdDBneVVZL3ZOeWx3a3lYUzMxNHhzWFZ4OHlQRTBXTHdQc2xUTCtJ?=
 =?utf-8?B?czE0OVNJKzFjN1k4K0JWdXU4SUE0ZTM5SmdKQjVHb0QvR1VoRW8xUTQzQkll?=
 =?utf-8?B?MG13c2FRaHA5ZlorRUMvbVgyT0Y5dDNXaHR3Mm1nSEcyNmhQTVpremN3TEhO?=
 =?utf-8?B?V3U3c1lkVm9xc0F1TExRNjRFNlpHSmRqYW9LeGRSR2JSSk5lbDRVWE1wdTF3?=
 =?utf-8?B?Q2hoSytabHFHQXJaZEQ3Nkc1d2ZlbE52SDA0YVdlMjhocXBwVGpGQ3pGTmZU?=
 =?utf-8?B?c0NSMUM5dk80b2RISkRXdnNiMmhxOVpOcFRPYzQwcng2QjNtU1k4MUtDK1Zm?=
 =?utf-8?B?d2p5OFdPdjRBTGpKWDFwN1RSUVNVd3Y5SHk1TXdOaGZqZ0tpRzZhUTIyQi9a?=
 =?utf-8?B?eVVibnEyTThnTXJGeFJjSGdwVW1Zb0U4QmRkK3U0cjQ5ZUdBa2g4NkNPd3ZY?=
 =?utf-8?B?YWxuQWN3Wm4zYkpveno5QlBnSUpyV2ZZc1BzK3J0VkJxaStpMWgrU2Z5Z1Yx?=
 =?utf-8?B?WlpQWTM2SGhOSFMxcmhRQlVhbEdCNkVWc1Rmc1FvbXZnYVp4WHBIeGcwWjdB?=
 =?utf-8?B?Q0p5YjV0RG9lTlhwYWRTSnd0dVkyclAyVFFOUmNYRzBuTklaR0ozV01Ld2Nr?=
 =?utf-8?B?YXp5ZjR6emJrdTdQSUM0cndCa0RQV2pnUWVKUjc4OXVHUU9BQzUxd1VJQ0hW?=
 =?utf-8?B?Q3pzcTFMU1JPOGE0TDF1WjdxU3lMcDlHOENWUW9ZNjRzU2ZKd2VSVnIwbjdC?=
 =?utf-8?B?WUlPbWtJSm8vWngxTFFZOEVmeXFFU2lrcUJjcmIzb1ZGUjc1QjdMdzBMQ3p5?=
 =?utf-8?B?Z3ZDUkg5UmowRitGZTQzaThKSGJQKzE5NnhuenFGczhxckJ2N3A4Z0dXQnRB?=
 =?utf-8?B?Wkk4VWl6UkxJQkNwTEZ4Q2ZZUm9DVWV3eTdlZ0d1aDhvTGZBbGNXWmdaU1do?=
 =?utf-8?B?bGlTZHpEZjBiZXhvYzZMVExEbm92eWRoOWg5cHlYc0NXNGNOZDN1Tk8zcFNn?=
 =?utf-8?B?NnRocG11SzQ2cndKMjF0emJqbUZjaVZnZ3l2M2FjSldCS0dpUStzcVRwcGJk?=
 =?utf-8?B?dXhHaGJLWUtlajdtZW1OTEtpdHRHb2doaGVYeXJWZzNDMHZvNFpsUEVuSjhz?=
 =?utf-8?B?QzRhMDg0M1JIMEk5elpZMFY4dk9UVGRudTJzbmxHTHg4a1M1TlVINEcwWUVv?=
 =?utf-8?B?SkxiYk1zOEFTOGNkYTNUdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdmc0JsQlE2MWttckZCMmlzaGQwTHUzZFRONFJObStsNnpGR0xLREZkMU41?=
 =?utf-8?B?enR6V2o3OEVhT0NDM0FRWUtkZG5tTDdWelpFbXBMdTNEM1B5enQ5WjRaZjFB?=
 =?utf-8?B?dEFESlpLc0t4L0hiSE43OTBXR2xJK21ycTRVeDN3eXN4d081Rnhoa3Qvc0k1?=
 =?utf-8?B?RXpPaUFlOHJ6NlMxank5YkQ3eXQwUks0ZnNMeDZnRFFkN0VXVlkwcCtGL1A1?=
 =?utf-8?B?RGFzMHp0L00zSDdTaFM5dTRPcmRsb2tLeXBLWktTRkdFbE1BM1cycVJhY28y?=
 =?utf-8?B?S09oeDhmSDZpd0VQRTl5R1piWkE5enVnUU5ObnpNSi9WWVA5bXR0VGNLMXdl?=
 =?utf-8?B?eDhIaHVNdjhueGFRRmhEQkNuU1FIU3paSUpkOVdEeHN6N0NnVFF2ejIxR2hU?=
 =?utf-8?B?M29NZ0F4Y3lOQUZ2ZHNZbmVaNFEwa3VpQmVhRUlEZ1RHOHZZVzNoNTNBVkNt?=
 =?utf-8?B?bmN6Q2x2NFhidUxFZFE3c1kxV0RmbkNmRk1abkJiYWhEUmIvZGRUWDlraWVE?=
 =?utf-8?B?ZFdSTmEySFp6VitleHNiSy9lUTE0OVp0NE95Z1BwaUw4WGwvM2JOSm9QZGsw?=
 =?utf-8?B?ZW43bDFxR2Fqd0YxVFlDQ3g0RzZvTzhrZnFhUlV2Wjl3N1p4cE5UNDR4dTJH?=
 =?utf-8?B?YVpaTVQveU9WWG5QMDRmK3FjSHdxY2MrWHN2T0kvTFI5NEZsR20rdkIxQjVn?=
 =?utf-8?B?MVgzMmIxS2NjZDdndmd2UE9SR1BKTHAzUjdwZkZiUzYxT2lIbGxENzZYUWRQ?=
 =?utf-8?B?YW5zVm1qM0R6dXpCMWcyK2loZzIwczRhWGoxdndTOXR4OWVqcm9IS3VtMjZx?=
 =?utf-8?B?TmxpOStiNFF3SW1IY2poOU1TZm44N2o0dnRzakE1U0pma0dvYUxTWXFJR2Ix?=
 =?utf-8?B?anRrTjBEcVd6Z09hWjE4aW0zYkk0R2dJZElpUy9QY2Q5RTMxekk5eFlPQXAw?=
 =?utf-8?B?SktqbjRQaDRSOU4xcFJLQ1dzTnNWQy9HcW51WFUyamZRNDRaeUJDOWI2czlm?=
 =?utf-8?B?bFVzbU8xbHFVdm54d2ZxclczUFFrc042VG9McnE4cU9yTlNhSkpnU1pXRTF2?=
 =?utf-8?B?MG5RbmczZlFGM0RSb2tmZ1FUakVJNUIrczZ5NVhRbFByVm9pQS9kdWFYbEdK?=
 =?utf-8?B?bEZVSWxUTnBhUUphQnQ3Z3hWMGNFODErU0g0SWZ1c3dXZWptdFlqWHI2L042?=
 =?utf-8?B?ZTFIUE9GM0JoZW1BbkROYnY0MlFMZFZZZW1TUGYyK1MyUjJ5TDgrYU54RkxX?=
 =?utf-8?B?UFYxMXpMY2VVU21ZN2I3eW41UzBTaTBTVlhKcHhyWjU1TzV6bnloSW5kU2Mr?=
 =?utf-8?B?WjBCTk95NHVoSXg5cEtSSEU2a0JJbzBNTEdYR1FHVkZueUNWNXlHZUJFWm9Q?=
 =?utf-8?B?aVdBb0MrZWhER3drckltbmpsSVV1TDk2WVJ2YURMNXpkVEZaN0xneEZLV0FV?=
 =?utf-8?B?QXZUaXpjdS9SYmxheXp5WjRjYm5zRDN5Qmx1endsQXBhVGxFTFV4U2ViVE9n?=
 =?utf-8?B?dXl4M2xLbTd6emV6RGhjd01majY3b2JBbzJrNTVCeXB5TEVWa3VFcWpUenpX?=
 =?utf-8?B?N3c3blNYNFpKL3NmV2RlY2JyekFuYXc2ZEZTWDVPbGZpZytkVkxvS21VOU1C?=
 =?utf-8?B?dWduNEI3KzlyaTAzdFBnNVp2ejVxZzJEUXZvWUtTd3NnTmhOdGd1a0xaYjNM?=
 =?utf-8?B?aUxLUkxLam5zQkhBbjQxUy94Zld4YjFFVjNZTm51eEJxQzRMUkFpWXpram9N?=
 =?utf-8?B?bUxKS3Z3c1YzUURNS1IvbWJJMEpFYnJXK1Q2SDVuT0xQMDlPc3c0MFkrTTFO?=
 =?utf-8?B?VGZmSWFsNW5Hd2Z2alBkMkc5dmRDZk1VbzRsb21tQjBjSG5XTnphWmV5anls?=
 =?utf-8?B?Vm1WcDcvWUtsVHo5WWxvYUdjbHVXREJEWjhEUktLQWRHUjJQTmp1YUZpUDVL?=
 =?utf-8?B?a2JSeXljWGxteUFLMUFxQS9sRlNNdXR2M3NKNVN1RGtZTW5NNWZ5dE9HNmN5?=
 =?utf-8?B?bmIrZFNQeVZyRmFrUXg3eGM0eGVqcFhnSHdRbG9objV6aWlBRzAxODlOM3cr?=
 =?utf-8?B?SDlVdDRHNXlQd3FIeFc2eC96bmIxME9OcjUxcDBXdXR2dHFvRlFpc0wzVWdW?=
 =?utf-8?Q?crWucB/vG+jGjzyD9tew1aCAd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ff609d-c596-4d18-c29b-08dcc24f36b7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:07:45.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjUS2uHfT+xPykwaDP8QccR93syf7RkhOtYinQO/yu1cfBu7B1izDA1bBz7LH/3qLxe8RTa7PYWNWogliA/5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com

On 8/22/2024 6:01 AM, Ira Weiny wrote:
> Li Ming wrote:
>> The "goto error" pattern is not recommended, it can be removed via
>> refactoring. In __devm_cxl_add_port(), there is a 'goto' to call
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
>> ---
>>  drivers/cxl/core/port.c | 59 ++++++++++++++++++++++++-----------------
>>  1 file changed, 35 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 53e2593daa95..a886b16b2610 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -828,27 +828,20 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>  			    &cxl_einj_inject_fops);
>>  }
>>  
>> -static struct cxl_port *__devm_cxl_add_port(struct device *host,
>> -					    struct device *uport_dev,
>> -					    resource_size_t component_reg_phys,
>> -					    struct cxl_dport *parent_dport)
>> +static int cxl_port_add(struct cxl_port *port,
>> +			resource_size_t component_reg_phys,
>> +			struct cxl_dport *parent_dport)
>>  {
>> -	struct cxl_port *port;
>> -	struct device *dev;
>> +	struct device *dev __free(put_device) = &port->dev;
>>  	int rc;
>>  
>> -	port = cxl_port_alloc(uport_dev, parent_dport);
>> -	if (IS_ERR(port))
>> -		return port;
>> -
>> -	dev = &port->dev;
>> -	if (is_cxl_memdev(uport_dev)) {
>> -		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
>> +	if (is_cxl_memdev(port->uport_dev)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  
>>  		rc = dev_set_name(dev, "endpoint%d", port->id);
>>  		if (rc)
>> -			goto err;
>> +			return rc;
>>  
>>  		/*
>>  		 * The endpoint driver already enumerated the component and RAS
>> @@ -861,19 +854,41 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>  	} else if (parent_dport) {
>>  		rc = dev_set_name(dev, "port%d", port->id);
>>  		if (rc)
>> -			goto err;
>> +			return rc;
>>  
>>  		rc = cxl_port_setup_regs(port, component_reg_phys);
>>  		if (rc)
>> -			goto err;
>> -	} else
>> +			return rc;
>> +	} else {
>>  		rc = dev_set_name(dev, "root%d", port->id);
>> -	if (rc)
>> -		goto err;
>> +		if (rc)
>> +			return rc;
>> +	}
>>  
>>  	rc = device_add(dev);
>>  	if (rc)
>> -		goto err;
>> +		return rc;
>> +
>> +	/* Inhibit the cleanup function invoked */
>> +	dev = NULL;
> I'm tempted to say we should use no_free_ptr() here.  But I don't think
> there is any magic we need in there.

Yes, I also think using no_free_ptr() is better. but I have to add a extra local variable to store the return value of no_free_ptr(), otherwise there should be a compilation warning.

@@ -870,7 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
                return rc;

        /* Inhibit the cleanup function invoked */
-       dev = NULL;
+       no_free_ptr(dev);
        return 0;
 }

compilation warning:

drivers/cxl/core/port.c: In function ‘cxl_port_add’:
./include/linux/cleanup.h:76:22: warning: ignoring return value of ‘__must_check_fn’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   76 |         ((typeof(p)) __must_check_fn(__get_and_null_ptr(p)))
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/cxl/core/port.c:873:9: note: in expansion of macro ‘no_free_ptr’
  873 |         no_free_ptr(dev);
      |         ^~~~~~~~~~~
  LD [M]  drivers/cxl/core/cxl_core.o
  MODPOST Module.symvers


> So.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
>> +	return 0;
>> +}
>> +
>> +static struct cxl_port *__devm_cxl_add_port(struct device *host,
>> +					    struct device *uport_dev,
>> +					    resource_size_t component_reg_phys,
>> +					    struct cxl_dport *parent_dport)
>> +{
>> +	struct cxl_port *port;
>> +	int rc;
>> +
>> +	port = cxl_port_alloc(uport_dev, parent_dport);
>> +	if (IS_ERR(port))
>> +		return port;
>> +
>> +	rc = cxl_port_add(port, component_reg_phys, parent_dport);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>>  
>>  	rc = devm_add_action_or_reset(host, unregister_port, port);
>>  	if (rc)
>> @@ -891,10 +906,6 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>  		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
>>  
>>  	return port;
>> -
>> -err:
>> -	put_device(dev);
>> -	return ERR_PTR(rc);
>>  }
>>  
>>  /**
>> -- 
>> 2.40.1
>>

