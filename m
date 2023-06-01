Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE52C77B7E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjFAP16 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjFAP1p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 11:27:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18710CC
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 08:27:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX91C5x3Yz67gR6;
        Thu,  1 Jun 2023 23:25:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 16:27:13 +0100
Date:   Thu, 1 Jun 2023 16:27:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/port: Enable the HDM decoder capability for switch
 ports
Message-ID: <20230601162712.00003bd5@Huawei.com>
In-Reply-To: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
References: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 May 2023 20:19:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Derick noticed, when testing hot plug, that hot-add behaves nominally
> after a removal. However, if the hot-add is done without a prior
> removal, CXL.mem accesses fail. It turns out that the original
> implementation of the port driver and region programming wrongly assumed
> that platform-firmware always enables the host-bridge HDM decoder
> capability. Add support turning on switch-level HDM decoders in the case
> where platform-firmware has not.
> 
> The implementation is careful to only arrange for the enable to be
> undone if the current instance of the driver was the one that did the
> enable. This is to interoperate with platform-firmware that may expect
> CXL.mem to remain active after the driver is shutdown. This comes at the
> cost of potentially not shutting down the enable on kexec flows, but it
> is mitigated by the fact that the related HDM decoders still need to be
> enabled on an individual basis.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I doubt anyone will be surprised to hear that the QEMU emulation wasn't
checking this bit when doing the topology walk.
Oops - I'll put together a fix.

I'm guessing this is already queued or upstream but if not
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Jonathan

> ---
>  drivers/cxl/core/pci.c        |   27 +++++++++++++++++++++++----
>  drivers/cxl/cxl.h             |    1 +
>  drivers/cxl/port.c            |   14 +++++++++-----
>  tools/testing/cxl/Kbuild      |    1 +
>  tools/testing/cxl/test/mock.c |   15 +++++++++++++++
>  5 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f332fe7af92b..c35c002b65dd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -241,17 +241,36 @@ static void disable_hdm(void *_cxlhdm)
>  	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>  }
>  
> -static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
> +int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
>  {
> -	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	void __iomem *hdm;
>  	u32 global_ctrl;
>  
> +	/*
> +	 * If the hdm capability was not mapped there is nothing to enable and
> +	 * the caller is responsible for what happens next.  For example,
> +	 * emulate a passthrough decoder.
> +	 */
> +	if (IS_ERR(cxlhdm))
> +		return 0;
> +
> +	hdm = cxlhdm->regs.hdm_decoder;
>  	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	/*
> +	 * If the HDM decoder capability was enabled on entry, skip
> +	 * registering disable_hdm() since this decode capability may be
> +	 * owned by platform firmware.
> +	 */
> +	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
> +		return 0;
> +
>  	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
>  	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>  
> -	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
> +	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
>  
>  int cxl_dvsec_rr_decode(struct device *dev, int d,
>  			struct cxl_endpoint_dvsec_info *info)
> @@ -425,7 +444,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (info->mem_enabled)
>  		return 0;
>  
> -	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> +	rc = devm_cxl_enable_hdm(port, cxlhdm);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..f93a28538962 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -710,6 +710,7 @@ struct cxl_endpoint_dvsec_info {
>  struct cxl_hdm;
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  				   struct cxl_endpoint_dvsec_info *info);
> +int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index eb57324c4ad4..17a95f469c26 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -60,13 +60,17 @@ static int discover_region(struct device *dev, void *root)
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> -	int rc;
> +	int rc, nr_dports;
>  
> -	rc = devm_cxl_port_enumerate_dports(port);
> -	if (rc < 0)
> -		return rc;
> +	nr_dports = devm_cxl_port_enumerate_dports(port);
> +	if (nr_dports < 0)
> +		return nr_dports;
>  
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> +	rc = devm_cxl_enable_hdm(port, cxlhdm);
> +	if (rc)
> +		return rc;
> +
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>  
> @@ -75,7 +79,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  		return PTR_ERR(cxlhdm);
>  	}
>  
> -	if (rc == 1) {
> +	if (nr_dports == 1) {
>  		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>  		return devm_cxl_add_passthrough_decoder(port);
>  	}

