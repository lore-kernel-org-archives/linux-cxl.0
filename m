Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6E2745E
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jan 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025702; cv=fail; b=u1jke1Qahfs/AHq5Ss7DIrLWER913KlOatoLlOxdfRrgEmIBIzuJJJej0YLI5n5ugn7CSolEm1I5NRSHALrdAfZTl4FPrVDlgVnzx08ZwpkjGHbxO8AHwN0pJVfXMKHilTSZDcJ+V+3uJMlihn7/wRpOtq7hNcm8A89FVltnnyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025702; c=relaxed/simple;
	bh=X2ZN2j2eoBhObdJzMRZV9W7N3NMTwUg8pZzwq5zlJiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U6E4Atkaisn5xVIEhThbU0uKMr1Ly0GRo6ipSVLWjPmTpw2LMoLL2LcVOkvzdSHkGj0B9EwQ9QPaX/NjcdMAJWcf+6pSaRQ/gL4gdWaQ4T+sRi7bTWx478OntrMkIW6t3zvM4ccKa/FWdfU5GNeGXwF25kOg7UEf1N0T4wm1j7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8GCF/HK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8GCF/HK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738025700; x=1769561700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X2ZN2j2eoBhObdJzMRZV9W7N3NMTwUg8pZzwq5zlJiE=;
  b=F8GCF/HKrzcErbH15XPC0CpOnXxDVXeazCXulY3NSGe5PgIhi4eMwhkM
   zKWYAdwWc1K5BfreuSMtmo66ohxvZ1Ji4Tc1VBRZk+1TD/NXTObzZOh6X
   h4EQLD1UQpzu1Nml5J8T5qwyBIXT9TZ4m9dobZ3nJOuA7F55qae2LdlpG
   KqBmwNL2ULHX6W8mLnh48grH5iQm/lU4FU+/fsPtsLTSDjTqihM1xt055
   ecFd64lh5m6SrS582Qtc4U5sFAGeV3zBbQszKCCmtRiJ0XuhG+rz1ZfKP
   A798QyZBijLLSX8azTd1tpODnZxs/x+1TdbglcRJcO/WRcrgtGg327qSp
   A==;
X-CSE-ConnectionGUID: clCHLpvTQHieaIIcj7YkMw==
X-CSE-MsgGUID: GGB1yX6QRZ2Smv2MYtflyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="48999349"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="48999349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 16:54:59 -0800
X-CSE-ConnectionGUID: jC3mwSZBTpqz0wC6P315Pw==
X-CSE-MsgGUID: PNMeAyouQbCSWxfr2rYylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113725897"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 16:54:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 16:54:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 16:54:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 16:54:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/u1dEGE7cVS4cttCfmo15f7bmLKEbdlVeZZBZjc1LEic1Y37XLZqx9ajYfeah9+AYgeo47sxYYNe5+T5ai6Wm2nUQ5ljurmPqwXNuEIuGVlNXCuNlAlsHM/6p8UhGPfzhVzWAY7YYCtGxIEMoLlT3JyG56y3HlURZdZ1frE8B8+2NPKW4/MSAjPr0EpmIIn9+zKHiw6zYyuShmqnR1xx0Y8hGRDWW6oFkmddxQlLkP551l70BLT9ubjrcVvz0U2vH4l1qUv5oXCOfayIvnGPc0I9i21CbCps1Smb0nHxvMO4oE7msGHc2Ok5jx075ZuTpkDSe0VtGOBINlFK042tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVqR99cNvK7SxG1dpCUbovhaSCXpiAf9a2gwvWxW2V0=;
 b=q2OCfnlAFhYOruZuGDBZ+6KgZWAC/sRV8HC6HQAx15pgKiNnFhTbdsPudP7D5ObfdTlDw8Fx+9WnRXK0F4ir+HtastYw6sdUlvGA3Ud1wzb0QURxu7obHskfDTGmV5OXR0jC3WdKpB+CmNQlG3Z+xVdCa2Ufqo74voi6iC5Dht2iiIHSTK9qBXm//li080VWfCg04Aog/6kS+qCE0CicXocLOKVL6ymdhamb4q8f9mxOGQugx/i9kbMMXUCK5BBbAt9sLLO2dVbq3eu5kh2uCkIALDW15RW/B7Ybvltpfz1iKcb4mbXB5TLYpFi4patv8lsl8rsgVo+1SQJTW+uJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 00:54:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 00:54:42 +0000
