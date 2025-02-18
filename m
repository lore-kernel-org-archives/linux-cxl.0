Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7226D5BC
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895080; cv=none; b=LLywtwA8ktaCiFCN7uOCyc5CLDbz7IzOaXXX2XNZHSS1k8jRNF7Y/7YJtyU0xB6WXAF4JBP1HmxtpqkicElGygL3Q7puu2YgRrTXMPlA7tWZg44/AsDsBKZodDtLGlsvo5YXrYdA48A+N5LCPN7YOvso11oXadlaz2FlgUcSNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895080; c=relaxed/simple;
	bh=PZOujvQ+MNaRhQOa2hN49EYGkUXw8bFhUJtY0Zoxzpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm4M9DyaM4tzmZrrWD/tN6ykQRf68Nl/1irsEpT7RHk/ezNuaN0zv/FhHtQMdsxYU0MSWO1/XvWimx6gXi1djoYchNS7/5u2Pv/oXKLaX7C/6aZcJygDLs5sNrJbQzCFa/HZ76dKLciGD64D77Z10J/YS7Xac839fa2+d9b+cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SxoQFEHl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SxoQFEHl"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471b5372730so72226571cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739895076; x=1740499876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQGGMSgY8MGd0sxrw5WDxENgtEsj70+ROuTTP1PL5Y=;
        b=SxoQFEHlyn6CAmG7dHYNAUqmfSlcv6TWg9T0bVtXnFSq0uS4kOPY7gjy0WsxY0bBun
         ndHY9HQN52yErO1EIUgM8XZ1bWGLBeEbh0C+ft541Sb5fkWNAAvpvSTryAuyjCF4GU+1
         4Fj+B583Abl4/CnGmLOAFv8tfyC1UzVBDHeq1lrmSQ6K8DTpade2wR/pVl347bz2i43I
         D3iaubq32DqUfQPCe7cc9DIIxmMqG6o5t856vcFVSrTqmAnabARfaJvo2aUvQgJClvSR
         iAPStuvS0T6z12PFr1iD4VHzHO8VJuSYJ55IZeYwBm6skwF7NnT1THuxyq968E48F/3H
         JL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895076; x=1740499876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQGGMSgY8MGd0sxrw5WDxENgtEsj70+ROuTTP1PL5Y=;
        b=TFU9Z4GoAgbtOxmnQgsVMEBSxNcy5EMy1GGIP6RJexVQq+O2ApxMJELIFTUsv74XvM
         GnIgtK2uekm1W/rBBgRjpF54L717EdAE/GwNj6OL3eIJ6y9T4c6DGpbNZw/XFyIP++Gs
         kphHx6jt+syr8Pz3sv+QDVwsVfPlnwDUvnsahRE7XvrsIPx/4IV6zLzVnk25v6f/wpsC
         yVkDGig9Eyu5ZBipFOg+inN4XWF2UdNn3vzCu5mcfyqDsM9B2Z8BT2IAAKgYS/8yDYHm
         lRYhjORt4l8b2/v6kmvcZAoT1xg7QdPTZeX9bbgsu5IJJ0uC4e2gcXq+8waVUpcFvGtu
         4FZw==
X-Forwarded-Encrypted: i=1; AJvYcCXet2sKVaAMOP/YSqjsfBbQBE1+RwuwrIsALsF+gGzjddpXHRQ9CwTiVXTaWQsLqIPN5FHRY02P/9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCv7PLugv4s07pPMmESeUxo5xnAluTROtj4KiLjC4W0+I4pdc
	mhyfxJ0vYov0ixmnmTXgTRWyYR1SsSp7G8h88XhKERfX0ctEcXAMq+m5Tnf/vtI=
X-Gm-Gg: ASbGncsrSMns/s0cL1NrNguKA1cew+I73HbcO4hlNWGD1t78y1h0gYnWeG/m0yUgK7+
	Z8oW62UBhhN4WzXzZSrt1/e5jRKOgq/7d2k2/XssdnnxNKIfe60m1Or/jBOtck2nyKAKGJo760o
	9b6SzYKPx4Y7vCQQrbSUMfm+X55BhwdkN89DlfPRBelTTxuiS9XHIEO6faZL65OQq0w6FPHWbBc
	s2YsMHZOPWhvR3WJ/45vv30EuCGMAC81luBFPzf0+Evq2+j39JfmRgOn5vqgP3etshXJD1mZyXT
	5UNSNQf+Upm01Ob0NBxdb0ShtOz3rluUqLVgWDfPHzVKskqshE2gYJ0FWg2I8FgVrsgHjfc6+A=
	=
X-Google-Smtp-Source: AGHT+IHYr4BQwfAkYI4GpOjTNITJVFyEpNnF+z5lYLa4RM2UUxXYRmgvzKbGSZXT2OG53A5PVYI3XA==
X-Received: by 2002:a05:622a:148c:b0:46c:728c:8862 with SMTP id d75a77b69052e-471dbd6fe65mr167655371cf.31.1739895075791;
        Tue, 18 Feb 2025 08:11:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fe6c81e4sm12279921cf.44.2025.02.18.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:11:14 -0800 (PST)
Date: Tue, 18 Feb 2025 11:11:12 -0500
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z7SxIBF-gkuBTqTJ@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z7RdH7RGNivDjq6n@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RdH7RGNivDjq6n@phytium.com.cn>

On Tue, Feb 18, 2025 at 06:12:47PM +0800, Yuquan Wang wrote:
> On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> > 
> >    1) This memory may be placed in any zone (ZONE_NORMAL, typically)
> >    2) The kernel may use this memory for arbitrary allocations
> >    4) The driver still enumerates CXL devices and memory regions, but
> >    3) The CXL driver CANNOT manage this memory (as of today)
> >       (Caveat: *some* RAS features may still work, possibly)
> > 
> 
> Hi, Gregory
> 
> Thanks for the in-depth introduction and analysis.  
> 
> Here I have some confusion:
> 
> 1) In this scenario, does it mean users could not create a CXL region
> dynamically after OS boot? 
> 

It helps to be a bit more precise here.

"A CXL Region" is a device managed by the CXL driver:

  /sys/bus/cxl/devices/regionN

In this setup, a "CXL region" is not required, because the memory has
already been associated with memory blocks in ZONE_NORMAL by the kernel.

The blocks themselves are not managed by the driver, they are created
during early boot - and are not related to driver operation at all.

The driver can still enumerate the fabric and the devices that back this
memory, but presently it does not manage the memory blocks themselves.

more explicitly:  There is no link between a memdev and memory blocks,
which would normally be created via a region+dax_region+dax device.


> 2) A CXL region (interleave set) would influence the real used memory
> in this memory range. Therefore, apart from devices, does platforms
> have to configure CXL regions in this stage?
> 

Again, you need to be more explicit about "CXL region".  A "CXL region
device" is a construct created by the driver.  In this scenario, the
platform configures the CXL memory for use as normal system RAM by
marking it EFI_CONVENTIONAL_MEMORY without EFI_MEMORY_SP.

Some platforms configure interleave in BIOS - how this is done is
platform specific but ultimately constrained by the CXL specification on
programming decoders throughout the fabric.

> 3) How bios/EFI to describe a CXL region?
> 

You would have to discuss this with the individual platform folks.

The main mechanism to communicate CXL configuration from BIOS/EFI to
kernel is the CEDT/CFMW and HMAT.

~Gregory.
