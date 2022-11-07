Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3550AC4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKGPib (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKGPia (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 10:38:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5590B3A
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 07:38:28 -0800 (PST)
Received: from frapeml500001.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5b1B6RhZz67Q1L;
        Mon,  7 Nov 2022 23:36:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500001.china.huawei.com (7.182.85.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:38:26 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 15:38:26 +0000
Date:   Mon, 7 Nov 2022 15:38:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2 14/19] nvdimm/cxl/pmem: Add support for master
 passphrase disable security command
Message-ID: <20221107153825.00005362@Huawei.com>
In-Reply-To: <166377437176.430546.17764703604719662576.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
        <166377437176.430546.17764703604719662576.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022 08:32:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The original nvdimm_security_ops ->disable() only supports user passphrase
> for security disable. The CXL spec introduced the disabling of master
> passphrase. Add a ->disable_master() callback to support this new operation
> and leaving the old ->disable() mechanism alone. A "disable_master" command
> is added for the sysfs attribute in order to allow command to be issued
> from userspace. ndctl will need enabling in order to utilize this new
> operation.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I'm not particularly familiar with the code modified, but with that in mind
looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

