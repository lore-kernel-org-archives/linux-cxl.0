Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4C20F073;
	Tue, 18 Mar 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310911; cv=fail; b=oDgRlTSeoUB/m+Jxzxv036uwLaz/6kZFcfSAgCn+nWy7czSxP3DQAHr4IZv3KfutoO4J2ezE4R3lrJxDy3uafqGa3wv0fS2lSdfxWl1gutKqzdnDtOxXYPeCBAFz+AXBKIcPCoJRibMdjwfc6nEU7oNCmFv9lXnxzStvMHoR90Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310911; c=relaxed/simple;
	bh=0CR53OMxs5uPBpidYunS6V6dtfWIaw64EGF5BjtukqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ttQ/KSSTa1o5IV4NgCQi8jQeGvxtfEbzOMEwxYrUOMBWX/mxsdksMhBmlToZjYhPqE3I0qN2oMSZDkz54x3FbMGdDgI+/BcUfaXYaxYAAYHU1zVS5f2UQYEkXxsaiYdnV5Ety+3WMVffU3Ilg51FL6pGQyN1veQlrZzSqsQZkgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYFyXC4d; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYFyXC4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742310906; x=1773846906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0CR53OMxs5uPBpidYunS6V6dtfWIaw64EGF5BjtukqA=;
  b=hYFyXC4dcWDWY76zL9lfB+55DHnbkcC0KtyU8DNNqkXzwr0vrsF3f9tq
   3+H6mPduTv2ZvxQ9ao2lvz4DiXPCDv9OM/1ITfCyZTz+6Gg4k0CqpOqBW
   RmUOzVfBdAnEnDbzxWcx57uJeKPU38vBKQPIy+zvmhzG35iTE44OMiugj
   at1gDN0eLlDNfk92u/jlsztJtcz/FwQ/igF3mGysWGGGRjW8PnVtfIRof
   nUrCvUfipn85yF3GaDNtubm/F712ZOH9c9htzxlWIevwweBvSJP9HeA1H
   nHBJzdz70UtstmSE0RIooJLWm3Qylz/mAEKZ6kBMq8adGTIBEXBfkPFHJ
   w==;
X-CSE-ConnectionGUID: vLdrOY1cQhWZby0pzTkCRA==
X-CSE-MsgGUID: JBOfWVsVTsubr2eh1e2gMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47345564"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47345564"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:15:05 -0700
X-CSE-ConnectionGUID: nboAxRPuSCSnu0++6MK8Yg==
X-CSE-MsgGUID: TPOCGfCrTuOj2WpwqzhRNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122315151"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:15:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 08:15:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 08:15:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 08:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxfk4I6JOzKH/It2mih9AxaRgCDCTP50LAYzrKweS5YXYcwsiJz6M1WHqlzA7+SiOfrS2gjBOHgC+FTrESo+TUA1HtvQwaU7JgFF/2E27kyIzi7U8WmLwgXgqLG+ssuDvaQj7ibN8VhZShLzR8u0yUpcjrh7l5uMGB7claeBgwXz1a8Co1FKD8hLMn3xEv3P5aI/BLD9JXxOTxJiosNsXP3MvdxefNnwAlYAeHumvu4tw7nvO8vxUHnhVOrmrgzQ527hPlg8ThbpX0o8tCVk0HQ6rynO1wm3zCixBaEB79wMBAjJpwtwm5SlAilac+AffAuBCoahqy+U6OmdYyj1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx+qj9ytRfBWc4a8R05FoSHmsleo8bxOsmjm9OOLr6A=;
 b=I5qThxg/+hQO/ry03LmeVeU+/34KwH1vAJUukrWI/Iu35o/fm3d1rEqNNmcP1xJmgZzmOROQsMCbG26NaCzRF4TptXkaJSsFAP85qUsu21WK5GPLtamXeBtJD7efAl3out1ZvM1VsK5ij+dR9Azr+/fXDq9AZv3PKWfLoKB5huTfw0YrE3b43+BvnLJeg0NSDusAs66VGQ4ulw+kSt8Jsg6+tUxgniPnhQKIWnrkxlhXv3vZorUfU2tNztW5oEZkxMteioTKsl7klV/9nGE0Xq0zRGN5FReEiAtuRgR4c6yY+rvK/tEp3COmkkBiB70/PLH3yKjHeYEt295JcfJwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:15:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:15:02 +0000
