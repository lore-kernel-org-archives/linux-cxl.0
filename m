Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381679;
	b=VfO7Sqra46jhgLw1wzA66MtduWws2qVp97EC1QW/RrTGCgxAV6k/2L56QWt58lDegE0l
	 5WHTH4jewxLCVOjBVye0lnkxSlhz6jHnnOYf2hFGBVtPo9GpNJhtDL9CP2FLBToDx9CU+
	 kQ8URyvSZcXEKlseOsuwryro4OnF+b6PTVm3DLRNl8FlLlxSOCcn9ai9PoLcIAvuKkthN
	 tMn85SbVB38o8f6Op00g45uYwNGPBVRC5/U3+Smgf7tYsZ4udkL7eq/5Ndj5O7r5U4VdM
	 0y+KlL4jJWyYashL1bAkXPTkxrlglC1WUuxDnkQogXU/4qp6hFLhgft9Gs2ir7Dq0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381679;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AbmgI+c358WW9X4xsVHrPuf2RX/FnxV0IKlkJ1CVV7g=;
	b=0pMIFH825ZCpvletRd8mXt6oPFEBnmcbMfmVFD0ju7NL6FNZxLav6FgGBEBUo5Y1C9Sl
	 4rn/aOFFH6XRq1KsDG/RUJFGtDZu8xzXXG7/3l5UcLihm/yNqMqQpiakx8A4nlLXd9ZwD
	 dzAUllJItGGo5aGgjTg21eNp7wXAA9M2kQh1jZtYHGdtFuBthu/SjvCf/tNJ77huDjMoV
	 EhC83vT/FEvXug8b8OCa5IU5398SZlysnwAXoZfMwq5Hcrqlt5n9Q5tqRpaL/0NMfZFf4
	 Wk+Kl0P6Jh1+wkuMhVDvmpvNbu0CRech1FqWChX76gQ/vAjj8r1c+ytxKchT83hwFiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lNqTdea3;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CB606A31A;
	Fri, 30 Oct 2026 17:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 191CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lNqTdea3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793381678; x=1824917678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5PyW5xxg6E88s7pnyR1i1IBAuIVjHfkU9lV97Ro/PE=;
  b=lNqTdea39+D/EH2wZKQ3JF4odm2g1bG0/pEr2S3mc2FglhsaFiavxg9H
   Kj7GJ+x4t62ixIfT/pVbdvj4EB3ROT81OAt2ODbWvGF3kp4cXqjdBfSHN
   2ODJRqTLLsnENgOFlZkTkURCodfgESkFFXBCCXfGT0xCHxLd2+aMw5GoK
   G896Ufvh5z7bWOQPmAvaXJTE05ej+7vmLoxXoF/YnTqQ3Hn+wCVQ3Ltyk
   2DdZtEK+Ee41B4ft+LSr4sWriSe8FEyGB2liHx7nuXqEhrRss23JdGTd2
   WzgaXysTpj71KD8J7UUJYqZZQO8M4LevSDLUIlqeUajkhGO2WUkznx6Hi
   g==;
X-CSE-ConnectionGUID: zjePILBGQf+SgPLbAdx+tA==
X-CSE-MsgGUID: imxLKi9OSuay8t3HPHLD8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2167724"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2167724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:34:37 -0700
X-CSE-ConnectionGUID: Sc2vAOAbSfqxhqW7VjbayQ==
X-CSE-MsgGUID: JhFRMV2QTAaJUSM7khis0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5513300"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.85]) ([10.125.109.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:34:36 -0700
Message-ID: <462e07c4-ca77-4111-a4b7-c45bf8a71e3e@intel.com>
Date: Fri, 30 Oct 2026 10:34:34 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl/pci: Guard decoder accesses after reset
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org
Cc: ming.li@zohomail.com, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260929020405.9724-1-icheng@nvidia.com>
 <20260929020405.9724-5-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260929020405.9724-5-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 7:04 PM, Richard Cheng wrote:
> cxl_reset_done() runs even when PCI state restoration is skipped.
> Reading HDM decoder registers while the device is inaccessible can
> trigger another error.
> 
> Skip decoder checks if the PCI Command read fails, returns all ones, or
> Memory Space Enable is clear.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2294f7761e50 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -976,6 +976,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  	struct device *dev = &pdev->dev;
> +	u32 command;
> +
> +	/* PCI state restoration may have been skipped after a failed reset. */
> +	if (pci_read_config_dword(pdev, PCI_COMMAND, &command) ||
> +	    PCI_POSSIBLE_ERROR(command) || !(command & PCI_COMMAND_MEMORY))
> +		return;
>  
>  	/*
>  	 * FLR does not expect to touch the HDM decoders and related

