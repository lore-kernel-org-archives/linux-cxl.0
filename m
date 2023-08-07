Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25342C00528
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjHGN2Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjHGN2I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 09:28:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BE1701
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 06:27:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKH65474Dz6HJfP;
        Mon,  7 Aug 2023 21:21:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 14:26:45 +0100
Date:   Mon, 7 Aug 2023 14:26:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
Message-ID: <20230807142644.00005faf@Huawei.com>
In-Reply-To: <20230804232726.1672782-1-alison.schofield@intel.com>
References: <20230804232726.1672782-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri,  4 Aug 2023 16:27:26 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In cxl_port_setup_targets() the region driver validates the
> configuration of auto-discovered region decoders, as well
> as decoders the driver is preparing to program.
> 
> The existing calculations use the encrypted interleave granularity
> value, the eig, to create an interleave granularity that properly
> fans out when routing an x1 interleave to a greater than x1 interleave.
> 
> That all worked well, until this config came along:
> Host Bridge: 2 way at 256 granularity
>     Switch Decoder_A:	1 way at 512
>         Endpoint_X:	2 way at 512
>     Switch Decoder_B:	1 way at 512
>         Endpoint_Y:	2 way at 512

Not sure this is a valid example
Those endpoints need to have 2 way at 256 I think...

Mapping out the result...

0000-0255  RP 0 -> Switch Decoder_A -> End_Point_X DPA 0-255
0256-0511  RP 1 -> Switch Decoder_B -> End_point_Y DPA 256-511 *
0512-0767  RP 0 -> Switch Decoder_A -> End_point_X DPA 0-255 *
0768-1023  RP 1 -> Switch Decoder_B -> End_point_Y DPA 256-511 
1024-1279  RP 0 -> Switch Decoder_A -> End_point_X

* address bit for 512 dropped not the one for 256
> 
> When the Host Bridge interleave is greater that 1, and the root
> decoder interleave is exactly 1, the region driver needs to
> consider the number of targets in the region when calculating
> the expected granularity.
> 
> While examining the existing logic, and trying to cover the case
> above, a couple of simplifications appeared, hence this proposed
> refactoring.
> 
> The first simplicfication is to apply the logic to the unencrypted
> values and use the existing helper function granularity_to_eig() to
> translate the desired granularity to the encrypted form. This means
> the comment and code regarding setting address bits is discarded.
> Although that logic was not wrong, it adds a level of complexity that
> is not required in the granularity selection. The eig and eiw are
> indeed part of the routing instructions programmed into the decoders.
> Up-level the discussion to plain ways and granularity for clearer
> analysis.
> 
> The second simplification reduces the logic to a single granularity
> calculation that works for all cases. The new calculation doesn't
> care if parent_iw => 1,  because parent_iw is used as a multiplier.
> 
> The refactor cleans up a useless assignment of eiw, made after the iw
> is already calculated.
> 
> Regression testing included an examination of all of the ways and
> granularity selections made during a run of the cxl_test unit tests.
> There were no differences in selections before and after this patch.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..5a1cc59cca99 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	/*
> -	 * If @parent_port is masking address bits, pick the next unused address
> -	 * bit to route @port's targets.
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
>  	 */
> -	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
> -		u32 address_bit = max(peig + peiw, eiw + peig);
> -
> -		eig = address_bit - eiw + 1;
> -	} else {
> -		eiw = peiw;
> -		eig = peig;
> +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: invalid granularity calculation (%d * %d)\n",
> +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		return rc;
>  	}
>  
>  	rc = eig_to_granularity(eig, &ig);
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9

