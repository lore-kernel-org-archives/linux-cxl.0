Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67AC25B06
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 20:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiHDUgy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUgx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 16:36:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F023AE4C
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659645412; x=1691181412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=spPETOYw2ZsCzWAlH5t+W23O68+KDG0oVeTOCR8b4hY=;
  b=dT6sgFhhqO4/WlVIXliIN1zAxF+8HPqwNNJhwPI80HGz36naBp/XY5x0
   8Wt7ZOrQwYV+245fA0TOQMbuCXhc1bHoH9BJffwR6Zq/RCsruiFMzdWFh
   my6zpiMY0dYKoexoTlUUif6YnZ27UsafV04FqTNr3j3z8m6Bkm6jFmY97
   ZA8r5lUTnwRUU7CddJvioUvzd9LZ1qAOYQhCM6jbNyD9iTOn3cirzhIif
   eUPZmZh8hPsBIMsbsh2Usl7FEGuISqKF4cP2Ez8ESab7E2ki1n/0l14gE
   FOD1IRyn2NVnuLzapLK0LKosV0ajUfZUD0x9WxqJleGkBSJaxL4VCDoBy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="315923073"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="315923073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706341907"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2022 13:36:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:36:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 13:36:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 13:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx0IICVXL0AQCvhO+kFLPGAOTGA2cyqJQL3p1FGQXmcMEabuMjVsYwrsoOaflYIz9/aIOLiYyO4eMcwIusKdLYKaEpfcIJMyTqq6mrPq0hCjgwbpZpp9whMNwRFDKq1CkvG4HPKProWZs4/HMOCA2spmrvMprlYvHCgkJMY8XYI1KpssS3Lqhyy2/VS4R7HywXIiVyzWwiuNZt7Ze8qQEhKI1FmEqkciJZOSdI28Dv7kfW4SLd0hcJeU0x8lGOLEaXqIvRmmXog7XHGkoSYtYJtCCypYQf6J8xp530c8hVOXd385LeNVYjNLE+1bxLvlRPFs5tRYdIuabGAgCfBFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU+C1J9yip3VAVWZt8h0ow7zwJfnRpZ2Xr9KvSOSKJY=;
 b=Y68YW+F4rjfR2amjJ/xhhclacN6pXRbst044lRNkn1JKnhDlgCN0ZhYNDU2CNGsouuCby9DjLQru1DqcG8XoWmg7FO+XHOPzXzJuNqjxGdxNix4CBsEyJFR6gjMdEgd30y6E3wUjVu3C7ARLw3BJOHiaQhSCHYqBstqneKs11CTZRjvtkHVqz1j97tLSCrtuNZlWTBE1zqM2/23WC/lYjgoz13BLuiqndvGqNFVDY88uBJr4F0F8MbPBE95JKLPkVUBeCfb5KLHGv93W2VPwTheZp9Ys2BzygHox8Ii4d5oybiVX1uJlx+g7XNd4RC0FK8tf4aRTZxJX4DNqt0wOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MW4PR11MB6572.namprd11.prod.outlook.com (2603:10b6:303:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 20:36:50 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 20:36:49 +0000
Date:   Thu, 4 Aug 2022 13:36:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Fix region reference target accounting
Message-ID: <Yuwt3NRrUHHTTydv@iweiny-desk3>
References: <165939482134.252363.1915691883146696327.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165939482134.252363.1915691883146696327.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebfdbfe4-94c2-4ab6-60b2-08da76590e92
X-MS-TrafficTypeDiagnostic: MW4PR11MB6572:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9mjP+lHKScT3B9PY9mwOuvfMu1BLxGWr/dHeFzN04WmMsbt7VTuPJst03NL6pjlZleZQ1WOnos0WgcZ2Mu/DXXSPfNzWtDa+QeEfU7TDwjp+a86v4Eox/oHCElNMMGH5lMcIBkESB/SWZ48GvlkTITHXgz95zBT8t+mc/k0tbNCgbo6sM8R8/7wDNeJfJuOYZ7IojROs35kI5bFiV0WZTh1xgqexrobJr3bxYrd0BkutGJQXOJRXMBgBGzXStqMFklpKMzAW86pfbr5/jYE6oeplyIBFr9/dcnO+3Pky7YEtgThDG1vWMDijKI6vZqPxbqvGd54OvxXOTlM/By78Q/8rcSq9uL+l/WSRBdTJHGa3Qs3gRwwkYK5hFo6CPcwFFrpyWG9I7b4GUpXIuIeTopBjnrSDbarMO0yGXrIXFNZcQJNxzT31YxFd0S2vFyoPHa9P5dmERosn3XLNII6abFIBjuJ8Z9yslsi/uc4cS5oUCkEITgFx1C7t+JHqtHvj+bP95Y6jzHtnW4c1xYHPchCZp54Laow+OXueoDcmiT2wXSFPARX+6IEZhrEg1hpxC7IQ6MbB93UeUq9VuS/rjPThfwNcYqRLiSjaOMVH1WttZUy6vA5K8u4wRph0O3ypS6FsedT4QJIOAbHnx9l3JaAsv3FS7eujn5nUwCgKAo4JSl0mB88BE6yPYjSrybsY2/CIhCYDtytyTdVbDxkKgej4b2kVcXpVJEhmWBh0dgJKsAMbrU11k9qeuQUnNmP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(107886003)(83380400001)(186003)(9686003)(6512007)(6666004)(6636002)(41300700001)(15650500001)(2906002)(26005)(6506007)(44832011)(82960400001)(86362001)(33716001)(5660300002)(8676002)(66476007)(6486002)(6862004)(8936002)(66946007)(316002)(478600001)(4326008)(38100700002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCSK9sANDtA2mlnajc0pGsjDb6jvAj1JEHzEEClcGs87vDUAblL4iv9TN6gI?=
 =?us-ascii?Q?0xpqmwrw5tfJyMeun1qK6e9c91tk3pZuJ2KkP/rDsk3ZU8Mh8ZKXYdDsl06S?=
 =?us-ascii?Q?F/frCvzwSP4MOpgiE7FBanF94RZIzcMwAhOr0SsKj5isJQtXorGREL4l7h2r?=
 =?us-ascii?Q?1O89lhMmu7WCSr1np/0HGHNnxst0Ny50ll8xFoTusXVk8w2TMcCU94mFIZc9?=
 =?us-ascii?Q?CUkndJrEv7hBr3QNVkOkbds7CROw4wNuEzQPU1pM4cSYVMNxlnO7ZC9pgm2N?=
 =?us-ascii?Q?Or+NOVOX2yN7WLiRxlW0knZ8XK2YWNAKYymXlBHma8INm80a6Q0PCgSDkhQV?=
 =?us-ascii?Q?t/E4NMfjFwpumfEVjMRXfPr9iY4CkubqdPWvInBqC9zcLxApPzaak2XDXT99?=
 =?us-ascii?Q?AAVCebcX1H58UDM8RA4rE/JVybCf5lMd+3/lOW+yOzNJMJOQMZ4LTcQb/HtL?=
 =?us-ascii?Q?pGRzkxoZvNM8Xh3+UsWsRdpIJB6ZxPTU+TbAGDfQA0jExouHB+/px8oW8FI2?=
 =?us-ascii?Q?IMeLwmBwHuU0OlfRIs7e2FX+6WFFJpvnRfGENh5cZuwKOlGGTVV3VGjatTi0?=
 =?us-ascii?Q?WLdvNkdUSiGDnH+qyBPgoUD6t4HMOeuD48KsHjJ5nF6Ik4N3vCMY7CKL25zw?=
 =?us-ascii?Q?qaftHG529RGrzzK2Qei3GDitAUdDm62UjgzPEJ/cyzyZKE8n8CAZKBRLuSP0?=
 =?us-ascii?Q?H5j/1FrutUN6aaclB3/qA9obUgmNIUPwI6zF7eSiYkIedVK6/EXfwDSCeCv6?=
 =?us-ascii?Q?10fEhqw/xO0M8oq1WjVxAKHIgbpQkhGhRKeoR16+FC3hmLCB89WkhIgSA2tE?=
 =?us-ascii?Q?seUxqR8NLm9y/NpHUlCsyRvlK4wlpa4I5CoYEq0aazix6Bu7vlLxhy998jSm?=
 =?us-ascii?Q?qs7B0r57ubgR4Wz+ecRJ58S74E2Wgi5LReePTzBxXMte9Xv+7EghXCbjeKSv?=
 =?us-ascii?Q?qySu4q3U3UuNne/ZGxipFPc60JByAEKWR8YdOy9lYIFpbF4LGbJIbCAJDSoJ?=
 =?us-ascii?Q?uNqhF0nb8nv180V9W3dW0FKIZHPEHu8/YHULjiPmKVeg3R5R+UDS1eZdZaBD?=
 =?us-ascii?Q?OfWksd/JKMDp0TvPNfaWSHf18/srZjoYhrbPWnrVGD+Qm4btnjWsA5/ZdhiZ?=
 =?us-ascii?Q?UP5X91+fjf5UR/NTxnOJPW2mBczb8k6BuqzpCiwdEgyi4K0bx3uBmsfgkvIP?=
 =?us-ascii?Q?eUhysYA3bpdORrufIu1fPFM4Yn0BrKwtZKoDtttU6YufXg2K2X+9kPQu2BgB?=
 =?us-ascii?Q?nXDXUUgirTrewn/BEIiUEt0n4a8SnqyHfQSnuzSEH3pczCjdD660Guiq81qE?=
 =?us-ascii?Q?TDe4wYQtoyK6IpqYOOhzTFEXhQouSg6EuJwqa/vhM37GV3D4cISVsd8RIt7a?=
 =?us-ascii?Q?kq+xsL2xuen9i8L+iAL5pOMlRTV22L2ajbISMuMPvIq1srYBcaLCVYBJj8/U?=
 =?us-ascii?Q?bm/wTHo+blu0yBOjDQwAKcL2Z0piCRwHnQAyRSaddLUYRd2OVEddbN0i8vJu?=
 =?us-ascii?Q?QUCLvbv5D3Es8vxYW1LfsLy3yl9gIeN2Mi/fhVjMWXSPQpR2gv+7kdqkFlDd?=
 =?us-ascii?Q?9iR8ouz2LeTtrQANPCfOFa9Bl8PHgbwUih8HVGqZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfdbfe4-94c2-4ab6-60b2-08da76590e92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 20:36:49.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0umS7NSbIvFjAorDrzhVKnCGqAK7skDvZ7Q0J3kWu++Td9kvoO4kFwwxbqkPGLmEj051MwYw6Crz1E7f9x5jgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6572
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 01, 2022 at 04:00:21PM -0700, Dan Williams wrote:
> Dan reports:
> 
>     The error handling in cxl_port_attach_region() looks like it might
>     have a similar bug.  The cxl_rr->nr_targets++; might want a --.
> 
>     That function is more complicated.
> 
> Indeed cxl_rr->nr_targets leaks when cxl_rr_ep_add() fails, but that
> flow is not clear. Fix the bug and the clarity by separating the 'new'
                                         ^^^^^^^
                                         clarify?

> region-reference case from the 'extend' region-reference case. This also
> moves the host-physical-address (HPA) validation, that the HPA of a new
> region being accounted to the port is greater than the HPA of all other
> regions associated with the port, to alloc_region_ref().

Technically this means the kdoc 'steps list' is out of order a bit.  :-(

But I like that this is only done on creation.  And I'm not sure it matter much
because 'steps' is more of a list of things this function does.

> 
> Introduce @nr_targets_inc to track when the error exit path needs to
> clean up cxl_rr->nr_targets.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |   71 +++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index aff4f736b63c..cf5d5811fe4c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -709,12 +709,26 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>  static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  					       struct cxl_region *cxlr)
>  {
> -	struct cxl_region_ref *cxl_rr;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_region_ref *cxl_rr, *iter;
> +	unsigned long index;
>  	int rc;
>  
> +	xa_for_each(&port->regions, index, iter) {
> +		struct cxl_region_params *ip = &iter->region->params;
> +
> +		if (ip->res->start > p->res->start) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: HPA order violation %s:%pr vs %pr\n",
> +				dev_name(&port->dev),
> +				dev_name(&iter->region->dev), ip->res, p->res);
> +			return ERR_PTR(-EBUSY);
> +		}
> +	}
> +
>  	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
>  	if (!cxl_rr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	cxl_rr->port = port;
>  	cxl_rr->region = cxlr;
>  	cxl_rr->nr_targets = 1;
> @@ -726,7 +740,7 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  			"%s: failed to track region reference: %d\n",
>  			dev_name(&port->dev), rc);
>  		kfree(cxl_rr);
> -		return NULL;
> +		return ERR_PTR(rc);
>  	}
>  
>  	return cxl_rr;
> @@ -801,33 +815,25 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> -	struct cxl_region_ref *cxl_rr = NULL, *iter;
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = NULL;
> +	struct cxl_region_ref *cxl_rr;
> +	bool nr_targets_inc = false;
> +	struct cxl_decoder *cxld;
>  	unsigned long index;
>  	int rc = -EBUSY;
>  
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
> -	xa_for_each(&port->regions, index, iter) {
> -		struct cxl_region_params *ip = &iter->region->params;
> -
> -		if (iter->region == cxlr)
> -			cxl_rr = iter;
> -		if (ip->res->start > p->res->start) {
> -			dev_dbg(&cxlr->dev,
> -				"%s: HPA order violation %s:%pr vs %pr\n",
> -				dev_name(&port->dev),
> -				dev_name(&iter->region->dev), ip->res, p->res);
> -			return -EBUSY;
> -		}
> -	}
> -
> +	cxl_rr = cxl_rr_load(port, cxlr);
>  	if (cxl_rr) {
>  		struct cxl_ep *ep_iter;
>  		int found = 0;
>  
> -		cxld = cxl_rr->decoder;
> +		/*
> +		 * Walk the existing endpoints that have been attached to
> +		 * @cxlr at @port and see if they share the same 'next' port
> +		 * in the downstream direction. I.e. endpoints that share common
> +		 * upstream switch.
> +		 */
>  		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
>  			if (ep_iter == ep)
>  				continue;
> @@ -838,22 +844,29 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  
>  		/*
> -		 * If this is a new target or if this port is direct connected
> -		 * to this endpoint then add to the target count.
> +		 * New target port, or @port is an endpoint port that always
> +		 * accounts its own local decode as a target.
>  		 */
> -		if (!found || !ep->next)
> +		if (!found || !ep->next) {
>  			cxl_rr->nr_targets++;
> +			nr_targets_inc = true;
> +		}
> +
> +		/*
> +		 * The decoder for @cxlr was allocated when the region was first
> +		 * attached to @port.
> +		 */
> +		cxld = cxl_rr->decoder;
>  	} else {
>  		cxl_rr = alloc_region_ref(port, cxlr);
> -		if (!cxl_rr) {
> +		if (IS_ERR(cxl_rr)) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: failed to allocate region reference\n",
>  				dev_name(&port->dev));
> -			return -ENOMEM;
> +			return PTR_ERR(cxl_rr);
>  		}
> -	}
> +		nr_targets_inc = true;

I don't think this is technically needed but I would leave it if I were you.

I think the leak only occurs on the extend case but I think it is safe to do
this and does make the code cleaner.

Regardless of the kdoc subtlety and with the spelling fix.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  
> -	if (!cxld) {
>  		if (port == cxled_to_port(cxled))
>  			cxld = &cxled->cxld;
>  		else
> @@ -896,6 +909,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  
>  	return 0;
>  out_erase:
> +	if (nr_targets_inc)
> +		cxl_rr->nr_targets--;
>  	if (cxl_rr->nr_eps == 0)
>  		free_region_ref(cxl_rr);
>  	return rc;
> 
