Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546714A4DD;
	Tue, 14 Jan 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874045; cv=none; b=cJ1yq/lHI0P48V0cN8Z0uhsdRgI4/vv1mne9x1lAprZvMOVhS54uk0y/JpnJmtuP/lqZSGlNz8qv50vD3FurHgzIs4A9+B0fo/QNSIoLpEay36x6U4Gtfm7ra/e/jdOQDnmeu6KjWcD3TzATSQexN939uIImfTZ3XCersnVf6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874045; c=relaxed/simple;
	bh=TLUPSVZl+/B7G2ISH+75DrhQl9qZIUxxp3JpHVEBrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKbSnPEJBs0N56z+DZLOxhC3MC/Jy3uXFRtnCSIdaLQOXh2/kM07AofN1yarvEWSI6N5lFtjI9IhJnOI2rZAIcaXWYYAkCvv+bQPf9EAF5Yds8R752VA4nUaTMSfabPygu32aI996vCTX7c0HsRGGgaG5K1NylOfgHWRWkAZ+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aF8vWtJe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aF8vWtJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874043; x=1768410043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TLUPSVZl+/B7G2ISH+75DrhQl9qZIUxxp3JpHVEBrM0=;
  b=aF8vWtJePQDZIatUvE2y+jdkYyFjsYHOK7il10D5UiPCbNxXqf0FkfH7
   PVkdTtYcjtrbMqDeT3Swn6913G67HlxXru62wQriO/3ktIv95Vn23wRRv
   wxec2fnpOBKXAyxwBYi4y3V9oFVs9zflr5gAYwdFUYWeX74XYwAyrEoTn
   K8dVK5txaDq2szFh4+iVBPTPFlDXcfMdo3xpMym8eE/gbzz4aKat2Xd4Q
   pauADRMeEZe7OY/1vz03f2imyQU8+RFlCTutnBadxUx4b3siQ5zZrkOXv
   6Mr1eFfYTQgn2NqFQ0YiV2+rDAX1+zjVniAp3TMc+irI2G2dTQFed+/rz
   Q==;
X-CSE-ConnectionGUID: N61BdZv4ShSLoLFbsvrXXw==
X-CSE-MsgGUID: xhu/WcsJTu+oa9fZ/7ou9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41119302"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="41119302"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:00:42 -0800
X-CSE-ConnectionGUID: NYRLU0sYRpOJNfzSIKHJOg==
X-CSE-MsgGUID: adzV4+WfR1uhO5W7Jwgv5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105451760"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:00:39 -0800
Message-ID: <7e390255-7e55-4b59-9a7d-6aa3857c8a42@intel.com>
Date: Tue, 14 Jan 2025 10:00:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/mbox: support aborting the current background
 operation
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
 a.manzanares@samsung.com, sthanneeru.opensrc@micron.com,
 emirakhur@micron.com, ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
 sthanneeru@micron.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241022031809.242591-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
> CXL 3.1 introduced the ability to request that the current on-going
> background command be aborted. Add support for this, where the current
> policy is for the request to occur whenever a new incoming bg command
> wants to run. As such everything is left to user discretion and it
> becomes impossible to hog the device/mailbox.

Are you trying to say that the patch is changing the current behavior to where every time a new bg command comes in, it will abort the previous one?

> 
> The context of doing the cancellation request is the same as the new
> incoming command, and will always hold the mbox_mutex, guaranteeing
> that any successful cancel does not race with a third thread coming
> in and stealing the effort.
> 
> - For Sanitize, the thread doing the will cancel the work, and clean

doing the? seems to be missing a word here.

