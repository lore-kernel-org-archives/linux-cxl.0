Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBD2CCB9;
	Sat,  7 Mar 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847210; cv=fail; b=hQ0/yS8luWw2C2JI0N0y/jur0kQpMCvBQSN4bz1XXc+IR6Zyb5pS+ZCN7I0qwS/zfCus40/ny9VwyOvJjad8yyogmq99So3zlu3Hua6jrcpdVYcb4c32d+eJX5pBx+uMWKPQ7s/DSD53paMcyOtuTr6pNfXoC0Fr6gOM8A+mfXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847210; c=relaxed/simple;
	bh=DLfsDtj4YoPhCuq1lyqZzb27oCXOTBZlZ2ZklyK+K6o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ag2KlO3n7Z+3xquY429AOovjfjhv733mXKtTmHv4OHJCYHnZA2DR+6BLy74RXdB7QIUS+WupyrS5M2anklrMqAk9zothMTBktigYyiP0JjAmfpkM+pZr1C2OgBFCUOUM0K81TztrWHWB9y6J14qaYXmAf9BwB9nJQk+l0WYZs+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H93zrXEs; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H93zrXEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772847209; x=1804383209;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=DLfsDtj4YoPhCuq1lyqZzb27oCXOTBZlZ2ZklyK+K6o=;
  b=H93zrXEsLeuurAkfC3B3A3ZGjmtOqsT4FbjVFJVvONss8HrE5A2eb6r/
   QxHFyMkgxP6bj2LwHeY5FNj4gEpy57XIJP77xpseDqTIe7h6iqt7h1PTl
   Zbe+EQv+jn5Cl2hgm1Jg3tfIThWm38rmRasvtU59+YgPX0IgaceR3AHU2
   liQGK3cWymblNrM4JFxSvWOi5vSW0zDfgL0gXsP0x/oud7j+kLB3eTHpL
   +OyVUdWZxzHjONVdIYy3GmQKSSjbomjbcElFoejxN9l8oVzjCPDfRqKQf
   cxN+Ro1gzbWv97l28bTjZSAXSsLLygg+Cndp4VWEf1MejdQdZOYXsD2L5
   Q==;
