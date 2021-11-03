Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97407C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EAA610FC
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 13:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKCNxo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:53:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4055 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhKCNxn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 09:53:43 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hkp2S15wwz67lD7;
        Wed,  3 Nov 2021 21:46:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 3 Nov 2021 14:51:05 +0100
Received: from localhost (10.52.126.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 13:51:04 +0000
Date:   Wed, 3 Nov 2021 13:51:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [INTERNAL PATCH 2/2] cxl/cxlmem: Change cxl_mem to a more
 descriptive name
Message-ID: <20211103135102.00001052@Huawei.com>
In-Reply-To: <20211102202901.3675568-3-ira.weiny@intel.com>
References: <20211102202901.3675568-1-ira.weiny@intel.com>
        <20211102202901.3675568-3-ira.weiny@intel.com>
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

On Tue, 2 Nov 2021 13:29:01 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The cxl_mem object actually represents the state of a CXL device within the
> driver.  This is data layered on top of the PCI or other device.  Even though
> the only device currently represented is a memory device, calling this cxl_mem
> is confusing because this is not solely a CXL memory device.  Furthermore,
> cxl_memdev does drive a CXL memory device.  So changing the name helps to
> distinguish these to structures.
> 
> Update the structure name, function names, and the kdocs to reflect the
> real uses of this structure.
> 
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
...
Hi Ira,

>  /**
>   * struct cxl_mbox_cmd - A command to be submitted to hardware.
> @@ -90,8 +90,13 @@ struct cxl_mbox_cmd {
>  #define CXL_CAPACITY_MULTIPLIER SZ_256M
>  
>  /**
> - * struct cxl_mem - A CXL memory device
> - * @dev: The device associated with this CXL device.
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
>   * @cxlmd: Logical memory device chardev / interface
>   * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
> @@ -117,7 +122,7 @@ struct cxl_mbox_cmd {
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
>   */
> -struct cxl_mem {
> +struct cxl_dev_state {
>  	struct device *dev;
>  	struct cxl_memdev *cxlmd;

This patch got me thinking about whether the new name should have some
reference to it being the dev state for a type 3 device, because of this
pointer the cxlmd making me think this wasn't generic enough to be called
just cxl_dev_state.

Naturally next step was to wonder what this was used for....

Far as I can tell it isn't set or used.  Can we drop this pointer?
That would make it more obvious this simply provides services to the cxl_memdev
as there isn't any path for things to flow the other way.

At that point, there are still some memory device specific items in here
but they are all caches of things we have read from the device so they
don't bother me that much.

Jonathan

>  
> @@ -142,7 +147,7 @@ struct cxl_mem {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> -	int (*mbox_send)(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd);
> +	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
...
