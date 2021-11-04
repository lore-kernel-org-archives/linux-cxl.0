Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7339C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A8060E9B
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 09:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKDJk2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:40:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4064 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhKDJk2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Nov 2021 05:40:28 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HlJTS0KWVz67yqX;
        Thu,  4 Nov 2021 17:37:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 4 Nov 2021 10:37:47 +0100
Received: from localhost (10.52.124.216) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 09:37:47 +0000
Date:   Thu, 4 Nov 2021 09:37:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/memdev: Remove unused cxlmd field
Message-ID: <20211104093744.000033b2@Huawei.com>
In-Reply-To: <20211103234857.3689354-1-ira.weiny@intel.com>
References: <20211103234857.3689354-1-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.216]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 3 Nov 2021 16:48:57 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> This field was left over when the connection between the cxl_memdev and
> cxl_mem was tighter.  It is no longer set nor used so remove it.[1]
> 
> [1] https://lore.kernel.org/linux-cxl/CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com/
> 
> Suggested-by: Jonathan.Cameron@huawei.com
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V1:
> 	Change Subject
> 
> [v1] https://lore.kernel.org/linux-cxl/20211103223413.n6fmf3gtop56wssz@intel.com/T/#m79c2c7ba4cc897c10e26acdaca890887e1dd487f
> ---
>  drivers/cxl/cxlmem.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f978a046591b..8d96d009ad90 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,7 +97,6 @@ struct cxl_mbox_cmd {
>   * Currently only memory devices are represented.
>   *
>   * @dev: The device associated with this CXL state
> - * @cxlmd: Logical memory device chardev / interface
>   * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> @@ -124,7 +123,6 @@ struct cxl_mbox_cmd {
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> -	struct cxl_memdev *cxlmd;
>  
>  	struct cxl_regs regs;
>  

