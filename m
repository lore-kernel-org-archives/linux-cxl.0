Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1692D12EE
	for <linux-cxl@vger.kernel.org>; Thu, 26 Feb 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098682; cv=pass; b=X+DdDFPB2AP/aZgH2OiGBVw0GX2S0QWR4769eH/wxOvymk58f1uk+qtAwK/g5Fypb7PDQGtBRiMwBmKed+SopSfMzqwa7t8l8KohFFi+++x0fzLM17+Xov4ByM5m8aEqgLpWhJIOOGb28ckAS6RfxGYxOMLUiFQYwlc0DrrFwkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098682; c=relaxed/simple;
	bh=0/SDumAlYUS1H3B4uzTA8O/Qk+mdYqBeIVg5I6GRmVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msug85mIpxtazOUfqJF1tj/LZAu/kdyV1t/kyRoykW9KaSwAHhhMmLw3fUpRcr2eJSfvD53xzAtYhj5PxM3p67u23aWKDLZuVS6cO63XOCbL3dj3cL+cp2AbbJmtCEQXmb3SmpXVvXFNVvod0bsrDFWU0hZqKfsGGN0xKdsfmzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=cRpCSMbS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="cRpCSMbS"
ARC-Seal: i=1; a=rsa-sha256; t=1772098668; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IXkXGEBPc5KIyp6nnTshJ2Y4VJccxE+KKGlXjAWjKnvc1qnHSJdVHHMH9ZwkZIqUfqC9jc5AHAc+bIP+kpXk/dMVy/7B1BoQzvXtRMaDpLpWhGxI9GJh4WXtI7yTaFBwiRQFoz3GM4oftimgNnIkP6a14xnZ2kofN4p3yrzCweM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772098668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lLhDUjSNe4fNWHCmjCtbhXVRGnLRFq4fXPZRbX4uj8w=; 
	b=npfIIyV3zBoXni6jXjDclm7EpbaEoWAgSx2w6x4BNsIqB/otvfV2CBfepKXxieptznftQ6MdJKTTZwRcy7jQ/bJeOkXSoQIf2xaeUh2DrspHbybiBIniU4HY9GSvag2zXiXkjI4X8VI1LCAioX1ma+1napP38aSgiqGso4Ay+P4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772098668;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=lLhDUjSNe4fNWHCmjCtbhXVRGnLRFq4fXPZRbX4uj8w=;
	b=cRpCSMbS46H2tPG6jucVmZ8b+JVf7Pg1gxLwZ1fUHDu3CzSI0/kro26ORXIOUpcb
	Hma3LszaXq1iZw3knspPmPacmNoKc9LTUV4/8MH18UIqfdBYsijuwa40aBEgWHo0s2G
	h9ty94Q3lhe0YddUc8nemZmJpicO3dcuhvXoxm+8=
Received: by mx.zohomail.com with SMTPS id 1772098666649910.593217473059;
	Thu, 26 Feb 2026 01:37:46 -0800 (PST)
Message-ID: <3a0fb6cb-e293-439d-9977-66b188a2ceb6@zohomail.com>
Date: Thu, 26 Feb 2026 17:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260225220251.1708089-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260225220251.1708089-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122847836b38baa21650473f82690000912af76d9e537930bd5adc6d19bad7e8b6d632c6aa29976f2553:zu0801122728fd71fec1e4ded4231f3b160000000265eae362f60d36577e5018dfb1ef2aae47e78d6c17deb2:rf0801122d3d03849622ea6b9a92e2a9bc000011453a8c427665d78ad90a3964e9d62857cc3da3caa3e538705a483b09ded9:ZohoMail
X-ZohoMailClient: External

On 2/26/2026 6:02 AM, Alison Schofield wrote:
> cxl_detach_ep() is called during bottom-up removal when all CXL memory
> devices beneath a switch port have been removed. For each port in the
> hierarchy it locks both the port and its parent, removes the endpoint,
> and if the port is now empty, marks it dead and unregisters the port
> by calling delete_switch_port(). There are two places during this work
> where the parent_port may be used after freeing:
>
> First, a concurrent detach may have already processed a port by the
> time a second worker finds it via bus_find_device(). Without pinning
> parent_port, it may already be freed when we discover port->dead and
> attempt to unlock the parent_port. In a production kernel that's a
> silent memory corruption, with lock debug, it looks like this:
>
> []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> []Call Trace:
> []mutex_unlock+0xd/0x20
> []cxl_detach_ep+0x180/0x400 [cxl_core]
> []devm_action_release+0x10/0x20
> []devres_release_all+0xa8/0xe0
> []device_unbind_cleanup+0xd/0xa0
> []really_probe+0x1a6/0x3e0
>
> Second, delete_switch_port() releases three devm actions registered
> against parent_port. The last of those is unregister_port() and it
> calls device_unregister() on the child port, which can cascade. If
> parent_port is now also empty the device core may unregister and free
> it too. So by the time delete_switch_port() returns, parent_port may
> be free, and the subsequent device_unlock(&parent_port->dev) operates
> on freed memory. The kernel log looks same as above, with a different
> offset in cxl_detach_ep().
>
> Both of these issues stem from the absence of a lifetime guarantee
> between a child port and its parent port.
>
> Establish a lifetime rule for ports: child ports hold a reference to
> their parent device until release. Take the reference when the port
> is allocated and drop it when released. This ensures the parent is
> valid for the full lifetime of the child and eliminates the use after
> free window in cxl_detach_ep().
>
> This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
> devices present.
>
> Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>

A minor comment below

> ---
>
> Changes in v3:
> Scope fix as a lifetime guarantee btw child port & parent (Dan)
>
> Changes in v2:
> Remove stray blank line (DaveJ)
> Rebase on 7.0-rc1
> Add Fixes Tag (DaveJ)
>
>
>  drivers/cxl/core/port.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b69c2529744c..09fc08205ed5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -552,6 +552,10 @@ static void cxl_port_release(struct device *dev)
>  	xa_destroy(&port->dports);
>  	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
> +
> +	if (!is_cxl_root(port))
> +		put_device(dev->parent);
> +
>  	if (is_cxl_root(port))
>  		kfree(to_cxl_root(port));
>  	else

There is a if-else block to handle cxl_root case and non-cxl_root case, maybe we can move this put_device() into this else block.


Ming

[snip]
