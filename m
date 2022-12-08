Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AFDC63705
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 11:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLHLIJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLHLHl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 06:07:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C371260E87
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 03:03:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSWRD1vBfz6H7G7;
        Thu,  8 Dec 2022 19:00:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 11:03:52 +0000
Date:   Thu, 8 Dec 2022 11:03:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl/mbox: Add variable output size validation for
 internal commands
Message-ID: <20221208110351.00007c18@Huawei.com>
In-Reply-To: <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
        <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 05 Dec 2022 20:22:39 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_internal_send_cmd() skips output size validation for variable output
> commands which is not ideal. Most of the time internal usages want to
> fail if the output size does not match what was requested. For other
> commands where the caller cannot predict the size there is usually a
> a header that conveys how much vaild data is in the payload. For those
> cases add @min_out as a parameter to specify what the minimum response
> payload needs to be for the caller to parse the rest of the payload.
> 
> In this patch only Get Supported Logs has that behavior, but going
> forward records retrieval commands like Get Poison List and Get Event
> Records can use @min_out to retrieve a variable amount of records.
> 
> Critically, this validation scheme skips the needs to interrogate the
> cxl_mem_commands array which in turn frees up the implementation to
> support internal command enabling without also enabling external / user
> commands.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


