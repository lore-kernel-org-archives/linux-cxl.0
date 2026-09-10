Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C14D8DB5
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057349; cv=none; b=A/B+tU0TX3LDBCMBUI6xxowUJ7etEto3PQVf0qlAI9UKSDyNrsrvQEWSUFaw3rx1Tga90KXorkpMvWbI9eXZNMW4JnpsBj/HPGzFLD9O4qFg1Ap0xrLGoeZ4+OHH+SdTjlbEtPrjsvnK8J1f3CInpArDTZe0gGiRTdfGKE2a4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057349; c=relaxed/simple;
	bh=p6vQWJN/EafUy/R6o1cCpJ6DDGnl6w2c89vs1ADfHsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6tYWa9kaMg/HGpTAaLiqgYTPfM/NGvSq6wO6Tj5iTqpdzSiG6jrFg1T+zKkJfLWBL911pLniUtVZd0wF+o83KmFkRCx4yvMGoEcTx7GCPB+fdN6fcnELxuPk4OvvaEKzf1S63T3OToDG+xSw1mMuyC/uGABPEmGnxjsfCtPusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD0j5e5I; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD0j5e5I"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1462404a91.0
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057345; x=1789662145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GIfJU6IVX6KOUqYIRa0zO66YeE92f7Q/x1to1Dv5ucw=;
        b=mD0j5e5I2waKrdpuGGKWBBGUU4+Sw8v/B94BEhAd5KAAjH5dOaXUSnkEw2UCkhu87w
         R8cY/iKKTLVDqzdZZnBwLPgF9h2bfl6cEuzxDlII6fjQ60VvEIPqIFfgJHlTLiV7cjlD
         7lTZ8BtRIV+Lkuf0LDy4SibXzrpEsnoCmuTdpCaITEQ/JQZy58JyOumWTIb+IP8XAUXu
         nmO6aDCiJFCi6xOPLbJXAeAfgV28xUWc4mRoFBcVrmtnkr3l9jeQE7DGxwYZ6Oaf9kPW
         JofdpdKyfsW4+ENxFkm9hVXtAeUnldVIaibI3oC3GLJWdSlpVAWiHUFiY6sls4PxDTv9
         OnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057345; x=1789662145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIfJU6IVX6KOUqYIRa0zO66YeE92f7Q/x1to1Dv5ucw=;
        b=HiFjWUKFoWPems7oeTK04hM64hMMcXxVdWab8Xrc8LVekUcGG2EinMwjGynvGUmUnT
         rAwPQV2O78rP2MD+FHOtYbLBxRwwcw0nEaQEe+mDy7ZaKFkMTHwGlspEI7xHv4gU/vj/
         5ub85K5uik3nOIxn2m2Acz2CdyfXfNVbPP2mqoAS27aNkN3eLzNcUet4UCMiIoh/9wao
         u8IX3I42nV9T2PQ9nq5jSaTcvxjLR6m1Jg5oFfOC+7/0dFmv5ZM2iwdmNd0e+lWC5WcH
         q2FgRkOyxWi3Ltt68NcT0D/by5ult2S2zlPYQnpdM1FO9vcHFnlQ9NMe0F3KzAhIfY3s
         42ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwYEHDYXaNlEcjeIUh977U/AuHmxUFVTa8JlbsAysxRZg44RP80uFm4DLgnxdJs4dBdLgREG3Rn2EE=@vger.kernel.org
X-Gm-Message-State: AFuF++ni5S1qEtcYnbOGx/dC+Ei92kPZi65VAjEJFm2/Bl8pRgdEp+K0
	LGXi1yImNEe6LnR4FSZMotM81mRPYojugTQC+YlxG7iRzN0d6KpSEx/z
X-Gm-Gg: AYBFou3mVvrjTsMrawio82JYUgkfGCr1wIBy0RUubXmfmNjtyXFwQ+XMMmZtL7LtJH/
	2J9vf0+GKWM3nXAvTbhr7QHXjv8LxMjXroeG7T5cNmHPJZRp8BEu5c3Mz2EIuhbYD/96HCw9ydJ
	lOi3EqyGsC9GUViVY9TWTWuHq03lpSamDFlh7gGUhkV+aVAWhu6UnqlyTlR40ielPf+P+8firwJ
	IZEOEcEEjo0JX3EG6nTduMPOQ6I8yITcrGKVh0q532EH8PiqppEUaddCNaZVXivKzSpcf4EtQSd
	6vrWiA4U3ClxECbmnLSduGsNssQ31vplAdHyc4HxYIpnqmyf5h2s7+Tcmr9Kb9WGQKRoMD19rlF
	K7th2BeGNhWuCRRctpVtyZr/rNaI0I2OPRldx9OE0nqXXm6jR2pIXhBl3ZxFQKsqBBwCaw8y4Lc
	u5eebG837XMVx1x16k6vzmqqzQ/Skv/2MkXtY6vSpyd7uTLeewRtglQsol23EeafJkT62QENly+
	w==
X-Received: by 2002:a17:90b:3c50:b0:399:ea1:5a82 with SMTP id 98e67ed59e1d1-39d7097c59amr11970586a91.3.1789057345300;
        Thu, 10 Sep 2026 09:22:25 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94b937ebsm361707a91.1.2026.09.10.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:22:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:52:23 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su887@gmail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqLZP3ORYzCLfSgR@acer-nitro-anv15-41>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
 <aqBSUSJWVA8JfCvX@4470NRD-ASU.ssi.samsung.com>
 <aqGPliCzr8lS64K7@acer-nitro-anv15-41>
 <aqGo7Rtb00mgS1lH@cxlqual>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqGo7Rtb00mgS1lH@cxlqual>

