Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AC12AAF1
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886169; cv=fail; b=SLdubFZ+tuqzJAS3UG2rsIO3POrHc0nWDBxlZ0eVkgrLV3IErJY7g+rp4cMiicfyiCTuTsrefnWPd5YscuK+NT/0DFyfpXV25vicjiVqnscCmR/z1d1ZApmCN4Q4BuaEleL/5zErkoYDWW7YBbMEMOoUBSXiwIpshMXD+em0eqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886169; c=relaxed/simple;
	bh=Z0VqVrEaA2G6YZ5a6ZgSTT/jKFlYMGoG02mKT8aNHZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AiQHQmkjKgPOtexzvSxNXjZTFX7/g37hXTnjWdG3FW0dvFdq26AqL4rg6XSi7JRIqI+XrC76htzZvlLDc0iYO9aiKvJWHp7jXo1wcXpfPV7ZXaS4n0McZHSKE/vbrNTNnqiqtk0929AeHFd0+bpOGZ31tMtqTXnFsc+bjgOAn3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVLiVQJh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVLiVQJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785886168; x=1817422168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z0VqVrEaA2G6YZ5a6ZgSTT/jKFlYMGoG02mKT8aNHZM=;
  b=WVLiVQJhdbnOGwAnl1WpN1BQP9Yl40uMs0JUxTrIH40h4KFejWCiASh3
   +EWy0/+1SNEaKnVvG+a/OGle230AvFF3xGZHQg6ecu0OFX5CxF/tmI0EA
   BPcwybvk76hT0E1a9IWO04v0lsBHq8rYYqOBURhWz2pS8W9xAEy10YzF7
   zYbu6xI1LFyncUJNpRLdcQuEDW2RVw52bK108NCI0k9D5sKrzOry0JbVf
   3zqf44JhrVhetN0p69hYo2UIJQAECWvhXDLGqdjKHjSqUK6kRwHv8w5rg
   9PsJQPAxAqk4feRHGUixcW4qyRqyz6FN3ZLvY582TmigcnnsUAqg2BRAw
   A==;
X-CSE-ConnectionGUID: 7FlSxWeCRg2zmvDfU4cIiQ==
X-CSE-MsgGUID: FWXoYtSDTGSCA9f5NylOrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="73987479"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="73987479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:29:28 -0700
X-CSE-ConnectionGUID: KYTvBo5ZTEa9ZpGwCUA6vQ==
X-CSE-MsgGUID: guoIUhtHTM+H92Ho8e52ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261705209"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:29:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 16:29:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 16:29:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 16:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4Yf3aoyTqdqv5+eUTjhpv6v7X6vdsb90sg4nCIozqIIuHmV9tGz7mZN6MpmbTxI+JTDceutR99WSmENJ1EpOYdcDqqgc/OkkWcBWAMjIhcVs9+0dovtqak1jDT7YjlXhzysOOSIT3tANJJQI9OdsbTITBticjkrG0v/w95L9ZlMnuKyz8POOMVqsv2UNEnvZWALf/hF3DQR1T36MOJoL1l6mOrn33THzuXDjWm4/VZ4seOb5u1xQ3etWKzb4eh27jgE42WFe9Oje1AniOD3l/MXbAtYeyA+A+NcS3RlKy5MOQXelz1gCdoIfHiibNkUUzsxE1Ho4y6f4I2s7OabSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prqVUmGElV2rJCbi/w68A5RL720JXcOJ+Hkq5RcuMRI=;
 b=iIXmAzhvvjVozWhqXXby39yJFxo0Rp6k0urUZbrpHv62c+lKFNafSsQ/EGFWxbpyqjkalqZLe0Fz9JJZa3AFGFaPgkSM8wNyTAK4eOJPz98U2zWG0KCuqoRCNmKXHI/CvIrEJkXXKZsy5amaHO4bS09kuctzIHCqZ2iEQSuE3pgo1ddCxegUecVTC2x3vsFf31VQQwauVqdQX+iRjE9k8GMKiZK7huE/mZfnZI6x2Vp71JRLlF1qNoWGOnhP8WH4GS+oUG5MUFYS0bL9HX6WQNx6h5LdCM/NxzPhj1tvLGuUzoGq6sefTcGOlYZgKiH1kI8rVsralbxBHn26LMjP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:29:24 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 23:29:24 +0000
Date: Tue, 4 Aug 2026 16:29:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/Documentation: Spell out globbed sysfs attribute
 names
