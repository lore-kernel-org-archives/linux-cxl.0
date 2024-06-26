Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F9E542;
	Wed, 26 Jun 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382995; cv=fail; b=gvPUZJWO+RbFn61XMQ4jw6IayKVwR3HdBY68xmTHXX5vNNhPhJMkwI229FT/936psMY2I2lgVMjiNbadhwnjuNAYgDkIFr59XVE6NGPAds6a+2369ZJDnoiZYyQ92UITO8rLQLfqnCkewNuYv1aF5422Gy4KNsmSxv7o3gcxqSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382995; c=relaxed/simple;
	bh=VoO5Mlw8tNeit5GNF6bcIf90joDu2K12tcIdYDY3h9E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzjtK8cpT8RuNXTId7b1LN6wjwlH42Ghc3OhKI58/COdGgoeMPIvv/pm9/jXyevSXrkistA7DJ5HIf69KIzTuQQ3/K/Ka+lJkfD1s7XVw8H55226ZplncOWR0gUh/WVKcnzANDXmWNYfXZpMJBtRlU68jaoMYo2VpNRBIHcz7X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjkAKln/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjkAKln/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719382993; x=1750918993;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VoO5Mlw8tNeit5GNF6bcIf90joDu2K12tcIdYDY3h9E=;
  b=EjkAKln/tn+VU/l2z9a5LeE3vS8O4MaMWRdCp5er99K6W1AkkmShfWjP
   TjyYTeZlMFv9iWRGW8LcQJNgu0w84swItnt7ybsYFgRqvQg+0CWcJaqXZ
   GfZtUrOgKBbxHInC7qxPKwXyi0WvCEu+ljC6VekOxsaSLhXbaJZp5zjJR
   005DhJzt5gvE27OkKh89WAQPRVE4EX+ISBjyvyKz095DxHeTYyZoNmjjG
   jy2deV33PTUO9uZuV8wSEi1S1oK1kXAF8n60WAt1lDGIMseWNtHj+kpuI
   GG9UaoeHW891rg7fpKgE3gckvIW3Y/k/E99w61HfTjudciAACB1NXURtq
   A==;
X-CSE-ConnectionGUID: u4ow8+69QimJ6OplzV2BtA==
X-CSE-MsgGUID: 2/FzZBR/TXeQHz9iB2RpRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16582371"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16582371"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 23:23:10 -0700
X-CSE-ConnectionGUID: UMRpt6bBSVGh93AhaLrfWw==
X-CSE-MsgGUID: nPG1HtkSQBiO4SmvycGhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44605832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 23:23:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 23:23:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 23:23:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 23:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN6eTIuiGXX7kC6sbsEl/01tHCJpPcgICVoRwARbtYiEDfzXg+fEiwjKYZNl+KBo3LFxbYx7qA4RiDNLiHxiy/3Mo/DQJx4l7+fQRvsDUDt10waOjyGrUiPrLXxNVpAjifsXnTCLcrScr+loGWeuaHpe2ICrfYl0emcE8cTccq66XiTPpxVQ6OKZ8AtfR3wGZvYSVL7FrF29UapFjWVgPamL8hqWRafYKQD7meeFxCUBCKyJbZHbp8uu/rmWWEAaenW8+C9V3lsiWVCVzxDbPxwxqhrd10fbr66+r8ATJoBQUNPc7lZk5Xwbb/H914LIF9qvak+Kh5cjqIKzuw41cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjNiXulQ3P51mc6oZ6cJyOhSa9aVKl8fz0ke38EalSM=;
 b=mY+nFBsa4ZGrfQz9GGH6bEorC+GWcZ6GC7/2cqXVEDDrZ6rhSpXSmcU2KPICG40b1fz2U05IIytM6iCBkfaOTUyEcRngh78nEaeGvNCuxWqy/tTbyalVmCskoIMI2qL+81dzdKzPSXfZQrkL9z9rLgOPnZIxoQP6vqtO2lyY7VPSFhEezLgVegcRcgTY177KD/uZpdYDUzbVR8/HuQ9qzeFXG6HjLl9GlwIwyHmzcS1gP7Kfzz6y9AjRB0Wb/t4sOj0IujMGlW9DHyHtEfo97CcCJyyi4r1LKdTKQEEjhmyfBJXpSOGvmHhA5fFFlHFEgG1eVNlLb/Krm6eJF2HX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 06:22:59 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:22:59 +0000
Message-ID: <45270079-6aa2-4530-8649-87bd5765d74b@intel.com>
Date: Wed, 26 Jun 2024 14:22:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL
 PCIe port AER internal errors
