Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D0363C46
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263306; cv=pass; b=ZoYCGYMG2UbQFbn0/8d/4I+GmStWvCBZDyUp2CvuG67d+RFn635AxK+jm8PW4f83BMhr0m5u8SVErpm6ITjOMvvgJ1LVgco1bzqIL24fFh8956J7VSTIOR/3WmffmBvoZFYSkGQHdtWQFYttNBzgy0429DpTZqfE+FH8bKGU8OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263306; c=relaxed/simple;
	bh=VPP0BjosP3C9rV/Ks5MDx6py4tnOP1tGk8NpyilA2U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRT/4O3gBQnfl904kwdYrnEB4dtavaOSd8hfTwPrnER1uOVMBTmGq4BHeRrmIsZEiz6RHCaprycWOexYm+gCdXCeiPuqu0LAFUx6fr62zTxb1Vd24ygZB5MdUUwu+Gaeo8tpKCN1VmTcx+xUKg2NOo2JhQlyitHBB3o2jmdCwWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=X69lDJgi; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="X69lDJgi"
ARC-Seal: i=1; a=rsa-sha256; t=1788263290; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y3QcAQjfUjqElyuHoW0OpQnGDcM7P98wqEENEGXvB1KdlI22cT4JP+RwfgUNnuBfhYc/bRMX8c/Qoal2YE8fcW9r2cdYX7A9DGYMD+kTop83tr8g+udmd5m/AGvesGJOsRXILr/GwtwXo9E/Ec6Qa8PJYhQk6GazZAv4kIvD6JA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788263290; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g15Ab/YNMfAfqqPvxd3ByfXUgEHEMs8Dy6SsUnl+uKs=; 
	b=Ei5ynSCzJ6pYB9vEzYdTPjRIRjVBctqcC6GAs6N6IMK3nJchz8Z7AX7NOtvi6VAQ10U2+K3HgbpNk3Ms1tnl4YOgstho3hiaBszW4tXG8VQKo55yNPF/eUhwiF3cWzZZJFRB1Bc3ajXOpXENoDeMw8L3JzGDizEcwF1htKwGUYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788263290;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=g15Ab/YNMfAfqqPvxd3ByfXUgEHEMs8Dy6SsUnl+uKs=;
	b=X69lDJgiUNH+KRKCKavRjoCzrZ4ymzKMc2ZyZTMikugzQkP/NK7vZUadnpQXFIzL
	2nqHeuLTly8D7jTQ4OHKDdDtD8le7wdOxZMPDpzNf6msBQYa4NHwScXcw9hPYdPIfsL
	o5a07loodIXv+54rKXiAqPepMq5FKBbe3R1Sm5uk=
Received: by mx.zohomail.com with SMTPS id 1788263287060806.4249566922746;
	Tue, 1 Sep 2026 04:48:07 -0700 (PDT)
Message-ID: <e0613c8d-0cb7-41d1-8321-2ffa238b8aa2@zohomail.com>
Date: Tue, 1 Sep 2026 19:48:02 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cxl/events: Bound get records loop in
 cxl_event_thread()
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Cc: benjamin.cheatham@amd.com, icheng@nvidia.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, jic23@kernel.org,
 Anisa Su <anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-2-anisa.su@samsung.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260901002912.958-2-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227982ce8c8af6c85288e50c2780000d3c01a422c5d4b96b644da1d88cf77c98a78e17a14ca714c00:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/1 08:26, Anisa Su 写道:
> cxl_event_thread() drains all logs named in the Event Status register and
> repeats until the register reads zero. CXL r4.0 Section 8.2.9.3.1 Table 8-203
> marks the register RO and leaves clearing it to the device, so a misbehaving
> device that leaves a status bit set spins the thread forever, resending
> Get Event Records as fast as the mailbox completes.

Hi Anisa,

Per the commit log and the description in CXL r4.0 section 8.2.9.3.1 
Table 8-203. SPEC mentions "Once the event log has zero event records, 
this bit(event status) is cleared". So it is a spec-violating issue on 
device side.

My understanding is that CXL driver does not need special handling for 
device behaviors that violate the CXL spec. If we are facing this issue, 
the correct way is fixing it on device side.

Let's see if maintainers have comments on that.


