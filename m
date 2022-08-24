Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE74C00140
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 14:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHXOtH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHXOtG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 10:49:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936670E5F
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 07:49:03 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCTRN3bKrz67D3d;
        Wed, 24 Aug 2022 22:45:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:49:01 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:49:00 +0100
Date:   Wed, 24 Aug 2022 15:48:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4 4/6] cxl: change cxl_port_attribute_groups naming to
 avoid confusion
Message-ID: <20220824154859.000006ca@huawei.com>
In-Reply-To: <166077131892.1743055.1029132844466334751.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
        <166077131892.1743055.1029132844466334751.stgit@djiang5-desk4.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Aug 2022 14:21:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Both cxl/port.c and cxl/core/port.c have cxl_port_attribute_groups. Change
> cxl_port_attribute_groups in cxl/port.c to cxl_port_dynamic_attr_groups in
> order to avoid confusion.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Fair enough I guess.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/port.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..c4aa073b7e31 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -123,7 +123,7 @@ static struct attribute_group cxl_cdat_attribute_group = {
>  	.is_bin_visible = cxl_port_bin_attr_is_visible,
>  };
>  
> -static const struct attribute_group *cxl_port_attribute_groups[] = {
> +static const struct attribute_group *cxl_port_dynamic_attr_groups[] = {
>  	&cxl_cdat_attribute_group,
>  	NULL,
>  };
> @@ -133,7 +133,7 @@ static struct cxl_driver cxl_port_driver = {
>  	.probe = cxl_port_probe,
>  	.id = CXL_DEVICE_PORT,
>  	.drv = {
> -		.dev_groups = cxl_port_attribute_groups,
> +		.dev_groups = cxl_port_dynamic_attr_groups,
>  	},
>  };
>  
> 
> 

