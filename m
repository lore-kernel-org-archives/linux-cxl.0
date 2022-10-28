Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CBC38A02
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJ1Um7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ1Um5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 16:42:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7009323AB41
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666989771; x=1698525771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eKiesdgbMmoSJk0UCp98vFF27y7+TY6Vh3hD1TPRAyY=;
  b=cxJmCH0vIpOOzUDjws+Z88geK9usNs6w/vFt+zzqKz/MJr0UekTteubk
   hSS09GaCjovFjMqGmJYh4LpqLyPy+cOVIsIZ63bqEd3Q8N3rDWPKyXpqq
   eC7nxmc+q6CctWXfdRlkfeJZ1u+ToKaKo/cQR7ETr86PqnudOgw7roKMK
   bkCK6DR4Cm22EZ/2Lj+bQQJAnMVX8Q6JPJ8OsMVl4d/TchW2vTKU9DV7Y
   pEuxqrKJr0z7wdDltKOFIIBusSnqfgXPhC9gjQwkK2NxxjyXx4ZJ7xdid
   Xyej2fqn0v89Dz9uKfpZFarkSYksNugysKsZj5wcfUmnpBlTobYEHGoPW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="295997684"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="295997684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="584053388"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="584053388"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Oct 2022 13:42:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 13:42:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 13:42:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 13:42:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 13:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHh5JRscFK1c//Yf75CTn9BpQJT0z3xasvGlbTt3hgtpOS/e30am3Tk3yVuFTy9S3lupG9QyjaIvA9PKwdXCv3Zt8KI5VonrGtx5perYn6CAchtX1rXp/dF127LeuEUZ3IKO27NHHPpbmKncNLkEgjom5nFiELblVzCGSDnM+mSQXMzqUZ9Tu32+CSE8CTZoOcCJXYuxkFD3cqPcBgmTRuG5BWFzC3/ROpstcX+db3Ya/pOCn4fXOdL+X8EjFpKrE2ZUzwwCMROWHlN6zPqFlGH0JX5BzfTUyA8mKp++e/+qxtACReEdmARVSJcvV17vquMNNM2a0KNrjU5Mb9LPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zji6fnJPVKDjRNt3owJBAH9KaTsnXR3aicjDFDGDITM=;
 b=MLostPS7U61uIc1L1NIj5yKb/y39l8f5npTJnu3Sb4QQQDjtZOmrr7XOTgsMVJQCiklg9kMd+XlXpr3DbOsjQFnHPlL7c31TiRuyzkUSyR1brq0VQSxY3AyfS/A5D/u/X1y0s0J7mR/nUzbXulvQ2HllPdaSr5pXDypQl15O8Z5L+QRmhiVuYZCbf6pSoTtThIkyVnEDopAYqNKXNVdspMOsStO2LZRgbhCF+qMLud0WgKGKilJFlmYQt+0WF85+WSE+6sA8gBVexxhtmzjVu/wTexQJkJ0irdm6BU7NShFydTcVcjnkZqOzWToen8pPHfVBMiHcBBw6z6q9Eh/DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB6764.namprd11.prod.outlook.com
 (2603:10b6:303:209::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 20:42:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5769.015; Fri, 28 Oct
 2022 20:42:46 +0000
Date:   Fri, 28 Oct 2022 13:42:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH] cxl/region: refactor decoder allocation for region refs
Message-ID: <635c3ec3b3eab_6be129441@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221028193351.408950-1-vishal.l.verma@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028193351.408950-1-vishal.l.verma@intel.com>
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW4PR11MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7f3584-4840-443d-d13e-08dab924f830
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZwRIhpp6tfOgpYn0l/FB8VddAvxiI6b6fSCcCr4K75m/iE6bmypi834+dOOxo9gxaiLRzG98Fxv/F1siWNQFIwyn/CtDW4xgId7LlsEE15B9dUP4OUCEqb+TNY8sXuodpL1SQ/4cjXKnFUKa8t84XD9Js5k9jrEGsa47XpGwO1LhSu8fgc99lx6ja6OfEU05dnJ3lxxpbgLdlE8A42NQn+zhpp7vomT09lyynDSBI29qz9s7/tYltfeg19wM0i9wvqD6o/lfxYj89yAhvQgedaHA/RRqziyq/jXG2qCqukl1bDNIe4qR4yUbW0jWVovHnFOnAWBtdSOZNIP8hSwvX0Ri4rQTbQeess4bQG0EDys5+dxa51LycMiz5w3CfYEQ6RS30ZTxj22NoaSxQNlC9nMrSRq6I0pJN3VHFg0LCfqP0C17A4fwpC14752viZWFuOKG103PnHin3owcrcr5A1fv9BHCbmeDLlDzwTYtfaTBo5Fal7HYjidl8RKJd7Kc9DUSxqyjudFSIUuF8RjTs+NHxgHQyM2p+nkVaamOVcRDJbCDCG4hDtmBF1QOPYcdu8XDDmaJD8Gh4CXKowq76/snlapHPMNsoMgeckKaNovpLxSntFmnXXOn3YnywrPSn+3MX1C9Pl8Cn9aknMPUOYhGgtHfHKsTidbyrJbCOx5tEDqg+uC9+UGI9JEjqt5s7sMJMVhNfVN9jYsQQTCAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(6506007)(38100700002)(82960400001)(478600001)(6512007)(186003)(54906003)(8676002)(4326008)(2906002)(316002)(6666004)(107886003)(6486002)(66946007)(9686003)(5660300002)(83380400001)(8936002)(26005)(86362001)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8drRWx3a+x0yItRKe63UVuPHdqFSEvfdKxhBd6gSronlwJB8USfka0XuPC8o?=
 =?us-ascii?Q?iwoTCmnq8kmCB1WLDkBorgRItWBQa5lgtjy522H6RfMM1yuTsJRNZv4p11Nb?=
 =?us-ascii?Q?RP7VX5l0U453EkKvqH2OB7gRA2RHIwcSxn1naidSWMlKytdZpo3beZIJdA5W?=
 =?us-ascii?Q?Lj2AwRF7nK/DNv89JAqfg8Rs357/fbfqKR1NHFa/uYaIooaTjJTTjInsdCre?=
 =?us-ascii?Q?jfYAyGNCxWJ6VQfazRwIxnWIduzQwlidgElRAFK1vdTGcPKHuIAHpcf9PNS0?=
 =?us-ascii?Q?ytM7idFA+bCopmPZ1NQXrUP0mK9TpCzEf6XAW2rMRgR5J51kx5wyNEZ8/uUM?=
 =?us-ascii?Q?iPqEdip1uCCS5gQleYIAbx59Ou5/R6eaFoH3M0izECTZ2nw0xpwlVYjEFFur?=
 =?us-ascii?Q?PDxxu/wDz6ymu5c03cWf5qk32q9bEIzNbfnQHTGux4XpVdTL5x38CWLFl9BX?=
 =?us-ascii?Q?fE64RHelmkVDJg6hlMuSu/t3kF/3E09pFEDySyJJjMsk6B8CXXXoFww/RZ6x?=
 =?us-ascii?Q?iEsF/waHwen8d4YX3MhCMUOJ5rjsCgyXzTJzpY5y0RqNi9mSHHTr/ZbsYGXS?=
 =?us-ascii?Q?mzOiIrce6WmPfPVOltRQLGV8jYpHP8JgOU+6NnicFJu7xPZJPD8nN/7NnCkW?=
 =?us-ascii?Q?z9RzyHa6aOXGe+lc6snccacAz0RCuqmKshOt/XNEF2bPt5rdVhMYrwvE/b4G?=
 =?us-ascii?Q?WIGHDiLJEB7p5h6sFsoN6+hJ83Kt046qJnTN8nCX9kVogPClJz1qk1URdJWE?=
 =?us-ascii?Q?8Ac4RlH43hLJBTI6TkYARbD0834ELUO2WSvKlByYc7HWBxdLslYzXGzEqCsI?=
 =?us-ascii?Q?RkzefkhGLZbqMPT4uLtK84VgjwH/7fiPhssQWlTnUz+6kBBVRlL5kge2EJrI?=
 =?us-ascii?Q?4q/HlW35GP0owo8QvqQh/oQtfnQMI0Cy/7aamuY6/1ylwzwDBopkwSVIPV+k?=
 =?us-ascii?Q?OA3l6i3alV7MT+OvVByaAPBkJ5u3M8O3WmG2pzm2AR8XwOOpYpB6kIW08vga?=
 =?us-ascii?Q?qYOsWCFSyH+czdgwThJICJ9o4ldT2Z5B3jWUAMQCZXokeTViFKyeKQpWVZ+p?=
 =?us-ascii?Q?wn6/L4NlrB9gqO7N1KZ0lskXM0cqkKgpD2MzgAv7h4D5bXzRq3kW/TYz+m9D?=
 =?us-ascii?Q?2fymlLRXwH2SPKYN5Wmd5P809SG5ScNthsKMS/LSQXlDQiDioHE4bnzmrMGo?=
 =?us-ascii?Q?WRMoN4c2MUvdVh9hByHTUEIjZpfn5C+Yo2Jr4VsXJoKcGAS+ieQfwg21VoPH?=
 =?us-ascii?Q?yZDxeaf/34EoKXsaQUbM2jECWOdF9onMYw5t/jEtkaUQoun+UoDeFMZ0UtN/?=
 =?us-ascii?Q?iPCnckX48HCnhvhpecu+1bNmsJBAbGT16lVcnTiNSjtfPAZ2020bwo3Yv0SG?=
 =?us-ascii?Q?TKPOKAOkEKLdEHiGeZWin+l1lmYBN8224Tw2jGkXcLm4dsqOe5d85/zGUBCc?=
 =?us-ascii?Q?GWqDh8SHnusdn0HYbha10e0LcEU+rHOtXKdCiL0colIezwB+fVWGiH4ugVMH?=
 =?us-ascii?Q?efMZEgsP1nh/DJCfkPRzHGRrmPu952FKdl33wVUsbeNt1VDPV6DYO9+31tRj?=
 =?us-ascii?Q?G99dWuijmiLygzgHgoDyx3Mm91m1hscYj7mXH7nFcFRewwy+hLrXZ655zKgz?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f3584-4840-443d-d13e-08dab924f830
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:42:46.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nc17K0TxL8wXQtb3MG4VVsFRfb/9k/U8VcU+40pWfVfoUEvOH4RLOywQ0CmQUVznvR/SZOs2yme825NteYMxT1IWCV7OD4iwRRi2gbovb5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6764
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal Verma wrote:
> When an intermediate port's decoders have been exhausted by existing
> regions, and creating a new region with the port in question in it's
> hierarchical path is attempted, cxl_port_attach_region() fails to find a
> port decoder (as would be expected), and drops into the failure / cleanup
> path.
> 
> However, during cleanup of the region reference, a sanity check attempts
> to dereference the decoder, which in the above case didn't exist. This
> causes a NULL pointer dereference BUG.
> 
> To fix this, refactor the decoder allocation and de-allocation into
> helper routines, and in this 'free' routine, check that the decoder,
> @cxld, is valid before attempting any operations on it.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/cxl/core/region.c | 164 +++++++++++++++++++++++---------------
>  1 file changed, 99 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..78176f7ccff3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -686,18 +686,27 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  	return cxl_rr;
>  }
>  
> -static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
>  {
> -	struct cxl_port *port = cxl_rr->port;
>  	struct cxl_region *cxlr = cxl_rr->region;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  
> +	if (!cxld)
> +		return;
> +
>  	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
>  	if (cxld->region == cxlr) {
>  		cxld->region = NULL;
>  		put_device(&cxlr->dev);
>  	}
> +}
>  
> +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +
> +	cxl_rr_free_decoder(cxl_rr);
>  	xa_erase(&port->regions, (unsigned long)cxlr);
>  	xa_destroy(&cxl_rr->endpoints);
>  	kfree(cxl_rr);
> @@ -728,6 +737,83 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  	return 0;
>  }
>  
> +static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				struct cxl_endpoint_decoder *cxled,
> +				bool *nr_targets_inc)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_region_ref *cxl_rr;
> +	struct cxl_decoder *cxld;
> +	unsigned long index;
> +
> +	cxl_rr = cxl_rr_load(port, cxlr);
> +	if (cxl_rr) {
> +		struct cxl_ep *ep_iter;
> +		int found = 0;
> +
> +		/*
> +		 * Walk the existing endpoints that have been attached to
> +		 * @cxlr at @port and see if they share the same 'next' port
> +		 * in the downstream direction. I.e. endpoints that share common
> +		 * upstream switch.
> +		 */
> +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> +			if (ep_iter == ep)
> +				continue;
> +			if (ep_iter->next == ep->next) {
> +				found++;
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * New target port, or @port is an endpoint port that always
> +		 * accounts its own local decode as a target.
> +		 */
> +		if (!found || !ep->next) {
> +			cxl_rr->nr_targets++;
> +			*nr_targets_inc = true;
> +		}
> +
> +		/*
> +		 * The decoder for @cxlr was allocated when the region was first
> +		 * attached to @port.
> +		 */
> +		cxld = cxl_rr->decoder;
> +	} else {
> +		cxl_rr = alloc_region_ref(port, cxlr);

The region_ref, 'cxl_rr', is being created here, but the function is
called cxl_rr_alloc_decoder(), which to me means the 'cxl_rr' should be
passed in / already created.

> +		if (IS_ERR(cxl_rr)) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: failed to allocate region reference\n",
> +				dev_name(&port->dev));
> +			return PTR_ERR(cxl_rr);
> +		}
> +		*nr_targets_inc = true;
> +
> +		if (port == cxled_to_port(cxled))
> +			cxld = &cxled->cxld;
> +		else
> +			cxld = cxl_region_find_decoder(port, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			return -ENXIO;
> +		}
> +
> +		if (cxld->region) {
> +			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> +				dev_name(&port->dev), dev_name(&cxld->dev),
> +				dev_name(&cxld->region->dev));
> +			return -EBUSY;
> +		}
> +
> +		cxl_rr->decoder = cxld;

I was thinking cxl_rr_alloc_decoder() to just be this above bit of taking an
existing cxl_rr and appending the decoder. The flow would then go:

alloc_region_ref()
\->cxl_rr_alloc_decoder()
free_region_ref()
\->cxl_rr_free_decoder()

...so the symmetry is more apparent.
