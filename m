Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58814C77B7F
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 08:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjEQIu3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEQIu1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 04:50:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A440EB
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 01:50:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLmwf465gz6DBVs;
        Wed, 17 May 2023 16:48:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 17 May
 2023 09:50:22 +0100
Date:   Wed, 17 May 2023 09:50:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 00/14] cxl: Add support for QTG ID retrieval for CXL
 subsystem
Message-ID: <20230517095021.0000204b@Huawei.com>
In-Reply-To: <6463fa7ae35c4_250e2941f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <20230512162831.00003b34@Huawei.com>
        <6463fa7ae35c4_250e2941f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 16 May 2023 14:49:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > Hi Dave,
> >   
> > > The QTG ID for a device is retrieved via sending a _DSM method to the ACPI0017 device.
> > > The _DSM expects an input package of 4 DWORDS that contains the read latency, write
> > > latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
> > > path between the CXL device and the CPU. The QTG ID is also exported as a sysfs
> > > attribute under the mem device memory partition type:
> > > /sys/bus/cxl/devices/memX/ram/qos_class
> > > /sys/bus/cxl/devices/memX/pmem/qos_class
> > > Only the first QTG ID is exported.  
> > 
> > The QTG DSM returning a list was done to allow for a case of mutual
> > incompatibility between the first QTG that is returned for a particular
> > performance point and the CFMWS that it points at.
> > 
> > CFMWS might say 'no pmem in here' but due to some RAM device that is a bit
> > slow, we might end up with a QTG DSM response that says put it in that CFMWS.
> > 
> > Hence the fallback list.
> > 
> > That is currently hidden by this approach.  It makes things more complex, but
> > I'd really like to see the whole of that list rather than just the first element
> > presented for each region.  I think it's fine to let userspace then figure
> > out if there is a missmatch.  
> 
> There is some confusion here, the "Only the first QTG ID is exported"
> statement is with respect to the case of multiple DSMAS entries per
> partition. For the case of multiple platform QoS classes per single
> DSMAS I would be ok if this qos_class returned a comma-separated
> list/tuple.
> 
> So, for example, in a case where DSMAS0 for the 'ram' partition results
> in QoS class-ids 0,1,2 and DSMAS1 for the 'ram' partition results in QoS
> class-ids 3,4 then /sys/bus/cxl/devices/memX/ram/qos_class would be
> allowed to report "0,1,2".
> 
Great, that works nicely.

Jonathan


