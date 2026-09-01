Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754939769B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285579; cv=none; b=eXglzI93nzLwcuvoA1vsmfF+4CFT8lN+uM2baE5+4bF2wK2uyrrqoRTfBZa57+FiRgweXfJZTvengeTdDfk33n5rLwOXd/kOp8z2VRxMFDCVpFdQIXJ4nxkf2z7iHK9pJ4Ych3sYaUFZ4SRTlb1fh0WhJShZXf4QMpvP9ztbkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285579; c=relaxed/simple;
	bh=4wxIvO+WSub1S+PoH2MJLvl+Kn5gjU98JUGaa/1VvgQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTn2b/QvENW8HUljDlPYFSQmwR2CpqhDphdDg6YaqkAMgbM7K9xiY1MGaxBRv/1Oc/WkItwPIdxNrBJYMiwtb+LWL8nATrsrLRxS7qUhOlGT1ipHcaIEv1/EsiXSLLwrtOEl1UWRMmeyU1oxtygJV78xVoWEHH0FUBAxtNcINZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVYKR8TY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVYKR8TY"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dbcb505578so3180627b3.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Sep 2026 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285576; x=1788890376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3UBmSGLE2vmcqumREpPk2qAfUb48LiHLEYWMxpNJ4B4=;
        b=NVYKR8TYBFTS9sRouRYPmQOg7T1vQ0ySHb6GXE5//vCCm+FJGcYuEy+3fDPt30DyPO
         SRlFLnxW5HWhSdL/kJtQkH+355gBrqZM+vxZs/fKg3ChsZ5hXcppvxCBCmg63pLRlX6f
         qSl0NwpDXWQVD8MPd4eoNzQxCbUjFi2HDCD3ln15X3x+nhFBsmoIfBHlwsB14tycmZEk
         rTz4GWpHDCx+nCEmDR7FHh9pzBt8b0mB3eoyq0PYoK/43lfPwNx3E5bmMel0EnYZBSfA
         GoHxAJ8Dmsw9DhdYgr9DuRQFP6/0QEsISe/vUQDLRtnRW2TQyRrwu0hgUgVlbIaPqm2d
         J8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285576; x=1788890376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3UBmSGLE2vmcqumREpPk2qAfUb48LiHLEYWMxpNJ4B4=;
        b=RLFsZhr71d4/u1eS492kWH3PK5zZewSO9LgarnFQu1Jp4nzpGTAmnTZ86QBnpyMhzR
         n5JQqZBIYbpxL26po7ErvGW8P71V4gt39U7IGHFCXs+FvtoYtvZTH9xKqIOEU3rnqeMy
         dQgOYmU3eExO95b2RO57fpbo2ZH65xBT5qMbRpuzpIRbcRY242SRZQJE/qTmPOS+FbT6
         2Fhq/XE4H1UBdlmkSHitL21pM8PPROYvq5XI8KnSRMkLZD3kaXpUochKzCj56qpTQYHn
         a4kyW8DVfeNVDpNDFLo60L1TIC6+o2+BfeMjQV6jAquH4d9YYdNNiIvXv5KmJVduoIoC
         uJ7w==
X-Forwarded-Encrypted: i=1; AKwUvBycUlJYwUKQH76N9G8eE/R8QKwZyMi/rxO1dxWHqSn/l2+OHbfWqNyUXN4b7BKoBWb86sv6jZSv4nU=@vger.kernel.org
X-Gm-Message-State: AFuF++nelfpIy7F10URiRUPPZOAXmNR3ox9+Qs0z/T9XHz6htEueL6HV
	38RPRf+rudMzYXoBMbBQN7ncSr/3lzGWoz6oc0hnDCeKb9LtMkHoB/Ey
