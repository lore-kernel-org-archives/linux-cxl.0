Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16C37A4BC
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708291; cv=none; b=k3PAHnQCEwMwU1NLb1Czu6sQ11RZIGPDO2pAj0RJXX6mGDboyZffZuv5w3a/iKE9AKG6MQEXLCmNwWzpEWbnBiZ7bXJq/LynlV6vjoCWLETmw85IXNW4CBRKNXB8Xtc5PzJEcPtcY47mEnq8MvFsC6Olan3U2Onpd+WBd+hIs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708291; c=relaxed/simple;
	bh=IvfxovO+CdqyjNmRB4o59Muv7AAtHfbYwYLaJ8dgrPQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc5F8ejgnSYraSwKduhQP9aBAjajgbo0r9riJhZwveWtrYPsTcDkLFZwi6XcGHDj68/GYMcay6EYPccqXAKyg8RIGMnWbulVtDw/FJBxBucPMLsZI9ZmOG5RVlfCIs2IEG3+Vdnpy32DnF10TE8or0EKHvBSncPpYXYcgNwAgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fRRM66DQQzJ46q7;
	Thu,  5 Mar 2026 18:57:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E3674056A;
	Thu,  5 Mar 2026 18:57:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 10:57:48 +0000
Date: Thu, 5 Mar 2026 10:57:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/3] hw/cxl: Add fixes in maintenance and memory sparing
Message-ID: <20260305105746.00000529@huawei.com>
In-Reply-To: <20260227223207.972-2-shiju.jose@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
	<20260227223207.972-2-shiju.jose@huawei.com>
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

On Fri, 27 Feb 2026 22:32:04 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

Perhaps a more specific title would help people understand quickly what
type of fix this is?

Something like:
hw/cxl: Fix handling of component ID to not assume it is a string.


> 
> Add following fixes to the commit: hw/cxl: Add support for Maintenance
> command and Post Package Repair (PPR).
That just wants to be a reference to the fixes tag.

> 
> 1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy to
> solve coverity warning because full size of the array to use as length in
> strncpy to copy the entire component id data, which is 16 bytes.
I wouldn't necessarily focus on the coverity issue bit of this, but rather that
it's not a string so memcpy is the correct function to use.  Then flag it as
as being identified as a result of the coverity warning.
> 
> 2. In cxl_maintenance_insert(),
>  - replace strncpy with memcpy in to copy full data because component id is
>    16 bytes data.
>  - remove memset which is not required.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

The original patch is upstream, so need a Fixes tag. I can't remember how
we mark coverity issue closures, so look for a similar patch and copy that
style. Maybe just a Closes tag for Peter's email pointing it out.

Code looks good.

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 4 ++--
>  hw/mem/cxl_type3.c         | 4 +---
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c83b5f90d4..9c99422cd4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1994,8 +1994,8 @@ static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
>          stw_le_p(&event_rec.column, ent->column);
>          event_rec.sub_channel = ent->sub_channel;
>          if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
> -            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
> -                    sizeof(event_rec.component_id));
> +            memcpy(event_rec.component_id, ent->component_id,
> +                   sizeof(event_rec.component_id));
>          }
>      } else if (sparing_pi) {
>          event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4739239da3..3cb1096e16 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1767,7 +1767,6 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
>          }
>      }
>      m = g_new0(CXLMaintenance, 1);
> -    memset(m, 0, sizeof(*m));
>      m->dpa = dpa;
>      m->validity_flags = 0;
>  
> @@ -1804,8 +1803,7 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
>          m->validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
>      }
>      if (component_id) {
> -        strncpy((char *)m->component_id, component_id,
> -                sizeof(m->component_id) - 1);
> +        memcpy(m->component_id, component_id, sizeof(m->component_id));
>          m->validity_flags |= CXL_MSER_VALID_COMP_ID;
>          if (has_comp_id_pldm && is_comp_id_pldm) {
>              m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;

