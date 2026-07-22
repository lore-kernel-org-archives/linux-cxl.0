Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D541470E8A
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747846; cv=none; b=pjdMWcwlQgigIZ+m3chi1RxiyWumaPBXLVEy3q6ndCwxfnjjQ45oYNFMrLZQqYZEE/eWrK95negxBFB5/7WKqsxNMDnWX51i+tsLjtszK+IgyntfhDMhWlCqL3BGZj54ZvpeHRXuI92IAF9cYn0/b/Cc0ApDMTk9Dd5HwleYSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747846; c=relaxed/simple;
	bh=oRVP2YqIK5Fe0gQiceXBodZWa/MEMWHrbUr9fFfXFQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFIlCtQk9f9UHNiyuxJxZ9QDLp4KhEs4y/kPX4Y2sx+pv+Xv9Brsf6Xpb5fxqx5CqGG2VUkqYlClj8p4blLS8u5NFK8cQiF3G0iIBjz7kr++6OsXHsSACw2d0NuZtFXHjXMvjA9/wFXOF1qM12DRYSA5H4xfesdohcjg4EmhFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig5RPG4P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig5RPG4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784747844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgADKQPfJd1AEoeiRdVbxkdpyLJkdcTqBLoWey7SyyQ=;
	b=ig5RPG4Ph6EUKda2FgNhUlBNMekDDchL8BY9iL5RL9UOn10YFCDcuhbIqjzP1FFiDqt75Y
	1Y9HeF7PG7CQ2h5EqLk3hHnLkI2tGQX7cJ379blVtdxfSAfKeMH8BqTvuQ/7YnC4hvYKyq
	K+LFJvEfnkHTXcv9fCntd9HknfW8hEI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-tTD_OZSMPy681rJVpZrByA-1; Wed, 22 Jul 2026 15:17:22 -0400
X-MC-Unique: tTD_OZSMPy681rJVpZrByA-1
X-Mimecast-MFC-AGG-ID: tTD_OZSMPy681rJVpZrByA_1784747841
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39ad467f184so79945821fa.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 12:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747841; x=1785352641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgADKQPfJd1AEoeiRdVbxkdpyLJkdcTqBLoWey7SyyQ=;
        b=OCst7A2hl026MMk/9JUBjMcKuDlNxh/TbZc0Hje2AuEXwYH0LeY2t+iiJcKDBlChHV
         MGGGj1jfKaSnbGY9nvl9RzVnKPL2Iva8ZTtzkFdDc3J0vLmDRj/yLxlrGlKz4sIPhJmn
         cDWQXUPYHC2HIKlYRyrnnBSyH/GPoUO0hQ5c3kv5retzNt2dr/nq5CeVOgs8zreLkUTi
         vWcEkmuGEUz+iBwL3auWWkwgAP/eXVyOZ0edtcnZYDxYbtFce8o5LNDP8WuAzmFf+uxY
         +n27o6c+j3N9Td+NhdTMf+Bqokigf5wT9p3Vo0gUgmQGthdGSoVyse50Pf6CmHFe6dLP
         7JuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDAgUx0Gs91tuoNJxiOeYun4WAet5crSGO4qJK0wMpMdwyCT5YOzWjfsyF8XSsDhUN25AM7CbFRik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5rJdHOE/gDFlb2f+oMWEwql83xHdeb4kgajEFmW0TorW79A4
	H6IBHd8N0P8oJ1p69Eh/cKn32ijixgnlHVojKhNX58lbZglAG3Mw6I7BOoyNHEo4kBiwDtO1Ib+
	HM1HRz+LHtqAv3BDZBv0mDSi2UFlId92WDi6L9v1hWrJNFw/3B8pR0cgfnhtZ0s0dWWk7iTYdIk
	1rBx3tKplts6jL5iftj0PBH28tix6mtjpTI5lz
X-Gm-Gg: AR+sD10IZ3Fap0nLeoJ6yAvfEjKUCcnpdjfjEu6RwAf43qoaZB7+D0P5aqjS4687o4z
	FiLR1D5rw37SqkowoG6GrmRDHmZhBfdEbw68zlKhyBVYYRzArAus4f9gatVTEJjdW48MtjdaixJ
	C7T4k5enqIxV+95uUHpiHBW/y/6XKfg1IfFdNou7qpseH4n0TMc4cJXQ==
