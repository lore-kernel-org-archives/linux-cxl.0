Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E6FC77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 11:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFFLPo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjFFLPn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 07:15:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276CE49
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 04:15:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb7Bn32Cxz67j6n;
        Tue,  6 Jun 2023 19:13:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 12:15:35 +0100
Date:   Tue, 6 Jun 2023 12:15:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 04/19] cxl/memdev: Make mailbox functionality optional
Message-ID: <20230606121534.00003870@Huawei.com>
In-Reply-To: <168592151963.1948938.7831940219025967692.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592151963.1948938.7831940219025967692.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:31:59 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In support of the Linux CXL core scaling for a wider set of CXL devices,
> allow for the creation of memdevs with some memory device capabilities
> disabled. Specifically, allow for CXL devices outside of those claiming
> to be compliant with the generic CXL memory device class code, like
> vendor specific Type-2/3 devices that host CXL.mem. This implies, allow
> for the creation of memdevs that only support component-registers, not
> necessarily memory-device-registers (like mailbox registers). A memdev
> derived from a CXL endpoint that does not support generic class code
> expectations is tagged "CXL_DEVTYPE_DEVMEM", while a memdev derived from a
> class-code compliant endpoint is tagged "CXL_DEVTYPE_CLASSMEM".
> 
> The primary assumption of a CXL_DEVTYPE_DEVMEM memdev is that it
> optionally may not host a mailbox. Disable the command passthrough ioctl
> for memdevs that are not CXL_DEVTYPE_CLASSMEM, and return empty strings
> from memdev attributes associated with data retrieved via the
> class-device-standard IDENTIFY command. Note that empty strings were
> chosen over attribute visibility to maintain compatibility with shipping
> versions of cxl-cli that expect those attributes to always be present.
Hmm.  I'm not keen on this, but I guess we've ended up in this corner
so don't have much choice.

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Trivial stuff inline.

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index d3fe73d5ba4d..b8bdf7490d2c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -254,6 +254,20 @@ struct cxl_poison_state {
>  	struct mutex lock;  /* Protect reads of poison list */
>  };
>  
> +/*
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or

Bit of a naming collision with other uses of DEVMEM but I can't immediately think
of a better name so fair enough...

> + *			 HDM-DB, no expectation that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
no requirement that this device

Expectation is a bit strong the other way to my reading.  These device might well
implement some or all of that + other stuff that means they don't want to use the
class code.

> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -273,6 +287,7 @@ struct cxl_poison_state {
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -286,6 +301,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	resource_size_t component_reg_phys;
>  	u64 serial;
> +	enum cxl_devtype type;
>  };
>  
>  /**
> @@ -344,6 +360,8 @@ struct cxl_memdev_state {
>  static inline struct cxl_memdev_state *
>  to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  {
> +	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
> +		return NULL;
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> 

