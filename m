Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A233F5A8
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853390; cv=pass; b=VmJ6jYoLIjbAaPF4muO8F3lE2dFH/9ats1MKf6D+VtR0YNmbnRE+1nQc7fi71Qgt3lE9kSDcWejGh7y8dcxw4jfIqmuPdsQMsBAU8zgkZhOoYu6kEJcKTdhGZOzGq92gaY4vBCay13ll65mrymQ/FH+R4wpPlnigQzZdOIzK0L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853390; c=relaxed/simple;
	bh=lowpFmrvsNjlgMHo2szT6XZJz28KEXOM+3vhDqNGI3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajZbymmaoCD2BSTcS86cg52x5lCJC+kFf3BzPBFo9DlKdOYDWqyocHVN6Iu6CMEs5YvyJUjVJmJKPAGMBat1Yibn41BPCk6VS8ojaeg5DxfhJ5JpmCzqVEi3cgBm50SOEmQTDdLR/QUN0UqN7PVgP4im48Wcf9+BteRHY9DQm0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0Pd+vdV; arc=pass smtp.client-ip=74.125.224.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Pd+vdV"
Received: by mail-yx2-f2.google.com with SMTP id 956f58d0204a3-6753d1555a6so874681d50.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 18:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853387; cv=none;
        d=google.com; s=arc-20260327;
        b=eDzK7IUf1buI0EomqGbXfBJwdk6SO4h+p5Jk3FNujxixlnf9w8IpgiqwV6qmQ3/h7G
         K5iAZqaTydHbRG6S41pIXet2YCt/KNhGkbN+xkCwmyjIkjM5WcJyyMPors/miP8daZbp
         d5wXuX41eRBSuaEQ+5iVrLFIt11u+b83S0jFCTPkfxiVX/GqJHM5VGe+x/mRiXGrohfe
         FZjeW5pFkCN28DmwCrcCAlFVHRkn1JOvnAfqwK9pxX2m7Hhbzxnkf7cuAQYD/2yNcmk4
         S0tgX1JdAypvrngGqmxbZ7b0hRopiBNYyN9AFNN41zklkJsOpdctUfWNuBWShWsGjWBM
         eggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        fh=F3SmaYskIVpOn+sf3/5738MRybc7LPjq9bpC4mmEiik=;
        b=lG0DySUnsPkd9/TVtUvISQxZVcQVyue/q/8poQQHGy6djLcHB/62B1dU2ZIYIBVePH
         0WYNjz7CTPCmLGm1brKEksN/C7TqI6ww7H9E9dhM7EF7WZ8EuzTofZsp3Ziz7YQhCcWF
         hUWg7C7GSRVvzuTtz2ayi18NpTbU7R7z4D43f6NXr3iPRb9PtyD21FIjgrlPYI1poRQv
         P8uUIeXScJ5NYj5+AF74LBhIw1U+fLcz0zblE/M6xgQPAT96p0n/Mxt0qPJ39zU3XoT2
         6sASEwD+qVnvRYQmmezlSnFCeeuWBlopTn6dNLWpM4oFGhZfxA9OyOBn/7ksUe5HJ3Mj
         umEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791853387; x=1792458187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        b=l0Pd+vdVYxaIyeC3wlw8iz6yekNOjFLzUxorbnIHaO3rH/NPSXb+NfFWPmsMenEmEv
         bN0V5yjapEJ40ueLuITXA8FQniQFbfwC9nIFuE0+6qBL1XWxkosbkJMuqNjwNhxwwQ4Y
         PDlN7gCV/0iikMfpolnJlH3r2IokWltkciwHdptBCnfhnb8u2CIvQ0mUH4uBdWI71gmy
         dvU2895amFkfOdb9xsSCFGqSM26xjPvnQ3cmd6Zc03pYTHudPdOavVG60fJOmBpaYGQw
         0KTDDz4oa+vrQ3WR/KR44iBG7XEI2IGg+XCfsdu0LZUBkKwytGC3cn4BALtHd7W5+pKF
         2FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853387; x=1792458187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        b=FF9BB9m/oJ2sw6QRJm8hx309bx+Bhy4JpZI0uuGq3ByswoDt9bKr8bht+M2uUU4DLl
         FfJgmQuNpNgTekr4tVtAGQfEgpSy/6VTZbphRosIv77UiFAKz12JlNqoq/M6/GKqp5d7
         LzpL2pPOFfJhOs/gO3DTkqqUkTkNLqH+V8EYUjA0DpcQ3ufhAfEvDwNjPCIEtk8NdWBw
         +BKVwPZs9iUW16OaV1jiNfRInZ9nWrtRwyoeiLETlhf1YsoGfqaP1z0wlQAZnqBnkGwv
         AH45ID4mzJijHa9u5j/7O0nc1vnZM9nWRS2S6rO1enPD2tSkGwZbGOC74fCHVYIfq8v2
         NFBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfBLsCk9f4Xi4aXZyzHg5elN45luURm77RiFwKhlFmwryCt8jKJH6gwkqrvCTI6UDQ7pXnMAwyRro=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZQudhCX5cxfGY68YOpranQOSAKD/vr445P5Eu2vtXNgSovCQG
	cHExdr2JJ/B0xK49nZZfBQpBm0prdrYS1nwoh/pnc7CFtQ3mThe2QgwvW9Yhc5/OFBecQEWiQeh
	pF5rwEYuvggC5OeeCQnO54ZxZahi+ZAkRYr84tXQ0bRZsGbg=
