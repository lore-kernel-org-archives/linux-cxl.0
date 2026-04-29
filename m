Received: from fly.ash.relay.mailchannels.net (fly.ash.relay.mailchannels.net [23.83.222.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6732F75B
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486740; cv=pass; b=FU/ismNxS5LHBwroRUe8usZtlz/bGEzy74HNWeTY9CUGhijMrKfyyq68dCRyjPtAo1hOVEiQKPhRXmFMSlf1ggR6/UHl9ffdyVGGgUMef/SmmK2JhsZT9qldQEDhAuL3RVRINY+rb5z8a+h9wpY7AjG8RyKo96X4J0Dx92bO0Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486740; c=relaxed/simple;
	bh=eV6ZL3pQH1WvEKXzymcJMr9elkVve8PVvWxeGDQfxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/hiRD8NJxQWhvEHXqO9MSepWbCihbPNaZ25LHc5xCyxQXGfLW2yddr1nS3MItTJMiSXJQDMRIu75eakbFo38WW+oFr4zNV3QQZADKkWkN9MsfQsHpNojvSwIHm2qg0T5sxYCeG9ezhQvDYlqAYq6xF7YvczGs7YJ4eDz981o4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Kz6BA21i; arc=pass smtp.client-ip=23.83.222.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Kz6BA21i"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5553A8C220F;
	Wed, 29 Apr 2026 17:59:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (100-96-25-229.trex-nlb.outbound.svc.cluster.local [100.96.25.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D97628C19CE;
	Wed, 29 Apr 2026 17:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777485589;
	b=vtbEIYDxzVyvNoxbQYVIFAbBe6RjETCEpR15ErU5sZpdlE3F3hj0BHbh3E/l6YQYxKDcmd
	sIRMwSEiUGyL5Hs2JeMZjJ8Y5XB4YWrxrZkuXPhyzsvaPg2sICs2gJhbycOuzFr2PS5upL
	g1kxBRzd+Ku5UiC15dJyi4aLKCT+D39WX3RQ5NXW0Ilwk7aKrnIaCtd5BO3puCjOR0RnKt
	XWCDA/kzAsVVwFfVGjGUpHcW8yFC12oEB47Yq//P9EpumO/9dFU+llw6YC8hFgpZcQ5dN1
	BB9P7zJmDYEvCOKKigdx5mHXIqlr3P376YNII/fKCsG3milziFihOMihulJHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777485589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2EtaUh2ajQjMhqU90dt7k/C90L5Mf92UWCD5VcfPHiA=;
	b=pqUxwesZ+HJHTQw/l6CKjG62UapX1L/caSjd7+UmcxI9lylYsHMZknZfUJszrnFgME9x+5
	mMPc4bdJMPDHfAavAEBcRGAsqotepbbkWYsSOVN9IQ+vZHzFXmL2RGtb7XskuDaVxjhyMx
	xSFWuPXO2seS14YraWLQkzT6FgabO+IOPiM9PyCT0JZg9hEmocPCAMszaDdr6vKplKReJX
	XX1tZPA42egz8gBtaqrOFNrFiqGc4E+8OX7mEajq1URo/oYX6xumzSmMR27WbkWsaznq1S
	4iJsR13Og1V3vcwysSUerULBMZ3pD8VkSW8CF9KpoIZqZ8Ugt65QD14G7dvmXQ==
ARC-Authentication-Results: i=1;
	rspamd-5bbb54c4f7-llrpx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Little: 5d9b4dca0a5d96ba_1777485590118_2690904288
X-MC-Loop-Signature: 1777485590118:324828431
X-MC-Ingress-Time: 1777485590118
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.25.229 (trex/7.1.5);
	Wed, 29 Apr 2026 17:59:50 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4g5Q792s94zSJ;
	Wed, 29 Apr 2026 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777485589;
	bh=2EtaUh2ajQjMhqU90dt7k/C90L5Mf92UWCD5VcfPHiA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Kz6BA21iEuPXOEz7Jny6EE93Ri9/T/jzYmgybxw9INBbbDmz4YsX85cGTbzByXi3z
	 qKWmFq3E+vbV7VOmyiPVnV5XPvIIWpN5nWRenxY61eu6vx28Pg5Qoafq0AiaTV1jRG
	 8JLmifkCFnENPj6z0764KBUUA2i2mMZCxKvfnrbUW7yv8X1cGVTi/DPllicHZetjV7
	 uNhf7Q/5r5iX4H4WC3awWqovBYKIivGyNcTmYF0MnfNWHlAiBpPJqdT2ySkMSX1x8O
	 AEtGjwsrVBaVm6B5mWnXO6YRgEy/z6LcXOvpKpeX8alZo8oUdHqKG57aRhdEbXG1Gd
	 VTxHV+JJeejUw==
Date: Wed, 29 Apr 2026 10:59:46 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
	djbw@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
Message-ID: <20260429175946.25xz7pkd4qrknyy7@offworld>
References: <20260428212220.711160-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260428212220.711160-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 28 Apr 2026, Davidlohr Bueso wrote:

>Use the new helpers and simplify the code. No change in
>semantics.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
> drivers/cxl/core/memdev.c | 16 ++++++++--------
> drivers/cxl/pci.c         | 21 ++++++++-------------
> 2 files changed, 16 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>index 3db4e91170a8..0c9067ced7b3 100644
>--- a/drivers/cxl/core/memdev.c
>+++ b/drivers/cxl/core/memdev.c
>@@ -138,10 +138,10 @@ static ssize_t security_state_show(struct device *dev,
> 	int rc = 0;
>
> 	/* sync with latest submission state */
>-	mutex_lock(&cxl_mbox->mbox_mutex);
>-	if (mds->security.sanitize_active)
>-		rc = sysfs_emit(buf, "sanitize\n");
>-	mutex_unlock(&cxl_mbox->mbox_mutex);
>+	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
>+		if (mds->security.sanitize_active)
>+			rc = sysfs_emit(buf, "sanitize\n");
>+	}
> 	if (rc)
> 		return rc;
>
>@@ -1247,10 +1247,10 @@ static void sanitize_teardown_notifier(void *data)
> 	 * Prevent new irq triggered invocations of the workqueue and
> 	 * flush inflight invocations.
> 	 */
>-	mutex_lock(&cxl_mbox->mbox_mutex);
>-	state = mds->security.sanitize_node;
>-	mds->security.sanitize_node = NULL;
>-	mutex_unlock(&cxl_mbox->mbox_mutex);
>+	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
>+		state = mds->security.sanitize_node;
>+		mds->security.sanitize_node = NULL;
>+	}
>
> 	cancel_delayed_work_sync(&mds->security.poll_dwork);
> 	sysfs_put(state);
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 95bf773aab14..3462cea6e61b 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -134,10 +134,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> 	if (opcode == CXL_MBOX_OP_SANITIZE) {
>-		mutex_lock(&cxl_mbox->mbox_mutex);
>-		if (mds->security.sanitize_node)
>-			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
>-		mutex_unlock(&cxl_mbox->mbox_mutex);
>+		scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
>+			if (mds->security.sanitize_node)
>+				mod_delayed_work(system_percpu_wq,
>+						 &mds->security.poll_dwork, 0);
>+		}
> 	} else {
> 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> 		rcuwait_wake_up(&cxl_mbox->mbox_wait);
>@@ -156,7 +157,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
> 	struct cxl_dev_state *cxlds = &mds->cxlds;
> 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>
>-	mutex_lock(&cxl_mbox->mbox_mutex);
>+	guard(mutex)(&cxl_mbox->mbox_mutex);
> 	if (cxl_mbox_background_complete(cxlds)) {
> 		mds->security.poll_tmo_secs = 0;
> 		if (mds->security.sanitize_node)
>@@ -170,7 +171,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
> 		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> 		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);

Sashiko had some feedback, which was a false concern. Copy pasting here as I
don't know how to reply to it yet.

> This isn't a regression introduced by this patch, but looking at this code,
> can this unconditionally re-arm the delayed work during teardown and cause
> a use-after-free?
>
> During device teardown, sanitize_teardown_notifier() clears the sanitize_node
> to NULL under the mbox_mutex and then drops the lock to call
> cancel_delayed_work_sync().
>
> If cxl_mbox_sanitize_work() is executing concurrently,
> cancel_delayed_work_sync() will wait for it to finish. Meanwhile, the work
> function acquires mbox_mutex, sees the command is not complete, and
> calls schedule_delayed_work():
> 
> CPU1
> sanitize_teardown_notifier()
>    mds->security.sanitize_node = NULL;
>    cancel_delayed_work_sync(&mds->security.poll_dwork);
> CPU2
> cxl_mbox_sanitize_work()
>    guard(mutex)(&cxl_mbox->mbox_mutex);
>    ...
>    schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ)

This is fine.

cancel_delayed_work_sync() uses WORK_CANCEL_DISABLE to bump the work's
WORK_OFFQ_DISABLE_MASK and clears the pending bit.

queue_delayed_work_on() checks the disable mask via clear_pending_if_disabled(),
between setting PENDING and adding the new work. If disabled, PENDING is cleared
again and __queue_delayed_work is not called.

> 
> Unlike the IRQ handler which safely checks if (mds->security.sanitize_node)
> before re-arming, the work function lacks this teardown check.

sanitize_node does not dictate correctness for this, it is about the status
file.

> 
> Does this result in the delayed work remaining armed after
> cancel_delayed_work_sync() returns, eventually executing on freed mds memory
> when the timer expires?

No, cancel_delayed_work_sync() is explicitly documented to handle rearming work.

Thanks,
Davidlohr
