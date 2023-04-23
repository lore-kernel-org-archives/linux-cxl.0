Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE1C6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDWP2i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDWP2h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:28:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12A10F6
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:28:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4Bsp40xcz6J6n3;
        Sun, 23 Apr 2023 23:25:34 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:28:32 +0100
Date:   Sun, 23 Apr 2023 16:28:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v13 3/9] cxl/mbox: Initialize the poison state
Message-ID: <20230423162831.00001a2c@huawei.com>
In-Reply-To: <9078d180769be28a5087288b38cdfc827cae58bf.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
        <9078d180769be28a5087288b38cdfc827cae58bf.1681838291.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:39:03 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Driver reads of the poison list are synchronized to ensure that a
> reader does not get an incomplete list because their request
> overlapped (was interrupted or preceded by) another read request
> of the same DPA range. (CXL Spec 3.0 Section 8.2.9.8.4.1). The
> driver maintains state information to achieve this goal.
> 
> To initialize the state, first recognize the poison commands in
> the CEL (Command Effects Log). If the device supports Get Poison
> List, allocate a single buffer for the poison list and protect it
> with a lock.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Nice. One passing comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 81 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h    | 34 +++++++++++++++++
>  drivers/cxl/pci.c       |  4 ++
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fd1026970d3a..17737386283a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> @@ -120,6 +121,43 @@ static bool cxl_is_security_command(u16 opcode)
>  	return false;
>  }
>  
> +static bool cxl_is_poison_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_POISON_CMDS 0x43
> +
> +	if ((opcode >> 8) == CXL_MBOX_OP_POISON_CMDS)

Perhaps at somepoint we should add macros to split the opcodes up?
Doesn't need to be in this series, but if we get a lot of opcode >> 8 it
might be nice (there are two that I'm seeing so far).

> +		return true;
> +
> +	return false;
> +}
> +
> +static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
> +				       u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_POISON:
> +		set_bit(CXL_POISON_ENABLED_LIST, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_INJECT_POISON:
> +		set_bit(CXL_POISON_ENABLED_INJECT, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_CLEAR_POISON:
> +		set_bit(CXL_POISON_ENABLED_CLEAR, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS:
> +		set_bit(CXL_POISON_ENABLED_SCAN_CAPS, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SCAN_MEDIA:
> +		set_bit(CXL_POISON_ENABLED_SCAN_MEDIA, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA:
> +		set_bit(CXL_POISON_ENABLED_SCAN_RESULTS, poison->enabled_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>  {
>  	struct cxl_mem_command *c;
> @@ -635,13 +673,18 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd) {
> +		if (!cmd && !cxl_is_poison_command(opcode)) {
>  			dev_dbg(cxlds->dev,
>  				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
>  		}
>  
> -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		if (cmd)
> +			set_bit(cmd->info.id, cxlds->enabled_cmds);
> +
> +		if (cxl_is_poison_command(opcode))
> +			cxl_set_poison_cmd_enabled(&cxlds->poison, opcode);
> +
>  		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
> @@ -1108,6 +1151,40 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +static void free_poison_buf(void *buf)
> +{
> +	kvfree(buf);
> +}
> +
> +/* Get Poison List output buffer is protected by cxlds->poison.lock */
> +static int cxl_poison_alloc_buf(struct cxl_dev_state *cxlds)
> +{
> +	cxlds->poison.list_out = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!cxlds->poison.list_out)
> +		return -ENOMEM;
> +
> +	return devm_add_action_or_reset(cxlds->dev, free_poison_buf,
> +					cxlds->poison.list_out);
> +}
> +
> +int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	if (!test_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds))
> +		return 0;
> +
> +	rc = cxl_poison_alloc_buf(cxlds);
> +	if (rc) {
> +		clear_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds);
> +		return rc;
> +	}
> +
> +	mutex_init(&cxlds->poison.lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ccbafc05a636..16e0241d72a9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -215,6 +215,37 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/* Device enabled poison commands */
> +enum poison_cmd_enabled_bits {
> +	CXL_POISON_ENABLED_LIST,
> +	CXL_POISON_ENABLED_INJECT,
> +	CXL_POISON_ENABLED_CLEAR,
> +	CXL_POISON_ENABLED_SCAN_CAPS,
> +	CXL_POISON_ENABLED_SCAN_MEDIA,
> +	CXL_POISON_ENABLED_SCAN_RESULTS,
> +	CXL_POISON_ENABLED_MAX
> +};
> +
> +/**
> + * struct cxl_poison_state - Driver poison state info
> + *
> + * @max_errors: Maximum media error records held in device cache
> + * @enabled_cmds: All poison commands enabled in the CEL
> + * @list_out: The poison list payload returned by device
> + * @lock: Protect reads of the poison list
> + *
> + * Reads of the poison list are synchronized to ensure that a reader
> + * does not get an incomplete list because their request overlapped
> + * (was interrupted or preceded by) another read request of the same
> + * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
> + */
> +struct cxl_poison_state {
> +	u32 max_errors;
> +	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
> +	struct cxl_mbox_poison_out *list_out;
> +	struct mutex lock;  /* Protect reads of poison list */
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -251,6 +282,7 @@ struct cxl_event_state {
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
>   * @event: event log driver state
> + * @poison: poison driver state info
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -290,6 +322,7 @@ struct cxl_dev_state {
>  	struct xarray doe_mbs;
>  
>  	struct cxl_event_state event;
> +	struct cxl_poison_state poison;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
> @@ -608,6 +641,7 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
>  int cxl_set_timestamp(struct cxl_dev_state *cxlds);
> +int cxl_poison_state_init(struct cxl_dev_state *cxlds);
>  
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 60b23624d167..827ea0895778 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -769,6 +769,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_poison_state_init(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;

