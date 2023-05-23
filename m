Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E49C7EE26
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 10:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjEWKf7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjEWKfy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 06:35:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF7120
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 03:35:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQVzJ2gNRz67lKb;
        Tue, 23 May 2023 18:33:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 11:35:44 +0100
Date:   Tue, 23 May 2023 11:35:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud?= =?ISO-8859-1?Q?=E9?= 
        <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        "Daniel P .\" =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>"@domain.invalid
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <20230523113543.00006a1f@Huawei.com>
In-Reply-To: <87fs7na2o8.fsf@pond.sub.org>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
        <87lehgq1cy.fsf@pond.sub.org>
        <20230522135737.000079c4@Huawei.com>
        <87fs7na2o8.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> >  
> >> > +#
> >> > +# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.1.1)    
> >> 
> >> What's "CXL r3.0", and where could a reader find it?  
> >
> > We have docs in docs/system/devices/cxl.rst that include the consortium
> > website which has download links on the front page.  
> 
> cxl.rst has
> 
>     References
>     ----------
> 
>      - Consortium website for specifications etc:
>        http://www.computeexpresslink.org
>      - Compute Express link Revision 2 specification, October 2020
>      - CEDT CFMWS & QTG _DSM ECN May 2021
> 
> Should the second reference be updated to 3.0?  Exact title seems to be
> "The Compute Express Link™ (CXL™) 3.0 specification".  Not sure we need
> to bother with the "™" in a reference.

Yes. On the todo list is to update all the references to latest released
specification because old ones are unobtainable to non consortium members
unless they grabbed a copy in the past.

Annoyingly this will be a repeated requirement as new spec versions are released
but the cadence should be fairly low.

> 
> >                                                      I'm not sure we want to
> > have lots of references to the URL spread throughout QEMU.  I can add one
> > somewhere in cxl.json if you think it is important to have one here as well.  
> 
> You could add an introduction right under the "# = CXL devices" heading,
> and include a full reference to the specification there.  Suitably
> abbreviated references like the ones you use in this patch should then
> be fine.

I tried doing that - it resulted in the index including an entry with all the text.
So on the webpage, the contents list to the left includes whatever text you put
in that block.
 
I'm not sure why, or how to fix that.

> 
> Please link to cxl.rst, too: add a label to cxl.rst, :ref: it from
> cxl.json.

Ok, I'm find doing that if it doesn't break the contents page as above.

> >> Either specify the header flags here, or point to specification.  
> >
> > Added a reference - same reason as below, the contents is being added to
> > with each version and we don't want to bake what is supported in this
> > interface if we can avoid it.  
> 
> Symbolic flags are a much friendlier interface, but limit the interface
> to what QEMU understands.
> 
> With a numeric encoding of flags, QEMU can serve as dumb transport
> between peers who may understand more flags than QEMU does.  One peer is
> the QMP client.  Who is the other peer?  Guest software?

Guest software in this case.

> 
> Can flags be useful even though the QEMU device model doesn't understand
> them?  Are they safe?  See below for a more general take on this.
> 


> >> No.  
> >
> > Ok this indeed ended up sparse.
> >
> > It is a tricky balance as I don't think it makes sense to just
> > duplicate large chunks of the spec. 
> > I'll have a go at summarizing what sort of things are in each.
> > As I mention below, we could break, these down fully at the cost
> > of constant updates as the CXL spec evolves to add new subfields
> > or values for existing fields.  This one for example currently has
> > 3 bits, Uncorrectable Event, Threshold Event, Poison List Overflow event.
> > The next one currently has 3 bits defined as well, but there are 3 more
> > queued up for inclusion.
> >
> > Realistically no one is going to write a descriptor without
> > looking at the specification for the field definitions and understanding
> > the physical geometry of their device (which will be device specific).
> >
> > I'm fine with tweaking the balance though if you think that makes sense.  
> 
> This is about picking an appropriate level of abstraction for the QMP
> interface.
> 
> In your patch, it is basically a few named sequences of bits.  The
> interface changes only when new named entities get added to the spec.
> Spec revisions may also add new uses of existing entities' bits, but the
> interface doesn't care.
> 
> The lowest imaginable level is a single sequence of bits.  Basically the
> named bit sequences pasted together.  Now the interface changes only
> when we run out of bits.  Mind, I'm merely exploring the limits here.
> 
> At higher levels we use symbols rather than bits.  This interface needs
> to change when symbols get added to the spec.
> 
> I figure the deciding question is the QEMU device model's role in all
> this.
> 
> When something can be used safely only when the device model knows it,
> providing a symbolic interface doesn't add to the things QEMU needs to
> know.  Moreover, the interface can't be misused.
> 
> For things where the device model acts as a dumb transport, i.e. only
> management application and guest need to know it, not having to put he
> knowledge into QEMU just to enable it to transport bits makes some
> sense.  It may enable misuse.
> 
> So, can you tell us a bit more about what the device model needs to
> know to function?
>

For the event record injection, this is definitely the dumb transport case.
Given a real device firmware might well create records that aren't 'valid'
guest software has to be written with that in mind. Also, additional information
can be added to these records in reserved bits and the guest software has
to deal with that (+ the spec change has to be written so that it is backwards
compatible).

For the case of Events, I don't think there is anything the device
model needs to know (beyond the 'which device question')

That is different from the poison case in the other series, where at some
stage we will emulate the other way of getting poison
(normal CPU read of poisoned memory) and need to be able to use the
provided address and length to implement that.

Note that a future series will tie together generating some of these event
records as other things happen - e.g. poison injection.  This will be
similar to how poison list elements are added either by QMP (to simulate
real hardware failures) and via Guest Software using a mailbox on the device
(to simulate software driven error injection sequences).

Jonathan

