Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F6C54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAZT7Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 14:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZT7Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 14:59:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D0410A3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674763163; x=1706299163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cZB+CPnYmbV2n1wL/MD8xedv1mfY4vPQzkN5nh3VUDw=;
  b=gEZ+g730mQvQvaxJdGpLVaGJE519vjxd2ctwFahtSzPChLtph/Nyz7WC
   Aq57F1OHu5wEcEk44XaPzdpz4WI/hDldcLyp24GdbAxqwLdROFT4KGJ1u
   dOcTEaDTvPENeEKR7tPUo32U+ROEByBInF+biItfQb/oHrEt/oFOlF96c
   VxzuOe+xhu0zkLbyWTIZK1OSLQHyAn2cRnLv1uHx3XN88pBxXAeBk2l1h
   pvXScykuflmJpXLirfD8BPEGiqCrgzcu4O6c4zbDcsLUu5hD2xsq+wE5N
   DRLEILcgHl1iWzsVzZquiqq3WmGMlPbfu8mQQfbECKdBB+kbm1DH0Pvz/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391454594"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391454594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:59:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="662990902"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="662990902"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.132.52])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:59:22 -0800
Date:   Thu, 26 Jan 2023 11:59:21 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <Y9LbmW9H3WWfqx2U@aschofie-mobl2>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 26, 2023 at 06:04:58PM +0000, Jonathan Cameron wrote:
> CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> the timestamp after every Conventional or CXL Reset to ensure accurate
> timestamps. This should include on initial boot up. The time base that
> is being set is used by a device for the poison list overflow timestamp
> and all event timestamps.  Note that the command is optional and if
> not supported and the device cannot return accurate timestamps it will
> fill the fields in with an appropriate marker (see the specification
> description of each timestamp).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Open question: Should we only do this if Linux has control of the
> error handling?  In theory it should be safe anyway given the
> specification is clear that the timestamp base should always be the
> same - so subject to small errors we shouldn't cause any firmware first
> handling to get confused.
> 
>  drivers/cxl/core/mbox.c      | 25 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  7 +++++++
>  drivers/cxl/pci.c            |  5 +++++
>  include/uapi/linux/cxl_mem.h |  1 +
>  4 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a7317bb142ed 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(SET_TIMESTAMP, 8, 0, 0),
>  };
>  
>  /*
> @@ -93,6 +94,7 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>  	CXL_MBOX_OP_SCAN_MEDIA,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +	CXL_MBOX_OP_SET_TIMESTAMP,
>  };
>  
>  /*
> @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_timestamp_in pi;
> +
> +	/*
> +	 * Command is optional and functionality should not be affected if
> +	 * the command is not available.
> +	 */
> +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> +		return 0;

Jonathan,

Would it be more efficient to call ktime_get_real_ns() right here,
rather than pass in the call from cxl_pci_probe()?

Alison
> +
> +	pi.timestamp = ts;
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_TIMESTAMP,
> +		.size_in = sizeof(pi),
> +		.payload_in = &pi,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..0ca7a35de893 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -274,6 +274,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> +	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> @@ -372,6 +373,11 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> +struct cxl_mbox_set_timestamp_in {
> +	__le64 timestamp;
> +} __packed;
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -441,6 +447,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2bbebbc7e032..30a2b231d970 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
> +#include <linux/timekeeping.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> @@ -482,6 +483,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_set_timestamp(cxlds, ktime_get_real_ns());
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..333301037b74 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,6 +41,7 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> +	___C(SET_TIMESTAMP, "Set Device Timestamp"),                      \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 
> base-commit: 172738bbccdb4ef76bdd72fc72a315c741c39161
> -- 
> 2.37.2
> 