> on behalf of the respective wq callback that will never come.
> 
> - For the other bg commands, the sleeping thread is kicked and we
> busy-wait until the polling flag is cleared.
> 
> In both scenarios, we guarantee that the aborted op's thread is no
> longer around, giving the new bg op full authority to submit the command.
> 
> Semantics for devices that do not support such functionality are left
> unchanged, and hence, with this, the driver benefits in both scenarios.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxlmem.h |  1 +
>  drivers/cxl/pci.c    | 81 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b933fb73ef8a..e843ffc3c23a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_REQUEST_ABORT_BG_OP = 0x0005,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>  	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f2378604669b..5da50e26e4c4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -115,8 +115,8 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  {
>  	u64 reg;
>  
> -	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> -	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_STATUS_BG_CMD, reg) == 0;
>  }
>  
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> @@ -241,7 +241,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	 * hardware semantics and only allow device health status.
>  	 */
>  	if (mds->security.poll_tmo_secs > 0) {
> -		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO &&
> +		    mbox_cmd->opcode != CXL_MBOX_OP_REQUEST_ABORT_BG_OP)
>  			return -EBUSY;
>  	}
>  
> @@ -335,11 +336,64 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	return 0;
>  }
>  
> +/*
> + * Return true implies that the request was successful and the on-going
> + * background operation was in fact aborted. This also guarantees that
> + * the respective thread is done.
> + */
> +static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
> +{
> +	int rc;
> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = cxlds->dev;
> +	struct cxl_mbox_cmd cmd = {
> +		.opcode = CXL_MBOX_OP_REQUEST_ABORT_BG_OP
> +	};
> +
> +	lockdep_assert_held(&cxl_mbox->mbox_mutex);
> +
> +	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &cmd);
> +	if (rc) {
> +		dev_dbg(dev, "Failed to send abort request : %d\n", rc);
> +		return false;
> +	}
> +
> +	if (!cxl_mbox_background_complete(cxlds))
> +		return false;
> +
> +	if (mds->security.sanitize_active) {
> +		/*
> +		 * Cancel the work and cleanup on its behalf - we hold
> +		 * the mbox_mutex, cannot race with cxl_mbox_sanitize_work().
> +		 */
> +		cancel_delayed_work_sync(&mds->security.poll_dwork);
> +		mds->security.poll_tmo_secs = 0;
> +		if (mds->security.sanitize_node)
> +			sysfs_notify_dirent(mds->security.sanitize_node);
> +		mds->security.sanitize_active = false;

Should this line happen before the sysfs notification?

DJ

> +
> +		dev_dbg(cxlds->dev, "Sanitization operation aborted\n");
> +	} else {
> +		/*
> +		 * Kick the poller and wait for it to be done - no one else
> +		 * can touch mbox regs. rcuwait_wake_up() provides full
> +		 * barriers such that wake up occurs before waiting on the
> +		 * bgpoll atomic to be cleared.
> +		 */
> +		rcuwait_wake_up(&cxl_mbox->mbox_wait);
> +		atomic_cond_read_acquire(&cxl_mbox->poll_bgop, !VAL);
> +	}
> +
> +	return true;
> +}
> +
>  static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
>  	int rc;
>  	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct device *dev = cxlds->dev;
>  
>  	mutex_lock_io(&cxl_mbox->mbox_mutex);
> @@ -348,10 +402,18 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  	 * each other: no new bg operation can occur in between while polling.
>  	 */
>  	if (cxl_is_background_cmd(cmd->opcode)) {
> -		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
> -			mutex_unlock(&cxl_mbox->mbox_mutex);
> -			return -EBUSY;
> +		if (mds->security.sanitize_active ||
> +		    atomic_read_acquire(&cxl_mbox->poll_bgop)) {
> +			if (!cxl_try_to_cancel_background(cxl_mbox)) {
> +				mutex_unlock(&cxl_mbox->mbox_mutex);
> +				return -EBUSY;
> +			}
>  		}
> +		/*
> +		 * ... at this point we know that the canceled
> +		 * bgop context is gone, and we are the _only_
> +		 * background command in town. Proceed to send it.
> +		 */
>  	}
>  
>  	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> @@ -394,10 +456,11 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  		cmd->return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>  					     bg_status_reg);
> -		dev_dbg(dev,
> -			"Mailbox background operation (0x%04x) completed\n",
> -			cmd->opcode);
> +
> +		dev_dbg(dev, "Mailbox background operation (0x%04x) %s\n",
> +			cmd->opcode, !cmd->return_code ? "completed":"aborted");
>  done:
> +		/* ensure clearing poll_bop is the last operation */
>  		atomic_set_release(&cxl_mbox->poll_bgop, 0);
>  	}
>  

