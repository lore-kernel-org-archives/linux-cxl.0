Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BC3AA196;
	Tue, 11 Nov 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865635; cv=fail; b=ADZGeSgUe+L+YveJs5TknjGZczNhkqiLoPAf4MM3XXMQr+fc74QM1rdQwJ823R7bI0gfQdabaTxKGvQoMZQuTDR0IOsceBQpv9hbvGwno8TiM1LpTcUn4beXY0J5T1s2A5RTlvluUmVtMqdk07kkZzz0rCpGLN61Yz+SsfovTjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865635; c=relaxed/simple;
	bh=KXdhWnQsoqrWrSkN2fyTahe7e3XsFVCZFJn5Yi7D07Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oHt+R0kb6FoQXKDnT8xFN37oh2TbhNKLL1w3lKmcyEghZ0MK79X5Q3pvra0Ek303wfZx3+5wtB+OWB2D7hUVRb+OAWdDECAvemEDOvm+5fh6e6ec8aVJouRMkhtspq8/7w60LICe2dykBG29EG95UMsjA2l91nyhTKumVQ3JLQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kTSD/4HZ; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kTSD/4HZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCgltsRHzhJiLysDpFZiDFSzlwK3DTQzLvmFLCh0/qLW/gRY3fOVt6saD9I24CI/uzL79RrTjCmXmNsZzCNGGgjG+cSLtT0eC4wVGuOnxV+UzHxVvPpBi9QJy5j1GQjja0QykXqFKuMOudIhpJmYLKGSjBzgqJB9rzC1XIlSzJrzpNfQCu9I3yXMO1XMRWNR7ft3+dEcYCKM+hVqfZ8XMqmvj2RIm2RW7D0yLm1ky23dMF9piJ7Y0Erk/k3Uov76ZQ6fC4p/3KiDRLC4y73Dnn2kcfQNnPHY5MVECNFJri21p9woaObwNMt0a6iqtJ3T9CqAje2KUv76CGRGQfQb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCVmHMOtMcuQpJvFCdwtQOYCo+/BqxWDV4X11Q8serA=;
 b=rx4BNKlrRwElAALQRpJTojb+aLt3r6LVcDtS+qnA2aKxTz5HGtAQmm6bXIZLuxcIfPVM/ClW00m7MynwEKYQ/Bn4BFMc+rrFQv6A8sUJ8xum+p13MCWQtQa5JPRwxr4qCUYtKGvf/TmWTGkwkug40NsZD3slenhA++g4WdpbLg6O+1Ro0eEM3rSnjsr3bh/ROz3FcQ5HdCveRZ2O6s0yNU1hnnpYq8LxwpOdDv/KrF8HhYxCQnnlWx2zr0cujfXFH8FoMRp9mGtgCU/YK54jUhogGRPBgi1DK2OeTJGWkDe+wdsa+RFS4KJedR7I/cljLH42WCwT2VWPExf7Pb02FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCVmHMOtMcuQpJvFCdwtQOYCo+/BqxWDV4X11Q8serA=;
 b=kTSD/4HZkpaXaF2vfNF49l9OuXdJHT7YI7ZXzK9Fz0FppyKiHtO23pFv4Kb3KvHin4qaLARIAaSQ49y2Y/yvX4Yav3eW3yXVxXM2A+bJaQbRjc7FF+SQ4lSbRwGHW57Ryr5kZPLA7dB5SZ3tkJg3S5neiGT7vODxMJhP2UsJPFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:53:50 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 12:53:50 +0000
