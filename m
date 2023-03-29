Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECFAC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 17:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjC2RjH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2RjG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 13:39:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CE46AD
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680111545; x=1711647545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UzVM/c7NOVgFTvzmKlbIV/z9PGvMDMtfwC2fod4bOFI=;
  b=UXfICJcHdp5mrz/BmKS5vgx5h7utdzZ2zLvXXgDikdeFFxAbKmBNnj3m
   /YZEWjOaxQyd4Rg1zuWU0dS8Blr6B4BzNxg5H7FYnDw7F1vzQ7V6/IjwY
   ka2eRWdYFbB2+8duFdwbrcyQ0g2hZu6jkrS7jUeixBNNB1QbZg85DQ8Dg
   CrOr8fKjm2pABwB3S8bznY1y9uHuauiE9hjeCYQ5OSlQGLQIL4RNjg7zN
   N6vjBXt5z7swYxvFkTHUrdng7dkDc3lpM4FbjGr3D+cWb6F0hUCzHjdGV
   YUXn81GLTBxkF43jkeSJfCnV/d6W4LlJLoA0FDibzgq0ymaP4mmpLdOiY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368725359"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368725359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 10:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753688342"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753688342"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 10:39:05 -0700
Message-ID: <55a56196-688e-cdaa-b796-657f1da684fe@intel.com>
Date:   Wed, 29 Mar 2023 10:39:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] cxl/region: Fix region setup/teardown for RCDs
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
References: <168002858268.50647.728091521032131326.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168002858268.50647.728091521032131326.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/28/23 11:36 AM, Dan Williams wrote:
> RCDs (CXL memory devices that link train without VH capability and show
> up as root complex integrated endpoints), hide the presence of the link
> between the endpoint and the host-bridge. The CXL region setup/teardown
> paths assume that a link hop is present and go looking for at least one
> 'struct cxl_port' instance between the CXL root port-object and an
> endpoint port-object leading to crashes of the form:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000008
>      [..]
>      RIP: 0010:cxl_region_setup_targets+0x3e9/0xae0 [cxl_core]
>      [..]
>      Call Trace:
>       <TASK>
>       cxl_region_attach+0x46c/0x7a0 [cxl_core]
>       cxl_create_region+0x20b/0x270 [cxl_core]
>       cxl_mock_mem_probe+0x641/0x800 [cxl_mock_mem]
>       platform_probe+0x5b/0xb0
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |   28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 808f23ec4e2b..52bbf6268d5f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -134,9 +134,13 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   		struct cxl_endpoint_decoder *cxled = p->targets[i];
>   		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   		struct cxl_port *iter = cxled_to_port(cxled);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   		struct cxl_ep *ep;
>   		int rc = 0;
>   
> +		if (cxlds->rcd)
> +			goto endpoint_reset;
> +
>   		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>   			iter = to_cxl_port(iter->dev.parent);
>   
> @@ -153,6 +157,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   				return rc;
>   		}
>   
> +endpoint_reset:
>   		rc = cxled->cxld.reset(&cxled->cxld);
>   		if (rc)
>   			return rc;
> @@ -1199,6 +1204,7 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
>   	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dev_state *cxlds;
>   	struct cxl_memdev *cxlmd;
>   	struct cxl_port *iter;
>   	struct cxl_ep *ep;
> @@ -1214,6 +1220,10 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
>   	for (i = 0; i < p->nr_targets; i++) {
>   		cxled = p->targets[i];
>   		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +
> +		if (cxlds->rcd)
> +			continue;
>   
>   		iter = cxled_to_port(cxled);
>   		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> @@ -1229,14 +1239,24 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
>   	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dev_state *cxlds;
> +	int i, rc, rch = 0, vh = 0;
>   	struct cxl_memdev *cxlmd;
>   	struct cxl_port *iter;
>   	struct cxl_ep *ep;
> -	int i, rc;
>   
>   	for (i = 0; i < p->nr_targets; i++) {
>   		cxled = p->targets[i];
>   		cxlmd = cxled_to_memdev(cxled);
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
>   		iter = cxled_to_port(cxled);
>   		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> @@ -1256,6 +1276,12 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>   		}
>   	}
>   
> +	if (rch && vh) {
> +		dev_err(&cxlr->dev, "mismatched CXL topologies detected\n");
> +		cxl_region_teardown_targets(cxlr);
> +		return -ENXIO;
> +	}
> +
>   	return 0;
>   }
>   
> 
