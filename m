Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4687C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiCYLwf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLwe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:52:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633AD4442
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:51:00 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KQ0kd3k6Hz67pVR;
        Fri, 25 Mar 2022 19:49:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:50:58 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:50:57 +0000
Date:   Fri, 25 Mar 2022 11:50:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 5/6] cxl/mem: Rename cxl_dvsec_decode_init() to
 cxl_hdm_decode_init()
Message-ID: <20220325115056.000058b2@huawei.com>
In-Reply-To: <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Mar 2022 18:22:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_dvsec_decode_init() is tasked with checking whether legacy DVSEC
> range based decode is in effect, or whether HDM can be enabled / already
> is enabled. As such it either succeeds or fails and that result is the
> return value. The @do_hdm_init variable is misleading in the case where
> HDM operation is already found to be active, so just call it @retval.

The text above is confusing for me.  Which part is justifying the
function rename and which part is for the retval?

Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/mem.c            |   12 ++++++------
>  tools/testing/cxl/mock_mem.c |    2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 50704deb2ff0..3baae1332760 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -68,7 +68,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>  }
>  
>  /**
> - * cxl_dvsec_decode_init() - Setup HDM decoding for the endpoint
> + * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
>   * @cxlds: Device state
>   *
>   * Additionally, enables global HDM decoding. Warning: don't call this outside
> @@ -79,12 +79,12 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>   * decoders, or if it can not be determined if DVSEC Ranges are in use.
>   * Otherwise, returns true.
>   */
> -__mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> +__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct cxl_register_map map;
>  	struct cxl_component_reg_map *cmap = &map.component_map;
> -	bool global_enable, do_hdm_init = false;
> +	bool global_enable, retval = false;
>  	void __iomem *crb;
>  	u32 global_ctrl;
>  
> @@ -113,7 +113,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  		goto out;
>  	}
>  
> -	do_hdm_init = true;
> +	retval = true;
>  
>  	/*
>  	 * Permanently (for this boot at least) opt the device into HDM
> @@ -129,7 +129,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  
>  out:
>  	iounmap(crb);
> -	return do_hdm_init;
> +	return retval;
>  }
>  
>  static int cxl_mem_probe(struct device *dev)
> @@ -160,7 +160,7 @@ static int cxl_mem_probe(struct device *dev)
>  	 * If DVSEC ranges are being used instead of HDM decoder registers there
>  	 * is no use in trying to manage those.
>  	 */
> -	if (!cxl_dvsec_decode_init(cxlds)) {
> +	if (!cxl_hdm_decode_init(cxlds)) {
>  		dev_err(dev,
>  			"Legacy range registers configuration prevents HDM operation.\n");
>  		return -EBUSY;
> diff --git a/tools/testing/cxl/mock_mem.c b/tools/testing/cxl/mock_mem.c
> index d1dec5845139..69946f678cfa 100644
> --- a/tools/testing/cxl/mock_mem.c
> +++ b/tools/testing/cxl/mock_mem.c
> @@ -4,7 +4,7 @@
>  #include <linux/types.h>
>  
>  struct cxl_dev_state;
> -bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> +bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	return true;
>  }
> 

