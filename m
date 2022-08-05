Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282FC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiHEWy5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiHEWy4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 18:54:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377CCE0A
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659740095; x=1691276095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y+2mW9FlkNQN/fO8xcy2J+agnE4mvuQQiK2IC58kBf8=;
  b=T7K6gqEjbGXT69W0FBUAu9HBJxTSv1DKXEnpC9ejsr0R0T97F+zqvotJ
   HQLkytIVM9Ujxm0qAdKMpS480yFnNPsCrRh8L0O/8oI7j1rois9QfIon8
   wf9opu4K9U4Tqor2tLAIPVHAg6X0bdwK25//gygnte7/W1Jwnnx7gwktW
   sMI+deslyjaGggHK6rxxLnPy9xG/PA2VpseGJJDwBWcD1ivcYzkn3y+CT
   kH0jxvnyjS8GufDWpwnPVfRohP1A8SM+buu7K9VIw6WD8yTZJrKv0eKhW
   MmkCIVPBWrskHIcZjpWLgRjbvKt0SWLyajCnlO3eGl3N9Xdl32wW/c4J+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316204463"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="316204463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="663176981"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2022 15:54:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:54:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:54:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 15:54:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 15:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noxcCi7gZmS7Qx4wBGgvT8OW3nvHMGJ5eEH2H3qsFHFl59+yYrt+nuYcWPjbysDsikOfZJyM83T8D0EEc78hXnmWBFgo3PVnMnvt/VpvyMwfp3CKyX+BwNjLmLxLPf6Xtz7VYrTKMMOsE40cfbsvCisfraoghAuTANsRISwNi7RdNUPgkmCgGSC3mzrtQYNKOzE6yG0Zifp0i2W5Imjg2cXvBfUfoY0AjVDgl27veY/UDhQ5mifXgF0kxOcXQJFNnOs12HyOTZ2AcO4IeANPpdrW5Us/nwLzghZq2B8pc4w7o/K4+kzraC8k9yRNplOFJ/lriuEhgMoSx+TS1mBc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRHNqkRRQJI0j+QcmWGj25mDucFub/JMLWjSbi4JnG4=;
 b=ltAdAeraWSwilXH2XGDh1X1Ok/cqSq6o2ae9SjaUXWTngY9Id5O7TfEyZDTQfd1i1wjlRP7cYzS+olNB8Jn0JfzC3jHHTPVQfYKneJs11FH6JmwwE2VKt1LhldfhrCLq1t0Ds86J1eCM5Psiep1s9vLDLuKg8w5gRh2tUEdzmzjykJHN8dqX+OfttV7yJXJLHwLr8OWbwQ9tBZIjw1pLUojQZVEBD10nYJsWDzosLBLtUrKk7P1JPJB0qJIOfM9SNsz/t29h3PSelXJcpQFlQS4e+JkBkK9PSXqRqt4IgXciAf3bLJJ2q5VrmyDY0ePI8DXsbDiCYIWbXdKhKA8xkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 5 Aug 2022 22:54:52 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 22:54:51 +0000
Date:   Fri, 5 Aug 2022 15:54:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 3/3] cxl/region: Disallow region granularity != window
 granularity
Message-ID: <Yu2ftysB2z6X8pJp@iweiny-desk3>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
 <165973127171.1526540.9923273539049172976.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165973127171.1526540.9923273539049172976.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a032e4ea-8c74-4229-b3b3-08da77358183
