Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E931B101;
	Tue, 10 Mar 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174825; cv=fail; b=nzFN8ITPkDeD1ZTRf4iCdRQC3kxS4pATa6L7m5LpVD86nUbNsnvclgpW83c6SzCRx138sAhAR9ZQpzY5/WWGdoo2PkaUouyptI72pE8ZUy6RrevE0er1PxCeGFgDHQDD4CchpVBOX8miJnTm9n1R7bmliJXGoJhJ9RyYeODLcPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174825; c=relaxed/simple;
	bh=3AFa83dVrZMlJWD0X8nbOY0eQX+BDkI4Z4BR+IPZgYc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Vo5HX/1nZD8VlLm3lg5F/k0/n5NPu9Vpzg0VIMN56GfPqst9NtwJBUnDHdEsxPm5iQ7blPYRCdpyWsgyyJxoj/ODtrUIYXKII6awZ78W0JNPjLpl30cVk8Oo+Un69eWpLfjmA3XkvLD6ET9EQQwLnlpu1ZDubzdbAGdx7zyLTTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lc2BT/Ex; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lc2BT/Ex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773174822; x=1804710822;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3AFa83dVrZMlJWD0X8nbOY0eQX+BDkI4Z4BR+IPZgYc=;
  b=lc2BT/Ex1rghXKh70ez3UQ0fw83LMIS46X1KT7nWunE4GgZbK+EomLSV
   uximP3h3eJofs69d5YSCGOvF3dhR2zp7RYQpd1BW068eVCGwRvYyIo0nt
   lyzuco4ROfz4gcw8fbGBCJ+VS7UhNjbqPVGyJFaDe+biqcCLh3Eb39hFF
   1zySpS59CrVpyX4Cgh71KoyNtzV8zkhF4/zmpjMuId8co4vF3LuLJF/Dq
   CQn+F8Il82MPeYUI8GCnaHOOltr04Cef3+1ObVBXfqzBoKUUHIWyGWcqw
   zmaa6paKHbzKJNMkkfLVS4KEgQmspy7fnHhy00pbgMmWeaLixyKnSw3Xj
   Q==;
X-CSE-ConnectionGUID: GK8FfkAGSdyIeSzIGLChpg==
X-CSE-MsgGUID: mM8pYEZjTgSzOzDV5ajg0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73257730"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73257730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:33:40 -0700
X-CSE-ConnectionGUID: ftwB5sSqTDyZCeAe09QxeA==
X-CSE-MsgGUID: F4EKdEz6RjawWuuNIiObqA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:33:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 13:33:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 13:33:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 13:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2qjWcmztfpxYRWeB3KCNiVTSwn5aD5Na/qliX3Gs6sVzqySgIQe+lW1pNnshqVWaPAQTy+jEZNM4flLnW24vPGPSssGfV3Iw7BiCkIoCFIXjTs9+iAEPjRWNEPbQjz0yi708YTXkum2qgrpZox/Nu9zt9i9LC4WGdZeFyMx2rXYqrHkPwExxURI7GiitjJ9roC96PRtN39T7x3oYrW90YybLYRcAGTuteoWGe59ZGjOg09jGZy8ZzFZlJJR+/W7eID02fpyZVXVo0RhX+Jllri5Aq99rWGaZHjxnt6r4oWZBlE019a6DbjlIveai3trpuJELdev35VKGKEpDiR/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL1kcHJItgv+cUktqy936fA3ka6Goe29AC0f4VZUn5k=;
 b=gjr5McFpbnE8Xwezi4Q58x8k70tVqh016+Q8gnEvzjT+6Vqt3Inqv299cr8OKEe+1tQibGDFZnZh1EOW1Z2qm5HR2AekhtEdorO9RC5/arm3jLBILovcyRo4hMWYmmKw0fNIty8XRD5r+M4LqT/opPgCrBXVaF12AmqCHBCK4QOlzb4j3K35s3oUIBiRuXS9hrQj1YM0X8KWn8Lct57E83x+DiVnUD1kf1djbn11rCIFuXCRGybpJOyPN7bu+08Caitp6sECzyLXypYOgoy2JSnfb0n5t+Bsaxa0C1T/Mv12XFEy8fueMF5tjajeVHX7gBdJYGGBSIVvFyJHOoHWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 20:33:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 20:33:38 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 13:33:37 -0700
