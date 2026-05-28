Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AF2EFDA4;
	Thu, 28 May 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934113; cv=fail; b=g3+Ni8DEg4XMEBSJY67A6+GenYVOMSdA8Z0IeElkthPsL3tsLiz1L5XeLkTe52fNu2jklqYiqj0ZuzyzUGH20+LbicSnipl4tQEtK8syHdbhk8gN9ZG6MJblW38XmL8keKMX18M7RNZdipL1RfzMgvFz/db+YlLRriBxXr0yBbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934113; c=relaxed/simple;
	bh=zNloRiIeRu3GIlu90uSXzViGqqqC1bJS2+W6yJ4JPJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cs264ObLrSUyUxF1F5juUXxyxgGOIiTJQ0PFYbRvXDugsLtjhM556QGS02xs7nZ1fLuEU4L9oz4ncStAy9RKGyYYB8zXuE41uiuu0WobzTuMhDdYhkxTCRjLC7x8GjVIx3LvjJpQMPy41/23bhubueJe8HFcTA/dqPgh99uzsqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JydDCPZw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JydDCPZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779934111; x=1811470111;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zNloRiIeRu3GIlu90uSXzViGqqqC1bJS2+W6yJ4JPJ4=;
  b=JydDCPZwOaL/iXKjK8ZGe8odcSiqNCMv6pE5zzeM6+fK0yftICGKyP66
   ku4ukH5c8GLRZeUcdk8K7WiLDUkhdUDRhnQ8P+es84wudi3HixHbojsWy
   ffGcqrBZ1ndm9n7nI+1+UA22KpdJJXejQHbXj4DVv/GJIxDpXJcLsJr58
   6HqS0hmfxFhhpbPWETAwyNm8OK4Q/mReTdvWMQUwZFWI+BnpparG1Lx7h
   pSDZq7JXlb/wKQCPQThGanpU94lUvnCbUmrhgPXrOZnn66HY6FenF1/4O
   swFdmwcia27b04MfsNTFedCg79EV7BnfDsCU27HQNEgHXbwKG4sZ2u/Fe
   A==;
