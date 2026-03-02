Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C72C187
	for <linux-cxl@vger.kernel.org>; Mon,  2 Mar 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464876; cv=none; b=rQSG+C5lBoxHp/9+7qGtlcHls3fuUWUSbFsFoc2nIcn5zxFZuHhlzF2pTx+23Y/ec0Er0YaAMn3kHPxXwujtdl7AtDV2xuIDrItNDGjK2xp8pdzIe4EJQf1Ureq7SZAR3QaREZRxzNqS/wj7In7/haO/2UVdiKpA86oqT1RbcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464876; c=relaxed/simple;
	bh=LF0Q/Gj06oTpDIMQhYLPsuiDbWsSgO2SH+Sj8FdqUek=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP976Sefu3xZPvaPXEAgdVYIZ6cNRBISOipEGSE3lxYxe9Fd9yzYJs3wquhdR2Au4wvlBq44dKQYfKkI9JuSxVr90dNWNAH1ATV5iwjACz5cFivfSGj2/2GZkJoqymZK7RbevI53bl176fV+C/nwSBK/N+pB78JimgIDrNpLsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPjKv2LX3zHnGcs;
	Mon,  2 Mar 2026 23:20:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 50D5440569;
	Mon,  2 Mar 2026 23:21:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 15:21:10 +0000
Date: Mon, 2 Mar 2026 15:21:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 4/4] cxl/pci: Remove redundant cxl_pci_find_port()
 call
Message-ID: <20260302152109.0000707d@huawei.com>
In-Reply-To: <20260228172549.1121832-5-alejandro.lucero-palau@amd.com>
References: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
	<20260228172549.1121832-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 28 Feb 2026 17:25:49 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
Needs to match the sign-off.

git commit --amend --author="Gregory Price <gourry@gourry.net>"
Should fix that up for you.

> 
> Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
> dport parameter directly. The caller has already validated the port is
> non-NULL before invoking this function.

Given the existing caller only does this immediately before the function call,
what the reasoning for dropping this one rather than dropping the one in
cxl_pci_setup_regs() which would have the same effect?  I'm fine with doing
it here, but needs a tiny bit more descriptive text.  With that added and
the author fixed up

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c32cc62c501d..d1f487b3d809 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
>  	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>  	if (component_reg_phys == CXL_RESOURCE_NONE)
>  		return -ENXIO;

