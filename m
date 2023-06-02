Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7645C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 12:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjFBMjW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjFBMi6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 08:38:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F118C;
        Fri,  2 Jun 2023 05:38:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjGn1j1Rz6J6x5;
        Fri,  2 Jun 2023 20:38:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:38:45 +0100
Date:   Fri, 2 Jun 2023 13:38:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 4/4] acpi: Add defines for CDAT SSLBIS
Message-ID: <20230602133844.00004377@Huawei.com>
In-Reply-To: <168565513141.1098279.7310204214131055216.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
        <168565513141.1098279.7310204214131055216.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 01 Jun 2023 14:32:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add upstream port and any port definition for SSLBIS.
> 
> Links: https://github.com/acpica/acpica/pull/874
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

FWIW given may come from acpica route anyway.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> ---
>  include/acpi/actbl1.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 8d5572ad48cb..a33375e055ad 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -465,6 +465,9 @@ struct acpi_cdat_sslbe {
>  	u16 reserved;
>  };
>  
> +#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
> +#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
> +
>  /*******************************************************************************
>   *
>   * CEDT - CXL Early Discovery Table
> 
> 

