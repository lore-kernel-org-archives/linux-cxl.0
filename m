Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47288C54EBD
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 13:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjAMNvN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbjAMNup (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 08:50:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9626C5
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 05:46:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtjKF188qz688Yy;
        Fri, 13 Jan 2023 21:42:41 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 13:46:28 +0000
Date:   Fri, 13 Jan 2023 13:46:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 3/8] cxl: refactor cxl_hdm_decode_init()
Message-ID: <20230113134627.00005117@Huawei.com>
In-Reply-To: <167330060509.975161.6672958439144493413.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330060509.975161.6672958439144493413.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 09 Jan 2023 14:43:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With the previous refactoring of DVSEC range registers out of
> cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
> __cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.
> cxl_hdm_decode_init() now returns more error codes than just -EBUSY.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One trivial style comment.  Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
>  			struct cxl_endpoint_dvsec_info *info)
>  {
> @@ -449,17 +375,68 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct device *dev = &pdev->dev;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_port *port = cxlhdm->port;
> +	struct cxl_port *root;
> +	int i, rc, allowed;
> +	u32 global_ctrl;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>  
>  	/*
> -	 * If DVSEC ranges are being used instead of HDM decoder registers there
> -	 * is no use in trying to manage those.
> +	 * If the HDM Decoder Capability is already enabled then assume
> +	 * that some other agent like platform firmware set it up.
>  	 */
> -	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, info)) {
> -		dev_err(dev,
> -			"Legacy range registers configuration prevents HDM operation.\n");
> -		return -EBUSY;
> +	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
> +		return devm_cxl_enable_mem(&port->dev, cxlds);
> +
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> +		struct device *cxld_dev;
> +
> +		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> +					     dvsec_range_allowed);
> +		if (!cxld_dev) {
> +			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> +			continue;
> +		}
> +		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> +		put_device(cxld_dev);
> +		allowed++;
>  	}
>  
> +	if (!allowed) {
> +		cxl_set_mem_enable(cxlds, 0);
> +		info->mem_enabled = 0;
> +	}
> +
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> +	 * Decoder Capability Enable.
> +	 */
> +	if (info->mem_enabled)
> +		return -EBUSY;
> +
> +	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_cxl_enable_mem(&port->dev, cxlds);
> +	if (rc)
> +		return rc;
> +
>  	return 0;

Maybe simplify to
	return devm_cxl_enable_mem(...);
if not touched again in later patches.

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> 
> 

