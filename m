Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9833577E45
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972955; cv=none; b=DVbBU+2T5v2uyBtS2s98ILKKb+Qmf9Mumqo7u6YjaFmkmZuWreZ80PejXSbK23rVqgs2C9DML1hgqSw5FpRhUYwZ9i8vAeELghl6H1yxccjXuX7ccw7lPPjMfH72giSEqTlHB2aKHCxxC+dlduZSG9hRxcClN8j1YIkuTIAtZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972955; c=relaxed/simple;
	bh=k4qWvxF7I4uhFfChz4175EV48qU08vb3lzzxocbanjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqKqF3PtbrFDpjcBv00jswrgdA0nOQT55oIuVQOuzhuwgQ4260ctybfG0KT8g912xbSbQQaxCEHEPsu8eZ1F3gWf0co1gjdgJfGyYMQq2h3eMtjTnr8VEPg5RuO6iCQB1bVw3UnIU00T6HXP9IyCK4l16D3tywaLeOwHMeUq0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MctDcv6w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MctDcv6w"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-86908cbc011so843445b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 09 Sep 2026 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788972953; x=1789577753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKPKuLF+daHDpmVC/XN4VLVpTXajVY+JPjJcyGS1ryU=;
        b=MctDcv6wmwQekhn2R+xsxnUtQ/NVlNNhrMZwT+Ens8ch1PRs/Xr5B9IQtPRpei+vSj
         OwApJ7MW9T8KF+l53nwJlZQ7Y75N/mW9cbriglmcg/o9e+QpifB39tJbZd+BCEDCyOXe
         CsZCA/peQweDfll2AnUd1yVTaxJjkHTIuhps8+psTJznLCElbn/DC52G+OsjXH4SnoEa
         1up3yzOoOr7st6xOByKBWAH0ABnRoVgVLu9xEd2ShrS9/iRl+OBCOt300vIrif+xeLrh
         cQMwVR9/fVBF0Rr9z+BaaM8ly+KEa5g4dDTqyS+n0ET9fCPibbs7oIU2J/JabGr7q6tN
         f4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788972953; x=1789577753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKPKuLF+daHDpmVC/XN4VLVpTXajVY+JPjJcyGS1ryU=;
        b=IkVEOpwGXOCK2Grs7tkIT3Q/9bLsXWVWo+SxGQziU4cLukeh4743iQm83cH0kqzhRi
         G3eMxytpmulyfz8R971CTEj/eBZ1Oio4P5O63cGkMeT2Cvndqq/Eg+CR5+bjdb0/awRA
         0TFBVMaZ6EBXunS2IiZ7W4cj+fqu4VUtmNlO3AiobnpNjFk3XXrr9ybyyHL3iMu0Swk+
         RvfvUjdOhyGDpFneS8niV3a4/rEWazB89cFa3VBRJQmvpvucW+TC8agVoPFd3virvyVS
         nNf78CXUkdrDe88o7mTNBIXr168wDEet+iIhS7JMiaiSGmuLCykgl3C8huItBh5izev9
         aevw==
X-Forwarded-Encrypted: i=1; AKwUvBwuxTQ6xHs0HDCxChWFrpNRoOcJV2zDFv3id31JSCose5CFWM0Ei5uY3gsEU8E7Na/wmo8z5eceDjg=@vger.kernel.org
X-Gm-Message-State: AFuF++mgJ6xnhf7nBLf4jaXDzw4sCJsVUIaXZsuThXdnwQAbYEwQZoBt
	0WyaHJuvYnYYN4Ov2nzEB+c2/06O8yalKx1vIxVknRKFeeSaQ6O/JCOp
X-Gm-Gg: AYBFou1meGbDZxJ7xVOuvjC0z8mZjw0gEwNdZRWE4gU0VaeiJm49vP/7ZTloJmhg+Bi
	T9eH0+7P5GXjrO6dVbhSks4kHl8qJV0jdJNV4M4o3U4SrHQNsa15Z3lvyogdkekKQZA0vq+J0Xm
	dhzLtS+fmCatZE3hrpybfEUTodkxQHED7RC95mNkv4BpIsbNGCWvjfvQyMh10i/4pEDbRSkC9Wm
	4uOv156w8k6JcbZ265xBpWveChpu62AkQD5Np4JDHR8bgF9TZDQwGcAyQPEZWzZSxoYigPlNbR2
	a3amsVsfX8CBs5y56/nAZdZVbODZin2UT/OmcgG+sYRy4cgFSja4qzzXAdUoJFS9W2XPxnNPxYd
	EvE1QvszED28J80OXGMjJzT1O+jGBUGJZAeLhcAuAA9A0BkEGOK20Yhw9K/19p2LfFJAWwB1oRf
	MJhojXaU/icZ3Y3GieDq34j7a8SYh5mF61PUNe/onEqVai+zCxoPXColXUowKVefXNcuMurBIE
