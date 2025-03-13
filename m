Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BB225D6
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887065; cv=none; b=n91twOqEL9y3zv21ME43dizdi7yJB9HI+y2c/N55mr9NnSFoFtqxa52LFaFuyalSv/S3QsbCujkuvB6WOeht6fsiHWVw+SxH4eDC0Ey8et1G2Nfhi+d54/jYWORaKHQwZ1BH160ImCLJiyIqW5s2Z3lN5C39rUdf4WiTHOEE74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887065; c=relaxed/simple;
	bh=6NuaKrlJwzqSDKDjBHf+Cx4W/xW2kBVGqK/Gow+UQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsIMwRQ7QeztqijeY1twIDHkG0Fel9663o38hg01sqDxBol/McbsSbO2tz9CpgXXokx/SJB3PqnHnP8rxT3vKmaGDjW/0PPtiABDOTmOmmL8FPU6AYrJkNJ1luSgQev10/P3vrAj6MCvFB8oKGjJQIqMz0I3fEmNNA6Yxynyf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Bxu/CBGh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Bxu/CBGh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e41e18137bso9674586d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741887061; x=1742491861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O83EJQJInxOlaXTG5L5nMhpQUXrgmfAXio9XKQcNg+E=;
        b=Bxu/CBGh1pVH5fT0NdtdDxQhTO/pJDlrkGJbdAIvv8FvPP/bvdScXcnGaLIsDMAvQs
         yuyS+90g3Q2E+9ZmAmDmeHAy0imuT/3I3n650YVGnggUbZ6IBgpFwr8YFhE0mIWsyOrp
         hAs548NQtxzVcwVdu7T8AAQEpYajbhMXyoxoy7DO0S5dEXqkdQvCuVJpuz7BI4j5nUw8
         /9hsiplD/eX2Xlp0l1p119LtByn6QTY5LT1p0e8WUa//zzS4CqHoNFOYZg4bpTJOnH9G
         n9KJnQrbpO3sBxisoNkowHb+n22z1V8VcH/TozRwoWWmofq53D8vKCcXARMzRIr+tmYh
         HGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887061; x=1742491861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O83EJQJInxOlaXTG5L5nMhpQUXrgmfAXio9XKQcNg+E=;
        b=Jf6Lx0IzxfzkkbL5fyOu4RtzbP50ysD10RY+YaKDtzrrswhTNVUVJEzzD+l5KL0OZr
         L9loqn0LKa9iteeyu3BW08ufsVAP87JCFdxeTDl7yR7ELbCMl2JhVl3JxN23txLfobz8
         ESg65J/Xeoi1HcrUEGEkpyKU5G1Y3Q9D5OCsWMgmhs+8NHCjbnSDH79EZL2zacA99nC6
         8c/ACbhz4gpHMyV/av+FZVUshssfK9mAZ9orBIpM5naLB2/nYCUaCVws+08NTc7LyqsT
         K8InLBUW5nZn4xSNFCnoIsd43tMEj2fzP2V65XJUrzsfILirLgdABzQvGpkJvgNJzE1X
         0p7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIjVvHEpT9pCQNyc6gnndfzsKmWw8LQfm3zJkIY0m2q+dUOZSo2Wz5iawDr5eWgfFNzZYXyf+idSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDEYfz/QIRVpz2RZru7ePvE/RgHlF2AiGChSSZyomaeuNKsPr
	c47HxvahA1tij5CVudVx4l+GWN0zKwC0+6g0iLFIaZCN4c4+jfnVSBKXlM7tPhY=
X-Gm-Gg: ASbGncuSEQrWEKyfweS6arTeIdcm1fM+nWxuR9gWqVVW8EV3p7i2iwYVLUxiPeJK8Ri
	XsGd7F2OWZBfYBC7ahwyxIpHEnLOBUqMv/6i1eSUgbk/UAbULlUf2gvaOMpI11A0bVrTqhNbYmP
	Wfcl9AZOCtKCynxSR6Y6ss3g+9w7NUNgEM8JxCxBILTReZYOniZ/OSlCategLbEwdk6v1mAQ6Ho
	SdyRCPmm9OV/mQK402c8gnpY5FWG8CwNItMXqwu9G4RCP7vKnnJ9pl3pdl8EMyrg0IJu2AdjK53
	Z2fg0hOyuvD9fkqdPsmP8z4ZXwk88SEriDDr2X8icjBabVqyCND8AxiqFR1HR9V4xtVDBjRSCY2
	wNe4eakyiqc9+lT0aNXVnGx8kP4Y6HoWkGC328g==
