Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A631ADC7D
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662279; cv=fail; b=DxkCzLjl3okx6KCYDOcbn64bBdz0ebUVMblm42RPjXcTq+BaSursgm7+xfzMlwT1rieyzeZEbNl+ZpgM5AVPYs8qDkRBP018MsskdCK1cVT0DvPyuBU9/bW8bBQWqhJFdGc4REKsdfFK00l7DHcktiuyTUh+eryB/17dEX7eDE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662279; c=relaxed/simple;
	bh=UXJBgVigFm7oVY+uUKjKI6zOzPRMmMzrZMyLmgyHaHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rqmRkLsFFr3UT9x2naLBRMJYFa7W+zRfta5FIY0mac0U6MBuYJHFW+w4IfnIIhaYuiatQvYhCcZDEE8EQODJ/F6OYD5cJ/tV209Rs6KbcIlf1r3C/cAuuOEN+FtGfGdj4wwVDks30uLorgdS1URTCHGxhKSkPdB5+1tkn+X5oQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKL5fNkd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKL5fNkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737662278; x=1769198278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UXJBgVigFm7oVY+uUKjKI6zOzPRMmMzrZMyLmgyHaHU=;
  b=NKL5fNkdxDFRgku/91P+7t1q0PIA8GOZFX5NosWPKGTWqXlLt0BQJlYb
   4xM3CjtdEAkJEtfmEHNCZXE2SnrZJ3DxEdq0QLmkFqK1x0IzGBYSa3p3F
   SIBYMOewQw+Lj+Ex+hM6pqiEpm7hNDDpJCEPUH/reFenwhexGjqjHGnbG
   dOIkYSGUJh/9kd8uzgnJZ87JV4ImEnNbuH0m7m40CPBuded+JylvuVdUM
   BSvuzKfkE7odV/9lr0Bt7JA75ToqjuowsXvCp2HVBo1q83JZt7aDzr4iL
   fsjmPhptGNY02qb9gUN9KcVdmDqb2HXdTGmuIv4WIl+yjonSg/Vntq71V
   A==;
X-CSE-ConnectionGUID: 3A2S98y2Q/OSBKY9C3Bqvg==
X-CSE-MsgGUID: wdapIvC0SVOuC9GmtXQpFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48686099"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="48686099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 11:57:56 -0800
X-CSE-ConnectionGUID: AoeZpQpgSdKC3aZHqS4i6A==
X-CSE-MsgGUID: BzL6+mxpS5yxW8fh2Lj0qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107474941"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 11:57:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 11:57:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 11:57:53 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 11:57:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6Vz4EVQ2v/wO1/RP5htOrMW3DTv/ygC1mvRPgT+mokWqCPqeBK9WvhLouCs52BcfD4QCP/Ku7fJI9NpKC0QWDS7af5iuRId/uaqdaRhKZMDrdIgbwVNOoYDSyG3CpSWTNPJmywTfjkJJhju7t7RQ46WpEiKerhhgGpjC3qvNsWkqt71XJoB9anKCLQVxymaHNyedwityY/N0nTUEKmQ17Bzo0V/mkMgUQGtgbD4j8pLdt7H+Zz/zvUI2Nue3Du4LjVKTVmLBAY8zBoLSv7exL8NFsmx/XpGRe7OJ07nQcEjX6sBsVAvnDPcttVxhUPzwsgtJmTSQpIS4MKqGqE3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7WGMjCvqLEZnNmJx89uNFAvBwh5zSRkH21ACD2cf3Y=;
 b=tBojD7tVil8T5FXONcXjHXvHmcMOkrCJoVabmdNPOvfMbAyQWTGVyHfEa21uZIPGrVOeHrfXEnYCShqDXiSjerv1ibWyq95n1dO/oRDewbcUO828webdpjgWksXcZ34wk6s5ML9J6IvJTpgCZErW5/KaJQUn3wKubswF8GkXapGG0hiVca9BN4EPaBdBYeYXqPkm7oyL58TlLH7KB3tyIWdV2FhLxcB5bjEBuYEb0tqhT62iL3v40EP4/A9IJQ9izF13NxzMGOup/LM4nhkJlXWM6KTr1d+yjJRhNGBYX0aTfHMbStBshbIPlaImFuaRWMx/+zHD3vNxG08rFLY+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 19:57:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:57:24 +0000
