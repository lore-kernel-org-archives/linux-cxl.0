Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836053644C1
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464244; cv=pass; b=WmcbXxU8NhBWZYGGIPvJU/vW3BGieTW8HFecxoqlzK+ZLBqGOL8Tt0ZTUep+1o2w4Up4FfKZiX+fO0DqBrJ+MLAMbFc5pNBpMi9fHhCA+oMBY9HE2cYgvv8b9ZH7Nx1U3B1w6v0apQyTml2LLD9sBwwBjyZgx60vgF8Nbjz+uzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464244; c=relaxed/simple;
	bh=oOgme09HLM0srNy5PYV7NUiOqvwkCHqw4GSl04ko5JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSSq7KiQlFkG+5FGjdEEkYzqdflJOMYzIXHbKYfdEBF1HErebymediYYy4m3s42yWiZNoBC369NCF+jpMq8P6RgW29pRkRFSfzYzce6mKn/iVN06yIIL3+yy0URsHoPbqyJDcisw0l/dnjSeSucVOWusxzHFnrMJq2OqH0+PYxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aSzXGzdG; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aSzXGzdG"
ARC-Seal: i=1; a=rsa-sha256; t=1786464225; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RVi4sLjGMH3RrJalwJj+/1RLhMDPRdiSHAtRUmKzmLsNQ2wlRc0WSMDso5YJOtwkEoMN8bjAulEawlgWrSIpcc1Ap+ZZ1ahnOMYQS+9Yq2WDYXzrURcIUhzUFzYqZhE5qvG8kfxQj/OneW+0nbRO+y21KFN5KR+Bb9R/pYxEPPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786464225; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iO3Rgtyeq1e1TpHD4yiJMVgnpmqN9+/UUPih56+pZMk=; 
	b=DJFW01KbZYk/dygM3l0sAHHD4IoEn9QNpcvY+sEHSvrswkHfXFOct7a7ZU39LzY1GPdepnppHYDBMvOWKfC9nXAut8dyRdP0TVnIJrgKThpIDaKqmc6fAjUiBjhsGEgOY/XrubJq8UAQwv4AhGU51kDeJxrc9ggP9ROe1QvGr/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786464225;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=iO3Rgtyeq1e1TpHD4yiJMVgnpmqN9+/UUPih56+pZMk=;
	b=aSzXGzdG+xAbdxkqLXARSyY9Zf6Eb9Ay0QejO02j24UjZDmRHWCR4inZooX0D+z+
	OGHYsQ+C3YeG9AXiw5EyAjyQEK522uMM1dVdxdHRzqdF0pyVPG5eqPsjOEM4VupgJPc
	n/leZ2Hgc8FfAP8XuB0lBFiyRM9Iv1WdrKN/SJAo=
Received: by mx.zohomail.com with SMTPS id 1786464223607390.80635754618504;
	Tue, 11 Aug 2026 09:03:43 -0700 (PDT)
Message-ID: <06658b3d-74dc-4d89-88c0-38b2ff098c75@zohomail.com>
Date: Wed, 12 Aug 2026 00:03:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
 <20260811113608.2815625-4-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260811113608.2815625-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227fdba198cdcfa6f3d83c9a1c0000024d7df721c16ac69e485944641b196fed4d6270141216eb3d3:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/11 19:36, Guixin Liu 写道:
> cxl_debugfs_create_dport_dir() creates a debugfs directory holding an
> "einj_inject" file whose i_private is the 'struct cxl_dport', but it
> discards the returned dentry and registers no cleanup. The dport is freed
> by free_dport() when the devres group of its host device is released,
> while the debugfs nodes live until the cxl_core module is unloaded
> (debugfs_remove_recursive() in cxl_core_exit()).
>
> So after unbinding the dport's host, e.g. unbinding the host bridge port
> or the ACPI0017 root, writing to
>
>    /sys/kernel/debug/cxl/<dport_dev>/einj_inject
>
> calls cxl_einj_inject() on freed memory and dereferences dport->rch and
> dport->dport_dev.
>
> The leaked directory is also named after the dport device, so re-adding the
> same dport (bind after unbind) hits an existing name, debugfs creation
> fails, and error injection stays broken for that dport for the rest of the
> module's lifetime.
>
> Save the dentry and drop the whole directory via a devm action on the same
> host device. The action is registered inside the dport devres group and
> after free_dport(), so it runs before the dport is freed. Propagate the
> failure to __devm_cxl_add_dport() rather than continuing with a dport that
> has a dangling debugfs node.
>
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/cxl/core/port.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..76bda54ed986 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -813,13 +813,18 @@ static int cxl_einj_inject(void *data, u64 type)
>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>   			 "0x%llx\n");
>   
> -static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
> +static int cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>   {
>   	struct cxl_port *parent = parent_port_of(dport->port);
>   	struct dentry *dir;
>   
>   	if (!einj_cxl_is_initialized())
> -		return;
> +		return 0;
>   
>   	/*
>   	 * Protocol error injection is only available for CXL 2.0+ root ports
> @@ -827,12 +832,15 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>   	 */
>   	if (!dport->rch &&
>   	    !(dev_is_pci(dport->dport_dev) && parent && is_cxl_root(parent)))
> -		return;
> +		return 0;
>   
>   	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>   
>   	debugfs_create_file("einj_inject", 0200, dir, dport,
>   			    &cxl_einj_inject_fops);
> +
> +	return devm_add_action_or_reset(dport_to_host(dport), remove_debugfs,
> +					dir);

I think we don't need to worry about devm_add_action_or_reset() failing, 
missing this debugfs directory seems like acceptable, but the failure 
cases of this devm_add_action_or_reset() will cause dport addition failure.

So I think just like below devm_cxl_dport_ras_setup(), do not check the 
return value of the function.

>   }
>   
>   static int cxl_port_add(struct cxl_port *port,
> @@ -1240,7 +1248,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	if (dev_is_pci(dport_dev))
>   		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
>   
> -	cxl_debugfs_create_dport_dir(dport);
> +	rc = cxl_debugfs_create_dport_dir(dport);
> +	if (rc)
> +		return ERR_PTR(rc);
>   
>   	if (!dport->rch)
>   		devm_cxl_dport_ras_setup(dport);
