Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7AC4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiKGQBb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiKGQB3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 11:01:29 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9712A88
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 08:01:27 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5bWy6kDpz67njv;
        Mon,  7 Nov 2022 23:59:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:01:25 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 16:01:25 +0000
Date:   Mon, 7 Nov 2022 16:01:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2 18/19] libnvdimm: Introduce
 CONFIG_NVDIMM_SECURITY_TEST flag
Message-ID: <20221107160124.00005223@Huawei.com>
In-Reply-To: <166377439534.430546.10690686781480251163.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
        <166377439534.430546.10690686781480251163.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022 08:33:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> nfit_test overrode the security_show() sysfs attribute function in nvdimm
> dimm_devs in order to allow testing of security unlock. With the
> introduction of CXL security commands, the trick to override
> security_show() becomes significantly more complicated. By introdcing a
> security flag CONFIG_NVDIMM_SECURITY_TEST, libnvdimm can just toggle the
> check via a compile option. In addition the original override can can be
> removed from tools/testing/nvdimm/.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/nvdimm/Kconfig           |    9 +++++++++
>  drivers/nvdimm/dimm_devs.c       |    9 ++++++++-
>  drivers/nvdimm/security.c        |    4 ++++
>  tools/testing/nvdimm/Kbuild      |    1 -
>  tools/testing/nvdimm/dimm_devs.c |   30 ------------------------------
>  5 files changed, 21 insertions(+), 32 deletions(-)
>  delete mode 100644 tools/testing/nvdimm/dimm_devs.c
> 
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 5a29046e3319..fd336d138eda 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -114,4 +114,13 @@ config NVDIMM_TEST_BUILD
>  	  core devm_memremap_pages() implementation and other
>  	  infrastructure.
>  
> +config NVDIMM_SECURITY_TEST
> +	bool "Nvdimm security test code toggle"
> +	depends on NVDIMM_KEYS
> +	help
> +	  Debug flag for security testing when using nfit_test or cxl_test
> +	  modules in tools/testing/.
> +
> +	  Select Y if using nfit_test or cxl_test for security testing.

Probably want to say it if has any unfortunate side effects when not doing
such testing.  Distros will want guidance on whether to enable.

Jonathan

> +

