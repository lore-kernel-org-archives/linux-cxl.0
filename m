Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB4C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbjELPQg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELPQf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:16:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766A5B83
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:16:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHskc4Dz3z67G90;
        Fri, 12 May 2023 23:14:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:16:30 +0100
Date:   Fri, 12 May 2023 16:16:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 09/14] cxl: Wait Memory_Info_Valid before access
 memory related info
Message-ID: <20230512161629.00000251@Huawei.com>
In-Reply-To: <168357886796.2756219.4806167633587850772.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357886796.2756219.4806167633587850772.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:47:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
> 
> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
> Low registers are valid. The bit must be set within 1 second of reset
> deassertion to the device. Check valid bit before we check the
> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
> the memory info is valid for consumption.
> 
> Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

It's a fix - should be first patch in series (to make it obvious backporting is
easy etc).

Hard to read this one as diff has been unfriendly, but I 'think'
it's fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> ---
> v2:
> - Check both ranges. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   83 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlpci.h   |    2 +
>  2 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6c99a964eb54..536672d469a1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -102,21 +102,55 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
>  
> -/*
> - * Wait up to @media_ready_timeout for the device to report memory
> - * active.
> - */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	bool valid = false;
> +	int rc, i;
> +	u32 temp;
> +
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
> +
> +	/* Check MEM INFO VALID bit first, give up after 1s */
> +	i = 1;
> +	do {
> +		rc = pci_read_config_dword(pdev,
> +					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> +					   &temp);
> +		if (rc)
> +			return rc;
> +
> +		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		if (valid)
> +			break;
> +		msleep(1000);
> +	} while (i--);
> +
> +	if (!valid) {
> +		dev_err(&pdev->dev,
> +			"Timeout awaiting memory range %d valid after 1s.\n",
> +			id);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	bool active = false;
> -	u64 md_status;
>  	int rc, i;
> +	u32 temp;
>  
> -	for (i = media_ready_timeout; i; i--) {
> -		u32 temp;
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
>  
> +	/* Check MEM ACTIVE bit, up to 60s timeout by default */
> +	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
>  		if (rc)
> @@ -135,6 +169,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  		return -ETIMEDOUT;
>  	}
>  
> +	return 0;
> +}
> +
> +/*
> + * Wait up to @media_ready_timeout for the device to report memory
> + * active.
> + */
> +int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	int rc, i, hdm_count;
> +	u64 md_status;
> +	u16 cap;
> +
> +	rc = pci_read_config_word(pdev,
> +				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_active(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!CXLMDEV_READY(md_status))
>  		return -EIO;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 84c9f73c7d92..1772cd226108 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -31,6 +31,8 @@
>  #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>  #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>  
> +#define CXL_DVSEC_RANGE_MAX		2
> +
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>  #define CXL_DVSEC_FUNCTION_MAP					2
>  
> 
> 

