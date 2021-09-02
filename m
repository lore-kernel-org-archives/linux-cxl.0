Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C477EC83027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D5C61051
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 16:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbhIBQox (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:44:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3716 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbhIBQow (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Sep 2021 12:44:52 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H0mtK3hc4z67Nxq;
        Fri,  3 Sep 2021 00:42:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 18:43:51 +0200
Received: from localhost (10.52.127.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 2 Sep 2021
 17:43:51 +0100
Date:   Thu, 2 Sep 2021 17:43:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <ira.weiny@intel.com>, <ben.widawsky@intel.com>
Subject: Re: [PATCH v3 12/28] libnvdimm/labels: Introduce the concept of
 multi-range namespace labels
Message-ID: <20210902174353.00001f7c@Huawei.com>
In-Reply-To: <162982118939.1124374.9504087573920499391.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162982118939.1124374.9504087573920499391.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 24 Aug 2021 09:06:29 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The CXL specification defines a mechanism for namespaces to be comprised
> of multiple dis-contiguous ranges. Introduce that concept to the legacy
> NVDIMM namespace implementation with a new nsl_set_nrange() helper, that
> sets the number of ranges to 1. Once the NVDIMM subsystem supports CXL
> labels and updates its namespace capacity provisioning for
> dis-contiguous support nsl_set_nrange() can be updated, but in the
> meantime CXL label validation requires nrange be non-zero.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
FWIW which may well be mostly so I remember to skip this one
when reading v4+ if you need them.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/nvdimm/label.c |    1 +
>  drivers/nvdimm/nd.h    |   13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index e8e0d3e409a2..7abeb1233404 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -901,6 +901,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
>  	nsl_set_name(ndd, nd_label, nspm->alt_name);
>  	nsl_set_flags(ndd, nd_label, flags);
>  	nsl_set_nlabel(ndd, nd_label, nd_region->ndr_mappings);
> +	nsl_set_nrange(ndd, nd_label, 1);
>  	nsl_set_position(ndd, nd_label, pos);
>  	nsl_set_isetcookie(ndd, nd_label, cookie);
>  	nsl_set_rawsize(ndd, nd_label, resource_size(res));
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 036638bdb7e3..d57f95a48fe1 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -164,6 +164,19 @@ static inline void nsl_set_nlabel(struct nvdimm_drvdata *ndd,
>  	nd_label->nlabel = __cpu_to_le16(nlabel);
>  }
>  
> +static inline u16 nsl_get_nrange(struct nvdimm_drvdata *ndd,
> +				 struct nd_namespace_label *nd_label)
> +{
> +	/* EFI labels do not have an nrange field */
> +	return 1;
> +}
> +
> +static inline void nsl_set_nrange(struct nvdimm_drvdata *ndd,
> +				  struct nd_namespace_label *nd_label,
> +				  u16 nrange)
> +{
> +}
> +
>  static inline u64 nsl_get_lbasize(struct nvdimm_drvdata *ndd,
>  				  struct nd_namespace_label *nd_label)
>  {
> 

