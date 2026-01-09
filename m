Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158727465C
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973348; cv=none; b=gvytkS2Bz3sOBLURPXl6ydCRoOsKgVxlJznFaGKWFbXKFv1wswfPG1wxfksaqr2KxBQpDwedz+zyRwYFmkyiwpMlYVgbrLH9SrFnFjD6kogvXLf7LF2v2Jl7+TJArjbg2diedJiBSfd//D56YTZJc/3ibS6RGFAB0VIUobtVNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973348; c=relaxed/simple;
	bh=9puD84hpyw4F/5uu9OAkxMy9aKmfs1gHa9HuFQ4f5H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2ibh4Gr38HnAS50sqJnXr9CNunDPDPgrDlN9rueHntEC/3U9QRjAuP7Q4XP5w+ABUXW+KfnGJ2UXJcjqQ7aIlkc5khoAZnPSG0zj3+mupqVslJ9kA27PlMmRlK2nVFJbSkDTfGgZraBwEPbt0QcuFgWayMdAk1Uw/OgAmy5Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAT3uYt1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAT3uYt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767973346; x=1799509346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9puD84hpyw4F/5uu9OAkxMy9aKmfs1gHa9HuFQ4f5H4=;
  b=TAT3uYt1OBQ9N/v3Cxl0oFB1W4l1n8O7R1vIirF81fX2d1odFYf0ky9a
   Ax4AE6wMhjoHJ7zBWi5LhZ3iAvTao76Hmonxsza1DCT0QUezRK9B+gMnv
   m1hhjI0nww3DpzxYv8CrPBzKnZLYmxXYqltpEkQorLT0lwPO2WOMdQ8bI
   8yghXukqpWk56QjBi1pCt0Q8EARO4SjWR8O6QUh9UNF0mbbzF3OxmHit+
   GD0myGzvPaXkFSVM9rAqEwkQLT1YbZptFFa8L2opL8zY1CHVcDTcJQm+H
   m0KbRPIA8aFQHlLxfXvchMfuEwwxiBPIoZ06GlPZKw30NqS4adSu2xqnF
   w==;
X-CSE-ConnectionGUID: kILgmmHUR5i5qK7GYCwF+Q==
X-CSE-MsgGUID: osirkOHGQ9SGjjbCsdgg5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="68359983"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="68359983"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:42:26 -0800
X-CSE-ConnectionGUID: 5xo3/ZdBSzu4e+nay7N+2g==
X-CSE-MsgGUID: Cvpdm4XBQzqBTafpigid4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203785319"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:42:25 -0800
Message-ID: <1e7cdf36-5297-42d1-8698-693490716bd6@intel.com>
Date: Fri, 9 Jan 2026 08:42:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Fix cxl_dport debugfs EINJ entries
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: linux-cxl@vger.kernel.org
References: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 6:57 AM, Cheatham, Benjamin wrote:
> Protocol error injection is only valid for CXL 2.0+ root ports and CXL
> 1.1 memory-mapped downstream ports as per the ACPI v6.5 spec (Table
> 8-31). The core code currently creates an 'einj_inject' file in CXL debugfs
> for all CXL 1.1 downstream ports and all PCI CXL 2.0+ downstream ports.
> This results in debugfs EINJ files that won't work due to platform/spec
> restrictions.
> 
> Fix by limiting 'einj_inject' file creation to only CXL 1.1 dports and
> CXL 2.0+ root ports. Update the comment above the check to more accurately
> represent the requirements expected by the EINJ module and ACPI spec.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/port.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..54f72452fb06 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -822,16 +822,18 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>  
>  static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  {
> +	struct cxl_port *parent = parent_port_of(dport->port);
>  	struct dentry *dir;
>  
>  	if (!einj_cxl_is_initialized())
>  		return;
>  
>  	/*
> -	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> -	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> +	 * Protocol error injection is only available for CXL 2.0+ root ports
> +	 * and CXL 1.1 downstream ports
>  	 */
> -	if (!dport->rch && !dev_is_pci(dport->dport_dev))
> +	if (!dport->rch &&
> +	    !(dev_is_pci(dport->dport_dev) && parent && is_cxl_root(parent)))
>  		return;
>  
>  	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));

