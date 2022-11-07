Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA13C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 16:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiKGQFa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiKGQFX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 11:05:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79532205F4
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 08:05:10 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5bc02Wsmz68BrB;
        Tue,  8 Nov 2022 00:02:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:05:07 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 16:05:07 +0000
Date:   Mon, 7 Nov 2022 16:05:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2 19/19] cxl: add dimm_id support for __nvdimm_create()
Message-ID: <20221107160506.00007b8d@Huawei.com>
In-Reply-To: <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
        <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022 08:33:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Set the cxlds->serial as the dimm_id to be fed to __nvdimm_create(). The
> security code uses that as the key description for the security key of the
> memory device. The nvdimm unlock code cannot find the respective key
> without the dimm_id.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxlmem.h         |    3 +++
>  drivers/cxl/pci.c            |    4 ++++
>  drivers/cxl/pmem.c           |    4 +++-
>  tools/testing/cxl/test/mem.c |    4 ++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1266df3b2d3d..24d1c66a30ed 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -178,6 +178,8 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +#define CXL_DEV_ID_LEN 32
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -244,6 +246,7 @@ struct cxl_dev_state {
>  
>  	resource_size_t component_reg_phys;
>  	u64 serial;
> +	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
>  
>  	struct xarray doe_mbs;
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..de5f37e0fe6f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -451,6 +451,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return PTR_ERR(cxlds);
>  
>  	cxlds->serial = pci_get_dsn(pdev);
> +	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
> +	if (rc <= 0)
> +		return -ENXIO;
> +
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>  		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>  	if (!cxlds->cxl_dvsec)
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index cb303edb925d..444f18c09848 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -113,9 +113,11 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
>  	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
>  	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
> +
>  	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
>  				 cxl_dimm_attribute_groups, flags,
> -				 cmd_mask, 0, NULL, NULL, cxl_security_ops, NULL);
> +				 cmd_mask, 0, NULL, cxlds->dev_id,
> +				 cxl_security_ops, NULL);
>  	if (!nvdimm) {
>  		rc = -ENOMEM;
>  		goto out;
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index a0a58156c15a..ca1d8f2fc6a4 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -556,6 +556,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  		return PTR_ERR(cxlds);
>  
>  	cxlds->serial = pdev->id;
> +	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
> +	if (rc <= 0)
> +		return -ENXIO;
> +
>  	cxlds->mbox_send = cxl_mock_mbox_send;
>  	cxlds->payload_size = SZ_4K;
>  
> 
> 

