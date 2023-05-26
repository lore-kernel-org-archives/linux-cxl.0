Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011EC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbjEZRKU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbjEZRKS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:10:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3CF3
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:10:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWZr24NPz67Q3T;
        Sat, 27 May 2023 01:08:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 18:10:05 +0100
Date:   Fri, 26 May 2023 18:10:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <20230526181004.0000512d@Huawei.com>
In-Reply-To: <87h6rz8bnj.fsf@pond.sub.org>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
        <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
        <87h6rz8bnj.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > +# @temperature: Device temperature in degrees Celsius.
> > +#
> > +# @dirty-shutdown-count: Number of time the device has been unable to  
> 
> Number of times
> 
> > +#                        determine whether data loss may have occurred.
> > +#
> > +# @corrected-volatile-error-count: Total number of correctable errors in
> > +#                                  volatile memory.
> > +#
> > +# @corrected-persistent-error-count: Total number correctable errors in
> > +#                                    persistent memory  
> 
> Please format like
> 
>    # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>    #     Record Format, Event Record Flags for subfield definitions.
>    #
>    # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>    #     Event Record for bit definitions for bit definiions.
>    #
>    # @health-status: Overall health summary bitmap.  See CXL r3.0 Table
>    #     8-100 Get Health Info Output Payload, Health Status for bit
>    #     definitions.
>    #
>    # @media-status: Overall media health summary.  See CXL r3.0 Table
>    #     8-100 Get Health Info Output Payload, Media Status for bit
>    #     definitions.
>    #
>    # @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
>    #     Payload, Additional Status for subfield definitions.
>    #
>    # @life-used: Percentage (0-100) of factory expected life span.
>    #
>    # @temperature: Device temperature in degrees Celsius.
>    #
>    # @dirty-shutdown-count: Number of time the device has been unable to
>    #     determine whether data loss may have occurred.

With "Number of times" this runs to 71 chars. reflowed appropriately for v8

>    #
>    # @corrected-volatile-error-count: Total number of correctable errors
>    #     in volatile memory.
>    #
>    # @corrected-persistent-error-count: Total number correctable errors
>    #     in persistent memory
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
> 
> 
> > +#
