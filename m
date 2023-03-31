Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6FBC6FD18
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 05:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCaFMa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 01:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCaFM3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 01:12:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD005CA38
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 22:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680239548; x=1711775548;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xA8QYz1Y7INzw43RJ2t/y6mmP/OV5PuLemzHzBRteFM=;
  b=XflS/mPArRfpmt9/+5bn9WCwFWfMmu1fYKMF3Isca+LQUlIVhVyiqw5Z
   2s9wQ6mpOWuc2a5ae8dzjoPjtA+pZQPoW6jwEy6AeRQLFTrQB77wGpWUx
   Dy8GY3IeHDE8tYLN0aIA0HFGGklgmdQUa+j8LwRHI2goXUTOzGMvKFZiX
   zGfrnEMX0+skYgrKUQTMbRa1K16BMnSxz9l2ywyxA6gddg+Cw99FL5LMR
   6pG5EjsjujzwFZmzyUt2ovFrIWDpnfXiRWRpJj2C24yFJy0c6aZUgpODN
   glpbZuKhvm5APq6M0NSAA8IUHRnurOCujkIZCOe8MFJg48oHJ4nhhBV84
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="325324204"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="325324204"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 22:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="808918918"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="808918918"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2023 22:12:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 22:12:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 22:12:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 22:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxNBZQhama6wpm2CMHZpL0sxMIz3qs7wK6Mz+0ysLBTp5ebMlU1s3bP8g90Qm7yZVB9pKJWJnp1mDxTT3NYewCE2XUIYPJXmODlymMHFvmyK3wrKEkPler3xIwoT6leK/2f3xZjMeM02FfhzpRUkMAOY5iMWDpC2V+zfhfaM0mO5wiyDhA6ftY6Ko5H2P1e84ZvtwFg1UeyRPA81NYlDdb+RacLmS7mZ0vLhPmxWUgfRIUT9EnYGX5qHqbgWMQ6NNOyJeqSJd3AyVJWqjX/p0EQtB8zevqVpqHfFcBsgSeFPLu+JPMoS8wizgwJGqM8UEnxyt4e8it2dawlIGnW72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qemb4y2C5kqKecZc9J1syz3u9coLmpwfpAJ7eDCDLCw=;
 b=ksZ2iYgztk64Tt5qPNwtf0jl9zdiya9y1WMKaX6ZbSPpHHh+kWa4PBxWVlrxtiF9ZYmrK7qU0p9h1/Uu3yl0IZ57rtsM1wOP29hcDZ2ys6wjG7E08Ycexc/1MGZRF8VdZeH8Fr9KdnQDXko1uCwmOHl7b7SWAg+QxqJ6VQ2bfS+YjamQYYtXFAVpm7joNGocB/3bNgskuTrOfSvU2x5E/73OaTbA4smNoQHK6m+Ap3TXawRSPZCsY50VOb4b5rjU9q75MG1WanFZpt3jaAi312vV4XV98OGPDuhAhVkFU4PChQt5imck6W6WhETRYsZwpL7gXL4VjoKu+KAz7kkkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 05:12:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5b2:6996:5aee:91db%5]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 05:12:07 +0000
