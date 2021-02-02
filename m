Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F2C433DB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A9C64DDC
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhBBUCN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:02:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2478 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhBBNph (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 08:45:37 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVQvR3dc9z67jmm;
        Tue,  2 Feb 2021 21:41:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 2 Feb 2021 14:44:52 +0100
Received: from localhost (10.47.79.68) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:44:51 +0000
Date:   Tue, 2 Feb 2021 13:44:05 +0000
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
Message-ID: <20210202134405.00002891@Huawei.com>
In-Reply-To: <20210202005948.241655-8-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.68]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
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
comment inline. Otherwise LGTM.
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

Ideally add section reference comments for these.  Makes my life a tiny
bit easier as a reviewer!

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
> +};
>  
>  #undef CXL_CMD
>  

