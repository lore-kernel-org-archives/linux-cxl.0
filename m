Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D833AC77B7A
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 10:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjFFK5N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjFFK4h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 06:56:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7C1720
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 03:53:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb6j32NF9z67b7k;
        Tue,  6 Jun 2023 18:51:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 11:53:36 +0100
Date:   Tue, 6 Jun 2023 11:53:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 02/19] tools/testing/cxl: Remove unused @cxlds argument
Message-ID: <20230606115335.00005356@Huawei.com>
In-Reply-To: <168592150866.1948938.14035429174747236697.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592150866.1948938.14035429174747236697.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:31:48 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for plumbing a 'struct cxl_memdev_state' as a superset of
> a 'struct cxl_dev_state' cleanup the usage of @cxlds in the unit test
> infrastructure.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Sensible cleanup. I'd be tempted to queue some of these up independent
of the main patch set, just to cut down on the noise when we get to the
interesting parts.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


