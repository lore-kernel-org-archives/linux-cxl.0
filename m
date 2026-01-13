Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5DC3191D0
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334873; cv=none; b=Y7PQC2TYFFF/qfgiPdlsAlYCRl98BT5ED0wr6EIUm9N8qiOGih9a0yhQlEkoeoA6OwI2QlgGr5scHo8jBIzeMEyB5pjLdS6nFXjEun77sngqN6l4fVURRvXRUGeqxvk355i1BNsYCLNKJHsEXqiZGNJDBT9qVNayOzGwacZKMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334873; c=relaxed/simple;
	bh=/pH8W2OExY5y4VXICkmJe7HAHRiyne3pZIH6zCI0Aj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmbqvqybGRBVu7L2OxKuFL/NjnQ7gQoM3P2JKJAJTek4TJUyMQlcsFFECszz1+Cq2t8CaE+GB7yds+C5DLBTrbxOnNtrqdunRsd1s7gZzxsv53leWDLF2MEj63JSkDEgQKJ/c348YzBO4KevxGz+P0QAt4OUEYHb6hRIBvRslgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=svFasikv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="svFasikv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f822b2df7aso106636661cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 12:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768334871; x=1768939671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsjm1b1/Cya0lOrUQSNALi1YNDSdP7lb7yu+tCKRLaE=;
        b=svFasikvkD1Fw2EfcveseqFC5ktzp5DnTBk+efHzw43Jjj2gCcpikuyo8c8uxN/5YH
         axue1nassEPItl/dx6Nbm6LN3JwyBOcgSXDWXNuoWO/WIvt/th9apVtZaHs8LCkH2w26
         a1O6nDRuYN6NcOuMjClAQaLTMZgBxIiAXQNlqHuCwqXFSAwmU9jNESiSfcw0RMVv4vku
         vJVYkleqLCJtRgVvlOGM3IOHQHP1I8YpP5d9Djoh/X+LKD10tgCVdLN0FKJBh5e1vgGU
         IDWoqCQjZvBIdAnrdJsWBx+2a+8mXsVVM/WR5M9XUWsznpno/lNTJViEbTs9HhUdDWD/
         OysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768334871; x=1768939671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsjm1b1/Cya0lOrUQSNALi1YNDSdP7lb7yu+tCKRLaE=;
        b=XXu6Dl+zcf4HZjShXRQNmBRgha+CWbqUDyyzcFg19CAv2oOuvEaEYfurUhdv8QxF9O
         Y2uhFLD+2LcGgxm/QxZAofaSGLiva9rSPwirmDwuqsUHLpzAHdEFnno05IQnxnZIVh+7
         xZOKEiS6RmHWb6aKJIoXRZFGylHuOJzVzRtL2RUnoJhJ5alZEEWq/Orie8kIDjy8AWsE
         Zdhm8tsaasuTwxOnRvX8Zm/c/zjvMhZ8s9sM+Khb1aVCycs4Si/HKOEh9PKO3912jLb4
         KPukXe9ukEy03NQOPl0XWf1ucMhiQx9rOtpJWSHX9XmAJ3UmXX/3ZD4NHpUyFUi+fkF1
         kQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/286/7ZQMGEkdqBwfcXtBrapN9OCsGQNBJNBD5cM/yAfkD6dhWUmjXRvqSSOOuZabobxMUq4/98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kESwCLUtz7VV/FCQaMZ/fayhT6BL0Oa8HLreeXuSawArgibF
	P45LkaGvPaYhjRto5BYoMD7bM6AcNsgJzYMhLtvjH+oryqvFN+SqnBiaFDRqAHDIXhU=
X-Gm-Gg: AY/fxX6nmIHg2Hx9BA+5LO0mjnzm2DXCXNR6CpZy8RBePDoa/7DDqyQulytkqudN6zV
	aGdk8laBOahx/mHIL/uG0jUYBYI351xQ8+syCKwR4gy9Yqikhd/V2moaUUDfTdHmjyEnDecCakg
	Eb45p1l5N0SK+GYLU+WCrm9jMiJ1x6nAFEs3H078uf2Bt3Yn9ZUkrSBMrb1C78+x8H1LaEDvzZg
	Xs5Xkj+GA80yAWiaiqR9722+rO9GNBJYQi0OPNY8JDph3TgB7J0HoqaAY8nvwjwXcmzJdu/47DV
	kg4mJzqZMSHVxDvobk4VViT49VlDy8jkcn/O2EgpofF9MwxFfNtfhBs+4X0wVHkFZE/Se5UAmvV
	wPG1wYeP3vevtx6yHfK0LKHNHAKT3HlA/8ewiuQeGGpK2B2Qmm0DYQ8y0PJXDZDsbbe9U/Z24bg
	vRDuQ2TbUe/pt8avdCr+5ddP53E5VgJQbTbC6+kE24rjtrC6CccEnoQzRPtLvZ4/EY3o0e1g==
X-Received: by 2002:a05:622a:1187:b0:4ec:a568:7b2d with SMTP id d75a77b69052e-5014825c4fcmr5708691cf.34.1768334871050;
        Tue, 13 Jan 2026 12:07:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df818esm154881cf.8.2026.01.13.12.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:07:48 -0800 (PST)
Date: Tue, 13 Jan 2026 15:07:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Message-ID: <aWal7isomFqZ4DHy@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
 <bffeb2ea-f5c3-4ece-81be-74b647f027ac@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bffeb2ea-f5c3-4ece-81be-74b647f027ac@intel.com>

On Tue, Jan 13, 2026 at 11:00:42AM -0700, Dave Jiang wrote:
> 
> > 
> > This is a "probe" operation not an "enable" in terms of runtime ABI and
> > presentation that starts decorating the region. In that respect it also
> > is not a "control" as much as an "operation model / driver". So no need
> > for a "control" concept, i.e.:
> > 
> > s/CXL_CONTROL_{NONE,AUTO,DAX}/CXL_DRIVER_{NONE,AUTO,DAX}/
> > s/enum cxl_memctrl_mode/enum cxl_region_driver/
> > 
> > ...otherwise there is nothing in this proposal that makes me want to
> > abandon the traditional meaning of a "driver" probing a "resource" in a
> > certain way to make it usable with the rest of the kernel.
> > 
> > Rest of this looks fine. With that fixup if we are going to have a set
> > of different region driver modes then the directory can be:
> > 
> > drivers/cxl/core/region/
> 
> Do we still have reasons to keep the region drivers in core? I know Fabio has been looking at moving the region drivers to drivers/cxl/ so the LMH cxl_test stuff doesn't doesn't need to do all the weird stuff to make it work. Maybe we just do the refactor now and move the region drivers outside of core. How about drivers/cxl/region/?
> 

I pulled them out into drivers/cxl/core for now, but this is a trivial
move.  I think it may still use some core.h functions, so it would be
more work to pull them all the way out into cxl.

will submit a v2 here shortly with just the refactor work w/ the new
sysfs entry (but no sysram driver, going to defer that to a separate
line on top of this).

~Gregory
