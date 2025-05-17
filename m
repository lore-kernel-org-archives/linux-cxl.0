Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B14C92
	for <linux-cxl@vger.kernel.org>; Sat, 17 May 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747441390; cv=fail; b=doPhY4TGKSz4SRv2S1x4S3ZoAQV7qoMQZcDNYtdT1riVbZhlOXmDI+YWJInSLH1SzLH5itJC3HvJgTZnu1BS+YmB6DG8GrCkQbNbiDHoOORreUJybJwfcSNap5WBFPxwSd0GmJ6FMbLrZyz7Ymci/7L7+bnGLXdBjvZBTL/iBos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747441390; c=relaxed/simple;
	bh=g7/QGFrtYNuq5fE0DCBKHNj9FTI1pppT6vgBPHhJbRU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Bv3PQ2NBywbFM1NEZXpbbjGUfQS3d3Y8HQDhLTvaCRqCtAyaAcQP2HAgDy3ryiuHUocOax58HJ4ZPqlEC95S69/BpOe/+nYHOv0nIR3oNFILenfFMf6YnXTQI+oKzEoxhPaozU45lu9rLa3unOYWD/owmQLc89cIvI8GdKdQhrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfjB3BVX; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfjB3BVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747441388; x=1778977388;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=g7/QGFrtYNuq5fE0DCBKHNj9FTI1pppT6vgBPHhJbRU=;
  b=TfjB3BVXgQAGV0vFZ1Z9NV4234ME14DphJ6tYhYM4dCdM9nLe3Jf8l92
   XzBOSW94QXFoCjqcQiiFSLClE6VBgSfF/KfPi8JQraA282yPmEqWXKsmR
   ilTvhPvyhaO8/kQ2/AhXWGPvX2WErnTN8hdVPlW1MYqrttwviqmeOCC8t
   OyURLfZL2cQo3Uy43yxiVH6D+wK0UWDH1r5qHT3nP3nTPSDw+AV4KPmKr
   wS0kx2gLG8BFbdMlkXBNYWOq1f2m4J2m3zh3aS3J8n6/HRdNz6N0SUfyF
   vW/4Y4SNIsAMcgWJHpSEE5+6uMB+BjIsH+UDiiJ8y1wRfXwm6AA9P8PBw
   g==;
X-CSE-ConnectionGUID: H+h8gPPzRjuaoBV7cp7jWg==
X-CSE-MsgGUID: DEmKpXr8SUi0EjFakpz9YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="48538662"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="48538662"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:23:07 -0700
X-CSE-ConnectionGUID: B62BVG/cR0mn+h9JG5TJdA==
X-CSE-MsgGUID: 7k70iGwTS+GDQqU/XCd9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138756092"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:23:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 17:23:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 17:23:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 17:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmjwsOjDjP4v97LI85PtUdZ8PigA7+IUAt9nDqdxLCaAUrTENX6lsBCYdxgG0bNK0HamydJPitG5ruCwH5+4bdm4Pcd8ajhkI9OadaMkFAiakqE6BB4QRdQooW2RZmBxhia/a8imS6VXLLh5k9Lnwzfkneh1owHSrXo9OzSzFXn1zbCz2jJSIDCdTgPzQOm9vesnxzlq/xslf1VfFWJVmca5eeTkgNsD6R3wJFKiQ4W0F9Mf73EVDHgs1BtlumtfrUva51O87I3B6799CKA6kEZUoRiRm0JEdN4SE18K2bGh7XOCwf5WAeJf/ah/Jc4ZrCtBRSpRY7NCwd7wXNe03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSI3Ws0zeyVzEg7yPMrHpDG+s6IRTDVLVVL8Qy+IbPc=;
 b=OyZYAxjIHgl5FX2CBECnPJVpsXQkQQsJsm/b4QBb+gAn5lcrHMjDubrMfrpnI8eEGF/IbtLyCcRZ+5L/h3/E48XOpQKTSkWGirtdayp19FthBvOqBgD2H7hRnQzNhtcaWxhEIeEU2qMASkSw+pYaw+iyzw29W54XIp90qVpZVGPM1e9xtJjMhfLPow+zuuOXpxiWwwC/0BWmEsBIYnnj288nnl6CshT6DTGXn4+PqmQr98u2AIwDL3JNSgjEzncV8zM/zAYrqyZIpCMPF9LJKnV97SffrQ7jc4tE6APHYbFjwl1b2AwCUS26ao/RMKBkqX9RNssJ4CY4iN0L0qAEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sat, 17 May
 2025 00:23:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 00:23:03 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 16 May 2025 17:23:01 -0700
