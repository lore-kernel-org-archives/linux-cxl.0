Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD5433BE;
	Tue, 12 Nov 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379112; cv=fail; b=hCOSjnjR0D4AYM/V7suuFQB6zzjpP8QaZnx494e8rEP57fck2+k8mxcdfkrvDMnMr8wym8Dz/3mlvc5h2g5rE5F92dGAvC8oh7b49b6nUmFhGQj/7DxangWPh6JypyOaKl0UKJ7NBCMxs6PFCAjF5TuOJEQbPE935ye1NvuVKOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379112; c=relaxed/simple;
	bh=RCE2EDeUPJ5gHpOz+91B/ixrByBSwsSjjUcJ2An8HW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2ZoVCXHmDh3gad3I/tw4NC2EGxkHAYRJwIITNGwnUp9fXcyfAgiv7mjxTBLEdzrljG176mHnckz5caf7LZV5h/wK3WRwEAaMwgKTCAeqggzdKqJruQzAhbj3CJS6uq8+wa7o2ZKDBTBRAjiu7mfCnNbs6gTeYuZUNgLWlaFSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDk+KH8z; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDk+KH8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731379111; x=1762915111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RCE2EDeUPJ5gHpOz+91B/ixrByBSwsSjjUcJ2An8HW4=;
  b=DDk+KH8zjHWeijAg5XuxkTiPEe6e17htR3H15tKAQjX0xjZA09CbNs81
   GKh/2uSVvkiPkaruhhsMRfE1gt3YjF0Z1Hrj7M7mbr+AmaL/qC+oqPZ5X
   wowv030niTvaa/3yFaYOcleMpBjMkK/94yTPPi1iNPJVkTbK2Krow66NS
   sojFba+EXdHniGx1tx57yqaJ/T/bMjqipt4A5KY0XsUOKkijsldY7DGGn
   iPboK+6VNWSSA/jSjNnvRLH6pLPY66fsBBPF3FOekq/jn9v3YvskXD0kR
   mLIcVV5oPCkpgMAHabCsCpwPMpyVqocnkVY0IPHmRggVno9rFJfye4Vae
   w==;
X-CSE-ConnectionGUID: 8zyhncPRRmyaeTgWLV6JHw==
X-CSE-MsgGUID: elPKZ220TSe0SHsxGm7Y8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="41824532"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="41824532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:37:44 -0800
X-CSE-ConnectionGUID: GwvMXTwJRYigi/Ul8CIT3Q==
X-CSE-MsgGUID: OGdRdleERC+1q0wqvj8NpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87162835"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:37:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:37:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:37:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:37:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR9tTfVDz1nVEC9R2uvGYAn/SEwqt6YSXFpn0HM9caczjFPTbo6NYgA1Ij4LrNYdc+dLq3qv5hoobftBLwFvrnclI2V3jqjBXfP4m23x6W/2rxdQyp1i66ftO5Z3sp2Gw5mBbI8AzSezSXZPEH+uJmbyT7aE1+zTCAVv67hEuNzLswI0IUWh2veAY3k/uPJOV5nZAW9/SFynFTc419HpWUUsUTjje0WAh41ewtpMki+wPRuhI4UFSRKGy89+UZiKTTl3muKeLxardpRc/bNfyF0ttbK4hGqPd7xjCjAxNQoIsXAUCjJzM6f586V+52lFHrQY7SSP636eu5Dtg9nscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCE2EDeUPJ5gHpOz+91B/ixrByBSwsSjjUcJ2An8HW4=;
 b=fQ3NnFbrU7sF29VFhCZ+PlKo5bfi/ZvUYaExiZ1sBm1fvmLIkdDBrq1V5jRPAipD/4EGXcgiWnTh7XpOzIE311WF4wrIMTEnPE5gT+V312YOcWYBuFqd4Lb8MUUocYyaC6hrcNgLDG2bRa+nkWqRUrvSkcJdkU959f8CWO+gZiKYzk8n5mXUjMf0G66gt8PDKD3liEPs8+MsJPUTtVAeD7Lhwov/dy2FxFanWzvYTHzw2JQetkO5mAggz5rOLsHPv3MW7MqAn4pCt6d1UwXKQadwDtYggFB6R2tD0ORuL4yrFhG0U32Mc8wh/gOknw8vqmcIFlhexTDm86SONEhOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 12 Nov
 2024 02:37:40 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 02:37:40 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, "Moore, Robert"
	<robert.moore@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC: "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"gourry@gourry.net" <gourry@gourry.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alucerop@amd.com" <alucerop@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Thread-Topic: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Thread-Index: AQHbMzhBefZ8dSHBrEGF5ZMghXTiPbKy8JmA
