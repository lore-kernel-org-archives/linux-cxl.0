Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A73C8C46
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321876; cv=pass; b=SSyvkVsPxYp0BEiSw2tISxxkmnB4B5dR06cpbSClIgv8I7M2HiCCceoC0RNHo+KUmKJ5ZClYTD07OwW89e6rihkmSDBQ1gIEGAEwIkn28oReWXPNYv1DjBgz/pzIU7F51coxw5oda5fZWSnsOB08C+qkIs2e9wbGjyY2mKii0Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321876; c=relaxed/simple;
	bh=j1Wh4CfTGvYBOyAROOZOXrtCRg+GLe0bKN/CGF567eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/uUvt9Gj4SteP2ng4RUjfGTh8qWkH1HJPC+Uqws9LHsfOqiEMPt4gQe3Yj3eaCke79V7w8JtKsZHhx5WA9uCnKckvmFbrw/O8x8UYjraEJZnJy9VrOsV/sAGmmbFgYlL1QdHWqUAjcSjin8VW0jNTPqyoTGpdMfAPNTq4gXNUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkA1ehXm; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkA1ehXm"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1799546a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 14:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791321874; cv=none;
        d=google.com; s=arc-20260327;
        b=Lyo8DUNZjhPuBvxr8mgSOOR4+G4gxpJq3ALk+5bjsQG0bX/s/JLAA1dUjOaMHX1wHW
         aWyC/R3Cy2tIKnGoJa7pjUvL3Mv/mkT2DaSx4gaiT4eZM0jdoIIqqfqQbgkIS/kBrU9Q
         lBgJ1nUm8ip0SH3UYeY7G8zzE0odVvz54qWfub4dEeX89m78HwBz6PIqjBgqiaAZbFQf
         k1/TYa0hQKcuNF3wBku9bJ/XiAPAarO5U2+7vpkbrzQKA05oMisFXqP6YKQ6g8FhqyqX
         c+66Dd33fAkzBpksnOiq3cQKNaVB7/jR2M4f4RfSBJdTj1DqOK9m1h01u2q+tdukZ7vo
         4IXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SYwc8JI6t2v5/H4JTTRJtWLrWEc8ZG38ZE/5tQf+csw=;
        fh=1iN4snIPNPNuV7s5RefEW8B72qjbk0a68b2xdfkV0WI=;
        b=GynoNfUCvO043yKT3jLlJini+6mwY4x1tEx+7q2neA5VD0LpWGHTjeiyP7jfocoJ0H
         jIqumvnZUPl04HSTqiNFm32+syXypyk3BxBRMPE8x5/DMRhQRW412TUCdl6reXVyhuB+
         sJPGAPtCPm+lknm6B7OH6fII7dqF86pDltbQI/OoAPR2a5Zyd0l31WTHecrq+EMzFh9y
         FDHgZyf7fK6j6s1Pcle5wsOUu0MWYUnmEYK0n2UGsmuIfINtejfpRli7dBtgohmgwRKe
         4p769TOUHVN1LaQosz1A0K5Q5jg6me8Eu9UnkPQJFQyPsnm+T7/VWo+3mbQ8IxMP3had
         0Z/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791321874; x=1791926674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SYwc8JI6t2v5/H4JTTRJtWLrWEc8ZG38ZE/5tQf+csw=;
        b=CkA1ehXmjauNAj0rvOeskxpTLPjL2ItGZqCg9fvqEAr3OnguGc0A+1UHoi8mfngl5S
         8GRlLNhthsMFYdf3znvA4fLU0J7R8o6hr/mvcAMHbk0RTd9e4yJOCPxPrD51VqtNPNiL
         O3Md2I8h0YI5bfFp2TuJO43VEO6JNs60zImfBgb2isb4YekMYvT4T7bDxpBKbQhSCdQK
         dYcStyGLZ6jHmO7+3wjowyDNIyCRcAAQ1fWa/nZzYeVRp72aIQoCylEOLk2GnzPuMWSV
         to9Ap73PpV+9H4k9RRjYwiGNrUsLw+XNTYwmDmSo5Jly5WHEv8wYxukzcboYG+Bcldw6
         e11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791321874; x=1791926674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYwc8JI6t2v5/H4JTTRJtWLrWEc8ZG38ZE/5tQf+csw=;
        b=qx2o6j9Tzn4wCx0DTaNjQU99ga8UkzK2Gor47b/tn1+fLq73akXQjVzvMv3tSzwulf
         H19X4YLlHPqUYxfIx0yAkR4di7MLh81qS4npBj54Atv6liQF0hxHHTzkczWJSnnhe7Y6
         buIh3bykHv9fy2ArstZKUH5FDNkGTQRB45wwTC7eCS7UC3d4pPqY2PEHld52VpXX6X7v
         iJI1P371LZDHGOfoTxmvIAt8j5KNNoQhyziUpVEsP8GQFSZ+IPuVOPc7M1a7R5mGCel+
         4kti398HKwH6bxm8gkTeUqY+MiZnAPw718FsaMYsbioTeKFwif3jsaI7HzQhTZXgYA+J
         KFOg==
