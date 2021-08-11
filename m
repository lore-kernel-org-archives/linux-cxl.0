Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358CC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA47C61019
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 18:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhHKSuC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:50:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3639 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhHKSuB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 14:50:01 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GlJkh5YtWz6G9JB;
        Thu, 12 Aug 2021 02:49:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 11 Aug 2021 20:49:36 +0200
Received: from localhost (10.52.123.85) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 19:49:35 +0100
Date:   Wed, 11 Aug 2021 19:49:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <ben.widawsky@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 09/23] libnvdimm/labels: Add address-abstraction uuid
 definitions
Message-ID: <20210811194905.000034f6@Huawei.com>
In-Reply-To: <162854811511.1980150.3921515741758120378.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162854811511.1980150.3921515741758120378.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.85]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 9 Aug 2021 15:28:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The EFI definition of the labels represents the Linux "claim class" with
> a GUID. The CXL definition of the labels stores the same identifier in
> UUID byte order. In preparation for adding CXL label support, enable the
> claim class to optionally handle uuids.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I've already commented on 10 and 11 so this was backfilling tags
for the ones I'd looked at earlier but looked good to me.

I'm not all that familiar with this code yet, so all my checking was off the
"does it look locally correct?" variety.

Out of time for today, and not sure when I'll get to looking at the remainder.

Jonathan

> ---
>  drivers/nvdimm/label.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index 7f473f9db300..2ba31b883b28 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -17,6 +17,11 @@ static guid_t nvdimm_btt2_guid;
>  static guid_t nvdimm_pfn_guid;
>  static guid_t nvdimm_dax_guid;
>  
> +static uuid_t nvdimm_btt_uuid;
> +static uuid_t nvdimm_btt2_uuid;
> +static uuid_t nvdimm_pfn_uuid;
> +static uuid_t nvdimm_dax_uuid;
> +
>  static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
>  
>  static u32 best_seq(u32 a, u32 b)
> @@ -724,7 +729,7 @@ static unsigned long nd_label_offset(struct nvdimm_drvdata *ndd,
>  		- (unsigned long) to_namespace_index(ndd, 0);
>  }
>  
> -static enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
> +static enum nvdimm_claim_class guid_to_nvdimm_cclass(guid_t *guid)
>  {
>  	if (guid_equal(guid, &nvdimm_btt_guid))
>  		return NVDIMM_CCLASS_BTT;
> @@ -740,6 +745,23 @@ static enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
>  	return NVDIMM_CCLASS_UNKNOWN;
>  }
>  
> +/* CXL labels store UUIDs instead of GUIDs for the same data */
> +enum nvdimm_claim_class uuid_to_nvdimm_cclass(uuid_t *uuid)
> +{
> +	if (uuid_equal(uuid, &nvdimm_btt_uuid))
> +		return NVDIMM_CCLASS_BTT;
> +	else if (uuid_equal(uuid, &nvdimm_btt2_uuid))
> +		return NVDIMM_CCLASS_BTT2;
> +	else if (uuid_equal(uuid, &nvdimm_pfn_uuid))
> +		return NVDIMM_CCLASS_PFN;
> +	else if (uuid_equal(uuid, &nvdimm_dax_uuid))
> +		return NVDIMM_CCLASS_DAX;
> +	else if (uuid_equal(uuid, &uuid_null))
> +		return NVDIMM_CCLASS_NONE;
> +
> +	return NVDIMM_CCLASS_UNKNOWN;
> +}
> +
>  static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
>  	guid_t *target)
>  {
> @@ -761,6 +783,29 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
>  		return &guid_null;
>  }
>  
> +/* CXL labels store UUIDs instead of GUIDs for the same data */
> +__maybe_unused
> +static const uuid_t *to_abstraction_uuid(enum nvdimm_claim_class claim_class,
> +					 uuid_t *target)
> +{
> +	if (claim_class == NVDIMM_CCLASS_BTT)
> +		return &nvdimm_btt_uuid;
> +	else if (claim_class == NVDIMM_CCLASS_BTT2)
> +		return &nvdimm_btt2_uuid;
> +	else if (claim_class == NVDIMM_CCLASS_PFN)
> +		return &nvdimm_pfn_uuid;
> +	else if (claim_class == NVDIMM_CCLASS_DAX)
> +		return &nvdimm_dax_uuid;
> +	else if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
> +		/*
> +		 * If we're modifying a namespace for which we don't
> +		 * know the claim_class, don't touch the existing uuid.
> +		 */
> +		return target;
> +	} else
> +		return &uuid_null;
> +}
> +
>  static void reap_victim(struct nd_mapping *nd_mapping,
>  		struct nd_label_ent *victim)
>  {
> @@ -808,7 +853,7 @@ enum nvdimm_claim_class nsl_get_claim_class(struct nvdimm_drvdata *ndd,
>  {
>  	if (!namespace_label_has(ndd, abstraction_guid))
>  		return NVDIMM_CCLASS_NONE;
> -	return to_nvdimm_cclass(&nd_label->abstraction_guid);
> +	return guid_to_nvdimm_cclass(&nd_label->abstraction_guid);
>  }
>  
>  static int __pmem_label_update(struct nd_region *nd_region,
> @@ -1395,5 +1440,10 @@ int __init nd_label_init(void)
>  	WARN_ON(guid_parse(NVDIMM_PFN_GUID, &nvdimm_pfn_guid));
>  	WARN_ON(guid_parse(NVDIMM_DAX_GUID, &nvdimm_dax_guid));
>  
> +	WARN_ON(uuid_parse(NVDIMM_BTT_GUID, &nvdimm_btt_uuid));
> +	WARN_ON(uuid_parse(NVDIMM_BTT2_GUID, &nvdimm_btt2_uuid));
> +	WARN_ON(uuid_parse(NVDIMM_PFN_GUID, &nvdimm_pfn_uuid));
> +	WARN_ON(uuid_parse(NVDIMM_DAX_GUID, &nvdimm_dax_uuid));
> +
>  	return 0;
>  }
> 

