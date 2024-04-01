Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B22A1BF
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012795; cv=none; b=fwxBEvQA93s/fhaoTi4192X9mid8jKOq7RvA5p7TeTSlkA+NV4bRucN0jhcN/WZP4mveQZK/Fkp0NpbCYJvG5yt3r/nz+yoXSmyrWUNOe6id9UfHSL6xOmrMf6khMEHsYvbYl5McJJAOYNNwllaN/6AuWHG6QKtTUDq+3Bp98Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012795; c=relaxed/simple;
	bh=TbpC8M+7RPwppbkhzTamYJOLZlUu6MTKc06W4CbpxE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC/DwEBU4s4qM0q3eI++UkzDuzOmGxsZ+d+x86mTvLzOWqBbkpynidc53HkTJyH9KmNcl9OUfnD4s6Z1kvCQK7TW/WaD2/J4npQyBPSdveT4nrUzqSWpbDzwLl5lgOpVOp2j6v7YTUhYnTmsG08rbIjAiUsymE/j3svcFw56O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ii3KyxUd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ii3KyxUd"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so3592707276.0
        for <linux-cxl@vger.kernel.org>; Mon, 01 Apr 2024 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712012791; x=1712617591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8nGCphDC2lDqE/CSbphHfkuC3TvEewjmAtLy2kdkps=;
        b=ii3KyxUdV/B6xvI/sbllezlCZ0avvlb1wPoVGBy+U4kzk8FpdcBINyezzZbCy0REkw
         +GP2vSoPu8l6fPBOs56BChMMSauO9hQ9rsV7saIFad+RXwSWLBGtU/SgEtPCUd6wpFmN
         uszdaCnQpwmZlOUniPRnC0bni58CDY3ox1pP9ueNyxEGsNqIZKoQK/NRNIyPYvpPEest
         3wX6uFLbVBdksLltATJJsqMniqLxaedwfMT1KbOUUeY/QlbGdCeXvzOZUw+zuHwoSh47
         NatFArMt3WvQyhTaS44BgRZdnV+cxTUlIYaDUeRruAs4LY/t9YIF1B6I+LTrsRXTI9im
         roww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712012791; x=1712617591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8nGCphDC2lDqE/CSbphHfkuC3TvEewjmAtLy2kdkps=;
        b=Jt/npO37tD3S/MVnHlMmuU/DiI4lmxKwacCP2wnrg5K8wBfxjAIwNZO42q5aWr4MJu
         TMzdlc6r2EjTruipzCrt39qAxQ3526TloDjOjZgbThJibmJEt8iH+JEHL9/OOT2jUIng
         xIFA4K2+ipluEvJeuAcwJiJ0DWdH6d+biGPORBRgesAyF0OkemPrQkR4k/3UScv5pqmN
         5M5ZZfCiGHQ7Br8XwJrqiWX0IP8p5tjPVmRgqt0dhT4qHn2NvZKYjHU1OmSxqwbHKxI8
         8J44xzOT7n+69rey4adxlazYpliC+hZqxzBUtKhoW/ngbsoFgfmg5xa7wSv4U3tW+8A0
         e2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0/9odZuWKeSVy6jV/lKhNRW3H4lpUFW8LNle4URDnfFQ7VnbbxtPYUVHYIt7+OIhSGQmWKUVfziF7WyOmrA5WbaNS39GZXVOr
X-Gm-Message-State: AOJu0YzKdmaYunAFFYo7s7zdtiq2lX48ugXYMHO1dw7+K+dffNPdxxQP
	nC3jLW7wSVECzXfWqkTh3YqvjecIzW0YKEu0VsE5HWhxR/s4R/XvRgA2euxony7+6pC9IX9ZYBI
	p9RLzdRTx5CmOieqoigThH9JYV+7pl12xLhUNrg==
X-Google-Smtp-Source: AGHT+IHzFkHkXRaCjC8Uy5FTEb4BrGRIOAJ4uvIAnoieQDU096hzOpi7JP+GKKrquqv5tMmb8A6yVyiIs7YwfEUYlA0=
X-Received: by 2002:a25:bb51:0:b0:dcf:30d9:1d7b with SMTP id
 b17-20020a25bb51000000b00dcf30d91d7bmr9194408ybk.45.1712012791583; Mon, 01
 Apr 2024 16:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329053353.309557-2-horenchuang@bytedance.com>
 <20240331190857.132490-1-sj@kernel.org> <CAKPbEqo3_zHF98SRoAz4L-CCGpEm8wN1P2RgPLa_q63e1qeGxQ@mail.gmail.com>