Message-ID: <anJ10CSmq05cnNGt@aschofie-mobl2.lan>
References: <20260804232014.2286549-1-alison.schofield@intel.com>
 <850eb9c4-8f3e-4fa1-b8b5-46f83f5f20c1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <850eb9c4-8f3e-4fa1-b8b5-46f83f5f20c1@intel.com>
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d296a7-201a-4b10-6606-08def28037f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kv1z34PAsnhkeqjtfmL+Usap2TBwAZasnlPE3mjRtMkB1pDXeYuGlpCNJjxacy240V4wvWXul2NhxUA8XflUBJ9ptfmx7VRLkF94uSdlgTQMjzAetQUyR31kFdOH4/01/BWNznvC9mD3FC0jMxCJ9Lfu4O1fh0xLi6bPPSB4xmQzljUTFfCKzNkndM2e20YU0ikfdwLSVHpk1ln5qkoQEL5uD73wh8n9JEKhGvO9p4QYexUi7exltADbl1AzwzhokyHYbqN/O5m7igfKafLWw97BcL8jZmCDu3yTBtvo1MEI/uMsTQ2tvF7oaBTNrkjVnIWwA1eWukf/2o+DGaEgTjluVWuCiY78rZJF5U/Oj5DNrz0j58UH7LOFWVG71FeBxI4J6N5ep5j8Kae7+FUFupBT75I86wdVu1J/zKBFX76nfmtIwhFVJNBuegcrs59Zb/Avi9thJMSNKGgi81t4MZhtMvyF3U223zD+WwcgcSM+8TfCIRXkGQ7TTGXuJJzFWbmLODRfErk0AkZrPzvJgQ49S304Bam6Wj5uugeMPOnYxFP3ruyU3VYeTC2avjbWWIuxthLGJxbTb6DefXeMo1qFfCJJjFo4hASA8ic34q1gX6dSmMPGfI8Nmee438URzbTSqVTcsT1a153jZJI0w/Vshtg9R5xE9HL2c7g4kHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXX29ehgb4PjQ3xuOKTXxjuqb/+eE8cVXdzfVfECyMvz4HYRCsFFKRCVSyy7?=
 =?us-ascii?Q?TrWiFP9QaTA+wS9Ws/Do18E/QF9ckZwLwTXSQJv5Q4JsvsV4rPZlPcdTDJZq?=
 =?us-ascii?Q?ULVUXBB8jKlI8pPaPflU3DTjjXB1whlJzlNEYJf2v64ho90pDoye4Ik2INAq?=
 =?us-ascii?Q?qRQdVA+s0w5LcdZM85n912Kx2uav15YdFRIq/ytuOxGWDY8YSwzTkX/f3ViA?=
 =?us-ascii?Q?xNYBiPpNoG+GSXCvUWf7XHh51nhaNCUVXBOXhw6WyT/y42jhvlKMITsluVwp?=
 =?us-ascii?Q?JetVuRVV8G4NulJFijGgvrE9zaSwGofZUn7nOtA/Suzm+OBPLzMYjHFgLx+y?=
 =?us-ascii?Q?MgAwjt6U4sLJ2JBFobXE08X/cN0mAkI+MQ2KN6kbTyL6YwKZsooeOyEXZGAf?=
 =?us-ascii?Q?AjoxRDxTqcRatH/TrqvwW7SvwOlhU57UTx4uomppp8pH9TBbWrDRRwPibuIR?=
 =?us-ascii?Q?aoqJHq4XKgpSbepIDuigrg7TlmAGtOvoRf6X0FToI9qUHpKa8Mau6fMMSF79?=
 =?us-ascii?Q?l9xOwBkxGdQmk0jAhS+d6zKBeoqa80mz2h4APgkIC46FTvZfA1DJ4lpMkAjx?=
 =?us-ascii?Q?KtUV8QwK9v/vCxkqlmqBSUJWLspxcw4RlcoKYC9lJQQQBoE0HmwwEj/7mqWL?=
 =?us-ascii?Q?QUXYokCOxG/tHuQBQE60UoNNkryUrwHCGe/luiCc2ImungH88iru/X6GB+ss?=
 =?us-ascii?Q?9dbJVlfgt8WnTJ0w9MtD2ofFumOcWC/+P6+ATafzjWD+9p2RDulvjhuJOQIi?=
 =?us-ascii?Q?z5ynlPWV2yQuha8PKErKJze66h727MB/kgBnGzKA8EuO2I/pWeGtTpdFz7V3?=
 =?us-ascii?Q?q2SyzBzV7dO2rIUs/B7Yfw3ZpicnbZwbgw1XP2ziTpTQw7K5aofkHjII2p4+?=
 =?us-ascii?Q?b8aEgS8/zmdUYLL7vCkcqc+bfWjO49c9YEa0EsyWtqIegscT68AWXI/HF+VT?=
 =?us-ascii?Q?gr6G7oUzLX39625J8Bx1Y8EGXDOATDYzyr8tz9v8288S5R3DF5nNfFbJg/Bd?=
 =?us-ascii?Q?hgz9Pa+WCfpSWiG5GcgcdYC4T3Kso2+nb/rL1Q5SrJFv+x5rKn3/sv/01i3u?=
 =?us-ascii?Q?t6a8GYs22JyWGRkF559uaqfZPtC0v7YlFX3oDPI78b+dR3s0tPG0YeJckoOm?=
 =?us-ascii?Q?8VvOSlzySglAjXT6x4riAGwsrwfRqmm4+0fG2LpMo6F+gV2cKqIIitsNIKxa?=
 =?us-ascii?Q?SEjLdxmXq2Do9lj2ZRh5nl8uklaf/8TI+8Hknb6pF1ybMX8tSfdDwZV38WHH?=
 =?us-ascii?Q?BbesTHYIUJTircmmZlFRe5Jiex94coHBS5rBrBXcCg90mi9wHM2Vac7JnjnE?=
 =?us-ascii?Q?R0RVHrBe1c7qFOHNLY887+aJtE0ZtDbxRdCP+JVFttYARimKpDjinCzxS/01?=
 =?us-ascii?Q?16e7eg6UlSmo0ut1kmuQ2WQR/lub7+DjgUx09G6Ol6kZK5P3tkiXiHipmO6w?=
 =?us-ascii?Q?wzRkKZRoFUFsoNUQdDja09NKX5HUkxl1Yrp8sM90uXT4AGZkuo1NkA+KHKAg?=
 =?us-ascii?Q?4GHSNUITr/jw7781DNgJKFCER57NuCI69xUQlCAr4WjUtHFEStgWaPwy3v/K?=
 =?us-ascii?Q?OuwDEuCmI2a0CztWaLPPH7K9XOORWsaVkWgTPwuqYmdNLwFT/WnLgexVXTQx?=
 =?us-ascii?Q?uJd22RAOKOCsGaUYiWYM1HX5GaAAQNaEz5S05t1hyXCWipPi4idtYLEcohU5?=
 =?us-ascii?Q?55ZzAX91saY7Km1bNFAI0br7Ge1N4b4QQGiTdGOorjAeDUqfA8iYCJHqYJYQ?=
 =?us-ascii?Q?GyzGj6KicYwLN5pjopzP0N0FEBhus+w=3D?=
