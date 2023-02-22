Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A97C636D6
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 16:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjBVQ1G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBVQ1G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 11:27:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4496A3754D
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 08:27:04 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMLyv32jkz6J7Ts;
        Thu, 23 Feb 2023 00:22:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 16:27:01 +0000
Date:   Wed, 22 Feb 2023 16:27:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nabeel M Mohamed <nabeelmd.linux@gmail.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <20230222162700.00006d0f@Huawei.com>
In-Reply-To: <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
        <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 22 Feb 2023 09:34:14 -0600
Nabeel M Mohamed <nabeelmd.linux@gmail.com> wrote:

> On Mon, Jan 30, 2023 at 03:13:27PM +0000, Jonathan Cameron wrote:
> > CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> > the timestamp after every Conventional or CXL Reset to ensure accurate
> > timestamps. This should include on initial boot up. The time base that
> > is being set is used by a device for the poison list overflow timestamp
> > and all event timestamps.  Note that the command is optional and if
> > not supported and the device cannot return accurate timestamps it will
> > fill the fields in with an appropriate marker (see the specification
> > description of each timestamp).
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >  
> 
> Hi Jonathan,
> 
> Could you please educate me on the reason for not supporting a
> "Get Timestamp" mailbox command at this time?
> 
> A use-case that I can think of for having "Get Timestamp" in the UAPI
> is to enable userspace to better correlate the timestamp in the device
> logs with the wall time by querying the current timestamp on the device.
> This could be useful if there's some inaccuracy or skew in the device
> timestamp.
> 
> Would that be a valid use-case or am I misunderstanding something here?
> 
> I can see why "Set Timestamp" is a kernel-internal command but fail to
> see why "Get Timestamp" cannot be in the UAPI.

Hi Nabeel,

I'd be fine with a patch adding the support, it just didn't solve my
immediate problem so I didn't want to make this patch more complex.

Jonathan

> 
> Please clarify.
> 
> Thanks,
> Nabeel

