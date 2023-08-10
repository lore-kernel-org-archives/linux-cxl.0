Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC2C04E69
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 16:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjHJQd1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHJQd1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 12:33:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFD9C
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:33:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RMC7Q6TKCz6J6px
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 00:29:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 17:33:23 +0100
Date:   Thu, 10 Aug 2023 17:33:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ravi Kanth <mvrravikanth@gmail.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: Support for CXL v3.0 spec with QEMU
Message-ID: <20230810173322.0000543c@Huawei.com>
In-Reply-To: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Aug 2023 21:42:12 +0530
Ravi Kanth <mvrravikanth@gmail.com> wrote:

> Hello,

Hi Ravi,

> 
> I am writing this mail to know if the latest QEMU has support for CXL
> spec v3.0? I understand from the older tutorials that QEMU has support
> for CXL v2.0. Is there any update to QEMU to support the CXL v3.0? I
> would like to specifically test the CCI mailbox functionality which
> has been added to CXL v3.0 spec.

The nature of the CXL specification and the QEMU support is that for
devices there isn't a clear divide between different generations of
the specification. By that I mean, that a device based on the CXL 2.0
specification is compatible with the CXL 3.0 specification. As such,
the QEMU emulation has focused on features of interest - it is a far
from complete implementation of all the options in the CXL 2.0
specification but conversely there are some parts of CXL 3.0 are supported.

Note that the particular CCI functionality is not yet ready for CXL upstream,
but we do have some support in the staging tree I maintain.

https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
specifically
https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea894a1d27625a4b80c

Note at this stage we only support subset of commands.
Contributions of more support welcomed!

Intent of the current support and related MCTP CCI access (over I2C) is
to enable ecosystem development, particularly of fabric managers.
For that a tiny subset of commands was sufficient to be sure the architecture
inside QEMU worked and that the proposed kernel code functions correctly.

Jonathan

> 
> Thank you in advance for your assistance.
> 
> Ravi

