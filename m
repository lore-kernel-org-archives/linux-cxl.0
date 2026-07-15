Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835A377A91
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156956; cv=none; b=gDHKL869u+zLdVnJQ9Yj9W2ZogzpVgfoXJP53t/Q76jhvaBtpqHE4TSQNjLsih843kq+nDR9MCahz8YbJN7lNexoxWMxpS3JdOHL7gXnNzNAcogjzUsOoyX4ADmjt+NzEdsXneOBJrFmYEbEN3kd4E1HMaUnIzeHTrs2niUk6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156956; c=relaxed/simple;
	bh=0NFG4Ww2jSroHmWiUivePZxK2XpVdq/qHaQxr1Q7fsY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glsSiWQVERXFUJHU4vXjcA/SxI4MMevrbRgltyR21nlEA9sTdTJOwp/+kmtNg+HXIZYF0zgcN0D/8eLyr7PCxitWoPQj4EIWhGzTIu/N+dDPNPNxN4mijQpEzwo4BQE0IJzHPvfgE1RdHLZBL0DmQIkrsX+h6H44W5cWLI0fx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6BcM9yV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6BcM9yV"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3937737a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784156954; x=1784761754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElxrIYjyBDIOHQflkE/kwut9Q3GwTe8Bx9Dw1cR1MdI=;
        b=S6BcM9yVZZPW/o2jIiQqq4HNSZS0ao4xD7bKyZ899nw08kKiZ+3IR7XheEXy/+FyC8
         V+/pp39i4HkNx/tKyhXa70EfKinYjICHtJmDn1IwbOVSx+mFuthv7CaO9IoMG0ChYRwf
         445fi2ihr4TuOdCEpnD/tzW0ZxJKeJ7SZrNNS3paoRb90Ll+S+MoaHHQWvk91VVgZZ/a
         ULcYh42wIDrUKVCBBKJwdTBTUsyS/4YhA+JvuW2KZHaYQQGYRTlXgrzM0v9oXR4eSX8V
         Lo+D25Ca4HCzcExObQ0o/9krHFkLxz0yfMLtzii4miYA4bX5IxRCMVO/OSW+zZlCXQCH
         VHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784156954; x=1784761754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ElxrIYjyBDIOHQflkE/kwut9Q3GwTe8Bx9Dw1cR1MdI=;
        b=bKmRWcfEQ3CBFGBaT+qboOZzcjHa8erjPfYThQoCG6Jso+bw9qg4jwVryEc+ZbQgah
         gMUE5mCcL0FzFhC93IlXNb3xePFHMglvxYSBfhiuLoI9Y9IOPRUHvp3icT25x1cSm0PP
         IooaL2WeeuHvwahagPCV8UGWyJmS3wGAOuvTPc6lSv3ENxkuwKkmwP5mw6IQ9LA9nwik
         9UgBWZIpEZgbeUn5sDKoPToz8Q4xgxsOx/r1hSyRlkzxHszQmugr1S5g0bTIpNUec51c
         ty2QlCTSZK22WhC4LXBg301k7bAlsz+K+NqZ3JRxS1AQFxlCycPIGuv33YwJI+rv5cgg
         llFg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5nQ0/ZlofmJ4xBE1TbJftuhiuHU3TukW5X5OXABD+TTHn12w2kx+oFlcoKgxtRR3IPI3Iv2ipaEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKySgqmMH/WNtKLtjUY3mxk5t7jtQVICyFCIAAT0cXdXY0tN6
	mkwqEcKEroDp+rs6hyePHfiTlubqNo7vvZCfEmztYoVTDOABcBN7MoMC
X-Gm-Gg: AfdE7cnR8n2xXZd4ITkGLf2clzWlgEzebNXfGnde+3WKT2DLnYGGx+m57Ge0APPT8Gf
	TyXfHh2wAheMeHcLC2HiZtGNfubC6XhI0qm0b1aSTnEdmQJiuA/lvFUFkytS5uH75d3c9ibXy7M
	/OsiHApemrncXnrCKiD0jkEmNnSekJ2S8n6g99V2q+W/TfHUy11XKMRIdDOgFBSgriNP1Dw1c1/
	8Bw0MYfaa64rXa95pBMV2XoGv3n+7iSQ4pbLLz5zZg4cMHavPgdRswYFXREmkTuXnQ1XriMJmR/
	bFyV+2XyIjDngmlTKRCIm48h8LsYhBRJ8ar/qFE5qm/QNXTmOSGExNyY4H23fEHy5RWZ9hdeB17
	AcE6MxuPXv1kTmjOI5jxLKnt8m9F/NqubuRNbNonCI8BZvdU37lGi0aP3Pvw3Wbg4Io+VuNOZHU
	5NnGTrr5mDDL4ezvrqwBEnoBTtZfPeAgob+ggryNpmPGrDDTALBRv+QgqvB38I6XTUh2b3
