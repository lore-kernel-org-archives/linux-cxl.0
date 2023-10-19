Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1FB1A290
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F9BE
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 04:48:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB5Vc1wzhz6HJTY;
	Thu, 19 Oct 2023 19:44:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 12:48:20 +0100
Date: Thu, 19 Oct 2023 12:48:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Fan Ni
	<fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>
Subject: Re: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231019124819.00005f6a@Huawei.com>
In-Reply-To: <20231019122448.0000009e@Huawei.com>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
	<20231012140514.3697-3-Jonathan.Cameron@huawei.com>
	<20231018103907-mutt-send-email-mst@kernel.org>
	<20231018172239.00005f3d@Huawei.com>
	<20231018173142.00003739@Huawei.com>
	<20231019100547.00003eef@huawei.com>
	<20231019052242-mutt-send-email-mst@kernel.org>
	<20231019122448.0000009e@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Thu, 19 Oct 2023 12:24:48 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 19 Oct 2023 05:23:04 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 19, 2023 at 10:09:24AM +0100, Jonathan Cameron wrote:  
> > > On Wed, 18 Oct 2023 17:31:42 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >     
> > > > On Wed, 18 Oct 2023 17:22:39 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > >     
> > > > > On Wed, 18 Oct 2023 10:40:45 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >       
> > > > > > On Thu, Oct 12, 2023 at 03:05:12PM +0100, Jonathan Cameron wrote:        
> > > > > > > Establishing that only register accesses of size 4 and 8 can occur
> > > > > > > using these functions requires looking at their callers. Make it
> > > > > > > easier to see that by using switch statements.
> > > > > > > Assertions are used to enforce that the register storage is of the
> > > > > > > matching size, allowing fixed values to be used for divisors of
> > > > > > > the array indices.
> > > > > > > 
> > > > > > > Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>          
> > > > > > 
> > > > > > Fails with clang:
> > > > > > 
> > > > > > ../hw/cxl/cxl-component-utils.c:130:9: error: expected expression
> > > > > >         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> > > > > >         ^
> > > > > > ../include/qemu/compiler.h:76:30: note: expanded from macro 'QEMU_BUILD_BUG_ON'
> > > > > > #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
> > > > > >                              ^
> > > > > > ../include/qemu/compiler.h:74:36: note: expanded from macro 'QEMU_BUILD_BUG_MSG'
> > > > > > #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
> > > > > >                                    ^
> > > > > > 1 error generated.
> > > > > > 
> > > > > > See e.g.
> > > > > > 
> > > > > > https://gitlab.com/mstredhat/qemu/-/jobs/5320879531        
> > > > > 
> > > > > Thanks. Will see if I can figure out what is going wrong.
> > > > > This code seems cursed.  I need to figure out a way to run the CI again.
> > > > > Ran into credit problems I couldn't solve last time I tried.
> > > > > 
> > > > > In meantime I can replicate this locally but not immediately obvious to me
> > > > > why it is failing.      
> > > > 
> > > > Any clang experts around?  This seems to be fixed by reducing the scope
> > > > 
> > > > case 4:
> > > > {
> > > > 	QEMU_BUILD_BUG_ON();
> > > > }
> > > > I have no idea why though...
> > > >     
> > > 
> > > For anyone following along I asked a friendly compiler guy...
> > > 
> > > https://github.com/llvm/llvm-project/issues/69572
> > > 
> > > Given that we realistically need to work around this whatever the outcome
> > > I'll add some brackets and send an update.
> > > 
> > > thanks,
> > > 
> > > Jonathan    
> > 
> > We don't seem to use QEMU_BUILD_BUG_ON outside of functions - just add
> > brackets inside it?  
> 
> Makes sense.  I'll give that a go and see if anything odd happens.
It's used outside of functions such as in
include/exec/tlb-common.h

So can't add brackets to the definition. 

Back to papering over the individual cases for now.

Jonathan