X-Received: by 2002:a05:651c:1442:b0:39c:7d51:70de with SMTP id 38308e7fff4ca-39f07ec9fe4mr5181fa.24.1784747841138;
        Wed, 22 Jul 2026 12:17:21 -0700 (PDT)
X-Received: by 2002:a05:651c:1442:b0:39c:7d51:70de with SMTP id
 38308e7fff4ca-39f07ec9fe4mr5071fa.24.1784747840707; Wed, 22 Jul 2026 12:17:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717064502.1980173-1-npache@redhat.com> <20260717182947.534af296aaa1831d13f8ae6d@linux-foundation.org>
 <CAA1CXcCrA9nrraxVNTdo19TRONvqM-fndSbDaCib4tZCmQC9tw@mail.gmail.com> <5766bfae-8dd9-4542-bbab-324dbde0e2f5@kernel.org>
In-Reply-To: <5766bfae-8dd9-4542-bbab-324dbde0e2f5@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 22 Jul 2026 13:18:46 -0600
X-Gm-Features: AUfX_mxBP6oQ9YP4CSpm6uLN70-PCju-h_3ep9e5ccbsKoOnsmvoI6BqZQW6fM4
Message-ID: <CAA1CXcCFrnw4K+yStkmdEOdfn+9XJd4tXYNyOnBKobLo_WRX0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: fix PMD level mTHP accounting bugs
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Barry Song <baohua@kernel.org>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fduBgLFjznZsflbE01cTazrSnSVHOqiZgUZ53o5zDT4_1784747841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 8:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 7/21/26 15:57, Nico Pache wrote:
> > On Fri, Jul 17, 2026 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>
> >> On Fri, 17 Jul 2026 00:44:58 -0600 Nico Pache <npache@redhat.com> wrot=
e:
> >>
> >>> While running selftests I noticed the PMD level per-mTHP stats (nr_an=
on)
> >>> remained elevated after each run. After further investigation I notic=
ed
> >>> this accounting error occurs for both the migration.private_anon_htlb=
_test
> >>> and the HMM tests.
> >>>
> >>> In the HMM case this is due to folio_add_new_anon_rmap() incrementing=
 the
> >>> mTHP stats, but never containing a corresponding decrement in
> >>> free_zone_device_folio(). We solve this by making sure to decrement t=
he
> >>> counter when freeing device memory.
> >>>
> >>> In the migration case, we are incrementing this counter without first
> >>> checking whether this folio is a hugetlb folio, which relies on a sep=
arate
> >>> accounting system. We solve this by adding the proper hugetlb check b=
efore
> >>> incrementing this counter.
> >>>
> >>> With these changes in place, the two tests no longer cause elevated P=
MD
> >>> level accounting issues.
> >>
> >> Thanks, I've updated mm.git's mm-hotfixes-unstable branch to this
> >> version.
> >
> > Thanks!
> >
> >>
> >> Sashiko is worried about the existing code ("list corruption or a
> >> use-after-free panic"):
> >>         https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache=
@redhat.com
> >
> > https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@redhat.c=
om
> >
> > I dug into this, although I'm not very familiar with device memory.
>
> In general: Don't let a tool waste your time on unrelated things if it wa=
sn't
> you that asked the tool for it. Someone else asked the tool to find unrel=
ated
> things.

Ok sounds good. It flagged the same issue in both of my submissions so
I figured I'd investigate. It also helped me better understand the
code by forcing me to dig.

>
> I thought we only support anonymous THP for device-private, not device-co=
herent.

Device-coherent has PMD support; albiet I dont think there are many
users of using the MIGRATE_VMA_SELECT_COMPOUND flag.

I think Matthew is fixing this from a different perspective. Teach the
split code how to handle this.
https://lore.kernel.org/lkml/20260722044220.1110278-1-matthew.brost@intel.c=
om/#t

Zi made some comments about it there.

-- Nico

>
> Maybe lib/test_hmm.c could somehow trigger it by selecting
> MIGRATE_VMA_SELECT_COMPOUND?
>
> But in migrate_device_coherent_folio() we have
>
>         WARN_ON_ONCE(folio_test_large(folio));
>
> So this would already be pretty broken and I wouldn't spend any more time=
 on it.



>
> --
> Cheers,
>
> David
>

