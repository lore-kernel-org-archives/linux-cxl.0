Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA47C7EE31
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 14:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbjFFOqC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbjFFOpT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 10:45:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E7E67
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 07:43:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbCp14Tp5z67M1f;
        Tue,  6 Jun 2023 22:40:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 15:42:56 +0100
Date:   Tue, 6 Jun 2023 15:42:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 15/19] cxl/region: Specify host-only vs device memory at
 region creation time
Message-ID: <20230606154255.00003a7f@Huawei.com>
In-Reply-To: <168592158192.1948938.1274727683021213802.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592158192.1948938.1274727683021213802.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:33:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for supporting device-memory (HDM-D[B]) region creation,
> convey the endpoint-decoder target type to devm_cxl_add_region().
> 
> Note that none of the existing sysfs ABIs allow for HDM-D[B] region
> creation. The expectation is that HDM-D[B] region creation requires a
> kernel-internal region creation flow, for example, driven by an
> accelerator driver.

There are potential advantages in using CXL type 3 HDM-DB devices with
a normal flow, userspace driven region creation flow.  If there is
any potential for UIO P2P transactions targeting them later (which
we won't necessarily know at setup time) then we'll need to use HDM-DB.
 The targetting of them for UIO will require some accelerator specific
stuff at the source of the transactions, but we won't want to offline
the memory on a type 3 device to convert it over to HDM-H
(assuming that's required...)

+ cache coherent sharing - though I guess region setup code may
be quite different for that anyway :)  I've not divided into
Navneet's set yet to see how he did it.

Code itself is fine - just the comment potentially being misleading or
overly restrictive.

Jonathan