X-MS-TrafficTypeDiagnostic: CH0PR11MB5561:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFwLak5+rTCSfWU68dKZ2S08M5Bf6UW9a4PDWzKi/ZgL3aADhFh7INni8mHWpJkGNvLlDPnSwr+fTRM8Z7a3Es6tzvYZNKtlVEuAmGLlc+vReEHEtBFHDZ6qLub0yHZ79TRFpvfmqodP9So2f3Tj+aNgXaW+91kfBEaICkFSEpLYPKhcAvFCaPFW/8H4/Le71fc6MiY2BQgW6jOj2R9HaQJALPM7hK6qBkQ0/RmQIMjbfC47YJOSHUPnUFjLrTK6cq6jWlVV346CldQubAFZatGifMEgdgYnbktapnSdW65gnzW+WtnYEH4bowVkVQw19+Zo/E48ooYMgcroVZmJoffUHVtnnNJlTr3h8GBAa4TUbWVZTgnBOMm8zBXTz1DdEw2EuZ5PyQxw/GJZSaUOkGg1NXXTbqlC/HCkX2+ygDxSsFH5OzOdROI8SPi4CoJyLBHdkFuG7opzHss0ehN29V4htmQO6EAxo+bSktTAmzUJxyqrg1Us2HqYtMUBlTYGEWJrXJRGnB4KLCAFgUX2f1B//2htBQPPfxGBXFYAZhvvu0QBxl1yUephnC1X5rSUA96hHm4cZcQKX4ApFcbRDTP3ut78rU/3hhhGge7qC/vTGgC5ZPnAHmJK4W4qmqiViv5N3kNBMbWosdi2zpMzpgncIkTuxS8RQMgHz5GN+vTT3NPqsT+5eKhcoPij9aitBE912FGclv4Jw91N/5nPYx+wofQRyQC36vCgQ91x1COt8wbs1ifrcTUetT24wUVb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(396003)(39860400002)(136003)(8936002)(2906002)(83380400001)(38100700002)(6486002)(66946007)(66556008)(6636002)(316002)(54906003)(8676002)(66476007)(478600001)(186003)(107886003)(6666004)(44832011)(41300700001)(5660300002)(9686003)(6506007)(26005)(6512007)(6862004)(86362001)(4326008)(33716001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Go2xPEiMznAoXvtKXHytc7eJL5fPq3COvV6KKJeb2YT7cXymaWVtgspASZp?=
 =?us-ascii?Q?Ca5cT4X5gu9YCZ9i07znljfPlzfr51KfRsoJ4noUCfNnj/DEYBsn4HauG8gU?=
 =?us-ascii?Q?WsZRV4q3SeA4Bz/I9ene+hTffRDIdBAzIbVEJ3XrgIm8R5xJyvmMn8SH2Vk4?=
 =?us-ascii?Q?s5Ejn7Fora7kPz96abYVHgjyUkDsALe2xizWwO8wlWYFlw+4ynbFzr7WKe6s?=
 =?us-ascii?Q?yyu52PYK9SwCBD3kSkkKJzqJ4S6SZgECsZ6/zf8d/nXeRKZc9pKjTLQ9Hx8C?=
 =?us-ascii?Q?ZjgXEJMepbsB9IoPQHABP77YRz9PQ8G3f5JWKB1lsZ/0HpeIMqMbBLg/z2+S?=
 =?us-ascii?Q?BolwGJqoSYq6viFHpd4A22m4LZt/W3qFxyHu6uiqediTuGULhJ+Gm8PT+tdo?=
 =?us-ascii?Q?OVbATz43T3eOR+8AS/l/bGO1IokGfZyuuHgdyUDmfqWU39k7T0pActWQgSKT?=
 =?us-ascii?Q?u+/QpJYa2dacmh4Rzz7DOxiI+2ovQLO4mu0d3GOBcCcDT5/mUdbel+V4FRXK?=
 =?us-ascii?Q?hT6nz39wS6JJm/ES7X8tQKhHX1VF1VtCOq+Lr22xLuRH1p88Ri1+VmIOEbp0?=
 =?us-ascii?Q?ODc+BK8FaFMGKvSGjiIXStTF5mBPAiAUaaA6HwipgEyGtG1YTfyNc6Il8QHo?=
 =?us-ascii?Q?KPSaCzwdJmqiDCU9nbrKofoflTn0nIJJp4O+/m9QfCemSejEpyBYxSm8qQVr?=
 =?us-ascii?Q?xIVvYYQDMKB7JTfXn7MhnX78nJhkMtwR+l4zd8dvWZYPL4GX/jO+I15GrAJd?=
 =?us-ascii?Q?Q0fiVFAwcn2Dlx99SmNLkjm//VDO1KvK5VgGYa+7A0UMU8iTnfRhoJ3wqNGf?=
 =?us-ascii?Q?Anpsh4F+8iQA1nrsOqckLNh2UxsI1CwmsP9lXMKO6l219tsdk9AcSu2Omgwo?=
 =?us-ascii?Q?dGpXP4ItC/L1l+SAu6xKbU53AnMiel9ckFX3D5NzY4NjYQGu6b6hPpC0VA8p?=
 =?us-ascii?Q?wZfak0EuUQIbDUIWHmiOcM4GjpP8jcPjI5KEU9KGjmtBq1X1YeEr9M1p0nvM?=
 =?us-ascii?Q?mbfAlRT/r30k9Fs4nf1hRC/qHdOamSkx1+Y/Brh90eEaC0A36PV7NOstnQFu?=
 =?us-ascii?Q?5WjRs/NrTR8ATm0eDkvyPhs55mhThjmhiY+bYLMI1yH4ymKiIWX2qWCyoeUp?=
 =?us-ascii?Q?mlS+SzgLQ6wkbpD3B2+OXrDWsUmHn9XP8feLPkxHf5KMgMlpG21/dbbj6nEi?=
 =?us-ascii?Q?5xziu3iwpi09j/j8qW4CSiPqAkU44VpKeX+9TyH8YsVxSWQp/t20ABK1E/TI?=
 =?us-ascii?Q?O1600rYfsal0M6eLvEIgn40TnyHa+sYcsAPUTycHpC2engfhz4Q75rrVwN7R?=
 =?us-ascii?Q?+w207Sa3HL8OidDyu45k0edxO+q1Lag03oVRCSbAtNJisdd7WBwgy3ZsgkYG?=
 =?us-ascii?Q?D7MPz2F6rFEMFSzTRpjGUOO15NGamgTQrNjBz/8tHtcgBgYHoiniE8owAkh7?=
 =?us-ascii?Q?YUmr7zCqWR/m4iggNt2pYW+uHVo3EGfahoEyM0stPbQ/WRVCMG0y2uqGHzUt?=
 =?us-ascii?Q?qQp0aTeQzwooVAYDU+W6B4uJ8O5bSZQWqF+MVuCJSSmb/G9kbs1B1+33sM2F?=
 =?us-ascii?Q?LzhMXDan1Z4HWdWUVAm4O6MRRZ9p2rw3mfHzse7V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a032e4ea-8c74-4229-b3b3-08da77358183
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:54:51.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue6Btis31e2ziaTbCKrQaiqqQD0hj+wC3LTk36fCfIk3EkkAyQxxg8PdZ4alyqhfUqx9NBPr5aHCVQSQXOxO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 05, 2022 at 01:27:51PM -0700, Dan Williams wrote:
> The endpoint decode granularity must be <= the window granularity
> otherwise capacity in the endpoints is lost in the decode. Consider an
> attempt to have a region granularity of 512 with 4 devices within a
> window that maps 2 host bridges at a granularity of 256 bytes:
> 
> HPA	DPA Offset	HB	Port	EP
> 0x0	0x0		0	0	0
> 0x100	0x0		1	0	2
> 0x200	0x100		0	0	0
> 0x300	0x100		1	0	2
> 0x400	0x200		0	1	1
> 0x500	0x200		1	1	3
> 0x600	0x300		0	1	1
> 0x700	0x300		1	1	3
> 0x800	0x400		0	0	0
> 0x900	0x400		1	0	2
> 0xA00	0x500		0	0	0
> 0xB00	0x500		1	0	2
> 
> Notice how endpoint0 maps HPA 0x0 and 0x200 correctly, but then HPA
> 0x800 results in DPA 0x200 to 0x400 on endpoint0 being not skipped.
> 
> Fix this by restricing the region granularity to be equal to the window
> granularity resulting in the following for a x4 region under a x2 window
> at a granularity of 256.
> 
> HPA	DPA Offset	HB	Port	EP
> 0x0	0x0		0	0	0
> 0x100	0x0		1	0	2
> 0x200	0x0		0	1	1
> 0x300	0x0		1	1	3
> 0x400	0x100		0	0	0
> 0x500	0x100		1	0	2
> 0x600	0x100		0	1	1
> 0x700	0x100		1	1	3
> 
> Not that it ever made practical sense to support region granularity >
> window granularity. The window rotates host bridges causing endpoints to
> never see a consecutive stream of requests at the desired granularity
> without breaks to issue cycles to the other host bridge.
> 
> Fixes: 80d10a6cee05 ("cxl/region: Add interleave geometry attributes")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 641bc6344a4a..401148016978 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -395,13 +395,14 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  		return rc;
>  
>  	/*
> -	 * Disallow region granularity less than root granularity to
> -	 * simplify the implementation. Otherwise, region's with a
> -	 * granularity less than the root interleave result in needing
> -	 * multiple endpoints to support a single slot in the
> -	 * interleave.
> +	 * When the host-bridge is interleaved, disallow region granularity !=
> +	 * root granularity. Regions with a granularity less than the root
> +	 * interleave result in needing multiple endpoints to support a single
> +	 * slot in the interleave (possible to suport in the future). Regions
> +	 * with a granularity greater than the root interleave result in invalid
> +	 * DPA translations (invalid to support).
>  	 */
> -	if (val < cxld->interleave_granularity)
> +	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
> 
