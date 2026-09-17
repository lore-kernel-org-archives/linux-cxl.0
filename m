Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646973BD65D
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670955; cv=none; b=gcf1hKIrzfJMO7OKaoxWSXxFpXyDu7v2lQyPVoKTe3M0FS69RM7g4T7w1r39l/NKBcxIygvjxZ5kHpN5GIy8c4pM1Qko1uRjFUDzC6lJN8CgsT6o44Tq/aBnUXK2EXrsEVVgq/QT3t7RC8oPmbLXlYaCOrkVD3OVUm6EdwrgeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670955; c=relaxed/simple;
	bh=EIqfHAc8ypVqq40XoSMNnPW7utteaZ6bEnxdM96/stI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYDOAD7hKkjlQvPVER7iWeYdzMVQhGPjDrSyQ8K6blYFgHKrc3DeuHe1zbK6EFM/FxOi43Af8CkKOdZX1pnllMcCXm3ahrajTFxSLXvnT8o4sgw4a8eKO3flEYtkjZ+ssNDAfHjACaTDPaSS8J0g+oetQwCcWMS0E0FmM8d45u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkY/dbza; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkY/dbza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789670952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXKNBaOmNeI3z6HISKxId+ncPTS32v368GzFP7z5VAE=;
	b=OkY/dbzaz/RaWKCtYcAHn8SOfc3JAiNGTCtQ5jfdQchOn4/PYrtJoyEro7p/8C4UKe+epP
	AhuV2fSdDVjChUtyHNeQdSbq77IGbF3u39FuIOf9m4W75EouP6UXq/Wd9DQpaYSOu7cr/q
	3TBgZd23MqlORD/Lc/rhhjb/yiQjKk8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-94xZzxg3MB2Q0GuB_pEvRw-1; Thu,
 17 Sep 2026 14:49:08 -0400
X-MC-Unique: 94xZzxg3MB2Q0GuB_pEvRw-1
X-Mimecast-MFC-AGG-ID: 94xZzxg3MB2Q0GuB_pEvRw_1789670947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9930E195DE73;
	Thu, 17 Sep 2026 18:49:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0808A1800581;
	Thu, 17 Sep 2026 18:49:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9E32C21E6A04; Thu, 17 Sep 2026 20:49:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Jonathan Cameron
 <jic23@kernel.org>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  linux-cxl@vger.kernel.org,
  qemu-block@nongnu.org,  Junjie Cao <junjie.cao@intel.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v4 5/7] qapi/parser: fix intermediate "intro" detection
In-Reply-To: <CAFn=p-YAVahwz2-MmWkwO10RxrDaJDKNp_2-eqEAyzjqbneW3g@mail.gmail.com>
	(John Snow's message of "Thu, 17 Sep 2026 13:57:28 -0400")
References: <20260916135841.3614495-1-jsnow@redhat.com>
	<20260916135841.3614495-6-jsnow@redhat.com>
	<87tsno5ulh.fsf@pond.sub.org>
	<CAFn=p-YAVahwz2-MmWkwO10RxrDaJDKNp_2-eqEAyzjqbneW3g@mail.gmail.com>
Date: Thu, 17 Sep 2026 20:49:02 +0200
Message-ID: <87pkybr9wh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: oynZaLMa5rjhIcmRa-c4b1yAMTImNaYLkSex1xMbvlc_1789670947
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Snow <jsnow@redhat.com> writes:

> On Thu, Sep 17, 2026 at 1:13=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
>> > something after the "introduction" to cope with both the old and new
>> > syntax while we converted QAPI to the new syntax. There's a bug in
>> > that code that only shows up in a handful of cases and only when using
>> > the new syntax while this affordance/flex code is still enabled.
>> >
>> > In the case that we do actually have a real bona-fide intro section,
>> > we want to insert directly after that real-deal intro section, not
>> > after any plaintext sections that may follow it. This code adjusts the
>> > temporary code to strongly prefer inserting after the actual intro
>> > section if it exists.
>> >
>> > Once again: once conversion is done, you will be delighted by how much
>> > of this ugly code goes away.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 9e14c2f7921..6a9a5589c14 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -845,6 +845,14 @@ def _insert_after_intro(
>> >          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` wil=
l
>> >          be sufficient.
>> >          """
>> > +        first =3D self.all_sections[0]
>> > +        if first.text and first.kind =3D=3D QAPIDoc.Kind.INTRO:
>> > +            # First section is introduction and is non-empty: insert =
here.
>> > +            # Rest assured all of this ugliness will very soon go awa=
y.
>> > +            # Pinkie-swear.
>> > +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=
=3DTrue)
>>
>> Isn't this a roundabout way to do
>>
>>                self.all_sections.insert(1, section)
>>
>> ?
>
> Yes O:-)
>
> ... but it's the more semantically abstracted version that does not
> rely on the specific location of the section. By the end of the
> next-next series, all of this goes away anyway. I think I was
> preferring to avoid using insert in more than the two helpers we
> already use it in. (But since I intend to delete it all, I don't
> really care about fighting for purity in isolating this call.)
>
> Specifically:
>
> _insert_near_kind(), _insert_after_intro() both go away.
> append_member_stub() also goes away. ensure_returns() stays but
> becomes something like two lines.
>
> *all* section modification in the next-next series happens exclusively
> through a method named `_append()` which Does The Right Thing In All
> Cases.
>
> --js

What caught my eye was the dissonance between self._insert_near_kind()
above and self.all_sections.insert() below.

Then I looked at ._insert_near_kind().  It inserts before or after the
last section of a certain kind.  Here, it inserts after the last INTRO.
Since we always have exactly INTRO, and it always comes first, it
inserts after the first section.  Just what the comment says.  Good.
But why not just do what the comment says in the most straightforward
way possible?  Am I missing something?  Thus my question.

>>
>> > +            return
>> > +
>> >          index =3D 0
>> >          for index, ref_section in enumerate(self.all_sections):
>> >              if ref_section.kind.name in ("PLAIN", "INTRO"):
>>                    continue
>>                break
>>            else:
>>                index +=3D 1
>>
>>            self.all_sections.insert(index, section)
>>

