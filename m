Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91111C83
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089815; cv=fail; b=fi4xNf4f7JnX7lz280yZsVACVcYUvqVKAGbqKHhFDXNzCgwqZRVw00zPNv3cI0RCJo0+NPK/jaH3VmWSw8HH3n54F3bTBeAItkypQvnSH5r77pAgLJsNAtSyGWhnZ6Z34qvsD0/KOkU1GMwaaXHxo/+eRCRdtZPuIEf6petRrP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089815; c=relaxed/simple;
	bh=X3CiUmHf6EMwFF/jjA07h7lCk8977PE9n0YCvLDh4qw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qZ0oHt+t599F/Er5ars/0Y5upzDe0JajJSf/lm3B9TixOnG1xTgcEBrf5a91AI2tG13u9YsM3PKfhvTuXrimgZo/mmZ8ibGlmy4gV4Tzvo2S5IyUUxW1jTQUW6xCfE0bpAVdRioyz5z5ialKqUPT0/u8YMNmHBvLkIozOqrlsKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7p8tUax; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7p8tUax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723089814; x=1754625814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X3CiUmHf6EMwFF/jjA07h7lCk8977PE9n0YCvLDh4qw=;
  b=I7p8tUaxmj/C234AfrweukEW9TmTpQ40C3f/cZWRWct1wFfIS41HUQDa
   gac8AY9x5XE4wbgFVLAESQMCuYZwf/nyWiN+I+3ri8naZPM2TtPowoOWb
   utWz/lezDDkuzEKnCe1wGEe5IcRZGdxLEgO2nUngTyK0Th0sxVRdYbKSp
   8yIECSppGrr5ZBK20/x4SFHtsf8u1TcVZ5vfj422mIWkOup5FbFgq84dz
   3uylUVG14P8ex30UvH9fTbAB9zMu7LO8PC/acUPbRI0p+FKeKVF2CNTj4
   uvHCk/ymfAhqfwIn2HYkHMOEMKuQQIPh6n8VRmMdjqwzTeJkgdeDCujtX
   w==;
X-CSE-ConnectionGUID: yxcC0BA2RDKKXVd6cHfvJw==
X-CSE-MsgGUID: QKTTVr3FQXu7jazupGjo3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32585664"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32585664"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 21:03:33 -0700
X-CSE-ConnectionGUID: flTi1cXZSc6ldwHwA5DBCQ==
X-CSE-MsgGUID: a5CqI+PHQnCjp1NTuHvufg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56771552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 21:03:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 21:03:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 21:03:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 21:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxbGhPDzWFEJbQp1CEWmmhyt9PdtHrKOv4X0r/uomabBgeBz9DFs3nx6F3LwMVv0dFXHKB6ac/e93zsuWl5C2mD80QcDPtEpqBw9ZsEpRSPDH12hxGERD4Yaa0TWHAOU6XwrpfHaSAh1FWqX1MuRQ3TL3vCpbnd9/sJiH4mRoimXigNCTscqT5xQRmMXD+eWiMXk6Gtkt19zAWHswn+TwGk4PvyCLCeOZRY45GEMlhv0oM/EYakMP5K6YDzVj/NZPL3M6W7IoEX0HO9pjGLB6PW7r4E0/wZuQgby9qxkudBHuzM7PpHRYOc9sq8kR/FDu+yJgFqYqE9piqnZuy5pHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU0lbQMBQuCteyZ/YJkOh7WGUON3S0Okuw8byXlXNKo=;
 b=pWvRvacTRYdbnft49DCr50D4mslFhbhFBdGKmT1R/pVKG7Ujw8O9sB4JZW+6Hhou1I4GDYy08to+aJDQAEYVLJPquPbcZ9wmQT4Fc4fhqmzzwtrB0abUJ3GDKlytBlg5v/ThP84zWOdsvn1ncNWIRdxIi5Df7VZSbboMcHQAhoPes9VmADMrdbdXiYbEDI7hHRGWyURcAcsWW00gB75WTw/O+6wKVFnXGc5r0er8sOw3SwW91krmeppsTSOTF71pE9OchYLYoqxuhw72GslW2RTqhmljlh7eYbvXPd/W8r3GcY46EBpdE+GhFcBcinFq7ImlHvKbxqyzQf4Fh0SkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Thu, 8 Aug
 2024 04:03:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 04:03:27 +0000
