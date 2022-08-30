Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBCECAAA1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Aug 2022 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH3PQw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH3PQu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Aug 2022 11:16:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0310D4CE
        for <linux-cxl@vger.kernel.org>; Tue, 30 Aug 2022 08:16:48 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MH9qx1jp4z67Lqc;
        Tue, 30 Aug 2022 23:16:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 17:16:45 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 16:16:45 +0100
Date:   Tue, 30 Aug 2022 16:16:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 3/6] tools/testing/cxl: Add interleave check support
 to mock cxl port device
Message-ID: <20220830161644.000047a0@huawei.com>
In-Reply-To: <166144367188.745916.2815396662040037518.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
        <166144367188.745916.2815396662040037518.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 25 Aug 2022 09:07:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Attach the cxl mock hdm to the port device to allow cxl_interleave_capable()
> to check the interleave configuration. Set the interleave_mask as well
> to support the new verification code.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 4b361ed63333..85000d1b5812 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -398,6 +398,8 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_BASELINE;
>  	dev_set_drvdata(&port->dev, cxlhdm);
>  	return cxlhdm;
>  }
> 
> 

