Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEF1D5145;
	Tue, 14 Jan 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880024; cv=none; b=X+I+dYSJ0+vcBw01g8i/oVEsFVJ4GlQBrACSlZfkg9ap8Gwh0dxT6X6kgojNAyu0d1l4AKsR1BVDycBEsL8fV3OCY7Ps6EJzXRYOq0ZnKuFdpBHuBQU2hdqu65FdqYDg/9MjjwcByt1hOyjwA2l8lXrHkgwCnExVm0Wht3aXL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880024; c=relaxed/simple;
	bh=iZZztovElKXKF0Qg0GwhnKgma5EIcG1eSzKpbaiou9s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aazKF6FlM69Cf3uUKnKsqOirJMtXzMT2+0iWFOVSZOWf3xcrUEs+n96VPbBv8YW95FLYMkoisQfRlM4rOrz8lOOV6JiQ5/QwVHZUQe4n9QgHRFD9I/5KdXpPSZQ8zbpTYuhUw5gVi33mU8NSQA9/NYJbz+Synw1l0XfNLe065cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXd9B2JL2z6K9Ns;
	Wed, 15 Jan 2025 02:35:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 52137140B35;
	Wed, 15 Jan 2025 02:40:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 19:40:18 +0100
Date: Tue, 14 Jan 2025 18:40:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
	<sthanneeru.opensrc@micron.com>, <emirakhur@micron.com>,
	<ajayjoshi@micron.com>, <Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/pci: lockless background synchronous polling
Message-ID: <20250114184017.00002e92@huawei.com>
In-Reply-To: <831f83fa-01da-42aa-8d9b-c0662e520134@intel.com>
References: <20241022031809.242591-1-dave@stgolabs.net>
	<20241022031809.242591-2-dave@stgolabs.net>
	<831f83fa-01da-42aa-8d9b-c0662e520134@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 09:12:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
