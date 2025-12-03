Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961319E98D;
	Wed,  3 Dec 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764733114; cv=fail; b=CWkW6sDnO0JSPrGk9KNCltoiuwN4y534Cpxxt/1g0VO2IcSphMgU/ONwL+5+tOPbvfppCaCccwn619ZJ1zfSRJciGyr31H9voyVtDoZmCRAKAy31hxqSOJYFMO4agrd5T2qPYRviADNm+BiFLYYMHMV6swwna323hCGuGzZG80Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764733114; c=relaxed/simple;
	bh=T22mMvG+OxSQ3jFiPyu0Lkv0mf/6j0ZXDrdxloVbfwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fo5mCwIxWrHpgBfZMwtm2AJhwLFxU7OQJ7/qgYDyF0i1aFZG1R9wGOqpytBMVg4B9GYy8w4bHDNI9M01p+iuwxLyj8XCWWXzW0Meak78vyVH8ku5aWhWV723HIMoFNuHl2xiCyayB7/SCIEHt97C6EjVJEoth+bXHCEL55+m2gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KU/SkyXz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KU/SkyXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764733112; x=1796269112;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T22mMvG+OxSQ3jFiPyu0Lkv0mf/6j0ZXDrdxloVbfwA=;
  b=KU/SkyXzK5eqG0Djd06mh8HE3AVtN8z6pxemuhlFxlwwI4MAT2ItLahC
   3706UNYcACIZqMCg36madIGBEw0/wKeE6DCiyyafpVBzrTrm+vfKKJFD4
   7IL0296bZ284Am6ID47V/yyocZsSykkLnY+xOh0Dm/gKLXcMTrC7nolbd
   33muXjYyzhWPH6pFMWOXnxHIRBC/xq1URuWDtJN51aw0nmAoZeo+iSvvR
   VwsjP2zmtKfoFVihiHai9YAt3nlbBgz6gikWnuFQXVfaJY2SBhYBYYjfD
   IUApQH97rgGYptHGM5/cuH0nom//GHfmT6okXtM36zBt7ojUsvIHf1P/F
   g==;
