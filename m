Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA4C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7E061101
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349726AbhICRou convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:44:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3742 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349698AbhICRot (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 13:44:49 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1Q8x3xhBz67Lvm;
        Sat,  4 Sep 2021 01:42:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 19:43:47 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 18:43:46 +0100
Date:   Fri, 3 Sep 2021 18:43:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/13] cxl/core/bus: Enumerate all HDM decoders
Message-ID: <20210903184347.00002b32@Huawei.com>
In-Reply-To: <20210902195017.2516472-13-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-13-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:16 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> As of the CXL 2.0 specification, every port will have between 1 and 10
> HDM decoders available in hardware. These exist in the endpoint, switch,
> and top level hostbridges. HDM decoders are required for configuration
> CXL regions, and therefore enumerating them is an important first step.
> 
> As an example, the below has 4 decoders, a top level CFMWS decoder
> (0.0), a single decoder in a single host bridge (1.0), and two devices
> each with 1 decoder (2.0 and 3.0)
> 
> ├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
> ├── decoder1.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/decoder1.0
> ├── decoder2.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/devport2/decoder2.0
> ├── decoder3.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/devport3/decoder3.0
> 
> Additionally, attributes are added for a port:
> 
> /sys/bus/cxl/devices/port1
> ├── active_decoders
> ├── decoder_count
> ├── decoder_enabled
> ├── max_target_count
> ...
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Documentation/ABI/testing/sysfs-bus-cxl  needs updating.

Various minor things inline.


> ---
>  drivers/cxl/core/bus.c | 161 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h      |  54 ++++++++++++--
>  2 files changed, 209 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index d056dbd794a4..b75e42965e89 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -43,6 +43,15 @@ struct attribute_group cxl_base_attribute_group = {
>  	.attrs = cxl_base_attributes,
>  };
>  
> +static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", !!cxld->decoder_enabled);
> +}
> +static DEVICE_ATTR_RO(enabled);
> +
>  static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> @@ -130,6 +139,7 @@ static ssize_t target_list_show(struct device *dev,
>  static DEVICE_ATTR_RO(target_list);
>  
>  static struct attribute *cxl_decoder_base_attrs[] = {
> +	&dev_attr_enabled.attr,
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_locked.attr,
> @@ -249,8 +259,48 @@ static void cxl_port_release(struct device *dev)
>  	kfree(port);
>  }
>  
> +static ssize_t active_decoders_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	return sysfs_emit(buf, "%*pbl\n", port->decoder_cap.count,
> +			  port->used_decoders);
> +}
> +static DEVICE_ATTR_RO(active_decoders);
> +
> +static ssize_t decoder_count_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	return sysfs_emit(buf, "%d\n", port->decoder_cap.count);
> +}
> +static DEVICE_ATTR_RO(decoder_count);
> +
> +static ssize_t max_target_count_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	return sysfs_emit(buf, "%d\n", port->decoder_cap.target_count);
> +}
> +static DEVICE_ATTR_RO(max_target_count);
> +
> +static struct attribute *cxl_port_caps_attributes[] = {
> +	&dev_attr_active_decoders.attr,
> +	&dev_attr_decoder_count.attr,
> +	&dev_attr_max_target_count.attr,
> +	NULL,
> +};
> +
> +struct attribute_group cxl_port_attribute_group = {
> +	.attrs = cxl_port_caps_attributes,
> +};
> +
>  static const struct attribute_group *cxl_port_attribute_groups[] = {
>  	&cxl_base_attribute_group,
> +	&cxl_port_attribute_group,
>  	NULL,
>  };
>  
> @@ -341,6 +391,107 @@ static int cxl_port_map_component_registers(struct cxl_port *port)
>  	return 0;
>  }
>  
> +static int port_populate_caps(struct cxl_port *port)
> +{
> +	void __iomem *hdm_decoder = port->regs.hdm_decoder;
> +	u32 hdm_cap;
> +
> +	hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> +
> +	port->used_decoders = devm_bitmap_zalloc(&port->dev,
> +						 cxl_hdm_decoder_count(hdm_cap),
> +						 GFP_KERNEL);

Mentioned below. No advantage that I can see in dynamic allocation.
Also, not really populating anything..

> +	if (!port->used_decoders)
> +		return -ENOMEM;
> +
> +	port->decoder_cap.count = cxl_hdm_decoder_count(hdm_cap);
> +	port->decoder_cap.target_count =
> +		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> +	port->decoder_cap.interleave11_8 =
> +		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> +	port->decoder_cap.interleave14_12 =
> +		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> +
> +	return 0;
> +}
> +
> +static int cxl_port_enumerate_hdm_decoders(struct device *host,
> +					   struct cxl_port *port)
> +{
> +	void __iomem *hdm_decoder = port->regs.hdm_decoder;
> +	u32 hdm_ctrl;
> +	int i, rc = 0;
> +
> +	rc = port_populate_caps(port);
> +	if (rc)
> +		return rc;
> +
> +	if (port->decoder_cap.count == 0) {
> +		dev_warn(host, "Found no HDM decoders\n");

No HDM decoders found.

> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < port->decoder_cap.count; i++) {
> +		enum cxl_decoder_type type = CXL_DECODER_EXPANDER;
> +		struct resource res = DEFINE_RES_MEM(0, 0);
> +		struct cxl_decoder *cxld;
> +		int iw = 0, ig = 0;
> +		u32 ctrl;
> +
> +		cxld = cxl_decoder_alloc(port, is_endpoint_decoder(host) ? 0 :
> +					 port->decoder_cap.target_count);
> +		if (IS_ERR(cxld)) {
> +			dev_warn(host, "Failed to allocate the decoder\n");
> +			return PTR_ERR(cxld);
> +		}
> +
> +		ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		cxld->decoder_enabled =
> +			!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +		/* If the decoder is already active, parse info */
> +		if (cxld->decoder_enabled) {
> +			set_bit(i, port->used_decoders);
> +			iw = cxl_hdm_decoder_iw(ctrl);
> +			ig = cxl_hdm_decoder_ig(ctrl);
> +			if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
> +				type = CXL_DECODER_ACCELERATOR;
> +			res.start = readl(hdm_decoder +
> +					  CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
> +			res.start |=
> +				(u64)readl(hdm_decoder +
> +					   CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i))
> +				<< 32;

Perhaps worth thinking about exposing if the decoder is locked as well?
Might be good to let userspace know that..

> +		}
> +
> +		cxld->target_type = type;
> +		cxld->res = res;
> +		cxld->interleave_ways = iw;
> +		cxld->interleave_granularity = ig;
> +
> +		rc = cxl_decoder_add(host, cxld, NULL);
> +		if (rc) {
> +			dev_warn(host, "Failed to add decoder (%d)\n", rc);
> +			kfree(cxld);
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Enable CXL.mem decoding via MMIO for endpoint devices
> +	 *
> +	 * TODO: If a memory device was configured to participate in a region by
> +	 * system firmware via DVSEC, this will break that region.

That seems to me like fatal for this patch set until fixed.
I'm not sure I understand why it will break a region though as I'd assume it
would be already on?

> +	 */
> +	if (is_endpoint_decoder(host)) {
> +		hdm_ctrl = readl(hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +		writel(hdm_ctrl | CXL_HDM_DECODER_ENABLE,
> +		       hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +	}
> +
> +out:

direct returns are much easier to review...


> +	return rc;
> +}
> +
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
>  				       resource_size_t component_reg_phys,
>  				       struct cxl_port *parent_port)
> @@ -432,8 +583,16 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  	/* Platform "switch" has no parent port or component registers */
>  	if (parent_port) {
>  		rc = cxl_port_map_component_registers(port);
> -		if (rc)
> +		if (rc) {
> +			dev_err(host, "Failed to map component registers\n");

*grump*  Unrelated change.  I guess you could sort of argue it's needed to
distinguish the different errors, but that's a stretch.


>  			return ERR_PTR(rc);
> +		}
> +
> +		rc = cxl_port_enumerate_hdm_decoders(host, port);
> +		if (rc) {
> +			dev_err(host, "Failed to enumerate HDM decoders\n");
> +			return ERR_PTR(rc);
> +		}
>  	}
>  
>  	return port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e610fa9dd6c8..6759fe097e12 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -36,11 +36,19 @@
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
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x0
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x10 + (i) * 0x20)

If you are doing the macro to access higher decoders, don't keep
the DECODER0 naming.  DECODERX perhaps?

> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x14 + (i) * 0x20)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x18 + (i) * 0x20)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x1c + (i) * 0x20)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 + (i) * 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)