X-Exchange-RoutingPolicyChecked: T3lwhI5kyKTsdiETCt1eBt02etCpSoEQkN1faOr3fLPjNd4d2yOuPUzYD099iNJbqwlTJJZckTtnkdMduK34ZEWNUmkPiR6v3+konnOTdLtn+fmybcyqQLyzqaQOE+tfUKUMDoyxk70vmi1/9K/tY/fizwlqHYoqjfJigp+5L1bJta+V0CB1gho2wQf/hdmYKzrlONrq4ahgaLFCRD5mlh3g0Xhr+D2fX0i5btF94IMJbV6moKpDWEiVeJ5kT/nM4tAn+Xr9X2ow1GlheVdopqFHqrDVcvrdViX2G1r7isrmWplmDH5ubyiTyBs9F9FwH9SzmA4is5+dapKAEqH2xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d296a7-201a-4b10-6606-08def28037f6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:29:24.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KK5xlfNaQtA69XYopZb6f1Fvv7ygpNWg0fKO2uyywT15DJmac3G5yH42y5Nq9F49SQ0+NTeoBQGcqnnWkl++1JCH0V/vmxoEYY8VgqU0wjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 04:24:17PM -0700, Dave Jiang wrote:
> 
> 
> On 8/4/26 4:20 PM, Alison Schofield wrote:
> > Four entries in sysfs-bus-cxl use braced globs to document groups of
> > attributes. Where the glob factors out a common prefix, as in
> > cap_{pmem,ram,type2,type3}, no individual attribute name appears in
> > the file at all and none can be found by grep or get_abi.py search. In
> > every case the glob also keys get_abi.py validate on the glob string,
> > so duplicates against separately documented attributes go undetected.
> > 
> > Replace the globs with consecutive What: lines for each attribute.
> > These lines continue to share the existing metadata and description
> > and follow the format used in sysfs-driver-ufs and sysfs-bus-iio.
> > 
> > Also restore one missing blank line between entries.
> > 
> > Verify with:
> >   python3 tools/docs/get_abi.py -D Documentation/ABI/testing validate
> >   python3 tools/docs/get_abi.py search cap_pmem
> >   python3 tools/docs/get_abi.py search create_ram_region
> > 
> > validate reports no sysfs-bus-cxl warning, and both searches now return
> > the stanza where they returned nothing before.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Seems reasonable. One comment below.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 

You're faster than Sashiko ;)
snip

> > +
> 
> Stray blank line?

It's mentioned in the commit log. 
"Also restore one missing blank line between entries."
Pattern is 2 blank lines btw entries.

> 
> >  What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
> >  Date:		October, 2025
> >  KernelVersion:	v6.19
> > 
> 
