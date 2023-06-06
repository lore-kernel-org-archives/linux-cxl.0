Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D9C77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 15:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjFFPfP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjFFPe5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 11:34:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485561BD
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 08:34:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbDxx6vqzz67g6l;
        Tue,  6 Jun 2023 23:32:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 16:34:52 +0100
Date:   Tue, 6 Jun 2023 16:34:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
Message-ID: <20230606163451.0000195a@Huawei.com>
In-Reply-To: <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:33:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Mock-up a device that does not have a standard mailbox, i.e. a device
> that does not implement the CXL memory-device class code, but wants to
> map "device" memory (aka Type-2, aka HDM-D[B], aka accelerator memory).
> 
> For extra code coverage make this device an RCD to test region creation
> flows in the presence of an RCH topology (memory device modeled as a
> root-complex-integrated-endpoint RCIEP).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Whilst this looks superficially find, I haven't reviewed it in enough
depth to give a tag. Might get back to it at somepoint, but don't
wait on me!

Jonathan


