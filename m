Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464737B012
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287723; cv=fail; b=Ydti3Hrx+GH7gsskWblO/8QIUXZjHKSugDltZBd+56JyLk2SNXdxaJhGyhSbJSZJRvRHIHSytXEu7r1Eh/r1uaPhd96L8UPSm8yopCgaclSAS/LzSs/wXUIqLAPWvgmCwu8fFW9FhwqB4jFxXLxJAQaq+KlHcEe6kifoyvCCg4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287723; c=relaxed/simple;
	bh=dx5r6EoiIGkD88FGGJWIDvue5wcZq6HZzVvm4X3OpEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KpEte1XlPWUOC6deEZLnR8xiN3N0CiWlo0XMErxBnw5tbbjQ80es0IxeWRf4NFzybo2BzB6qVrdQhdjvFP+xQImvvbGlbfayAqSxBiogttxI4hwjuSc1G8SB3lLsILeKChB73sGwiqt277j0oyXuwG50l5Z78kuY3NOagvLtAuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZlvjPEa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZlvjPEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781287722; x=1812823722;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dx5r6EoiIGkD88FGGJWIDvue5wcZq6HZzVvm4X3OpEg=;
  b=HZlvjPEaQOk+wd2u5WVt6irmepZexG5r/92jOFhD8pwT7WecRD5HnEP0
   HZABgTsIAP8ZT+gADvo9LAC8zVX6fFt8bjTx7Vq81QAAZ0+OQFVP34CKO
   9I31LLTXMiNaNWerylmjTs9/AvD9ccAuKW6yN4YxArO1n+8pEv/LHnCNm
   FiemKmq4IQIRTD4RmFdbLtbZnL7qLdpFuGR7fQJ/YLK8YdMFOeDeV04Wa
   B7Qa5rqjEMhZQ1u7a+1+bSrnQE2VvYwDRE39s0ueoJd16Gzvfinl0show
   FOEyUKlZmFWFIPwC5QtyYa/8weWK8G9fngFD/HPSB+Vl/bfwAGFaMiACl
   Q==;
X-CSE-ConnectionGUID: ww5Jjw8XQW2q74cHazsBgQ==
X-CSE-MsgGUID: EMLZwv5FQwqG3p9o7l5ugQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82186032"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="82186032"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:08:41 -0700
X-CSE-ConnectionGUID: j7O3SQNGQrK8aRhzqv81Pg==
X-CSE-MsgGUID: kbu3DvZMQ9mAqkDnn1BKLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="250799047"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:08:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 11:08:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 11:08:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 11:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl5WLnth2SKRRUp+0Ovwc0MSixDfRREvppCWb9/MsQAF0wfzvD0TiFhaxzQTWD9ltI8/xpGQrsjbu8X/e027WOCwmC35aZUBPJ4HpfNtAUN7KjZ4vd2oK6GBc842fB5+C6FzufzB6Y4BQdz1pw6txKf4WEDd49A2Gmo1kHTL7QkK0N/l8KsVhjvddK4Y1bNIwx0ZrAKDV5xbWodc0l/M8lhak+sGiPvTjJaG7PwxqfXHyZRkzKilV/GP1keCrcSiFVjVikxeuYwRmdOJARqTaTL//TLfNEzMWzO0k17aVVUV3+li1VDiS497apHkW5giarfMa0VpndtAUGAs+E6MLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ce3FSy8F9iiGkn3ybBlVIlIFyZrWDZIzWFChaTm1Jc=;
 b=STeWizvT6Pd9fvulLZY775Ay8YHMyDQyL0XYqO02FiwVgaonMabHkj96Jcofd/eDGt1SCwwoQY+fdKerG3ZlmjyPKtYTtSDGIsVTYXBgP9lo5MaYnymzeLJAtpgmB20sRMSikVpsv4wxKZzlVxGyaZyvp/gVzsf0JGapjOituqgVY1gdq6LgDl9+zRfXhcQtJzXQYlXENthvDOhGNcAVT4e8tqvpcmMG4Zl+JIrhjXvTIw77WB4IfwA8TZ++Yxl/SPeeZ6CD+mAUicHf3osij7rGj3BzodkRsLWYA+jQN7sVQbWaVENy7yHBol8in/BvZ+UqpMz++zI7+ENwbNR1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 18:08:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 18:08:33 +0000
Date: Fri, 12 Jun 2026 11:08:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Purva Yeshi <purvayeshi550@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl: Align interleave decode/encode helpers with their
 callers
Message-ID: <aixLHWHErZ2h_Gpo@aschofie-mobl2.lan>
References: <20260605040801.865965-1-alison.schofield@intel.com>
 <01f42b02-e050-401d-9b0f-f2b0fc6b8d23@zohomail.com>
 <aitqeGQHdIfKz0j-@aschofie-mobl2.lan>
 <b10a77ec-f321-4e95-9347-34df96064d64@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b10a77ec-f321-4e95-9347-34df96064d64@zohomail.com>
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2d8d2d-5036-45c9-2334-08dec8ad9db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|5023799004|56012099006|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C+4xRWhOqKGfr/MeG/zG//LW/WN8V2PWAWg83cZUzA2YF8A2CitkF+oFMw/FLKA9Av5lYmmB/WQKa6/pY7O2odQViTZ5c7t7ToksHbY9RP+0toGJFYgmo6th5+7iaUN73YWj/LQ1hUSAK5u+21lUlIssVBfUnPPJn5+IclI60l49kNyepLaX+LzXqhT2WF4yNRXNozo7DMfqgVmS3CivlLJKGyW3z1co4Vgc+KGvSmJHLn5j2ZjvrTWfxtMnDgs0ivsVXBz45wVHfCXIGg3sxEiKZWONd1OPXSx94mq9Cu7LQQaSTx2OZCcAeMtPw6TGmJV3GvEfXuEKX6VDFiHY9J6H7jPHVkzGCH56A4OpsD0d5+Ml6HJQrk1SxKlul6EyhUs5cntjBLJnmvelLJ9hT0DnetxHOueD+KMa/0/Un2tyENFiipWF/WLmMHhyrJsIYZwtAQc1kYyS7clUZNOAMuvCOrdqjXekKcK03+D/KXwaJluIaOwz0QjPcc87LD/V8BMsGVrLtVVuvM34k9fQVceDcSFkWCmQ0HmG8HOkNpK99r9OyXh2NX7E260QV1eL5ZmQjzfkN+tpdwC6eATJW/pNFhKKdWcukWVGOW16Qup16Y3N9eIFRuajoTTM5h1gJZaaUAveI79Iakp3KOUm/t8XcJwVB4mjv/RbiIgZ2+1mhqIPqJ5pzfg91AJLiZAYBaW7oUy+AUx+0x0SmM+z7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2owbFBpRmpubHpRTkFUR1ZIRXNNa3R5QmZZSWY1eVFpTEVMME0ydnFFZWxI?=
 =?utf-8?B?QStnRTU3SE9wOHBHMFhvUU93dUlyRCt0azh2UFNyZDNqbGd5YUlhMzdMQzBM?=
 =?utf-8?B?Q2JLeDlTUEhyZU9zK3FKY3VtbGRZRWszRjY5YU04TGdrdjBCNWwwOTlOQW16?=
 =?utf-8?B?UTlxYlc4SGNiLzRXV2RCNjBMVG13enlqNGsrcDY2dHZUdXFKejdMWmNqT0Uw?=
 =?utf-8?B?amxwdmhPdHFNTGorQ1pJcjRGOGx3TXBxb1dKUE9RRzJ4VG9UejVzRmV1MFg3?=
 =?utf-8?B?bmw5bjh6Qnp6K1NQV0k0REovdzN6WERsL0ZFOEZiMktrRmpLZEJsNk14bGpS?=
 =?utf-8?B?cHVSSWswbmVvbnUrQy9ieGJtYTRBU1BkOVhoVDBPY0tRS1JkRHcrTDc3M3NM?=
 =?utf-8?B?V2RXVnA2U04yM2I1NnFUSnNCVHZRYXd1ZE1XbWxYSXA2S3U3d0tvQmU3bi8w?=
 =?utf-8?B?RnlYMXIwRzlBT1JTV1Q4cWM0Qkt4Q1VJN0VUQW5nN0M3TitPUk9pQnlMMWJi?=
 =?utf-8?B?QzZKdHh6T0hFMEJhQWthOG4xbW8rVDJSaVZHOWswczl3V3NxbERJemJUZWJq?=
 =?utf-8?B?WTVHN3VycVNRZ0I4OXhWRC9Iejg4VDVnY1g5NVJvbEsyeXViWGhTRllXUFVy?=
 =?utf-8?B?bDJPTG5Ma2hCa1dCbnNTaUp2U1JPcWZqM0N1OG9ORzdURDl1MlordW9MRnlW?=
 =?utf-8?B?M042a0p1L0RNd01lOTV6bjh2OE9HTG4wUU43NlJsZE9HTjJGOGxOeXpqZ0k5?=
 =?utf-8?B?cU1GV2hyWjdxRnoxRE4zaFZ1Y2Q2QTIvMVdINm5iMzUwRmNUbDVXSGd1RmFV?=
 =?utf-8?B?ZUQzRCt1R3pMTGJNRFdvczBWbnEzdjV1WGFRNWpXejNjdUN6Q1Z4QnIvVG52?=
 =?utf-8?B?V0grT0lYQncxQkY2STZPT0o5WmpuK3BjR1VWUE1XRDYzRDZlc2JEQU1vaE52?=
 =?utf-8?B?Uml6L0dTREFPeXZOeDR4Z005Nk1rUTFud3hONUxkdGhoSlhuYXJSbDMwdjF5?=
 =?utf-8?B?YnY4UkthdnZCdmVEc2M0UVZCWk5abU81clFFeVEzODQxMHJQUTdqNzg4N29P?=
 =?utf-8?B?K2wzZUFibHhsMG5FVWN1OVQwNGdLanVEblNxUUdYYURWMzhwSkxnQjBRMVlG?=
 =?utf-8?B?Q1AvZHJ0T2FHYnhpNnB3cXN5U3ZFSWpIS3dndklqd3ZXSFZXQ2V5NFg5QXM2?=
 =?utf-8?B?MmNIUFErUjNsWWFGaUdsQzRGKytmRXJiLzVzVHVLOXNGdFBXSGVkdStuSTFL?=
 =?utf-8?B?cWk4RW1sOE80aGJWUUdnT2xmY3hJUG1OMVhWcmljdTVGQkg4RmtqbWh3eFhE?=
 =?utf-8?B?Ly9UYyt2a0NNWEJnejZTcmxqOTR2NFFZWnE3OUZmbEkyaHF0NGk3TTBqc1dB?=
 =?utf-8?B?RjNSRHM4bHozVUY4dS83MUxzbzg1OXgrS1FDaTliSUkvSkIyMHZ2WW16SnZs?=
 =?utf-8?B?QzJXRFM5czZGN0liNEY4MU5TclpTOE1vWXlpaWRXcGd3T0l5RkhaU0NzbGxj?=
 =?utf-8?B?OWhoamZTV2c3YjVmdWlHcjNZdGtidVVIbHk5bHpRZ2o2L2JlZFBHWXVDKzJP?=
 =?utf-8?B?MVdlc28wVUIyd1lRWEg3Y2ZkeWcrZVBqSFRyaE5FeTVodVNkQVlsTC9BbzJk?=
 =?utf-8?B?QUlQcVRzbmtLTm53ZXBVOGFjR3cyMFhFT25pS3FBSkcvN3MybFlGM2x2bWdN?=
 =?utf-8?B?YWxRcUZmd1hEZVN2cHh1cmlBYkpFWHdISjRLQ1RKK29ucFkwWUpvM1lhbVR3?=
 =?utf-8?B?OXI2ajNHZ1ZrdGJ3UCtkSVRYQzZ1QUVnQk1rUFdaa0MxMlNRVXBUTlkrV0xC?=
 =?utf-8?B?YXUySklTeVZZbzlVekJVZUMwNWRMMnpkYVhnQWVNcmN4T0VjQUM1Q3BNZ0Nz?=
 =?utf-8?B?WmhUb2pzTVkvMnJTMjlyNTlQOVpMQk9wVldrTU9UM0o3M2pKYllrVGlsVHhO?=
 =?utf-8?B?bCtkMlBucDQ1WlIzMm56VnNDNUc5Mm1nQm04WVJLL2pEZFYvNThFVlpQc052?=
 =?utf-8?B?V1RQZEFlVUdBeHlPZ05iMEhoTXVraVIzRitJRXM1WEpxL3VQWlEzckl0emtI?=
 =?utf-8?B?NmF0bXZMWmV6UWtHZ0w5RzNrVkxDTHprSy9VRFM4NmtENExKOG92c1VDU1lz?=
 =?utf-8?B?VEdCeWk2d3lOOURsZzVPaURmWUlELzNMSlRTUE40dW94ZytuQ08yTWF3Zk9C?=
 =?utf-8?B?KzBFeDNJVC91TVNjUEk1eDBHQ1B3b3NDdjVYOG10OEtMK3MyR2V2ZGUxL3A2?=
 =?utf-8?B?WFNUK0FjbCtWK0ZqSTV0a3pjVTZ2Mk5XTjJad2hmNWhrK2JqMm5iMHdDMG0y?=
 =?utf-8?B?QlUyK21nZ2s1WE5CSEYwRit0eEdjWkhoaERoV1hSUXYrNkkvMmlwTExTejNU?=
 =?utf-8?Q?s2RA5Ozj6ddN9Agc=3D?=
