Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C34C33D3
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667489; cv=none; b=Z81WOHo1Xhhn9+qRwhfVpGlD1YBjqojZ/Pujv7cwF51sr4bR1S2fX4ely9Js31ssfFbsaaqZpu/e+/glJGLnh3G4JynR6sQC4J/yqg9kY7SF9Kk324Y9yawfV6ps9wWJOqrBRSNUcJrz9TIyMYzZCPND6mVKwBkW4BqeOtmFw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667489; c=relaxed/simple;
	bh=MwK64ShBMZqMvaPp0DEMl9UjPBP1AweoM7qVPbBM2KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+BwAVRgo0fRdpaNknkyBL1eRAHPKO4An5zECZ4lcPylWAbQ220PfCPd0bVUybJicbbHreMs+FliwE0EQ98ijZW87oYGpQYWpmy4agGCSZvOzcFNw+PnMcaELvg4MlVstF8wqrl6n92YHZHzTUx/uK2C91v5YjaBHWRmBkcizJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxbWuNIN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxbWuNIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789667483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
	b=AxbWuNINu/gD8pi4zcqTQnK1PzIPZ0NNkQdY1SozQ7HTB3H3Se3ZENnGX7jRiLIEm52aPD
	mJaTNaxbtvd7W78n3yAuo/BHmJaCD7rcFfBRLdMjMDT9Jhw3fUF3a6fQpyf9eyxn4Ow4aN
	c2x5F7+HeBAIj6U4gD3q5NrN7TI+B2o=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-sqKbW4eaNAmRr-9uC7K0vQ-1; Thu, 17 Sep 2026 13:51:13 -0400
X-MC-Unique: sqKbW4eaNAmRr-9uC7K0vQ-1
X-Mimecast-MFC-AGG-ID: sqKbW4eaNAmRr-9uC7K0vQ_1789667471
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66f78d2f2a0so1514586d50.2
        for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667471; x=1790272271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
        b=PtEMT4u8zpcWDKGRk1DUQq/ZPlTUGoFN0uY1ka+Zjbqnq73IErCe7rRPcKsCsqJ644
         yTueNlewQyTntbuyTo68aNA+Nlkth2ecFiBvSL5GekucT0NiDzy6IhDAnW/oGcHQAWiZ
         zkSVBEdxLyb62r8o6VRH193PlUcZBCuTq/yiXV1A57USUgdVDA1Jvp0hIsA6ZS5ieeaJ
         Tm/Abrwt2LTq8Hlw0IU1aoPG97SkQFm/aK57NIz/nMpLQLl8YDmqyEZd2wVqbpGQTQNy
         LtIjzFQlea+ShYIoY36jeMQoDiZFOl1VTRyoGex4xe74SR+XUaxNYbL66Zbkn3el5fDk
         NzaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy35zkWNMca1TwaEWpg8lFpGFyNgQEi6ahPxX2/UWutdvxVMCrPK7tqr5QXavxBp7yj0DwY+mV4HhY=@vger.kernel.org
X-Gm-Message-State: AFuF++mdTC/ZtR5YdoIpyi7GGfnyWc/xRw3P0mgN8R4bQMi74bG6datF
	401C3ikRf2LHHIChEJveWwphPPVE3en2BPVpt2VIvGBvR8vfOxaGQJMfUzzVqnSqc/xgXsM6zh/
	cd088h7mmtZc8zpkiVKDK7eLjnOk9s8BahW3we9wgAGN2677Rpvt+3Byl58eEaGwhFSL7uCyVln
	viNkny5hg16CxnSq8FEkr0NCO9lEkIBpMDPiT+
X-Gm-Gg: AYBFou1ulOgFrWjJD85lEItM9gkL4CxXqGtgGed17kNVvfhAwZ0KzONnuU1w48NnZtK
	RaRbZ7MTFq2kV+h4t3pMMjXm6wPAVbY+i2u22A7/ZRuDyKib3uAyOaddkbEYCeDw22Ug0zvf18R
	ERueEYdFh7F+Kt/njKxgXPlGtee6r+nBHn9wtdICJk8aHmo3hiXOnOEghmPKV3+tfMLd6/DDKuk
	+HF6cQaxgcJIPxo
X-Received: by 2002:a05:690e:450b:10b0:66c:486c:aa1b with SMTP id 956f58d0204a3-671631f05acmr1743274d50.38.1789667470752;
        Thu, 17 Sep 2026 10:51:10 -0700 (PDT)
X-Received: by 2002:a05:690e:450b:10b0:66c:486c:aa1b with SMTP id
 956f58d0204a3-671631f05acmr1743251d50.38.1789667470302; Thu, 17 Sep 2026
 10:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916135841.3614495-1-jsnow@redhat.com> <20260916135841.3614495-8-jsnow@redhat.com>
 <877bkl6p5s.fsf@pond.sub.org>
In-Reply-To: <877bkl6p5s.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 13:50:59 -0400
X-Gm-Features: AcwNN1X3Ijah7JnB4DXCnn25H-wDvOuxeeEXSvmMKd70__JU6VQ57kzsptrcuPY
Message-ID: <CAFn=p-YbywppYTRUj9K9ncrue8b9NTgqXtcjWzMYiiJwTgYCpA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] qapi: convert intro sections followed by notes/examples
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
X-Mimecast-MFC-PROC-ID: -sBtNCk-Pa9zDot8Lrz_yNJxqwPvwvxpxXDA3ghwW2w_1789667471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:13=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > These provide a rather natural cutoff point, but technically this does
> > introduce a new intro/details split to these documentation blocks.
>
> Not sure what you mean by "technically".

As a German, when an American says "technically", you can just omit
that word from the sentence.
I think, translating for you: "I don't expect these changes to have
any immediate effect, but it's possible they might".
You found the case where they might - a case where we probably
actually did want a "TODO:" but never added it.

>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine.json   |  5 ++---
> >  qapi/migration.json | 15 +++++++--------
> >  qapi/misc.json      |  3 +--
> >  qapi/run-state.json |  7 +++----
> >  4 files changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 84d95c8d87f..276258d9e5c 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1209,9 +1209,8 @@
> >
> >  ##
> >  # @HV_BALLOON_STATUS_REPORT:
> > -#
> > -# Emitted when the hv-balloon driver receives a "STATUS" message from
> > -# the guest.
> > +#     Emitted when the hv-balloon driver receives a "STATUS" message
> > +#     from the guest.
> >  #
> >  # .. note:: This event is rate-limited.
> >  #
>    # Since: 8.2
>
> The patch splits the first section between after the first paragraph,
> i.e. before the note.
>
> This matters, because we insert generated argument documentation after
> the first section.  Rendered documentation changes like this
>
>     Emitted when the hv-balloon driver receives a "STATUS" message from
>     the guest.
>
> +   Members:
> +      * The members of "HvBalloonInfo".
> +
>     Note:
>
>       This event is rate-limited.
>
> -   Members:
> -      * The members of "HvBalloonInfo".
> -
>     Example::
>
>        <- { "event": "HV_BALLOON_STATUS_REPORT",
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index d571c06fc20..a272e701385 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1254,10 +1254,10 @@
> >
> >  ##
> >  # @migrate_cancel:
> > -#
> > -# Cancel the currently executing migration process.  Allows a new
> > -# migration to be started right after.  When postcopy-ram is in use,
> > -# cancelling is not allowed after the postcopy phase has started.
> > +#     Cancel the currently executing migration process.  Allows a new
> > +#     migration to be started right after.  When postcopy-ram is in
> > +#     use, cancelling is not allowed after the postcopy phase has
> > +#     started.
> >  #
> >  # .. note:: This command succeeds even if there is no migration
> >  #    process running.
>
> Similar split, but rendered documentation doesn't change, because
> nothing gets inserted.
>
> Same for the remaining hunks.
>
> Should the one hunk that changes rendered documentation be in the "qapi:
> convert/split remaining QAPI/QMP intro sections" series?

If you should so please. I was splitting by semantics and not effect,
but I can split this one out for you.

>
> [...]
>