Date: Wed, 7 Aug 2024 23:03:21 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Lukas Wunner
	<lukas.wunner@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-mm@vger.kernel.org>
Subject: Odd lockdep splat involving mt_adistance_algorithm
Message-ID: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dea3551-2928-4e2b-1ac5-08dcb75f0e9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BpGiTVE8Yg6D5OkWsZwb+lTHlKLzLENLl5sENAwzOSyj9Ue+kKOmYWF5gflV?=
 =?us-ascii?Q?TttKFigvc6q/PqqhsR3okEBlDedKrh1WP3gUSYU+X3hM/WDy19tc4RbzABng?=
 =?us-ascii?Q?QIK9UP/5DGdbqueRLOtOGZYIgVdfCaKTFi4pEUAmNdJG0jZ8DG65JgWMOTMA?=
 =?us-ascii?Q?ZaMFcx77SkkQm1WixzNtIe4IIufxEdLysetB9K11MphFbzZ6fv5kRPl7b/WW?=
 =?us-ascii?Q?M6QJnb0rPe5EGP/Y3DAEPNrB6MPBWz4O3VK3PQqoGtfO15VJ/y7uC5+FYoDe?=
 =?us-ascii?Q?L36oXkLsV9S5w43tmS5d12YVY58D5oc7AeOIHoEpIVm2yUv13tHbGpaSrrw9?=
 =?us-ascii?Q?WybGLGATDAAvw5GBQD3PChCt0uRLkKzhl5gD+OqkJD24VsEVDgv9nQ5kn4b8?=
 =?us-ascii?Q?lslq11wD/tjWg+uL1GIV6m+xB/TljE9Jwb7aRcszv6hYA78cucFQYYAJCZKt?=
 =?us-ascii?Q?bLSHkP8AGmJmRqcdzOZHRR0v7dmnfapPHo66GqqNuc1/mJkMxa9iTRyVcaxl?=
 =?us-ascii?Q?ZjrOAtcf9DLwihwZMHoh0XkWP1gBZb4yaDV2lJDxVC0sT7nsAcakMFOhmr5I?=
 =?us-ascii?Q?pq9/D8e+jfW3mGcV0efC/hI5cg+BV3x009uGkEmXh3VdZiUU5p4pkK5mzcp5?=
 =?us-ascii?Q?Eaw9zFXJdwJjr/OdPvSH1yE5ebjZwdYGt/EPl7f0JZTFWJ6/6BVsFPvmvSyV?=
 =?us-ascii?Q?6FN3rukHW/+0x8wJQzHocEnxiv7yxeX2revbmc+E90NNS0vYsL7pxzI1ArLu?=
 =?us-ascii?Q?jbVGrie3WGCetIw+OkHpnPz91USKksF5jZZk19Pcaq3jR0YmjsK1p4fb2Ihe?=
 =?us-ascii?Q?rLyBwGq4Alvn4MazClmQUKt/J+ivsJ6y3mkuc++OoO/MdKg8p9+5cGdHIXXu?=
 =?us-ascii?Q?JQwNope3UC2biD32mIzNamGnMj6dFm5J6YGbC75nMYT27avCkoY5soP8diYL?=
 =?us-ascii?Q?sMyBp8k2A2VIqbNmz8LJblXcGpyjAatimDbUYTAhLNvd21AvkEhTcJ/xFk2m?=
 =?us-ascii?Q?8RFZpYnOubXXzyQmZI8Bv7vW3q5GtYbOUA5CIB6oMbsyt9B+7GqLoPZoEP8w?=
 =?us-ascii?Q?5ib3ic8sco+8NeDJkMYPG1mfKz0lD4RS7QdlYGUAMo8okS+rXR7nU7rcF0ZL?=
 =?us-ascii?Q?SUVhI7AhEh5VCtXz9lhZVhP9QLeIkybF1MK32LxRUPn+eN82PbgOEoVHrll2?=
 =?us-ascii?Q?yhEzXVRsYzdnqz4eXyDkfjsMZnOhS0rqs+cLnx7UbQxsHyZaGnVFEt60d9An?=
 =?us-ascii?Q?iZXup815z4pM1rYpkcqG2hb+qkMvcI5qJXazllufOlI24K68N1r/ftC6RC3B?=
 =?us-ascii?Q?UW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kE7ec8m/zg/0fsr+QnP6yjTEDL6ALad0mvwG2aR7vLC3QRcGJwz2iArbx1id?=
 =?us-ascii?Q?fy7agKVFn26jRCrc6ZpF/vU7FsE/2TzSw0FJJeoJk8Du6gq0kdqvxcsjcgAv?=
 =?us-ascii?Q?Pzc/8XJaI5Siq28sev5AKuYf2xg1zk9TCp1RIuWyZ4fSDJKqiCWXgOwL9EYF?=
 =?us-ascii?Q?0gTCLkiDfgLxOCjICkwn0j1c9EK9ObGvjdyJ1wsvFpTW6gsPEuEwOqyEvpSV?=
 =?us-ascii?Q?XXZRpNOz8mmmEtwtjZRE2CIOaIOY2iuiir8Hvt/6On4pEpawQjCOyVDjvpJZ?=
 =?us-ascii?Q?WztgUiilsFjkeXBT2EzOQMi36yIb+i7ivjnHHI8ZYp1BaRhLqBjeZHBsSYnP?=
 =?us-ascii?Q?9rfewpmA+RvptUu8Zp2orsKro8CPRobFZemFogEo3K8Ksi/oQng8I7JAcFo0?=
 =?us-ascii?Q?lttmquMtYMDzVPEf0SwMOG/ihzvct5fgFWEOTl93plID6o7fPZb7/Uqj1Tb/?=
 =?us-ascii?Q?AKV/bQR+TxfwraahUdN2juTSMOqRVeDVJwHy5eLn1KFiC25PhP+zeM4iJNmS?=
 =?us-ascii?Q?wVs5cpkMha7CbufrT73GEEql3eXwDxB695uTHWGxrtCniaFPkAoP9902LwQS?=
 =?us-ascii?Q?dQSDvbrlTdEaCMHzg0VVmzNQiDTPrFgSfX7Xu4xn3if0zWH/WksqUrDbdIoS?=
 =?us-ascii?Q?44wCBvSoYAwcmf//XZpVnYQCDR6cka2z3AHTeW2Dll1a7hF3c2e9OTp6nIWM?=
 =?us-ascii?Q?UNcYwxH9eWkAhfTHbhXbrKrpG9oi5MJTnMRtlFHG6uw6y4EsPdDorpa2stac?=
 =?us-ascii?Q?zVkkvpY/VkxFrmHveXeVqEQbPmh+JDmagPNFq9dLHdFiExtXIBLAuUZ45YLe?=
 =?us-ascii?Q?bmaSpjcdeyqgojZcIB2HNjEdUWPQslsW0YA8zMWRIa2jFV1f0KbulbXivCq4?=
 =?us-ascii?Q?6dHBll5U3nfLt9QJdxZWk9X/z2ewAkNJwQg3HIBEYqzW9Mv1kVQ3+sTaBXM1?=
 =?us-ascii?Q?e39FC66SNnABrCUSlsMgGjTWbrDerJeAIjUnglyyJMTjpAxUDxfgwMSfBwJ6?=
 =?us-ascii?Q?gPB+FukiqHPTCGaTKkVZ3Ap/QPfdfGhv/Qvt11ZUMC5pjMIA0g+WUGs4qYgz?=
 =?us-ascii?Q?FcdVgbHQoogLIzqaXRPPS5AFR88qAoiQeTSAfVtKGt4WF7tU5oGg4W99iJfF?=
 =?us-ascii?Q?l07ywuHf60ktJtlttKZOsVeHIINkyfBc39O/9jDK8hMU7wjhxpC59nIr9gtm?=
 =?us-ascii?Q?EZExa8Yt8NupJtk+Z3wmRyB3M8jkbrnQ6IoYg10m3gJpIzkpYjq7o9OpLXQd?=
 =?us-ascii?Q?Dre5+DTyydXADHK82s2PD8/2D3LmuZKqCx67ER0h5tT23Jp2LCAcyy+j3O8C?=
 =?us-ascii?Q?6FVACMc7kk4SczVy62wmfXkChbsVTke5Fus5w1JKFj0YcZooLC1Pxgw9ISdE?=
 =?us-ascii?Q?kjb5xEHKy4yoASfO/1M1oGgIz4eSyzgf4AzlOOplLIu1ld5PoVb8r4YyHOPl?=
 =?us-ascii?Q?OxRJEaRcGomfHnibYfHqOjMuMTnUH8Ue529SPjtHc1bk3TWVkl1dN8CTUdqt?=
 =?us-ascii?Q?h1gVB4Vt5MFlwOynobridtR/f00yG38iVX+Y8PLF9qMxKv2VvuJN/I8YecR3?=
 =?us-ascii?Q?L9M8SG4qde438cuS3tNhTjEUxdZy9b5D+Oc0wjkT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dea3551-2928-4e2b-1ac5-08dcb75f0e9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 04:03:27.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3/4knxq2Ha3daT1H/ZNCe/3gwYx7T6b1X8Z7WWcIuDmlLSAJLQUpLzb+2Cxs/tLSNEnoPnPQeAoK6zWziromA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com

