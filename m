Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32085485CD8
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905660; cv=none; b=BuQWGtSrEmU7qdSrn7C41VHWJ38NmgeJAReQjDWhddbP3exjmE6UCtcFHu1oL3p53MP38aNPRcikh3qPt++Q23yiEA5yc1oo/X2RL184Atk29aYuoVi0WOzZ2XIhZqAGEoHWA/tie/mjDI/En14GJedZj4ql8PcvwD2HuK+e2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905660; c=relaxed/simple;
	bh=RlL6eeJiRfVkyEEe9CV1DU5iAsZ8trUj6sa4Pkn9xls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ4Idy15RlczqHYA5Yif9VevdkW446Rhfk7hvrEZ+hFJDMj0Dz/scX7sZwZdGmQ4viuaZhZ5Mn3e86y8HM6LDkQHzCLToDNIX1D4fcHGaDDr23AQT80C8JK5VePoKj5TMWklOhYCMZfGt1ZLvtXszvLx2QOh0cVwED3tnkkmxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSZIT5HF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSZIT5HF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B31F00A3A;
	Tue,  8 Sep 2026 22:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788905658;
	bh=bRNdhzscjzLE7lO0PwAFiR7fZ94eSDTN3vPUBXSbpmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FSZIT5HFOecZV+woCtyE+cVd5m3m2Ymu7deddj1U2H3AUTuGve1r5H1cIBGWPR/2Q
	 vtaQrYwfaSnlD39cRvgwPO4y7qE9C4gZLb+0mx3AYUHGK2JIgbNox8E9Lb9tApaihm
	 MZFUj8/zK+7yuXbYp7I6SNFVj1gtSYw4UCMy0O89o7jC1KcLtIecInBemGci90YP3a
	 8M3hxcsnCHpp+tPLudwA/8AhOVVmaoYAIRLskqQj1fWvL1Ou0SiD8rWAu5iJWdG4dp
	 XNi0WPfagtBFGKKlo8eK1XLbqZ1gQPdpxp5oWPEkJiyOu3Z8p4A723Yg/l88qpSs74
	 ijRfVkYRysMgw==
Date: Tue, 8 Sep 2026 23:14:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <20260908231414.427c677d@jic23-huawei>
In-Reply-To: <20260908102124.2231730-8-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-8-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 03:15:10 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism. The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications. Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity. Disable DCD if interrupts are not supported.
> 
> The DCD event log is not drained here. cxl_event_drain_mask() reports
> only the logs the driver can service, and the DCD bit is added by
> the patch introducing DCD event handling. Until then a DCD interrupt
> wakes the event thread, which finds no log it owns and returns.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 

One minor thing inline.  Otherwise LGTM.

Jonathan

> ---
>  drivers/cxl/cxl.h    |   4 +-
>  drivers/cxl/cxlmem.h |   2 +
>  drivers/cxl/pci.c    | 124 ++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 109 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..d6e02bd0cf50 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -192,11 +192,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL |	\
> +				 CXLDEV_EVENT_STATUS_DCD)

See below. I think this define has become a bad idea, making things
more confusing rather than simpler.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d..1ea505b1f40e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/* Event logs the driver drains: standard logs when native_cxl */
> +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> +{
> +	if (host_bridge->native_cxl_error)
> +		return CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;

This seems a little backwards.    Better I think to just list the logs that
are supported. There are other logs coming and I think we'd want to opt into
them deliberately like you are doing for DCD rather than have them caught
by the _ALL define.

	if (host_bridge->native_cxl_error)
		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
> +
> +	return 0;
> +}


