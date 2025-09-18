Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8B35947;
	Thu, 18 Sep 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223595; cv=fail; b=W8FmjEesSRJEFowrPDQhLfQBwwIQPuuBIeHFM6G0+XEuDajPS+72TFagzAI/AGAKuoQL6zrnR3CxsHEYotDwuyHyU9c+rWJ9sFoKKYc1MNi1ihycSJoPNL17uG8mp0NnsZciLruRkx4Zj4b95J98jdOgxKDPBRNugkwM1zquRyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223595; c=relaxed/simple;
	bh=V0BwV+AV84QugD8y7+P1dD/DfJhy9V96+XZ5fvI7NNM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iWnC5wlEIeTrKe/q4QgQEhwHsXsBc0GkgSzN6N8kaDVth3tC5Kd5t9eg0RPjn4ijigl43V0t3SFizcwEHM3plZWcya1aRfuoU4LaQ4Rhsc9CDAKwx7AIWWA+O/pM3dh1EERIYfNqljHZHqZWDlNhoXwWLYy/7bVEsZGVb+ONHUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe3cUghg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe3cUghg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758223594; x=1789759594;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=V0BwV+AV84QugD8y7+P1dD/DfJhy9V96+XZ5fvI7NNM=;
  b=Pe3cUghg/MYJSyJgvzNZIarEsjgNeVjgzs1PF7KoxgDlTBkpWoiMpaY3
   kjrtsTKRdJB4ggh2YbD/ECjYMNILC4fWwDGGW6TQhiHoM0HTDBxMyv5S/
   C5Gfx8vbLkubGpCqwEQaKCF0Ep94qFZPhC12+AqfkJNDn4LoZOdzbKicU
   5RqPWq7rENRPUw5J29kXZJ/CG7yHGHXtVDZb3838L6dJzZ+HAd/mC8AST
   VSRHOVRsxuBmo5LM5/GYJnyVeHwATY9UHLz11NJ2bmzM44bGQZ2PQgoZz
   rwO/9McGjyZglYA2U7A5LCzZja4I1TGbsygTchfO8pBKEFkBfKkeAjA/t
   Q==;
X-CSE-ConnectionGUID: tWskozEARf2/Y/6a0Ko8Rg==
X-CSE-MsgGUID: jzsjjZjnTdeEYqx9LewuSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60497873"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60497873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:26:33 -0700
X-CSE-ConnectionGUID: J5J9UK6ORd2vj2AgecQG0Q==
X-CSE-MsgGUID: aOSG2ozKQYqkPA0viSjlSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175559296"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:26:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:26:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 12:26:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRVV5xbqbh4njE4i3Jd5J5V0DdBVcmDjf66JiGRauqGa2j4KtiLNC959gZgoO6ZHxh8UE/n2Wl7pz6YKupif4eCOe9LB+KQO1uucJfkjVDHzZn2+Qjjlo+1/ttD70MrfhPHbzoGGqa5eyBbTd874sxJ9w3CncH/Uy4usKqbT+xHsf/uS3lNKKhB5Ah6iXFAU5NEDmztypaWvtaDwt44Fuxh4snfVGsycJYuk438/FuWbDydz1O20j8CcDabIN2fYG1ZuXEMnbash0DoKKDqLQhxm4r7EMWo96erthEpaD1oBvU+p6yR3aAXC0d4occBg/V9aa+J2YA315LzkJ9txCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAJkgLBOmbrDE4wlH8B3gw8ZiMR13sx57y6+v7iggdg=;
 b=dKF5fi5pvnpLqcY/7yGvgaUEhweaHoM5Z58HLIPIiI3ZPJSKFZTAjB850//5SNEujUweroSXb7TPkdUJgTvkOs/gdMzM8cWcj2T3HyVPpmw+OCcHu5gdG+462QD4Tko1fTT01t2NeCra8wklHqiL+NTPV8Io+R6wQWriFzXcI9iY9afiRis2VLFqyB1s7tsDnd68NmuclQsMPGPFR0WnL7NYbrhzV3epf46HucSFUnS79txAkBKn5Ft/qHIWHWOe6lRvQEAoVPj/axIt4SAlMWLSD+SMcxm0Os9V8wS63MaIebigitsJaZv4y9Lk9QD4OVvgA/t788viHduYbgkMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 19:26:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 19:26:29 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 18 Sep 2025 12:26:28 -0700
