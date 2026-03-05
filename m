Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF5379EE8
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708361; cv=none; b=GjN6u5rEc/SmnENVnLTipAClukLgANCtfc76r2wTpcodxI8jGYglIu+wyFXW5RW3A6d7353cINtzUVxk26yW6tpRNIsdAHZb6ZsME/Si8yrfNOMsXi2usr6Eb0m9iUuMfMeJ9jHUeH5BLMy48LGOvOM5xMUtcvB8ybmv9VAg2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708361; c=relaxed/simple;
	bh=OJID0qV05Nx+oiWNoNOLmoJzc7CA4r612ASGo/DEtWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPoO6PGf337kaElpZWMPyUrBudt3iTu2PN7D2Ayodz05JCqwxsHD6VzQgxscbQlRe+ebniST8K6Rx7EiL4DdmlsGTMT4bOhas/rKxL/emgXDjXyWbeC3yyJ+uoV9HiO0fcVEai3leZPGWqpFSa91Xtjy+RXdyaAWAbXIqHm0rTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fRRNd1YJzzJ46n0;
	Thu,  5 Mar 2026 18:58:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7256D40569;
	Thu,  5 Mar 2026 18:59:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 10:59:16 +0000
Date: Thu, 5 Mar 2026 10:59:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH 3/3] hw/cxl/events: Fixes for component id in event
 records generation
Message-ID: <20260305105915.00000875@huawei.com>
In-Reply-To: <20260227223207.972-4-shiju.jose@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
	<20260227223207.972-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 27 Feb 2026 22:32:06 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>

As for patch 1, nice if the title suggests what is being fixed.
With that,
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> Component id in CXL events is 16 bytes data, but event record generation copy
> 15 bytes only from the qmp "component-id" field using strncpy.
> Replace strncpy with memcpy and change length of data to copy to the size of the
> component_id array (16 bytes).
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3cb1096e16..03a5d1751f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1895,8 +1895,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>      }
>  
>      if (component_id) {
> -        strncpy((char *)gem.component_id, component_id,
> -                sizeof(gem.component_id) - 1);
> +        memcpy(gem.component_id, component_id, sizeof(gem.component_id));
>          valid_flags |= CXL_GMER_VALID_COMPONENT;
>          if (has_comp_id_pldm && is_comp_id_pldm) {
>              valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
> @@ -2066,8 +2065,7 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>      }
>  
>      if (component_id) {
> -        strncpy((char *)dram.component_id, component_id,
> -                sizeof(dram.component_id) - 1);
> +        memcpy(dram.component_id, component_id, sizeof(dram.component_id));
>          valid_flags |= CXL_DRAM_VALID_COMPONENT;
>          if (has_comp_id_pldm && is_comp_id_pldm) {
>              valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
> @@ -2185,8 +2183,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>               corrected_persist_error_count);
>  
>      if (component_id) {
> -        strncpy((char *)module.component_id, component_id,
> -                sizeof(module.component_id) - 1);
> +        memcpy(module.component_id, component_id, sizeof(module.component_id));
>          valid_flags |= CXL_MMER_VALID_COMPONENT;
>          if (has_comp_id_pldm && is_comp_id_pldm) {
>              valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;

