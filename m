Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839748165E
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198637; cv=none; b=tVwQV/BIRLyBWoZZN8dVX3krWnaUoQRV3EYml6hcWusZNs/wyD5ZQ/oxFHU6XXmiYrXtHVPoN8E56TPizMRMgCFGSVU4QlbtCwS1jU/Twd9kJ1sG+yVY2TfAse1J23gq1kOGhtgIaMaGASVmP9qyz7VSwNyHPr7+CEXHgVfR/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198637; c=relaxed/simple;
	bh=BRUbF8a1/YdKwOWAmSCK+aolTBIptfvRyOxs9xpjn/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBvvKq0s1e/OK2aJDfLksAj1kA5wDRAR3y/ivAA/CcM7/gZykS7Uh4bFtk7S92mepGFQ9LbR5MoDImXjTcecPTM7HM5COK34yy7oSZt4KoZN8gC2ggWIL7tDmI8YPxxklNfNviNk/nytRm0nUiyTgOQMNLbO0r3YT3YNJhDTzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1WsliSe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1WsliSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781198632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6i8jLVdQ9iH7gHU8yzBEQmG3u/XRRqWxD3Id53UKfb4=;
	b=V1WsliSe8NQ6W/jTvRObMuOoLbSfjpCwG3Ao/o+jFqlhWINZQ/jsMhbo+dpFgdfuka+zwG
	gzWswL+VPMkLz1qOZ02+53OflS4RE8CeLXBOFwDb+kAW1z8QFu7dA4b7F1SZauvniR3gwb
	Oh+JmMP3DICx+EEArKRcEBBF6WvKluY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-uxMiTfO4OtaygQyaf1bK9w-1; Thu, 11 Jun 2026 13:23:49 -0400
X-MC-Unique: uxMiTfO4OtaygQyaf1bK9w-1
X-Mimecast-MFC-AGG-ID: uxMiTfO4OtaygQyaf1bK9w_1781198629
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66032d92cdeso80357d50.2
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 10:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198628; x=1781803428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6i8jLVdQ9iH7gHU8yzBEQmG3u/XRRqWxD3Id53UKfb4=;
        b=mlWUjy6zfev3hZP95uoZi6GrA5wZzw1ieVUBdMjL+f1/xLCMg6YoslKA9x0UvAvD25
         cOwa9VVFcbuAeuyIabqgsYoo0clQs0qEthx1EybS2hAWmbdDraJHj34AaFR00URxM2Fm
         BCBy/dYsJkEatvohgNX83wBU/fVrmrt7YIeRaFIhlBaVUfX9j0UKKq2zhj6Aq3+dWCTK
         DJCR2jeW4WVlbCFuFtM6vSTs6vyVJWR5yI2ryCPu/GN7DQFXCKKKn26aj2KxSYk88XVh
         0AU17u/hIG3EZUe0SPnzBJG9sMwYHMJxA6YqoaddneUQgF5uqtayPdFF6+RTa/t/ehF2
         VG9A==
X-Forwarded-Encrypted: i=1; AFNElJ+ptT/IVR67aLdNH8Lns4powwfFvWg3mDePSKWpF+Mad1RyEvgGnslghCoD/Cw4R3QyY0rCaK/697c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOzv57Z7UvTMFzbB5xnOi09ZaOTDYYep9geQc9sCCAZ74hvFB
	+a5F34TAwX7b2mGU4MLb/AA6VJlNh8htHDcCS6MkX66U3SpxS7ZCUOdMm53BybeMkRiV6TW3cGB
	t8oKgBLfYvCFJzZ+0sSLjCyAJbSl1B5huQwEW73+Lv74Ud+54eMdOYP1GHQZ4evD1HsTCcl9F7O
	Zx0m/2TyIUgmUWvPBWZm6ePp5NO1qyEohw9XNh
X-Gm-Gg: Acq92OGFLrOIJ7o680TB564pFnQEfg9xa0aZkS5ka7oFlzveIIHUf8lBdLTv+UV5IaB
	TG/b3rOx+/msCNdhQidAW45W0L+1xl6hdYQ7LeT8rdk6HSUiX6cNzYuyZ2h0AFKMtrzEOJfnclQ
	VMfVh6nHjB2D6vSGYlU2nU2cjrysggK7DqiI9l5QgU5nki48cLyYMKOrbftbkxTazGvoKOeIL4M
	qQU
X-Received: by 2002:a05:690e:12c8:b0:662:5ec2:8e3c with SMTP id 956f58d0204a3-6626960d510mr2985922d50.4.1781198628586;
        Thu, 11 Jun 2026 10:23:48 -0700 (PDT)