> > For non-sanitize background commands we rely on holding the mbox_mutex
> > throughout the duration of the operation. This causes other incoming
> > commands to queue up behind, and interleaving executions while the
> > background command is timesliced by the user.
> > 
> > However, in order to support the mbox request cancel background
> > operation command, the lock will need to be available to actually
> > perform the request. Semantically this allows other commands to
> > many times be at the mercy of hardware returning the respective error.
> > Potentially users would be exposed to changes in the form of errors
> > instead of commands taking longer to run - but this is not forseen
> > as a problem.
> > 
> > In order to not loose sync with the hardware, introduce a mailbox
> > atomic that blocks any other incoming bg operations while the driver
> > is still polling (synchronously) on the current one.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  drivers/cxl/core/mbox.c |   1 +
> >  drivers/cxl/cxlmem.h    |  13 +++++
> >  drivers/cxl/pci.c       | 114 +++++++++++++++++++++++-----------------
> >  include/cxl/mailbox.h   |   2 +
> >  4 files changed, 82 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 5175138c4fb7..9af3cd16d23d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1429,6 +1429,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
> >  
> >  	cxl_mbox->host = host;
> >  	mutex_init(&cxl_mbox->mbox_mutex);
> > +	atomic_set(&cxl_mbox->poll_bgop, 0);
> >  	rcuwait_init(&cxl_mbox->mbox_wait);
> >  
> >  	return 0;
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 2a25d1957ddb..b933fb73ef8a 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -557,6 +557,19 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> >  
> > +static inline bool cxl_is_background_cmd(u16 opcode)
> > +{
> > +	switch (opcode) {
> > +	case CXL_MBOX_OP_TRANSFER_FW:
> > +	case CXL_MBOX_OP_ACTIVATE_FW:
> > +	case CXL_MBOX_OP_SCAN_MEDIA:
> > +	case CXL_MBOX_OP_SANITIZE:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}  
> 
> Should this information be pulled from the CEL entry? We should add the code to store the 'command effect' field when walking the CEL and store this information for each command. And then we can just check bit6 of the field rather than statically program that in the kernel.
It might make it easier to maintain.

If nothing else the maintenance command stuff in Shiju's patch set
will need to be added to here possibly, but they are allowed to not
be background commands I think depending on the implementation.

So I'm in favor of using the CEL for this as well.

Jonathan

> 
> DJ
> 
> > +
> >  #define DEFINE_CXL_CEL_UUID                                                    \
> >  	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
> >  		  0x3b, 0x3f, 0x17)
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 188412d45e0d..f2378604669b 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -278,29 +278,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
> >  	mbox_cmd->return_code =
> >  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> >  
> > -	/*
> > -	 * Handle the background command in a synchronous manner.
> > -	 *
> > -	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> > -	 * which we currently hold. Furthermore this also guarantees that
> > -	 * cxl_mbox_background_complete() checks are safe amongst each other,
> > -	 * in that no new bg operation can occur in between.
> > -	 *
> > -	 * Background operations are timesliced in accordance with the nature
> > -	 * of the command. In the event of timeout, the mailbox state is
> > -	 * indeterminate until the next successful command submission and the
> > -	 * driver can get back in sync with the hardware state.
> > -	 */
> >  	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> > -		u64 bg_status_reg;
> > -		int i, timeout;
> > -
> >  		/*
> >  		 * Sanitization is a special case which monopolizes the device
> >  		 * and cannot be timesliced. Handle asynchronously instead,
> >  		 * and allow userspace to poll(2) for completion.
> >  		 */
> >  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> > +			int timeout;
> > +
> >  			if (mds->security.sanitize_active)
> >  				return -EBUSY;
> >  
> > @@ -311,44 +297,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
> >  			schedule_delayed_work(&mds->security.poll_dwork,
> >  					      timeout * HZ);
> >  			dev_dbg(dev, "Sanitization operation started\n");
> > -			goto success;
> > -		}
> > -
> > -		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> > -			mbox_cmd->opcode);
> > -
> > -		timeout = mbox_cmd->poll_interval_ms;
> > -		for (i = 0; i < mbox_cmd->poll_count; i++) {
> > -			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> > -						       cxl_mbox_background_complete(cxlds),
> > -						       TASK_UNINTERRUPTIBLE,
> > -						       msecs_to_jiffies(timeout)) > 0)
> > -				break;
> > -		}
> > -
> > -		if (!cxl_mbox_background_complete(cxlds)) {
> > -			dev_err(dev, "timeout waiting for background (%d ms)\n",
> > -				timeout * mbox_cmd->poll_count);
> > -			return -ETIMEDOUT;
> > +		} else {
> > +			/* pairs with release/acquire semantics */
> > +			WARN_ON_ONCE(atomic_xchg(&cxl_mbox->poll_bgop,
> > +						 mbox_cmd->opcode));
> > +			dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> > +				mbox_cmd->opcode);
> >  		}
> > -
> > -		bg_status_reg = readq(cxlds->regs.mbox +
> > -				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> > -		mbox_cmd->return_code =
> > -			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> > -				  bg_status_reg);
> > -		dev_dbg(dev,
> > -			"Mailbox background operation (0x%04x) completed\n",
> > -			mbox_cmd->opcode);
> > -	}
> > -
> > -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> > +	} else if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> >  		dev_dbg(dev, "Mailbox operation had an error: %s\n",
> >  			cxl_mbox_cmd_rc2str(mbox_cmd));
> >  		return 0; /* completed but caller must check return_code */
> >  	}
> >  
> > -success:
> >  	/* #7 */
> >  	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
> >  	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> > @@ -378,11 +339,68 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
> >  			     struct cxl_mbox_cmd *cmd)
> >  {
> >  	int rc;
> > +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
> > +	struct device *dev = cxlds->dev;
> >  
> >  	mutex_lock_io(&cxl_mbox->mbox_mutex);
> > +	/*
> > +	 * Ensure cxl_mbox_background_complete() checks are safe amongst
> > +	 * each other: no new bg operation can occur in between while polling.
> > +	 */
> > +	if (cxl_is_background_cmd(cmd->opcode)) {
> > +		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
> > +			mutex_unlock(&cxl_mbox->mbox_mutex);
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> >  	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> >  	mutex_unlock(&cxl_mbox->mbox_mutex);
> >  
> > +	if (cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
> > +		return rc;
> > +
> > +	/*
> > +	 * Handle the background command in a synchronous manner. Background
> > +	 * operations are timesliced in accordance with the nature of the
> > +	 * command.
> > +	 */
> > +	if (cmd->opcode != CXL_MBOX_OP_SANITIZE) {
> > +		int i, timeout;
> > +		u64 bg_status_reg;
> > +
> > +		timeout = cmd->poll_interval_ms;
> > +		for (i = 0; i < cmd->poll_count; i++) {
> > +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> > +				       cxl_mbox_background_complete(cxlds),
> > +				       TASK_UNINTERRUPTIBLE,
> > +				       msecs_to_jiffies(timeout)) > 0)
> > +				break;
> > +		}
> > +
> > +		/*
> > +		 * In the event of timeout, the mailbox state is indeterminate
> > +		 * until the next successful command submission and the driver
> > +		 * can get back in sync with the hardware state.
> > +		 */
> > +		if (!cxl_mbox_background_complete(cxlds)) {
> > +			dev_err(dev, "timeout waiting for background (%d ms)\n",
> > +				timeout * cmd->poll_count);
> > +			rc = -ETIMEDOUT;
> > +			goto done;
> > +		}
> > +
> > +		bg_status_reg = readq(cxlds->regs.mbox +
> > +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> > +		cmd->return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> > +					     bg_status_reg);
> > +		dev_dbg(dev,
> > +			"Mailbox background operation (0x%04x) completed\n",
> > +			cmd->opcode);
> > +done:
> > +		atomic_set_release(&cxl_mbox->poll_bgop, 0);
> > +	}
> > +
> >  	return rc;
> >  }
> >  
> > diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> > index bacd111e75f1..23282a3c44f1 100644
> > --- a/include/cxl/mailbox.h
> > +++ b/include/cxl/mailbox.h
> > @@ -13,6 +13,7 @@ struct cxl_mbox_cmd;
> >   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @mbox_mutex: mutex protects device mailbox and firmware
> >   * @mbox_wait: rcuwait for mailbox
> > + * @poll_bgop: current background operation being polled on
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   */
> >  struct cxl_mailbox {
> > @@ -20,6 +21,7 @@ struct cxl_mailbox {
> >  	size_t payload_size;
> >  	struct mutex mbox_mutex; /* lock to protect mailbox context */
> >  	struct rcuwait mbox_wait;
> > +	atomic_t poll_bgop;
> >  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> >  };
> >    
> 
> 

