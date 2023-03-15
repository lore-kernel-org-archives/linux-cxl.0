Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB52C6FD1D
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Mar 2023 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjCORA3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjCORAZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Mar 2023 13:00:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA815CC1F
        for <linux-cxl@vger.kernel.org>; Wed, 15 Mar 2023 10:00:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcGpn3rhzz6J7N3;
        Thu, 16 Mar 2023 01:00:01 +0800 (CST)
Received: from localhost (10.126.171.21) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 17:00:18 +0000
Date:   Wed, 15 Mar 2023 17:00:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] cxl/mbox: Block inject and clear poison opcodes
 in raw mode
Message-ID: <20230315170017.00002c98@Huawei.com>
In-Reply-To: <6952da15b164e18e7f26fb26631839837d9797b3.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
        <6952da15b164e18e7f26fb26631839837d9797b3.1678471465.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.21]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Mar 2023 10:49:09 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison are commands intended for debug environments,
> and can cause data corruption if issued without validation. They are
> kernel exclusive commands not available to userspace through ioctls,
> but could be submitted via the raw mode ioctl.
> 
> Add inject and clear poison to the cxl_disabled_raw_commands[] list.
> Attempts by userspace to issue either command via the RAW ioctl fail
> with -EPERM.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Makes sense
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/core/mbox.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 77fc811bdfed..4b5e65edbc71 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -89,6 +89,10 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   *
>   * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
>   * is kept up to date with patrol notifications and error management.
> + *
> + * CXL_MBOX_OP_[INJECT|CLEAR]_POISON: The kernel provides a sysfs interface
> + * to these commands that ensures data protection of mapped resources.
> + * See: Documentation/ABI/testing/sysfs-bus-cxl
>   */
>  static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_ACTIVATE_FW,
> @@ -97,6 +101,8 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>  	CXL_MBOX_OP_SCAN_MEDIA,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +	CXL_MBOX_OP_INJECT_POISON,
> +	CXL_MBOX_OP_CLEAR_POISON,
>  };
>  
>  /*