X-Gm-Gg: AYBFou1uzGub99M7y/JuyWp6lR+Q8M9H4qcLSxyopP/mHr1AT61rpDRi3LsRKSeq5mJ
	joVWMgl0PmcPNyL1r+WTBqs3zr6ixZk5y1olVYSMJrNkNTN6E1KYfReccTHfjnmiWkxOV0rinj8
	vQ+1OkdHLQ2Cb6a+GdA3RN/6bY4E+JNLt2I4mj/3VIkerVP6B44K5SpPAG+yJx5rPvktZncU2+t
	6K+8drj9fkFCK1vtlTgAO6mW0/8Cd24klDxP/zd303aL2Mjh6zEqz2nPTxE9Efke3ZQ+QfIIVKa
	EQNkhrzK7w9Pjk+a98GTReS5SlizBTdn9HHKvJ4L+CGn8esK7EB7Q0YI+J03elh5p/h7Ec0PWdU
	dtaSvQLwZ2M4/rM9nWU2KMprTsb1mOmHoANaYfxef2YDSIEXs9sNdt1Ir6gYeEdZBQZD0djlxIE
	Jd8D2ETPNrcd4s3/FxvTUUuvjf1cVgmcnHg4dM+/YsjT1mUqqehBT6851vUWGTHLx+i/aZvmZQM
	qbXXKJPDt9gBcY8txJH0yYA5aGGUDNdEp81kixK4992VMhN6A==
X-Received: by 2002:a05:690c:ec3:b0:81e:45a6:bd53 with SMTP id 00721157ae682-85d69927a1amr145876167b3.8.1788285576376;
        Tue, 01 Sep 2026 10:59:36 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e6756c433sm80845387b3.44.2026.09.01.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:59:35 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 1 Sep 2026 10:59:33 -0700
To: Li Ming <ming.li@zohomail.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	benjamin.cheatham@amd.com, icheng@nvidia.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com, jic23@kernel.org
Subject: Re: [PATCH v2 1/4] cxl/events: Bound get records loop in
 cxl_event_thread()
Message-ID: <apcShQJl07HOOaFP@4470NRD-ASU.ssi.samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-2-anisa.su@samsung.com>
 <e0613c8d-0cb7-41d1-8321-2ffa238b8aa2@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0613c8d-0cb7-41d1-8321-2ffa238b8aa2@zohomail.com>

On Tue, Sep 01, 2026 at 07:48:02PM +0800, Li Ming wrote:
> 
> 在 2026/9/1 08:26, Anisa Su 写道:
> > cxl_event_thread() drains all logs named in the Event Status register and
> > repeats until the register reads zero. CXL r4.0 Section 8.2.9.3.1 Table 8-203
> > marks the register RO and leaves clearing it to the device, so a misbehaving
> > device that leaves a status bit set spins the thread forever, resending
> > Get Event Records as fast as the mailbox completes.
> 
> Hi Anisa,
> 
> Per the commit log and the description in CXL r4.0 section 8.2.9.3.1
> Table 8-203. SPEC mentions "Once the event log has zero event records,
> this bit(event status) is cleared". So it is a spec-violating issue on
> device side.
> 
Hello Ming,

Yes, that's correct. The event status bit must be cleared by the device.
However, while testing a DCD device, I encountered this scenario due to a
firmware bug. I mentioned more details in the cover letter of v1:
https://lore.kernel.org/linux-cxl/cover.1787768932.git.anisa.su@samsung.com/T/#m393e57d7f7f3916e8f2826a006ef0bc4dfd3606a

Sorry for not mentioning it more clearly this time.

> My understanding is that CXL driver does not need special handling for
> device behaviors that violate the CXL spec. If we are facing this
> issue, the correct way is fixing it on device side.
> 
I agree too, but since I encountered this on a real device, I thought it would
be worth patching up.

Also if anyone is wondering: the reason I used QEMU to test the patch this
time is because the firmware on the device I was testing has been updated,
so the error doesn't happen anymore. Instead, I emulated the bug in QEMU.

Patches 2-4 were just pre-existing errors noticed by Sashiko, not
something I encountered on real hardware, so maybe those are not necessary?

> Let's see if maintainers have comments on that.
> 
> 
> Besides, your patch makes me realize that checking the return value of
> cxl_mem_get_event_records() is valuable. GET_EVENT_RECORD and
> CLEAR_EVENT_RECORD operations could fail in
> cxl_mem_get_records_logs(), which cause that device could not have
> chance to clear event records, then device would not clear event
> status register. In that case, the loop in cxl_event_thread() will
> never break out.
> 
Yes, I think even if we decide not to add the special handling for detecting a
non-compliant device that doesn't clear the bit, checking the rc of
cxl_mem_get_event_records() is necessary.
> 
> Ming
> 
Thanks for the review!
Anisa

