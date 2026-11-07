Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794012955;
	b=DuEw21nF5VgsqNll/WOmeuD3k197emZFP2L/slJ1uGkX0I5gLEncIY/CZ3YDwcWoksUl
	 dEkV1eBjJTXgmg4pyEf/bDWsEBDZVFZOepuLE5c3BVtNQeiYa6BRKs1Q+4LqI+1T8i2z5
	 Zhe5aL9Pf7JcLbKfCwmk2MEYY/mM24B1sCwG21YyF0fpFYIMjWunJSUPPS5IOUDx5Y1yq
	 vld5khpBUto2mNG9naEmiiGFmQadNK6YfnFpMd9hhssCXU+DBV9ASSpjZFvOn0zLX9j8a
	 mSufFedOKBrbpadOmmSQGOkKms/cF2LuHVDcyk+/ZpYDOkvGyi7csm+jCxEHDUfaCcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012955;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=qTyrG4DHw1IhfH+fwQLELOZbmXpgkmFwl5tpKw0Zgxo=;
	b=K6fzAN33fiqi9EQk1T3JkpNzb8xQ6Aw9q3NJkh9Op4voB7Z2dioKQsbFtrS9xqlLBH6I
	 Ib9JqPB2pk5laAJBR3jsFAwOmgN99xdAOOYmkaWjWiB7BNv9bp+PW//RpiHWnz2k9BE3j
	 lNg3RgkmULNzcVNs5qVQOUz9YjYB7ZM3Ajlkl1Otw1SHk2YNjqrg3rgqMqLouGnzscnZR
	 A0RnP0cfhzvSBJl//8uAb7Rb+aU7odMLhnU07OrFFDLSOp3K4uxgf3RupgbqpujZsZX9U
	 6GnWveuKrls80jxrrdifiPTMLXtuFnKYL3Bapq5hdaqglWiIFVyX8tmJXzVdbXago1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P567uhMj;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B800606A32D
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B800606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P567uhMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794012954; x=1825548954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IQ2peBUNAOfRcFTUocHzyP3czKXXGG7iKAEOt014hL0=;
  b=P567uhMjXfhE8IokUz157zBIWxP3CZ98nzme+tba8sfSfv17ve1HC6/t
   B8V4hXzynjB9RtqqEo0MKHMDAKctM9CXICwAPxZZZHCVCpglWIWhlJUQL
   93Ip1lw3FiUmKt1lRD0FxXeg2ZGi8G/vtfSo3ImF5dmov3EOC1f0qk/V+
   LMZlRCkJRKMYfbfUTgYePcMGygY7VY5ZxXIG1jrniMQV3QPZt3sJ4qGnN
   AE/XEE2IZKdTFPr4Uq/IlQqBG4tNjVYo7RgrzHXbFZ38ktCgjxEMIUm+z
   rcFx7Lsg169R7UptwFLbCYGXzY7MlhX5liG3ybB7PCbioHdBDylSmb0+7
   A==;
X-CSE-ConnectionGUID: yWF0cPrxQ664G1i6x5/+xw==
X-CSE-MsgGUID: SVrNalCHQ3SGgJK+wtrWCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2822728"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2822728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:55:53 -0800
X-CSE-ConnectionGUID: Jt3YWDx9SkyXbXsLKQNZWw==
X-CSE-MsgGUID: KVqnuI/2SeqfYU4JW/B92Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7263684"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:55:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:55:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 16:55:52 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:55:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbtEqJg1lOWohJ/Ow/nPXsSLQwAv9Sq2/RO19qyu3X3wQyN5BRWufCqZZzd7L355Rw29SY67LWNZolct+3mKt3EXY7ARce1l/NZdQEHldERJocOi9Nz+Y08paXYMc8ZUxrHvdfAoQKhjFfPkhLJVLuxJCyJ12PTj9cijnYppdhhak3TQa1BbkSxx0D21SSu10U/R/swI3eIfK+4tcsRRXCLIrMoYc9WfhBn0hIUaJuZE5qTOPvgCyUg4XquddgxsAMSlr1R37vygg3ZyYW8lqP4IZGlcI33jJb3c9lBcCu2dPIhgqn521YgYLEkivwRdtcSgzhGQkQIvHXPrHT2+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTyrG4DHw1IhfH+fwQLELOZbmXpgkmFwl5tpKw0Zgxo=;
 b=wfs2p2Vo8Ywo1B92bOG4GIQbPVzYDasEEmQDkGGQo8cpX5Eb2PmTW4CmCB+rEidEbwRvbBfNZQUumsKaMzi8KDo90hbQIYpv3xKY3PxiqjNuoCtmRVefDa7tXywfRlVjVKfulahrAPB+BDUFKBy6Lc9ALc05/eCBkgTZhVhrRFMbPtccbw2Im55PZwY1rPpn6YLEFzJjoFemllrmhGQpPPSS7FPgzMPB8zvBCvkhjnlTmJRO6UgBetIuoAG6TlXIplROiLjsl8zBenNEWXcLT34TzZWCOkq2Z+9QHydBfeVUGKx30uwxjosC+F8HbGX5OGGKz54LrMcU9jr9vZxkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:55:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 00:55:49 +0000