To: ruansy.fnst <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<sunfishho12@gmail.com>, Ruan Shiyang <ruansy.fnst@fujitsu.com>
Message-ID: <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
In-Reply-To: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a32e4d6-37f0-4136-4285-08dd94d8fcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTFqdVJmRFhxYld4TFlUYXFhOXd6cVNadHl3K1gxc0RFQ1AvZnJ3Z1ovSmxW?=
 =?utf-8?B?Wm9ZWmU2bVFLQzlCckZ4em1QOVVNazhwc3FjZWhHd3FPays5R3pLczAvSVh1?=
 =?utf-8?B?RldJaGZXRDdRRVJhQnc0M1NtUDN5VXBaL3JjSThnWVZKbXRWWjB1bUorTFY2?=
 =?utf-8?B?T09XOHlhL2FSb09MRjJWU0xhYWpTTG9OakltclhzRmprYUdCQ3BrWTZjNHFY?=
 =?utf-8?B?cjFWN1FpTE0vc3I4Mnh2d3NGZUl3RGdpaXFJaVJMTDRYMW4yd3NOWmRQU2Ir?=
 =?utf-8?B?R1plSjl3emhDOTRpeFNtT2tGYk5MVDExQUhmNGVjengvelZyTzdqanVDdVdV?=
 =?utf-8?B?bi9UTkVXOU5HTzZGZjJ4Z1ZuMjRTbWtPQkYyUStFYndUY2g1UUtFTVVJRGZ0?=
 =?utf-8?B?OENQYXkrMHZicG9RUmVnOFJxdjVHbFVZMThDbGlPcUpwakdVUWlkZUQ4d0g2?=
 =?utf-8?B?ci9OOHBHRW5SNmdHNmtkQmR5Rjd3blM0Wk5uUm9FU1FvTlNzRVBXUTJXKzJU?=
 =?utf-8?B?ME9FVkRYK0xyY2J2bWxMb3NpVmxoUnFLSHJhMFljUFVYQWxqVnd4aXJsRHZV?=
 =?utf-8?B?MXFlQ2ZhT09lQ1ZoR2xvTWFQNWhSRkxPajEwQkJJSjB1SnIrQjRadE1sQjJP?=
 =?utf-8?B?b2F1anZwSmp5MFp2M3RFb2trb1NwanQzN3JGelFad3hveDI1d3JVTE83bGs4?=
 =?utf-8?B?LzJLMG5kWGJkalhUUGMyYVhuTTlmSUZ5SHQ5bUJqb0I5SmJERXVUVlBPK3BD?=
 =?utf-8?B?L001ZW41blFmVnRUQ1ZxWlpaaHdPMy9vcU5iVlJKcVgzOWVKTjJDWG9FMzYy?=
 =?utf-8?B?NVJjcnEvb1R0Z1FjNno1N2hzRmZuUDdSQnRldmxvVmF5VHgvUlpoMnUvSWU4?=
 =?utf-8?B?dUhrQllVa1lkYW1LK0FhZUsvb1JneDFVU0VSamhQemkxSXovRjN6QnJZaXBp?=
 =?utf-8?B?T3BDdG56TE1iK3BBOXNRZ1ljV3Nzbm9yVmJiMTVSbEtGbngrVndRTE52YStz?=
 =?utf-8?B?V3F2dlJ1T1BMUENsejBSY2NEMU54TU5SVmRRTWc2NHI3ZkR2VzBwRUdJN2ZC?=
 =?utf-8?B?R08ra0l1Z2l2RUlxdkc4b0FiYlkrVC9MRUlmRXZnMytMMTQ2bUN1ZzByMlBE?=
 =?utf-8?B?cEwvZmlrRDRZMGhUdGp3bEszcVBweWF2Z3dReUlFR3c5REh4dEd4enhTMXlU?=
 =?utf-8?B?VlRzRlNxMjhXMmQwK2pROWh4WVMrbXJ4M3RxdERZTFZwWXg3N2l3ZjczQkhB?=
 =?utf-8?B?a0Z3OFR0UXZqb1FNODh0QWxmRGtLd05DQUlsWDVNbzVkUFYyb3JGOUFUTUxB?=
 =?utf-8?B?UUIrSFFNQ3dKZUJuRHJSWDNlR1hHS1JPbGtIanBWNXlZUE9paTVNblprRjJG?=
 =?utf-8?B?c2V0QloyRlFqWjByNkhVSUc3WkhMZGZLd05jNGVGbWpSTUIrQUlmajRnSVI4?=
 =?utf-8?B?M0I0VlhHcFYxZk42NXREZnlIMnNWZG5HZTRXN0VDd3Z4Z1QwUVhDTHBuUlVa?=
 =?utf-8?B?d3dCdDI4dDZJVGoyUTNVT1lKYktWeTM3ZW0yVDVBTm9tcnNyWnBjTVZZYnRY?=
 =?utf-8?B?TEVYL0QrcEVTc1p2YTM3QW9wUDVuclVnVzNtVzM3RVFHOGV5QyttbHJZcEY2?=
 =?utf-8?B?c1owczM3S1QyeGIzZFJQRHhVbXU2V1BJWlFZdXJSQnZvYnFOay9IdDNmandC?=
 =?utf-8?B?VU5HRGNjVEp2Mzc4QzcvVXNLdkpZa1JLL1VoSXJGRC9iT3c2ZDMwdElXRW12?=
 =?utf-8?B?VENld1VZSnlTaFppM3phRGtmOEQ3SHpGcVE4dmtPRzdnaFBTZFA1cnNQMXJW?=
 =?utf-8?B?c0d0WTdIT3FWQzBLTzVoS1hnZ09FSmE4Ulp2NjBLc3lCQ0g5TzBOTU40cmZz?=
 =?utf-8?B?NUdZNnBHQnp5dGl2OFlyemtlTlova3JjRCsrNk44NHhOek9yV3dCcE5aZGI2?=
 =?utf-8?Q?hmjjYDCoMOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdRbnJ0K2dHdjJUMjB2elBmNmVBS3lOdEJQbDRtaUVnRFc3VjRmTW82QjZ2?=
 =?utf-8?B?Qk56OTRMa1V4QWtTME9HdXBhWEFtbm5yc1llaTJGdzMwd2RjMENNa2ZlSWh3?=
 =?utf-8?B?aU9pTWM1T2twdTIvVzF1ZjNZTGVKRm9VTnd6eGhsK1FOTVRmT1lZOVl2cWwx?=
 =?utf-8?B?eHFlUlRuYldpT2JpT3hNV1FXeWJPeXhsUHBGdThFcWozYU84cU1VaUdTQkpk?=
 =?utf-8?B?dGZvQU5wNlJqMGhYdjA2TTVjTGRsL29IRmwrVFFURFg0UFl4Q2I2RXVYMllz?=
 =?utf-8?B?Qm95R2RRQnphcCs1NEZuLzJPSVJ4V2FYcXV4ejF5N21DSHVBVk56cHRpbFJz?=
 =?utf-8?B?SVNhcGlZZ3FXNStvUGNXaUNYMmhTd2JUeVhkSUZCcysxenRuMzZ2K1JZSjAv?=
 =?utf-8?B?YWc4endlWG1pbGV3cHRGTVRVckV0SUR1MDRKK2s2Rlh3OFQwWVhQMXVJYnAz?=
 =?utf-8?B?c2FuUkd5M0FDaktiTTJNNHJWU2hnSnJaaDVQWTR6c2pMTlFyRmhLbmloaDJF?=
 =?utf-8?B?UXZvalNsMkY1RW1iSEtEUDF2Um9hR1cxdHI5Z1J4UVpSK0RyWFliYmJtbEdL?=
 =?utf-8?B?VjdYa0EvR0ZzMkF1TGJNMmFYbS92VlNTMmUzcURvd0t6T1p1NVFvUzNFWHRz?=
 =?utf-8?B?NE1kbXVuc3JSZUo3c0NNT3FMYU9keUlyNTBBMXR2RzlsUkdOSHZjZFo0Rm91?=
 =?utf-8?B?dUY1YVkvQUVwZUk3emswOFZnejRtM0RXNFRxTHdxVlhKRFJoWU0yRDgxcDZk?=
 =?utf-8?B?QVJ4UHRaYWpubTEvaG9QQUtHVE5RU3h6ZGUwekxQS3FhYU44dWYwWndxekFp?=
 =?utf-8?B?SDJXRkRUNjJaOWtZS3kzOWJBQ1lBYUZJV29xbG9ncVc2YmhRSjJZUHhqZTF5?=
 =?utf-8?B?ajhGTGpJVi9YcHVVQ1o2TnBlSmJtbFJtZDRrOVhLSUJVczJiZkdNWk9QNU9C?=
 =?utf-8?B?ejl1K0J4UkpjMjFIQmc0TmE4QVNyM0M1R05TdE83V0FqTWlXaENlUXZqN1dM?=
 =?utf-8?B?a3ZGcUZERllac3k0SHRHNTFwRVpKL1A3NytNSSs3aG92NWZSclZncXhsNHJT?=
 =?utf-8?B?bUVaaHBqUE0rOVlFZ3RZY3REd0g3V0pSbzJ6ZDZhaWN6ZG1BNlZPTjNXSnYw?=
 =?utf-8?B?RVVhRFhwRFV4QnZzN0RtWEZMakRBenU3M1Q1ZUVMQTYvREl3MmE1VEtNVkZU?=
 =?utf-8?B?WDVkYmtkSjdVRXIxZFgyd1ZCdXJ4Ynd4U05hNXBnN1Q1bE9iNGk1eENVRVNZ?=
 =?utf-8?B?RnJZV1ZOVG8zOHVWQ0MxY29DNGhrbWhWRFc2bWFqcnRUTE5rejY1RzVYb2J3?=
 =?utf-8?B?Nm5Iam1PVU4vY29ldlRxMHFOWjBWbUF0WkN4S0w0TkNTQ3FUcVZ2aDFxQXA1?=
 =?utf-8?B?UDdGWWpxQWJqNXFNSVdsQ0pZTGxLZlk1OVlKM0I1NnIxSGFqcmxRNS9aejJw?=
 =?utf-8?B?dmZPOHNUZFlOZ2thWlFkWkZaZ0RkT25FclppbGRRSHVIK25pU2k4V0RlQ2Rj?=
 =?utf-8?B?SGRqNEkvQ3VDMUc5SkxOQnpRaDNqRmFJeEZjaHdmOXVxa1U0TitGUGovR2cx?=
 =?utf-8?B?QXAzMlY4aFozUmoxZW9WSmpPN0g3NmtsR1loY295QzJkT3ZZMlBGSWVMeGt6?=
 =?utf-8?B?VFVVcEcwT25RcENjVlVsRktQRWxRcmw3SGI4K3hoVWt5d2FuRmNrSFJrV1E0?=
 =?utf-8?B?NEJsSDl2V0J4cmNJZk9EUDdZMUVjYXhuK2dFNVl1YlJpTWVVZFFObCtuQnhx?=
 =?utf-8?B?d2V2Z3I4WFcyV3pCVHovQmZlNGQ0ay92cHJoSm9LNmZYSFJQeEFwTHdpYWpC?=
 =?utf-8?B?R213em12dzFVMGVUMUh1dkV6bmY0SmF0eUIwYXFRZWdLOGM1SjNBaVhoSmV4?=
 =?utf-8?B?YmJBeHlEVjlhMUoxQis2R1pDckF1cSsvai9Kc2ZBUXlESlpiUXlPdjNZUjRF?=
 =?utf-8?B?anNQVWErQ1g5WUR6RzVjZVdLNFVlU3huUTQ0TTd1eFlyb3Z3TGFiV2liMFV6?=
 =?utf-8?B?NU9HbXVvdVA1R284bXZtQXVZSmdYNTI0dlIzeUVIQTQyanUxTDIrelBkWDlW?=
 =?utf-8?B?R3J5bENNOGlRT09qRFU2cW9FYjlVcHpRWnpIVEMzUStwMS9qdUc4TEw1TUdR?=
 =?utf-8?B?VCtvbFJIVUdiYlZSZWVYc2VHNWl3UXBwOTZHMWp0a1pnOGtCWjhaMHM0VjZP?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a32e4d6-37f0-4136-4285-08dd94d8fcfa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 00:23:03.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B62ZzRBdORyqxiwbCIPHmd52P01dWRKUFQUDJ/d6rrxSO4fP2RB53d+cHW93FXf8O1cipzTMw6FdI7b0wAa/6B9RDk+NhB1E7h9+F5gsu3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

