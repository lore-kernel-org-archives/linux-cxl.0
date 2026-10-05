Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E254854E6
	for <linux-cxl@vger.kernel.org>; Mon,  5 Oct 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207210; cv=pass; b=SUjEqf9k1Nb5TWAXE1ukvvwHYPg9E1jp03WClxq8jFaE6cYbBKf8n4c0DfG/SnQNEfNLt0rFig7j+nwwX9EO2NlTJIkrGea2gGS/V1sgXrSEtvzAMAh1qlFhVbDqnm2dJ5I2eW2AgrfkbnmLacOrWHODFaKPGUIkAh3nUdsgMvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207210; c=relaxed/simple;
	bh=I/7qOpbaPjFZCfk8Hbfl7OK+toY69qdxL0Ly1nx8uco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri0mkdlyhwjJYr7kMjUXoqhwEZv0YPnDjymRwE55s2KQ+0KXWf31Oq3zC5tD2S/Hr4neOVot46Q8o8kjDuqnjkuY5HFlpI9rFeoMeBcB5HyXkvb8QXn4dy4HX1AutSptbVG3lBW1yRN3G8AZMSMh1geCTQhfQbD8A8YMGdXcbnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gfjjL07D; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gfjjL07D"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53396adbc53so18550671cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 05 Oct 2026 06:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791207207; cv=none;
        d=google.com; s=arc-20260327;
        b=dU1BDJhqep6OnIWpOrY4m9PPJzR6Lnk4R9nsQaamCBveXQnanXA7BRr7sB/ijfsI4f
         cAru1+0sVhgF7drVqYlSxqlxEdHMcW9gz35R2ttF9eixweZHQX+LJfNJ4Uh3Xgdyg68J
         56uhQztU+d4ZBmJEf0j9tiThbPo8bp4fL9+EzVom5CnLUBz+pbPMmjrg9pgBee20/tUG
         qnuFpX+fDRyiSOK7D7UoESErCvGK2Kc0F5q3eTURzN3YykruoWSn52OQS7v0s6DxXtd9
         uvxEBH/2gQzY+j7Ewy5qCPoIUCZE9jiYflWHaKCyJSjcB7dKFgxgDNFyZALMvMGFz1jf
         3IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7otsqulBzc6rkKlGohX6jHgXmZfiW8WkwVHav/09IiY=;
        fh=i2UEFDiOVGNx16yJ9GPE5zdr7zqlr1QQZoHIMJNwf34=;
        b=NLFI35+BTb3ZBZAUy6E/fkGhA/oPYwwGnprbgSc7wO+Kbo2AOqP6oOR23PPd7viVSO
         JUs5EXo3cw65n6LeOi7dwRDyEdF8tHm3WIoAf2GsJzilby77+UCqwudjBySijJh1RRI6
         YxPNVssi6TmVBGuYJeCzwFhyftltZQuWIlmUehkrQufCK6h6o0l9om7mbxkp8IAzYgjt
         uR8QGvIvpIREFc5+XQbhj9OC0hVrRaQEdkF5V89EZsWuHKNrOJmOHxCwv+0NlhIjN+cT
         Qzzz3iP5NvjzWOu5c7mEGAUQmznUFxXgBFBJboeD/B4+5ZAioZunumUnv10RRlqujjBL
         OiQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791207207; x=1791812007; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7otsqulBzc6rkKlGohX6jHgXmZfiW8WkwVHav/09IiY=;
        b=gfjjL07DXKftDZOMBHlg6JMQYyt1eJiAm38/zXZVDDIi6EXGuZQLqWVkJnKL6CteYI
         nqhi1M+fMTZn5LjAsLUoGTzg8ObuJluEEidcyD1/hGlALwDmz7E/ThqCe921M4yzGVYM
         m4wn9fVnYt6ASX80PtbFYEZ0fnm9pgB5ZlPgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791207207; x=1791812007;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7otsqulBzc6rkKlGohX6jHgXmZfiW8WkwVHav/09IiY=;
        b=cMdABsKG8CSCXhc+SV4LtlsLJ/A0qWEP5/GnkcxR5vp+vCPHXBg4eKmjreXKc7bruA
         y5xmhyTeo6YG4AlCs++IpuqaAzR9Xhsigc/nRnTtYA03EqVwDbkw8YJkQ00GtTf7/tb7
         +1+7jaPI/TAvZK4334bJjf3ojlzANIP57fPkVWaFW334lVxGpozpcNnmPgcWogWhNcy7
         cgb9W2dxoqnRpbM/+FxQubju5Eo6OFotBiyggowH9lwnDX9LV3tiSaquoku//rlWHO9Q
         YETcDyMxm09pTtKSei1Vqu1HSTCLd6P0TzhC0KG2c92+r7FDrs43HEcYreHB8SK1iYRz
         hxRg==