Date: Tue, 12 Nov 2024 02:37:40 +0000
Message-ID: <1595d6b740602682f12a4e502e459b0d82e48711.camel@intel.com>
References: <20241104084110.583710-1-ying.huang@intel.com>
	 <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
	 <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
	 <Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
	 <672d329119d63_10bb7294cc@dwillia2-xfh.jf.intel.com.notmuch>
	 <87a5e762gc.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5e762gc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB7291:EE_
x-ms-office365-filtering-correlation-id: e5ff421d-cbe8-42de-e5bc-08dd02c2fa7c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WTJidDI4b25wSWNrLzduVDBwaGRCR05zc1dTUlhmb042L2Y3MTFiSTJMczlu?=
 =?utf-8?B?U2NvNnJMbVZDK1d6cjZnYysySFpDeDhNaWZqZHpJVWdXRTBaZ2MyWEF6NWxP?=
 =?utf-8?B?aHh0ZVVRSit6WXo2QWRERmhKUjczM2l1bHdURW5LNnFuQ3JxMDZCQ3dzeXdu?=
 =?utf-8?B?azdhYndDSXpvSlZKK2V3SHlSWmlpNCtLQ1ZlblllN3RHcE5xbzRSazNEVGRw?=
 =?utf-8?B?a3FNOUxOMUpLMUJ5K25ScldVbXFIYjRXcmJOVjU5d1F4NlBGRzQ5L0syc1NO?=
 =?utf-8?B?ZXFKdFBtM0RHMWhQaDU5ekdFcWEyQ0RRbGtxNkx6VFVwNUZ1ZzlPd09qTm5l?=
 =?utf-8?B?S0dGclJ6cFViTHBlL2VkckRVdVJJR0ZlU3VoZnhDZUNXNlZjaEtjOXluSmlo?=
 =?utf-8?B?RXVFR044ME0rS09GUlZCM3RqUnZVQnV6OUwreWd2VDVSR1FQdjJqWHBBaUNS?=
 =?utf-8?B?Vk5ndVlsVmU1b1F3cFZuK0xqdHg2bGpmODQ5b2pIM0orR2tpQ21YMnlsZ3Yw?=
 =?utf-8?B?cklzNmhFVXhLSmhtblMyY3pZOUxCbTM0K255ZXp5dHlHdGFGZnpCU3JtcytW?=
 =?utf-8?B?ZWZvWkZ5VGlReVZZa3VJYjR6VGlxL3hGTFBFSEpkVXFyV3VWT0NESXJVa1RY?=
 =?utf-8?B?SWZrcUQxUEdNL21CMmdtN09TK3M4b24zbU12T3pjSDRjTTVzcVJGREdJenFw?=
 =?utf-8?B?aFpPUXhPRWU4VE5tZG1NUHY0SEhWUXJBMENQYUxTZzZlRUs4UU5BS1dUaGsv?=
 =?utf-8?B?bktkZzNkZDlRY2ZyWCs0eThNWXZmeVBCMEhyYU1sQTh6R0ZST1ByQis2YVNM?=
 =?utf-8?B?cENtcFNnZkNBcFFtZStnY3lPRWRBTDNnMnJ2ZjNQWmZHMmYvZHZRUitlRUdJ?=
 =?utf-8?B?ZkNJd1IzcGFncCtNZDdHL09JVzRTN0wxdnphVW9wYjlOemRzTWp2VEhGNmU0?=
 =?utf-8?B?T2pRUDJEQ2lKcCtTQ0RVYmxlU3NRYlhkWHJ2RDF4VWl1dzBFYXl2eTBXSHl2?=
 =?utf-8?B?RDRpTk5uY1BFNENBZkZBNTVIOHlwTW1sT3BwNlRjU2svS0ZqbjlQbkNvMCtT?=
 =?utf-8?B?WlpEWit1TE9YNDFET3lMVUkwVC9objhtYTVPcHJvekpmbXJGZmJ5d2lpWm9k?=
 =?utf-8?B?WElxaWJpeUhadXFlemlMQ1ZwZGljMVRZSGNmd0IxTURXNjl2T0xVWkhxLzNx?=
 =?utf-8?B?NTNkRWZMTjEyQmpPYzlLVXJrQXI0bzI2c3d5N2JxUEpndGdScmI4NHJnT05F?=
 =?utf-8?B?SHk1bk5MWEhlRG4yOVA3bGMwdTQ4YVYxc0FrOXY1WXFuaXVCaHZ5QzdadXNL?=
 =?utf-8?B?aDRVc3FLNm55UHc1d3pFVTMvWmxxQkxaRlBkSHpzZnNUZmV1RUtxeUx0azBa?=
 =?utf-8?B?Wk51MGZUK2FJdUY2ZS9Sb0hCTThyNml6eHFVellPNFNJWFV4bndWaHN0bFp1?=
 =?utf-8?B?bDErTDV1dUtwQlk5eXJHK0F0RmpWZGZmaDBBOEJNSTk1OVBMaSt6bnNHWWc4?=
 =?utf-8?B?R0gzM3d4SSthZ1RDODcxQUswL3Z3WFFSWlBWdE55MlpyeHJWRTZKWFc4TSto?=
 =?utf-8?B?ekNHejgyUHlvZE1IdEVDUXNxV2xPK0xRc2svcVZiem9VdUtYbW01eVFVa0ZV?=
 =?utf-8?B?MlhkNHByUFdKOXRrSDJYUXJyNlh4bzhnSmpLVGIrTCtRQkN2L2JxN2tvV0Ro?=
 =?utf-8?B?SDlJOEY0bjVrZURjRGxVanYyRk0xNmFLRCtTTzIvdHdka1p2YURUekNaQXBG?=
 =?utf-8?B?d3NJL0R0bHArdS9ib25Zd0hRRVhPVzNTVFBYVG0rWXE3QkpDQXhOVEZqYlJa?=
 =?utf-8?Q?gQPp/TpIsGN8jgcSrtpvyCnna0rjAXTy4Ymrw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdXbUdmSzVRdWZQdHpqSEdMcGN3Tk1wdUVTMjBqK2xlVHUxNVhyMWppMkpx?=
 =?utf-8?B?ZW04eFF6c0xiU2xMQU9TeXdTamtBMGplaXVGTTZ4ckRlbndNdWt4L1B2MzYx?=
 =?utf-8?B?U3lNaG9xZU5DSHRFWGY0WGlKOFFmTm9vS04xNWVoNTQ0Q043VmNrUnNadHhz?=
 =?utf-8?B?TVZRcUxUUGRNR1JrT0hrM25ReC9ieHNka2p5dWttbXZIZHByMkZ6Q2V4S09i?=
 =?utf-8?B?cVkrUjIxVld6cXBXZGhMQmtLemt2RkpXdVM2TjZZaDUydlZQVElKUGFvYmhL?=
 =?utf-8?B?aDJYYzNJazZiVmEyNnptVnlFK1E3dXErNzZ0TGRTRitMVW4veTFnT0sxY0ZS?=
 =?utf-8?B?VVdrMzI5SnRBQzllMHV0NE1GWVZXVVJTS0xrWmVpNElBVFJsOW1uSExqL2pl?=
 =?utf-8?B?SFNvTloyU3NockpFWVhKZ1phcVlld2UxS0Z4QWU0b05xdmZDQlA1OTM3K2Zs?=
 =?utf-8?B?MFhsUU9peTI4cGxYdGUxb3ZCYWRzVnFGQVZWWmZpVzlNelFrMkVMR0YyUDVp?=
 =?utf-8?B?d2NNNWx2OWNxeFVGbE04MnlYZmhHNlpuNHpoKytiK2ZvYk44YzM4NWZwUG41?=
 =?utf-8?B?SVpjc01tcjFSVzZlUmZveXd1WHRMTTNFRzJOaGY0d3JrQmEraGUzNHdoSmdY?=
 =?utf-8?B?Q201a3ZOSWFDVlEzWWFKR25sbzNyZ3BSZkhhZjVIL01kQS9iV0VNYXZHYVJY?=
 =?utf-8?B?cHJjQVZIems4YnMvU0paWE8yU3B2dmZNbTdGN3cvQWljU0tjeEpxQ3F6S0lC?=
 =?utf-8?B?c2tNckl4Q2szUlo4L0laam85YUFwUUQxak9HQVRzaVBsWkZybzZkYnMxT0pk?=
 =?utf-8?B?OWpXZUFEZVJtTk1EVmVDWThQQWtlZHVRcXBhcnNjOGQvY3hVSlBSalRBREMz?=
 =?utf-8?B?MXBzQmE2RE1IaVpCUFFValdMTjRZOS9FK2Z4aEFRTnZJZ3pkK2N4NWZxTFpL?=
 =?utf-8?B?OEVlM2lZMU1hSVhsdE93SUlpd05jZ1NlMHprRUJLTVRCZ1RyOFZabCtYVUd0?=
 =?utf-8?B?ZWVCNGhBZVlYdFg2Vlc2MWhnUS9OcGRHK25vSTJhRWRVRE4wSUFkSy9JbW5P?=
 =?utf-8?B?QVIxZDJLa2puOEVKSGhjWXFLWXFuOTdBS09OWktOcS9RandzK3lFU3ZRVmNH?=
 =?utf-8?B?NmVCWU5sRndkL0FUUUZ3K2t5dnY2NkxUTmhKZXZNYmZ4c1I1dzFkb1pkeFUz?=
 =?utf-8?B?RGJ6VUpzbEdpSEZSclA3ZHFSbTE2eWtQSGVEVTEyU09wb3ptdG5QZUZwdHZ1?=
 =?utf-8?B?MEVKY0VCRm1vSHE4K3d0akZwTnJIemEwc2tydXczTGg2cU1VVzhDTG84cWlR?=
 =?utf-8?B?M2RjbVBOd281Zkd5VDN4d2NNSmgyV2VrdjZVTXRBS282WTN1Vm5QVFRCSmFI?=
 =?utf-8?B?VTVGWjFrZnM0d3I4OE83L3JDeTRySWVyZVY5U0cwZHpsZ3dGSlFwdXdPNVB1?=
 =?utf-8?B?Qm1GU3RobzR0c3VJZC9jUUFjL3FaaHBNYkdNbWVoU0s0T29GT2lEZVRnZVRX?=
 =?utf-8?B?T1RsaTY3dzhSLzU5Mk9TSmp3dkIzVlRobm1TRHVuZUlIQnh3aGF4Z1UzeDY2?=
 =?utf-8?B?S0JQNEMrSjNyekFLQWNzVGVreG5hem55Y0hIZWErZGo0MUlxMVZSWmdhNWJh?=
 =?utf-8?B?M1p6enVITVo1UUdoZ3ZVY3Vadml1dk5uaHVOQkZuTU11WXVqb3pKZ1k0NFoz?=
 =?utf-8?B?R0daMnRXaGNHYTdLQVN2K1BBU1QwbjE3elJ0dU40OWJSTkdWSXNnYmZCMHF4?=
 =?utf-8?B?K3RMUzNFeTQ4cmlhR3VYeWw4ZGtZNXEyVVRRWGxqbURTUkRONS8xQ2pDM21z?=
 =?utf-8?B?Tm42Y3lJZzREYlM3c25mK2FBeU82SHZzc2VOVWdpUG9GWFdQTW5sT3VNUmV6?=
 =?utf-8?B?UWN1ZDRVbTJ5ZVYvSW1sZWJUSEhqdWk3OHVDVHZQLzRPYkJRTE9wYWlOYkJ4?=
 =?utf-8?B?eUtkbGN6WS8zeWhkQ0Jta1FhSksvVTNSZ2p6WEN3WGx4cFk0VDZ6LzJ3Vkd5?=
 =?utf-8?B?SFpKL3ZsU0Q2Ym5IVVRlTDBvcmg5K3B4RDdQNURkRW1GaFBpWU1wcjRCb2hX?=
 =?utf-8?B?U0djZ1dLU0lRU0NFaDNVVkVtR0lHRnRiTkcyZnlLSXRsVVMwSHlhajREeXdz?=
 =?utf-8?Q?GjQKeh29iBtYfpzqmnmT3uK1n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03C1FD9332ABC4EAAB9E109D95DFAF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ff421d-cbe8-42de-e5bc-08dd02c2fa7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 02:37:40.5350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YC961LW5XV5vC7ml/FuJ7s7aJWBlP4h24QD5fMkEZHdMqY0XUJwYHAMB11vq582umm05R5kcZWAN9Mt78tEulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
