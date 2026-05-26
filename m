Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32B38C42E;
	Tue, 26 May 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828601; cv=fail; b=LC6qGWQ2e+Wo44TMty0SiABOEaGoFdFob5uL5CvvRSRqwuNuGW8JfhhuNJ2OXt0t6E7m9QOjznZbnyUEqNlIk3+ujHdZtdE+bPvppffe5xmNz8XCfduB1kwull4YMs951ArW/h4kuvK6HEY+UVNs+2pYoE3TKhODWIBRSOi82ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828601; c=relaxed/simple;
	bh=3Gh+d/E3oP5RMp/0caokJhxaDvvAEEyOnU3ywJ/RnFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/2IncBAUdoPXWf0b+Ln9K24DvBOfnUSTJ1IVlu23ThyBqHXxp1yHkkpV9sAr/lvmO9Q1i451xH+L0j9O9FKNVa/BGg6Cf1BtH8jVyzKmM1jt4TVHyrtLzInCWoJqaCx14F6AzK8op44BsvkeN92itJbXyeTuw7EXU3REmdkQWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaBSTIS0; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaBSTIS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779828600; x=1811364600;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3Gh+d/E3oP5RMp/0caokJhxaDvvAEEyOnU3ywJ/RnFE=;
  b=SaBSTIS0HxYI7f5nJ+3c4otieKJt8a4y2TdR7ZVaJqj784nMCkbK2QO2
   LJ4g3+ImfXlRuST6k//RLtbVQLnikickQIiUY9WAPRCqQzUbp7Liwusw3
   7y/6s1tzIwv64n2SQWce9oIOHQdSFoOxZEiTsazXEkUG/+AHh8xIJyQAp
   teJj3iem7KIX4xnJ5cGSOpQaHDE4JY++E8VGELLavFbyzQCGgJML/9c0g
   tOlqbrrmUHH4ufq0HIzfpEuj4qe/JV9qquN/Hsio+rNOAU5QdEwfu+L5i
   llZ9sOKRwBMjqryIx3XRZylHWWmS09HOW3g33yhtavBZwuN06S83hCjU7
   A==;