X-Google-Smtp-Source: AGHT+IHuylmJfYk7wLLXX/2M7mKuROyvy47bvGrvCnuvmNFtINIICBzR6GpKU9pV+TBfiu9Nbi1ktg==
X-Received: by 2002:ad4:4ee9:0:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6eae7aa22d7mr6914286d6.30.1741887061046;
        Thu, 13 Mar 2025 10:31:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb663603sm11829221cf.43.2025.03.13.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:31:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:30:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z9MWUhHmZ5ND0b_e@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313165539.000001f4@huawei.com>

On Thu, Mar 13, 2025 at 04:55:39PM +0000, Jonathan Cameron wrote:
> 
> Maybe ignore Generic Initiators for this doc.  They are relevant for
> CXL but in the fabric they only matter for type 1 / 2 devices not
> memory and only if the BIOS wants to do HMAT for end to end.  Gets
> more fun when they are in the host side of the root bridge.
>

Fair, I wanted to reference the proposals but I personally don't have a
strong understanding of this yet. Dave Jiang mentioned wanting to write
some info on CDAT with some reference to the Generic Port work as well.

Some help understanding this a little better would be very much
appreciated, but I like your summary below. Noted for updated version.

> # Generic Port
> 
> In the scenario where CXL memory devices are not present at boot, or
> not configured by the BIOS or he BIOS has not provided full HMAT
> descriptions for the configured memory, we may still want to
> generate proximity domain configurations for those devices.
> The Generic Port structures are intended to fill this gap, so
> that performance information can still be utilized when the
> devices are available at runtime by combining host information
> with that discovered from devices.
> 
> Or just 
> # Generic Ports
> 
> These are fun ;)
>

> > 
> > ====
> > HMAT
> > ====
> > The Heterogeneous Memory Attributes Table contains information such as
> > cache attributes and bandwidth and latency details for memory proximity
> > domains.  For the purpose of this document, we will only discuss the
> > SSLIB entry.
> 
> No fun. You miss Intel's extensions to memory-side caches ;)
> (which is wise!)
> 

Yes yes, but I'm trying to be nice. I'm debating on writing the Section
4 interleave addendum on Zen5 too :P

> > ==================
> > NUMA node creation
> > ===================
> > NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> > identified at `__init` time, more specifically during `mm_init`.
> > 
> > What this means is that the CEDT and SRAT must contain sufficient
> > `proximity domain` information for linux to identify how many NUMA
> > nodes are required (and what memory regions to associate with them).
> 
> Is it worth talking about what is effectively a constraint of the spec
> and what is a Linux current constraint?
> 
> SRAT is only ACPI defined way of getting Proximity nodes. Linux chooses
> to at most map those 1:1 with NUMA nodes. 
> CEDT adds on description of SPA ranges where there might be memory that Linux
> might want to map to 1 or more NUMA nodes
>

Rather than asking if it's worth talking about, I'll spin that around
and ask what value the distinction adds.  The source of the constraint
seems less relevant than "All nodes must be defined during mm_init by
something - be it ACPI or CXL source data".

Maybe if this turns into a book, it's worth breaking it out for
referential purposes (pointing to each point in each spec).

> > 
> > Basically, the heuristic is as follows:
> > 1) Add one NUMA node per Proximity Domain described in SRAT
> 
>     if it contains, memory, CPU or generic initiator. 
> 

noted

> > 2) If the SRAT describes all memory described by all CFMWS
> >    - do not create nodes for CFMWS
> > 3) If SRAT does not describe all memory described by CFMWS
> >    - create a node for that CFMWS
> > 
> > Generally speaking, you will see one NUMA node per Host bridge, unless
> > inter-host-bridge interleave is in use (see Section 4 - Interleave).
> 
> I just love corners: QoS concerns might mean multiple CFMWS and hence
> multiple nodes per host bridge (feel free to ignore this one - has
> anyone seen this in the wild yet?)  Similar mess for properties such
> as persistence, sharing etc.

This actually come up as a result of me writing this - this does exist
in the wild and is causing all kinds of fun on the weighted_interleave
functionality.

I plan to come back and add this as an addendum, but probably not until
after LSF.

We'll probably want to expand this into a library of case studies that
cover these different choices - in hopes of getting some set of
*suggested* configurations for platform vendors to help play nice with
linux (especially for things that actually consume these blasted nodes).

~Gregory