X-Received: by 2002:a05:690e:12c8:b0:662:5ec2:8e3c with SMTP id
 956f58d0204a3-6626960d510mr2985896d50.4.1781198628052; Thu, 11 Jun 2026
 10:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com> <aireq_jrgKH0zsNy@lucifer>
In-Reply-To: <aireq_jrgKH0zsNy@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Thu, 11 Jun 2026 11:24:36 -0600
X-Gm-Features: AVVi8Cc9AyMT0x4hZewByKSnvCI7sNJtuPeLPz0ZADonrkvnlD7gQM_HjWEylw0
Message-ID: <CAA1CXcDbynmd=otyCFdM3W9gV7HseQ2qREMXGU2ngwbHwofwcQ@mail.gmail.com>
Subject: Re: [Bug Report] Elevated PMD nr_anon after running selftests
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-cxl@vger.kernel.org, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 25K5MYmF-ZU1H0Ye8mTuImjXeKPSDCT-ENKrFHoj0ao_1781198629
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:39=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Thu, Jun 11, 2026 at 09:58:55AM -0600, Nico Pache wrote:
> > Hi,
> >
> > While testing my mTHP code I noticed that mm selftests caused an accoun=
ting error in
> > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon
>
> You're not giving any details? how does this manifest? How did you detect=
?
> Output? Etc.

When running my mTHP tests, I always have a terminal with
watch grep . /sys/kernel/mm/transparent_hugepage/hugepages-*/stats/nr_anon

I noticed that when I ran selftests the 2MB count remained elevated
even after the tests finished and the system memory was returned.

e.g)
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon:34831

>
> >
> > At first I thought I might have caused a regression, but when retesting=
 with 7.1-rc5 (without my code), the issue was still present.
>
> Seems to be a regression in your editor's line wrapping... ;)

Haha yeah still figuring that one out :) The guide on setting up
Thunderbird recommends wrapping at 0 which seems wrong...

Hopefully I have it working correctly now.

>
> >
> > This issue occurs in two mm selftests:
> > 1) hmm test
> > 2) migration - private_anon_htlb test
>
> OK that's useful, but what exactly happened? Any test output?

Tests seem to be ok (although the HMM tests fails, but that's not new)

>
> >
> > I spoke to David about this and he suggested the following diff which s=
eems to have solved both issues.
>
> Whilst speaking to people off-list/elsewhere etc. is totally fine, I'd su=
ggest
> engaging with the community as the first course of action is often a good=
 way of
> resolving things.
>
> Even if things arise from private discussions, which is also totally fine=
,
> please do give sufficient context so that the community can engage with i=
t.

That was my goal here :) Perhaps I fell short...

>
> And I would suggest that ideally you phrase things such that you are aski=
ng the
> community as a whole :)
>
> >
> > David would you like to send a formal patch or patches?
>
> So on that point, I understand you're asking David specifically because h=
e
> suggested the patch, but I feel that you'd get better results making it c=
lear
> that you want community input :)

Yeah I didn't want to just send a fix that wasn't authored by me, and
I didn't fully understand it. When I brought this up to David (during
a separate off-list conversation), he suggested fixes within minutes,
and asked me to test. This was the formal follow up.

>
> As one might misread this, and perhaps other such occasions, as you feeli=
ng THP
> =3D=3D 1 person, which I am absolutely sure is not how you feel, but phra=
sing things
> a little differently would help underline that :)
>
> Kernel review and maintainership can be rather a thankless task, so detai=
ls like
> this matter I feel! [and I realise I probably screw up on this regularly =
too so
> we're all constantly learning :)]

Yep! Still learning (and often failing :))

Cheers,
-- Nico

>
> >
> > Cheers,
> > -- Nico
>
> Thanks, Lorenzo
>
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
> > --
> > 2.54.0
> >
> > For (2) he suggested
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index d9b23909d716..9fd50ea25d2d 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >                 /* No turning back from here */
> >                 newfolio->index =3D folio->index;
> >                 newfolio->mapping =3D folio->mapping;
> > -               if (folio_test_anon(folio) && folio_test_large(folio))
> > +               if (folio_test_anon(folio) && folio_test_large(folio) &=
&
> > +                   !folio_test_hugetlb(folio))
> >                         mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_=
ANON, 1);
> >                 if (folio_test_swapbacked(folio))
> >                         __folio_set_swapbacked(newfolio);
> > @@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >          */
> >         newfolio->index =3D folio->index;
> >         newfolio->mapping =3D folio->mapping;
> > -       if (folio_test_anon(folio) && folio_test_large(folio))
> > +       if (folio_test_anon(folio) && folio_test_large(folio) &&
> > +           !folio_test_hugetlb(folio))
> >                 mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1)=
;
> >         folio_ref_add(newfolio, nr); /* add cache reference */
> >         if (folio_test_swapbacked(folio))
> > --
> > 2.54.0
> >
>

