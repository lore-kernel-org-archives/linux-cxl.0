Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205436B931
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201848; cv=none; b=STkLbwD/ADfKJF50HHULVICuvh5tby5hon2W+R2dVuG0yiiDObFwsQ3IZPR0ms+HYQtcKtnZKKRPaTWgnOocVlCXFOixz8SzKVA90dXI+mcBttg+6bdeTd32Mt2EYBYHnh/16ek4loBtz3z0aTE98lsUbCZ3RB2wvBd/fN8+AhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201848; c=relaxed/simple;
	bh=vf5+09dUi2yVakE2E0JaMao3iRm+jgJ4m8tGZgpIASY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4WOiR9kA25/1Izb4z0SiueMwhdxll7rW7obl17CxOCYm/8NWQMt2gtxHVkrR1hu8ZkfvrIr7mNHSw9PITyCp1TJvmq/JUi3d0mGvlWJhGP7id9eYozGu23WhLiBU6WQY5tUH4vhnWK7zjjwCjPhUblpYBfCxYA6L4J/O3nzN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7ZqcO7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7ZqcO7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788201844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy0jZcKpecBsRYb0oiNpQgveju/GEQS8bQ6zsdRVYxU=;
	b=W7ZqcO7i+SyERvLg8JFTFRaCK0Es2NjOZfOaMNgCQf6HCHLciVSDOzKYwasUqC1BjsUgw7
	7n24ezXizgzHD6t/Z/2Emhn+4qZQdPBlGuJ6fyFfl/+R/kxeP6R1LYHEOQT8oynJ7bPxyj
	GZ6JQ7POG/5VllEfv5dnmC68E9/+Lu0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-k75uPXN3MHeBK-rDEuVr8w-1; Mon, 31 Aug 2026 14:44:03 -0400
X-MC-Unique: k75uPXN3MHeBK-rDEuVr8w-1
X-Mimecast-MFC-AGG-ID: k75uPXN3MHeBK-rDEuVr8w_1788201842
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66e50de8143so4183055d50.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 11:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201842; x=1788806642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy0jZcKpecBsRYb0oiNpQgveju/GEQS8bQ6zsdRVYxU=;
        b=KL+LmsnGwKSMggfl2IOAB6Gf6/doxyKMaCk+L+3X7L5041xWPj7dTYonUTDJbBbJu8
         9tW7qtBKCZTYfK4nz8ja0kp5EOeSIQiF1qiaTjMq88nrr7BkshWnFOzLpi+3Kg6bGn6P
         n2+QG6yZvLP4KUpWddHSObUWDHDdeSTUBaZB3IB/vsgjorqz2E4q/FFjnmEj9HXMzGfH
         jsnMVgVHGcPx+p7FUENWk3c5OJbO0n3je2pPM0i32cDWuFQ2fNwc0DIBRiCumnmrLgFc
         0E9AVn+Pcob8cqlwiF5IiT0+din6r8cJGPEpK9SRDhvYj2XW56rsX4F+ALqLaAK/j0MR
         VrJg==
X-Forwarded-Encrypted: i=1; AKwUvByOd6cBuOA6QLpQHPet3WWWnL7JAZ21yPujat9JIyaQz7PUJrpU7ITADQf2PMfkTWYwAc8L9N5Kxjo=@vger.kernel.org
X-Gm-Message-State: AFuF++nJcDlNrnDEhFhRNkjzBzWB3uM80pMtimOZ9hJaA7as02EqR9bL
	x5EqZ25qq6dNfBgjOKpaolVXes/PR3z69EKGbwCxh0flkVw3iQIm16zzAIKGcbgiUlr3iElUj9P
	szbJnvo01Wu/+vVSP9XreOYEhUqBB387S9dXLnaGkVPRdfx0VJoOYoS78YvwQn7/l/NvHcad3Dn
	/nXo0L8vxUJfb8QcpPQkmbGFmQbC8LKQSkh64X
X-Gm-Gg: AYBFou0MAvn3wVhVj0BK8xAOfMTg7I9Y4pu0XNML3iE6YPc68xbRpa93QLmmogTdpTZ
	6JPmNFUo11yugr7Zk6xWvh5dDh9fcnekNkgXOsx0pZCgRJhbwLxZ3kxUyQdmXUsqM+cH+/jLRot
	OyLdMKvjRZ357MCgcCphD9AaHPmaeXTKuXOSCZbHWnNs4wFWrq07AOaUTrb+pK8ljpiySoQcEEQ
	UZzvJ8SQw6ybhvN
X-Received: by 2002:a53:e031:0:b0:66b:b123:edf7 with SMTP id 956f58d0204a3-66e4c7640a7mr7909071d50.41.1788201842207;
        Mon, 31 Aug 2026 11:44:02 -0700 (PDT)
X-Received: by 2002:a53:e031:0:b0:66b:b123:edf7 with SMTP id
 956f58d0204a3-66e4c7640a7mr7909044d50.41.1788201841638; Mon, 31 Aug 2026
 11:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826193840.2152000-1-jsnow@redhat.com> <20260826193840.2152000-2-jsnow@redhat.com>
 <ao_-_38raHK0rWkX@redhat.com> <87jypb90c0.fsf@pond.sub.org> <apA-CzGqrlFNfjp5@redhat.com>
