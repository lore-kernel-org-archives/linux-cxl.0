Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17C1D9A5F
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488123; cv=none; b=Qwma6RvxMyJaXhZLwWpMcV7LK6jgi7JZdSb/78Ot44EiSb5WOYV9giEeKNzCyHozmumxI7LfnudNC80NR8wWo/s+S9YzkmJDVjPwyupowOjvrg/M//UssFrY3aHozBQNsfYouUUqo4aht/vgN0lMzQuqqihoHNe1osP9Tr2/U6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488123; c=relaxed/simple;
	bh=+7UEky+TDhv0k58uye4JoMBF14ZYtNbQ7lReARytUMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efvVYEdH5pCluQ12wKwUFYm0+s9uDR5srk4xdQUq2I+jCIiGiQYjxru9QiQ8Dz0obKbfeWSY5K0jYoB0i83sBV5yHbLTiJ723fb9F6rOMX1WWu/yftWRHJz6+m65N+MZ+pzvmaR65CzqvCfW3hGKuDGvCRme9V9M+RzoU9hq454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnCnTEYK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnCnTEYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749488122; x=1781024122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+7UEky+TDhv0k58uye4JoMBF14ZYtNbQ7lReARytUMI=;
  b=EnCnTEYKZHvflTGqvYm3V0q7hRx+pnMmJ2qTbyUD6yn9S5TIt2DZLu+n
   X5jkSuRDBi9PePRWBodeXVw5cfu2+oD34c7GMELw5ABKI38076Kv2bi17
   SlSE0tCIQ+a8PIlXX2ZdogMhLPWZuadM18lFWvgnFf34X6qJNBerVzVBa
   7PL5jZIXnvcpB+yFLWUym2G6xizVLHB2pJZwoTuKHsu5y6AG7PWdhRmeV
   3roXq1iKO9FEG3ITrtXSV06B104c35ul41vMX/B1IfyWeiO/5OD2LIDJX
   KO0m5XtT1ogD80LoY+ExiFwvnuQWSeFoPKzT9gk8ixG68hr8FfV3lHXBH
   w==;
X-CSE-ConnectionGUID: 7dpx1XcvTf61xywn/JOyfw==
X-CSE-MsgGUID: Mn+Mdjw1QnmUISEUrMjC4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55364271"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="55364271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:55:21 -0700
X-CSE-ConnectionGUID: fg3K/AOTTk+CD669XYENHA==
X-CSE-MsgGUID: H+tHxwoUT2mWoNqF/bqn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="177472844"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:55:20 -0700
Message-ID: <d37eaf92-a74a-4c44-8307-ca87906e9a75@intel.com>
Date: Mon, 9 Jun 2025 09:55:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Replace mutex_lock_io() w mutex_lock() for
 mailbox access
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Alok Tiwari <alok.a.tiwari@oracle.com>
References: <20250529205117.1990465-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250529205117.1990465-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/25 1:51 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> mutex_lock_io() differs from mutex_lock() in that it may call
> io_schedule() when a task must sleep waiting for the lock. This
> distinction only makes sense in block I/O or memory reclaim paths,
> where giving I/O a chance to make progress is useful.
> 
> At this call site, cxl_pci_mbox_send(), the mutex protects an MMIO
> mailbox. The task holding the lock is not blocking I/O progress, so
> calling io_schedule(), as mutex_lock_io() may do, has no practical
> effect.
> 
> Although there is no functional change, using the correct locking
> primitive, that more accurately reflects the semantics and intended
> use of the lock, improves code clarity and avoids misleading readers
> and tools.
> 
> Reported-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Closes: https://lore.kernel.org/linux-cxl/0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next with Fixes tag dropped.

> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 785aa2af5eaa..bd100ac31672 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -379,7 +379,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  {
>  	int rc;
>  
> -	mutex_lock_io(&cxl_mbox->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
>  	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
> 
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca

