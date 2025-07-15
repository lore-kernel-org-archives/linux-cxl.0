Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC23279910;
	Tue, 15 Jul 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597898; cv=fail; b=T5Fs8/vBA8PLhkfTngAkN/bV3gC7YErN3sKgV0OybZ6axfDUDzuC8fLcifRbDJKIph5R2upHM+X1gTmu0m/CUxC1rST8S7tq4RPc7bIKx9XGdnCJBMj+4EX+xca8C5vVUVDGWQqhwyz5sbj2nJqhqm2JKuBiy+frS1AkhuOZeLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597898; c=relaxed/simple;
	bh=ird+IyIYhuKCi3BebWyMZh1fnFRk5PNypPXvaf5vA+k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nEXCP7KvyBvpmRAeqsBiYH9jo8bu6X2hcIg2zITDhLsR08mFnl02/1gzZAvZpyorzRtnREc/Db0hE1mtem+nK9LbO18JwlgBjLNBVmaRlNsO/7+ezF/VB4RoXES/oliTYHu9IanD6E45FAuDqUFHijRAu0LYp9qO7XxjyAtmaMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvNI3Fhz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvNI3Fhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752597896; x=1784133896;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ird+IyIYhuKCi3BebWyMZh1fnFRk5PNypPXvaf5vA+k=;
  b=hvNI3Fhzc76haEjWao7JgGUbaotZyw5LEpT9lWzUnCMwAbC8W/MwDubn
   zFSUs2RQblBSwf2gQXIGLwoppIIpCYCqXfS0oTjqMKB9elRGRVbDBiNRU
   7Rc6atY78aA6YxFWDBssA82q2OXKDVESO1h3xhCUwV07iEJaq1qErwMf2
   ULgo+ZQUjer6Ivo20ARckuvCwJAGTP/8UcxVSGWszYgRxgwSBhu1A7veM
   3FxSapBspbAmA/uRdvUwNws2j4a49PRrJG7E51YbBMMFVoWeKzpry+nPj
   ASH/3oHlGDpBssM/EjInl1JmQHA04xciZUEmHEIt1vdwgXMDtCUxKq0Jm
   w==;
X-CSE-ConnectionGUID: frWbUnTIQOOBo3r/r/kPow==
X-CSE-MsgGUID: JyIJaozuQUSaeeX2JQj6Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80270229"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="80270229"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:44:55 -0700
X-CSE-ConnectionGUID: 8lP2YM3jQbSheom79+EjxA==
X-CSE-MsgGUID: PAZLT+i4Rduq6cbhZkdOdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157997611"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:44:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:44:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 09:44:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZgTF0txdEV/xcelkSzygU3L47sDlRtE4ZXcUAjsfgsf9cEfS5ATJA46EzJjZXFBWpRVyUMW4WLfW1AUS2NyDRQZ1X1Oz7DW7ARTBdX+UpxRd+RYCnYHaKxDtIAARVdiy5ivFItOsOuFhjxOBxT3/oiNTnCaE33jXtVdP5ChVduux8w9at/x1ZekoOruhe18heEa83YHf8K/WgStqnD7Y+X2jjegCZjepFJJXTYteBhtIlhah5NZFGrbA7PHoGr0+J00mPv0fLzBo/VVnKO3gDVPrYml3WQJ+z6lWipokglwuMwMEv2eaBgamwDK3tBiATSfpxKor62tjm707a2NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlcAyfB3vxS6h+tm/pp9QsjUwTdHGOWlUrwJ+9fqSiQ=;
 b=AR1RIkSrtUJwnjwkusG5QE+9oYrPcsiWWZwnemnQBiBc4WYetuKRehMdOsGYGfdple8paN+2aDDHaEEkSUL1CeHb4qfUpPIoHaSWCJSXB0AO+6aNYqxldVbza3QZN5Wgwrudzow8380o8GC+6JkAIwdCX47CoJ62rWq8xobSe0vSCYqu3X5cErLLkl13imwhktcGVCjc6JlKDJ4cRHWE5G+sr8/tbzejYy1/kYtBLvmU9XG6EdUAKXbiIqEDclkSKW0cQG/wVtqT1ETQ/Si1ON8AQCJfG/JJTD8QX4jU9DHq+khW1qX9wKyIEDMmUquE/IEIygal93aKMEtRzFqo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 16:44:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 16:44:31 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 15 Jul 2025 09:44:29 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>
