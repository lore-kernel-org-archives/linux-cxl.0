Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68451CA9F
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969515; cv=none; b=VRsOrykx66/ETQfd7T1mjlk60f5Ca7NoWi7mbZPDCcPXYgFWdlG3XmSwPttixifhEZE7n/8zvDl0I5ajZ+Cq63GOV5Ht8BKfSweelNEPrhMsSrukgV8BznNWv+qsQYnfMRwRrmBsz0pHM/yK0CmB42EgXufK6KDCfNH/Mo1Jang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969515; c=relaxed/simple;
	bh=F8dE5tcQNMcrtmNA/KieAIX3AegVrejAkGVf3+8XRPo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+CDF6Jt5XZyrSHeRiOuulBE6rmP34/+686mepk8NHmQqsNrKX9m3VsRI7C/+lSQtxLNHf2By2HljaPBM4CKX3f/nSYIN48Pib5Co/eVH1m6Lokf2GWUbzXusrdm+U5NYtUiW4FtyKq0e0NbTuD1B2ArckutDSTgeEPRkhiYOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk7Dz5CXwz6JBTy;
	Tue, 27 Feb 2024 01:40:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E41F9140B73;
	Tue, 27 Feb 2024 01:45:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 17:45:09 +0000
Date: Mon, 26 Feb 2024 17:45:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240226174508.00006366@Huawei.com>
In-Reply-To: <20240221182020.1086096-7-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-7-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 10:15:59 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all dc regions share one
>    one host backend.
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region;
> 4. Fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Only comment on this one from me is beware of FIXME wording for
features we haven't implemented yet.  Makes people thing code isn't
good to go, when in reality we may or may not care about implementing
that configurability in the future!

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6e5f908fb1..b966fa4f10 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +
> +    if (dc_mr) {
> +        int i;
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /* FIXME: Currently we assume the dynamic capacity to be volatile. */
As below.  TODO: Allow for non volatile dynamic capacity.

> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
> +                    dsmad_handle++,
> +                    ct3d->dc.regions[i].len,
> +                    false, true, region_base);
> +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +
> +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> +            region_base += ct3d->dc.regions[i].len;
> +        }
> +    }
> +



> +
> +        /* FIXME: set dc as volatile for now */

Not sure it's a fixme, more of a TODO to add control of this later.
Fixme sounds broken, whereas it's a missing feature only.

> +        memory_region_set_nonvolatile(dc_mr, false);
> +        memory_region_set_enabled(dc_mr, true);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +        if (ds->id) {
> +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +        } else {
> +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +        }
> +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +        g_free(dc_name);
> +
> +        if (!cxl_create_dc_regions(ct3d, errp)) {
> +            error_setg(errp, "setup DC regions failed");
> +            return false;
> +        }
> 
