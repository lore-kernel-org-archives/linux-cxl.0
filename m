Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1B322B8C;
	Tue, 23 Jun 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233671; cv=none; b=nj98SBf3dWJQMbkZ+L7ebxtaXF/VyAX7KjXt0zAuhwlp1RLbH+VpJyVr/DTc9jmP7Gcw0QVB4iD5BujHbOAng0eeIZyddvDBW0BBAop0SYAFe61TJxSDWXIxqPgYcUl5fCLgiSiKk/EJbVrwVdk0qmytYDWeWtkPkMhGvE++4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233671; c=relaxed/simple;
	bh=NRCdL7kylozZW8R4QZ6YNm8l63XyRIXOfYdrIUMB5oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz63EVCQ5xY5hoUCA0v1VCLgFMqVoWNZtRgFI8Rzw+ZP4/fb9IyceWBWd6/giT7EBgccYcQSeAYNyywwe3DLdmb3hPVb6Bfaq+P0LMcLk3hHtUZ/3uL04kqNGEKBV36tIyL7fWLFxCpUwaOaA97UxSsgngho4uFXFgItna7UmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ao7r7wU5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ao7r7wU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782233669; x=1813769669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NRCdL7kylozZW8R4QZ6YNm8l63XyRIXOfYdrIUMB5oc=;
  b=ao7r7wU5I7JovfzftPOTIHdGggVFF+53ApJBDJ3ocrWPc2ToP8r9SDpS
   3glh4z1tkgoXDG7qDZNM3zioxMTvPFI/ICqSZW7OglHD8OKbAGcro5rZI
   YwmuOu3L8NBXJ0NDeiqlltYwt/E+N6K2ceJH/VFeXNGHXVqLhg58vyJw+
   i8nCHZktejwhLHo6E2ZfP/TycnS9Za/4lJPcUPi05p6OtbCpnKKN9k9xZ
   1GzNBW8SlT9OQRU77YkagfrZHm7Z5VbDToXm4/y1orYhqga1Yj88kwP+J
   5m8SSNrQ8kZoQuo1eGH8XuFa3QCf5hH4tcIjM5xPouCcPtHL+9Mch16f+
   Q==;
X-CSE-ConnectionGUID: shg7uQ+cQVa93l/qVtM2ew==
X-CSE-MsgGUID: v7eMSh6NTq6FnWxE+V8qww==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94374226"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94374226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 09:54:29 -0700
X-CSE-ConnectionGUID: cpJ+aFK/Sne+PX+bEC7cHA==
X-CSE-MsgGUID: +gawK/KGTAqXpF+lDNAFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249596074"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.151]) ([10.125.108.151])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 09:54:27 -0700
Message-ID: <12abc0a8-6f1f-410c-91e7-479381e579ec@intel.com>
Date: Tue, 23 Jun 2026 09:54:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Convert PCIBIOS errors to errno on remaining
 DVSEC/PCIe accesses
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, terry.bowman@amd.com,
 alucerop@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com, mochs@nvidia.com
References: <20260623062002.21447-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260623062002.21447-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/26 11:20 PM, Richard Cheng wrote:
> Follow-up to Dav Jiang's commit 26aa60e02762 ("cxl/pci: Convert PCIBIOS
> errors to errno on DVSEC config accesses") .
> 
> PCI config and PCIe capability accessors return positive PCIBIOS_*
> status codes on failure, not negative errnos. update_gpf_port_dvsec()
> and cxl_ras_unmask() still return the raw status on their accessor error
> paths, inconsistent with the errno convention they otherwise use.
> Convert it with pcibios_err_to_errno()
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changelog:
> 
> v1->v2:
>     - update_gpf_port_dvsec(): Also convert the pci_read_config_word()
>       failure path. v1 converted only the write path.
>     - Drop patch 2/2. On a failed config read the accessor returns ~0,
>       which cxl_decode_regblock() already rejects, so
> __cxl_find_regblock_instance() already returns -ENODDEV with
> map-resource cleared. There's no bug, so the change is dropped.
>     - Fix the commit message, the second call site is cxl_ras_unmask(),
>       not cxl_setup_parent_dport(), fix a "Convert" typo.
> ---
>  drivers/cxl/core/pci.c | 4 ++--
>  drivers/cxl/port.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e4338fd7e01b..bf6d566b2d6b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -838,7 +838,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  
>  	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> @@ -852,7 +852,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
>  			phase, GPF_TIMEOUT_BASE_MAX);
>  
> -	return rc;
> +	return pcibios_err_to_errno(rc);
>  }
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport)
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..8db4d15e9427 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -92,7 +92,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (cap & PCI_EXP_DEVCTL_URRE) {
>  		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

