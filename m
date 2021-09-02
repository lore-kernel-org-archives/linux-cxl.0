Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A4C676A8
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F286109E
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbhIBQiq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:38:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3714 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbhIBQip (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Sep 2021 12:38:45 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H0mlG4lH4z67Cnk;
        Fri,  3 Sep 2021 00:36:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 18:37:45 +0200
Received: from localhost (10.52.127.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 2 Sep 2021
 17:37:44 +0100
Date:   Thu, 2 Sep 2021 17:37:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <ira.weiny@intel.com>, <ben.widawsky@intel.com>
Subject: Re: [PATCH v3 11/28] libnvdimm/label: Add a helper for nlabel
 validation
Message-ID: <20210902173746.000064e2@Huawei.com>
In-Reply-To: <162982118423.1124374.11980785134458815600.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162982118423.1124374.11980785134458815600.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.69]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 24 Aug 2021 09:06:24 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In the CXL namespace label there is no need for nlabel since that is
> inferred from the region. Add a helper that moves nsl_get_label() behind
> a helper that validates the number of labels relative to the region.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Looks a bit pointless here but makes sense by patch 14.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/nvdimm/namespace_devs.c |    5 ++---
>  drivers/nvdimm/nd.h             |    7 +++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index d4959981c7d4..28ed14052e36 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1848,12 +1848,11 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, const uuid_t *uuid,
>  
>  		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
>  			struct nd_namespace_label *nd_label = label_ent->label;
> -			u16 position, nlabel;
> +			u16 position;
>  
>  			if (!nd_label)
>  				continue;
>  			position = nsl_get_position(ndd, nd_label);
> -			nlabel = nsl_get_nlabel(ndd, nd_label);
>  
>  			if (!nsl_validate_isetcookie(ndd, nd_label, cookie))
>  				continue;
> @@ -1870,7 +1869,7 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, const uuid_t *uuid,
>  				return false;
>  			}
>  			found_uuid = true;
> -			if (nlabel != nd_region->ndr_mappings)
> +			if (!nsl_validate_nlabel(nd_region, ndd, nd_label))
>  				continue;
>  			if (position != pos)
>  				continue;
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index ec3c9aad7f50..036638bdb7e3 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -342,6 +342,13 @@ struct nd_region {
>  	struct nd_mapping mapping[];
>  };
>  
> +static inline bool nsl_validate_nlabel(struct nd_region *nd_region,
> +				       struct nvdimm_drvdata *ndd,
> +				       struct nd_namespace_label *nd_label)
> +{
> +	return nsl_get_nlabel(ndd, nd_label) == nd_region->ndr_mappings;
> +}
> +
>  struct nd_blk_region {
>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
>  	int (*do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
> 

