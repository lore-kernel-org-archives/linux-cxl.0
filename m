Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF314BF90
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291880; cv=fail; b=abCv9/NJxjFUTL+ietWQ6L7ijpfIWD2l5AqCA2IqXR8L9KzfbBlcgxTz7D6+RP1FbvdMHmPiLjdbRXv8XZgIZkw9jyA9OMzETSXrTlsRiJHFTVAWmiCHsM9kku6r5TsP4QK4EforKV47u3RW1FXeAU3SamdAZynaSd1kCLC4/J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291880; c=relaxed/simple;
	bh=aT9+grSqAA8klFg6zDoMro3sPYXHQENuZoi3SOBHC2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neICpFLcueUHFRgMTGAse9A+/S9DC56dxeM3ht9AmM9a5lqA0+mR4TacSh8a6CZXPGPUSxFsI1qh1HAcQSibPk+tcklEQrikMoeTW6/qrZna0EylGpnQY8kiGS83rhM4Egz5m2B4rT5vhuwLL1mZNGTrn6sa0F0HjV/ITXmz6HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AV3B48jO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AV3B48jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723291879; x=1754827879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aT9+grSqAA8klFg6zDoMro3sPYXHQENuZoi3SOBHC2I=;
  b=AV3B48jOJDx1IsKjbbK/zAA/EuL0/2kxYCi5TipFVP9gE+4NGcto1tVK
   a6/0nFJrKzuh+B7zDXcXjZo0n9Bk4i5WqSnE3QrT27ua+A0ZvPy4sfTWR
   Ix3svhRf4jRccMZerx1bHCZnC66DZF9rANz3ckI/5IbjB/ztiD/HvXly6
   MZXb66emYR7WPNYihNyOn7QU5A5+4ERDLBvKZCigS+0cMc8jsONPndbRr
   lGznndTbZRaJISxUtTPEKY3+lZAubSqVNMCPHE8tuTNlZc1YYM0AmrC/D
   8SdEXcaxi3lw7wHke4QQN1XZo7DGMMjFiiJkVPYNKPB1kKpYH81Qp5xjf
   w==;
X-CSE-ConnectionGUID: Pdr+28vcSe+JwgJZto1Nxg==
X-CSE-MsgGUID: aOwfEONiRkKR+oFYhq5c3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32606581"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="32606581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 05:11:18 -0700
X-CSE-ConnectionGUID: zlcrnLQwTLaWX4Ik2uuZWg==
X-CSE-MsgGUID: qGsVJ2PZTCmix/vyrQXMig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57896789"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 05:11:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 05:11:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 05:11:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 05:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz1FxdASLgfzst9r9Zb/BC9AH2TrXdXcD5Nm3vYr1wy8giGmzm8AMvzYZpCtiKhZyVdC+ht3tYQU1OilzSo3bzJ57cFtG4Jwij2D0hLppY/pn+0G0K03d8Y3GKhvtmX448srJOn65Ft0wQAgMh3y/KaLTwyV4IHtuTaCQ89lDS/FJ2aUOwLBDL/EEZRdmlx0IKNwmNwTYSCXj/tKb2xsRdwnxaC+0BMjISUAfyOCydJIZjPWSmRosPxc1ZuxKfKhyzvN0A68b34+2oOJXQGskJvUJYO/k6enezOfzr3ONBSUzriaWICLuQp0D4j+l8V5URbiTgWUU0hws4vvIqYfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTeYKyuQsNNoEer8IBg+HAttJ4c3wS1xoKJzziHiRng=;
 b=Ab1N6obEJ3ivQ3PqLjZ51UDbx/jpgB0sGC1u69+FnZWoyx1GKu60T9E+4Xajw45juZNlxgVIxpOe0nXGEJtm4xziATmVzYw3hevUDprmbSAQtxPtbc5fLZbISHB0DnBIncEhCP9inHt3isX6WbaY4tFrBNPA8whXsKrGm7n2jVznWWkEoSk4JACNyrJ+/gvjmd1ku4Q4RhBS1ras+VMeSBkwhHYCjTkZATKD5IcQGhK0CZ3hcwiKT6kbHqftwKt7mooe/s93cj780mMDpRHuc9diNsTvb7upQNnSp55tTdMcRSNHNCpXEoYhH4cQHXk0G/jwVAeb4Te1j5Les2MX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 10 Aug
 2024 12:11:15 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Sat, 10 Aug 2024
 12:11:14 +0000