To: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Message-ID: <69b08021288c7_490a1004d@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
Subject: Re: [PATCH 0/7] cxl: Consolidate cxlmd->endpoint accessing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddcb2dc-e9ca-484f-eab9-08de7ee44f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8EBZHlK1gGhf8pXPFC5kJRJyeizqdIbIA9N/NpMLwGffDlywJl2WPXtgQk39sh5kQwSlS1GlQRQZeyDEmBZX9Vlk9Sqecil6aNRWI0AtQyVAbv2ejmHzEGWXbGpZXCHYKaGR8MocdV6tEro1LtJsvhtjdzgMRU+/s96hHcvDrxgwnVqc/oX5QybtKaZnZ3iIL8j6AgTUOIUbIrcUkpNAm51xylCnB8sG138ABFGUtqWVl6iBInCf7DpyD8msT50EDtnkMk45drj3hPvisfeAcQ3Bk/eso+VZ5EfBPLM/8iSAuyZGFht9fgmG1w5Gnk9/MeNIQT75/iP3d7YHe2jQ2GYRA2aDkhD9sxkaqjIqlzEXY/+uwrMPr3uaOvZlHL+oebMF5CKisXxMEfAphFXV31pKduCKAmcq5n70QVNh777UzsZGzTDQkPMf5Q3V3B1PWmuXJe5jPbJRB5wbosogX83ClowBF3YIHWpdnYKzH9z5+v0grsB93WFo9prv2OTWNWTcyJwKjkenJdElR9zJmMdQ+NAE2MhMfncLAuMwW4t0Fw5U/AzPIkepFRTWUZmzICbUcckhL5efBUMp9De2bntZrlP9s+J+Q/KeP8gEKq0rtVLRJTzLS2caF4IRiI2kVSaajsEYqWH56+MpCttkzOoHEPQINmKyb011UZ8ZHYfuegwbcNelfbEQfTM57bdCCDQQ+16IgLX6VuDQojg6vOn8YCzKuQyg3HlKKL+2XBhb5nGS3nHZCw4KtjIViIr3Kjvw0RdkChtOtflCAnO92w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1pHSDlHT2Zlb3lDRDlMOUp0bFp0S0ZsOG5LcTVkTmVvQzZlM0Rta1FZdGIy?=
 =?utf-8?B?Mkk0bUNFeUlkamhOZGFHOVVrTlVjQlM3T0RvQ2xhL05VS0lxVVdtSGNFWVJh?=
 =?utf-8?B?Y1ovSy82STI0cUF0ZHRMWGF1N2NYbXNTeUtKcDNFRTg5TUY1emxxNlBHK1I5?=
 =?utf-8?B?VkZ6ZnczU1VHWER6UEVNc09FeCtVV2V6MVgzMjRRWmpzdU9JKzVLQTlnWXNC?=
 =?utf-8?B?Z2RQOXNuZGV4OHo1cEcySnp4SVNzcWJmcFhadjhlT3RlbFRWeUFYbzN4UHpK?=
 =?utf-8?B?eGhoeFU3YmVVRGdkNVM5OFMzRkNtQyt5Wm02VzZQQzNicVJ2YWM1VUxpRVV6?=
 =?utf-8?B?NlNSUVcwWUptYXRza1h3RUF5SVZWVE9TY1pnNllkN21FMXh4a2wvUVgzWG9S?=
 =?utf-8?B?TVBPdGw0amF5STQ2TE9HMnR0Z0pYZERrdThCTkhLNjV2SGMwd0doMDBqMzM4?=
 =?utf-8?B?Q3JtamwzWGZaMGY2UkhmaldHejkyYzRaRjNjeWYzNk5BUjgyaS9ZZWNGOUJN?=
 =?utf-8?B?OGRDejN3UjdqY3YvWFI5b1lmWTUxUCt4cXE5eEc5NWtLRm95TkV0SnA5WjJK?=
 =?utf-8?B?WjJ2ekhhVjJMNy9hVDlaZXAvanVOaG1yajlTTUJGalIxZVpjeGVBVXVybTIz?=
 =?utf-8?B?bXE3SnUrZnhoK2dSSjNPZnNjK0JWQUxTRlR2N1U2bnFCNFR6WHFMUnhrQUxV?=
 =?utf-8?B?OGdvZlhJZzluOUIxdDFZb1E1eDRPK1NvajRoU1kxZDl0empSY2QyWklFS1J4?=
 =?utf-8?B?QnBVUng0NXVYM1VEOERvVWNSVk5BdWpYdkRvbzVLRzNyRnBtYndEL0hPaUtD?=
 =?utf-8?B?YSs4dmpIek9XTk1jYm1BRGk4Z1BvT0FkNnNyR0dXRWRZOTh5eUx5OHVhTEda?=
 =?utf-8?B?cGpraVZ2TTFLRDA0VHpFY2dTSGs3MVF2bmZLUGNGQk5YNVZhTk5Qdmd3UTJ4?=
 =?utf-8?B?TFVaL1EySm5md1JBUVpiN2hUaWRDcXhSakNlajRTN2wrU25VME5mcXgvbURZ?=
 =?utf-8?B?aFE5b1hFaUxwWWExQ1NhWTk2M2Yvekpoa0NqWXI1cDM0MHJ1ZWxhT0dZZ3Zh?=
 =?utf-8?B?M1QwNnJFR3NkLzVsUlpjeHYyWEJqbXFRamRZUW9adzZwSEhxQWxRZXlQYTQ4?=
 =?utf-8?B?SGptcjZqdnNDRkRVSFFkV09qS3dyL2trTitQNnVyaWdnc3hTQ0xMdUlmRWdP?=
 =?utf-8?B?TXpTRnYrYnJaUXFjb2h3cnRkVXZ4RkhLSFV1N2lJaFJjZXY2VUNUM1crR2Z2?=
 =?utf-8?B?L2llalowaE13dnJQSlViZU03Sm1QeHpoZzRzdFZlOHh0SWgrNUtNR2krQ0lt?=
 =?utf-8?B?ZkE0WjZHWlNobHhjODV0Y1luR1pvNnRRcmkxMFFPaGh5YWM4RjZ0VHQ1V0dV?=
 =?utf-8?B?L1RmMmc4a1E0aXJqM2Z6K25MY2x4b28yNFdFcXEzWFJzN1FEM2p2em90S2NL?=
 =?utf-8?B?T3puekl2UW1STDNzNUZrOEgyUU5PQUpEbTNUcURsV0tTcVpmR2NFNTZ3UnpR?=
 =?utf-8?B?MTE3cGtyaytyeXNUQ1Q1RUNWS3AweGkxNUFXSkpoMjZKdUNJNFd1U0RlbWNZ?=
 =?utf-8?B?cVZUSVYzR3lyYTZhbC9mUGYxUGZQYjZYRkhodVpVaDVLT3R6UGNQZEVWUjZ1?=
 =?utf-8?B?OXRkS1lqS0tTRzlKQjJYSTlpcTRHT1ZXYkZReG56MVorczB0emRrYmQyYmlt?=
 =?utf-8?B?c0ZYbzQ2VkJzZHJiV3FHdTJ0R2JTV0xkNEs1M3VvSnA0aXBVendHaE13SjF0?=
 =?utf-8?B?QUU0Q3VCM1lPcFlZZTU2V2FUMjNHOHNpN1lqREg1OGNCT0R4eVJzZHhMQktJ?=
 =?utf-8?B?UzRiaWVxejN6WW4xSEZKMmhYL0N4TjNLVmlSQ0VObFhHUEhmS3BwTGpHV2RV?=
 =?utf-8?B?RWJlbHNROWJTVUNOOFk1TG9nakRxa2lrUkxxNjJ4R1hJOC9NWkhZRi9ERWR5?=
 =?utf-8?B?dUJkb1lTUnk4bjdqdkV3ejJZZXJKeUlOOEpXTnB4bVF3aEVabDVGUW1ubDBC?=
 =?utf-8?B?S2V1djVMb09DUmdpb2pOT3VJQlpGVTJKUFZ1cE9XY0pQQUVGVG9GS1l4NGJC?=
 =?utf-8?B?aEVrUm1PajQ5bStiQ0swRUNESUZPaCtyaW93cHFhOWc4Sk0xTmU1MXhjNHpK?=
 =?utf-8?B?YTFIZU9qUTcrMEVGVTJnN0tYNnQyS1RHRFhaLzc3RVBVYWxxa2tIK1lzUHBU?=
 =?utf-8?B?M0N1ZGw2Qk1NMnJlSkpQRHl3UGpqKzlKMXJOWnBHcWRtSnl3aDhDYjRBZkJ2?=
 =?utf-8?B?Tjd3U1lvMW92OXBxTTZMc3VPTHVhUmc2R3p6WEZVN2c3M1FkcFJtQnFQM05C?=
 =?utf-8?B?UGFKYmVIWk5MVkhxWko5QWZBZzVOVXM5NEM0dWgvRTJ1STlEV0VYMndZajBr?=
 =?utf-8?Q?y13SWeARsHtY5EV4=3D?=
