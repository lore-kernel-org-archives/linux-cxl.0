Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65001CE79CE
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjITMTQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjITMTP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Sep 2023 08:19:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3AC2
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 05:19:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrHb14NY5z6HJd2;
        Wed, 20 Sep 2023 20:17:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 20 Sep
 2023 13:19:03 +0100
Date:   Wed, 20 Sep 2023 13:19:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC:     linux-cxl <linux-cxl@vger.kernel.org>
Subject: Re: A confusion about cxl.mem in CXL drivers
Message-ID: <20230920131902.0000504f@Huawei.com>
In-Reply-To: <2023092018244461102314@phytium.com.cn>
References: <2023082215220191352877@phytium.com.cn>
        <2023092018244461102314@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 20 Sep 2023 18:24:46 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hi, Jonathan
> 
> There jumped a silly confusion when I am analyzing cxl drivers: 
> Since Host to access the cxl device memory and to access its mmio registers
> both use load/store instructions, how system software distinguish 
> with cxl.io and cxl.mem protocols?
> 
> Many thanks
> Yuquan

Hi Yuquan

I'm afraid I don't really understand the question.  So I'm guessing a bit whilst
trying to answer.

Is it about the kernel side of things, or more on what we are doing in QEMU
where we use iomem regions for both CXL.io and CXL.mem? For CXL.mem that
is done in QEMU to give us the ability to do fine grained address decoding
(below page level) but it doesn't in practice matter to the OS on top. It's
just an implementation detail in QEMU. There are knock on effects if you run with
KVM though as instructions can end up being read from the memory
(so that's not advised!).
However for both CXL.io and CXL.mem it is a host physical address range
and how the OS deals with it is dependent on how it is mapped.

So from driver side of things, the CXL.IO stuff is either in ECAM (for config
space) or mapped as PCIe BARs.  The CXL.mem stuff is mapped via the Host Physical
Addresses described in a CXL Fixed Memory Window.

So the right type of access is used based on the underlying hardware performing
the routing for the appropriate Host Physical Address range.  Same applies
on top of QEMU.

Jonathan
