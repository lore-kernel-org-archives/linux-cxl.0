Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42F3C1F31
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263279; cv=none; b=kO6romNPVZnEZT7ZC0Nzp4xUusA92WPGhNZOQxx89Dgaj+2PuBj8Vkx1h2dVuhluec6tyhDa29J8C/0uVih4MOpSve0xg2EqWCCXkGdPdJTk0UeNfpiVN8nUi9MbOgzdu56p9yRE80rtzrkBsUDOPKBSvnZuxX1dv/GdeYdUKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263279; c=relaxed/simple;
	bh=BmwTLn9EjRkQmK9olPEMDQvMYaPtP4a2w40hQBeehAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAo5BKCnCeOHnGU+ebvL8lY4FZ+Cv5vmPP5gnCrLFiHREJHJQ8ITD3dChntmm91+trvl/sqpafGOBzfcotNV0c1XCxVWf4kc2kkMxsxJuJmOYoz0OlzBZc0O538e86R2E86w3rb6y8KKRtO+4Q9ZdrRtlLUI6DHdFg7FIyzJg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYPAsJ35; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYPAsJ35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781263274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9FlJSoQ1PrMv3NoMGU38Y/z2migVxYwYPcZc0DtbZI=;
	b=FYPAsJ35VVzLRQfNBEBVKa6sLYo6TO2yPWUxb3RexhxygsmTcmkRw+xkkj0b4+b35zKgV5
	xOZer9B1vgdJQ0q/+IH4P/d81tBixVOEhfM1igU8qTfWeFMQKKxuyagDgE4d0W87sbRhDO
	lK1E4kOXIJn94KmRBUs26ApZpWzZXsU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-rPbEZBcnNCOOyM-3DR-O6g-1; Fri, 12 Jun 2026 07:21:13 -0400
X-MC-Unique: rPbEZBcnNCOOyM-3DR-O6g-1
X-Mimecast-MFC-AGG-ID: rPbEZBcnNCOOyM-3DR-O6g_1781263272
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7e9bb6a26d6so11529617b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 04:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781263272; x=1781868072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9FlJSoQ1PrMv3NoMGU38Y/z2migVxYwYPcZc0DtbZI=;
        b=HBw8LV0xzxNcQdmO9n5NgHPMmiweLD+samJxFbg5QKWhC5HR0mCznH0hfNLiFVIUM3
         aulTK8qI/FaF2ZDMON0Ww2EqqHwXDtvezL5yJ1oj7mmWIXxfoMDigOJyzPmJIY9D+Wid
         4HTbTXUtpqI7967VYFK59xE0dNJXbkjA7pPS9UrowdP6YTJShVGdgsQaDVZ8rN9JRQdN
         6QmMp1JtzwBMQ5CvbXAwCc35B2FWrkMACk1jHQTL+AqjS5Z1dnj4N7GdvdFoddsFxuVp
         hBSnubunC6dtntSBv9Lok31tRFFehZfhyRzjq9rYPynWMrDqqmkOT0w1z1x7LA7Pc5J6
         oMEA==
X-Forwarded-Encrypted: i=1; AFNElJ8zc+zMNuXxhY3GUPIfMqHdXbMVUC0jeygRYFkJl2uhFw1OSHew7mFMnnjq/rtekXRi7jrMaOOywxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2XVgKL7uX90FFrpIJR2jCrVt3TohP497Op65dVL914sXatB4
	4AWyLX+cUhrqDQ2qcMUYX27P4ZCEToMOnOWXkBVGaLQKnMrOUUTPEpHQU+g7RNgNK5dNGu9Cm2x
	N1H4edUG3YTvjJqvy/Wlm65Et8d0dcipGXl5QBKP0Cs3A2a9GUwh0ET0PjiOp5OGbnUlU2OQqeM
	feaYaIDGyzGfYtdiMPhkr7jIqxoWV25y3jOLKB
