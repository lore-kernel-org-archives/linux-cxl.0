Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48913B7AE
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337536; cv=none; b=jwpYgdgmH5qeOC3BJYP37aE2ZFxGpUzHC8okq0hKbdo+cRKX9PTgKGjsbaEpWy4PrK8p1/jH7jI/QxDABxBUBxwcNZmG9MfiGkO3n+nMYmQUHNiiLFEAC+l0p9vUel8GT2AAdmTiU8O+Fhf+qK4zPChK8X83f78loO/ujVK7Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337536; c=relaxed/simple;
	bh=smK0ZCMjZ6Vhkm8UF51OmR5oAvAHhr+cC6/47j8HtP0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BXLS4c5Ouhu66r5VPJ1nXTwCPULbEGOnIbQWM8+XF9lucL7uFyntQmC5HWHRasV6axLX50zg303zNTjB2ABzjaJZ0mDFHc1RYgxtF5PUP3IsFJk56zgQRv7Q7zcIc3QbNYFK9uMaacut1EpM3LUriLf+yaPlVTpyMefgBeJOryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHhDnszs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHhDnszs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789FF1F00A3A;
	Wed, 24 Jun 2026 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782337534;
	bh=4KIAynZXmsDBENs3FR9yg8HqY7lczD4nP2hsiHqp0Og=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fHhDnszsfeTVWePACd7YNWZZVv7YwzXC+nYw5p52EBkkjNBK3ZJpeB5X3pY5CZWP2
	 0L1APTkFpgIRy/FOTL+f6TuDj38s9rGTBZGnvEJUVOv8dgOmaCa7vsL7hMOP5MlN3j
	 whrvue2Lk8fnXM8Xg7cs3CXPtZecN2tX76wOkqoAUFTC3CpM3riaRjXgYeHNiiElPU
	 PZgSRKDlxZdbbq7T2eLsEfSd5OQXKheBc2zZ91dbgL2vy/25IDwfHK/a5thRFg9JOQ
	 N4IxJRFTOSOHWC3fvPXZwSaDw5uNVKOXp0+FSL9WgtUWb22GO/xNLtJky3W32jUj4D
	 /gjwddfvOQDRQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2C06F4007E;
	Wed, 24 Jun 2026 17:45:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 17:45:33 -0400
X-ME-Sender: <xms:_U88arNO9Fuvo6_jYHPwcfa_8VzdaEIMaJsohSIt_Ox0FyDvxwG7cw>
    <xme:_U88atZLkB4dCnfUqvCqO3NhutmN2Z9zYqvZzeb56XcVAC7ZeCN22dbImipkvQFxX
    NiD6mj2sa6d_sSyhFeLywPtM1s7LASFG33KdDyjp24vfe96SDDmHdEi>
X-ME-Received: <xmr:_U88anqWWFmowk147_gArk1CV0w9uWE3bbPUpHRzTUv4Ic9WzWTJZovVC4jwwdsyjHRATPgR1scMSdCeWHLEo_Vdy8R1xttwl0M>
X-ME-Proxy-Cause: dmFkZTEQ9GiK483u4+eLMgim2D8qp68ht3Sx8LZ0SbuSZyRKxUvO8XA8UDsKJFBgu7wmay
    lnqsi6usUvsT5fe66mOmMtjwLc1oNXQQGhb0Ws9O9PHj5B2Je5xOcXT2ZD8N0FuXzDn+Ky
    vju9q9RAty77yeNOKP6NxZBFY81LnfYMECseuGTO2kCF5+++3RWEan3chlIgN5ApGcOu6/
    VH7dXG759NQwgbAYQylKL+UcMhnCPT2pPuwSBwVwpzHIZPY4+Z0kHG80wwjpcqm6+G6BEg
    5Jn+AeAtnoeDFhJGLd5ALqESnN3HkmdwIA9NYZey971se/cuXmucexbbHmoDYrjPLbi9BD
    XqbJoVQ0LrO4eND+c9lKlb+Sj9dHiJyCCDZk8wADG3xakzm5jTYHesskQ1LWbji8ztXEIK
    2PFi3v45BGr4xNaHYCb6JHwAh3MRBSICbhpOJMwGr5NWoNg5lxW6Fojh1fXd6wskX/xTd/
    uUTIP6x0eElg7KkpxKMCDCaBnos9TGNVfR0YtFf894EF7Gv57HWGIavMjBjBnyxodpS4Pz
    lRvGepW33JEuW1EASf4HxPHVFCROzxKCbVcuG5MVL6GcB6Kk2N4GkG5wLtlwr+a4UJ/xT6
    gvmsAX/5ZNcSxpuMvbxe8wBsgsJF1NIkqF1JpvAZ/Yvb36Yjd5olDLfSl1UQ
