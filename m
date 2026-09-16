Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87F377558
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567940; cv=none; b=R0fIA/au/utyl0NkAYVnvRsDjBP2p/v/toCk8084XEuJsylG9s6Sg4Zdw9+nJABlSVDCgkB3VOlZJ/uF0G4h/t3ii3fJa4TFwSXh8eKsAV9xJ1v21ti6X2dXROUy8YWwMr7NgzFBWaFo/Iq3MsadM6XN6nFpwbuwIJl0ZnjoUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567940; c=relaxed/simple;
	bh=Bz9SWBLA/1RUN89ZB/1c7INvPOzJTqABef8L2hV1+9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV2JcJ7EOE/T3hRo+OE+yuQKl6fUYmaV+gWZU40Kf1P9oqQV+iZHHnetd9krfdEJ2/C5nRzVPmI0WvIixsbc4dHb7GvhshDv/wFp99mpWBpp7Em0ZwBZiocxoHv+Tl57wojvr53LTWJP2oJ1K4jarhr/lLk1DE/r7XGzWCbYy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/YurIq2; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/YurIq2"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910531ea7feso8890886d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789567938; x=1790172738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgJdcm+eEONTUrvoohdyqwlV+G7FBK9fgCXEE2k/YEU=;
        b=C/YurIq2G082WWILuhgO0wffWiWvBJvqSEhSmBAXro4md/JPsFJpyqJNfm9+/SDghf
         Q2wBzdFs1MCt/Xmw7Sw9IFS10iWsPHlouJejzlhxdlffK89TJPezgQI8IirhVuf9T7UC
         zHzHT2JbFT9vFve2PnRZmKpeZOeJVmYjKqBTBTq8Vt7idFBBcreAExue3ZvEcIJq0lN0
         uby0o9cqiD3nDgmCnmq1wodV5m+o4Jy+Y6J3powtLhj8ROQTguIPy8iVFnrdNdUTzD0/
         8oFnNGZSlWhwrWg5sBMAiZCqgnPHfaEWl/7iA/Jfc7UtMdNaCTw6JaTGDHK96xqOrzAH
         U8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567938; x=1790172738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qgJdcm+eEONTUrvoohdyqwlV+G7FBK9fgCXEE2k/YEU=;
        b=Vg+PzhGbYy+Njl70A3/0WTfR48Z6Fn8XJAW/eLvZPLZT+J0Aci8nRCEYDk+NwCe3a/
         gSU3UTyoU0tjnpTTLNqca+oNR48MKywHA0H8Y2JbrWzQWOMSWUA9jaCD+tCsRRyI/d99
         jOi2Pf7GpCuGqBjBEMX+X2AFWXt9oLDvcI+GEd4+9zf8a5ZGzNy3YSzvg7u321w1Ub2R
         WywgLzsXz4oDMK4qURMHfQn27YqcexOvnuRkgAOC9sF4VJH1yOD3h3mTiDoNxuwIpGkU
         JmtkLkDhEnScEm7MIXJYgc02icgNLP5H5pyjxnVlUumeTOMgOTJmuqIKPIM6+BtunHyM
         sjYw==
X-Gm-Message-State: AFuF++mbOKsIYM3Nji1/nT6iANdX/2OM6lstITBsHYOA7netfpf7qP1z
	QzdtPaECglsLMPfBEWC9kTvUPNljh8DUSWWcx5j386TW+a9PzevbMZ/0
X-Gm-Gg: AYBFou3OndT1dTmT+KgHX5TeYKlXw/CjHUGLVYR1EgwvezwvUMnubCFMmjpz2cIpPqa
	SBFS6ZxE80Tazv2S18FUmGMhie9YSheB3Dr4UC9MAE30tOxNeuYBtofFO54mEfD9vIeE6dCl5Ll
	quui4JQif0VEXtf5qiBVKk8eWA+PIhgLo7wnS7xE9XgqDFCHDoy0lmLWAgRP3sWCl8baxEymQhQ
	EHfkFthYAUi0H4awBkb1g7aFBxFX3zb6E3lgZNp6JG2eo2qbUj7fBtr+H/dWriZLckotaCDgNmb
	PH2zswLF9nErMo0Ybjf7zvbmbbyncODrJy9w+CFbuwpNyrVCmD//vg02y/+cBfuZwEm2aq7NN5J
	hgtMjr9rDZ/RAZtmxaU7dtgy31j0qL1LlqecCxw/CTiR2FzkBXJTbnpB3kgu37Jz3RIgVN5/eX5
	kafbSwhB1nk4PGYyFcFW2ledVNws96mUrCJlp0vUTCZ7hLWWrX/nUbR0caQ81ksuqwl1vMmBzu7
	g==