X-CSE-ConnectionGUID: BqVJomQXQTeGeDsTOmk9RA==
X-CSE-MsgGUID: /J8HlMpYRKOP2Xm5AQBJng==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="83233433"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="83233433"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 13:49:59 -0700
X-CSE-ConnectionGUID: SbhOxWHiTG+UR8CoWkM1rQ==
X-CSE-MsgGUID: gn5lqSAASjCkfWyQ72SvAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265893349"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 13:49:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 13:49:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 13:49:58 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 13:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qomk1q3vdJx4g0qSkW4vz7aKWR8vAVcF4HgkJfmvdhYJTTVC99DtqhUpBBwyvNtIcy2Q0gI8+n5d1S261urrhdOty/HAVfA6Hnj+lq14ELTfzSd6FE3lJFTDpIa5Z3gRMBEzFRq7lgNzVl7fCK7FJwIipEY72mWUoeNct/icZMFVZlxwDMIGhau1I/IlwpmHyA3p80gY5mTjZIRyNMSbXDZgpjzQ12aWz/WLXFlTMPnNKOCSJLLiDg9t5T9M9KZs3sVo3xLs9GwE/SsGfhfB28LZHgGkmiqUMRydRhxdpppFDmt/MZsp7uWBwGW3yjC4GCk0fchHlp/Q7dT79iU17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ2EDuoinKYHoDa3qw1RHWn6Xel2yQ2VjozB6JpqC88=;
 b=SCTlT4Pb6ZZ/obAsX56fPFdJzb/L+jNGuGusjl5AXT6XXijZ7Yn/oGVfG2dbbjYL6unejHOrij1qwYZYlaXBwMq244QDBGPWlLZCY+mWe/cTO7mKYBXTfU2XyjvXEB5xWekRKOrzQTCooxuXChd61uFUnFo2CkHSditiQcolTLaW1fcDCGZa0d41xJNR1/VSFfCWMHnkBXk1Ryh98EwGBsjeq9o5vyjL9G7pzDvc3pxtFYBb4IOES7u0Us2cMuSkJFV3BN8nzx6ApkDEsmFvvTBtF7IXJmtc7yDbhMKENak7mXnMFiVIlJFqSwGAFLBfCR3SU9thbjMxP9UR1TgiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6711.namprd11.prod.outlook.com (2603:10b6:806:25b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 20:49:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 20:49:47 +0000
Date: Tue, 26 May 2026 13:49:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/test: Update mock dev array before calling
 platform_device_add()
Message-ID: <ahYHZx0NSqfGSQjy@aschofie-mobl2.lan>
References: <20260520121457.234404-1-ming.li@zohomail.com>
 <ag6zbJFdvxkf6Q9I@aschofie-mobl2.lan>
 <082c7b2d-e9dc-443a-b385-79585cf8e48d@zohomail.com>
 <83dc5f69-115b-4d2a-bc0e-46ed0c3cee10@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83dc5f69-115b-4d2a-bc0e-46ed0c3cee10@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944a5b9-1c7b-4a5e-0b53-08debb68529d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: QjiaOEfRMf8YnQwjpJ/btQnQtBpV5iYC+1zWncmEqSnO8/iRBuMgPrQDhzLnPggJ/cY6E+twrzrINBq+zFIM8fCC3F+bc6yJkOMEysBw4l4qDc0vr//GFfpxeAv6k7qZjxl0rl0/eSRYut4Y+/pXXChLGBTCaNfbCDTbYDUgu1zfRpyuUNI1NmIh0Q/YeGthD2baGit63H4dDYzzHeHfkoUck7ftEnUV8j3vvRjYCHQN/WnAREKgP4Ck6tTwGgROYrI03Zc+NPKHRdQ6jQThWYxLCtewjwfG4ogp+3hcuI7KCrN/siOllKJB2nfGosKqc2YRb2n9Rw42jgAMDREDl6YQDmyC1q0Ycj4l1bDg1A7oCaWN52HMzzMUYVCMbqTiwRRAx2Mm0udnlfr/yrUsDzT3aAFNS5A12SPYvE1THzIfE9DRnivDRmTug+e6REdDmuP2nh6+58RM8MpUs2WEFbxV3HGSVhhFjqGya0cTS/SSdkFFizS9QflSboTn8SVptzSqIR87nm0tcCxht8puCWqSBb5a9Yh6ol74V1HaLtcV1HdLKQX2pWvLHvfg0PH2Z+MSklwnD91LFDZV+0wr5+tc0ShDSodVtIO0NhXYPkz77tz7Xxb2+lM45zCEwIJjPxXN8MFrh/LYSjSEtNov3FHyMIePrCAhCUJdmy5Pf+XP7GaC94HDLeX/r+Ap7MMd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmd5MUw2QTk4Z3N5ZWs3Q3ZJakdIRlowVk1mVUltV3dnQkVJNUVqd1VtY0Qv?=
 =?utf-8?B?Vi9NQUFsQTI1UmVjTmhUMk9CVU5lZUNuMVNndlFSOHBiSnFGOHk1UUpIZjg4?=
 =?utf-8?B?OEVZcnZMbmJnbE9maEJLTjhJVVV4Qkk4NXU0em5GZ01CNXFWWFlKMWhVYjhM?=
 =?utf-8?B?ZkMxbEhubkVPWFFQRWFJNVZ6NXpsY21UN0FFZVdnQXNmTWJvcmF4VlV4SzZw?=
 =?utf-8?B?Z3NEMzd0MXFQTXNrZjBaVm5JV1NMUTIyKzA2RlNNMTB2MmF2R25mRTV5dng2?=
 =?utf-8?B?TzY1MjlobDFXdWphdkhkYXRyUWorR3cxUWdQZ1k3ckVrSkY0WVFkMk5JKytE?=
 =?utf-8?B?bjRta2w3bXh5RjlLcFdNTjV5UTh5alBUSnlDM2hyUThwd3dEYlpaS25ENVJl?=
 =?utf-8?B?YlZaR2xMYU9peTBzZTJQRUFFVnZUZW0wMzZOV2oyZVUveWxQZzh0UkwrWE9v?=
 =?utf-8?B?UFhiNWZwb2lwcnlCSHBIU1RzWUtHOU9mdkk0OVZOeHJ4SVF3TUpKZVdiZm1J?=
 =?utf-8?B?Vy9WUmlQNlNpYzBFQ0lvMnJyQ0kxbU1peC80VWlMY3c2TkJqWGd0ZVd0L04x?=
 =?utf-8?B?dXBxVEw1cEswYm1lUWRCbkpUenZYZDUzTGhQZXVxQnY0M3hYUDhscWpSQ01t?=
 =?utf-8?B?SktVM1V6V3EySHJlSnVrQUtJNUFMZ3dIc3NSTm5BaXQ2YmpKMzdoRGp6c1Na?=
 =?utf-8?B?T0ZMMmtwazR0Y3kzckIrSmxvVXFrQ1lOTHZoSE5ESVZTczlnY3QwcDlwUGJj?=
 =?utf-8?B?OUtBc29xTXJOZnJtV3FVanhCdlZ0RWM0a1J4NUNaNlBOT3ErcEtWUHFjcktk?=
 =?utf-8?B?N3hHR0NydXBsWVJIMVVSVmhEa3UxMW43QWhScXJlOUpBU2RqN2NnTkg4TEdW?=
 =?utf-8?B?NC93am9pOVk0SkhROHZDUFRlVVVzWUJqZzZycVgwMDhGcVhBYnNkK3ByWVhT?=
 =?utf-8?B?UzNZNDFSZzdkNlBvM0o2Y3ZWREpqNlFMWnhzNFdzWlBJK215WHBPZlFOT0dO?=
 =?utf-8?B?V1J3c3gyRWJzV21yNGQydEFXaVVHOTRkcVZkcUc3Z0JuWGdRYXhPZ3UrTzFL?=
 =?utf-8?B?YkdudkpBeXRJalltSDRIdDU1dDRpcU5BM3lmS2pLeENTb01DUDg2bnRpS1pn?=
 =?utf-8?B?VGlNSXhLQ3ZMN3gyUUdzUXVBeW9xNDhHYW5JYkJMenJ1enozWno1ZFBQK2VM?=
 =?utf-8?B?SHhBOTkzZ0lpYmVtZmRLTUduKzF4eDZ2ZVUvL2tKdXNHbGlFNGdiMm0xcklx?=
 =?utf-8?B?RDBQL040RzFvSzk3RWZQeVVsRWQ4aU9seTlTSmV1aU44UGJYMkZkS3JpbzhT?=
 =?utf-8?B?LzNSL1RsQ0l6WFpsWlZGaEFJQ01mVVlRa2ZxNkNtdnFPWDlVRHl4M3pFNXVB?=
 =?utf-8?B?K1R1VXZrcXpTU1BvWFlNaGlFTk9TQTIyWVlOVklGdHhBaFNjRllQcktwVElK?=
 =?utf-8?B?MDU4b0lMek9wK2xGMk5KcTNBM0V4dHVKY205VmNnMU9rQmxKWDQvRVl2ekVW?=
 =?utf-8?B?TTl4czFZQm1PK3ZOdkUyeTNpbldkNll6VVd0Q1oyZ1Jjc0x0c25rb3FrVmRU?=
 =?utf-8?B?TVNPVFZ4alFzdjVybVNlNUZJVVk4SmxneG91dXdhMzliM2RnSlhVK2U4S2JD?=
 =?utf-8?B?QSswLzg0RUxHOFVtOEx2Yk8wODg4OTBYQVVCcXRWWXNKWWF2azR6YmdTd3RI?=
 =?utf-8?B?L2hVTG9YcG1rQXd4QlIzK04rdGlXQzdzazdac1NjQ1h3c3dkaEVBazU0NGdI?=
 =?utf-8?B?K2lTRTBzQjcwdlduU21udFVsRW50TVBCQ3ZRRFBsS1FJbC9Jd3k3N3o4Q04y?=
 =?utf-8?B?blNQRHRvUnlBUUFYLzFqdlVBRGtnQllIZFlTSHdnTGlZRUNlR0lUU01sVStQ?=
 =?utf-8?B?SnNYWXp2OFV6RzBzNEhWbkFUMGI5SXU4MWF0a3c0VlR4WG9YN1NCTXpyamth?=
 =?utf-8?B?QzZEclZPSG5rUnJkcEs4NndKc3J0WkJpRmxXRnZETDd2L0hRQWE2UDhPNHd0?=
 =?utf-8?B?ZGlSWHdCMlJqWFYzTG9JZC9vcFJKUFYzRlhWaTIxenBjODJMMkNxZXBzMW13?=
 =?utf-8?B?RXk3OURqNVBZTjY5cHBEQ1d4YWlJOWdVT2x3QzUxdGh1RkpTN2pwTmI2ZmVs?=
 =?utf-8?B?L3hqUncwV2J4UWtWZG1ZM2ltbkRYOUxPOFJaMEtpRlM1OGcyaVBqc1BSeFg5?=
 =?utf-8?B?SGFJdWtQVW03Z0o0WXdQTzFZb2hZbFZvc2dDN2l0OCtnNHBlc3NUUGxuOW5r?=
 =?utf-8?B?RVVyVEJQOUp4dDhvTllvSDJFeXU0NWlBQ3RQajVzaWNvWnQyWnVGTDlHd0JS?=
 =?utf-8?B?dk9USzRHOGpMQ05KSE4ycGZTSi9QZWQ5M0NMMDdOVWhReEtlazZxdEw5WjJN?=
 =?utf-8?Q?S4CvXPCe8KjVyoMU=3D?=
X-Exchange-RoutingPolicyChecked: SGlOMcSZ55wgBAFzrZv4bh4ETcJUowXwjCI1iDX/aAaT3+5QQ6UzuWKGf3i0zDbs8Om/u0RtALmGhiUi7S/NUdukYbWpFDfsS6N7PZgRD1jnI7qe2MH4XTcgBMG8pAIe/8GelYviOrpW7OEfORR3WjabQAZd7XiOJr7dgtlq/l5guEHRnli6SrtmrlTOdZHgmyZ89dbwl0+wiexuZQMn6285C2RlmpKJ7ZvcA8UXtGWVjkxc+AgOMzO9s6LTbYdRQU4UCVxm6wu4JFT9USzPbxvo60GreYkO3GtJL07DSMssXU9YIjzANypBHVvE+g94lZE8EcLlk+cGNlRcskTfxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944a5b9-1c7b-4a5e-0b53-08debb68529d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 20:49:47.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp2wxd8amTuwvFLgYOiUCOuoznbfYeE91kgCLrv02WHg2urT+lBKcRz4VdFCqEhMHs+srDT/KCnUJL/NBjkRHMPYwXU38qdQuPCEJRMTPJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6711
X-OriginatorOrg: intel.com

On Fri, May 22, 2026 at 07:50:59PM +0800, Li Ming wrote:
> 
> 在 2026/5/21 20:25, Li Ming 写道:
> > 
> > 在 2026/5/21 15:25, Alison Schofield 写道:
> > > On Wed, May 20, 2026 at 08:14:57PM +0800, Li Ming wrote:
> > > > CXL test environment hits the following error sometimes.
> > > > 
> > > >   cxl_mem mem9: endpoint7 failed probe
> > > > 
> > > > All mock memdevs are platform firmware devices added by cxl_test
> > > > module,
> > > > and cxl_test module also provides a platform device driver for them to
> > > > create a memdev device to CXL subsystem. cxl_test module uses
> > > > cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
> > > > CXL drivers calls registered mock functions for a mock memdev by
> > > > checking if a given memdev is in these arrays.
> > > > 
> > > > When cxl_test module adds these mock memdevs, it always calls
> > > > platform_device_add() before adding them to a suitable mock memdev
> > > > array. However, there is a small window where CXL drivers calls mock
> > > > function for a added memdev before it added to a mock memdev array. In
> > > > above case, cxl endpoint driver considers a added memdev was not a mock
> > > > memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
> > > > than mock_endpoint_decoders_setup().
> > > > 
> > > > An appropriate solution is that adding a new mock device to a mock
> > > > device array before calling platform_device_add() for it. It can
> > > > guarantee the new mock device is visible to CXL subsystem.
> > > > 
> > > > This patch introduces a new helped called
> > > > cxl_mock_platform_device_add()
> > > > to handle the issue, and uses the function for all mock devices
> > > > addition.
> > > > 
> > > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > Hi Alison,
> > 
> > 
> > I missed that you mentioned putting platform_device_alloc() into the
> > helper. I will send out v3 for that.
> > 
> > 
> After taking a look into the implementation, maybe keep current
> implementation would be better.
> 
> This helper is responsible for performing the platform_device_add()
> operation for all mock devices. However, each type of mock device has its
> own specific logic between platform_device_alloc() and
> platform_device_add().
> 
> If I move platform_device_alloc() into this helper,I will also have to
> incorporate all these device-specific implementations.

That makes sense Ming. Thanks for trying it out.

I'll add to my previous tag,

Tested-by: Alison Schofield <alison.schofield@intel.com>

> 
> Ming
> 
> > Ming
> > 
snip
