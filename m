Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA83C3C0E
	for <linux-cxl@vger.kernel.org>; Fri,  3 Jul 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083393; cv=none; b=s0bIJw07/agoqFCcF4nRnfCBY6q6bARnKFODpar2IgxiH/L4nYN2RLmyw0JHJ5qp9xzG4pfxaV0shl8vtqoV8Xcy/Sq5QEeaphbesJ5W2nh7jGcmm1eKEZOVNsiClpAnwWzOSarphAbb+yysFgMFsHY3/d6K6o0vtw1JLJ3pTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083393; c=relaxed/simple;
	bh=dOe0rEJMcDWi4szhcoZXofeoCXzFBelBTDZbHLHN0/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5ete7MAlNiNiQhqiN7KjnCIXVj1dw3XhPqWewMdQdfUbvzglRdruVOq9cLlrOAFagwCWbbdWs5oQZEuoxK0d180uBeTv1aokzoe7XiGMoWZf7ArrO4v/WGAj4rf7rniLoOHtvC8ZJY4dsc+wObF9aV1gj56T2XvMnHHBM3M5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdePjsOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdePjsOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783083390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HED6HRnydnqiSVH4UAUTFWH58XzQx39lyeEfirFqz7M=;
	b=RdePjsOQhMu7qxfrFkRIpa7KvkDAyBpZ3nnLZjLIKe3lieU8DmbgxIW8Im2bCiCb5IUdzj
	atYTmdPzkVzFDcb5qXFWgMmmaYP28v6PRbygssuW9w9+mf85J8UVQejH8FAJfowqPRQmZa
	g2nPaYHrYMWv2VaMSrUrHgO43SjumEY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-jfiNwM-NMz-oo72eFpuvOg-1; Fri, 03 Jul 2026 08:56:26 -0400
X-MC-Unique: jfiNwM-NMz-oo72eFpuvOg-1
X-Mimecast-MFC-AGG-ID: jfiNwM-NMz-oo72eFpuvOg_1783083385
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39ae216b900so3148341fa.3
        for <linux-cxl@vger.kernel.org>; Fri, 03 Jul 2026 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783083385; x=1783688185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HED6HRnydnqiSVH4UAUTFWH58XzQx39lyeEfirFqz7M=;
        b=BRXzPksws9uxUam4zbCfp785DKUHWpQqabpv08zBUJje9Sa9S7twxy731nuPGS94JF
         hXLodzJkwLmdjdbIRE99GDP9sVjCtgOjN4SJDncQBcnq7H8gOQ1umJ+lPnhhNKh6k4mO
         isjnjXKfTKMONnzCk7q5RwdEnxteV7Q03Z9Kjx1J1cLJxqB1IJggmKo4AVcQ+KjgiFVA
         ZBiMD456gP8MBQEQQAa1nFCE5P9XoX7SjDMSigzzSkXRTuPeCoR47gDYgvvJPrqgoMoE
         UJT3QdxYFw7p1bFb7kzuO9EEfjJ9f4oqxR07GIzujQce8f87SAjSf1XQdiWOq8uO1/cN
         UHYg==
X-Forwarded-Encrypted: i=1; AHgh+RoEQcJfebxQegYnDXM5JRFnnn4ESKX71XsxwBdnXznuqrfr2YnFm7aO7OvRtgyF/oGZEIWr1hmko/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnKZ2auq5LCjeyfadduXqSsRAs1r/bQpVwSvNxJvaDXMEUPpY
	xjRt4KxtBLwaC/tgsTpiQ/YrkLn57edfsFIwvyGFIxJMVG6vxObym1kGWxbYS4Hbe117NMCKXGP
	QDQ87SdWpW9F0K+ju1OAYCvxGed0nZbVSDI2FZ5H+jkVVrixD91cbTknPGl6g6q7BkXc50IyZD2
	eT+q7KHB4rJLJUofzcdIVL+NJaBs954y/LH42H
X-Gm-Gg: AfdE7cmmqRsw+3JhfC/dGvz6EYd4z0yl+Ney/TOHGbeuI+2wl42tg66hfsAFd2wI6UR
	TdWBccauATc9zGxpDpJLSo7ynh99Hr/kRUXC4klEgXqWrWHVMzkGBTJLUMHHDNunJlH387+nXzF
	RbUdSDvUbRf1n4ou9h9n/LKRzWCjUN3eGtlOFqBySB/wDmTH6aff71rWK7cMWLacZC
