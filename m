Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED97C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 11:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjFFLVN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjFFLVN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 07:21:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC423E55
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 04:21:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb7KC0c3Zz67j66;
        Tue,  6 Jun 2023 19:19:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 12:21:09 +0100
Date:   Tue, 6 Jun 2023 12:21:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 05/19] cxl/port: Rename CXL_DECODER_{EXPANDER,
 ACCELERATOR} => {HOSTMEM, DEVMEM}
Message-ID: <20230606122108.0000110d@Huawei.com>
In-Reply-To: <168592152508.1948938.17633369037592532464.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592152508.1948938.17633369037592532464.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:32:05 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for support for HDM-D and HDM-DB configuration
> (device-memory, and device-memory with back-invalidate). Rename the current
> type designators to use HOSTMEM and DEVMEM as a suffix.

I'd state this is inline with the CXL 3.0 spec naming.
Device coherent address range vs Host - Only coherent address range.
(or rename HOSTMEM to HOSTONLYMEM which I think deals with that subtlety) 
> 
> HDM-DB can be supported by devices that are not accelerators, so DEVMEM is
> a more generic term for that case.
> 
> Fixup one location where this type value was open coded.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Bike-shedding aside LGTM

Jonathan


