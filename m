Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC2EB64DA
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjGNLhT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjGNLhS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 07:37:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1EE210A
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 04:37:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R2Tsn6Gxsz67VkC;
        Fri, 14 Jul 2023 19:34:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 14 Jul
 2023 12:37:11 +0100
Date:   Fri, 14 Jul 2023 12:37:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Region ID in Initiate Dynamic Capacity Release
Message-ID: <20230714123710.00004140@Huawei.com>
In-Reply-To: <DM6PR18MB28445F66E323501519D4861BAF37A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB28445F66E323501519D4861BAF37A@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Jul 2023 21:54:47 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> Hello All,
>    In "Initiate Dynamic Capacity Add Request", LD-ID and region-id to which capacity is added are specified. However, in case of "Initiate Dynamic Capacity Release", no region-id is specified in the request payload. However, specification says that f "Initiate Dynamic Capacity Release" command fails with "Invalid Input" if invalid region-id is specified. Is this an errata ? This is true in both CXL3.0 and CXL3.1 (draft).

Hi Shesha

Please do not discuss consortium draft documents on public lists.  Here we can
only talk about those that are published.

Also, these questions are probably better addressed within the CXL consortium (SSWG) anyway.

Jonathan

> 
> Secondly, can we add capacities to 'a' LD from multiple regions, meaning, can "Initiate Dynamic Capacity Add Request", be executed twice on the same LD, with different region-ids in the two calls.
> 
> Thanks,
> Shesha.
