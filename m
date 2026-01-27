Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4022620DE;
	Tue, 27 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540506; cv=fail; b=THL7UkQljTHc4Y+M1vLoErkFCVCCb6YRIhq8RniPR2X2oFu5OAAZapPBmRSB847UlhC6ozhtV34skGx7JdAwNXJVptpZHc4pFnLp6nqLAuaudkPXlU0/I01HxeH0hs0FluBJZlJijKfpr4qKbwUg6aDZv0Vt9yiUGYFxEnn34fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540506; c=relaxed/simple;
	bh=dVpq9nc0Du4H49AR+k6ltXPKHB3h0P8FwrifUZHKR/Q=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ajFpdalhy0H95PU+nE04QWWbq7SjGFqQMVcovU1KT+c/h2cFG7bxe8PmA8F0Ahn4sCqPwZ9qF2AOApOpqw2smIpbPRaPlt1nHNrKmsZdNrfNL8ubKBFaLu8OSiX7u4+O8fL9QwZ4Hv11XDwE2UycoDUXG8UMj0XuASBZ33G9O/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9ZPAzkw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9ZPAzkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769540504; x=1801076504;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=dVpq9nc0Du4H49AR+k6ltXPKHB3h0P8FwrifUZHKR/Q=;
  b=f9ZPAzkwA47TrAfsoT7U0igvugGqutgzt3lwYvmz7WqXemWlv5W2tQor
   ePgOUpoVdZvg/BYfSwpyyQs9eQ2n8u1VkwT1sOBGEUG4aixC4XhpCC+Uz
   do7qr1t5EkkPM1U16kuEQKz1T+NBlCPa7GyRlmAc16fpCJ+4sNqV3+RMh
   yodHjBj3HnK49EjaFFbDlkZSlKawCvdvmK+4hLzQzFlQzTme77R7Z2ekU
   zCF2F+58gtsgCceQkX0JCBhgisgNMXy3+OM6aK1Cjwkg2h2ArDnitRJ2M
   GaNqPALJfXSfgosoktlOTAyDYgwlgzFIW6O6JDQlyjE3En4kNkjcNfBkv
   w==;
