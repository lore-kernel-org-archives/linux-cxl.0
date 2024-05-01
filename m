Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D101581E3
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606043; cv=fail; b=LPw27wQw/JVRjLtdByHFYisLWdjFMlwswsR5PXdVEjw5GZsXtoN9cSoaOnZbvA7fdPRetau0VPY0nNISzT4dvdB+3DW5e4umV88HvUQEpCKn1uSMEbcT0WDTsPYAi5HleLujFy+qojfAWIfUOM9DGWGE7eKtH0xXWRw5YC2sXDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606043; c=relaxed/simple;
	bh=cTF3qGbDu3YtTIXZU3K8uwymnOTd8GWvSkokXM02tKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6rZ5e2smZMiakpcPl+z9nyGeEAYRhjBl+HpSyt6DP95K3aH5yxtU8rpCZTVuPWmIhmLw57wADgUGbukptze1k5TxWjEc6fOY1YIG6qk85zDmFQZ7afO0fioE/xkUdX5rQZeTalRN6G8CmZ22uK87sEJLc7CnmMenaW1laWR40o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrOsF6w+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrOsF6w+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714606041; x=1746142041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cTF3qGbDu3YtTIXZU3K8uwymnOTd8GWvSkokXM02tKg=;
  b=LrOsF6w+/8Iq97J7Gclt9OssIiMf3dEBrIiFE3vOLL0ESL/l0gO/nbuR
   alDfoS8x8DxOQoVTlO1cwU0QRTWHwrITjo5BJbzHi8zqc/PfdmZPA37Xx
   l8Ue+K6H6FWOMKk6kkxht4rMKWXQywetK+tjorQDxDMdNzzi2RrwBFA5X
   8aUEy4ZxzFfUeFut3RMknCVtd8Ws1KLeEiUkZN1QlIDT3/SkOaAGLsMqn
   Kf25NrB2JMlcT3Attcihnnjgum6d7R9yzrkWBWDIE1rmgYPvjZtOU/GTY
   vUgj+TbAtDdfY5e2Lyczhm5RcAoeEur/e7jgSR5OVy/kVr1LSKVCT5vBq
   A==;
X-CSE-ConnectionGUID: aUtiEl19SWqpj4BGIiHnoA==
X-CSE-MsgGUID: f4hVvcNBT3O86GSEJiCQRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10485703"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="10485703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:27:21 -0700
X-CSE-ConnectionGUID: QBq7rVNOSsiu4t9/anqtgg==
X-CSE-MsgGUID: D96OV54ZQImYi8D6feKczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="27438204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 16:27:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 16:27:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 16:27:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 16:27:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 16:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXOyASZH92xbLm2a78NecqaA4dBJV061jIGL7UHNGzjYkgDSKqgtN/gPo92kpI3+jN6/cNDQm49OY3Tp1rbWxuJq3pklZthnJPbzmXaDoG1o755i0OTuiGhFJ7+BUMTkQkFpe0GAums42n6Jswe530Tzk57crGz702J8dFPxEBGHj/4/AGAW18njg8FIVxNwv7FowvuvxsQbT4TKld3WDiGBWjkeM/EhORACOWirkg1bmWSj870BwYPMWBZ6xyMOevtH1VfALg5l5neNsB8ssEaH6Bzp58kCwvftInANOeL4XxcdxzmPQN7I0ccin1h9+DuTSeDSuiUj2zaXl7Fdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsdA4lrIG0irCx8c9U5WD/VXcaIHD9YekdvUrlkHDOc=;
 b=XP7ohn0YggjPbqlV1C/SnHoi2ogHtVNFDudVIMf7LjSqlX8eU/s096lBQCXCxY+aWBVbkg4ShOQfr22AbCqbbUETMMHQe+S3Bzp8ZyS1kcoVZnONloBc5yqrDEUc0xCtF+N8ZC+l0aEICJbEBsN4MySNakEMVJpEwV2hg/TVGpQuEEieDw9EQdydIiEJm4QwftNpyf+jNRb66eWqHQ0FybDUFej6TuB32NIFB+c3goyjE8kghaVLP7UZFN3yFsiJl08uGq1IWFzq8vaiwHDvec6HdOL0jz1ujsPhhkdGBufotHK51DD/29pp5tojtWX5Vpjw3Zj2ru0jwWEW0dE3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 23:27:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 23:27:18 +0000
Date: Wed, 1 May 2024 16:27:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to scope-based
 resource management
Message-ID: <6632cfd3b6e93_1aefb294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
 <20240501130251.0000265d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501130251.0000265d@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: eecf4282-c4a4-4cf9-b518-08dc6a363ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4UCtaXp5NYlJtRX48GbNsa3BQ/D8WMyVcUVa+4D0kgW8A1esdFOQ84LluIA?=
 =?us-ascii?Q?ripEs8wb5tRnPOF1eIkwwta6g6z0eE6VeMc8Guq1R3gKp3OPFKg8Pw1Tg/x7?=
 =?us-ascii?Q?l1FcUBD/b4cm6uOKB8/OvBzZJa747pN+qPDcREYzWryBEudtFD8coFzZyKnY?=
 =?us-ascii?Q?xsrEQyJRIKwMQzLTKT92kOHbK1MY0gP9xBPTgCITouIds8ugvVBtTpKqhOr+?=
 =?us-ascii?Q?bZMOnt+1jOwGoVlAuhF9ZeXTFIJ5ZDqa15znOBa4kQm1b+xN/C/0/5pqFGdh?=
 =?us-ascii?Q?WvIXisapemYpaR3ogXu2Tkx4JDKP2fq8UH3RC0F9lqlNAndGAW31ypcAGPJJ?=
 =?us-ascii?Q?UarKwcM8UNJyOaz6dqO3vWYy9jFgUMZv/wqqY+bMYb0ImWFNee9fMexoLujC?=
 =?us-ascii?Q?8TWxdfM6lZS0xS+edAaUp5pnmthh1jPaJdWDDjVmmiN/rhO1Ljim8/naHAy/?=
 =?us-ascii?Q?59/YGNKrDmp/fD4qEDPJqXGWJmkArlDTNKeMRbxyD+hjocPHrHlf7BCbvdGB?=
 =?us-ascii?Q?kQcf9gXWQ8lIGZIavwRH7MZNUrnS6oEC9fMdiy2D9rTX7H/SUGI+Vk2r7gtD?=
 =?us-ascii?Q?C9bY70gTW7BgEdIQwHiq5pNeQp5UIaNil1DKnwvZC9M+BdsfmHzZNLufp17W?=
 =?us-ascii?Q?GEAaMVz+9xTxlZr0W5u5fcWMceqmEupv9OcIEZ2qsnjI36mn/G6dOitMlnAu?=
 =?us-ascii?Q?eLYecre62YQG5p54R0niN1LzuHRjpeIYJpGfk/i/KPRff25a6fTeh8QpnVX5?=
 =?us-ascii?Q?Jg7Jyw1uBhZAItpSDcRGYidXt/DzwfuP8uppJ8+msmWRvDnULZJ09ULcqhye?=
 =?us-ascii?Q?f6cTP4gV2m5Wmpioa5Ws1gw086TVR9lJAuVxtmTFl5aGYO2KeHlFZ8eTfcw5?=
 =?us-ascii?Q?NyJlK/x2gmb+k5j7+TyGfTNfSZRdWoHvLC7aH59z6/bFrYTz1T/m/L4OfN24?=
 =?us-ascii?Q?c/TcZTBt7YO7ARjBFJXPknhKORuUbZGNV3L5hNdX87YFymhMos6f4tQQ1R0j?=
 =?us-ascii?Q?tm/VZqrIAqcAmP6oZQIO6X8jPEb4sDlO+sVTrXK3vBbzY8k0aoVTNvtMKT2y?=
 =?us-ascii?Q?aeXaozolrE7Dy5XUj6UehbLEAXEU49yeDz8rIhSxb5TvAgMreRN09AumR+HY?=
 =?us-ascii?Q?gfgzBhj8ORfcf8HGbCWxiifIevSBVoju57Hi4uzD/of7AuuTdma5BH+a/kbo?=
 =?us-ascii?Q?96zDNrZdD/7WR3RCANzdrVB8UTYWS7MQa20mhNOSKP75g9cJSaY8n9S2YAY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kzp8eOXska8kkzysJlZTSpGWtUY0fc4ZXMvmhBzAv3+pxSCmBkwq8T8N/XjB?=
 =?us-ascii?Q?NqwG36fWw5B2Ey5zd5qU18NQrcwzyV+F5NrC7AHEzpC/6LA0i3vyZeOoIn73?=
 =?us-ascii?Q?RI6PmihJfkud6gnk9EMMTTNzqsuDxUIroitc+Kw6mkCrxK/7t9/k2CNn3g1i?=
 =?us-ascii?Q?lFzb1fI+LUcg1Qvda4xPnxlusnY5Lhy9hJFBvauH9433mRNg9XMOdHHDNFiA?=
 =?us-ascii?Q?6V1wZ/jBk2Xo91zyIBFEHCKMtJ082RrAOZ6C4pcuaYNuMHDZo6IImCDDuMHS?=
 =?us-ascii?Q?k74nrzZSjmTLZRLtBbNergGakRPxnYGGHDd2tNoCVjN3l37LQKkNmYgUiULf?=
 =?us-ascii?Q?iPyA9hG1mOl7rRJQiunGoSW/Zz7I7YkbA/jrvcCxkkL6fBiUGQFd0lxAuOTc?=
 =?us-ascii?Q?7afKVMjnmHwCR6fhWD3hOSCNg1gOQtDdfGnNy8QtMxNEyfD4ZicnBVtDzpo9?=
 =?us-ascii?Q?bBE+QymseUQQheWOBFOCIW92DL4/E3aIRpbP1a9rr6NwWTSx+W8i+JOTys6Z?=
 =?us-ascii?Q?AbLuw36Yk+XafmJNUYunf+9iG56+dTBBnadjJ9DqVz0pTVrlCWWUpTMeooby?=
 =?us-ascii?Q?gKb6wniZZOdW+1vWUjgGUWsBm9VT/rPiRnnncNowmtYcHOmakSGEZ45PYaVK?=
 =?us-ascii?Q?kQWIQW8m12nxBzFy4NmtYkxO8UBAQtw8PwANA5auXkn9pTsTPUxx9nkEfbzJ?=
 =?us-ascii?Q?ZXJsRUxEZRTj5NT1d3fhYapvCYfhnD/iScU//IqHCbv+KYVDACf370ZZLxm4?=
 =?us-ascii?Q?M632STf6zOlbBAWGxWQCPV0k9uRITcDL4PhWMCIbyL+m0KUEf0hJx2bva2KG?=
 =?us-ascii?Q?1sV3/ymGomzTuV+3RZJ1HgdcHEuF3OBNEfvd6Gp3gmklJ2zl/QDGiSOfAxld?=
 =?us-ascii?Q?Nv93mkyJnEkFTVGPyQJGuyPkB5VaBoxVx0Rwc/KgIOzFC//b36314u0cwJRD?=
 =?us-ascii?Q?E9p3D+GVBCMuzDIYKyUlUIQ7h72UIlCHaZSQGYImc8ZWR8h1/PjLtWStEQHf?=
 =?us-ascii?Q?ia4A8XinBoTprnbb0o++0O4zgvUBwgzk3UoZ3YIWXbwZYKgykj897zOis33q?=
 =?us-ascii?Q?i5S7YR0PSxPVaLzWrdl1WtT4c0tkw1OezyTnyL2NWtStv+UHnZXgqETe2Ket?=
 =?us-ascii?Q?1wwAzIvYdjq3gf/GOPIepW3VrTJfqluO/MEhEB2/uO5PrdxO50hh8mBeCzsH?=
 =?us-ascii?Q?IkP7gfhSb6oyrmhSrYQq2p3VFqwXEDeQoF+9t/hu5TrQKaz5vjCYmp5M+xMW?=
 =?us-ascii?Q?c+Zg76JittWNF4oi3Wriqw3NsKI6P/E0aLcVXvAi3CgpSRMNkdSXEElBfdsx?=
 =?us-ascii?Q?Rl76OYgAZSmjCe4lkcfVwTP8zTvNsxvH5DFbO1JebI0AhZszze+qRHkiJ99k?=
 =?us-ascii?Q?PsjNc+V9iv9/jeG8458EZy1BH4pOVY4yk1AQNbAVBsLgmY5cSFtNS4uznR6C?=
 =?us-ascii?Q?SP39p52QOLAT7Uahs9rJ/C/roRv5R/Fg1fFPxpr1t8OdW7w2YD+JnsWl4qWc?=
 =?us-ascii?Q?nWQ5MOa4DTlV0NrJlnjm7cKsCmTIysvVgcFRw2p0NhO4SNT+XdlKnWJUXinU?=
 =?us-ascii?Q?L4NpOsFHZFeu/5NU3KCNfXoiPW3c9EJNXPrCBPkCMt7gf3c/mQK1uVwm/zsT?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eecf4282-c4a4-4cf9-b518-08dc6a363ddf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 23:27:17.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqaf0WRb7lc9aXJcVExiH8kOJyFqYEoAAIuy5WO+z7oKeakETmvVb5QRLsW/47hSwb8KkB4Gixq7qmLPM4UoiAejuWfIbPl0nuPT7zAh8cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 30 Apr 2024 14:59:00 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > A recent bugfix to cxl_pmem_region_alloc() to fix an
> > error-unwind-memleak [1], highlighted a use case for scope-based resource
> > management.
> > 
> > Delete the goto for releasing @cxl_region_rwsem, and return error codes
> > directly from error condition paths.
> > 
> > The caller, devm_cxl_add_pmem_region(), is no longer given @cxlr_pmem
> > directly it must retrieve it from @cxlr->cxlr_pmem. This retrieval from
> > @cxlr was already in place for @cxlr->cxl_nvb, and converting
> > cxl_pmem_region_alloc() to return an int makes it less awkward to handle
> > no_free_ptr().
> > 
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Closes: http://lore.kernel.org/r/20240430174540.000039ce@Huawei.com
> > Link: http://lore.kernel.org/r/20240428030748.318985-1-lizhijian@fujitsu.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Trivial comments inline  Up to Dave or you on whether you want to act on them.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> > -	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
> > -			    GFP_KERNEL);
> > -	if (!cxlr_pmem) {
> > -		cxlr_pmem = ERR_PTR(-ENOMEM);
> > -		goto out;
> > -	}
> > +	struct cxl_pmem_region *cxlr_pmem __free(kfree) = kzalloc(
> > +		struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> 
> That is rather ugly.  Maybe bring the kzalloc down onto the second line and
> wrap the GFP_KERNEL (or just go over 80 chars)?

I have made a conscious decision to stop caring about manually making 80
column collisions look nicer or selectively breaking the 80 column limit
rule. For this drivers/cxl/ corner of the kernel, whatever the
.clang-format template allows, works for me.

So if you can propose a .clang-format change that makes things prettier
in this case I would entertain it, but otherwise, life's too short.

Along those lines it would be nice if usages of __free caused the
automatic line break to happen after the "=" sign rather than later at
the arguments to kzalloc() like the above. However, I don't know the
template incantations to achieve that.

[..]
> > @@ -2861,9 +2851,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> >  	struct device *dev;
> >  	int rc;
> >  
> > -	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
> > -	if (IS_ERR(cxlr_pmem))
> > -		return PTR_ERR(cxlr_pmem);
> > +	rc = cxl_pmem_region_alloc(cxlr);
> > +	if (rc)
> > +		return rc;
> > +	cxlr_pmem = cxlr->cxlr_pmem;
> 
> Is the local variable worth retaining? It's only used twice.
> 
> The fact it's a clxr->cxlr* also seems rather like it could be named
> in a more compact fashion inside the cxl_region.  Would pmemr
> work for instance?

I am ambivalent about a cxlr_pmem rename. It would need to be a separate
patch to handle the 46 instances of cxlr_pmem.
