Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F663CB
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776385210; cv=fail; b=FB9LnorSF/gdaklSZekUqeN05rj8pFnerjfHz5BV8/P5l/JURqLFtgeWpFd8y9mzf2or958OyE8oDXUmszDJ4vMfo/s7ngFEZ/YbQfN07iyJVDukg5DYy+9SZrOyS+NW9K97ZbztN4J7vhR4SCAMDZqxuR4LAJ1M+mOwZE/Ke70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776385210; c=relaxed/simple;
	bh=eQGv/UbNXhFrk0PHF7GNtjSy2QEQHECQHcJcrYHcx5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ualGM1ZICqBtVLw2E5Kmz6xJgdQEeggeejDAgODWvyLVDObDcN4cAWv5+pG+dX0mufeRNg3uBiRN1rMmLOjUoCzvVs5LsrERGkPIwkCstCdHlFzeYoOTU4PYP+3lKE2rzAgN4CIVDz7CKbJYzYlnA8piRNfPC902ZOgVsPhVgfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUibxCf4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUibxCf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776385209; x=1807921209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eQGv/UbNXhFrk0PHF7GNtjSy2QEQHECQHcJcrYHcx5A=;
  b=gUibxCf45WjV+uZuqMcWucT2BmwzUkeVopBynybeIAqTeJ3xVO0RBQXl
   vsjNq2MSuX48rG8k99s8MRQNA4EKGMF+TQtLrmtMExQdeU+Cg+p81C54W
   MSiaEXCaDR5uPENV8cPdmU0eal9gpCGpDvRPqHZD+RKCbQoIT4eWMxjxE
   JKiwKV9fPpssVT+ahhjMJ1ksUmmgu+I9hTXSOuQG2B0TSN1W0+EzHHay7
   HBdHbCdxDjdRsdStXTIbRZeva6fReoj1nXifihDN9GGJ97rv+7vU0XrLC
   L/aJbyvFQQMDm3mi61SNAFHP0lJMgibxPXU837bC98pkRF09BXmXCHDN6
   g==;
