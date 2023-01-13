Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC0BC54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 11:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbjAMLMj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjAMLLa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 06:11:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FF64EE
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 03:04:45 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntdls42kBz6J6BP;
        Fri, 13 Jan 2023 19:02:01 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 11:04:42 +0000
Date:   Fri, 13 Jan 2023 11:04:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rric@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Quiet port walking warning
Message-ID: <20230113110441.0000657e@Huawei.com>
In-Reply-To: <Y7VIjfnd957nCncQ@rric.localdomain>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
        <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
        <Y7QIP33kUAEPp6sb@rric.localdomain>
        <63b49906246a_5174129457@dwillia2-xfh.jf.intel.com.notmuch>
        <Y7VIjfnd957nCncQ@rric.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 4 Jan 2023 10:36:13 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 03.01.23 13:07:18, Dan Williams wrote:
> > Robert Richter wrote:  
> > > On 16.12.22 17:33:32, Dan Williams wrote:  
> 
> > > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > > index 810e60cc331c..6296d2bc909a 100644
> > > > --- a/drivers/cxl/core/port.c
> > > > +++ b/drivers/cxl/core/port.c
> > > > @@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > > >  
> > > >           uport_dev = dport_dev->parent;
> > > >           if (!uport_dev) {
> > > > -                 dev_warn(dev, "at %s no parent for dport: %s\n",
> > > > -                          dev_name(iter), dev_name(dport_dev));
> > > > +                 dev_dbg(dev, "at %s no parent for dport: %s\n",
> > > > +                         dev_name(iter), dev_name(dport_dev));
> > > >                   return -ENXIO;  
> > > 
> > > Maybe we should also change the return code to the common -EAGAIN for
> > > this case here too? It looks like it is just passed to
> > > cxl_mem_probe(), so there are probably no side effects of this change.
> > > The probe is triggered then again by the base driver.  
> > 
> > Good point, might as well explicitly return EPROBE_DEFER rather than let
> > the driver core turn EAGAIN into EPROBE_DEFER. Tests seem to pass with
> > that change as well.  
> 
> Yes, EPROBE_DEFER is the one used in the Deferred Probe
> infrastructure.

If doing that, can we add a dev_err_probe() call so that the deferred probing
infrastructure gets a nice error message for anyone wondering why this
deferred.  That calls the device_set_deferred_probe_reason() in the
-EPROBE_DEFER call and deals with dev_dbg print for this case for us.

> 
> Thanks,
> 
> -Robert

