Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F31E493;
	Thu, 20 Jun 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889320; cv=none; b=fOf7zP8TvBcAajUNL512ZSxdTQ+LVEAtnlf+L6MD+8B/0l/UlH3I1Z2dl2yfJCvTeaphBBGT/dPkoYdokGTlLWlDS8g634i5G9IPj03yPM9mUgwsT7iEraCXHQCh8FcNi4mBpjCWLN5tzCASbhjnbcWwtu+fmHYTvDjms5a7q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889320; c=relaxed/simple;
	bh=j7cpECeosRQCrOQG3FbP8xjL5vadH9k2+3W4vtjY9rY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBk73aglJyYdLDLCZ2kuixJU2AaIE6QWAkS1eWgfC46b5V2DS3h95Sa2DBZCYPjUZt1xvvUt1/hfET9DRVp26r5BRRmjASdE1QEIOQlFx4XdOaSsWAp1iTeUeQLBeJrfiXL4XrJvIQZQ5xEAGOpjnMRb5mqtvO0wPKKCuHZJL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gsy50Sqz6K9Dj;
	Thu, 20 Jun 2024 21:13:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 001DF1400D9;
	Thu, 20 Jun 2024 21:15:16 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 14:15:15 +0100
Date: Thu, 20 Jun 2024 14:15:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 9/9] cxl/pci: Enable interrupts for CXL PCIe ports'
 AER internal errors
Message-ID: <20240620141514.00007c6d@Huawei.com>
In-Reply-To: <20240617200411.1426554-10-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-10-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:11 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL RAS errors are reported through AER interrupts using the AER status:
> correctbale internal errors (CIE) and AER uncorrectable internal errors

correctable

> (UIE).[1] But, the AER CIE/UIE are disabled by default preventing
> notification of CXL RAS errors.[2]
> 
> Enable CXL PCIe port RAS notification by unmasking the ports' AER CIE
> and UIE errors.
> 
> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
>              Switch Ports
> [2] PCI6.0 - 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h),
>              7.8.4.6 Correctable Error Mask Register (Offset 14h)
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

I'm not sure doing this from a driver other than the one handling the
errors makes sense.  It is doing a couple of RMW without any locking
or guarantees that the driver bound to the PCI port might care about
this changing.

I'd like more info on why we don't just turn this on in general
and hence avoid the need to control it from the 'wrong' place.

Jonathan



> ---
>  drivers/cxl/core/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e630eccb733d..73637d39df0a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -861,6 +861,12 @@ void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
>  	struct device *uport_dev = port->uport_dev;
>  
>  	cxl_port_map_regs(uport_dev, map, regs);
> +
> +	if (dev_is_pci(uport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(uport_dev);
> +
> +		pci_aer_unmask_internal_errors(pdev);

I'd skip the local variable for conciseness.

> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
>  
> @@ -878,6 +884,12 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  
>  	if (dport->rch)
>  		cxl_disable_rch_root_ints(dport);
> +
> +	if (dev_is_pci(dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dport_dev);
> +
> +		pci_aer_unmask_internal_errors(pdev);

likewise.

> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
>  

