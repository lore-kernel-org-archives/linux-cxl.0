Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD042640A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856518; cv=pass; b=pB7U4Tqwa1/W+TtzLI54NARzGbkt95KTOJsuvTg8epOSnLpnqYER+vYn3W4RpZQHn2qdFAGCW9uVaqgbrNNFXqkbIOykX3VWBT4NA4xdS5bdtrqae9AVaBi9lkZhtBvYFLGpavzm7R35nmQVAsrZSm+wrqOJ6qwQLb9DdS1OVYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856518; c=relaxed/simple;
	bh=mG265DhJNejB3aQoWJ6qVy75eCz04BYxxJNwPeHfTj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdKzTvrXvR2CYcTf6y9a2PXVn6JQXbcG68rtOKGHwEimJwmoFq+u6ZIs6VkntR9dOVi/Iz34DJO5iPxdtmoCqnaK4pHazMAMTgnAP4qknzStfzBofds7YLzVPQ/SLXxFf5naavWw+yVrBRM3e3loi6W1j5+AiycXpC0ZtQsNlMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvn5T5ze; arc=pass smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvn5T5ze"
Received: by mail-yx2-f1.google.com with SMTP id 956f58d0204a3-675bcb34141so1056643d50.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 18:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791856515; cv=none;
        d=google.com; s=arc-20260327;
        b=bbb59+uYTRog8mxd0FsUWmR/516S7TB9whcTtWm35Y/J98Vdq1VS/0+uopLwH1bGT3
         6kIIlkURQnydZKDhKdAAFI6sPM031RquFUmxt3RkxQ1NzCVCGNWPpXY6NkiA5Ot0YPOm
         q59hummlwTuQnUmcuxwa/GsU05wzhuiOM6NUDjDgT27Jj46tAF0keAm5J+PhVFOLGoxr
         7i2XW7C24UO+WHYci0//+6y/0qK0ay2cl8R7eN7FhldRpSP0WojAIE1Ndz6GlK4BT566
         k8Xrt20pVOo4fHvj0Dug9l2M+b5RGupsLWIJtsl+0BiKTuLUb9RvOXlItK3bTgu//U9N
         YPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZWY1+3DvZQ0StiNShQCtdQAyPVbWkBMdlv0s3OdV3Y=;
        fh=emYGQDN2D4bSTuJohoeBwa+7cY6c7BgOi8Nv2ZXAxWE=;
        b=cXvy2Zb6CAWJK4NX8tRq/cAhmTSIfg7OBtq2qjq8T7Yj4ARQ3Ms0of94SOSIVM+mlD
         +CsuSpSTZmjwVowJoWl/mC00cgPi48oBb7wYkZqEXSCHiXDG2iRHC2QxK3kUM+LM3kC5
         U3OGph5tJViGjSxYo9JC1AKCzu6qNKTuNA3PdMWD4HFkrVcvyCaI5UXh0GaXJZUB/lzm
         oo0B5hBBD9fUXTv/kHgV3ktbCZDqgM33DpNvHOO44Puym64qBC2ASpJeuRlZ2b7KFJn+
         SP23yNi/M5mzC7Ha1zmlcGYbmGloLK4XVgy2s5UVdJzQyUnDGLw/FXpp75B7dV696Tx6
         kXfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791856515; x=1792461315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZWY1+3DvZQ0StiNShQCtdQAyPVbWkBMdlv0s3OdV3Y=;
        b=Wvn5T5zeH6R5qvW8UAxE8l8bgurch7aUZebNHYYc6H49S066y+tWC/1rnEHYsSWbf0
         cfuZSZUCUUD7bN//VvAFSnfzyIm1GCdpC6ibK5mjfYIipppdyDPMmbol2d4cOjupJgBN
         RkTKE2HYTJcVuxjosGl94VQmG2blg1X8rZiS0pS7ZrPzyiMpltDpj8zCGgxPe+weEB0U
         u94imbMvQIji5YbbKR0KEwqjG+mkKWFE9G56eqN9VjidkNnXSK6gtEwPzhW/rCixYO7O
         o9h8cKWuXCyA8E6CMFpkUKVzvQzqpImXrh4CjKvaLIAThr9g8DohGqo0kPwPzLZPUMVi
         rj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791856515; x=1792461315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZWY1+3DvZQ0StiNShQCtdQAyPVbWkBMdlv0s3OdV3Y=;
        b=ZjDYQE7QHOnKq7ZkjP1YIwI9fTHjYiRNlru8fzRlgziGLoiQLSimgMenDeUKco/Gmm
         9UuyPl0+PqRvxUTVNjmMSiqNCChnSuGkiTm8uX8FwQyW0R0aPwdsIb0D3oJK1nYv6tcH
         JOmEhoPGbJ1PnNqsXdWFVehu1IF8AjFE1d2wLTgZQ+N+AQXmRDgT8+vmq5cGZ8yDQ4Ym
         1ioBg7q3BubhLTZb4D13lHPzzA5biqo7kJzfZu4ZLD+3rLuQFOCMJ4HjJGtjcAGyXU9k
         1DCwRQgKVCV9E6n1wbE+Tic6RxBctI2Kr7bLrm3DCbUrI5nF2A3axi9DGU/Ba8ZJCSjr
         FHkw==
