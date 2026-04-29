Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0583EF0A6
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460024; cv=none; b=HbqWfp0nR40QkmcSy80bwsF2ShfkA5+hPR/M0elc32t9E6ZAu0Io/gvDL7di0TWsN0dAEmb/YibXix6ciw+cXg4SJuFH7FQO5EIgevrbkxR/MUQb2q8zjwN0RCi1EU/5cpNnvlEsIJKuib5ifCZ5lc54OjeyvlMeKQipVE9tyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460024; c=relaxed/simple;
	bh=HObom7mnDMtZT+G4zU1KDMM8aJSQoNZuqYqq6hwREGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0Q84j+ywC8hdVtzcgJQvb+piXiwkGjImRZ7zVJzgE4xR5qQlMJIgzgwZnzOOmHBVcLyZBAbcQzhPW+r0vORB97ZTeWJ2pQIXPkxa8AXB3zQxSf6I3f8h2LZPVMY0PUThk4GsC5L6p4NJOlRa7tke7/spJ1w9YWS10rmewA0ceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqCmeta7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqCmeta7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C16C19425;
	Wed, 29 Apr 2026 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460024;
	bh=HObom7mnDMtZT+G4zU1KDMM8aJSQoNZuqYqq6hwREGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqCmeta7Yk5VozeSkqRHYKdSrbszjEjiuq1EtgxTMdQV1ZSYKi7Ctz6VnBxD79mTs
	 hRAfCltv/zQfBGSKpDJwN2ZVItfXCGmOdlilD2pdRmuDUNMoA8TPD4AvtT5n1Jhlxg
	 30o8OmBcA1agpNofg/hOx7LcEZo7nGD4v/4yDNQsDHEZlcnvOwhRKR9leIbKdDp2y5
	 7fiVwioXobxmo01djpT2UX2EU2D7JxYFQ4EYttXwnkYvhX9pOkF7pLbr6Zm8vv1aAO
	 UZJtwe53Y/QxxtgexloAzzPEO2lY9Zci9UVtn51ulgBokrV+GA8VsUoxJIUL69ezxf
	 8dI8aBW60lTeQ==
Date: Wed, 29 Apr 2026 11:53:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
Message-ID: <20260429115336.2f5169e4@jic23-huawei>
In-Reply-To: <20260428212220.711160-1-dave@stgolabs.net>
References: <20260428212220.711160-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 14:22:20 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Use the new helpers and simplify the code. No change in
> semantics.
Does it simplify the code?  I'm not sure these particular
ones are that helpful.

Don't get me wrong, I love guards() and using them in new
code is fine but I'm not sure it's worth the churn if we don't
see a significant advantage.

Some specific comments inline.  I think with a few tweaks
the advantages become greater and outweight the churn aspect
- others may disagree!

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/memdev.c | 16 ++++++++--------
>  drivers/cxl/pci.c         | 21 ++++++++-------------
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3db4e91170a8..0c9067ced7b3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -138,10 +138,10 @@ static ssize_t security_state_show(struct device *dev,
>  	int rc = 0;
>  
>  	/* sync with latest submission state */
> -	mutex_lock(&cxl_mbox->mbox_mutex);
> -	if (mds->security.sanitize_active)
> -		rc = sysfs_emit(buf, "sanitize\n");
> -	mutex_unlock(&cxl_mbox->mbox_mutex);
> +	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
> +		if (mds->security.sanitize_active)
> +			rc = sysfs_emit(buf, "sanitize\n");
> +	}
>  	if (rc)
>  		return rc;
As it stands, if anything this is worse from readability point of view
as the setting of rc is getting further away.
However... If we take a it a step further I think it would be worth doing.

	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
		if (mds->security.santize_active) {
			rc = sysfs_emit(buf, "sanitize\n");
			if (rc)
				return rc;
		}
	}
+ can drop the rc init at the top.
That way the scoped_guard() is letting us move the error check nearer
the source of the error and is a win.

>  
> @@ -1247,10 +1247,10 @@ static void sanitize_teardown_notifier(void *data)
>  	 * Prevent new irq triggered invocations of the workqueue and
>  	 * flush inflight invocations.
>  	 */
> -	mutex_lock(&cxl_mbox->mbox_mutex);
> -	state = mds->security.sanitize_node;
> -	mds->security.sanitize_node = NULL;
> -	mutex_unlock(&cxl_mbox->mbox_mutex);
> +	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
> +		state = mds->security.sanitize_node;
> +		mds->security.sanitize_node = NULL;
> +	}

This one is churn for me. But if it's the only manual
mutex handling int he file that is left, fair enough.

>  
>  	cancel_delayed_work_sync(&mds->security.poll_dwork);
>  	sysfs_put(state);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 95bf773aab14..3462cea6e61b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -134,10 +134,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> -		mutex_lock(&cxl_mbox->mbox_mutex);
> -		if (mds->security.sanitize_node)
> -			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
> -		mutex_unlock(&cxl_mbox->mbox_mutex);
> +		scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
> +			if (mds->security.sanitize_node)
> +				mod_delayed_work(system_percpu_wq,
> +						 &mds->security.poll_dwork, 0);

This one I dislike because the indent is getting larger for no
major readability advantage. GIven the scope is tightly defined anyway how about
instead doing:

	if (opcode == CXL_MBOX_OP_SANTIZE) {
		guard(mutex)(&cxl_mbox.santize_mode);
		if (mds->security.sanitize_node)
			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>  		rcuwait_wake_up(&cxl_mbox->mbox_wait);
> @@ -156,7 +157,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  
> -	mutex_lock(&cxl_mbox->mbox_mutex);
> +	guard(mutex)(&cxl_mbox->mbox_mutex);
>  	if (cxl_mbox_background_complete(cxlds)) {
>  		mds->security.poll_tmo_secs = 0;
>  		if (mds->security.sanitize_node)
> @@ -170,7 +171,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
>  		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>  	}
> -	mutex_unlock(&cxl_mbox->mbox_mutex);
>  }
>  
>  /**
> @@ -377,13 +377,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
> -	int rc;
> -
> -	mutex_lock(&cxl_mbox->mbox_mutex);
> -	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> -	mutex_unlock(&cxl_mbox->mbox_mutex);
> -
> -	return rc;
> +	guard(mutex)(&cxl_mbox->mbox_mutex);
> +	return __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
I like these really simple ones just for saving lines of code.
So this is good as far as I'm concerned.

>  }
>  
>  static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)

