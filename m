Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E742346AFB
	for <linux-cxl@vger.kernel.org>; Sat,  5 Sep 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578804; cv=pass; b=PdoplKcHGQuozRwblPbwHPlqZIfmA83mPR33gj8D9ke3pJQApVc3c9zw/FPuDt5EdjXfrRZoFdF8noFsYFR9xs1Kaqd7jxM9zDsLylityfV8HObc29ytAT2j9USIlscdenStxLpIDnGb4x9WbaYgEH7XKx0h7lQnaSGE9IM7lXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578804; c=relaxed/simple;
	bh=Ro5WQFnUyuX6c8ZMaP/vKnPsUVwk4Al6XZOewowjF5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtKgEcuocHBCQFCwFnRw1jg2Afa4uNpQ3ObaM2YVK6pQ1kZJO+3GVxxjKqncjunqrXhczN/Fii/IilbQZQ9O+t01m2echUqeIxQUpoDemc/IHlO9sd8g+R1VKuUF4dPj3NIaAMvdaub0wmUbdAjjEi77VN0ge+6NVGQihlzkyQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iWq4SVlh; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iWq4SVlh"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-87005a0e052so22281837b3.2
        for <linux-cxl@vger.kernel.org>; Fri, 04 Sep 2026 20:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788578800; cv=none;
        d=google.com; s=arc-20260327;
        b=EnrJWVoxap1HmET7NqdpO8h7u8qt8v2aHG1MPtho84CVhCrAgj7CO2mMXH6JmIkglj
         dZKiWHsonQGY+nXooS6BKTFWDr30jJ1JyFE7YF55DdpisXWxWeyFe1yroNx4a4eyTwOe
         boX0ydHB/EGIrXFKlV4ILmQDhEtyp4RMUP8NiZgJ8achT8Io/i7sbTbkHR25uMjE0nRR
         LgOGtkPjtjt3kuteI0ODhREdIbcX0aGYOJjiV/1FQ/usgOQW+EUTHzY8gExP1cdN9Ktk
         mf1Zksf0uvBLo2hadkdoLyUQqAB+TzsR+Xllcv9ofgmC3JBrxGoOEp4MypBunxcsLQd/
         wAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nulUh8YNeX+n+nn9HvwdNzcBQLH+YBQeOJSncThU38=;
        fh=QGai6r+ZN0aSpkpnVe/nUqSyhr7qz1VgAbXyMv4KBdc=;
        b=pWHF3sCLXcPSiMK3pa6urnNDanlMAZITtwtt5yfgfhINzSagBX9os0kWwjR3LVzUmF
         WI6YGLtW4G6ApMmPoER3YjNH8qLi+utjNoKmo9wLIcTUDwcjBBNNonqImneBTTLV26WI
         Zhuu0UOkOhQIg1RZdvN9NLQZVC2zaZ8e5WhFboPLQDZHLejnICEPHNJun2RD80NiFfb/
         StNkDR7CSg0CpuK9UFyJF2oeCKl/19kxY5R9bvP75op2n1CC+qCxRF91aY3sRrPPsJJd
         S/U3YAMHzgsHfvyAfRWfQLkIisvMg3ujwyWterJZpWvkueo9b8DQcmZMVcqzfMyqwkIk
         7Zjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788578800; x=1789183600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nulUh8YNeX+n+nn9HvwdNzcBQLH+YBQeOJSncThU38=;
        b=iWq4SVlhKAkW0P/B/n2SQDRPD0Wn+PQPw3fRV/5mRjZL89eQfEFuXOFAOWK3JGD8o7
         JEGCPlkrCYXKmA6D+fmQaQWsPUWA/widZnaJtGXVHNUIyK39VbmlABaZhYEriUtm8O8q
         UQXuPgi0RxulBF3fW+NLyNkXkWXo2pPM97OLwyafz+KNfcO01WOHOawxszZbx0QKcjl6
         KYKk5DySzNKMK6t3TmEWv2OUK79/QtmzbozXUbJcc5gAITFOHG0ORbNTQ28ZscE/4b5K
         KtlvHUVncClu+Q0nyfmOXB0axFUZHGISrcaEQo2tDeVu7PkeiQ07H4OPOKaM4SzVdmhm
         fi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788578800; x=1789183600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nulUh8YNeX+n+nn9HvwdNzcBQLH+YBQeOJSncThU38=;
        b=ZEuF1xIcVxoSXffxKTx9gF3Yqc72VjVvpCe31eDGLJ14FyOfDhFtWXKDEk5Zc0iL4p
         JxSfHx6raNgAKFfRRV93kMWsZKKLFXOzhj3Pu/fgTk+Qac5U9qyoj6DVqPTPHF7U2I6O
         jly5s3+y4eCeMguTwzAisNQYzOh6PQf1/8H4t0nwsfGQ5ivSx0ZX88idLdY7nICQkDiv
         p6C+GoHR+0sxbBgFc/9W4sdSAAkb/lWU6mQTGGzpWj3T3n+ZTZxz/l78o6YlxhPf5VWj
         6IyUhcK9AtV3hHwGYnaCNsun/xwrhjp40mH/QfieAHGYolJhONuRGBR+jWUv04YJguur
         KcDQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+7eYeSskcThtfBktfNta0NA89S3HKfif/3arZ7LvSGT0zTkLpgSOYo+6BGHRh1fPr5WlNVguAKGY=@vger.kernel.org
X-Gm-Message-State: AFuF++mJiKGeW84kcIewNjHUEUT6wjfFhJXMaQDNgSFQqytZIaDaRnwR
	SBVho/O37RSL9LhrJqS2AhPOBeVAPusriHY9ivcWYfqiuMD7u7BI3aiRaTYXbVhmncMkzwCb/xg
	vQmYPtvvuylmz/luxY2xCVrznm8zDR4cV3yEscYrOeaQJZMxsa60UYbITdQ==
X-Gm-Gg: AYBFou2MajVWEKNk0GoYCM7H4v9aFjg2im0Lo4W4GXuJgE6Fe1UhEIPD7Blq7YlJBuf
	6lfFVOvr+QLzPVBwYwIt5faYO3qPbMueupJLpkNm8N6WkcILGCMM825aEvsXyLJbyskDdgRNlz8
	JCIj6YDNd5nURyVo8b51BSwDIDCLIikNu3JEjKdXh78sxRaBgKPke9ed+uuusr8DF6juDX8t/ht
	h2DTTyq+S6AKGaJhqGlu7DVyM96CkySlMA102OgvrQA1XvguTH4+lxBxrVDUaCgEZ5PTDRHgDjF
	cxosO/cO3g2LV5EDsKkF1NOhP9WN5wT+bCkEPJiJKyIOiq8=
X-Received: by 2002:a05:690c:9c0e:b0:85e:6840:4ea5 with SMTP id
 00721157ae682-87126e97f78mr50237547b3.26.1788578800363; Fri, 04 Sep 2026
 20:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903122128.12264-1-songmuchun@bytedance.com>
 <20260903122128.12264-5-songmuchun@bytedance.com> <20260903125312.16B761F000E9@smtp.kernel.org>
In-Reply-To: <20260903125312.16B761F000E9@smtp.kernel.org>
From: Muchun Song <songmuchun@bytedance.com>
Date: Sat, 5 Sep 2026 11:26:04 +0800
X-Gm-Features: AcwNN1UeHEvk3zYctxqOtU6UT64a-Esa9ORnfEzCr_q1R1rkedrEbgma7jX-zEo
Message-ID: <CAMZfGtVhb8MMTJGPgsfo7a2VFEGS84VP--_dA5ffY_KykEV53A@mail.gmail.com>
Subject: Re: Re: [PATCH 4/4] fsdax: materialize pmem vmemmap metadata on faults
To: sashiko-reviews@lists.linux.dev
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Global TLB flush broadcast inside global page table lock causing=
 severe lock contention.
> - [High] PMD fault materialization failure incorrectly returns VM_FAULT_O=
OM instead of falling back to PTE.
> - [High] __vmemmap_materialize_page dereferences a potentially NULL PTE p=
ointer if the DAX device is concurrently hot-unplugged.
> --
>
> commit 9e2a623911317e382af87ef795b2fc34f1686554
> Author: Muchun Song <muchun.song@linux.dev>
>
> fsdax: materialize pmem vmemmap metadata on faults
>
> This patch opts pmem FS-DAX into the shared read-only vmemmap mode and
> materializes private metadata before inserting a PFN into a userspace
> mapping. It shifts private vmemmap allocation from device registration
> to the first DAX fault for each metadata page.
>
> [ ... ]
>
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 1fbba0d21c13d..89377301d51b0 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
>
> [ ... ]
>
> > @@ -1877,6 +1878,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault=
 *vmf,
> >       if (err)
> >               return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
> >
> > +     err =3D vmemmap_materialize_page(pfn_to_page(pfn), pmd ? PMD_ORDE=
R : 0);
>
> [Severity: High]
> Is there a risk of severe lock contention and RCU stalls here?
>
> When a PMD fault triggers vmemmap_materialize_page(), it loops 512 times.

No. It loops 8 times not 512.

> Inside that loop, __vmemmap_materialize_page() acquires the global
> init_mm.page_table_lock and performs a synchronous TLB flush:
>
> mm/sparse-vmemmap.c:__vmemmap_materialize_page() {
>     ...
>     set_pte_at(&init_mm, addr, pte, mk_pte(candidate, PAGE_KERNEL));
>     flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>     put_page(template);
> out:
>     spin_unlock(&init_mm.page_table_lock);
> }
>
> Could this cause the system to become unusable under load due to sequenti=
al
> global IPI broadcasts while holding the global kernel page table lock?
>
>
> [Severity: High]
> Is there a race condition with DAX device hot-unplug here?
>

No. The FS-DAX fault path is not relying on that SRCU lock to protect
later struct page accesses. Before dax_fault_iter() is reached,
grab_mapping_entry() has already installed
and locked a DAX entry in mapping->i_pages. DAX invalidation/removal
paths synchronize
through that entry and wait for locked entries before deleting them.

> The prior call to dax_iomap_direct_access() acquires and then releases th=
e
> DAX SRCU read lock. By the time we call vmemmap_materialize_page(), there
> is no lock preventing the DAX device from being hot-unplugged, which tear=
s
> down the vmemmap page tables.
>
> If that happens concurrently, __vmemmap_materialize_page() will find
> pmd_none(*pmd) is true in virt_to_kpte(), resulting in a NULL pte pointer=
.
> Will the subsequent ptep_get(pte) dereference this NULL pointer and panic
> the kernel?
>
> > +     if (err)
> > +             return dax_fault_return(err);
>
> [Severity: High]
> Does returning dax_fault_return(err) on a -ENOMEM error incorrectly trigg=
er
> an OOM kill for PMD faults?

There is no reason to fallback since no memory could be allocated.

>
> dax_fault_return(err) translates -ENOMEM to VM_FAULT_OOM. If this
> allocation fails during a PMD fault, shouldn't it return VM_FAULT_FALLBAC=
K
> instead, allowing the kernel to gracefully split the huge page and retry =
at
> the PTE level (similar to how dax_iomap_direct_access() handles PMD fallb=
ack
> just above this)?
>
> > +
> >       *entry =3D dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_fl=
ags);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903122128.12=
264-1-songmuchun@bytedance.com?part=3D4