X-Received: by 2002:a17:90b:2dcc:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-38e29facf55mr4440727a91.3.1784156954192;
        Wed, 15 Jul 2026 16:09:14 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e53349dsm5371877eec.7.2026.07.15.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 16:09:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 15 Jul 2026 16:09:12 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v11 10/31] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <algTGPgDuwTUFI_q@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-11-anisa.su@samsung.com>
 <20260625181442.33E561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625181442.33E561F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:14:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] An unhandled DCD event status bit will cause an infinite loop in the `cxl_event_thread` IRQ handler if DCD processing is disabled dynamically.
Fixed

> - [High] The driver fails to perform an initial drain of the DCD event log when the BIOS has control of standard CXL errors (`!native_cxl`), stranding pre-existing events.
Fixed

> --
> 
> commit 4e2d7455b6a9875d8ee530fc91ae3a8b65741caa
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Configure dynamic capacity interrupts
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.  Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8d12c684d6700..95a4bf7c1e466 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> [ ... ]
> > @@ -632,6 +657,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> >  	return 0;
> >  }
> >  
> > +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> > +			struct cxl_event_interrupt_policy *policy,
> > +			bool native_cxl)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	int rc;
> > +
> > +	if (native_cxl) {
> > +		rc = cxl_event_irqsetup(mds, policy);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	if (cxl_dcd_supported(mds)) {
> > +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> > +			cxl_disable_dcd(mds);
> 
> [Severity: High]
> If cxl_event_req_irq() fails here, cxl_disable_dcd() is called, but the
> device is already programmed to generate DCD interrupts.
> 
> When a DCD event interrupt fires, cxl_event_thread() will read the status
> and retain the CXLDEV_EVENT_STATUS_DCD bit because the mask includes it.
> However, cxl_mem_get_event_records() skips draining the log when
> cxl_dcd_supported() is false:
> 
> drivers/cxl/core/mbox.c:cxl_mem_get_event_records() {
>     ...
>     if (cxl_dcd_supported(mds) && (status & CXLDEV_EVENT_STATUS_DCD))
>         cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
>     ...
> }
> 
> Will this cause cxl_event_thread() to spin in an infinite loop since the
> status bit is never cleared by draining the log?
> 

The fix is in cxl_event_thread(). Instead of setting the event drain
mask based only on the value of native_cxl:

mask = host_bridge->native_cxl_error ? CXLDEV_EVENT_STATUS_ALL
                                     : CXLDEV_EVENT_STATUS_DCD;

we additionally check cxl_dcd_supported(), because the native_cxl value
only determines if the standard logs are owned by firmware. DCD event
logs are always OS owned.

So the mask becomes:

u32 mask = 0;

if (host_bridge->native_cxl_error)
        mask |= CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;
if (cxl_dcd_supported(mds))
        mask |= CXLDEV_EVENT_STATUS_DCD;

This gets put in a new helper function cxl_event_drain_mask() because
the second bug below uses it too.

The helper is called from cxl_event_thread():
static irqreturn_t cxl_event_thread(int irq, void *id)
{
	struct cxl_dev_id *dev_id = id;
	struct cxl_dev_state *cxlds = dev_id->cxlds;
	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
	struct pci_host_bridge *host_bridge =
		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
	u32 mask = cxl_event_drain_mask(host_bridge, mds);
...

So if dcd has been disabled afterwards, DCD events are still cleared.

> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> [ ... ]
> > @@ -687,11 +744,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_event_irqsetup(mds, &policy);
> > +	rc = cxl_irqsetup(mds, &policy, native_cxl);
> >  	if (rc)
> >  		return rc;
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	if (native_cxl)
> > +		cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> 
> [Severity: High]
> If the BIOS has control of standard CXL errors (!native_cxl), does this skip
> the initial drain of the DCD event log?
> 
> Since the driver owns the DCD log regardless of native_cxl, it appears that
> pre-existing DCD events might be left in the log, potentially preventing
> subsequent edge-triggered interrupts from firing.
> 

Fixed by calling previous defined helper cxl_event_drain_mask()
which also checks if dcd is enabled.

So if (native_cxl)
	cxl_mem_get_event_records()

is replaced by

status = cxl_event_drain_mask(host_bridge, mds);
if (status)
	cxl_mem_get_event_records(mds, status);

> > +
> > +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> > +		native_cxl ? "OS" : "BIOS",
> > +		cxl_dcd_supported(mds) ? "supported" : "not supported");
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=10
