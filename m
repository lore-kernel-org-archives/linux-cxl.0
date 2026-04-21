Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73B194C96
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805356; cv=fail; b=KnLcFwuT+csJZClDOrP2MGF5CR3ke4HPMZy/8SdhB9DL8uxv3nH7Ed6UaRLFvKpEliTdP2Dx+gIfaeUcmmyEHv4K7/hB7g6hrPXyxbR+D0RcWawwUEmo8UmG9bW6lDK3e8A/xW4tKHjQBvDnXIdhJkEM32MDCykJh/cxPsMJUWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805356; c=relaxed/simple;
	bh=HMElnRXp7SEAK8/drVy5eEJIWmRfMKdPbavYGiCtAVc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nc9DKEnxPdl/HyHIFW4BczOGB3k9PMpj8WYA3ENbOlsZ/9U2qWzFDOt+WJhLoOG+jPSkmDXFfb+f8tbCqw/MpyDNnH+CeSKoXDbxkUowY0iMy/0445aL+tqLWjKOMjQiYk87an/JumRwDex739X4/i1EyaPIxgaU5G3oAFGrfKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M33Q93T7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M33Q93T7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776805355; x=1808341355;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HMElnRXp7SEAK8/drVy5eEJIWmRfMKdPbavYGiCtAVc=;
  b=M33Q93T7Sh0dLAwky2jMH0fs84pYuw57Dcu8VLsouOBnuv2mQ0bwedFQ
   viz3vWPAltC0r9G304nJWm+OvQJry/O/OudSCvhfqlng0J6/1D3OyF2k1
   hXfW8aKV8CYnrd+PfRmfmU9m84U17gQ9YN9uYai0wzaojUI7zONeOudtq
   nT4XVMrzHTyZ1QY6t51T7jy0hG+UHJx7DyI8DYtKHX6vQnHuLjZPGgLj1
   d7ndzENAi/niY21043qPaPsf2CXkOqCsdzY3Jkj7xMbdC1R69zR9uCgyC
   uUFdToBHGHwjptLzCO6UYT0pLt8CiqfYAbH7Llx9cTa1KuwOGFFJ7fwoP
   Q==;
X-CSE-ConnectionGUID: 292kNJaQR0mZ25xGkJdAKQ==
X-CSE-MsgGUID: rsd97E2cSFKG48p+qX35Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65290354"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65290354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:02:34 -0700
X-CSE-ConnectionGUID: 5XhPWokHRaCP5SxKKSbB2w==
X-CSE-MsgGUID: fdQKLV7zQViCgRjjXmO3bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255615181"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:02:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 14:02:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 14:02:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 14:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw+a0TqYBdPjB0VhwhwD2/NJCplltx/PYmEypO5Ni+f31ARBBelv79s9ufuuxaruafUTyCp4RZhYByDOXdHzm9foYEJ4e7tTZfRr9OI00GuribbnTiAC0E4rGNN61G2dcRDZ8WWcBUPn1oayaJmB5DytsMz6Bh3WPT23cpHdb+UaRYt6mu5vvoc9471J1JBwqcEw56xiWv7PeFL9uyX2v+0qHRcDj1xMvE7ZWUyRlDpzU+992yyDeTzhPGtF4HUZqb6C5YveuqyY+xgE36M8aKcA41ya00cQlDSGE71cs6kdB0RKJ1bnW/F8f/G2RfWjjSlGA1YhIHQRhEaapkAHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju6/tNnDRcwA01VlKGogc7o+v2Ipn97301nM2lIznBc=;
 b=brJ5IsbA9Z9pbChcOgU1ekhKI5ssLaIIvO8T7fYhjeHtu+zOVhn682LW32qFzriB/cTI3Z3UiqQPUB5dr/DKg6H5pGzR6BWqXdBpLJrgJedLFQtxu5ssl0sIuxFOP9zbWwve8ES5J4m9lOhzqMhnHTdhjFXsnK1LeSOjn1wfOYcUu1P7X/owcVCpWzDBCPhjKaWs1IYL645jjWNwE/GpL/2t55b09GsiAuEQN/OQuYSvF4m18KAW4nifnOuWrJsXT1tpo2U2uQVxSy3WVwx2kFtNAIgYvD5yJw76Kn/Z5fJxmLFuKll1W9hdb9tMytmIsIbhlGfLphmXRq29i+UhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by DS0PR11MB7285.namprd11.prod.outlook.com
 (2603:10b6:8:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 21:02:30 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c%6]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 21:02:30 +0000
Date: Tue, 21 Apr 2026 14:02:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <john@groves.net>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <aefl3_heFBu6iGe_@aschofie-mobl2.lan>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|DS0PR11MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: d141687f-8eba-4d3a-f47b-08de9fe94d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18096099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I2a5LIIGOios2yKxwLocIvbrakxqhcVflUIuhs5wisHPrBn/s3npzd6tWFa319eY/mx/9poZ6CSpDmF3X/JJfAZiA+94OZIeOUSe4FM6Zv1/9I7jft2bK6a2TTqF1VBaqccTMSeqWVCAhRotU3YCvyebkSIDMMum+XCdOcvCT+Sqqk8Y4pPjsXqHf62KUpr5uiCNHQXYFNmRr2Z5kSPWw6tuXpj6FxhQ3vu/gjWRENLgS4IN7Kv6lCMN/+ph2xxGC/OZ5IjRFXfMaNI5uWHg+vcc6hRXxqalVXapA3k83o6XICuQ9MWpMDnrDXrIJBzC24x/ZbmaKjsPKEpWLdNyYUNEu7B5BCCKVLbUTEDrDstZmhVzwKdevmmrydC80gXorRhQc26L5touOl/jTRQNDfXjID6yFPv1eE5nagjVwoNDUp2D94qWDoyg7FemQattDo3Obnv7ghois62TTUVOETIHf8rwcJ/I0gt+Bump0Kh7u4U/5VTcZjN5F+OTuPvl3wilJ7I7Ze0PTjN6+IRGtPHsKRogaiL6gHpMyZkxBNJC/OnOm6fA7+BiNUC2CNF4O7EmMmNTIsZdANBqxZ887aBwx4b/8Yx7pV3BQqWpO5/TKJVxrV3TbkXq8pb32M7ZNdQV9vy5N9TbWAASkjo0rR2oRSZ4FIKp/fajMoGS33aV/N7DSjYmxhcAqIBkoDuGivCV7IDfSSKJli5wwZqwYvr8u6O8v0P10Mg3omChN1twHrGOfFGzW1pcSjMBisQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18096099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hE5ZqygaAY7BBqOMd2WHt/36d6ArcXraP0c5C6qmoHXU5ZkSFqph1hfrsZMP?=
 =?us-ascii?Q?ivwrpuhsWMOSYfKCoMp+nsyhFUNnXM7TuWxIgbuTIcePhOOOHp/PWvlwGpuK?=
 =?us-ascii?Q?57pd2AMG+jDCP4UYG3K7jwYh8dlvtuGTO51MtzpgzTVItQ2/CRPUtDjDgK3h?=
 =?us-ascii?Q?r94qndjnoFzdatUfW4nLaDJ84Stvbt8DN80VkjBDsmXzfTErhmuarFbnBy+x?=
 =?us-ascii?Q?4B6wEooVGQaIol91rdyg0kbKn5Ci3eOH8W7RAOiVKk+TL7VTHzJ2FX/NwZ4L?=
 =?us-ascii?Q?h1lDM7u9NbElzN1JMZ/lrTH1CZor4LcKG7ONCuoH4A0YeIenJkb5v+Wg/4fs?=
 =?us-ascii?Q?1dGC6muHvoWBPlvSHdZY7a5PKgUXW4lQqJJt8BWcTAewPEeyMpnSCct6n1kR?=
 =?us-ascii?Q?V84QoBUEM95vt/8r7SkkrWRCzxRL8/6lnbKs0VQDeYhiyzRPnj7sth//zVYg?=
 =?us-ascii?Q?VaM4C6obYFZATD6pxevoLoPf430SR1/PLpCTeGbg4Vuh+e8ti11zUpgWMacx?=
 =?us-ascii?Q?z4wnqendCO9tSu/ZTWP0ctmVJXEBJ4km3EEFJGE3xUEjEHGTUDZl3zpYxy47?=
 =?us-ascii?Q?qEWMOe6yAuhtxDRmwBtTKtxJvHqkZJK2Gz4u4YuFDkDu+WyME2vLQQc08sU+?=
 =?us-ascii?Q?odWhsZ8L8Cw0xjQhldEyPJySIgoc3sVGWbwhZqNzm0vpBHl/vL6/fn+1axVK?=
 =?us-ascii?Q?x0HnNaDUQkKqYvcI7WQTM8f7aAgJLcL5yPC19CMGKwWOdCvz/6bB2KNmdU8W?=
 =?us-ascii?Q?Kl6uYYyJrUtCWoJEY1t/RpfoUm5KTGSvhgsB2uicVYLE4LLtGTZcr0Ntx+7k?=
 =?us-ascii?Q?8VAV0IXW3TbIu11b2brhvR9A5FSnIHElEAyDNop37eHcc7iwbYt5Wo+ma+mY?=
 =?us-ascii?Q?58Q8nbvuLc8e2tE9iSjVCCd44RDVoUJFsWOcM2fbx2CH6AOKdagEOrzV8GzZ?=
 =?us-ascii?Q?4PiH+kDWdiQn38lks0CKqmhV41fBo76Y2eKWTRdwGo87HdPJmj8vOS0xHBEK?=
 =?us-ascii?Q?iUnDpUoeaCFugI0UpXm6w+AHLnSCCK2uJXlfaBWYMvDMaBriQO2g7Xayr4xB?=
 =?us-ascii?Q?1KqoFWQgowxJtz7B16s/m/XQRnBH4q+SmHblrzoMmo4DmGs67P4k/VwYVXvp?=
 =?us-ascii?Q?pa9c3NGfc9K4GvIfguENXrpMfh5HsG2Vv0+bbQQr0zNnCSobqPdWxvI6JScy?=
 =?us-ascii?Q?8UoEz8EAE5zvaWixMqpo2tJinoQr51NY+X+grkPYBekEgWGJom6O0oscgJnq?=
 =?us-ascii?Q?4wpqxnZdfKfyxxW41TuwQ06hAoojJlzV+WcNYhCo0IL4SpmlFFPu/Ga6UE6g?=
 =?us-ascii?Q?pUik/iNXzIUkeGPekBxlOIx1/evVkKh2lqXMWcNQH+16M3Cp4f+aTQ5RfC4H?=
 =?us-ascii?Q?4ABPFWxgYNaac6bivGwmJfMqSH2Q5gjNvtu6mJuV2wvML3nS2b0exbZqbQvT?=
 =?us-ascii?Q?WSOVYdJCrmHCpnHFpdIMeL3I7tCXBs77IugywcOd49IJVRCH/NQpEWPGUH4Z?=
 =?us-ascii?Q?9C7ZwjGepV48gqK+qWfbhDkEq/DUDwd9yyIO0imNB3aEWaKrrD4m/6AdILo9?=
 =?us-ascii?Q?HdtdZHSSawCdzEnJVz+tPJ1nuNH1o+w0ykR+5EikJBWUJa/ke9MYSAWrtJ6B?=
 =?us-ascii?Q?WnoE4I06uHpcEai00SLyHyehsJSz0qSrBU5UqHd65rEQ4loDt0qsBNfq8oyc?=
 =?us-ascii?Q?mFYjuEzaOyxeRiugPSWb9yNWaFCTSQfKhbzkm9EWXoQAY3gCl46ASiozPTpX?=
 =?us-ascii?Q?wyMLafbGW0D0F5ICSJkFT4qpiYqszKo=3D?=