Date: Fri, 6 Nov 2026 16:55:46 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Drop the root decoder target_type assignment
Message-ID: <au53Ejee-dm9bYnl@aschofie-mobl2.lan>
References: <20261106234200.2656245-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106234200.2656245-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bafff73-a9b6-4ae7-5166-08df3c69dd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gk2DUS+1N819N7/veoTPbvykzpSTKy7Po+KcsmBjGoHphGUFtZSqd+B4xSrXAKmg2ZJlNT4hnkxEM4gCpnMu5dOwIKqV/v3jAqG9XAouVVF1dmzT8ghCDXmjdqWQzcxUaDFg+dtsQgTGvTz8mSvOJPM/gTNa9CRMch7IwCBmEyGeIKA+O+l3X7ZC3lmsHjfV/cdJPJCeWWcg4lcvfU593W5VeZQ/aWcnlEo09/iURCIbW6xlmeYffmbfZZw04iM7D5B9pqAClvtASS6QVX24+3MNa2bC+BdyrgF4GBoomWRvGRVPTZu/Msxo3fPf+mou1vg3IjWcvLFRA6Apw88ybE5RVRWqDDfGt0iLZyVip0lScQQz5/uCP2KzG3dWOew9TGz3SwmtDvo8XQl2CLPR2x8tuYbZOOaR5hfx3MdrdW8Sx+M56+q+2yfe1huEhY++gAaDE8BAEi67c8/eQUCaeZ/e4w7wHMDqkhQSfeZF8yepLCP4XTKg9gJNFkXgq6qHBtBfywqUfadG1JzrRHrzGwQJ/zJfrkmfT5lYt4R3VIcD6ds8w9ZUHdGSo+SLDUZN7EaTQWxpQXh6KdmCPiWoPg9L5+OG9nc9t6aKA8vMa3R+a7dIX+6DW1eKNHQo9ej+5X5dd/9Wmk5Wp7uUeojAU+xuDxbI13QnFrKm2MCdJNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMIjVvHd6MRnVivjwXftCdMmBL2HCrCPjUKRFac3leyqhVsFrKFgf6QgSzbM?=
 =?us-ascii?Q?NdkbW38r12p594tEG61b7DBZptfLnD7Nbaeo3EW/Y+tlXpZHuLI5++vf8qZY?=
 =?us-ascii?Q?4vHPvaoi5VssPXhVhm6u9OXZCdxd4VjtwAkGmD+xBDQ5Z5JOyMAI9VXoVKPr?=
 =?us-ascii?Q?Nd5VWyf17vfVmbeD5c8UvMjnLmWQ8u6AEM1PEOjnO6QEl0QsBzG4xmojEWq1?=
 =?us-ascii?Q?KThFV+wzIrRNXVMt0v8WGFvnWDjNdMQsLWJObUB2Hf5uz9yGzmZCw4QCz2ig?=
 =?us-ascii?Q?UUeA21yjr199r7gO3d53UJ8WUCBuXy/YbG1BeVfoX3u6MABWWPGvk+7s0LDu?=
 =?us-ascii?Q?WaYjNCbevr11KwDxkfFRs4jD+vZrJuXQ25sx5PVAOVJS2mVLfHW1EKjKH5/S?=
 =?us-ascii?Q?+3/StK4cQtlx2fYtAuGBKj5lfk6kmlgUIA08eUfBugjdy+ZjuLVSAwSxPn+e?=
 =?us-ascii?Q?jqN4BkCVdCA2sAHs/I5ojs9hiVR8WS65fDosCpGEipGDFQW7OPMqQV/dU3/o?=
 =?us-ascii?Q?Jef5AH+gmkrASv7XqmV1ouIkgVHY5cYD4H+6J18wKBwi7154dW8ceUglznwU?=
 =?us-ascii?Q?iP+BxBOZAFKcwLfi1UY9EHx1cyr73WtC10yCqgaKNqMemUCwWLjQLz9SFAho?=
 =?us-ascii?Q?68TZMzu3vHDwHweVfnILnE1FEZCniTAx9B3cw4TvJE1+EHwzeupngrWZQt03?=
 =?us-ascii?Q?Rc7H2YH6ZyxVTxNRuYUYQuhVKweCEq+Lh7/0O0dXvealLPirHU1mVCDySD8h?=
 =?us-ascii?Q?LYm9fXgc0J5K12wEN+GmZ7EszeKGpv5g5K9c8CXZX5dfhysPvQVPt0nm9EnG?=
 =?us-ascii?Q?juMe/dWpK3tr0iY/lDcHjB7Sr9uAlYHyiEAsvBrPjftKjvfaW8arQCg4HnO5?=
 =?us-ascii?Q?uwwn9gbS3Iq1FuTHwbFi+VXeiAiIlxQu9R+NgRl5klyg6RIiJ9ZGf2jXVJoB?=
 =?us-ascii?Q?hBHY6KItZOxgW3zQFcOhE6Sdke+hZ13Mv9eKqbxvcL0i1K7y5m7Hennqw26r?=
 =?us-ascii?Q?NnAENSONPN2deb7dQKBoRD0K59NqjOPvTty8TcZy/2SgGzNixUX1TJod+Wap?=
 =?us-ascii?Q?qBlge+vsCLmcSMjFwaEmoB8H1Tn9cqUYb5bI0S9rIA9FSfA53Bc/qpsjQfVj?=
 =?us-ascii?Q?s6dwQh1nUz8o7ews8URWlcoiJd0Mum8W0Rr6J+geeT9imdLx1hbhISpl5gK/?=
 =?us-ascii?Q?+JWzsEyxiCuPJ5QvVyHoWhmFzvOhHXxT0Jgv3rdmfhl4Bov34ltBrKRYJ061?=
 =?us-ascii?Q?98RD9j4m6DLxKVbk3MOW0eQzM70lXvHqOu2QxWMWY55uCLz7tw+t/fSQ5uCx?=
 =?us-ascii?Q?t4JWOHA6I9pk3W4F95JvGNmthxdVG+X3ZUuveQyujpBHDPftIO+P1hhGGjBz?=
 =?us-ascii?Q?nCKyAm6JouQF2sYVwVfLMI63QWOMV6kqvJspX8X+nizneCJV5drEJReSArsK?=
 =?us-ascii?Q?V5qBivxeUkiT/80CeeY/MxXdYJfPIb42NefVSAqF8NxPtVp1bJrtmYJKcsXE?=
 =?us-ascii?Q?I0md2Bwhg5ynasPgUzDH/tfmb7a6zk+w4e0zDSjpZ0tb7jOfpVktjhVJGbX3?=
 =?us-ascii?Q?S9ZdFdDG39lIEql7eFaHeZrH2aaKOnfdWc4YVipZ7UhyuTb0+XMxiM4b0s+h?=
 =?us-ascii?Q?SuPQsdxI0j+vNYFTZQRJP9uf6BfqLacAoLpfFzwk7IzQtFNRXdl/JXaTAYTZ?=
 =?us-ascii?Q?6Vo9igS5AHAXNhie+iNlHieKTGgV9ETxKcFkmIsiAMUmHW3Y9GmdVkaQ0UOg?=
 =?us-ascii?Q?zQ8s+Ga52hCo2BpXpT1Apvpqx1Hx77Q=3D?=
