Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43D74C14
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415933; cv=none; b=rKai/0zaO7VhQmNroi+PVrVK2rP7pgqjeuSlqwMNOAYZorhbXdpR+J6S3DZCgY8gszU84w/aqdwgkY4Me1q3EGyHTVW+e2aiMnG7utSp1KLM/u1dycuBdYoH/pEbv7Wu8/RmD8KP+UU5fWHAK3np1QALN3WyuOcvvA/wwVvEJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415933; c=relaxed/simple;
	bh=nGJPgsUri+Tb5gFgRJeLuxf1hLVkEGYfeFLnEaemiiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVLqTRoF6i+Ewopa5M4eBqJ/BVI5dGgNUU2IvDbL3FhewZtQVzPoCVYlxiVKGZV+yEVbswFyURp1VzwX9K9QuCyoUU3PTjmUkhon5h8vzZPCead2U0nzr5ZuQ9h7zqZRoADdp/OZIKSI7t6HlN7SRvBY+Q+JR8YYW5tHbwexwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhb4YlZf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhb4YlZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777415932; x=1808951932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nGJPgsUri+Tb5gFgRJeLuxf1hLVkEGYfeFLnEaemiiY=;
  b=dhb4YlZfqaL3nRoYOGRkQWct3cvRa2shbOBwwb2/yvkw08ZiaE9VskFZ
   r/HFrWLsX2tSGQhxbcrQsZGvL0qlAjS1HoHWE8YYCL+MdZH5Q4i1mGHB6
   3eRjgmKIgtJ4bTB7DCx+G5DX/hVDrh278J6eBYcWl4gf/KLxvrl4+WXXL
   X9z/8HVL2f1ykNgE+xhVN8xX/Vme6+fxt1JPEvC7Mgb7ODDvFKWoImvq2
   CIajdXAsE2XSgx5/evf6jpkqKKgj/LWBroQI1+zmEVr+Jo5FRqwXFoPcP
   aHZE28aPYfTb1i2V/afGtrnA7deMNOReWaBVR/nl3N4l0P+LrWa8/OEu3
   Q==;
X-CSE-ConnectionGUID: 690fK+PuRTKSZgyRRcmIxg==
X-CSE-MsgGUID: MyxwJ8tGSb2zesInpa+ZCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78531413"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78531413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 15:38:51 -0700
X-CSE-ConnectionGUID: zwa9Ke7DSHiz/SVrGK0QNQ==
X-CSE-MsgGUID: CbB9C4DkRpOCyJBSuO2sRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233231804"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.229]) ([10.125.108.229])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 15:38:50 -0700
Message-ID: <b96ab07b-a134-4417-86a5-386c17829977@intel.com>
Date: Tue, 28 Apr 2026 15:38:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, linux-cxl@vger.kernel.org
References: <20260428212220.711160-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428212220.711160-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 2:22 PM, Davidlohr Bueso wrote:
> Use the new helpers and simplify the code. No change in
> semantics.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Is this in prep of media ops?

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
> +		}
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
>  }
>  
>  static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)

