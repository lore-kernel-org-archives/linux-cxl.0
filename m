Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16B3EBF19;
	Tue,  3 Feb 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144647; cv=fail; b=t5jYv9cezqYrumIgwxPm8LfSobVlR4bPMdIEqA9DUp0gfKMZfhFqrpyXaLpcv/3MR48YXN5uCR9poHfOZ7ZT9I8sZPKlun26R7jXnjrIZYJsITITpC2KkdU2qZRCCpgZheeGvEp/o1x2aUVwTPvm6NA4h2Mt38VxLqXihmzM/OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144647; c=relaxed/simple;
	bh=awVWd6L+h1oGpeBghqlDKNU2KjLsrvalVEH4sS3MUv4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=l6965wdwfkrj1FjZQcxFEC5+16kEM3OmeNIQb4chmq8c5uugEcvi0/dLQWvZMN8k4bujlwfeEIb1Hf54ItYXJtvDtA/1qyz3lIkdDeYsYidRlzGUXDWTyqpC0v4w6Lyb9CXVF45jcP0gbDN097uQomKYYpKIzQ4HPu3qKPh1Rso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGqhqjhs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGqhqjhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770144645; x=1801680645;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=awVWd6L+h1oGpeBghqlDKNU2KjLsrvalVEH4sS3MUv4=;
  b=VGqhqjhsF2IZhd99cOGaMV//KklnwcjkWDl2RLwe2WFn41wkf5Tv+0SU
   DtO1RnUVnBe9gfXc93IeFSLyKGLK0Pn1y//88WqrUSu6lnViayxsgukow
   tukSpL3uKO570fJ5FX6gzrgDjTmZ3/IU6n11+Gy7NfPdKWjdz1xjRSa8L
   zSteKP32RitDeM7FdXF6BGacKCft5Zk2c10Kb+TY9cPv4nkBeTagCFZ+/
   HljhV40ex4W1LgP+pgGzIxms2kOiWOuflxW4Te6FUCUCqCULEZfWxt+we
   FgT8KtkxJFrTw675KNFGFwsf9fZInO1s5s0Fka2Bivp2wPKZhF7YtmChZ
   Q==;
X-CSE-ConnectionGUID: hQCOS+pXTM+72T6VE0ZvMA==
X-CSE-MsgGUID: uuDr9PbDTQimoDrtqHPOUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96780032"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="96780032"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:50:44 -0800
X-CSE-ConnectionGUID: eYXefCRHRuCTNQSfYNo6Jg==
X-CSE-MsgGUID: BoPQwUjyTFG16B7Xyng8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214471642"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:50:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 10:50:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 10:50:43 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 10:50:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8mK8sSMqVOlH2P5L2n1Zn3ShondLn+D0OA+comZe4twMyf7cKkKDB5qxAfrLabYktG1Ihfh+UJmluBcexxTsSQ17viOghpkvopiBirekar+6RuyKJlWNLcdkbehesv2b6ESKE4TEEA9zzLFTbPFQvqr/oJb2rcFaz+Y55OL5dejpGKFLP1ZQodVx4vxHMyOomTMMxfYODJ99umb2brTn0FkHHZlzfUJ+KjEpLFeDWx29gmjx3iMW+FqGojTCMAIJdinb7wobB5AL8jAnIecYtDL4AhKTx3sLqcZrqAhLiyLwpXf/JtjpJ2wbPLuYYyaKGefi74F26POmM0M0d6XJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbN97z1yVOrm+V8N0Dbu+s8AKLI/QulCQMjE7iP0zBo=;
 b=e7KzYEaCFxnv4NQo6Kwoo3/Ii4viDe5B12iiYwY2R6dD0hmYCvMP06jjikXblVJtUDLuT4tRlc3hvn9PA4zUuUrgaxRBFy7cPjw8+KJp2Om3y8FqmRMprkqakltzx8c9o0UsKJJkO1T/9T3SMiI6Tx64JaDW/tkpqX44mBxtjN0LRPyziXr6NjxRdEKhUVerALp9IFvszxCuoGPQ7i5mnl4PKz3BRcS2WraIsCMhSTpYob1iDUJoe8GcAiQNuFeTZXOCKwvMfhxLnMUQyLhrrNkwpOVu0I5wrH+JfecRcQ8rQd+dWvbG/Yo1umL8iNXe5PoJvlSRLp3z5G0KKP0TDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Tue, 3 Feb
 2026 18:50:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 18:50:34 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 10:50:32 -0800
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>,
	<linux-doc@vger.kernel.org>
Message-ID: <69824378deae0_55fa10084@dwillia2-mobl4.notmuch>
In-Reply-To: <20260203173604.1440334-3-rrichter@amd.com>
References: <20260203173604.1440334-1-rrichter@amd.com>
 <20260203173604.1440334-3-rrichter@amd.com>