Besides, your patch makes me realize that checking the return value of 
cxl_mem_get_event_records() is valuable. GET_EVENT_RECORD and 
CLEAR_EVENT_RECORD operations could fail in cxl_mem_get_records_logs(), 
which cause that device could not have chance to clear event records, 
then device would not clear event status register. In that case, the 
loop in cxl_event_thread() will never break out.


Ming

>
> Bound the loop on work completed instead. cxl_mem_get_records_log() and
> cxl_mem_get_event_records() report failures and which logs returned
> records; the thread drops any log whose status bit was set while it
> returned nothing, and caps consecutive errors at CXL_EVENT_DRAIN_ATTEMPTS.
> Every pass either drains a record, clears a bit from the mask or spends an
> attempt, so the loop eventually terminates, even if the device misbehaves.
> The first error is returned and an error from one log does not prevent
> getting logs from the rest.
>
> Retrying is limited to the failures that can plausibly be cleared:
> -EBUSY and -ETIMEDOUT from the mailbox, and Retry Required from the
> device. Anything else gives up on the first error, so cycles are not wasted
> retrying on a non-retryable error.
>
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
>
> ---
> Changes:
> [Richard Cheng]: retry on transient failures
> ---
>   drivers/cxl/core/mbox.c      | 74 +++++++++++++++++++++++++++++-------
>   drivers/cxl/cxlmem.h         |  3 +-
>   drivers/cxl/pci.c            | 63 ++++++++++++++++++++++++++----
>   tools/testing/cxl/test/mem.c |  4 +-
>   4 files changed, 120 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..2b71a8e1f35f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -988,6 +988,18 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
>   	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>   }
>   
> +/*
> + * cxl_mbox_cmd_rc2errno() collapses every device return code onto -ENXIO;
> + * pick out the one the spec asks the caller to retry.
> + */
> +static int cxl_event_retry_rc(struct cxl_mbox_cmd *mbox_cmd, int rc)
> +{
> +	if (rc == -ENXIO && mbox_cmd->return_code == CXL_MBOX_CMD_RC_RETRY)
> +		return -EAGAIN;
> +
> +	return rc;
> +}
> +
>   static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   				  enum cxl_event_log_type log,
>   				  struct cxl_get_event_payload *get_pl)
> @@ -1056,11 +1068,11 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   
>   free_pl:
>   	kvfree(payload);
> -	return rc;
> +	return cxl_event_retry_rc(&mbox_cmd, rc);
>   }
>   
> -static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> -				    enum cxl_event_log_type type)
> +static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> +				   enum cxl_event_log_type type, bool *got_records)
>   {
>   	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> @@ -1068,12 +1080,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   	struct cxl_get_event_payload *payload;
>   	u8 log_type = type;
>   	u16 nr_rec;
> +	int rc = 0;
> +
> +	*got_records = false;
>   
>   	mutex_lock(&mds->event.log_lock);
>   	payload = mds->event.buf;
>   
>   	do {
> -		int rc, i;
> +		int i;
>   		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
>   			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
>   			.payload_in = &log_type,
> @@ -1085,6 +1100,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   
>   		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>   		if (rc) {
> +			rc = cxl_event_retry_rc(&mbox_cmd, rc);
>   			dev_err_ratelimited(dev,
>   				"Event log '%d': Failed to query event records : %d",
>   				type, rc);
> @@ -1094,6 +1110,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   		nr_rec = le16_to_cpu(payload->record_count);
>   		if (!nr_rec)
>   			break;
> +		*got_records = true;
>   
>   		for (i = 0; i < nr_rec; i++)
>   			__cxl_event_trace_record(cxlmd, type,
> @@ -1112,31 +1129,60 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   	} while (nr_rec);
>   
>   	mutex_unlock(&mds->event.log_lock);
> +
> +	return rc;
>   }
>   
>   /**
>    * cxl_mem_get_event_records - Get Event Records from the device
>    * @mds: The driver data for the operation
>    * @status: Event Status register value identifying which events are available.
> + * @drained: Optional mask of the logs in @status that returned records.
>    *
>    * Retrieve all event records available on the device, report them as trace
> - * events, and clear them.
> + * events, and clear them.  Every log named in @status is drained even if
> + * another one fails, so that a broken log does not suppress reporting from
> + * the rest.
> + *
> + * Return: 0, or the first error encountered.  -EAGAIN if the device asked for
> + * a command to be retried.
>    *
>    * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
>    * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
>    */
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained)
>   {
> +	static const struct {
> +		u32 status;
> +		enum cxl_event_log_type type;
> +	} logs[] = {
> +		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
> +		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
> +		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
> +		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
> +	};
> +	int ret = 0;
> +
>   	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
>   
> -	if (status & CXLDEV_EVENT_STATUS_FATAL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
> -	if (status & CXLDEV_EVENT_STATUS_FAIL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
> -	if (status & CXLDEV_EVENT_STATUS_WARN)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> -	if (status & CXLDEV_EVENT_STATUS_INFO)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> +	if (drained)
> +		*drained = 0;
> +
> +	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
> +		bool got_records;
> +		int rc;
> +
> +		if (!(status & logs[i].status))
> +			continue;
> +
> +		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> +		if (got_records && drained)
> +			*drained |= logs[i].status;
> +		ret = ret ?: rc;
> +	}
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..cb5372eb2d85 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				unsigned long *cmds);
>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				  unsigned long *cmds);
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained);
>   void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>   			    enum cxl_event_log_type type,
>   			    enum cxl_event_type event_type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..239df18c9c87 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -509,26 +509,75 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>   	return true;
>   }
>   
> +#define CXL_EVENT_DRAIN_ATTEMPTS 3
> +
> +/*
> + * -EAGAIN is the device asking for a retry, the rest are the mailbox being
> + * momentarily unavailable.  Everything else is permanent as far as this can
> + * tell.
> + */
> +static bool cxl_event_drain_retryable(int rc)
> +{
> +	return rc == -EAGAIN || rc == -EBUSY || rc == -ETIMEDOUT;
> +}
> +
>   static irqreturn_t cxl_event_thread(int irq, void *id)
>   {
>   	struct cxl_dev_id *dev_id = id;
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	u32 status;
> +	u32 mask = CXLDEV_EVENT_STATUS_ALL;
> +	int attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> +
> +	while (mask) {
> +		u32 status, drained, stuck;
> +		int rc;
>   
> -	do {
>   		/*
>   		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
>   		 * ignore the reserved upper 32 bits
>   		 */
>   		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver, and logs given up on */
> +		status &= mask;
>   		if (!status)
>   			break;
> -		cxl_mem_get_event_records(mds, status);
> +
> +		rc = cxl_mem_get_event_records(mds, status, &drained);
> +		if (rc) {
> +			if (!cxl_event_drain_retryable(rc)) {
> +				dev_warn(cxlds->dev,
> +					 "Event log drain failed: %d\n", rc);
> +				break;
> +			}
> +			if (--attempts) {
> +				fsleep(1000);
> +				continue;
> +			}
> +			dev_warn(cxlds->dev,
> +				 "Event log drain gave up after %d attempts: %d\n",
> +				 CXL_EVENT_DRAIN_ATTEMPTS, rc);
> +			break;
> +		}
> +		/* Progress was made, so reset number of attempts */
> +		attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> +
> +		/*
> +		 * The Event Status register is device owned and read only, so
> +		 * it cannot bound this loop; records read can.  A device that
> +		 * leaves a bit set with an empty log makes no progress, and
> +		 * only the device can clear that state, so stop polling that
> +		 * log rather than spin on it.
> +		 */
> +		stuck = status & ~drained;
> +		if (stuck) {
> +			dev_warn_once(cxlds->dev,
> +				      "Event status %#x set with no records to read\n",
> +				      stuck);
> +			mask &= ~stuck;
> +		}
>   		cond_resched();
> -	} while (status);
> +	}
>   
>   	return IRQ_HANDLED;
>   }
> @@ -682,7 +731,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   	if (rc)
>   		return rc;
>   
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>   
>   	return 0;
>   }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index a7da279aa3ef..87e01612cea9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
>   			event_reset_log(log);
>   	}
>   
> -	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
> +	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
>   }
>   
>   struct cxl_event_record_raw maint_needed = {
> @@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		dev_dbg(dev, "No CXL FWCTL setup\n");
>   
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>   	cxl_mock_test_feat_init(mdata);
>   
>   	return 0;