On Thu, Sep 10, 2026 at 03:43:57AM +0900, Anisa Su wrote:
> On Wed, Sep 09, 2026 at 10:25:50PM +0530, Shaikh Kamaluddin wrote:
> > On Tue, Sep 08, 2026 at 11:22:09AM -0700, Anisa Su wrote:
> > > On Sun, Sep 06, 2026 at 09:27:05PM +0530, Shaikh Kamaluddin wrote:
> > > > CXL event interrupts may share an MSI/MSI-X vector with other event
> > > > logs or device features. Consequently, cxl_event_thread() is registered
> > > > with IRQF_SHARED and must determine whether an interrupt belongs to the
> > > > event-log facility.
> > > > 
> > > > The handler masks the Device Event Status register to the event logs
> > > > supported by the driver. However, when no supported status bit is set,
> > > > it exits the processing loop and still returns IRQ_HANDLED.
> > > > 
> > > > Track whether at least one supported event status bit was observed.
> > > > Return IRQ_NONE when there was no event to service, while continuing to
> > > > return IRQ_HANDLED after processing one or more event logs.
> > > > 
> > > > Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> > > > 
> > > > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > > Hello,
> > > 
> > > This looks similar to a patch I sent last week:
> > > [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were processed
> > > https://lore.kernel.org/linux-cxl/8e22c1c2-8098-492a-8162-3dd27507c853@amd.com/T/#ma4cf2b2dddaeebc06cb73f81647817bdbb51963c
> > > 
> > > It was dropped because I received the feedback that in general, the driver does
> > > not need to handle device-side errors/spec-violating behaviors. I believe it
> > > would apply here as well. But if I misunderstood the intent of this patch,
> > > let me know.
> > >
> > 
> > Hi Anisa,
> > 
> > Thanks for pointing this out. I came across your v2 patch 4 only after I
> > had sent my patch.
> > 
> > Your patch 4 is based on the preceding robustness changes in the series.
> > By that point, cxl_event_thread() has been changed from the original
> > do-while loop to a while (mask) loop, and
> > cxl_mem_get_event_records() reports both an error return and the set of
> > drained logs. The handler also uses the drained and stuck masks to
> > control further retries.
> > 
> > My patch leaves the existing event-record retrieval and do-while loop
> > unchanged. It only tracks whether a supported event-status bit was
> > observed and uses that information to select IRQ_HANDLED or IRQ_NONE.
> > It therefore does not change the handling of mailbox errors, undrained
> > logs, or retry behavior.
> > 
> > The handled tracking in both cases addresses the same zero-status
> > shared-vector case. My motivation was its effect on generic IRQ
> > spurious-interrupt detection. Jonathan agreed that this is a cleanup
> > rather than an interrupt-loss fix, so the Fixes tag should be dropped.
> > 
> > Since your patch was posted first, would you like to repost the IRQ
> > return change as a standalone cleanup? If so, I am happy to step back.
> > If you no longer plan to pursue it, I can continue with a v2
> > incorporating the review feedback.
> > 
> > Please let me know which you prefer.
> > 
> Hello Shaikh,
> 
> Thank you for your clarification. Please feel free to continue with v2.
> Can you add me to the CC list for v2? I am working on some prepatory
> patches for DCD an there would be a minor conflict with this patch,
> so I will need to rebase on your changes.
>

Hi Anisa,

Thank you for offering the handoff. Since you posted this change first,
I appreciate you allowing me to carry the standalone cleanup forward. I
will keep you in the Cc list for v2, so you can track the final change
and rebase your DCD preparation patches accordingly.


> Also Ben Cheatham gave the feedback to mention that "MSI will eventually
> be disabled" as a consequence of this patch in the commit message on my patch,
> which I think may be valuable here as well:
> https://lore.kernel.org/linux-cxl/20260901002912.958-1-anisa.su@samsung.com/T/#m866a4fdb159553039d8d47b6ee7f2312caa9ed73
> 

Hi Ben,

Thank you for the feedback on Anisa's earlier Patch. I will update the
commit message to describe the consequence more clearly. When the CXL
evnet thread returns IRQ_NONE, irq_thread_fn() does not increment
desc->threads_handled. On a subsequent interrupt, note_interrupt()
observes that the counter didn't change and accounts the previous
interrupt as unhandled.If more than 99,900 interrupts in its 100,000
interrupt detection window are unhandled, the generic IRQ code calls
irq_disable() and disables the affected MSI/MSI-X vector.

Thanks,
Shaikh 

> Thanks,
> Anisa
> 


> > Thanks,
> > Shaikh
> > 
> > 
> > 
> > 
> > > Thanks,
> > > Anisa
> > > > ---
> > > >  drivers/cxl/pci.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index c7c91e8dc51d..8b560cae91f2 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> > > >  	struct cxl_dev_id *dev_id = id;
> > > >  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> > > >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > > > +	bool handled = false;
> > > >  	u32 status;
> > > >  
> > > >  	do {
> > > > @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> > > >  		status &= CXLDEV_EVENT_STATUS_ALL;
> > > >  		if (!status)
> > > >  			break;
> > > > +
> > > > +		handled = true;
> > > >  		cxl_mem_get_event_records(mds, status);
> > > >  		cond_resched();
> > > >  	} while (status);
> > > >  
> > > > -	return IRQ_HANDLED;
> > > > +	return handled ? IRQ_HANDLED : IRQ_NONE;
> > > >  }
> > > >  
> > > >  static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> > > > 
> > > > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > > > prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
> > > > prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77
> > > > -- 
> > > > 2.43.0
> > > > 
