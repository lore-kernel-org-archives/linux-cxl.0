Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE43803E3
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408098; cv=fail; b=GWG6s32/UMpb9mxJProZE5ZF8gNLB1YyhVKWdvE/g8DyeUXtGJFghsnrKZ9tMXs43hDjg+jKmsm1Y46dJ+PUwAVVNyCq/wo+BA3zNl/8D6samP3sQM8Q/sOEXGrXgKj/MTRvymA0fJsEH3LuCpesgBPTjKcfIZcYmYJUFDEA/7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408098; c=relaxed/simple;
	bh=s30j62BXISxwmALWrfE8dpnVoDWIUxqLtGbHPsgkCUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5RhCkTo4Kt0A1xB8spSg/gjPXJjGjcKkSOaJElYXYYvjKsGSi+q9CqQZ6pIEbBeAD6D/bvgLU83x5NyrBp0Ttulq+Gr7qFGYO8W4YcOiSxiLaqiYd/FmgwgMx5HT9aVJFkMbuSLEYNVG8v3WfXkoNneXMSYA5rRzfjbP3jrOwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ7dWNC6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ7dWNC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788408096; x=1819944096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s30j62BXISxwmALWrfE8dpnVoDWIUxqLtGbHPsgkCUg=;
  b=BQ7dWNC6vS1Me4v98HH72YD6cWeIHua8rUjb+iTxCCSJDNmnvHG7HNzg
   oqkALA7AXfuXypL+bgXx8gSKjw4RTv63b2bMpwx3+sWeRg4kp4znMeFng
   EwR58us4O1a/bBmNwSYYRS3yfni1xYzaZ8sO8VotdR0LHMhktI2sVjz6d
   If11HzMGo75E3jQa1j9kvUf177c9iUyMX2WFrhajHVg0msTfPDSKIClnl
   5roH2a9lL2U7H+FKVf/bmu58ffD34iTmQ5PHJNkOsxwcyEv+nEZ+fQPIb
   6Ulp3MSUMeW0yi5KZoI/2HhNj1Ee8e7hPrxWoyCHtGoj9gFqvKWAe0RYH
   A==;
X-CSE-ConnectionGUID: SOU/yTxAQbm/l/VSPTrExQ==
X-CSE-MsgGUID: eO/QnO4aS2O/6ZkVz23gpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87814220"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="87814220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 21:01:35 -0700
X-CSE-ConnectionGUID: l5PnYgGgTHigfNkg1CEmOg==
X-CSE-MsgGUID: tZkfKcKYTaacZgUxRnsHfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293097774"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 21:01:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 21:01:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 21:01:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 21:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTpTgAn0IEI9uH02PyjJUsZV8rAr2+oVBvN5pHAUHTfQvPkoQduEljvIMNz+Chn8ds64WZhLjfSf1To0SrupURngadh1dlobOIWKR+6AaxhOom0mCJHngwBTlG/SQdMCLls4qU4WBSt26uSTgy6iX70Cy0/+jw3KDH4/ljuaXyt1NHOihbmhqOgv952xE/B916abgGbzQVJNeSBXxFAXiB2Yz2fKFCSngI06wkXPtt8tncCP/4suDfcNfGwXcuFjoM55FiGbgbZuDepggZtxmp8sxF1gUeC0KG4XoZyyglZzo1RmKhT1O0hOZUCe3zPRwey+uaM7SiNK5MLVs+iP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgNl6Y2TdAXUkPDDVdpeuNgpk4K7JtoY0G/WmV6teik=;
 b=OLbsH3n3Dv79PIxmPf7ZcexRro/NsAUaHBSElXq4zV15KePDsLdubZ9E0gzJfXu2SvMkSGNvf9lsYXLIYTTk04Fzrm4h1Ls9q4tEcrwQuCynDIqjgfXlrIeLPyFifGCidgghDN+3HGYW42xOWvkaE6gD5bDheIOoJZHQFJTR8ZIqIJFc9aVT/bVnxcoRI3soZOe5XwrvlKQhlwBhsmTuSA5bcPqt5p4Lz0Dt29JdplOvP6Y1cd1UE3H+44D+R+tkHmGSxuMGYcLwOFQ1BiIgJcvsOySkWWL21aqlBSMlUdbGbuPn8MLruTDtaQNPr6uZZMNz0iU/9FwDeEiU7LgoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 04:01:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 04:01:31 +0000
