Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E513777E
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211028; cv=pass; b=swrMz1GSX7YBiN65v7NqFDPMJbLHTykhdbVFKecN949JdEbyTYdlfuol4oWaXk7zi0apxvyWN7TBhHoWiCykPCBnUHPrXSTyfP2JTwVP1HqWnGx2AHpM1E1p03ZFyQnh1fveIUNx0VCHjlNc9hPvFWZ45OoEOUC51dMDmDDHWYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211028; c=relaxed/simple;
	bh=q9FGTHaILoZVigKOpgsBSdeLdo1+D/C9bxQQIIg1vsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzcGdA0cZmf9Pj2WHk6Bleq0puNbYHJwPXIsjoiOh1/+w2C84fhmb7s1FsDiWnQToN8v4H3CcArsABWVdoWiluIZUgiDPWqxD9RJtRnZY37TswNaqcxTzLslflT5WvLqe6qoe9xSjpbYNDRenB+a0CGVMlhVB43byCd+cbxZLJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XHdSKJxI; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XHdSKJxI"
ARC-Seal: i=1; a=rsa-sha256; t=1790211019; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AMeUnqz/j/c8EsLE2xvFnLd7rfWsv6YbCvNkT/FDPxkYu1dR7xBHesjXqClDVcNoOkttPFSfWzQ9fuyS/dve6aoFUYUEWYpbcleaq7Wg9gOkl4FsJBYK0ZFB1eI4Fs79of10SPgG8WOpnwG0Retubf7+ftD5Wj7PFg1S0bfx4ls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790211019; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GW77NXVB23K9M70dQRdZqIqDQLMRNvhJvxT0q8S2lhw=; 
	b=V/Hr+zhmbpTj+wQXiABL9R7w4KJ/G2dJYR1uiy1miiSw5BSdGmtU6nyDQoYfUTOKLYTp9dUMNoACrN1mAhYWRieSscsQmUIRHxiheV7OXayy91mBMsyIrE7qPs9c47UgMKkuWJxnGCeuYSiXssIyuKfk/EzPkzFKNiibJefWdDU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790211019;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GW77NXVB23K9M70dQRdZqIqDQLMRNvhJvxT0q8S2lhw=;
	b=XHdSKJxIV1EBFeHpZhGCgnsqL8gugXRFIiu/zl/YRGEdEuUf7Gq+3ORlXAKDQLby
	psR2xFdOChTFv3G0jL9+33IPrf4YxrOa6ivTDwZUR0fcb+4JU1rgA+gla7xIUd4/ATu
	JbPmk3FaF8FFBg/gBgddqM/00s6J95aIPpFlic0g=
Received: by smtp.zohomail.com with SMTPS id 1790211018078111.85870477215258;
	Wed, 23 Sep 2026 17:50:18 -0700 (PDT)
Message-ID: <a23d7347-178e-4651-a8b5-099d5d73f46b@zohomail.com>
Date: Thu, 24 Sep 2026 08:50:13 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/10] cxl/doc: Update maturity map with BI support
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1790103847.git.dave@stgolabs.net>
 <8d84cdb26c176226070377f8fdd66fc6af5ace6c.1790103847.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <8d84cdb26c176226070377f8fdd66fc6af5ace6c.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227eb5adce5105e7b8be95de84d0000783da7f1c1416da2f0e58fef497277081727fc2b0fce33e6e4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/23/2026 8:43 AM, Davidlohr Bueso wrote:
> Add the respective Back-Invalidate info to the maturity map document.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  Documentation/driver-api/cxl/maturity-map.rst | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index 282c1102dd81..0b857476cb47 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -63,6 +63,11 @@ in place, but there are several corner cases that are pending closure.
>  
>    * [0] Decoder target and granularity constraints
>  
> +* [1] :ref:`Back-Invalidate (HDM-DB) <back-invalidate>`
> +
> +  * [3] BI topology enable / disable (endpoint, DSP, USP route table, RP)
> +  * [2] Firmware-enabled path adoption
> +
>  * [2] Performance enumeration
>  
>    * [3] Endpoint CDAT
> @@ -166,7 +171,7 @@ Accelerator
>  -----------
>  
>  * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
> -* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
> +* [1] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
>  * [0] CXL.cache 68b (CXL 2.0)
>  * [0] CXL.cache 256b Cache IDs (CXL 3.0)
>  
> @@ -192,6 +197,15 @@ Details
>    hiding some standard registers like PCIe Link Status / Capabilities in
>    the CXL RCRB (Root Complex Register Block).
>  
> +.. _back-invalidate:
> +
> +* **Back-Invalidate**: HDM-DB lets a device snoop the host over the
> +  CXL.mem BISnp channel instead of CXL.cache. The kernel enables BI on
> +  every port between a device and its root port, requires 256B Flit
> +  mode on the path, adopts paths firmware already enabled, and creates
> +  HDM-DB regions under CFMWS windows carrying the Back-Invalidate
> +  restriction for Type 3 and Type 2 devices alike.
> +
>  .. _background-commands:
>  
>  * **Background commands**: The CXL background command mechanism is


