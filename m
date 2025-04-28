Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4921FDE33;
	Mon, 28 Apr 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878035; cv=none; b=MHh6ZealWEnOUUs2rnlQj5v/Dh4LIHFgdX5SeZqJH+Lma6Te4zCnGOEvJNTk5BPk2yHCBXh/6mfMHMT3mGgWdGa33WnUMZ4xuFp1Gbfa4vHOXG/VRaDwu/Vut5YPrha48sQlmzr8l48OLqXQlSt4Ir4Pxh+ox/a9kJx6Gp87HBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878035; c=relaxed/simple;
	bh=eyRMGZGGuI1jCqPa85trFLtZ2GppPcOVR+k5ZTfKxTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceTcgGSd3Sj8SZN02tiVGLq5ZftbV1XqzRm5BuIyVbyltsIn4DRC8T/cOYsqmBEyDAU1wutI3w7WxUCdspxjR1s6fOD4NY175ApVeoPlyLxkptRSjnrj1a619+kfiLFxA5uYzd/eFzrlY1qEFOjBJpKyuOrZ/2twbKpz/ithpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDo4azqC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDo4azqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745878034; x=1777414034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eyRMGZGGuI1jCqPa85trFLtZ2GppPcOVR+k5ZTfKxTI=;
  b=JDo4azqCY4Lw0hHAysevcdvsOX6DQefMbbLdT5/385S7ljEvHJ1SImAS
   p0EZ04VVJ0eS6Ts0TWhY7BD4u28GkOYCyqZRTuaghkbAGCjzTMJTDB5zq
   q/XKHYs2OAPhF7LuJNUJEBKULnreF1qKkPWhhrF5Bw2+xPQcWQ0L/nZcB
   8La68Fyzyg21C0V7VmxB1EIGgVFhAT38z6+moUQJDZbvz98zJtb4VTUHl
   8PR2UIDdsno2j4adfrxkaNK5sXGtCiULZjExiV51AWuLffXSdxFlLTdXA
   Ju4JT05C4b3jXQBKJyBO1vnj1HRp0Hs3R99anfvSfX5kFpoarzKAbecj1
   g==;
X-CSE-ConnectionGUID: CwTGi05xRx+9mjYFqQ7ryg==
X-CSE-MsgGUID: I/rbInzxRTieCqv/IH2iMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="57687143"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="57687143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:07:13 -0700
X-CSE-ConnectionGUID: eCViiM1oTfK4l4Kx4zpcwA==
X-CSE-MsgGUID: DFxwPUvRR0CB0BfwbE+t9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133955355"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:07:07 -0700
Message-ID: <41e17e85-1093-4848-a4cb-92c65663610d@intel.com>
Date: Mon, 28 Apr 2025 15:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-3-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250428214318.1682212-3-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:43 PM, Robert Richter wrote:
> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 33c3bdd35b24..6386e84e51a4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
>  
> -	root = to_cxl_port(port->dev.parent);
> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> -		root = to_cxl_port(root->dev.parent);
> -	if (!is_cxl_root(root)) {
> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> -		return -ENODEV;
> -	}
> -
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> +		return -ENODEV;
> +	}
> +
>  	for (i = 0, allowed = 0; i < info->ranges; i++) {
>  		struct device *cxld_dev;
>  