Date:   Thu, 30 Mar 2023 22:12:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/region: Fix region setup/teardown for RCDs
Message-ID: <64266ba31d9da_375f7e29483@iweiny-mobl.notmuch>
References: <168002858268.50647.728091521032131326.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168002858268.50647.728091521032131326.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adb0537-87c3-4046-4389-08db31a67962
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTVVXyUh4wbuJGlMAfBPAbpbfifNzUivrEevAOK8T76zOcR++OdYECGUlxQA3yK57J+qsYgD+cNMlWsWpWdVwMtgJuWzWSvBr4v15TeYKIOlxNXi0mEnaF7FK7iMWJXPZSJXWAwQ+OygeayXgl9h4y47Y73gg56o8ek9hHUQrgpbdB/igienT4lXAeXf24dgGX/ZIlek2bWeUIUzws+zUph6UIeBQY1HVlPLpDJte0aLsKBqQXLcaKgY81JZ2rH+XQfFZjARmttpudoQ6NjMjnLnXV9nGxFUa3qw9yOj7Mz6a18VbvjFC3BL+7FtT5EugQm+2bECxDiZWQ2U01Y3V445/x+PlhYXhkABM3souN8euK5aNo3gLczAJ4dshx8QUAePOjDK5xVcOD6C0FxoOngc4U+Dq+5V1RnjU4mCGCZdSpmUkZ3qxajFa0hpDS97MrHwfOIYhON3mhTJfMD5FZppcldL8e+VeeiQKmoPOynI4Pa0d9lx/apxbQbR/F55yi+qzKCXYfDNL8tdnfeLmaae26cBe3Hi9eWKWHWqLfbnuxhtvOLyO90GUkQ51JU2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(44832011)(83380400001)(9686003)(26005)(6506007)(6512007)(82960400001)(38100700002)(86362001)(4326008)(66556008)(5660300002)(8676002)(41300700001)(478600001)(6666004)(316002)(66946007)(8936002)(6486002)(66476007)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UqMSwyE6Kzrjl5m2CUcFIN1ny6sC4q9FDDyY9n/lJSat78q7EAsegaeSJOVL?=
 =?us-ascii?Q?Ja6gZ3vGQcmFkoeHFxHl9iky7PuR/nu+q9ps0cPe5rFoXppZgwur+NQfCAuB?=
 =?us-ascii?Q?5n3Rzv3ktQTYJIP0mMVzzwnnxcYVrRcFhwS0wA764AILvSzQrs1RfC0H2vfN?=
 =?us-ascii?Q?Q1h9FK/cceUHyCf/xupL/JVm/4uw06FQORCD2KIvUWEpMPaBs3vzdhs59mtm?=
 =?us-ascii?Q?3HYlqI2ISK9U5OpETJvRq+yoLxoHFaEvN4yJ4r6Swm8PhCNte90ReSLMyiSq?=
 =?us-ascii?Q?upuGshcyvrQpEUpgGDPREoiCFgyupSfV95cWv1gLlNqcRZJMai24FEi5mHng?=
 =?us-ascii?Q?X3gI0dEPzo4Dgmjf9Z3vG8zbOruxyRzjnok1qK5Jqxn+Gn5g2ebDjKF3MdPI?=
 =?us-ascii?Q?ueFuiU66N9T3OMrAdBjJhlj3zocmOjD3xqlHHhPe92NESYYc6FZnVxUsFaMJ?=
 =?us-ascii?Q?H7sosdGVRiywOnqNwOedqE/cHt34ZaOzKZfKqTQGtPpBSnKoDPrQgvvRkPt7?=
 =?us-ascii?Q?DdeENBzGCklbAhr1A50hE1eDO3BHNu7EprjeZPMd7MfifByLuZvSgANNfcz/?=
 =?us-ascii?Q?Nph9W/seW3uAycFukEb4eboNrN71kj4HWNp1ajuU5FCoeN+GhK2QPX6z+bI2?=
 =?us-ascii?Q?soBpnwZvl5vdNsO2l1Mcusf+7tAZfj9QszRlhN2elFI6h9QkUWye2LGlnL/k?=
 =?us-ascii?Q?btnrtyooivaeidEPLxwBSBCofw0NVmXuksOrlD/IrbXEZjQAQ+4AhNBvL3Xc?=
 =?us-ascii?Q?wzu3DWwS3B1Szuhx+q/CaoIUnh63FLzkW8cnR21MjKnlj4Wb8BTjKweZWiPw?=
 =?us-ascii?Q?LZ7tng3rR3o/RXT07PEgYlUpeoQwZIvIvfJSxLgfI94BzJ3q0DDTZf+G7Zq5?=
 =?us-ascii?Q?k2rLZBLBs3aONSHEwIolswgrwd0LhuQJNQo/khsBGfmMukbK4/UVpnLS1O0Z?=
 =?us-ascii?Q?UQ1wceKyJMnEYWNzlxiIX5O2scVJsPuzQjCREx/oJEfgv/WPBquwde8nc2VH?=
 =?us-ascii?Q?wpAddhAPcBxRPchiesqTplO3ypzT5sn15xnRzf9A03ENEkpsL5G3Qnqb0OiT?=
 =?us-ascii?Q?f0Mk8/fc2UyWEgFnuF4TFaXuIxDNnyCMBmLqD/fSc+QAEV8WnOb7W6nzgtLZ?=
 =?us-ascii?Q?8kVTXpjy8KcTOAyr/o8yAGazfm/vP59NQEQsTouFfNwnXf6nZK3W1JZXHy96?=
 =?us-ascii?Q?25s8OSHXkfccsHUGlxi5HK99JrVxA4BKwb5Rr3rP6XOyiXvqe673vjggbOuB?=
 =?us-ascii?Q?RZn74INGVqjUgXVmNS19t2EKrUTLHCPPnA/9kpHbX8mFTpuud0dDUtsOMecE?=
 =?us-ascii?Q?OFrLJ7pwcNBfb3mwZxiMWA4HRKJFO06BM8rIqymCyJvfi4v0gyojQsotqF13?=
 =?us-ascii?Q?FLnoJw+q50v68TZaiUKczL7ncOJazIuauX13bQro/0UKIFO3/fDEFeHB+fFJ?=
 =?us-ascii?Q?M3CvhlRqr190CUWl6AERY59IC+BfxU3eEDKzfqAkNVLShqNm8QKx2GtBjCwP?=
 =?us-ascii?Q?EvKXqh4KRXJPc9hD0wPpWKWQ8PHclmPky/zlSrQ+YEot6Ik6BdDVCCklygAJ?=
 =?us-ascii?Q?PXVpIOeE8QjqW+TXPW8oZCaeqP1AVqjf/WzRI35i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adb0537-87c3-4046-4389-08db31a67962
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 05:12:07.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/6X0gxsgunJuntVq32Qgwk23VOly9PdTaXOuoL9qa+bB9sP+buzUmLgtPmp7QIW9O8AmP2vWK7Yxsdh4e0o3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> RCDs (CXL memory devices that link train without VH capability and show
> up as root complex integrated endpoints), hide the presence of the link
> between the endpoint and the host-bridge. The CXL region setup/teardown
> paths assume that a link hop is present and go looking for at least one
> 'struct cxl_port' instance between the CXL root port-object and an
> endpoint port-object leading to crashes of the form:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     [..]
>     RIP: 0010:cxl_region_setup_targets+0x3e9/0xae0 [cxl_core]
>     [..]
>     Call Trace:
>      <TASK>
>      cxl_region_attach+0x46c/0x7a0 [cxl_core]
>      cxl_create_region+0x20b/0x270 [cxl_core]
>      cxl_mock_mem_probe+0x641/0x800 [cxl_mock_mem]
>      platform_probe+0x5b/0xb0
> 
> Detect RCDs explicitly and skip walking the non-existent port hierarchy
> between root and endpoint in that case.
> 
> While this has been a problem since:
> 
> commit 0a19bfc8de93 ("cxl/port: Add RCD endpoint port enumeration")
> 
> ...it becomes a more reliable crash scenario with the new autodiscovery
> implementation.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/region.c |   28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 808f23ec4e2b..52bbf6268d5f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -134,9 +134,13 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  		struct cxl_port *iter = cxled_to_port(cxled);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  		struct cxl_ep *ep;
>  		int rc = 0;
>  
> +		if (cxlds->rcd)
> +			goto endpoint_reset;
> +
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>  			iter = to_cxl_port(iter->dev.parent);
>  
> @@ -153,6 +157,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  				return rc;
>  		}
>  
> +endpoint_reset:
>  		rc = cxled->cxld.reset(&cxled->cxld);
>  		if (rc)
>  			return rc;
> @@ -1199,6 +1204,7 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_port *iter;
>  	struct cxl_ep *ep;
> @@ -1214,6 +1220,10 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		cxled = p->targets[i];
>  		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +
> +		if (cxlds->rcd)
> +			continue;
>  
>  		iter = cxled_to_port(cxled);
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> @@ -1229,14 +1239,24 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dev_state *cxlds;
> +	int i, rc, rch = 0, vh = 0;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_port *iter;
>  	struct cxl_ep *ep;
> -	int i, rc;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		cxled = p->targets[i];
>  		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +
> +		/* validate that all targets agree on topology */
> +		if (!cxlds->rcd) {
> +			vh++;
> +		} else {
> +			rch++;
> +			continue;
> +		}
>  
>  		iter = cxled_to_port(cxled);
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> @@ -1256,6 +1276,12 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>  		}
>  	}
>  
> +	if (rch && vh) {
> +		dev_err(&cxlr->dev, "mismatched CXL topologies detected\n");
> +		cxl_region_teardown_targets(cxlr);
> +		return -ENXIO;
> +	}
> +
>  	return 0;
>  }
>  
> 


