Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95764C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMRkz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJMRky (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 13:40:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D585748D0
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 10:40:52 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpGwd2Cqgz67J5b;
        Fri, 14 Oct 2022 01:39:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 19:40:49 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 18:40:48 +0100
Date:   Thu, 13 Oct 2022 18:40:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        "Huai-Cheng Kuo" <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v8 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221013184047.00004d08@huawei.com>
In-Reply-To: <Y0hLquDTg8jv9SbE@memverge.com>
References: <20221013120009.15541-1-Jonathan.Cameron@huawei.com>
        <20221013120009.15541-5-Jonathan.Cameron@huawei.com>
        <Y0g8UgumJwqU4QyB@memverge.com>
        <20221013130840-mutt-send-email-mst@kernel.org>
        <20221013182144.00004466@huawei.com>
        <Y0hLquDTg8jv9SbE@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Oct 2022 13:32:26 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> If you're expecting this to be dynamic in size in the future, then maybe
> what we really want here is a function
> 
> static int ct3_get_cdat_size(CXLType3Dev ct3d) {
>     /* TODO: Dynamic sizing calculations */
>     return CT3_CDAT_NUM_ENTRIES;
> }

Perhaps, though that suffers from lack of locality and clearly
flagging that the enum is definitely not global.

Anyhow, lets argue that mechanism when it's needed :)

Jonathan

> 
> 
> On Thu, Oct 13, 2022 at 06:21:44PM +0100, Jonathan Cameron wrote:
> > On Thu, 13 Oct 2022 13:09:26 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Oct 13, 2022 at 12:26:58PM -0400, Gregory Price wrote:  
> > > > Other than the nitpicks below, lgtm.  Not sure if you need a sign off
> > > > from me given the contributions:
> > > > 
> > > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > >     
> > > > > +/* If no cdat_table == NULL returns number of entries */
> > > > > +static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> > > > > +                                         int dsmad_handle, MemoryRegion *mr)
> > > > > +{
> > > > > +    enum {
> > > > > +        DSMAS,
> > > > > +        DSLBIS0,
> > > > > +        DSLBIS1,
> > > > > +        DSLBIS2,
> > > > > +        DSLBIS3,
> > > > > +        DSEMTS,
> > > > > +        NUM_ENTRIES
> > > > > +    };    
> > > > // ...    
> > > > > +    if (!cdat_table) {
> > > > > +        return NUM_ENTRIES;
> > > > > +    }    
> > > > 
> > > > the only thing that i would recommend is making this enum global (maybe
> > > > renaming them CT3_CDAT_[ENTRY_NAME]) and using CT3_CDAT_NUM_ENTRIES
> > > > directly in the function that allocates the cdat buffer itself.    
> > > 
> > > 
> > > Yes I think I agree here.  
> > 
> > Ok, seems a consensus against having this local.
> > 
> > I can do this for now and then revisit if / when things become more complex
> > and this becomes not global.  I guess a potential case of premature flexibility.
> > 
> > Jonathan
> >   
> > >   
> > > > I do
> > > > understand the want to keep the enum and the code creating the entries
> > > > co-located though, so i'm just nitpicking here i guess.
> > > > 
> > > > Generally I dislike the pattern of passing a NULL into a function to get
> > > > configuration data, and then calling that function again.  This function
> > > > wants to be named...
> > > > 
> > > > ct3_build_cdat_entries_for_mr_or_get_table_size_if_cdat_is_null(...)
> > > > 
> > > > to accurately describe what it does.  Just kinda feels like an extra
> > > > function call for no reason.
> > > > 
> > > > But either way, it works, this is just a nitpick on my side.
> > > >     
> > > > > +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > > > > +{
> > > > > +    g_autofree CDATSubHeader **table = NULL;
> > > > > +    CXLType3Dev *ct3d = priv;
> > > > > +    MemoryRegion *volatile_mr;
> > > > > +    /* ... snip ... */
> > > > > +}    
> > > > 
> > > > s/volatile/nonvolatile    
> > >   
> >   