Date: Wed, 2 Sep 2026 21:01:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] Documentation/cxl: Describe mixed-granularity
 regions
Message-ID: <apjxE8ff0Ukqr9fD@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <3ad2df22dacea3cbd58a3ca2732003e120605277.1787255388.git.alison.schofield@intel.com>
 <20260821213527.48d71a39@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821213527.48d71a39@jic23-huawei>
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 95647b1a-3703-4479-f577-08df097009b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|4143699003|11063799006|10067099003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: cm9PKdnu1sxvZErvg3itXaevttnAI4BeynaEs/dwmJNwbTlm61fAtsuW3vWg3d6dvpjhLPkuNPLyLXaDHAbVTsOgx44OGgSHzPueXNv7lNQ0zXueW7kN0DwdyY6GmDtUQZI+bRW218Gz9kQK26/Jel3OoJ8iQoI19MlfjYrhoBN/JvBy9FfkYnpZJKov0BPZngCZJkyEvElQ6nT/ijJoQ+PuN/+b0OKpZm2Nhr+jSLBolHOhgBDY2m9MmGpogS7UrzDPL5DYR5n1jWu+9EysVh32lf7+2UkNmg4Yc50r9fzeWDjBVJPX5sCqR3eNZynh+V//VLkj7PDlqqqysFxvTUg06FysiGBYSQBNe/W7btoFfhBzn+uT3fDrhFHt8AceKB9Tcj6SisHj6wiirMuhSNskkW8CwlUNg+PfnkYk254+YXpKnGYBxe0DVilPWTquDgNRceFUIbP/iXvaCmPrk3C5+mBH1mQGc43Pz1iv7Il58D+EdCIO1Dc7M2fNE5GDB3FtRC5mX3G1ymyEoOFpjnts7sKYczcQ0TOgT2ALKlwdAJWjLZT64VxJT5zdfptt2qPuYqnnvLCLpAOFj54GAWHH/b6elpTiyXO6dTozojLC2CGNjLHE8oaqjGCbjZKl2I8Bt3MrCehK2DEoGFYiq9kUlDkcXV4XEysNy9Qo2ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0eGWu1W+DAfnXQFc8DGQol2EBqgkG94ZpdUkBnTyzIfI7MWWN0NnvMkhDvap?=
 =?us-ascii?Q?KySNDAHBmfln1BUXN5X2gsaNpv/nNS5uniuV5ukKuRiPSknqktjIXFsYNQuP?=
 =?us-ascii?Q?5Te0Poya15e0BHgE9CiSWHlKGVylHQyu3Bp7SPihyisNtk8wez3F06kTvzKH?=
 =?us-ascii?Q?wGQI7oLce7mVP07bkpbo8avBXBAQCRS0mrf/mdugWNrDhl1K5z+pEQ1k1WuQ?=
 =?us-ascii?Q?ZjLqR6Ccr83qUuliB1CAjF2LJRpI663L2pZhRzSYcnxo8dXlBsomo1wrZ7C9?=
 =?us-ascii?Q?YXPrHi6xTjVe3xoqRTVxFx3IIgXK25zYTtatnYrja0pR4A0EBZ0qb9NOQ8kc?=
 =?us-ascii?Q?uB433Z3zs+dgsSWZ/f9SX4k9vpTvON3NvxROShgAFEBcVRP8lzIaw9JOXL8L?=
 =?us-ascii?Q?BmxA1xVZcIE8+yUpWehluyXDEs8VQ5FjEKDl4/eRMWKCp+W7GcI1ZAiVAraW?=
 =?us-ascii?Q?p//yJ1/NgLHCpC0dlYHZyRQHPP8hVuy1SVe3+W1v9vYGjK9jWb5kWR1zGx+s?=
 =?us-ascii?Q?zAV4h60fuRoe5bwNLYLGlZ/G+b4TbfEbmDVyZVgJI2m1SaxB1iRwK+28IzUW?=
 =?us-ascii?Q?+4JrYycayqdMiZx3ZT4xs5ybKLohbNO1ijDDvcu1R+QCgWiPMIuSPazinipF?=
 =?us-ascii?Q?9N1R25iPjlHh0C0OSYoKM6J4BS0iEL4g9PDxFcCLWTqBOmBALyDApTslPpl1?=
 =?us-ascii?Q?iylkQ6NkqkjIvF10YRITpb2GT0bIsV8R4Ubc+mK7uC5jP3CVu6D4JiAtzaeX?=
 =?us-ascii?Q?z6Ui/w7qR/HoRuaqo2mcWpKiKhRlPfRwqqGI5pa2Hsys2UHcaT4KfuAfeELt?=
 =?us-ascii?Q?74vRmxl3/1M+b65+MufP0B9kfHj+DJwObjihXlrcGY6nNaOsOzesVn9IYYOp?=
 =?us-ascii?Q?km7lsLTDlgfoW7H5VeJr1zJRPVV44BOnd/CsUM6lNKshTrdmP+mA+c+69R7o?=
 =?us-ascii?Q?Z32kp2thVwvKJN5oWqKsEiL1wjcfKyL1UXTxutEUtcf2eyDVa0Vli2kXm6Hd?=
 =?us-ascii?Q?Gwik5Eyy7GJlg2+tyCzmf8yOJA1hBPAFMPppyZwL/7yG8NQ2c9eI84WmBavc?=
 =?us-ascii?Q?rsd0BGSWmyso2kAVCvZ0ZOoQvS5HF46GerPjJKbfAV8vt2bU+QAGDx78SgwW?=
 =?us-ascii?Q?XgtFF8UbAyT8s4EidUhKs9QTQNPI2zR6WqIr6ezhAK6UHAsM1hEaubghWY5i?=
 =?us-ascii?Q?XOKkZ9cD+dx8JiuEkxjfN326YafYML8n/v+Ss6tLIr5Op/NVy8vTjStfXJvW?=
 =?us-ascii?Q?nMQtihWrgC3YKDhl4u7c3OZzIZk/F6g/vXRn4nvfD9eiX9C6gG30Hd1JJqg2?=
 =?us-ascii?Q?HzF8KL+u/KLQf3NO6XFiJ3r8zgvIUAfw4KtIhX1m3mr8hAcjZCh8p4p4fL0m?=
 =?us-ascii?Q?p1zN3EqLa2bRI5IbNtRKe6LppJvGxgl7ocKQGYpX7W7aMXlrm9vbsk5jc+bB?=
 =?us-ascii?Q?PC+x6+RaeFR4IWXWeS6Iq5UvO87bZAn4xoqHT0fpL+gCSbuDI/un4wff7rRl?=
 =?us-ascii?Q?fG6pyRWtC4gfcB5VH4QXh7osy8Odpz7YOCP1rrSfshecCPvBUqrZ8KPFWtko?=
 =?us-ascii?Q?Ua3G+rkYY3lm75jB+Qeh1KMQQYnvo4RiaLZWmWIPl1JftRbeIhlw85Ur+pyz?=
 =?us-ascii?Q?JOJhSdA6Y47RUy/0s+841yXGFphTc7+oaUoVYQXMjc3k1bVCHiypIJUHFTj3?=
 =?us-ascii?Q?sBJHdiqWpL5lXTjcc0hDVJs2/PFjfV8jdCF8KzdIUx+PmU52r60+PzyexAiz?=
 =?us-ascii?Q?mQjYEVoGIv5Rzvg3U6Di5lcPlLKC3EA=3D?=
