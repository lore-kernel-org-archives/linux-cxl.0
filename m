Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247A34A78E;
	Wed, 28 Jan 2026 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628224; cv=fail; b=cSah92AmpJPWLU4AkBRdCSForQTIX6p7osjA/ZNl7kzdJVOWNN/VdzDFVJqfet7ypmInHReZBjzgxO7kvXKak5IARr8np3C0nrIuWv7KTeTsMr15J6Lf3aRbTaRTBLGa1TfwSOjJt8YZ3gAcF7MRpsyIlY+AqrZYDlJs8AdZcPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628224; c=relaxed/simple;
	bh=25hVgSbFki1OHczKj8Rf8sGArP7hyAbtdfSMe9qdSIw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XqrSKDP11UNNlXqh3Znfh8tJnCRW2WI/H+AgDSVVArT21up2cZwQkn2e2YvWwWFHv/HBQNU0wlpW7h2gtbFyVaeBcvpFx+9/cbVwT6SGsuQbz3BcsLBEAUVXgop+ciZvJbeIA1ywJSq12GsEbUIlSb88yKAPixhKqb3E8WsbMJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZoYMqpB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZoYMqpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769628223; x=1801164223;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=25hVgSbFki1OHczKj8Rf8sGArP7hyAbtdfSMe9qdSIw=;
  b=QZoYMqpBW30OthMN4rHw+d/yc8rEj9f3UjyV4rKZRcEtTJPQdXDMuYnd
   EZlxj/Ptfwd1AgcVAONf1VriSVioRBu/Qhz1AYzVQ565ApVDuKF87ACNC
   M2JwoemEqtTOeGOBgF1ze+OzBYBiOg6oe/GKt8aZDjSNFGr2uEA47kKIn
   E/Su/1nG/OPwrZXS/3TqbXQoMdOu0W6JTTgPSPB9i8TjwfGUH8JiJTJFu
   ggGSXLc0SsiTByRE+Oqf+p80cEypvBbMpHY92NCtuQcX6Qz9hmtAR2EgG
   pDmVhOaXkyqzJ15xTH69/eWeL0Ix4fa2ut9d0iQy1VTYtNX8XRidq/AOP
   g==;
X-CSE-ConnectionGUID: Pwj4oVBnSTOi9j3Xj10bwQ==
X-CSE-MsgGUID: zDEm3tCCRYiA0V5t47BC6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74475555"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74475555"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 11:23:43 -0800
X-CSE-ConnectionGUID: +l/Gd7eDQs2GAYEZiseiYA==
X-CSE-MsgGUID: cmFutlqSTpmcbFT/zKSA6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207952675"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 11:23:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 11:23:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 11:23:42 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 11:23:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV0H8ktlKiunh1YU5GjKTG+YHWr4EP4NvLvjrp4nP+qK1xS1wnzyg9ZG0BkuSIIPyaKOpPJqCCf3u/ylM1CQg/2KsgQIxWzMrI8QA4MFc3eUfkbiVhxIWEaoWs4gXeiJr8nHWy5zvfBA52MMwKKof3MOZf/YaUKvtVfQrejRnOLsDGfvmBKY2bM3QzI0GF7wshmX/w9iuhIFFehH+4G4IWHJWzIlPZ+CnJ0y9mrY7XybviBMntj1bQWGBmTXPxc6ft73YV+CAVC/Bu33JD/c50vdkY5QfQjjSiCTB6F0O4dfSVDXPJnCozpr/EJ8sRmbnlLQVjFxsX0urdQ54DXS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIj5TGS5tiAbl/AEE/AR1ewi7+uqIXEWwtftGW7udBA=;
 b=wjYyHCraius/5xNPUEEe0e4CDa8QUZ9HV2h7c3zQpDT0ERvJ943qjMduSvqSkLY1ZfSkNEjdmDMTXuaz+WSnw0npgtmMt5QDOVHLoaPEme5/qwj16e7bHph8+qWAoKy7gMRve1osrG8Flt74ldF5xRIzgSuwI1t3ExKnqPDoNAfuJPsP5JWZuRJV2GAP6xYvzmbtvdfxLfDgfdojD1j5XUg8snPMt/kyP/0KZC9RSqGzttEoWRWR+4XxqYE/h5DvTWuxXypgAWixJq44mhs2lKtfKO4vYAzuxXXEZn+L9bPQ66aIwUkiLp2GYNUr2A2gb1oM5o7w75Tgqf2BXEK5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 19:23:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 19:23:36 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 11:23:34 -0800