X-Forwarded-Encrypted: i=1; AKwUvBxbZL4sbJNxhScxVEwmVTYug39Kb82a0zFnSZWXOhBlbhsew4W9iJSyig2L3Drd9sNvnRzknh1PKDg=@vger.kernel.org
X-Gm-Message-State: AFuF++lfAHwXtWnMvaabojB5LDoD+8qkZW6hDZg+R+GiNtVDyo8jpodp
	WnBl6NJbrLGQXHI84F6hgnYkhCV63jtSTkcNOg3rZ30+lxJ8w/IZ3ja1tOE8ZP7wNyEWABVIRv2
	PQeaAzoqb3bN1UplGCe3W62jsxfD0qtJY8IygB9OMZQ==
X-Gm-Gg: AYBFou27W643bLsAw5OC+D0JbTt1ZUdKxVHbfa5GpKokROF5/oKuIrnroLjFdLrqRm5
	h613K3hctDlsJ4KQ+dh3WN1cumpmWvm/6+tiqr6/n+CamaAU29dfRHA9r5WU8mNLxgYDqRlIy9W
	FaLfDt4nR3I3ZP6Kuw7nug8Hs8RRbdcSErNYeVJU+aBfRgaW939RTh3S3YxuQo6RjbRRbYKhv1r
	5qcSuMws9cHLuYKN+GlbgXC4m9Wc7lPdkFOu5oxixAASCAssvtQVDVQFeiu8RmqPypiATMfLQw0
	jVaWEmIlRSw8g6zY7z7PJCnDZkJJk80S64kQpXy171QuXoFNdCmmm1lpCu13/BzX4Hy1Oe3Z3M7
	A29HAFpiMliwW0pDD6kULNzc=
X-Received: by 2002:a05:622a:1ba6:b0:533:9826:a9ac with SMTP id
 d75a77b69052e-53511e43589mr124329411cf.20.1791207207172; Mon, 05 Oct 2026
 06:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-4-mszeredi@redhat.com>
 <CAOQ4uxjWCRs59Qpc4t+2=i67rdJkHt=+rH07ZXv7ZzAvTjTm-A@mail.gmail.com> <CAOQ4uxi1+WgHJdnRKMD3tp24EOyx7iPByzSKLn_siTVY3_sRDQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi1+WgHJdnRKMD3tp24EOyx7iPByzSKLn_siTVY3_sRDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Oct 2026 15:33:15 +0200
X-Gm-Features: AclHuK98SWoqABe7rwTyIrlCpXfPZvMeW8Yn8TO-gyQNFntxAo01LmvUy6dhY_s
Message-ID: <CAJfpegttAHQAGhE61t-VZqfQv9Z==ovbyLY6qp3KOK_CvjBciA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fuse: support 64 bit, server allocated backing ID
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 20:59, Amir Goldstein <amir73il@gmail.com> wrote:

> > > All 64 bit values are valid.
> >
> > Can you reserve id 0? or have a reason to need it?

I thought that removing all restrictions on the value would be nice.
But okay, zero value we can live without.

> > It would feel a little less hacky if we do:
> >     else
> >           fuse_backing_files_init_32(fc);
> >
> > and set
> >          fc->passthrough = 1;
> >
> > inside both of them to gate against fuse_backing_files_free()
> > called without processing init response,
> > or without either FUSE_PASSTHROUGH in the init response.

Bigger problem is that IOC_BACKING_OPEN can be done before or during
INIT.  So we need to take care of that case and the race as well.
Fixed by:

 - leaving the idr initialization fuse_conn_init()

 - adding fc->backing_id_32 flag which is set by fuse_backing_open()
after chekcking that fc->backing_id_64 is not set.  All under fc->lock

 - in process_init_reply() checking fc->backing_id_32 before setting
fc->backing_id_64 and failing the connection if so.  Also under
fc->lock

 - in fuse_dev_ioctl_backing_create() if fch->initialized is not set
return ENOTCONN

> Also we should not enable passthrough if rhashtable_init has failed.

rhashtable_init() can't fail if parameters are correct since it falls
back to __GFP_NOFAIL() for allocation.

Thanks,
Miklos
