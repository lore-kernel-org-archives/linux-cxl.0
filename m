Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E20C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 13:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjFFN0y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFN0y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 09:26:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A99126
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 06:26:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbB891z7tz6J79Z;
        Tue,  6 Jun 2023 21:26:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 14:26:50 +0100
Date:   Tue, 6 Jun 2023 14:26:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 09/19] cxl/memdev: Formalize endpoint port linkage
Message-ID: <20230606142649.000001ce@Huawei.com>
In-Reply-To: <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Move the endpoint port that the cxl_mem driver establishes from drvdata
> to a first class attribute. This is in preparation for device-memory
> drivers reusing the CXL core for memory region management. Those drivers
> need a type-safe method to retrieve their CXL port linkage. Leave
> drvdata for private usage of the cxl_mem driver not external consumers
> of a 'struct cxl_memdev' object.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Good. I never liked this being 'hidden' and un-typed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
