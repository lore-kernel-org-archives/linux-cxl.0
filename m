Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25144396B6F
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522723; cv=fail; b=uQILJBQdyDDMPCq5ZxdZwNwjOV4x868/Gtbdvip7yiiZ34A1jzNhYpcGrL5I+rZpU3xwAz9GU/ITgc/baHeX8+eNRXa3VQ8+Q58wmTdQM5yrW/7pY/ENoi/cw7bpz+4XbHfVKH6Yt7wxV1JyweF2fNUwPxDYV2UxO3aPo7El4Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522723; c=relaxed/simple;
	bh=5W6bARIpHdKIpJO4q1aFYZsqLtYOx+7b9GSmKKIAXkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Paj7cXGDFIdA0sr0DWa9CoWtdfgCOdTwMFnH7qDXsyaW0v2jfkFzSxn8MGZ8UE1hnmqaAME6gd7426zP/+a2sBwue1b0uCV5wCBtVlS/fxNnpOVj0nuN9zfrUoLaHlq93kLDfA4/BdK5HYdv4Pw3YA2lPyVh7P4dho6LsnrvUNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbYv0W13; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbYv0W13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522715; x=1821058715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5W6bARIpHdKIpJO4q1aFYZsqLtYOx+7b9GSmKKIAXkU=;
  b=ZbYv0W13Q/3z6qL2OiLvRfeQfxk9/uSOHHXqYv3vUIo9f060keVXE9k6
   hR38XzaNgD6SzIdhor0xBk0kiD/AhB5r34fzQM39NxRxzXaA2Z3eJPxwi
   OELxfpGUuKwMeK6APYdOoX3n0bmI5i+AHZigX35LB+4LOzIVOF7iOWACx
   Jni50nR0cgv9XEh3NAUIoW/vKOeWQ49tWjMkUWtxfxW2VZEXMLaEUQVfY
   cRJkYEOt14EVKwqDqFmNm6f/OBvedmWtgBVuV4cbscsmwBYvVa0T6gITz
   udwNmTSJTu97LE+7AqICJmotI4WOBhAgT1gvfOfS5l35G+tvX37j+20xP
   w==;
X-CSE-ConnectionGUID: xSq9anWeRVWowT/UgQUCZA==
X-CSE-MsgGUID: 6rZ7AqZ/S9eUrxpj7fw/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89939574"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89939574"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:38:32 -0700
X-CSE-ConnectionGUID: 9B9wFueJTciALAGzTzQ3ng==
X-CSE-MsgGUID: GLMcrnNxTYycwk7oPjOWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268905177"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:38:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:38:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:38:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISExA8VjooLfFRqDqaVJe9L3zLuvEj3Iewby7jrbtl6bxzMhXrst/z9CjzTj0llWBcRnhsOIR7lETNABEp1JlWkwtSZaxZCTctUdE/ADa+CwLppQfNqqkKVinAQox/i5O8Nbr4VvaZ0uPK/FwAuIagW3a9Shk1hm+JxdQcG1XATUCg3N9MD+GdZwDibmv+704v7GMdkbfdodQip5rGgYU2xr44qUxFzvwO1HvZLCBQNfj4SO0vbwX/1Cy0WDG8iTJIpIaxy3lyLikw98lb1ff/114V5a4raxEkC10S5M5tNX1kpMpn8TsCSBwG8099c1vmc2zPlI5uJbzF6oo/Uelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFW9FIq92TEzopQzwmLKYtpIBCZsHqhTzj031NJWgJQ=;
 b=deWoemXp8JzNMg/GIzCmpyZeBEUGq1jJ2OcmTrps4Iu3madlf8pLtKFPPvzzQzv+xELEyIzwvpPQ/K5sKo/m2cfBm3sGCwOpo1NyNb7rZjo58ECSciWmFkOTOrQM38Lun7BTN2+C6a3hjI/gJ6kLmgJYsapZqgz05PNqjCyacrhgUFb3CAuQ1rf+m9zdqJ1VRCLMC30GqZTgt0P8Cx0ajL5A9ICFMs6ULFjWjOxKeEvsaFjH7DfWc+3rq7MqzLnclDShBKIv5brclrj6LiwdkY4HZ6Jjt2Z16lUKqkiT3V9HVdIrP1vUIBJWsNf8SjvZHnOb7+JtvWgNBdJo5xXnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 01:38:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:38:26 +0000