Date: Mon, 27 Jan 2025 16:54:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 04/19] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <67982acfd7882_2d1e29420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-5-dave.jiang@intel.com>
 <6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127111008.000002c1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127111008.000002c1@huawei.com>
X-ClientProxiedBy: MW2PR16CA0069.namprd16.prod.outlook.com
 (2603:10b6:907:1::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: de5214b6-4e1c-4d2b-0c6b-08dd3f3659f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ljGEQT6YW2eCASDNd3YS6/NuOLWnRx3TFvEjpUpnXH1wDZqfEsx/ZcNAN1AE?=
 =?us-ascii?Q?DFr4fSwitQm2/76yvd7X71NWyKvGlhD6UK69S/hp96XU8J2UvPq7qh325UPp?=
 =?us-ascii?Q?9RNXGe/KM4AqaK/o1AcYwWXhE6XAJCJGxYKbOx37QumTaRHs3N+J4RM3aRpF?=
 =?us-ascii?Q?hPO8FZP+qS45TsCgr5TUS9aYfyQjF/F8fqHzEZC1SGz3FMuX/TuRahDsHJb+?=
 =?us-ascii?Q?jdqSSHCU5mY3PfOtl7wktjvDARqkYpKhEbhpo0Pmrc6nPZYd4GnbPEUSt/m4?=
 =?us-ascii?Q?wXM/SB8SyxYfAJxfr9/yqy8XLk6dtAikgeslEB89uK7RMFi5Cw4rhH54I+z4?=
 =?us-ascii?Q?MkGdebHy7SySUmq4qXycp8kMIHFObb8tbMqjxkzIVPtVqZPT4sqcv+Yl2nvo?=
 =?us-ascii?Q?zZqGPAgdwaHtyhyEahzsFSuy0Fx58v7Om4Ekauz/ENal2NHHZJ17VJv5OpZk?=
 =?us-ascii?Q?Z8FcN3ru/V1RcFYrKrapO4/uz8z+9LycqGfsynpv4wDzIIxoofJx01tj8gId?=
 =?us-ascii?Q?5XGpbfdMzMKAeSkudFP0+RGVIT5v11dFChU3h+SkPwTyZRm1TyXeWO3pV2mC?=
 =?us-ascii?Q?kR+waUrO0eR0EajjvFC8amnmeA6bAI7EdbxHj1LyR93tK7w1u4auZaLK11Em?=
 =?us-ascii?Q?VXctXhUediFQkHOxySNCmT77LKrwJuqp52RHPFCa0TnsAZ9xY8iTHkSl/ptG?=
 =?us-ascii?Q?2STUGFGwZmQETf9rmidODMMivkjCeYzh/FvQzaOe+yTiAHqRdeSCdOGClbix?=
 =?us-ascii?Q?4RsPfAK0o99eL0b6/nRJUbbIOjlDr7GJMAy0xDlEk18u07PZOAJWq2MXaFfE?=
 =?us-ascii?Q?l1EIjPwIBEuUM53nmsZolHvwVi4Qol2H+xbYBgTPDOzxvZwIAgmh7pWhPgHb?=
 =?us-ascii?Q?zUzd9A66hSvIJqCYMnqYapV6iCA2lffEIIJaCk8jyRy7VaGAza4kKKaAJRRu?=
 =?us-ascii?Q?ApsSJwBa56hRkysGNcy4dU1buR0dQ3HqeLzsaJ0eKG0iZ0hteqZXuTg/alZV?=
 =?us-ascii?Q?eca0gbCfqbjIQgmiET6CKtTcR9kT7iwbA6GdhwYqM2Q1P4k2M4/lSujA9+b1?=
 =?us-ascii?Q?tLL9g4jtBCpjz+Vk5H6Tp+6tH3Vql+GhnyNTlyccmk69gAJrZwMaydibFkcd?=
 =?us-ascii?Q?jSfligZEHMtDzd7syHC4j4Vg6nwDD2Sm/ClwNHDV27igu2CU2OpqfrocB5Eq?=
 =?us-ascii?Q?lZXq4Eu5fJwuEBw1U2zELp0UFX+fImpLwXkn9d/HTAFDq9cNoMOZSVG9qpbh?=
 =?us-ascii?Q?E7hQfj67ZOfbaExD3sEJS5AZy1IaaDTZCBDOZrQXGdHfqsZidzWMIUq/KrG/?=
 =?us-ascii?Q?IyiKHmXQRVbbENkRItfu3yvZyV6RpwKC6dSVJl78c50CszsdnUA4NrDXyDig?=
 =?us-ascii?Q?7iL/wlrT1z/rUygQfGngtQUVFP3R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TjkiTl/8Y/zGAtSHmErHzT/p9bkKRqMp0oF3AUl+c4CR1TDn0aWbQXkoVfeL?=
 =?us-ascii?Q?tcvKQaMKZFcSPMZrI8yQlJjHGuGCjgnpttmYZEjE9A64DDurb+R8JcD+crft?=
 =?us-ascii?Q?NPkIhv3kx7/Y0cbMBcEu2O32PO6pp8jJfno8d99QrIoSVUaqnCfeG4t7VHKA?=
 =?us-ascii?Q?VYSZMuXiW49rvF+rAujez65oQgRQcy6Bp5QlOp21jq/SoiAjiZTQtgWhhD5x?=
 =?us-ascii?Q?YWUROnWw8vmr4+P+d8trC8QBQPKQcBy/xc1xyMenMyb3LAw+18iqMdxQfFpN?=
 =?us-ascii?Q?0m1CQ8SYZFIoAfcgWNKjwdklTOcvquE4v0WZyueiHcxBBazAq7x43mc6pqkU?=
 =?us-ascii?Q?CetJCzzdEEywkgbJJvYdHhlrdxgw1KBgpPyJ18gQqKL4CeGn6EFaRr3ivmt0?=
 =?us-ascii?Q?TB/r3QANjorLbrUi2xaSnDA0nGGE/oZOIudz5XoCQEbg4HYdItYqh65YIUiA?=
 =?us-ascii?Q?6MyZHIrBOrCie4ICOA1IdgJBQ/dMbsXkAMMxFJwYk4x9G4bu9IfWUwC+FKeL?=
 =?us-ascii?Q?WkibsPdn/+lwKHTkfEzIKcfGYVziMqKX/QkksgBoiZymWz6feAoxupGvh16Z?=
 =?us-ascii?Q?reCamJPKuwnx1Hq3X69AHn3b1UU1N3MuAxR1uVUNQX3Kujc23tIroR/LOSAT?=
 =?us-ascii?Q?diFaAf0huebnd76VZU4OkCPM2cJUSVaePjBQtZgK1Tb1fdnBDrT47yn5lWlI?=
 =?us-ascii?Q?LGMUNzJd0TiNUpt2w/SkT8dD9Q4IuQz0uDNrdEFtA8yt5VeeOpSne51Hb8JQ?=
 =?us-ascii?Q?tpA0nrwhOxUNhIWFrVUEmzT5zQSeQzt3C5ED/QawLqnLOAdBDuyXqlrF3f+C?=
 =?us-ascii?Q?hjo0gdhAwOC7vXxLZPXEKVfDmn0M8RUiUGPd5Qtk3YJhbbL46j/kOZVqSRXx?=
 =?us-ascii?Q?P9xH02LK99/Q0IzRgJE/Lpe2RJX6tnBqRMUj9fpAol4DRTLpubufhvD3tcY0?=
 =?us-ascii?Q?QdQZsvKhi+k7/yxksXWLrBJDA1nRzZFoSQvdP6GDuPSexjicN/CD+7ObFgZR?=
 =?us-ascii?Q?9cAL4WD72V8DFGKAWKpeOZFxcXEDoqaFdlfi9+ZIu6oE+LXYfQzoCptwy6xS?=
 =?us-ascii?Q?9MDlltLr5qZ4hFpnRue9Mj6YiCPYmnPksl/uNiT23uGn1RSEih5U+YmdhYpW?=
 =?us-ascii?Q?QKtPOohGZB0iQq/0I7LwFZstgkOV+gPbcEyQpgvEHU3CMjWwNxsPwmvJfzxW?=
 =?us-ascii?Q?kc14zmbOGwNiAUEOi2MI8zjRN6utl+1icLqWAg2zVNUjLHxx+XQQKo1UO0iN?=
 =?us-ascii?Q?L6LVAvgcVjJ6ZCF+05gvT3Nf/QqXBjMrtgb5Wp6LHCEF4AZxOZOSr2QI4628?=
 =?us-ascii?Q?fVS2P/ZMSD97x1JzIIItvki8khF3+ovDjwbpAFHXIUcwy1t/MnCR7RXWKMde?=
 =?us-ascii?Q?e4s8jgJEoa8KVVDWXT3c6vfKJx5y28Jn7TpKw3FCGgLhi7rMlJpZnRvWUY+F?=
 =?us-ascii?Q?G7Ts0f0REP407MyC5HibGhffqqZf1HHg0GFZ4ilf9wrIuRqP8gcbRdIvBu7M?=
 =?us-ascii?Q?D1L6HmvDaMTNHDobZLh+l92kKZPNr+q0U3NCrW+/KxBmU+40KVeDANgfFGXV?=
 =?us-ascii?Q?RKz/Zfgt4NWkzCFKZHxiYnPPBHZnT1QdLTy00Tex8AnwIv0AGcf6rGt/Q3WS?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de5214b6-4e1c-4d2b-0c6b-08dd3f3659f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 00:54:42.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km+bWipaQmYqVcIG59MO01+JRANt71w0WIvOBa0wZUgZdhY3jMvcDymlYPbQPMcxv179fuvHB4acl2zsonO0DMcgHgqZfnz0nB/pTbkzlV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Jan 2025 16:30:17 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dave Jiang wrote:
> > > CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> > > The command retrieve the list of supported device-specific features
> > > (identified by UUID) and general information about each Feature.
> > > 
> > > The driver will retrieve the feature entries in order to make checks and
> > > provide information for the Get Feature and Set Feature command. One of
> > > the main piece of information retrieved are the effects a Set Feature
> > > command would have for a particular feature.
> > > 
> > > Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> > This has me thinking that the EDAC integration should just be a feature
> > of the cxl_features_driver.
> 
> I'm not 100% sure I see what you mean here, but if you mean pushing
> the registration code into cxl_features.ko...
> 
> I replied to this in the other thread, but just to add a bit here.
> I think this creates a worse spiders web than we have today. Not
> all EDAC features we might add (e.g. device self test) have anything to do
> with get/set features.  I'm not sure we'll support that one in EDAC soon
> though it might make sense if there is generality with non CXL systems
> (I've been meaning to look into that.)

I came to the same conclusion and am now skeptical of cxl_features.ko vs
just extended the memdev ABI. We have long since shipped the expectation
that command passthrough is a compile time policy option. Each component
that wants a CXL-Features-FWCTL interface can just register one via CXL
core helpers. In this case it will be similar to what currently happens
with the fw_upload interface registered against the memdev, not a
cxl_fw_upload.ko driver.

> To me, the CXL features support is providing a service to some of the EDAC
> features, but they use other services from CXL drivers and potentially
> don't use CXL features at all.  For now we have the repair drivers
> that only use the features support for a tiny bit of what they do
> (tweaking device initiated aspects and detailed record generation
>  - if we even support those yet).
> 
> At some point we may have core CXL functionality depending on
> get/set features as well as there are things we definitely don't
> want in either EDAC or fwctl like metabits storage controls.
> So I'd be careful adding any thing to cxl_features beyond stuff
> that is definitely clustered with fwctl bit or helpers.
> 
> Soon I'd also expect us to add 'features' to fwctl interface
> that aren't using get/set features. I think you suggested that we
> could do this by making up some guids for them and pushing though
> this same interface.

Yes, although I hope the availability of FWCTL encourages new and
interesting device functionality to just be a Feature, so that we don't
have to play Linux GUID games. That might be what triggers the creation
of a query command because that could lead to future scenarios where the
kernel needs to dynamically mark a Feature as exclusive that was
previously allowed before the kernel knew about it.
