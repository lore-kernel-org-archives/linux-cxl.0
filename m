Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6548DC54EBD
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjAMLhX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMLgv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 06:36:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3D11C16
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 03:24:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtfFQ6PGWz6HJWW;
        Fri, 13 Jan 2023 19:24:10 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 11:24:19 +0000
Date:   Fri, 13 Jan 2023 11:24:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Clarify when a cxld->commit() callback
 is mandatory
Message-ID: <20230113112418.0000060b@Huawei.com>
In-Reply-To: <167124081824.1626103.1555704405392757219.stgit@dwillia2-xfh.jf.intel.com>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
        <167124081824.1626103.1555704405392757219.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Dec 2022 17:33:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Both cxl_switch_decoders() and cxl_endpoint_decoders() are considered by
> cxl_region_decode_commit(). Flag cases where cxl_switch_decoders with
> multiple targets, or cxl_endpoint_decoders do not have a commit callback
> set. The switch case is unlikely to happen since switches are only
> enumerated by the CXL core, but the endpoint case may support decoders
> defined by drivers outside of drivers/cxl, like accerator drivers.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Seems reasonable though (just for consistency with earlier discussions)
I don't like assumption that nr->targets is the right thing to decide on.
It's fine to have decoders in single target case and if we do
they should be committed / not registered as pass through decoders etc.

Hmm. I've never tested the single downstream CXL switch port case.
Similar to HB in that case HDM decoders are optional. I've no idea
what we do about that corner currently.  One to add to my tests ;)


Anyhow, this is fine
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>




> ---
>  drivers/cxl/core/region.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c11a6ab5e48d..60828d01972a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -156,6 +156,22 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  	return 0;
>  }
>  
> +static int commit_decoder(struct cxl_decoder *cxld)
> +{
> +	struct cxl_switch_decoder *cxlsd = NULL;
> +
> +	if (cxld->commit)
> +		return cxld->commit(cxld);
> +
> +	if (is_switch_decoder(&cxld->dev))
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +
> +	if (dev_WARN_ONCE(&cxld->dev, !cxlsd || cxlsd->nr_targets > 1,
> +			  "->commit() is required\n"))
> +		return -ENXIO;
> +	return 0;
> +}
> +
>  static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -174,8 +190,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  		     iter = to_cxl_port(iter->dev.parent)) {
>  			cxl_rr = cxl_rr_load(iter, cxlr);
>  			cxld = cxl_rr->decoder;
> -			if (cxld->commit)
> -				rc = cxld->commit(cxld);
> +			rc = commit_decoder(cxld);
>  			if (rc)
>  				break;
>  		}
> 