X-CSE-ConnectionGUID: Rz38xukERS68BEejBX/qzA==
X-CSE-MsgGUID: RjUJke6ORGGEjyvof6whIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65722498"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="65722498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:38:31 -0800
X-CSE-ConnectionGUID: uOCrXd+eTHuMOQrYC23HVg==
X-CSE-MsgGUID: see5Yig4SUOFrKZlmA5TbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194374128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:38:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:38:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 19:38:30 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:38:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXwBCRUQwqFbGwUZ72mx+AH8XnlSFUw4Brwb3ToIE89gpufF4PanliW8Idn2YZzKb/OhXbDk65gL+BNsmTlUo4e8PcqVHdXSq3HmJGS3Q155Hy6BYkqSL16AOTlDoFZ1CsghetKfOPT7z+70SBIhxXbX3WkQz3mPD4jSgO2IrNLoF+ZHXsfYHVqXP2L+C39scXumyjOdo94raEQoXfSqr136+31u/I3ywQVkWLy8zdvd8A3zRgt7mQ7MdzN/cgsYYiYT61uTdV17GZslL44VnfaqC9XPAiYnRtNWmjnc3zadJXkmKqpRIcN6ukKfAxdUvRRMBzUe+4v3GS1q5GBMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGP0q9wubykZZDX92OgMx0hrJr7DpdN2wgIrlIeYWgE=;
 b=Dk/wNzvi0da9G79ufkZ+0gCrkNCwWE00JByEMHC5SlDIDhbiYY12UshKPzMTuKBFJB7iD+9Pwt7t5Pm7mxttjD91rB2VA3BhDTIPVR/GcogkphOHGeakG8ORkrcLHfLOW1veXlcmu4+7PVCbiRkPH6PQ1b+Wz8eJ7g78oPhQsB1KoN8EwJZGIpKi5iJDzgMEP7Pn/9SHZkdAr4XMTC/Pocf1RNHahiSuTrhTghFqvh9dmo87Y59s7Q0m9mzOCcs/NQT+M83faXLHBsN7fVnGxNHBsMNUkS0pfaZrSE8+RQy/xji1ERxUMIuIERm9V9qWs/MoZoDd7Aj931xNBhLkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6354.namprd11.prod.outlook.com (2603:10b6:510:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 03:38:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 03:38:26 +0000
Date: Tue, 2 Dec 2025 19:38:18 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v1 0/2] cxl/cli: HPA-ordered destroy-region teardown
Message-ID: <aS-wqvEjYUGEUs-s@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: e92a31ad-5432-4d27-c6a0-08de321d6aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3AraUtLNWlKczMyOVBZZWt0NHJIKysyRFRFNzh6bWd6L0FTLzhNaWFHWHgz?=
 =?utf-8?B?SjdPa3FRQ2dFSzdZdk1yVytyWXd5MG5xNG9ySmM5aTZVMzV5bFJxWmR3S1hP?=
 =?utf-8?B?N0tMUFlGNVJuT0FSUnNoaHpCYXJvWVFaYy8yMXBvV2s4bDNseGZCd2w0MkdD?=
 =?utf-8?B?bEhLQlBvbU83TEVzQkVBY01UTEZ1Qkd1cVVKUEdhd3pMMDQva1pYTDJ0OGhV?=
 =?utf-8?B?b1U3NHpnbU04MnVlazJHdUZnYVJrNjlhNW9VYnZWK1dEL1dTNlpONmRLUWVq?=
 =?utf-8?B?TkhNU2plblZiUTdiN1REd212eTVtOXN1TWFreUlYcTVUT0p1NjlPNlB3cGZB?=
 =?utf-8?B?MEkwRy9xMzZMNHRVd0crSVJ2dlVhQkZRckJ4eVh5NHp3UkxCeHhKSUFsV0lu?=
 =?utf-8?B?T0FZUDJPU3NHSlNaWXp0b0FsUnJSYktJRUVUQXJWM29wYWcvZWVGanZIMnNt?=
 =?utf-8?B?YjF2RWYwTXJqVDVRQnhZVC9kaXZOVUI0NEx3aWJuUGViOVZkSTJrZE85TUNJ?=
 =?utf-8?B?aGlZVG5RV1ZpZnQ1dW52aHJaYi9oV1IrRHc1RnVhOGZpN2k1Tkd5cFZnbEQ4?=
 =?utf-8?B?czVpYlVQa3ZhakRqUy9QVy80WVNTUEZraERVRkRnL1Y2MktMMXRjR3czd0NQ?=
 =?utf-8?B?bTNScjRpSnZDNkt2V1NKUkNSYUd2ak9MdFNhNnRZNWwvQWl4alF3S05lTzZ0?=
 =?utf-8?B?SkV6YVRsWVNsWVRwZDdIVVpqWVJCVjZsKzNhZlVoaTl4NXpGdnIvSS9rUVdj?=
 =?utf-8?B?Q21DSlZ2NGtBR2JBTHZaTnY1YUExbFVNejBoVkZUNkpNbkp1V3ZFWFBjNC9j?=
 =?utf-8?B?cG1JT0hjajA4N2RPTWt4YUVLQ093NXVtU2J3eTlYZ2RMK1JvM1gwTU1xRUFV?=
 =?utf-8?B?dUZ1M2Z5ZmhGVitQdWo2aGRBckt2NTR2V044TXQ3OFZzTUVEQ2I4cndwa3pG?=
 =?utf-8?B?ZGtMR1M0aENiY0dQNkdMQ010TzZiMU1qR1krTTFucExxaUVEc2lscVRGbFRP?=
 =?utf-8?B?UzdHcmZXZXpNTFFFRHFoM1p3Z0RZeE5BUE5zbW9ZTTZYT2tCYm8rK1ZnVFR5?=
 =?utf-8?B?akJjZlBsQ2RnSllwU05ZcnQ5SFN3OHA3QzdhT3l0VVAwb0IrN1FtNGIvVE55?=
 =?utf-8?B?aXZhNldQSUJ6OFkyWVZjSkdsT0xLQ2cxRzl6SnVSNDJyU2UzNmFuZUxka3Fa?=
 =?utf-8?B?OVhvVmp6a2Y4WUhteVFjNVlXOWF5Wk5ZZ1l5R05ucnl1TlNJTHBrekZtVERk?=
 =?utf-8?B?WmhBTXJmTzdleXFQeWN1Q1FTN3hvVnlaZjkyQXY4WmQxc3JLRWdaZVBUenlW?=
 =?utf-8?B?TnpHZUNwZDljUHNhR3VoNVcvZTNtbFRVZkMrQTdOVzdVVU1pdisrUDJBQ2pa?=
 =?utf-8?B?alNXdTh2M1lnR3RxS1VnTHN0b24xZEVXUU91alhLYnRSUFVqbmhyTE84MGpO?=
 =?utf-8?B?NHRsRnE5OENWV01DNWs5TWNldHNuSFB5bFFuNldKWG5janNCNi9RR0twS0to?=
 =?utf-8?B?ZFo2NjB2VkdobENmSWIxZUhTcXI3czVtTTVuOXlXK1dKZG5Ld01NSFAvSUJY?=
 =?utf-8?B?ZElWaFFnUVM3MWpacWNHazN6VjBJNjQ5UVVKWGZ4VzNuVlhyTjdGWFMxblYz?=
 =?utf-8?B?ZVc4ZWxNdHJiN3Eyc1YyR1M0aC9OMVpXanNTMWJybytubk9USWRJekxNc3dN?=
 =?utf-8?B?alhYMTBpbXBmY1o5TFB6dVY2UFcyVkdkY2U5Vm85ZW9mOGJnU21DT2VrMWox?=
 =?utf-8?B?dXFTZnh6eW8yNTY2TSsxUHpKaFhBVU5vekNieXhITS9OeFlvbDFrY0ZubXZQ?=
 =?utf-8?B?M01CaC92cjNHWHhSTkk3alA2NXc1OGJpT0JwSFZ2SlNaUjdzUmdzR2tZZ3d4?=
 =?utf-8?B?aHlwWTloS2RNV1o1Ujd3VWN2YjYraG1XTEpKeVFwM1lJVEF5S0s4OXNTZFpX?=
 =?utf-8?B?TE1jTkgrUWlUK2VVbmZvUnhDSXBGb2NNYmJFV0l2dDNkUWE5dENJekEzYXAz?=
 =?utf-8?B?eXl1MXE4TktnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkduNGxmNzdUS0ROWVh4Uk0vU1E2OU0yVG1Bbm5sdlZQalVreUUzMkkyZTlV?=
 =?utf-8?B?NmNCcUlLZVp6VTdJS1h2VTZFV3pFb2NYc0ppRm5pYlZFWjYvcHJRN1lsdk11?=
 =?utf-8?B?aU0veUlBNi9mWU9YbmRUM2lvdEdTcFZqS3dFMTE1VlcwdVBIMlR5SkozZVgx?=
 =?utf-8?B?UjlGSmhEcUpnUjNrSUtxTjdrSHRmaDlQd0piWG12QWRlYUhKU0hOVkpqaUZK?=
 =?utf-8?B?RVh6SXVyRzZwOUw0TzlFL1hJcGxTcWt4SGFSUjV3Mm9JVGRtS2ExRU4va0Nn?=
 =?utf-8?B?TCswcHJuYUJ6TkpNQllvZG53ZXEzTlRlM3psTzQxUEpndU1rbEU4dGNPR1Y5?=
 =?utf-8?B?U1RBM1duS0p0a3MvZDVvZk9lWDJHTyt3T3RyUVVUUnhwVkQyYjJVdGMzV0d2?=
 =?utf-8?B?M25EYSs0czVnVnNRdldPdGtIRWZKeENCM3liaWVpeGJ1L2Nyc2lQZU9HSUlI?=
 =?utf-8?B?dUxBc3JuZDJhQjNzSFY0RXV3a2FSbGM3a3p5WE0wa3p5L3YwSEYvNU5LSEla?=
 =?utf-8?B?MGhRSXVHUGhRbDlPMUZjOUhRSUlsQzlwS3lYV3k3OHhNNTkxQWFoQUlLak01?=
 =?utf-8?B?N3lxa3U0Q29KeG1FSDZZUGVMaERINElnZW5obEJUTkhVdVNPT3RidHdVb2Nv?=
 =?utf-8?B?UnB3V09Dd3NQMTVjV2lOY0dkSndNaUVJSi8rTElhUnJQdTdxWTk1RkFSMU0w?=
 =?utf-8?B?clNwMGJzZTkvM0xuREQ4cmU3Z2dqMlJhNkxxSHRvaHhSSEx5dnFESnNtVzQy?=
 =?utf-8?B?NWI3Q1hTbDZaYjF3SG9iY29tYktQcFJHOHkvTkdBM2NtaTRSek40M3p0d3l5?=
 =?utf-8?B?TDlMZ0IraVN1MWt4Nmk1WlVNT3lIM2RWck5rYmVWSXF2bVN6c05TQWlSS20v?=
 =?utf-8?B?T3VzTFV3NFNwRDFSaG5MS3VkclpIM1dlcUFNRDRpNnp3a0c2WXpON0Nvb2h4?=
 =?utf-8?B?dUpDRlIxRzZJaHIxN2RrdzFCZmtzQUtXcE5VMTRUelhzMisybmlDRmtDWWxz?=
 =?utf-8?B?b0NBUXJpVXdXNys2ZFI4a1UrN2thVTlveHBERU4zclJtZWlmNnlpKzFpaFg2?=
 =?utf-8?B?TFhEa3pNdGFCWldESzJiT1ROdlVNU0FMYWk3WWZwbmJNSFJkWmhSQkVGMVBT?=
 =?utf-8?B?bVFNL3plSEdza2ZyOGlycGVCVGppV2d6UVU4MlEvbElQQ290UCtWbkRhamJN?=
 =?utf-8?B?clJUa2NEUzh4OXBlcTk3aXJCK1ppVzJOeVVqcERzdEV2VjZ4MnZkM3JuZXI3?=
 =?utf-8?B?cUtYZXVRdWFqVU53SnZRZmx3VndnR1JhWDNLbDEvWXg0TlZBNHFaUXZVQkEx?=
 =?utf-8?B?N1pld3N4RkdyTlNVYko1ZlYzTWovUVhTM2ttSXRta2diSGNRMmVva1V0M2FY?=
 =?utf-8?B?emJhUlZiNHFqTWl5R0ZCZ3JNVWNNb1BkRHBha1dlV2doeHNWTFVqSmVpckU3?=
 =?utf-8?B?SHl1bXdVc241aVcvbGI1ZW85eG8xQzEzbHNuekJoQ2J0ZVdOK2hrckFqSWdK?=
 =?utf-8?B?cFlOcjBZeUc3bjY2WmlWTTMxMno4aXJtZENtNEJZVUFGRjA0dmJaaWxSU0t2?=
 =?utf-8?B?b1RCSFR6TlMzRGQyaGpKNzlwVzZUK3lNRTRkOGNLYXUzL2FEZFVKbExpQ3JY?=
 =?utf-8?B?cWxnbmFvMkZPSzJZWVUyL0dWV1c0Z0Vscnh2VElDSGcrQnlaekRlalFzZzVk?=
 =?utf-8?B?SmJNVkRPcFNDNTA1S3hreDNJVUlEZmM1dXBuWHpzekMrOTYxdkN3S1hTcm1W?=
 =?utf-8?B?MWZmOE1BL3VTKzlXTDhCMExNODVHLzZsNWEzQzd5M3FRQ241ei9lYzUxcVQ5?=
 =?utf-8?B?TWZ3S3EvT0V4d1FEb1FtckQ3L2tUWVNMYll2K2VGNjBDeDUrb0Npd21mbTNw?=
 =?utf-8?B?dE5CWndsVEdwakhmSERLNzg0WGpuNFpjbDE3Rkhyc0pnd0dWdjZ0K2owdHV4?=
 =?utf-8?B?VUwrYkpsMERiLy84NU9aU3p4R0NGclMrd2VGRG1qR2R2RFQ2dzl6QlQwTmNk?=
 =?utf-8?B?WmNUU1dXczlsR2FKTW9lMWpXWXk5cmVqb2ZtTjhRY3lBVGlLTURmbTRGTXVi?=
 =?utf-8?B?TjNxeUdXZklKbzVNcm9oYncvZ2xRdytGRFFmNk90R3NkVzFaOW5NQW9OcnAr?=
 =?utf-8?B?SUQ2VVhFWmticFFRTTNFMnQ3eGJ3VmYvR2Y0SkVBYmNTdjREamQ5V0t5RndI?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e92a31ad-5432-4d27-c6a0-08de321d6aab
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:38:26.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+1ji5QFdNtbkJMUpAzHS/7OGQs2yByGU+jbceP9Zgvc6DsfEBZPa8iIDrnOQz7o7eVVJ2F6gH3aY3bggM0+MrBW0L5go50baF9xkl4IJpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6354
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 11:38:22PM +0900, Pawel Mielimonka wrote:
> This series addresses an issue in destroy-region, where
> region teardown relied on libcxl enumeration order, which is not
> guaranteed to match the increasing HPA order exposed by the kernel. 
> When a decoder window is fully populated, attempting to destroy a
> non-last region causes kernel-side validation to fail (e.g.
> set_dpa_size(..., 0) returns an error), and subsequent destroy/create
> sequences may become impossible.
> 
> The CXL specification requires that decoder programming (and the
> implicit teardown path) must preserve continuous HPA coverage and
> proceed strictly in order: decoder m before decoder m+1, with each
> covering an HPA range below the next one. Practically, this means that
> region teardown must follow HPA-descending order and must stop as soon
> as a gap in the requested suffix is encountered.
> 
> The patch introduces destroy_multiple_regions(), which collects all
> regions under a given root decoder, sorts them by HPA, and destroys
> only the suffix requested by the user (or all regions in the case of
> “all”). The implementation guarantees that only valid teardown
> sequences are attempted and prevents decoder state inconsistencies
> observed during repeated destroy/create cycles.
> 
> Enable/disable paths and all existing bus/port/decoder filtering
> remain unchanged.

Hi Pawel,

Thanks - this is much needed!

It's very valuable that now trying to destroy any region out of 
order will fail 'gracefully'.

This worked for 'all' and needs a small fixup for the decoder option.
That's noted in Patch 2 reply. I didn't test the other filtering yet
but started updating a unit test to cover these cases.

See https://github.com/pmem/ndctl/blob/main/CONTRIBUTING.md for
a few housekeeping tips on submitting to NDCTL.

-- Alison


> 
> Pawel Mielimonka (2):
>   cxl/cli: add helpers to collect and sort regions by HPA
>   cxl/cli: enforce HPA-descending teardown order for destroy-region
> 
>  cxl/region.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 3 deletions(-)
> 
> -- 
> 2.45.1.windows.1
> 
> 