> 
> Jonathan
> 
> >   
> > > >     
> > > > > 
> > > > > Jonathan
> > > > >       
> > > > > > 
> > > > > > 
> > > > > >         
> > > > > > > ---
> > > > > > > v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
> > > > > > >     error message.
> > > > > > > 
> > > > > > >  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
> > > > > > >  1 file changed, 42 insertions(+), 23 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > > > > > index f3bbf0fd13..d1997a52e6 100644
> > > > > > > --- a/hw/cxl/cxl-component-utils.c
> > > > > > > +++ b/hw/cxl/cxl-component-utils.c
> > > > > > > @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> > > > > > >      CXLComponentState *cxl_cstate = opaque;
> > > > > > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > > > > > >  
> > > > > > > -    if (size == 8) {
> > > > > > > +    switch (size) {
> > > > > > > +    case 4:
> > > > > > > +        if (cregs->special_ops && cregs->special_ops->read) {
> > > > > > > +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> > > > > > > +        } else {
> > > > > > > +            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > > > > > +            return cregs->cache_mem_registers[offset / 4];
> > > > > > > +        }
> > > > > > > +    case 8:
> > > > > > >          qemu_log_mask(LOG_UNIMP,
> > > > > > >                        "CXL 8 byte cache mem registers not implemented\n");
> > > > > > >          return 0;
> > > > > > > -    }
> > > > > > > -
> > > > > > > -    if (cregs->special_ops && cregs->special_ops->read) {
> > > > > > > -        return cregs->special_ops->read(cxl_cstate, offset, size);
> > > > > > > -    } else {
> > > > > > > -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > > > > > +    default:
> > > > > > > +        /*
> > > > > > > +         * In line with specifiction limitaions on access sizes, this
> > > > > > > +         * routine is not called with other sizes.
> > > > > > > +         */
> > > > > > > +        g_assert_not_reached();
> > > > > > >      }
> > > > > > >  }
> > > > > > >  
> > > > > > > @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> > > > > > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > > > > > >      uint32_t mask;
> > > > > > >  
> > > > > > > -    if (size == 8) {
> > > > > > > +    switch (size) {
> > > > > > > +    case 4:
> > > > > > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> > > > > > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > > > > > +        mask = cregs->cache_mem_regs_write_mask[offset / 4];
> > > > > > > +        value &= mask;
> > > > > > > +        /* RO bits should remain constant. Done by reading existing value */
> > > > > > > +        value |= ~mask & cregs->cache_mem_registers[offset / 4];
> > > > > > > +        if (cregs->special_ops && cregs->special_ops->write) {
> > > > > > > +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > > > > > +            return;
> > > > > > > +        }
> > > > > > > +
> > > > > > > +        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > > > > > +            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > > > > > +            dumb_hdm_handler(cxl_cstate, offset, value);
> > > > > > > +        } else {
> > > > > > > +            cregs->cache_mem_registers[offset / 4] = value;
> > > > > > > +        }
> > > > > > > +        return;
> > > > > > > +    case 8:
> > > > > > >          qemu_log_mask(LOG_UNIMP,
> > > > > > >                        "CXL 8 byte cache mem registers not implemented\n");
> > > > > > >          return;
> > > > > > > -    }
> > > > > > > -    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
> > > > > > > -    value &= mask;
> > > > > > > -    /* RO bits should remain constant. Done by reading existing value */
> > > > > > > -    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > > > > > -    if (cregs->special_ops && cregs->special_ops->write) {
> > > > > > > -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > > > > > -        return;
> > > > > > > -    }
> > > > > > > -
> > > > > > > -    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > > > > > -        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > > > > > -        dumb_hdm_handler(cxl_cstate, offset, value);
> > > > > > > -    } else {
> > > > > > > -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> > > > > > > +    default:
> > > > > > > +        /*
> > > > > > > +         * In line with specifiction limitaions on access sizes, this
> > > > > > > +         * routine is not called with other sizes.
> > > > > > > +         */
> > > > > > > +        g_assert_not_reached();
> > > > > > >      }
> > > > > > >  }
> > > > > > >  
> > > > > > > -- 
> > > > > > > 2.39.2          
> > > > > > 
> > > > > >         
> > > > >       
> > > > 
> > > > 
> > > >     
> >   
> 