X-CSE-ConnectionGUID: Tat+jyhpSrGbkdxAU6asHA==
X-CSE-MsgGUID: f9Mao/uqTzOHnHpbWBdX8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70647179"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70647179"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 11:01:43 -0800
X-CSE-ConnectionGUID: jl8CzFJST5KS/3QVVSwLZw==
X-CSE-MsgGUID: QJOQYaYARR6/Q5YbW+sw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212160258"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 11:01:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 11:01:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 11:01:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 11:01:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCVRfvvbAtuURZ6K/KrdKjrkSIitMCF4hqCSbtJjGJ274AyC/gG4BP2sqpK70HdltEpdfK7OIk34T36hLl7gtsrXzBDNf1+tlh2ybdPf8xbjEaNqROkC7dZjQMFiYEM5NOSbCmObboiiQ+QXSLBsgA/AjqZqZ639ji3uO9Tg4ll5SMbKMkRtJwyJHPNa9CQ2eL6quPRaaVqyLNuUQANubAIDrJE4cmT7l4UU86e6qDAI0m4Et9fe/THOgQ1FAvdLrP5zXoPbiF2ZP5IbIIuatdJbiHEYbLZacOR6BuEs3f1Gg6amyQJepJgkGq0HEnrqPLC9LcmQewqTUNym0GH/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzRMqcv/Q/ogklzOfQyLLdj91ZNTE+xV4kpE5IUfpHk=;
 b=eEYOnhYciPooyAw0yY+9uqamy5u+AjkDDoH2/6ZT2Z3ph3kzo/Do97oYmwq1RfEMFHldxsnl+aTslX61ZdPAMHW3LIdrPtPVphV5cIYUVToaaf8gntZCv+OGs/22ttYli0zNWyVAz2OUQjjwlrHPMUsXwz2KNo/aJ0+7s+1lxP8JT9i/WUsPBiWyCeJSoLaR9cheX5qZFvEkOvU+saZRYBPyk/H9pfzSOoevkcVno5FG1jY15O+ycq3yza/oztJ2ZXlTeEyqewaNHVu6zcuOgdYpMvUHhtnVd5duMu93wB/illc82TdpuzXEFJ93cWG/SPaEcVtvGGlXqZdIUJyqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 19:01:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 19:01:37 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 11:01:36 -0800
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
Message-ID: <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122172432.369215-3-rrichter@amd.com>
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
Subject: Re: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2a2a02-61ba-46d7-83df-08de5dd67f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzI2Ri8wcFMyc1g4Njl2Ukc3NmVJTUU4UE8zU0c2d2VoTkdrNXoyZDNlb25u?=
 =?utf-8?B?UzZnR3BPUndVdXZRN3E4aXJyWWcwaEZLYlJhbEsxOUVNOGJ2dFpsb3NuWlRh?=
 =?utf-8?B?Tlk5RzFNejI1d3FnR0U4SGVnTnYrTjF3S1E3bkVWOGc0WjdtRy9EZ3B3MW1a?=
 =?utf-8?B?UnhYdVM5SkpaWWNmbEs4RlVxd3lMN2NjbGJqU2d0cWZkNG5zU3l0S3hQbzZS?=
 =?utf-8?B?aFhaVSt2WUhVVndIWmc1MjBrV0xuSnZyMnZJM1ByTkl4a2FOSTg5aThWSXJC?=
 =?utf-8?B?NmlMcDBpU2RvNEFGTkpOV0cwNTV0MzlaNzlnaDhNZHg2SkhwSVhOdGE4UFRn?=
 =?utf-8?B?VlpScCszc0dJQS9GaXcwQU9JeEp3Q2xKN3BTWXcwVHdvdmdkQ2lQUnYzSXRu?=
 =?utf-8?B?YlNzNHBXdURSSjNtRVVzUWNJRjZacHM3UGRWVlF6RzhqZUg2ZTFpL2ZrTERi?=
 =?utf-8?B?WG0vTlVMcWZULzBSb21JajNPSUxaL0NGM1c1VWJUMUJtcTQvSHVQVFc3cHJE?=
 =?utf-8?B?M2R0VklSWERKbWowdkJXYmlib1p2MU9hMVd2cTlZM2wveEV3S1BMYlZWaFdi?=
 =?utf-8?B?V0d3Vzc2cGNTdW1vcisyMlJjWUgrRHV5eWR0dXc1NVA5aVk2R0s3dTZmZFgx?=
 =?utf-8?B?c1MwVlNsblFIeFlrNm90QWRaeldLeWpaR3JUMTB1YlZnWmZidlRON3FJNFE1?=
 =?utf-8?B?d0xzSTdIT3BKTG5KVjFIRXFlcUYwT3ZsdXc0WkY1akFqY21UWExMVUE3Y3N2?=
 =?utf-8?B?d3FsaThCMW9CYTlUamk5OUFRUUZ3cThWaFY0YWlNQktDL3dyNFptbCtHV2VO?=
 =?utf-8?B?amRHeFV1ejdDOXhIdkZQazk1VTJ5dE5BTkVaSU51VndjZXh4SFplOU85a0hm?=
 =?utf-8?B?NGFpTWwybTFEV1E4Q3c3OEVKcXRUYW1HaUdvdENMTzdvOElxZjVWN084K216?=
 =?utf-8?B?YlVYZU5yWTMzWGZmY3dpUE8zOGF4YU9hVW1zaUJtRS9sOHNCaUloVWNXL2VP?=
 =?utf-8?B?Mmo0WENKNzBNSXptbEFWMWNmRVRNYkx1cEQ4L2NtRU1tWHNsMFBKc1d3QU9W?=
 =?utf-8?B?RHg2b3YwdkR5bWlCZ0FlaHdOWjBZdmYxejBMbWRGT1owQVV5WjdhTFVqQjhT?=
 =?utf-8?B?UmZJczQ2Y05wN1lDSWVUVjFmS3ZkZnN2WEd1ZlFPdFJLUEprZE1yd1VjK1Ez?=
 =?utf-8?B?SHVFSDhuajhEbWhUdVBMOU9hRGZzdDNETmxQZGpTdkZQeXFYTDZjTkpqWXc2?=
 =?utf-8?B?a0FMODhEaHo3TVZoV0w0dmNBd0ZTaE1ST3dKb1RwT2NmSGNsbUhBaDhwT3cw?=
 =?utf-8?B?cXNUNnI0YTdTTHFTaWVHZG1jUmwycEpZcG1TelR1OEd6N3RkUWxRQlh4N2NV?=
 =?utf-8?B?RWh3TXZlTENaRVVDMHZUSUhWNlJIR3UwTUFRSithU1lVcjNQZXVQS0lFTkpI?=
 =?utf-8?B?WkVpd1R2N2UrWStvSzVhb1RpZHg4cE50elVqY3c2V0FMcHRUWUNxMjViV3hH?=
 =?utf-8?B?WU81QjI1a2d2KzJOTVYzbktWQjU5VE1kdVVvZHd3dlVOc1lqUzVlUHY1OTk1?=
 =?utf-8?B?RG1xMk5rdjBSYmRaelJPUmZib1RoSzJlcllaSlhXemdyTkJteE9mWG4rYmNT?=
 =?utf-8?B?OURlMU01UVRIcys4NUhNcDFLZzg5Q09LajhubndUckV4YXVMQkxGRUlCK3Vk?=
 =?utf-8?B?S3RQeW1tUkZvN3lCQWVwT0RSeWk2RHZ3U251eUovWll3MmJPdnFaSWFaOWUz?=
 =?utf-8?B?Tm8xVzM0UjJSVTFpVWhOazZLVm1ERHBsLzRiSnRSdWMwZGxINENzdmZUelds?=
 =?utf-8?B?OXVzVWdSbmtxSUdOdjcvVkc0dlJzbVB6ZkgzR3JTWDBwV1hZaDM1ckpDRy8r?=
 =?utf-8?B?dG9veHgvY0NsKzFjdWdBd3k3QlFkUU1VWmFDMThZa2pRUFZsNGRIaHB6a0xq?=
 =?utf-8?B?NXliTnRzL1N1ajk0cm11SXZwOERtL0k0N3ZuMGUyTDVRYUx1dUtHSmoxSmJt?=
 =?utf-8?B?VnJza1d0YXJuR0Z4My9WcjhUaDZWQmlTUHBPN2NrSTY2ckR0TndHbnc4Y1Qv?=
 =?utf-8?B?cTYvaVViZE1Dai9KNmFzQVlMZzE1bmd2M00rMVFBbTZuVERCRTN4MlptdXUy?=
 =?utf-8?Q?D1QTY9SunvDAjHUKS3LEmjaWQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRvRmh3S1czY2E1MjUvWGpoYWN1Q1h0OWxxQmJnbjBBOElCMWFONlgvWjhU?=
 =?utf-8?B?MFIzc2x4K3BUTzUvaWxjdC9sdG8vOVVJWDdzaUpJcUNteGwxS2c0K1N6aWhW?=
 =?utf-8?B?V1QvbkJpZFlPYkVxQXVKU0VIMXhReElNMnVrcnFBWFBDeno3YUxWRHFObWJj?=
 =?utf-8?B?alBGb05ObUM1eVNvOXp6aFdkMU1hRjlENk9KMmVXWHpoaEg0Qy9pWURJRXVj?=
 =?utf-8?B?Qkd3UVlTRWplNVhlQkFNTmVVZnJqUjR2c1VqUFk2dDhtVHk2TS9lMG5JdmNq?=
 =?utf-8?B?VnJMMDFCbFFkcGN1eEdlYWhPakxvUlFyZjVQSXFJUWlsb0FuTk85Y1B4a3Y2?=
 =?utf-8?B?dDIwQ3JPVVVZekJRR0F4S3ZPRUQ1VVIzRVFBNmtaWXF5ODBTL1F1T2dMbDBO?=
 =?utf-8?B?aWh2enhnNUNzcVJHMkJqR1FWMTJvWXQzMXFzWlF3K3Z1YVcyWGJMUWhKUUxV?=
 =?utf-8?B?OW0rOHJmUEQvajlMNFdGODlFRUU0SVRMZVpGZ0dxN0IzOGtHeU9XakFMK0E2?=
 =?utf-8?B?UTM4akFOZWRRNWMxcXRZZERHR052Q1VJcEFTcGIrMmZCNmVPMWM1R1p6Sno4?=
 =?utf-8?B?WEVNblJ4RUVOL0JmcC9vSzdSQm83V25PWGUyV1J2dkhwV3JyVnpIK1JqWitL?=
 =?utf-8?B?Y0ZBOWtpT0tLNnBod1dXZzJkN2FmMFZCREV4OWkvVk5iZDZuVExYMDA5ZXkv?=
 =?utf-8?B?cStQakxLZkJlZXJka2FKM3RzME1xNHJBYnBoUWZRSTBBMEpmdmxFNXNlZVRK?=
 =?utf-8?B?VC9obEVDbE84R1NZNVpnY3Z1WHlZSjgvVDJ2MStodVMxSGl6T3l0VDhtVTJD?=
 =?utf-8?B?aUE5QTRTZHVTSHlPdHlhckZPbUZ6dEZIRW9ROG5jSUlWMVBDelhuOVRBcFdj?=
 =?utf-8?B?ZFBFNnJIc3Bad211VUxVcnVsSnREdTdFSE9xMU9TT05BQ2haOVNxZlE1Y2Vh?=
 =?utf-8?B?aGQ0bVZKSnI0c1QzWGpTVWlHTmFqckNJSTFGb3FnbyswNlk5dG1lMEIzSlNw?=
 =?utf-8?B?cWNnRUR6RTVzZFdUUCtHUjNjZWQxZjRIV3BZZDI2cWx4NEw1NDJyQ0VXZENH?=
 =?utf-8?B?NHp3ZHhDeTRsb1BpS3dUOXB5ci8yQ0gvS1Y1cWNPM0FJOXJaRGFVZGJkc2V0?=
 =?utf-8?B?bVdodklSSUNnZkZSWjliTk53TFRPbzhDeHUxbmF6YXN3ajRib1lhL2VtdGo1?=
 =?utf-8?B?VmFKZno2djY5cyttTDVQZWl3U2FTaEhBWHRKNElaald3djdGK3c0VUpDMlJK?=
 =?utf-8?B?WjVxR1BkT01kcGFUcnZrcTBZZER0UGVqUFExZEcrcGg0Z3ZKNGo2ano2Q1A0?=
 =?utf-8?B?ZG0zbGJhdGpSNUFnVGQxdnh0Kzlob3lzZWZxNmZnV1ZwTVpjK0EzcVYxSW1l?=
 =?utf-8?B?dis3Y2N4emY5NDd0bk5zbVFTa0tSdUVTbTkrRU54MGMrblBMbjhxckxXTGZM?=
 =?utf-8?B?aFBhdVpCSkhHZzA4eFI4UitNbmxjdzI4czB6cktDQ0J3SjdxKzg5di9nVVBH?=
 =?utf-8?B?RUs4RmUwamp5eGdHZVk0OWFtajJIQ0tEekxIZG12b2xPVTk2MlJSaGNaeTli?=
 =?utf-8?B?M0p6MFp4bzhBV3BXVFQ0OWNrc0MzOC84M09KNGZrTHBZUjdGaUkxdStOQ3Rq?=
 =?utf-8?B?UUxINlJKNnB5N2hYRnJJSkpOMlEzaElZK1FjbU9RMm4ybVUxZEpBdzAzTU5Z?=
 =?utf-8?B?UDhITWYrektSNTJrS0FHVGhvRlRUYllteEcxbG1hdlcxYXZWT1k1bm5JSUNQ?=
 =?utf-8?B?cktwMUUxa2JGQ0pOdTQvbnBXZWw4Nnc0bWIrZmNaS3JRYUlmWlJJblJidTdw?=
 =?utf-8?B?RWRuU2VMWGtueDhRak1pZ1JJYWg5eGJaVGFTaHB6VUpYNTlzMGYyKzl5VjVz?=
 =?utf-8?B?TVNONmI0L2lMZEdLV041U1JmRWNnWFg1U08vWGpJZkY4OFpHc1ZBN05UeS9E?=
 =?utf-8?B?VkFMSzlaSEN3ZDgyS1ZJb2IxbjNYNUVPUXl5WEQwQ1B1N1g4MUJOai84cy96?=
 =?utf-8?B?YUkxWklJODh4UGZQQXFtRXhUU3pMZ3JueWg5bXBpTmd1a0R1RVhXNzBYTHlQ?=
 =?utf-8?B?TG52WXZ0a1FUN2tpdGpvdlhtU2FWbGdiOEk3NHdTdms5c1Z0K3MybHJDclVP?=
 =?utf-8?B?b1VkUWptU0plbXBaNGJuano5QzhtaUpvTG5CQTE4WnpCT3NEL0VRa0FDVXF0?=
 =?utf-8?B?djBpT1JuM1VkZUtCTThXbDI0WUFidTl4WWpDcmJjWnJ5UVhsVWdlQ2NHeEpP?=
 =?utf-8?B?UkRxb2RveDhhUEowU0FzdEdhOWRESTZ2YkNLZ2JyUVRJZXN0VU9PVG5lM2Zq?=
 =?utf-8?B?L3pUR1N1aU44ZCtlNTllVHEyeXBKbHN0WEV0RUtPS1hhdDZUSTlpRy9QK2lB?=
 =?utf-8?Q?3JzzpUDe07NMXP7o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2a2a02-61ba-46d7-83df-08de5dd67f70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:01:37.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArFsahn1AkFAzY8IftWNt/KTp4zYBuA2wV1i/5XLZZTD1aLUP7wPFXvYwRIbGWEpGn2HO/BYyuZplsBJ5aL2Vkh3nPGSmNFDywK0VR4k2/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
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
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
[..]
> +Detailed Description of the Change
> +----------------------------------
> +
> +The following describes the necessary changes to the *CXL 3.2 specification*
> +[#cxl-spec-3.2]_:
> +
> +Add the following paragraph to the end of the section:
> +
> +**8.2.4.20 CXL HDM Decoder Capability Structure**
> +
> +"A device may use an HPA space that is not common to other components of the
> +host domain. The platform is responsible for address translation when crossing
> +HPA spaces. The Operating System must determine the interleaving configuration
> +and perform address translation to the HPA ranges of the HDM decoders as
> +needed. The translation mechanism is host-specific and implementation dependent.
> +
> +The platform may provide an interface that can be used by the Operating System
> +to translate a DPA and determine its corresponding SPA, such as a Platform
> +Runtime Mechanism (PRM) handler or a Device-Specific Method (_DSM).

Optionality is not a standard. Linux does not want to consider different
vendors making different choices. One mechanism per concept is the
expectation.

In this case PRM is an implementation detail behind a _DSM calling
convention. I would much prefer if this implementation did not directly
invoke a PRM handler and was instead always fronted by a _DSM. For
example, one way to avoid the pains of PRM would be to implement it as an
AML method. That is not possible if Linux is directly invoking PRM.

With the change to drop the mention of PRM and just document the _DSM
protocol you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and for the implementation can you update it to only invoke a _DSM
and hide the fact that it might be implemented by PRM on the backend?
