Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365427AC48
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821502; cv=fail; b=ssYAEEUfdqFDqakuaPLb7+SbegEjE1JOQNf3SbhUruxHhD3YQKIxGWhBEa+QmJVCUrDVmJp8YDGaAWnhxgcVh9OIc7HFOeAhV3r7Wma69mRNB7itzEPJGbMcKOax1MQt/JhNjz2EerORZoponFHN1sJweDRIe5t2JrtE5i6OvIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821502; c=relaxed/simple;
	bh=0hVLypeRty/+NSE4gajE0eLlNOj+AGn74om4kUHGK0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=on4IuxxAqeLWDmdJH/zYsC66yC6dhSDWsQzZ8Dudclps/igxvEPXD1DDjkCypWWxYNq6zJa65956eyvcLG74A+5hCjsOWQxIiKYhzs8c6aji7SgO7QcRJ5a4fPQxMQBFC1iqtW33LvD288L3T9qOLBxFwNGNGL6Ag2ddCn6yGJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbdCTqfx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbdCTqfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769821500; x=1801357500;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0hVLypeRty/+NSE4gajE0eLlNOj+AGn74om4kUHGK0o=;
  b=cbdCTqfxzqypzWaUAcHgzfJcK9xeKpGmnDojFUOl/Z9m3kjpeM0cAvXM
   t6+BDEHB+D+JRHLVetGrA7/VqKa3ZPoA2S9LHne8/RYH2eR/chZ63r9rl
   XBVLIXHxEDSHPHM1RyBnDEBeJghxVMejvHdt6qs5qNYPykukj0m2yELbC
   3q38qo4uBiOqNgLxnXu1Gheup0BfjigJUX8vYDMtVpt1YsHpwC4WiRUbu
   pEuWKZOjE8sQuoyg9X5tRHYVokkTR4HWZmNAtBEozsZfQkShqfqD6JxhZ
   4LT2LJH59AWh/vcKEz8gXr5Y47+TfCC4OGa76y8aJDf5gcjb2YTQCZ9c+
   w==;
