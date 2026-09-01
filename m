Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69E3AB294
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257417; cv=none; b=UJ8Jhr9OBTOkssswPm8iOqavMY+BzD/ttYHhy/8c7KrHK1gMsSmhAp3YwJZBkAP2LbDW0kTbsNgqacLvpwrvwMzMU//3mDkcoW8AfXbmYwhN9rQvTQBMEC9MirljE9iwVK79HKcQrCR0UsfvuOxqZsOiQlYewbmkQQaJwex3w/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257417; c=relaxed/simple;
	bh=CwDwVq3w0/m/8eg7WqkDGxHgvN6b0hQiKdHYxQ8pKB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDxVFq5cD7NsUShETNw/MIbm6oDlHWcCLy1NbyluyTD31chPRmXYTFIEjTE/r3BUxo7JJpCoqewxtazFcPFOaJ5UcYrLanz/ZLTue79yuEJxOzQONebaF1WY7R/dApgd1BdNtsdq1gjYfe7iUmpclpewnnDck1GRN9xNy1EDR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDTP3RUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDTP3RUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YA3bf0Xqyq5RboFUYGW78ZpCMr7c/BXnEsTq1ErGWE=;
	b=CDTP3RUQ0j7P/YFc6Dnqej9dR4I3bHOAvx4/YKuutGLlaxbHNlCL+2T38/FwmxQDiP9gEn
	TJ3i6peiRJOc6IvDsn/KfV5ECAb9wBbigUSwvRfaWiLJaNT3yTyvkMQ4M14a30RE6lF/rx
	+eIgZ4IFpsktrxyKRTFMJnzLPeX4NM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-BYg3Qom6PmK40zQ_sfArqw-1; Tue,
 01 Sept 2026 06:10:11 -0400
X-MC-Unique: BYg3Qom6PmK40zQ_sfArqw-1
X-Mimecast-MFC-AGG-ID: BYg3Qom6PmK40zQ_sfArqw_1788257408
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EAFA1831343;
	Tue,  1 Sep 2026 10:10:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B489F30002F5;
	Tue,  1 Sep 2026 10:10:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B0E8221E682B; Tue, 01 Sep 2026 12:09:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
  qemu-devel@nongnu.org,  Alex
 Williamson <alex@shazbot.org>,  linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
  qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>,
  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
