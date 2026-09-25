Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A02F28EA;
	Fri, 25 Sep 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367862; cv=none; b=I9abYb6wGx9gWLEtR89ldnCzMc6uRODkYpAAEr1ZiUpOJlxzRUUWImgs2/QKdEcLCMRPH8kiFfg9hrZ1c1KJqzqvPk8TkGjcm07eUE7Twds1BEmmKtPZSXNuNVLti81q5QaweXxSTOV+ra1hmowjiCz+/DqmkIHbCOqPRB1UtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367862; c=relaxed/simple;
	bh=MHlQd2XbQytBoR/Ha15LXYbuOf0bTeI6LB/v3kZlZPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if1PUgEA/3FT/YDL175w4sH4yXBMygKJtRYEWJjebBi3HhD1XBjgVzdyXKoRTEmpD0jw+YVVFKnqRbFKHauz+QKuPvW7KQsCBIheDsP0KJlqC/r9FvZgWxtyU/c3sbmTbtqBJmpOp8e0VNmXhB3wgGtR/vszu7H6GYwFF191H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HElSgzBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HElSgzBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0021F000FF;
	Fri, 25 Sep 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367860;
	bh=oxlPviVpyBt7kVpYbPTzuJIJu58P7y38V+6UNjHDCnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HElSgzBsZMr/m1tDdBPoCxKivOicPmOhj98BCOqnm3VKsah4u2AN0fnzOAAQKa3cF
	 +0lAnlG9IySujeCypSuUwQwiAXWPcEQ6w3ViyJZ+8te815UeDHFrZQmVh6laFOV7Iq
	 vJ3A/V9TjBVnBFO4phgCS474Qjt2I9ngBtJql/vBnRa6QTVo5eJN+0fzQnZrzex8uV
	 QVAhEwPaRtCs0W3Z27BtkE6LVz2f9IMlkMOzPkydo/mBCZBNNtJuqTPeOPqwJZq9eF
	 D66dukyTwG4i4JHShQSCkXVuTzdGQ9hG8Ul6vBfUDXu12kh5Yv9+quKUnxzcXopfns
	 BCYKVDiwbc2Qw==
Date: Fri, 25 Sep 2026 21:24:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Cc: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
Subject: Re: [PATCH v1 4/4] sfc: add multipf support
Message-ID: <20260925212415.1672622b@jic23-hlaptop>
In-Reply-To: <dc8fdf95-4cca-4dad-bed0-4f7b3c6eb64a@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
	<20260921191239.4249-5-alucerop@amd.com>
	<20260924021535.3e55e8cb@jic23-hlaptop>
	<dc8fdf95-4cca-4dad-bed0-4f7b3c6eb64a@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 12:16:56 +0100
"Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com> wrote:

> On 24/09/2026 02:15, Jonathan Cameron wrote:
> > On Mon, 21 Sep 2026 20:12:39 +0100
> > <alucerop@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Use CXL core accelerator API for registering non-PF0 PFs to the memdev
> >> linked to the PF0, along with its complementary unregister.
> >>
> >> Adapt the ioremap call per PF to be an offset based on the PF function
> >> index and a hardcoded per PF CXL.mem slot size.  
> > I was wondering how you'd know what memory belonged to which one!
> > Simple solutions work best I suppose :)  
> 
> 
> Hi Jonathan,
> 
> 
> Yes, I think nowadays it is simple. I'm afraid if CXL usage increases 
> this will require some request to the firmware ... which could depend on 
> previous setting requests to that same firmware through fwctl.

Ultimately I'd kind of expect either an allocation mechanism where
we tell the device which portion of memory it has (nice if that was
shared architecture rather than a per device thing), or a way
to discover if in practice it is fixed (like here).

> 
> 
> >> +
> >> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
> >> +				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
> >> +	if (!cxl->ctpio_cxl) {
> >> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> >> +			&cxl_pio_range);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	probe_data->cxl = cxl;
> >> +	probe_data->cxl_pio_initialised = true;  
> > 'map' is carry quite a lot here that isn't really about mapping anything.
> > Maybe think a bit more on the naming?  
> 
> 
> Not sure I understand your complain as ioremap is being invoked here. 
> Maybe cxl_iomap or sfc_cxl_iomap as this is a static/local function 
> would address your concern?

The cxl_pio_initialized doesn't have anything to do with mapping as such.

> 
> 
> >> +
> >> +	return 0;
> >> +}
>
> >> +
> >> +		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
> >> +			kfree(cxl);
> >> +			return -ENOMEM;  
> > ENOMEM for a map failure? Seems a little odd but if there is precedence
> > fair enough.  
> 
> 
> Confused here. I can see ENOMEM being a common error if ioremap fails 
> through the kernel. Maybe this related to your previous concern about 
> the function naming, but cxl_map can only fail in one way and that being 
> not different to an ioremap failure.

Ok. If it's common choice than fine to stick with that.

> 
> 
> Thanks,
> 
> Alejandro