Date: Thu, 23 Jan 2025 11:57:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <jgg@nvidia.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v1 02/19] cxl: Add skeletal features driver
Message-ID: <67929f21b0bb6_20fa29456@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-3-dave.jiang@intel.com>
 <6791be94971b2_9b92294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ad962652-395e-4bdd-ba8d-a82d5dfe27e3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad962652-395e-4bdd-ba8d-a82d5dfe27e3@intel.com>
X-ClientProxiedBy: MW4PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:303:87::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3f1918-bc5e-49ee-f657-08dd3be82794
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rSJh5UiWYPtl7zMcZLzGy7pB7FnWrLI3NiWkIqZHsN+9h9LMgawvekJCs3qa?=
 =?us-ascii?Q?J6jLqL58FO7wystpN/3W75a5P0A1b2pUDtKyWvH6wxByfeT7LexkN3MSheWd?=
 =?us-ascii?Q?G37qfYyVjCOH8N/79qc8yvIyG3RObEUgeiqw0Yw/uhPw1uLtFWJPwwcopWKz?=
 =?us-ascii?Q?IBgC992doD1rbi4yTDhQN08RyMNtXaENOTxfSw26K53xX3Mkt5HUesE4Tenc?=
 =?us-ascii?Q?mP0+jhmdkLlAGd7HeRbZr5kQ2AZUH31ci5SaXkSrNFUqP3n/8a9gf/UovQTL?=
 =?us-ascii?Q?RAyfo63jPzyueGcPfRC2DTq/JrYwxBcm7GPeK7aAxIjCJfsAC6AsvRpw0ZvJ?=
 =?us-ascii?Q?D5nDaTg9AE9qWnSH6KOXKrDVhtxLG/NCvfqbJhviOdK/lEyXPwxvOYKSY68z?=
 =?us-ascii?Q?42Dh98+1sEjUJ7MCZcqTyaf1rnsUQIH0RdlfweI1txUrCElRoP6BGrWaGEil?=
 =?us-ascii?Q?v+oqnFy+S2SUp/nxQ6LxkQnk00w66eCcSUYh2Ov8T5f0SNFpNHr0N4zwp1dw?=
 =?us-ascii?Q?FOqYiorHitWBsQxBBgEUCVRjdnOwqOifzEMAlOPC9CzBS3pC2DBKIpkYSHoT?=
 =?us-ascii?Q?O7Ns5Jn0qf0F3twyv3R4SJvSOlsYkGV5Gm6xAQj2Hws0Qsl3Q7apLckXlk/m?=
 =?us-ascii?Q?wD1lZbQEbw3VOlznFxazK1BldCP6+zETW4D89X6gJIT/tbKMKANZR8kgSZOy?=
 =?us-ascii?Q?OFhm7WIuecj4AekhSfPYNo2hN88w/BFOt9qx5lLWXkgqp3ue8+cTGwmCkR0j?=
 =?us-ascii?Q?rKDGh/tHhF/6oAJOzXUSGrsQB2DiWNOEhfNtSaCSAFC0tw1umYOiTK7gCURE?=
 =?us-ascii?Q?ZsJ2Tp6wxATqQ+lGTOillMgZVlow4PspH6Hg0Pb4nYm1oU2Ki4s7Xyuyb0Ar?=
 =?us-ascii?Q?wjGm+wIfWut54yl+ndMg4BcNJqOVbmAEsmNkGf5HAHolzpctEhQSr3QsE9F4?=
 =?us-ascii?Q?GNrRDv+JkxDDaQfW+bYM0j8G+8yFW8vlBzneMWul1PAKDDzzjBbvzarGPA1f?=
 =?us-ascii?Q?xdBV4Rt53dy+4E/tPMWm1O3taeLBzTeN6pQU1pCB5oMgBCpXgIKYERtXAwNP?=
 =?us-ascii?Q?KeXmxXrCUjBaMEbzlneLlGvCL2AAITbWSg6watAV7w3IrGo6ESnmCJzcr8BZ?=
 =?us-ascii?Q?70w88TisDitHFCBkp/Ie/DWfWyulit81vKwgMBdncdapL18xqCQoTkhIGVX4?=
 =?us-ascii?Q?Jv64DHvJtjZj453n0nj79ZhjShX1U0bPfs+YVOmpplrtdy389RFTr+N/pQm7?=
 =?us-ascii?Q?gvG4fFQeWmor8lBfOQ1y7sTJMdv2QwOeeRx+logIVSnO9ZO/S0g9he9EUXfA?=
 =?us-ascii?Q?gTChXiOeQKddktDvr6SkgLp/dn9oZCZa6WO1wvspnOPiCKD4P7/nQTJpn4+y?=
 =?us-ascii?Q?RRVXysm86UGNmYzOmpR+RjlI0QKc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyZqpnqQuHZ6FxCE6io/hJH20N9u8gWC1Cnq4fs0scsZmbLI86kPGuJvn0UM?=
 =?us-ascii?Q?nfAZ7EhrNEC82ChnzRnj3WPMhAAbJliN1XWV1ImPij1Y9IZwda/2HB5kN5Dw?=
 =?us-ascii?Q?L1dPgaDUxltWH1vYuSYZKoR6Yzf/KHsne6JnMP2zubbosew/A/O1UIkTVmzu?=
 =?us-ascii?Q?i5BucR2yE2885GexfUIg2aK/3m9mqO2x3J1hN6JyxXPWdVhR6ZWmR+jOawZ6?=
 =?us-ascii?Q?eYJQTh4IYQGc1Jx5Koj1BzdwP9KLW57thljitr0XPyP1FCndVRBzCylbodDp?=
 =?us-ascii?Q?IIdfM7B+PMKQgOCFSf6Ukvdb0/Fg7uIHlMhWdUaGnk+VcgMKMjq8MXh0QbS9?=
 =?us-ascii?Q?/aKBV/GoZzXnKEiCyKbwVdq10DIL1byoP4D9IjFcUwb/n7gtoEM7GIbNN0Dz?=
 =?us-ascii?Q?ii02LKPOu1x14T4V3LXIAolBMkYHMVVqM2d/4rc6b3WDTAMQvjhexnshLRG8?=
 =?us-ascii?Q?cFMkf+orjaXTvaTaE1MgSxgbs3P2Vj18xSlOoQFA0Bk9bgVGkdZ5Tk9nvQ+Z?=
 =?us-ascii?Q?RKetDLFaOhPfwVUnV8v/cQNKR7apyoI/SiThFFebYXKOC4FuQiKcUdgYF1+e?=
 =?us-ascii?Q?H5JgRZM9ggyPWYcVzcccSutJT2/piCOTVGvEycUZCgyARcv91fki+7hzdrRs?=
 =?us-ascii?Q?Q7+4YZlZLjhc/hA8hoihpd+9inZIrG2uhirsCNSSxjvpIa2e8yvZoqElnst2?=
 =?us-ascii?Q?0z+ZLY/JZKlZWMI0AH3uAuFXaWi2BPTjYbffPpIh//Z0VZEE3qUqnFMWE9V1?=
 =?us-ascii?Q?e8R1OMhUU7+obph3VblL/72cBGMxjIFQdN5bduYmD4gZyftFC9BrM6bVeOr4?=
 =?us-ascii?Q?BOTlFUkM/9psBbMaOX+Kwo2jtwO5BoNBZglPaYQDrcOhtgXvhoIt+Uvamn9t?=
 =?us-ascii?Q?d82tg2cNdT96F23lrczpPxYwFPeZISvD6xoldbMIi1m+/AKE9yPLYL1C6/Tc?=
 =?us-ascii?Q?H32N4XXr5HLP5c0dniA5tym15vJLylmd45838gsL0Rt5nr3bBNBoVXjU7cn1?=
 =?us-ascii?Q?fHaVAcCFvvA0bOarUBKBAZbQFSyIxP76qHaDNv27rDdRIUOtcWJZjXe/PYyZ?=
 =?us-ascii?Q?qFDH+QtuX5HfsW7bJAJ104WuCeJg1iAJQJ3bOyZXUAuhUFLbbjpdA+4kRR/5?=
 =?us-ascii?Q?fVMJZ58pTjP/I93SVC5rg80w/cWRqumxm/GcivJ6gMTilrBqszDN60kLlnoB?=
 =?us-ascii?Q?E2p//S+2z2Mld22zSEDTEnHDj5MUfSKz4UTgl8/gp35Y2JJ2qn4HE49dAHMn?=
 =?us-ascii?Q?cR+5JD7rsQ5Nec2dPT0Lpik7EkHTmh9KG8xCExQ/sG7o403y5yzD/g64KSHT?=
 =?us-ascii?Q?Av5vl5H24NvBfS/A7rR1fPeznTxxcQ/pDmiOT5C9goVo7z+WaBA4V2xY92ne?=
 =?us-ascii?Q?/sTHXa9QD7B0cA6nDgQbf2ZRYwMW6unyUFDM8GE4BloIbHenQ6yWwqZUkple?=
 =?us-ascii?Q?lcsZIgiTOLP+eMQwx7LRGAMVmlBeLH8CFoOWkJOIy2HVdHLnNbtIipRK8Jgf?=
 =?us-ascii?Q?Inj6Z5W3wux6yW0isor/bsx9ir0y3pboHMk3mpOqBSm/iv045TOUsWeKaDKK?=
 =?us-ascii?Q?VcAiNEdHSUBxYSDETAKsbniO/hPij2BLpU6uM/Qb1VevfOrrM4P2a/9BepuD?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f1918-bc5e-49ee-f657-08dd3be82794
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:57:24.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/F2Vp4udJBOcViEEOEjMHMMsUxbH4K8m7gEk+7ktgMK93veiWcZogKS9oHOvhgXOADyxQtlz/PAv8jpbPxdAlmz+8a2/8zXFKKWEVswO7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 1/22/25 8:59 PM, Dan Williams wrote:
> > Dave Jiang wrote:
> >> Add the basic bits of a features driver to handle all CXL feature related
> >> services. The driver is expected to handle all CXL mailbox feature command
> >> related operations.
> >>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> > 
> > Does this need its own ida? I expect it could just use the same id as
> > the memdev, and that saves some potential confusion of which
> > memory-devices support features and which features interface correlates
> > with which device.
> > 
> > ...or how do you imagine that working?
> 
> One of the issue was that the feature commands query happens before
> memdev is created. So that ida doesn't exist yet. In order to share,
> we'll need to do a split initialization of the feature device. But
> really I was trying to separate the association of features from the
> memdev as they are independent of each other. i.e a type2 may not have
> memdev but have mailbox and features.

We could do what platform_device does and let the id be optionally
auto-selected or specified by the caller?

However, I think that's a can we can kick down the road until a Type-2
user with a mailbox, but without a memdev shows up. No signs of that on
the horizon unless someone wants to chime in to the contrary.

The Features commands of most interest to date are around memory RAS, so
it is likely those will have a memdev. The Type-2 series from Alejandro
registers a memdev for example.