Date: Tue, 15 Sep 2026 18:38:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
	<habil.kim@samsung.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH v13 7/8] cxl/core: Enforce partition
 order/simplify partition calls
Message-ID: <aqnzDv1p4jQTK7Pu@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-9-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-9-anisa.su@samsung.com>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1d433a-86fa-4b5c-86ed-08df139333c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5TAeby2/cfQ42qYytjAjLMUuVWEPZGz86eB9CYzsMaAhcEfHdVCBNSDAxodRxkTv+sG43ZakeayuRBiv7yrojym5Vs78zCyK0KPPvY6LXk3a37CRDhhDw+sTyOk1SdyurwnJNl9G1JaG0yRCGFCW7TSmQ1SqSdkc4oZfB0+K7MAkUgvu9PLKYN9cKMKq9fsBCEN5mJs2swJicTkdm7iNK0oaxiBbSoWrJcu9J+LsXfZr7Lni+QIRdpdRcGYaWcBSpDifHBXj1RIxVgih/VTGMWMLcLuzX8hkyGXThIDcvoCm+qcgyzZDYk2ZVM34kgibPvXW1No4n9/ys61d9G4rjkXpNpkAfj26/j7ak/4xmGT1s3GCgc8AnyipTpU7Q/H+zOVb0pmfeUvMVVRWQBFXGpzsE+VC9bgcMr6jtU2OzCJiTNg6bKfR/Nk3ifJrr+5YPWzwwBOX+7gO7QYweHbT1EPpfDA5bQg29rYFO/f84So4u4N7sGAIrWJHAH/NT7LiJY3ZoCuDDiCn0JJk+hc2ehTpLMW1+NKY4L4sAuVsHON/fU8Chg35OJu0BYsXOLCryhnTDndtn/SJKFX7GpVU4uQtehgX2ojug4ZIAJ3/ge9/EFHpoio2S3wskj+MKTFg85K3mj2/kz3DHUNquQ07lBAwARRQSNoiYJaMIEDeh7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4NeFg/1VXyeIoyGGwbWeijNZEEikaUO09+Tl3xShvfYo/XqPbNLLh4+Lcd4?=
 =?us-ascii?Q?W3htPAjJ/BRE6Ds7nhDSqQdtb6baUTYaXv353weAgeONLyrQ0OSCnunQb1z2?=
 =?us-ascii?Q?P7wIf5r3W1hrHVYMou/eV3TuyKFbOpMFlFNezdgEfQO9sj9Hl8pQ13vJeGkk?=
 =?us-ascii?Q?PiKfWC4fPBpzFatDNUY9OAYM7Pr+SwqjwTedpbJiO3tG9MJNY+qTXzbxt358?=
 =?us-ascii?Q?1fUVMo67vRDiW78VTVno4qSo2MUzaKFwO8EovTFNBQZtMUJ6pnaw71NgpvAT?=
 =?us-ascii?Q?H0mTHkDcU69DmIO34gghHmK5dzc/g5nVSkOk6Q26HMWU7cHrA9TrlrrohXto?=
 =?us-ascii?Q?C06G6t/LocsWC9Xak8A6Pz0YqDZWcxYO+xOMioUdrfa4SmKP+dmzFkHLHpRL?=
 =?us-ascii?Q?WAsSxb3mQpMC/VKjLjfodBPUw5aeHKJbD+OpmLrMLqVIJLYcGtAaaKmiU1mX?=
 =?us-ascii?Q?Y1qkMd56KzwskSTuaKPY4+PrzbfdET4x8rogthWJEJ9vh00ecwH4gP/WcwHq?=
 =?us-ascii?Q?/BIZwVDnL1+7yP9l8lPPVMy98bcHpWIvmQuPrE9Nwrb0NQwBfRe3mud8rH1/?=
 =?us-ascii?Q?d+zH+qaz2XsVECJKAUZju856DHgs0CigelE+w7es3SYs12kUF/oZsLdQvk6+?=
 =?us-ascii?Q?WgFzQZFMpjKuo+vOrLOA0ndCOuKGbsI6OLMiYSu71/JuQXuEEa2DWJjrTRee?=
 =?us-ascii?Q?p5iiOCDBrEgIsUbGq33csZOhxYIouzivEqAV6AhF08Zt+TQKtZoTinOIaTAn?=
 =?us-ascii?Q?je3TMVYuwO59CezpYOS8H9SypvomdblMtwY0As/D2sMwbih68DC0ZQ5g9HZ4?=
 =?us-ascii?Q?z4i4c3YoHOrgV+2WhK7LJEnzpURQAcAY8Xhet62iLeK70K4gQa2AhlM/Mrb4?=
 =?us-ascii?Q?4PB28ZUwPoh0tRl9LtqodfQM/e2anckz/IdtcVqlsb9DfGCzuPBPcxpPcsh0?=
 =?us-ascii?Q?cmmiNCmThHeyrly+B5VhweSksxZ4TyOAqri+83IMBU4Fd+4A+blVSTl/f2TQ?=
 =?us-ascii?Q?sVYRQIoZrv8sGXWljoiCsAFTw+LaQg89JoWjzyCU/3y3Lxy46NtbFi6CQMlM?=
 =?us-ascii?Q?HeV7K1bXgnYoNSwahNik9H4tE8LW790QdIoWyPPMMn7FwBltKIYRRVRI6tsu?=
 =?us-ascii?Q?bouNSVBitx0clGdfNs2XpCc6Uc34fWgl/atVRH3JocMOhCzoG6Sh1SuXBStu?=
 =?us-ascii?Q?kTTS3zBKLLWV/5CutOoEix9B0lgYldlbQGzaH7Ghsdd8xMpBD8bmlpRfb+e+?=
 =?us-ascii?Q?7AnWM5y9KPp9IfDHHOcwCAxwi89yhogNHXDmCkBpfLyfzR9Yo4McF7cAMmjR?=
 =?us-ascii?Q?/A1jvKdB4nyQ6bIRU9FNVj481Ts8aSBb8RVZea+ajQ7tbXIau+oeSmbZkEwM?=
 =?us-ascii?Q?A0veDspqGpcblgbIK2wze6V27mKHyk5T5TyG/CrPbtwwjHZ8q+AZlqUt5qDx?=
 =?us-ascii?Q?xtYbnpHV26IkJTFelHr+UUYpxVWPjo5jIRGMgdFOfLe2Hkn7KibCoeqPuIiO?=
 =?us-ascii?Q?Ij2Buf7znpBGZLe2kv3oQTOgwVxVqDDtCkT2NPaNIQJGOKVeKxDDl3Dl4H1m?=
 =?us-ascii?Q?tVeDfvzocsnhGaych0+Oe+mu/X6tUhiWNn7FjSzLVhfiys31TjveWvVQ8ooW?=
 =?us-ascii?Q?IbpBZSrxyQxEnzqHa2iFQGACx3ju7zglCi5aMEjaIyQ5dnW6IlVCj/4xWw2y?=
 =?us-ascii?Q?SU8r7xNeb0TYSwcbFqhLqQlz/U/IdYyYK6n88+tziYyeWUx5jPJtfNZtI/zp?=
 =?us-ascii?Q?KgrAIApgtdu52E8ArH3UkZdmWANXkcc=3D?=
