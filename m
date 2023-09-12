Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8CCA0ECA
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 13:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjILNfp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjILNfb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 09:35:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75910D0
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 06:35:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlPhZ3tc6z6F9CD;
        Tue, 12 Sep 2023 21:34:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 14:35:24 +0100
Date:   Tue, 12 Sep 2023 14:35:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <junhee.ryu@sk.com>, <kwangjin.ko@sk.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v3 2/6] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Message-ID: <20230912143523.00004068@Huawei.com>
In-Reply-To: <20230912131351.00007e5e@Huawei.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
        <20230906001517.324380-3-gregory.price@memverge.com>
        <20230912131351.00007e5e@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 12 Sep 2023 13:13:51 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue,  5 Sep 2023 20:15:13 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > Call CXL_TYPE3 once at top of function to avoid multiple invocations.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>  
> 
> This one is queued up in a set I posted for Michael to hopefully pick up.
> So no need to keep it in this series (I'll post tree short etc)

Ah. Not yet queued up, but moved up my tree to next to the sanitize patch
that introduces this code.

Jonathan

> 
> Jonathan
> 
> > ---
> >  hw/mem/cxl_type3.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index fd9d134d46..80d596ee10 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1248,17 +1248,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> >                             unsigned size, MemTxAttrs attrs)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> >      uint64_t dpa_offset = 0;
> >      AddressSpace *as = NULL;
> >      int res;
> >  
> > -    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> > +    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
> >                                        &as, &dpa_offset);
> >      if (res) {
> >          return MEMTX_ERROR;
> >      }
> >  
> > -    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
> > +    if (sanitize_running(&ct3d->cci)) {
> >          qemu_guest_getrandom_nofail(data, size);
> >          return MEMTX_OK;
> >      }
> > @@ -1268,16 +1269,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> >  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> >                              unsigned size, MemTxAttrs attrs)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> >      uint64_t dpa_offset = 0;
> >      AddressSpace *as = NULL;
> >      int res;
> >  
> > -    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> > +    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
> >                                        &as, &dpa_offset);
> >      if (res) {
> >          return MEMTX_ERROR;
> >      }
> > -    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
> > +    if (sanitize_running(&ct3d->cci)) {
> >          return MEMTX_OK;
> >      }
> >      return address_space_write(as, dpa_offset, attrs, &data, size);  
> 
> 

