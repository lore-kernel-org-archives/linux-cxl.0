Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DD4501A
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475205; cv=fail; b=qI1hp11/tB7O9j7wevIka8Ax4EawruWrQymRcYGygxzijeTEubrN+rRdWAm4ZP+fuK0IrBHEBaSjWAWVQNDL7YTexU0xd7deeiGUKUxgYu16HRb5eBqyUM5sMnyJCnYDm2s9oTdmVnKtvheZe6ts5jT2/SZoKEQ5OuomuGG0RGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475205; c=relaxed/simple;
	bh=XdngmmzMDopjzsrQpYY9pFDsfX6FUEZv8DhImwfRBVQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sV+2cE6wC+l1plJ/54Xw4Q8hceH399oIwwhY39waX7U7bf/CJpAfZd8UexG/jpMnGaWC8mPeXZAGIZXwLLGln4sChj1da1/4rLDNChxFZlbU6FYoFAcc2FSAeKLpAb7rhfZQRKlvyU7tSNzDUHAn7HCJwbvRl9WsQG/a5AvSygA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTok9NnL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTok9NnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753475204; x=1785011204;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=XdngmmzMDopjzsrQpYY9pFDsfX6FUEZv8DhImwfRBVQ=;
  b=UTok9NnLCkd/peWDhHSxBn92O+K6s5Qw647wVH5CEDb27FLUZAXGyOox
   xgdYOfdgweDwdFHsY6T13kQxqfvgLmHFMYMlnuHzxrZxy5TPCF+bR8Hik
   OREj9Xn9GBiugrc1P1hDwkVe2gUCViOvZd3S7YpAJgBC2syCgXx0nuPiA
   601v5pfRBRB0Fm+ggHtnfEz5j/DiSwDEg42IbA9HAxCcTUX2CwikQh2Q/
   l3njMGvKNlS4rYvk580PFSDkHe6rrVHTb2g1wW/XynBtTQUztwgFLdejF
   AhRKXen2Zcif+kuv86/U29sIwUcwAK7+SCnM95sLSUFZWWJxdXHC0niSR
   w==;
