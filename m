Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636A770F1;
	Tue, 22 Oct 2024 05:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573954; cv=none; b=Fe9IhpHPiAlOEMMIlTEZP1ytM/o7+KkaUfk4ESJkuv8V1Hfu5TRboC37obIz+ddAiPpJv7TLYmGYv/tK4cYRlSj1Ruuu5YeqCXWhHWkte06z0X+UtJA90k8iXUDA4s78fP0Oz1pN05oMRPzTKYmL6m9XLBVTLHqvppvNaoJA3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573954; c=relaxed/simple;
	bh=t+mw3U3Z7Lj1hw45TbzEbQjpZRx54yulUQ1brGuifa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GR0/NxsSZZcCE/mjYYNYKiWqevRjoEBPNoSRAURzNaqOYAQx1I/J50XfYNGM73qmJd8vpMCL+CREeOuxglU894LqLiglk1vtNFsVxwxWNkKr0QR/S4muMqzOPNuC2BtB14MGUwhlCTkUa/bP1n4VZuZ0DCDTYl57D8U2ISSTggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eypRtj/m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eypRtj/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729573953; x=1761109953;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=t+mw3U3Z7Lj1hw45TbzEbQjpZRx54yulUQ1brGuifa4=;
  b=eypRtj/m73V5RyIPRIdJFKt6ujbJajKYqMUPF0mnQqsLIrnx9o/Gxx8B
   ORs3YX1nMSSLcsNT4Zx5iFYDz06TAzZQwQVVxfrV+e6FSvQm7y/umtjVF
   QSMT233Jt9Z5D5LiQBjfbZvYBpOYtzhOY0BVb/yj1/uVG7CPh4AdzZFmk
   cmhXg8gAhi+rgP6X/anu85UiWYQJjaFbfy/sEPLj4mlGDsGnkJ8rNlhhF
   OBtkZFHzb3GqSboXfVudEwG1z+mYXVcKi2XzsNxRtxWJ6gB+x+KUhOfXF
   dU4QjDAlV7aCkyvpZEPEG9ETAqyrwRmrd1SjA4nVGFSWBffgjwD/rAFeF
   w==;
X-CSE-ConnectionGUID: Y0sWqWIySXam+u8ClOcTog==
X-CSE-MsgGUID: n1oE7Wv8RLefWNePRAVA+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28964061"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28964061"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:12:33 -0700
X-CSE-ConnectionGUID: IYciLYptT4WWCKT2nshsrQ==
X-CSE-MsgGUID: xwiSQpOxQXah9pV5gB9JLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84816761"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:12:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Dan Williams <dan.j.williams@intel.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl/core: Return error when
 cxl_endpoint_gather_bandwidth() handles a non-PCI device
In-Reply-To: <20241022030054.258942-1-lizhijian@fujitsu.com> (Li Zhijian's
	message of "Tue, 22 Oct 2024 11:00:54 +0800")
References: <20241022030054.258942-1-lizhijian@fujitsu.com>
Date: Tue, 22 Oct 2024 13:08:56 +0800
Message-ID: <87a5ew67x3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Li Zhijian <lizhijian@fujitsu.com> writes:

> The function cxl_endpoint_gather_bandwidth() invokes
> pci_bus_read/write_XXX(), however, not all CXL devices are presently
> implemented via PCI. It is recognized that the cxl_test has realized a CXL
> device using a platform device.
>
> Calling pci_bus_read/write_XXX() in cxl_test will cause kernel panic:
>  platform cxl_host_bridge.3: host supports CXL (restricted)
>  Oops: general protection fault, probably for non-canonical address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x27
>   ? die_addr+0x38/0x60
>   ? exc_general_protection+0x1f5/0x4b0
>   ? asm_exc_general_protection+0x22/0x30
>   ? pci_bus_read_config_word+0x1c/0x60
>   pcie_capability_read_word+0x93/0xb0
>   pcie_link_speed_mbps+0x18/0x50
>   cxl_pci_get_bandwidth+0x18/0x60 [cxl_core]
>   cxl_endpoint_gather_bandwidth.constprop.0+0xf4/0x230 [cxl_core]
>   ? xas_store+0x54/0x660
>   ? preempt_count_add+0x69/0xa0
>   ? _raw_spin_lock+0x13/0x40
>   ? __kmalloc_cache_noprof+0xe7/0x270
>   cxl_region_shared_upstream_bandwidth_update+0x9c/0x790 [cxl_core]
>   cxl_region_attach+0x520/0x7e0 [cxl_core]
>   store_targetN+0xf2/0x120 [cxl_core]
>   kernfs_fop_write_iter+0x13a/0x1f0
>   vfs_write+0x23b/0x410
>   ksys_write+0x53/0xd0
>   do_syscall_64+0x62/0x180
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> And Ying also reported a KASAN error with similar calltrace.
>
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: http://lore.kernel.org/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

This patch can eliminate the KASAN error when  `modprobe cxl_test`.
Feel free to add

Tested-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

--
Best Regards,
Huang, Ying


> ---
> V3:
>   update return code to ENODEV and change logs #Dan
>
> V2:
>   Check device type in original cxl_endpoint_gather_bandwidth() instead of mocking a new one. # Dan
>   Also noticed that the existing cxl_switch_gather_bandwidth() also have the same check.
> ---
>  drivers/cxl/core/cdat.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index ef1621d40f05..e9cd7939c407 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -641,6 +641,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	void *ptr;
>  	int rc;
>  
> +	if (!dev_is_pci(cxlds->dev))
> +		return -ENODEV;
> +
>  	if (cxlds->rcd)
>  		return -ENODEV;
