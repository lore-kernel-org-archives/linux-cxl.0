Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66448C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 09:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjBCJbb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBCJb2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Feb 2023 04:31:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932931F5DC;
        Fri,  3 Feb 2023 01:31:13 -0800 (PST)
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P7Vk24sT9z6J9fr;
        Fri,  3 Feb 2023 17:30:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 3 Feb 2023 09:31:11 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2375.034;
 Fri, 3 Feb 2023 09:31:11 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
 events
Thread-Topic: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
 events
Thread-Index: AQHZNzLN5iUmsHWwIUGecRCDH4ZAy668DlwAgADlB8A=
Date:   Fri, 3 Feb 2023 09:31:11 +0000
Message-ID: <a5df429552ea4c65b680f985daa32c29@huawei.com>
References: <20230202181846.692-1-shiju.jose@huawei.com>
        <20230202181846.692-3-shiju.jose@huawei.com>
 <Y9wR+Kqs1P65ztwT@aschofie-mobl2>
In-Reply-To: <Y9wR+Kqs1P65ztwT@aschofie-mobl2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

>-----Original Message-----
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 02 February 2023 19:42
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: mchehab@kernel.org; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RESEND PATCH V3 2/4] rasdaemon: Add support for the CXL poison
>events
>
>On Thu, Feb 02, 2023 at 06:18:44PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support to log and record the CXL poison events.
>>
>> The corresponding Kernel patches here:
>> https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef
>> 7f08.1674070170.git.alison.schofield@intel.com/
>>
>> Presently RFC draft version for logging, could be extended for the
>> policy based recovery action for the frequent poison events depending
>> on the above kernel patches.
>
>Hi Shiju,
>
>Looks good to me based on the kernel patches you reference above.
>I want to let you know that a v6 is in the works, and will lead to some naming
>changes below - but minor stuff.

Hi Alison,

Thanks for the information. I will make changes according to the v6.
>
>Alison
>

Thanks,
Shiju



