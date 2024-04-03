Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01976156662
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186018; cv=none; b=tkyepwySFtdNSueuOT2uGIH7AeGv6vFrtj5FDnLRYgqWclR3ss7eML+94T0WWRvHho+Ysdo5EQwwtMCOvmpg0wjPMRAL3bMK+eJsj6b6oAVz9GicIKu/rk37uaggBp8XLpcLPYGftwwunqXBYV00u+6Vp/8+IiZgxnfXUek2oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186018; c=relaxed/simple;
	bh=pUU3g8YyhBE2JjQkANiR+x6xd6tdfAbxrQ8hOKQJLk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSV/164mwVhuiyTEVTSoSqL2RE0cH4x3BOfkhp6tSBXlfMGJ0vL5rD2UiB4Pn9wtf9HtVAxdwl2JGwd6FQGKXb3BtOsPk4y+IUpvV5ECdb8RASP8PR02R2GJSRa+SWJe5/QqCx9Nqko1UdT+AaMu+WBaEZHi7a3QYXPL2chxyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YpHO0zEH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YpHO0zEH"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd161eb03afso404764276.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Apr 2024 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712186015; x=1712790815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXQkJndwO2OFb1B4uAhm6DSgUpXUEz9T4TSxXyfE+FM=;
        b=YpHO0zEHFvldxI0Mc3QMoW5Egln0Cd9kQZU7ZnJCjJSrsvJ2pi6JlM534SCnHvyZMH
         Gt7UcJ21OxN60o+OVGHJVrrIHYC6J7IzId4jItlZ6UeKkoyjQuWJPPO2q2smCwcO90M9
         GYpQQhPW6SoTB4WUr1O39rT7fCd1VBBM6jDep6UEXIWPS3dqotjMkq1UWav+5szq4/0O
         hnKz5LjTBcDZ7DdtKWSNOqHyF8rgs8Lc1lTUVIyG7h7MsK9sRqWb07GBWfwMybYrkMzj
         nXS8Yn2sOdBp157g7DtATzBGlUwceB3Rb2UTEEXkRuWj1KuML3OD1Eu7XdegAk31c8FJ
         C5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712186015; x=1712790815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXQkJndwO2OFb1B4uAhm6DSgUpXUEz9T4TSxXyfE+FM=;
        b=Qqebc/Zprj9rUmuiUqzkbDDmCq91NJi/4Rkc7KKAIDi21hhWq/nQ8dmO6dA8hltAdT
         4WayHdB2Hf1NbKAHVnQwhoz2aZ2EU2/FbNk16M5NhIqSwDDPrnGbXMqjkH1hw0Os+77b
         i1r6GE6ZFcu8uKFrErhoe2nshXnYdqzaVLcJbvvoi1jGAEnCOj9DuC3CdyZ1+KsS0eHk
         reoHqev3ot15xJfRky4YFbINwB/PRTeEl6W6pQMN9aJowKawCVC/kZya7j9LeFZb2zM6
         BtshqNS/j2gUDMbjtXleeZ/CPdyx/A2S8qjjUxjlsqU2BkLrazUrG4T1w5+7gFNRcPbV
         /naA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDQQfq1Dkr37v4tRV9HItDpCQzpnpDTlFFOZvtyhdG6EVnsE71+C1MYDPHTnnzrKj9ZQqmrYH4gNFtlcxm+e/NSYqRe3VOJpy
X-Gm-Message-State: AOJu0YxcsrGMVy3V7MtprogLgPZypVzuDHEa4vaEw/yHBQXWy1sqzNCN
	NL5wy6to+IFda/tVKh9nK5lxoe7R2nVHDMWNwrkQVz0YTD6k8WcQZ92ENyAdm1xikSjx0i2dVoZ
	fvMn6JqyokqxpVUPJPT+xteWizrNvsUvFIbzZtg==
X-Google-Smtp-Source: AGHT+IFVeLOeseHn7jgUi35tqoQdrprRgFyBUayTJ7qIeLYhEuQo2z8SpiV7Er/5CVQCTXOehRej6DG8/caODWdPemM=
X-Received: by 2002:a25:8189:0:b0:dc2:3936:5fa5 with SMTP id
 p9-20020a258189000000b00dc239365fa5mr828148ybk.51.1712186014869; Wed, 03 Apr
 2024 16:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-2-horenchuang@bytedance.com> <20240403175201.00000c2c@Huawei.com>
In-Reply-To: <20240403175201.00000c2c@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 3 Apr 2024 16:13:24 -0700
Message-ID: <CAKPbEqo_zN1Y-Ut6oGpP6OaRALQRFMmA737_br-9=ROcnj25gg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] memory tier: dax/kmem: introduce an abstract
 layer for finding, allocating, and putting memory types
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for your feedback. I will fix them (inlined) in the next V11.
No worries, it's never too late!

On Wed, Apr 3, 2024 at 9:52=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  2 Apr 2024 00:17:37 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Hi,
>
> I know this is a late entry to the discussion but a few comments inline.
> (sorry I didn't look earlier!)
>
> All opportunities to improve code complexity and readability as a result
> of your factoring out.
>
> Jonathan
>
>
> > ---
> >  drivers/dax/kmem.c           | 20 ++------------------
> >  include/linux/memory-tiers.h | 13 +++++++++++++
> >  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 47 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 42ee360cf4e3..01399e5b53b2 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
> >
> >  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
> >  {
> > -     bool found =3D false;
> >       struct memory_dev_type *mtype;
> >
> >       mutex_lock(&kmem_memory_type_lock);
> could use
>
>         guard(mutex)(&kmem_memory_type_lock);
>         return mt_find_alloc_memory_type(adist, &kmem_memory_types);
>

I will change it accordingly.

> I'm fine if you ignore this comment though as may be other functions in
> here that could take advantage of the cleanup.h stuff in a future patch.
>
> > -     list_for_each_entry(mtype, &kmem_memory_types, list) {
> > -             if (mtype->adistance =3D=3D adist) {
> > -                     found =3D true;
> > -                     break;
> > -             }
> > -     }
> > -     if (!found) {
> > -             mtype =3D alloc_memory_type(adist);
> > -             if (!IS_ERR(mtype))
> > -                     list_add(&mtype->list, &kmem_memory_types);
> > -     }
> > +     mtype =3D mt_find_alloc_memory_type(adist, &kmem_memory_types);
> >       mutex_unlock(&kmem_memory_type_lock);
> >
> >       return mtype;
>
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..a44c03c2ba3a 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > +                                                     struct list_head =
*memory_types);
>
> That indent looks unusual.  Align the start of struct with start of int.
>

I can make this aligned but it will show another warning:
"WARNING: line length of 131 exceeds 100 columns"
Is this ok?

> > +void mt_put_memory_types(struct list_head *memory_types);
> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct acce=
ss_coordinate *perf, int *adis
> >  {
> >       return -EIO;
> >  }
> > +
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +{
> > +     return NULL;
> > +}
> > +
> > +void mt_put_memory_types(struct list_head *memory_types)
> > +{
> > +
> No blank line needed here.

Will fix.

> > +}
> >  #endif       /* CONFIG_NUMA */
> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 0537664620e5..974af10cfdd8 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memor=
y_dev_type *memtype)
> >  }
> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
>
> Breaking this out as a separate function provides opportunity to improve =
it.
> Maybe a follow up patch makes sense given it would no longer be a straigh=
t
> forward code move.  However in my view it would be simple enough to be ob=
vious
> even within this patch.
>

I will just keep this as is for now to minimize the changes aka mistakes.

> > +{
> > +     bool found =3D false;
> > +     struct memory_dev_type *mtype;
> > +
> > +     list_for_each_entry(mtype, memory_types, list) {
> > +             if (mtype->adistance =3D=3D adist) {
> > +                     found =3D true;
>
> Why not return here?
>                         return mtype;
>

Yes, I can return here. I will do that and take care of the ptr
returning at this point.

> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
>
> If returning above, no need for found variable - just do this uncondition=
ally.
> + I suggest you flip logic for simpler to follow code flow.
> It's more code but I think a bit easier to read as error handling is
> out of the main simple flow.
>
>         mtype =3D alloc_memory_type(adist);
>         if (IS_ERR(mtype))
>                 return mtype;
>
>         list_add(&mtype->list, memory_types);
>
>         return mtype;
>

Good idea! I will change it accordingly.

> > +             mtype =3D alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     list_add(&mtype->list, memory_types);
> > +     }
> > +
> > +     return mtype;
> > +}
> > +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> > +
> > +void mt_put_memory_types(struct list_head *memory_types)
> > +{
> > +     struct memory_dev_type *mtype, *mtn;
> > +
> > +     list_for_each_entry_safe(mtype, mtn, memory_types, list) {
> > +             list_del(&mtype->list);
> > +             put_memory_type(mtype);
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(mt_put_memory_types);
> > +
> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB
