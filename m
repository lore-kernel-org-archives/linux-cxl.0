Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E43379C52
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642175; cv=none; b=FaPaUmVKmtxHLJbYcAKfRxhbSq1U2xlfSr4pd78xG9p2c2tUxOkxEUNNbxd/Ilee6HDd2BS2I3ZGOqW9mhsg4jlduFgBXW1IlFYKfvHZLzUzqO+HDFeFegkdPxtot+rj8llMLzVM190DmWxqIA1twZ1kOHEwaZvHcelQ7ozQiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642175; c=relaxed/simple;
	bh=m69ZmsaLR0BfojTKBik+i1Tw8/FWTormzQEEmASx9tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1XOwFr/wQDbHPFJ79dFbFGjJ+eetWpuDhNVH8CP3Zyo3Ol6a6mMjuQGKCUhS20Q9NmohMvSd/uf9oUjutME7OtAxW43ANt6zAJz3bjMNyvEq5FqHlJZX7uLtNiRgqc5VRXsJzNVvvOI6KYgpxH4j88qAMFdRKkP9+DlAKNXJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auv+cOF9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auv+cOF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784642173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fw6tX10NOGyHA6auYIwnDyOcSkQ3ibq0lAwrBaFXhs=;
	b=auv+cOF95a8jdbGGN1VrjO7rd9sqP3SZ8Ncho5jhTGPIKgJBwWQaZ2vc1De+MAh6sClakO
	SD/33Vlm7P4tqzmT7qWWx3Y3K6TB44kJd9GmJcXnv3daS1KSMS7Se65w/YjA/ZLmBXQYb0
	YzRsUMnzu0wj6DVyBhTs2aeQBnhHMGk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-gzJnEEvdN1CV905tf8wd3w-1; Tue, 21 Jul 2026 09:56:11 -0400
X-MC-Unique: gzJnEEvdN1CV905tf8wd3w-1
X-Mimecast-MFC-AGG-ID: gzJnEEvdN1CV905tf8wd3w_1784642170
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39cbf7e087eso36837611fa.0
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 06:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642170; x=1785246970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9fw6tX10NOGyHA6auYIwnDyOcSkQ3ibq0lAwrBaFXhs=;
        b=ZkIwOPFR17N8FFN3psLiZrGNGj+uOjSLuN/o/kuFw4HM9V3/W7Yc/Drn5yOS5iDfrb
         tcqUKXZVadaC//Gb3Mhymd/KCf/kvAvCybHHE5dmzDeQ0Ubw/64AL/O772ggd6Zifqll
         FQAtRmYxfhE4Xs7OWZhh1UI9Sdu44MSQY+EXDGnNVKWTyAlKEiGhEHTx6FsMiwL9uL5E
         UbGnGzO07c5KCIMEGmxdNz/Ck38ujYXhvV297NdIFtGbYt7JMEI1aLesQ/QkYMbm2DUj
         0Pva5FwgqtVfIfMSjMo9V/iodbL0FGgTftzhximwRGE8xv2gy5oE9M4vsciodCvhJe2k
         gmhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqFbtuH9OUC/Bd0KzRkY6HteDKzaCLlNfwBENbaI6n6Qrx75zsYg69u5LWm+oxpo1+yMobG8YxI84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhTmsFlVAAosYkgkW3mZw/eCBZrXa9rdSQ3Y41mo6Sf/nY0jc
	2ubfkTnKDS0BaokC0Ggw0/KTOpUFpZj31E3rB6vm2NjpS9zUuYnKdLO8oGBZQLJXT9sFwsWPepH
	aW/61OQIq5FNxbolQKTMRb/u9RfoMl6Pe7fP0dKaqYq7wkKTyWaufZ8IJg2LXtgvDSp4Fqqlgtt
	F1ummiASzuk/gctF+SK0AhAfktDO1BPQCfX/2n
X-Gm-Gg: AR+sD123GBMEyYnV/1ZJp0OqV8t5sveBjWj7SYorapTAS71GR9fHAE9E0Lj9MdENmtM
	LnUXFp6BG+J6HBlGZpvF6U1WuIv4EdSBT0eueF4jDV3JkvP7u6CZD546e4pc4SnKLfOTN+D5BVp
	XtJUmvTVMBeBNoFCckcQeIYkxgjvRXb6BP9RtppvWtC36aebbLgVtTCg==