X-Exchange-RoutingPolicyChecked: vv2+QuYLNjA++yCBipyUgYiejPoSMGZ6oOP/705HdbHJaBiIouHMM/sAFhM5IvCOyqeQv8ovfybtYXcl5c+f5WMT6lqqfSuwKGaVBfRE2xulQ6o/pEe2QIOVurOcx9dwKXRSWF17Sc837dy9bbziDxx9DMf4ToWHmSSqtOlyX9Trw+MhfOx9CYVc94JoMFi9WnLG6oBbXGlp2DT3KD/CxXm+w2t6jGU66XPgK8JjN88HXlYItaXkjXtJJBeiJede0SvBzg5Mqe874SAvgMKL+EHdCSkzkdFlSbUUmPoUgtyGLJz5s1wGC3wioiNWXXB4iJvj6zjAlYpRZTRQoStRPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bafff73-a9b6-4ae7-5166-08df3c69dd5b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:55:49.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1ypZhOuR/98MYbn3jeRxgEGzVYZz+tfC5uxyJo1mn5c3gG6YWRSo9I4jgOsXjkrOwb8LXeAiSdTS8RQAV3I1PxcucMupeK/aXrFTVjdfuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com

On Fri, Nov 06, 2026 at 03:42:00PM -0800, Davidlohr Bueso wrote:
> A root decoder's target_type is never consumed. The field is
> already initialized to CXL_DECODER_HOSTONLYMEM by cxl_decoder_init().
> Drop the redundant assignment, which only suggests the root decoder's
> type matters.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