X-Gm-Gg: Acq92OHEMKDMTG+hEuPW7CrJ8JHj2mX09TdXMJDNDjz5ZCWC14cZuqAxldja8P/RUt9
	GNSgueJS17TOSRUVcl2jvof0a7AxVa4Gflf0/ZE5hHmzcXMh7uKGLCeP/ZgCPSzVOgUpVwA8mAK
	FFa2HqMsp5cUOwy8PuDWWSdIq0e3jOmOYbUui9PObYyx7Zn0Hay0c9QM1toTzkoX4OfH07OPP3j
	Kc9
X-Received: by 2002:a05:690e:e86:b0:660:7a4f:9fe2 with SMTP id 956f58d0204a3-66278468075mr1653909d50.57.1781263272501;
        Fri, 12 Jun 2026 04:21:12 -0700 (PDT)
X-Received: by 2002:a05:690e:e86:b0:660:7a4f:9fe2 with SMTP id
 956f58d0204a3-66278468075mr1653865d50.57.1781263272001; Fri, 12 Jun 2026
 04:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com> <7e7cbc60-e9c7-4a63-9d4b-4e8fcad7bfc0@kernel.org>
In-Reply-To: <7e7cbc60-e9c7-4a63-9d4b-4e8fcad7bfc0@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Jun 2026 05:22:01 -0600
X-Gm-Features: AVVi8CdNLha-RR1qN40JSwbbQIn5r6XpUlj26RldKCxPkjYT8VOZtB96P7x2nAw
Message-ID: <CAA1CXcDmE3G2K-V0VrzWy=xHUjOwnMcXDJjY+hBV1hxBZUGh+g@mail.gmail.com>
Subject: Re: [Bug Report] Elevated PMD nr_anon after running selftests
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-cxl@vger.kernel.org, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RL68p059ecUuHC7zA8JUVQ-dcgeOOYHOqjj7n8Pg3yY_1781263272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:09=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 6/11/26 17:58, Nico Pache wrote:
> > Hi,
> >
> > While testing my mTHP code I noticed that mm selftests caused an accoun=
ting error in
> > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon
> >
> > At first I thought I might have caused a regression, but when retesting=
 with 7.1-rc5 (without my code), the issue was still present.
> >
> > This issue occurs in two mm selftests:
> > 1) hmm test
> > 2) migration - private_anon_htlb test
> >
> > I spoke to David about this and he suggested the following diff which s=
eems to have solved both issues.
> >
> > David would you like to send a formal patch or patches?
> >
> > Cheers,
> > -- Nico
> >
> > Diff for (1)
> >
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 053842d45cb1..683a77dd679d 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
> >         mem_cgroup_uncharge(folio);
> >
> >         if (folio_test_anon(folio)) {
> > +               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1=
);
> >                 for (i =3D 0; i < nr; i++)
> >                         __ClearPageAnonExclusive(folio_page(folio, i));
> >         }
>
> Wasn't there another issue with hugetlb?
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8a64291ab5b4..0aec894266f2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_spa=
ce
> *mapping,
>                 /* No turning back from here */
>                 newfolio->index =3D folio->index;
>                 newfolio->mapping =3D folio->mapping;
> -               if (folio_test_anon(folio) && folio_test_large(folio))
> +               if (folio_test_anon(folio) && folio_test_large(folio) &&
> +                   !folio_test_hugetlb(folio))
>                         mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_AN=
ON, 1);
>                 if (folio_test_swapbacked(folio))
>                         __folio_set_swapbacked(newfolio);
> @@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_spa=
ce
> *mapping,
>          */
>         newfolio->index =3D folio->index;
>         newfolio->mapping =3D folio->mapping;
> -       if (folio_test_anon(folio) && folio_test_large(folio))
> +       if (folio_test_anon(folio) && folio_test_large(folio) &&
> +           !folio_test_hugetlb(folio))
>                 mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>         folio_ref_add(newfolio, nr); /* add cache reference */
>         if (folio_test_swapbacked(folio))
>
>
> Yeah, if you have some capacity, please send patches (and figure out Fixe=
s:) :)

Yeah ill spend some time next week trying to understand why these are
happening and produce patches :)

>
>
> --
> Cheers,
>
> David
>

