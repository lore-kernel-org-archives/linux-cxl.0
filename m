Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8898DC77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 11:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFFLLA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFFLK7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 07:10:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577E9E
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 04:10:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb75N73vyz67KPR;
        Tue,  6 Jun 2023 19:08:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 12:10:55 +0100
Date:   Tue, 6 Jun 2023 12:10:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 03/19] cxl/mbox: Move mailbox related driver state to
 its own data structure
Message-ID: <20230606121054.000069e1@Huawei.com>
In-Reply-To: <168592151409.1948938.14287743104711770676.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592151409.1948938.14287743104711770676.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:31:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> 'struct cxl_dev_state' makes too many assumptions about the capabilities
> of a CXL device. In particular it assumes a CXL device has a mailbox and
> all of the infrastructure and state that comes along with that.
> 
> In preparation for supporting accelerator / Type-2 devices that may not
> have a mailbox and in general maintain a minimal core context structure,
> make mailbox functionality a super-set of  'struct cxl_dev_state' with
> 'struct cxl_memdev_state'.
> 
> With this reorganization it allows for CXL devices that support HDM
> decoder mapping, but not other general-expander / Type-3 capabilities,
> to only enable that subset without the rest of the mailbox
> infrastructure coming along for the ride.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not yet sure that the division in exactly in the right place, but we
can move things later if it turns out some elements are more general than
we currently think.

A few trivial things inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---

 
> -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxlds)
> +static struct cxl_mbox_get_supported_logs *
> +cxl_get_gsl(struct cxl_memdev_state *mds)

I'd consider keeping this on one line.  It was between 80 and 90 before and still is...


>  {


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..d3fe73d5ba4d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -267,6 +267,35 @@ struct cxl_poison_state {
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @pmem_res: Active Persistent memory capacity configuration
> + * @ram_res: Active Volatile memory capacity configuration
> + * @component_reg_phys: register base of component registers
> + * @info: Cached DVSEC information about the device.

Not seeing info in this structure.

> + * @serial: PCIe Device Serial Number
> + */
> +struct cxl_dev_state {
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct resource pmem_res;
> +	struct resource ram_res;
> +	resource_size_t component_reg_phys;
> +	u64 serial;
> +};
> +
> +/**
> + * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> + *
> + * CXL 8.1.12.1 PCI Header - Class Code Register Memory Device defines
> + * common memory device functionality like the presence of a mailbox and
> + * the functionality related to that like Identify Memory Device and Get
> + * Partition Info
> + * @cxlds: Core driver state common across Type-2 and Type-3 devices
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
> @@ -275,9 +304,6 @@ struct cxl_poison_state {
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> - * @dpa_res: Overall DPA resource tree for the device
> - * @pmem_res: Active Persistent memory capacity configuration
> - * @ram_res: Active Volatile memory capacity configuration
>   * @total_bytes: sum of all possible capacities
>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
> @@ -286,54 +312,41 @@ struct cxl_poison_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> - * @component_reg_phys: register base of component registers
> - * @info: Cached DVSEC information about the device.

Not seeing this removed from this structure in this patch.
Curiously doesn't seem to be here in first place.

Probably wants precursor fix patch to get rid of it from the docs.

> - * @serial: PCIe Device Serial Number
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
> - * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> + * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
>   */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -
> -	struct cxl_regs regs;
> -	int cxl_dvsec;
> -
> -	bool rcd;
> -	bool media_ready;
> +struct cxl_memdev_state {
> +	struct cxl_dev_state cxlds;
>  	size_t payload_size;
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -
> -	struct resource dpa_res;
> -	struct resource pmem_res;
> -	struct resource ram_res;
>  	u64 total_bytes;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> -
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
> -
> -	resource_size_t component_reg_phys;
> -	u64 serial;
> -
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> -
> -	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +	int (*mbox_send)(struct cxl_memdev_state *mds,
> +			 struct cxl_mbox_cmd *cmd);
>  };

...

...
