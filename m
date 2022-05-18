Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F503C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiERQpK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiERQpJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:45:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E041F90D7
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:45:06 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3Jf60qsqz67lp5;
        Thu, 19 May 2022 00:41:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 18:45:04 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 17:45:03 +0100
Date:   Wed, 18 May 2022 17:45:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 11/14] cxl/pci: Drop @info argument to
 cxl_hdm_decode_init()
Message-ID: <20220518174502.0000240e@Huawei.com>
In-Reply-To: <165237931557.3832067.5196055352152981142.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237931557.3832067.5196055352152981142.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 May 2022 11:15:15 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that nothing external to cxl_hdm_decode_init() considers
> 'struct cxl_endpoint_dvec_info' move it internal to
> cxl_hdm_decode_init().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c        |   15 +++++++--------
>  drivers/cxl/cxlpci.h          |    4 +---
>  drivers/cxl/mem.c             |    3 +--
>  tools/testing/cxl/test/mock.c |    9 +++------
>  4 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6146764ac68e..8f14d846713c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -226,14 +226,13 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  /**
>   * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
>   * @cxlds: Device state
> - * @info: DVSEC Range cached enumeration
>   *
>   * Try to enable the endpoint's HDM Decoder Capability
>   */
> -int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> -			struct cxl_endpoint_dvsec_info *info)
> +int cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_endpoint_dvsec_info info = { 0 };
>  	int hdm_count, rc, i, ranges = 0;
>  	struct device *dev = &pdev->dev;
>  	int d = cxlds->cxl_dvsec;
> @@ -273,8 +272,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  		return rc;
>  	}
>  
> -	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> -	if (!info->mem_enabled)
> +	info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> +	if (!info.mem_enabled)
>  		return 0;
>  
>  	for (i = 0; i < hdm_count; i++) {
> @@ -314,7 +313,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  
>  		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>  
> -		info->dvsec_range[i] = (struct range) {
> +		info.dvsec_range[i] = (struct range) {
>  			.start = base,
>  			.end = base + size - 1
>  		};
> @@ -322,13 +321,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  		ranges++;
>  	}
>  
> -	info->ranges = ranges;
> +	info.ranges = ranges;
>  
>  	/*
>  	 * If DVSEC ranges are being used instead of HDM decoder registers there
>  	 * is no use in trying to manage those.
>  	 */
> -	if (!__cxl_hdm_decode_init(cxlds, info)) {
> +	if (!__cxl_hdm_decode_init(cxlds, &info)) {
>  		dev_err(dev,
>  			"Legacy range registers configuration prevents HDM operation.\n");
>  		return -EBUSY;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 202fdaa8d293..53cd34f8813c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -73,7 +73,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>  
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
> -struct cxl_endpoint_dvsec_info;
> -int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> -			struct cxl_endpoint_dvsec_info *info);
> +int cxl_hdm_decode_init(struct cxl_dev_state *cxlds);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2a5dc92d566f..8ce89d128e36 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -54,7 +54,6 @@ static void enable_suspend(void *data)
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_endpoint_dvsec_info info = { 0 };
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *parent_port;
>  	int rc;
> @@ -95,7 +94,7 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_hdm_decode_init(cxlds, &info);
> +	rc = cxl_hdm_decode_init(cxlds);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index ddf0e7dd9249..45ffbb8f519a 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -208,16 +208,13 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
>  
> -int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> -				struct cxl_endpoint_dvsec_info *info)
> +bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	int rc = 0, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
> -	if (ops && ops->is_mock_dev(cxlds->dev))
> -		info->mem_enabled = 1;
> -	else
> -		rc = cxl_hdm_decode_init(cxlds, info);
> +	if (!ops || !ops->is_mock_dev(cxlds->dev))
> +		rc = cxl_hdm_decode_init(cxlds);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
> 