X-Forwarded-Encrypted: i=1; AKwUvBwcrdSkMogyzTQXHe2rdJCI6n7EF+HrjRNSJdinjH4TSHy0j1G2fZYqsdAHgUcFGsHVs8S165QzPRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0I2EvdM7qpvBx8owu3pubV9oJi41gRXhgdLimKNHCsh2pcZH6
	ZGWw6E1YPgJspMoOYYAeydKKYSJoWg7zW4SqtcK5OlGKGgp2p/XWPRJ3cXT960n2F3YAiTo2Ays
	3Z6iq3gENMuFLfAKqbFeQ0PqoCP7ydPM=
X-Gm-Gg: AYBFou3S+jmvSmHCkwxm6boAvV7na4vFSd2cR8PEd8gf7Nl3BwuAHXh9F4yxHXPfU0X
	b5NDKr0UDiFA6cUgv0UilfujKkb8OGrHikJio2jW0vZCR3mf7Hi1VHW3Dv2UU7b0n4HaW3ycowD
	gk7QTrYwo78vqmUt6SmmMGQVF1rwDXU+7/LUT8GIvRXmE983+gg/cb/HT683KnsZ3W1JMTSVSBY
	SxJbQTTMbexV0Q1ygMgRwaA34VpNL0eIZTI32SNZ1iU4Z9kpUl+gX6PqkK9fW5Yf1i1r/lQ4TRo
	1hMBjomvqZTQIqMKxPxluyJ6mAwKbPWwCTMLrRpThlzXz/iCfvxHidPhzqUG4jeke61I06SqIPX
	90mdGFRcF0II=
X-Received: by 2002:a05:6402:21d7:b0:6ab:7700:9371 with SMTP id
 4fb4d7f45d1cf-6aff47b52d7mr243717a12.25.1791321873525; Tue, 06 Oct 2026
 14:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-4-mszeredi@redhat.com>
 <CAOQ4uxjWCRs59Qpc4t+2=i67rdJkHt=+rH07ZXv7ZzAvTjTm-A@mail.gmail.com>
 <CAOQ4uxi1+WgHJdnRKMD3tp24EOyx7iPByzSKLn_siTVY3_sRDQ@mail.gmail.com> <CAJfpegttAHQAGhE61t-VZqfQv9Z==ovbyLY6qp3KOK_CvjBciA@mail.gmail.com>
In-Reply-To: <CAJfpegttAHQAGhE61t-VZqfQv9Z==ovbyLY6qp3KOK_CvjBciA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Oct 2026 23:24:17 +0200
X-Gm-Features: AclHuK_VeO0DSevIgJfwzhinVGoS4FTfS8bmWH03wQQ5EUrXtEm_7IyCpO31gUM
Message-ID: <CAOQ4uxj76PJiumvXLHoJUKx_=FAueg3WQjYd64=B_TXo581POg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fuse: support 64 bit, server allocated backing ID
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:33=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:

> > > It would feel a little less hacky if we do:
> > >     else
> > >           fuse_backing_files_init_32(fc);
> > >
> > > and set
> > >          fc->passthrough =3D 1;
> > >
> > > inside both of them to gate against fuse_backing_files_free()
> > > called without processing init response,
> > > or without either FUSE_PASSTHROUGH in the init response.
>
> Bigger problem is that IOC_BACKING_OPEN can be done before or during
> INIT.  So we need to take care of that case and the race as well.
> Fixed by:
>
>  - leaving the idr initialization fuse_conn_init()
>
>  - adding fc->backing_id_32 flag which is set by fuse_backing_open()
> after chekcking that fc->backing_id_64 is not set.  All under fc->lock
>
>  - in process_init_reply() checking fc->backing_id_32 before setting
> fc->backing_id_64 and failing the connection if so.  Also under
> fc->lock
>
>  - in fuse_dev_ioctl_backing_create() if fch->initialized is not set
> return ENOTCONN
>

I guess that works, but why the asymmetry between the two modes?

We could check fch->initialized in both _open() and _create()
and then no need for the backing_id_32 flag?

Unless we gate _open() with fch->initialized, then it could fail on
either one of these cases:

                if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
                        return -EPERM;

                if (inode->i_sb->s_stack_depth >=3D fc->max_stack_depth)
                        return -ELOOP;

Quite randomly.

Maybe I am missing something.

Thanks,
Amir.
