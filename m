Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7801C7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 14:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjFFOby (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjFFObx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 10:31:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57F10FD
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 07:31:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbCXq05Zgz67bbM;
        Tue,  6 Jun 2023 22:29:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 15:31:48 +0100
Date:   Tue, 6 Jun 2023 15:31:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 12/19] cxl/region: Factor out interleave ways setup
Message-ID: <20230606153147.00003aac@Huawei.com>
In-Reply-To: <168592156445.1948938.13669058823244900070.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592156445.1948938.13669058823244900070.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave_ways.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