X-Received: by 2002:a05:6a00:3693:b0:857:726d:270b with SMTP id d2e1a72fcca58-8616d53bad3mr52548995b3a.23.1788972952777;
        Wed, 09 Sep 2026 09:55:52 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86154048df2sm7345063b3a.61.2026.09.09.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:55:52 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:25:50 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqGPliCzr8lS64K7@acer-nitro-anv15-41>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
 <aqBSUSJWVA8JfCvX@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqBSUSJWVA8JfCvX@4470NRD-ASU.ssi.samsung.com>

On Tue, Sep 08, 2026 at 11:22:09AM -0700, Anisa Su wrote:
> On Sun, Sep 06, 2026 at 09:27:05PM +0530, Shaikh Kamaluddin wrote:
> > CXL event interrupts may share an MSI/MSI-X vector with other event
> > logs or device features. Consequently, cxl_event_thread() is registered
> > with IRQF_SHARED and must determine whether an interrupt belongs to the
> > event-log facility.
> > 
> > The handler masks the Device Event Status register to the event logs
> > supported by the driver. However, when no supported status bit is set,
> > it exits the processing loop and still returns IRQ_HANDLED.
> > 
> > Track whether at least one supported event status bit was observed.
> > Return IRQ_NONE when there was no event to service, while continuing to
> > return IRQ_HANDLED after processing one or more event logs.
> > 
> > Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Hello,
> 
> This looks similar to a patch I sent last week:
> [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were processed
> https://lore.kernel.org/linux-cxl/8e22c1c2-8098-492a-8162-3dd27507c853@amd.com/T/#ma4cf2b2dddaeebc06cb73f81647817bdbb51963c
> 
> It was dropped because I received the feedback that in general, the driver does
> not need to handle device-side errors/spec-violating behaviors. I believe it
> would apply here as well. But if I misunderstood the intent of this patch,
> let me know.
>

Hi Anisa,

Thanks for pointing this out. I came across your v2 patch 4 only after I
had sent my patch.

Your patch 4 is based on the preceding robustness changes in the series.
By that point, cxl_event_thread() has been changed from the original
do-while loop to a while (mask) loop, and
cxl_mem_get_event_records() reports both an error return and the set of
drained logs. The handler also uses the drained and stuck masks to
control further retries.

My patch leaves the existing event-record retrieval and do-while loop
unchanged. It only tracks whether a supported event-status bit was
observed and uses that information to select IRQ_HANDLED or IRQ_NONE.
It therefore does not change the handling of mailbox errors, undrained
logs, or retry behavior.

The handled tracking in both cases addresses the same zero-status
shared-vector case. My motivation was its effect on generic IRQ
spurious-interrupt detection. Jonathan agreed that this is a cleanup
rather than an interrupt-loss fix, so the Fixes tag should be dropped.

Since your patch was posted first, would you like to repost the IRQ
return change as a standalone cleanup? If so, I am happy to step back.
If you no longer plan to pursue it, I can continue with a v2
incorporating the review feedback.

Please let me know which you prefer.

Thanks,
Shaikh




> Thanks,
> Anisa
> > ---
> >  drivers/cxl/pci.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index c7c91e8dc51d..8b560cae91f2 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  	struct cxl_dev_id *dev_id = id;
> >  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > +	bool handled = false;
> >  	u32 status;
> >  
> >  	do {
> > @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  		status &= CXLDEV_EVENT_STATUS_ALL;
> >  		if (!status)
> >  			break;
> > +
> > +		handled = true;
> >  		cxl_mem_get_event_records(mds, status);
> >  		cond_resched();
> >  	} while (status);
> >  
> > -	return IRQ_HANDLED;
> > +	return handled ? IRQ_HANDLED : IRQ_NONE;
> >  }
> >  
> >  static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
> > prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77
> > -- 
> > 2.43.0
> > 