Subject: Re: [PATCH v5 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF8225D2149:EE_
X-MS-Office365-Filtering-Correlation-Id: c59fccc2-2b52-4bce-7a72-08de63551d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXloSGY5TkhlblFmMUVpWXQ3Tnp2ZDBYclgvaVFUb0hqTmViMTZyd0kyTHMy?=
 =?utf-8?B?UDhpM2ZsL0J2VDZsMUdPWTNSNzg2N1lGSlUvZUZQNUg3RUNaM0FxU0JzbkZU?=
 =?utf-8?B?VlBlVXZrQTlnNGNzSXdQc1VGSEcwSUJCVFphamZNZmJzaFI4Q2VCaHhPZGgr?=
 =?utf-8?B?OWMxdFRybWJTVmlsMmNiWVVCTGpha2d1MlZGZklydEFXWHhMTWZhMFRVRk1v?=
 =?utf-8?B?RFJFTzZwVTJJREt3eUo0eExnMGxrRU90UUJybnltdE80RS9Qc1NFenhOVkVr?=
 =?utf-8?B?a1FpTkluZmJTQkNFRUQ4dEkzQnJlbkY4TnBPTHBjL2xyYW1PRnF3aW5GaGVQ?=
 =?utf-8?B?cUl3Vk82SGN2cHhkWWJRR1hEM2M2eGxLdzVsSFNFcTB6bFdDZXlRWFdLUTVs?=
 =?utf-8?B?OVplamlGWHBuR3RzcEZVM2VYbzhodUl2S3hlTFR5K1A4MFJjLzMyMHIya3JK?=
 =?utf-8?B?OHVoZFMvamQvMXpCZ04veEVtaHN4ZEN6NTFRdTh0UCs3Q0laS3BTTHJuN1VC?=
 =?utf-8?B?b2xxY1g0cVIzWERVZXpSYVdsQ0hSZDlsTWQ5LzQxMXdPbTBPMTVtb28rQTBz?=
 =?utf-8?B?elg3QjVER0N0SjJqQ3VIdnN0UjdsNHZRQURUKzJ0WWZaeDY2bGhVWUdzU3hp?=
 =?utf-8?B?UkZoKzhTQ2s0bEFaQVdNWDA2K2VuNGVPN0tMR1RqRUNkSUVvTkJ6Y0R0eFpi?=
 =?utf-8?B?Mnp3U1hGa3JSMXhzTytkZlVMTFcxelVQTzJ2ZFVJM09Bdk5lbDdMbWJlUHFS?=
 =?utf-8?B?Wlk5aHBYSEd2UjM3NWJBNzRJNFlCcFRvblZMNnpveGR4MUFqbGlJcDc5MUZa?=
 =?utf-8?B?TzFESlNoLzgrekU4azIxY0FOczJNN04vbjBvbXp3MXVRdkhPRUVaVTArUG1n?=
 =?utf-8?B?d29MTGxVNmlXeFNhbGpWczk0cE9tcUEyM0RhajR0b3F0cFFaQ2Q1cmVEcVRB?=
 =?utf-8?B?dlk4U2lVcUZPWkFDZnVzZDFscGxZRW04R2NwV1QrS01sazdLVmpvaFVZUnFB?=
 =?utf-8?B?dStzVkpaZWpSa3RESTRoVm1PdjBSeFVTSzlxWDM4akpXbWw0MlhpNFFJVDdV?=
 =?utf-8?B?c0xlNlg5VmJYbWFhY2dYcXRad1BaR1RFNUpVZGE5RDZyVU4wMkVFdEM0WXRE?=
 =?utf-8?B?b2dWTSthcFZnR1A4MGJlOFd6SjNwVDgyMmd3RERBY1RNdzZ4U3J6RUc5QVpS?=
 =?utf-8?B?ODlWR25ydVIvTGFmRW8ySHFFSDk1Sm5oVEVzSFBDUkpOZEwvMVdibE5vakhn?=
 =?utf-8?B?VVhXU0I0N3p6Zzl4TmdaNithVVQzRGR3U3JTZ0NWWmhpdjFCZ3oza0FIanBr?=
 =?utf-8?B?NVJyVXJQb0F5MXVFZWtlQ0hWaUJraVBSWHZFQkQ0U214SGF2KzBQdUlwbGYv?=
 =?utf-8?B?ZkU3d2tRSENEVVFOQ0JsZWlYMnM4cDZvZ2JFMDRRR0l6RitCM3orWGlqYXBW?=
 =?utf-8?B?bXMzVHZFVU1TOVR4K3JKaW54OVhOSmgxMEt1ZVB2VWNoWGpDc240RWxGL3Yz?=
 =?utf-8?B?ZGVLRkVoUFRQNnU0LzJxakdWMWRoQjhlYUFDWUtyM0FuRjd1MWN3YldoOHhv?=
 =?utf-8?B?eG00bjUxdW9hY1RISWtrNERpTTNFaTBzUndVdUhpYytTeG9tS28rS2R2UWpu?=
 =?utf-8?B?MGlKaDczajkvWjJ3S2xlWi85ZmJrSG9zL0JRQSthQklOU1V1ZVhncm5HdEtI?=
 =?utf-8?B?eDdOdzhyK3pMWFRZMjRjTUdkT003UjNlVjExdUJMK3VEd1RUK2FnODJtenNW?=
 =?utf-8?B?ckVEelJOYjZIWHgzSFJVOHlOdW9qa0RPK210cmhHZ1ZlZUFMeVpoUEpjSmJP?=
 =?utf-8?B?NTZzenJCSndzVWNrVHJJNHROR1JuNi91MVdtNWliVDFQVnB3Q2pkV2JkcGh1?=
 =?utf-8?B?b0U0VmVKdGxPWjlod05QbmxWdGhRREFZa1JlNjlqWE92elNFRzUyWUNwcmNw?=
 =?utf-8?B?QkxLTlZKeS9OQWdKdjJldmxjSzJFdTROUzdkcFBjRFdEbis0WHljQnpuNTM3?=
 =?utf-8?B?WWJDL0lpZEZIaDgxOUxZK2JTbjY1R2ZGV0JzTGNGZVF0NG9ZUHBTbGo4Sitl?=
 =?utf-8?B?cWlOSlM4TDdySHFmR2xtRWNBMk9adGM0VHJFcXdBaVQ3blI1L2RQWlNzMy94?=
 =?utf-8?Q?YzjiOecmrTURjrMaAVuUmRU/l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVQ2dThGcUhaeExwUmdDdHdIQWJ2aDRmZEJETStyUWQ3dlRnTW9WYjdXUVB6?=
 =?utf-8?B?d3ZPTUtkcWJjVXZldGJ2b3A1VytqUENOeXdZWmFVcUZycHdZWHpNWGF5bVFu?=
 =?utf-8?B?UGl3U25Kb01IWFdVRVVDMXlvMTVwdmxJRTJVZE9abmJxZm4zbm9OZFQyMXJZ?=
 =?utf-8?B?ekZua2E2QmlDUUl5ZWNOb0E0Y3NTcGZqcS9ZZE0zeDk5bGxycTRDemRXNStQ?=
 =?utf-8?B?Q2lGL3hoUnZRMnU5ZGdhdGRieE1KeER1aU5WUk0vM3czdTIxamo4MHNJTG1r?=
 =?utf-8?B?NXVmZ3g1Y0o1dUNOZUlHYU9SRldvNkY1cGp6TGo4d0dWdmZHbUovTVR0UGFJ?=
 =?utf-8?B?K2J2d1htY3dIbnQrRkhiTHgwSjR4WmhUZHd6ZGpPNitVTnp3OGpzeEdFaitM?=
 =?utf-8?B?bEtlZTRyNzg1V3V2SXdzNktkaUhac1h5YWs4M2Rta2ViTHpPZ1Fxa0YwY253?=
 =?utf-8?B?bGM5ODRGUWhwVDhZN2lCYURpVFBhN2xXTmRjUVl2VHV5K1YvYWc4RHJNTzZj?=
 =?utf-8?B?NGZSWEc1SXRpcEM5ZmFOMDlGa1ZtNGkwcXNtQTByNkU5TjE1NEkyZHJNUXdu?=
 =?utf-8?B?cVRaWHBMeTZaRDRvTVIvNFZReDN3Ri9wUlNwbHFRUHpPVTl4d3lQcTJSV3Zt?=
 =?utf-8?B?SFRkSkNsSVR4bjlEYzZsWTNDNVZYWXVLekJDMmRFNUZHS1BOMnltdE9PeXNF?=
 =?utf-8?B?Sll5N1dQMUgyZXJQWlJWTTNjSmgxaXAra2I3d0xTcEppakY0NkNHdHJweTlm?=
 =?utf-8?B?dnZoRDNMTlJOODhVaVN6U254a0o3SmU5SExhVkN2UnBZclN3d3o0OGNXdW43?=
 =?utf-8?B?L1FjL3ArZjdZT2tDNFpSWkpZM29iemJoYUxLL2xmZzM4Wkd6S1RSb2MyNVRa?=
 =?utf-8?B?YXRuYmJrMUtCbnZOdDhCV3ZTeE42cnJWWERwU1Fvb1JwUEJNTnBrYVdBRGRI?=
 =?utf-8?B?aHVoc2NIU1NDRXFDdys0N08vemZiQXRYLzlwdDZuZmdzSGpSZUxiM0RGd21Y?=
 =?utf-8?B?RmR1Y093TzZINURob2IrUTIzaGZMNmdsb3MxcFJuNkhhQkM1dDNJcjFEWVFR?=
 =?utf-8?B?d1VURUdFd0Y2cFY1L0pWSkRuTE80YXFNQ1c2UytRL3VRRzY2NFNQZmtRWmpz?=
 =?utf-8?B?NjNTVG54V1I4aGlkNjdDWnBZSjdkUGcrUEVkaGVKQURqaEhVRlhxZ0MyUDhW?=
 =?utf-8?B?NlBySklUejRTSDNDOStNbW40dTJ6OXlaY01xKzYrRU1LZlcrY1oxWTBxUTlY?=
 =?utf-8?B?d2hMNDJ4Z3dRREZ1K1hkYkE1VCtmN2pFWGhGTmUwK3dhZHlhcDRjVVFFUUJs?=
 =?utf-8?B?ZURlYUluaGtZMzhDbVYvMTlBdVBHNVViY3hDdG1wZWNMUmRLcU1IYVc2bHlX?=
 =?utf-8?B?NlgzUWZ0Q1h6Rnlyd3ZXZ1RSeC9KSjZtcXRVQSsvSEg5c1ZpWVRpTHJMMGJZ?=
 =?utf-8?B?bWtTRzkvQUNYdkN1OWhiVEI2R3QrOUNLQ0JsZmNVc3lJNDBCQlR6ZGk5cVZ6?=
 =?utf-8?B?UnBucHVXUnN0dUdnbTRIL3NoTEVGNTBlMzNBZDhFcFVTR0ZNWVhyQ0RYSjRO?=
 =?utf-8?B?K1I3TU0yWjRCclYxUjNESXo2anZuVGJjOVJiQ2dkdE9lSFl4cElHdS9wbjU3?=
 =?utf-8?B?bVF0Z2lXbExLbzJVRjllVVhHeEZ2ZlYzYzZlVlhtUk43RnlEZXYrZkxoU3Mv?=
 =?utf-8?B?WEczUlNxOFRaTkxzNFIzWmU2M21OVGVOaGpvN0ZjSy9icWdTU3EydXBGczJG?=
 =?utf-8?B?M2IzZlNZcmpyTDMvZjZ1NHE4T3h3Vk5GYU5McndRYnBaMnczdWhCbzFkcitk?=
 =?utf-8?B?ck1ZV3RaMWNKQWYvRzVhZnZSbXNmQ2xqSXJFUUlyTFhGWXZObmErQzI0cXhN?=
 =?utf-8?B?SXhnMnNkcFBuM3ovWnRTSXhOclJCVXJuNHcya1p1eDQ5U09tOUgxYVl1WlVT?=
 =?utf-8?B?dlBXdDhnMzZvZ21MaSttYmNKNm9FeXBCeWdROSsvaWpSK3FlUEJQUXlSd3hr?=
 =?utf-8?B?LytCZHZqTVltUGRTMk1oQjFsS1hYdmxzNUZvcmhaajhKK0RxMGwxTjVURHQv?=
 =?utf-8?B?TU1zWmhTUTBZNGtVSWxSRE5sQ3pNU3h3WE5pZ1dZNktWOGpUZ3BlQmlmeUdy?=
 =?utf-8?B?L3hNZ240bXFmeXdDcVpPMWhyZ0NFRzBpQUU3ZEZkRzd1ZGlUY0d6VUtYeTN5?=
 =?utf-8?B?S3JqQ2d5SGI2ZUpSWlN3MVNlSUlwc3kyU2FqcFlhOGFSSDVpaTdXeVVZTFB5?=
 =?utf-8?B?bWRGN3F3WkpyU2hDSlRreWJiWmhKNmZpblArR2ttL09zRUIzU1BNWEE3bm15?=
 =?utf-8?B?MVZ5dS9wZmUzNEd5bXZtcXBYQ295WW5Bc3Z4U0RJazNxeFpuOVJTeko3cURG?=
 =?utf-8?Q?Tsxf1i3v4e8ZoC7U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c59fccc2-2b52-4bce-7a72-08de63551d16
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:50:34.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/esGKVfngp1hGPlVCB1ki+4kaEkDE76z3iTPUGMlxEXnbdpupH4BPN6I7jKyBRyZdSi2qAVMR+o27iGd1bSD++nGFwgYA7junYZWSHQbZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
X-OriginatorOrg: intel.com

Robert Richter wrote:
> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> 
> Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Can drop this ack, now that the Reviewed-by is there.

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v5:
[..]
>  * made PRM handler mandatory including the GUID handler id to be used,

Looks good. Going forward let us not reach for PRM ever again if it can
be avoided with native driver enabling with some static platform data
tables.