X-CSE-ConnectionGUID: UPq2VJ6AQz+bTEHDbcJJxQ==
X-CSE-MsgGUID: W7+RCjLJSNimrIOqReVwTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91347430"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="91347430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 19:08:30 -0700
X-CSE-ConnectionGUID: 1wyZ4wogTTuFoovmgk3yjg==
X-CSE-MsgGUID: tjRjmESDSjCs1e0HVaP+Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="280528993"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 19:08:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 19:08:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 19:08:29 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 19:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwx39/YC3SdaVWoi4jU2K8PW4FlEhQIWSSDtg4qkmHP30B4Y5cOxahT7849mQCuOHqBkpTr3OoUBCbMCGboPw45hegEymR4CjSSKrMmfFDAJugtB/+8njyhRZSgyryAmXZ5jKHwAWLOhzkdrtTNRAVyFT0uAqxy+VBUSHaAd/adbmpudDuyDgYepo12GaZSdu3Pp35erj8I2FPt9Quy9q6YLMgXLcAZ1sps5uCSPOC2/Cq0xWP3ZpF8LTmpDc8uINjyJ6oQ0ajKHwRiAj7VozqHFKoLSm22lICb1y2B+ZOBm0Pv5Ih7XthQ+0G50f5vi5eRlY0u+Q+iGIWaQq91qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqtYoxRKM1VopTf3x+Opl0tA6cdBgthUluwyCHTfKcQ=;
 b=Uy4NyaMjZNT3FtRRS1PiwbqTZZxGVR1bFmrJ7hgaZa6tyxc3VtrUUXTL3zjCnMtE5ePCOKx6+vnIJuwPtBZC0VrJPfwFsUntmNCVHnWQm4Il5RtbcOKM3Z7N1VRx/JOh8lISq+uKt/0Egck63FCK+vMIHksYAX5Jx9+4ojvQWOArrnsEL5W2MnhEtEtaUEveDFGAEZ3VXY4QlU7Gxwns8NxTGKfUBHgbLXVc+aZA5AwkNgm0HsteuYUuNM94nR/ytpAnZ62mw2DoipXsnoyTmdwz2idzXCl4ZfKGxxC1BEsc4L4DkFuJtzei2/7RfRcUiRnjUp/C4ppGYFaboOrvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8671.namprd11.prod.outlook.com (2603:10b6:0:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 02:08:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 02:08:25 +0000
Date: Wed, 27 May 2026 19:08:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
Message-ID: <ahejkhm9QI4t3dzn@aschofie-mobl2.lan>
References: <20260524095620.636535-1-ming.li@zohomail.com>
 <ahYnR1hMdweV5o3U@aschofie-mobl2.lan>
 <1f7d91e1-94e0-41cd-b1bc-72d8905358fd@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f7d91e1-94e0-41cd-b1bc-72d8905358fd@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 42888859-b58b-4d69-7b5a-08debc5e0079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aQnNLHNj9uBievjcl6mSI5HiveL1UjS+rNV0ziOhIPCY2mposUaQN2YxtkKDSwVJKuuBn+a92o8uKKK8dg7JRSO+juR2BXboPIgx7wjAmwos0CE7VGHUKjV0/FU/mc5nnSyou9dxoIFhqpKxxInRU7BNXJHRJxIeao1Z0zh937EB2E0ydmeWNSEJsBFQUbEKhO1BfYNDiWlpiMvyaamOZQOVXnDyAWSCU87e5ge35Vk6AuAjil6YGOazPAL+GyY53+dkzVJa77vwEeZlEcuL7LwpVJoHLnSSZuajZXEzWLTL+bBvJnNYwmuO8X07m+WiromyepO0pgPvLlGmkemKkZU8t2ttHYTsqRCKtoClTvTwqC8CdAp1cBSyvSxT7xGyp1iDPxVPspVwlOjuQ14TaMsC16lgRpraYwkkzEtWIHX8Jz3BGzk00HghCIbUe25DnnAhchMLsU7auJw3shDikNY/rpB4Dlt529/H2aguC8VHp3G2JddHAuSdE9WYNYvc8xVbQ1IAVCdbyvXcPlENR+yED3MAcsPllhSFCJLE21yJUp5CVGPcbl0q3ecI+nb3NxkVvX+RX6ihFDCOi2o2J+g36OjbBR10LZG/Ot8TGeuQHnA+ugUYwk1vmchXJ11NuK6WTLd47FHTwqBXSz64ICvrE7MQvVRwilkuD2dvxl6leCVsFY67MkQTXtqvQOgL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3l0dmV5UnUxQnloYXQ5aFVEM3FuVStLQzE2ckpGYWRISGI0cG5mejlRM3JI?=
 =?utf-8?B?bmlGVDI5d0F5T3k0V2lGTVRFSTBBTTlNdHBCZkd0RkNJU3VmSVZSVUJtbWZ0?=
 =?utf-8?B?UGlmTldLd0NCeVpKSkZFdmY5Y0tITnEybTN4SmRGYUxKYk5yRkhkaXpYN29P?=
 =?utf-8?B?bDBWWFZGdnFDa3Myb2EwdzIzdzVLQXR3clU1VXo4alNVSGdlNlZsYXF2WlJM?=
 =?utf-8?B?THFKL29HMU5LOVhsQ3cxTGs5Ym5ZUHBSMmVWWDdLcjkzT1VZcmNkR2h6ZWJL?=
 =?utf-8?B?UyswUjJQZ0x6S0M0Vi8veDBEcGFPeXoxa1RhM2RWUGoyRTRraHZRc2lXb2Mx?=
 =?utf-8?B?VHlHRm5DNDMyTFREVmNHZHlKQjFXY094elBYN0F2UE94N2x4TGErbHZhc0R5?=
 =?utf-8?B?SjUzay90dVcvQkNZM0YxNmFoVGp1b2lJWlI2ZDNSOG1zdXdSMCtqbzZFejFm?=
 =?utf-8?B?YXRFOXFwMDF4b1BDZXVmaVFyMHp5TmxMa0pSRTlGVFV5alZTYVN6MGg0M3FV?=
 =?utf-8?B?b1pKbm1MMlVhNGZob1RyaTNkUldBaWxUZ3BSamUxbFhzZEphUUR0OWpKNlB1?=
 =?utf-8?B?bit1d21mbmR0MzRLa2tuYW5UN3hoTzJhZWZEb2JDdWo1WHowWkMxTzRMNzBR?=
 =?utf-8?B?YmVhQmRTbG04bStsSHE0OWpkRHNUNHBucFl1UFRjcEd1aktoWVFVWm15MDRy?=
 =?utf-8?B?bDhtSEx3d0Zjc2UySnI0SXhWZzE3K0ZrY0l4TVUxRnJCcCsySTZIU0djWFJS?=
 =?utf-8?B?WVNvNWEzV2JoTW9GRStDQlJkc3VMTnd5YVNkRXlFRm1TckJPa05UWndURmU2?=
 =?utf-8?B?cVJYZDVxcFk5K2s4MmFmd3UrcFNOM1BEWG5QY2lUSzNtSVN3SlRndTZidVd4?=
 =?utf-8?B?MUYxYnVaU0ludlJDbXBhV0VuR2FNaG41NmtJZ3BuVEViWnJDNTZlNWFLY0tP?=
 =?utf-8?B?WlJEM0p1ZVoyZDArMERaUkNkWU41QjJiQjF2ckQ2V0lTWDRYUFlldzZpenBu?=
 =?utf-8?B?RWFtdlJLbEZFY056WE9xTFJjVmR1amJKRUFiMzY0V0U1a1h4K2ptL3Vicng3?=
 =?utf-8?B?RUpxODFmUHlvVzBuajc0K3Y0eXd6eHBRVGF6MmV1Z1NtNlZHU2QyZmFXQTQz?=
 =?utf-8?B?SXYrejkvOUNYYTdzWGR2OGZnRVFRUjRRdWJCd2xZNDMyOHMySGsyQmxLVC9o?=
 =?utf-8?B?ajdORVd6bk9nK2Z4b1JkNTRHL2twRWRoUWI4alh2bFplZi9WZ2Iyb1Nkdlhw?=
 =?utf-8?B?U2hlaFFYSnJiK0NIajAzWW5mVGVMcmJaZnlyRXlrVmhDbTdQZDdTZkhLa1FT?=
 =?utf-8?B?TUxqcHdxdHB5V1NxRHNyTVZCV1dBdzRYY0U4Zkw3OUhiVnRMdzVpalNTeFhT?=
 =?utf-8?B?Yys2L0pPWGVlcy82QnphUXlWUXNFWFdSQkNlSjVHbE5DcUE3aFdRUjliY1px?=
 =?utf-8?B?OFJoc1JWSkpVMTBadVN5WFo2RGZuTzFvZ3NKQWFIVWdwOU1wZkVlVFU1a1Bl?=
 =?utf-8?B?RUppelQvbTRlZHJqbWxCWExCMTc1MWJ4Mk4yY0k1N04vVndTSEJOL2l2U0o3?=
 =?utf-8?B?dzhmWDhjWmZNaHRXaWpncW5TTlFkcUh1R0IxbXhqdnMwY3pFNDJ4SHNKeVg4?=
 =?utf-8?B?Z2RVOGhjSE1na1V3Y0dHeDhmblNEaDZSNU45dEYyc0orRmRUblBuYWRPRVl0?=
 =?utf-8?B?amZnN0pmaThiMmMveGo0YmdHa0lMc2YxV1NabWtYVlhVSi9Qb1FJWkZLQ2lx?=
 =?utf-8?B?cXhkdHZabFJZWlcxY2xCc2tJTkdVQk02RmMzb2t3ck9ZZkRybFRxVzduZ1Zm?=
 =?utf-8?B?TDFUd0Z3UXJ5ZWpjL2J5NHNkaWw0ajNzS0xYaWUvbE9DbjFyZ3dWWDZMVTJp?=
 =?utf-8?B?YlJCTlkzNWJ4Uk0wOVVQaWFlT3JzeXNYVlZyWHV5SU9lcDhTLzRIeEhLNmRH?=
 =?utf-8?B?UUw3YXpkYmZVV1ViYzJxU0pxc0dQVDJFY1dLQ3ZhTU1IanFsRDFsYWtva0Rm?=
 =?utf-8?B?NXZrRCtDbzVzVVh6a0l0SW4rV1BUemFxYzRxV3pUVEJrZjBQYTExcm9vNXFs?=
 =?utf-8?B?Z25uTUtROFc1OHg1bkJWbzFmdXUwQ1l1YU04ajJxb3NxTGFZNkViRGFCeVM5?=
 =?utf-8?B?OEZlMmJ1S0wrdERVR0ptaEZMN3VHNC9hU0NpWk9uRm16UjRlRTc3bWxRWGo4?=
 =?utf-8?B?WkJTMDJ3cFUxeC9sTVNYRWdGdzQxaTlzZ3VFR3pKOWZFbGcwdXBNNERaaWVh?=
 =?utf-8?B?ZERsWHZMd0M2cmViTk1mWGg2eFFwNU44ZTJVSHpIaE1UYWhYNWNid2twSXFO?=
 =?utf-8?B?Y2ZVUkFSMmlmK2NFMnBkTmJ3bnVSTzlvbUtuZXBhMSsxU2VuSGxKV2dEOUZh?=
 =?utf-8?Q?e3tp5LubLKcqA3ks=3D?=
X-Exchange-RoutingPolicyChecked: kT1U4uNezF5CvRwXqOJwlzIlesTfKdzVnyFUz7Mp9e1r5e6wKlMv+USzduinneLFXVX7X+HJPI6BbY6IrtO62OtwBfbocudCyKg0xt7/4NxQ7tDhUT41aIQ8AEKI3P5vpzI5XVuFanH9mCLWb5t1QSi0qrRyCnxWKy8niO6z1PLUaJKZO9U30PaPr4KP3vtc3WUwp3y3pJT4N+uBmhQaTn+jmTHtM8zVw7u6pexlgpr8j4KuNWeIAZC8EBD7UR4m2jWYEBhC94k/1VSsajUcOQS8OeFTqgIfR/sugfarjYswSHabQQRmH5yiLhSEHuFcn4PNJUrHlf6uFddMQO7E3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42888859-b58b-4d69-7b5a-08debc5e0079
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 02:08:25.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQdb/Rn0Bsj4BbDsWmTa6G/z6OXdinj1wJHrE4QUBScI9zPu46+20AZA96+G7V0xv8MX5ujUa8sftJTkBj5UX3ekucuG9AC0Ed7LRxFPWi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8671
X-OriginatorOrg: intel.com

On Wed, May 27, 2026 at 09:32:54PM +0800, Li Ming wrote:
> 
> 在 2026/5/27 07:05, Alison Schofield 写道:
> > On Sun, May 24, 2026 at 05:56:20PM +0800, Li Ming wrote:
> > > In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> > > accessing p->targets[]. However, cxled->pos can be set to negative errno
> > > in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> > > causes the driver to use a negative index to access p->targets[],
> > > resulting in out-of-bounds access.
> > > 
> > > Fix it by walking p->targets[] instead of using cxled->pos directly.
> > > 
> > > Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
> > > Signed-off-by: Li Ming <ming.li@zohomail.com>
> > > ---
> > > Changes from v1:
> > > - Update commit log. (Dave)
> > > - Update comment in cxl_region_sort_targets(). (Dave)
> > > - Fix potential 'hole' issue. (Alison & Sashiko review)
> > The switch in v2 to walk using p->interleave_ways instead of
> > p->nr_targets fixes the 'hole' issue inside the cancel walker
> > but there are more places where a corrupt target array will
> > cause problems.
> > 
> > cxl_region_attach_auto() and cxl_region_sort_targets() both assume
> > that p->targets[] has no NULL gap. We need to compact that array on
> > cancel so that nr_targets remains the index of the first free slot,
> > with no gap below it.
> 
> I think I got your point, if cxl_region_attach_auto() is called after
> cxl_cancel_auto_attach(), It will rewrite p->targets[p->nr_targets] with the
> new cxled, the previous cxled in the slot will be dropped.
> 

Yes, here's a sample 'arrival plan' that goes bad:

4-way auto region with decoder A B C D arriving one at a time

arrive A, B, C 	targets=[A, B, C,]	nr==3

B memdev unbinds and cxl_cancel_auto_attach() removes B
		targets=[A, NULL, C]	nr==2 hole, and C at index 2

B memdev rebinds and cxl_region_attach_auto()
		targets[2] = B  	nr is 2 and that overwrites C
		targets=[A, NULL, B] 	nr==3, C orphaned
			
arrive D	targets=[A, NULL, B, D]	nr==4 == interleave_ways

Let's go sort because nr now equal interleave_ways:
	i=0 that's A and OK
	i=1 that's NULL, dereferencing cxled leads to panic.


> 
> > If you do want to fix both things in one patch, then uplevel the subject
> > line to something like:
> >          cxl/region: Fix corruption of p->targets[] on auto-attach cancellation
> > and have the body describe and address both the OOB access and the compaction.
> > 
> > BTW I don't feel too strongly about combined vs separate patches, but I
> > don't think this OOB patch should add in a partial fixup for the hole issue.
> 
> If my understanding is correct, I think they are two different issues, split
> into two separate patches would be better.

I would like to see this patch go to v3 without this change:
- Fix potential 'hole' issue. (Alison & Sashiko review) That
means don't change your walker to use interleave_ways, go back
to how it was in v1. That was a partial fix for hole that had
nothing to do w the OOB on -ENXIO issue.

Let's get that merged. Then do the hole fixup separate.

The hole fixup is small, just the compaction in the cancel walk
but it's a separate corruption of the target list, so separating
the fixup is good.

-- Alison

> 
> Ming
> 
> > 
> > > ---
> > >   drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
> > >   1 file changed, 19 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index e50dc716d4e8..8956b049c462 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
> > >   		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> > >   		/*
> > >   		 * Record that sorting failed, but still continue to calc
> > > -		 * cxled->pos so that follow-on code paths can reliably
> > > -		 * do p->targets[cxled->pos] to self-reference their entry.
> > > +		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> > > +		 * dev_dbg() for every member. which is useful for auto
> > > +		 * discovery debug.
> > >   		 */
> > >   		if (cxled->pos < 0)
> > >   			rc = -ENXIO;
> > > @@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >   	return 0;
> > >   }
> > > -static int cxl_region_by_target(struct device *dev, const void *data)
> > > +static int cxl_region_remove_target(struct device *dev, void *data)
> > >   {
> > > -	const struct cxl_endpoint_decoder *cxled = data;
> > > +	struct cxl_endpoint_decoder *cxled = data;
> > >   	struct cxl_region_params *p;
> > >   	struct cxl_region *cxlr;
> > > +	int i;
> > >   	if (!is_cxl_region(dev))
> > >   		return 0;
> > >   	cxlr = to_cxl_region(dev);
> > >   	p = &cxlr->params;
> > > -	return p->targets[cxled->pos] == cxled;
> > > +	for (i = 0; i < p->interleave_ways; i++) {
> > > +		if (p->targets[i] == cxled) {
> > > +			p->nr_targets--;
> > > +			cxled->state = CXL_DECODER_STATE_AUTO;
> > > +			cxled->pos = -1;
> > > +			p->targets[i] = NULL;
> > > +
> > > +			return 1;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > >   }
> > >   /*
> > > @@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
> > >    */
> > >   static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
> > >   {
> > > -	struct cxl_region_params *p;
> > > -	struct cxl_region *cxlr;
> > > -	int pos = cxled->pos;
> > > -
> > >   	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
> > >   		return;
> > > -	struct device *dev __free(put_device) =
> > > -		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
> > > -	if (!dev)
> > > -		return;
> > > -
> > > -	cxlr = to_cxl_region(dev);
> > > -	p = &cxlr->params;
> > > -
> > > -	p->nr_targets--;
> > > -	cxled->state = CXL_DECODER_STATE_AUTO;
> > > -	cxled->pos = -1;
> > > -	p->targets[pos] = NULL;
> > > +	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
> > >   }
> > >   static struct cxl_region *
> > > -- 
> > > 2.43.0
> > > 
