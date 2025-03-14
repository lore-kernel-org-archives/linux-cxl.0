Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F311ACEC6;
	Fri, 14 Mar 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954468; cv=none; b=M6KtDHKqgZ0gnk8cE04tNkcfEDgZMxNIoKmgk9wfjYvAyF62WzXAJe++SFGQqEksTU86UdtHIfwjXxPAFM/c85JEVG/ZE1hAFkAn+UsrWz9mq4+WC9T+/YhHU1hSnwfmS3e3kiYgNYxG/Qt/axWB28DvKhe+MM2AT6OP1vA2mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954468; c=relaxed/simple;
	bh=CEGDIbCSYYBjuLAqgTPFoj/SxZ+LElIDkIBh0fHUnrM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUH53ckOkKY/+mkPwLSN57rjHZT0nAARf5rRxF+BjEN5q75gb2NhFqPzavyImaYXGknI4l6TxXqIT6z8RYQsamQl9OAEi1GKWHL+Vx5puux4tW/gtcUUydNI9UjiBhFIUt13eZVRLNY9aiTeWyCbBAGCXNhcmmlkjuQv84QZsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDjs943mwz6K5Vq;
	Fri, 14 Mar 2025 20:11:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7115C140B39;
	Fri, 14 Mar 2025 20:14:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:14:21 +0100
Date: Fri, 14 Mar 2025 12:14:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 2/2] cxl/pci: Check link status and only enable active
 dports
Message-ID: <20250314121420.0000069b@huawei.com>
In-Reply-To: <20250305100123.3077031-3-rrichter@amd.com>
References: <20250305100123.3077031-1-rrichter@amd.com>
	<20250305100123.3077031-3-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 11:01:23 +0100
Robert Richter <rrichter@amd.com> wrote:

> When downstream ports are enumerated, some of them may not be
> connected to a corresponding endpoint or upstream switch port. The
> dport is inactive and its link status is down then. For permanently
> disabled ports a HwInit configuration mechanism (set by hardware or
> firmware) may assign a (further unused) default port number. The port
> number may be set to the same value accross other inactive links.

Spec reference needed.  This sounds like it came from the spec but
searching for it isn't finding anything.

> Those duplicate port numbers cause the downstream port enumeration to
> fail including the root or switch port initialization
> (cxl_switch_port_probe()) and all its active downstream ports.
> 
> Prevent a port initialization failure by checking the link status and
> only enabling active dports. If a dport is inactive, there is no
> matching component (endpoint or switch) connected to and thus, it must
> not be enumerated and added to the kernel's CXL device hierarchy.
> There is no device that will connect to an inactive dport.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 524b8749cc0b..72683e1b41e3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -32,6 +32,26 @@ struct cxl_walk_context {
>  	int count;
>  };
>  
> +static int get_port_num(struct pci_dev *pdev)
> +{
> +	u32 lnkcap, port_num;
> +	u16 lnksta;
> +
> +	if (pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap))
> +		return -ENXIO;
> +
> +	/* Skip inactive links */
> +	if (lnkcap & PCI_EXP_LNKCAP_DLLLARC) {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOENT;
> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +	return port_num;
> +}
> +
>  static int match_add_dports(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_walk_context *ctx = data;
> @@ -39,7 +59,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	int type = pci_pcie_type(pdev);
>  	struct cxl_register_map map;
>  	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> +	int port_num;
>  	int rc;
>  
>  	if (pdev->bus != ctx->bus)
> @@ -48,15 +68,17 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (type != ctx->type)
>  		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> +
> +	port_num = get_port_num(pdev);
> +	if (port_num == -ENOENT)
> +		pci_dbg(pdev, "Skipping dport, link is down\n");
> +	if (port_num < 0)
>  		return 0;
>  
>  	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>  	if (rc)
>  		dev_dbg(&port->dev, "failed to find component registers\n");
>  
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>  	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>  	if (IS_ERR(dport)) {
>  		rc = PTR_ERR(dport);