To: Terry Bowman <terry.bowman@amd.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <Alison.Schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "jim.harris@samsung.com"
	<jim.harris@samsung.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "Robert.Richter@amd.com" <Robert.Richter@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-8-terry.bowman@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240617200411.1426554-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfa6429-5c3b-4723-1ec2-08dc95a86d03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|7416012|376012|1800799022|366014|921018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTZMQlRra1gxZTZsYkFGVFpUMWI0TXpKY295a2hESFdSeHBwemRaQ1lVa2xi?=
 =?utf-8?B?a3gyRGJOV3k4OGdwN3JEUEYramRBaTZUYWR4NStEU2RIVmlrVzB5ZVk5OXh2?=
 =?utf-8?B?NDZQZlZzNnVvME9pV1JhZjVNaDJ3b2M2akM0VllXY0IzN2V3K1VyVEplM1Fu?=
 =?utf-8?B?dXJXMkJKVDBBTmJtYVNQQXdSTk4yd3FrK2pJNW0yT1NZMHNEeXhZMWxwV0Y3?=
 =?utf-8?B?Y1ZWUldQNG9YUC80Nml2cmRnckNsNlFxRjB1eDJPSGxRNDRNWU1VMTdhNDZF?=
 =?utf-8?B?aENqNzQ1THVHQUl2STNNZk1yNjBuaUR1Y0ozRHI2THdoV3hoNUZmY1RoeHR5?=
 =?utf-8?B?UDdUYm5rMUovTWVwMjFQWjJ4QUI2VFVWSi84SzltM2VHU1k0MXpoUUV0TU5R?=
 =?utf-8?B?SFgxRktiRk9zT0gvTlFjL0hITEltRFRIaEwyV0RLbUNGTWVmQ3FKRnc0UXp6?=
 =?utf-8?B?NGxkbXdjVzZMVm9zNDV0bXhZUGtreVBkTytTd1VhV2Fkby9CR2lCcFphcDBE?=
 =?utf-8?B?dGhRdHFJWEgwWEJkSjUzS0taeUYwU0h6WTR3NEZ3MnNjR2FIOTdZemVxbnNl?=
 =?utf-8?B?TEJDVGhqWU1ZY3M3b0FWTGJ4ZE5qeUR1czUwWXI2eW04RTN0aFBkTWxrc04v?=
 =?utf-8?B?OXErTFpmdjNEL0N1RWFpQ2tkT2xmRlM5VGFxdDVUM0t0WXB2Z3krcEZ0M2FG?=
 =?utf-8?B?UzhZSmtxeTdjTUJXUklUWk1US0lNR0lCbHJML3FVT3JqcXlVdWV1ZWZ2TEpS?=
 =?utf-8?B?YjMvOWJiZDVVMk1UQ1FZOWhlaHlMMlBVZDAwMFJoQW12eFVHZWk3OXRtSWt5?=
 =?utf-8?B?aTFwMFdmNWdyRm5WMk4vT254V1kzeDU5QzJlWG1zTjNDV3U1VTNqdFg1ODZR?=
 =?utf-8?B?ZG5xdnNEeVFlbldYcHJwbGpxSGJ6aU1SbE5pMVJJc25ieENQTUgvekptek9N?=
 =?utf-8?B?NEI3dkhoRFdlUEJFdjJLMDhkaVpFVFpUV1lxSlRqak51S2UxTWhSci9aeXNG?=
 =?utf-8?B?ZXY2eFh1bkpGVG50dytnQmtwc0EvNDJFODdKL2dmdVNDRy82bkErcC9MVFBx?=
 =?utf-8?B?clRQSmFoMXJPemY3SEp3SkcvdktUbys0VzVwbEZ2TEZZV2ROalhoeXpPZldx?=
 =?utf-8?B?MkVRME8vV2k3TnZKMXVYNWVScVZ0OTh1ZDl6d3oxV2d2emNYRkFjM3ZSdnpZ?=
 =?utf-8?B?V283L2xnRzU2ZHlPTGZkOFlMbmJOZmlKUDlTUWduUysvZnJhb0VXbzZzd3Rz?=
 =?utf-8?B?QXFRczE5WWZVU1VUWWt1eU9QL0R3NlY3TlpGZzQxdS9UZjZxcXo5TjFDekVl?=
 =?utf-8?B?WmJXcnp2aUJBS3cyeHNVVWRPMzcyMUlHVGJNRGRIVnJreGF1b2xwazlkMG1v?=
 =?utf-8?B?dk9BdW1lNHJjLy9XRzF2bHdyd2QxNDltVFNqbUlDNm8vTXRJZkpwdHZoUkgy?=
 =?utf-8?B?SnNkdGVMTnNsdm5NM2xkeWtDd3E5RDBPZ1FXZmVFcHVvcGVmWmlSOEM3bWRk?=
 =?utf-8?B?c2ZlMC9oRVAvelBBRzQ1SGIrRzJnWFBmc1FIb1VlaWxsYjVqNXYxdGJQeG9P?=
 =?utf-8?B?K3BNRGhMYk4vKzJOU2NaN2pWVGRCNXFDNjFoc09zOVZGeFU2ODhXd0Flc2JQ?=
 =?utf-8?B?bHg4bSsrVDNnWDV1eENRQ21MQ1hkclo5bHFUYTJtaTUzcDBOVTNwT3NBd21F?=
 =?utf-8?B?VjNEYUwxQzdLeU5ScUI0OThyMExCSzhORm1ZUmFKQkNMOThhYnA4VzgwK01v?=
 =?utf-8?B?SXZFbklEY3RjQVVoMUs5L2sxVmFXOG8zQUtPaWtXWi9zcHRWd215eFVIY2VU?=
 =?utf-8?Q?OywAaXxJrfYjqziFoVWQqKc4UxFgphk0hoIO8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(366014)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXV0TzlMejZYeUJuVVJJWWNvVlBCbkJrRmxtTE9sMVI4ampnV0liaWtjWDJ3?=
 =?utf-8?B?bVBSQ09rd2RVc2VWbjRoOEFLcW9rblZhcEorK0hFY0UwQVdNQ25yRmtvQ3pZ?=
 =?utf-8?B?andpQ2p4WEx2c0NGVFFiaC8ydEtFbmtxaVF0TjB1cDBFR3pqcXdsSE95RTY0?=
 =?utf-8?B?VjhuR2UrcnFKeWFNTFpnckNXLzhHTkhRbFRyV0MyWFo1ajFjSU9mZk5GbEdW?=
 =?utf-8?B?b0JnWDZTb0ZkR1JCOUtTK1RPZWRtdmhtdWJsNHFaZUJMMnU1Z0RiMmdYK0s1?=
 =?utf-8?B?ZHp6ZUhBaTZ4UEx6TlpPRUM5Yi9Gc1grS2lqbjdvZ3BKWlhHWXBOc1FZRWsw?=
 =?utf-8?B?TjFRdXltOTcwNzVkUmtJWDBYZmhyUmRpOEIyTXNOTUlwM3A0OTR2cFo4eFV2?=
 =?utf-8?B?Y1ZtL2JKa0FFdXQ2cUdUdXAxTDZQbzlBZHBnZUpxWnBWWmJFZU9aOWNOSWx5?=
 =?utf-8?B?NWNNamNsVUliekJEdVJTOTRzczVkM210alBxM05PcEtZZkdueDBDN2VVRGYr?=
 =?utf-8?B?K0k2TjNTU2VSTFhBM0J5anBIRzJrNWlBZFloOUNXNkhtNXlOY1B5MWpLT2lY?=
 =?utf-8?B?MjN1Q1FZclJKUjJqek5OblR6Wm4xV0tjRE95STRIcE5QdkRnT2d1MXNyZEF6?=
 =?utf-8?B?czBwYkc2NlVEdmRNUnBwZmVhOFZMZC82dWw1RkdMcjlYZ0IrOGVZTU56ZTJ2?=
 =?utf-8?B?cW8vMnNBdStRZTQyTHhEU05SbkxaNDljU205OERPa3ZwUTUvR3lMY01yRURJ?=
 =?utf-8?B?dmpLSFZwQU9PZnVDajVmZnNYaXBmYURrNEtjYnBPYnV3d0phd2ZQS2k0cUZy?=
 =?utf-8?B?QXFwY09HWmlwZCt0VjhZWlFPOHQyUHBjQkVEeHZHM0JsZlZObTU4N3pPU3RN?=
 =?utf-8?B?Z3pTU0ZBZHVhYWh6c0k1UWVmR0llajN3UCtwbnVIODFjUk5jeVk2R2xUOTNR?=
 =?utf-8?B?cUhyNWZmQm16bnpzOVdJQWhDd2pLRGZsY2lzMjEzM0YrT2xJd3l2ZTZoTHcx?=
 =?utf-8?B?QUphQ2hhMTFVcjhjSURxV2NER2JNTlY0K0ZjSEVyOEJSaTlpTlAybU81ZWcw?=
 =?utf-8?B?UU9EbHBGN0paOVRnNmNTazJkdDdNN05LaGRqZFlwcTNNajY3WlJRdlhlT3BW?=
 =?utf-8?B?RUNkdFpBaUg1UHFsLytONWNWTE5wOHFtTDlHUHRpUkIxMGZuekhwQXY2ODQz?=
 =?utf-8?B?U0EwaWk3V0tPVWJVNWhaeFVSTFY0a2ZaUG1UZ2Y1M3ZoaE82QUNZUE1PT3h6?=
 =?utf-8?B?Sm40YTQ1VGd4RzZObnFxSjhvQk5TU1FmTlpLR2JtcC9HZTFBdkRXV25SRmpQ?=
 =?utf-8?B?V0ZwdmZqcXZ3T1lQbklKMTNtMnl4M0tDL09aUjhwSmVFaHZkN3RjM04wVDl1?=
 =?utf-8?B?TEl3QWhKV3hraVV0cTh2d0VwZ05DUXNVTzdHa3h0MkdodlUwRGlUKzF4RE1V?=
 =?utf-8?B?OTYwdVBmUStvRWtseGg1YTgzdXg3RVZvZ2hxMW04TVBUV2pQU2tnSi93ZmdP?=
 =?utf-8?B?Mmh4anVCMTBKbjdUQmxtMmxSSnpUU1crOWtncEcvQ0tMZitLWjFvUXVJaGgw?=
 =?utf-8?B?RVM0clh3bG5ySmVTSnluTnlpQXVEalM0b1dkWmpSL0NGMWYzdHBPeUo5OFU2?=
 =?utf-8?B?M3BRQ2lqSHhTNUV4UHlYMDJKYmFIMTZTdGpGSTNuTldhZ2NuRm5kLy8zMHFu?=
 =?utf-8?B?MEw1L1o5dEdoWGI5SmlTdWhJcXdWSXJDc05UZzlWaXlHVFdPb1k0Z0NudnB3?=
 =?utf-8?B?cGNyY2FwbHR6Ukhmd0IrQy9OZGpQWW1aNFRlS3RFQWMrQTU4NWNWS3hrc3gw?=
 =?utf-8?B?R3V1S2tSL3VTdDVPQjZyVmpPV3JJNEpzbXdMYm52a0tPRlI3WW4ydkpZWjRC?=
 =?utf-8?B?M2RhYlVpVmdZc2h4YkIvTkJ4OU1FYlFveldsZFk3WUZCRjBvM1FmcUVkWXBw?=
 =?utf-8?B?eDFTT01welNyb09WQ3RCS29FU3pySzVibnAwL2d3Z2kwRmM2TE9iM1YyRzY5?=
 =?utf-8?B?ZmFQOHJId0QwcGtXRHE5cU5KYktBUTZGcmZmaUt3QlhMQU1TQkVTS1A2QnNo?=
 =?utf-8?B?azAyNyt5RmttMlN2ZVZqVUJGMHRpOGhBdzJRUko5MVlQUytNTnN3RDlJWlpt?=
 =?utf-8?Q?fNv5dXyZZurC9gmzBsinWs26H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfa6429-5c3b-4723-1ec2-08dc95a86d03
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:22:59.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJy+wno6pIfYyggluflA/FPfSb9AOK1YOD/1jxdBkKKvT8FP/FCJU66e3jC+3AIh0GCDlx+kOli32bPugOd6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-OriginatorOrg: intel.com

