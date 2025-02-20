Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594A3214
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012928; cv=pass; b=f9+wFo87X2ONBtHnr4ePMhZHB++uO+2ZcFtIKFTnhLHPSZX8OMiEV+WoxKv4b/7UwssXO9qpE9/QhwdfuUg0+dPO9ZO94jnPNilPJ+X3aYLlg6HduuHNhkGCY4hDJYOj25pSrHfEukdTAAA04dgrxcW1Dm8vEWtwC0F7l0q1mLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012928; c=relaxed/simple;
	bh=8yZwzlD0Z5lM2LNGDEMkOEu8BHHBzZbnNfA8VVb9ads=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmmUJb0d4J1GQR96IjdQPZ9Qg1kxmhr3wSMFu00S/4LgSNXqCbn0qMeUGDAqRdlTSGVsWAv+dAqwyFSJ0FsVzfqhCMU5j1s0uJzd41n5Gq+hAAyuHviqG7J2I+YS5RWEtddxAw+oxnY+e3spv8gfY/WFmi+I+GW6r+N37GEDA8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=f0z4zfBv; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="f0z4zfBv"
ARC-Seal: i=1; a=rsa-sha256; t=1740012910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KmV3+62TOHWYsAPzhgajO+h/OdcLhaaJZ9oxP1cCGci98J0l1rP8DK57CqeMeZM1rAWL+2+AqSFTPi7rG8/OLHbFF/yPjvFuHO3TYlXBUgK02CR9BOSErPQKruN/mvMMJxyc0fGJuLCsSete6A5lBaTY7sYHYpiml3U1j8caXHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740012910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=atATi9hoW1TjfEygZcEbtl7P/tdMJmhYoExQ0fpsuY0=; 
	b=fwU4vxkp9d1yZ8FQ4EsEah7lseAj2snhI6C6lq2yuN2c2GsxrtsGJrnkp8E7XK8IB8tJ7TnPsT6EmOYVwJh88Mo7t1VNhAO+xw9bbJ3/7YpccM24a1Z4lHQtxeTQLtCPlWK/KX/LYhOOi/7YLa2hYQYp2PEl+KHswsnrnlgxrwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740012910;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=atATi9hoW1TjfEygZcEbtl7P/tdMJmhYoExQ0fpsuY0=;
	b=f0z4zfBveLLja3aozAJGwmeuldQKOF8dEa0v0fJmSzQaRq1ptY3yWOm+kI8vWL0S
	wvjYGyqTwUm0cDwwEDfe3e3hcNGAGBF7pP9PMu86w99qt5eKG+fa1tDfWPnO1Mvr2vG
	TRw2IPgNomSXFg/ufj+CwTvTlFJBhBMNTuwNjfls=
Received: by mx.zohomail.com with SMTPS id 1740012907789521.5489155891507;
	Wed, 19 Feb 2025 16:55:07 -0800 (PST)
Message-ID: <baea8356-901b-47a0-b590-157b2451d40d@zohomail.com>
Date: Thu, 20 Feb 2025 08:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-2-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250219062832.237881-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c517291b0df1e7a23a2d93e100008cbf5d3378a2984954846ad65b9dd127660fe7933bb620f23c:zu08011227ab9c8ef8473004953ab88f9a00000c5d1d228a77de4e869dce701b7bf1da39538701fa2fd8ad0e:rf0801122daf8cd5d4ec7ec692d4bebd8300005bf69a5b8792f729d88aa182b9ce52a2701ab362a6074875c6839236494935:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 2:28 PM, Davidlohr Bueso wrote:
> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..2226cca3382d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1072,6 +1072,27 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  #define GPF_TIMEOUT_BASE_MAX 2
>  #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
>  
> +int cxl_gpf_get_dvsec(struct device *dev, bool port)
> +{
> +	struct pci_dev *pdev;
> +	int dvsec;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pdev)
> +		return -EINVAL;
My understanding is checking the returned value of to_pci_dev() is not needed, to_pci_dev() is a container_of() macro. Besides, above already checks if the device is a PCI device.
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +			port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +	if (!dvsec)
> +		pci_warn(pdev, "%s GPF DVSEC not present\n",
> +			 port ? "Port" : "Device");
> +	return dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
> +
>  static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  {
>  	u64 base, scale;
> @@ -1116,26 +1137,23 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>  {
>  	struct pci_dev *pdev;
>  
> -	if (!dev_is_pci(dport_dev))
> -		return 0;
> -
> -	pdev = to_pci_dev(dport_dev);
> -	if (!pdev || !port)
> +	if (!port)
>  		return -EINVAL;
>  
>  	if (!port->gpf_dvsec) {
>  		int dvsec;
>  
> -		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -						  CXL_DVSEC_PORT_GPF);
> -		if (!dvsec) {
> -			pci_warn(pdev, "Port GPF DVSEC not present\n");
> +		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
> +		if (dvsec <= 0)
>  			return -EINVAL;
> -		}
>  
>  		port->gpf_dvsec = dvsec;
>  	}
>  
> +	pdev = to_pci_dev(dport_dev);
> +	if (!pdev)
> +		return -EINVAL;

Same as above.

Other looks good to me, feel free to add

Reviewed-by: Li Ming <ming.li@zohomail.com>


