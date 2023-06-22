Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E17DEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFVNuq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVNup (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 09:50:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513011988
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 06:50:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1sS450Pz6GD5X;
        Thu, 22 Jun 2023 21:47:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:50:40 +0100
Date:   Thu, 22 Jun 2023 14:50:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 04/12] cxl: Remove leftover attribute documentation
 in 'struct cxl_dev_state'
Message-ID: <20230622145039.00004e43@Huawei.com>
In-Reply-To: <a4292abc-1884-5d39-4802-1e06b54328d8@intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
        <168679259703.3436160.12583306507362357946.stgit@dwillia2-xfh.jf.intel.com>
        <a4292abc-1884-5d39-4802-1e06b54328d8@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Jun 2023 14:29:08 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/14/23 18:29, Dan Williams wrote:
> > commit 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration
> > in the core")
> > 
> > ...removed @info from 'struct cxl_dev_state', but neglected to remove
> > the corresponding kernel-doc entry. Complete the removal.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Closes: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > ---
> >   drivers/cxl/cxlmem.h |    1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 8e4ba5b52902..66896fc6c43f 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -287,7 +287,6 @@ struct cxl_poison_state {
> >    * @next_volatile_bytes: volatile capacity change pending device reset
> >    * @next_persistent_bytes: persistent capacity change pending device reset
> >    * @component_reg_phys: register base of component registers
> > - * @info: Cached DVSEC information about the device.
> >    * @serial: PCIe Device Serial Number
> >    * @event: event log driver state
> >    * @poison: poison driver state info
> >   