Date: Tue, 18 Mar 2025 10:15:15 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <67d98e0394e3a_422c1294e8@iweiny-mobl.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dce1b5-4557-4edc-ab6f-08dd662fa7ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/UEd5k21umEqWCK/TpqyrHD+HSvO9CbnIpqwCUBqo8J5CSqqxIuInV2iC49k?=
 =?us-ascii?Q?4nwIpdS7EliiKuM2v6oJPhjoQcli531OU8l6OPYKZb0+ESf9NNw6P18I8M8W?=
 =?us-ascii?Q?Y2UN57bPVcfe6vEzYL/yY+i2G5LhQiArzPy7do+JXrzcLfm+ahmKgWzMles7?=
 =?us-ascii?Q?P4UxobGsHi0LLfVAzy7hbNio5m2Frflf4FGxOnKM2kRk2h0tvDSDeHqgOLUo?=
 =?us-ascii?Q?WUbVKAZkLqJw0gNTIIx0v+daWx7USX9a8gBFzYEaMpJxd04AXf5lli+43rVw?=
 =?us-ascii?Q?x+Sodgce35CaDgm7e1XZMtzDtnw6FFWCqsl/UoY1L5Wwz5FrL7UjaurcjO8l?=
 =?us-ascii?Q?v8OyamhCGudjj+j+q/BEqhITs69XbqtvpC35gtie1htm9AUW+7ycxT/e9K2w?=
 =?us-ascii?Q?9ytyfl++lZUPKDms1CDRSg6pwUZ+mZpJMk9c5L8ecmeR6CC3jXHKJ5wRGkF7?=
 =?us-ascii?Q?hQRYHRthcnJNli+OpIE8fuaXxq0IjMhfPKm5XMB5FLwRfxVx9jU/f/ZnPyPo?=
 =?us-ascii?Q?2plvyTb/cTMRefLzML/JF7REhpekhS1EGbYx8ZSxAxSC6qZYTk2b9L+zOrbj?=
 =?us-ascii?Q?LGL9VPV+hf7Tvu5w1edap2QjkNCBvDKGylNOqy4FIcICaVos/p4DUR1qY3Ni?=
 =?us-ascii?Q?kbr/+iUZFv6tTidhDW6Bc56tlczqLJE4qaqo6DPdBtR72+zEE9dhjZSA2dYF?=
 =?us-ascii?Q?sRe6gAXxvcm5N64/Tj2FaqYuYwmkQYykSYEgZoKVxeiz37/nMua/Fg+GYZoq?=
 =?us-ascii?Q?uW17Lf37Egryvyw9+Kv8h2DT7jOf+8GwjXFU/7RFAPKhLuV/N1kwP47kAUkK?=
 =?us-ascii?Q?XSOKMyAL72XfP3kmrYbEdCs0KZ0Jm3agiWcoxyGPOAu5lZvlk+2w8PrW/Js4?=
 =?us-ascii?Q?lAKbg5/mH87RIHsY/7nDG7MC4MbU7/gOJ55ifdWIqjjkLgYUEU8hEw+oe2/R?=
 =?us-ascii?Q?OYcGA+vwc958CAPgoYTklDuFoSZJsv5GVNY5h4r3b+IJRvYOrKCgWVSLfqLw?=
 =?us-ascii?Q?7z0E4HhQ82SPQQnbj04SDQYDSI7FbmDaiEV8aXaQpg+dkPPVj+D/dwzRbNyr?=
 =?us-ascii?Q?77DJJpgCoJyKiy269MZOg+TiGvZYU4TDo8x+flC+T2tblnq2lDzogFg4P8T5?=
 =?us-ascii?Q?i0dC+Av740LeuDaACk5OWx6/iYXcKq9I9kCnEzucThJrYzWNP/q0JrBQt+Zi?=
 =?us-ascii?Q?K0ClSq86ptg+qvl1CpiaAZ04i+5FSO72MIGf0oeEX+BTuODHU2JTSYh5KQ84?=
 =?us-ascii?Q?1NHXXDGDbjULj3uSwx2w1bX6bBGR2mMfcPLnApnCqaME4SwVmVTQN5g9+IM5?=
 =?us-ascii?Q?APmw6YwGBPhM5yQNVTPt752JaELJbhEDG92kMcDCJwqkIXys/l7Wmp5ciwvi?=
 =?us-ascii?Q?xgE6StwJfxmu+qH/SOZfweHKiY/c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QhxTfTOORL3mDv/dpSVazqDzZkpf9+RuqININhe4yt8xBVkrFM+DJnraVwIT?=
 =?us-ascii?Q?r+g5dhBNIjSFdXh9hqFaJaE+77cRw7PHNE/yZtxuJue+Hyd+TLT5gs4fP+gu?=
 =?us-ascii?Q?GUII2mrhjwl1geqBU11F3Ua8DhcxoODpIe+aXSGkp/QzfuKJUo7yPQvzaZyy?=
 =?us-ascii?Q?rEOeXeihSirAelJk0MTU24878//BTOIL8bXlMWPDyhZ1We4WxMpWAIsYVGQu?=
 =?us-ascii?Q?ZuV2C3axT13OGELFHPy1HcwRbYyCT4rGhWaD6/XaFM+88EWv1Yi9rRXGgvfr?=
 =?us-ascii?Q?wwvYcysiMr+siQ5iBFwycfN6Mdxrbz1XP/3x7vIrfDEqGyYMaeSddRRj5Gys?=
 =?us-ascii?Q?Ss5Qhoe4ZnEfzjZrgsKV+sN1N+FA3nZtQQAAeBnmxzyzK+QBGgtXTn3UIVmQ?=
 =?us-ascii?Q?R+pRsmAP/eiBdB3iXbMDDEJrZuMAU7a0t/OZn5EfbhjbYll1poo0leqypz/2?=
 =?us-ascii?Q?Ut1Gg8VgFPkzba6ZGuqy2kz1TVlP9LwRLdUi74tqcJf5qHafCuhCGC00VA0N?=
 =?us-ascii?Q?T3bdewCSvdy/Tq9tC/ww66vcoYkJ71iXTB2aO0M7vf5J7P5RIP+nvgV9BzZ3?=
 =?us-ascii?Q?YDOUi3+MM9GhqbTnlIzcGQj7iP47fQtSwTsP0zdJ5GMmeUKLfx9yObirVwaB?=
 =?us-ascii?Q?H2twhkrksV3JEER2ggqZhTtPwzB7oOxmKjRA9IIe9kXZsv/3deccqTpMr0In?=
 =?us-ascii?Q?FE7GeL8Zpd0Csi0enupOSIf/B/rpFFg+galiP6wgcdnnDSZaRbNVZOgiysSJ?=
 =?us-ascii?Q?SV5A1LswVvP96bYcSvw/G8mzUrT5iTktzi34KobmTEi2Lxp7YtT/eT4QTz48?=
 =?us-ascii?Q?/MjIXc1CiS3VQqsfrDAXe2MDMpYSzVjsO8raSice90RpTjYbxbKS4xE2gH9A?=
 =?us-ascii?Q?mt9JTRh6WdffD1P6QQaNVUx+uLLnQ0NEE+y6FqPkhZOtZCyP3XaTKkRV1TKC?=
 =?us-ascii?Q?1lAAzJjPj6lsmHWlo/qDJXHiSLztj10s7XEKZF0JIet+zHnrLiPEwt9wVWvG?=
 =?us-ascii?Q?Mh/S21hok3XLx3DFqjzBj1kwQSlTSnfEmUpT7oHKxldGWlnKLGfYwBNz2F5+?=
 =?us-ascii?Q?lGKeOwFqbL+xHTK70C5dAlQk4/IJfMl0nW0oltRo3TpimC4LRFbp/usYdAyu?=
 =?us-ascii?Q?q/IeOQDpoxaWyCtnpqiijXG3jo/4gokUyIPoBIRfAMs1YjM6gZ8+jU6sr3Wk?=
 =?us-ascii?Q?E/zElIW8FpJ7+9kTRz3oUP1TcIMkF0WCZG0hgQir8x3wdJw5UodVtFo6iMiR?=
 =?us-ascii?Q?lT+lkJci9w100rZTTIf2WoZaYzmfCHkvi1TgdarJz3CaLrLDMxoL0aI6Ukgz?=
 =?us-ascii?Q?25RWpoa9eP01cCpInLVC4fln+tWpB1QcoXGUYm/iciCG9xjSm5nvu27xa54T?=
 =?us-ascii?Q?fxDICJ1To/MNy+d4gYgJEMtt19o8X39nuwvSA2agJb3tlfULvFsvqWdAbdTK?=
 =?us-ascii?Q?ryBWcxg48KQttYMRBtgglarRP0LEpSX/eGe40At25nub77pPgvOS0hkqHcZO?=
 =?us-ascii?Q?6KX5zCy4mk2GO4h9AwySDbapaPl12InxcsFbqBlLtBx6Y2fkaDFZI4QvTfzZ?=
 =?us-ascii?Q?xLv0DabTj8YOx2/FXvjTWv4/VbEpn6Ws6vHr9OdY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dce1b5-4557-4edc-ab6f-08dd662fa7ed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:15:02.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmoa6C3mpmHbSS7xrRmvQ18mlmrCi+NlRIhCbO0CCwIIholdPzphsD11GoR3U0huLPAbPuyOr1psHV2wUsXtDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> ranges are always guaranteed to align to the NIW * 256M rule.
> 
> In order to construct Regions and attach Decoders, the driver needs to
> match Root Decoders and Regions with Endpoint Decoders, but it fails and
> the entire process returns errors because it doesn't expect to deal with
> SPA range lengths smaller than corresponding HPA's.
> 
> Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> with corresponding HPA's. They will be used in the process of Regions
> creation and Endpoint attachments to prevent driver failures in a few
> steps of the above-mentioned process.
> 
> The helpers return true when HPA/SPA misalignments are detected under
> specific conditions: both the SPA and HPA ranges must start at
> LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
> be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> aligned to the NIW * 256M rule.
> 
> Also introduce a function to adjust the range end of the Regions to be
> created on x86 with LMH's.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
