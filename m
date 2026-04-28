Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072713B5B3
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354996; cv=none; b=UehScKKLrYyFSEbXG1zAD/3YL/ECy760KliB0DBUK1Fl7cZ7ihtTv4D/TWzQ6Y7R9GsvKoaIIMTn27VKrlMRrfOFdAXfbdlEOgXuJ65bQim01f7PsX+JD47Z+oZoY5DyANvO2rhoa8yRcHWSkMDhxX8XEhhD7QpI7mwFh5EFnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354996; c=relaxed/simple;
	bh=HJ15R5Kw3hmWU/sk/kpE0svrFTDUqqfbvIpq7P0GHEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9J3gsGqmgvVxjCdu61aABbaxIxbbeyexMaiPONsbY7SVa+wm65jEMAl+JnIIHUG/P+CUFjHRapFOR8rkqRFjp7z4xnYllmMLHmHJH6LV5Je6l7IJRslSFb02hMfph6jHxWyjUnWVtUVUHyZWQrCnCq3Cb3QQD9KWrT2//Lw6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso20788917a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 22:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777354993; x=1777959793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xpPg01MKYajp+Ist+hyAKv8dpH5VzBbcmxuwu8KQCk=;
        b=dAg54gik+3PHWkm63HYkzmFyzF/ECAT7fTcpNNs4WfSZa0thr4x6L6TZV5lHYFdl3g
         Cdzd4c9a3B7lmGpPLe6Jb8NO+hQ+oYCg+YxblgKyYJRDfq5HM0D4QNc5zHKO//HlWBB5
         nIRV824OMB7A0WKOh1O+NYbbXMlcKq2Y4gP8FboPbmIubLiQEYAoFLKjMFZiH3Khb2zI
         FZnShPeq73CjNMJcY3HduLcaubDruyjCam/XU9JG9snQf6g7bKcahikQx69sf6qjtpY6
         amrcSVZO1fkvRX63gAGAf1GRgUrAkN5ycluBlntx+KLaLZOlK4w+ypkaMpH/ImlwpmTy
         bp1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/0zNcnybJHEG7jjoSGFzTIDm7UKQjBItMrcfQW4yRzoWbUa+gCq9p+LtJJcoWFKH2X1D3vYXx5qVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHR67WualNMdqHM8OfdwQKN0hBmk8QMiLDjuRK6XYO8YHes0+c
	lWmef3V33Fy0xKVcgIEz8hEG4GJlFE4b3bpxzS0ElTCiJ39r3NKTJWRAJvRaVF8U2Rc=
X-Gm-Gg: AeBDieu9McdNekQUxv87EIIKdNJaS8ZIqaOXOwIbPGFBZLYrimcdqiLDsLCXWZG4ZF/
	9qw1Cb1ErcWEXkBatWrVUj1sZqhpnw5nVW6KRdGaP5nh3CVcVBsizS6ZRyYm0PNO2PT4+D7Ge+m
	28UYW87QV1Rgjw36cgZG6sKMa63X4+s+9iBVlDk2enuhp3qD/KEsuuAlo9nQ8y50LznfHF7Qu0g
	DIDXol/nyKuyuY+BV1O2QUobkLiR8cxUuKZ8h/1eZtFBzotAQ9nz7Tw/aKF4t0XGlkyfSAToyjE
	ioBOrVbd1s+LyGd1XFuDV9fKCii8sBAtD+pL8ogtZU5hDyqxzU/ZyPHEoH1rC4p/N9zPciV0eCL
	J2322qt9OvzrXiy2L5tZBETyVeI1bqXd195wYNnVsnF1piWWfwmfye53MXLm4iSXtbndXKuhP4J
	mVVOL3MzkFI87v4ftSRv45UE2RL8cKVZ7bBgDQMPidYFlnGliM/ML7xASeWf5bE+wziA==
