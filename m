Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E61DE4CB
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399102; cv=none; b=tgxbpSjfHWUi1YlGL6u5P9F51bkH14Up952uVtwn2/n2deabk6urpjTZN0N0AFHf/6l51VVJfcjxGCpQRj1iJUY5dlKSmxP9NIJAkQ2ol9DLBoY3c+sGf/Bhp9Y9hv/cEJDI5u6pdg5mPTbfIRUirBud94ojlms4lI+wTeInDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399102; c=relaxed/simple;
	bh=FdX000BfNXmYUb4opHXMevAqiMWP56/tqAYYlyDF/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3zh750ImMQJPCUKKM3l+5fbAqtJnT91uNewm+xDKSUp2ISx9aOSXlq4YbYN21bYk03QnUrDyPChDsPVeqlvOe0faZN/NOdda7WWBRHFi6i76qGaK0Lm87K+CRIVy/meJCxg8NCibuZ1dXSNaWsJHSY4vaOJjfoLgijfvQ4djjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MhgcSAsu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MhgcSAsu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7ae3fcec5feso599428785a.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728399099; x=1729003899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=MhgcSAsuU+jCrZX0l4hWSH5pUs0TMn9rZR9g9vqnKmTJlaAUqcXirI1m91ppzNRdB2
         yBW0ompQ8CCS2isafEyPBA68NaRTDth/Iuv2ZSxib0nglHmssItSMkO2WkgY/3OLGrGO
         ToaWBIPzhzTbIlfJDtUdbqUwsxwnQRDnrlK2ZvKRygTzG+gUq2b9Ex84naglBcpfUoUj
         wKvsgMH9YkY3vCqAeLusFZAh+22QaaBhPw2shOjIhNEYp1uyE6S7uxvAdo12eyF7wU+i
         IMOZpfkMfT4yA830bdiXc1fw5iuXocEb7hT32rTjkJxJvQRilU7FhSao9UNXq3wB8NgH
         E7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399099; x=1729003899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=OABaaMBCT0+gQwm1pb+sWwZhj7/8P9JvZkd6dn4JrKblzNDrXxr4taEoWk0OCkC25h
         uOCPQMqKfOjG3YlGC5czYSw1tmeOaKYz2OgMeaJe5G+gguyzbRy1F4QE83Ql1YhrwtQr
         0U8V6vnI32r1HVBRA01aHnoqP8MQNdF6Sek5q40vOQP5Rbdyh49oBHUBVlwqoZbpS48h
         N9eFwfyls2t8fg+Vh1gCXRJBBrc4pZEiLN8zPJrN+wK1VWTaqyHYb72s+XbywaISj88Z
         mzm8qJGDiodDNRTGc0I4YYz7bIuH0WAC/6MSYrCm1r/15LBK8+CmpkNfOXIbsrC6r+mX
         JL7g==
X-Gm-Message-State: AOJu0Yy0cTGTlbuVktK1LkxFPvGdp4Y713unS8QA93Bn7Lci/TZEpyYv
	W7PSp0QFOJiU+yXxuZWWMHtxx56DNeUYjfWA1p67DH46LHgjHHeWqUm4w9fKJao=
X-Google-Smtp-Source: AGHT+IFq4ejAZimMFPt1747gCyE+Qz23dQBrY1mL0z6fT+fBj1wX7llJiqwXX1zCd9TNFYGsXrL5tg==
X-Received: by 2002:a05:620a:29c4:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7ae6f48699fmr2414673785a.43.1728399098773;
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75635ca8sm360029085a.60.2024.10.08.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:51:29 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>

On Tue, Oct 08, 2024 at 04:03:37PM +0200, David Hildenbrand wrote:
> On 08.10.24 06:43, Gregory Price wrote:
> > On CXL systems, block alignment may be as small as 256MB, which may
> > require a resize of the block size during initialization.  This is done
> > in the ACPI driver, so the resize function need to be made available.
> > 
> > Presently, only x86 provides the functionality to resize memory
> > block sizes.  Wire up a weak stub for set_memory_block_size_order,
> > similar to memory_block_size_bytes, that simply returns -ENODEV.
> > 
> > Since set_memory_block_size_order is now extern, we also need to
> > drop the __init macro.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   arch/x86/mm/init_64.c  | 2 +-
> >   drivers/base/memory.c  | 6 ++++++
> >   include/linux/memory.h | 4 ++--
> >   3 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..6086f99449fa 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1424,7 +1424,7 @@ void mark_rodata_ro(void)
> >   /* Adjustable memory block size */
> >   static unsigned long set_memory_block_size;
> > -int __init set_memory_block_size_order(unsigned int order)
> > +int set_memory_block_size_order(unsigned int order)
> >   {
> >   	unsigned long size = 1UL << order;
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index 67858eeb92ed..f9045642f69e 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -110,6 +110,12 @@ static void memory_block_release(struct device *dev)
> >   	kfree(mem);
> >   }
> > +int __weak set_memory_block_size_order(unsigned int order)
> > +{
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> 
> I can understand what you are trying to achieve, but letting arbitrary
> modules mess with this sounds like a bad idea.
> 

I suppose the alternative is trying to scan the CEDT from inside each
machine, rather than the ACPI driver?  Seems less maintainable.

I don't entirely disagree with your comment.  I hummed and hawwed over
externing this - hence the warning in the x86 machine.

Open to better answers.

> -- 
> Cheers,
> 
> David / dhildenb
> 