X-Exchange-RoutingPolicyChecked: EDMvUpO+gA3t6qQApBcY8j7ZF1tK3hlDLZy0ERKOS8Mc68j3L/Zmz47BMr2M4pdiiBuZVLCae64KI659yDzTmadyKCBawPdnHaBCcpNjYMk0bSS3xWBbq1jmBj+jcpHOoGq/BKRl8N8xoMxTE7Mm+/Vp5PHIH5Ix2rVi7sBQWhoz12hzde4SC4lR0Gh41jqljrLnQcGwe/ZP7Y97ipM7fQbdd8xs1VYM+QJmab29CLhYC1rBkDIx1Y9QhwF/ZRZ6XX8Dmd+F+B3Y4BzPujoRoGGBrjhutk6vtsaqmMJcW3iSHspDY+mcKZh6nsKkO7fqYhS6g0bOCoYgXiZCv5cE9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddcb2dc-e9ca-484f-eab9-08de7ee44f37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 20:33:38.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th0xFhmARyyf++bA6MGcjtf/FZ6cfWYGt8fSashnjuvImBDcyZW8G8izdAmKOnOluseFbAHO+crps+NOIEinHGMCzNso9SkOq4nBgO7RbCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

Li Ming wrote:
> Currently, CXL subsystem implementation has some functions that may
> access CXL memdev's endpoint before the endpoint initialization
> completed or without checking the CXL memdev endpoint validity. 
> This patchset fixes three scenarios as above description.
> 
> 1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
>    endpoint.
>    there are two scenarios that can trigger this issue:
>    a. memdev poison injection/clearing debugfs interfaces:
>       devm_cxl_add_endpoint() is used to register CXL memdev endpoint
>       and update cxlmd->endpoint from -ENXIO to the endpoint structure.
>       memdev poison injection/clearing debugfs interfaces are registered
>       before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
>       There is a small window where user can use the debugfs interfaces
>       to access an invalid endpoint.

