Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3212C7FB
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143832; cv=none; b=BZUzkgxUntgS4Pzarziu+sg5+zkLU1ChTRarx5ylWidY9K2/8rUwtnQ6EBcCrCJJVWbEC7ACFwuNncrvvNJeJ3w90wakUDCDcnoT+HH3qItTj/kj7eCDCN04gTOa2jqJrBHbZOsSzN+vtUdKozsYvSO3+TQYDeTlqoLYhVYEswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143832; c=relaxed/simple;
	bh=wF3eSR4he3cxhVVV3Kr41yFivYxoCdqFCJsVBQ+Ik64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em0KxkYJrhbYfqGqanU2YRSOEYZOoleRcd6uAe5CjnreIPq73SW1xJtfJ8QJcy+Vn1tps9KlB83e2BJ0Hzar9yNPHeTvwG6Icm3E1H5DqsV4dRbVo/S7OcEkVD2seAZ84bbDCOX7WkawtNvoKD11J1Gi75q7NsfXK2oCxEWzMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LuCI0TzI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LuCI0TzI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70943b07c2cso810243a34.1
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143830; x=1723748630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJD3NMKxCdaaPWikegeFRbNee15HLPMi9fn1KjdIIdg=;
        b=LuCI0TzIYnGBrQBHuB2jfaYrUf8Z7BIvdhAdr1mpsTm4PwU2/0BCLqa7HaRFRLb886
         Lp4vL77TCDYetKC1d6XW6cUZzDc6sSRfGkiY17LauCiDaJ34bRikYQc+SowUj3MTYas2
         w8cyBc4L0irl7gnyGfrUevtuiQIwlGD6oRs1v6aPT3SM5w9DJ+f3c/P26v3H/FIxcMdk
         f5OOq7HqzLR9nhzV0OJFScPVN53q6M7pA0iZPnx/k+E/NOE7Xv3YDsSddkOM8HN7VHbV
         z1Xyc2h4+oaSRiifzh13dNvpMYEQppjwqs6aJLRIdOttwWtk5q4wRVL/RWTf/cSUiGIX
         BhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143830; x=1723748630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJD3NMKxCdaaPWikegeFRbNee15HLPMi9fn1KjdIIdg=;
        b=HVQHg+T8v9Xc3K4E6ZrQSRZwmLbngKi1TYbuB3jDAyR38hKbiY2nDoFm5Jt1FylmM7
         H6bUD8pOtyKkCTVn+VtZzDhTlXXztQYvmHoyb7gzt9HQvBw5dR6Gauqm49g3hddLv74+
         hdARG44VpLUA18GwcrO9fQqr19VqOzy5o/emoAvOSmhh1bKRYZnmbj0J7vPLGBqKGig8
         KzjmvV2AghZj50i2gpX+fQwR9YGN+aQ2B/iRUmfKCAlVXVOwhHaV5sBiU+M+ItAkWWNN
         dIdl/ZzTlXRM/0Sepbw+BCOy1cU1Oqv6cw4QEVzb1VUtc7d1lchkoVNp3K7q+i54nDxb
         LFFg==
X-Forwarded-Encrypted: i=1; AJvYcCU0MwDodDTQ2R1GRl0gT/NK6+7GDkyXveJN6b1hgnL7lsj53DMR/oYnVqqRcYeXeGr6RXXXFeRm1J0aziCxRezig6zeR7K9lRUJ
X-Gm-Message-State: AOJu0Yx/YLJajRmKxisKtfqxKiMw7oG6W3UkChD/5s7YG3P6YXoXtj1N
	Nj5+iMNLiFJuu8EEDDeonCNYT0yI6ipvJJE5JAz+0QgRUjvDKXY8fMlqgXFZNOvtTH6Jnx2/FRA
	aiw9mJL8TTkIXK7ac9MljOyXL+cM3N1YuB96Y8w==
X-Google-Smtp-Source: AGHT+IEQca1KIhdNSUI2/4IjEdXBF2eDVBstcisCNWacbs8Zj90oeDvngeCX/YUYlKJXyS6Mli9xj1i7zvInvyLokXU=
X-Received: by 2002:a05:6830:d05:b0:709:4578:8e06 with SMTP id
 46e09a7af769-70b4fc266damr3494134a34.4.1723143830208; Thu, 08 Aug 2024
 12:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com> <490ae360-50a4-497f-b148-ef077b73e911@redhat.com>
In-Reply-To: <490ae360-50a4-497f-b148-ef077b73e911@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:03:13 -0400
Message-ID: <CA+CK2bCxRimZFZkL0CdNhuqD6RmWM6-X3c8+-sUX6NGHn3ULRQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:26=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >   #ifdef CONFIG_COMPACTION
> >
> >   struct contig_page_info {
> > @@ -1255,11 +1272,11 @@ const char * const vmstat_text[] =3D {
> >       "pgdemote_kswapd",
> >       "pgdemote_direct",
> >       "pgdemote_khugepaged",
> > -     "nr_memmap",
> > -     "nr_memmap_boot",
> >       /* system-wide enum vm_stat_item counters */
> >       "nr_dirty_threshold",
> >       "nr_dirty_background_threshold",
> > +     "nr_memmap",
> > +     "nr_memmap_boot",
>
> While we're at it (sorry, I should have found more time revieweing this
> earlier!) ...
>
> What is the unit here? Should this be "nr_memmap_pages" /
> "nr_memmap_boot_pages"? Like
>
> $ cat /proc/vmstat  | grep pages
> nr_free_pages 3618323
> nr_zspages 3
> nr_anon_pages 1053316
> nr_file_pages 3199210
> nr_shmem_hugepages 546
> nr_file_hugepages 0
> nr_anon_transparent_hugepages 0
> nr_page_table_pages 15215
> nr_sec_page_table_pages 0
> numa_pages_migrated 0
>
>
> Nothing else jumped at me.

Good idea, I will add _pages
