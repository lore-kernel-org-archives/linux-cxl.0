Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64404C761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjC3SZS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjC3SZS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:25:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A6D517
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680200716; x=1711736716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9V6IbwW5fKh723uay3pGDGj2iW6AF7Nc2Z3kL2vagfI=;
  b=Ufyb/LLlAsTg4OS7fkJr63nBaLa5jCEdZfzyEJeQabalvndjw2oLx8eU
   mVC+LRTLL3DCHjPqorKG8M3X81FlfMtnV/IGVI4B8vsV1NCZWsOBb+wQb
   OS7RT34vMQumzphoK+6wewXbNFWUaNmTrrCeKjed3Lu1lDt9DQNvNS+VK
   T4AGAnzjAyn2DyeWiNKpl62OJSeeX0U5dov5flUiQ9K6EsuzyN0PNYHAP
   WXUXoMljM2JM1TIciPmDIaTu/QnzTj3ZhiY0WXrUIOTlIYEAkCl4DG7fQ
   cegGhlc0N2NykX7LkV3zlfsq2/xOFmbdPAZ7plCCT8Jpspbqy/OMvHgZ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342896796"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="342896796"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="828417461"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="828417461"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2023 11:24:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:24:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:24:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 11:24:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 11:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OknnttD+TNYweitgTDlP/RPC5feNx+ekw6zivLzjT8504DcBLkKbe1bblSD4714nEtqUnM3O+mtrQvk7/RFyibLYBxtTBX7NGrsB/Mo1uIXi7XDbf5adE2kxJKz5hEwzbqYPFO8vyqc8PjEcbvsk7sj5jxWPU0gG1iZfmRpsjKo5a0GVtRrrkHkzGNYkelArD6SaGX9EPPWu4ERLdsqWC1nqe2MGyYHOdD+vXhqvAqN2wcYM0B7tBIB4ltXiGOG7Pj8xpEDzbDQqMFSq7y3Btz6bchlDuVZJjpY9XRFXoysHdbiYcAXN4d6lCYm64vyds82ng4hWIRwDe+xNRW9juA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3kCd9UytLg0EsDLEklU6bFwObRGX/z7cJ7chW3hGtk=;
 b=VlXbCj3AEOfDsXL3HqmlXcsTMUp5oEw9ZhCUKCrSVFF51qkKJ4j++zEwwYGhhRZr9EjwLcHUyAsucSNn4oZ+KMzOWj8OJBoKITUjv/rnqfBmQ7O9YtQ8nWfj1EQg5Zy25fVv0jKbU3r7kVU6obJ7NTxKwknXyGHcItBFpd8hJV78j6e7hqgiDRSEcl2M7bI0w4XeGkE4QOVL5E/23IOOC1c3FO2vfdxlJrOa2WmW8hGNhmfJJ53rKty4t6//OAGmI4i/Kwk8Bzoepo/9B6Bmbl3ex6EOZt8HcT3BNx3IqfOT18LpD6452IzLfzBrYpOC58O+qWvkJ/cB+TpxqGNASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 18:24:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 18:24:45 +0000