This is the justification I wanted to see in the changelog of the
patches themselves. That is a reasonable theoretical window.

>    b. cxl_event_config() in the end of cxl_pci_probe():
>       cxl_event_config() invokes cxl_mem_get_event_record() to get
>       remain event logs from CXL device during cxl_pci_probe(). If CXL
>       memdev probing failed before that, it is also possible to access
>       an invalid endpoint.

Makes sense, please put this in the changelog.

>    To fix these two cases, cxl_dpa_to_region() requires callers holding
>    CXL memdev lock to access it and check if CXL memdev driver bingding
>    status. Holding CXL memdev lock ensures that CXL memdev probing has
>    completed, and if CXL memdev driver is bound, it will mean
>    cxlmd->endpoint is valid. (PATCH #1-#5)
> 
> 2. cxl_reset_done() callback in cxl_pci module.
>    cxl_reset_done() callback also accesses cxlmd->endpoint without any
>    checking. If CXL memdev probing fails, then cxl_reset_done() is
>    called by PCI subsystem, it will access an invalid endpoint. The
>    solution is adding a CXL memdev driver binding status inside
>    cxl_reset_done(). (PATCH #6)

Makes sense. I jumped into the patches first since I was familiar with
the problem space, but happy to see you did this analysis. Just
cover-letter analysis can typically get lost in teh shuffle.
