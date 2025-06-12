Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF96BFC0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705955; cv=pass; b=gS26n34Eq2THos5bA+CabA2LWb8eJEOwaiuglqCXDU9EKgC1yQv/M5iy6TljjCGiS3FaWQKn5PB4finILtmPwxLU7Oyb4bpa9kj+lK6QJt2kBsR+LQ2ZnvRm1uhkzrv1TvUu1OHOOM5njdFEMaVRwPYQ/UWEj/0GDuYW4I4ctYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705955; c=relaxed/simple;
	bh=/PDDKKg+GXpkNB9hDG+dfueGKU3DjxqrOs3ipMEUIas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+h4Su8RLDFL4gVOS7ynRqNGj6l3Yp+9VwyG35BbU1pwgpVYeSjNNoFCJmbM+HEvgF2L1YLND7NRNlxwlk6olWIPi62PXT92nGchrHY/P3BZJWhtntQO2mvO1RU7TTd4OSEz6AnSiVfMaFelDOPO0Uhmb3n6vCZe/Mpb6VqO40E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=YGl7Qrff; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="YGl7Qrff"
ARC-Seal: i=1; a=rsa-sha256; t=1749705947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cu1Yv3vGWySrGTgX3Gc+KUDyXGEPlwzL/j6FqL3u3yCzYDVuunJ+XaUsBcZyIic3rnlgKvlilmDQaxHoDYlqDWjC3Ge8TYPN+aIS5kqEoAW8/kxMwqyIdh7Fm0N47Pbu+JIotot4LDWQIMPibsp2JDGcj+oyDqv4UydSt/mQ6Wk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749705947; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G6JvIx2DNCqVLvyscmiiDX+uL6Q756r2Kfen+kUijdk=; 
	b=gTQMvviAljd/tfS5ibTvCp8bL/eGwrfEVspVG2e8Ay1lPKYcAfSUK43YySv6eCYEL9fFnAOt/pUR3ieTr/WVprbNZhGcrpmGDPysG/KNN5shTHyQVPtMr07Fy5S4lbvZnVAgEgYKn7YapPnQffpnAao3C2BRV3LNFqmJh1zJCL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749705947;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=G6JvIx2DNCqVLvyscmiiDX+uL6Q756r2Kfen+kUijdk=;
	b=YGl7Qrff8BSprwyO48VSMOUiYtmPv5Iu5GoTBQsxHFW9L7eFJBI+2tyBXW06p+Qe
	FUKnNpTVJtDWGtUKDeG1eg/NzVDCz/UZ1WohQDqyllft89XuwCMresnoH/NlNg2aOZc
	zQOlNCqr8bRNipG9L0sYt0Fx5rMQdrsbNk379kWI=
Received: by mx.zohomail.com with SMTPS id 1749705945618201.84535147038844;
	Wed, 11 Jun 2025 22:25:45 -0700 (PDT)
Message-ID: <f85041bb-bbda-4b7e-8584-7fcb271a5378@zohomail.com>
Date: Thu, 12 Jun 2025 13:25:42 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Terry Bowman <terry.bowman@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>,
 dave.jiang@intel.com
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227d7e203f3a8d686af84ec90ee0000891fb55feac5afa552d58d535c2bb0e1ec0288be310cded07e:zu08011227650a6b41ff7a4838beadd1a4000065dbd0c84335ac90da47b6d75795f81bd621b71939e47dbbe2:rf0801122dcd1e7f10940f20319092280100006a87f714b7bae0fea20bbfd5f4b2a6675e8fa133d3fa877a122449692e28af:ZohoMail
X-ZohoMailClient: External

On 6/12/2025 1:17 AM, Dan Williams wrote:
> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
>
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>    device, nothing guarantees that.
>
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>    guarantees that.
>
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>    reason as the trace is 100% generated from data in the record.
>
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.
>
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/ras.c | 48 ++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
[snip]
>  static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -73,13 +71,13 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev;
>  	int port_type;
>  
>  	if (!pdev)
>  		return;
>  
> -	guard(device)(&pdev->dev);
> -
>  	port_type = pci_pcie_type(pdev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>  	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> @@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  	}
>  
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
> +				  match_memdev_by_parent);
> +	if (!mem_dev)
> +		return;
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);

missing put_device() for the mem_dev?


Ming

>  }
>  
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494


