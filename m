Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0185C6FD19
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Mar 2023 16:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCMQEs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCMQEq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Mar 2023 12:04:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331F64B1E
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 09:04:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pb1fz1Hf6z6J7Ft;
        Tue, 14 Mar 2023 00:03:55 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 16:04:42 +0000
Date:   Mon, 13 Mar 2023 16:04:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        "Mike Maslenkin" <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 2/2] hw/cxl: Multi-Region CXL Type-3 Devices
 (Volatile and Persistent)
Message-ID: <20230313160441.00000dc1@huawei.com>
In-Reply-To: <20230307194914-mutt-send-email-mst@kernel.org>
References: <20230227163157.6621-1-Jonathan.Cameron@huawei.com>
        <20230227163157.6621-3-Jonathan.Cameron@huawei.com>
        <20230307194914-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


...

> > +    if (vmr) {
> > +        if (*dpa_offset < int128_get64(vmr->size)) {
> > +            *as = &ct3d->hostvmem_as;
> > +        } else {
> > +            *as = &ct3d->hostpmem_as;
> > +            *dpa_offset -= vmr->size;  
> 
> You can't do math on vmr->size, it's Int128.
> And generally please do not poke at mr->size use APIs.
> 
> Which one will depend ...

Good spot. In this case they are all sub 64 bit so
simple memory_region_size() is appropriate I think.

I'll add a precursor patch converting existing 
int128_get64(mr->size) users in this file over to that.

Thanks,

Jonathan