Date:   Thu, 30 Mar 2023 11:24:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <6425d3eb9cd89_c722294a9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <20230330180019.00001b7b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330180019.00001b7b@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: ab54e4d4-340b-4943-a71d-08db314c0996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9lRukR2IpoKNUJj5aNuwMznbXh4U08ERQRp4chiKq0CwU+hiFSAS9uGJi6D/MkgZjGAtJoXoIzDX9bfCixyLaCdcKzAoJB4kSl/3C2FLQLT9SgGise1KEd8NzaijxWbMlXx3nND5xH11E0JPpKalHLAQzdqf/7SmspWsjd69+Tz3xOYktd9Gzg0c9rxNl4f9WHsOBoKx8PTrEpDlcefEvXBgMg9rXGJ4jDx/+9D6iwjz5rmnaQ9qRl4Y/BX5ljZGQgXJ/ZJdHpxlUQR7dM6I7jdEfzKuUJDAOSi2oir1veaBmkiR73IdMJKcrj9p1LGTKuF3lR5yk557VeVS8oUDm8efBJVhYGr+zkncyRsGiWlrCVRflOZ/Dwvap69ri/R1KJCLAfFXV3lp//6yDaPpP9KHuh1Epuljyjk4C7pLxZ/g1SWEAOtFBD4DlOdR5XyauN+fGvbAOwhheqvp+eCNq0IZIwrKEo36fDGvJZdUO0CzkyMRSybHpowZFMQiAF3RiSpldk43gDQVnqJ6wfbVNWHUs6jDMQXMTTY9P+AaNha3+V12Wlguoqmi9syI5kK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(9686003)(2906002)(107886003)(83380400001)(6486002)(186003)(4326008)(66946007)(66476007)(6506007)(66556008)(478600001)(8936002)(5660300002)(38100700002)(316002)(26005)(41300700001)(82960400001)(86362001)(110136005)(6512007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lv3tDs28SSRpvJGixFR5S7asMtTvSvC9f5/vt0Lq5mkkZc3q6beHTRLswTyJ?=
 =?us-ascii?Q?Tokjt/89VpegHb5U1XY07aoj9JmFI52xoOBqiOh8FrB/Iaz55reaiqi6DJ7k?=
 =?us-ascii?Q?/r4+k12PqRJKXPXIO6CGKWarVRFXfl1JE/BcVHW/IX5peCmx8AvatmSeyQCX?=
 =?us-ascii?Q?d259qZbnsSQULHe/JDHGNQnq3U5DcAS07Y2g/XR/HprCW5MnPMu2zFkSSxfw?=
 =?us-ascii?Q?bgzKTeEWWzcoK9RllMkSo5HFj555xDq37iiPWYovnSANkJ2vIWtJHkB57ovl?=
 =?us-ascii?Q?s48x+pre2+gZjLsXOD/IsPRI40514utR5jpLI+jw3MHxqXD2O/A7yTxNO3xJ?=
 =?us-ascii?Q?KMu1qmCCiN50uj1ZmhVM5x7SPIZP3i+tjZrNL+NC3oHbRZXrsWifL6DUkXCF?=
 =?us-ascii?Q?d97pvpdQPR5YlOkXJXzOe1A+ohgOlAP2IFGr4qE5dGdFrEhgCeZHbJSUDKR6?=
 =?us-ascii?Q?7cjIJx3cRX1QgVf2Be9LQ/wmPEeuww7FdCW1GqfesxI/EuDil7rInwCr6Ku6?=
 =?us-ascii?Q?qaxl5BaqtspbpIHX/g1Q2llagFr8NgEQH+ICUPMS1Gujto4WQf0Ji/qrsjuN?=
 =?us-ascii?Q?4llAWOZAqKWUI50IQx3c1sB90dFMU0dbKQWZB9+/7xgBzEf3uDfIS2W52f6r?=
 =?us-ascii?Q?wNDvaSsE4ErpPBEkhWbcLpKQjVbNYL3ikbZqUOCM6832gp/xrh7MCjLsSQM/?=
 =?us-ascii?Q?OJTq/wCMHVJqU90ssjYVSd8rJZVlu2wSbP3qwlYmg9MIZnrIhKh4CLzzcTyH?=
 =?us-ascii?Q?FdXHI2LhIfkdlnsOxOFt9E7yjHfxqLvjnnq6VQ9Y1yl0Ee5JclufvS9wMU6d?=
 =?us-ascii?Q?hyURvgs+AZJ+afHScuVKGilsbNjBegWumO3vhniDqf9hbGujjt7KpJS89/EA?=
 =?us-ascii?Q?2W43hZS+yImoD43OIuIx3S1NvWgTeE1XOElP7ThGP/MbPIYneo/DvrLOc2VI?=
 =?us-ascii?Q?1U4USjVwc8A1YGQBLg1taMlwL3c7MSeTy50lv2n2I7SHgZ21g3RbZT43dvWG?=
 =?us-ascii?Q?loVcsYYZUMNOCib64cT8bspmU9UfFoNyMh0tFCyTDi2fcj3RA4Fkuvp6otKm?=
 =?us-ascii?Q?sZyEJG7r+UpcbDMuYlfz5HUODw0XTMxZrS3YwKb1nnvK+7q/9jlt7+D6no8J?=
 =?us-ascii?Q?gKyXJx/VB7P0kXiPYRRvzcQdgnF4+i+CP2gJUVWnDkR+7R7Imflo9Mlmsm6j?=
 =?us-ascii?Q?FS9KrNBkLbGw774U5f3iQ6n8gOaeHFaSTtrUS4OJwuYm9RvWMgrCbSt1XtS9?=
 =?us-ascii?Q?PV61TLbkoju34K1SeeMRdiuQus4kVwrkumuj0C2X78/OCzaWT1KahdW+blD7?=
 =?us-ascii?Q?//cHw5QPbt+lC3hZTw9GKLjH2h69ryzz/YgPEKMHulF+P7NWtY+TsLSKQvM3?=
 =?us-ascii?Q?ZCfBTp51ukaeukNyWovZGjBk6AassRv+zjq3hzbxE8UbAXVa5szStmwG+0iB?=
 =?us-ascii?Q?P4eACoTJqlvR6NGQMwO5EqO9ehPrPIffUU4y0A35mDUPe64E6d2GTAs3QOR/?=
 =?us-ascii?Q?rHOgOYWVUXKhy2UrJVgN+n8tpvt1tvpI/JHCOlCZtkPdZ6+OX0A8XxexByhO?=
 =?us-ascii?Q?eK/r1deha9EeGZm2YGvWndRcc7I6HUvNhilmYHRHDC62ve4/dnbCdm/YaiLr?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54e4d4-340b-4943-a71d-08db314c0996
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:24:45.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwIxkbG2533X/ldP0kenhJRQgXhZAzgXWbQb5TFmw5CxNy5vypRuBQcSD31KIeItqc0NHZr+mJjJBISwjaGcZbm+YeuXgWrp6CtX3QdOPjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 29 Mar 2023 14:35:55 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > One motivation for mapping range registers to decoder objects is
> > to use those settings for region autodiscovery.
> > 
> > The need to map a region for devices programmed to use range registers
> > is especially urgent now that the kernel no longer routes "Soft
> > Reserved" ranges in the memory map to device-dax by default. The CXL
> > memory range loses all access mechanisms.
> > 
> > Complete the implementation by filling out ways and granularity, marking
> > the DPA reservation, and setting the endpoint-decoder state to signal
> > autodiscovery.
> > 
> > Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> > Tested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |   30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 9884b6d4d930..5339c0719177 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -738,20 +738,26 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
> >  	return 0;
> >  }
> >  
> > -static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> > -					    struct cxl_decoder *cxld, int which,
> > -					    struct cxl_endpoint_dvsec_info *info)
> > +static int cxl_setup_hdm_decoder_from_dvsec(
> > +	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
> > +	int which, struct cxl_endpoint_dvsec_info *info)
> >  {
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct range *range;
> > +	int rc;
> > +
> >  	if (!is_cxl_endpoint(port))
> >  		return -EOPNOTSUPP;
> >  
> > -	if (!range_len(&info->dvsec_range[which]))
> > +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +	range = &info->dvsec_range[which];
> > +	if (!range_len(range))
> 
> You call range_len(range) quite a few times in here.
> I'd be tempted to suggest a more minor diff of
> 
> 	u64 len;
> 	...
> 
> 	len = range_len(&info->dvsec_range[which]);
> 
> then use that throughout and don't bother with
> the local range variable.
> 
> range is a bit odd to keep in a local variable as
> it's not immediately obvious it's an hpa range - obviously you
> could call it hpa_range which would help, but feels like
> the length is the important bit except in one place.

Done.
