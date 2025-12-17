Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECF192B7D
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987787; cv=none; b=gK5Vle0T3TRoEbfCpgwFI/j0+wh+xL6Ukvvh1xdbSA32V64P5LqV7/sNxsQ2gKW0VF/Axw42Af9CyH0eq+vTOsWqHXai/RJBkMosvL2wNcpFjZpXu3WpU1II7vpS4a6wdUewLoCKYisEVBYtwiOd5CxpNA0A09wFf+A0hq5a+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987787; c=relaxed/simple;
	bh=qu9jsg0IxF6dgP/a67OAV6kclH7Z7t/HyZO5NRRWWnw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQRpjYJaxlvUXHufgHIc8mPD2bP2m4qGTVdrjwZBeDBBo1p/lFvWe4iSzasR2PsfkaRLnH+j2XSHy5Sr/8T2AYI55+zW/pcKwW5w0gFR2uj+s9P4VH0VQCJHE2FlBZm2zpUIVTn2Zab5AXAUve0VX1fNLkX4rrklzd2UBUlJRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWdyx6p9tzHnGhG;
	Thu, 18 Dec 2025 00:09:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C73B40565;
	Thu, 18 Dec 2025 00:09:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:09:38 +0000
Date: Wed, 17 Dec 2025 16:09:37 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 03/17] cxl/core: Add function for getting CXL cache info
Message-ID: <20251217160937.000021e9@huawei.com>
In-Reply-To: <20251111214032.8188-4-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-4-Benjamin.Cheatham@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:18 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add a function for getting common CXL.cache information. This
> information will be stored in the struct cxl_cache_state member
> (cstate) of struct cxl_dev_state for easy access by endpoint drivers.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

I'm only having a first read through so probably only superficial feedback
at this point.

We have so many major series floating around I suspect this will be a cycle
or two anyway :(

Anyhow, comments inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/pci.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      | 13 +++++++++++
>  drivers/cxl/cxlcache.h |  7 ++++++
>  drivers/cxl/cxlpci.h   |  4 ++++
>  4 files changed, 77 insertions(+)
>  create mode 100644 drivers/cxl/cxlcache.h
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 18825e1505d6..5b1cace8fc0f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxlcache.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1258,3 +1259,55 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");

Stray change?

> +
> +/**
> + * cxl_accel_read_cache_info - Get the CXL cache information of a CXL cache device
> + * @cxlds: CXL device state associated with cache device
> + *
> + * Returns 0 and populates the struct cxl_cache_state member of @cxlds on
> + * success, error otherwise.
> + */
> +int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_cache_state *cstate = &cxlds->cstate;
> +	struct pci_dev *pdev;
> +	int dvsec, rc;
> +	u16 cap, cap2;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +	pdev = to_pci_dev(cxlds->dev);
> +
> +	dvsec = cxlds->cxl_dvsec;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
> +		return -ENXIO;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
> +	if (rc)
> +		return rc;
> +
> +	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */

Given old versions of CXL spec tend to become hard to get, probably
shift to using 4.0 references for this series (this probably raced
with that being published!)

> +	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
> +	case 1:
> +		cstate->unit = 64 * SZ_1K;

SZ_64K

I'll comment on it in the sysfs abi patch but I'm not seeing unit
as necessarily something we need to keep around once we have
used it to interpret the size.  So probably local variable is fine.

> +		break;
> +	case 2:
> +		cstate->unit = SZ_1M;
> +		break;
> +	default:

I wonder if there are devices out there that simply don't tell us
(so case 0)?

> +		return -ENXIO;
> +	}
> +
> +	cstate->size = FIELD_GET(CXL_DVSEC_CACHE_SIZE_MASK, cap2) * cstate->unit;
> +	if (!cstate->size)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1950cf3d5399..259d806fb3e3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -759,6 +759,17 @@ struct cxl_dpa_info {
>  	int nr_partitions;
>  };
>  
> +
> +/**
> + * struct cxl_cache_state - State of a device's CXL cache
> + * @size: Size of cache in bytes
> + * @unit: Unit size of cache in bytes
> + */
> +struct cxl_cache_state {
> +	u64 size;
> +	u32 unit;
> +};

