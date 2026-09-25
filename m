Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EC369D5C
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379172; cv=none; b=JsB8RG32TCT46fr36+Oz4MH2Q5o3T4Mt2xVaE4SsD39JRPGwBGZoM8vCsy9xoJRKS+VCj8IR2o+gBCL0/L4Gvg1NstajeGDFQEaIRop9W0SrU0KLcpSKEMJtq0kxAMoBDNlpXGkIPJkmUIoFgL+LG/RjXJ0JcHcPYEl4VCUracg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379172; c=relaxed/simple;
	bh=JQyn7JUo7iHdTTjnsjflPRLM01mT3aUq02W8Iu7384M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJFFsaTFn/+OZrWS9bcussvSFFL5UQJlGMmhOnfsjSDo2zct0M+k0Vpcxuptm+uhiEQesVnI36A3Ml8JcVpLwmXiH5KYySubB4Wvb6adStTGhtuXkv1MED4Qbu4X93+gMR+gV2GYI7rogCQdAJJiI75Cp74nSHTANAW4RdPvhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGdPQ+yQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGdPQ+yQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0781F000FF;
	Fri, 25 Sep 2026 23:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379170;
	bh=ZV0CzkM48aHVhQ6N2tp/P/4kEzGGW2SGsGRI+5C8svk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SGdPQ+yQ5kBfDNoyZEDFEWej4O3LkSEyKwWYfDpAaq4sI//7vFCR9kou19161YMQK
	 9GFh+evgJlTBqdzeBErHuEt9Jsqy3dJD8O1PsqvppABTyddz+pLxyVsyma7XaklMmx
	 IuWfH6y7h5kyXGt/unVKJFwzDZ3ZAo+ffWI9rjr0ZDyQaAYE9hn/C2cii/Tkpq+Wu3
	 gk5Q70YEsD8ePS8aXCY1OHJ3ojUtMYq4OenA+DHJQuyP2e43GQuLLXVluZDX6Qvj6w
	 A4cxUZ0spoxEGjykhqSqydIzHvfWtu/ZMqhrgKNL1cSAIOfuSNst3hpWz93CyS2XVe
	 I6qcomTOM+aPQ==
Date: Sat, 26 Sep 2026 00:32:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20260926003246.52b0c2e3@jic23-hlaptop>
In-Reply-To: <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
	<d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:38:39 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Setup runs from devm_cxl_endpoint_decoders_setup(), between the
> port's HDM state and its decoders. Registered there, its devres
> teardown brings BI down after the decoders quiesce and before the
> HDM state is freed, and BI is settled before the decoders, and later
> the regions, are looked at. The BI-ID and path enablement belong to
> the endpoint port's lifetime.
> 
> Setup is safe in endpoint port probe context. The port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
> 
> Dealloc is safe in endpoint devres context. Both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
> 
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
> 
> Likewise, the device state outlives the walk - cxlmd->cxlds is
> nulled only after cxl_memdev_unregister() has torn the endpoint
> down, and delete_endpoint() clears cxlmd->endpoint only after the
> endpoint devres has run.
> 
> Each dport is programmed by its position - the one immediately above
> the device takes BI Enable, every dport above it takes BI Forward
> (Table 8-157, Table 9-13), at any switch depth (Table 7-97). Any
> level can be shared, so nr_bi refcounts endpoints at every dport.
> Registers are written on the first endpoint and cleared on the last,
> but only downstream ports commit (Table 8-156), once per endpoint
> (Table 8-152), and a failed commit undoes its write and commits the
> undo. A USP advertising a BI Route Table that failed to map is
> refused rather than treated as absent. nr_bi counts only the
> endpoints this driver enabled, so a level can be cleared while
> firmware still has an unbound device on it.
> 
> A reset may wipe the device's BI Enable, whose reset default is 0
> (Table 8-157). .reset_done reads the hardware rather than assume
> which reset ran, and invalidates cxlds->bi, failing closed with
> recovery by rebind as for decoder loss; dealloc unwinds the dport
> refcounts regardless. It also clears cxlds->bi unconditionally - the
> endpoint disable fails when the hardware already shows BI Enable
> clear, from a reset .reset_done never saw, and the flag must not
> outlive the BI Decoder mapping it describes, which the endpoint port
> releases moments later.
> 
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing the dports that share state (nr_bi and
> the control register at any shared level, the switch USP's BI RT).
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
