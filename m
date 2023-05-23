Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACCC77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjEWMr2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEWMr2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 08:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2711F
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684846002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dRH8NEgGXCDzh3rtjG1YE13tf7f9D9LeqrBwdq/9Khg=;
        b=PdlBi1HkKnuLd1ZB8oBkO09+QeWoof76zayg6q3zey+l+JP3tG6nk/jIQQTQQpZ1tBADnX
        QZSgt4nrYIAqtS9wlMknxHmmTURXDokflxSXP9vIGkbZx/bkZmAz5Y7JWVT0rCEuQCKkdA
        Oe6bzJxUwgDZEZWp3ygRsN/U0UDiaik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-MN5ii5jUM1aKIfNN78TzCg-1; Tue, 23 May 2023 08:46:39 -0400
X-MC-Unique: MN5ii5jUM1aKIfNN78TzCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2610A3801EDB;
        Tue, 23 May 2023 12:46:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F37DD492B00;
        Tue, 23 May 2023 12:46:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id E8B2621E692E; Tue, 23 May 2023 14:46:37 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>, <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
        <87lehgq1cy.fsf@pond.sub.org> <20230522135737.000079c4@Huawei.com>
        <87fs7na2o8.fsf@pond.sub.org> <20230523113543.00006a1f@Huawei.com>
Date:   Tue, 23 May 2023 14:46:37 +0200
Message-ID: <87ttw35i6q.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

>> >=20=20
>> >> > +#
>> >> > +# Inject an event record for a General Media Event (CXL r3.0 8.2.9=
.2.1.1)=20=20=20=20
>> >>=20
>> >> What's "CXL r3.0", and where could a reader find it?=20=20
>> >
>> > We have docs in docs/system/devices/cxl.rst that include the consortium
>> > website which has download links on the front page.=20=20
>>=20
>> cxl.rst has
>>=20
>>     References
>>     ----------
>>=20
>>      - Consortium website for specifications etc:
>>        http://www.computeexpresslink.org
>>      - Compute Express link Revision 2 specification, October 2020
>>      - CEDT CFMWS & QTG _DSM ECN May 2021
>>=20
>> Should the second reference be updated to 3.0?  Exact title seems to be
>> "The Compute Express Link=E2=84=A2 (CXL=E2=84=A2) 3.0 specification".  N=
ot sure we need
>> to bother with the "=E2=84=A2" in a reference.
>
> Yes. On the todo list is to update all the references to latest released
> specification because old ones are unobtainable to non consortium members
> unless they grabbed a copy in the past.
>
> Annoyingly this will be a repeated requirement as new spec versions are r=
eleased
> but the cadence should be fairly low.
>
>>=20
>> >                                                      I'm not sure we w=
ant to
>> > have lots of references to the URL spread throughout QEMU.  I can add =
one
>> > somewhere in cxl.json if you think it is important to have one here as=
 well.=20=20
>>=20
>> You could add an introduction right under the "# =3D CXL devices" headin=
g,
>> and include a full reference to the specification there.  Suitably
>> abbreviated references like the ones you use in this patch should then
>> be fine.
>
> I tried doing that - it resulted in the index including an entry with all=
 the text.
> So on the webpage, the contents list to the left includes whatever text y=
ou put
> in that block.
>=20=20
> I'm not sure why, or how to fix that.

Show me what you tried (as a patch or something I can git-pull), and
I'll have a look.

[...]

