Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED7BEDEC5B
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 14:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjIMOKx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbjIMOKG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 10:10:06 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 07:08:56 PDT
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3940D2128
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 07:08:56 -0700 (PDT)
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
        by isrv.corpit.ru (Postfix) with ESMTP id 24AD8217DF;
        Wed, 13 Sep 2023 17:00:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
        by tsrv.corpit.ru (Postfix) with ESMTP id 17F1427CC8;
        Wed, 13 Sep 2023 17:00:30 +0300 (MSK)
Message-ID: <afe29ae4-4cac-4edb-b6fb-8652da03554e@tls.msk.ru>
Date:   Wed, 13 Sep 2023 17:00:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linuxarm@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
From:   Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

04.09.2023 16:28, Jonathan Cameron via wrote:
> A small set gathering patches that have been posted and reviewed on list
> over the last few months. Looking to get these upstream before making
> any significant changes to the CXL emulation for this cycle.
> 
> More wide spread cleanup will follow later this cycle (reference
> updates to available spec and line length improvements).
> 
> Dave Jiang (1):
>    hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS
> 
> Fan Ni (1):
>    hw/cxl/cxl_device: Replace magic number in CXLError definition
> 
> Li Zhijian (2):
>    hw/cxl: Fix CFMW config memory leak
>    docs/cxl: Change to lowercase as others
> 
>   docs/system/devices/cxl.rst  |  8 ++++----
>   include/hw/cxl/cxl_device.h  |  2 +-
>   hw/cxl/cxl-host.c            | 12 ++++++------
>   hw/pci-bridge/cxl_upstream.c |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 

Applied to my trivial-patches tree. Thank you!

/mjt
