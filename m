Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C31ECAAA1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Aug 2022 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH3PRk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiH3PRa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Aug 2022 11:17:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15312F11A
        for <linux-cxl@vger.kernel.org>; Tue, 30 Aug 2022 08:17:24 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MH9n01WB0z683hj;
        Tue, 30 Aug 2022 23:13:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 30 Aug 2022 17:17:21 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 16:17:20 +0100
Date:   Tue, 30 Aug 2022 16:17:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 1/6] cxl: Add check for result of interleave ways
 plus granularity combo
Message-ID: <20220830161720.00002b0b@huawei.com>
In-Reply-To: <166144366038.745916.13425367025352369885.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
        <166144366038.745916.13425367025352369885.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 25 Aug 2022 09:07:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a helper function to check the combination of interleave ways and
> interleave granularity together is sane against the interleave mask from
> the HDM decoder. Add the check to cxl_region_attach() to make sure the
> region config is sane. Add the check to cxl_port_setup_targets() to make
> sure the port setup config is also sane.
> 
> Calculation refers to CXL spec rev3.0 8.2.4.19.13 implementation note #3.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c    |   47 +++++++++++++++++++++++++++++++++++++++++-
>  tools/testing/cxl/test/cxl.c |    1 +
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..28272b0196e6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -940,6 +940,42 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int cxl_interleave_capable(struct cxl_port *port, struct device *dev,
> +				  int ways, int granularity)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int addr_mask;
> +	u16 eig;
> +	u8 eiw;
> +	int rc;
> +
> +	rc = granularity_to_cxl(granularity, &eig);
> +	if (rc)
> +		return rc;
> +
> +	rc = ways_to_cxl(ways, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw == 0)
> +		return 0;
> +
> +	if (is_power_of_2(eiw))
> +		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
> +	else
> +		addr_mask = GENMASK((eig + eiw) / 3 - 1, eig + 8);
> +
> +	if (~cxlhdm->interleave_mask & addr_mask) {
> +		dev_dbg(dev,
> +			"%s:%s interleave (eig: %d eiw: %d mask: %#x) exceed cap (mask: %#x)\n",
> +			dev_name(port->uport), dev_name(&port->dev), eig, eiw,
> +			cxlhdm->interleave_mask, addr_mask);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1047,6 +1083,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	rc = cxl_interleave_capable(port, &cxlr->dev, iw, ig);
> +	if (rc)
> +		return rc;
> +
>  	cxld->interleave_ways = iw;
>  	cxld->interleave_granularity = ig;
>  	cxld->hpa_range = (struct range) {
> @@ -1196,6 +1236,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> +	ep_port = cxled_to_port(cxled);
> +	rc = cxl_interleave_capable(ep_port, &cxlr->dev, p->interleave_ways,
> +				    p->interleave_granularity);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < p->interleave_ways; i++) {
>  		struct cxl_endpoint_decoder *cxled_target;
>  		struct cxl_memdev *cxlmd_target;
> @@ -1214,7 +1260,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		}
>  	}
>  
> -	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
>  	if (!dport) {
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..4b361ed63333 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -398,6 +398,7 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	dev_set_drvdata(&port->dev, cxlhdm);
>  	return cxlhdm;
>  }
>  
> 
> 

