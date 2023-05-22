Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78BC77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjEVM55 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEVM55 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 08:57:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F916184
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 05:57:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPy6Y1FKXz6J6yM;
        Mon, 22 May 2023 20:53:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 13:57:38 +0100
Date:   Mon, 22 May 2023 13:57:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <20230522135737.000079c4@Huawei.com>
In-Reply-To: <87lehgq1cy.fsf@pond.sub.org>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
        <87lehgq1cy.fsf@pond.sub.org>
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

On Mon, 22 May 2023 09:19:57 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > To facilitate testing provide a QMP command to inject a general media
> > event.  The event can be added to the log specified.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index ca3af3f0b2..9dcd308a49 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -5,6 +5,56 @@
> >  # = CXL devices
> >  ##
> >  
> > +##
> > +# @CxlEventLog:
> > +#
> > +# CXL has a number of separate event logs for different types of event.  
> 
> types of events
> 
> > +# Each such event log is handled and signaled independently.
> > +#
> > +# @informational: Information Event Log
> > +# @warning: Warning Event Log
> > +# @failure: Failure Event Log
> > +# @fatal: Fatal Event Log  
> 
> Are these proper nouns?  If not, the words should not be capitalized.

By your definition below of them being capitalized in the CXL spec then
yes, they are all proper nouns.


...

> > +#
> > +# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.1.1)  
> 
> What's "CXL r3.0", and where could a reader find it?

We have docs in docs/system/devices/cxl.rst that include the consortium
website which has download links on the front page.  I'm not sure we want to
have lots of references to the URL spread throughout QEMU.  I can add one
somewhere in cxl.json if you think it is important to have one here as well.

> 
> Aside: the idea of a document with numbered section nested six levels
> deep is kind of horrifying :)

Agreed!

> 
> Again, capitalize "General Media Event" only if it's a proper noun.  If
> "CXL r3.0" capitalizes it this way, it is.

It does capitalize it.

...

> 
> > +# @flags: header flags  
> 
> Either specify the header flags here, or point to specification.

Added a reference - same reason as below, the contents is being added to
with each version and we don't want to bake what is supported in this
interface if we can avoid it.

> 
> > +# @physaddr: Physical Address  
> 
> Perhaps "Guest physical address"
> 
> Address of what?

Changed already based on Phillipe's feedback on v6 to
Physical address (relative to @path device)

In CXL terms it's a Device Physical Address (DPA) which
are independent of the host (or guest) physical addresses with
runtime controllable mappings.
I'll change it to 

@dpa: Device Physical Address (relative to @path device)
(and Device Physical Address is capitalized like that in the CXL spec)

> 
> We have no consistent naming convention for guest physical addresses.  I
> see @addr, @memaddr, @gpa.  Let's not add yet another name for the same
> thing without need.

It's none of the above (except may addr which is so vague)

I'll change to dpa.

Also added a note that some of the lower bits encode flags
Not this is probably why the spec uses a different name - Physical
Address  to distinguish this from DPA - I'll keep that naming in the
implementation of the record, but it's not needed in the injection
interface where I think DPA is less confusing.

> 
> > +# @descriptor: Descriptor  
> 
> No.

Ok this indeed ended up sparse.

It is a tricky balance as I don't think it makes sense to just
duplicate large chunks of the spec. 
I'll have a go at summarizing what sort of things are in each.
As I mention below, we could break, these down fully at the cost
of constant updates as the CXL spec evolves to add new subfields
or values for existing fields.  This one for example currently has
3 bits, Uncorrectable Event, Threshold Event, Poison List Overflow event.
The next one currently has 3 bits defined as well, but there are 3 more
queued up for inclusion.

Realistically no one is going to write a descriptor without
looking at the specification for the field definitions and understanding
the physical geometry of their device (which will be device specific).

I'm fine with tweaking the balance though if you think that makes sense.

Jonathan



