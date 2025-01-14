Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1216189B8F;
	Tue, 14 Jan 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871135; cv=none; b=F9zqSznj8eZS8HfMOWPllp9FZ15Bk4/I711LgA9JEuleFIbwJYIvv2PSUB4ds+sAIxH5x9Yh5x8uQF/JWvPFmpkAzWaP4x6AlGodeOjvbrL9UdOmWjq8hclDccgN+8CYpyunX1fNzAJJcGhw/sBjEtbv5I56z6+uDlUnOJcaIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871135; c=relaxed/simple;
	bh=wkGB3AcjWp88PReucHleWWof/3R/8Caxjm/kGPJ8OWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPVs054a4JBZJpj5fy/DTY/BuZDo49dmobdnO6bLwdIhyD1v+IJZMuetq5/9hvMV0x+E9SIp1dkNJZngikCnCxIFOqQjdrNZixOke6mcUoo9+bQMrzIVTJvSmj2DfIYairkD1RwtsCw5M7UxENgZQrrMHQIkEPs3rI0C8QnVCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gszAyoJ/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gszAyoJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736871133; x=1768407133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wkGB3AcjWp88PReucHleWWof/3R/8Caxjm/kGPJ8OWo=;
  b=gszAyoJ/earG5NYpMbMnspJQQM51YlLEBx2epX00zxAx2sv9MbNfOvWn
   YdkYdtd1A/MEjEwtBiRgffQaRfP9P4WHDo+vvRR2aFF09IWtpxOIa29Wl
   OY0bdsuubMKi6Yb42M/ZviFCrSKJrZsZXxV0VzJ5YZ6lNbiCIfQxIM9Fs
   XpXxnIf94SmU9t2XZcLXv3JbThmBg0Bf612pG8YnwglUOz5uQwkpVy+wH
   +UdORgyysaDg0JeJroyuO6DQaq0shkB1Pc8lL93Gyp8ZGduo1moxV+h8R
   TqApZJ1oYtLw3ikEIj6h97zlnaQsU1z53Sl8LykelNK1vwX7Yb6SnJDYj
   w==;
X-CSE-ConnectionGUID: nllSD43mSsuy2DSyHS4NLQ==
X-CSE-MsgGUID: mGMu4SW+Q2m/f+g4SdXYww==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47664518"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="47664518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:12:12 -0800
X-CSE-ConnectionGUID: xqrrpjudQTeJy2bbOEoS5w==
X-CSE-MsgGUID: eTe7LUzjT/Oe87PTZB4/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109794998"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:12:11 -0800
Message-ID: <831f83fa-01da-42aa-8d9b-c0662e520134@intel.com>
Date: Tue, 14 Jan 2025 09:12:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/pci: lockless background synchronous polling
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
 a.manzanares@samsung.com, sthanneeru.opensrc@micron.com,
 emirakhur@micron.com, ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
 sthanneeru@micron.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241022031809.242591-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
