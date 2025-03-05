Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DD254AEF;
	Wed,  5 Mar 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201629; cv=fail; b=F+CO5PUrGHHs4LPJhCZpjYRN48up3RWt3Lq1w+1wxH9chDqddMSwA9ynDYwzBG/Tl1d/5GvspR1ndr/c+uluCMThRl5nxpTJ44W+VV+Ekvh2OsWy3Qz3slocH8IKuVKuZg46h8E13beWB+pV2xeLWO50FjmVfkU7z6HUizBJ/4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201629; c=relaxed/simple;
	bh=F7PyXdCt73GfCIhLeUmv0JRkj2goLRNBtuMhOV4hjE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YU61fMUzrMOvXoHrFvTBIrnfVzjD6q1lzNW+Y/klhyLdo8nDoI14rimuf/JYjdHaRJWqk8UUizMRBV2gZ4RKz9IG00czDp+2kh00q5fvx+nf43yFBmg9CSz99iPp5cbHVOYBgtXtQ/842k2yW9DEugzG/b+h8/dOGI3qFYmE3bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKgis5nu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKgis5nu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741201627; x=1772737627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F7PyXdCt73GfCIhLeUmv0JRkj2goLRNBtuMhOV4hjE4=;
  b=bKgis5nu6/D5YSpnbIUcCbuYRdlfRMue9EfGcRT3R0Nw4/dlD/5AjfqC
   popnk1spUylQaVaUpjQQUbfsuYi4L91ZPm/5ksLMvh+7nERXo+yBavTs2
   +SlFHCsdJfAUVlBg9tsGD1/HQzozIKLIfIJrtILt9O4I55KguD1YULvV5
   dpvaDHsoSsf7wBXhrz7jR5a0px3M/pbDHax6hvl8dbdeWtmfm/rgorTwu
   29FtXgpIMdyT6tBrOerIc+lz2d2zTqJCgnay0JOIaDxxamX+ZSDstMwIv
   w3tDbBU1CyNWO+lkazGYZi4LLmzYtbUFU2TMOk1QqHxVYWgo3w0+DGaov
   A==;
X-CSE-ConnectionGUID: ku320c06SIeS+sU7vK89Sg==
X-CSE-MsgGUID: VE0KFK2WRq+4LqPLdnD4OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42074311"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42074311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:07:04 -0800
X-CSE-ConnectionGUID: 1O0OL5MARdqBoLBqIkhO1A==
X-CSE-MsgGUID: G3P1wVCgSy6aeEzYXJG1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="149547718"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:07:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 5 Mar 2025 11:07:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 11:07:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 11:07:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1P6mer5NjCrhGYtMIiw3/Xb2k3Zch+0lLFGmWECzP9ggzqmFn1H2mwrVjQWvGy8a17no7hvmtG5oL3SsmffBTY+6NKuirjJ/6mMZGoSFm1ohibmKG+grtl/WCTnPoF+mVr9MssLMt84vNQXdUFSV9wQUEw3nUQTIuFPaVxcXthtyrkSHJqjmatIJWxmm5A1Y3ibXdpqmFbBLtkqdGksQWTYUp1hmfRbCkk+XADihjXEY5/1eNo2e5XY8A4F92wbUbE4tlPaxjmjjpp/Ynrmi4xYcFbDkahqf+soNmA9C1hZ6lfB9Ti8vqSp/Q6h+rba22MnME3JitK3RdtsQcpmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Meiwhw/wtDyCIjVHjHBgLcb4nOzMC23m+156cLT3a8c=;
 b=wYmazwsMLcQCp/zW3BdAKU40EvHezM80V7YYvYbd9YarVdAT79XEeAri85boD0GFBVWflsLLf75YTeUb0cIefplScVtzu/AFIjG7FIJieCqRF6pY4HXZt1/MYHM/woOD9bW1u0sJGOv1GJhzf6Hij1hNFTlyXdsVZrtFox3J0TZhTSPA+bLqXW9dP30tJZYnOTK7a58lg7TB6xWdIu9WOmiIyvQdmcW/3MwxXGTj8nOzN8FXMkhRgNZAb8iRrsKEoWvr1/AVG4bPwNgZE6wDGHJcZ82dB0F5VR0N+LmkGOeKxVfBCs7HJ/N/XOaBLHh1gJV6HlgKL45W0smHr0abUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 19:06:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 19:06:54 +0000
Date: Wed, 5 Mar 2025 11:06:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH 0/2] cxl/pci: Inactive downstream port handling
Message-ID: <67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250305100123.3077031-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305100123.3077031-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cef9f1-f34b-4236-9d99-08dd5c18e4e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+T8fYAVhGhmRIuYPlvoPojucuCsR1KR3uFp3N+w55sA1rhMxwLmKNNFSTaMp?=
 =?us-ascii?Q?8u2GIQbTsAnWbYUvsNmdqytdHW4paqvyX/EhlbegS8+L1D5BgSR6nExM5vUd?=
 =?us-ascii?Q?KPXLdRukrUiOr5t99aR/CDwlT7LsN1NtHZ5uCIaKM+lVjyG73V0MDhUeVQgz?=
 =?us-ascii?Q?irBjrS4y0Np1uPodUG8OZrDayUTPgqA4yoh4Y6wnkGhJ56Us6WEfpiiQdFRH?=
 =?us-ascii?Q?xKV8T9a67MEDNWyQ2rg7FSzan/xRJzq17MRd7SytlZFhxF36hehYqhp1jk4I?=
 =?us-ascii?Q?uRkv/2kSWb3uvDeX7dSVwpmDG6npvWup9oFNSasRpnC11OBIoRZFAnk1hp3Y?=
 =?us-ascii?Q?HKk+NXQu0n2lj6VYsUB7GUK2n7P0D+lDCQZHmnLwCRpzKXlZ7d4APFFh6plR?=
 =?us-ascii?Q?ElzwGmAIxyKOTcAWQdrs2ZqLxEf9XQngEVN7n7ELvB+0og9yOQFDpkt/VWSR?=
 =?us-ascii?Q?Sl45C5DyVg1BxQ9kUPjlXhNkyf4IQOCMhOf3EERH1kF/KiTSnCA6Trzi3lwv?=
 =?us-ascii?Q?JDiYnWokyy4FFBdp2IBPm9LE2topv33p1y8O7OjEfBRcjX308A2AV16lTz1p?=
 =?us-ascii?Q?ZT0FUjxdyq0UKFeP600zCDcQ4fDc/hUzJ4mstzRsD8fu+oYN0mmMep4utHmk?=
 =?us-ascii?Q?apFS6CClXENqkZlDm2/XEYyaNlZw4hUoakTW/3jpBEz8ZarMw7gQ0DRr0mrj?=
 =?us-ascii?Q?K1t1o3KH168weX9Yr0+3isibZWAb7CN0x34W9hG6JGKiGjrMeYUSijcrk7b/?=
 =?us-ascii?Q?ASUQyUSSQ9guUREvS8uqu2zdI9OT+E1VPNw8a1juMjXXXswN7rfAvEu5AX7U?=
 =?us-ascii?Q?URphGmR8I7Ou9I/PtVRNJhZ2tS0qIpggx2pbRdqgBgWs6LIVom/zYYSpEcd0?=
 =?us-ascii?Q?ketb+13p6QjVFx4X+xKhVl1QQW8VcCej05zHz+7rXv3acEFg+n2MJ4meoZSn?=
 =?us-ascii?Q?DtSNIgoDdbTft/77Z4JJCavgSUq2/MVv0bDxF0eY2l3jiTxTlipUizzNJJom?=
 =?us-ascii?Q?Kj8bKU7f4j5Fl2Pxvo+vHsE/AS4znMsBoYYr+GFjn/cwSUq5VWZZPfJmvYZd?=
 =?us-ascii?Q?/jAlEcfY+RQtfAbtmfme3qjT4zyVCya6JF1liNXzgXEcCFoASu9HuFBK0DqL?=
 =?us-ascii?Q?pOlNV28BkIStTwlXTud3fZHPKUGo3fOm9Yscjq2YDtsZTIyEYA8ULEe7aOe1?=
 =?us-ascii?Q?HauEWV76n5zat2MI77z38kFQHyK44l68nWYwH6mZWqSiVK1iajM5bCu9wSnV?=
 =?us-ascii?Q?1XpnlJ2IcPqquf+/LVG2vSpwyx1J2sKav/Q2bBRWHCQ9GlyRpYpYJ6kX6UCJ?=
 =?us-ascii?Q?84jpVOsouDNu5Yrzhj1DJtq+zNYn+XH/3MHLk3/DuVdCMT+9JdpPtgYJu4Cn?=
 =?us-ascii?Q?PqYXD3kVG8rT7/JuzOuryyJ0lgj8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHemAAHul5TnRA95HhjZVieb1f2suwhlh9CB+mBqi9TF6crNlELup5D5gdLB?=
 =?us-ascii?Q?i7S4X1r/GTrbqgJok6f6bKCnmJsfU+z4MGSMD62ZgIqBRhGY06X013JV5M+f?=
 =?us-ascii?Q?Ud6goxL+d09vehA6b37eR2W5Lgq0Giw4RhMBL5g6+HyidZ/40PRlejHY6ggZ?=
 =?us-ascii?Q?4G8E5k9n1Jjjr3fyD4rH4QZCe9BdFNDwNgP1MfYEpV6Wg4dqMhXO4bOhOWes?=
 =?us-ascii?Q?Zo8FHQS1K2GlOMp7kwhiY5rtXPFjJo+pcuIjwLvSimxiTnpMiXYkF+9c+aHI?=
 =?us-ascii?Q?bCbmbHofDh73JWru+iveXwDmqgiqEElq0AkYnIe1AbptZ66a+wSMe8720EIg?=
 =?us-ascii?Q?7MgLUlVG2IByizTyLRRowbJWcW5dnJ0zyIRNfnoNx0NX96l/bPmf5Yn+vNPA?=
 =?us-ascii?Q?Do1aYquZmyrp+JfQHO5mF9KzWCgkKaCBSvb5giCsuWq1G1gZhS9HWOI1PH+/?=
 =?us-ascii?Q?D5Wq/rnhZ2BzBKLENQd7gSVvO7ap2x1trrPWSvqll2lPXpMlLer+UnZ1pl+n?=
 =?us-ascii?Q?DO6SeDf7jgtwFIJjsWhSj7koTp1fbQkLlNJS5T8uztTZAoc+54pS72ZoPAeU?=
 =?us-ascii?Q?c8qxwvSa+0PQXerNdtV4MQaWxYFvVihYQlfXu8D9/3coZ563nYqZhVob2i4F?=
 =?us-ascii?Q?XHZWVL3OnJL7Es5PV/BaT1X2+YjW3mG4xf5PHBUqO4Si4gv864wiFyuEF26b?=
 =?us-ascii?Q?30sicbajgcCs7S5jQrSLjIXBn2Wvi9scNsjP/pMMGSQ2e1cF+20svLPgxc96?=
 =?us-ascii?Q?PY2JVY5F8YAYmYYWUCgaJRb8Kj87re/zVQUumMg5RvkF3tpLplRQgaqvcAzB?=
 =?us-ascii?Q?QlGLsm+P66ZLCTSquiyIu3pHqNEpMBYujOUU7WU0LYl7C70rRKZQ/C53uDSE?=
 =?us-ascii?Q?pQ0hY3cBmzryIeQYuqgkXwQNRFAlqlhaONalgrv6y0XDPXb7LrAzXpSrhk8i?=
 =?us-ascii?Q?KDfVJKiQwSrb4lEDCDVUAHIk2DWmx7SXYiUGn4xnad4zsqAHg7mFGBWnzz4s?=
 =?us-ascii?Q?1lHszsIbYA2e3fqxO/NQ2kblIEF5d53mKluFKFzQmTnTTojiMRtD3apHm8Au?=
 =?us-ascii?Q?60betnp7KAKkpRkgArmPqtOwkZOAgnTPUyBiLqjqsbYOBGOp0nWabnABu931?=
 =?us-ascii?Q?pkuehM8IhbcyiKQ0XbnipyLgbxYjzZH/3ElPfHnc10tUP1F5MxFBAIbENPzN?=
 =?us-ascii?Q?ZW4hRxNpbVaqt+mVzTt5N8XBVBr18hhhLPL9DmLBn7mItuJAu4cC/Ov8x0vp?=
 =?us-ascii?Q?R5F92GToI4lzvBeVdQaJ+EaQwG3RsXF8CV3xYUUV2EI+EU7ew8qXCS1SzfAc?=
 =?us-ascii?Q?kRcWtsY74vvmFOl7/ZQCPcd2PLsavAVci3+T1Z2az2PNksswWOw8PO3WUQFM?=
 =?us-ascii?Q?GU92p+HxzYvkullu/PZwtCiy1MHTIoUuvJII85i6VtZIqt7wiC3Wrv5wO1Mt?=
 =?us-ascii?Q?gs5cn0m0+VigO2uYzAnR3idICoTP/kCuvQ47uQBP53/WTtPG2Xp9mcLs5+N9?=
 =?us-ascii?Q?RyrUNfyNav9NtlMPe9uwEL0qlJPBsWG0n/jSH7TifpYfoMHTrxDIPprHWQ/X?=
 =?us-ascii?Q?w9v9nwE/HivFmTVbtl8HVsZwdGaO7k9USkpxVX+jggaWbkx2GkzItupdIYQE?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cef9f1-f34b-4236-9d99-08dd5c18e4e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:06:54.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d815Zc7hR6qZmJyuaT702BPglc+Ijv6ku4TEQxvhSzTgP+L6RYAQ9d5x23V/lG+XCJP41eRr6lAqMxVDmrJKVHLZZH1zRUsJ3DkMSsQ8U9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

Robert Richter wrote:
> A small series with individual patches to handle inactive downstream
> ports during enumeration. First patch changes downstream port
> enumeration to ignore those with duplicate port IDs. Second patch only
> enables active downstream ports with the link status up.
> 
> Patches are independent each and can be applied individually.
> 
> Robert Richter (2):
>   cxl/pci: Ignore downstream ports with duplicate port IDs
>   cxl/pci: Check link status and only enable active dports

Both of these problems are to addressed by work in progress patches to
delay dport enumeration until a cxl_memdev is registered beneath that
leg of CXL topology.

I would prefer to focus on that solution and skip these band-aids in
the near term unless there is an urgent need that makes it clear that
waiting for v6.16 is not tenable.