On 6/18/2024 4:04 AM, Terry Bowman wrote:
> CXL root ports, CXL downstream switch ports, and CXL upstream switch
> ports are bound to the PCIe port bus driver, portdrv. portdrv provides
> an atomic notifier chain for reporting PCIe port device AER
> correctable internal errors (CIE) and AER uncorrectable internal
> errors (UIE).
>
> CXL PCIe port devices use AER CIE/UIE to report CXL RAS.[1]
>
> Add a cxl_pci atomic notification callback for handling the portdrv's
> AER UIE/CIE notifications.
>
> Register the atomic notification callback in the cxl_pci module's
> load. Unregister the callback in the cxl_pci driver's unload.
>
> Implement the callback to check if the device parameter is a valid
> CXL PCIe port. If it is valid then make the notification callback call
> __cxl_handle_cor_ras() or __cxl_handle_ras() depending on the AER
> type.
>
> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/core.h |  4 ++
>  drivers/cxl/core/pci.c  | 97 ++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c |  6 +--
>  drivers/cxl/cxl.h       |  5 +++
>  drivers/cxl/cxlpci.h    |  2 +
>  drivers/cxl/pci.c       | 19 +++++++-
>  6 files changed, 123 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc5a95665aa0..69bef1db6ee0 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -94,4 +94,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
>  
> +struct cxl_dport *find_dport(struct cxl_port *port, int id);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 59a317ab84bb..e630eccb733d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -689,7 +689,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	void __iomem *addr;
>  	u32 status;
>  
> @@ -698,10 +697,17 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (is_cxl_memdev(dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
>  		trace_cxl_aer_correctable_error(cxlmd, status);
> -	}
> +	} else if (dev_is_pci(dev))
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -733,7 +739,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  static bool __cxl_handle_ras(struct device *dev,
>  			     void __iomem *ras_base)
>  {
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
>  	u32 status;
> @@ -759,7 +764,13 @@ static bool __cxl_handle_ras(struct device *dev,
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	if (is_cxl_memdev(dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +		trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	} else if (dev_is_pci(dev))
> +		trace_cxl_port_aer_uncorrectable_error(dev, status);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -882,6 +893,80 @@ static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
> +static int match_uport(struct device *dev, void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return (port->uport_dev == uport_dev);
> +}
> +
> +static struct cxl_port *pci_to_cxl_uport(struct pci_dev *pdev)
> +{
> +	struct cxl_dport *dport;
> +	struct device *port_dev;
> +	struct cxl_port *port;
> +
> +	port = find_cxl_port(pdev->dev.parent, &dport);
> +	if (!port)
> +		return NULL;
> +	put_device(&port->dev);
> +
> +	port_dev = device_find_child(&port->dev, &pdev->dev, match_uport);
> +	if (!port_dev)
> +		return NULL;

 seems like just a bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can replace these find_cxl_port() and device_find_child().


> +	put_device(port_dev);
> +
> +	port = to_cxl_port(port_dev);
> +
> +	return port;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +
> +		find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;

Need put_device(&port->dev) after find_cxl_port(), use scope-based resource management __free() here should be better.


> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct cxl_port *port = pci_to_cxl_uport(pdev);
> +
> +		ras_base = port ? port->regs.ras : NULL;
> +	}
> +
> +	return ras_base;
> +}
> +
> +int port_internal_err_cb(struct notifier_block *unused,
> +			 unsigned long event, void *ptr)
> +{
> +	struct pci_dev *pdev = (struct pci_dev *)ptr;
> +	void __iomem *ras_base;
> +
> +	if (!pdev)
> +		return 0;
> +
> +	if (event == AER_CORRECTABLE) {
> +		ras_base = cxl_pci_port_ras(pdev);
> +		__cxl_handle_cor_ras(&pdev->dev, ras_base);
> +	} else if ((event == AER_FATAL) || (event == AER_NONFATAL)) {
> +		ras_base = cxl_pci_port_ras(pdev);
> +		__cxl_handle_ras(&pdev->dev, ras_base);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(port_internal_err_cb, CXL);
> +
>  /*
>   * Copy the AER capability registers using 32 bit read accesses.
>   * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..d0f95c965ab4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1027,7 +1027,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
>  }
>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
>  
> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> +struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
>  	unsigned long index;
> @@ -1336,8 +1336,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7cee678fdb75..04725344393b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include "../pci/pcie/portdrv.h"
>  
>  /**
>   * DOC: cxl objects
> @@ -760,11 +761,15 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>  void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
> +int port_internal_err_cb(struct notifier_block *unused,
> +			 unsigned long event, void *ptr);
>  #else
>  static inline void cxl_setup_parent_dport(struct device *host,
>  					  struct cxl_dport *dport) { }
>  static inline void cxl_setup_parent_uport(struct device *host,
>  					  struct cxl_port *port) { }
> +static inline int port_internal_err_cb(struct notifier_block *unused,
> +				unsigned long event, void *ptr) { return 0; }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..6044955e1c48 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +int port_err_nb_cb(struct notifier_block *unused,
> +		   unsigned long event, void *ptr);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..f4183c5aea38 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -926,6 +926,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return rc;
>  }
>  
> +struct notifier_block port_internal_err_nb = {
> +	.notifier_call = port_internal_err_cb,
> +};
> +
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
>  	/* PCI class code for CXL.mem Type-3 Devices */
>  	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
> @@ -974,6 +978,19 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> -module_pci_driver(cxl_pci_driver);
> +static int __init cxl_pci_init(void)
> +{
> +	atomic_notifier_chain_register(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
> +	return pci_register_driver(&cxl_pci_driver);
> +}
> +module_init(cxl_pci_init);
> +
> +static void __exit cxl_pci_exit(void)
> +{
> +	atomic_notifier_chain_unregister(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +module_exit(cxl_pci_exit);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);