In-Reply-To: <CAKPbEqo3_zHF98SRoAz4L-CCGpEm8wN1P2RgPLa_q63e1qeGxQ@mail.gmail.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 1 Apr 2024 16:06:21 -0700
Message-ID: <CAKPbEqpsE8aqH0t6iKmuLkhjFX2CfRK70K5U0eC1VvAyk8ofKg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/2] memory tier: dax/kmem: introduce an
 abstract layer for finding, allocating, and putting memory types
To: SeongJae Park <sj@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

On Mon, Apr 1, 2024 at 11:27=E2=80=AFAM Ho-Ren (Jack) Chuang
<horenchuang@bytedance.com> wrote:
>
> Hi SeongJae,
>
> On Sun, Mar 31, 2024 at 12:09=E2=80=AFPM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > Hi Ho-Ren,
> >
> > On Fri, 29 Mar 2024 05:33:52 +0000 "Ho-Ren (Jack) Chuang" <horenchuang@=
bytedance.com> wrote:
> >
> > > Since different memory devices require finding, allocating, and putti=
ng
> > > memory types, these common steps are abstracted in this patch,
> > > enhancing the scalability and conciseness of the code.
> > >
> > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > ---
> > >  drivers/dax/kmem.c           | 20 ++------------------
> > >  include/linux/memory-tiers.h | 13 +++++++++++++
> > >  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 47 insertions(+), 18 deletions(-)
> > >
> > [...]
> > > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tier=
s.h
> > > index 69e781900082..a44c03c2ba3a 100644
> > > --- a/include/linux/memory-tiers.h
> > > +++ b/include/linux/memory-tiers.h
> > > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> > >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf=
,
> > >                            const char *source);
> > >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)=
;
> > > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > > +                                                     struct list_hea=
d *memory_types);
> > > +void mt_put_memory_types(struct list_head *memory_types);
> > >  #ifdef CONFIG_MIGRATION
> > >  int next_demotion_node(int node);
> > >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)=
;
> > > @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct ac=
cess_coordinate *perf, int *adis
> > >  {
> > >       return -EIO;
> > >  }
> > > +
> > > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct =
list_head *memory_types)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > > +void mt_put_memory_types(struct list_head *memory_types)
> > > +{
> > > +
> > > +}
> >
> > I found latest mm-unstable tree is failing kunit as below, and 'git bis=
ect'
> > says it happens from this patch.
> >
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     [11:56:40] Configuring KUnit Kernel ...
> >     [11:56:40] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
> >     ERROR:root:In file included from .../mm/memory.c:71:
> >     .../include/linux/memory-tiers.h:143:25: warning: no previous proto=
type for =E2=80=98mt_find_alloc_memory_type=E2=80=99 [-Wmissing-prototypes]
> >       143 | struct memory_dev_type *mt_find_alloc_memory_type(int adist=
, struct list_head *memory_types)
> >           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> >     .../include/linux/memory-tiers.h:148:6: warning: no previous protot=
ype for =E2=80=98mt_put_memory_types=E2=80=99 [-Wmissing-prototypes]
> >       148 | void mt_put_memory_types(struct list_head *memory_types)
> >           |      ^~~~~~~~~~~~~~~~~~~
> >     [...]
> >
> > Maybe we should set these as 'static inline', like below?  I confirmed =
this
> > fixes the kunit error.  May I ask your opinion?
> >
>
> Thanks for catching this. I'm trying to figure out this problem. Will get=
 back.
>

These kunit compilation errors can be solved by adding `static inline`
to the two complaining functions, the same solution you mentioned
earlier.

I've also tested on my end and I will send out a V10 soon. Thank you again!

> >
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index a44c03c2ba3a..ee6e53144156 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -140,12 +140,12 @@ static inline int mt_perf_to_adistance(struct acc=
ess_coordinate *perf, int *adis
> >         return -EIO;
> >  }
> >
> > -struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +static inline struct memory_dev_type *mt_find_alloc_memory_type(int ad=
ist, struct list_head *memory_types)
> >  {
> >         return NULL;
> >  }
> >
> > -void mt_put_memory_types(struct list_head *memory_types)
> > +static inline void mt_put_memory_types(struct list_head *memory_types)
> >  {
> >
> >  }
> >
> >
> > Thanks,
> > SJ
>
>
>
> --
> Best regards,
> Ho-Ren (Jack) Chuang
> =E8=8E=8A=E8=B3=80=E4=BB=BB



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB
