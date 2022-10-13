Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB5C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 12:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJMMXz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMMXy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 08:23:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C926118749
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 05:23:53 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp7sQ5xb8z6H6rn;
        Thu, 13 Oct 2022 20:20:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 13 Oct 2022 14:23:51 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 13:23:51 +0100
Date:   Thu, 13 Oct 2022 13:23:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: update names for interleave ways conversion
 macros
Message-ID: <20221013132350.00001864@huawei.com>
In-Reply-To: <166559542232.2130239.9179572026142352550.stgit@djiang5-desk3.ch.intel.com>
References: <166559542232.2130239.9179572026142352550.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 12 Oct 2022 10:24:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Change names for interleave ways macros to clearly indicate which
> variable is encoded and which is the actual ways value.
> 
> ways == interleave ways
> eniw == encoded interleave ways
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Same question on why mix eiw and eniw

Either way I'm fine with this as a good improvement to readability.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v2:
> - change iw to ways for better clarificiation (Alison)
> 
>  drivers/cxl/acpi.c        |    4 ++--
>  drivers/cxl/core/hdm.c    |    6 +++---
>  drivers/cxl/core/region.c |    6 +++---
>  drivers/cxl/cxl.h         |   12 ++++++------
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 5664411c3198..1291d7814b38 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -48,7 +48,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
> +	rc = eniw_to_ways(cfmws->interleave_ways, &ways);
>  	if (rc) {
>  		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
>  			cfmws->interleave_ways);
> @@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  	}
>  
> -	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
> +	rc = eniw_to_ways(cfmws->interleave_ways, &ways);
>  	if (rc)
>  		return rc;
>  	rc = enig_to_granularity(cfmws->granularity, &ig);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 626cb7d66194..a37a94ede96d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -489,7 +489,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 * Input validation ensures these warns never fire, but otherwise
>  	 * suppress unititalized variable usage warnings.
>  	 */
> -	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
> +	if (WARN_ONCE(ways_to_eniw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>  		return;
>  	if (WARN_ONCE(granularity_to_enig(cxld->interleave_granularity, &eig),
> @@ -736,8 +736,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		}
>  		cxld->target_type = CXL_DECODER_EXPANDER;
>  	}
> -	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			 &cxld->interleave_ways);
> +	rc = eniw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			  &cxld->interleave_ways);
>  	if (rc) {
>  		dev_warn(&port->dev,
>  			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 34590f961740..474326dcde34 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -323,7 +323,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	rc = ways_to_cxl(val, &iw);
> +	rc = ways_to_eniw(val, &iw);
>  	if (rc)
>  		return rc;
>  
> @@ -1010,7 +1010,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	rc = ways_to_cxl(parent_iw, &peiw);
> +	rc = ways_to_eniw(parent_iw, &peiw);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
>  			dev_name(parent_port->uport),
> @@ -1019,7 +1019,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	iw = cxl_rr->nr_targets;
> -	rc = ways_to_cxl(iw, &eiw);
> +	rc = ways_to_eniw(iw, &eiw);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
>  			dev_name(port->uport), dev_name(&port->dev), iw);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ef6cc63c06ef..ad9239a851e2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -78,14 +78,14 @@ static inline int enig_to_granularity(u16 enig, unsigned int *granularity)
>  }
>  
>  /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
> -static inline int cxl_to_ways(u8 eniw, unsigned int *val)
> +static inline int eniw_to_ways(u8 eniw, unsigned int *ways)
>  {
>  	switch (eniw) {
>  	case 0 ... 4:
> -		*val = 1 << eniw;
> +		*ways = 1 << eniw;
>  		break;
>  	case 8 ... 10:
> -		*val = 3 << (eniw - 8);
> +		*ways = 3 << (eniw - 8);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -102,12 +102,12 @@ static inline int granularity_to_enig(int granularity, u16 *enig)
>  	return 0;
>  }
>  
> -static inline int ways_to_cxl(unsigned int ways, u8 *iw)
> +static inline int ways_to_eniw(unsigned int ways, u8 *eniw)
>  {
>  	if (ways > 16)
>  		return -EINVAL;
>  	if (is_power_of_2(ways)) {
> -		*iw = ilog2(ways);
> +		*eniw = ilog2(ways);
>  		return 0;
>  	}
>  	if (ways % 3)
> @@ -115,7 +115,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  	ways /= 3;
>  	if (!is_power_of_2(ways))
>  		return -EINVAL;
> -	*iw = ilog2(ways) + 8;
> +	*eniw = ilog2(ways) + 8;
>  	return 0;
>  }
>  
> 
> 

