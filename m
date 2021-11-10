Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C36C43219
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0655611C9
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 17:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhKJRnC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:43:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4080 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKJRnC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Nov 2021 12:43:02 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HqBnk5Nldz67xX4;
        Thu, 11 Nov 2021 01:35:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 10 Nov 2021 18:40:12 +0100
Received: from localhost (10.52.121.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 10 Nov
 2021 17:40:12 +0000
Date:   Wed, 10 Nov 2021 17:40:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [INTERNAL PATCH 2/2] cxl/cxlmem: Change cxl_mem to a more
 descriptive name
Message-ID: <20211110174010.000055c2@Huawei.com>
In-Reply-To: <20211102202901.3675568-3-ira.weiny@intel.com>
References: <20211102202901.3675568-1-ira.weiny@intel.com>
        <20211102202901.3675568-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.123]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 2 Nov 2021 13:29:01 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The cxl_mem object actually represents the state of a CXL device within the
> driver.  This is data layered on top of the PCI or other device.  Even though
> the only device currently represented is a memory device, calling this cxl_mem
> is confusing because this is not solely a CXL memory device.  Furthermore,
> cxl_memdev does drive a CXL memory device.  So changing the name helps to
> distinguish these to structures.
> 
> Update the structure name, function names, and the kdocs to reflect the
> real uses of this structure.
> 
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

...

>  struct cxl_memdev *
> -devm_cxl_add_memdev(struct cxl_mem *cxlm)
> +devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
Just noticed on a read through (I'm trying to catch up with recent changes)

Combine the above 2 lines into one.  Could do it as a tidy up
patch if too late to fold into this patch.

Thanks,

Jonathan


>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
