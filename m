Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E6C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 13:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjE3NdZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjE3NdY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 09:33:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B5C7
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 06:33:22 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVtbJ584Nz689rj;
        Tue, 30 May 2023 21:31:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 14:33:19 +0100
Date:   Tue, 30 May 2023 14:33:18 +0100
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
Subject: Re: [PATCH v8 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <20230530143318.00005430@Huawei.com>
In-Reply-To: <87wn0u4953.fsf@pond.sub.org>
References: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
        <20230526171304.1613-8-Jonathan.Cameron@huawei.com>
        <87wn0u4953.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


...

> > +#
> > +# @corrected-persistent-error-count: Total number correctable errors  
> 
> Total number of correctable errors

Gah. I've now seen these too often so read that a good 5 times before
working out what was wrong!

> 
> > +#     in persistent memory
> > +#
> > +# Since: 8.1
> > +##
> > +{ 'command': 'cxl-inject-memory-module-event',
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> > +            'type': 'uint8', 'health-status': 'uint8',
> > +            'media-status': 'uint8', 'additional-status': 'uint8',
> > +            'life-used': 'uint8', 'temperature' : 'int16',
> > +            'dirty-shutdown-count': 'uint32',
> > +            'corrected-volatile-error-count': 'uint32',
> > +            'corrected-persistent-error-count': 'uint32'
> > +            }}
> > +
> >  ##
> >  # @cxl-inject-poison:
> >  #  
> 
> Neither these nitpicks nor the one on PATCH 5 calls for a respin.
> Simply fix them in the PR.  Thanks!

Thanks but for now Michael Tsirkin is still picking up the CXL focused
series based on patch sets so I'll spin a v9 with this stuff tidied up.

While, not true of this particular set, a lot of the CXL series are still
impacting the generic PCI code and so far Michael has been happy with that
approach.

Jonathan
