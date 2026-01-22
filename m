Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8AF39DB11
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118876; cv=fail; b=EUr7jWRVQenHd7dIHSQpAPKi02O+7Kc7pdyByiFYUmoTEaxOLZ6vPzFLLVoYHw7Kfwj9hy8gl0VfrJGb0t3orNcGaaBvnk15gi44DaOlJ2KdV8xI8/y0gBoBXAFM/fl1XteKD8VJtd2+0johrzu8A0B7E6GAbCcf1b2P91ZoFRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118876; c=relaxed/simple;
	bh=oshMEceONQ5hf3l2SjX1l+CykvEscMlPAh2m+v7BXgo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=E32c+dhogEWa+oykmzclge2C+B8M2eSZLSebr2ggb4H2hYcAQ8bhSmFWQoqWoNz6wQmFjRWLCiElwkk7/rT2xYraetOrKylUfb9cV5ZKfBbgwNNx140rpn26XWZ+AFECyUa83niFdE5aWBGA274jgJyQn9VbyJBFisY+yL5tXwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAoUVduT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAoUVduT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769118846; x=1800654846;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=oshMEceONQ5hf3l2SjX1l+CykvEscMlPAh2m+v7BXgo=;
  b=RAoUVduTW9jLLI1Dqo0yOGMR/iCRCSYtQSxJTbq4ZVnt3d0vsgHYDaAN
   a2xmv+1bTF6DBjG92sS9ZqzfDtNBAIztAkld2KFlmfo8/68Dqvwdef6P5
   5GS7q86ijN5UqC2Wfra6PyB7JLinDnEe+pxjkNy2GXeyjQ7FlBgI3w5r6
   stNB0P7Z252u0lJycPCh66gSzgjK3gm6QBBQhSyoDDb4SVLkvrZGBPGrq
   tE1TdilgBIdiFvHS4xw2yYe10v5bfI2j6JLbnntIa4EkdPMmRV4F0OGL4
   ruQyWr6a2cdyPfnRDSnn+PIaIPQUEXGfOPObSBWUrUQugsNo18u7nuX+5
   g==;
X-CSE-ConnectionGUID: qVG1tk+aSu6Sjv7CtJ47EQ==
X-CSE-MsgGUID: 2f5nCHdHSO6X/yU/D55VJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70420481"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70420481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:54:02 -0800
X-CSE-ConnectionGUID: sjqaVlERRF+UUSfm9gcDyQ==
X-CSE-MsgGUID: 0/nTD8w+Rdq49jKFjxhhFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="244456615"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:54:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:54:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 13:54:00 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJaKau9ZyobXEPTuQ68rOpcR9h/AMUFdmieqWDNfj3n/9v0hlb2WpHabTDoS0o/59oNwrlhZ5WVyIFtaym7FMtR0zqbP/RnZ49v2wgfji/nM6zrdp0UUzNzEORCIMQCk+Y8hNvY7EQIYH505wzF4dPyS7Xj43U3GnpURQygo6Z4xCLrWD9Fm2fruKIs201YRSa6LoITHm0G8zsGBVyCWkFvdELt2tMKTcuFTHZapRJ/4wt2CgTDk+SgsyD+VaNYNfSYJ52GR2qkTv+uGvJJDHN+BMPTazFBTVpCaiWqTdO3MvD6VquJTIHfDdgco9t8uKPwqww2LSGeQF2nnhTbn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoSu6QIFPTQu01Y79pwyH0Y9TVQep3qT/sNV+qG28WE=;
 b=Athj+YfQJDBxq1TyEnfmDrVoxge5daFjBGz3qvXCmv6Kn+s0f3feho+VuBF0l+11qVuLO9REvasqv/PPllzNlAyKy2d7Hdb7FLlL3EVE/2jUFZC8uetG6nt9gDymb2z6GI9Jh48aH6vSCqg+W3hAIzsKu5FpAeLp8yktzy2M2xzOtbX53M2GYOYZPrdyFzqHCPOX67KNfVLsvzfjfGasauDhsQLke8TjNRxAs1DR3Jkcv/S1Zo4dfUT31LcE2uK7ouqorRhyk/6ev4IcPJ9ztAXXxj77yxrFufF+wwxBAT7rPDZYTi2Vqw+9gKs+8RxHLYIdj5+s6HmEl8B0KlONnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 21:53:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 21:53:53 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 13:53:51 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <69729c6fc25e7_3095100ea@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122144425.000014ca@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-6-dan.j.williams@intel.com>
 <20260122144425.000014ca@huawei.com>
