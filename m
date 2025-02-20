Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBB28F5;
	Thu, 20 Feb 2025 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013407; cv=none; b=unlVnryJPyrLh7IsOPciSISxomZPmDosvmV9rjdotkO6tAcFS3hMMJQbEGQSup3n28dvCeO6KwuciA1Rj01Jsheg4CkFSihFU6Mb7JELaJ81feu2IXl/owGPmf7rp3NRFvU0aU4xs6VbfUapzOHBX/sdAIKhR0TVGkQvwg2ZrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013407; c=relaxed/simple;
	bh=B0p1EXxnI6i4wyesOZtGNKWI3uZ3+W2ep12QIsrLF+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6ywRWEpWeQMN7UqhoRMcfErmbkl6QZc+juwZVGR1LEkTMEf9DAm0vB7oouHh7vQemS9EODL36vVWZ4v6rqSld/us98a+8M3IjAtFExnokcJdlXCyaTGgXYoYLmV0SJ1kWig6LBeiV0oc97gVDyrIJ5J8r4iypcUWzoVG3wGF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVEmlWsR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVEmlWsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013406; x=1771549406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B0p1EXxnI6i4wyesOZtGNKWI3uZ3+W2ep12QIsrLF+0=;
  b=fVEmlWsR1ZsM3iMjZSHm7VDzUtVq21r+DZVOOS5YZzrFPEWPjsPaagXp
   bQRhr2p33SIsLTU9FZZbM6RaLD1VOmD+7FahMOFTXtMT9hcAOJoowPqvC
   nQ4u1aPszwkdbrnC6LafbgQ0VYR3T5DVY0374Cq1H6SsPTqiKWqHPSY4t
   zvZVQ4s/OOl5/tKVvN4xRzhvAyH+SXEMgy3OZ4kw5i3YLClnE7CrfZWYc
   5GQT25DS1VfDoL6HGxz8hQlrqJpJyq+nSmPoNghqxyCoy45pdz+P12Dn/
   fepjqJ1klmQdDMLdTBf6+DGPIHpSGBguMDilAEaCxY8Y5i5cA7pW7uUsZ
   A==;
X-CSE-ConnectionGUID: RY+OWawZRD2i5bqcOWuB/A==
X-CSE-MsgGUID: mqfNhe3XQF+jHuqKEK/RlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40632064"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40632064"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:03:26 -0800
X-CSE-ConnectionGUID: cNZN/oXSTjaumHTBV4AOnw==
X-CSE-MsgGUID: UdJxh4+ORleyQAR64tZPlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118984759"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:03:24 -0800
Message-ID: <a953bded-10b9-47c6-a595-062ac86e489e@intel.com>
Date: Wed, 19 Feb 2025 18:03:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] cxl/pci: Moving code in cxl_hdm_decode_init()
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
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-3-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-3-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
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
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2ec8c97ab160..f8e22bc278c3 100644
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

