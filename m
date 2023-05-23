Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65858C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 08:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjEWINR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjEWIMn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 04:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33590186
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684829436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrwnZp6yeMQOmeCBRF+viYsURs0tplrgN8AkC8JRKGw=;
        b=jC11KvsyajZBWcf1rT4o+Q4nZbjcWmtQih6yLLcE6iun9aJbpiI1IAgSfkYHOMslJY7Jyo
        tUPkD0NBnCAWs21zDhi/tVsULqJmX5SWpxGR9U/LJszP6DDdjutWBqIP7oYd4LBt9LgJ2Z
        Ou2pKziJBkhEH3E4pE/ChkNp1WIxsTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-_5opcnalPbW_CGWkF2Ksqw-1; Tue, 23 May 2023 04:10:33 -0400
X-MC-Unique: _5opcnalPbW_CGWkF2Ksqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92698185A794;
        Tue, 23 May 2023 08:10:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BA2E40C6CD7;
        Tue, 23 May 2023 08:10:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 32B1521E692E; Tue, 23 May 2023 10:10:31 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
        <87lehgq1cy.fsf@pond.sub.org> <20230522135737.000079c4@Huawei.com>
Date:   Tue, 23 May 2023 10:10:31 +0200
In-Reply-To: <20230522135737.000079c4@Huawei.com> (Jonathan Cameron's message
        of "Mon, 22 May 2023 13:57:37 +0100")
Message-ID: <87fs7na2o8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Mon, 22 May 2023 09:19:57 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > From: Ira Weiny <ira.weiny@intel.com>
>> >
>> > To facilitate testing provide a QMP command to inject a general media
>> > event.  The event can be added to the log specified.
>> >
>> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=20=20
>>=20
>> [...]
>>=20
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index ca3af3f0b2..9dcd308a49 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -5,6 +5,56 @@
>> >  # =3D CXL devices
>> >  ##
>> >=20=20
>> > +##
>> > +# @CxlEventLog:
>> > +#
>> > +# CXL has a number of separate event logs for different types of even=
t.=20=20
>>=20
>> types of events
>>=20
>> > +# Each such event log is handled and signaled independently.
>> > +#
>> > +# @informational: Information Event Log
>> > +# @warning: Warning Event Log
>> > +# @failure: Failure Event Log
>> > +# @fatal: Fatal Event Log=20=20
>>=20
>> Are these proper nouns?  If not, the words should not be capitalized.
>
> By your definition below of them being capitalized in the CXL spec then
> yes, they are all proper nouns.

Good.

> ...
>
>> > +#
>> > +# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.=
1.1)=20=20
>>=20
>> What's "CXL r3.0", and where could a reader find it?
>
> We have docs in docs/system/devices/cxl.rst that include the consortium
> website which has download links on the front page.

cxl.rst has

    References
    ----------

     - Consortium website for specifications etc:
       http://www.computeexpresslink.org
     - Compute Express link Revision 2 specification, October 2020
     - CEDT CFMWS & QTG _DSM ECN May 2021

Should the second reference be updated to 3.0?  Exact title seems to be
"The Compute Express Link=E2=84=A2 (CXL=E2=84=A2) 3.0 specification".  Not =
sure we need
to bother with the "=E2=84=A2" in a reference.

>                                                      I'm not sure we want=
 to
> have lots of references to the URL spread throughout QEMU.  I can add one
> somewhere in cxl.json if you think it is important to have one here as we=
ll.

You could add an introduction right under the "# =3D CXL devices" heading,
and include a full reference to the specification there.  Suitably
abbreviated references like the ones you use in this patch should then
be fine.

Please link to cxl.rst, too: add a label to cxl.rst, :ref: it from
cxl.json.

>> Aside: the idea of a document with numbered section nested six levels
>> deep is kind of horrifying :)
>
> Agreed!
>
>>=20
>> Again, capitalize "General Media Event" only if it's a proper noun.  If
>> "CXL r3.0" capitalizes it this way, it is.
>
> It does capitalize it.
>
> ...
>
>>=20
>> > +# @flags: header flags=20=20
>>=20
>> Either specify the header flags here, or point to specification.
>
> Added a reference - same reason as below, the contents is being added to
> with each version and we don't want to bake what is supported in this
> interface if we can avoid it.

Symbolic flags are a much friendlier interface, but limit the interface
to what QEMU understands.

With a numeric encoding of flags, QEMU can serve as dumb transport
between peers who may understand more flags than QEMU does.  One peer is
the QMP client.  Who is the other peer?  Guest software?

Can flags be useful even though the QEMU device model doesn't understand
them?  Are they safe?  See below for a more general take on this.

>> > +# @physaddr: Physical Address=20=20
>>=20
>> Perhaps "Guest physical address"
>>=20
>> Address of what?
>
> Changed already based on Phillipe's feedback on v6 to
> Physical address (relative to @path device)
>
> In CXL terms it's a Device Physical Address (DPA) which
> are independent of the host (or guest) physical addresses with
> runtime controllable mappings.
> I'll change it to=20
>
> @dpa: Device Physical Address (relative to @path device)
> (and Device Physical Address is capitalized like that in the CXL spec)

Better, because the difference to guest physical address is now clear.

>> We have no consistent naming convention for guest physical addresses.  I
>> see @addr, @memaddr, @gpa.  Let's not add yet another name for the same
>> thing without need.
>
> It's none of the above (except may addr which is so vague)
>
> I'll change to dpa.
>
> Also added a note that some of the lower bits encode flags
> Not this is probably why the spec uses a different name - Physical
> Address  to distinguish this from DPA - I'll keep that naming in the
> implementation of the record, but it's not needed in the injection
> interface where I think DPA is less confusing.
>
>>=20
>> > +# @descriptor: Descriptor=20=20
>>=20
>> No.
>
> Ok this indeed ended up sparse.
>
> It is a tricky balance as I don't think it makes sense to just
> duplicate large chunks of the spec.=20
> I'll have a go at summarizing what sort of things are in each.
> As I mention below, we could break, these down fully at the cost
> of constant updates as the CXL spec evolves to add new subfields
> or values for existing fields.  This one for example currently has
> 3 bits, Uncorrectable Event, Threshold Event, Poison List Overflow event.
> The next one currently has 3 bits defined as well, but there are 3 more
> queued up for inclusion.
>
> Realistically no one is going to write a descriptor without
> looking at the specification for the field definitions and understanding
> the physical geometry of their device (which will be device specific).
>
> I'm fine with tweaking the balance though if you think that makes sense.

This is about picking an appropriate level of abstraction for the QMP
interface.

In your patch, it is basically a few named sequences of bits.  The
interface changes only when new named entities get added to the spec.
Spec revisions may also add new uses of existing entities' bits, but the
interface doesn't care.

The lowest imaginable level is a single sequence of bits.  Basically the
named bit sequences pasted together.  Now the interface changes only
when we run out of bits.  Mind, I'm merely exploring the limits here.

At higher levels we use symbols rather than bits.  This interface needs
to change when symbols get added to the spec.

I figure the deciding question is the QEMU device model's role in all
this.

When something can be used safely only when the device model knows it,
providing a symbolic interface doesn't add to the things QEMU needs to
know.  Moreover, the interface can't be misused.

For things where the device model acts as a dumb transport, i.e. only
management application and guest need to know it, not having to put he
knowledge into QEMU just to enable it to transport bits makes some
sense.  It may enable misuse.

So, can you tell us a bit more about what the device model needs to
know to function?