X-CSE-ConnectionGUID: u+giNVm7S7S1Zbvnz7kPig==
X-CSE-MsgGUID: Mg/XP5M5TvCRg+QgAPHF9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="79987734"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="79987734"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:20:08 -0700
X-CSE-ConnectionGUID: DQxWq5VFTlSXWZoAiESnTg==
X-CSE-MsgGUID: tIMseCoPTTmgsbaSr4fE6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="254110476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:20:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 17:20:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 17:20:07 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 17:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFFRdcpS0Id4cqykM5rcN7/QMKzAKKtyhJ97ZEZXnmv8Ngns9grtvmcjlaBSJ6bg+3Kz3WRQ4QXwwhqRwQH1EZeipiMGe3DHSgfv1g06eXIp3F1V1EjtVzxoreadYQzYMOkGZbnf6HMcekt7wB/pPDPDtfwDUNRbbLjJZyl1acHho+DTjFm8VdDUi+X4lrWrEjVnPAR7/1RmGau7VlPmaEvuHqdOvZ6Xn6j9fHxmTZT1iMokwb+Hu2ezabTuB4lOgE1lCrBsbxDYgmK5JKvqGLUMNvnRr+3GEUyc1vwyf1Ss80dmVDsw7ArKgRvnrZzsfDmMZpMWsF4m1U37w19AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSTFMbqvtzVb63DCNRpaAZtGlT29hY7IWo6YMMW+Wkk=;
 b=H4O2e3GFS29N0YqXfBjoKzJSaHfvkfwZajMR65UJGlzYF/l/2MFXRcmXgTAmMnjGN1V4A3ZsuiMjDNW7soVXGxK+UZT2vplnLSi1tyH25qT11+dDNrKbnfuKvUv471+WuqCEacbd59FUzjt4BCMMIW+Sa0Hl0KR8J83q50ko5zPNiKzar8MG+NoEsfH6MEMNZSJpvXI8BKE5Wwlwk9GPkuRFYnPYnT6NXHRcLGbnD6vxOr6flwpvQ/fqC1MCJQRfoxJ8GXgUE6AqmDrxb3F6Pw8N+J+68s/ejyOkNg/S3Vol/7qKL0h5Vx5Xc8sbRMs/GaekWXgEabNojf2Y2JXlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH8PR11MB7070.namprd11.prod.outlook.com
 (2603:10b6:510:216::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 00:20:03 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 00:20:03 +0000
Date: Thu, 16 Apr 2026 19:23:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, <dave.jiang@intel.com>,
	<gourry@gourry.net>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <69e17d9ee2924_52a121009@iweiny-mobl.notmuch>
References: <20260411011137.43545-1-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260411011137.43545-1-anisa.su@samsung.com>
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f6c8b5-3bfb-47f5-4ce2-08de9c17121a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pmtDEiw53d186YXBvv6NFQ09U2GfNa/7a3MpwOntjUczu6l49V5m8mOrHCNTriQ3K09Xsdf/O/UBOejKlWu/KDN+Me2pv7FtQlf5y2qGE9ogv9GB+fQvhBxz0QZceTaLdkH9tfKwKpKOHOUi6hGgNmsjMhKjTROTRClN/YZw9YVx6pNMXJXlXGVZ9oM65LMnVbxg1LbmSAkEI+jbPVve9PmvdGx1J+aNlZOXROHkKFGji6GbWqrZHZ0JSK62OkYl2PtKFs8TxUwKwB9nvFdQoPcik8bhiIcrZBgl5kishZe8/aiQSOM6CtlpWQ5HGbGvfXMUa5cECAWvQzfPOef/b4viuKRDlLB1bVkSg1DJ5XU469dl3M+5141Mp442w+aAGnYY5qkPo+w9oOrbgZ7KX9ZuwTP+P1v+neYDZfAZdgU9G+jFbelmudEl1JZBk6E6CaabSRu6AAoD257JuiDHBSrVWLaLR587kr9h/RlU9/Btz3jXsPA8LdWpyzUqtBKlJ9NhiAz0izk6M+Cyi+eSlFNioSCKCll8PNmOGWtdQWfDNl4eEAFQXOEoIGfhWdnfOg/OYgriOgGz5HGIT40kn97qfuqNutcfygzhpKan6vj1nKhSctzmpdn6YhczXE2FRJ40FB+kcCTjGlIXVJnRI9bPESzk1aGRzPvbJaxjT7cSmgR/WkfncMTkXD7Qjk5PM6HVs1r2AkCUb73GX04fldQZkHhr6/2Sgacp2xre/80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHdhQaiT53Nqp9/Y3QliVFCZEAsAGJ/4TAdEGUCKuUJ2E5/f9BK5nKGrprXM?=
 =?us-ascii?Q?8XtAX617uDMhOFYcFhw3MKPbWbeQEqmlh5wFnT4gkMCzF+qmnTlhknzTKNRK?=
 =?us-ascii?Q?0b/IQbjGxAUsRZvp3x7gnrfukjcXmt05B7QMRvNb3VDKIsZ3VkmTirFXDgBh?=
 =?us-ascii?Q?TNc+YGe2L82vjKUvLhy+Q0dCaz3sXqlsuiTfEKNZzE0X6Zu4q8zmNaRlIK+e?=
 =?us-ascii?Q?FQMuU2muAX24xlyJ+Bg9haNdqnwwpoMjkkAaEGikQQWo82+C6nmCBZ65nNSn?=
 =?us-ascii?Q?EuvzjyVG4b8cbzp+AhkX+2GM5uVbZ0YpGPHObukg6ld+uyf0tm5ZPQOnZBT1?=
 =?us-ascii?Q?pH0MYpZcahrpOvt2kNW4vsQogy0Cm9oI7bXWzYs5aRnaqxX8AQOUDvtVhxDY?=
 =?us-ascii?Q?26JkH9MOglfihIfAtQYxLsb+K0WYMQ4PHFR4MuQQfaHaAnT+VQgLrxCNMmCn?=
 =?us-ascii?Q?Lt5ODP3D8dkoO8XpomkuXd+5nnksyzGGhNVIyhuLbrr+f1gSvS1LW03YiNaZ?=
 =?us-ascii?Q?snJ8JUmsXVNsmOYhijgLiQDAKx9xmEfyFCSQy20Aew6pwdCjIkisk6urIgqc?=
 =?us-ascii?Q?s/lDw+Z3JLF2Dm0ScieA2+GGUF2v0480onCC5qqIoL4W7qcTy8u0uxOO7nVc?=
 =?us-ascii?Q?moNvOR5/cr5S/Jl+5m5AqzWxSrFj2I3tsf4Wank9Umeeuw71zwNgZYxn3rss?=
 =?us-ascii?Q?LSELJbvvbvsLYYV+2PutXjqt9jVaTfAsXjeI+TaxYY+Dca48pqmOUUaw560Z?=
 =?us-ascii?Q?TmFH2yLQ7qL2rI3LL7M5D6zF+u2JKCEbhOolwqFjsUqR//x5pv9guMCGb8ke?=
 =?us-ascii?Q?LOv1VB2B0owYVH4Eo4Z5BAbv+x2593uJWwr9PHH8QfDAelugebYVP48D1QGj?=
 =?us-ascii?Q?c00i4wUbEPW1J+fOZREoVt7ZHQNx8i0GWXpyFAllXVXQ2h3oTh8cuYFPEa31?=
 =?us-ascii?Q?M9s9gXWhN/R1S1q1IY/acTHNT3961MXNeRk4xSu3yadc7davk/e5zxiUfwG2?=
 =?us-ascii?Q?N/7Eoo5hV6fWA2wbNwlLLFSdCkgGu5bKTDVlB3qsgV7e3EN2j4f0K0iQf5rQ?=
 =?us-ascii?Q?E8LX10inYJn28ch1JrlqhJNUr9oTA2Ex3ktxmtBpR3xveGBDx+KU7zApH3Ly?=
 =?us-ascii?Q?Uw4ES5rM2qR/CKS1/7CvjeslxSH/f57VHQGQ/ZZI40Upa4kD7E5sq2E/gI1d?=
 =?us-ascii?Q?yqiJcnlq9VYOsKUiLeYo+0wgoM/URYjJwJSI7gtDK67XCLPFJFhkKd2IQUUv?=
 =?us-ascii?Q?JB/e+LKlMr12n7D3oBuCZ89qDpuR3UAmdwLV0rx7kHayGMvtylO6d9wei4/u?=
 =?us-ascii?Q?EsFlSyTSmqOx0+VPUdDj2RzRw33I17/YYh5BNrNzg5oAwuP/pv041WoBXq4P?=
 =?us-ascii?Q?JAUqShmdbCbZvOhFvQd4pim2Ltu0jxAk3aIV8JRWesr0co7jXnOTJYOn1sPU?=
 =?us-ascii?Q?ZIHPwOgafgyRKCkg2vakqjSr8o1fGcjofF+Jv3k7GsahRM4Cfy7I0v72PYMz?=
 =?us-ascii?Q?tjErI189X2/lSlUkvmZBf3MmuikSK+WEKYZZDzOntNl/mKhsSOz3hkgYIp2T?=
 =?us-ascii?Q?T0DAYnLxvVW9pSinZA8m+zSuFHCdFNJg51xElY3iPbcYmgAC2PjowJGX0pum?=
 =?us-ascii?Q?Vo9VmTbkhqvLT2nGFYr7LL/FcohowGy11+4SskTcZ2JfCiVR6D612oPHRHVt?=
 =?us-ascii?Q?VrdNwMVJjnooQZmmfjFc1APUwP8gpDfFMvXHsAIpHPrm6LguV4UXmOqxj7ia?=
 =?us-ascii?Q?7iND4HF6VA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZeYHg3SrRryM2il1oruYTbh5bj8SQSERmXThBAJfFmgjPDkxT3a2ZIfjlA4RCoySF5y4MtnKEG689Ob9mmAi3yuQlnF+gCRokEiXeLq8PrR9Pa4/jar5wQkvjGm6ZDOKuj5ofRUGQCizZa1Pz6v5FiWySwlMnQzayIh5UqeGhnc4gfeuiwSCUy8J95tmHZOur6ow5bX8OAFGPRFu6OFeaY2QBtXliZ2cFHfc18GbMrBFqutwkd4ozTO6pfP1avOOYJ6LOuTIWqSKQDYDEimpx87Pp0pY1/bm9FMPl2UnQ6ARcb0SvC6oQWemP03vEtZh8ozduj4yEAzBBMrMD4+O0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f6c8b5-3bfb-47f5-4ce2-08de9c17121a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 00:20:03.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnLPIxsrm+rpB+UUYJQdF/dGg6HQHALPDt3W08tFx/aejoXxvqOqxOFXoyvtQJ5hlHQ4OClRMbpa1xgmyvFGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com

Anisa Su wrote:
> cxlr->cxlr_dax assignment was dropped during refactor.
> 
> Fixes: d747cf98f091 cxl/core/region: move dax region device logic into
> region_dax.c

I don't believe this is a valid fixes tag.

Looking only at commit d747cf98f091, this line does not appear in the
original function...

-static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
-{
-       struct cxl_region_params *p = &cxlr->params;
-       struct cxl_dax_region *cxlr_dax;
-       struct device *dev;
-
-       guard(rwsem_read)(&cxl_rwsem.region);
-       if (p->state != CXL_CONFIG_COMMIT)
-               return ERR_PTR(-ENXIO);
-
-       cxlr_dax = kzalloc_obj(*cxlr_dax);
-       if (!cxlr_dax)
-               return ERR_PTR(-ENOMEM);
-
-       cxlr_dax->hpa_range.start = p->res->start;
-       cxlr_dax->hpa_range.end = p->res->end;
-
-       dev = &cxlr_dax->dev;
-       cxlr_dax->cxlr = cxlr;
-       device_initialize(dev);
-       lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
-       device_set_pm_not_required(dev);
-       dev->parent = &cxlr->dev;
-       dev->bus = &cxl_bus_type;
-       dev->type = &cxl_dax_region_type;
-
-       return cxlr_dax;
-}


Furthermore, I don't see where this line ever appeared in
cxl_dax_region_alloc() prior to commit d747cf98f091.

So what is the purpose of this change?

Ira


> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  drivers/cxl/core/region_dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> index de04f78f6ad8..068690d02c8c 100644
> --- a/drivers/cxl/core/region_dax.c
> +++ b/drivers/cxl/core/region_dax.c
> @@ -62,6 +62,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  
>  	dev = &cxlr_dax->dev;
>  	cxlr_dax->cxlr = cxlr;
> +	cxlr->cxlr_dax = cxlr_dax;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>  	device_set_pm_not_required(dev);
> -- 
> 2.43.0
> 