X-ME-Proxy: <xmx:_U88apYxLA-JhB2I2P9dlAIkyG1XJav0ZyRsXN3ZlQlunmZ2Sh2vow>
    <xmx:_U88anRcB181y028oYyqBv2LuUjEHl3FJlPytX-o0HiT8Clz2mHkaA>
    <xmx:_U88ao4WtPD51Szw-L8ytuCXEf7ksxkY8L-sohcpeejLivMkpJsfNQ>
    <xmx:_U88akw4rKVCQ-uJhrVMlGJCliQP45ajDU1obtUyzLCIyj0iiCUKig>
    <xmx:_U88avQAJ3bG1BjqBTSuyHQwNI3rH74s9EUjfTrWZH_OB-DAOUSRgjye>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 17:45:33 -0400 (EDT)
Date: Wed, 24 Jun 2026 14:45:32 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: sashiko-bot@kernel.org, 
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
Message-ID: <6a3c4ffc36c36_f123010054@djbw-dev.notmuch>
In-Reply-To: <20260623124055.291BB1F000E9@smtp.kernel.org>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
 <20260623124055.291BB1F000E9@smtp.kernel.org>
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

sashiko-bot@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Resource Teardown Ordering Violation in efx_pci_remove
> - [High] Missing Hardware State Restoration for CXL HDM Decoders After FLR
> --
> 
> commit cd561fb9993e195accb646b7a8524a13a2dd0b79
> Author: Alejandro Lucero <alucerop@amd.com>
> Subject: sfc: obtain and map cxl range using devm_cxl_probe_mem
> 
> This commit introduces CXL support to the sfc driver by creating a CXL
> memory device using devm_cxl_probe_mem() and mapping the CXL range for
> CTPIO buffer usage.
> 
> > diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> > --- a/drivers/net/ethernet/sfc/efx.c
> > +++ b/drivers/net/ethernet/sfc/efx.c
> > @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
> >  	efx_fini_io(efx);
> >  
> >  	probe_data = container_of(efx, struct efx_probe_data, efx);
> > +	efx_cxl_exit(probe_data);
> 
> [Severity: High]
> Does this tear down resources in the correct order?
> 
> efx_fini_io() calls pci_disable_device() which disables memory decoding for
> the endpoint.
> 
> Because the CXL memdev and its sysfs interfaces are managed by devres
> (created via devm_cxl_probe_mem() during probe), they remain active until
> devres_release_all() runs after efx_pci_remove() returns.
> 
> If userspace (e.g., CXL utilities, udev) accesses the CXL sysfs attributes
> in this window, the CXL core will attempt to read memory-mapped component
> registers on the disabled device.
> 
> Could this result in PCIe Unsupported Requests (UR) and a fatal AER fault or
> kernel panic?
> 
> >  
> >  	pci_dbg(efx->pci_dev, "shutdown successful\n");
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> 
> [ ... ]
> 
> > @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >  		return -ENODEV;
> >  	}
> >  
> > +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> 
> [Severity: High]
> Is there a mechanism to restore the CXL HDM decoders after a Function Level
> Reset (FLR)?

FLR does not impact CXL settings.
