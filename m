Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39A3BE642;
	Fri, 18 Sep 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746049; cv=none; b=eOB9EpaKLsKqpzzPm2pbwUlMSmAL1Eh7QlbGAaWRPvhewgp0kzW45bSdN2r4oWKX2moZzEAGDb68jJei55cvOWb23spK8UXPo8FwaVrFDIVmKyUeshbJNXR7bnhauN2Xh1q/phI1azeEFOYcYMBXBp6aX9Q+/izjoI1+i+5yiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746049; c=relaxed/simple;
	bh=lwmdc3He+ffZqOKAhXhWiLf5MPr6XGEuf3Kp76ENcc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqd9jr2XyQyCMpKTao9yUEr0VH/rgPvEXh0/Ccz/rQl4PSNCpux8z+8oUmj/zre0JHkwjIBtlVjHCViMAXH/E0pAL75C001O7Irpznjen9UDIGJSzQzRA2dPwgrmcT090CQWbTdFKOk8ZKiDMLVlTvlC4CLwyYFUUq9s3VHs1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkof8BYV; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkof8BYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746046; x=1821282046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lwmdc3He+ffZqOKAhXhWiLf5MPr6XGEuf3Kp76ENcc0=;
  b=Qkof8BYV4B+8UYVIqxfZyJ9x0Hyi3nYI3bx24VFHWbPDvjnggc4N1LFT
   Zzg68j7zFUd/VU9JXM1W7XREPBB7rJB84B9dKW0QcpugdM2wcWFmAAzwC
   FV6A4ZlJ/xyM9sgN3RHAL7X4OIWnVWodfv4ol5jE/ZeJF7aQR2gFciyhx
   Avw4GdsaMtW7i9kKOVrNO0CsPG5NyY8rbOORCXbd2BuNBn1IF20+4D824
   YG2IGkXu3lZsWiA8QctjLValsPny2YaIjnIW3BLaGH0ae+u7mdHsow6fM
   ETOHYUvdH9Us6JbXvouUSX+8o63jK3STeWTzKkBmCCRiAazDKnvSrhYzn
   w==;
X-CSE-ConnectionGUID: ZHCz4+ZPSt288F3V0KmkQQ==
X-CSE-MsgGUID: AMNuvK8ZQAyBOGW7Ryqomw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="759793"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="759793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:40:44 -0700
X-CSE-ConnectionGUID: qGu3k0KTR0msRFN7zuWMxg==
X-CSE-MsgGUID: YmzZG0zPTtW0aSmIuE0Apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="297908548"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:40:43 -0700
Message-ID: <3554ed26-1659-4126-92ed-48d7df83b0c2@intel.com>
Date: Fri, 18 Sep 2026 08:40:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: anisa.su887@gmail.com, benjamin.cheatham@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/26 2:38 AM, Shaikh Kamaluddin wrote:
> CXL event interrupts may share an MSI/MSI-X vector with other event
> logs or device features. Consequently, cxl_event_thread() is registered
> with IRQF_SHARED and must determine whether the event-log facility
> claimed the interrupt.
> 
> The handler masks the Device Event Status register to the event logs
> supported by the driver. However, when no supported status bit is set,
> it exits the processing loop and still returns IRQ_HANDLED. This
> incorrectly reports that the interrupt was claimed and prevents the
> generic spurious-interrupt detector from accounting it as unhandled.
> 
> Track whether the CXL event handler claimed the interrupt and return
> IRQ_NONE when no supported event is detected. If no handler sharing the
> vector claims a sustained interrupt storm, the generic spurious-
> interrupt detector can eventually identify and disable the affected
> IRQ.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Applied to cxl/next:
a8c458611a7d

> ---
> Changes in V2:
> - Emphasize that returning IRQ_NONE enables generic spurious-interrupt
>   detection and drop the Fixes tag. (Jonathan Cameron)
> - Check whether the event interrupt is already disabled by Anisa Su's
>   patch; no code changes were needed. (Ben Cheatham)
> - Rebase onto v7.3-rc2; no code changes.
> 
>  drivers/cxl/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..8b560cae91f2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	bool handled = false;
>  	u32 status;
>  
>  	do {
> @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		status &= CXLDEV_EVENT_STATUS_ALL;
>  		if (!status)
>  			break;
> +
> +		handled = true;
>  		cxl_mem_get_event_records(mds, status);
>  		cond_resched();
>  	} while (status);
>  
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157