Ying,

I'm working on the CXL DCD support[0].  After rebasing to v6.11-rc1+ I'm
starting to see the following lockdep splat[1] in my testing.

I don't understand how lockdep thinks there is a dependency between
(mt_adistance_algorithms).rwsem and cxl_dax_region_key (the
cxl_region->dev mutex).

Do you have any insight into how the notifier rwsem gets associated with
other locks?  I just don't see how the association in this splat is
made.

Thanks,
Ira

[0] https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-08-07
[1] <splat>

[   25.691773] ======================================================
[   25.692509] WARNING: possible circular locking dependency detected
[   25.693222] 6.11.0-rc1ira+ #20 Tainted: G           O     N
[   25.693888] ------------------------------------------------------
[   25.694599] bash/1161 is trying to acquire lock:
[   25.695194] ffff888022ece0e8 (&cxl_dax_region_key){+.+.}-{4:4}, at: cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.696122] 
               but task is already holding lock:
[   25.697145] ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
[   25.698069] 
               which lock already depends on the new lock.

[   25.699536] 
               the existing dependency chain (in reverse order) is:
[   25.700618] 
               -> #3 (cxl_region_rwsem){++++}-{4:4}:
[   25.701643]        down_read+0x2d/0x170
[   25.702204]        cxl_region_calculate_adistance+0x20/0x90 [cxl_core]
[   25.702922]        notifier_call_chain+0x40/0x100
[   25.703526]        blocking_notifier_call_chain+0x41/0x60
[   25.704158]        dev_dax_kmem_probe+0x40/0x380 [kmem]
[   25.704778]        dax_bus_probe+0x6b/0xa0
[   25.705351]        really_probe+0xd6/0x390
[   25.705872]        __driver_probe_device+0x78/0x150
[   25.706463]        driver_probe_device+0x1f/0x90
[   25.707003]        __driver_attach+0xd2/0x1c0
[   25.707547]        bus_for_each_dev+0x66/0xa0
[   25.708067]        bus_add_driver+0x111/0x240
[   25.708574]        driver_register+0x55/0x100
[   25.709069]        0xffffffffa1172050
[   25.709557]        do_one_initcall+0x60/0x2c0
[   25.710060]        do_init_module+0x60/0x230
[   25.710555]        init_module_from_file+0x75/0xa0
[   25.711095]        idempotent_init_module+0xf9/0x270
[   25.711643]        __x64_sys_finit_module+0x5a/0xb0
[   25.712164]        do_syscall_64+0x75/0x190
[   25.712651]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.713225] 
               -> #2 ((mt_adistance_algorithms).rwsem){++++}-{4:4}:
[   25.714117]        down_read+0x2d/0x170
[   25.714567]        blocking_notifier_call_chain+0x27/0x60
[   25.715095]        dev_dax_kmem_probe+0x40/0x380 [kmem]
[   25.715610]        dax_bus_probe+0x6b/0xa0
[   25.716043]        really_probe+0xd6/0x390
[   25.716481]        __driver_probe_device+0x78/0x150
[   25.716956]        driver_probe_device+0x1f/0x90
[   25.717397]        __device_attach_driver+0x85/0x110
[   25.717864]        bus_for_each_drv+0x6f/0xb0
[   25.718296]        __device_attach+0xb0/0x1b0
[   25.718703]        bus_probe_device+0x94/0xb0
[   25.719119]        device_add+0x646/0x860
[   25.719518]        __devm_create_dev_dax+0x19f/0x470
[   25.719954]        devm_create_dev_dax+0x1d/0x40
[   25.720393]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
[   25.720867]        cxl_bus_probe+0x17/0x50 [cxl_core]
[   25.721329]        really_probe+0xd6/0x390
[   25.721720]        __driver_probe_device+0x78/0x150
[   25.722145]        driver_probe_device+0x1f/0x90
[   25.722569]        __device_attach_driver+0x85/0x110
[   25.723009]        bus_for_each_drv+0x6f/0xb0
[   25.723414]        __device_attach+0xb0/0x1b0
[   25.723809]        bus_probe_device+0x94/0xb0
[   25.724206]        device_add+0x646/0x860
[   25.724573]        cxl_region_probe+0x5ae/0x7c0 [cxl_core]
[   25.725025]        cxl_bus_probe+0x17/0x50 [cxl_core]
[   25.725465]        really_probe+0xd6/0x390
[   25.725840]        __driver_probe_device+0x78/0x150
[   25.726247]        driver_probe_device+0x1f/0x90
[   25.726655]        __device_attach_driver+0x85/0x110
[   25.727073]        bus_for_each_drv+0x6f/0xb0
[   25.727463]        __device_attach+0xb0/0x1b0
[   25.727838]        cxl_add_to_region+0x2ef/0x5b0 [cxl_core]
[   25.728302]        discover_region+0x4b/0x80 [cxl_port]
[   25.728726]        device_for_each_child+0x48/0x70
[   25.729137]        cxl_port_probe+0x160/0x220 [cxl_port]
[   25.729565]        cxl_bus_probe+0x17/0x50 [cxl_core]
[   25.729984]        really_probe+0xd6/0x390
[   25.730361]        __driver_probe_device+0x78/0x150
[   25.730776]        driver_probe_device+0x1f/0x90
[   25.731177]        __device_attach_driver+0x85/0x110
[   25.731600]        bus_for_each_drv+0x6f/0xb0
[   25.731982]        __device_attach+0xb0/0x1b0
[   25.732378]        bus_probe_device+0x94/0xb0
[   25.732770]        device_add+0x646/0x860
[   25.733141]        devm_cxl_add_port+0x43d/0x760 [cxl_core]
[   25.733595]        cxl_mem_probe+0x23f/0x350 [cxl_mem]
[   25.734025]        cxl_bus_probe+0x17/0x50 [cxl_core]
[   25.734453]        really_probe+0xd6/0x390
[   25.734821]        __driver_probe_device+0x78/0x150
[   25.735220]        driver_probe_device+0x1f/0x90
[   25.735611]        __device_attach_driver+0x85/0x110
[   25.736025]        bus_for_each_drv+0x6f/0xb0
[   25.736412]        __device_attach+0xb0/0x1b0
[   25.736788]        bus_rescan_devices_helper+0x39/0x80
[   25.737207]        bus_rescan_devices+0x46/0x80
[   25.737611]        cxl_bus_rescan_queue+0x11/0x30 [cxl_core]
[   25.738080]        process_one_work+0x1f8/0x660
[   25.738478]        worker_thread+0x1ca/0x3a0
[   25.738861]        kthread+0xe0/0x110
[   25.739209]        ret_from_fork+0x30/0x50
[   25.739575]        ret_from_fork_asm+0x1a/0x30
[   25.739958] 
               -> #1 (dax_region_rwsem){+.+.}-{4:4}:
[   25.740573]        down_write+0x2a/0xc0
[   25.740930]        devm_create_dev_dax+0x15/0x40
[   25.741322]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
[   25.741776]        cxl_bus_probe+0x17/0x50 [cxl_core]
[   25.742201]        really_probe+0xd6/0x390
[   25.742580]        __driver_probe_device+0x78/0x150
[   25.743003]        driver_probe_device+0x1f/0x90
[   25.743403]        __driver_attach+0xd2/0x1c0
[   25.743780]        bus_for_each_dev+0x66/0xa0
[   25.744167]        bus_add_driver+0x111/0x240
[   25.744545]        driver_register+0x55/0x100
[   25.744930]        do_one_initcall+0x60/0x2c0
[   25.745308]        do_init_module+0x60/0x230
[   25.745679]        init_module_from_file+0x75/0xa0
[   25.746093]        idempotent_init_module+0xf9/0x270
[   25.746499]        __x64_sys_finit_module+0x5a/0xb0
[   25.746907]        do_syscall_64+0x75/0x190
[   25.747277]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.747716] 
               -> #0 (&cxl_dax_region_key){+.+.}-{4:4}:
[   25.748351]        __lock_acquire+0x15a0/0x2320
[   25.748750]        lock_acquire+0xd0/0x2e0
[   25.749108]        __mutex_lock+0x7b/0xb60
[   25.749479]        cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.749949]        cxled_add_extent+0x376/0x400 [cxl_core]
[   25.750400]        cxl_mem_get_records_log+0x586/0x760 [cxl_core]
[   25.750877]        cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
[   25.751360]        log_dc_event+0xc5/0x180 [cxl_mock_mem]
[   25.751788]        __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
[   25.752333]        kernfs_fop_write_iter+0x141/0x1f0
[   25.752742]        vfs_write+0x262/0x500
[   25.753108]        ksys_write+0x59/0xd0
[   25.753484]        do_syscall_64+0x75/0x190
[   25.753851]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.754297] 
               other info that might help us debug this:

[   25.755143] Chain exists of:
                 &cxl_dax_region_key --> (mt_adistance_algorithms).rwsem --> cxl_region_rwsem

[   25.756258]  Possible unsafe locking scenario:

[   25.756878]        CPU0                    CPU1
[   25.757314]        ----                    ----
[   25.757706]   rlock(cxl_region_rwsem);
[   25.758067]                                lock((mt_adistance_algorithms).rwsem);
[   25.758631]                                lock(cxl_region_rwsem);
[   25.759126]   lock(&cxl_dax_region_key);
[   25.759502] 
                *** DEADLOCK ***

[   25.760242] 5 locks held by bash/1161:
[   25.760619]  #0: ffff888008d7f3f8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x59/0xd0
[   25.761197]  #1: ffff888009589088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf7/0x1f0
[   25.761858]  #2: ffff88820881c9a8 (kn->active#154){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1f0
[   25.762533]  #3: ffff8880170dd788 (&mds->event.log_lock){+.+.}-{4:4}, at: cxl_mem_get_records_log+0x5b/0x760 [cxl_core]
[   25.763297]  #4: ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
[   25.764050] 
               stack backtrace:
[   25.764621] CPU: 2 UID: 0 PID: 1161 Comm: bash Tainted: G           O     N 6.11.0-rc1ira+ #20
[   25.765274] Tainted: [O]=OOT_MODULE, [N]=TEST
[   25.765709] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-7.fc39 02/14/2024
[   25.766389] Call Trace:
[   25.766717]  <TASK>
[   25.767013]  dump_stack_lvl+0x8f/0xe0
[   25.767400]  check_noncircular+0x130/0x140
[   25.767807]  __lock_acquire+0x15a0/0x2320
[   25.768204]  lock_acquire+0xd0/0x2e0
[   25.768588]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.769101]  ? __dynamic_dev_dbg+0x166/0x1d0
[   25.769530]  __mutex_lock+0x7b/0xb60
[   25.769913]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.770433]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.770939]  ? mark_held_locks+0x40/0x70
[   25.771341]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.771867]  cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
[   25.772362]  ? __devm_add_action+0xbd/0xe0
[   25.772796]  cxled_add_extent+0x376/0x400 [cxl_core]
[   25.773269]  cxl_mem_get_records_log+0x586/0x760 [cxl_core]
[   25.773780]  cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
[   25.774273]  log_dc_event+0xc5/0x180 [cxl_mock_mem]
[   25.774742]  __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
[   25.775284]  kernfs_fop_write_iter+0x141/0x1f0
[   25.775731]  vfs_write+0x262/0x500
[   25.776124]  ksys_write+0x59/0xd0
[   25.776511]  do_syscall_64+0x75/0x190
[   25.776904]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.777385] RIP: 0033:0x7f5c0fb3bee4
[   25.777771] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 74 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   25.779190] RSP: 002b:00007ffec4c72e48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   25.779815] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 00007f5c0fb3bee4
[   25.780415] RDX: 0000000000000023 RSI: 000055ceeac88cd0 RDI: 0000000000000001
[   25.781005] RBP: 00007ffec4c72e70 R08: 0000000000001428 R09: 0000000100000000
[   25.781604] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000023
[   25.782196] R13: 000055ceeac88cd0 R14: 00007f5c0fc0c5c0 R15: 00007f5c0fc09f20
[   25.782813]  </TASK>
