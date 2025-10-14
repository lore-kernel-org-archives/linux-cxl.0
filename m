Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40712FE05A;
	Tue, 14 Oct 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452754; cv=none; b=ArMbFlqd7AJlMx7ByUMooiKCy+6ropxvSOsEiVaC+fMEjOqM1a7s8OLsbLwzxZ4mMWOjKOF2kYP3JP9X2O8f7ke2I38BvVvpKYO0H+SH9B86A5JhBBhDqG9crelPzpoRxKuRa+CcUPIfpPqp+I7joWOagPGCE55hnVJhdrqi5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452754; c=relaxed/simple;
	bh=JIFXO/maDYxsszQjgtyWILDuEObhd/8GxCOtcj6zkMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3FsCWQaVoWseT4WYlciqaTHX+A4qXvqm6OJCJGL/CzbAtVbLk/bCpIt7UCM5ijCrlDZDVacBkfY8qmcZqimIdORiZk8LqG4ZmbQg2TeoFVeMMYI4OtEvAVSP8zr6XtfV517AF+TnrfOhnfGIWoMLstiRX9Y04yadqIpD0PwB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/x99eKQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/x99eKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452753; x=1791988753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JIFXO/maDYxsszQjgtyWILDuEObhd/8GxCOtcj6zkMY=;
  b=V/x99eKQNk2zT/WKr2vPK3khZS54Mfqk2gw+ssfy8EbX0iFSe24zEXcB
   j7A1bAMEXakBkuI7PzCGEm7oCsHnDv7mht2R3Sw2nAxmiJoXQ6ldVu8iM
   SdPQcAuHw1D4P8BPY4MLwy9NwHlJskRI3RMO5xQKWAVxSLHF+FOCO72Og
   Wh0qXYbbk0Wgx1Bq5r7PrfvKmfs6CAQth+5tvmlWZRAYg98VwhOgd48Dd
   vZ8OcQfRAVuOTgRQ7310lKJB7xg4r0krR77El8W/6ZG90LcQqNXk7Mex7
   +iDbD7zBZOGfcysBg96fIm7NlLuLJWXDnNnRQvszjVFNxfGd6j9g8bjBN
   w==;
X-CSE-ConnectionGUID: Rl4x+ZsLSe+eRAtlqTyM5Q==
X-CSE-MsgGUID: WsIV1bCOSayADzt3qsOOXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="80247041"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="80247041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:39:12 -0700
X-CSE-ConnectionGUID: AyZDS/eFQvS2rijZuAiWKA==
X-CSE-MsgGUID: OTVzpTZ0SYSiJH3cLuwg3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="186321436"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:39:11 -0700
Message-ID: <565e8042-9a77-4dad-b111-156fcb9210e2@intel.com>
Date: Tue, 14 Oct 2025 07:39:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cxl/port: Avoid missing port component registers
 setup
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251001060337.431639-1-ming.li@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251001060337.431639-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/30/25 11:03 PM, Li Ming wrote:
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
> Fixes: f6ee24913de2 ("cxl: Move port register setup to when first dport appear")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

applied to cxl/fixes

> ---
> v3:
> - add fix tag
> - add review tags
> 
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