X-CSE-ConnectionGUID: BU2PCum0SWCI8rsEOndJ/g==
X-CSE-MsgGUID: LDncenK+TSan9GiDP46SKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="74036034"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="74036034"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:33:28 -0800
X-CSE-ConnectionGUID: YDJjzUU2RPiREQTiVFf53g==
X-CSE-MsgGUID: Xy7U9SqWTSSVPEDWVfqpYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="245371254"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:33:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 17:33:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 17:33:28 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 17:33:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJA1Q/240JIaZHg3NaakQW248ZF0q1Z596x3rmNXCdRePtb3Zyctn7Rlgi202iiPYKCBciYXUF167AHh3LitRM6YypDR976a9a/6IRcdEbZHjs8IfcdZLcIiwGseRjMb3IPiNHjv3aPb0wh6d77NKXmfbBl+QyZHRiHATsxvtMd8mOLcF499v6PjQTcmee+KOvegD92Ns5brP8VvT50LhghScl4T/j8b15qvHe8aq2D/sPl/yikcZkhirwbQiGPTy6Mjv9APpZMis//6nAq+W6YrX7QQl7HnY40tzYhoyeib8XqxKArsQB3N9IOpvHcjE0Fl3VEhlIgvPOQ7jpXNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFZRn9+3qh+AZq9GbdAK2vay/9KitAjy48RIxB5yGmA=;
 b=MeN5E5/cS7hmvZwdnjgN8hfcWU5OSle1iBJdd7tJgaPSWVjXB6FD6ABRIhAmMnf42C2d53dK3EbEeRssYMJYtV3Rabo+4J6F6QUMfr2VJzKQR0saUOi+4Q88bLFdT7rq11BuNEDU1hKFlS0pABSY4mlH9qTCwrNsEKF8KXbo33ElmY4EGuCYrhoNWN6ShJdCx9mA6Kkcnj37gre9sL+s0797Q1xLFbueTAI1lHDyPllKDHxdylW8oaU4CoijuswW4gDD8ZWTszRokpbHLSjS5pFDzVl5hBg/PjlE/OAmbY4yMmwlkWAdidYAWlgcP8HFC3d1kdi4YdfRydDjhkXytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH2PR11MB8867.namprd11.prod.outlook.com (2603:10b6:610:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Sat, 7 Mar
 2026 01:33:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Sat, 7 Mar 2026
 01:33:19 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 6 Mar 2026 17:33:17 -0800
To: Song Liu <song@kernel.org>, <dan.j.williams@intel.com>
CC: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Message-ID: <69ab805da9dcf_6423c100f0@dwillia2-mobl4.notmuch>
In-Reply-To: <CAPhsuW7uE3J4+td=wLpJfiwSVbeyrF261in_yj3pudK9v6_o=Q@mail.gmail.com>
References: <20260302200429.803417-1-gourry@gourry.net>
 <69aa2c9631aef_6423c10077@dwillia2-mobl4.notmuch>
 <CAPhsuW7uE3J4+td=wLpJfiwSVbeyrF261in_yj3pudK9v6_o=Q@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH2PR11MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c82779-b777-424c-bf56-08de7be9832a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: RVnRrgFE2E9WbQQCwZLtCnCmKrkfn0yfix+fXDPBlGEBo90w62hctJPdcyoinHXFiSre71R5AkPRSAh14gxDT+6reaNJBKixDNGyyXwgFZZOD6oDQBPSpdbdJLnK4hnahvvpGXwx/UyYqu6aOSSdnJcVP9hccjURauZyHe+DoaiCPfqvwmKKDtaWTd34qfnJFxyLOOFTiYjjIaUxKmxYxhJ3+LsHHiVcj5sNLWPV2dY99vpN9gWz1oIIl3GzQGf1Wlv3tj3O5Lq0ZKdLmYJOZWeKU1wKhzBgP/DAQWgqQhzPlrzNVUR55j/rMxAWIG8wMkwJ0cJ8m+NGEI2Kix9eUHH6B6ltu/IsQ/ELsfJlyrx6KA+AUqrgMZgNf0uacIPHLIcIhNJm4w8UYM2vIgsdT8oemkOmLW7uYsP0j9Wzv0pQTJEMMW7Jb9ziiI5vb2h4CTPjp+wf6KQ5tYm0w6jx3otwlQrCfG5JpZRRo8tcc1XCSFqg3pdefj8EY+YzP1GlP0Q0KADl8kMBx7TzgxIxjVZWttiC63FnPr5nxBC6hBSh3dTsmrnD3t+OgLogScyiV+cgShk2cFbBOgapQeCHNBxWkmshnok3J3clfE1wuUy3sFi7EZehMTf4tfGvqNqjnwDTsk/FGtRRFOGJ4lW32Rhn1g4q5I1WpemHs6wCoX9Et+cBiAyvJ+ju/oal/gnrwZShtBL1IS/hsbJabDafHwhpa/uaOZrJYCJiAmNmDBDB9TI2RZm4LbDcPIwT1jms
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDV1RFZ4OE4zemZRSHY5c1d1bnRONzJ6UFJ3ZlFUcERWK3F3YmE4VlBKQ28w?=
 =?utf-8?B?SDdEMlcxN2JrVUxxRnhic015UWJMVEtjeDFzaUgrclVvaWdLaGdqVy9sSFJj?=
 =?utf-8?B?MnhSTGJEbVJJMnhITHBrSUZBcXNHaEJKeUdqb3R2NnVUeVRVTFo3clM1T2xk?=
 =?utf-8?B?ME9OSndxY2RPRkJqbEtCdEk5WDJJOUM0QjBkRGljbnFSNjk2SE9US1lNbTJl?=
 =?utf-8?B?TFpjNEhMMXUzQ2xKckRiQ1Y0emd5aXhrc0huMEVOZkxqQ1dkVUNZenhwa2N5?=
 =?utf-8?B?RTZBY291Yk5aTUJvQXdLd3dBWTRGcTBoeGFJWnFxRlYvb2tVUjRqY3F3TFFs?=
 =?utf-8?B?SFBsYUlYSlg0YVh0R0g4SExjcXEzQWJYSTdWUjMvTGRiSFB3djQwaGZia2JI?=
 =?utf-8?B?c1BwL0tlNU1WdUJZS0dGcDQrYkw4bGUySU9ZUVdERUkzNjBwSlZLMGpvcVNP?=
 =?utf-8?B?U05kVFJ2enlKYVJNcEZWRm1NZ1Z0TndRUmtUbldFalVKL3NOODk5YnZjRWJo?=
 =?utf-8?B?Uys1TGQxNXBZa3NpcS9NQjg3KzFMSFc1V3JoYWc1bkxWQnMrSGZIMlpkNWVV?=
 =?utf-8?B?NUc5NTQ1ZXkzTlBQRGpMS2pIc2t2NEhMTTNSNG5CMEhnaTM2eFlicDhMYlpQ?=
 =?utf-8?B?YTA1M1RQNDVKSDdiOFNEU3pLeDZHNk1iZ1kxZmNwOVhNRHcxaVZoWnNhbzhI?=
 =?utf-8?B?M0x5c2IxWFJoVnVFOGV2TXZPRGlRV2ZYRHBqZnJtWitlVERLbkpUOTVHT3Bo?=
 =?utf-8?B?aGtmbThHdE1FeEFDSmVuYWFNbExOYTNZZXJIbTNZc1VheWhRZ1k2ZmJnMGtj?=
 =?utf-8?B?UFkxUWdvWlNBRmhtM2RRb1NsS055Uk1oS0pqT1ZsdG4xWUN4OHB1d0hJWDJ5?=
 =?utf-8?B?QUVuaExRQU9hV1BMZzZtZldwR2dEVnRETk1mS2VxUHBDbk5tWGJOaXJMcXF0?=
 =?utf-8?B?QkxUaldyQmJHTHpaVVUzcnUzNmlHcXp0WmZ3SG9EMkJPZ3VsYnVRTzFHTy9i?=
 =?utf-8?B?MUovS1l6cXM2S09EYU0yNnN0SHZlN0ZCTk5UY3M0TFY1Zzk1dEI3Z0FweVJI?=
 =?utf-8?B?VXc5VFUzZ0Q4VmFCL0hEYVBHcWlXL296Z1A2SVVSRUdMWG1VQm9zUWZmNC9N?=
 =?utf-8?B?RGhBeWNBODgzZlQzQWdkYmw3REo4YTFjSUMvcVVYUysrY2lXZzNnaG1JN0RB?=
 =?utf-8?B?T0t3UzdYaXJzWDdSREo2aVQ3OTk4ZVoyZUtTWjRZNkdydStSbFRJcUpSZ1VB?=
 =?utf-8?B?UHk5K1dKMWNmTXhVaXhiNVJaMWV1SjBtSjZSRzRCNUVwbHJFTjU2UFQ4UEZP?=
 =?utf-8?B?VWQzTlZUajh4QlpyZVN1RTFnclRrcW1FY1pyR2lxRkZRUXJjQ2VSU2lPUzl0?=
 =?utf-8?B?NndFUWtZd0FrUXo0bXJ1dHNqUGNGWUwrNE0yN0VVbW44UVJZaHN5NUhKUnhU?=
 =?utf-8?B?MkU2UDJpL0Y2bTMyVnN4OXNTRW1JWnBMaVdxWHdDOVpBYnY1dW4xQ2FGNlZj?=
 =?utf-8?B?QzFGVVg3czFWTjE5THJxYmpZZlpJRW1MMWNuWjhndkxHd0N0VUJYZGFPaEFY?=
 =?utf-8?B?MVpNUG5PWGJjOFo4UGYyc2poU2Rjdlo2cnFqSTJiSDdVS2dFVEg3QkRBSUNL?=
 =?utf-8?B?RTlMYSs0ZjRrVml3YXpETmlDR25KbGFSaVBMcWxtRWV6aEtsYXhWeWtOYVdn?=
 =?utf-8?B?SzB3UEVvSnU2MUtoZ1hvWUxqZm5wVmxQMlo4bFp5N2pJMUQyZXNxZFU5TWhR?=
 =?utf-8?B?MXhlUkF2eFNFZW8yVVlQMHQ0S3ZZT2lKcVNPb1hQOWtiRTFSbVZKOWtRUitw?=
 =?utf-8?B?M0tOclFhdVMwWXVYTGpBanpHMFJza2tGTnlOWVRIcVZ3L1J3WXBsREVDSmd2?=
 =?utf-8?B?OEVDeDc4cFU1ZzVMUHhCaVdadytFMUtBT3I1L0tveE5sTkpKWlM3UkY5NXpm?=
 =?utf-8?B?Smd4Z1RjalpmQ0Q3RHBVNDhSa2gxTzVjRy8xQlhISzg4TDZzYzhQSldoRHNk?=
 =?utf-8?B?M3ZwRWNvQVNaOWxnUlcwZDQ4NkZaQnRKaEtINHRONS9CeTdKZ3NJTDJLUVZp?=
 =?utf-8?B?WCtWZHliMlZCZ1lUSlpnMTZHYjNJU2M1TGVkNktKcTdQbG9yRkxZZmpsVzhv?=
 =?utf-8?B?SXhKeTBRRHVXVVR6dWNsOXRYd21KYnNLbVg0MGp5d1JZOUZrN1V2a2xXeDhs?=
 =?utf-8?B?OXZ4eTRUemMwWWdXWkp6SmpXNTE3T3Z3V1VUYXNUMHhka3RSdHFudUdqZkRi?=
 =?utf-8?B?ZGZQOEV3dlJQWW9RZzRqUGJ4dlhVYlUxNnFRUXYrNE1HMGVWSG1Ka3JWdkU4?=
 =?utf-8?B?a1FkcTk5SXppMDFFL2htWkpMR1dIbkRRZHZxSXRZUDJuYXBCbjl6Znh0YmRK?=
 =?utf-8?Q?loJt/buT7og2rbI0=3D?=
X-Exchange-RoutingPolicyChecked: jZsRCuokAaahgPSEENGgj2IRIzhKoPYt6k8SpuDxp00Rfm3PADhGicyHswdS7EAAodjRaEwPVbScF1ohCAEodHL6l1ifvt5IJm6KcGLo2V6dXo3otSPDp9gXyTQrOemt6stq5FUNGM7vwvVcSExzxkNqpE1vd7zoKjvvv2ixd7BFcVoXNKUmSDRuyPP5gVKseKx121vzqsB7PhYnsafVhFdLk6vkBebeJwQTy8cgmIadozn6Fjcj5haYFOF37tvyP7uiVfCFpNr23pykBsuy1OgM68Mk222vgMNriUjwrfQqW+pIPs+BnMjyQb2XEweuzvmTMBmYzVvU6Orph5LnrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c82779-b777-424c-bf56-08de7be9832a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 01:33:19.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV1+10vSIF/Weqt18UWQXzImr0Bbcw60BDQKuPEIjRFnWJJ7WC8+LaXArzgBSjrwjtOto7/9XcjnV3CSpiI4QZhcPMj7C26rRVmtmfH/KoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8867
X-OriginatorOrg: intel.com

Song Liu wrote:
> On Thu, Mar 5, 2026 at 5:23=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > Gregory Price wrote:
> > > Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> > > cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> > > cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> > >
> > > When CXL_ACPI=3Dy and CXL_PMEM=3Dm, the built-in cxl_acpi attempts to
> > > link against a non-built-in cxl_pmem, which the linker cannot resolve=
.
> > >
> > > CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=3Dm constrains CXL_PMEM t=
o
> > > at most =3Dm.
> > >
> > > Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> > > built-in caller references a modular target, preventing the link erro=
r.
> > >
> > > The result is if the pmem/nvdimm symbols are not reachable at build
> > > time, then at runtime it will always return -ENODEV.
> > >
> > > Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_p=
mem.ko")
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/cxl/acpi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 127537628817..7065413eda9f 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device =
*pdev)
> > >       if (rc < 0)
> > >               return rc;
> > >
> > > -     if (IS_ENABLED(CONFIG_CXL_PMEM))
> > > +     if (IS_REACHABLE(CONFIG_CXL_PMEM))
> > >               rc =3D device_for_each_child(&root_port->dev, root_port=
,
> > >                                          add_root_nvdimm_bridge);
> >
> > I think we want this conflict to be resolved at build time. The nice
> > thing about a new CONFIG_CXL_ACPI_PMEM symbol is you can check your
> > config to find out why your CXL PMEM is not working. Otherwise,
> > IS_REACHABLE() hides this subtelty.
>=20
> Can we fix this with something like the following?

BTW, this is queued now:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=3Dfix=
es&id=3D93d0fcdddc9e=
