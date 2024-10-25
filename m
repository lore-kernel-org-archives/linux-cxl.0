Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A02064E3;
	Fri, 25 Oct 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860578; cv=none; b=R86kWm1RkKXEr+BnLmOiK/1/WKgUehtX2I31ol6vPMSG/s/tYU3OnAIDZ7wx6deekFov6ocsCGTtyz32v7TY/nz3JMqSNgy20hm3XxC3wuj6kmbA9TIsAUmbPQ5louAayPvbJd8BzLMOXUxIGuk8W1jMkvz5ggL/I18vV/5w4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860578; c=relaxed/simple;
	bh=4fUJF73a5oXUqA7Zgwy5HERtObrrQMaFZqOBiL3DjrY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzDcWdeS2pBZ94OOdQIcccue85/JaBlFhm7yHtovn09KuHIP/1K2JK6jj4lH7zWQc6p6S5Dc9/81cQCgEYrHG8c6605Vn3ci2Z2FOSdswPMtifibaXBDrhwq1tN6xrmSIpWuZd/LqE5OcBPv2t9RPh9cpcbhyF8hxb79RUWt3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZjCs3LCJz6LD0c;
	Fri, 25 Oct 2024 20:44:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C09A31408F9;
	Fri, 25 Oct 2024 20:49:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 14:49:24 +0200
Date: Fri, 25 Oct 2024 13:49:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v3 2/6] cxl/events: Add Component Identifier formatting
 for CXL spec rev 3.1
Message-ID: <20241025134922.0000145f@Huawei.com>
In-Reply-To: <20241025114555.1363-3-shiju.jose@huawei.com>
References: <20241025114555.1363-1-shiju.jose@huawei.com>
	<20241025114555.1363-3-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 12:45:51 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add Component Identifier formatting for CXL spec rev 3.1, Section
> 8.2.9.2.1, Table 8-44.
> 
> Examples for Component Identifier format in trace log,
> 
> validity_flags='CHANNEL|RANK|DEVICE|COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='PLDM Entity ID | Resource ID' \
> pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \
> 
> validity_flags='COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='Resource ID' \
> pldm_entity_id=0x00 pldm_resource_id=fc d2 7e 2f
> 
> If the validity flags for component ID/component ID format or PLDM ID or
> resource ID are not set, then pldm_entity_id=0x00 or pldm_resource_id=0x00
> would be printed.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Given I can't find any more information in the PLDM specs on how
these might be formatted, this looks like the best we can do.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/trace.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 7305974e2301..b508873ce426 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -268,6 +268,28 @@ TRACE_EVENT(cxl_generic_event,
>  	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
>  )
>  
> +/*
> + * Component ID Format
> + * CXL 3.1 section 8.2.9.2.1; Table 8-44
> + */
> +#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
> +#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
> +
> +#define show_comp_id_pldm_flags(flags)  __print_flags(flags, " | ",	\
> +	{ CXL_PLDM_COMPONENT_ID_ENTITY_VALID,   "PLDM Entity ID" },	\
> +	{ CXL_PLDM_COMPONENT_ID_RES_VALID,      "Resource ID" }		\
> +)
> +
> +#define show_pldm_entity_id(flags, valid_comp_id, valid_id_format, comp_id)	\
> +	(flags & valid_comp_id && flags & valid_id_format) ?			\
> +	(comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) ?			\
> +	__print_hex(&comp_id[1], 6) : "0x00" : "0x00"
> +
> +#define show_pldm_resource_id(flags, valid_comp_id, valid_id_format, comp_id)	\
> +	(flags & valid_comp_id && flags & valid_id_format) ?			\
> +	(comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) ?			\
> +	__print_hex(&comp_id[7], 4) : "0x00" : "0x00"
> +
>  /*
>   * General Media Event Record - GMER
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43

