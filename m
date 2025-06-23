Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8048221FD4
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688969; cv=none; b=g534ghElbWz13usywo7xjWSie3ovjsMHgHrOGnE33LOl+9GXNOBOTSRk36+Qjwucoos6mCysDDXLnWv5S0GEJDHA+QuWM9tNiBQswwA6QF5dRRdi5lEUhwrWzdBRuXDlApdI8ABA/Tw/Yo5Q5VmLPldDJ8rSHj9pyzHtLyAW5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688969; c=relaxed/simple;
	bh=fxx556c6Wns9eH7ecfreTl4D/5u/9saoDRdptF/V8NY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aE34EaSB3H3cHI3LMocBDStYZQKKmzdiLVDrkVUNQ+LUu9ctjMyfUdEkWuTsILkKwPf6ntZiyky6R54kAaO2V0DvWrTR4ERSUg3SbAMvTtaLIp4h1ccMbbTde22A1jQjxa35RY7l2ujAciKXn2YBCQtOsWMbXkAnrbTkh0+fBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQr1k1chkz6DKdB;
	Mon, 23 Jun 2025 22:24:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AA09140114;
	Mon, 23 Jun 2025 22:29:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:29:21 +0200
Date: Mon, 23 Jun 2025 15:29:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/pci: Lockless background synchronous polling
Message-ID: <20250623152920.00005b6e@huawei.com>
In-Reply-To: <20250617193611.564668-4-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:36:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> For timesliced background commands we rely on holding the mbox_mutex
> throughout the duration of the operation. This causes other incoming
> commands to queue up behind, and interleaving executions while the
> background command is timesliced by the user.
> 
> However, in order to support the mbox request cancel background
> operation command, the lock will need to be available to actually
> perform the request. Semantically this allows other commands to
> many times be at the mercy of hardware returning the respective error.
> Potentially users would be exposed to changes in the form of errors
> instead of commands taking longer to run - but this is not foreseen
> as a problem.
> 
> In order to not loose sync with the hardware, introduce a mailbox
> atomic that blocks any other incoming bg operations while the driver
> is still polling (synchronously) on the current one.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Minor comments inline.

Jonathan


> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0d8f3605dc3f..3e6c231e9a8b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -312,23 +312,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
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
>  		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>  			mbox_cmd->opcode);
>  
> @@ -338,6 +322,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE ||
>  		    mbox_cmd->opcode == CXL_MBOX_OP_ACTIVATE_FW) {
> +			int timeout;
> +
>  			if (mds->bg.opcode)
>  				return -EBUSY;
>  
> @@ -347,41 +333,17 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			mds->bg.opcode = mbox_cmd->opcode;
>  			schedule_delayed_work(&mds->bg.poll_dwork,
>  					      timeout * HZ);
> -			goto success;
> +		} else {
> +			/* pairs with release/acquire semantics */
> +			WARN_ON_ONCE(atomic_xchg(&cxl_mbox->poll_bgop,
> +						 mbox_cmd->opcode));
>  		}
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
> -		}
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
> @@ -411,11 +373,71 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
>  	int rc;
> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
> +	struct device *dev = cxlds->dev;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  
>  	mutex_lock(&cxl_mbox->mbox_mutex);
Perhaps scoped_guard() appropriate here to avoid need to unlock explicitly
in the error path.

> +	/*
> +	 * Ensure cxl_mbox_background_complete() checks are safe amongst
> +	 * each other: no new bg operation can occur in between while polling.
> +	 */
> +	if (cxl_is_background_cmd(mds, cmd->opcode)) {
> +		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
If you use scoped_guard() the indent will be getting a bit high, so maybe
combine the previous two conditions.
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
> +	if (cmd->opcode != CXL_MBOX_OP_SANITIZE &&
> +	    cmd->opcode != CXL_MBOX_OP_ACTIVATE_FW) {
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
> +		/* ensure clearing poll_bop is the last operation */
> +		atomic_set_release(&cxl_mbox->poll_bgop, 0);
> +	}
> +
>  	return rc;
>  }

