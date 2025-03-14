Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC471FDE29;
	Fri, 14 Mar 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954286; cv=none; b=CklXhFTULHeOnEeXXohEUbc+8SuwgUucxNbGIfCRCw9sWtllA0WHVShBgcTUV470mBLvH9K6X08qOE+VvDz24eOyiIM3Nc8hArQsKUi9DSyNLmIqJH2r3+eswq61C7uhLNIVfqOqYy5BudZ1xanBCgCy4dDLzezvbyx/GZtqShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954286; c=relaxed/simple;
	bh=Xc8gsw5EvnSyLHhGt3r+kfwiA5oqCRPMhBtAyx2IZnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mlr3ga7cjHqTG5OX3TXbhqYk/0A3UtP9BtAUi/mw9iG24E7clynLlVqPYds+k8TS463lcoOGE2kfVCenlYS0lGOxqydLFyvXcqzEnPXVZ3duDxcnLjFLd4Lvc3c4AQA8Jn3X2WNUnMTRaIW3e/pwXnFgjM7p89iTvFT1DxC9NkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDjng6dhzz6K5WX;
	Fri, 14 Mar 2025 20:08:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C959F140155;
	Fri, 14 Mar 2025 20:11:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:11:20 +0100
Date: Fri, 14 Mar 2025 12:11:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 1/2] cxl/pci: Ignore downstream ports with duplicate
 port IDs
Message-ID: <20250314121118.000014c0@huawei.com>
In-Reply-To: <20250305100123.3077031-2-rrichter@amd.com>
References: <20250305100123.3077031-1-rrichter@amd.com>
	<20250305100123.3077031-2-rrichter@amd.com>
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

On Wed, 5 Mar 2025 11:01:22 +0100
Robert Richter <rrichter@amd.com> wrote:

> If a link is inactive, the port ID in the PCIe Link Capability
> Register of a downstream port may not be assigned yet. Another
> downstream port with an inactive link on the same Downstream Switch
> Port may have the same port ID. In this case the port enumeration of
> the root or downstream port fails due to duplicate port IDs
> (devm_cxl_port_enumerate_dports()/add_dport()).

Obviously it's a bit irrelevant if there is hardware doing that, but
can you add a PCI spec reference that says the port ID may not be configured.

In my (often wrong) mental model, these are fixed values. It's marked
HwInit and text for that talks about conventional reset (which I'm not
sure applies here).  I can't find any other references to when you
are allowed to read this.

Anyhow I'd like to know if this is a quirk or a bug fix for compliant
hardware.

Jonathan


> 
> Relax the check and just ignore downstream ports with duplicate port
> IDs. Do not fail and continue to enumerate all downstream ports of a
> CXL Root Port or CXL Switch. Turn the related dev_err() messages into
> a dev_dbg().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 10 ++++++++--
>  drivers/cxl/core/port.c |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index fbc50b1156b8..524b8749cc0b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -59,8 +59,14 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>  	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>  	if (IS_ERR(dport)) {
> -		ctx->error = PTR_ERR(dport);
> -		return PTR_ERR(dport);
> +		rc = PTR_ERR(dport);
> +		if (rc == -EBUSY) {
> +			dev_dbg(&port->dev, "failed to add dport %s, continuing\n",
> +				dev_name(&pdev->dev));
> +			return 0;
> +		}
> +		ctx->error = rc;
> +		return rc;
>  	}
>  	ctx->count++;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 33607301c5d3..8038cbeffbf7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1071,7 +1071,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  	device_lock_assert(&port->dev);
>  	dup = find_dport(port, dport->port_id);
>  	if (dup) {
> -		dev_err(&port->dev,
> +		dev_dbg(&port->dev,
>  			"unable to add dport%d-%s non-unique port id (%s)\n",
>  			dport->port_id, dev_name(dport->dport_dev),
>  			dev_name(dup->dport_dev));

