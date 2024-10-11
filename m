Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF12194AC
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655171; cv=none; b=aUkxXo4i7X4EysUaQbHYg4IpoqsXItn3beQyPBO20Ub+pXg9Pvl6licKjKMPrc044yJKX1hxUpYmD88HNcXXD864RrmDlY0ELR9GfQglGTXcVAGILgKk8T5RqiWSBH6QMeoTNbTd4rTufJ+WTZ9il2IKtRUpNoPXviDEM6FY6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655171; c=relaxed/simple;
	bh=oa0wWEHk2DCgqrnI5NOLBJVu4UIRkhWHOM9j5gizBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNLXiz4OrGYr7FZUGfDNvBbLZ0LqbK8z24hS6dKqQZXVOf5vG9iLD9nuCTXSz8M+ykwBi8kxpCStDvkOngg8tF5Wy1odv6Hi1p+QudwS/YfeyoeKWcatQLRNEYWDfg+IzFy0ZdCIbQsxFcnS4YY8fXgvYggRO9ku5/lcgskKT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OoP9AM4D; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OoP9AM4D"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b11a28242eso58268585a.3
        for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728655167; x=1729259967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMgQAKnsRs9CqPUiZARlP8dyHlTa8JA38T3vt8l3mtw=;
        b=OoP9AM4DUSycm1wuyGbr1ndEJyrJAetSznP1hRPbvKwk10LNRp6k7p31nFwujsoilA
         JUfIWaeP2lzyEsWLSsFVLGnnOS+M/zqsNDSv9akYYbFFBjsOgLEQiRTS0ta2IpJn238I
         9aJQAd0Oj5PJlopdRZySkZftqsA5oNHnBlBJxhUOMb3lp2+cm+LLUoBnnwqoEZPjmtrZ
         oIQYJsJlIp0QlbVvwnE8rsNJa+VSa7zbB4adS7Z7fJTkiTmPO1hW2TMvw7SN7LOZWLtx
         9FmJheXWnBZtm+j7FUkdBB22MReLysCzwEZBjRkpRNfzd+12q6KlHhmdshDc5w1HariA
         hpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728655167; x=1729259967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMgQAKnsRs9CqPUiZARlP8dyHlTa8JA38T3vt8l3mtw=;
        b=cNq5tyPoHuhYWwbrDIEpvOV++49Do1cWCmYw1xrUjpMuLqA96wJAaca2gmYsYqqWYO
         hLIofR2d9rdAPx6Srxftsck07bKhU+G3iLSKCcX5IT38n1j4pknSyLEkYdVCaffOdmLn
         9sqBU+QgRSZhElYcbjpN+3EA95cccaulijT8+s1Q4rD1Ejg5jLvDq9A0jhnMqgC05r+5
         AHddAXiWhpVyWVomKcqVQR9gQY1kaqSeo8C5ilsILasqYq/Ioc6UdnbAXMFdZoeIYYgP
         sycO55+Arqffx1/WTvyZme6/oqy0pCC0bT4SzTlqEhM2c+KgwrB44DGY5c8EzEd/V816
         cRZg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSoLnH3k/V+6DSAFhtjixWvQ1G+Ma1MCbykYUnTd+4xx4R6rwMEykbd+isG8fX3oNTlvQCHgxcPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw160vPmTj9/BUVqnJqFZTo0LiZgCVed+1a+o44M191Vb8FkJtz
	7KAEJfMVsHXvS3OIkn1ejHJy1/qrOlphiRklQw41tbKT8ObU4lwPhKlZkiDV44M=
X-Google-Smtp-Source: AGHT+IHcByFF6yQ/bPeQbJ3nqEcB1yr2kvWliV8YMpQdFKT5Ch9+kA9/fIFQYrGYJJKQ8+n1Sx+XxA==
X-Received: by 2002:a05:6214:5c03:b0:6cb:e770:f505 with SMTP id 6a1803df08f44-6cbf012bc58mr29670396d6.50.1728655167499;
        Fri, 11 Oct 2024 06:59:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d6asm15892246d6.5.2024.10.11.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:59:26 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:59:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	dan.j.williams@intel.com, bhelgaas@google.com, dave@stgolabs.net,
	dave.jiang@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <ZwkvMIqC2DjLZJrg@PC2K9PVX.TheFacebook.com>
References: <20241004162828.314-1-gourry@gourry.net>
 <20241010221628.GA580128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010221628.GA580128@bhelgaas>

On Thu, Oct 10, 2024 at 05:16:28PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 04, 2024 at 12:28:28PM -0400, Gregory Price wrote:
> > During initial device probe, the PCI DOE busy bit for some CXL
> > devices may be left set for a longer period than expected by the
> > current driver logic. Despite local comments stating DOE Busy is
> > unlikely to be detected, it appears commonly specifically during
> > boot when CXL devices are being probed.
> > 
> > This was observed on a single socket AMD platform with 2 CXL memory
> > expanders attached to the single socket. It was not the case that
> > concurrent accesses were being made, as validated by monitoring
> > mailbox commands on the device side.
> > 
> > This behavior has been observed with multiple CXL memory expanders
> > from different vendors - so it appears unrelated to the model.
> > 
> > In all observed tests, only a small period of the retry window is
> > actually used - typically only a handful of loop iterations.
> > 
> > Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
> > interval (1 second), resolves this issues cleanly.
> > 
> > Per PCIe r6.2 sec 6.30.3, the DOE Busy Bit being cleared does not
> > raise an interrupt, so polling is the best option in this scenario.
> > 
> > Subsqeuent code in doe_statemachine_work and abort paths also wait
> > for up to 1 PCI DOE timeout interval, so this order of (potential)
> > additional delay is presumed acceptable.
> 
> I provisionally applied this to pci/doe for v6.13 with Lukas and
> Jonathan's reviewed-by.  
> 
> Can we include a sample of any dmesg logging or other errors users
> would see because of this problem?  I'll update the commit log with
> any of this information to help users connect an issue with this fix.
>

The only indication in dmesg you will see is a line like

[   24.542625] endpoint6: DOE failed -EBUSY

produced by cxl_cdat_get_length or cxl_cdat_read_table


Do you want an updated patch with the nits fixed?
 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/pci/doe.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 652d63df9d22..27ba5d281384 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >  	size_t length, remainder;
> >  	u32 val;
> >  	int i;
> > +	unsigned long timeout_jiffies;
> >  
> >  	/*
> >  	 * Check the DOE busy bit is not set. If it is set, this could indicate
> >  	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> >  	 * it is expected that firmware and OS will negotiate access rights via
> >  	 * an, as yet to be defined, method.
> > +	 *
> > +	 * Wait up to one PCI_DOE_TIMEOUT period to allow the prior command to
> > +	 * finish. Otherwise, simply error out as unable to field the request.
> > +	 *
> > +	 * PCIe r6.2 sec 6.30.3 states no interrupt is raised when the DOE Busy
> > +	 * bit is cleared, so polling here is our best option for the moment.
> >  	 */
> > -	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> > +	do {
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	} while (FIELD_GET(PCI_DOE_STATUS_BUSY, val) &&
> > +		 !time_after(jiffies, timeout_jiffies));
> > +
> >  	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> >  		return -EBUSY;
> >  
> > -- 
> > 2.43.0
> > 