Subject: Re: [PATCH 5/9] cxl/port: Move dport probe operations to a driver
 event
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 464f87cd-1cb1-4943-6b82-08de5a00bc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk9iQnVJc1pBaUlva0Era3ZFeDlHMDNWdHRTbGZOWVg5TUZmSUpyOUdDRnNX?=
 =?utf-8?B?bDVVZ0lVVHpWY1NpRDNta3JVNFpLbVoxQnBQWldTRDVOdkFjSFpUUHZKYWZQ?=
 =?utf-8?B?b0t0ckg0aUxmemI1cVpLQTlEZFNaSVBLbU1ZM2NBeCtxVDJqODdSSjVlcFIr?=
 =?utf-8?B?TXExbzJGM0tJc3JJVGpneFF4dVhLem1DOWNqbWhoRitIb2JGL0RNaGlwQzF2?=
 =?utf-8?B?eU44YktNVnNqczVaOWllNUNGQ1pxN0hNY0J3M2tsVmhmbEdINGhJREI3Nkg1?=
 =?utf-8?B?VFh3d3FkcTRheUJueStyNEtXN1ZsME50NjhTUWJHTzlMY3QxL3p5YkMrLyty?=
 =?utf-8?B?YVpRSFQ4c2prbnRzMElZZEpQR3Jwazhnc2wxelFta0NWdkRmVWhZWDdLMW5Q?=
 =?utf-8?B?R0Z6amkraG53UUtUVm1GNnIvV3NnRlF2aGdrTU0reWFHTmZGVDFMQWFLYnl5?=
 =?utf-8?B?OGt6OC8vbDVUVzQwbTc3QVg3U3BOYlNkUzQzWUpYRVNxR1pLTWJjRTVRM0FM?=
 =?utf-8?B?SUdGVVhNUkt6OE9EY3VKVDJPM3NEWTBCVGpWVjFYYUY2TlFNNjloSWhGOXQz?=
 =?utf-8?B?MnhoY3lIeGJGaDRyajhZeW4xdkVlUnJuajlRSWZ5VUx6ZFNldEd3THRRaWpM?=
 =?utf-8?B?N29qNW5zTk4wc29jVTNIVERQSWpPL0ZUeisvMWFHaE1WZVNJazllRUJCL0d1?=
 =?utf-8?B?V0NhWWlWR1A1QVFDOGhiMGlKb01DTGluaGZTZ0Vqck9vajVTdjMwcmxmR2xV?=
 =?utf-8?B?OEVRbUQxWEhvdUtZV3YrUjhaZHN1aVRvNVRKeS9YTWlWUHRYSUkzYllZQzZZ?=
 =?utf-8?B?NDh4WG5GZmhOZzhxR0l5ZXNUQkQ0aHMrVnUrQng0SFpzMDF5aDdLbGlVM3Yw?=
 =?utf-8?B?bnF6cElTaG92Mms5T1IyZGRSTUVsWVBicGpQZHQzbDJyaU1wWWRxaVQ3VU5n?=
 =?utf-8?B?YVpDNzQrVm5sNmdUM1UrQ0tmcDVpSHI3SzRNQXNBTE9GRXpOdS9uWXJRWW1V?=
 =?utf-8?B?VmVDYnloSndQZWFIUktBa0J2S0RBTWpCa1VCN21lSU90SDF1REYxdExEdmF2?=
 =?utf-8?B?MlpNZzF1b3dSc3cxdDJYRnY2TzFjQURZbkd0aGZ4Q2JmRjNFU2RLcW1nWlgr?=
 =?utf-8?B?YWZ4UkRQQ0lrdCttcTN0a1Y0VEU4YThtMjdkQ0hTektlR3E2Z05kVGdEaFIw?=
 =?utf-8?B?Q1NJTmdIb2xpTlJqendrWGYxbTZkYjNtNkQyRjFoaDkwU2NjSmZTeHBqT0Zk?=
 =?utf-8?B?dHFDc1lMUzEyY1JlM0JEd1paYzNJTjBKWSt5Rkh5UUNUakM0aUY3K3R2WXpk?=
 =?utf-8?B?YUkzV1haS1RHbFQ2cEt3Y3JLd1VHTUppVFZyYjBTTHd3S2V4WnY4d2trK21C?=
 =?utf-8?B?UUp0R0ZybXlUOE1UcnphRExYYnBvb2c0NnlVQzNJZGF3VC90aEdxNXdEaEZX?=
 =?utf-8?B?bEp5MkpmU0sydW1aZUtiRWpvRDdWQUQ5MTZhKzl0c1dJbEZZLy9vSTBkQVE4?=
 =?utf-8?B?K2NuWTY5SXBMOVRMRms4OFRyOWIxbURVanR0b1oyK3lveFByWkx3blQwa0h6?=
 =?utf-8?B?MytsVFk1cnRiMVJTR2VvS0VDZWJvcjA4d2RqZlNRT2JDeGJVTm5rd1RNYmdx?=
 =?utf-8?B?K21QYjZvSVNtQ3VuR2dQREs0RjJ2OGVMYVFUNUpIVnhDWktyaVhKS3BoVVZu?=
 =?utf-8?B?TFM5YWFkUEcrODhqOVVVOHFVMlBGbllPbHN4MUFVUkdYeXptNytJYTFhbEdi?=
 =?utf-8?B?Q2VnbmhjR2xIV213QWJpdlZsdVljckQyNHh2OVZPSk43bXpGVnFtYTYvY2Mr?=
 =?utf-8?B?Q1ZIZmcyVVhPeU9BNzZzVnRqcXV5MDY1cUFNbjF4U3dLYlJFUk5nYnVmcW9E?=
 =?utf-8?B?ME13QnZaNlZSbnc2UnErQ1VqUWszRDdKREoxcVhWSHd2bEFrK2s2RHc4V00x?=
 =?utf-8?B?VFhjZzNNdnRBVDlPRmI4RUVwT2VYU0lwWEdSWXNYa0lvdm9Ia29MUjFpNlg3?=
 =?utf-8?B?ZVBza0llOTFzTk5nbXZqUDBWT250UnlZREVIZHJoRGhNbXdRb24rckxwNExE?=
 =?utf-8?B?KzBVWHE4akVsNHVlSkhXN2o3UFBFNDhHNlVGcWhiU3RpbEI2S0JZZkZTQmxa?=
 =?utf-8?Q?mchc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtPZnBad0VyTlV2SDFERFZpclpZQ1p4MlpSZysrSkQxT29pTGpISy9KeDI4?=
 =?utf-8?B?U3A1KzVESmVGOGkrMEFCNnpOV0dXSnUxUzZSV21tKzI3U1VQako1VWI1bUNM?=
 =?utf-8?B?cVZvTTFJenRvOERFeEhzZ04wVGxRZFF5Vmhma0NOSGN0anpMQk5wYU9ObFIy?=
 =?utf-8?B?STd0YUxOZW5iQ0VOTFJMOFJIeGZDTFlSRVN4QVNad1RKei9OU3l6eWhOeHBr?=
 =?utf-8?B?clY5ck1Vb3B0V0d4Qm1nekFsMllTaWNvajlrMWRDUjcydjNlcGhhdURqc0I5?=
 =?utf-8?B?UGVXVVBRWHpsb1A3OE5RZEw4ZlN0SkpoMmlubjhvS1VLR3RvRTRHd3huVHky?=
 =?utf-8?B?WTNVeVRFTUtYSS9pNzVRL3FUczZOWm9hMzdvM0wybmNLUk5CeGRwNzB0MWtD?=
 =?utf-8?B?MDZ1Y0ZZMWdZYW1vb2E4UFh5U2M4TDR0LzVwTDE0NEJ2bXRIcGxNTDlBQUJ5?=
 =?utf-8?B?ZWdtOVlpK1B6S0ZKVGtYVWVRRFczT0N3SmZ2OEFsY1lYTGJxY2lqUTFWTFZZ?=
 =?utf-8?B?My8rVkM3WkFwMWNYOVFKVzJqZ0JwVlZ3RGQwTlZMcUg5Q2tZUExBdEcrWnJ6?=
 =?utf-8?B?RkZzdzg1QS96eU9QRHgxMmlralFUb2tNc1NyTEdtRk5SVCtXSHEvTnNBdXE5?=
 =?utf-8?B?czVjYnhmbEtCV1NJckVZUDF1cFpSOVFvOVNaTFNpdTNJcmdaTGFodWxxb3Q4?=
 =?utf-8?B?OEVnQld3aDVFMlB0L0crU1cyQTFKLzJ1bmNuY29mRS82MWtVcWZNSnBnbDFE?=
 =?utf-8?B?WE0wSXA4dmNJMzNWT29oSFlzN0hsQ3UyQm1zY2tjWWthRDVENzAwMld0UnZL?=
 =?utf-8?B?RFh2MzJGY3BMTHpWbXQrRXhnaHFvQjR6Y0pWV0FoVyt2Yzh2ZjErOEx4M1hP?=
 =?utf-8?B?WWJEUFBrRFNKWWxiYVdyS3JJeEg0UDgyLzVqQkVmN3JoU1pTVVdPQ2pQQVl3?=
 =?utf-8?B?TXl5UDlhY0VkLzFkN05qajJHN1YvREg3Rk5WNUFLeG9xVittbGd1UCtyaXBI?=
 =?utf-8?B?eW9XeUdiUUtIQWwyZ1hUVEVuRnYydTJodVFaN2lsS0lSQjlocGxnKzRKL3RX?=
 =?utf-8?B?alI4S2tTTW83U1p3alhObGY4aENwQVVvanc2cmJ2SFdBSGdMQzIvR2hpYk1F?=
 =?utf-8?B?cjdvTVhHOVJMbEJobjdwcUdLRStXS3hDQVB3d3hiUUhIUHFsL2lNQWJFY0Fj?=
 =?utf-8?B?SUdKZEQ5Zk1nN2NrbGxzczVqV2FuQUhGekx0dkJTamtuWjlPSWY0TGtEUG9L?=
 =?utf-8?B?NTNyNVNPOVVnUTN2THJXa1ZXRE1iTlU4cERPcmc2NlY2ZUZJS1MrTmduSG5T?=
 =?utf-8?B?L3d4VmF0Q204ZnB4dHBacm5KVUdHeDBaRUJmcytZWjNMNDJRQk02TkpIQWJM?=
 =?utf-8?B?Qk10MHoycVdqRU45L09RNUNhREwzbmhTTWthQTBJbGxYd2FpVndobUw2S1BE?=
 =?utf-8?B?cVZsY3FHampyYWpVU3ZIYzdNSXlmSElMOVpzam4wVUR5WENiTXRKRnVoZWV1?=
 =?utf-8?B?M001akNTNVhvM1lrb1dVSUJuYlY3VmQ1MWUySjFlQUtQeUJkQmpnTTBva1hN?=
 =?utf-8?B?YWROOFB1YkEvWkZ5bGZDU1gyY2ZGZ0lmSkZyL0xPd2NFUjBuam5ycytldHhJ?=
 =?utf-8?B?ZTd4ZEZPSE12ZEI5MGh4V0FNaWZWM1BvNFczMllQd0dGZC9RK3N1c0Y2cXZh?=
 =?utf-8?B?UjhjbVFZeHovUUlzU0NPR253MDlCSjZ2clorK3diSmhaTUpib25uTFltcDhY?=
 =?utf-8?B?RVdybDFLekY2bHMzZlBFbXdkVk9DN0dmM0lobVJ2T3JEdkRjSUZaeUl0dnVy?=
 =?utf-8?B?TWs5SFF6bkJEMHRyYUNyNWt4dk5SWmY0T3M1Q0pFbmFwTnpqWU5uOUF6VG9F?=
 =?utf-8?B?N0dvTWZJSmgyOEdiYXZxcmNyLzEwZ3VIVGl1ejhXdGpBY2xCb25FNnNEMjRU?=
 =?utf-8?B?S1Z2TFJwZ0huR2o4VXc0enc2bldvRFBnRTZrV09BaXBuL3RuS1hLUDRuaXU4?=
 =?utf-8?B?eU00R1UvSkQ1aklRMnFteWdvV2xaNnlDeDRVVTh0dkV4VHRldVdubWJCcmow?=
 =?utf-8?B?cnp3L1NLeUE0WlhUeUd4eFpGaFJLbVErVGR6K2phWVc2S1g4ZUVKSzUxQ3dC?=
 =?utf-8?B?c1d0UFh5QU05TzRHYnZHdnh0ZnFQaTJSc0ZpZjUvOXpHbFluVWxXV1MzaUtF?=
 =?utf-8?B?VUgvZXVsYVpzOGxCYVFmeC9pZU45Y1ZwUk0xT1pnTkVpNmJrS1J1WFN0OGVB?=
 =?utf-8?B?by9LWi9OT2JEMGVYT1F6U3dMOE9CMnU0S3pZeE0xTDdZK1lUUWJQbXcrU2R6?=
 =?utf-8?B?VXZEOFF3cVFGOWdYS1RDcUVxWG1SWDBFWSswZWZYa1p3VFE3d3R1bXFPVmtE?=
 =?utf-8?Q?+ya2FTbqbfqmsWs8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464f87cd-1cb1-4943-6b82-08de5a00bc1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:53:53.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFRzsHczxB9OfAmrMjf0YvOpB1SvzFQMo4kp09DU6h91yWc4nAdLLH95VOejFXsM8dBiI/rnz5utHbnOSUjMdid0KBXCGeA+EltGSZiuwz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:26 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for adding more register setup to the cxl_port_add_dport()
