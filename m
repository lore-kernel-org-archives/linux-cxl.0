Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C43AC0E5
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077783; cv=none; b=gQzKCilji7LZD6OnF/gnZDYBfdgk0n6C7hjNcxFmxRuFOvfRlJxOITs1/+XXEyUp6naDUxul5OQJwfY2pfxQubBHinmJuzU4Vv5DJ4Mqi0W+DTgfbRZwo2l+pDijLfL90sGDLpnu4fN/3BSo4i7eJHVeCOi0wzoYCHmXEP6TKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077783; c=relaxed/simple;
	bh=eFPr95sXIrSi7tenqY206spkvYTjz+NFNcQp+X+Gx44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJR9WIbPMAOnV+bdif5AtpuFKQEYZaFl5EwfYe9Rn56pNNpzue9P52X/rPPMco5I0tWcqeY2kzeREwSIE4IWWLIVNJrmwgt3eR/8q+GThrQNDWTC96+bZoSUwZ6dnUZAtR1wKnNSMe4tpxJTOgtkArTew/b8SL6vn3gyOz9no7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M99uveLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M99uveLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89741F000FF;
	Thu, 10 Sep 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077782;
	bh=Nh8zAImCNNEDvhTLqbOJ5SR953aHMQ0JdbnEDFda4Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M99uveLuWecus5kY7XZStKgaLFncfSiEWKpPbWKFdGjc3K1l/rAnrrX8BecOmPRhs
	 zU1BNPHadQV/Zspvlc2oI5Bp37Jji/Z+3UCGCJEcCsfDqkN937yjNPC59ZvApfDxNt
	 PCu7M2aQaoVQbdrJ0sNQrndpQVMV0NEZ5XXrYROgAXkeXWqRZCO8pBfEIJZXsx5rB0
	 RYqYqFj1PZwvxC9IAMM9BLM64iyxs/7I+LB3Du7u44h9FKURSN0LBJmIdv2XHgrTE+
	 mwafFolqW1DSjr1LyCU4F2s9+o6DKiGL+IcJ0IbW2vNy7s1Axsa+974gOVnCcvFcoR
	 B2g+mQMl5exew==
Date: Thu, 10 Sep 2026 23:02:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
Message-ID: <20260910230256.47075bea@jic23-hlaptop>
In-Reply-To: <20260828074752.3336779-1-kanie@linux.alibaba.com>
References: <20260828074752.3336779-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 15:47:52 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> The per-dport einj_inject debugfs file retains a pointer to the
> 'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
> the dport host frees the dport and leaves einj_inject behind, so writing
> the file dereferences freed memory:
> 
>   BUG: KASAN: slab-use-after-free in cxl_einj_inject+0xa1/0xf0 [cxl_core]
>   Read of size 1 at addr ffff88810880ac90 by task bash/1690
>    cxl_einj_inject+0xa1/0xf0 [cxl_core]
>    debugfs_attr_write+0x61/0xb0
>    full_proxy_write+0xfc/0x1c0
>    vfs_write+0x1d4/0xe60
>   Allocated by task 213:
>    __devm_cxl_add_dport+0x1e1/0x14d0 [cxl_core]
>    cxl_port_add_dport+0xd6/0x200 [cxl_port]
>   Freed by task 1622:
>    release_nodes+0xfa/0x2c0
>    devres_release_all+0x113/0x1a0
>    device_unbind_cleanup+0x76/0x260
>    unbind_store+0xde/0x100
> 
> The stale directory also prevents recreation on rebind.
> 
> Remove the per-dport debugfs directory when the dport host is released.
> 
> Found by code inspection, then reproduced on a QEMU CXL topology with
> KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
> QEMU emits no EINJ table). Unpatched, writing the leftover file after
> unbind gives the splat above, and rebind hits "already exists in
> 'cxl'". Patched, the directory goes away with the dport and rebind
> recreates a working einj_inject.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

...

> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..62a9c2038d1f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>  			 "0x%llx\n");
>  
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
>  static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  {
>  	struct cxl_port *parent = parent_port_of(dport->port);
> @@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);
> +
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);

I'd move it up a couple of lines so it is closely coupled with the setup function
for the directory.

This is an interesting corner, we don't fail on debugfs registration failing
but I think we should potentially fail probe if a cleanup function fails to be
registered thus leaving us the hanging reference you point out in the first place.

Jonathan

>  }
>  
>  static int cxl_port_add(struct cxl_port *port,
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

