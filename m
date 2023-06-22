Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F39EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 13:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFVNuN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVNuM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 09:50:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCB118
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 06:50:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1rx2mCxz6J6FM;
        Thu, 22 Jun 2023 21:47:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:50:08 +0100
Date:   Thu, 22 Jun 2023 14:50:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] cxl: Fix kernel-doc warnings
Message-ID: <20230622145007.000020ad@Huawei.com>
In-Reply-To: <168679259170.3436160.3686460404739136336.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
        <168679259170.3436160.3686460404739136336.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023 18:29:51 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> After Jonathan noticed [1] that 'struct cxl_dev_state' had a kernel-doc
> entry without a corresponding struct attribute I ran the kernel-doc
> script to see what else might be broken. Fix these warnings:
> 
> drivers/cxl/cxlmem.h:199: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Event Interrupt Policy
> drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'buf' not described in 'cxl_event_state'
> drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'log_lock' not described in 'cxl_event_state'
> 
> Note that scripts/kernel-doc only finds missing kernel-doc entries. It
> does not warn on too many kernel-doc entries, i.e. it did not catch the
> fact that @info refers to a not present member.
> 
> Link: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

FWIW given how trivial this is.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxlmem.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..8e4ba5b52902 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -195,7 +195,7 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>   */
>  #define CXL_CAPACITY_MULTIPLIER SZ_256M
>  
> -/**
> +/*
>   * Event Interrupt Policy
>   *
>   * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> @@ -215,8 +215,8 @@ struct cxl_event_interrupt_policy {
>  /**
>   * struct cxl_event_state - Event log driver state
>   *
> - * @event_buf: Buffer to receive event data
> - * @event_log_lock: Serialize event_buf and log use
> + * @buf: Buffer to receive event data
> + * @log_lock: Serialize event_buf and log use
>   */
>  struct cxl_event_state {
>  	struct cxl_get_event_payload *buf;
> 

