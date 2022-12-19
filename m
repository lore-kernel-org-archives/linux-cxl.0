Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7DFC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLSQTn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLSQTm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:19:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02CCCC2
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:19:40 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbPvK1Cjsz67D3d;
        Tue, 20 Dec 2022 00:15:41 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 16:19:38 +0000
Date:   Mon, 19 Dec 2022 16:19:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 3/8] cxl: refactor cxl_hdm_decode_init()
Message-ID: <20221219161937.00004067@Huawei.com>
In-Reply-To: <166984995249.2805382.1339697898311247332.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984995249.2805382.1339697898311247332.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With the previous refactoring of DVSEC range registers out of
> cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
> __cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.

Should mention briefly that this results in richer (i.e. not all -EBUSY)
error return codes.  One other trivial suggestion below that might well
become irrelevant in later patches.


> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

> @@ -445,17 +370,68 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  {

...

> +	rc = devm_cxl_enable_mem(&port->dev, cxlds);
> +	if (rc)
> +		return rc;
> +
>  	return 0;
	return dev_cxl_enable_mem()
assuming this doesn't then need putting back as it is in later patches becasue
you add more stuff before the return 0.

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> 
> 

