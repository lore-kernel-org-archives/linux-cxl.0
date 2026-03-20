Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0273D7D8B
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024077; cv=none; b=pN+8JznwhTS+L4bOwJddXZMRcG3twQWWdmZrP4TUB2NFYeFSRF68XN2cYRaYTqfOy/77TQSrDdBIv/F+GZPO4M4sI70iFZGgRmPHwb3V1MKssQ5DtYVm0pL9JjVrlyACqRJyh8KIfpQ/sP9XCh5WIu6pKJpWfWAgGtmq/Vp6ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024077; c=relaxed/simple;
	bh=Xz5c7DHzfWTu2cXngrcYiU4luJwyG2LsNUYgrLZrsZk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TIdfj631OTmxrY3y4iDqNWXlUGmG7iRgI7VOVch7yYLxz0EJGI5J0gO4owjn9OiERFzmxgz+hxCH8pOXK2Ato20CvXpYDSgzVk5huPQc1wF5uLABMYZXe8bySabqKHdgOcCnOzmaH5kWVvh4Y6jWn4VStSyW+6Lw8/R52tWxMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gr35MkD8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gr35MkD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774024077; x=1805560077;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Xz5c7DHzfWTu2cXngrcYiU4luJwyG2LsNUYgrLZrsZk=;
  b=Gr35MkD8qpJRL0P0vLsigQF6mLoXF/px51A2YT9OIAn64jCFWXg21mO6
   jNUVBnXYqpYIsf5jsqRqA6V5TLK+stXNzILdHTKBzsKIChfkVozIrw9nF
   HwheJJskzpDaQKIlDaylNJXlXKj2UnTIaSuZVaPgjfT+wxs9ejgulIOwG
   +KUANN9Kov/Ohos+HzcIfi1P7HcJFQccMdoQde4d4DVHaiCEPxhCdOYcJ
   EiESZPEzmvgQ7vh7ay33HHoctetX4bHxMu2Y1sbLzcs/8anT60g6qEqwy
   JcmLFEUVtBwMw2NZHroPrtqjahMGwzqOXAkcCKl0ThAf8whAYzjZOY6/m
   A==;
X-CSE-ConnectionGUID: l7X0TYYVS+O8r6jch7grwA==
X-CSE-MsgGUID: oWVmhVi7S5GoTuO1DuSmVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="97733094"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="97733094"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 09:27:56 -0700
X-CSE-ConnectionGUID: ELY1ybuETvGgwnAzhy8i5g==
X-CSE-MsgGUID: C84/RtE1S5CdDPJiwlohNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227813153"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 09:27:55 -0700
Message-ID: <3ea683cb-03d1-4a97-b03a-726bf6ea22de@intel.com>
Date: Fri, 20 Mar 2026 09:27:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Add endpoint decoder flags clear when PCI reset
 happens
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com
References: <20260319152541.2739343-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260319152541.2739343-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/26 8:25 AM, Dave Jiang wrote:
> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
7974835aa9d5 ("cxl: Add endpoint decoder flags clear when PCI reset happens")

> ---
> v3:
> - Rename cxl_decoder_clear_flags() to
>   cxl_endpoint_decoder_clear_reset_flags() (Ben)
> - Make the function single purpose rather than taking a flag. (Jonathan)
> ---
>  drivers/cxl/cxl.h |  1 +
>  drivers/cxl/pci.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..d09c84bcc015 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..84cff73b39e5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1030,6 +1030,19 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static int cxl_endpoint_decoder_clear_reset_flags(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxled->cxld.flags &= ~CXL_DECODER_F_RESET_MASK;
> +
> +	return 0;
> +}
> +
>  static void cxl_reset_done(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -1045,6 +1058,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	guard(device)(&cxlmd->dev);
>  	if (cxlmd->endpoint &&
>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +		device_for_each_child(&cxlmd->endpoint->dev, NULL,
> +				      cxl_endpoint_decoder_clear_reset_flags);
> +
>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
>  		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c