X-OriginatorOrg: intel.com

Q0MgUmFmYWVsLA0KDQpPbiBTdW4sIDIwMjQtMTEtMTAgYXQgMTQ6MTMgKzA4MDAsIEh1YW5nLCBZ
aW5nIHdyb3RlOg0KPiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4gd3Jp
dGVzOg0KPiANCj4gPiBBbGlzb24gU2Nob2ZpZWxkIHdyb3RlOg0KPiA+IFsuLl0NCj4gPiA+ID4g
SSB0aGluayBzbyB0b28uwqAgSG93ZXZlciwgSSBwcmVmZXIgdG8ga2VlcCB0aGlzIHBhdGNoIGp1
c3QNCj4gPiA+ID4gbWVjaGFuaWMNCj4gPiA+ID4gcmVuYW1pbmcgYW5kIGRvIHRoZXNlIGNoYW5n
ZXMgaW4gYW5vdGhlciBwYXRjaC7CoCBEbyB5b3UgYWdyZWU/DQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBJIGRvbid0IGtub3cuIEkgd2FzIGp1c3QgcXVlc3Rpb25pbmcgd2hlcmUgYW5kIGhvdyBm
YXIgdGhlIG5hbWluZw0KPiA+ID4gc2NoZW1lDQo+ID4gPiBuZWVkcyB0byBjaGFuZ2UuDQo+ID4g
PiANCj4gPiA+IE1heWJlIEpvbmF0aGFuLCBhcyB0aGUgU3VnZ2VzdGVkLWJ5LCBjYW4gY2hpbWUg
aW4gYW5kIG1vdmUgdGhpcw0KPiA+ID4gYWhlYWQuDQo+ID4gDQo+ID4gSSBmZWVsIGxpa2Ugd2Ug
YXJlIGdvaW5nIHRvIGJlIGxpdmluZyB3aXRoIHRoZSBnaG9zdHMgb2YgdGhlDQo+ID4gb3JpZ2lu
YWwNCj4gPiAiVHlwZTIgLyBUeXBlMyIgbmFtaW5nIHByb2JsZW0gZm9yIHRoZSByZXN0IG9mIHRo
ZSBzdWJzeXN0ZW0ncw0KPiA+IGxpZmVzcGFuDQo+ID4gZXNwZWNpYWxseSBzaW5jZSB0aGV5IHdl
cmUgZW5jb2RlZCBpbiB0aGUgQUJJIGFuZCBBQkkgaXMgZm9yZXZlci4NCj4gPiANCj4gPiBJIGFt
IG5vdCBvcHBvc2VkIHRvIHRoaXMgbG9jYWxpemVkIHJlbmFtZSBpbiBkcml2ZXJzL2N4bC9hY3Bp
LmMgb24NCj4gPiBwcmluY2lwYWwsIGJ1dCBpbiB0ZXJtcyBvZiBpbmNyZW1lbnRhbCB2YWx1ZSBy
ZWxhdGl2ZSB0byB0aGUNCj4gPiB0aHJhc2gsIGl0J3MNCj4gPiBxdWVzdGlvbmFibGUuDQo+ID4g
DQo+ID4gRm9yIGV4YW1wbGUgY2hhbmdlcyB0byBpbmNsdWRlL2FjcGkvYWN0YmwxLmggbmVlZCB0
byBiZSBjaGFzZWQNCj4gPiB0aHJvdWdoDQo+ID4gQUNQSUNBLCBhdCB3aGljaCBwb2ludCBpcyB0
aGlzIHJlbmFtZSByZWFsbHkgd29ydGggaXQ/DQo+IA0KPiBJIHRoaW5rIHRoYXQgaXQncyBub3Qg
dG9vIGhhcmQgdG8gY2hhbmdlIEFDUEkgdGFibGVzIGRlZmluaXRpb24uwqANCj4gQWRkZWQNCj4g
Qm9iIGFuZCBSdWkgZm9yIEFDUElDQSByZWxhdGVkIGNoYW5nZS4NCg0KRm9yIHRoZSBjaGFuZ2Ug
YmVsb3csDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWN0YmwxLmggYi9pbmNsdWRlL2Fj
cGkvYWN0YmwxLmgNCmluZGV4IDE5OWFmYzJjZDEyMi4uZTE5NTkwOTkyOGRmIDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9hY3BpL2FjdGJsMS5oDQorKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwxLmgNCkBA
IC01NTEsMTEgKzU1MSwxMSBAQCBzdHJ1Y3QgYWNwaV9jZWR0X2NmbXdzX3RhcmdldF9lbGVtZW50
IHsNCiANCiAvKiBWYWx1ZXMgZm9yIFJlc3RyaWN0aW9ucyBmaWVsZCBhYm92ZSAqLw0KIA0KLSNk
ZWZpbmUgQUNQSV9DRURUX0NGTVdTX1JFU1RSSUNUX1RZUEUyICAgICAgKDEpDQotI2RlZmluZSBB
Q1BJX0NFRFRfQ0ZNV1NfUkVTVFJJQ1RfVFlQRTMgICAgICAoMTw8MSkNCi0jZGVmaW5lIEFDUElf
Q0VEVF9DRk1XU19SRVNUUklDVF9WT0xBVElMRSAgICgxPDwyKQ0KLSNkZWZpbmUgQUNQSV9DRURU
X0NGTVdTX1JFU1RSSUNUX1BNRU0gICAgICAgKDE8PDMpDQotI2RlZmluZSBBQ1BJX0NFRFRfQ0ZN
V1NfUkVTVFJJQ1RfRklYRUQgICAgICAoMTw8NCkNCisjZGVmaW5lIEFDUElfQ0VEVF9DRk1XU19S
RVNUUklDVF9ERVZNRU0gICAgICAgICgxKQ0KKyNkZWZpbmUgQUNQSV9DRURUX0NGTVdTX1JFU1RS
SUNUX0hPU1RPTkxZTUVNICAgKDE8PDEpDQorI2RlZmluZSBBQ1BJX0NFRFRfQ0ZNV1NfUkVTVFJJ
Q1RfVk9MQVRJTEUgICAgICAoMTw8MikNCisjZGVmaW5lIEFDUElfQ0VEVF9DRk1XU19SRVNUUklD
VF9QTUVNICAgICAgICAgICgxPDwzKQ0KKyNkZWZpbmUgQUNQSV9DRURUX0NGTVdTX1JFU1RSSUNU
X0ZJWEVEICAgICAgICAgKDE8PDQpDQoNClRoaXMgY2hhbmdlIGlzIG1hZGUgYmFzZWQgb24gdGhl
IHNwZWMgdXBkYXRlLCByaWdodD8NCg0KRG8gd2UgaGF2ZSBhbnkgdXNlcihvdGhlciB0aGFuIExp
bnV4KSBmb3IgdGhlIG9sZCB2ZXJzaW9uIG9mIHNwZWM/DQpJZiB5ZXMsIHdlIHByb2JhYmx5IG5l
ZWQgdG8ga2VlcCB0aGUgb2xkIG9uZXMuIEFuZCBJTU8sIGlmIHNwZWMgY2hhbmdlcw0KYW5kIHRo
ZSBiaXQgZGVmaW5pdGlvbiBjaGFuZ2VzLCB3ZSBzaG91bGQgaW50cm9kdWNlIG5ldyBNYWNyb3Mg
Zm9yIHRoZQ0KbmV3IGRlZmluaXRpb25zLCB0b2dldGhlciB3aXRoIHNwZWMgcmV2aXNpb24gaW5m
bywgc2F5IHNvbWV0aGluZyBsaWtlDQoNCiNkZWZpbmUgQUNQSV9DRURUX0NGTVdTX1YyX1JFU1RS
SUNUX0RFVk1FTSAgICAgICAgKDEpDQojZGVmaW5lIEFDUElfQ0VEVF9DRk1XU19WMl9SRVNUUklD
VF9IT1NUT05MWU1FTSAgICgxPDwxKQ0KI2RlZmluZSBBQ1BJX0NFRFRfQ0ZNV1NfVjJfUkVTVFJJ
Q1RfVk9MQVRJTEUgICAgICAoMTw8MikNCiNkZWZpbmUgQUNQSV9DRURUX0NGTVdTX1YyX1JFU1RS
SUNUX1BNRU0gICAgICAgICAgKDE8PDMpDQojZGVmaW5lIEFDUElfQ0VEVF9DRk1XU19WMl9SRVNU
UklDVF9GSVhFRCAgICAgICAgICgxPDw0KQ0KDQphbmQgbWFrZSBMaW51eCBzdGljayB3aXRoIHRo
ZSBuZXcgTWFjcm9zPw0KDQp0aGFua3MsDQpydWkNCg==
