Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92072415F2D
	for <linux-cxl@vger.kernel.org>; Thu,  6 Aug 2026 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058821; cv=none; b=onxgYMvnXb6lOSuWNzWrFb8uBGyAebvDqlC6YLl7StXnhiC6KHX3prwoEqiTu9kB8SGOHch1/KsTskVGAF3gzE+2Kz6VmFWczLM64kKmZ1xoACg/A90+vT5EMN9M47vBsTJc1WAk34MTen9lELyUgaSSWW2xVcm+vnZrCQCcwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058821; c=relaxed/simple;
	bh=8ernjYW7bovLgY78GoVgutHqXvV1nj4wsCTAcwbRWr4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4TWDxx2SHu56c+R/Il2jCHXgaD5Nwm+Vopfo/WVc0brH8iKTlZXKCdxdaQlBKBZsoT7FfXWsbhcbfyg3p6iAmH0gzEOwQ7lKLY/jwwvzaz6+LglQgSM/uLIoOWiN9P386Ec5IAolarmSWR4KrJ2kvwVzRzQswNHzEQzEnGzRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqv2W4C0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqv2W4C0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf27856f9cso35130395ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 06 Aug 2026 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058820; x=1786663620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yMThCopPkAFmI168rEXeIJriFw8m5HwaXiuoWGQJQhA=;
        b=eqv2W4C0c87j80zZIhf942/Jm5rWlHoWFSjTcuh331h0dJh4fAF40ve3W/H1FXWMYU
         +DT483A8D9GxP9Kk9Dg15IZ5iTPZMMoD28Kqt2S97VaxVsoxg3wByS6zXn38F4M6EBut
         sJ3B4Tt1huoGUa6+OdMcIedKT8MZ4jCZWDqySfq6m+7Qc1ENSvLV9OJHLX0/mBiTAHpM
         +c5WxF+TIDirLYWbpqRKkACMwPcnU3owuHN+APJiYrzeXTd28S9cD/pC5VE/6QrgtuM2
         u8ddzCJ+rB7vHymfuwqO5Qjdh/oIe1max+//+3DCc6ri3XNicQrV7Hdo+RupoTs41D2j
         +2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058820; x=1786663620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yMThCopPkAFmI168rEXeIJriFw8m5HwaXiuoWGQJQhA=;
        b=hOwVI8uNTjmHr6+Jy0XKIycvMddN/+LHD66QR8GrZwcZEDzIbQR2tKAQERhOnOq7QE
         p7rXlFnXcin1v4MWBqo1L5BW4eW9k9WKAUSprFuWGd93nv8Fr46JeY91+TTusx1Na/c9
         6lgxQFzmFFZ6csljO8QXNMYfgU9gHWQnMoxMPJ2EWxArH4WJc6/OI5HVeFzPubVxDbkD
         xV6X3b6zmbB0Qx9BQ9CLV706Q1CFrT9/INbDoL56F5cT36wS8MjKEcZg+vPqZMBWYPVg
         K73dc/b3odD+XRZVAO0MgGXwBwYDw3pL+3LNHgfqhK4nxTcTxkyx0XzCFmpUcKJ6HSiL
         iBkA==
X-Forwarded-Encrypted: i=1; AHgh+RqFbdGQzSGueMDWoXoZwVgLwBmdJZONfkah/7aw1lHK6q0iLRCL7Kkf8esyqd2qPDfEwkHKzrVCQPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx594/yhl0MKsLqaiMQ5TKqN5vTDoSCcoge70dWMdCbsGHKyuVK
	4FwA7gm+KGNtPKvbPS6Yi8V8ndrmbb8OBs14rB0MvuVuxJ6sFUITXQpq