ruansy.fnst wrote:
> From: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> 
> Now that cxl_wait_probe() has been added[1] to wait for udev queue
> empty, the `udevadm settle` here is no longer necessary.
> 
> [1] b231603 cxl/lib: Add cxl_wait_probe()
> 
> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> 
> ===
> Question to Dan:
> 
> I understand how cxl_wait_probe() work, but I have some questions about
> the motivation of adding this function:  Firstly, is it function added
> for simply waiting for new added CXL device been ready before cxl
> command does the actual work?  Just for replacing `udevadm settle`'s
> work?

No the motivation is that a command like "cxl list" wants to be to
determine that a given object is "enabled", i.e. driver attached. At any
given point of the time the cxl_pci driver could be going through async
attach, and the arrival of the cxl_acpi driver may trigger
cxl_bus_rescan().

So the assumption is that interfactive invocation of cxl commands should
arrange for a stablized snaphshot of the topology state.

> Now I am facing a problem that cxl command takes a long time to complete
> when I run it in a udev rule(do some configuration when CXL memdev is
> added).  I found it is caused by this function: waitting for udev
> queue's endding but itself is in the queue.  The cxl_wait_probe()
> function does not seem to allow me to do that.

Yes, that is a problem.

> So, the 2nd question is: is it against the spec to run cxl command in
> a udev rule?

No we need to find a way to make that work, so I consider this a bug
report. My initial reaction is that when called from a udev rule cxl-cli
should honor a new environment variable, perhaps "UDEV_CXL", that
disables this waiting that is only meant for human interactive mode.

The udev rule would need to know the potential asynchronous states of
the topology.  However, as long as it is performing object local
operations it should be fine. For example "UDEV_CXL=1; cxl list -m
$memdev", where $memdev just experienced the "add" uevent, should just
dump that object's details without waiting for the rest of the topology
to settle.
