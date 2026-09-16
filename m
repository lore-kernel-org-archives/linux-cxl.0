Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900761A5B8A
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519050; cv=none; b=nE5UmYLJb7aYfqeKUy9sfVernDdSCteHvSgbx81QOYSauOaX7io+zECHDJlro33JXNuc5eGi1HETz1cfoABufKrtk1ulpWbOrxQZv20EZeyEgZSnQx2ksFzFDRnVJJ/ZiW1OmWuw2sEl/0aYX8Zxfxk/7o9khgD7X3bozl34ZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519050; c=relaxed/simple;
	bh=/PjDFzNQ4MwfKQTCx8WL+nddwpz++fXoI2e7Z6CnAHo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul5/K2yY9ZizmPvF68dd8p+hVuzH59L59wtjg+V60vPHRFdVJfx0GXXqm4WWqgw9PcysnZTuuUtfzlfn2401/dI8FMf0yM6Yh0ybqKcofUpk9Nv58ymsiKjf7/WP2dcFGIjcaOEf9oAI2XCAuA2LlOp0xlqH/AP85W5oXZ4Rt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E45Rm/5p; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E45Rm/5p"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8686f46e4adso274743b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789519048; x=1790123848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqKkVTQQYcwc0gbDN5faBzOyekyMfBu7hjn3LfeaFvo=;
        b=E45Rm/5plnl8zHt1CD+RThMP5/scOyy233xBzGtB5YzAGoEzY3jGavgwAz6pc1JjlC
         IPTfgbqzAJMukih5nybTFkQxbzqYHtNExrgIBEIjtzvOVGFRXiypKEfe0wE8/YmDX9ic
         dDZVC5WxXNHrRfdrd0YjHeW/icCvHwbU+OEkhXe+C5rTF4SRue4OJ+8QANrNxUE4fOUx
         FW4f+IcPoIc1deTpOidGwoGjUWv99DnEGyhAVEyf+iLYr6PkfmnGFdkJI5lBFfxd5qct
         cAWp4DSdUqh2nPu6o7Zq1QuFgOc5mj2V30S6KhxWE1Y4nHy3YHNWrbnWWVUCfdU23g3z
         2iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789519048; x=1790123848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqKkVTQQYcwc0gbDN5faBzOyekyMfBu7hjn3LfeaFvo=;
        b=lZnIzNQXOL0Y8uWKVAzgbITDDobw0SpHsTckq0wol1Fpc0v8s7gxdhLFn9tl5z0Ys6
         lapZiDXjfZmzZz+hxwFZJr9/dfXXMJYIajRqxavQh3xXxZSp6M8JmsTqstA5zduyPb4d
         2VfdMdU4nKmg9avR7RSMEWaHg+NYxSqnAmbsizZXDRaV50HW72S8P1ubJe3gcxdwsmne
         T5NMNwozBn15bPiQIRn+5b24jD1wpwwp/B80PURhnf02oLZcNNiHRr1w2HxZzIZd9Ag7
         COXkwfX3ckSHvyCiwPOyr06KJ2pMdpokg5YnWi6Mh+tw6bLr6OojsnrlcVO3l+AY/4gz
         8XAw==
X-Forwarded-Encrypted: i=1; AKwUvBwT48wXGYkgvADRHVfqGJoFchmqX6SrmUTfxhDj6dO1sJ0B7n8W0C0T84FCDA3asXGZaEYtHM5ivQI=@vger.kernel.org
X-Gm-Message-State: AFuF++kzdtVy/CB0GZJC6d2tQzfazUmugFRZgFlTdWuGkwleKQmZN8iy
	2wLb0woj556hjzZjjyjvUmOMN8twfGoGWVrDb+g8Gxztm6Gun/ri/E7k
X-Gm-Gg: AYBFou0Rc+yOV+BbSLp4vNLeUEfGFrpLCTTDK6pbCNT7QElM91r+PMoRjbUpsl1/Yug
	rPauP759YJEB4xFaQkthYegRQW/RWA5pIqXRQV3KnClQ5FiYLkdTDWCBG0KKa+LbAQO5R6E/7EP
	qqrk7J0V47GBa46tzn03iukb54iz+/nUCfCyf99yL83xs8LNh9WPKGbJ56j/UIbFRdeJV3EYG8Q
	FGIXQprKmLHLxXMt89RVa12aaYN+eS7PeF3GXaA+pzn6rzmCAGZ2dqDYkDYUsaoktYLIukQJYbb
	DU9Uns+AkqSDCtWln13z45XNbB9vWkkRZ9YagIV60Wyxw1NJrmiuDp7JNU1mE3d6qEbigfR/3cS
	HIrh43WmKUB3BtY7p8AZtkyWPQb6Gas++4XCoORlL9AjM7HD14E3E1IBAgSy8+zFk1nKdzSSY8P
	sBQRlzbEGxwHa0inav6YpJKPQeIsnPsRvmPj9LFV0pGTl0Mc0cZSMha1CzUL1Iiw1XzH55kgcO0
	9pM+KmZqeEWnoC8krAm3n4haoww4FbKG1Rw
X-Received: by 2002:a05:6a00:244a:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-872369ec1c8mr829313b3a.2.1789519047717;
        Tue, 15 Sep 2026 17:37:27 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-871febde2f7sm317692b3a.6.2026.09.15.17.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 17:37:27 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Sep 2026 09:38:37 +0900
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, anisa.su887@gmail.com,
	benjamin.cheatham@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqnlDSdofHDUNdiT@cxlqual>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>

On Sat, Sep 12, 2026 at 03:08:15PM +0530, Shaikh Kamaluddin wrote:
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
Reviewed-by: Anisa Su <anisa.su@samsung.com>
> ---
> Changes in V2:
> - Emphasize that returning IRQ_NONE enables generic spurious-interrupt
>   detection and drop the Fixes tag. (Jonathan Cameron)
> - Check whether the event interrupt is already disabled by Anisa Su's
>   patch; no code changes were needed. (Ben Cheatham)

One thing I want to correct: The change requested was to say a
spurious IRQ will eventually be disabled in the commit message, not
check whether the event interrupts is already disabled...
See https://lore.kernel.org/linux-cxl/aqLZP3ORYzCLfSgR@acer-nitro-anv15-41/T/#m32c74ebf05eee9a3ee49c57dd24848db29919031
I do see that it's been added to the commit message though, so no need
to do anything.

Thanks,
Anisa
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
> -- 
> 2.43.0
> 