In-Reply-To: <CAFn=p-bUTApw73Ddz-tH1FzY97Ct5rfFZ=domFhm-OO3G8COug@mail.gmail.com>
	(John Snow's message of "Mon, 31 Aug 2026 14:43:50 -0400")
References: <20260826193840.2152000-1-jsnow@redhat.com>
	<20260826193840.2152000-2-jsnow@redhat.com>
	<ao_-_38raHK0rWkX@redhat.com> <87jypb90c0.fsf@pond.sub.org>
	<apA-CzGqrlFNfjp5@redhat.com>
	<CAFn=p-bUTApw73Ddz-tH1FzY97Ct5rfFZ=domFhm-OO3G8COug@mail.gmail.com>
Date: Tue, 01 Sep 2026 12:09:59 +0200
Message-ID: <87a4q19tag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: WlMR7QVnWhTM9GChoIkw8LrKF4sMf7qNzjhg1-AKwu4_1788257408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Thu, Aug 27, 2026 at 9:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>>
>> On Thu, Aug 27, 2026 at 03:09:35PM +0200, Markus Armbruster wrote:
>> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >
>> > > On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
>> > >> Signed-off-by: John Snow <jsnow@redhat.com>
>> > >> ---
>> > >>  qapi/error.json | 3 +--
>> > >>  1 file changed, 1 insertion(+), 2 deletions(-)
>> > >>
>> > >> diff --git a/qapi/error.json b/qapi/error.json
>> > >> index 54cb02fb880..a53b13e55c9 100644
>> > >> --- a/qapi/error.json
>> > >> +++ b/qapi/error.json
>> > >> @@ -9,8 +9,7 @@
>> > >>
>> > >>  ##
>> > >>  # @QapiErrorClass:
>> > >> -#
>> > >> -# QEMU error classes
>> > >> +#     QEMU error classes
>> > >
>> > > Where is this need for indent coming from ?  From the POV of someone
>> > > writing comments, the need to indent the introductory text like this
>> > > feels very counter-intuitive, an exception from any other inline
>> > > docs syntax I've typically used. Is there any way we can avoid this =
?
>> >
>> > The cover letter explains the need:
>>
>> Yes, I just didn't see the connection from that, to the use
>> of indent.

Writing good cover letters is hard.

>> >
>> >     This is being done primarily for the benefit of the forthcoming
>> >     "inliner", a feature for the rendered HTML QMP documentation that
>> >     seeks to "inline" QMP command argument documentation into the argu=
ment
>> >     list for each command.
>> >
>> >     There are two main motives here:
>> >
>> >     (1) We want the split between the "introduction" and "details"
>> >         sections to be mechanically obvious, so that auto-generated or
>> >         inlined documentation has a well-defined, obvious spot to go.
>> >
>> >     (2) We do not want to inline irrelevant, introductory text describ=
ing
>> >         structures to be copied into command documentation.
>>
>> So IIUC, you're saying that we are going to rely on indentation
>> to distinguish introduction from details ?

Yes.

We are already relying on indentation elsewhere.  For instance:

    # @fatal: if set, the image is marked corrupt and therefore unusable
    #     after this event and must be repaired (Since 2.2; before, every
    #     `BLOCK_IMAGE_CORRUPTED` event was fatal)
    #
    # .. note:: If action is "stop", a `STOP` event will eventually follow
    #    the `BLOCK_IO_ERROR` event.

The description of @fatal is indented.  A non-indented line ends it.
The non-indented line happens to be a Sphinx directive here, but that's
immaterial (the QAPI doc comment parser does not attempt to parse ReST).

>> > Note that the inliner elided Netdev's Intro "Captures the configuratio=
n
>> > of a network device."
>> >
>> > However, when Intro and Details bleed together, the inliner elides mor=
e
>> > than it should.  I consider that a fairly serious issue.
>> >
>> > I'm afraid forgetting to mark the end of Intro with "Details:" would b=
e
>> > a common mistake, easy to miss in review.  So I explored possible
>> > alternatives:
>> >
>> >     Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
>> >     Date: Wed, 15 Apr 2026 11:43:45 +0200
>> >     Message-ID: <87zf341ru6.fsf@pond.sub.org>
>> >     https://lore.kernel.org/qemu-devel/87zf341ru6.fsf@pond.sub.org/
>> >
>> > John is working towards "3. Make the end of intro syntactically obviou=
s"
>> > always, specifically "3c. Indent intro like descriptions and tagged
>> > sections" with the ultimate goal to reject unindented Intro.  That way=
,
>> > we cannot write an Intro with an unclear end.  John, correct me if I'm
>> > accidentally misrepresenting your work.
>> >
>> > Questions?  Better ideas?
>>
>> As an author, how substantive is "Intro" expected to be? I guess on
>> QAPI docs I've written I've not ever been aware of there even being
>> a distinct concept of Intro vs Details to think about. It is all just
>> some lines of prose to me.

That's deceptive :)

Consider

    ##
    # @HV_BALLOON_STATUS_REPORT:
    #
    # Emitted when the hv-balloon driver receives a "STATUS" message from
    # the guest.
    #
    # .. note:: This event is rate-limited.
    #
    # Since: 8.2
    #
    # .. qmp-example::
    #
    #     <- { "event": "HV_BALLOON_STATUS_REPORT",
    #          "data": { "committed": 816640000, "available": 3333054464 },
    #          "timestamp": { "seconds": 1600295492, "microseconds": 661044=
 } }
    ##
    { 'event': 'HV_BALLOON_STATUS_REPORT',
      'data': 'HvBalloonInfo' }

