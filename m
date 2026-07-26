Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE4285CBC
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785100165; cv=pass; b=kASiQX7avlSTN3eLI+OLfDM+ijbG9nh5K140oDXG6rff5ImVuIAbySG7IRIaVwGqSDa3b+inWxnQl+W+56Ae9v+EQpwCUW6KO8MxO0eQfrstd1AosDOJg4zt6A9PVwJUmW8ZlLdT7UOk9f5btWIKXsjHGBVtMEIVHIop+P3iCxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785100165; c=relaxed/simple;
	bh=XVSIoaWfu1Kj43UnK0ys1QBWZCloSd1bN0Al4TAoQH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqT694vifuQRuA7s3XrsoyOBJWsjdn3jJqjVRagA+SCfXxVcK18X+fCddc6xBf55aKb6Raix8CZpDoYbK5VcES6fsZvYAWx9r9Haw02+T+qyj+/o/lnZyX9QYn4ZFWDPLkF7EJDwmt/76amq16SxHWDhAN6NIAk7IE6FlYgSlWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PahwNV4G; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PahwNV4G"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso18200155ad.3
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 14:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100164; cv=none;
        d=google.com; s=arc-20260327;
        b=UEWbj4SEvDp1hIhdIbHVPip38idU5OCxiLWb/NuS8mZl6EKYw6kQeMi37rGU0i8izz
         BM2ibf4i4yfuZrPrBY1/DiyeembCQfgkWBFFQq6l2aRNMGlgBQS3IgMt68JIzDT3qghc
         zxXtDY0Plr3GMUEqu4tY2/KOGOJFBld6CyOrImattqlutLkCBT/tw24laT/U9FdyPQnt
         RWKmj+xbMQAcTahM3p/b7x+WfQFrETMZS+dmMF6vLZ6VqkkbY6BLDkQCc2XZmvebkY1Q
         IX2P/cdE1X5zABS+sQSd3akufJlDgHjQRAwxz/+3sy4TJrmIqJKB0C9PFfcrsHjcsovi
         7x1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
        fh=IHfVW2EvSf6VmqpV4361lkIQawsml1H7bzPYq8CH8h8=;
        b=kqVsMC430K5kKyUK89SKzFcSbZuQCx9ggzMPsTP/OhA40Jz0cT8PnONPJJG2wLIniK
         Jaakm1SIVbFeWJYS1PMgYb1ItTBBG0MTZWz/QkJuPMSTAd9Wjl5XiOG2dd7a+lH2IfWX
         eVPsyjqxf+2wfYaYqhF4Krc2pUqLUF2OT38w8i7MmcC4KwDVcav4P006QZ6Dt0/rsRXr
         PYXACH6BKCoLIt29FQtqZ3Chig/esyZOpX790MhdQ1MhNqea3x04PAc8WwdHygfg4EWa
         s+y+KmG7r2NaX9lyvt4E+0ff7+vtrAJnFOUu8ykHJJOKn5OTkbOyUhVAZzO6L2VKXCIz
         BvVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785100164; x=1785704964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
        b=PahwNV4GkA10rTJf1lMabl5XAq5SZVxw4/IyHEGyYGYIskLP1/NVAy1eh0xThpVZAx
         UxXSP6hcTg/uDdzV+HEb+o8lgiUe0m9eQesWPBQ0hFPkui7uKutetBhZfUYYIfVzoQLX
         om1ywtWYcI7hJWBIEtaKOMaieeEODdDNGqImihgBvGXls/ZutU+OjSEV4U6ZDKawxVRX
         iVBO4Sz1xxVlKln7OHoPuQ9aPVt0tnjZeUY+8+XMPkuMn/9yCBcGr0PsPcdy/GkNPtCn
         vzPZu3F/X8QbelFnLDNyO1HcWVI00y1HNzZyP69EcA2rBRRObXO7SpCbqwDz5Q6IBxU8
         Ci8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785100164; x=1785704964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
        b=phAPuar1IvVKZkbeHevpgLAtSeef3G3SxsB7Vb6wXcAFu6CSFu8vPhD7QXNjIQvZ5l
         yrnyM2BwSRjS3sNkM3aRIzmHrzAvZm+Etv4h9Jz8bKos6e23GQFZdGUHhqvlxvBphVjb
         L1AV1uQM9hVPzntgAPC1A8yPaB6v+Y8xY4AHj+yRsEJn56VD+0jBVNWhR1/o36qXDPWR
         opWqHpPzhJYmsfi91FQFGF8ek3EnpTPFY+zPBhF+JARY5C99MdI47kxNgYFop9b4zPE/
         Ma/L+LM6G+NcAt+vEFUXZbYVB44A18u2E5i5/m3d2CiIW6RcsLyNrsino2rTWXwcQD6W
         Kezw==
X-Forwarded-Encrypted: i=1; AHgh+Rprx4wkCW5S5ssh+YOJemtLMljd6C2/7t9yLOvbxbAJyT6BFT3tQyGPIfDaer9vnxZ9qFQIo8Ci43k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQKYuQ4KsYw4jbn0EoU25jU/KquwGQwbMrXC1LmX9lZG/sEpn
	gKDjVknM43nxZy5IvKTlYWTurw+WDvceqLvPsvSLXohJv+uPXDI/APjYOpW7i/MYtQFIvCSSqeo
	rypLRkHkNN1PHhhcl4fW7tS41F2S8jXw=
X-Gm-Gg: AR+sD11RoB30bIvSUEerrJtxl2aDbuPDjax477ta7EXipJF5hSx1GA/OmJH5hQwVjEY
	TU9HspyFtM0lv5YeWiaSw1Iw4xF8DKcvHtWcJvQQTIJOVtPMPiHxh2FzgW/PuBS9LXHY3XvqLnl
	BZe/+E2w+3KoSVBOvri8pcxC23k1LO6BgjRHEoc/eGKoWTtuPCXOHjBZU1App+fkUb8vtLP2g+U
	hgS6pwaXNvJE0ZwVcAAO+b+bNbVonanEb+czG9DpsXCPYkyfeh7TG1pUTJfSNlwS2CAHQoJo35T
	JxZM72Lc6FA8VomCJQ==
X-Received: by 2002:a17:90b:3810:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-38f293cd15emr5801529a91.1.1785100163960; Sun, 26 Jul 2026
 14:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com> <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726164738-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:09:12 +0400
X-Gm-Features: AUfX_mylOzHtLX1B5pdeb_u2WgbX2EqX4Pr6UFlRNQstCQqi_x-D3pds_NHf1lg
Message-ID: <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
	Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
	Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org, 
	Brian Cain <brian.cain@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:49=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for t=
he non interleaved cases")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Not commit log really?

SSIA, but I can make it longer if it helps.

>
> > ---
> >  hw/cxl/cxl-host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index 7e744312f1d8..eba13c9e7cba 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDi=
rectPTState *state,
> >      MemoryRegion *mr =3D NULL;
> >      uint64_t vmr_size =3D 0, pmr_size =3D 0, offset =3D 0;
> >      MemoryRegion *direct_mr;
> > -    g_autofree char *direct_mr_name;
> > +    g_autofree char *direct_mr_name =3D NULL;
> >      unsigned int idx =3D state->hdm_decoder_idx;
> >
> >      if (ct3d->hostvmem) {
> >
> > --
> > 2.55.0
>
>
