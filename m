Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B551225A38
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160987; cv=none; b=aXT2uMyKwdGrTD+CnOj7xwjPkBmND0EBv78jaLdKAd1SCwx9/uKcW5Nqy31E+OrRyrUab1Dt/g/t+KvayrEKXNrZ9V6jlffvVO3qooYyRksoaRb6cYE9q9qfgqolwzqz5QhrA3vs0hETFkbK3wyO5A1jM0uxm2VlSsk7Y6fGukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160987; c=relaxed/simple;
	bh=eB4CBPrFTEd8vrWk3XvtPspRZVWOG+R1TCjX59sRmdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs58a4+dVGiHhC880n1GHb+rmvYgfUFI/W6pjcOYoGy2UZRW7E/4mqWURWrC5VhMVmQHPaEtGZCGcsNzennDmR6mlNzLQd3wBGAdhR0JWX64lbl3Dwi1jev+F6Rt6m9N4hm5oEfwaH6zKyEpkt56AE8HRMzH0/6huUTOHm8RyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkZstB57; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkZstB57"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso10856a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789160981; x=1789765781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGMfoTpezrZDm/cqA3KkUYo7Tw7rc2tYb+GVefN1YGU=;
        b=jkZstB57TVRTjovcrWz0Cbv4Z3EbhUvzReZ9ZfR6+QgZtIUUJgP+QPQZ6GJk/rAQi6
         wGFQdtchSndPu/pUbAh5UiC7i+/VESPZ+L1hnMLQ7xm8SMIa2fc8hNW30J6mtuk7TEIQ
         w8paaPkCzn5AEoPdxPvaTQD5X96Rhrg6m/Sp/L9fKd9RLhVYVgshWJjw5jB1Wt5uHFMo
         fj7hGYjf+gyJDOnWrumvz9BJmNypCS88g4FfPivwENNU5i8eGG6cJeAAgNgpCCYPybIO
         w912X8hSeeozXE7ormlfltUeWElKnrhOuQaTGvEWEp/OKd8DfGuEuW+YjD7V3Aap7WZH
         ugyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160981; x=1789765781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MGMfoTpezrZDm/cqA3KkUYo7Tw7rc2tYb+GVefN1YGU=;
        b=Wpb4oqBEZuBEbgt1ShyvgGu7TbXuXToLMF9bNa2HkpZXcGkrVCUmqhg5XBqM2ifYCx
         p9VFglyL/2A6HSWyJJOtkQwqY5VLeQXYoeValdkeemlzwPsIUXQ/l6nftdCOZNVVq6dh
         b7ALdBnX5OAG5iywCCg1ykoj63QFtyZiZsfq68FNiNpKqj0elr/R8PtH3qskzC/FmahL
         f3oZaRpNNRDYDjIpKfLLyJMUVWMXV3itmbmJmDZ5QeLUM5Wz9w4BMeZCOaRLJNSh72Uy
         +VxRAdcJ8dl+iHP5pwZOs6ppdFDxNHJ14xO5mTJ4ZcVpLpmEnCtZOqG7X9/p6qNLJ6xc
         6fWw==
X-Forwarded-Encrypted: i=1; AKwUvBz5oOB97lj5ca8Efo6UeQql4AdEYFBLxc3VGSEVtHy9EoB9ew7bi111tNucUZq4lJpW2Fgx8ghOc4I=@vger.kernel.org
X-Gm-Message-State: AFuF++lAE3gtOLLGzT69jmk4qP8+gz+DyCeRKDzPB/g/EvWJGq/+HAmH
	7iAqwlsoywPbDY1DjG6wLS4AF4NaWqt8hnMFnfDSdjZqybzUSs2s60x7ucDAlBIi
X-Gm-Gg: AYBFou17Ys2Z9IoOfXNZsNoHgngbjqkQ2WBvq6TIS+g6kVQVWZoLKd3P+X6IMCOHLql
	dvjZ2PTa+GKVgUlUINF5/OmJylask4fP8hGcUP2oVQKiO0tyUYCkkVEp0hDLeuOaJuztpV2fIeF
	SoOKiedQm5UR8tXmp7HYKPTZjfho7Wwo4Teidl1fhQSNtOsWKD4f8SRo+EwnzdTKskXgMZYemLj
	I4JURu+a9MM3YZUopfnxcXqhp5BJkGhHn5lpjt5eubPFkjXxiKr2Hx0sdF6Uz9qxs5FO83RXtIt
	WAMVX202xjq2WD4FbTvhXVsTZA0sIE82qVv3ddgewSHImpVpv7pI/FX0Pux3BhOXC+q/b/aIsWR
	wrT2PXbgLGpLL2iR2BjsEwgOYgAwjrfkchV0mhRWck7r3Doc2X6ZIVtPYxWkzTlwoYBr7TiLC0I
	G13JaU6QMXtS2clZaMpa04DcQsFgaAoh/kJ8gN0scSmtq9qlg8fl0qpDaMRASwWAMUoTxTOqdln
	uBQrqS/urnKrmYRZwUcMkpawh32iqd/NxBo
X-Received: by 2002:a17:90b:2d88:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39dbc0c2aeemr114833a91.7.1789160981260;
        Fri, 11 Sep 2026 14:09:41 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95095946sm6817101a91.5.2026.09.11.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:09:40 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 06:10:57 +0900
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <aqRuYaUt9qAvPA3W@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
 <20260908104327.DF5E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908104327.DF5E61F00A3A@smtp.kernel.org>

On Tue, Sep 08, 2026 at 10:43:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] If a CXL device is surprise-removed or a fatal PCIe error occurs, `cxl_event_thread` enters an infinite loop, pegging the CPU at 100% and deadlocking device removal.
> --
Surpise removal is unsupported. Jonathan mentioned the same on a similar
thread: 
https://lore.kernel.org/linux-cxl/aqLZP3ORYzCLfSgR@acer-nitro-anv15-41/T/#m8e12567a42b07fae8aa307406e6e017fe24ad832
> 
> commit f11145933c61ad9c3ba90b62e3f38dc571f856c5
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Configure dynamic capacity interrupts
> 
> This commit configures Dynamic Capacity Device (DCD) event log interrupts
> on devices supporting dynamic capacity. It disables DCD if interrupts are
> not supported, and carefully preserves firmware-first interrupt policies
> if selected by the BIOS.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 7b754af2168d0..1ea505b1f40e8 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> [ ... ]
> > @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
> >  		 * ignore the reserved upper 32 bits
> >  		 */
> >  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > -		/* Ignore logs unknown to the driver */
> > -		status &= CXLDEV_EVENT_STATUS_ALL;
> > +		/* Ignore logs unknown to the driver or owned by BIOS */
> > +		status &= mask;
> >  		if (!status)
> >  			break;
> >  		cxl_mem_get_event_records(mds, status);
> >  		cond_resched();
> >  	} while (status);
> 
> [Severity: High]
> This is a pre-existing issue, but does this loop lack a check for PCIe
> surprise removal where MMIO reads return all 1s (~0)?
> 
> If a CXL device is surprise-removed or a fatal PCIe error occurs, readl()
> will return 0xFFFFFFFF. When this is bitwise ANDed with mask, it leaves a
> non-zero value, causing the loop to continue. 
> 
> Since cxl_mem_get_event_records() will also read ~0 (e.g., when checking
> cxl_doorbell_busy()) and return immediately without changing hardware
> state, won't this loop spin indefinitely, pegging the CPU at 100% and
> deadlocking device removal when free_irq() waits for this thread to exit?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908102124.2231730-2-anisa.su@samsung.com?part=6