Date: Tue, 11 Nov 2025 13:54:17 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
Message-ID: <aRMx-YYhaouP4LvR@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
 <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To MW6PR12MB8758.namprd12.prod.outlook.com
 (2603:10b6:303:23d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dd6aad-f815-4d9b-4744-08de21215c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9Aca4lxX5F46xQDoljmg/QVQ+c16zHxPXBrsQBruE2a5bW+M/lx1KqV6MLI?=
 =?us-ascii?Q?YM2SScsvYWETjQHvbrHQYwf7+pqpmQsyr/zHvIu5yL4NE5uxnfKw+1Jlpy9d?=
 =?us-ascii?Q?ADbEO9FeQbBtm0GdcEUSBYI9J7hpMWxPVdQgkTa8WZM3Uke0/4Bf9rKKO3P1?=
 =?us-ascii?Q?gqMce/0+YKmafL7gJs/0Jr41Bzm1sfVWK3ierOXrDSOMuubn5kW+o8MSE5EW?=
 =?us-ascii?Q?pg2HrA8o7t5qxXr/5jCP0PmFQ8ruiYqOHMDUPgFyWRxkkg850NHRbpum+ie3?=
 =?us-ascii?Q?6mrJGplBqwHNwERpIKUDo7ejC+DsrEeH3IqWlspGOIlyTMl2eRv1W2x4C7NG?=
 =?us-ascii?Q?aragJ5KeDwvL2aFLs3F+SdvCviCk/xvy8M+TSt0iBOAxFBgvl07SpmhKCk9S?=
 =?us-ascii?Q?QgtQO1uJtu7dvqmuE9kJBA/LF0icuoMAFJ1LuJyw0g/pTb2a3fjEW6yalDa5?=
 =?us-ascii?Q?gGS8+Y2Ih5xM/gAE+8C70pYAPnjsOMS0qEJ0hqwsJkLmgjCAKpBSStj6Klfv?=
 =?us-ascii?Q?y6/eE1tz4n/5qpfPaZurI17C5wzdZ12KNIh6VSt3bS82prBChlkgfn64le8g?=
 =?us-ascii?Q?/bj/KJJ9E0KSyssFknWLHXs31VG7whOSfql4o2KVWQoGGnz6tKcTQZp31TRi?=
 =?us-ascii?Q?riY0hVj0+LSeaaS9XWQhC4T1X33bDDcl28IpEuG97IA8D0yeomBpUYMSPOYw?=
 =?us-ascii?Q?cawlKv1O6mxRj9G0H18uzCfgORrzk3/qT2YaMqb+Fk1pIYlqGdEuJNMlhmpL?=
 =?us-ascii?Q?CVJ/R3j7/erQaMt1R9Qoo3orJJMazfC/gKji61ySYm1i5obj6snQd6h1KpJ6?=
 =?us-ascii?Q?xks3Skb3bwjQvHdMlTdJt4TvC8begl1UolQfUapGnqeZ6MjQWjjRNQULygQy?=
 =?us-ascii?Q?ZsBbC/vF9WnSgrxcqrLyfKKzTWZ7lvfGPGrKQfsTScEMg4uy4JrZmmzpZX4Y?=
 =?us-ascii?Q?71f11YKrS9Eo4dNPOLODrxfiL5st5oOZs7l7paIhmr73nH2RHEyP1IOxfm7c?=
 =?us-ascii?Q?YFZsfLXBlJuvLEz3iQ7DnEg3n+POuyyJiFJDuNlPKjMrX6ncA065oOnzJ53L?=
 =?us-ascii?Q?Zx0x1ZfilSBIyqyBYcP87b30rEnpNFNAFC1k0ifk87f/aswC7O9uXsNL1W5Z?=
 =?us-ascii?Q?iJxRVJrR3xSxNv1tW6E26E2N6z/R62oVt1RUmzlUfuEmK2BWp+N1yhfDrIkJ?=
 =?us-ascii?Q?Abeohs6hNEacEdTXBny3X+U+Sn1TQVZhOkTXoYxD2Q/kIy6apMsQJb1sHyix?=
 =?us-ascii?Q?LQt1+bswFJgSULzKdYcFJARCIkFrIkkQ27JFTc3EigFiuC06ybup14STycKj?=
 =?us-ascii?Q?odTkLrRkYMUez4D2UK4g6YdiLG+jM8Ojw0oojzsLy2VZdvBaQqvm5hZVlkgl?=
 =?us-ascii?Q?AYERcVB7u/BYTu2EWD7eleETOuWcNpGfNCGXJlSeu/K4qZC4/TSx5pm5TPUW?=
 =?us-ascii?Q?iZsqWbbCglF8AIPL7pu1SH/4VG/UA6sV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jq1exHZ1zPGTOt0y/6MO3UbWP4S6E4tSzx08dhMsZIDx9L6J/XjmwEZ7z93j?=
 =?us-ascii?Q?9bwt/NLJ13H41LqjK6vIxlSXQjjBR+xQWyDJs3XAMVmMSitvEEFbMVlUQNTq?=
 =?us-ascii?Q?fkY75fmWKsP8dc7MUZVhq/jGlHciUAlsXp6CLxY9OW85yh/vBd1Gs6abLErH?=
 =?us-ascii?Q?M3+vQjMUKBuookCLb8kT3PO+uxJzijtLiJ15dGWdkgnMXZehk8HsG44LRLA8?=
 =?us-ascii?Q?vIzddBWoeYjHVKXwnzsCuHX2iWG7lZ8k/I6fI+71ePT3KVKFMW2Gyc75dSYh?=
 =?us-ascii?Q?V7R9cyuOGwtLor4nBQ51glfNhSzhj+3JWJGya5s5v8rCmK+2SSa41CLm70xj?=
 =?us-ascii?Q?SA3PMxEKlt+lQF3UEs6SdS2VzJB+VujsWgTgmFd1Rm7ridvTFyTz7WtkTi41?=
 =?us-ascii?Q?YYwVk9haIk5XWUovGjItwZSW8xbJ2ULHdsce6chIVGNXOy2dzP3oMB+pwe/p?=
 =?us-ascii?Q?m4ghybx+8k72o98UlTgWQX3LmT9GM2veL++LGl+DbyAVLHwQ3Lo2CqMAFdXM?=
 =?us-ascii?Q?TZDXWXMC8lPk2pOQWyUCuuhsSV6Is+Uj0uV92gSLqyKvbZw4hUbKzdJ7oRns?=
 =?us-ascii?Q?aXAT+btiCUyHfPGhU6iMyeM9Svr/tewRClS5xrtGThFddcfdrePRMSChEb0S?=
 =?us-ascii?Q?S8+6bKjGLb5ojzptnS86uP2mN7yxHKP4yyuvo4qo/WrBHTvaNWIXqkKhhMG1?=
 =?us-ascii?Q?KdRJYKVqvk2L5EUiyB8XuleFIdgaZiFcdQN+NX7iB3p6ud8347F005RtJfvc?=
 =?us-ascii?Q?nMECjWUhdVRQcZMwwFEvPrYwRoQL2oAPfPyDRMpcKTbPTlCrDzb4O9LhIki8?=
 =?us-ascii?Q?cCSmNZrt39JLL0CLCz/K7Rz4kEEUG51mTE2cfm3NYvO5DeOP3LecUr+VE9Jd?=
 =?us-ascii?Q?AW/43czAR4a0FtPPSbbvjIelVby/46WFdLaVu8DHKTb6d/6X35MEboc1L9zG?=
 =?us-ascii?Q?PAs5hLJZUIC39Rt2gi2+vqm2f9NUBUMAamlFwP9+WBOXDi9+icqDRKgm5NoR?=
 =?us-ascii?Q?HjHhTpOmNCqEduYQJnYY/dF5kQvK/C+jqQ9yctyq7EJPgT64HY7T5FLZYWTy?=
 =?us-ascii?Q?t0CKR1/lf5TJ0AWdXriDlvh3ffYCwxcSF+vqTElQSWvNb1ob8qCkVDcWyUCX?=
 =?us-ascii?Q?9wCkTResZJbej9eEjmR9MOvq/5LWFxQDLg46VZlPk659O0lnWgVX1G5LrJrp?=
 =?us-ascii?Q?kFYXRDuNQ9U918dVP8Qn3ZRyTosRNT8tP39QNbl4Lrnh5hkXWv20lck1C2uo?=
 =?us-ascii?Q?1QqJ+fAYD3BFVj56qLlmN46ukk6rRRJ1H7iPADdZ6hTfYFxMSDVuAepUZ7wg?=
 =?us-ascii?Q?Un2pb/SUGjUDnZ5V024017HcGGXIlWewDtmMz4xzmJ6wriIcc6EvIRlxpFMj?=
 =?us-ascii?Q?KNRo5uwH13iZvAsWFmBjRJREa6rNqyMszWkDSVM938Q61/3Va0nEzO+tB1e8?=
 =?us-ascii?Q?75QfNze6LjZfTO5I61v8+p2/Ie8lt1nrUq5E4bVJDjKZ10wcLRqG7zOacbx+?=
 =?us-ascii?Q?fX8sPtGCFog2tCNg7x6vujX8+g+D3PSBTl6e4yRaVMmSU3jvvXECIVhId5m+?=
 =?us-ascii?Q?tccC19BdyfDsipNKNs00bBZh1WBcxegEun66fYbl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dd6aad-f815-4d9b-4744-08de21215c1a
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:53:50.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0iTP1Cu8SiZrlPQD6YpESvnMYeF/XMEfltQ+FD4eoXXZEdA0lvwm58MuYAXCkjJX4RCuYHLVRnzG7oOIS7o2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

On 04.11.25 10:13:34, Dave Jiang wrote:
> 
> 
> On 11/3/25 11:47 AM, Robert Richter wrote:
> > There is only support to translate addresses from an endpoint to its
> > CXL host bridge, but not in the opposite direction from the bridge to
> > the endpoint. Thus, the endpoint address range cannot be determined
> > and setup manually for a given SPA range of a region. If the endpoint
> > has address translation enabled, lock it to prevent the kernel from
> > reconfiguring it.
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/atl.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> > index d6aa7e6d0ac5..5c15e4d12193 100644
> > --- a/drivers/cxl/core/atl.c
> > +++ b/drivers/cxl/core/atl.c
> > @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
> >  		return -ENXIO;
> >  	}
> >  
> > +	/*
> > +	 * There is only support to translate from the endpoint to its
> > +	 * parent port, but not in the opposite direction from the
> > +	 * parent to the endpoint. Thus, the endpoint address range
> > +	 * cannot be determined and setup manually. If the address range
> > +	 * was translated and modified, forbid reprogramming of the
> > +	 * decoders and lock them.
> > +	 */
> > +	cxld->flags |= CXL_DECODER_F_LOCK;
>
 
> Feels like this should be something the BIOS should enforce if that
> is the expectation? And the kernel checks and warns if that is not
> the case.

I think this is more a limitation of the kernel implementation rather
than the BIOS. The BIOS provides enought information by CFMWS, PRM,
HDM and PCI topology. In theory and if there is demand for it, support
could be added for driver region setup.

-Robert

> 
> > +
> >  	ctx->hpa_range = hpa_range;
> >  	ctx->interleave_ways = ways;
> >  	ctx->interleave_granularity = gran;
> 
?