X-Exchange-RoutingPolicyChecked: VcYH5HX9NwN4QdnhxSYaMJj3vPp3ndlIu7k68XVUuO+wjuOq9txi+VdHw+3wunDEbXkP110UjpDi+hMjclTD3DKMsRqbMS1t8fHVb25xl0D11G713iZqcm4r7nTF9Dvh1JrQh+YJiCxpaL+u7zsX8fcRnJuRgKDHrM6nmRtl/z8tlsSWjAIoMwcN2UAyY9AhNukF1RYvU+iuUaGkVHTWMlWSgVZG1JdC1ET/RJOJLWvdSgdCDv2qhCMMmW3K0DQiDsSCP13kUyru3jOSHjiwytCYIjocLWiHUgZtPSGE9L6oOD6QXYFphSq2vUbLRSBBDYMVin2G2Ut533xHO+pLDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95647b1a-3703-4479-f577-08df097009b7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 04:01:31.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNqcBPr3pMZkevzeuCHm/SKcjUyW6tEzNnb62APZILs6SQ9z7QSiWcUTHY+65ZbKzYl8SkxXe1r+GQ5Jq/6mwTcmxZoD2UFQQVBkULs2uyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com

On Fri, Aug 21, 2026 at 09:35:27PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2026 16:31:24 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> Hi Alison,
> 
> Can we pull this up to be at top of patch set?  People really need
> to read this first, so make that easy!

