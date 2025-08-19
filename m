Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D82222C7
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612791; cv=none; b=plECwY08eeH5rxwbTo4T8Sq+xURd4NlCWAPN+l6EBxGi+Lj23NbaHDL9pKzIA+HcqU4kPcagru4vXpdN1MM66CpjFv8mmcjc/nwYK8ibl+B01T1EkZXWUurjAB/iTUwhsrUMEVkaLUWeZJLVMkWa070rO82u8swPEfVyyQ9SZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612791; c=relaxed/simple;
	bh=LM26MwK0kA27jYUnN9HVdqjXkD9edrzyqaa075JVRcI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLMu5WHkGVuFlNcd0bPTzi4pGi+QPzr+HKUJJyzTGHO4jTyzSKouW5GMulkdfQjz+UrrxHe6JDvVtXYY9mTpUmsN4oIBeDku5TWf6cgnmwhalTqp8BVQwYugpLBoBeGI/nJEZWboLPQudCuv0VDo5IwJw+ruE255TjviPuC08tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5s0r4mBMz6GC9P;
	Tue, 19 Aug 2025 22:10:04 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id E1F8E14037D;
	Tue, 19 Aug 2025 22:13:04 +0800 (CST)
Received: from localhost (10.126.171.177) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 16:13:04 +0200
Date: Tue, 19 Aug 2025 15:12:58 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 14/18] cxl/cache: Add Cache ID Decoder capability
 mapping
Message-ID: <20250819151258.00007ed8.alireza.sanaee@huawei.com>
In-Reply-To: <20250812212921.9548-15-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-15-Benjamin.Cheatham@amd.com>
Organization: Huawei
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
 frapeml500003.china.huawei.com (7.182.85.28)

On Tue, 12 Aug 2025 16:29:17 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL Cache ID Decoder capability is an optional capability present
> on CXL downstream switch and CXL-enabled PCIe Root ports. This
> capability is required for having multiple CXL.cache enabled devices
> under the same port (CXL 3.2 8.2.4.29).
> 
> Add mapping of the capability as part of allocating a CXL cache id for
> an endpoint. Implement mapping/validation of the capability in a later
> commit.

Maybe you keep ID or Cache or Decoder consistent everywhere in the
commit message.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c     | 25 +++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  8 ++++++++
>  drivers/cxl/cxl.h       |  6 ++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index 24559b9ba8e8..f123d596187d 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -69,6 +69,27 @@ static int map_cache_idrt_cap(struct cxl_port
> *port) BIT(CXL_CM_CAP_CAP_ID_CIDRT));
>  }
>  
> +static int map_cache_idd_cap(struct cxl_dport *dport)
> +{
> +	int agents;
> +
> +	if (dport->regs.cidd)
> +		return 0;
> +
> +	/*
> +	 * A missing Cache ID Decoder capability is only an issue
> +	 * if there are multiple cache agents in the VCS
> +	 */
> +	if (!dport->reg_map.component_map.cidd.valid) {
> +		agents = atomic_read(&dport->port->cache_agents);
> +		return agents > 1 ? -ENXIO : 0;
> +	}
> +
> +	return cxl_map_component_regs(&dport->reg_map,
> +				      &dport->regs.component,
> +				      BIT(CXL_CM_CAP_CAP_ID_CIDD));
Less relevant to this patch. It looks like cxl_map_component_reg
receives redundant parameters, both regs.component and reg_map comes
from the same structure and other occurrences in the kernel also grab
components and reg_map from port, so not sure why two separate
parameters are there.
> +}
> +
>  static void free_cache_id(void *data)
>  {
>  	struct cxl_cache_state *cstate = data;
> @@ -138,6 +159,10 @@ static int
> devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd) rc =
> devm_cxl_port_program_cache_idrt(port, dport, cxlcd); if (rc)
>  			return rc;
> +
> +		rc = map_cache_idd_cap(dport);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	return 0;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 0924127bd8fd..1362f4156ee6 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -110,6 +110,13 @@ void cxl_probe_component_regs(struct device
> *dev, void __iomem *base, rmap = &map->cidrt;
>  			break;
>  		}
> +		case CXL_CM_CAP_CAP_ID_CIDD:
> +			dev_dbg(dev,
> +				"found Cache ID decoder capability
> (0x%x)\n",
> +				offset);
> +			length = CXL_CACHE_IDD_CAPABILITY_LENGTH;
> +			rmap = &map->cidd;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d
> (0x%x)\n", cap_id, offset);
> @@ -231,6 +238,7 @@ int cxl_map_component_regs(const struct
> cxl_register_map *map, { &map->component_map.ras, &regs->ras },
>  		{ &map->component_map.snoop, &regs->snoop },
>  		{ &map->component_map.cidrt, &regs->cidrt },
> +		{ &map->component_map.cidd, &regs->cidd },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1a2918aaee62..04fde1a994d0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,7 @@ extern const struct nvdimm_security_ops
> *cxl_security_ops; #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
>  #define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
> +#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability
> Structure */ @@ -176,6 +177,9 @@ static inline int
> ways_to_eiw(unsigned int ways, u8 *eiw) #define
> CXL_CACHE_IDRT_TARGETN_VALID BIT(0) #define
> CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8) 
> +/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
> +#define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -241,6 +245,7 @@ struct cxl_regs {
>  		void __iomem *ras;
>  		void __iomem *snoop;
>  		void __iomem *cidrt;
> +		void __iomem *cidd;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -285,6 +290,7 @@ struct cxl_component_reg_map {
>  	struct cxl_reg_map ras;
>  	struct cxl_reg_map snoop;
>  	struct cxl_reg_map cidrt;
> +	struct cxl_reg_map cidd;
>  };
>  
>  struct cxl_device_reg_map {