X-Forwarded-Encrypted: i=1; AKwUvBwlKQ4AVEbvwgm2IdNy9c56dwSGeaqSsxpdBEOP6aR+yGkKw6w4B/wZsmtTjhsrx6vH3DtTsBmVNx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhaOyvq82Ua81vW9vXNOIbPmwjUB+Dbra7kBL+uZAqUbg7ExPF
	v9HBqhPgfgTiLbPC9b4BDRgbXlwIoV0V+gzke/DZ/wclbr/0DxqO3Pg9UNfFcfg7vjuizjKqWQU
	JH2ndCUV2+r3sCf+AL4fAJtIILzaoWsk=
X-Gm-Gg: AYBFou009lCpsfLLR3wF3q5DEPa8r5y4AyKx9P5mL+c0VCugSQKcG9BUKNbX7ksAXSz
	jWmb+/UTbzmZV/NCut6AqnD5X+ojLZKox9wou206b3fiIRSq0mlu2dUpZeGu0kNiTRQgT8aqv5J
	byfupito0LRF9zRGbKloAPn9bUychOqRTJ4XBJCEf+isa3FAZiPFbn+yjtCyPTeydEIEyPgJBDx
	XorpswCZ9IShcejs4y7+CwKzeQL8fXsslm7xku9g3WsbIL5SBjAU58VeAazzlAZtZEzbhpNl5VC
	izvMaHEOF90KD72NrcF7ZIcHIk1IDWwyzYlzj1IJqqpEcH3sMzbUGxG5BOP8698tNoNOQgRyqA4
	DVK5jiOFZkQp+1JIGpP3u9w/o2g/d4VblKjnZ
X-Received: by 2002:a05:690e:d0f:b0:677:c1c9:8cad with SMTP id
 956f58d0204a3-6793630857bmr4065688d50.101.1791856515453; Mon, 12 Oct 2026
 18:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011131857.30481-1-jianyungao89@gmail.com> <as1riZMcDaX5niW9@aschofie-mobl2.lan>
In-Reply-To: <as1riZMcDaX5niW9@aschofie-mobl2.lan>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 13 Oct 2026 09:55:05 +0800
X-Gm-Features: AclHuK-qPrcKDhDkwZ2-LoYX7aqLa6VHDfxw6GQjUohnMboPcDsPQB2ik2549xw
Message-ID: <CAHP3+4DCsJ4vJWFWfswGj70p+it+KJ2fLA1G8p5iKYJ7fi4TGw@mail.gmail.com>
Subject: Re: [PATCH] dax: fix mapping_store() returning 0 instead of error code
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-kernel@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alison,

Thank you for pointing this out! I'll drop my patch since Muchun's
version covers both cases. I'll review Muchun's patch and add my
Reviewed-by if it looks good.

Best regards,
Jianyun

On Tue, Oct 13, 2026 at 7:21=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Sun, Oct 11, 2026 at 09:18:57PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > When the region driver is not loaded, mapping_store() returns rc
> > which is 0 at that point, instead of an error code. Set it to
> > -ENXIO to match the equivalent check in size_store().
>
>
> Hi Jianyun,
>
> The change looks correct, but there is another path in mapping_store() wi=
th
> the same problem. When alloc_is_aligned() fails, rc is still zero, so the
> sysfs write reports success without allocating the requested range.
>
> Muchun Song already posted a patch addressing both cases.
> https://lore.kernel.org/nvdimm/20260924025035.1265035-1-songmuchun@byteda=
nce.com/
>
> Please take a look and add your reviewed-by tag to Muchun's patchset
> or comment if it doesn't meet your needs.
>
> -- Alison
>
> >
> > Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >  drivers/dax/bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index b809e1a264af..262f97b5e7aa 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -1192,7 +1192,7 @@ static ssize_t mapping_store(struct device *dev, =
struct device_attribute *attr,
> >               return rc;
> >       if (!dax_region->dev->driver) {
> >               up_write(&dax_region_rwsem);
> > -             return rc;
> > +             return -ENXIO;
> >       }
> >       rc =3D down_write_killable(&dax_dev_rwsem);
> >       if (rc) {
> > --
> > 2.34.1
> >