X-Gm-Gg: AYBFou3sNj1zpk79VVKmG6qT+wGe+mAW5OuEnhatXSADjdcEdMlv0jVdZdrw9oKcygg
	ROObKzFhHjLNli/VSdIFP2ujTP4BJ67rKuIe8KXkIeyOH/2tWJsU5fQgYXBstZF4+y5totvNkhe
	SQahY5XAXpIGLW2n6IspqgjOAOoxkTYuFWnSWBaUTIzFdoErKsduKDpx9elouXZsGjJoxmBIszW
	0Zyt3Us1l+MX8gUoK6oJodg610DPnLKJBbclxYbGGWBuGO/gDV57RZM2Do8coyDtXj0UxZdRvtm
	pIpdV97bKX8NYVjOnamka0uEkB7f52N1NRBjsmANtNI+pogcfM5T/Og=
X-Received: by 2002:a05:690e:1688:b0:679:42c1:d156 with SMTP id
 956f58d0204a3-67942c1d3e2mr2820147d50.137.1791853387325; Mon, 12 Oct 2026
 18:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012151857.22534-1-jianyungao89@gmail.com> <as1nmV342j-eUOYm@aschofie-mobl2.lan>
In-Reply-To: <as1nmV342j-eUOYm@aschofie-mobl2.lan>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 13 Oct 2026 09:02:56 +0800
X-Gm-Features: AclHuK9sFgO33rPYLTn8ixdiEhdZBta4PDJKOZxl9dlxJLJscw0iQpyhSfFl2bw
Message-ID: <CAHP3+4Dr-XsZggVSf=THU7NBb8RANc5MCREHORkXV5shcgk22w@mail.gmail.com>
Subject: Re: [PATCH v2] dax: fix dax_core_init error return code
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for reviewing the patch! The revised commit message looks
great to me. I'm OK with it.

Best regards,
Jianyun

On Tue, Oct 13, 2026 at 7:05=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Mon, Oct 12, 2026 at 11:18:57PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > dax_core_init() mistakenly returns 0 on error paths. Change the
> > error return to use rc so the actual error code is propagated
> > to the caller.
>
>
> Hi Jianyun,
>
> Thanks for the patch. The change looks good to me.
>
> I'd like to expand the commit message to explain the impact of the bug,
> not just describe the correction. I've proposed a revised message below.
>
>         dax: Return errors from dax_core_init()
>
>         dax_core_init() returns success when either the character device
>         number allocation or DAX bus registration fails, even though the
>         error paths have already released the initialized resources.
>
>         For modular DAX, this allows the module to remain loaded despite
>         failed initialization, leaving subsequent users and module remova=
l
>         to access resources that have already been released.
>
>         Return the error code from the failed operation so that module
>         loading fails rather than reporting successful initialization
>         after the resources have been released.
>
> Please let me know if you're OK with the above, and I'll amend the commit
> message and merge the patch.
>
> -- Alison
>
>
> >
> > Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Drop unnecessary goto label, keep direct return for dax_fs_init() err=
or
> > - Add Fixes tag and Cc stable
> >
> > Link: https://lore.kernel.org/lkml/20261011132017.31131-1-jianyungao89@=
gmail.com/ # v1
> >
> >  drivers/dax/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 45f84b0eb909..210f4af479f0 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -738,7 +738,7 @@ static int __init dax_core_init(void)
> >       unregister_chrdev_region(dax_devt, MINORMASK+1);
> >  err_chrdev:
> >       dax_fs_exit();
> > -     return 0;
> > +     return rc;
> >  }
> >
> >  static void __exit dax_core_exit(void)
> > --
> > 2.34.1
> >
