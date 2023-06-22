Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93927EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 13:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFVN4M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFVN4K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 09:56:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C91FF7
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 06:55:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1zd4Z3Sz6J6K9;
        Thu, 22 Jun 2023 21:53:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:55:57 +0100
Date:   Thu, 22 Jun 2023 14:55:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 10/12] cxl/pci: Unconditionally unmask 256B Flit
 errors
Message-ID: <20230622145556.00001e3a@Huawei.com>
In-Reply-To: <8daadc47-115f-79a9-a18a-a72e6f06b7ed@intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
        <168679263124.3436160.6228910132469454346.stgit@dwillia2-xfh.jf.intel.com>
        <8daadc47-115f-79a9-a18a-a72e6f06b7ed@intel.com>
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

On Thu, 15 Jun 2023 14:34:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/14/23 18:30, Dan Williams wrote:
> > The current check for 256B Flit mode is incomplete and unnecessary. It
> > is incomplete because it fails to consider the link speed, or check for
> > CXL link capabilities. It is unnecessary because unconditionally
> > unmasking 256B Flit errors is a nop when 256B Flit operation is not
> > available.
> > 
> > Remove this check in preparation for creating a cxl_probe_link() helper
> > to centralize this detection.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