X-CSE-ConnectionGUID: 73LEVD75SCahwNYSeddvmQ==
X-CSE-MsgGUID: CnsplhU5Q8etDD8QtXvUkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71057938"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71057938"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:04:59 -0800
X-CSE-ConnectionGUID: TJZnJ97fRYqsBofAjwbedg==
X-CSE-MsgGUID: jqlUznk9THG4Tw1INTgfBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="213491768"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:04:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 17:04:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 17:04:57 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 17:04:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkMNTOvnDGa40XBVqNPZKlsiHFlF1je9ikJtTL3+LOhaA7oGVVmkDrSYCi4B2it9K3EfRSiYblbMn9UtoEQ+lgP0kYV5IugFc3/615EZR7BlTj6OxHaF/TLx1xMaeQhF/4j2Dly8dF5kS5wS7ELzREFQ1YmedAGDLnC88yPTXCUNaarFItZ1IxbDVn0R/G/Ck7PInKE2CSQZyLAhGUkXkPRsEWzat9aTFmCbJWQ8nwamb1VIk4aPlOUv8xG5nt9Z3ySv7V5I+oM0qRGNWILeQBw2a1qVIsBUg7DGUMYvwAjoC+oucx8fpKz+J7PYzkGQtPwPnS11mvQO4mUpoY44cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHLvjKl98uxblIR+pFZjgxp+mcXSZBuKOtaZeqw4nyI=;
 b=HM5EMNvnXFcwsHtTDdW9N7uNN808pGIigz77k2h6FB2er5+eZQBIYbo92R/7W72Zs9Or/jyxfUPfoJ1cTqx1r9BRqM/wdnJebbsTOVULjisfno2FjoLJ5x4tgV+rLH6yE/xorpKd4W/OVP1/aCMthWQrrcu+3fcxiPLkjI9ldmuTanxg5Hokv0xQn+X7n14sr/b0xZ9WSbIliQxdv9WXnZcEmaPG7ifnxdHL5FLnk7ZqlcZfqSM+7fXOp2yF6mrPplrG3SQZfvnl1ud7KPxfv24ogNY8562lq5KEt+5CDuzhLUUF3WgjeFlBJ6hhosFwJ9KhthQmPjTdJt0f2CAM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SA3PR11MB7584.namprd11.prod.outlook.com
 (2603:10b6:806:305::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 01:04:55 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 01:04:54 +0000
Date: Fri, 30 Jan 2026 17:04:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>, <gourry@gourry.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Message-ID: <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SA3PR11MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: fd72ab94-a9e8-4837-a3c0-08de6064be95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGZFS0dCSmdVSmZ6TXFJaDB3UERzTE0waDkzd1JzSkhXNWpRT0xPeU1aVC82?=
 =?utf-8?B?Y3hFWGEvK2NiY0c5RlowN3UwT3pKSDZoSUxmTGsweGVnWEM2RnpOTjdRS0JX?=
 =?utf-8?B?QXNIWlI3dEJxZXprUG5CZWh0Rys2UEF3cmhjbmdOb2hSN09GZlc2L2l6R3JI?=
 =?utf-8?B?OFYxL0haWGVoNnFSUHVxZTRVanhReXNBZWVjcnlXNWluSlZncjEzZnpaMkN3?=
 =?utf-8?B?NnYyVnBUaVA5bitMWk1QaEpkY2w4RWRTMXNOdXFwa2I0MlZIdkRlOXJHTmE2?=
 =?utf-8?B?aktWdWZpbWFqc2JiYmpmUmEwY3JzbVRmaTRCM0RyREF6Tk1sbjRDZ2tDK0Q3?=
 =?utf-8?B?QzM1a0NPeUdBQUhwRVBNMVM2UDRCbEhneE11cE83U1F1ZG1jS29nQ3ZKU0ZR?=
 =?utf-8?B?LzIyNGNkNHZFKyszd3kwRHVaNnBVcGdXRTdsMCtPZ2dRazJaSUNaUVlJRnJL?=
 =?utf-8?B?aXFYbHh4bVFQUVdJYTJnU0p3Rm1jMzVMVkdZTGlHL3lUZnJrUVRiUm5aZno1?=
 =?utf-8?B?cEd5VTdYODRrS21qb2N4dk9Yc1kwcDVFSnd3OFlwM3VZZENEWTdxVTdnOXkx?=
 =?utf-8?B?eFV6aExTMU9maEpIR0pEbHY2cWF0RGFiRUFOS0JaVGNuUWFialFtOFlQREE1?=
 =?utf-8?B?cVNWTmoxRUFxUVBhVHB6S1VBWjNCcHdnbXB6MndWSjc2N0ZpdnJuOGc3K2pQ?=
 =?utf-8?B?dXA4VjRkUllwaDh0Vk1ieHBhbVo1U0Q4b0VLck9UdHhXb0xzRHpJdFRzeWZG?=
 =?utf-8?B?QjNvNEU1MHhMV21MY1MzL056LzBnMXNRMVF5ZDJjNzY1bFBTUnN4R0g0OHZM?=
 =?utf-8?B?WGp5UzNOZUhHdCtFRFFnd0pwdVNQVHhGRUN2eEQ5ZXFLd3diQ0lDcWlTc0RU?=
 =?utf-8?B?S3c2TmtyYUUweGhPNi9oemViSEN6WTJVZ1lPb1dGclg1YitOZjBlZW5mTzFj?=
 =?utf-8?B?d3NRdGZZbmVtREtyRmxTN3VHZTkwazY5U2JTU1dnU0xzc3E2R3c5V1dheFNR?=
 =?utf-8?B?VG5hVHh4ekNHSmJ1VS84VFJnbHAvZms0dVpxOENwK2RwT3NnenN6Z3BvRFcw?=
 =?utf-8?B?TXFZRXVnb3JZS1ZiOW1iQUZRVmp3d3N6VTN4SEJyZkVRZ1Z0aWFvMzJ1MW01?=
 =?utf-8?B?K21DOUNpK1Z1a1FSTUpyT2hQSDlIYlVXR3g1UVZUYWEvRU0vY3VxaXUvRlMw?=
 =?utf-8?B?eks2N3VMM0pQa1RCL2tuRnU1NWlvRTNoTmZ2empuZ1Q4RmJkdXdEcFBWT3ZS?=
 =?utf-8?B?SFFhRThnK2szWkY3R29DVGJOMmlsZlNOSVc1S1pveUxOdS9tRWVxcVJDdWMx?=
 =?utf-8?B?Y0IvL1Y1c3hGdEFNN2MwZVFOd3dENDFqMHhoZTVqWk1LNFF2UE5nayt2dHJF?=
 =?utf-8?B?OUViN29BcTlhNms3MFB0clZGNDhtdHJKSHFlLy9PSVNDU05aOHpMS2Q5TFUr?=
 =?utf-8?B?VkViZHRMbk0rbjRmbHQ2WGFyRTV1U2NYZFlXQjVjUnlpK3VOQVlaSElhWSt0?=
 =?utf-8?B?MVo0ZjRxYlI2WUdPSExTaGtrRzNnd3kyU0s4OVEwQmkxdHZnemM0MzNZYlE5?=
 =?utf-8?B?Z2xlT0NrUWlBQ2dFTlN6S0E3Ky9FWHdnSTU2ektHRjhOTFc5dVJIdWR6SjdX?=
 =?utf-8?B?Nkt6Y2JjSWRtK3E3ZWlHMStuWWNhdlNBazlLK0MreHdtMkxMMzNoYklkYjdo?=
 =?utf-8?B?ajNHRm9MeTZGT21DeVZoVXJkM3F6eU1JeEkyQTFJeXFSRFEwOTNubStsU3VB?=
 =?utf-8?B?bk1LWGZlTGN1LzB5UiszbVBJVzQya2l0WmU2WXR4ek5pL093b25walBFOUpU?=
 =?utf-8?B?UWhHV1dXSTVyQmtYbWo2Y0c2SG9yemgvTnh1amNMY0hvWDc1amdKcDdxSDE0?=
 =?utf-8?B?OHhRYlQ2eG1FeFNWR3cxNE5QTVlQb09VdnlwTW5HcUNzZjYyUGdrN0FCU09y?=
 =?utf-8?B?YWRHZ0kzV1A1ZDF5OWRqSGZCaWJMN214ZUdzSVNPeTNQaTBrSFpNK05Vb1lF?=
 =?utf-8?B?SksyR1JrQ212M2dHRmZGMXlTU1BON3ZKNGp6Q05PUDI5Wm13b0NmNExNZ0J3?=
 =?utf-8?B?S3gvSFN6Z1k1RnVUdHU5N1RxMzVBdUk1TWYzdGUvbzMrbHJ6Zm1yZm40bXJm?=
 =?utf-8?Q?JQ7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFqbXYyOVZqMEJiY09VSy91RUI2d1F5Q0ZqcDdZQnZUYlRMZkRQY3kyNXgy?=
 =?utf-8?B?QkE5VzZaeEFkdVFFWTVhL2lZNEgzK1pCRkplODRLMFJwbDcwekQ4cGtweDF4?=
 =?utf-8?B?VUFJaVR2eU1MR0ptK09mN00venZDVmd2anFacjducFF1YWhlRzgxeTUzU3Mx?=
 =?utf-8?B?bjVWYTAweDUzRHdMWmhzMWpVTkt0ckJIMXM1NGdKZktLWERWLzJ4dVRCSFFv?=
 =?utf-8?B?cloxZ2ZFdHVvSDZXMlphQlV4K0FSenpUcW1MUXZGYWsrUU9KZ3M4NEJxOFU3?=
 =?utf-8?B?Q1FLN0U0cTBKRWhETDNQdURtelZtOURXSTU1RUxscnJId2I1aVhreDdqSDIv?=
 =?utf-8?B?RFV5M0tzbmVaWER0WDkrV3dPNDd6MFdHUVNSMDNyaysyVVY2bjYvMzJad1lF?=
 =?utf-8?B?M2RZSlFBYUV0c1hjbDAzR002cnhGQ1B1aGR1a0hqLzJnZzF2ZHJtRVM1K3RR?=
 =?utf-8?B?RXVOT29pZWtlcFFMbHc4OWwybC9DVkE0R3FZWllrVFg3ckphOElnNDVVQ3V2?=
 =?utf-8?B?aDd6WDBhbC9jU01RNVdTQ2JHRndpZVpBdDIrdDdKWVR5QlE3WXFUTnpKWlpa?=
 =?utf-8?B?b2UwQ3YwYnFnd3JsNmY0U29vbGlvdU1HckFZYUlQTzFSUmNTMER0UnlLYno5?=
 =?utf-8?B?WFUzRGlObE5EcVpnbkFBb3VRaEg2NUt3NlRVYzZhY2RqSk12eUFYZWIvRFk4?=
 =?utf-8?B?OEpRZytlV24vaG84RThqUTh2SHpjbktYdlhQRmtrME96eEo0N21POW5FUURr?=
 =?utf-8?B?NllHWFNSRXJuMXhNZ043TlUzS1ZLazFTVmZQQldueVhXNlFkTElZM2RhdWtq?=
 =?utf-8?B?SHhuUU45alRHcDBpRXJSb0d4ZU5SZjR3RC9sZksyQ2Y3UkRPUlh4UmhrYTJn?=
 =?utf-8?B?T0FZTmNHMTg4Z2FGc3FvT3A3Rks3V2FvKzRscUxEZ25WdzhCODdxNGluWkg2?=
 =?utf-8?B?RDB0b2wzdkN6UUNEc3JIdEphVnAzajF0NmNGOVVuTjJIY1dGamNVcnZzZ1Fi?=
 =?utf-8?B?Si9oLzhYVDF2TEZ5cFBCd2xkbzBIeUhVTk9wWGJqL1FtRXhINURWQ1FRaVVm?=
 =?utf-8?B?TWJPZnkyTjRVd3BCZmY5ZHR0ZXhRZzlESWdIYnk5NHE4SUgyVWE4V3BMVTB4?=
 =?utf-8?B?U1pzTmltb0RsWDN0UjFRb3VCdnIwaWR2RWJFV3pHdEVBN2ZwNW8rb212cmR0?=
 =?utf-8?B?bmpRajRZL3RpcmErZEp5K3JlYXdKc2dmdDl0Y3owa05wdjdJbi9VaFlNak9Z?=
 =?utf-8?B?eUdWdzRFUTZmcW9ITVE0cHBJY2lhcTVEMm1oVVJRVUxQdFBiSTRNb2pJZDhY?=
 =?utf-8?B?VjdocDZmVU50SEVkckxyZFJyUzF2S21Va2dXencwak84TWlINzdTcTBiYUlC?=
 =?utf-8?B?OGszZHkwMlRya0tDOERqQzlEeFVhVCszblRYU0ZmWGNMZ3ZJVnFOTkNsNWxr?=
 =?utf-8?B?OG01eUhWeDJkVnl1eGVKUVI5cUozcTdqaktXVi9OL0o1MlBuekF6NW9WRzBC?=
 =?utf-8?B?TWsvYytDYklmYUE1OFhFSlhESGJwVlcvbE1MWGZEY1J3Uk1IUjFobUpOMkdq?=
 =?utf-8?B?NWdQVGFMWFowakJwa0RibjZIVG93TEYxcFNBTW5VT0xYRFNJL0NIckt2MUV4?=
 =?utf-8?B?amdWYUMrZUxnVG10eTFidXd2Qzg4M0Vpa1JkVE5FdktFdFd5VEhQMjh5dXRJ?=
 =?utf-8?B?NDdiUXdnckVueWloMmpLZlU2MHZRS0praG5OTmJlSEkvNnVoTVFidDVQdDh4?=
 =?utf-8?B?TzBPNndlN0FURlpicmI0SDVYcUVZUmxuVGxIV25zNUV6L2NDdW5ZWHZudENi?=
 =?utf-8?B?TTQyN0lBb3VzQW5UaC9Dc0xrbGlmdnFjcUhsb0grdnk4OWNTUm5oWHZEakI3?=
 =?utf-8?B?RllhSHhVNUNrWlVIekYzY3ZYS1dYaS81anc5R0xoZkN1SExGL3pmVWpTdE5E?=
 =?utf-8?B?VkNselA5Y08zc1VXMWIrK0FQMTFvZDJZcjNuOWFCRVNtZ0o1NGVDM2FSTE1R?=
 =?utf-8?B?ZER2NUZNTjhVekFYWnVwdzZpTjVGY1FXeEx0b0JMVUtIVndyMWtJSHVJQXc0?=
 =?utf-8?B?d2VLSUptalczNVR2TlZrcWpOemZMWUdjVUp0Y212eTRSUDNKT24yTjVsK1oy?=
 =?utf-8?B?b3JKTk1JOUFwVTFiRzZMYnhJMlBNOGFiejdIN0Q1QTN1YnY5ckIxTEUwTG15?=
 =?utf-8?B?TFQrdVYvRUlUZ3djOHRweDIwRW5qT3dzM0JWdWpMUCtDeStTZ2N5MTF1cU96?=
 =?utf-8?B?Uy9URlBWcGlEQTNNc2MzTDNSR25aeGk5ZTJpbXlKZzRMZ1I1SWxDTmtGZEMr?=
 =?utf-8?B?Mlh0bG9Nd3hraWNJMllWYm5CbU5ENkJlTW5rS0VmTmJRelZSZEJGaGtYN25U?=
 =?utf-8?Q?TRpfiNY5ItRfd3y0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd72ab94-a9e8-4837-a3c0-08de6064be95
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 01:04:54.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxQ810qaDewIrMIFgYl0cm7JRaxr0RGZHJmnx8vx4MKWI0isAITvzl3aw4GCvzY34ldzUoZoEDWAMYxRrOpcOFxmxTt9LXINoROiFSGX5pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com

On Fri, Jan 30, 2026 at 09:45:29AM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > When auto-created region assembly fails the region remains registered
> > but disabled.
> 
> Right, that is good forensics, administrator action is needed to figure
> out what to do next.
> 
> > The region continues to reserve its memory resource, preventing DAX
> > from registering the memory.
> 
> I would rather have the partially assemebled region to continue to
> exist. It can help debug the expected catastrophic error reports from
> DAX enabling access to a memory range that the CXL side can see has
> completely failed (lost an interleave member). If the failure is more
> benign and DAX side access is viable, then the forensics matter and
> userspace can cleanup.

Thanks for all the feedback, Dan & Greg -

I'm responding here because this is the overriding topic of do we want to
behave better upon region assembly failures. If there is a path here to
becoming a better region driver then I'll take a look at the implementation
comments, like if or how to timeout.

One point I should have led with: while we are focused on failover to DAX,
the issue here is more general. It is about the region driver leaving behind
an unrecoverable partial configuration on assembly failure, independent of
consumers.

Neither of these failures are recoverable from userspace today. If they
should be recoverable from userspace, prove me wrong, but I'm doubtful
that we are just one smart admin or one good cxl-cli update away from handling
this in userspace. That's why these patches make the region driver fail
gracefully. And I do think it is the region driver’s job to fail gracefully.

When auto-created region assembly fails, the region remains registered
with decoders still enabled. In that state, userspace does not have a
supported way to unwind the configuration. cxl destroy-region fails because
the decoders are still enabled (--force fails). So while “administrator action
is needed” is true in principle, the admin has no effective action available.
Leaving the region behind does not provide a viable recovery path because
it leaves all the things related to this region stuck. All the things being
the HPA resource, the DPA resources, and the decoders.

On the forensics point, the most actionable diagnostic information is not in
cxl-list output. cxl-list can show the existence of a disabled region, but
it does not show why assembly failed, which endpoint is missing, or what
happened at the time of failure. The forensic info is in the kernel log,
because that’s where the assembly failure is detected and where the relevant
context exists. With the changes here, the kernel messaging is improved so
that the failure is explicit rather than requiring the admin to infer the
situation from a disabled region in cxl-list.

Of course, the timely topic is that unregistering the failed auto-created
region releases the memory resource for DAX. To be complete, I'm not
suggesting that these failures should lead to the “teardown of all
regions and give all the goodies to DAX” path.

Also, if you all think the endpoint arrival timeout is silly, I kind of
inferred that from Dan's comment about BIOS seeing it a only few seconds
ago", then I can drop that.

Thoughts?

--Alison


