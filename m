Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7978C6D
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633443; cv=none; b=nrHI6+STuIUSEC6RNkH52UCMjOR5BFkhvqArDa/DVadta7Oz+JFccOSHJmiNi2sVtHlb+zA9mcCo54w2rnI4zkPPehFnUSI+arXZ2IIopEiYBiMS5Dm3pJZ6epLO0Pq6q74J0GAQRO1+31ULJtAlq9y5+X7udN4TZ3b/hIdpZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633443; c=relaxed/simple;
	bh=nJfTaCAxbpAnnnbM8n63wzAB76uT+a4ZKjWhTB94oC4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4PW5PuffMajprkEhPmut5UvnBm5A8irTm3IsGDH2ovYTKWBT0R+Ei1uXb1kjYjQi3yae/E0/3Ht2yiP3182mFk9UhVHPFSaG1GL/jDsVE5XwLMGFGHZzDFo/+4bdZs5DcQYRb/Flaf+GB2R+kXvaoy2XDAvlsJzBEtpbEJreNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyQnB5rWzz6LD8m;
	Tue, 26 Nov 2024 23:03:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 96385140CB9;
	Tue, 26 Nov 2024 23:03:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 16:03:58 +0100
Date: Tue, 26 Nov 2024 15:03:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming4.li@outlook.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
Message-ID: <20241126150356.00001b2d@huawei.com>
In-Reply-To: <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
References: <20241122072001.94758-1-ming4.li@outlook.com>
	<VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Nov 2024 15:20:01 +0800
Li Ming <ming4.li@outlook.com> wrote:

> cxl-test environment always hits below call trace with KASAN
> enabled
> 
>  BUG: KASAN: slab-out-of-bounds in pcie_capability_read_word+0x1df/0x220
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x82/0xd0
>   print_report+0xcb/0x5d0
>   kasan_report+0xbd/0xf0
>   pcie_capability_read_word+0x1df/0x220
>   pcie_link_speed_mbps+0x6a/0x130
>   cxl_pci_get_bandwidth+0x68/0x1c0 [cxl_core]
>   cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x780 [cxl_core]
>   cxl_region_shared_upstream_bandwidth_update+0x257/0x1640 [cxl_core]
>   cxl_region_attach+0x1025/0x1e80 [cxl_core]
>   cxl_add_to_region+0x121/0x14c0 [cxl_core]
>   discover_region+0xa5/0x150 [cxl_port]
> 
> cxl-test environment creates cxl memory devices based on platform devices
> rather than PCI devices for testing. but cxl_endpoint_gather_bandwidth()
> always assumes the device is a PCI device, it will cause the issue in
> cxl_pci_get_bandwidth().
> 
> The fixup is that faking a maximun bandwidth in cxl_pci_get_bandwidth()

maximum

> for a platform device so that the cxl-test environment can be used to
> validate the functionality of region bandwidth.
> 
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Li Ming <ming4.li@outlook.com>
> ---
>  drivers/cxl/core/cdat.c |  5 ++---
>  drivers/cxl/core/core.h |  2 +-
>  drivers/cxl/core/pci.c  | 24 +++++++++++++++++-------
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..bd0448c3c9a8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/platform_device.h>

Having a platform device include in a file called pci.c is a bit nasty..
Can we instead check if the device is not a pci one?


>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1032,19 +1033,28 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>  
> -int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> +int cxl_pci_get_bandwidth(struct device *dev, struct access_coordinate *c)
>  {
>  	int speed, bw;
>  	u16 lnksta;
>  	u32 width;
>  
> -	speed = pcie_link_speed_mbps(pdev);
> -	if (speed < 0)
> -		return speed;
> -	speed /= BITS_PER_BYTE;
> +	if (dev_is_platform(dev)) {
> +		/* PCIE_SPEED_64_0GT as fake speed for platform device */
> +		speed = 64000 / BITS_PER_BYTE;
> +		/* PCI_EXP_LNKSTA_NLW_X8 as fake width for platform device */
> +		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, PCI_EXP_LNKSTA_NLW_X8);
> +	} else {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		speed = pcie_link_speed_mbps(pdev);
> +		if (speed < 0)
> +			return speed;
> +		speed /= BITS_PER_BYTE;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> -	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +	}
>  	bw = speed * width;
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {

