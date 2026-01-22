Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856513EBF0E
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100337; cv=none; b=f1fWCeW+aUgmm8grH2oXuMpSVAg/yRD54rQ9EUcZpJi7DFIfYhkTOtKo9IBj02ixQcIZ7HabZHd+CG7pGD9jaJpZTzJGvTXPJwWewAVkHpr2/oglSbbIz02eRIuHufRWndjJhI58XhPIwhG1ccIOqIMKyzMHdVCVXn66TfpoYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100337; c=relaxed/simple;
	bh=pnW02QP/8ZNrLfhJZtfzXoxtLSni6jVwN6xXGuNt6Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsJQ28gSzqyxamdkbszEuw/GryiA7vDBWljvxMVvqgJpaO0E9OvHRQBACHcOGZS52AwgtKuRZsFikJUakZml4bvYyLdM9pMnCiXOybsl9OTjWBX9KzT4h/+NAHKr7g6GBKQDdmWEIJrEFS+ytki4jZmMId2iM3T6E580IF31cus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuidE3gR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuidE3gR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769100327; x=1800636327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pnW02QP/8ZNrLfhJZtfzXoxtLSni6jVwN6xXGuNt6Mw=;
  b=DuidE3gRUfkcXTPc35GSBcHG5GQXNn5FFVZWtbfDekxnKnO3Y+zs98q+
   HBQtFZlj+6RwoypK/AXHE2h/wFlpfpYks9Mp0qNTqdR/iYKO4DbXIhCVS
   +PnZAUs6h+YmgSA659l92+XLRBgT9R4MzXsftR8qmMdFLKKBTad7nXRqA
   x3Dmj2wXwAEdC0khaP8yEIeWbSowoaOMPdzs5BfStg5/4d9GA4bPDAIhF
   MrsZgniGMuTf0D+3dZg2PoBOgwM2GNtlbGsHAZTUIa8tL5P85p2wPYyVA
   Qr7ESMgMkNbR2l4mOr2kIIfs8uBGf6krCOevihsPvYavkLxzftm5tvVTC
   A==;
X-CSE-ConnectionGUID: eTBGSQ3xTFCJzDRYYiqAcw==
X-CSE-MsgGUID: wjtqLZg5R8aHVxVve7zx5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70320681"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70320681"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:45:24 -0800
X-CSE-ConnectionGUID: cwgM1SjtQm6WMYneaao7LQ==
X-CSE-MsgGUID: 41VONaG0RDqH7S0fHYpkXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229741242"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.157]) ([10.125.108.157])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:45:23 -0800
Message-ID: <18189693-e78c-4d65-8829-24767d7e7d9b@intel.com>
Date: Thu, 22 Jan 2026 09:45:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cxl/port: Cleanup handling of the nr_dports 0 -> 1
 transition
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, terry.bowman@amd.com
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-2-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122033330.1622168-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/26 8:33 PM, Dan Williams wrote:
> There are multiple setup actions that can occur for a switch port after it
> is known that it has at least one active downstream link. That work is
> currently split between __devm_cxl_add_dport(), the add_dport() helper, and
> cxl_port_add_dport() where decoder setup occurs.
> 
> Clean this up by moving all @dport object setup responsibilities into
> add_dport() and all port effects into cxl_port_add_dport().
> 
> add_dport() handles taking a reference on @dport->dport_dev, and
> cxl_port_add_dport() grows the awareness to setup the port component
> registers. This removes an awkward open-coded xa_erase() from the middle of
> __devm_cxl_add_dport() and instead tasks cxl_port_add_dport() with calling
> the common @dport destruction path if anything goes wrong.
> 
> After this @port->nr_dports is always the count of @dports in the
> @port->dports xarray, and cxl_dport_remove() is symmetric with add_dport().
> With ->nr_dports now reliably tracking the number of dports the use of
> ida_is_empty() can be dropped. Recall that the ida is only cleared on
> "release" of decoder objects, and release can be arbitrarily delayed past
> unregistration.
> 
> Lastly port->component_reg_phys is no longer reset to CXL_RESOURCE_NONE
> post setup, no reason is seen to carry that forward.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/port.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..ff899c690d85 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1066,11 +1066,15 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  		return -EBUSY;
>  	}
>  
> +	/* Arrange for dport_dev to be valid through remove_dport() */
> +	struct device *dev __free(put_device) = get_device(dport->dport_dev);
> +
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
>  	if (rc)
>  		return rc;
>  
> +	retain_and_null_ptr(dev);
>  	port->nr_dports++;
>  	return 0;
>  }
> @@ -1099,6 +1103,7 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	port->nr_dports--;
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>  	put_device(dport->dport_dev);
>  }
> @@ -1181,21 +1186,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	/*
> -	 * Setup port register if this is the first dport showed up. Having
> -	 * a dport also means that there is at least 1 active link.
> -	 */
> -	if (port->nr_dports == 1 &&
> -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> -		if (rc) {
> -			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
> -			return ERR_PTR(rc);
> -		}
> -		port->component_reg_phys = CXL_RESOURCE_NONE;
> -	}
> -
> -	get_device(dport_dev);
>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
>  	if (rc)
>  		return ERR_PTR(rc);
> @@ -1622,7 +1612,16 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  
>  	cxl_switch_parse_cdat(new_dport);
>  
> -	if (ida_is_empty(&port->decoder_ida)) {
> +	if (port->nr_dports == 1) {
> +		/*
> +		 * Some host bridges are known to not have component regsisters
> +		 * available until a root port has trained CXL. Perform that
> +		 * setup now.
> +		 */
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);