> For non-sanitize background commands we rely on holding the mbox_mutex
> throughout the duration of the operation. This causes other incoming
> commands to queue up behind, and interleaving executions while the
> background command is timesliced by the user.
> 
> However, in order to support the mbox request cancel background
> operation command, the lock will need to be available to actually
> perform the request. Semantically this allows other commands to
> many times be at the mercy of hardware returning the respective error.
> Potentially users would be exposed to changes in the form of errors
> instead of commands taking longer to run - but this is not forseen
> as a problem.
> 
> In order to not loose sync with the hardware, introduce a mailbox
> atomic that blocks any other incoming bg operations while the driver
> is still polling (synchronously) on the current one.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c |   1 +
>  drivers/cxl/cxlmem.h    |  13 +++++
>  drivers/cxl/pci.c       | 114 +++++++++++++++++++++++-----------------
>  include/cxl/mailbox.h   |   2 +
>  4 files changed, 82 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5175138c4fb7..9af3cd16d23d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1429,6 +1429,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  
>  	cxl_mbox->host = host;
>  	mutex_init(&cxl_mbox->mbox_mutex);
> +	atomic_set(&cxl_mbox->poll_bgop, 0);
>  	rcuwait_init(&cxl_mbox->mbox_wait);
>  
>  	return 0;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..b933fb73ef8a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -557,6 +557,19 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> +static inline bool cxl_is_background_cmd(u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_TRANSFER_FW:
> +	case CXL_MBOX_OP_ACTIVATE_FW:
> +	case CXL_MBOX_OP_SCAN_MEDIA:
> +	case CXL_MBOX_OP_SANITIZE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Should this information be pulled from the CEL entry? We should add the code to store the 'command effect' field when walking the CEL and store this information for each command. And then we can just check bit6 of the field rather than statically program that in the kernel.

DJ

> +
>  #define DEFINE_CXL_CEL_UUID                                                    \
>  	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
>  		  0x3b, 0x3f, 0x17)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..f2378604669b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -278,29 +278,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>  
> -	/*
> -	 * Handle the background command in a synchronous manner.
> -	 *
> -	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> -	 * which we currently hold. Furthermore this also guarantees that
> -	 * cxl_mbox_background_complete() checks are safe amongst each other,
> -	 * in that no new bg operation can occur in between.
> -	 *
> -	 * Background operations are timesliced in accordance with the nature
> -	 * of the command. In the event of timeout, the mailbox state is
> -	 * indeterminate until the next successful command submission and the
> -	 * driver can get back in sync with the hardware state.
> -	 */
>  	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> -		u64 bg_status_reg;
> -		int i, timeout;
> -
>  		/*
>  		 * Sanitization is a special case which monopolizes the device
>  		 * and cannot be timesliced. Handle asynchronously instead,
>  		 * and allow userspace to poll(2) for completion.
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			int timeout;
> +
>  			if (mds->security.sanitize_active)
>  				return -EBUSY;
>  
> @@ -311,44 +297,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			schedule_delayed_work(&mds->security.poll_dwork,
>  					      timeout * HZ);
>  			dev_dbg(dev, "Sanitization operation started\n");
> -			goto success;
> -		}
> -
> -		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> -			mbox_cmd->opcode);
> -
> -		timeout = mbox_cmd->poll_interval_ms;
> -		for (i = 0; i < mbox_cmd->poll_count; i++) {
> -			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> -						       cxl_mbox_background_complete(cxlds),
> -						       TASK_UNINTERRUPTIBLE,
> -						       msecs_to_jiffies(timeout)) > 0)
> -				break;
> -		}
> -
> -		if (!cxl_mbox_background_complete(cxlds)) {
> -			dev_err(dev, "timeout waiting for background (%d ms)\n",
> -				timeout * mbox_cmd->poll_count);
> -			return -ETIMEDOUT;
> +		} else {
> +			/* pairs with release/acquire semantics */
> +			WARN_ON_ONCE(atomic_xchg(&cxl_mbox->poll_bgop,
> +						 mbox_cmd->opcode));
> +			dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +				mbox_cmd->opcode);
>  		}
> -
> -		bg_status_reg = readq(cxlds->regs.mbox +
> -				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> -		mbox_cmd->return_code =
> -			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> -				  bg_status_reg);
> -		dev_dbg(dev,
> -			"Mailbox background operation (0x%04x) completed\n",
> -			mbox_cmd->opcode);
> -	}
> -
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +	} else if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>  		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>  			cxl_mbox_cmd_rc2str(mbox_cmd));
>  		return 0; /* completed but caller must check return_code */
>  	}
>  
> -success:
>  	/* #7 */
>  	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>  	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> @@ -378,11 +339,68 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
>  	int rc;
> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
> +	struct device *dev = cxlds->dev;
>  
>  	mutex_lock_io(&cxl_mbox->mbox_mutex);
> +	/*
> +	 * Ensure cxl_mbox_background_complete() checks are safe amongst
> +	 * each other: no new bg operation can occur in between while polling.
> +	 */
> +	if (cxl_is_background_cmd(cmd->opcode)) {
> +		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
> +			mutex_unlock(&cxl_mbox->mbox_mutex);
> +			return -EBUSY;
> +		}
> +	}
> +
>  	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
>  	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
> +	if (cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
> +		return rc;
> +
> +	/*
> +	 * Handle the background command in a synchronous manner. Background
> +	 * operations are timesliced in accordance with the nature of the
> +	 * command.
> +	 */
> +	if (cmd->opcode != CXL_MBOX_OP_SANITIZE) {
> +		int i, timeout;
> +		u64 bg_status_reg;
> +
> +		timeout = cmd->poll_interval_ms;
> +		for (i = 0; i < cmd->poll_count; i++) {
> +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> +				       cxl_mbox_background_complete(cxlds),
> +				       TASK_UNINTERRUPTIBLE,
> +				       msecs_to_jiffies(timeout)) > 0)
> +				break;
> +		}
> +
> +		/*
> +		 * In the event of timeout, the mailbox state is indeterminate
> +		 * until the next successful command submission and the driver
> +		 * can get back in sync with the hardware state.
> +		 */
> +		if (!cxl_mbox_background_complete(cxlds)) {
> +			dev_err(dev, "timeout waiting for background (%d ms)\n",
> +				timeout * cmd->poll_count);
> +			rc = -ETIMEDOUT;
> +			goto done;
> +		}
> +
> +		bg_status_reg = readq(cxlds->regs.mbox +
> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +		cmd->return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +					     bg_status_reg);
> +		dev_dbg(dev,
> +			"Mailbox background operation (0x%04x) completed\n",
> +			cmd->opcode);
> +done:
> +		atomic_set_release(&cxl_mbox->poll_bgop, 0);
> +	}
> +
>  	return rc;
>  }
>  
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index bacd111e75f1..23282a3c44f1 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -13,6 +13,7 @@ struct cxl_mbox_cmd;
>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: mutex protects device mailbox and firmware
>   * @mbox_wait: rcuwait for mailbox
> + * @poll_bgop: current background operation being polled on
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   */
>  struct cxl_mailbox {
> @@ -20,6 +21,7 @@ struct cxl_mailbox {
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>  	struct rcuwait mbox_wait;
> +	atomic_t poll_bgop;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>  };
>  

