Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AABA933;
	Fri, 11 Jul 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204096; cv=pass; b=jL6NA/e3OvQDcMpKkHVAf9G6Z3zq4fzgRo5khVCPUd1FdXdvhzmkmR9czt/euLFZhf9Sz2A0NCVPASNDP0zo0DPKJDwVdcA6RiH4Mcq5DJCVQ22oq+MJn5uoZ9UpDRMFZ0LjYNDEcRonhjHDR0qLy0tQ8RiVUAxPCkE3ciXbWEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204096; c=relaxed/simple;
	bh=Yp0nTMDOWNFv8xsyqrqX/eJ7fDCBpHvdfXKgKhx67/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1H0VRjRrgZbtU3xBKAFpTqShptP3S7eqKApKkZ/NBTmICwv6KjQdKy9PlI+Fq36VgiofeEDRQODJGhgXNyfgTYciMkW4gCAASVVSe9Z5/984EnI+TGooYdiPYtMpzorY1SkVDxnYFSR+h1z1QNFKv7HO0ncf1uCh8gj87PHATs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RuNI59Fg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RuNI59Fg"
ARC-Seal: i=1; a=rsa-sha256; t=1752203956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FHF1IlWTgeNIBFTHQlP/iRk5ycki0xO7TuWhdjTTMW+5SbK6MM7+KCO5qZNqRTp0hNiVSuv88rbkD1V4vJZuzaWsCPD1+uDgAfo4i3sfGkuCRiS7ibRpXGm72B02L6BZHUn+/0vjtj9IaMJ0DUFfZ6IFbaxutCrI0+nk8KXGSTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752203956; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vVEH4yQRs/uYYX1WeK003/TXB9IWCF976d+LQr111CQ=; 
	b=Quo5lHCdwJgSiNaJ8/KPwpWJZ44GA623yE8EcxrWgFfwaLBwHWdFbemra7E4n+jKgtXoeiAe11Cf95z/DBkrCEQBVLBsoE445yAAj/qsqopjs3MepWkoZHIHmRYeCB15BY7iEfaMFZYOLvtPSltFlexvzYQxK5GKHpeEK2sLJz0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752203956;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vVEH4yQRs/uYYX1WeK003/TXB9IWCF976d+LQr111CQ=;
	b=RuNI59Fg4qxr0L2R9p83NzVxb2GXnj7qSa3yHPQslMsAayg405hy/ntTLEkWfqoS
	wtghJl7X40SVFAHCfdSzNoTMv1AukL2ltBCVuaZ3LcHYJ0WACu72GtzVe1ApT7MsvvP
	MVOgdgOAlcY55xq2wmxh7IePZmQzL+TGsfOHBfy4=
Received: by mx.zohomail.com with SMTPS id 175220395452834.989640811052254;
	Thu, 10 Jul 2025 20:19:14 -0700 (PDT)
Message-ID: <64fcf4b7-b5c1-4983-b4e3-c490a461e8a0@zohomail.com>
Date: Fri, 11 Jul 2025 11:19:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cxl/core: Introduce a new helper
 cxl_resource_contains_addr()
To: linux-cxl@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, shiju.jose@huawei.com
References: <20250711031101.126990-1-ming.li@zohomail.com>
 <20250711031101.126990-2-ming.li@zohomail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250711031101.126990-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112276c761464beada33c2247d4a800004672d82109d605b6f531d1792cf338ac7031878fb39bccd4da:zu08011227ae45c79bdc0ba9cca9cf6eea00007652cef06d4aa577d87617fa5c581098dea9c6842589b098a7:rf0801122d717bf382b7e798b107ac988100002877533e2ba3074a2a24302d9946d0e226bbc3558c1d7b01a9ce5982193b09:ZohoMail
X-ZohoMailClient: External

On 7/11/2025 11:10 AM, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function cxl_resource_contains_addr() to check if the resource
> range contains the input address.
>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

I added a wrong reviewed-by tag here, it should be for Andy not Alison, Will send another version to fix it.


Ming

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h | 1 +
>  drivers/cxl/core/hdm.c  | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..6b78b10da3e1 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -80,6 +80,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
> +bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
>  
>  enum cxl_rcrb {
>  	CXL_RCRB_DOWNSTREAM,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ab1007495f6b..088caa6b6f74 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -547,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  	return base;
>  }
>  
> +bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr)
> +{
> +	struct resource _addr = DEFINE_RES_MEM(addr, 1);
> +
> +	return resource_contains(res, &_addr);
> +}
> +
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);


