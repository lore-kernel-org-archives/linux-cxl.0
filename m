Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33B25948B
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033134; cv=none; b=VV8kGGbXC8fR9kXax4nE3+AqzHRfuS/kPcgw2K5jGCXWkLngdphjdXqzR3KchVsnKG5ZCUctMjcPe7OEP/9OtwjGlZn6MFxafmyXq5zYk3ZdNmRexZb1Lo1gkg+s/MsxBNNRC5TP1eDM7qyxEPHwzYx1pCCyN1JXqf00qDNmf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033134; c=relaxed/simple;
	bh=FgxQudu3r8oc2/55lCD60dlwh7jGgQhqLK5z0UpSMig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaAaAkvO5Su71VvB7Rl2MXEwN3M3TG4QFkXwUNGZm9edk0UMVxqvdYDFjkfSxRNtOOs4NiN9hz+F6Pa3gV7A+BPDJZwVb1xsCseP6GZPUUXZ8yY5jmFErcywCCzKWCZFq6Rg6lbBaUPImZHQXOkFt03sNSK8sVltJcStp37y1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iCjLr0Fd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iCjLr0Fd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6c3629816so47258285a.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734033131; x=1734637931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJV3UCNwEAe2Dr+yRJd54EBGWomKGB6Lx2nk3vQKPSg=;
        b=iCjLr0Fd1eYG2mb2cN/UBkx07N2eqMBUfJ9G0AeodUbMjkGwoxz7cspvyvqgYyNpfV
         U4FpWI6k+bNWdCs6WU/nGRuwFTEtTSk+2Tfm4vd7NStYnen23XwP55ptU2ZLFP06hOM2
         xudwJKO8aPweaMuW/P6mxC1TfIiEHc1pLAObZA7shmbKSm8rPRDj8fZD/w00xDPAgjRF
         z6TZmF+bTFlJn4ZIVoMwCQJsjFXKJyzNN5BuwmVghbUB1C6LjreIARZHDp71SpNVT15U
         nlF6Sgew4fpshX1IvZGCfnSxjL68fwvG00aV/+K7tRlXhXPq/I4ztS5RcZUS/Zx2i61C
         H1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033131; x=1734637931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJV3UCNwEAe2Dr+yRJd54EBGWomKGB6Lx2nk3vQKPSg=;
        b=CEz8ZC59KNnLUIy324NAgbfwSN5LyR2+xxoz6dSVLMHG0qN5pxv54SZXUi/PDTc5Ml
         gPMCv1FthxJPnSQioOCnbp5HdesG+zzNbePYCyScQP3yr2GejIYNTI+yG33Ume2H3Ead
         VCBFhrg3fZ921BmowIfrzctJ8yJYgiKhFbUWMqFAEFenIzFP60keNT8I2XQSgXZK/ev3
         xWEjjGATns8eC0oTBOUSxaJqARSNy4W84e0d78FkdHcauNgv0WlvlNkHIdxqIXABwBO1
         bypw1YQRhct9rLfoJw/fXTnO7LrDHrH7tb5BKKMYYmB9YU8KGxfVp4aijmUXWERmRKCJ
         bD6g==
X-Gm-Message-State: AOJu0Yyv8qduEFVC6sJBVMKNNm7PjB8pN//IK/+EB2zkGN362VZ8OYrp
	e9Z+ytKAHb661kG8VpCSULieR8IIqhcIvbVc0FLUs1bJ1sFqYAg5JiEsE2Lpsw0M/iFYx51Oc6r
	b
X-Gm-Gg: ASbGnct5BrC4oYr4aZMieuuUIyC4INniTj0+8spiWwtYYUz+D4dlK7NBI/h2SWdS6Vy
	zZkYdQ9pBUW3zCRH3bdlcmzwATrqXjCMKltPcPLvjRdbzZBLXHKB4UqfOx4foHqbzOUtYUqM5z2
	nq19BXCsRS9ewLUWEKeuxpadCu482qo9OnkXyZcSgQT/eLqVhuOCh3NAo/MHcTEDczjb1Yn9sh3
	6Tl4tOxHBYWfrMSB2frjQNRumii3NpUPiCbNllFVd8GCUidaoRclWTFmQbDvcP+QNN0OTERzFni
	IWo31BQmYuQOUs7S3bapxOd2yooiRnN4ndri9ru6gQ==
