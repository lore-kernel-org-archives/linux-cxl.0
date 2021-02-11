Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2726C433DB
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCDA64D5D
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 18:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhBKSDk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:03:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2553 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhBKSBq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Feb 2021 13:01:46 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dc44n72fSz67n8d;
        Fri, 12 Feb 2021 01:54:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 19:00:41 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 18:00:40 +0000
Date:   Thu, 11 Feb 2021 17:59:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Da?= =?ISO-8859-1?Q?ud=E9?= 
        <f4bug@amsat.org>, Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 07/31] hw/cxl/device: Add cheap EVENTS
 implementation (8.2.9.1)
Message-ID: <20210211175939.000079f3@Huawei.com>
In-Reply-To: <20210202005948.241655-8-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 1 Feb 2021 16:59:24 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Using the previously implemented stubbed helpers, it is now possible to
> easily add the missing, required commands to the implementation.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 466055b01a..7c939a1851 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -37,6 +37,14 @@
>   *  a register interface that already deals with it.
>   */
>  
> +enum {
> +    EVENTS      = 0x01,
> +        #define GET_RECORDS   0x0
> +        #define CLEAR_RECORDS   0x1
> +        #define GET_INTERRUPT_POLICY   0x2
> +        #define SET_INTERRUPT_POLICY   0x3
> +};
> +
>  /* 8.2.8.4.5.1 Command Return Codes */
>  typedef enum {
>      CXL_MBOX_SUCCESS = 0x0,
> @@ -105,10 +113,23 @@ struct cxl_cmd {
>          return CXL_MBOX_SUCCESS;                                          \
>      }
>  
> +define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x20);
> +define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
> +define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
> +define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
> +
> +#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define IMMEDIATE_LOG_CHANGE (1 << 4)
> +
>  #define CXL_CMD(s, c, in, cel_effect) \
>      [s][c] = { stringify(s##_##c), cmd_##s##_##c, in, cel_effect }
>  
> -static struct cxl_cmd cxl_cmd_set[256][256] = {};
> +static struct cxl_cmd cxl_cmd_set[256][256] = {
> +    CXL_CMD(EVENTS, GET_RECORDS, 1, 0),
> +    CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
> +    CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
> +    CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),

CXL 2.0 spec says IMMEDIATE_POLICY_CHANGE for this rather than
IMMEDIATE_CONFIG_CHANGE.

> +};
>  
>  #undef CXL_CMD
>  