X-Received: by 2002:a2e:bd16:0:b0:39a:e7f6:49aa with SMTP id 38308e7fff4ca-39b36f0dc25mr21174981fa.2.1783083385212;
        Fri, 03 Jul 2026 05:56:25 -0700 (PDT)
X-Received: by 2002:a2e:bd16:0:b0:39a:e7f6:49aa with SMTP id
 38308e7fff4ca-39b36f0dc25mr21174701fa.2.1783083384715; Fri, 03 Jul 2026
 05:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702172548.37075-1-npache@redhat.com> <20260702172548.37075-3-npache@redhat.com>
 <4c67ac7b-e021-4e4c-ae5c-07bfc0fba9c6@linux.alibaba.com>
In-Reply-To: <4c67ac7b-e021-4e4c-ae5c-07bfc0fba9c6@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 3 Jul 2026 06:57:34 -0600
X-Gm-Features: AVVi8CfzTBD7feuDGQNv3STuJ_PVTWfd_G02diIzr1_4eSFOGvY8Pww9hOYi6es
Message-ID: <CAA1CXcC561g+nmAjB9Muvi4rsOYPgbud5USmJnxivV0RDYU=Vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/migrate: exclude hugetlb folios from
 MTHP_STAT_NR_ANON accounting
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>, David Hildenbrand <david@kernel.org>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	willy@infradead.org, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YpVeCZQV86elrbSzZJFcKrC71fO3b0Gre5cIzdesnAk_1783083385
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:10=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 7/3/26 1:25 AM, Nico Pache wrote:
> > __folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
> > destination folio when `folio_test_anon(folio) && folio_test_large(foli=
o)`
> > is true. However, hugetlb folios satisfy both conditions despite having=
 a
> > completely separate accounting system; they use hugetlb_add_anon_rmap()
> > which does not touch mTHP stats, and their free path also bypasses the
> > mTHP decrement in __free_pages_prepare().
> >
> > This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
> > migration without a corresponding decrement, permanently inflating the
> > nr_anon counter.
> >
> > Add a !folio_test_hugetlb() check to both places in
> > __folio_migrate_mapping() so that only actual mTHP folios are counted.
> >
> > Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
> > Co-developed-by: David Hildenbrand <david@kernel.org>
> > Signed-off-by: David Hildenbrand <david@kernel.org>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/migrate.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index d9b23909d716..9fd50ea25d2d 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >               /* No turning back from here */
> >               newfolio->index =3D folio->index;
> >               newfolio->mapping =3D folio->mapping;
> > -             if (folio_test_anon(folio) && folio_test_large(folio))
> > +             if (folio_test_anon(folio) && folio_test_large(folio) &&
> > +                 !folio_test_hugetlb(folio))
> >                       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_AN=
ON, 1);
>
> Yes, anonymous hugetlb mappings can reach here, so this check looks
> reasonable to me.
>
> >               if (folio_test_swapbacked(folio))
> >                       __folio_set_swapbacked(newfolio);
> > @@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >        */
> >       newfolio->index =3D folio->index;
> >       newfolio->mapping =3D folio->mapping;
> > -     if (folio_test_anon(folio) && folio_test_large(folio))
> > +     if (folio_test_anon(folio) && folio_test_large(folio) &&
> > +         !folio_test_hugetlb(folio))
>
> If the hugetlb folio has a non-NULL mapping (i.e., it's a shared
> mapping), we should migrate it via
> hugetlbfs_migrate_folio()->migrate_huge_page_move_mapping(). In other
> words, shared hugetlb mappings should not reach this path, so this
> hugetlb check can be dropped. Or am I missing something?

I double checked (and others seem to have confirmed), you are correct;
these hugetlb pages shouldn't be reachable here.

Ill drop this hunk and retest :)

Thank you,
-- Nico

>
> >               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
> >       folio_ref_add(newfolio, nr); /* add cache reference */
> >       if (folio_test_swapbacked(folio))
>