X-Received: by 2002:a2e:a803:0:b0:399:813f:ba8 with SMTP id 38308e7fff4ca-39eb28d2e4emr40566541fa.23.1784642169648;
        Tue, 21 Jul 2026 06:56:09 -0700 (PDT)
X-Received: by 2002:a2e:a803:0:b0:399:813f:ba8 with SMTP id
 38308e7fff4ca-39eb28d2e4emr40566401fa.23.1784642169261; Tue, 21 Jul 2026
 06:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717064502.1980173-1-npache@redhat.com> <20260717182947.534af296aaa1831d13f8ae6d@linux-foundation.org>
In-Reply-To: <20260717182947.534af296aaa1831d13f8ae6d@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 21 Jul 2026 07:57:32 -0600
X-Gm-Features: AUfX_mwwiPmvqqUaVHsEmV_LKORSYZ1xa64gG9rW73SaBNGLYov7qz_m_ESycN8
Message-ID: <CAA1CXcCrA9nrraxVNTdo19TRONvqM-fndSbDaCib4tZCmQC9tw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: fix PMD level mTHP accounting bugs
To: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, David Hildenbrand <david@kernel.org>, Alistair Popple <apopple@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>
Cc: Barry Song <baohua@kernel.org>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PRlxZbD9DP7rL9GrdAeb5DQ1NUb3OTvXKU_VqHfSXaA_1784642170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 17 Jul 2026 00:44:58 -0600 Nico Pache <npache@redhat.com> wrote:
>
> > While running selftests I noticed the PMD level per-mTHP stats (nr_anon=
)
> > remained elevated after each run. After further investigation I noticed
> > this accounting error occurs for both the migration.private_anon_htlb_t=
est
> > and the HMM tests.
> >
> > In the HMM case this is due to folio_add_new_anon_rmap() incrementing t=
he
> > mTHP stats, but never containing a corresponding decrement in
> > free_zone_device_folio(). We solve this by making sure to decrement the
> > counter when freeing device memory.
> >
> > In the migration case, we are incrementing this counter without first
> > checking whether this folio is a hugetlb folio, which relies on a separ=
ate
> > accounting system. We solve this by adding the proper hugetlb check bef=
ore
> > incrementing this counter.
> >
> > With these changes in place, the two tests no longer cause elevated PMD
> > level accounting issues.
>
> Thanks, I've updated mm.git's mm-hotfixes-unstable branch to this
> version.

Thanks!

>
> Sashiko is worried about the existing code ("list corruption or a
> use-after-free panic"):
>         https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@re=
dhat.com

https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@redhat.com

I dug into this, although I'm not very familiar with device memory.

It seems we have two options:

a) free_zone_device_folio() unqueue =E2=80=94 unqueue zone device folios at
free time, preventing the corruptions/use-after-free.

b) deferred_split_folio() zone-device guard =E2=80=94 block at queue time;
covers all callers; stopping the shrinker from ever touching/splitting
a live device folio; makes (a) redundant for this bug, but it could
still be kept as defense.

I added a few people who may be able to help.

Thanks,
-- Nico





>
> >
> > V2 Changes:
> >  - add RB from Zi
> >  - Drop unnecessary check in __folio_migrate_folio(). HugeTLB has its o=
wn
> >    migration system in hugetlbfs_migrate_folio().
>
> Here's how v2 altered mm.git:
>
>  mm/migrate.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --- a/mm/migrate.c~b
> +++ a/mm/migrate.c
> @@ -624,8 +624,7 @@ static int __folio_migrate_mapping(struc
>          */
>         newfolio->index =3D folio->index;
>         newfolio->mapping =3D folio->mapping;
> -       if (folio_test_anon(folio) && folio_test_large(folio) &&
> -           !folio_test_hugetlb(folio))
> +       if (folio_test_anon(folio) && folio_test_large(folio))
>                 mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>         folio_ref_add(newfolio, nr); /* add cache reference */
>         if (folio_test_swapbacked(folio))
> _
>