X-Exchange-RoutingPolicyChecked: EHfLB/zFoKc/iT5D78e5XHZm5DtY4Fy5QKXmyDoP+ruYVxVr4IoiYwe6uj8l9Mx68/wF0bK9dX5q3OUPUZt+df1tNl7TMnfV2aWQrxUcTtbcwAIDECtKGE1MLwvQDKcXNzvckDAn4kY0S1qEHVaShr9cPvF70tFV8y4X7WBwZ6oYcmgIbAOI4/ykNwGYh8Fsc38AyMAYXBdDqDTJcQg3M2FGnVcU67Fs/tQXRbFdlNHzBZuQtVLJQiTjQWvlgG/VTUGeUyUmok1CLmyBZz2nIcnegowOMqcl5FBygfOTL3J+JZwkpSToVqXFnPivW6qhUA5y6q0D+w39Obny2AwbTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2d8d2d-5036-45c9-2334-08dec8ad9db1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 18:08:33.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D9+6zdgCD6ova6sXOCtOiFseNanbx8vXiGjmgEpbdqo7JqKsKzqBuibRb0OapOAcsVcUFib7nfs8u9c4nY75Stn1HhS/o0g4DnK3bUnkWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 10:49:06PM +0800, Li Ming wrote:
> On 6/12/2026 10:10 AM, Alison Schofield wrote:
> > On Sat, Jun 06, 2026 at 12:21:04AM +0800, Li Ming wrote:
> >> 在 2026/6/5 12:07, Alison Schofield 写道:
> >>> The interleave conversion helpers translate between encoded HDM
> >>> interleave values and the granularity and way values used by the
> >>> driver.
> >>>
> >>> These helpers have been a recurring source of static analysis
> >>> complaints that expose type mismatches and potentially uninitialized
> >>> outputs. Fix those issues in the helpers so callers inherit the
> >>> consistent behavior automatically.
> >>>
> >>> The decode and encode helpers have different interface issues.
> >>>
> >>> The decode helpers return values through unsigned int pointers, but
> >>> the decoded values are ultimately represented as int throughout the
> >>> driver. Align the helper interfaces with their callers by changing
> >>> the out-parameters to int * and updating the handful of affected
> >>> locals to match.
> >>>
> >>> The encode helpers leave their out-parameters unchanged on error. That
> >>> means callers that ignore the return value may observe uninitialized
> >>> encoded values. Initialize the outputs so failed conversions leave
> >>> defined values. This issue was originally reported by Purva and the
> >>> helper-side fix was suggested by Dan [1].
> >>>
> >>> Tidy up a related, pre-existing, printk format specifier mismatch in
> >>> cxl_validate_translation_params().
> >>>
> >>> No functional change for valid interleave parameters.
> >>>
> >>> [1] https://lore.kernel.org/linux-cxl/20250419203530.45594-1-purvayeshi550@gmail.com/
> >>>
> >>> Reported-by: Purva Yeshi <purvayeshi550@gmail.com>
> >>> Suggested-by: Dan Williams <djbw@kernel.org>
> >>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> >> Reviewed-by: Li Ming <ming.li@zohomail.com>
> >>
> >> Since the types are changed from 'unsigned int' to 'int', maybe we should
> >> drop the second parameter of these helpers in the future?
> >>
> >> A negative return value indicates failure, other value is valid.
> > Hi Ming,
> >
> > Good catch and good idea. Thanks!
> > I'd like to address it now, probably turning this into a 2 patch series.
> >
> > Not exactly as you suggested, see if you agree w this:
> >
> > I'll convert the two decode helpers eig_to_granularity() and eiw_to_ways(),
> > to return the decoded value directly, while keeping out params for the encode
> > helpers ways_to_eiw(), granularity_to_eig().
> >
> > Decode converts cleanly: results are small positives, so a negative return is
> > clear, and no caller is made worse. ie ones that must check already do.
> >
> > Encode I'd leave as is. Those helpers run on two kinds of input: raw sysfs
> > values, where the return value must be checked, and already-validated values,
> > where the return code is legitimately ignored. Keeping the output param,
> > together with the *eiw = 0 / *eig = 0 initialization this patch adds, lets
> > both kinds of caller share the encode helpers.
> >
> > I'll go ahead and code it up so you can see if you like it when you 
> > see it.
> 
> Hi Alison,
> 
> These changes look good to me. Thanks.

Dave's applied this patch for the 7.2 merge window, and that does fix 
reporters issue, so forget about my mention of a 2 patch series.

I'll just come back around with a second change for the next merge window.

-- Alison

> 
> 
> Ming
> 
> >
> > -- Alison
> >
> 
