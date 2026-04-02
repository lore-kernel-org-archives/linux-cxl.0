Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67828472
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154512; cv=none; b=OsPirrkK1OC6jSa0eV0yhTLUMXiVkqanLl8fAv8t0d7TygUQD/ODMz3iF6DYsdKJLwDhuA95n3s7gfuwIO4cbxkCsRB7Y/S8AnuUlo5395D71yffB9y3xnkywszjGQdKYcEwfJX7Dg7PBCEdXxvjzO/nitBI4lCthY7gbmukGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154512; c=relaxed/simple;
	bh=3wLn2EzGj/ZCUyJnUgUcvL+uUYO+oONRzbuPkYnaT6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpzbMo9TMWdBNx0WwvUalQU0MO308UTTomVBk6RdLQODjhMT4yCRvVevlx3Vu+5nFWQ/RJlm3SxHqFq+twHBRjCaYt/ORSIXdlwsWrE9R8E8a57g1myZRv43fZmGkhrPiwiYXQYlWuRZcurHuy4qWFsQRJi6jOF7jd3s0lr5z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so169736766b.1
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 11:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154509; x=1775759309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S5DT2wBs8AqJgexCrhyhylPGuRKzHa9bxGRV2/uoaFw=;
        b=eoYibWHaKxnsGUHB0sSzV+G69RJf1CvhSPe6WNAmsSYszbQ/KB59rRYPahhoPpD/St
         WTaoJSsUB17epY6+Yz80eBuw4pPGOJScn7lKEBlZIUoBhTlTN3tgbHgtKhPjOZhC4b3I
         kI7ijIWFWqDbZaWWnmu6j3jy5/T9t9Lr77diELw9LntACCE7aty34KPkf3hZbVq0385J
         p0JbnorScpyzcfU6Fi30vtp5jzVzX71FYjSC52pYYVxt4dCKqf/vdNWWnG6145S7Nepm
         XRwPeYfb9CRACVNa7QXyUbOn9DvWpfYPyXsTXuvSPf01pHBugvdpuY/jNzjZqSUmVesY
         bSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVX/HupYf+Hw3qHVHkInV9b2H71RAHTahNqgNbNQ9deivig0sDAEveyuIw+lMp69Npd7DIOsJzjnpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcRX62o7bnXJ2ixcqiXoTNI4yKm978lbpPQkmiq99RSzRhCBO
	qsPyHaGbiIbrRzNMmUbkPlfZbzWdl3ykLQSZoBpVfLFCbr356vxyfJcP6AY/zPMovLIivA==
X-Gm-Gg: ATEYQzwrkXInBRfhd4wRvN8gHwcNQQjCPnL8sqkN1EUsUfjkYs6QPRLgscZB/tmYSE4
	kVhou0vD8VuWYd26NASFq67wvvNmWMTDJMXHb1F0V6se6KTcjqIeUG3CBOuafj/ZQKG/OgNjkQV
	9v+BISxefwPKfjn1ms5of+7l+GLzZH6MhBtP32OEwOpxdhmF87wHv8GLl6QVN8SL9nUcRZ94YDU
	NoYIAG5SKKvD8iflE2gi9IHOFHKliH6c1byLRtDqToh4XdFqz3c6ESvoitlYT3neWpLYgoLSZOm
	90TcpCOz01ZhEkNPTQbGWocinwj0ZLr9MuGUflBwChfubfBxZQAAFrYmrRV6eJqLEg5NaSjEqaJ
	AE3iCOrRH10T3E6w7jZ3GD0Z1gvPFptlxK8RuGsnQ3mpo8VPnMBBVAJHVCi9bo0MVjCAi9EsfgB
	7JAmrEsLNG7qzu/MTNlpuAkc8znPlqPMuhqni6d9W5nbC3siGOAD4duwk=
X-Received: by 2002:a17:907:11c6:b0:b97:6384:2317 with SMTP id a640c23a62f3a-b9c13904e59mr440120766b.17.1775154508790;
        Thu, 02 Apr 2026 11:28:28 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff131csm119863166b.52.2026.04.02.11.28.28
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:28:28 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so1096674f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 11:28:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9IboxiBNBGd1wsCAJrZvtVvEwYYbBVCJDSxtHQlIGez/gPMEsSTAvkUxCgVT1Pggp+O8Ozycf0xg=@vger.kernel.org
X-Received: by 2002:a05:6000:2303:b0:43c:fb9f:150c with SMTP id
 ffacd0b85a97d-43d292ecccbmr136467f8f.43.1775154507981; Thu, 02 Apr 2026
 11:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330130156.2212694-3-iam@sung-woo.kim> <69caf2141dd3d_178904100ea@dwillia2-mobl4.notmuch>
In-Reply-To: <69caf2141dd3d_178904100ea@dwillia2-mobl4.notmuch>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 3 Apr 2026 03:28:12 +0900
X-Gmail-Original-Message-ID: <CAJNyHpL-fyDnEJv2bxKNjBAzxHZ9HmKTu72MzcVhWiFrDRKzpw@mail.gmail.com>
X-Gm-Features: AQROBzA0EggoHd90nFQiTUhHuNUBwPV709PJRZhA8yWo5N0XBATQF54qspafGuA
Message-ID: <CAJNyHpL-fyDnEJv2bxKNjBAzxHZ9HmKTu72MzcVhWiFrDRKzpw@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/hdm: fix a warning in devm_remove_action()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:58=E2=80=AFAM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Sungwoo Kim wrote:
> > In the following race scenario, devm_remove_action() can be called
> > before devm_add_action(), triggering a warning because there is no
> > action to remove.
> >
> > To fix this, __cxl_dpa_reserve() performs devm_add_action(). This
> > extends the critical section that embraces cxled->dpa_res =3D res and
> > devm_add_action(), so cxl_dpa_free() cannot observe dpa_res without
> > the devres action.
> >
> > task 1:
> > cxl_dpa_alloc()
> >   __cxl_dpa_alloc()
> >     guard(&cxl_rwsem.dpa)
> >     cxled->dpa_res =3D res;  ...(1)
> >   devm_add_action()        ...(4)
> >
> > task 2:
> > cxl_dpa_free()
> >   guard(&cxl_rwsem.dpa)
> >   if (!cxled->dpa_res)     ...(2) pass, due to (1)
> >     return 0;
> >   devm_cxl_dpa_release()
> >     devm_remove_action()   ...(3) warning, no action is added yet
> >
> > Splat:
> >
> > WARNING: ./include/linux/device/devres.h:160 at devm_remove_action incl=
ude/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> > WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release dr=
ivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> > WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x32=
0 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> >
> > Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an end=
point decoder")
> > Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > V1: https://lore.kernel.org/linux-cxl/20260309000810.2632065-2-iam@sung=
-woo.kim/
> > V1->V2:
> > - Let __cxl_dpa_reserve() handle devm_remove_action() to reduce
> >   duplicated patches. (Thanks to Dan for the suggestion)
> > - Make the comment concise (Reflect Dan and Alison's comments)
> > - Make a warning log in a commit message concise
> >
> >  drivers/cxl/core/hdm.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index cb5d5a047a9d..63bd0d5f31df 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -408,7 +408,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_d=
ecoder *cxled,
> >
> >       port->hdm_end++;
> >       get_device(&cxled->cxld.dev);
> > -     return 0;
> > +
> > +     /*
> > +      * Perform devres registration while holding cxl_rwsem.dpa so
> > +      * cxl_dpa_free() cannot observe dpa_res without a matching devre=
s
> > +      * action.
> > +      */
> > +     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
>
> This needs the pattern you identified in v1 and comments should be
> reserved for cases where the code needs more explanation. Something
> like:
>
> /*
>  * Invoke the release action with the unlocked __cxl_dpa_release() since
>  * cxl_dpa_release() acquires the the dpa rwsem
>  */
> rc =3D devm_add_action(..., cxl_dpa_release())
> if (rc)
>     __cxl_dpa_release()
> return rc;
>

Dan,
Thank you for your review and suggestion. I will fix this and add a
comment in v3.

Sungwoo.