To: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Message-ID: <697a6236185dd_3095100d2@dwillia2-mobl4.notmuch>
In-Reply-To: <aXoJPP00R7qblx-o@rric.localdomain>
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
 <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
 <aXoJPP00R7qblx-o@rric.localdomain>
Subject: Re: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d1a82a-435d-4b35-d924-08de5ea2bba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWFNS0hMZDY3UWg1TExjRzdtRnlycEZITzVUVndtZDlkWEpOUEFtK25oY1dh?=
 =?utf-8?B?aDF5dmZyTmxabU9IRFhWeDVQZ1RZR1oyaUF4WDRGcjU1cFlxZG5VWlVmbUF0?=
 =?utf-8?B?S3dvaW9vK0w3M0tFdjgxREMyVGtKSXJOMTZnVEJoT2lKMUhNOWM5V1pmSmh3?=
 =?utf-8?B?Y0xhbWJ6cHFJNUdNVGxQaW8wNnJsUEsyY2FIMGZCUW9Gcy93YTlFSjdGRVp6?=
 =?utf-8?B?QlRDNmJMSzBJNnhtRlZMOUJSa0xOZDVYTEpYTzVpQ3dTQ2RNUTBkRzVwdnV3?=
 =?utf-8?B?T2xFY2xldGx1eVJmd1BBdnBTOVdwby9jQjZOUEU1dFBhdHhuTzd0T0NUTFJE?=
 =?utf-8?B?enVSeWVFWWZTdnhCQlpuUzNHL3NGc3FXMllZMktDLy8rSTI3ZU5jNTlMeVdQ?=
 =?utf-8?B?N2orRmd6MVZBQ3h6SkFsM1BpOEQ1TFc5cmlzSkRZcXlYR0hzaFpvVjg0VHI3?=
 =?utf-8?B?ZDZkbk1zYTF1Q3FmVm4zd0tqd1B5a1d2RlRUM2ZTOFUzNVdPUHRqWGxKampr?=
 =?utf-8?B?SVZhcHgyZGhwYkpRano2U1JHWnBJRFAwcGtKUmtlcmVJTyt5UnAwa3dGK2FT?=
 =?utf-8?B?a3M3alB2VDQzOWRXNkY1Z1AzekpIaEZzNmNDcEF4bndWYm9DaVhDQ2xxdUVi?=
 =?utf-8?B?ZEcyaEhyVjJnMXF4TkNOQWIzbDl3RWNmVmZGdWo5aWtaNkw1dE11V28wMW1L?=
 =?utf-8?B?U3JsSVFLYWNwMlRTVTI2T3RSL0YwS0o5WDNPb1lLSEgwTHA5Um9qZGxwOHJK?=
 =?utf-8?B?dEJGekV5bHh2S1NLRU1hNWpwNkN0eDlTbG96NlR3bWRYZFFiTGRUdXJzTHNt?=
 =?utf-8?B?WHVGK3BTeStNM25Dc0ZlbmFCcUtJZVNiYTVybnhnVVdKVHJ5TWxJVzd3TmQx?=
 =?utf-8?B?R2Z1RVoyZFdMcXpoVy9nMjJ0V2FPSzNMdHVGRFdydU1hUEovWGVidlJ3eUlP?=
 =?utf-8?B?MUpsODg5MkRLZ25IdDVuRVpLbHJwa3RxcFpVa2pjNnVFSUs3ZDJlajJQVExy?=
 =?utf-8?B?NFo1MG9tV0FwWG90YjFaQk5vM2dJVnNIOGtlTDE4NEZkdnJsK0hZaDFmbHhC?=
 =?utf-8?B?N0hHejA3N1h0WUxMYkJXcVV2UUVkdmpGR2lHMzVRV2lrdXFyMW1TNTl2SDlO?=
 =?utf-8?B?NlhybFFFRi9jZk9ySS9ZaXVURGt2WEE0c3lYNmc4WHJWc3RqRXVvNkp4Mkw5?=
 =?utf-8?B?VzFlMjlWOWU0VnVnRWFKdFd2RlQ3V29kQXNtMFpaeHc2MjRWYVBpaHNRME0y?=
 =?utf-8?B?RHpTeHJTa1NtRjUvS0VBSm1Wb2pQZ0ExVExSN3EwUUVWcEVsUDZUMVN5Q2NF?=
 =?utf-8?B?R1FwR1VVbUM3WDZML0FVUldjQVFnajJ5dmVUWnVFR1g3TzExdlYzeFpxbnpu?=
 =?utf-8?B?akRMdjlhOSt0MloyVytsWmJpTWdhNGQyYTNEMWR5TTFCZzltcG1vTEdtTEt2?=
 =?utf-8?B?MklrNlhHcjVkM2YzYTIvR0QvT1dRQlMrbEprN3hvVzg2T0l4Mlpod1FFZklF?=
 =?utf-8?B?bVhPSG1TRW1GZVFGV3oxaHVoejc3QXMvQktvN1F1V2FsYW5xTjVIbzVVaTVI?=
 =?utf-8?B?S2NsSGZPUmVBNk4wZE9Ib1o2NGlYWWtxU1NEMjRFT0pxVW9LK1FOTnBsWlds?=
 =?utf-8?B?OVovaGtSeDVOSXlnZlA4dGhuTTYxVHhtZkM4TmNtK1BqNmgxZlAxUzBkcHdN?=
 =?utf-8?B?OUNOMTc2Q1M5TFZQTDFSQ3cyTFpreURHbjE0Y3c2M1ZIOStqMVJySmhIZGxZ?=
 =?utf-8?B?QUR6THQ5U3V5ZStxVFhiNXlPS1pXRCt3bGd3SWMwZ05RQVYyUGY3ZEtVUlpL?=
 =?utf-8?B?NzljQ1lUenNMQnVZYlMyaWo3U3p3eC82cnZHSU1XOWJDRzhRYlNXRmZFeFZm?=
 =?utf-8?B?b1V1S1JyQjUyQTZ4VTFWTktZSzZaSzdXTFA1dkp5UUdoWTd6eVFWNDBlK0Fk?=
 =?utf-8?B?OFVESVZHNnFkTENLTnl1VDFFTW55VGIxcUxTNXQvYkh2U0dUVVUyOU1LNWVq?=
 =?utf-8?B?MDI4ZjJiTXIvb2N4NGFFYXRxdmIrazJSNDNQZEZOK1NNUHBXOElhTHBad2lu?=
 =?utf-8?B?b05OWmRteGozMGdvZGdmY1dlcW9Jd0s1SVc0MVgvSmk5bTl3aU5XTVp0UC9Q?=
 =?utf-8?Q?0a5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hObEtiUndVSEwyT291U3dBR3B0dmhZZGVKYndVb2FaNUYyTVBEUFk0SVdi?=
 =?utf-8?B?TjdwMzNWMkRRcWlXa011K09sV1JYakhFcDdtQy9QTDgzZXRCRWdxcVRsZklU?=
 =?utf-8?B?WlNTN256VVRSdXhRZWpZYVRXakpLTURZbkVsYUM3R29tWXlPbmdkdFZ4M0xs?=
 =?utf-8?B?RllkMldtTk9QQzJQeldtc2pzZ3ZyVUxWUnN3alVuTGZPNnp6aFRISHdjU21N?=
 =?utf-8?B?L1dvTTlEMzFCZjZzYlVlWm8yOTNXRElWLzdNZE9VMGVXN0tGOUE0REh2RFRJ?=
 =?utf-8?B?Sk9mUFdVdHBVcWF2RlpaL2hvb1JXczBReVdMTkZKc1FrbFcweVZYckFXcCsv?=
 =?utf-8?B?aVpaZjd2K1VYaVVTelJObGZ5U3hKaWNtT3dCWHFpNFlPVTVlUDR5UE8zUXND?=
 =?utf-8?B?aU52dXQ1WGxSamhCL2dSMUpmQktweEl6WURpQmFOWVBmYTVjd2hPbGptTDlM?=
 =?utf-8?B?TEk5a1hHWTl4ZUE0QjhqTXBrODU4ZTJubnZLKzdHNWhpbk9rMVF6cHBOdHQw?=
 =?utf-8?B?TkJsNjB5Nk9hQ2lvNkxjT3ZBVGR0cWhWK2RqdVdjckR6dmg1Y2R6b2RVa1RF?=
 =?utf-8?B?K0dZL0xCeDdLdURVVlhKK1VPZkpMYXdaTyt1bWttRUlCK2tnMkh3bGdLL1p6?=
 =?utf-8?B?aFlGdkJVZkplcWZWU25Sb2NKREhNdDVZWXhJeSsyNk9Eb3NzeVVxZHFaTFJz?=
 =?utf-8?B?MmI2N0NmUXU3RWZTWjhkQUtMMFlsYzBzOEhHZjFaMXdpeXR5aEYyYWZzTVBT?=
 =?utf-8?B?bmpaNjUxUkxnaDVweHJodDdCa24vT2tFaWkrcGNYQ3d1SEt5Wm8rOWdaWUhB?=
 =?utf-8?B?NDFpc1JkRWV6L3RxdWZDZ3ZLOWFqa3FMNXArN0Vnd3VYb0NSWDg4QVRJQUJx?=
 =?utf-8?B?N3l0MG5iY0V5SEIzcEtUMVpsTlpYZG9UOTRMSzhvVWkwWnB1Z09zRTRDdHZp?=
 =?utf-8?B?T0U2UGJaYnFZNVFreDNoZlprQjd6bVhabE5DRUN1YmRzbk1zYURpTXdLNXFa?=
 =?utf-8?B?cTZGWGVCZTk1a1F6MDhUbzVrMjgwUXc4UnBwSmFrSUZudHRNVmxlb3JBYktX?=
 =?utf-8?B?S1FtSGlJRW5YZ21wRHEwaWRhYzRDcTQzRGhCUDRPTlBETEdTU1B4YVhBOFEy?=
 =?utf-8?B?UTlrTUg4aHJJeCtTTVErRzNoN1lSeWd5QmNlMldzeDVhMHpFOW13RWVoSko0?=
 =?utf-8?B?ZlBZRSs2L0kreHVCMVlEc3E2NHdMN3NCMllSMEFxL1NTN2FKMkRtVTl2cE81?=
 =?utf-8?B?RkprV004QjV3NGxoK2h1NDFBT3RSZExLdDdVdm9EZUNpaU9rSy9hOWpzRCtp?=
 =?utf-8?B?QUxMV1ljazBWbXE5VE1QbUlEakhzY1RQNHZJNUJtUFZOQmM3K2VKTmp5TUtS?=
 =?utf-8?B?dGljbDlVci9ZOUEwMUZONXZaLzRaRGdIamZqN2xpVDhnWXVIbTl0aGl1dmNY?=
 =?utf-8?B?cVRTdEZLKzR6Yk9RRTRRWVhzaUJsZU5SV29yS3F6MjB2bUtPT2hNeldMdk42?=
 =?utf-8?B?YTFiQ3Z2d0czWnNhZlZ4a2tzN05zbWFCSXRhN2FsSnc3Z3BQdVh1QVFFU1Ja?=
 =?utf-8?B?UTVJSFJ1V0RldjhPblNFSWd4cDZzelJ3ZGRlaklMcGJ0ZjFtc1l4WXUwY3g3?=
 =?utf-8?B?Mm5ha2srNmFnZi9RWnNtdEZXRFJXNmdSMlVLQVR3dW1uVW1wYzVyN0t1OTRF?=
 =?utf-8?B?Ym9Gck1jU0pKMHJ5YWhERzZIaGJIb0wyd0plcDlXMmlpdGxzeHgwWFJvUFNG?=
 =?utf-8?B?WjN3bVpuaEZINXA3ajhaSEZxcjRRT3hVVXoxT3U3S2dFZnQ3L1l1dmdXM2w0?=
 =?utf-8?B?aXV0ckRyWlkvOElwT3lpTzBuYnFQdUFHSjVkL05VUmNuZDJ4elVxVlBxMnlT?=
 =?utf-8?B?K0JhYmRKaHVZL0h4TkwyVTY4dnV2MThvWjA0REJEYXBudVcyaTdVaGtrR0FD?=
 =?utf-8?B?bEdDMFcraE0zSnhSUlpEdnh1R1RrRlV6aStPSzNVOWI1RHlSa2VyUHFCNlll?=
 =?utf-8?B?SGFnbk5NYzhwV3NOME1qQ2FLcU0zZzhpd0luM2pJMVoyWnpPcHNLRzM4dFVY?=
 =?utf-8?B?cm9tK0oxcWxObUNxZEdTK21kNUZwdE0vQVFPMWhHRXZpaU4xakFLcUlkVFZ0?=
 =?utf-8?B?ZnJlUmZSdDYwUnFMMXlUQjFMN3pFZmhKU0JjWlRuMk96ekpTcFE5bDZleVV2?=
 =?utf-8?B?UXJUeTRwbkVXTlV1SnJaSnRaK0J3QmE4Y1ZZUGVTTUtHSS9qUVUzRXBIODhP?=
 =?utf-8?B?Wko0ZVZwUWhpb000TGpCVVFnZFlEY25JV01rUTc0OUFLWkhaZjlTeDU0a3Qr?=
 =?utf-8?B?L0sxeERaQmZrNXB4ejdsMFhFV3pTV0lkQXRpTmxRTmVLZUJDV2VWVExWT3F6?=
 =?utf-8?Q?ZKBXiFEz8DNGmYdw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d1a82a-435d-4b35-d924-08de5ea2bba4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 19:23:36.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZwT/hYwjq8/VyGWmAJcSiujvxyuMt4tLiQypdy+KVu0q9lCDbsJKd6ErSY7afm+aefU+0SpTaboGJFvs9SOZAE2+mmBtm1aQ4M/VNOB85g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com