X-Gm-Gg: AR+sD12c4rSWkhHBfADAIWPcS60y59QJpeAt4R0Rdn8kwvFbkL/854Dc2A8v+i7xWr2
	Q5g3cFl8DMyukWUUGBGjaYOZD1RBD5n8b8MW9iQ2r7BXLPYY6ygteExHdYOOJNMvdlmuC/jE9OO
	RhEaNvUuudQazd5oD1nvHuJNMvjhI/WvyLzW94NjfNGPXkz9BtyqlYrz7rJzCm7L4Blw0pe5yDH
	e+ftM3Wm03ueEFlZjtFb7q9JsiXvuWrj6rubvt9wWJYErDk07p8UeRKHW2w/1EdQ0thrNznxFSS
	rUdPNrQhFkCs3pCDZrdLSTz6/Twr2hNoZu7IOlDz47o3JBbXnCcfPJfGBCmEX3TNhMkSsuI3jJ8
	8eFlOze9PT67v52lyoY4IwWB2eeVjDWfn3q2EaoeRzBwWgR/Yog/3XxT8UC7reEnuZaY4goSuaj
	InfMt88zRmCQKXM3cp679c4FZbYQSkf5LYUIZmlviy1rfE1NouedSJ1Hur
X-Received: by 2002:a05:6300:4049:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3cb85ea369dmr22427218637.21.1786058819814;
        Thu, 06 Aug 2026 16:26:59 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8bb33f90sm25853a12.2.2026.08.06.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:26:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 7 Aug 2026 08:27:27 +0900
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, sashiko-reviews@lists.linux.dev,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v12 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <anUYX0t32y37vfyR@cxlqual>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-7-anisa.su@samsung.com>
 <20260731090444.558491F000E9@smtp.kernel.org>
 <am28sIX7a6Z7QaXr@AnisaLaptop.localdomain>
 <anExYCOu1n0RnYvh@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anExYCOu1n0RnYvh@aschofie-mobl2.lan>

On Mon, Aug 03, 2026 at 05:25:04PM -0700, Alison Schofield wrote:
> On Sat, Aug 01, 2026 at 02:30:24AM -0700, Anisa Su wrote:
> > On Fri, Jul 31, 2026 at 09:04:43AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > > 
> > > New issues:
> > > - [High] Infinite IRQ Thread Loop / CPU Spin when handling DCD events
> > > 
> > False Positive. DCD events are ignored because DCD is turned off
> > (mds->dcd_supported = false).
> 
> Hi Anisa,
> 
> I have related review feedback -
> 
> 
> snip
> 
> > > 
> > > [Severity: High]
> > > Since mask now includes CXLDEV_EVENT_STATUS_DCD, status can have this bit set.
> > > However, cxl_mem_get_event_records() does not appear to handle the DCD event:
> > > 
> > The mask never includes CXLDEV_EVENT_STATUS_DCD.
> > Above in cxl_event_drain_mask:
> > 
> > if (cxl_dcd_supported(mds))
> >               mask |= CXLDEV_EVENT_STATUS_DCD;
> > 
> > mds->dcd_supported is set to false in Patch 1 so the DCD bit is never
> > set.
> > 
> > So status &= mask becomes zero and we break from the loop.
> > 
> > - Anisa
> 
> I understand that dcd_supported being forced false makes this unreachable
> today. My concern is that this patch adds the DCD bit to the drain path
> before there is code to consume and clear that log.
> 
> As soon as a later patch enables dcd_supported, the bit can enter status
> and the handler can loop without clearing it. Could the DCD bit be added
> to the mask in the same patch that adds the DCD drain handling?
> 
> -- Alison

Sure, that makes sense.

cxl_event_drain_mask() no longer sets the DCD bit, and it
loses the mds argument it needed for checking cxl_dcd_supported() to set it:

	/* Event logs the driver drains: standard logs when native_cxl */
	static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
	{
		if (host_bridge->native_cxl_error)
			return CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;
		return 0;
	}

The bit is added back by "cxl/mem: Set up framework for handling DC
Events", the patch that adds the DCD case to
cxl_mem_get_event_records(), so the mask and its consumer arrive
together.

The commit message is updated to make it clear that the DCD event log
is not drained in this patch:

    The DCD event log is not drained here.  cxl_event_drain_mask() reports
    only the logs the driver can service, and the DCD bit is added by
    the patch introducing DCD event handling.  Until then a DCD interrupt
    wakes the event thread, which finds no log it owns and returns.

Thanks,
Anisa
