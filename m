Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AB12E42
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9BB7
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 04:29:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5nT73GhSz6K7G4;
	Thu, 12 Oct 2023 19:28:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 12 Oct
 2023 12:29:05 +0100
Date: Thu, 12 Oct 2023 12:29:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, "Dmytro
 Adamenko" <dmytro.adamenko@intel.com>
Subject: Re: [PATCH 1/3] cxl/region: Prepare the decoder match range helper
 for reuse
Message-ID: <20231012122904.00005052@Huawei.com>
In-Reply-To: <79f1fb5c1756289d1ee02bd6581548aba0718b98.1696550786.git.alison.schofield@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
	<79f1fb5c1756289d1ee02bd6581548aba0718b98.1696550786.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu,  5 Oct 2023 17:43:11 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> match_decoder_by_range() and decoder_match_range() both determine
> if an HPA range matches a decoder. The first does it for root
> decoders and the second one operates on switch decoders.
> 
> Tidy these up with clear naming and make the switch helper more
> like the root decoder helper in style and functionality. Make it
> take the actual range, rather than an endpoint decoder from which
> it extracts the range.
> 
> Aside from aethetics and maintainability, this is in preparation
> for reuse.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..64206fc4d99b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1487,16 +1487,19 @@ static struct cxl_port *next_port(struct cxl_port *port)
>  	return port->parent_dport->port;
>  }
>  
> -static int decoder_match_range(struct device *dev, void *data)
> +static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
> -	struct cxl_endpoint_decoder *cxled = data;
> +	struct range *r1, *r2 = data;
>  	struct cxl_switch_decoder *cxlsd;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> +	r1 = &cxlsd->cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
>  }
>  
>  static void find_positions(const struct cxl_switch_decoder *cxlsd,
> @@ -1565,7 +1568,8 @@ static int cmp_decode_pos(const void *a, const void *b)
>  		goto err;
>  	}
>  
> -	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
> +	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
> +				match_switch_decoder_by_range);
>  	if (!dev) {
>  		struct range *range = &cxled_a->cxld.hpa_range;
>  
> @@ -2696,7 +2700,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, void *data)
> +static int match_root_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 = data;
>  	struct cxl_root_decoder *cxlrd;
> @@ -2827,7 +2831,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	int rc;
>  
>  	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> -				      match_decoder_by_range);
> +				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",

