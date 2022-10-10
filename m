Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7969C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 12:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJJM7c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJJM7b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 08:59:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7B24DB72
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 05:59:29 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmJqR49WMz67xdt;
        Mon, 10 Oct 2022 20:57:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 14:59:26 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 13:59:26 +0100
Date:   Mon, 10 Oct 2022 13:59:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [RESEND] CXL_MEM_QUERY_COMMANDS returning commands not supported by
 the hardware.
Message-ID: <20221010135925.00006e75@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Resent because I can't type email addresses so this didn't got to the list..

Hi All,

Noticed, whilst implementing a switch CCI mailbox version of the same...

UAPI documentation include/uapi/linux/cxl_mem.h says:

struct cxl_mem_query_commands...

Allow userspace to query the available commands supported by both the
driver, and the hardware.

Currently it seem to report all commands without checking they are in the CEL.

Easy to tell given I just added a bunch of switch commands which are
apparently supported by the type 3 devices (which would be novel).

How to fix?  Make the code do what the docs suggest, or change the
docs?

Or am I missing something?

Thanks,

Jonathan
