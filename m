Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B73C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Nov 2021 13:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhK3N1W (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:27:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4184 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbhK3N1R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Nov 2021 08:27:17 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3N9k6KYtz67XMQ;
        Tue, 30 Nov 2021 21:19:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:23:57 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 13:23:56 +0000
Date:   Tue, 30 Nov 2021 13:23:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 8/9] cxl: Introduce module_cxl_driver
Message-ID: <20211130132355.00004f82@Huawei.com>
In-Reply-To: <20211129214721.1668325-9-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
        <20211129214721.1668325-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 Nov 2021 13:47:20 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Many CXL drivers simply want to register and unregister themselves.
> module_driver already supported this. A simple wrapper around that
> reduces a decent amount of boilerplate in upcoming patches.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
FWIW this is obviously useful.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7150a9694f66..d39d45f4a770 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -308,6 +308,9 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
>  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
>  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  
> +#define module_cxl_driver(__cxl_driver) \
> +	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> +
>  #define CXL_DEVICE_NVDIMM_BRIDGE	1
>  #define CXL_DEVICE_NVDIMM		2
>  