X-Received: by 2002:a05:620a:172a:b0:93b:6f87:ff60 with SMTP id af79cd13be357-93bb7774174mr417814385a.14.1789567932952;
        Wed, 16 Sep 2026 07:12:12 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d18e5asm229043985a.44.2026.09.16.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:12:10 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:42:08 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqqjuLNtbROumYj_@acer-nitro-anv15-41>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
 <20260912094807.65E461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912094807.65E461F000FF@smtp.kernel.org>

On Sat, Sep 12, 2026 at 09:48:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The threaded IRQ handler `cxl_event_thread()` can enter an infinite loop if mailbox commands fail to clear event records on the device, or if a PCIe surprise removal causes the MMIO read to persistently return all 1s (~0U).
> - [High] The driver blindly trusts the `record_count` and `count` fields returned by the device in mailbox payloads, leading to out-of-bounds kernel memory reads and potential information leaks.
> --
> 
> commit 659b756fc25aa4e783ce4a882044a537d7b5d643
> Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> 
> cxl/events: Return IRQ_NONE when no event is pending
> 
> This patch tracks whether the CXL event handler claimed the interrupt and
> returns IRQ_NONE when no supported event is detected. This allows the generic
> spurious-interrupt detector to identify and disable the affected IRQ during
> interrupt storms where no handler claims the event.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index c7c91e8dc51dc..8b560cae91f2e 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> [ ... ]
> > @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  	struct cxl_dev_id *dev_id = id;
> >  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > +	bool handled = false;
> >  	u32 status;
> >  
> >  	do {
> >  		/*
> >  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> >  		 * ignore the reserved upper 32 bits
> >  		 */
> >  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> >  		/* Ignore logs unknown to the driver */
> >  		status &= CXLDEV_EVENT_STATUS_ALL;
> >  		if (!status)
> >  			break;
> 
> [Severity: High]
> This is a pre-existing issue, but can this loop become infinite if a PCIe
> surprise removal or fatal device error occurs?
> 
> If readl() returns all 1s (~0U), status & CXLDEV_EVENT_STATUS_ALL will
> still evaluate to a non-zero value, passing the if (!status) check. The
> handler will then call into cxl_mem_get_event_records() where mailbox
> commands will fail on the removed device, exiting without clearing the
> hardware event status.
> 
> Since status is never cleared and the error handling doesn't break the
> loop, this evaluates to true at the while (status) condition and repeats
> indefinitely. Does this IRQF_ONESHOT threaded handler need to check for ~0U
> to avoid monopolizing a CPU and preventing device teardown during hotplug
> removal?
> 
> > +
> > +		handled = true;
> >  		cxl_mem_get_event_records(mds, status);
>

On the drain loop: Jonathan already responded to the same report on v1 — surprise removal isn't supported today, so there's no evidence this is reachable in practice. 
link : https://lore.kernel.org/linux-cxl/20260907194400.17bb5f5c@jic23-huawei/

Li Ming and Davidlohr made the same point on Anisa Su's series: the Event Status register is device-owned and the spec requires the device to clear it, so a device that doesn't is a firmware bug, not something the driver should work around.


> [Severity: High]
> This isn't a bug introduced by this patch, but does this code blindly trust
> the record_count returned by the device hardware?
> 
> When cxl_mem_get_event_records() calls into cxl_mem_get_records_log(), the
> driver reads the count directly from the untrusted payload:
> 
> drivers/cxl/core/mbox.c:cxl_mem_get_records_log() {
>     ...
>     nr_rec = le16_to_cpu(payload->record_count);
>     ...
>     for (i = 0; i < nr_rec; i++)
>         __cxl_event_trace_record(cxlmd, type, &payload->records[i]);
>     ...
> }
> 
> If a compromised or malicious CXL device returns an artificially large
> record_count, could this read out-of-bounds kernel memory and leak it to
> userspace via tracing? 
> 

Valid, and not introduced here -- different file, different Fixes: tag, so
I'm not folding it into this patch.

record_count comes from the device and records[] lives in mds->event.buf,
which is sized at probe. Nothing checks one against the other, so a bad
count walks off the end of the buffer.

> The same pattern appears in cxl_clear_event_record() and
> cxl_mem_get_poison(), where the untrusted count is used as a loop bound.
> Should the payload size be validated against mbox_cmd.size_out or the
> maximum allocated buffer size before iterating?
> 
> >  		cond_resched();
> >  	} while (status);
> >  
> > -	return IRQ_HANDLED;
> > +	return handled ? IRQ_HANDLED : IRQ_NONE;
> >  }
>

These are pre-existing issues and independent of the IRQ_NONE versus
IRQ_HANDLED change in this patch.

Anisa is already taking care of these checks in her upcoming patch series, 
so this can be handled there.

Anisa's patch link: https://lore.kernel.org/linux-cxl/20260901002912.958-3-anisa.su@samsung.com/


> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912093815.14455-1-shaikhkamal2012@gmail.com?part=1
