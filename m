Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04C29BD91;
	Mon,  7 Sep 2026 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806918; cv=none; b=dyKojTLOAXqnPxQ4TyCG4HIn13LqMegY5B4jc26Cn0xDygKonDsAAA18X08EZYlfHz6OgOg6yB8UMvnn0jYKif9/ay+kr/G3eaLLNtXb7swD6rBBlVUEEOL4oWFx/I/McUXAQq2bUUt7AwMVYQ+cLNaT0uc7Fs/0KXwtImuu8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806918; c=relaxed/simple;
	bh=htrCXtnZ0GWiFORxvT949iCj6jaJ/Y5cRXIq52cexSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZoZUx6Lq4z+bkp2pZIaNYgdr3n2MBYVtvwmMUNnp+wZuy/ZzXRAAodaLjPflMu56ko4IGVuCXfB+Yi+kkMOfk/c32KErXuJcHtGpayVUhqy/Fe5u8ch+k15vOkd6FbsHZerkQeewQ62azCIwt0fAQpOJ1HrymxH3DWeOTWPW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPJfKAC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPJfKAC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04361F00A3D;
	Mon,  7 Sep 2026 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788806908;
	bh=WUGlg6nOt6cJk2JXuG7+Y1oHcwtL6rVa38JzQRjXjb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DPJfKAC54z+2fIAyhpi+B0+4tKrar9hzLyzCNC5W3JRSnKLB/TGOnAuXu6UsMju9D
	 scw9614mOdVO18NHpD1JfNfDcmAzTsA4nMsqzuh3w4SBpmCnGyiE1gAxUuuqVra7Bp
	 CMN5jj3eNI0tTq7iragP6tGT/ErozLCh6v/z6P/AkfdGWHjB5b2oV1NvepG0Hl4EhS
	 XVPsSnXknmzVBejQcH+iNMmmxWJNB4xb9E6P7jMmEhFe9cd8uazUy272Rxrvh3jpKr
	 9siHWm3tTl/+8gsvgGN3O9M0Ta/9e2ga4VZLvCuWs7FjjLL+1uTjEr0eAWh94Fia1V
	 bP1zhuBa+Xk6Q==
Date: Mon, 7 Sep 2026 19:48:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <20260907194824.615e47ff@jic23-huawei>
In-Reply-To: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 21:27:05 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> CXL event interrupts may share an MSI/MSI-X vector with other event
> logs or device features. Consequently, cxl_event_thread() is registered
> with IRQF_SHARED and must determine whether an interrupt belongs to the
> event-log facility.
> 
> The handler masks the Device Event Status register to the event logs
> supported by the driver. However, when no supported status bit is set,
> it exits the processing loop and still returns IRQ_HANDLED.
> 
> Track whether at least one supported event status bit was observed.
> Return IRQ_NONE when there was no event to service, while continuing to
> return IRQ_HANDLED after processing one or more event logs.

What is the practical result of this change?  
I think it will only affect the spurious interrupt detection so
to me it looks like a cleanup rather than a fix.  Is there
any path by which we actually lose interrupts as a result of this?

> 
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> 

No blank lines in tag blocks.  There are a number of tools that rely
on there not being any and as such there are also scripts that run
on various upstream trees that will send us annoying emails if this
blank line is still here!  I'm not sure why this mistake in patch
formatting is so common as there are plenty of docs without the
blank lines!

> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

A suggestion for an alternative implementation below.

> ---
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

			return IRQ_NONE;

And don't need the other changes.

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
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
> prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77

