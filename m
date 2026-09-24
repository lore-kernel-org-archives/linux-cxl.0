Received: from mail-dy2-f22.google.com (mail-dy2-f22.google.com [74.125.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDA3A48E6
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224203; cv=none; b=OHFzdGtRAbFcSl6IaijJ7G3Vtosj70/fu4U0hwgpsOJRR11fjLixOR8n/F+0z4npH+y8Qd0+JT7TEaU0aJcWfaZw+zHVYCrt/a5EKUQxsntLJvHtPLC3YBKvf3+uwbVfV1elIhcBS9FH9fJ6/9/4hv6yM7pVM0aaLc45+gnE+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224203; c=relaxed/simple;
	bh=DGI+jNvsZqaWgCIG18I9kcv8LEm8FvmlozW/ZGSMzbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD7gCFPm5TlYhS79UKq5nS4+7Ctlcd85z+ZzqFzPlULC6hPbluQxo6o3tZZ+2hzbpcVAZvZASlBAELPUKALCLyb2Ex1EZ8/gn3EnV57wjUYdFRc5hshQz0Ab7uMgz01r2lSGxE1tkuTmiuhR97XkWf+2o1jyAfomdQsy3m7AAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq0hKd8t; arc=none smtp.client-ip=74.125.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq0hKd8t"
Received: by mail-dy2-f22.google.com with SMTP id 5a478bee46e88-33bf5a1c4d9so1657755eec.3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224201; x=1790829001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AKL757kGHNvfsML+k55hOUcVYeXxT3urEJywVMirA7A=;
        b=Cq0hKd8t9AKe8vZKR8IJYVIo5P194Hiu0oBuYJYym9vUdC1B3GrQddjwEAA+Jrl4/p
         cCXlIXndOzKD7P0sL02JlaKqpOFSw+FldKqRz7PM654VdyqmgdJrlC7bNerjaCsfPhoL
         itcByT81+QBd+CbXEV/ZVwZY0KBZlS4qOLaetfcoSVAcfZjZrDCwHLmHRgbXAO4vzsML
         4ZwVMMg/2JCkKgHgw7czmQ8n4p0XY61e/v+F/mtq0Zc6rR32Fe4NIWxS0owDJo6pAcph
         vS2J/w5pmDGX9BWvqm4ntBnV2JnPPRk8lf4By4//cUDo7HPieoFNpYAkWkNPNIJ4tw5G
         f/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224201; x=1790829001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKL757kGHNvfsML+k55hOUcVYeXxT3urEJywVMirA7A=;
        b=XbrVk4SD3mm1I0ignfZPPMEVfVZPYE53mEHSwOfVj+gdWzjRfWa49Cxr5PkBk2Tvng
         GHrc8GqoaFc1m0qPtbNPzpqD+fuQ8Q29xrZXTbvBScrUyTx3cj8LGGO5DOyp5QySSG1x
         NBCwfZG7iATi+QrwrfazzMoZDlvkfh7IVJxzBRzP1qcwnsB+sXkGnLztj5U592o0HmvD
         zZy8ESYOCF+UAKmojb/OqqbbmW8I85slO9Q/OBwBK5kmuhf4AXhg79ktTNxXdtd+oytD
         y7KP+WJUwADoFgmXHJYqIl6kmMw3S4hrFiUiJRH5LCXLsfO9F+gVQ6KouHJ0RhlMK6Ea
         pbPA==
X-Forwarded-Encrypted: i=1; AKwUvBxx19PZgDJSyKPNfNCszXo71c3AGHE/AWdt/aqA1wkZtRsLOj8vN0w2eUjGzAIrnsxSbvizOWy33NU=@vger.kernel.org
X-Gm-Message-State: AFuF++l0/Y5Nvp0Anoy2nAlnx2iRSVP9R2bnJ0nuYoVr3J903so6BEfb
	y74NRhPrViE7b4ubDNvCNUSvVrqtduHbeI4sew6RYHMDUIU2mnKS8oLS
X-Gm-Gg: AYBFou1zkHG5ueR/aUtF+DU8HzeVmxceVmP+wRoON9fBY757yNYLixdkDNmRx71nVGQ
	4IlLnocfzWEvyTEwiQpaSmKtQr2T2FaM3J904eEpVu8uaNspAqdCerciWSJxzlYjn9epT5cj3hX
	Zy0NRvOnagpnA2YuFgQ77ZnRiaqdd8HL7SP/nDUmGzyTiU16O6uqN7CjluFAU6d7RO9c+1jPrp0
	hxR5BxKjlIWyq8Kyp3yPwJP+V8OjnG4w3wUuF1LjFDlS0a1amZ1Wy0a74qEp/KB8frKV+VByVoA
	eOfHNekGXqfbno/5VypwKm9Ab3xXUCjWyx5FRBO4Gqt+YKxZufhClKBslCiYLjjkvNA5+1IrnaX
	RNau1cQhnflxT8/twYwLGFuVc6qz6ehh09O6/RbsLz5LbRNRl3F9nrrYmBbThoO0W6j/pcb0fQZ
	1tzOr3whQRrEov8KHVB08Q7YwXDK0kqUJZNDrKD0sqN5TX9xR2NkGC0M/ga8KgkuG4VSr9H8Y9C
	PKAzY3Q+ISq+o677qBn5AGbRGJ4V6mkEQ7cXx0xi1gh1TZl6JYGxY0lWLJPrmRWXT7tgTyX2ThJ
	qcxkprCHzHqxmtUQk6yaTMD7dDc=
X-Received: by 2002:a05:7300:d08e:b0:333:f2a3:5517 with SMTP id 5a478bee46e88-3400637c0eemr880525eec.26.1790224200857;
        Wed, 23 Sep 2026 21:30:00 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258204sm8590672eec.11.2026.09.23.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:30:00 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 23 Sep 2026 21:29:58 -0700
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v12 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <arSnRvG0VGSMHSBM@4470NRD-ASU.ssi.samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-4-anisa.su@samsung.com>
 <20260731090250.0C8DE1F000E9@smtp.kernel.org>
 <20260804010748.7f9f8174@jic23-huawei>
 <anL0mD3DKfwJh4UY@AnisaLaptop.localdomain>
 <20260922003402.5134db4a@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922003402.5134db4a@jic23-hlaptop>

On Tue, Sep 22, 2026 at 12:34:02AM +0100, Jonathan Cameron wrote:
> On Wed, 5 Aug 2026 01:30:16 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > On Tue, Aug 04, 2026 at 01:07:48AM +0100, Jonathan Cameron wrote:
> > > On Fri, 31 Jul 2026 09:02:49 +0000
> > > sashiko-bot@kernel.org wrote:
> > >   
> > > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > > - [Medium] The commit message claims to extract and store the 'read only' attribute from DSMAS tables, but this logic is completely missing from the code.  
> > > 
> > > Given it will make a lot of difference to a user if they think they have writeable
> > > memory that isn't - I think we probably do want to have readonly here.
> > >   
> > I did some digging: it seems in v8, the read only flag was gathered and
> > exposed in sysfs, but dropped during the region -> partition rework.
> > 
> > v8 of this commit used to do:
> >     dent->read_only = dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
> >     ...
> >     mds->dc_region[i].read_only = dent->read_only;
> > 
> >     https://lore.kernel.org/all/20241210-dcd-type2-upstream-v8-6-812852504400@intel.com/
> > 
> > and a following patch exposed it, with a documented ABI:
> > 
> >   https://lore.kernel.org/all/20241210-dcd-type2-upstream-v8-7-812852504400@intel.com/
> > 
> >     /sys/bus/cxl/devices/memX/dcY/size
> >     /sys/bus/cxl/devices/memX/dcY/read_only
> >     /sys/bus/cxl/devices/memX/dcY/shareable
> >     /sys/bus/cxl/devices/memX/dcY/qos_class
> > 
> > In v9 dynamic capacity moved from its own dc_region[] array and dcY/
> > sysfs directory to the generic partition model:
> > 
> >   https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-3-1d4911a0b365@intel.com/
> > 
> > size and qos_class survived that move because ram and pmem already have
> > them. read_only and shareable did not, because the generic partition
> > model had nowhere to put attributes that only dynamic capacity has, but
> > the commit message survived the rework.
> > 
> > More specifically, read_only was dropped from both the sysfs commit and
> > this commit. shareable was dropped only from the sysfs commit, but still
> > read from the DSMAS entry in v9 of this commit. Not sure why though; I
> > didn't see any consumers of the attribute. Oh well... We use it now
> > since shared extents are supported to check if an extent marked shared
> > is actually in a shared partition.
> > 
> > So TLDR; I've removed the "read only" part from the commit message. But
> > let me know if you think it should be re-introduced?
> > 
> > I agree with what you said about it being important for a user to know
> > whether a partition is read only. Some things to consider:
> > 
> > - The partition model has no precedent for a DC only attribute.
> >   dynamic_ram_1/ currently exposes size and qos_class, the same two that
> >   ram/ and pmem/ expose. Adding read_only there would be the first
> >   attribute that exists for one partition mode and not the others.
> > 
> > - shareable is in exactly the same position. It is gathered and used
> >   internally but not exposed anywhere, so if we are adding one of these
> >   back we should probably decide about both.
> 
> I vaguely recall the discussion on this ending up with we'd call the
> partition something different to reflect the extra property.  
> 
> dynamic_readonly_1 / dynamic_sharedram_1 maybe?  Argument being
> that these properties are as different from normal RAM as persistent
> memory is.
> 
Yeah I think we discussed making it its own partition mode but I don't think there
was a strong consensus, just that we agreed it should be exposed somewhere,
somehow...

I am leaning towards just putting it under dynamic_ram_1 even though
these attributes would only exist for dynamic_ram mode:

/sys/bus/cxl/devices/memX/dynamic_ram_1/shareable
/sys/bus/cxl/devices/memX/dynamic_ram_1/read_only

Mainly because if we go up to 8 partitions, we would have
(dynamic_ram, dynamic_shared, dynamic_readonly, dynamic_shared_readonly) * 8.
And NDCTL would have to know how to handle creating each type.

I also don't see anything in the code that makes it terrible:
- each partition mode has its own attribute array and visibility callback
  function, so it doesn't affect ram/pmem modes

I brought it up because I wasn't sure if there was a specific reason why
shareable and read_only weren't carried over after the partition
rework. From a code standpoint, it seems fine to me?
I assumed it was so all partitions would share common sub-attributes
but I guess I shouldn't have assumed...

> > 
> > - I don't think the DSMAS Flags bit 6 (read only) is specific to DCD?
> 
> In theory yes, in practice there isn't a path for non DCD to actually
> get the data in place and transtion to read only so maybe an expensive
> source of zeros?  So yes allowed but not much use to anyone so we
> won't see it.  
> 
Mmm very true. You might just clarifying this point here but just to make
sure we're on the same page: I dropped the R_O part of the series and deferred
it for the future because it includes implementing write rejection for
r_o partitions which IMO can be done after the core functionality is in.

Thanks,
Anisa
> >   It describes any device scoped memory range, so a read only ram or pmem
> >   partition is expressible in CDAT today and the driver ignores it.
> >   Maybe it should be exposed in sysfs for every partition
> >   rather than only on dynamic_ram_1? Which probably makes it a generic CDAT/partition
> >   patch rather than something for this series.
> > 
> Jonathan
> 