X-CSE-ConnectionGUID: 8JpK76apR3+Mw7N6Wz/CKg==
X-CSE-MsgGUID: f8FaKXQGRw+Bs//1hL1csw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="58436641"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="58436641"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:26:43 -0700
X-CSE-ConnectionGUID: 1b6rr/sWSG6Fc2oZLGaHTg==
X-CSE-MsgGUID: Fno56z24Q8OXImcTSx3kJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166487443"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:26:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:26:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 13:26:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtFXnvQq0FmgoAbqXqH+H5IFDy8nW16yuDu2ZRvKm4N0PqWUNhCWN8sZBGFt30HhX6AJUIuvOjgpfAMLaIcrjXLcq76R2uBYhdlhj3HkUxPTQp75/OMgPmWQRak2B6r+8F1Y7iTpyOSjKDHZge3bsfCmL3TsB8NBmRqupyMOHWfDl5u7hBec1ezaripTwg3GldRf3enFSrD1zQoXV9FftKNVmHays37QU1+SHnTSXrGIntr+ty+KjdgjThAHhYUA5FMHBZcgyY9ZlFYCVKD7HVccU08ebdp+PoO5XT+6x1Aln2sFYRT6wANCNdM/AwkFRoEkaA0/Bcmk35JbTrQFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t66cvmdqdXx+V8/UUxQP2WrOvybKIqmCUpS5MirbvC8=;
 b=oF8/APxTGJD5s97wpWDO49A6CX+XqqQrfaqmF48h6qNCJ2QIwo+PyqA3OrCHbYevVWelpPXZc8/y/57U6WC4CRS83jOs9YCmgRihMvzCizgSf2jQ3SLNxgXsUy1XAtuBMle3aGJTz2fWnJ/un8uK4iO0BJ5pNlPMGSk85Lf10qz5zKaYKvwYXZGpB+VLSCKOqsU65mEpIv+kZNVR6EzajvomcXS5DQWFgRcwuwHbrD+h+JOY0Ama45mO6M7qOUxfbW9NDrBGcyHTuuqHGPWEp8/JqOKiEpgZXcNs6yyke1y2jCudVr6yEhU0/cL+4spkNYF/YsbLIUeJZ+xOVKBhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF2B89F77E0.namprd11.prod.outlook.com (2603:10b6:518:1::d11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 20:26:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 20:26:25 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 13:26:23 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>
Message-ID: <6883e86ff1e44_134cc710062@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250725171928.3398136-1-dave.jiang@intel.com>
References: <20250725171928.3398136-1-dave.jiang@intel.com>
Subject: Re: [PATCH v3] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF2B89F77E0:EE_
X-MS-Office365-Filtering-Correlation-Id: bae57e84-e998-4c90-fc26-08ddcbb98743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0dQdTg2WUtabGVMeGpQdDlOWVB2Ly9Mb1BEaFdoejJGNUs4TGIxU2NjYlVk?=
 =?utf-8?B?L1VHMkJPU3JocU51ZS9zUFNGNkJWT012ZUErYkpUWit5ZEFheDdmbkVSbDJZ?=
 =?utf-8?B?ay9ObjhLcWJLRDN3THhyTmNLVjY4eG9McHZLSTA5V0lWbGx4RXprZTJwdGpH?=
 =?utf-8?B?b1hCSlZjQ3VqZmNKdzNkTG9LUFd0UndpR25IdGV4dXBQVkhyd29IUHlJMzVw?=
 =?utf-8?B?S01vS1o3VEN1M21qRFlNKzdlWW1zdWFYbkFnYkxWUVR1M1p3ZEYybFhyTUwy?=
 =?utf-8?B?ZGx1S2JIZkpETzducGxrMWhEMnE3MWk0NGhuVy9nb2g0Wkx5N0QxdGtrQXBW?=
 =?utf-8?B?ZE56d1Rqa3hyVnhrUFMwa3ZlS1J6OVRQQ3RpcGI1UzZnMmZXZjVMeklSMGhp?=
 =?utf-8?B?WGY3YVNZNkpHVlhQMXBwcHBiUjFxalR3cUNDWnBJWno1dERnenl5T3BnZnNj?=
 =?utf-8?B?cnhlb01tZ3RQZlIwbFVIVHRSR1VyUXJjVzFFYWgzMWxvZDRuV1NIV051VjZz?=
 =?utf-8?B?Rng3RjEvR3N1U2lWYThObUtOVXZ5bFBkQVh3UVBUalNSRFB6bEsrTDE2OHhS?=
 =?utf-8?B?Y0VoZ0NNRmlJcXNYVnR5Wno1aGNHWlpyeXV5K0lETGtQVDdqd3NPdTl6K0V5?=
 =?utf-8?B?bGNyYW5Bdk5mZndLbVdxV2ZPOE9PT1l2WS90a0pzdEMxVnpOSUdZZDluU1E2?=
 =?utf-8?B?cnAyT3Uycm90eGlJSFVpcldjNVpxTlRIWGJFcHc1amRENW9xRlBwelNYMmNP?=
 =?utf-8?B?ZnY1Q2I5QUJJelcxUWhrSHNhTkdTMFVBU2ozTWFkeENZWEZUcHpjaEErZCsy?=
 =?utf-8?B?YlordW9JVmYvNmdFZEhrTHVxTGlOSUwxWjdOZEhkY1NFYjRybjZjM1FjMHFq?=
 =?utf-8?B?N09BNFpqOEdhMjFtNnNTNHBpU1FJNGk5azVjTVN1bGp5aVJlL1RKMkdUdWF1?=
 =?utf-8?B?d0lGSVRHYlZmQmVLZ3R1SjN1L1I0Y3RMV1RJQ25YWmpHaHF5MDhXMkcvUGho?=
 =?utf-8?B?MGxsS3hxM1Q0Tm5OUm5jUFhJQ1M4ZStnYjQwb3o4MnY0Qlcwb29sY2xOelBj?=
 =?utf-8?B?Zk1YZ0tyWHAvT1hQVTMxWEhJbnI4UWtHeVBEcGNDRVY2SURlS1F5OEFOejRX?=
 =?utf-8?B?cHQ4cGZrcVY3bStHYmt1SmQrdTFKSjlaNjY2YzFuVHVJSERxcmFseXdid1Yr?=
 =?utf-8?B?QTk4a2FwYWsvZmtMQ3o4Z1RGT1dxVENaSHg5Y2Z0dm5IcCs5M2JsTVVGbkpu?=
 =?utf-8?B?V2N2QmpNMGY4Yytmd2xWbUhkNk5reXc5VTZvNldhVS8vdU9QRXdHZFp1QkFG?=
 =?utf-8?B?TFJOclBzNERWREN6K2I5cnJWNkNLTmRicC9wL3h4Wml0VVMwbmpUbXd0a3Nm?=
 =?utf-8?B?VnBVWFhycnFyVU8xL3dJMjRsL0xSMTN6QmVBSUFoMzVRa1RoYlVCMFFVZEth?=
 =?utf-8?B?cVRHZHFTVUdRd1hjS2N0R0hpdm9QQTZRcWVya1FjcXArNDcwd0NkUWhLNEZp?=
 =?utf-8?B?UXphcTBiOXArYktJT3gwRUVrejhmOTd4K2Y4bG1zOGdYZFNQZks2bU4vSUh0?=
 =?utf-8?B?T2F0REFtL29CY2J6dmgvK0Uyb3lGZXNMNmR3VG9rYXFHbmtYbjI0Ty8vREhG?=
 =?utf-8?B?WHdWakpDZWh2MGJaVi9Objh1ZTdFUXgvOXhCVm9RYSsrblA1QTNJclpIcTFM?=
 =?utf-8?B?WVRyZ0QxVWpLZm5JVU0yN250My8zYlZ2bG4yTVRMS0xSWVMrdHBabWpSSTVY?=
 =?utf-8?B?ZHJKbmVjb1hoMVdnUnRUYUtzZ0xyT2kzcCtjN09qTzZtNlUxeFhwL1R0UEQx?=
 =?utf-8?B?Q1N0clFUNHQzQ1oweXZNL1VrSVl0Q2tnQVhvQXdxajlUeXNQREE3UUJTZ0F6?=
 =?utf-8?B?Ti9tMlcrNU9mSXpWZnRzeE1FK0xQZDRmbCt6ckJyM1ZwR3B6LzFURFI5R0FV?=
 =?utf-8?Q?UUjnwRLY7I8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1M3RTNkd1pQa2VnV1hPMEpyNVVacWZOanRTNmpsK1NreWg3a1hvaHpHWTNS?=
 =?utf-8?B?YlR0TjEzTkhuWEF0a2E3Q24vY3hac0RIaEhiWlNhMzUrWklwbzVvbE1wUE5C?=
 =?utf-8?B?UFNJbXBOSUlnUjhEV0hmSnB0NkVpcEtIZkEyWDN3a3lmaU5vRzl2Z1oxM2RC?=
 =?utf-8?B?ckJ2aEdEMnJJWnViRFM5NG9lV0lyYmtKNG1ScEJDZ2ZnSURzK0JMM05IRS9J?=
 =?utf-8?B?b2pyZlRIdmEvc3MxcytUWFp1NmpkTVk2Q3dJNFllOUNXbDhXR1JCVnd0WHRG?=
 =?utf-8?B?Tm1ZSmh5UWw1WG9JZkFGM0xYTmRlaGd6SktuOGMrNGJocUlnNG02UG1Malc4?=
 =?utf-8?B?eVg1aFRhSmhXMWd3MFJVZW1wVVI4eTBJWHlLMnRwQUhzV0hFMEcrNU9JSE5P?=
 =?utf-8?B?Y0xjaTc4RGY5TFRRTjJ5RmxiOUJSMHY1bVp1a2IzRjN2cm43Q2QrbDdOYmhM?=
 =?utf-8?B?RHBhcnJtdW1VNi90andPbU9pZUM5R0RIc21qelhydUpHZnJvTkJYR2ZtN1pY?=
 =?utf-8?B?bFA3OUI5YU10UmlQTjRheE4veVlKMENRN3N3bHZiRnJvTGdTT2JkR2ozNjMz?=
 =?utf-8?B?N3V4UFpLTmhGZ3RrVFdWNkduODFUbHg2SGlRWXNTazMwMXFCLzV3bi9USDZ0?=
 =?utf-8?B?SzM5MnRDUTF3cS9OcTViTnhaTHZYMU5SbG1LTGE2anpmNzludXFDdTlxOStG?=
 =?utf-8?B?ZWNQOTFmVGpHVE1CYWNsZncvdjFOUS9rbnpNaWxxUjlpamRkdUhPbm5IMHI1?=
 =?utf-8?B?bGNxUVZ6Z01MaXpReHJqRTY5R0RWZmEvakdFL0lqd1orM2ZxMGl0ZEVwV3FD?=
 =?utf-8?B?UEZTSUNleXcwWnNlazNGYUYvRGhpMndKdWtENW5wblUvaUlHUlZoZzg4OTNH?=
 =?utf-8?B?NU0wekxXWFJMVTNLOER3QW4rY0xXNU1hOTFKZDRkYkZWMmhuLzRIZjBwOHA3?=
 =?utf-8?B?d2d2NXZtTVo1WlM0ajZKSlkycUdYVGx0T05UVTdtSmZZQ2pmTHdFNUxnZXgy?=
 =?utf-8?B?Qk8vRitRb1l2NUlsUkxiSzR2SmI4d3h4TUFyOXIrckNiUnZPTHM2RmMyNHJQ?=
 =?utf-8?B?eUR3U2YxbzVpMjVHNEJtVWplblBvYjhObFZjQ1RjQUphWmtSK2ExUnAxTzMz?=
 =?utf-8?B?blJKUXUrZ3JMSTVXZEpEdXZTdENKVE5TMmM5QjBoUDlXK2hPVnl3MnM4M0RF?=
 =?utf-8?B?RFNOOWtuZUxHQU9FY2R4THlzWS9tbGJhSURNNWNYMjVEa3VHUlN1MzB3UXpV?=
 =?utf-8?B?NGRTRWI3MHA1OVhRekZ5NVM5MlUzWm9vVW00VUVkNCtkZWRkdXk3QnoxSm04?=
 =?utf-8?B?dDc2NHdKblJjSjQ2elhIbXcrTXJlbjBXc3BwdzBHL3l5cVE2eDV6K01WUWdl?=
 =?utf-8?B?RFJRZUc1TEZBeXlQdFlRSENrMXl6OE1hTkdSUWx2UUhBWlJEeitmNitkVnNw?=
 =?utf-8?B?VkhTa2VNVmdmQjB6OU92TnJ1Q1NpODRubE54eFUrYXFNVkpyZTlxQVNUYUxY?=
 =?utf-8?B?MUZzdmZqdUJlaDBKMzl5UjVneDZMNG1Ld0tLQ3FvS3JzdnlIWTFiQVNOZWpU?=
 =?utf-8?B?N2k4T1lpNjg1MWFkYVIyY1BVVlpIZ2RyTWV5NmFOVnpEZ3VSSXc4ekJwbWg0?=
 =?utf-8?B?RC9OdWFjYytiSERKTGRKcEY4ejRZdTNia2xiTDhpaHJ1OC9sRTF1aXFFWkxy?=
 =?utf-8?B?dmlBcW92K3FjQkJwYlR0RzZ6TFRUUlhkTjJBV05tS1J3Z09haXVDYy9Yd1VU?=
 =?utf-8?B?QXUxYm5GMzRhK2ljS3Ixb2htZlJhWFVOWWtDQmljQlI4RkdPSGRKTno2TTNo?=
 =?utf-8?B?d05kdkVDVERudktzc3hJeVBabkJrL21CMCs5bGEzK1FBUU5jTWtnU1Yyb3RH?=
 =?utf-8?B?MzNmeWY1a2w4alNYNGU1aElXS09WM0dUTFZkOWpYWW02enRVS1NtYmRhVXN2?=
 =?utf-8?B?RWZUM0ZsYUFjOGNlVHBJUUhCV2hLTzh2NXhkUTBIN3pRYlZLVzNVeUUwUWJk?=
 =?utf-8?B?dk5qaW1vWTNzQjZqSVM0NmV3amluK25lWUFtNE9xblIvalZ3UmdLbG5VdnA5?=
 =?utf-8?B?b0JPSTU3S003MUpjR1BjTlk2WDVoSmswNnUwWjBvY2RzdlFLTm5YYThvRnZD?=
 =?utf-8?B?UDJQUkVuSVZZcGo3ekFrUnFZQ2czRXlzZ2htTmtmWnE4VjJ1dm9ockhFaWdM?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bae57e84-e998-4c90-fc26-08ddcbb98743
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 20:26:25.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kid0agHeu4/XcwRQM5G5vgcdjR3DaNA9c9JPmrNmVI/lab/yrnQEcE1ia1MYitQXewKLxX8zkdH02TBW0Xm4rxesrXYolGX2i9aa7omn95Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2B89F77E0
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Gate everything behind CONFIG_CXL_RAS and move to core/ras.c (Dan)
> - Move the PCI AER handlers to ras.c as well. (Terry)
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/core.h   |   9 ++
>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>  drivers/cxl/core/ras.c    | 313 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   8 -
>  drivers/cxl/cxlpci.h      |  16 ++
>  tools/testing/cxl/Kbuild  |   1 +
>  8 files changed, 344 insertions(+), 328 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..6a3895440163 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_RAS
> +	def_bool y
> +	depends on ACPI_APEI_GHES || PCIEAER || PCIEAER_CXL

No need for "|| PCIEAER" because PCIEAER_CXL has "depends on PCIEAER".

> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..1c652e575aaa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,10 +14,10 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> -cxl_core-y += ras.o
>  cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_RAS) += ras.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..ff1a478e690f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +#ifdef CONFIG_CXL_RAS
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +#else
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
> +#endif
> +
> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);

No need for any of this, all of these functions can now be marked
static. Now, it does mean that some of these need to be reordered in the
file before their first use, but with this patch already doing code
movement might as well move the code to the right order in the file and
skip the need to do forward declarations.

[..]
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..9063134c85d9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -132,7 +132,23 @@ struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  void read_cdat_data(struct cxl_port *port);
> +
> +#ifdef CONFIG_CXL_RAS
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +#else
> +static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> +
> +static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> +						  pci_channel_state_t state)
> +{
> +	return PCI_ERS_RESULT_NO_AER_DRIVER;

I would have expected PCI_ERS_RESULT_NONE. Not that it matters much. The
only way this is possible is if AER is turned off, and if AER is turned
off, this will never be called.