Message-ID: <6c941094-eae8-4347-966d-017d2fdcedd6@intel.com>
Date: Sat, 10 Aug 2024 20:11:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 4/4] cxl/pci: Simplify the code logic of cxl_hdm_decode_init
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming4.li@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-5-yanfei.xu@intel.com>
 <66b66adc74114_257529420@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <66b66adc74114_257529420@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 017c8906-2e69-4145-6b74-08dcb93587f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1pXWEd6bnBnOUV3QzdDRXEyYzhIa3A4dXdqUVU3U3diam5UeUNBcnltb01w?=
 =?utf-8?B?U1NYeklxVG5DV0V6d0hZeTRrMXRLQkIrZFpsVUtNa3lyTzAwSzl3WkhWRVpH?=
 =?utf-8?B?N3BuRW0waXJ5KzEvVHVXTnpLRmNhYXR3YzF2MHZUNTI3OXNmNHI2TnJHbW5H?=
 =?utf-8?B?R2Vld0I0VHFhQ01uOGUraEk3YmtSMzJ4QXhSMXRRT3g3c0xBVE0yVlA0WVMr?=
 =?utf-8?B?czJOdDdxb3V0V09BbEp5cUxVNTdSVUNLb24xT09sL1VreCtsODQvSE5UZVVQ?=
 =?utf-8?B?ckUydjJpRmNURGk0YkRPQ1ROS3FQaVRFcWM5QWp5TFpxaVF0dk1KUXErMXpO?=
 =?utf-8?B?T1d5TWY0aldUdFhVT3dkZlFvdGNvVGN2RnZlb2JxRzNRYXVXNk1STDc4eG8z?=
 =?utf-8?B?US8vby82T2FsL0FkZmFOWTQrTE9hb3BvbFZFNm05UFhjamN2WENjeVVTSkRL?=
 =?utf-8?B?OFJLTGxoa0JENWZZN1ZkMVpuWE44T05yc2hUTmtvY3hMaWY1MkFkM01BQUpZ?=
 =?utf-8?B?RHpEK1hOVSs0aHYwMEdRQ0FPTjEwRHVZY2ovNFZKNW9hdjR1eWVUalB6dTRx?=
 =?utf-8?B?NmpnZDJhdjFPNXBxY21aWlRNWSszNFNOOXF2ZllaNmdyYVJjUkVZMEdqek1R?=
 =?utf-8?B?aWFDVlB0cjFXSmdUZXUwU1BKS2JRQUJpdld4OWN4V0w0a3hGVDByc0IySkFO?=
 =?utf-8?B?ZzZhbURWbTY0QWJWaGtDNVI4VnFBMlBKMjhCREM0ZmxSS1FBNGlHNkNFaGpk?=
 =?utf-8?B?dlVWVi9pTmY1MWhYdnVmSEEwbGJnSE1BOGlrWlRBNVpqVDdUZTExeDEwem1r?=
 =?utf-8?B?ZUxBY0pWSy93NkRCdWlESlJKazRjaWIyUU9BZFhqcDJ1MDlDN29oQUQreGM4?=
 =?utf-8?B?aFpKYTZxcUFnUEhvVXU4QTJVOHFGUENsdEtSRlFCNVJVVCtnZis3eEFVbWk5?=
 =?utf-8?B?cmFKTmRXc0RqQnlIZE4zdjk4blJQL1M4b0dvQkhubGFmOXJjY1pHZVIydkJ4?=
 =?utf-8?B?YnRHTkExVk1LNnF6aGVXM2YyWEc0Q1dyYm1CTnU4d2QwblJ4V3NPR3YxS0FW?=
 =?utf-8?B?aUlvUlplbG1aOG1Xc3RURDJIZzFxL2NPKy9lY0d1R1NhQjNWQW5QZGZlWWxw?=
 =?utf-8?B?eFpOcmpydjc2bGJJY3Qxc0FlMlBuTE1Wd3RNSitESlJ0ODdkc2o3QU5Zcklj?=
 =?utf-8?B?a3JhWFgrdVlsZWZXbklGTEU2QXd4QjRrdE5URTdiMkw3cmtlNTllSDJobXVB?=
 =?utf-8?B?bjVoWHRjbWJMb3RXcFViVU93b1dRMytOcEkzWWFJN2JTc2dFYXNQQ2NQZW1x?=
 =?utf-8?B?SXJ1TVptSHlVN1V4azNBak1IOVc5dVovQ2hjMEJlS3p2Y2hPcmg3dS8vTnAv?=
 =?utf-8?B?SkhuZ0RnSWlNTDBhSEhMN015YTBXc25WU2lLTWo2OWNqeGE2Z21JdnlscVJO?=
 =?utf-8?B?QmdDbGRqMlJhWkxnUDdWeC92dForeVplN2ROWVlwWjZLYXViR0RQQUthU091?=
 =?utf-8?B?Tk9RNVhOb0FhNTI3K3lnWlpLUXg1TE5YNDdlWTdQN0xieGhkNjE4ZFBRVisv?=
 =?utf-8?B?V3FwL2lvVjBzbVRHL2ppRVVjVWs4M1M1UnptL0UxQ2hpYS9STHY1c1k2V3Rz?=
 =?utf-8?B?cXlQS0J0WE1GeWwzMGNCV0ZRU3pxbU80eUNxRTJQbE5tUUFuMjJmczY3Wk1D?=
 =?utf-8?B?R1g5b1J6bmlxWGlockhZV3lGczJWeEdKQ240bkwrbHZKUUlDME9kSWMxeDF1?=
 =?utf-8?B?akxoS0ZFZkNxamovYXg3eWZnWXlFT2pHalRHQktIZmlsaDFPWjFMZmMyYlJG?=
 =?utf-8?B?a0wyY2hBT0RZUnJSQ0NOZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnU0UEdvbTJDb1pHWkpweW9CdTJpYVpkbWY4Z2VVWGd5N284SUhvdGNzSDJP?=
 =?utf-8?B?VkZ1MHVEa2Frc0I3b3p1YTI3cHk1OHpKbmxwWUpuRFpKUEJOVllhRjIvMnc0?=
 =?utf-8?B?T1c1eG9EZ3pGWU01YndjMkwzcDJpY0d3WGVuQ2dKLzFUYThWT0tNNkJtNmRT?=
 =?utf-8?B?dGM3UHlVUkJhRGJvYk5RYmJLRnRtYTJWQmhYZTQ3cldLZnBKTEpSeHEwMzZm?=
 =?utf-8?B?UG85akZpblJHTUl1UUZXb2g5d24zYjBJQWVzZ1FXQzFOUmJrMzJFR3ZDSG92?=
 =?utf-8?B?T0pEUTBZaHp4c05mZFo5QWJHZkRvTVRFZkVFZjZZYnhMaG1UdEN5ckkzdFVG?=
 =?utf-8?B?M0I3TDYxeXhndnk0Lzd2K0dHWmZmMCtDbzkyKzNyZTB1Mm1XSjByWXo2SkJp?=
 =?utf-8?B?ZzM5NDB6MGZxRXVGK3RZcUdld3hNM0QwRjZiOXN4WnBXSUtwSGRWZCtMUjFm?=
 =?utf-8?B?V1pxSDBFbVpzdk5oMXBYNU52bkZtUyt4VDUzVmJUOVNVSWx3MVRxamxTS0k3?=
 =?utf-8?B?andPaUlBSXNTWncyUjNmcEZ5UHErNWh5ZzBkbG81dHFmQUVPaVZPZzJ4VjY5?=
 =?utf-8?B?L1Q5SFppdWFCcUZOTVlsSEgrZjEvL3FmdjQ3b3pyOFF6cVNtUDB5bUNDNXI4?=
 =?utf-8?B?SUloU1QvQk5MTXFDOUdTZkZsaVIyMEkwRWZUZ2xtK1ZKaXJ3ZEpqMTBITlV3?=
 =?utf-8?B?UWx6eWZUbkd4YnIyWitncURWTDh2UFNkd2ZUcEQ1WTV5Q1lWUHdnWEtPYU1l?=
 =?utf-8?B?UnI1NUJZWDQ3VUFxV1N6RGFMeFZoZldtdVp1UGJKQWo4VGpGMHZpNTRLWFlB?=
 =?utf-8?B?MUVGZG8rby9Ma3hUaEpnZTdWL1JibVJqZzgyK2JRVWpPWlEyNCtveWlUU2J4?=
 =?utf-8?B?VGZVcEVxdUEvNUpXTVpLTjhvZy9jR1doSVByRWN6Si93eldDeVVRTFI0VG0v?=
 =?utf-8?B?aXNoeFRWNzg1dDZ2TDJrdWVhdmlLRUl4MEhBeXJrY3J6cFZiOVk2R3Y5K2h5?=
 =?utf-8?B?N2VsUWtQcy9hQWNINlo2cjlPZE5nYkZDcmtUVUZkUmdQcU1KamF5UW1rSCsv?=
 =?utf-8?B?QmRmczhZMGR2MDdBV3g2REpFZGtrRXkxTkpkOW1YK2N5SFhIYkVyNlN4MmJ5?=
 =?utf-8?B?UkZFcEVuUnl5MS9DMGlhc2hzVUJwNG5lOXd1anZCd0sraVg5aENUKytsdktU?=
 =?utf-8?B?dkdZc1plUXY4bEx6SnJmams2MUo2eUlUblFHc21BMWUzNmd3SkpYcUlMa2ZK?=
 =?utf-8?B?TGZoKzM3MlRVdGw4YVJRVUVmTnNPWFBEdE9iaGR2cDdBN204SFhianZIU1lq?=
 =?utf-8?B?aExWejNqVXBJUUJLMHA5R0dqclptKy9rbGZqVWhKZmhCdVVJTWoycm9lVFk2?=
 =?utf-8?B?TllNczY3K2FpNlUwcVJoRkRqUDJmRXpucmRvVXlTWllwZURpeTk0cElxM2I2?=
 =?utf-8?B?all0MXhFTmFMSnI0VEQ4NlRBSlFyZnpWQWtSanRvbEFtNzlYNzVMSTFUR0NJ?=
 =?utf-8?B?cmNYdWxCdUpHVlViWEZMMHNKZTFienRXWVZMRTdYM1hTd3JqY2ZDcmFCNzVJ?=
 =?utf-8?B?Y0t1NVN2SWJLK2ZFOFhLeVkvaHhNaTEyQzI5ZXFVcEN3U3BSWlQvMXFFazdN?=
 =?utf-8?B?d2dZL2x3N1lGdmplekM0dnVGR3UzQ256MDlSYjU3citCMnlIOGlvZVJoVWhB?=
 =?utf-8?B?dmJmNUR0ZmFSeVNVLzZMNE1OSjRPN0R4NC9QVlQ0VStqR2dJWktDU3U1TFIx?=
 =?utf-8?B?QjNQT21Ueml0TXZ3SVhPaEJEQTlidzQ4YUtjT2cwMVZub09KMERCR2w3NXBl?=
 =?utf-8?B?ZkJXLzRYZFIzV3Iya1dQWFBFVEkyK1NsSEZlYWlCNjFkdTVLR0Zsa1B2RWp1?=
 =?utf-8?B?cFNvTHFoM3FLRDJ1VElObFd3L3Y5VkxmNElHcmU3ZW1vd0hVNjIvUFhuTitS?=
 =?utf-8?B?RXByWEpZUmlWRnE5anAxYWNMQlkyZitqQWxFYjNWZXJnNkc3azYvY0t1S2kw?=
 =?utf-8?B?MDJrSU5GT3NDKzV6cGNBREF4c096K09kVm5BcG1vTy95VDlINXp1MEU5NDhM?=
 =?utf-8?B?QkswUm1QSk9WelUvbGF0OEx2RStKMkVNUFBUYTBvZFA2VUlIMzNkcjd3Zitj?=
 =?utf-8?Q?RhDfqCzyC5RemCLFij8afSykG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 017c8906-2e69-4145-6b74-08dcb93587f2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 12:11:14.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyhP6Ho1SATmUcrPrt3dXXb4CSZfvcP6mNiD4UO7eTXn11ehR3wthbbR4IM502JVv/7JmzwFRg+HMpPiOK4TBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com



On 8/10/2024 3:15 AM, Dan Williams wrote:
> Yanfei Xu wrote:
>> When HDM decoders exist but is not enabled, the cases can be divided into
>> two categories: DVSEC range enabled and not enabled. Extract the check of
>> mem_enabled out to improve code readability. No functional change.
> 
> I am not convinced that this is clear win, and that there is no
> functional change.

Yeah, no functional change.

Before the patch2 which moves the check of dvsec_range_allowed() 
earlier, the previous codes in cxl_hdm_decode_init() is like below:
             ....
         for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; 
i++) {
             ....
         }

         if (!allowed && info->mem_enabled) {
             ....
         }

             ....
         if (info->mem_enabled)
                 return 0;

It checks "info->mem_enabled" consecutively three times, so if 
extracting the check and replace it with one check of 
"!info->mem_enabled" can improve code readability I was thinking.
However with applying of patch2, maybe this patch is not much necessary, 
we can drop it. :)

Thanks,
Yanfei
