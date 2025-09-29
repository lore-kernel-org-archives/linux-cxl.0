Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDBCA52;
	Mon, 29 Sep 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164854; cv=none; b=hHGUSl3LT+RvJAcC1d8gAJEVy6ZPPxKOwX8rfXpjX8ulTd9Pw+P9eZ0PntyYxzP8I9Bz4JKj+bQAAKD3QhsrmKtrebT2CsZu8mTxgdF2cQQamhg1AZ3u2C/WBX2DI54jDpskHc7/piJYfpkzcqxRaz1eLM1tlXBDwkHsCz49Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164854; c=relaxed/simple;
	bh=bQ1mK4GnCyBOHvcnyHOeLISpTMS/ksG35U5SIXjtduE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hitbcpyM3C8tB74B43m0UM4VMz/EkdodXgHMqaZQBhqMhEB2lLyTv9XqtseYQku8x7R3PXV6QIscqCdDtzUdvNTXGNwdkPo6jCYJ6fq73+lx6bDKpCh3PVUxu5IzeYugjeJ/9hnP+djXLt7JTYmuPjQEUpKwwV3JXfr2B2HiZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHkm2t4V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHkm2t4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759164852; x=1790700852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bQ1mK4GnCyBOHvcnyHOeLISpTMS/ksG35U5SIXjtduE=;
  b=ZHkm2t4V9TdVX1eMY20cq4mctLr5XAB5KktTqU8QVEdfXz6QZ9bhe3NJ
   zh8Gh2HfsDJAXFBdKu4ufaFojA0O9cph3E4mRvIj0sZevfV5SE9muz5sR
   Ry396SixgECKjhUY1F2I6lNt/fAtGKk+/2zUvLmUef8pSwPK7Fg9rIPao
   DhdruT5J/w65scwWjjFdrzZqTDia3PmjIrIbGIodvjSlcfErXl/8ehOGk
   Oh1uTDHnX72YzZGDJwPw1JKK4Iaw5e9P5/VrnnJ5MpHjM3YNwvXzqwwvN
   1ucREKLcxD0kdLG1Vmg05KD9BOB5yGkklO7wlf9UbBhc5klTf5+cSul40
   w==;
X-CSE-ConnectionGUID: bSX2WMP4SLG5fPFauzfipA==
X-CSE-MsgGUID: FMKxgbCLQhyFFYZjMnQ0Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61326948"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61326948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:54:00 -0700
X-CSE-ConnectionGUID: diJ17Vw4TB6aU2dSScREaw==
X-CSE-MsgGUID: 4zg6UPYZQbyE+l7xOelQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="182693454"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.116]) ([10.125.109.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:53:59 -0700
Message-ID: <e2749038-bf78-47a6-83da-96f02bd75599@intel.com>
Date: Mon, 29 Sep 2025 09:53:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/port: Avoid missing port component registers
 setup
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250928101433.424778-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250928101433.424778-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/25 3:14 AM, Li Ming wrote:
> port->nr_dports is used to represent how many dports added to the cxl
> port, it will increase in add_dport() when a new dport is being added to
> the cxl port, but it will not be reduced when a dport is removed from
> the cxl port.
> 
> Currently, when the first dport is added to a cxl port, it will trigger
> component registers setup on the cxl port, the implementation is using
> port->nr_dports to confirm if the dport is the first dport.
> 
> A corner case here is that adding dport could fail after port->nr_dports
> updating and before checking port->nr_dports for component registers
> setup. If the failure happens during the first dport attaching, it will
> cause that CXL subsystem has not chance to execute component registers
> setup for the cxl port. the failure flow like below:
> 
> port->nr_dports = 0
> dport 1 adding to the port:
> 	add_dport()	# port->nr_dports: 1
> 	failed on devm_add_action_or_reset() or sysfs_create_link()
> 	return error	# port->nr_dports: 1
> dport 2 adding to the port:
> 	add_dport()	# port->nr_dports: 2
> 	no failure
> 	skip component registers setup because of port->nr_dports is 2
> 
> The solution here is that moving component registers setup closer to
> add_dport(), so if add_dport() is executed correctly for the first
> dport, component registers setup on the port will be executed
> immediately after that.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

That makes sense. Please add a fixes tag. The commit in cxl/next should be stable.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
> - remove dport from port->dports in case of component registers setup
>   failed.
> 
> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
> ---
>  drivers/cxl/core/port.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d5f71eb1ade8..8128fd2b5b31 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1182,6 +1182,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	/*
> +	 * Setup port register if this is the first dport showed up. Having
> +	 * a dport also means that there is at least 1 active link.
> +	 */
> +	if (port->nr_dports == 1 &&
> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc) {
> +			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
> +			return ERR_PTR(rc);
> +		}
> +		port->component_reg_phys = CXL_RESOURCE_NONE;
> +	}
> +
>  	get_device(dport_dev);
>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
>  	if (rc)
> @@ -1200,18 +1214,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> -	/*
> -	 * Setup port register if this is the first dport showed up. Having
> -	 * a dport also means that there is at least 1 active link.
> -	 */
> -	if (port->nr_dports == 1 &&
> -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> -		if (rc)
> -			return ERR_PTR(rc);
> -		port->component_reg_phys = CXL_RESOURCE_NONE;
> -	}
> -
>  	return dport;
>  }
>  

