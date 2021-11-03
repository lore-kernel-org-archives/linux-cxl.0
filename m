Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C1C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AEB610E5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKCPVl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:21:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4056 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKCPVl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 11:21:41 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hkqzx2mYCz685Yr;
        Wed,  3 Nov 2021 23:14:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 16:19:02 +0100
Received: from localhost (10.52.126.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 15:19:02 +0000
Date:   Wed, 3 Nov 2021 15:18:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211103151859.0000493a@Huawei.com>
In-Reply-To: <20211022183709.1199701-9-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.31]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 22 Oct 2021 11:36:49 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The CXL port driver will be responsible for managing the decoder
> resources contained within the port. It will also provide APIs that
> other drivers will consume for managing these resources.
> 
> Since the port driver is responsible for instantiating new decoders, and
> it does so during probe(), a new API is needed to add decoders for
> callers which already hold the device lock of the port.
> 
> This patch has no functional change because no driver is registering new
> ports and the root ports that are already registered should be skipped.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Hi Ben, A few fairly generic comments on stuff noticed whilst
catching up with discussion around this series.

Jonathan

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 91b8fd54bc93..ad22caf9135c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -17,6 +17,9 @@
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>  
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>  #define CXL_CM_OFFSET 0x1000
>  #define CXL_CM_CAP_HDR_OFFSET 0x0
> @@ -36,11 +39,22 @@
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
> -#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)

CXL_HDM_DECODERX_TL_HIGH etc perhaps as no longer just decoder 0?


> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> new file mode 100644
> index 000000000000..ebbfb72ae995
> --- /dev/null
> +++ b/drivers/cxl/port.c

...

> +
> +static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
> +{
> +	u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
> +
> +	if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))

Drop the !! as doesn't do anything useful.

> +		return 0;
> +
> +	return ioread64_hi_lo(hdm_decoder +
> +			      CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
> +}
> +
> +static bool is_endpoint_port(struct cxl_port *port)
> +{
> +	if (!port->uport->driver)
> +		return false;
> +
> +	return to_cxl_drv(port->uport->driver)->id ==
> +	       CXL_DEVICE_MEMORY_EXPANDER;
> +}
> +
> +static int enumerate_hdm_decoders(struct cxl_port *port,
> +				  struct cxl_port_data *portdata)
> +{
> +	int i = 0;

Don't init.

> +
> +	for (i = 0; i < portdata->caps.count; i++) {
> +		int iw = 1, ig = 0, rc, target_count = portdata->caps.tc;

Use some more lines for this - it'll be easier to read!

> +		void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
> +		enum cxl_decoder_type type = CXL_DECODER_EXPANDER;
> +		struct resource res = DEFINE_RES_MEM(0, 0);
> +		struct cxl_decoder *cxld;
> +		int *target_map = NULL;
> +		u64 size;
> +
> +		if (is_endpoint_port(port))
> +			target_count = 0;

I'd rather just see a bool for this instead of using the value not allowed for
other cases.  Slightly more code, but no need for the comment in the previous
patch.

> +
> +		cxld = cxl_decoder_alloc(port, target_count);
> +		if (IS_ERR(cxld)) {
> +			dev_warn(&port->dev,
> +				 "Failed to allocate the decoder\n");
> +			return PTR_ERR(cxld);
> +		}
> +
> +		size = get_decoder_size(hdm_decoder, i);
> +		if (size != 0) {
> +			int temp[CXL_DECODER_MAX_INTERLEAVE];
> +			u64 target_list, base;
> +			u32 ctrl;
> +			int j;
> +
> +			target_map = temp;
> +			ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +			base = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
> +			res = (struct resource)DEFINE_RES_MEM(base, size);
> +
> +			cxld->flags = CXL_DECODER_F_EN;
> +			iw = cxl_hdm_decoder_iw(ctrl);
> +			ig = cxl_hdm_decoder_ig(ctrl);
> +
> +			if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
> +				type = CXL_DECODER_ACCELERATOR;
> +
> +			target_list = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_TL_LOW(i));
> +			for (j = 0; j < iw; j++)
> +				target_map[j] = (target_list >> (j * 8)) & 0xff;

temp just went out of scope, and target_map is still in it...

> +		}
> +
> +		cxld->target_type = type;
> +		cxld->res = res;
> +		cxld->interleave_ways = iw;
> +		cxld->interleave_granularity = ig;
> +
> +		rc = cxl_decoder_add_locked(cxld, target_map);
> +		if (rc)
> +			put_device(&cxld->dev);
> +		else
> +			rc = cxl_decoder_autoremove(port->uport->parent, cxld);
> +		if (rc)
> +			dev_err(&port->dev, "Failed to add decoder\n");

why not return an error?

> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_port_probe(struct device *dev)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +	struct cxl_port_data *portdata;
> +	void __iomem *crb;
> +	u32 ctrl;
> +	int rc;
> +
> +	if (port->component_reg_phys == CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	portdata = devm_kzalloc(dev, sizeof(*portdata), GFP_KERNEL);
> +	if (!portdata)
> +		return -ENOMEM;
> +
> +	crb = devm_cxl_iomap_block(&port->dev, port->component_reg_phys,
> +				   CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (IS_ERR_OR_NULL(crb)) {
> +		dev_err(&port->dev, "No component registers mapped\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = map_regs(port, crb, portdata);
> +	if (rc)
> +		return rc;
> +
> +	get_caps(port, portdata);
> +	if (portdata->caps.count == 0) {
> +		dev_err(&port->dev, "Spec violation. Caps invalid\n");
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Enable HDM decoders for this port.
> +	 *
> +	 * FIXME: If the component was using DVSEC range registers for decode,
> +	 * this will destroy that.
> +	 */
> +	ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +	ctrl |= CXL_HDM_DECODER_ENABLE;
> +	writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	rc = enumerate_hdm_decoders(port, portdata);
> +	if (rc) {
> +		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	dev_set_drvdata(dev, portdata);
> +	return 0;
> +}
> +
> +static struct cxl_driver cxl_port_driver = {
> +	.name = "cxl_port",
> +	.probe = cxl_port_probe,
> +	.id = CXL_DEVICE_PORT,
> +};
> +module_cxl_driver(cxl_port_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_ALIAS_CXL(CXL_DEVICE_PORT);