Rendered documentation looks like

    Event HV_BALLOON_STATUS_REPORT (Since: 8.2)

       Emitted when the hv-balloon driver receives a "STATUS" message from
       the guest.

       Note:

         This event is rate-limited.

       Members:
          * The members of "HvBalloonInfo".

       Example::

          <- { "event": "HV_BALLOON_STATUS_REPORT",
               "data": { "committed": 816640000, "available": 3333054464 },
               "timestamp": { "seconds": 1600295492, "microseconds": 661044=
 } }

Where does "Members:" come from?  Its generated.

If we move "Since:" to the end of the doc comment, we instead get

    Event HV_BALLOON_STATUS_REPORT (Since: 8.2)

       Emitted when the hv-balloon driver receives a "STATUS" message from
       the guest.

       Note:

         This event is rate-limited.

       Example::

          <- { "event": "HV_BALLOON_STATUS_REPORT",
               "data": { "committed": 816640000, "available": 3333054464 },
               "timestamp": { "seconds": 1600295492, "microseconds": 661044=
 } }

       Members:
          * The members of "HvBalloonInfo".

This one is clearly bad.  The fact that an innocent move of "Since:" can
make the rendered docs worse is a defect in the QAPI doc system.

But even the first version isn't quite what we want.  We want Members:
further up, like this:

    Event HV_BALLOON_STATUS_REPORT (Since: 8.2)

       Emitted when the hv-balloon driver receives a "STATUS" message from
       the guest.

       Members:
          * The members of "HvBalloonInfo".

       Note:

         This event is rate-limited.

       Example::

          <- { "event": "HV_BALLOON_STATUS_REPORT",
               "data": { "committed": 816640000, "available": 3333054464 },
               "timestamp": { "seconds": 1600295492, "microseconds": 661044=
 } }

Now we're ready to discuss "intro" vs. "details.  Their separation
matters in this example, because the generated "Members:" go right after
"intro".

The root of the problem is a syntactic ambiguity.  "Intro" is commonly
followed by some "@argument: ...", "Return:", "Error:", or similar.  But
these are all optional.  When they're absent, the what's "intro" and
what's "details" is syntactically ambiguous.

The doc comment I used as example abuses "Since:" to separate them.

> In most cases, not very substantial. For commands and events, it *can*
> be quite a bit more substantial. For structs, enums, etc it is almost
> always laughably trivial.
>
> When the syntactical delineation of intro is complete, further QAPI
> parser changes will make it even more obvious: any free text that
> exists between the intro and the other sections will be flagged as an
> error, where you will be urged to move any detail text to below the
> metadata fields. This physical relocation will help suggest to the
> documentation author what goes "above the fold" and what goes "below
> the fold", so to speak.

This is part of our slow move towards a standard doc comment structure,
ultimately enforced by the generator.  Standard structure helps readers.

>> My only alternative idea to indentation would be to declare that the
>> "Intro" is always the 1st paragraph of text and anything beyond that
>> is the "Details". That might match up with the way that contributors
>> naturally write text where the 1st paragraph conveys the key idea,
>> such that they dno't need to think about Intro vs Details as a
>> concept.
>
> Yeah, that's roughly the idea; and some prototypes used this idea in
> the past - but Markus wanted an explicit, obvious delineation
> precisely to *force* documentation authors to think about the split.
> It has implications for what gets generated into the documentation and
> in which scenarios.

"First paragraph is intro" is workable syntax.  It restricts "intro" to
a single paragraph", which is unlikely to be a serious problem.
However, the restriction is easy to forget.  If you write two paragraphs
(because "it is all just some lines of prose"), the rendering can
surprise you, in a bad way.

Having to indent "intro" forces you to be explicit, and avoids
surprises.

> I do usually try to make my upgrades "invisible" to the user, but in
> this case I believe we are erring on the side of "explicit is better
> than implicit" because of the implications of the text not always
> being copied in a precisely straightforward manner to the HTML docs.

Blame it on me: I pushed John towards explicit.

> I will address the subtleties of this issue when the inliner is being
> merged by updating a documentation writer's guide that covers what
> goes where and why. For now, we are just trying to do the bulk
> conversion.
>
>>
>> With regards,
>> Daniel
>
> --js