> > path (for RAS register mapping), move the dport creation event to a driver
> > callback. This achieves two goals, it puts driver operations logically
> > where they belong, in a driver, and it obviates the gymnastics of
> > DECLARE_TESTABLE() which just makes a mess of grepping for CXL symbols.
> > 
> > In other words, a driver callback is less of an ongoing maintenance burden
> > than this DECLARE_TESTABLE arrangement that does not scale and diminishes
> > the grep-ability of the codebase.
> > 
> > cxl_port_add_dport() moves mostly unmodified from drivers/cxl/core/port.c.
> > The only deliberate change is that it now assumes that the device_lock is
> > held on entry and the driver is attached (just like cxl_port_probe()).
> > 
> > Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Just a small comment on maybe adding some scary sounding docs, or
> a struct wrapper to deal with the very specific callback inside
> struct cxl_driver.
> 
> With at least a comment,
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/cxl.h                    | 25 +++------
> >  tools/testing/cxl/exports.h          | 13 -----
> >  drivers/cxl/core/hdm.c               |  6 +--
> >  drivers/cxl/core/pci.c               |  8 +--
> >  drivers/cxl/core/port.c              | 78 +++++++---------------------
> >  drivers/cxl/port.c                   | 60 +++++++++++++++++++++
> >  tools/testing/cxl/cxl_core_exports.c | 22 --------
> >  tools/testing/cxl/test/mock.c        | 24 +++------
> >  tools/testing/cxl/Kbuild             |  2 +
> >  9 files changed, 102 insertions(+), 136 deletions(-)
> >  delete mode 100644 tools/testing/cxl/exports.h
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 6f3741a57932..75ff5f055f7f 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -840,8 +840,11 @@ struct cxl_endpoint_dvsec_info {
> >  };
> >  
> >  int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> > -int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> >  int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
> > +void cxl_port_update_decoder_targets(struct cxl_port *port,
> > +				     struct cxl_dport *dport);
> > +int cxl_port_setup_regs(struct cxl_port *port,
> > +			resource_size_t component_reg_phys);
> >  
> >  struct cxl_dev_state;
> >  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
> > @@ -855,6 +858,8 @@ struct cxl_driver {
> >  	const char *name;
> >  	int (*probe)(struct device *dev);
> >  	void (*remove)(struct device *dev);
> > +	struct cxl_dport *(*add_dport)(struct cxl_port *port,
> > +				       struct device *dport_dev);
> 
> Having a single callback in a generic driver struct seems unusual.
> Maybe wrap the structure or add some documentation to set expectations.
> 
> Probably not the time for it, but why do we have our own probe and remove rather
> than using the ones in device_driver?  Maybe we talked about this long
> ago, but I can't remember the answer :(

I think there were thoughts on a common 'struct cxl_device' indirection,
but fell through and never came back to cleanup these definitions.

I think for now add a comment about this being needed for the most
prevalent CXL object 'struct cxl_port', but that longer term we may want
to consider separate 'struct cxl_port_driver' and 'struct
cxl_memdev_driver' wrappers.

That would save needing to up-cast the 'struct device *' argument as the
first step of these probe routines.
