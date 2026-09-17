Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7083B14A2
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667865; cv=none; b=aY2t5Rgj8k3RZEvryWuz8Z5ID7y+LGyYL0Fyy7moLZcqXoCI+JII7B4wBSBBE+jmRYT1bWgI2G6gVPih5VmA+e80cauVbjqw4kyBg0G4O9/2yfauG19oy81m66FDVWvHmkRyXJVDdhxBUdrc2zPjXzKN7wKAYoDPP6Yh7gQg+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667865; c=relaxed/simple;
	bh=75DArpsWugOX0nFtwfox4Mr5q2+Bi+DHj7YsWQLBZ7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSmsO5+4uzVEYibRRpsUmbqV4fZfYUH8LjUOMMHZvYmq5tsem0Mqu0NiyMP4GuiVpP+ipofw95Y5aOdP2Km9gwJRvyWnJz93zvY2Ssaq/49uxNcRvzU/UW6K2FpXChPwiPq73OYBkXRiGW9lZrz8bm/7jhY8FGkZnL4gQUSUSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBp79/DY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBp79/DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789667862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
	b=TBp79/DY7GPZzPdZXcbASS8gYFr+OY5FZqk6Ks9UQSbBd79+wFBTx/uS98VTVVdZrd3vN3
	j+77puUunqBCl94q8KprWL3Yw6/bay6VZMimZ3AftE7crbAzQDCW073Jf4WYh5cBfv4MXW
	kwklA1FpIzu+U8tVeq+lbGS9ERv+618=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205--ifCxZg5PdKW3yxXAakAAQ-1; Thu, 17 Sep 2026 13:57:41 -0400
X-MC-Unique: -ifCxZg5PdKW3yxXAakAAQ-1
X-Mimecast-MFC-AGG-ID: -ifCxZg5PdKW3yxXAakAAQ_1789667860
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66fb71198e9so1019383d50.0
        for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 10:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667860; x=1790272660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
        b=1aSZ/s/QHZYq5dtfx2qY0+YMZ7ON0yW0q0QlHC32VacqSIkesJBeAG55WpLIv1f9D6
         W+Btx6zFXPgYJS6beAp0Vff1HYAXdRNE96/SGegSgKyBrEjv9arKZvJJ/J6BMY1wUxbl
         ACnIABrKyL2K908hoJ4Dx5UPs2/m9klY1PFdXqlvjJWcBOHEsFI3OkOOkpAlysNfqUuf
         XQBIh3bjjdtll0bQHuWGIN1nj74aFZrHLjHUSM7Ltlfa71rG4WN6TN/nJkRdoOsH13DC
         /ZmoPAdhbnfgtU3ZibFz3PBH0UOAqNOz5kbdRGYz4LJIgZPqgYZxPY7KBrnJ1vIHn1B9
         QGzA==
X-Forwarded-Encrypted: i=1; AKwUvBy9vMxWl5qljACoF+UrMLZy8NT5Lv0aACFbp01KD27Li99ooW3YUWRxXNelOUtnhyphCmAFO68aJW0=@vger.kernel.org
X-Gm-Message-State: AFuF++n9AA9+TXvlwm/fgrNf8/zw3kEesgnbq8pifdLsuVZG02r+uggc
	H6X83rn6OsBpWdk2QT3iFDtUXJ4ZmfIkUChIrNshxYvKLqjlIKzCFqGOFw/jTw8dBRUcyJ4LZvQ
	ibEhZTzVcfbvkHjI1hvGdV/mY7s9l22Mgboc1pejsA5xp9LBXSRXUWZh1iBoBzaz5WpVZL25iOb
	uCOYo/2sBkSfkuIRYOk/MAFt71hA5BHkEp/KcC
X-Gm-Gg: AYBFou25Q0fvrVKFMBq488Vps7PTIzK0BwgCK76xav+7utt83gHeCoseW+nt7flJXsa
	m2WF7wOnerIE6Wco7/Xv6jMQYUF3r2ewsDCIhtnc7+d0n0YQMa9nu8PKd7QdzdsQQEkodMLD1SW
	LHRJh5Fz8xb0wLXc74rtEoMMBsHo/eY0iDJxcDTNZb9TiL7DMkb1tduM1ahDidV4JcdPP5GLwF4
	2cgJBbM8Apdznpu
X-Received: by 2002:a05:690e:120c:b0:66a:b15e:bb93 with SMTP id 956f58d0204a3-6717034c5afmr1189628d50.13.1789667860165;
        Thu, 17 Sep 2026 10:57:40 -0700 (PDT)
X-Received: by 2002:a05:690e:120c:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-6717034c5afmr1189605d50.13.1789667859750; Thu, 17 Sep 2026
 10:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916135841.3614495-1-jsnow@redhat.com> <20260916135841.3614495-6-jsnow@redhat.com>
 <87tsno5ulh.fsf@pond.sub.org>
In-Reply-To: <87tsno5ulh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 13:57:28 -0400
X-Gm-Features: AcwNN1XG52uuiUnWNJlaDC6V1kzKVkLG2iXP2kRaAwxcqV_ifQ48YVjOovC8RbY
Message-ID: <CAFn=p-YAVahwz2-MmWkwO10RxrDaJDKNp_2-eqEAyzjqbneW3g@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] qapi/parser: fix intermediate "intro" detection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
	Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	Jonathan Cameron <jic23@kernel.org>, Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
	Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>, linux-cxl@vger.kernel.org, 
	qemu-block@nongnu.org, Junjie Cao <junjie.cao@intel.com>, 
	Lukas Straub <lukasstraub2@web.de>, Hanna Reitz <hreitz@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RFmGTX_7HTXafNhf_OVDWj-M5TaI91rq9nMJAf1mFgQ_1789667860
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:13=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
> > something after the "introduction" to cope with both the old and new
> > syntax while we converted QAPI to the new syntax. There's a bug in
> > that code that only shows up in a handful of cases and only when using
> > the new syntax while this affordance/flex code is still enabled.
> >
> > In the case that we do actually have a real bona-fide intro section,
> > we want to insert directly after that real-deal intro section, not
> > after any plaintext sections that may follow it. This code adjusts the
> > temporary code to strongly prefer inserting after the actual intro
> > section if it exists.
> >
> > Once again: once conversion is done, you will be delighted by how much
> > of this ugly code goes away.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 9e14c2f7921..6a9a5589c14 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -845,6 +845,14 @@ def _insert_after_intro(
> >          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
> >          be sufficient.
> >          """
> > +        first =3D self.all_sections[0]
> > +        if first.text and first.kind =3D=3D QAPIDoc.Kind.INTRO:
> > +            # First section is introduction and is non-empty: insert h=
ere.
> > +            # Rest assured all of this ugliness will very soon go away=
.
> > +            # Pinkie-swear.
> > +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=
=3DTrue)
>
> Isn't this a roundabout way to do
>
>                self.all_sections.insert(1, section)
>
> ?

Yes O:-)

... but it's the more semantically abstracted version that does not
rely on the specific location of the section. By the end of the
next-next series, all of this goes away anyway. I think I was
preferring to avoid using insert in more than the two helpers we
already use it in. (But since I intend to delete it all, I don't
really care about fighting for purity in isolating this call.)

Specifically:

_insert_near_kind(), _insert_after_intro() both go away.
append_member_stub() also goes away. ensure_returns() stays but
becomes something like two lines.

*all* section modification in the next-next series happens exclusively
through a method named `_append()` which Does The Right Thing In All
Cases.

--js

>
> > +            return
> > +
> >          index =3D 0
> >          for index, ref_section in enumerate(self.all_sections):
> >              if ref_section.kind.name in ("PLAIN", "INTRO"):
>                    continue
>                break
>            else:
>                index +=3D 1
>
>            self.all_sections.insert(index, section)
>

