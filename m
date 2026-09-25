Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7C3E559A
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377666; cv=none; b=ECRE6m2w4c80OBP2DpTHQrbOPcnfhxTgI/bFDnKbi+Z0jJLRWdj0ki9aDiUywdbOE+SlqWjdS/HOnMGE3K48NPcE/6b54HwRGKGPZHglgFd7JnB4l7bsyDBUd56eEE3KDq+nz2lcAUZ/tbj3WCvx/u/2ox95zLvkliWQjl9WHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377666; c=relaxed/simple;
	bh=shUJrpvqV+6xIHr046mZAVP02M+Vrhne5D8tPeGJOvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZjMveK+pM/1KOm/+WbopCCf1GKxay3h8wwBcWQ3aUsbAuG0BZ6FUJJsX+RcuMLumqaT1giC+RKl10VKt3TyGX8mGJbAP85fw2rz8BGlMCa0k7QuV7tHVHqMOTXnMWY/ZNwiAKHVpDxGzNgvx7T9p3AiNLP55gy00d8GMiPsG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZq+vaZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZq+vaZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76201F000FF;
	Fri, 25 Sep 2026 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377664;
	bh=bqTFWV71aLVU8qQaKxf8tnjgBFXTIkBK6SaG/+OP+eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EZq+vaZkKysGU3FUeFpWLT0JLKptEhgIBYe/MPk0d6wgLn4SPG6SiRMUamV5Yd7r4
	 XZpNvn1ikpDKQi9F1Et2FZu4QnbCBlm9ayG+faZCkHM57PhsADhtO8UxBDAAXu/u+q
	 toEFuK7WmFQDT6RoUTPOgJqgvTynP8cTbDiOk+UasO+/GCM9FTBJPBFzXkuD2UgSXC
	 xxGSxotlCXNS1fsS2fuCDOqCPP1qEQ9xaooissNQ0qIuI9sv38XXSu4GB4gCjc4InA
	 v2WGaHOhfHZwbw6eVLTeAsSo9l45RsbRdHdNDVnqa8xlHf17TIrtTZCdh8La4MYrLv
	 4XwHSbpq9XMVw==
Date: Sat, 26 Sep 2026 00:07:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, ming.li@zohomail.com, icheng@nvidia.com
Subject: Re: [PATCH 2/2] cxl/core: Hold the dport host lock across dport
 lookup and use
Message-ID: <20260926000741.7cd17073@jic23-hlaptop>
In-Reply-To: <20260924212159.52920-3-dave.jiang@intel.com>
References: <20260924212159.52920-1-dave.jiang@intel.com>
	<20260924212159.52920-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 14:21:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
> 'struct cxl_dport' that is already freed, and all four dereference it
> without the lock that would prevent that.
> 
> A dport is kzalloc()'d into a devres group on its host device, so it dies
> when that host unbinds. The host is &port->dev for a switch port and
> port->uport_dev for the root port.
> 
> Both helpers return the dport through an output parameter. The caller's
> port reference pins struct cxl_port, not the dport allocation, and the
> lookup itself is a bare xa_load() under no lock.
> 
> Add cxl_port_dport_host() to name the device that pins a dport, and
> cxl_pci_find_dport() / cxl_mem_find_dport() to look one up with that
> device's lock held and asserted. Convert the four callers to use them and
> bail if the dport is gone. cxl_port_add_dport() already follows this rule.
> 
> cxl_mem_probe() chose its endpoint devm host from dport->rch, which meant
> dereferencing the dport before taking any lock. Use cxl_port_dport_host():
> rch dports only ever land on the root port, so it selects the same device
> without needing the dport.
> 
> Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> ---
> Found by review, not from a failure report.
> 
> Untested: two of the four converted sites add a new lock acquisition, and
> neither executed under test.
> 
>   cxl_pci_setup_regs()        new guard() sits behind is_cxl_restricted(),
>                               which needs a PCI_EXP_TYPE_RC_END device
>   cxl_handle_rdport_errors()  needs an RCH dport AER error; cxl_test has no
>                               injection path
> 
> Only cxl_pci_setup_regs() introduces a lock order lockdep has not already
> seen: device_lock(&pdev->dev) from probe, then the dport host lock.
> 
> cxl_handle_rdport_errors() nests its new host lock inside the
> device_lock(&cxlmd->dev) that core/ras.c:274 and :298 hold, but
> cxl_mem_probe() takes that same pair in that same order and ran clean under
> PROVE_LOCKING, so the edge itself is covered. What is untested there is the
> path, not the ordering.
> 
> Reaching either needs a cxl-type3 attached directly to a host bridge so
> pci_pcie_type() is PCI_EXP_TYPE_RC_END, which run_qemu.sh does not generate.
> 
> Tested in QEMU with cxl_test, PROVE_LOCKING and KASAN on, 8 module
> load/unload cycles with concurrent sysfs readers. No lockdep splat, no
> device_lock_assert() firing, enumeration unchanged (15 memdev, 12 port,
> 192 decoder before and after).
> 
> cxl_mem_find_dport() ran for 15 memdevs on each of 9 loads, covering both
> cxl_port_dport_host() branches. The rch branch is covered too: "cxl_mem
> mem2: endpoint9 added to root3" shows the new selection picking the same
> parent dport->rch did.
> 
> Not fixed here, found by KASAN during the same run: emit_target_list()
> (port.c:158) dereferences cxlsd->target[i]->port_id under only
> cxl_rwsem.region, and cxl_dport_remove() (port.c:1091) never clears those
> cached pointers, so a switch decoder target array keeps dangling dports.

Given that is I think what you fix in previous patch, drop this paragraph.

> 
> Same bug class, different mechanism - a stale cached pointer rather than an
> unlocked lookup - so it wants its own patch in dport teardown.

I think the fix is good, but one thing about wording of an
explanatory comment inline.


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..508f590a08c4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -701,6 +701,18 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport_dev == port->dev.parent;
>  }
>  
> +/*
> + * The dports of @port are devm allocations of this device, so they live
> + * only as long as it stays bound to its driver. Hold its lock across any
what is 'its' here?  Also 'this device' the one returned? Perhaps.

Return the owner device of the devm allocation of dports associated with
@port. device_lock() should be held for the returned device 
across any lookup and use of any of these struct cxl_dport instances.

> + * lookup and use of a 'struct cxl_dport'.
> + */
> +static inline struct device *cxl_port_dport_host(struct cxl_port *port)
> +{
> +	if (is_cxl_root(port))
> +		return port->uport_dev;
> +	return &port->dev;
> +}
> +


