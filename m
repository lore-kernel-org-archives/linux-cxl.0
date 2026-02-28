Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F751DF261
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262278; cv=pass; b=nzSg023LISsuG3OSfM5t7vdiWJhB3UfmVlbXT8agTr3vnTM42dh6gzbNBn6coODHSoZCSV8oe5mOib+sXaM+5RCJgDu6QD7MptGQWw+2joat0FGaYnPXDGxYtcoSEyueP3/XnjjPskJ8AdFIc+ClXEtSxUbWqjCdoDQTZiGjUlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262278; c=relaxed/simple;
	bh=OEHipjSwH6m4X4kLLPiFCbq1/5jwO7S6ZMVF8C64nF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZMi0W61MuDcoqiz13wp0G5buY450g9Fg9GQvm41jP9Cnd6EJDHS4wO13ef25F+OLu4w2eWQ+6FEhUU1VaAfBkvWnTiPuG8lwgSAf5EfXY0hIhmUbT39co425lm6mGeW3RfVir1mlOJQD6Gc8MyKCZYS3PGw1IOqPY00dRnTBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XAeldWyN; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XAeldWyN"
ARC-Seal: i=1; a=rsa-sha256; t=1772262263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BySFVw1YeZb+OYdcF2MJ3jePmLmkuBejqIyuK/N6jmWVdC13uXGg3NcuU9qJxbP7nRdC7VFEGq9bvsQ9Vl6Etv/skF+iFp7dEX4OU0XR9vR5QMRqJ9jNzzcAmwCVb4MjlfzzRy3KKH8HO3yjKR2wEd5laqB248kBJTGd2yvXcT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772262263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=INadkVs8zImUbuVdQf/qlDtPp30p4UklvLpMeb2qSnI=; 
	b=HdzMOss5n67Inj/jZ3s5RY55+RfDp8cpQ3JzwOA+Gl2/Y8yob1zkBBe9x3mD19VX4twTH6/8K46o3ccA2ZdFaMICQEyafosA/MnryyLwyyHMKyEoe8j4Zgp7Skbn/LYAvPLPTjuMq0jRzCbu9BuDmqcuK1nl4Nzg7UFqjC6gqyg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772262263;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=INadkVs8zImUbuVdQf/qlDtPp30p4UklvLpMeb2qSnI=;
	b=XAeldWyNxzd4yoobaPgWryhaJyMCkOcSIToGyaxrSWV5C5rpkJW59IVough6aGoD
	KpP6zty3dyoJAZ5bfBDs7j+22pZdG3RZzGpfF79GBIUnkQWdZ8pWTp08VYSM+mbqPjf
	qbinE1M8fBJiAYd7JMAJTQkGS3Ere7qh1UjYU6dc=
Received: by mx.zohomail.com with SMTPS id 1772262261018478.25519548488376;
	Fri, 27 Feb 2026 23:04:21 -0800 (PST)
Message-ID: <c3a07fee-1a91-4f7c-a279-fb15be36a531@zohomail.com>
Date: Sat, 28 Feb 2026 15:04:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260226184439.1732841-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260226184439.1732841-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228c39178cb6b1e3a7b0f12aa9000004c39277e6bdf8fe066540a88e84d7ee411b5b744c3afce5d6072:zu080112272cb6e6d49f3d4771afad0b170000bf0477e0e6d715c2d5cf1aa5632dc5c3b0708172a7902c38e3:rf0801122dbaf215986fa9ad16c47c527a0000f1c8319d2702503af746bf8d5b57906a26fdb5a71d38c800a8f776a1e3cc8b:ZohoMail
X-ZohoMailClient: External

On 2/27/2026 2:44 AM, Alison Schofield wrote:
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

Hi Alison,

After looking deeper into these cases, looks like the changes cannot cover the second case?

My understanding is that cxl_port_release() will be called on the child port before the device_unlock(&parent_port->dev). The put_device() for the parent_port is still possible to release parent_port before calling device_unlock(&parent_port->dev).

If my understanding is wrong, please correct me. Thanks.


Ming

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
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>
> Changes in v4:
> Move the put_device() into existing if-else logic (Ming)
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
>  drivers/cxl/core/port.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b69c2529744c..a004da8fbe55 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -552,10 +552,13 @@ static void cxl_port_release(struct device *dev)
>  	xa_destroy(&port->dports);
>  	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
> -	if (is_cxl_root(port))
> +
> +	if (is_cxl_root(port)) {
>  		kfree(to_cxl_root(port));
> -	else
> +	} else {
> +		put_device(dev->parent);
>  		kfree(port);
> +	}
>  }
>  
>  static ssize_t decoders_committed_show(struct device *dev,
> @@ -721,6 +724,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		struct cxl_port *iter;
>  
>  		dev->parent = &parent_port->dev;
> +		get_device(dev->parent);
>  		port->depth = parent_port->depth + 1;
>  		port->parent_dport = parent_dport;
>  
>
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f