X-Exchange-RoutingPolicyChecked: WbzGsnfJh+UCETYadcaH/RNuI6IMiOYahehcJW8gj7F423jKtEusDRX7l75CdgdkIQldnZuix/mkUa+YWCqrPkVRhaKxHUEa8HeauSBtSzJdc4lXvaX0mh4OIxFvyQbhpowgB2FAQ/qEJdvv5ulFW31CmBxB48MTv/ZekpmotBi2efV6BB7YTOZsl7f+rAyGgHmrjGqIgmEIZrFqRcnnsIrGfm1yF7YF870rgOLsiqklrPJYbACwY3xqAaQzOy67eknnQA2Tbxu7K0L3igNbN03eKisgyRMqqMeNXV78Xd4362UQ4e5Z9fI6P6tkmEbIy/ohGmv/ZySYkzA6tsMMTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d141687f-8eba-4d3a-f47b-08de9fe94d06
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:02:30.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml8hZ2faLNSEiOxQ5tJ2UX8c+ggL+HG157ev0S5845FG90EPj2oWdcxFlSHbFep0Rvmydc5a/+/EDy36HqLP4lzaQWc9e3AhIyz/bbxnV0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
X-OriginatorOrg: intel.com

On Fri, Apr 10, 2026 at 06:22:55PM -0700, Anisa Su wrote:
> This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> support, which are the requirements that I've understood from the community
> meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> greatly appreciated to let me know if this is on the right track? Or totally off
> the mark...
> 
> Everything is the same as before except:
> - extents must have tags (uuids)
> - 1 tag per region
> - regions must be contiguous (no more sparse regions)
> 
> To achieve this, the main thing is to change the relationship between
> cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> comprised of 1+ contiguous device extents with the same tag. Contiguity
> is enforced by sorting device extents by DPA order. They're re-sorted by the
> original order in which they were sent for the response, which is required by
> the spec.
> 
> Once valid extents have been collected, it's passed as 1 contiguous capacity
> to the DAX layer via cxl_dax_region notify(). Once notified, the same region
> cannot be added to again, unless all extents are released.
> 
> For release: upon receiving a release event record, if the extent is within the
> bounds of any cxl_region, and it has the correct tag, then all extents in the
> region are released, so the "More" flag is still ignored. Not sure if this is the
> right way to do it but it was the simplest.
> 
> The changes to the DAX layer remain untouched, as all of this extra validation is done
> in the CXL layer. And since FAMFS already takes care of the devdax -> fsdev conversion,
> there was no need to add anything there.
> 
> Most of the series remains unchanged as I've tried not to make too many big changes
> right off the bat. Only the following commits were modified:
> - cxl/extent: Process dynamic partition events and realize region extents
> - dax/region: Create resources on DAX regions
> - cxl/region: Read existing extents on region creation
> 
> I've tacked on 1 commit at the end to change the driver type of DC regions from
> DAXDRV_KMEM_TYPE to DAXDRV_DEVICE_TYPE so it can be bound to the new fsdev driver.
> 
> Also, I've documented with more detail in the commit messages of the commits
> that were modified on what exactly was changed, so I hope that's clear.
> 
> ================================================================================
> Git History
> 
> This series is based on cxl-next, with base commit:
> 3939dba00f98 Merge branch 'for-7.1/cxl-misc' into cxl-for-next
> + bug fix: https://lore.kernel.org/linux-cxl/20260411011137.43545-1-anisa.su@samsung.com/T/#u
> 
> GH Branch: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-rfc-04-10-26
> 
> It doesn't apply cleanly onto famfs-v9, although I have the version that's applied
> onto famfs-v9 here: https://github.com/anisa-su993/anisa-linux-kernel/tree/famfs-v9-dcd
> - famfs-v9 for reference: https://github.com/jagalactic/linux/tree/famfs-v9
> 
> I've tested the current series without famfs as well as the series applied on
> famfs-v9 with famfs.
> ================================================================================
> Testing:

Where's the CXl unit testing...

big skip


>   tools/testing/cxl: Make event logs dynamic
>   tools/testing/cxl: Add DC Regions to mock mem data

Hi Anisa,

I'm inserting here and referencing the last 2 patches above
that add cxl/test support for DCD testing.

Let's use it! We'd really like to see the ndctl patches sync'd up
with this kernel set. That would give us a CXL Unit test 'cxl-dcd.sh'
to run on each revision. 

This is one link, perhaps the last to the ndctl set, but I think you
may have posted something long ago too:
https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/

-- Alison

