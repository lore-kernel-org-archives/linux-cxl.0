Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFACC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 11:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBTLhD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBTLhD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 20 Feb 2023 06:37:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183A211E
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 03:37:01 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PL0hP6k8hz6J9hS;
        Mon, 20 Feb 2023 19:35:01 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 20 Feb
 2023 11:36:58 +0000
Date:   Mon, 20 Feb 2023 11:36:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v5 6/7] cxl/hdm: Add emulation when HDM decoders are not
 committed
Message-ID: <20230220113657.000042e1@huawei.com>
In-Reply-To: <167640369536.935665.611974113442400127.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
        <167640369536.935665.611974113442400127.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 14 Feb 2023 11:41:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> For the case where DVSEC range register(s) are active and HDM decoders are
> not committed, use RR to provide emulation. A first pass is done to note
> whether any decoders are committed. If there are no committed endpoint
> decoders, then DVSEC ranges will be used for emulation.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm confused a bit here.  I 'think' the aim should always be to use
HDM decoders unless they either aren't present or we know the
DVSEC range registers are in use.

The conditions in here are too broad + trip up current QEMU.
There is a 'bug' in QEMU as it programs the base registers in DVSEC
but it doesn't affect this flow (and shouldn't).

I'm not sure how you are detecting 'active' for the DVSEC range
registers as described in this patch description. As far as I can
tell there is no way to work that out other than if the top level
CXL.mem_enabled == true;  The various active bits in the range registers
refer to whether the memory behind them is ready to use, not anything
to do whether the range registers are setup correctly and 'turned on'.

If CXL.mem is not enabled, the memory is definitely not
in use. Equation 8-2

Memory_active AND CXL Mem_Enable=1

Now the snag is that CXL mem enabled has been set already in
cxl_hdm_decode_init() called from cxl_endpoint_port_probe()

So the hack I'm carrying is to stash if 'it was not enabled when
we would otherwise turn it on'.  If that condition is true and
there are HDM decoders, we should use them.  Sometimes it feels
like there is no right order possible for enabling all of a CXL
device!

Note the QEMU device here is heaving like any unconfigured freshly
reset type 3 device - or a hotplugged one.


From 5c3e6c5c5c6c37dd0e614273113daf1ff2487e53 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 20 Feb 2023 11:24:34 +0000
Subject: [PATCH] hack

---
 drivers/cxl/core/hdm.c | 11 ++++++++---
 drivers/cxl/core/pci.c |  1 +
 drivers/cxl/cxl.h      |  2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 45deda18ed32..a2b209cf9856 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -739,7 +739,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
-static bool should_emulate_decoders(struct cxl_port *port)
+static bool should_emulate_decoders(struct cxl_port *port,
+				    struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
@@ -752,6 +753,9 @@ static bool should_emulate_decoders(struct cxl_port *port)
 	if (!hdm)
 		return true;
 
+	if (info->was_not_enabled_at_probe) {
+		return false;
+	}
 	/*
 	 * If any decoders are committed already, there should not be any
 	 * emulated DVSEC decoders.
@@ -780,7 +784,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
-	if (should_emulate_decoders(port))
+	if (should_emulate_decoders(port, info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
 
 	if (is_endpoint_decoder(&cxld->dev))
@@ -806,7 +810,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
-	if (cxled && !committed && range_len(&info->dvsec_range[which]))
+	if ((!info || !info->was_not_enabled_at_probe) && cxled && !committed &&
+	    range_len(&info->dvsec_range[which]))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
 
 	/* decoders are enabled if committed */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7328a2552411..a08c35216ad8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -377,6 +377,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (hdm)
 		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
+	info->was_not_enabled_at_probe = !info->mem_enabled;
 	/*
 	 * If the HDM Decoder Capability is already enabled then assume
 	 * that some other agent like platform firmware set it up.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d853a0238ad7..c32a9f9438e8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -696,11 +696,13 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @was_not_enabled_at_probe: hack
  * @ranges: Number of active HDM ranges this device uses.
  * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
  */
 struct cxl_endpoint_dvsec_info {
 	bool mem_enabled;
+	bool was_not_enabled_at_probe;
 	int ranges;
 	struct range dvsec_range[2];
 };
-- 
2.37.2




> ---
>  drivers/cxl/core/hdm.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a49543f22dca..39e02f28b6a6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -730,6 +730,32 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static bool should_emulate_decoders(struct cxl_port *port)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 ctrl;
> +	int i;
> +
> +	if (!is_cxl_endpoint(cxlhdm->port))
> +		return false;
> +
> +	if (!hdm)
> +		return true;
> +
> +	/*
> +	 * If any decoders are committed already, there should not be any
> +	 * emulated DVSEC decoders.
> +	 */
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> @@ -745,6 +771,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		unsigned char target_id[8];
>  	} target_list;
>  
> +	if (should_emulate_decoders(port))
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +
>  	if (is_endpoint_decoder(&cxld->dev))
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  
> 