Message-ID: <6876856d329fb_2ead10062@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715165607.000036c4@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-8-dan.j.williams@intel.com>
 <20250715165607.000036c4@huawei.com>
Subject: Re: [PATCH v3 7/8] cxl/region: Consolidate cxl_decoder_kill_region()
 and cxl_region_detach()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a7f41e-bfd5-42dd-5d7f-08ddc3bedf61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDN1Sm1hWFpJRDQ0SDVoZkY4c1JmbVQyN2V6RlVoUitGRzlDenhudGloS3N6?=
 =?utf-8?B?cHlTZjFreERuN1FIYzNEMytiazB0S0dNdXFLdW8yRExrR3E0dE1BV29pSWdR?=
 =?utf-8?B?bnJGSG9nNldRRU1DdTVacGZpMmttODhWTDUvV2x0YkZxRFQ2MXVJNDFML0Vn?=
 =?utf-8?B?WWVEaWh5dk9UeCtXWUF2UVk5K2V4bmZqbHZGenZOWDNnUVRVZlpoNW9SOXFu?=
 =?utf-8?B?THB3YWF4T2txU0xhMFlZZXlTTHRXN1NZd2dFRFdwQllLU1lMaG52aW1SdVlD?=
 =?utf-8?B?WkxXaVFwU1poQm1DT3h2b2pkUDZiT00zRHBiLzdzM1JUVmRZNU9RcW5LTnhG?=
 =?utf-8?B?RGQyRXNKYzM0L1dqcjNsdlZNanR6WlpSVXcrSWo0UkpIVTkxbWp2RE9ETlk3?=
 =?utf-8?B?b05OU1ltNTRQY3NCbGVaSHJLandZVzlkTk80U29icXJRL2YyaEtqTWFoMXVn?=
 =?utf-8?B?aklZeE8wZ2NGRDFaNGRQUGpzaGNoWUZJcWttNmhzUWtrNmhKK3dqTVAxMGM2?=
 =?utf-8?B?R21JZE1tREwzdlJ4R3plTGtldHlYMlhQcU5zY3U4dU0yS0V4NnlrTGI5bGho?=
 =?utf-8?B?dDFYR1A2WXlXNStuZWZKbWFhRFMzQ3h2SE9yRVN2amt2aVAxNXlyeW9TT3Zp?=
 =?utf-8?B?c1F2b2pqMllkSlNTb1c2VDViWi8rcTBDOHc0K3BpUG4vRWp0WWdJR0JBWXNa?=
 =?utf-8?B?b1BqNHpZaVFqR2paVWZoL2ZndzJwa0ZXaXVWbTErQm9NVVV3UUZQK2cwbTVY?=
 =?utf-8?B?WjRBLzl1bFJXZ2l6T29kQ1ZXek5xc2NWc1ZodzlHcEhkTjZUZlZVVmtxck5C?=
 =?utf-8?B?aWpqVTA4S0VSYTIzYTg5MmhnZnRYclY1V20vdGl0Rm5ycTNjOWZnM1E2bURt?=
 =?utf-8?B?OFQ4emtGMnRENW1NcEs0VllxQjdVVUVveUl3bUE1aTFzTEVjM2s3V3JMTE9k?=
 =?utf-8?B?SFZZTHFiUldFdDlCV1BQRkdsYTRRaUNmRVNkd2NaL0pVekpBYUFBRThUSzh5?=
 =?utf-8?B?Uk16ZDRlOXpabU4vNGliWEVMdTVzYnJsK3JQRVFrSlk5ZnhGNTFEWTZIb1hI?=
 =?utf-8?B?RCszYTZQbXNOeC9LSkpUNVlFbkR4RXJjbzB6c2dxeitiZmk0Uy9oejV2WTlp?=
 =?utf-8?B?bGw0S1NGSGo3WDJRcGN6STNZT3BORTcrK2tFaXpCNjYzNG5GaFZINExMUll5?=
 =?utf-8?B?eE9vcTBkZUkxMkRDcVhWamdGQ1BpZ2RYUUpSS3picEFOUmc1ZW8xdmlxdWM1?=
 =?utf-8?B?cWlwVmhqL2E1aW96c2FXbHQxNUkxWm5TYW1wTzlodnYrUEgyNE1Ld1lwRGZV?=
 =?utf-8?B?d3FSSG5DNjFzeTQweGNFN0lBNytOdnp5MmppNzZXNlc0c3hLUTZZdUpOSGVl?=
 =?utf-8?B?cVgyU0p6TEZyMjlmc0ZXQ1dDYWxJQlpERW93enJZeUNobDBndmxGb01NYk5y?=
 =?utf-8?B?YkRqd1NOelhsT2xQelkrQTBqWkhwam9ncVJiV2gwWlVTZHgzZkNkcHgzTEls?=
 =?utf-8?B?MmgxMmsvekczTjNnUXRKVkRwU25zTTZOZXJqVk95NnFRUWNaZ0Z3K1ppbS9s?=
 =?utf-8?B?djQ3RS9ZSVlDN3J3ZFBNUFovZzJJNm16UjJPNjJZSlROY0xQVW16M3dQN2lS?=
 =?utf-8?B?ZFRCbm9WMk5wa2NhRWVZYUdiRGxxTldYOFNrWlA4QzhLa3p6TGc0U3JDTHFq?=
 =?utf-8?B?dWZqQWhkS0pTb1N4V1QyOW5nTWsrNDJkbkU4RkcyeVVQSnBESlRnN3V1TzFN?=
 =?utf-8?B?OGFSK0oxR20xZERSemoybW5NQXpYWFlVbXJsMjRERi9LR1Q2eHpZaUV3bXdy?=
 =?utf-8?B?OWJ0UHpPTEV1cnlZTVZuNHJYNm9vUjJwa1BVZTRidWxVeGEwclUvT2pyRDRa?=
 =?utf-8?B?TUV0TmdQZzJYOWR0UjZHeWN6V0IvL2hDdFRmUy92eEtOa3ZPbHdOelZCQ3Q0?=
 =?utf-8?Q?/+ZEskqUg8M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThtY2txMmZVWUZlZURML24raWUvdlJKWG9BZGlhclNSdlZEWFhaL1dFRzBO?=
 =?utf-8?B?ZHJ6cy9lREZYZVRDU0s4YVdNaEN1NjNvY0pkWVlTOUlDUzdUeDN4cE5OU2gy?=
 =?utf-8?B?MDJGTFVoOFgzdm95dytQNkxYenNJTU9WemdpM05ZOENDQm9GYjh5TXZxUDVv?=
 =?utf-8?B?NnM1aTBlU2JMMko5YXo3UjY4MjdwRU1kdGcxQVdPN3VrOVYwWVJwbW9BLzRi?=
 =?utf-8?B?RGJKZGlzK0d1eTUvVmhObmJkandoZ0EzV2RkNlJOSkxlMTVjdTU3SHVud3ZX?=
 =?utf-8?B?Sll5YVVDK0VKcno5N2x0WThCaVA0UE9zUUpWMWFhbU84YlducmdKMGZ3Tlgy?=
 =?utf-8?B?RGpscnMzREE2YloyT2pBdGgyWEZqVlJWbXgwVFhpNzNzRjh6MnpNNmhvSUQy?=
 =?utf-8?B?YXBYQ1E2SmhLaFA1MjUyaFZuOGFOdnJXTEtIYUxrODJyR0N5SHRMaTU5a283?=
 =?utf-8?B?ME5RSXMxVGpSR0VhY0JTSnpSMm5FZ3dMMTdBeHd2QjQ0ZWxDOUtuZzFWRnlM?=
 =?utf-8?B?ckU5TzZleDhvUmVxRVRIUC9Pa1JYQkNja0kwQ3hBZzcrck84ZEJSNDdpejZZ?=
 =?utf-8?B?TGNIZElRYzFwaTJhRTBpUnpnMER2bXp3RjhMRlZLQ09ZTFIzNjVIenJ6dUpj?=
 =?utf-8?B?Rnd6cmQ4TWVHVG1WbjA1dUw0NFgyZ2xqaXhJYlJPRHN2cWJyZEs2cEZsMmJ1?=
 =?utf-8?B?TjMrdjl0YWhUNkdxdUFaN2RweThGV05lVkxneFpyZDB4YlZVMTNsY2tGWXFG?=
 =?utf-8?B?VEE5Q0RJQkg2ZmMzNjlZb21JMGF0dXRsSFo3alR2TEpSbWV0SG9LeEZxUjFp?=
 =?utf-8?B?dDRDQWRIa3RSZ01pczVUeHQ3ZnZFcnBJcUZPQVRnYWMyMS9nZW5yWDVMRDl5?=
 =?utf-8?B?aWJCQitUM2JPdmVCMlFvN2NUM01oVXhzRnhsd0tZSDdZV3VianR4NmdLaU1H?=
 =?utf-8?B?MGRaa1FoRXdvblBNeEFKNTUzci9JQ2NwRUdtOGJkSEdhU2NkR0ppanl4V1Mz?=
 =?utf-8?B?UjFtSXcwOHJOSFBINnhRdEdMWXhiVFIvR1JybkhraElGT1hYNkFxc1V6SzdB?=
 =?utf-8?B?SWZoR01iS1VXbVM0RktpdE44bkkxMFpETzc3UDloTkNaLy9FWXRnRmdCdDR0?=
 =?utf-8?B?K3lMK3dtTHVmZjZmN20rSElGT0l6OGxDU0NiUzVtLzJRRk84NXRnazdkRGNS?=
 =?utf-8?B?SStEaDN0ZjBiVVp5Vnc0MTB3U044azNna2ZES2k2eFpkOStibElVcFIwU3lR?=
 =?utf-8?B?cHlEdm42R2NlLzd2cjlpYlNSb1V2S0RQaUhnRngrOCtFY2tqUzFPelpOa211?=
 =?utf-8?B?M2tQT0o3WlNlMU1sOXVPSmV6WXNjVEtMM3dkR2NzRVFrRmF0UGI2cjJXTmR5?=
 =?utf-8?B?WExyU0R5N05SNS9ydy9KbnBQWWtmYWRmY0pmMUJoaE5STlAzZ0dFclNmWGhu?=
 =?utf-8?B?L0piUm1jMmZzRmVvREhJRzZyTERnT2ZWTURjS2xhRlBnT2FlZExvR2s1Q05w?=
 =?utf-8?B?dG5PbitWVXBhRks1OWczWlNtOUd5SVoxY040UUIvc0VUMmFIdVgxcUxUVFF5?=
 =?utf-8?B?ZTlYRlNhUU9Kb2lxWGFRZFM5eGNaUVprQkhGeDRrRFFvR2ovTlkwaW9KNE5u?=
 =?utf-8?B?Q09KcTNhU1dLSWdLRDJ5SllpL0tJVENhWUgyVGl6TnA3ampLd0dsMlYrakFF?=
 =?utf-8?B?U3dYK2JOS092Sms2aXBzMDh4MjJ5Qnd6VjdobUxpd3dzbkJIMDNFVDA1QVNU?=
 =?utf-8?B?WmxLazJUaUlwUU0xQVJ5TjZGakEzZlQ1Y01GZzZNSFZqUXQ5ZTBxNFRjNkRw?=
 =?utf-8?B?T3lmYzI0S2xQa1g4T2ZpaXZuWDJkeXl0UGVrRzRyVy9CYjAyek1SendDUk4v?=
 =?utf-8?B?SU5oTjZ1WThJSUFqaVg0MGcvazNOcC8zWFV1RGN2bTJnNUJMbUFVL1pRenVI?=
 =?utf-8?B?cUIyVm9tUURwdy9WVmtraVg4UjdzN0ZjclZVbXlvaTF3anltMVlKelhmWlZr?=
 =?utf-8?B?WGF5RDl3Uko0R3VBRU96OTVTdUI5bEZUOXVEazYwK3B4THFtMkVqUDRxL2Vp?=
 =?utf-8?B?TlpNemtYcS9ORm1nMldlWUR6RndjV3FUUVkybUJtU0Z1dDZTcThnSTYwQ3F3?=
 =?utf-8?B?MzlDQ2JjdTc4ZnZoNlV5Qjcyc0w1Y21uUCsrQ0E4anNzczZMRC9xSXFxNUJs?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a7f41e-bfd5-42dd-5d7f-08ddc3bedf61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:44:31.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTLJANidxkiTtmAmTQWfQV7Mfm0o4cV1KaqYcpEbjT+YY+ACqf78mNbMUk4tExiO5FTQDoRcY4zqJ49SBaeQEjH4VEiwtu8OO9V369Wka98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 16:49:31 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Both detach_target() and cxld_unregister() want to tear down a cxl_region
