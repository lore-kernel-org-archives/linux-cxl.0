Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2D398915
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535667; cv=pass; b=Y8rovO4rPoit31y0oI36in6ZFZvrlM2M8NVVF7Pixv+Fj/jNeRcf4QpS2fSgjK8QqblTYKwblceVj8CbqG7Y5wNRNPlWiwZL22zi0K74nlaBbZRxgSFg9qqnIndRHaLjR5OAxrj9yk8xayhtumG9zuf5kWJf8ZB5VhlkC8QfM9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535667; c=relaxed/simple;
	bh=1eee5drbn4hQlfAk88cXKMXaneD5JjjiHQPyWc+Yoc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKpUWDzgeYx5h1P0oP1vUV3UhLLXmCwXeOwM8rCZrzNN1Sch84b7kp8YiVQfWp6dTYkmS3TOuVlj0ODMyF/siQQy4YZA51csfVMwCwflF4OC+bPqaY/GXccaW1O97DkBItovBJQWbdNEUkf4lJwCGqaRxamI7PPyL9KkELRnhEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GTTTylrL; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GTTTylrL"
ARC-Seal: i=1; a=rsa-sha256; t=1786535655; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IVARlcg/Ws7gbG3OQhbMNvZzOopmNmcwVB9BL7VU1weZJU/USQ5dA36iMlzizJMZ6aWSuxgO4vGvO2JPT0R/CIZefW+I8mEwCHT2/y0WcewXee05YCF+8UFbl1v3kNwKdzqX/Wlndtr4H51y+lLjKTcKtgmN5mZhxQHgMtSplMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786535655; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x7Ceo1MAcZZaI+X1+905OMar6RUz+mcr2mRrK4wruQ0=; 
	b=B54lCneUDZTlksuR6Yj/8WckxUGGTw13IKFsx6G1BivOflephBZAuinyetCHpHfQxi9HPMxU0rZBEvZO2M4AOYnP9p2ey8/FtUXpePZ6P/aybM+QTXOkaEe5ch2k1M+V3K2x3kYHE4aPqpXgFRSxFgGRuMRYky+5Gep47FZzDRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786535654;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=x7Ceo1MAcZZaI+X1+905OMar6RUz+mcr2mRrK4wruQ0=;
	b=GTTTylrL9m7QZz7MNiydD3JyOPOJeAtJbEmIR1E6c5KSFxEzGn7Ozzt9wLsuwtGY
	d+rNp0IZ9rC98IG1zkSw/zv30IgI+crUY2ctjwo97tlnQ/VS0xWgsSyO2bxOmwPevfo
	1gu6CJCq8BJys0iMtl10Rr54wE8cbgRiVNhPyAXE=
Received: by mx.zohomail.com with SMTPS id 1786535652360819.9258603759376;
	Wed, 12 Aug 2026 04:54:12 -0700 (PDT)
Message-ID: <e2b0b35d-c528-43c6-ab98-730c82e0eb24@zohomail.com>
Date: Wed, 12 Aug 2026 19:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/core: Fix dport use-after-free via the einj_inject
 debugfs file
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260812060943.56246-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260812060943.56246-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227faff7a4e75042cedb866e39c0000e9072b7900a88aa838abe19ff54b00d38545a4fb0075dc89f2:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/12 14:09, Guixin Liu 写道:
> cxl_debugfs_create_dport_dir() publishes a debugfs directory containing an
> "einj_inject" file whose i_private is the 'struct cxl_dport', then discards
> the returned dentry and registers nothing to remove it. The other per-dport
> facility set up next to it in __devm_cxl_add_dport(),
> devm_cxl_dport_ras_setup(), binds its resources to dport_to_host(dport) so
> that they go away with the dport. The debugfs directory has no such owner:
> it lives until cxl_core is unloaded and cxl_core_exit() tears down the
> whole cxl/ tree.
>
> The dport itself is freed much earlier. free_dport() is registered in the
> dport's devres group, so the dport is freed when the host device is
> unbound, which is an ordinary sysfs operation on the host bridge port or
> the ACPI0017 root, not a module-teardown-only path. After that unbind the
> einj_inject file is still there, and a write to it calls cxl_einj_inject()
> on freed memory, reading dport->rch and dport->dport_dev and passing them
> to the EINJ code.
>
> Re-binding the topology does not recover either. The stale directory keeps
> the dport device's name, so the second creation finds the name in use,
> debugfs setup fails, and error injection is silently unavailable for that
> dport for the remaining lifetime of the module.
>
> Keep the dentry and remove the directory from a devm action on the dport's
> host device. The action is registered after free_dport() within the same
> devres group, so release ordering runs it before the dport is freed. Its
> registration failure is deliberately not propagated, following
> devm_cxl_dport_ras_setup(): a missing debugfs directory is not a
> functional failure of the dport, and on that path
> devm_add_action_or_reset() has already removed the directory itself, so
> there is no dangling node left and nothing to gain from failing the dport
> addition.
>
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
> This was patch 3/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
>
> v1->v2:
> - do not propagate the devm_add_action_or_reset() failure out of
>    cxl_debugfs_create_dport_dir(); a missing debugfs directory must not fail
>    the dport addition (Li Ming)
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>    the code change (Alison Schofield)
>
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/port.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..62a9c2038d1f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>   			 "0x%llx\n");
>   
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
>   static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>   {
>   	struct cxl_port *parent = parent_port_of(dport->port);
> @@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>   
>   	debugfs_create_file("einj_inject", 0200, dir, dport,
>   			    &cxl_einj_inject_fops);
> +
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
>   }
>   
>   static int cxl_port_add(struct cxl_port *port,
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