> > 
> > Bound the loop on work completed instead. cxl_mem_get_records_log() and
> > cxl_mem_get_event_records() report failures and which logs returned
> > records; the thread drops any log whose status bit was set while it
> > returned nothing, and caps consecutive errors at CXL_EVENT_DRAIN_ATTEMPTS.
> > Every pass either drains a record, clears a bit from the mask or spends an
> > attempt, so the loop eventually terminates, even if the device misbehaves.
> > The first error is returned and an error from one log does not prevent
> > getting logs from the rest.
> > 
> > Retrying is limited to the failures that can plausibly be cleared:
> > -EBUSY and -ETIMEDOUT from the mailbox, and Retry Required from the
> > device. Anything else gives up on the first error, so cycles are not wasted
> > retrying on a non-retryable error.
> > 
> > Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > [Richard Cheng]: retry on transient failures
> > ---
> >   drivers/cxl/core/mbox.c      | 74 +++++++++++++++++++++++++++++-------
> >   drivers/cxl/cxlmem.h         |  3 +-
> >   drivers/cxl/pci.c            | 63 ++++++++++++++++++++++++++----
> >   tools/testing/cxl/test/mem.c |  4 +-
> >   4 files changed, 120 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 7c6c5b7450a5..2b71a8e1f35f 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -988,6 +988,18 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
> >   	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> >   }
> > +/*
> > + * cxl_mbox_cmd_rc2errno() collapses every device return code onto -ENXIO;
> > + * pick out the one the spec asks the caller to retry.
> > + */
> > +static int cxl_event_retry_rc(struct cxl_mbox_cmd *mbox_cmd, int rc)
> > +{
> > +	if (rc == -ENXIO && mbox_cmd->return_code == CXL_MBOX_CMD_RC_RETRY)
> > +		return -EAGAIN;
> > +
> > +	return rc;
> > +}
> > +
> >   static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >   				  enum cxl_event_log_type log,
> >   				  struct cxl_get_event_payload *get_pl)
> > @@ -1056,11 +1068,11 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >   free_pl:
> >   	kvfree(payload);
> > -	return rc;
> > +	return cxl_event_retry_rc(&mbox_cmd, rc);
> >   }
> > -static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > -				    enum cxl_event_log_type type)
> > +static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > +				   enum cxl_event_log_type type, bool *got_records)
> >   {
> >   	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >   	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > @@ -1068,12 +1080,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >   	struct cxl_get_event_payload *payload;
> >   	u8 log_type = type;
> >   	u16 nr_rec;
> > +	int rc = 0;
> > +
> > +	*got_records = false;
> >   	mutex_lock(&mds->event.log_lock);
> >   	payload = mds->event.buf;
> >   	do {
> > -		int rc, i;
> > +		int i;
> >   		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> >   			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> >   			.payload_in = &log_type,
> > @@ -1085,6 +1100,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >   		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> >   		if (rc) {
> > +			rc = cxl_event_retry_rc(&mbox_cmd, rc);
> >   			dev_err_ratelimited(dev,
> >   				"Event log '%d': Failed to query event records : %d",
> >   				type, rc);
> > @@ -1094,6 +1110,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >   		nr_rec = le16_to_cpu(payload->record_count);
> >   		if (!nr_rec)
> >   			break;
> > +		*got_records = true;
> >   		for (i = 0; i < nr_rec; i++)
> >   			__cxl_event_trace_record(cxlmd, type,
> > @@ -1112,31 +1129,60 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >   	} while (nr_rec);
> >   	mutex_unlock(&mds->event.log_lock);
> > +
> > +	return rc;
> >   }
> >   /**
> >    * cxl_mem_get_event_records - Get Event Records from the device
> >    * @mds: The driver data for the operation
> >    * @status: Event Status register value identifying which events are available.
> > + * @drained: Optional mask of the logs in @status that returned records.
> >    *
> >    * Retrieve all event records available on the device, report them as trace
> > - * events, and clear them.
> > + * events, and clear them.  Every log named in @status is drained even if
> > + * another one fails, so that a broken log does not suppress reporting from
> > + * the rest.
> > + *
> > + * Return: 0, or the first error encountered.  -EAGAIN if the device asked for
> > + * a command to be retried.
> >    *
> >    * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> >    * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> >    */
> > -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> > +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> > +			      u32 *drained)
> >   {
> > +	static const struct {
> > +		u32 status;
> > +		enum cxl_event_log_type type;
> > +	} logs[] = {
> > +		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
> > +		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
> > +		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
> > +		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
> > +	};
> > +	int ret = 0;
> > +
> >   	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
> > -	if (status & CXLDEV_EVENT_STATUS_FATAL)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
> > -	if (status & CXLDEV_EVENT_STATUS_FAIL)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
> > -	if (status & CXLDEV_EVENT_STATUS_WARN)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> > -	if (status & CXLDEV_EVENT_STATUS_INFO)
> > -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> > +	if (drained)
> > +		*drained = 0;
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
> > +		bool got_records;
> > +		int rc;
> > +
> > +		if (!(status & logs[i].status))
> > +			continue;
> > +
> > +		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> > +		if (got_records && drained)
> > +			*drained |= logs[i].status;
> > +		ret = ret ?: rc;
> > +	}
> > +
> > +	return ret;
> >   }
> >   EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ed419d0c59f2..cb5372eb2d85 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >   				unsigned long *cmds);
> >   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >   				  unsigned long *cmds);
> > -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> > +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> > +			      u32 *drained);
> >   void cxl_event_trace_record(struct cxl_memdev *cxlmd,
> >   			    enum cxl_event_log_type type,
> >   			    enum cxl_event_type event_type,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 267c679b0b3c..239df18c9c87 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -509,26 +509,75 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
> >   	return true;
> >   }
> > +#define CXL_EVENT_DRAIN_ATTEMPTS 3
> > +
> > +/*
> > + * -EAGAIN is the device asking for a retry, the rest are the mailbox being
> > + * momentarily unavailable.  Everything else is permanent as far as this can
> > + * tell.
> > + */
> > +static bool cxl_event_drain_retryable(int rc)
> > +{
> > +	return rc == -EAGAIN || rc == -EBUSY || rc == -ETIMEDOUT;
> > +}
> > +
> >   static irqreturn_t cxl_event_thread(int irq, void *id)
> >   {
> >   	struct cxl_dev_id *dev_id = id;
> >   	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > -	u32 status;
> > +	u32 mask = CXLDEV_EVENT_STATUS_ALL;
> > +	int attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> > +
> > +	while (mask) {
> > +		u32 status, drained, stuck;
> > +		int rc;
> > -	do {
> >   		/*
> >   		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> >   		 * ignore the reserved upper 32 bits
> >   		 */
> >   		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > -		/* Ignore logs unknown to the driver */
> > -		status &= CXLDEV_EVENT_STATUS_ALL;
> > +		/* Ignore logs unknown to the driver, and logs given up on */
> > +		status &= mask;
> >   		if (!status)
> >   			break;
> > -		cxl_mem_get_event_records(mds, status);
> > +
> > +		rc = cxl_mem_get_event_records(mds, status, &drained);
> > +		if (rc) {
> > +			if (!cxl_event_drain_retryable(rc)) {
> > +				dev_warn(cxlds->dev,
> > +					 "Event log drain failed: %d\n", rc);
> > +				break;
> > +			}
> > +			if (--attempts) {
> > +				fsleep(1000);
> > +				continue;
> > +			}
> > +			dev_warn(cxlds->dev,
> > +				 "Event log drain gave up after %d attempts: %d\n",
> > +				 CXL_EVENT_DRAIN_ATTEMPTS, rc);
> > +			break;
> > +		}
> > +		/* Progress was made, so reset number of attempts */
> > +		attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> > +
> > +		/*
> > +		 * The Event Status register is device owned and read only, so
> > +		 * it cannot bound this loop; records read can.  A device that
> > +		 * leaves a bit set with an empty log makes no progress, and
> > +		 * only the device can clear that state, so stop polling that
> > +		 * log rather than spin on it.
> > +		 */
> > +		stuck = status & ~drained;
> > +		if (stuck) {
> > +			dev_warn_once(cxlds->dev,
> > +				      "Event status %#x set with no records to read\n",
> > +				      stuck);
> > +			mask &= ~stuck;
> > +		}
> >   		cond_resched();
> > -	} while (status);
> > +	}
> >   	return IRQ_HANDLED;
> >   }
> > @@ -682,7 +731,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >   	if (rc)
> >   		return rc;
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
> >   	return 0;
> >   }
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index a7da279aa3ef..87e01612cea9 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
> >   			event_reset_log(log);
> >   	}
> > -	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
> > +	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
> >   }
> >   struct cxl_event_record_raw maint_needed = {
> > @@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >   	if (rc)
> >   		dev_dbg(dev, "No CXL FWCTL setup\n");
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
> >   	cxl_mock_test_feat_init(mdata);
> >   	return 0;