To: Andy Shevchenko <andriy.shevchenko@intel.com>, <dan.j.williams@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Message-ID: <68cc5ce459c93_2dc0100e4@dwillia2-mobl4.notmuch>
In-Reply-To: <aMxbxAGjoKWmVXLc@smile.fi.intel.com>
References: <20250904225010.1804783-1-dan.j.williams@intel.com>
 <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
 <68cb426324810_10520100fa@dwillia2-mobl4.notmuch>
 <aMxbxAGjoKWmVXLc@smile.fi.intel.com>
Subject: Re: [PATCH v2] cleanup: Fix "unused function" warnings with
 conditional guards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: dffc389c-ae64-4aa2-79cb-08ddf6e944b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUM4K2JSdU1sS2tlY3pqVktsbXE0ZXZoRUxtdkFUbFptamU4VjE0Ly9QaVFN?=
 =?utf-8?B?YTgxdis5YmRBVS92cGZwUVNmRkY3WXVHanpWbi9uRjJSMWpTb041alI1Y1dG?=
 =?utf-8?B?cmZuVHl4SVZUMmtCa3FqV1V0SVBZUmFWNDdPaUR6YS92TEp6NGh6UlQxejNl?=
 =?utf-8?B?UEtFbVlzZFB2akJEWHFZdkVCQjZYR213eG1TUFFZUDR5SFNqNjc2RGNPN2N5?=
 =?utf-8?B?RE1uaTJKdHZUWjBDc2txM1Nnb2xSdFNEWjVYL0p3ZGxLTlRDbktQaHpOdW1G?=
 =?utf-8?B?WDVDazZOb3k3M05VU05yalJmbjJKN09XMnI3QXUzOEFnRkpkOFp6ZFFyQXVr?=
 =?utf-8?B?ZnpMdWFXT2FOYytnWmRvMk1YQllPeU5sSVpDZ090UVpiR1JoYnFVRVFzNGNy?=
 =?utf-8?B?am5CVzF4TUxCN3B1cEFib29IZmJ2VzBjc0xJRSt2VzU3Z3czSXkvaU1FNXd5?=
 =?utf-8?B?dFBKNnZ6U3ZHRWE3VUZzbHNqdkNlQjZjT3VjNUlGK29kVGZmSFg3TXd6ekkz?=
 =?utf-8?B?K2ZVUVQ3UDFETmlNaGM3SkYrVFJia3dvOVR6SU1wWnJ6d1B0TDR5NFhpTXhB?=
 =?utf-8?B?SzlOSlB6VDEyQVhVYUZvclpCNTBJd3crOTVxVlZlM1YvVWNXSVFEV3FvV2J5?=
 =?utf-8?B?MDc5YjliMW9RaTdPNWhtTUVKcXJXOFRNSHpYOVBHbVRzR2ppMHNQZktHL0x3?=
 =?utf-8?B?WWQrRk15YkwzaFhiTHFMdGFQS0kzSzU3V20wN0VEYXoydDFNeHBScG9HeTNE?=
 =?utf-8?B?a2NHOE9ES3pZWUlSYVFIWkdibHo4SWQyalE0enZSUWxsY1E3K29UajlsbjR5?=
 =?utf-8?B?UXVYbHkrOVhsQjU4ZVViWU13Nm5Qc1Z1NDRCYlBabFZqaFRaWVNGdTZrSXpw?=
 =?utf-8?B?YUZXVml4aTA1MGhNNTV6Q09ucUdMMWdXZWhrMUh3YTUrVWFLaVR4eEpEQlIw?=
 =?utf-8?B?VkpNVlpsODNxSEZNcUd3cG5EcXJNbnVzNDdYQ1crQkZiRS9OTWFxMWFJV3Bi?=
 =?utf-8?B?K251VDJxSndxWElCejhkTTdFRCt1eDNMaWhGVnBGbHg4VDdjTlJhTFRpY2ti?=
 =?utf-8?B?Y3Fldjc4S1NhZ3JoNmlscnhmbHVvQ05xTjF4VWR6NUk0UmZ4d0pyNFhSZ2FP?=
 =?utf-8?B?VUFVcmViNlFsN0lRcW9EUmdDS2ZINFNkVVhWblhVdjAvOTNCYkNOSlE4Y1Rn?=
 =?utf-8?B?WG56TWh3RkN3a05IcmZYSWt1QjV3ajQ2a2Rzc3AwRmoyWmg5T2FKMytzWVNx?=
 =?utf-8?B?dGl4aHVPeXYrTnB0Q2dVdWdPTklwQldXTEc1YVI2SlRLbm9kaW9SRFAxYTd4?=
 =?utf-8?B?Z2kzZ1RSR0IvNnRUR2haTjh4Tk9YaEdZaTFoUitRemtPOGdaVXpSYkg5VVg4?=
 =?utf-8?B?Z21YemQ4ZktKcGlnR0lhWWhscTZqNUx5eVErajN2NU9aK1RTWlM0S2FkeHQr?=
 =?utf-8?B?Y3dZSGpFK3ZYckxqVEpFSEFPWVFNN2pDaGJ1WXpxOTE5SHJZQ0lURi94MzlY?=
 =?utf-8?B?UERnRENpc0FvR3hmOUJxaGdJTkEwZWtiWHhocUZ2cWhzOXA2L3J0KzkvRDVK?=
 =?utf-8?B?dDlxUmJRaE0rZk54MmlrRmhqMnlGWDEweEFIU0x3bUphbVFmRzNvRUR6d2sx?=
 =?utf-8?B?aGwxd2x2cTRncEN4NTFvTzE3aU9yQmgxR1VpNlNFR2xHK3lyV0RaMWQ5MjNs?=
 =?utf-8?B?c1d0Rzl0d0prMFJmaE05WG1yR1lmcWUxSnFRRVNISmUvajh1WjMyeGlmMSty?=
 =?utf-8?B?bm9LMHZPdEFuN2lCUkd0bUFXend3Y2l4c1B0eVlQQW8yZ0kzTldlbFI3RGti?=
 =?utf-8?Q?rEoSNm3Nm3t63pFnb4BJHOgYNhY/NDtXchtYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFlNnkvN0p3Y1BwWjRCMkxHMG9sTmtXZktKS2ZTTC92bnl0TVVkQmVWZThz?=
 =?utf-8?B?UU9IRHVIUnovWXNXbzI1cnkvVkdvVEFaaHJ2a25QdkdlTEcreHVmR096RXhX?=
 =?utf-8?B?bzY4QjlIQnF1R3F2eTQ5blRUbTl2MGV5TzhvZmg0YktLTVFzbUlTQ3dUeEZp?=
 =?utf-8?B?OFZMV1lxeFd0K1BkRGVXK3ArRzhpTjhzd0NoTm9pZHFUb0NzWVIrRHQzekNB?=
 =?utf-8?B?bzVSWms4elhDSHMyZUZDTkN4U0Y5NVd3dHFLTCs0SEZqRUNqSkg4TklLa21Z?=
 =?utf-8?B?Z1ZPYWh0eWNvc2hGQW9sL01NQnFGdWpLMEpWSUx6VzhJNmo1M2J4Qy9MNmpD?=
 =?utf-8?B?OWw1b0VqSkRDbzdGaDJOSWVNelI5bkdFZmtJT21Bck9Fbnk1Z2NObzhSQWF5?=
 =?utf-8?B?aE5PY3RXbEtMcGF0V3dVVVgvNVVwbGFBcnFTenFjbHRuS0NqL1pHdVY5QXR3?=
 =?utf-8?B?R25ZSjB3dFAya0VDMjJaYWMvMGJ5VTlYSEJsYy9iMW94R2VvOU9RWlpCb0J5?=
 =?utf-8?B?SmltRThWYnIzdTg2WFVYdW5HbHNqM3g3NmlBRllUeHBzdWUxR1doVEtGZjV1?=
 =?utf-8?B?cFMvRklIZXowd1dCYWIxblVQVzJ6bGJpaFVyWjk0Qzk4UTVsOGRTdzVxYXhX?=
 =?utf-8?B?MWd2djlHQWUySVN2WjQvMkg5dmMrSnhhdmRQd1JwcmlqVkFENkRRYlcyUzRO?=
 =?utf-8?B?aHZJeVpjSnhQV2xQMTlLMms4alRHYWlYZXRxVTR4RE1YTmViNVAwdkc3TFl3?=
 =?utf-8?B?MTdwbXZrTktZUUg2SldJV1pjeFJ1Zjd0V005SlVPeXlkT2E4WjhweVh5SXFx?=
 =?utf-8?B?ZVNLUmJQNGU0U2M4dG9hTGRNODYzeGtNL0pyWERDTWF1YlFWZ3U5aW9LMm5C?=
 =?utf-8?B?T3dyblRDTUQ2Yk9DOFFlK25JbGlPWUJ4VHNSamFPckFqZE5KU1RMN2VDenJR?=
 =?utf-8?B?NEhnK2JxSU44R1hidFY3UWs3TXFxV1QzaGlUMTdreCtOWWkzaGkzWUlBY0gx?=
 =?utf-8?B?cUdodU1xQXNPVWRBZnNSNGxwWW42VXlCa2x6VllOSWQ4M2RGZUlja0VVYWFk?=
 =?utf-8?B?aFdPZzQ2djV1NHAxTjBCMkFxTkZ3ZDdyZFB1RWlSZjFqTWxzb0VQRTYzdXRk?=
 =?utf-8?B?Sk1MVEhES1FzNUNvaXRnUnhKUVd5VUVGcS9naVAzOWJuTE05a3RMdW91OVJq?=
 =?utf-8?B?Nyt4NWd2QXVtOGt0V2pYYkRiMTdrVUFCdmQ1dTFPUnJyb0doZjBJTlZBcHlD?=
 =?utf-8?B?SVN0eUVjUDEvRXVhM3VZNUVBelRvSk9LZFpsM0Y2ZnF6N0FKNTEwa2lFUjl0?=
 =?utf-8?B?WFpmZnFBaG83UXdlSnk3MDNUaExJMnRGUlkxR2doTmpRZXlxN3NMeXR6NlFT?=
 =?utf-8?B?cHlkcTc4aVlNQkk2VVltRHByQ2NwRzN0dEd0YS9SNU12R3BNQkprV3VRN2VX?=
 =?utf-8?B?c0IvdUFoS3IzeXd6SjVORHduTkFWRnZOTDRCd1JZbUpjdGpocWd1bitxbnhX?=
 =?utf-8?B?ZGdjNnp0azFqNUpnUDUxMDJqWU1mb1BSYkx3ZENFWmJYNmprdmtITWFLN2pw?=
 =?utf-8?B?UCtpaGxtZXBzc1JJc1ZHUEdHR2pUbys4dUxnMXdacUZpZzkrNTg0OGMyS3dD?=
 =?utf-8?B?b2lrV1FvaG1GK0ZBWWFsK1RTaW52ODFQcnFBanYvQTg4TURPc0t1R3BjcEVN?=
 =?utf-8?B?QTQ3RkNPZHNlSHhpUmE0bUN5TEFudTZ2WmNKVk5XTDJUY0NBOVdzY1lrRjhW?=
 =?utf-8?B?NW9FdGNXUFgrU3R4VjNBQ3g0UHpHMUdVS1ZaZjBCdHRYdFphZTVBL1o3dWcr?=
 =?utf-8?B?ektUak1QcFVtK3k3ZGx2UklPWkUrbW9oTGN1clQrWkpxVnd5UHJtN01IczZ2?=
 =?utf-8?B?b2hlZTI2ZndPcDV3S3plNFVuRk0yUFRPb2p4SldLL09oUUliRnFyZFVyenBw?=
 =?utf-8?B?L1Y0aGdPcDY5ZGxNakZvVStPVVZYMWV4OE1KU3IwQzljNmZtTTh0NVFZYU10?=
 =?utf-8?B?c2VjeldRbVJrYVlEdGJ0S0pDNFE1emhHSE56VDFMbFZwUkw1TTd6YXg4eXIr?=
 =?utf-8?B?dEtxZHZRRnliUERqRDJOWEJMU2dDdnRjbEt5c3hKaVF6WXkzWFRjSXVtZTBV?=
 =?utf-8?B?alRGTitzWml5NjF5K3c1V2l1c05ycGhGeVFsaWFaZGcyMVIxdlFwVVRnUDVi?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc389c-ae64-4aa2-79cb-08ddf6e944b9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:26:29.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKY7QrIL9ljQY2pwpMqjshVoaWARryofb2RvCSToOS+V+y5qlPuYfDpanwNNMiP2NyhZUDeN24puBv4BtPRY5t+fO2LjbAdn/zGt1VRehQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Wed, Sep 17, 2025 at 04:21:07PM -0700, dan.j.williams@intel.com wrote:
> > Andrew Morton wrote:
> 
> [..]
> 
> > > > Alternatively just merge the suggestion in [1], and call it a day.
> > > > 
> > > > Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]
> > > 
> > > lgtm, unless we think this (your) patch improves the code for other reasons?
> > 
> > The tl;dr above is that the warning could have small value, but probably
> > not greater than the overall benefit to Linux to stop bothering folks
> > with this low-value warning by default at W=1.
> > 
> > So I am over the sunk costs, and moving this warning to W=2 is the way
> > to go.
> 
> Can somebody add a fix so, we have v6.17 able to be built with `make W=1`, please?

Andy, might you have time to take Peter's proposed diff and wrap it with
a changelog for Andrew to pull?