Perhaps name this bit to indicate that 1 == type 3 device. Otherwise
need a macro to define type2 and one for type3.

>  
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
> @@ -49,6 +57,20 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  	return val ? val * 2 : 1;
>  }
>  
> +static inline int cxl_hdm_decoder_ig(u32 ctrl)
> +{
> +	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> +
> +	return 8 + val;
> +}
> +
> +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> +{
> +	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> +
> +	return 1 << val;
I guess there isn't a strong reason to clamp this to values the
spec actually allows.  Perhaps a comment to say that for this and ig?
> +}
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -188,6 +210,12 @@ enum cxl_decoder_type {
>   */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
> +/*
> + * Current specification goes up to 10 double that seems a reasonable
> + * software max for the foreseeable future

I'd stick to 10 until we have evidence otherwise... If you happen to
have a mysterious strong reason to go with 20 though I'm not that fussed
but I suspect others may have equally strong reasons to pick another number ;)

> + */
> +#define CXL_DECODER_MAX_COUNT 20
> +
>  /**
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
> @@ -197,6 +225,7 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport

Is it currently documented anywhere that ig is in 2**(ig) bytes?
Might be worth adding if not.

>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> + * @decoder_enabled: Is this decoder currently decoding
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -208,6 +237,7 @@ struct cxl_decoder {
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
>  	unsigned long flags;
> +	bool decoder_enabled;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
> @@ -255,6 +285,12 @@ struct cxl_walk_context {
>   * @decoder_ida: allocator for decoder ids
>   * @component_reg_phys: component register capability base address (optional)
>   * @regs: Mapped version of @component_reg_phys
> + * @used_decoders: Bitmap of currently active decoders for the port
> + * @decoder_cap: Capabilities of all decoders contained by the port
> + * @decoder_cap.count: Count of HDM decoders for the port
> + * @decoder_cap.target_count: Max number of interleaved downstream ports
> + * @decoder_cap.interleave11_8: Are address bits 11-8 available for interleave
> + * @decoder_cap.interleave14_12: Are address bits 14-12 available for interleave
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -264,6 +300,14 @@ struct cxl_port {
>  	struct ida decoder_ida;
>  	resource_size_t component_reg_phys;
>  	struct cxl_component_regs regs;
> +
> +	unsigned long *used_decoders;

Given it's not huge use appropriate macro to allocate
it directly here with the maximum of 10.
DECLARE_BITMAP() in similar fashion to patch 19 in Dan's
recent series.

https://lore.kernel.org/all/162982122744.1124374.6742215706893563515.stgit@dwillia2-desk3.amr.corp.intel.com/

(I'm liking lore having "all" now !)

> +	struct {
> +		int count;
> +		int target_count;
> +		bool interleave11_8;
> +		bool interleave14_12;
> +	} decoder_cap;
>  };
>  
>  /**

