Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899151E45C
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569043; cv=none; b=pBw6bX83PE9OCiR2BzQA3fs4L0kaY9lnOB6trXxtjqUHYwMvtRulCEPGJMp9ADAl45yIFWxAyMdGTdRI/2OZ7i3szgcVjBgr/gXyFzcjuCbdArcYj2C2VChA8e9FOUdqQJ3eJ+LGli5afkNfvLL6mfLUp9Azmdq4sZ0D+i5wwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569043; c=relaxed/simple;
	bh=n50EDLBpp0PcLVpFQaOjQv7TAzbBAn/fBTN5CuZ51Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGkcXa1lSgmrGT90m1A5fVmkamqQ9LU6WumWxaczGvqaQFtGllsaPY4GrfsGLahJxTlFT8ptV2WiMnSn6TQivlB+U5XbwlFwP0onLifM6SebwS1A93QFHl8TS/KzOqAF1LKQRcBb1AT8xq+S3KeDSYa0a1gFDxx2JIiGgNuzyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egE/5NQz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egE/5NQz"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so11245155ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789569040; x=1790173840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vAIxdcn+2euFFjhYmCcfT0OwZlA6a1v07ZRE8SeJ058=;
        b=egE/5NQz07o8f6MlS/eWFB13irJak2X01K20lnHxBmmobkH2i3Doz6rTLAsAHwNre0
         12VNT8cs2NCcv9rGWNhxnU9QuJFVfJc6mCtEwKzwRf69CWZvvzIQodSHv9I7OWlwcW2E
         PJ5OFvmHVcCtC/jpZDB3jRvtfS1CG63Ms6VdqWx/2ABi/+aPcOkxd9T2S4Z+RFr1gwrQ
         kGVpx+hAhTnmxXSN7Nls0p41n0MGFA6N4vhKaQJH2Spprl4zIjc0f9CPsiYg67AfAGfD
         LsZ7NJkHVMepyOVVjen2fTaa4//m9H27PVOjwDUIgAA3q/blKVskdc1JPM23ztBfaVfl
         YDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569040; x=1790173840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vAIxdcn+2euFFjhYmCcfT0OwZlA6a1v07ZRE8SeJ058=;
        b=XFFULsdmvSHRgEol6gx1Vh8f4l3jDbhHqDkylZEd/1826kVlqWK/Qpee5HGRu2D6k/
         962pd6Rq59TrQ0GQK5IgVl+wm4+gEcVW65NFLc8dLoo8pmjM8LX6o2urq9WAG9kd01bC
         lP6H3E0De1ZCbGSOXsMbjIckNlyDggaDennP8cd4hEA0tr/NO8MsAI6fqcXwIyKcZ6t2
         JgLa7KyKh/9PbYf8ut+Lsbs786Etsi9omFQeldI5oAOEgUsFL6oDJ4N7uFyq1x6MQw9k
         t0+md3wzZhLJgCpH3SXNdct1AFxy36OPC0S/5/G1nohqsPr7KpDLfvFA5QC6hjllVp3S
         zePw==
X-Forwarded-Encrypted: i=1; AKwUvBwrvYXqfRJa+t2Ed9sIXwQ7xcR6UVNj9dvE6aLdSdda8mE8s0Cnudq0tPeOPTckVayNrDRhsZsYYxc=@vger.kernel.org
X-Gm-Message-State: AFuF++nToFVFeLVSfNltVc6rYW864j6//LWL6e9/Yt4J48eMbPWW7URN
	PiSjR1JbJ2GTShgpxt0mNT1xr6l1WY9C5WubaeEAQJZZcOKTbkPdfIDp
X-Gm-Gg: AYBFou1PFpJCslfyyjNFUeL7IzZJsU0cd6Pwq9TMVzryuhClud52pgsbE+OEU6lLySI
	5/u5fmKUMfuBrjHsDBa8KXdXP8h3Vxk1ZRCO9yH2KXh0D9H5UPo9I2BXsSMnU8WVvtQrHbELkXi
	l0fQSFwj5MHRU52Z0Y1sZ41Sdpu1ZIajj58KsFDaI7UWuaAEdvNcDpLf+fti64WzsXMz8CK10YO
	hVBV/yhg4h1u2zWtgWmbeJK6F9VA1DaAQetESetZOTv62O9BMriiaqfoCrjkiDbP1UYTfcNKsxy
	Bp///rBFBLOpWN/R7Ogp36AaLghcl3+orHYfHVIqHgJAd2/Pmmehj02KUE5U9cGsnFTC2GwjP36
	0Jy+XlAOHI4fuK0bd13BbW0L8uzTwuk+T/lVZKWsDKvKWsghaFI0aC15j7AQCkFAjBUGJi629f5
	P8UQQqXVR4Wzu4k2mvL8/41qR73XTkjgVbwB8CI4nXpSkMX6yJVkPuxAcYF9QHV+x6kPujeWS0W
	A==
X-Received: by 2002:a17:90a:1c97:b0:39e:1fb6:9659 with SMTP id 98e67ed59e1d1-39e1fb6994cmr4255054a91.22.1789569039499;
        Wed, 16 Sep 2026 07:30:39 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab51c2csm1747149a12.7.2026.09.16.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:30:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 20:00:36 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqqoDPmG9lfDNAwc@acer-nitro-anv15-41>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
 <aqnlDSdofHDUNdiT@cxlqual>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqnlDSdofHDUNdiT@cxlqual>

On Wed, Sep 16, 2026 at 09:38:37AM +0900, Anisa Su wrote:
> On Sat, Sep 12, 2026 at 03:08:15PM +0530, Shaikh Kamaluddin wrote:
> > CXL event interrupts may share an MSI/MSI-X vector with other event
> > logs or device features. Consequently, cxl_event_thread() is registered
> > with IRQF_SHARED and must determine whether the event-log facility
> > claimed the interrupt.
> > 
> > The handler masks the Device Event Status register to the event logs
> > supported by the driver. However, when no supported status bit is set,
> > it exits the processing loop and still returns IRQ_HANDLED. This
> > incorrectly reports that the interrupt was claimed and prevents the
> > generic spurious-interrupt detector from accounting it as unhandled.
> > 
> > Track whether the CXL event handler claimed the interrupt and return
> > IRQ_NONE when no supported event is detected. If no handler sharing the
> > vector claims a sustained interrupt storm, the generic spurious-
> > interrupt detector can eventually identify and disable the affected
> > IRQ.
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Reviewed-by: Anisa Su <anisa.su@samsung.com>
> > ---
> > Changes in V2:
> > - Emphasize that returning IRQ_NONE enables generic spurious-interrupt
> >   detection and drop the Fixes tag. (Jonathan Cameron)
> > - Check whether the event interrupt is already disabled by Anisa Su's
> >   patch; no code changes were needed. (Ben Cheatham)
> 
> One thing I want to correct: The change requested was to say a
> spurious IRQ will eventually be disabled in the commit message, not
> check whether the event interrupts is already disabled...
> See https://lore.kernel.org/linux-cxl/aqLZP3ORYzCLfSgR@acer-nitro-anv15-41/T/#m32c74ebf05eee9a3ee49c57dd24848db29919031
> I do see that it's been added to the commit message though, so no need
> to do anything.
>

Hi Anisa,

I got your point, yes commit message already covered this.

Thanks,
Shaikh 

> Thanks,
> Anisa
> > - Rebase onto v7.3-rc2; no code changes.
> > 
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
> > base-commit: df2908090cda368b01ff43709f51890076c56157
> > -- 
> > 2.43.0
> > 
