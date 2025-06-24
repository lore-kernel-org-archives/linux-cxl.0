Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B572D12E7;
	Tue, 24 Jun 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773420; cv=none; b=mo7sr8w4MHWKjh42Qw+Wo6H+n/r8dlTaRAK9ZoVjwVrgt9oDXMwno9U1JHlxbP9vcWCPGq0ANK6grBkl4NjkfWRjxcu5hfVRjLApwIGw8tn+XwoECu5HnasQ7vOIIpAjU6dVV4UAD0THJPLLFe60v5cHR7CZcQAVQvKkXMgYDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773420; c=relaxed/simple;
	bh=BpzCqYrZgktHyHFsZFW3UfcXDFM+0KqnOLAMuBNHnj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr1X/QkCkW97MDJwspwfBc0Lr2IsDLCf0TLAwyGw36C67KSwe9aBLWQcWdNvNqBiBVzdR3MRWxOJTBx7JR8Jv1zTVv4n0xD6dAKixKFa1sVwpgSCmV7hHInn0J7MV2UzcxC8zU9jBz+ROSnmW8F3J5p4g1hKYu4debuyCc9TmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehjJHvjZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehjJHvjZ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553c31542b1so4473127e87.2;
        Tue, 24 Jun 2025 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750773413; x=1751378213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yABC0w8DEfvFsnNOYqPanr5Sg2H2x2a5U7q3it7HMM=;
        b=ehjJHvjZ14n/jCUzZJfjUQ7PtAlXWe/lOKEyET3PX3iOC8z8b6dtiQ8YeNXIAw+VnL
         nqjhnwTKIEd62R4EX0uZZ4jU/g3IGahZfjTyMMqB0FAoIYJOqHF0Iefyq5pbj75CMn6n
         Ur5JSd6PhXM87RQWXMGewUWwEU+9/43tch61kAtUQBSY7ygX8+U092DEwTp+YIwrff9D
         Gl0XZRVTqEgG2zRqUmJ3TDGyTpl88CNuXBXbDtCkQ7VcCrsRYOUuSE5OeOgrVHpqIqsZ
         0WZjX+LnbDEAkDvstVV3v3UNcFpwNf9NGVnFqTrCIvoTM5H8l6N3JzFuewgiTSNiVvSj
         HFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773413; x=1751378213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yABC0w8DEfvFsnNOYqPanr5Sg2H2x2a5U7q3it7HMM=;
        b=pWbD7S15J9b4CvKgnQK3kl8UTJlh63gDZG0zDUUPp+bh7KCSJfB6FV/6HR5xvlpCq9
         EPA5ZwJXY2Y/Yci8VlDlFOYet/marivOA43A6TRsE7sKcUCcoKi+Q2bT27embE2WaAbX
         R884Ogdwc0joVK0oqxeoo2PigDs8oXOz2sptLawctXBCuqkcLCJRRupJ8UxPB5pVC/WW
         bpYGx+s8m4jgNhGmQ3U1PnegHscYigw85N09xXwOM7dtjtYx4EuyAqjWRZYQkldMjYKN
         pQNoyw64qwXmNCl95qeZLHVPU1Hg4SDFTJlr/w97H2d7Lh5nM42DOW6xDmC7LsFIJ9Cb
         KoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUss42Fndd7cZpSdN8vkH/Qc12nJtHOEQ203pnuJ4bY0zP0iTTk0BYfB75ReS0lnbcWQHDUUNpBHpyk/z7Q@vger.kernel.org, AJvYcCXZZlQfwP180RasaYFDissMTb0uFQy/I63lvIufZt/0f19U00oYixBrEsRTvFCTwY78nSjAFYZ8lXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfY/zYWKyGo0Rpb0L0m7Kz1OmaGqpZsYvhLGk2KAriHQV/R38K
	SQoaVLxTvBBxaONYX+QWmAqrUcl4jpoHYblgCZj7SAD8PcqtXlc4t+7rIb1MInZ5ucoJSCKKnNt
	wcPQJMjRDY0Y+R5riK/LLTykanea3I90=