X-Google-Smtp-Source: AGHT+IFyiPL6K5AGYOLsd4p9hQzVnmuIR8XXj1rvfykXI+mzn70MxmL/wiXnotUopZJ8xPiRXmnpjA==
X-Received: by 2002:a05:620a:46a6:b0:7b6:7618:d7ce with SMTP id af79cd13be357-7b6f88d08a6mr356836385a.10.1734033130823;
        Thu, 12 Dec 2024 11:52:10 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f25b2155sm116397185a.91.2024.12.12.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:52:10 -0800 (PST)
Date: Thu, 12 Dec 2024 14:52:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20241212174016.0000002a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212174016.0000002a@huawei.com>

On Thu, Dec 12, 2024 at 05:40:16PM +0000, Jonathan Cameron via wrote:
> On Fri, 18 Oct 2024 12:12:52 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > From: Svetly Todorov <svetly.todorov@memverge.com>
> > 
> > The shared state file only needs to be intialized once. Even if a guest
> > dies without clearing the ownership bits associated with its head-ID,
> > future guests with that ID will clear those bits in cxl_mhsld_realize(),
> > regardless of whether mhd_init is true or false.
> 
> That sounds like a race condition if not all hosts are brought
> up before the first add.
>

We weighed this against having to do an external setup like

# SHMID = ./create_sharedmem.sh
# ./launch_qemu --shmid=$SHMID

Which is what the original non-generalized prototype did.

So yeah, there's a race condition AND a footgun (setting init AFTER
qemu instances are already using the memory will blow the state away).

This was intended.

As you allude to in the next chunk - the only real way to get around
this is to have an entirely external process serialize access.
 
> > 
> > The following command line options create an MHSLD with 4GB of
> > backing memory, whose state is tracked in /dev/shm/mhd_metadata.
> > --mhd-init=true tells this instance to initialize the state as
> > described above.
> > 
> > ./qemu-system_x86-64 \
> > [... other options ...] \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > -object memory-backend-ram,id=mem0,size=4G \
> > -device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
> > -qmp unix:/tmp/qmp-sock-1,server,nowait
> > 
> > Once this guest completes setup, other guests looking to access the
> > device can be booted with the same configuration options, but with
> > --mhd-head != 0,
> > --mhd-init=false,
> > and a different QMP socket.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
> 
> A few trivial things inline.
> 
> In general the scheme looks workable but I'm not sure the contraints at setup time
> etc are suitable for an upstream solution.  Certainly a useful tool to have
> for kernel development though so I'll try and find time in next few days to apply
> this on my gitlab tree.
> 
> Longer term I think we need a more complex external program or a main / proxy
> type arrangement so that ordering requirements can be enforce

I marginally disagree.  We have to check ownership during memory use.

We should try not to have an external process dependency for deferencing a
pointer backed by an emulated DCD device. The current overhead is bad enough.

The shared memory use here mostly limits that overhead to cache invalidation,
and keeps the entire system fairly simple.

All this is to say - we err'd on the side of keeping it simple, even if it
has a few stupid footguns.  Obviously open to ideas, though.

>  and we can have
> richer info.  Having to chat to each qmp interface independently works fine is
> also a bit more complex than I think we would eventually want.
> 

This is a small component in someone's fabric manager that translates their
requests into QMP commands.  Whatever we ultimately decide on, the complexity
here is about the same.

> Having a solution in place though will make it much easier to move towards
> an eventual upstreamable solution. This is a great place to start from!
> 
> Jonathan
> 
> > +/*
> > + * We limit the number of heads to prevent the shared state
> > + * region from becoming a major memory hog.  We need 512MB of
> > + * memory space to track 8-host ownership of 4GB of memory in
> > + * blocks of 2MB.  This can change if the block size is increased.
> 
> I'm lost what makes up that size?
> 

I think the math is wrong here, we may have calculated based on
a larger capacity.  I need to go back and look at how we came to 512MB.

~Gregory
