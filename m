Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DBC6FD1C
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCVQYl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVQYl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 12:24:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B52C643
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 09:24:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pgqr51bNyz6Y1JL;
        Tue, 21 Mar 2023 19:58:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 21 Mar
 2023 12:01:48 +0000
Date:   Tue, 21 Mar 2023 12:01:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] hw/acpi/cxl: Drop device-memory support from CFMWS
 entries
Message-ID: <20230321120147.00003ea7@Huawei.com>
In-Reply-To: <167937891122.1510933.11055956062467467440.stgit@dwillia2-xfh.jf.intel.com>
References: <167937891122.1510933.11055956062467467440.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 20 Mar 2023 23:08:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> While it was a reasonable idea to specify no window restricitions at the
> outset of the CXL emulation support, it turns out that in practice a
> platform will never follow the QEMU example of specifying simultaneous
> support for HDM-H and HDM-D[B] in a single window.
> 
> HDM-D mandates extra bus cycles for host/device bias protocol, and HDM-DB
> mandates extra bus cycles for back-invalidate protocol, so hardware must
> be explicitly prepared for device-memory unlike host-only memory
> (HDM-H).
> 
> In preparation for the kernel dropping support for windows that do not
> select between device and host-only memory, move QEMU exclusively to
> declaring host-only windows.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi Dan,

Can we have some spec references? I think the Protocol tables in
appendix C would work for that - but more specific examples called
out from them would be good.

I'm also not totally convinced it isn't a host implementation detail
- key here is that host bridge's are still part of the host so can
do impdef stuff as long as they look correct to CXL side and to
host side.

Time for some wild implementation conjecturing.

Imagine a host that has host bridges of above average smartness.
Those host bridges have HDM decoders (this doesn't work if not)

Host is using a single HPA window for HDM-D[B] and HDM-H.
The host bridge knows the target is HDM-H - it can get that form
the HDM decoder Target Type bit etc.  The HB can send (to the
rest of the Host) whatever replies are necessary / fill in extra
info to make it look like HDM-D[B] to the host interconnect protocol.

(after some fun with a white board we think you can make this efficient
 by potentially making the Host bridge HDM decoder setup visible to
 other parts of the host - relatively easy give lots of time allowed
 for a decoder commit).

Why would you do this?  Limited HPA space availability on the host
and wanting to be very flexible about use of the CXL windows.

Obviously this is all moot if there is a constraint we can point to
in a specification.

BTW. I'm carrying a patch (it's on the gitlab tree) that I haven't
posted yet that lets you configure this restriction at runtime as
a similar potential host implementation restriction occurs for
PMEM vs Volatile.  That is also needed to exercise the fun corners of
QTG etc.

Jonathan

> ---
>  hw/acpi/cxl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 2bf8c0799359..defb289e2fef 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -103,8 +103,8 @@ static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
>          /* Host Bridge Interleave Granularity */
>          build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
>  
> -        /* Window Restrictions */
> -        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
> +        /* Window Restrictions: Host-only ram and pmem */
> +        build_append_int_noprefix(table_data, 0x0e, 2);
>  
>          /* QTG ID */
>          build_append_int_noprefix(table_data, 0, 2);
> 
> 

