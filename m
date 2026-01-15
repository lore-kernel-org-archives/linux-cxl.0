Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B533C00BC
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502622; cv=none; b=ERc413q9t5v8/DVPq2SNoJwOvXWSPheR2Dsqz3LryMNk9tx7HNMqFkqpCith7CBXR1u1bgi05gRqqZOoljYblx0+6JCnWdrn+EtGHdJfjcGKLjtzcoL4fSGJWDmiW7ba44n3GD7w5I/hgRrkdprF6fZeUZFYXgXugcO13EWvhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502622; c=relaxed/simple;
	bh=RwdVbz/vTZmRVCI/PLBGqVqfjSZropvq1LKOdYtl4E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCx0TM0azfUFGfofEJmmYxqpezpdHN3Emcmqe3RI2W6xWeVFLCCD3Skmc3q5xvQjojqkutYRrpgPR0hvBp8tr2ByzI0O81VthPdaxdQ3MyfLrsTS5t726EVZADuZNtmoBQZnMKQDlsmWHstnLwyLUYG89JL02qs9RslExSv6gcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZY3mCy7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZY3mCy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768502619; x=1800038619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RwdVbz/vTZmRVCI/PLBGqVqfjSZropvq1LKOdYtl4E0=;
  b=kZY3mCy7sMKZY2s63UVaHxs5Q3MC/9O1O9zG1xMqvGmIzjZG2JkzbwsF
   VFolexiE3gecoXxe2W+oT41m3AgvNECWdRmtPwcq7vRj74x41HFFawERM
   OkLDH4WSb1b0vMpUewcq+0ANAg4yYcq38LvoabgffHZqnS+vGCtFyTnOe
   zD4mhA+7ZzQfIurXY19zVf+qOrxAoD1MX3FGIPuTNRmeAqUbnbmlnSu28
   s2V0uXbZl6AI+79IGEqxnnhpHOpDaD1VehWTmb8JQSN7K+dH2cvywlv2w
   ILttw1jRwz91PfIM4QjGnvLOHVAUGU3aC2ERcDwQ7/OoN8vYfDlwWEvji
   A==;
X-CSE-ConnectionGUID: 35NR+6hhSByUD3hUdJnPFA==
X-CSE-MsgGUID: aMq1SShLSHmzqQCUpQZ0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69020782"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69020782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:43:37 -0800
X-CSE-ConnectionGUID: QbLl+ooYSJmjsAuEvzbtAQ==
X-CSE-MsgGUID: vr/HkbXISVSMFT1a/7cJ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204641127"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.80]) ([10.125.111.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:43:37 -0800
Message-ID: <25cc30cc-b724-408a-9673-2070227173e9@intel.com>
Date: Thu, 15 Jan 2026 11:43:35 -0700
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

Applied to cxl/next
5c604e7a9f6c215a7942671f62b76461678960b1


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