In v5 it's Patch 1. 

> 
> > Mixed-granularity region support introduces interleave relationships
> > that are not obvious from the existing CXL documentation. This is
> > particularly true for the 3-, 6-, and 12-way configurations and for
> > understanding which configurations permitted by the CXL Specification
> > are supported by Linux.
> > 
> > Document the mixed-granularity model and Linux's coarse-to-fine
> > restriction. Include the relevant configurations from CXL 4.0 Section
> > 9.13.1.1 and annotate their Linux support status.
> > 
> > This intentionally repeats information from the CXL Specification.
> > The specification remains authoritative, but showing the Linux support
> > policy alongside the legal configurations ensures readers do not
> > mistake an unsupported Linux setup for a configuration unsupported by
> > the CXL Specification.
> > 
> > Assisted-by: Claude:Opus-5
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> My biggest queries are:
> - Naming.  bike shed time :)  I think this evolved to point where 'mixed'
>   no longer describes what is being built. I'm not sure what is mixed.
> 
> - Are we sure people are doing coarse to fine?
>   They might be - I remember a discussion with Dan way back where I was
>   arguing that was the natural way round, but he convinced me that fine
>   as fast as possible made more sense, as about spreading larger hotspots
>   and linear accesses onto as many paths as possible as quickly as
>   possible.
> 
>   Given the reason to do this is either a hardware restriction, or non
>   power of 2, going fine as fast as possible may still make sense.
> 
> Honestly I don't (I think) have any skin in the game here so if this
> works for you I am fine with restricting things - as long as we make
> it even clearer what is going on!


I tried to make both of these clearer in v5. In particular, the
mixed-granularity section now defines what is "mixed" up front, and
clarifies that refining toward the endpoints is not a preference over
Cross-Link First. More on both below where you called them out in the
document.

> 
> > ---
> >  .../driver-api/cxl/linux/cxl-driver.rst       | 135 ++++++++++++++++++
> >  1 file changed, 135 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > index dd6dd17dc536..4e56c18294ef 100644
> > --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > @@ -602,6 +602,11 @@ derived from their upstream port connections. In `Cross-Link First` interleave
> >  configurations, the :code:`interleave_granularity` of a decoder is equal to
> >  :code:`parent_interleave_granularity * parent_interleave_ways`.
> >  
> > +When the region granularity is finer than the granularity of an interleaving
> > +root decoder, the relation inverts: the :code:`interleave_granularity` of a
> > +decoder is equal to :code:`parent_interleave_granularity / interleave_ways`.
> > +See `Mixed Granularity`_.
> > +
> >  At Endpoint
> >  ~~~~~~~~~~~
> >  `Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
> > @@ -619,6 +624,136 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
> >  Linux does not support unbalanced interleave configurations.  As a result, all
> >  endpoints in an interleave set must have the same ways and granularity.
> >  
> > +Mixed Granularity
> > +~~~~~~~~~~~~~~~~~
> 
> My main question here is why are we calling them mixed?
> From that name I was assuming we were doing
> 
> Root 4K
> HB   1K
> Sw   2K
> 
> Where the granularity isn't monotonic.


I kept "mixed-granularity", but reworked the opening to define it before
using it. In this series, the mix is between the root and region
granularities, not arbitrary changes in granularity down the hierarchy.

The new text starts with:

Linux has required that a region's interleave_granularity equal the
interleave_granularity of its interleaving root decoder. A
mixed-granularity region lifts that restriction. The region granularity
may be finer than the root's, so the interleave refines from the root
toward the endpoints. The mix is between the root and the region, not
granularity varying arbitrarily down the hierarchy.

Please take a look and see if that makes the terminology clearer.

> 
> > +Every decoder advances one target every multiple of its own granularity, and
> > +the decoders below it subdivide the span their parent assigns to a single
> > +target.  Linux supports two orderings of granularity down the hierarchy.
> > +
> > +The `Cross-Link First` example above shows the first ordering, where the region
> > +granularity equals the granularity of the root decoder and granularity coarsens
> > +toward the endpoints.  In the second ordering the region granularity is finer
> > +than the root decoder's and granularity refines toward the endpoints, reaching
> > +the region granularity at the innermost interleaving decoder.  A region using
> > +that ordering is a *mixed-granularity* region.  A mixed-granularity region
> > +requires an interleaving root decoder.

I also reworked this part to address the coarse-to-fine question above.

Cross-Link First remains the fine-as-early-as-possible case and is
unchanged by this series. Refining toward the endpoints applies when the
region granularity is finer than the root granularity; it isn't intended
as a preferred alternative to Cross-Link First.

The new text makes that explicit:

Refining is not a preference. Once the region granularity is finer than
the root's, Linux gives each level below the root a single granularity,
its parent's divided by its own ways, so the ordering follows from the
region and root settings rather than being chosen. [...] Reaching a
fine granularity as early as possible remains available through
Cross-Link First, which this does not change.

The restriction is that Linux does not support a hierarchy that refines
and then coarsens again.


> > +
> > +Linux supports only monotonic granularity hierarchies, either coarsening or
> > +refining from the root toward the endpoints.  The CXL Specification does not
> > +require a monotonic ordering, see `Mod3 Interleave Configurations`_.
> > +
> > +For an 8-way mixed-granularity region below a 2-way interleaving root decoder
> > +at 4096, where each host bridge routes through two levels of switch, Linux
> > +programs::
> > +
> > +  Level             Ways    Granularity
> > +  -----             ----    -----------
> > +  Root                 2         4096
> > +  Host bridge          1         4096
> > +  Upper switch         2         2048
> > +  Lower switch         2         1024
> > +  Endpoint             8         1024
> 
> Given multi switch restrictions, why not just do one level and make the
> host bridge do 2 way interleave (to two RPs each of which has a switch below)
> 
> I don't think that changes the logic, but it reflects more standard
> CXL topology (if no PBR fun involved)

Agree. In v5 the example is changed to:

Level		Ways	Granularity
-----		----	-----------
Root		2	4096
Host Bridge	2	2048
Switch 		2	1024
Endpoint	8	1024

The cxl-test topology is changed the same way. So now the documented
and tested example are cross-HB, host bridge, then switch.

> 
> 
> > +
> > +Each decoder contributes to an endpoint's region position in proportion to its
> > +granularity::
> > +
> > +  position += target_position *
> > +              decoder_granularity / region_granularity
> > +
> > +The root above selects a host bridge every 4096 bytes, so it advances one
> > +target every four region positions, while the lower switch advances one target
> > +every position.  When the region granularity equals the root granularity, the
> > +root advances one target per region position and each level's weight is the
> > +number of ways below it.
> > +
> > +The ways and granularity of a mixed-granularity region must describe the same
> > +interleave span as the root decoder::
> > +
> > +  root_ways * root_granularity == region_ways * region_granularity
> > +
> > +A region that does not describe that span either leaves part of the range
> > +unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
> > +region below a power-of-two root decoder spans a multiple of the root's range
> > +rather than one target's share of it, and is not subject to this relationship.
> > +
> > +Mod3 Interleave Configurations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, selects its
> > +target with a factor-of-three selection rather than from binary interleave
> > +selector bits alone.  CXL 4.0 Section 9.13.1.1 defines the 3-way selection as
> > +the address above the decoder granularity taken modulo 3.  A 6-way selection
> > +claims one binary HPA bit at the decoder granularity and takes the modulo 3 of
> > +the address above that bit, and a 12-way selection claims two.
> > +
> > +The factor-of-three selection is not an additional binary selector bit, so a
> > +Mod3 interleave distributes across the hierarchy as::
> > +
> > +  3  = 3
> > +  6  = 3 * 2
> > +  12 = 3 * 4
> > +
> > +The cross-host bridge selection carries the factor of three, and the remaining
> > +x2 or x4 is binary interleave selection below it.  A 6-way region at IGB across
> > +three host bridges is therefore::
> > +
> > +  Device-level region:   6-way @ IGB
> > +  Cross-host bridge:     3-way @ 2*IGB
> > +  Below the root:        2-way @ IGB
> > +
> > +where both levels describe the same interleave span::
> > +
> > +  3 * (2 * IGB) == 6 * IGB
> > +
> > +The CXL Specification defines the legal Mod3 compositions and is normative.
> > +CXL 4.0 Section 9.13.1.1, "Legal Interleaving Configurations: 12-way, 6-way,
> > +and 3-way", Tables 9-6, 9-7, and 9-8 list them for a 12-way, 6-way, and 3-way
> > +device-level interleave at IGB.  Those tables are summarized below, annotated
> > +with the subset Linux supports.
> > +
> > +CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   3-way @ IGB        none           none           supported
> > +
> > +CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   6-way @ IGB        none           none           supported
> > +   2   3-way @ 2*IGB      2-way @ IGB    none           supported
> > +   3   3-way @ 2*IGB      none           2-way @ IGB    supported
> > +
> > +CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   12-way @ IGB       none           none           supported
> > +   2   6-way @ 2*IGB      2-way @ IGB    none           supported
> > +   3   6-way @ 2*IGB      none           2-way @ IGB    supported
> > +   4   3-way @ 4*IGB      4-way @ IGB    none           supported
> > +   5   3-way @ 4*IGB      none           4-way @ IGB    supported
> > +   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
> > +   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
> > +
> > +Table 9-6 row 6 is legal per the CXL Specification and unsupported by Linux.
> 
> but is unsupported by Linux.
> (perhaps clearer?)

Yes, changed.

> 
> > +Walking it from the root toward the endpoints, granularity goes::
> > +
> > +  4*IGB -> IGB -> 2*IGB
> > +
> > +which refines and then coarsens.  Row 7 interleaves the same 12 endpoints at
> > +the same granularity with those two levels exchanged::
> > +
> > +  4*IGB -> 2*IGB -> IGB
> > +
> > +which is monotonic.  Linux programs row 7 for a user region and assembles an
> > +auto region whose decoders are programmed that way.  An auto region matching
> > +row 6 is not assembled.
> > +
> > +Leaving row 6 unsupported does not prevent a 12-way device-level interleave.
> > +The specification defines six other legal compositions, all monotonic and
> > +supported by Linux.
> 
> Silly question - does anyone actually care about 12 way? :)  This would all
> be much easier without it.

Yes, someone cares/cared, that's why I started this 6/12 way support.

I don't think dropping 12-way simplifies the implementation much. The
factor-of-three handling is already needed for 3-way and 6-way, and 12-way
uses the same handling with a wider power-of-two interleave below it.

I also think the 12-way example is useful here. Table 9-6 has the
non-monotonic layout Linux does not support (row 6) alongside the
monotonic arrangement it does support (row 7). That makes the Linux
restriction fairly concrete.

I added a third CFMWS to the cxl_test topology so the supported 12-way
case is covered as well.

-- Alison

> 
> > +
> >  Example Configurations
> >  ======================
> >  .. toctree::
> 
> 
