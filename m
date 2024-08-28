Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E4145FFF
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833294; cv=none; b=BNFVo3ijwbjxINshe7Beupe39XzGu55JzleZHmLK1PrV1rYsQrknazFkw8NrX/DC5icFLXttkUzuQSf8MRoGrsIi/2AFeVktBzL4F5ZNbpc1hujmjtbGTIfLlw9f6aKwAusR2EfGhjVsLbbQP5r7gCFKstAkdjSYzUbxMRKWHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833294; c=relaxed/simple;
	bh=QYQR0Sr9MIVbQZ9X5hKv35Y7oZZDg+g6UNWZdh4xjyY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwZpfm4DKEfMZ6DmlXJG4OGGpMwFVdmcQ0slVn+Z8kk8h7xrODL/ErALLhMx5JvUUorZmvgYv6Id7DnKsvAwQUe4w4pGINORvNrr96lgvF6expPiusjpN+5C1X425kCArByIcrNRJxH+qGJ4lPffbdVyBkbtZEDssFReMJE9Vek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wty2H06xxz6K6LZ;
	Wed, 28 Aug 2024 16:17:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C7B38140447;
	Wed, 28 Aug 2024 16:21:27 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 09:21:27 +0100
Date: Wed, 28 Aug 2024 09:21:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/pci: Remove reduplicate host_bridge->native_aer
 checking
Message-ID: <20240828092130.000032b4@Huawei.com>
In-Reply-To: <20240827045755.1837473-3-ming4.li@intel.com>
References: <20240827045755.1837473-1-ming4.li@intel.com>
	<20240827045755.1837473-3-ming4.li@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 04:57:55 +0000
Li Ming <ming4.li@intel.com> wrote:

For title, just duplicate (not reduplicate)


> cxl_dport_init_aer() already checks host_bridge->native_aer before
> invoking cxl_disable_rch_root_ints(), so cxl_disable_rch_root_ints()
> does not need to check it again.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pci.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 118db6a577d7..7234166df0df 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -800,14 +800,11 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> -	struct pci_host_bridge *bridge;
>  	u32 aer_cmd_mask, aer_cmd;
>  
>  	if (!aer_base)
>  		return;
>  
> -	bridge = to_pci_host_bridge(dport->dport_dev);
> -
>  	/*
>  	 * Disable RCH root port command interrupts.
>  	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> @@ -816,14 +813,12 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	 * the root cmd register's interrupts is required. But, PCI spec
>  	 * shows these are disabled by default on reset.
>  	 */
> -	if (bridge->native_aer) {
> -		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> -				PCI_ERR_ROOT_CMD_NONFATAL_EN |
> -				PCI_ERR_ROOT_CMD_FATAL_EN);
> -		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> -		aer_cmd &= ~aer_cmd_mask;
> -		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> -	}
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
>  /**

