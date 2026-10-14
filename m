Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AC2EEE75
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970659; cv=none; b=YdHDwsznZBAlW9CaJ/T+IUz6w0qheqOHzz+Hv7XtZxFgpQ80PQJiI61JuLMgx+pcPzuwVt7ATLyJUi/3cTN4g7zgV9YcujLe651jpqrgqBEzXz3oM3B3tBLXz3iDlt5D48wv/sjAEvu/R7dtIGYzkm1NnXO+0jFe7HRHiNFfGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970659; c=relaxed/simple;
	bh=2JqF29mdIDBiDoEAPp3FTW8LA4BFk/t8vIBM6YPijak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqsHLHrm2guoZpUxI8gNfOFZu35gIDBorZuRwqzGwhyCqX5H3YZ/8mprX84lLr70E14Ey95I6HiB5cLueVzDj4Agn9Dy0A+efYZVEVgKn8DjyVlBA+mQ0ocSAu/Qxk1aZDfsxBR8v642AaY8JlKIUYJZWN7a19gPvRBGAOdAFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPhw/0am; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPhw/0am"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791970657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZHWlhTDhL5WqiNRs5JbrYvHrkANNCynzraFMjRCOYs=;
	b=bPhw/0amEEw+E/S+XSDUL5sTA/02SwYMJxOzHPWE2KdMrjZIFSxGPuJmF3P6zgG3yVh9EN
	w6fiP2Bj9zpRlKVpbvF4S5n0SLnf/0OUMHhWvFdy7DVdcNpgjSA0lmDWoIybrP38cUEzSW
	cdXG2oOMTotYGx9kqfD5f98LUJ4YC3Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-lxPeYbNOMma9p_hq0cwlpg-1; Wed, 14 Oct 2026 09:37:34 +0000
X-MC-Unique: lxPeYbNOMma9p_hq0cwlpg-1
X-Mimecast-MFC-AGG-ID: lxPeYbNOMma9p_hq0cwlpg_1791970653
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0c6e7151cso5839247b3.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 02:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970653; x=1792575453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZHWlhTDhL5WqiNRs5JbrYvHrkANNCynzraFMjRCOYs=;
        b=i7bO51CVdATcGORrYcluTKml5G7K9WZOK2x0vRgb7fbuDc+TYPXRXyJ9wvNn1FaJI6
         J7ReyaoqzL30siaR3xc4FGbAnWUhKF2nJaH/J7/CgGbtWjBmKM+SDQs2+CpbD/YYSDgM
         EEzEwQgDi2aqmy6KA2UsSY5yGl138fr6jejZohQ5pJ2j8nMBDCC16GMAB5CoIDcfCb/5
         DslQWPq4JnwKQXK6HoJuA7iuAsR3FR4c3qI1pn3w/VieeD7Bp0K1yvqQMf12O2YLtByU
         B7BGuIA6sKh9pbSvUcXvOtk7+5AZaI0iABrBKEQw4d9U5nQHJMW84dl9T1j8/6PZ8Et1
         AEFg==
X-Forwarded-Encrypted: i=1; AKwUvBzePDb46dxV1mv9wJTPFyhxvPHj9rsbZqRPdfXfwO8Dvl9DkLPI8p6SUQavTI6hf2oPN7cm6Jhri6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3qop7cFrKSrbI00V5krPwMza10cHb3dOA3Rj16JaZGnFfMXcl
	CYyKIFn+H9zRuqHwjX1Z0349nqLwD9DR0eoxfu4E6J6Qlr/Ynr/ZQUyfFKiSRgFg4QCvUyBz9oN
	oU60GyBQCinx8eZmZ5/auHKvsYYlXJ5KMHa7QnjZSTq7g101rKQZ2zpZITzNdt3XHUZUSy2SgjO
	O2eaXGxRYouCDQWCOSa6dGwQbRmKGxL7ZZ07yC
X-Gm-Gg: AYBFou3CD2DUQafQvvZ71v+Vu+rxTBRWZ3g0bsyIXfXdDi9hut/FdCWgEZ+7WFIOBiI
	PAxSRNr/TMxiw1O9VHDrzXaaH1nNX9LCeEIs5FRW2vPI2KGgCfxpsEgrgwNA0TD2dddtOTVhyWf
	DKZ5rP8Z0wY7PbGzL0pVX0W74dauclq6kPyoyoSTn4QwvT+PRcX//4
X-Received: by 2002:a05:690e:bcb:b0:679:8e30:440e with SMTP id 956f58d0204a3-6798e304456mr345326d50.158.1791970653460;
        Wed, 14 Oct 2026 02:37:33 -0700 (PDT)
X-Received: by 2002:a05:690e:bcb:b0:679:8e30:440e with SMTP id
 956f58d0204a3-6798e304456mr345307d50.158.1791970652857; Wed, 14 Oct 2026
 02:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008112004.1899560-1-mszeredi@redhat.com> <20261008112004.1899560-9-mszeredi@redhat.com>
 <sashiko-outbox-164097@kernel.org>
In-Reply-To: <sashiko-outbox-164097@kernel.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 14 Oct 2026 11:37:22 +0200
X-Gm-Features: AclHuK9oudbuDKSUqa_bJ75j7x9Hwi3mgbzizDj7pqL1HcfMX3cGRTRtlrqqQvI
Message-ID: <CAOssrKd-ACNEo8uOddmyCaGBsF-GYTNsnOq8PML991Gqq0E4Ag@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] fuse: add extent map I/O support
To: John Groves <john@groves.net>
Cc: sashiko-reviews@lists.linux.dev, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: psTPQ7KZ2yQfwrtMIKIWuGchZ7UAT7cbr_L5qdlhorE_1791970653
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:

> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index b5bef7b9e466e..77d7a54066e47 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -551,6 +551,17 @@ static int fuse_fsync(struct file *file, loff_t st=
art, loff_t end,
> >       if (fuse_is_bad(inode))
> >               return -EIO;
> >
> > +     if (IS_DAX(inode) && !fuse_inode_vdax(inode)) {
> > +             /*
> > +              * Note: the DAX fault path calls this via dax_finish_syn=
c_fault()
> > +              * and taking inode lock in that context is prohibited.
> > +              *
> > +              * FIXME: need to flush CPU caches for the DAX memory ran=
ge
> > +              * FIXME: need to sync metadata to the server
> > +              */
> > +             return 0;
>
> [Severity: High]
> Can this cause silent data loss on fsync() for DAX extent-mapped files?
>
> When an application calls fsync() on a FUSE DAX extent-mapped file, this
> bypasses flushing the CPU caches for the DAX memory range or syncing meta=
data
> to the server, while still returning 0 (success).
>
> Because the operation falsely reports success, applications relying on fs=
ync()
> or MAP_SYNC (via dax_finish_sync_fault()) to ensure data durability will =
not
> take fallback actions. Could this lead to silent data loss on a power fai=
lure
> or crash?

John, what's up with CPU caches on mapped writes?

Thanks,
Miklos

