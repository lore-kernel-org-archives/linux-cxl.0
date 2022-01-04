Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81DBC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Jan 2022 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiADXVh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:21:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:52090 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbiADXVh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 4 Jan 2022 18:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641338497; x=1672874497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4KWko6gNsPH+L2DhocuIpYWZspbvU83Ae1Kuy3EK+0=;
  b=JQwMocN8saf/yaM8CmcaOy4pnccPjfhSNLTsQr3VdquxERBwI8QAH0ix
   agYiY4/g18u2grkNutx7gFoxSyiV4BXWYQrOoLntFiuox/P0rTN8ZpED+
   DvAOTk8E7Dvl0unh6oNAEhELw1+qLjynEsQqxNI2r1xg9J/GzgiPiYQq8
   NK/zDG7OLb4shspzn/NTLV0SAVEDKWGKksgh8Qa79QPFBP5XK2Ax1/bBg
   RXLLBISRuTemc2+CJIe4ItAz0+Qf3B2wVpm9H3yd+b6hsqwDb7+7WIC0l
   kbKISk8+SMViwAR0RE+Ufp9ptHbf1gbPWDG37xBfCMo1lCzgbG8yAuNKW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241140071"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="241140071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:21:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="620819633"
Received: from pchilaka-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.136.197])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:21:36 -0800
Date:   Tue, 4 Jan 2022 15:21:34 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Do not allow immediate mode in
 SET_PARTITION_INFO
Message-ID: <20220104232134.y7j5rs4ljizkl462@intel.com>
References: <20220103202100.784194-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103202100.784194-1-alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-01-03 12:21:00, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may send the SET_PARTITION_INFO mailbox command using
> the IOCTL interface. Inspect the input payload and fail if the
> immediate flag is set.
> 
> This is the first instance of the driver inspecting an input payload
> from user space. Assume there will be more such cases and implement
> with an extensible helper.

Not sure if it's useful, but this was implemented at some point:
https://lore.kernel.org/linux-cxl/20210210000259.635748-8-ben.widawsky@intel.com/

> 
> Note: At this time immediate partitioning is not allowed because the
> kernel will need to react immediately to this configuration change
> and that support is not yet implemented.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  7 +++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..2cf5ccdea7df 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -352,6 +352,41 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  	return 0;
>  }
>  
> +/**
> + * cxl_payload_from_user_allowed() - Check contents of in_payload.
> + * @opcode: The mailbox command opcode.
> + * @payload_in: Pointer to the input payload passed in from user space.
> + *
> + * Return:
> + *  * true	- payload_in passes check for @opcode.
> + *  * false	- payload_in contains invalid or unsupported values.
> + *
> + * The driver may inspect payload contents before sending a mailbox
> + * command from user space to the device. The intent is to reject
> + * commands with input payloads that are known to be unsafe. This
> + * check is not intended to replace the users careful selection of
> + * mailbox command parameters and makes no guarantee that the user
> + * command will succeed, nor that it is appropriate.
> + *
> + * The specific checks are determined by the opcode.
> + */
> +static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_SET_PARTITION_INFO: {
> +		struct cxl_mbox_set_partition_info *pi;
> +
> +		pi = (struct cxl_mbox_set_partition_info *)payload_in;
> +		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> +			return false;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +	return true;
> +}
> +
>  /**
>   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
>   * @cxlds: The device data for the operation
> @@ -405,6 +440,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  		}
>  	}
>  
> +	if (!cxl_payload_from_user_allowed(mbox_cmd.opcode,
> +					   mbox_cmd.payload_in)) {
> +		dev_dbg(dev, "%s: input payload not allowed\n",
> +			cxl_command_names[cmd->info.id].name);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +

Perhaps foolishly, the kdocs for handle_mailbox_cmd_from_user() documents the
error conditions. Would you mind adding EINVAL?

Also, cxl_validate_cmd_from_user() was supposed to handle this kind of stuff.
All validation from user commands should spawn from that. Is there some reason
this one is different?

>  	dev_dbg(dev,
>  		"Submitting %s command for user\n"
>  		"\topcode: %x\n"
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8d96d009ad90..e10b86f06c75 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -231,6 +231,13 @@ struct cxl_mbox_set_lsa {
>  	u8 data[];
>  } __packed;
>  
> +struct cxl_mbox_set_partition_info {
> +	u64 volatile_capacity;
> +	u8 flags;
> +} __packed;
> +
> +#define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> +

I think these defines belong in cxl.h

>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> 
> base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
> -- 
> 2.31.1
> 
