Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFEC77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 16:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjEYQnY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEYQnX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 12:43:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4AD1A1
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 09:43:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRv3566dRz67pJF;
        Fri, 26 May 2023 00:41:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 17:43:16 +0100
Date:   Thu, 25 May 2023 17:43:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v6 01/11] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <20230525174312.00007fb2@Huawei.com>
In-Reply-To: <168451600072.3470703.11316174773607021145.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
        <168451600072.3470703.11316174773607021145.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 10:06:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details. The device handle and the DPA range is saved and
> to be associated with the DSLBIS locality data when the DSLBIS entries are
> parsed. The list is a local list. When the total path performance data is
> calculated and storred this list can be discarded.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> new file mode 100644
> index 000000000000..f70a3a146901
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.c
> @@ -0,0 +1,58 @@
...

> +void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
> +{
> +	struct dsmas_entry *dentry, *n;
> +
> +	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
> +		list_del(&dentry->list);
> +		kfree(dentry);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_list_destroy, CXL);
> +
> +MODULE_IMPORT_NS(CXL);
> +

Trivial: Stray line at end of file?

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h


