Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF50C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbjEOKFS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 06:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbjEOKEk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 06:04:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244882D55
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 03:03:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKZgN3SSNz683nf;
        Mon, 15 May 2023 18:02:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:03:52 +0100
Date:   Mon, 15 May 2023 11:03:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl: add missing return to cdat read error path
Message-ID: <20230515110351.00007567@Huawei.com>
In-Reply-To: <645d816a18c74_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
        <168382793506.3510737.4792518576623749076.stgit@djiang5-mobl3>
        <645d816a18c74_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
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

On Thu, 11 May 2023 16:59:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > Add a return to the error path when cxl_cdat_read_table() fails. Current
> > code continues with the table pointer points to freed memory.  
> 
> Yikes, at least the attribute is BIN_ATTR_ADMIN_RO(), but still bad.
> Will mark this as an urgent fix.

I see it's already gone upstream but fwiw

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I first thought we were saved because the cdat_length parameter
would be set to 0, but nope, that will have the value from the
earlier cxl_cdat_get_length() so if that succeeds and the later
table readout doesn't we indeed end up in a mess..


