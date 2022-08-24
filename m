Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5CC3F6B0
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 09:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiHXJiC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 05:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiHXJhb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 05:37:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895ED96741
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 02:37:30 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCLbX4bDNz67yqK;
        Wed, 24 Aug 2022 17:37:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 11:37:28 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:37:28 +0100
Date:   Wed, 24 Aug 2022 10:37:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 0/3] cxl: static analysis fixes
Message-ID: <20220824103727.0000282e@huawei.com>
In-Reply-To: <20220823074527.404435-1-vishal.l.verma@intel.com>
References: <20220823074527.404435-1-vishal.l.verma@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 23 Aug 2022 01:45:24 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Changes since v1[1]:
> - Fix the decoder filter check in patch 1.
> - Fix a missed free(path) in patch 2.
> 
> [1]: https://lore.kernel.org/linux-cxl/20220823072106.398076-1-vishal.l.verma@intel.com
FWIW: Series looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Fix a small handful of issues reported by scan.coverity.com for the
> recent region management additions.
> 
> Vishal Verma (3):
>   cxl/region: fix a dereferecnce after NULL check
>   libcxl: fox a resource leak and a forward NULL check
>   cxl/filter: Fix an uninitialized pointer dereference
> 
>  cxl/lib/libcxl.c | 4 +++-
>  cxl/filter.c     | 2 +-
>  cxl/region.c     | 5 ++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 9a993ce24fdd5de45774b65211570dd514cdf61d