Robert Richter wrote:
[..]
> the Zen5 machines only use the PRM method as described. They have been
> out for more than a year now with stable firmware. Moving to _DSM
> would require a new firmware release and force all of them to run a
> firmware update.

Ok, so then do not document _DSM as an option in the convention
document. Only document what has been shipped and require anything that
follows to not deviate from that de facto "standard".

I was confused by this convention document offering optionality (direct
PRM or _DSM) and then requiring that the kernel accommodate the less
preferred option (direct PRM). If there are no plans for the only
existing implementation in the ecosystem to support _DSM then simply
require direct PRM forevermore.

> > ...and for the implementation can you update it to only invoke a _DSM
> > and hide the fact that it might be implemented by PRM on the backend?
> 
> Additionally, a kernel implementation change is needed including
> another test and review cycle. As you described, the implementation on
> the BIOS side would probably be a _DSM wrapper in AML added to the
> SSDT that calls the actual PRM handler. An alternative is an ACPI
> quirk injecting that as AML code, but that makes things worse. IMO,
> all this is not worth the effort just to define the interface as _DSM
> only, and then use a wrapper to call it. Plus, there will probably be
> no platforms that adopt this.
> 
> I really would like to see PRM and _DSM coexist in the spec to avoid
> all that. We could restrict the PRM GUID to the one currently used to
> avoid other PRM handlers coming up (if platforms adopt this at all).
> Please consider that.

No, please no coexistence of alternatives. Direct PRM is shipping, catch
Linux up with this singular reality, close the door on future changes in
this space.

If there is ever a "next time" for a different platform concept,
strongly prefer a static table + native driver enabling approach.
