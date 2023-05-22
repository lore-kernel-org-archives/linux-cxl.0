Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562DC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 13:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjEVN0d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjEVN0c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 09:26:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04878BB
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 06:26:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPyq90hRhz68917;
        Mon, 22 May 2023 21:24:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 14:26:09 +0100
Date:   Mon, 22 May 2023 14:26:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <20230522142608.000002f3@Huawei.com>
In-Reply-To: <87edn8q0aj.fsf@pond.sub.org>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-7-Jonathan.Cameron@huawei.com>
        <87edn8q0aj.fsf@pond.sub.org>
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


>    # @bank-group: Bank group
>    #
>    # @bank: Bank

Just a quick note to point out that the CXL spec contains very little info
on some of these. They are considered generic enough DRAM terms that
people who care know what they are.  My explanations will be whatever
google gives me. Which brings risk of them being wrong.


>    #
>    # @row: Row
>    #
>    # @column: Column
>    #
>    # @correction-mask: Bits within each nibble.  Used in order of bits
>    #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>    #
>    # Since: 8.1
>    ##
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
> 

