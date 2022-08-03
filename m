Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A1C19F2B
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiHCWIA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 18:07:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F41D31C
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659564478; x=1691100478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HuEZHuNb5ubJXldbBePHm6w+8g8ipeaIS31kfrsohBs=;
  b=JyBmMd2s7fVEELpdZ9hAUFDzqy+WPKqdeJtWB5stZxt8Et35GxuwLs5B
   ogOTFCkwUYWp9wixBR4fXD2lBGBVFORFjufh2z7xkv7ak1F7rg+mDXOx2
   rsqhXDlIRx6/WQ/fJudLTMKYhlq82JlUE896xQ++YB+edX47LKqWERgs3
   LaAjY/HVDRkVPT8F57ndEDgwrCOszM2qZWnrCNL4rTdLMs8fKHV0Ig1Pe
   Zmxu/dXW/2tKEz4fhpIVO+14Ot4rkvUwf6GcKn2YbMug2ZYH/8/TFO+EX
   H5PrTbEwH3GR46JGJm2i7E++g48KjC5GKqXRM0wI5M5qs7RVXU8Q3EaDN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376088251"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="376088251"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="729366074"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2022 15:07:55 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 15:07:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 15:07:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 15:07:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 15:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM0GYZvqeM+VMK/O6QcAA5QLCHNFEzF4z+32b6FyZbExEwsHAmEtsWNJRMPNDRT9jMsnoPXhf2LRNaQWaK4QRbBpkFGswcgtMZ1k+WtBXAWHhCDTaIs8GzcqirFRtQt1oR0mokB47cYDNjBI9gjojFW2IYc4DVoNVEi2yeSP3y58GYtgTjKXkTO4hNlGKS/EzYVZ29YkYSHDSaXCTvk9mFaDlWUWTE7sOKWXY/gZNIFAUV9gnAc9JeTGbzrJH5IuMYS3AU4KrP4J+DHl8Y9d/qgG3dem1soauj00yIn5ZnUSqAG8Hlpb3PIiWxQGC8c8bf2CGw/V7I3i1F6zzQH0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy2zDWgmAUk1dlW6V2uorG1DY9g4DyR5t7EwSY6X1MA=;
 b=YSVbql+S0jndRijqGIro804nBXl+HTJ3dwUZDuZvuk2SywYYoq8dAb5sqIr0aMYhr73lN6M+XB2PakevFODLFX7EuVbPwvZCFXY+bv7FbjxmJb1jrWH52pO0myepgEygQH5JKg0fR3vVyOMswhjeAI7vZJvfIe68AcKmYyb9ZE6yQ5+HxGM+Nxkq+ShuVbbMHsRmsG2c9lwfreRS1Ty1aXE7vJpSmS18UAdGP1XampqnfRBYLHLguw/UJyfPfKlbA5hv9RNcVI4GhhCAadDueYcewEq7SOnShDx+a26/vbESFTXVOzfBXfGHfZVbN3pSofUoNuAwXTJjJdSZPvZnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN8PR11MB3537.namprd11.prod.outlook.com (2603:10b6:408:87::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 3 Aug 2022 22:07:52 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 22:07:52 +0000
Date:   Wed, 3 Aug 2022 15:07:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/region: Fix region commit uninitialized variable
 warning
Message-ID: <Yurxs8Fy0UXgspPo@iweiny-desk3>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
 <YurtcUKKDFUbjJp4@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YurtcUKKDFUbjJp4@iweiny-desk3>
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e99d743-9de8-41f8-d0f8-08da759c9c33
X-MS-TrafficTypeDiagnostic: BN8PR11MB3537:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abVa4nhyfV5enGkeF/jwHhCuYQlf0bX2qx7OXzWpUGXSupIRf/94v8zGXGbGQYTo5CqriakBVonuWeKxU695TQkslhuHEhy9voy8NOY4IoZXdkzMp0us1ggu8RBrnSMsnusyX4rHRPTAquh5+UgpqQ/7hPoeBP8MVCCseIB4ZOg2cA+SpHvwSfbBpsIocMCCA7oLBL2GUmEBinctZwhSB1bqVkue2AEpN86AyGRcb5c0I53b03/x4E/UI8UPaEQKVMZwlwoffs6+q2/jkvCRc1Fonw6TPCDjnwzLl9xtihkXQoivCR0mOldy1o+eGx+Bos8Qyzjv5kBFjnNTrHLXHf7Ptlw1kY714efcZhWhHP9MT/f/klCVyvUn6OEYIEf2vYPw6U/3X/I9Ikm05eRjDgUyKdLrkZ2fHlRtPibfE+qELqRc5MtuN3P8XxwtDx5FAxRFu8Z5edb3qHBmtdBgbVHU3KMkIofrXBleeGs8dpHsF2WJYoFq6oEMFZovUoG3t4s6zSkov2XN+4ggtsatfSCUkCnJ/UTE40Tq2PX/qKsiiH96L48Ve9z1uG8LOHUT+ZSriE0cAABxYyYQO+SHNT8dJPGYqv3ssG00zgDDFhWHe5a1onApZXD4UaAtwbL7FSgTzGzFx5UYHqt7PtP3WNjfrSDr60hJ0cbIfcjK+fSnlGNMdcHWxxOfC8X3J6h1az+kCVDnpf2e7fbxcP/ohO89tTr2MAAvxOrfiGxKo2XPEsXS7/lozid2DmztEJK/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(39860400002)(376002)(136003)(396003)(83380400001)(66556008)(66476007)(186003)(107886003)(66946007)(44832011)(8676002)(8936002)(6862004)(2906002)(4326008)(6506007)(6666004)(6512007)(9686003)(26005)(6486002)(33716001)(41300700001)(82960400001)(478600001)(86362001)(38100700002)(316002)(6636002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6A/GoCxcM9BhtxhXlT/g2c7oSXmlgnb2MVZ5QEqkWlPHZzFZ2YNFLSHVWy6?=
 =?us-ascii?Q?72CZyVFZeWKZBvi8vcC8F7RCB9TiWrKTJqYJUdwLRrX67FUHe0LSYJ7Hb+Bg?=
 =?us-ascii?Q?cUWVnNCv+5b/3rh+Kb4TxHyYUMd0KpjlzWNz4jL8x2iaSCA25elvYX857T1X?=
 =?us-ascii?Q?k2X8SqlWkKEM2klxSKtD1+wT3scwkgyb8DiBBE1dTbo3PdTpT3YvAqHNAJAM?=
 =?us-ascii?Q?VK7qfEFI+yXiuz7iIz3IngV3o778urCbmE0mBlKd9i7qvED8p/Hu3L9NFGnY?=
 =?us-ascii?Q?26/+HYzgzCvrwGRvcG/rn2h3KsgoQg1q0TgUAtrDqgLxjIF1PZaw7rE9J19g?=
 =?us-ascii?Q?qtjHVlWIpB0dx8yxLFx1Yc+urCbZV9Mg+rVmm+9wjoBr0Tbyur82gkfG62Uk?=
 =?us-ascii?Q?EOqN3/TA2kdESreWoXliOJYg8X+I5pom/kJfX9AmcDRtXyoX6BOjReB1q2rQ?=
 =?us-ascii?Q?b0YKxMOgCU875DOIz0zjpUkIMEWlxJdOCCVy9YaHHYvLaCBlW35AxWu+eWjM?=
 =?us-ascii?Q?KkrgopXwl1d9iifzuIj0hQFRbaqZ8NLEzxsL0/F8/DwtK6YEbMBBfR0pLuQq?=
 =?us-ascii?Q?j+K4T2PXfMDF8fIdqxJaGJb7VbCvcZD62hlabuCUGP4DdMHZAeoSZQII3nqB?=
 =?us-ascii?Q?TbjXWBDNqnwecUTM2NGZsqdqFUid6cVB0BHEhtnTRFakbIp6QNyQ3ViiQuh7?=
 =?us-ascii?Q?mskjM1r+7NtkZuOsfd+4od3nu+wAbEl5BdCPct/R4XAL3tCG8JQUOBOucb51?=
 =?us-ascii?Q?2viEHzP4w03k9bd1pald7JSST7GwB9JO8Dv9sdB0lrB5H8RWV6zIFuad0jFj?=
 =?us-ascii?Q?pdST52Yo4nqfAIB5la1fchV/O5cyRRWxHMRe0WtzHKf6m++6aHNLNYh+bjwN?=
 =?us-ascii?Q?mYLoIXM8C81lwjmFgLi2MpSG0piM42jGsQdCRBZJgW+wWrkwxP+f3G79Rs68?=
 =?us-ascii?Q?Ddbkzz7+5JlTxapEmfF6iSib3vdmLeCSuq/6Ez5+ssgTbAOPRZAjSvoDtPVM?=
 =?us-ascii?Q?XmcP7pz5iTgALWvX8XLwJs8FMLYMmn2jvgxlH8WJRJ/L+ZoQFF9QjpBR87nk?=
 =?us-ascii?Q?i1s/8FHUmV5dfSwGzrEdMEMC5jwxgeo/jeJ3rCMhMZzraa9+irAv0wYqtZqr?=
 =?us-ascii?Q?sVsQ7w9K0lrJa0eE97F8Vqo5NvP07t10NGITa2A44jWCT1d0+jhN61R7iH8e?=
 =?us-ascii?Q?JHN73rD2YPq94Dvg4hQ2v8pTJj1T8O+GrNVvclTxb96XFD/bpaSKLqzeCnCX?=
 =?us-ascii?Q?AOci+H2lUDq7LRJg6BTRMSDEIbonJv3Ozvk6zZfgh1gkGKVZlCPXvahyOJos?=
 =?us-ascii?Q?OF62Nno1Scf1ttZyWzPYepCWrQajbIe4A+yWj9lXGZ/MC+gcQYvMD8vQytYi?=
 =?us-ascii?Q?n8V+p4RXHwgxAEuZ90nCPcRknQr/xYQj773jcRgT+AxZffNqSxX1nYzKjLG2?=
 =?us-ascii?Q?xFBxQhRb9mNP/GZG6RLP+ogjVIDJDuguZNqI0umB+4FYKzIPqWoxVaiv8dEk?=
 =?us-ascii?Q?Y6g+C9oMqt4phCVmdXRO6V0GkvhvtMCGA7wRbOkDtwYn1oy/JybiogNKCteW?=
 =?us-ascii?Q?K2vQ6I4lAA4lLzO3If/w1D2JciMnGvF8flpVz22r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e99d743-9de8-41f8-d0f8-08da759c9c33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 22:07:52.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egq+ME3wjvyuVNEANzSoQF/rfDzg5iB90zTdnShu4BV7dLx5o2WBTaAmKWmrRvrvYyP5sxhPFthSOiZGwheuTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3537
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 03, 2022 at 02:49:37PM -0700, Ira wrote:
> On Wed, Aug 03, 2022 at 12:24:41AM -0700, Dan Williams wrote:
> > 0day robot reports:
> > 
> > drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.
> > 
> > The re-checking of loop termination conditions to determine "success"
> > makes it hard to see that @rc is initialized in all cases. Remove those
> > to make it explicit that @rc reflects a commit error and that the rest
> > of logic is concerned with unwinding committed decoders.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |   12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c931b6eb4e7..a68e4e0cf169 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> >  static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  {
> >  	struct cxl_region_params *p = &cxlr->params;
> > -	int i, rc;
> > +	int i, rc = 0;
> >  
> >  	for (i = 0; i < p->nr_targets; i++) {
> >  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > @@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  		}
> >  
> >  		/* success, all decoders up to the root are programmed */
> > -		if (is_cxl_root(iter))
> > +		if (rc == 0)
> >  			continue;
> >  
> >  		/* programming @iter failed, teardown */
> > @@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  		}
> >  
> >  		cxled->cxld.reset(&cxled->cxld);
> > -		if (i == 0)
> > -			return rc;
> > -		break;
> > +		goto err;
> >  	}
> >  
> > -	if (i >= p->nr_targets)
> > -		return 0;
> > +	return 0;
> >  
> > +err:
> >  	/* undo the targets that were successfully committed */
> >  	cxl_region_decode_reset(cxlr, i);
> 
> Doesn't this take care of teardown now?  Does the for loop even need to do
> teardown now?

Never mind I think I see how this logic is the same.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Ira
> 
> >  	return rc;
> > 
