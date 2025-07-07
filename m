Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859326560C
	for <linux-cxl@vger.kernel.org>; Mon,  7 Jul 2025 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918110; cv=none; b=iCWRe7M9TcNUKQRsUa47VZHNxc1N7bX43S8lkH/NFdYvNw1x2t6PS0APc2RoZf59Fbuv/3yTAhYNswojRfRR6ovQNH0KRPpt61NeC8t9GsND0MqPnXr74xshBZchmLkh/E1wlvH9q2w74hmFLhMgtQ94I1uoMCJFE2PVedc+JG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918110; c=relaxed/simple;
	bh=rH1Um4JjiE+OKcCWJfxcm3QVfpMPdYIq4FdAa+Mqz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODgzpvCJB82USP8nTmtX+WC2OQuvWN1SS9bTE7ZsdFfizllspyvC7UHsWqTWG4/E/dKjLwAMIaf2x+tQiSPL5FbY4SZ3QVrenOdIBxfxstq/IocPJOyoPIWv9ETYogvAtv4adAVHOePhuOpqXQkZaX7t0ir6zK6mn1WNl3/2Bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dPuV7djX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dPuV7djX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d7cf6efc2fso146515185a.3
        for <linux-cxl@vger.kernel.org>; Mon, 07 Jul 2025 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1751918106; x=1752522906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UADh6/FawOv4Kskk6Mh1+PdTlSoMCExqyQRzaDETwds=;
        b=dPuV7djX+WLrtwXa/XcHF7ITOJ1uLxqCE1cF6NwY9MJBkrveA0WWtw9H+pKf6t2jcw
         jlmHg7+qMzJYSjXuUMx2tNY9yoBMH5Lj51x6+Ez2DSrwyPFjTARl1D2fZ8At4J9niwYg
         EEy22bQicKJD3+M1iYjrHF3UHRcebLKvMK0mhs2dMeaymZNUaNqSx0fmQhUnEK//P2ZF
         8xihyafXksZWJqVzewljFbGr5dixm6gxWxRkxDjEZqjMItBaQLOAZpZub01odcv/kO0z
         ultmmz8j3aaXfzHhQ5w36duaTXLKtSl92K6oXx+nWvV1RtGe7T5c3PuWQ4Tm9vGWAC6W
         XsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918106; x=1752522906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UADh6/FawOv4Kskk6Mh1+PdTlSoMCExqyQRzaDETwds=;
        b=P8Rg9rDkF+UHzVgKc7JpYsFqn0PaujHn8trqqSv4ft31UZWlQdZO/Mkh1JA0SEz/7A
         AI6iYT9PzkdLp05DmiYAGonpdjB5fIvguFq3o355WrkRhVAF+a4UKc/wCOf+5BvK2dzA
         iSt9wktgPR7uDXcpI6To5ONIv/beaoMdv7RqC/a1NoXmx+lkRK3oD1EJgmQWpzMo1j/L
         XrziHJgd+EGSFJOom4KM7wlfvg7gwEyWYhvwa9h5ruEnw9C7fWcXKJSpEjvcLs0fYUv2
         ZvN9Vk/O6Czkd5L6mqSmb0+dyGPNN9bFzO6YM6+oUYgBFRzxsLA54PNa4LyCACh/2/M5
         kqOw==
X-Forwarded-Encrypted: i=1; AJvYcCXmb43VGGHkt2MsjFw4qAmS7DVIaiRkn4rWcyvKh2RTj2V3xfiEgwrFVVsqweTGk8P9ZL/br9B3ylk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaSWfJXk7wlZWQjmaiR1a0bSvDjpyvdkK5qTwn60PanDm58Pi
	PiiZa3F6sg8GsWt60YCWF+eFUTXySftRbP4Aquukske7GMYmAo7ek7YUma6R8hqtj5o=
X-Gm-Gg: ASbGncucsXkOGG0nP9ox/037U4K9umI2GaENiTCvZTH9wWG72PeJsFOapRHzdG79jkM
	fWhvhBR+kE1ZNWuKSEZtDFA71fLfcmZf83w/ByqufoHMYWEmRl/mxGzpP4EDURBULKiQkN6mFY/
	MPzPnwHQkTVd6ti15/uprmeKWuzBOBsqGso5RfDP7PdVdkW2GBJgLDfRBbsyCL8RY+8BDEbHgCV
	SEiuvTuYdRqcgj6x+K7XRKdKpDVxvd78B5jA2KCYgFUcV6MO0TU5LDW9Z9bH0Vr0onK6uGqFcrs
	209nyWdnFcKHajdtZTspgEl9VGdPJqw85pOCQJuKxio7rCvqLXZs45Ao9ffuS8F1pBOn2J5SW9G
	xcc8ICIBnwElWtEvX8Nd8swqZrPAL+XBFaLGgmnEHGQ==
X-Google-Smtp-Source: AGHT+IEPOB9nrwcPS8zwLTEDLhm0/0j1fZ7qx4I+2SLCJR2zuzEDi/FJw9KBkuJrFGpVm5CERv79vQ==
X-Received: by 2002:a05:620a:468d:b0:7d7:891:83f with SMTP id af79cd13be357-7da04327fb7mr45809685a.50.1751918106175;
        Mon, 07 Jul 2025 12:55:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f58esm661893385a.79.2025.07.07.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:55:05 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:55:03 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <c32cede0-643c-47bb-bfde-93adbcf16155@intel.com>
 <aGbcpac1pma1od40@gourry-fedora-PF4VCD3F>
 <1985851.b9uPGUboIS@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1985851.b9uPGUboIS@fdefranc-mobl3>

On Fri, Jul 04, 2025 at 12:05:33PM +0200, Fabio M. De Francesco wrote:
> On Thursday, July 3, 2025 9:40:21 PM Central European Summer Time Gregory Price wrote:
> > On Tue, Jul 01, 2025 at 08:23:57AM -0700, Dave Jiang wrote:
> > > 
> > > 
> > > On 6/23/25 12:19 PM, Gregory Price wrote:
> > > > On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco wrote:
> > > >> Add documentation on how to resolve conflicts between CXL Fixed Memory
> > > >> Windows, Platform Memory Holes, and Endpoint Decoders.
> > > >>
> > > >> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > > > 
> > > > I won't block a doc update on a suggestion so
> > > > 
> > > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > > 
> > > >> +Platform Firmware (BIOS) might reserve part of physical addresses below
> > > >> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> > > >> +or a requirement for the greater than 8 way interleave CXL regions starting
> > > >> +at address 0). In that case the Window Size value cannot be anymore
> > > >> +constrained to the NIW * 256 MB above-mentioned rule.
> > > > 
> > > > It might be nice to have a diagram that explains this visually, as it's
> > > > difficult for me to understand the implications through words alone...
> > > 
> > > +1 on request for diagram to explain. We should try to document this issue as clearly as possible. Thank you.
> > >
> > 
> > At the very least, it would be nice to have an explicitly example that
> > explains the expected cfmws/decoder configurations that are valid but
> > "technically" violate the spec
> > 
> > I *think* this basically boils down to "CFMWS size is not aligned, but
> > all the decoders it targets are"?  If I understand this correctly?
> > 
> Yes, this is the intended meaning. 
> 
> E.g, two windows, 384 GB total memory, LMH at 2 GB:
> 
> Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
>   0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
>   1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256


In this example, does the root decoder have 0/2 and the host bridge
decoder have 0/3?  Because root decoders objects are created by reading
the CFMWS Base/Size - while host bridge decoder objects are created by
reading the host bridge DVSECS.

Or does the linux code read CFMWS Base/Size and create a root decoder
with 0/3 because "that's what it should have"?  etc

I think you need to describe what the expected behavior is for what linux
will produce in terms of the decoder objects given the above.

> 
> 12 *256MB = 3GB, the Top of Low memory below 4GB is set as 2GB in the platform for MMIO Low Mem Hole (2-4GB). Only 2GB will be potentially available for user, but currently the CXL driver expects a CFMWS range's size to be greater or equal to the HDM Decoder's, so it  doesn't match them and we lose those 2GB described by CFMWS0. If we allow the matching, we make those 2GB available to users.
> 
> Is a table like the one above good enough to make this subject clearer?
> 
> Thanks,
> 
> Fabio
> >
> > > > 
> > > > which is likely why the conflict exists in the first place :]
> > > > 
> > > > ~Gregory
> > > 
> > 
> 
> 
> 
> 
