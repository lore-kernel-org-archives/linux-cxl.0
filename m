Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFC1CEAC8;
	Tue, 14 Jan 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875565; cv=none; b=fEusJz4M+esfKLxPVf5iAsSIXsk0tApN9er+9k/S62FK5vuynEiZKvipNlM7g6O3mYx1TBbTQiThsA42Ar+cppsc5Vp87fp4vCRK8ee0t1yinZh/i6USYWUuNxntcXPR+3CgquYKOiBufsla3/cdmvjmIVTndEJSfC8K9Ym1yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875565; c=relaxed/simple;
	bh=4iKvhNs5zTOCe3G0s7NYL57dkXV5FXzy+/xXxXw8Ml8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6691/q0MMH4rUysWezPGtTCNyIZScGbpPfC2MFlvlrZFx4n8Cp+E0B5EsulgxKs3O9TEN6SXYQ+WXDvd0qY+jXDF0AQ1LaTXGKZA+7jME4/k6ms6Xzp8mOioPX+09bpDd9wDBsFpf8zUyOyDfNNDCWACPxxNp0FLuuUx4mVevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyEljXsE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyEljXsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875564; x=1768411564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4iKvhNs5zTOCe3G0s7NYL57dkXV5FXzy+/xXxXw8Ml8=;
  b=OyEljXsEdt0HTLamrxQEyDflTpNb8xAe84OV+8H9RqKfUFyKxoU6sD8V
   5Njzi+wca9d7/4v6cUMEzmKCy49IeiEcdZq4eqPtQtrEb31FvTShL+o4x
   T/CU4FIGx6PZeGO2REXQ2509iNHTW45GiSLSiyAVCHVJs4LkAQOkPqDd1
   NfdPYv6UuRcV9exrJLAUZ896Q8q32JOyJ3mxCrCQCC2LH0/Le6BataiRk
   zHsW4WBLG7n7bP5W0p5MwfnQIpAvGSgDk0k1cxUkh8Rf3kaP+fm/yO4gX
   Iru5smGuxSn4haMaHIL9glK2kIvIrLqxwfkmlk0laGxrCInUHOAr/Wu7W
   g==;
X-CSE-ConnectionGUID: Z174prWbTCmV4ViQ0o/aDQ==
X-CSE-MsgGUID: BUQ4i+P4SZ2MkRus4TXCmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48184939"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="48184939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:26:04 -0800
X-CSE-ConnectionGUID: Fm511CMtSFeUC75WePlxmQ==
X-CSE-MsgGUID: bP/4I54lRgC4g/L1ryIJbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109837901"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:26:03 -0800
Message-ID: <de3ff022-f226-4633-9641-f911fd99c4fe@intel.com>
Date: Tue, 14 Jan 2025 10:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cxl/pci: rename cxl_mbox_background_complete()
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
 a.manzanares@samsung.com, sthanneeru.opensrc@micron.com,
 emirakhur@micron.com, ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
 sthanneeru@micron.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-4-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241022031809.242591-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
> With the abort functionality, this is a misleading name,
> rename to cxl_mbox_background_done() instead.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/pci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5da50e26e4c4..7b0fad7f6c4d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -111,7 +111,7 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
>  					 dev_id);
>  }
>  
> -static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +static bool cxl_mbox_background_done(struct cxl_dev_state *cxlds)
>  {
>  	u64 reg;
>  
> @@ -128,7 +128,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  
> -	if (!cxl_mbox_background_complete(cxlds))
> +	if (!cxl_mbox_background_done(cxlds))
>  		return IRQ_NONE;
>  
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> @@ -157,7 +157,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  
>  	mutex_lock(&cxl_mbox->mbox_mutex);
> -	if (cxl_mbox_background_complete(cxlds)) {
> +	if (cxl_mbox_background_done(cxlds)) {
>  		mds->security.poll_tmo_secs = 0;
>  		if (mds->security.sanitize_node)
>  			sysfs_notify_dirent(mds->security.sanitize_node);
> @@ -359,7 +359,7 @@ static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
>  		return false;
>  	}
>  
> -	if (!cxl_mbox_background_complete(cxlds))
> +	if (!cxl_mbox_background_done(cxlds))
>  		return false;
>  
>  	if (mds->security.sanitize_active) {
> @@ -398,7 +398,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  
>  	mutex_lock_io(&cxl_mbox->mbox_mutex);
>  	/*
> -	 * Ensure cxl_mbox_background_complete() checks are safe amongst
> +	 * Ensure cxl_mbox_background_done() checks are safe amongst
>  	 * each other: no new bg operation can occur in between while polling.
>  	 */
>  	if (cxl_is_background_cmd(cmd->opcode)) {
> @@ -434,7 +434,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  		timeout = cmd->poll_interval_ms;
>  		for (i = 0; i < cmd->poll_count; i++) {
>  			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> -				       cxl_mbox_background_complete(cxlds),
> +				       cxl_mbox_background_done(cxlds),
>  				       TASK_UNINTERRUPTIBLE,
>  				       msecs_to_jiffies(timeout)) > 0)
>  				break;
> @@ -445,7 +445,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  		 * until the next successful command submission and the driver
>  		 * can get back in sync with the hardware state.
>  		 */
> -		if (!cxl_mbox_background_complete(cxlds)) {
> +		if (!cxl_mbox_background_done(cxlds)) {
>  			dev_err(dev, "timeout waiting for background (%d ms)\n",
>  				timeout * cmd->poll_count);
>  			rc = -ETIMEDOUT;

