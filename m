Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8813AC00140
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 14:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiHXO7L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXO7K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 10:59:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075CD89804
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 07:59:07 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCTfz3tH3z67ydF;
        Wed, 24 Aug 2022 22:55:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:59:04 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:59:03 +0100
Date:   Wed, 24 Aug 2022 15:59:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4 3/6] tools/testing/cxl: Add interleave check support
 to mock cxl port device
Message-ID: <20220824155902.00007b3c@huawei.com>
In-Reply-To: <166077131383.1743055.4589788759198107631.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
        <166077131383.1743055.4589788759198107631.stgit@djiang5-desk4.jf.intel.com>
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

On Wed, 17 Aug 2022 14:21:53 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
I couldn't follow what was going on here, until I realized you've renamed
this function.  Now cxl_interleave_capable().

Are the tests broken (null dereference) between patch 1 and 3?

Seem like dev_set_drvdata() should move to patch 1.

> to check the interleave configuration. Set the interleave_mask as well
> to support the new verification code.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..3ce353a20b80 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -398,6 +398,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
> +	dev_set_drvdata(&port->dev, cxlhdm);
>  	return cxlhdm;
>  }
>  
> 
> 