X-Gm-Gg: ASbGnctN8u57KFoL/vLZooevYTikRW9Yo4pD9ccUkFTvP6hO0uX2LMhbzNZDP2zHSP4
	YK8FEUi2IGyqpYuJ65oprzn/McNtSiRVxqT036iVPA3cdairSZxD/Pf4Fj8PuJYmCV8xrP71PlB
	y+FTu6+Gkw2wxWSuoZ0G1/+cwEoqDmqi55lvRADycLbEdabe5INRGmRQqMpSUbYajpKHt4szb4d
	A/Hsg==
X-Google-Smtp-Source: AGHT+IHXYi6I/UqWOT18oDq+1JOOpyKXM7cogsUpmD7YM+DSdmtZsArE5Lb3v+YDn6Av7/arwxcsKeYaVo5vgs03PuI=
X-Received: by 2002:a05:6512:b8e:b0:553:37a7:b217 with SMTP id
 2adb3069b0e04-553e3bf3e5dmr5544673e87.35.1750773412740; Tue, 24 Jun 2025
 06:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623091929.366357-1-pranav.tyagi03@gmail.com> <2025062343-brilliant-laziness-e2cf@gregkh>
In-Reply-To: <2025062343-brilliant-laziness-e2cf@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Tue, 24 Jun 2025 19:26:40 +0530
X-Gm-Features: Ac12FXxXAIMa7msu1Ixldzq9g6VHMyrCm53AQgkcjWXSWvwjIHhI1C4QApdm17g
Message-ID: <CAH4c4jJtKP_MsqGBgt1kRim_nmWOS=Zd49iNYiHNM2-yDgMv1g@mail.gmail.com>
Subject: Re: [PATCH] cxl/port: automate cleanup with __free()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, ming.li@zohomail.com, rrichter@amd.com, 
	jeff.johnson@oss.qualcomm.com, peterz@infradead.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jun 23, 2025 at 02:49:29PM +0530, Pranav Tyagi wrote:
> > Use the scope based resource management (defined in linux/cleanup.h) to
> > automate the lifetime control of struct cxl_endpoint_decoder. This
> > eliminates the explicit kfree() call and makes the code more robust and
> > maintainable in presence of early returns.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  drivers/cxl/core/port.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index eb46c6764d20..c35946882b20 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/idr.h>
> >  #include <linux/node.h>
> > +#include <linux/cleanup.h>
> >  #include <cxl/einj.h>
> >  #include <cxlmem.h>
> >  #include <cxlpci.h>
> > @@ -1888,14 +1889,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, =
"CXL");
> >   */
> >  struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_por=
t *port)
> >  {
> > -     struct cxl_endpoint_decoder *cxled;
> >       struct cxl_decoder *cxld;
> >       int rc;
> >
> >       if (!is_cxl_endpoint(port))
> >               return ERR_PTR(-EINVAL);
> >
> > -     cxled =3D kzalloc(sizeof(*cxled), GFP_KERNEL);
> > +     struct cxl_endpoint_decoder *cxled __free(kfree) =3D
> > +             kzalloc(sizeof(*cxled), GFP_KERNEL);
> >       if (!cxled)
> >               return ERR_PTR(-ENOMEM);
> >
> > @@ -1904,7 +1905,6 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder=
_alloc(struct cxl_port *port)
> >       cxld =3D &cxled->cxld;
> >       rc =3D cxl_decoder_init(port, cxld);
> >       if (rc)  {
> > -             kfree(cxled);
> >               return ERR_PTR(rc);
> >       }
> >
> > --
> > 2.49.0
>
> Note, I can't speak for the maintainers of this subsystem, but
> generally, making changes like this for no real good reason, for code
> that has been around for years, is really not needed at all.
>
> If you fix a bug with it, sure, but changes for the sake of "let's use
> this new feature" in here really might not be necessary.
>
> Why not add cleanup.h support to code paths that actually fix existing
> bugs instead?
>
> Also, you have added some coding style errors to the code now with this
> patch, which also is generally not considered a good idea :)
>
> thanks,
>
> greg k-h

Hi Greg,

Thanks for the feedback.

This patch was intended as a cleanup to improve consistency and
readability, particularly around handling early returns using
cleanup.h. I followed up on similar prior patches that introduced
automatic cleanup in this subsystem and aimed to extend that style
more consistently.

That said, I understand your concern about changing long-standing
code without a strong functional reason. I=E2=80=99ll be more careful going
forward and focus such changes around actual bug fixes.

Regards
Pranav Tyagi