X-Exchange-RoutingPolicyChecked: qD5oSVtvSbSDYFyDsmKrU4haKBrrcwZ+RezWiauyz1uZmeZdeWcS2WoA9RhRbOfxRc2YKsWgKPZvwfpQ9DJxc6lkQVt7ctZ8sDr++WI1jjenm1yUxRZL1S5k0LddKRV1e4DtnXosQ4vGU+gIvk+4fx5QbCsDN2Y5TkCbNaX4gDhdHhHv1A1d6m7F2UXBsz1uOltVtJU4AWbXAc83LOLNf71KN/u8Jw30EeMDmVTPQsYOwDXq7R38aoEO6hxiDc3h9gvTR1ILxbZJPBUp9oIKnmBYu3NYXUI4nv8wByzMs9ccJVYOde0m+0a3bDjGJRZ3A69A5zQ7K79w1wV5AZB1+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1d433a-86fa-4b5c-86ed-08df139333c1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:38:26.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtFuhGmj+nQA8Cu+aDNrKBNU6aWMgx4xA5YcO9e5Fnuyumnri3Mc2pLqrudmwH4hccE51RWxeyBp0rQz9vUizXuNXC11LZkI48FPRZgXAj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:11AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Device partitions share one flat DPA space in a fixed order: static
> volatile capacity at DPA 0, static persistent capacity immediately above
> it, and dynamic capacity above all static capacity.  The static pair is
> mandated by CXL r4.0 8.2.10.9.2.1 "Get Partition Info", Table 8-310: the
> device "shall provide this volatile capacity starting at DPA 0" and
> "shall provide this persistent capacity starting at the DPA immediately
> following the volatile capacity".  Dynamic capacity has no such rule.
> Table 8-347 only requires the region base to be 256M aligned, so placing
> it directly above static capacity is a Linux requirement,
> enforced by cxl_configure_dcd().
> 
>     DPA 0                                                     end
>     +---------------+---------------+---------------------------+
>     |      ram      |     pmem      |       dynamic_ram_1       |
>     +---------------+---------------+---------------------------+
>     part[0]         part[1]         part[2]
> 