X-Received: by 2002:a05:6402:3897:b0:66e:68e1:fc18 with SMTP id 4fb4d7f45d1cf-679bb089902mr739517a12.23.1777354993003;
        Mon, 27 Apr 2026 22:43:13 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67cd14bsm307524a12.3.2026.04.27.22.43.11
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 22:43:11 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso91214045e9.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 22:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+EGJ6gDUviefx+TPmGL6CrAvhkRV5wDceJYEPEHesInw0nOow2B9GZFGKyHX0ECiGbMgppHCg8mUw=@vger.kernel.org
X-Received: by 2002:a05:600c:6814:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-48a77b1dac1mr24524935e9.19.1777354990909; Mon, 27 Apr 2026
 22:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427032010.916681-2-iam@sung-woo.kim> <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
In-Reply-To: <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 28 Apr 2026 01:42:52 -0400
X-Gmail-Original-Message-ID: <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
X-Gm-Features: AVHnY4LZ0LNj5Gsz2bpZoydVUmT_QxR4xsC47L-lPo_vlXsWP9fyjOfZlTvBHco
Message-ID: <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region unregistration.
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, Robert Richter <rrichter@amd.com>, 
	Li Ming <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 1:42=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 4/26/26 8:20 PM, Sungwoo Kim wrote:
> > This version mainly addresses Dave's comments and meaningful issues rep=
orted by Sashiko AI[1].
> >
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > This patch series fixes race conditions in cxl region unregistration.
> >
> > devm_release_action() should be called once, otherwise, it warns about
> > the second call. However, the current implementation has a race conditi=
on
> > that allows multiple calls to devm_release_action(). The details are in
> > each patch.
> >
> > To fix these, the first patch adds a new function that guarantees that
> > devm_release_action() is called only once.
> > Using this function, the second patch subsitutes the current use of
> > devm_release_action() in cxl region with the new function.
> >
> > Change in v3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Addressed Dave's comments:
> > - Split and made this in a patch series.
> > - Enhanced a commit log explaining why a workqueue is used in the first=
 patch.
> > - Added a context on how these issues were found and what impact was ob=
served and how that effects a user in the second patch.
> > Sashiko AI review fixes:
> > - Fixed construct_region() as it also can race.
> > - Used a driver's wq instead of system wq so unbinding can drain a work=
.
>
> A few issues Sashiko raised with the v3.
> https://sashiko.dev/#/patchset/20260427032010.916681-2-iam%40sung-woo.kim

A Sashiko's reasoning makes sense to me. In the middle of
construct_region(), users can perform a sysfs write, which then calls
unregister_region().
unregister_region() must not be called before construct_region() has
completed, since it calls device_del() and put_device().

This isn't introduced by this patch, but I can fix it in v4.

An enable/disable flag to allow sysfs write might fix this, like:

static struct cxl_region *construct_region(...)
{
... // when a construction is done
  set_bit(CXL_REGION_F_ENABLE_SYSFS);
  return cxlr;
}

This prevents a sysfs write before it's done:

static ssize_t delete_region_store(...)
{
  if (!test_bit(CXL_REGION_F_ENABLE_SYSFS)) {
    return -EBUSY;
  }
...
}

Would there be a better solution? I'd like to ask for comments on this.
This patch series already introduces two new flags, and I'm concerned
about adding another.

Thank you!
Sungwoo.

>
> DJ
>
>
> >
> > [1] https://sashiko.dev/#/patchset/20260422045637.3048249-2-iam%40sung-=
woo.kim
> >
> > Earlier approach:
> > v2: https://lore.kernel.org/linux-cxl/20260422045637.3048249-2-iam@sung=
-woo.kim/
> > v1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung=
-woo.kim/
> >
> > Sungwoo Kim (2):
> >   cxl/region: serialize devm action removal via scheduled work
> >   cxl/region: Fix a race bug in delete_region_store()
> >
> >  drivers/cxl/core/port.c   |  6 +++++
> >  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++++-----
> >  drivers/cxl/cxl.h         |  9 ++++++++
> >  3 files changed, 57 insertions(+), 5 deletions(-)
> >
>
>
