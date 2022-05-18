Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB7C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiERQcM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiERQcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:32:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D9712EC
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:32:04 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3JMv2J6zz6894q;
        Thu, 19 May 2022 00:28:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 18 May 2022 18:32:01 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 17:32:01 +0100
Date:   Wed, 18 May 2022 17:31:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 07/14] cxl/mem: Consolidate CXL DVSEC Range enumeration
 in the core
Message-ID: <20220518173159.00002e92@Huawei.com>
In-Reply-To: <165237929461.3832067.8402587124652027178.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237929461.3832067.8402587124652027178.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 May 2022 11:14:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for fixing the setting of the 'mem_enabled' bit in CXL
> DVSEC Control register, move all CXL DVSEC range enumeration into the
> same source file.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Comment inline but not something to necessarily do anything about as
it's a transient thing mid series.

> ---
>  drivers/cxl/core/pci.c        |  129 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h          |    1 
>  drivers/cxl/cxlpci.h          |    4 +
>  drivers/cxl/mem.c             |   14 ++--
>  drivers/cxl/pci.c             |  135 -----------------------------------------
>  tools/testing/cxl/Kbuild      |    1 
>  tools/testing/cxl/test/mem.c  |   10 ---
>  tools/testing/cxl/test/mock.c |   16 +++++
>  8 files changed, 158 insertions(+), 152 deletions(-)
> 

...


> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 8c3a1c85a7ae..0cfbde134fc7 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -58,18 +58,15 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>   * decoders, or if it can not be determined if DVSEC Ranges are in use.
>   * Otherwise, returns true.
>   */
> -__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
> +__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> +				struct cxl_endpoint_dvsec_info *info)

Seems a little over the top to bring in info just to get to info->ranges.
Mind you you get rid of it again later so it's just temporary ugly.

>  {
> -	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct cxl_register_map map;
>  	struct cxl_component_reg_map *cmap = &map.component_map;
>  	bool global_enable, retval = false;
>  	void __iomem *crb;
>  	u32 global_ctrl;
>  
> -	if (info->ranges < 0)
> -		return false;
> -
>  	/* map hdm decoder */
>  	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