Looks good to me now. You can add:

Reviewed-by: Alison Schofield alison.schofield@intel.com

Please add your Co-developed-by here too. The partition ordering/refactoring
has evolved under your ownership and should be recorded.


> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> ---
> Changes:
> 1. cxl.h: document the DPA partition layout above enum
>    cxl_partition_mode with ascii art, and cite where the order comes
>    from: the static ram and pmem order is mandated by CXL r4.0
>    8.2.10.9.2.1 Table 8-310, while a dynamic partition has no such
>    requirement -- 8.2.10.9.9.1 Table 8-347 only requires the DC Region
>    Base to be 256MB aligned -- so following pmem is a Linux choice that
>    cxl_configure_dcd() enforces. Reported by Alison Schofield.
> 
> 2. Commit message: explain what the partition order is, where it comes
>    from, and that this patch starts enforcing it. The previous text
>    named an "implied partition order" without saying what it implied.
>    Reported by Alison Schofield.
> ---
>  drivers/cxl/core/hdm.c    | 10 ++++++++++
>  drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
>  drivers/cxl/cxlmem.h      |  9 +++------
>  drivers/cxl/mem.c         |  2 +-
>  include/cxl/cxl.h         | 20 ++++++++++++++++++++
>  5 files changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7f63b86887f4..18e9dfa115fb 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -469,6 +469,16 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>  		return 0;
>  	}
>  
> +	/* Verify partitions are in expected order. */
> +	for (int i = 1; i < info->nr_partitions; i++) {
> +		if (info->part[i].mode < info->part[i - 1].mode) {
> +			dev_err(dev, "Partition order mismatch: %d (%s) follows %d (%s)\n",
> +				i, cxl_mode_name(info->part[i].mode),
> +				i - 1, cxl_mode_name(info->part[i - 1].mode));
> +			return -EINVAL;
> +		}
> +	}
> +
>  	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
>  
>  	for (int i = 0; i < info->nr_partitions; i++) {
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 4a5793fa3cbf..5297fa20c8b0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -77,20 +77,12 @@ static ssize_t label_storage_size_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(label_storage_size);
>  
> -static resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> -{
> -	/* Static RAM is only expected at partition 0. */
> -	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> -		return 0;
> -	return resource_size(&cxlds->part[0].res);
> -}
> -
>  static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = cxl_ram_size(cxlds);
> +	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_RAM);
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -103,7 +95,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = cxl_pmem_size(cxlds);
> +	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_PMEM);
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -426,10 +418,11 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	NULL,
>  };
>  
> -static struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +static struct cxl_dpa_perf *part_perf(struct cxl_dev_state *cxlds,
> +				      enum cxl_partition_mode mode)
>  {
>  	for (int i = 0; i < cxlds->nr_partitions; i++)
> -		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +		if (cxlds->part[i].mode == mode)
>  			return &cxlds->part[i].perf;
>  	return NULL;
>  }
> @@ -440,7 +433,7 @@ static ssize_t pmem_qos_class_show(struct device *dev,
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
> +	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_PMEM)->qos_class);
>  }
>  
>  static struct device_attribute dev_attr_pmem_qos_class =
> @@ -452,20 +445,13 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	NULL,
>  };
>  
> -static struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> -{
> -	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> -		return NULL;
> -	return &cxlds->part[0].perf;
> -}
> -
>  static ssize_t ram_qos_class_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
> +	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_RAM)->qos_class);
>  }
>  
>  static struct device_attribute dev_attr_ram_qos_class =
> @@ -501,7 +487,7 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_RAM);
>  
>  	if (a == &dev_attr_ram_qos_class.attr &&
>  	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> @@ -520,7 +506,7 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_PMEM);
>  
>  	if (a == &dev_attr_pmem_qos_class.attr &&
>  	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9106affd7c81..35268d1c387c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -412,14 +412,11 @@ struct cxl_security_state {
>  
>  #define CXL_MAX_DC_PARTITIONS 8
>  
> -static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> +static inline resource_size_t cxl_part_size(struct cxl_dev_state *cxlds,
> +					    enum cxl_partition_mode mode)
>  {
> -	/*
> -	 * Static PMEM may be at partition index 0 when there is no static RAM
> -	 * capacity.
> -	 */
>  	for (int i = 0; i < cxlds->nr_partitions; i++)
> -		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +		if (cxlds->part[i].mode == mode)
>  			return resource_size(&cxlds->part[i].res);
>  	return 0;
>  }
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..9c4ef401cbad 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -139,7 +139,7 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxl_part_size(cxlds, CXL_PARTMODE_PMEM) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
>  		if (rc) {
>  			if (rc == -ENODEV)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 43edcde5bce3..b6895302a6ee 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -130,6 +130,26 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +/*
> + * Partitions share one flat DPA space in a fixed order:
> + *
> + *   DPA 0                                                     end
> + *   +---------------+---------------+---------------------------+
> + *   |      ram      |     pmem      |       dynamic_ram_1       |
> + *   +---------------+---------------+---------------------------+
> + *     part[0]         part[1]         part[2]
> + *
> + * The static ram and pmem partition order is mandated by CXL r4.0
> + * 8.2.10.9.2.1 "Get Partition Info" (opcode 4100h), Table 8-310: volatile
> + * capacity starts at DPA 0 and persistent capacity starts at the DPA
> + * immediately following it.  A dynamic partition has no such
> + * requirement -- 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
> + * (opcode 4800h), Table 8-347, only requires the DC Region Base to be
> + * 256MB aligned -- but Linux follows that precedent and requires it to
> + * start at the DPA immediately following static capacity: after pmem,
> + * after ram on a device with no pmem, or at DPA 0 on a device with no
> + * static capacity at all.  cxl_configure_dcd() enforces it.
> + */
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> -- 
> 2.43.0
> 