> > when an endpoint decoder is either detached or destroyed.
> > 
> > When a region is to be destroyed cxl_region_detach() releases
> > cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> > 
> > This "reverse" locking pattern is difficult to reason about, not amenable
> > to scope-based cleanup, and the minor differences in the calling context of
> > detach_target() and cxld_unregister() currently results in the
> > cxl_decoder_kill_region() wrapper.
> > 
> > Introduce cxl_decoder_detach() to wrap a core __cxl_decoder_detach() that
> > serves both cases. I.e. either detaching a known position in a region
> > (interruptible), or detaching an endpoint decoder if it is found to be a
> > member of a region (uninterruptible).
> > 
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> One query inline about what I think is a change in when a reference count is
> held on the region device.  I'm struggling to reason about whether that change
> would have always been safe or if there is another change here that makes
> it fine now?
> 
> (or whether I'm just misreading the change).
> 
> Jonathan
[..]
> 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index eb46c6764d20..087a20a9ee1c 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -2001,12 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
> >  
> >  static void cxld_unregister(void *dev)
> >  {
> > -	struct cxl_endpoint_decoder *cxled;
> > -
> > -	if (is_endpoint_decoder(dev)) {
> > -		cxled = to_cxl_endpoint_decoder(dev);
> > -		cxl_decoder_kill_region(cxled);
> > -	}
> > +	if (is_endpoint_decoder(dev))
> > +		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
> > +				   DETACH_INVALIDATE);
> >  
> >  	device_unregister(dev);
> >  }
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 2a97fa9a394f..4314aaed8ad8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2135,27 +2135,43 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  	return 0;
> >  }
> >  
> > -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> > +static struct cxl_region *
> > +__cxl_decoder_detach(struct cxl_region *cxlr,
> > +		     struct cxl_endpoint_decoder *cxled, int pos,
> > +		     enum cxl_detach_mode mode)
> >  {
> > -	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
> > -	struct cxl_region *cxlr = cxled->cxld.region;
> >  	struct cxl_region_params *p;
> > -	int rc = 0;
> >  
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >  
> > -	if (!cxlr)
> > -		return 0;
> > +	if (!cxled) {
> > +		p = &cxlr->params;
> >  
> > -	p = &cxlr->params;
> > -	get_device(&cxlr->dev);
> 
> This is a fairly nasty patch to unwind and fully understand but
> I'm nervous that in the existing we have a get_device(&cxlr->dev)
> before potential cxl_region_decode_reset(cxlr, ...)
> and now we don't.  I'm not sure if that is a real problem though,
> it just makes me nervous.

The reference count is not for cxl_region_decode_reset(). The reference
count is to keep the region from being freed when the lock is dropped so
that device_release_driver() can see if it has work to do.

The lookup result from endpoint decoder to region is only stable while
the lock is held and the region could be freed at any point after that.
The pin holds that off until we are done with the potential follow-on
work from detaching a decoder.

The reference is not taken in other paths like region sysfs because
userspace activity in sysfs attributes holds off attribute
unregistration.