In-Reply-To: <apA-CzGqrlFNfjp5@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Aug 2026 14:43:50 -0400
X-Gm-Features: AcwNN1U7U_H0llO6PbcP2SiDomkf5aFXIboSJ6KTmuVOJVPeh4fAMV8BIicxfUc
Message-ID: <CAFn=p-bUTApw73Ddz-tH1FzY97Ct5rfFZ=domFhm-OO3G8COug@mail.gmail.com>
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for error.json
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
	Alex Williamson <alex@shazbot.org>, linux-cxl@vger.kernel.org, 
	Michael Tokarev <mjt@tls.msk.ru>, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Peter Xu <peterx@redhat.com>, 
	Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org, 
	Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
	Jiri Pirko <jiri@resnulli.us>, qemu-block@nongnu.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	linux-edac@vger.kernel.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
	Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Zhao Liu <zhao1.liu@intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LE7KTGEeFyN1-lmLR2lqivvT6luHtrhdddmzPbukMB0_1788201842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Aug 27, 2026 at 03:09:35PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
> > >> Signed-off-by: John Snow <jsnow@redhat.com>
> > >> ---
> > >>  qapi/error.json | 3 +--
> > >>  1 file changed, 1 insertion(+), 2 deletions(-)
> > >>
> > >> diff --git a/qapi/error.json b/qapi/error.json
> > >> index 54cb02fb880..a53b13e55c9 100644
> > >> --- a/qapi/error.json
> > >> +++ b/qapi/error.json
> > >> @@ -9,8 +9,7 @@
> > >>
> > >>  ##
> > >>  # @QapiErrorClass:
> > >> -#
> > >> -# QEMU error classes
> > >> +#     QEMU error classes
> > >
> > > Where is this need for indent coming from ?  From the POV of someone
> > > writing comments, the need to indent the introductory text like this
> > > feels very counter-intuitive, an exception from any other inline
> > > docs syntax I've typically used. Is there any way we can avoid this ?
> >
> > The cover letter explains the need:
>
> Yes, I just didn't see the connection from that, to the use
> of indent.
>
> >
> >     This is being done primarily for the benefit of the forthcoming
> >     "inliner", a feature for the rendered HTML QMP documentation that
> >     seeks to "inline" QMP command argument documentation into the argum=
ent
> >     list for each command.
> >
> >     There are two main motives here:
> >
> >     (1) We want the split between the "introduction" and "details"
> >         sections to be mechanically obvious, so that auto-generated or
> >         inlined documentation has a well-defined, obvious spot to go.
> >
> >     (2) We do not want to inline irrelevant, introductory text describi=
ng
> >         structures to be copied into command documentation.
>
> So IIUC, you're saying that we are going to rely on indentation
> to distinguish introduction from details ?
>
>
> > Note that the inliner elided Netdev's Intro "Captures the configuration
> > of a network device."
> >
> > However, when Intro and Details bleed together, the inliner elides more
> > than it should.  I consider that a fairly serious issue.
> >
> > I'm afraid forgetting to mark the end of Intro with "Details:" would be
> > a common mistake, easy to miss in review.  So I explored possible
> > alternatives:
> >
> >     Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
> >     Date: Wed, 15 Apr 2026 11:43:45 +0200
> >     Message-ID: <87zf341ru6.fsf@pond.sub.org>
> >     https://lore.kernel.org/qemu-devel/87zf341ru6.fsf@pond.sub.org/
> >
> > John is working towards "3. Make the end of intro syntactically obvious=
"
> > always, specifically "3c. Indent intro like descriptions and tagged
> > sections" with the ultimate goal to reject unindented Intro.  That way,
> > we cannot write an Intro with an unclear end.  John, correct me if I'm
> > accidentally misrepresenting your work.
> >
> > Questions?  Better ideas?
>
> As an author, how substantive is "Intro" expected to be? I guess on
> QAPI docs I've written I've not ever been aware of there even being
> a distinct concept of Intro vs Details to think about. It is all just
> some lines of prose to me.

In most cases, not very substantial. For commands and events, it *can*
be quite a bit more substantial. For structs, enums, etc it is almost
always laughably trivial.

When the syntactical delineation of intro is complete, further QAPI
parser changes will make it even more obvious: any free text that
exists between the intro and the other sections will be flagged as an
error, where you will be urged to move any detail text to below the
metadata fields. This physical relocation will help suggest to the
documentation author what goes "above the fold" and what goes "below
the fold", so to speak.

>
> My only alternative idea to indentation would be to declare that the
> "Intro" is always the 1st paragraph of text and anything beyond that
> is the "Details". That might match up with the way that contributors
> naturally write text where the 1st paragraph conveys the key idea,
> such that they dno't need to think about Intro vs Details as a
> concept.

Yeah, that's roughly the idea; and some prototypes used this idea in
the past - but Markus wanted an explicit, obvious delineation
precisely to *force* documentation authors to think about the split.
It has implications for what gets generated into the documentation and
in which scenarios.

I do usually try to make my upgrades "invisible" to the user, but in
this case I believe we are erring on the side of "explicit is better
than implicit" because of the implications of the text not always
being copied in a precisely straightforward manner to the HTML docs.

I will address the subtleties of this issue when the inliner is being
merged by updating a documentation writer's guide that covers what
goes where and why. For now, we are just trying to do the bulk
conversion.

>
> With regards,
> Daniel

--js

