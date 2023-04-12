Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63CC77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 04:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLEps (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 00:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLEps (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 00:45:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00012D57
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 21:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681274745; x=1712810745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vekp8poAw4bqxOzbxQw2BHBb3fUXQB5XUoNyYziwYo=;
  b=ldKM0jwk4486K4pxJzl9w5qCSXF4IO/C9Y1O86h24fjLO6cP8marG9pY
   He2pFsSaaN4dksV/PtL+NV5inb0nw7dVdsN0vXPRFOvydE/DK/gUWXOtv
   7DZr5Y0RzU7gi7fESFZTI8aoSWVh0/vVNWb0Cx52yR/tIDXkHF0ujkyGi
   YcMrPwAGqg95GJa2fzPqYOcMGOMJrczoBx0Sf14fI3HDbhhdaOW8eH6IH
   VslBMgqRqu+VZ83JEM2jcTGDlb2V6CLYNNSlz0JZdut5FS3rHwMFDdWpo
   gZNfX4vyY5HpnWE68t8wwg2iiI/Q3pCh4BsQdd4QKtgzcNFS2zGNy6cMZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346475628"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="346475628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 21:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753380353"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="753380353"
Received: from mblair2-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 21:45:44 -0700
Date:   Tue, 11 Apr 2023 21:45:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZDY3dR0vA6+zihxN@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices maintain a list of locations that are poisoned or result
> > in poison if the addresses are accessed by the host.
> > 
> > Per the spec, (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> > list as a set of Media Error Records that include the source of the
> > error, the starting device physical address, and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the poison list.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 71 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/pci.c       |  4 +++
> >  3 files changed, 142 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index f2addb457172..69a5d69dd53b 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -5,6 +5,8 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/ktime.h>
> >  #include <linux/mutex.h>
> > +#include <asm/unaligned.h>
> > +#include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  
> > @@ -994,6 +996,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> >  	struct cxl_mbox_identify id;
> >  	struct cxl_mbox_cmd mbox_cmd;
> > +	u32 val;
> >  	int rc;
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> > @@ -1017,6 +1020,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
> >  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> >  
> > +	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
> > +		val = get_unaligned_le24(id.poison_list_max_mer);
> > +		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> > +	}
> > +
> 
> With this new interface I do not expect we want to support user tooling
> that wants to retrieve the list via ioctl. So I think this wants a
> lead-in patch that deprecates the poison command support so that the
> linux-cxl community only has one mechanism to maintain going forward.
> 
> Something like the below as a lead-in, and then you would add code to
> cxl_walk_cel() to set a flag for the "get poison" machinery.

In the inject & clear series, I made the commands kernel exclusive (and
also blocked their usage in raw mode).

https://lore.kernel.org/linux-cxl/1576040e-e8db-bc78-2fa3-622c8f7da8ec@intel.com/T/#m5b86f3e88ee7ad5b92843babdb9fd41b7f03cf36

Is that not enough or not the right protection?

Alison

> 
> -- >8 --
> From f2cd1d1e09fe6f36255f3b8cd831b2b4903045d4 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 11 Apr 2023 17:48:45 -0700
> Subject: [PATCH] cxl/mbox: Deprecate poison commands
> 
> The CXL subsystem is adding a formal mechanism for retrieving the poison
> list. Minimize the maintenance burden going forward, and maximize the
> investment in common tooling by deprecating direct user access to issue
> this command outside of CXL_MEM_RAW_COMMANDS debug scenarios.
> 
> A new cxl_deprecated_commands[] list is created for querying which
> command ids defined in previous kernels are now deprecated.
> 
> Effectively all of the commands defined in:
> 
> 87815ee9d006 ("cxl/pci: Add media provisioning required commands")
> 
> ...were defined prematurely and should have waited until the kernel
> implementation was decided. To my knowledge there are no shipping
> devices with poison listing support and no known tools that would
> regress with this change.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  3 ---
>  include/uapi/linux/cxl_mem.h | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..8e24038b8769 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -61,9 +61,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
>  	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> -	CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
> -	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
> -	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 86bbacf2a315..90f17343f1ba 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -40,19 +40,22 @@
>  	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
>  	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
>  	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
> -	___C(GET_POISON, "Get Poison List"),                              \
> -	___C(INJECT_POISON, "Inject Poison"),                             \
> -	___C(CLEAR_POISON, "Clear Poison"),                               \
> +	___DEPRECATED(GET_POISON, "Get Poison List"),                     \
> +	___DEPRECATED(INJECT_POISON, "Inject Poison"),                    \
> +	___DEPRECATED(CLEAR_POISON, "Clear Poison"),                      \
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> +#define ___DEPRECATED(a, b) CXL_MEM_DEPRECATED_ID_##a
>  enum { CXL_CMDS };
>  
>  #undef ___C
> +#undef ___DEPRECATED
>  #define ___C(a, b) { b }
> +#define ___DEPRECATED(a, b) { "Deprecated " b }
>  static const struct {
>  	const char *name;
>  } cxl_command_names[] __attribute__((__unused__)) = { CXL_CMDS };
> @@ -68,6 +71,28 @@ static const struct {
>   */
>  
>  #undef ___C
> +#undef ___DEPRECATED
> +#define ___C(a, b) (0)
> +#define ___DEPRECATED(a, b) (1)
> +
> +static const u8 cxl_deprecated_commands[]
> +	__attribute__((__unused__)) = { CXL_CMDS };
> +
> +/*
> + * Here's how this actually breaks out:
> + * cxl_deprecated_commands[] = {
> + *	[CXL_MEM_COMMAND_ID_INVALID] = 0,
> + *	[CXL_MEM_COMMAND_ID_IDENTIFY] = 0,
> + *	...
> + *	[CXL_MEM_DEPRECATED_ID_GET_POISON] = 1,
> + *	[CXL_MEM_DEPRECATED_ID_INJECT_POISON] = 1,
> + *	[CXL_MEM_DEPRECATED_ID_CLEAR_POISON] = 1,
> + *	...
> + * };
> + */
> +
> +#undef ___C
> +#undef ___DEPRECATED
>  
>  /**
>   * struct cxl_command_info - Command information returned from a query.
> -- 
> 2.39.2
> -- 8< --
> 
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> > @@ -1107,6 +1115,69 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
> >  
> > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +		       struct cxl_region *cxlr)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_mbox_poison_out *po;
> > +	struct cxl_mbox_poison_in pi;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int nr_records = 0;
> > +	int rc;
> > +
> > +	rc = mutex_lock_interruptible(&cxlds->poison.lock);
> > +	if (rc)
> > +		return rc;
> > +
> > +	po = cxlds->poison.list_out;
> > +	pi.offset = cpu_to_le64(offset);
> > +	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_POISON,
> > +		.size_in = sizeof(pi),
> > +		.payload_in = &pi,
> > +		.size_out = cxlds->payload_size,
> > +		.payload_out = po,
> > +		.min_out = struct_size(po, record, 0),
> > +	};
> > +
> > +	do {
> > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +		if (rc)
> > +			break;
> > +
> > +		/* TODO TRACE the media error records */
> > +
> > +		/* Protect against an uncleared _FLAG_MORE */
> > +		nr_records = nr_records + le16_to_cpu(po->count);
> > +		if (nr_records >= cxlds->poison.max_errors) {
> > +			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> > +				nr_records);
> > +			break;
> > +		}
> > +	} while (po->flags & CXL_POISON_FLAG_MORE);
> > +
> > +	mutex_unlock(&cxlds->poison.lock);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> > +
> > +int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> > +{
> > +	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
> > +		return 0;
> > +
> > +	cxlds->poison.list_out = devm_kzalloc(cxlds->dev, cxlds->payload_size,
> > +					      GFP_KERNEL);
> 
> Given the payload can be multiple pages in size use kvmalloc() like
> cxl_mem_alloc_event_buf().
> 
> > +	if (!cxlds->poison.list_out)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&cxlds->poison.lock);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> > +
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> >  {
> >  	struct cxl_dev_state *cxlds;
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ccbafc05a636..a3033c8dd8e2 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -215,6 +215,24 @@ struct cxl_event_state {
> >  	struct mutex log_lock;
> >  };
> >  
> > +/**
> > + * struct cxl_poison_state - Driver poison state info
> > + *
> > + * @max_errors: Maximum media error records held in device cache
> > + * @list_out: The poison list payload returned by device
> > + * @lock: Protect reads of the poison list
> > + *
> > + * Reads of the poison list are synchronized to ensure that a reader
> > + * does not get an incomplete list because their request overlapped
> > + * (was interrupted or preceded by) another read request of the same
> > + * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
> > + */
> > +struct cxl_poison_state {
> > +	u32 max_errors;
> > +	struct cxl_mbox_poison_out *list_out;
> > +	struct mutex lock;  /* Protect reads of poison list */
> > +};
> > +
> >  /**
> >   * struct cxl_dev_state - The driver device state
> >   *
> > @@ -251,6 +269,7 @@ struct cxl_event_state {
> >   * @serial: PCIe Device Serial Number
> >   * @doe_mbs: PCI DOE mailbox array
> >   * @event: event log driver state
> > + * @poison: poison driver state info
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -290,6 +309,7 @@ struct cxl_dev_state {
> >  	struct xarray doe_mbs;
> >  
> >  	struct cxl_event_state event;
> > +	struct cxl_poison_state poison;
> >  
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> > @@ -538,6 +558,50 @@ struct cxl_mbox_set_timestamp_in {
> >  
> >  } __packed;
> >  
> > +/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> > +struct cxl_mbox_poison_in {
> > +	__le64 offset;
> > +	__le64 length;
> > +} __packed;
> > +
> > +struct cxl_mbox_poison_out {
> > +	u8 flags;
> > +	u8 rsvd1;
> > +	__le64 overflow_t;
> 
> I was wondering what the "_t" meant, I always read that as "type". Perhaps
> "_ts" or even just spell out "_timestamp".
> 
> Aside from the minor fixups and reworking the enumeration mechanism per
> above, this looks good to me.
