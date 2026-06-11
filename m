Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305AF9E8
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195849; cv=none; b=rzdh4HrjIOtNNYjdPKvz9BsYISP2IbohnzQjY9wHUEI4JNqfNRK5c/Eis4Gs1N1Y0lFw07wbJA+HftFQeCY1K0Pir13z3tU7UwfWJUKeuh+9apubSpIntzGJb/OfuGzjex7jVvV78sSr2RK7HvlRkaWmhIIOnAWKVPJBVzNN0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195849; c=relaxed/simple;
	bh=YqpjZ2mJYo+OscrePw1sjkzQ+nl0rlFsGa5QD/lhW78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDldYXsyrJpk3O1NMw9tPVALOu2/luS2+TrJFigbxNJcgj7YIxM7H1+uWQNgOjzOmZJGBilYPzPzi1VOV0+idA1VUOX9tsZx1NV6He3xsbE+19taQxToBsJ0UcupIpgZ8ZpgaTMsvDicsLX5ueraj7yNcj5HdCVeIJBiB3RrfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy7H0iuv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy7H0iuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781195847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lo2BJAapvZJXWOBDzrRCDmN5WtMov6d+Ohtu+DitNMw=;
	b=Gy7H0iuvwtQLYLxnJ9X3AxhXcQ5dXhoz8rwlEuxg2FJjkLZ4MPuXX4jh9g6qNSuQ3up9h8
	2wjDhIqslmwEUf2GkmQvQlje6Bd8tJ/nVLSU23d67DShuk/vNNB3atFOGK+ACPhODKwf+Y
	Y3pDoHFhki5sLhtkOK0rt2OHNnNn9bU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-FiwRCI7WO6SJyHgeRmjzRA-1; Thu, 11 Jun 2026 12:37:25 -0400
X-MC-Unique: FiwRCI7WO6SJyHgeRmjzRA-1
X-Mimecast-MFC-AGG-ID: FiwRCI7WO6SJyHgeRmjzRA_1781195845
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66053e40709so113683d50.0
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195845; x=1781800645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lo2BJAapvZJXWOBDzrRCDmN5WtMov6d+Ohtu+DitNMw=;
        b=eKq/Z4eXwoolqotnkhFnJKzAVQVEPRgqRN6WR2kH+Om3kdY1E7cSTTmXhfyYZ9TS50
         plNHW0K1HgzqZfxmTtfFvGxrNncrep56pgJxPhhiY4g60IKQwKaWtXoQa48znzE1GLbw
         /toakp8z1F11PkxMVSvF7YHbs74BP6YSJd/lIZ3k9a6MBrtdFGAP2KXRMCtHwphBVWla
         NaXgdtayxIJyX/hB6FNDqtTxqcDr4F5+WSA6sNqDX2PhJhPGFfj6OXdEaJBaXXqpIr7P
         mpxnrMTX8w1elkGskBS2Ld7L48XkmFzH5zDQewyJzCN08cIXFE+Xv3Xt7RnL2lqpPeAo
         3Vxg==
X-Forwarded-Encrypted: i=1; AFNElJ9vOrEtkpbSK9SaQIld8evZubQqESKKw7rUjq4Uglyxcxam+pleJUVqmaSMhtbWGrUJdT6K7kzIfvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGeLxjn4D/JoWXd1LTzD+RMazAeV2KLuc+Y193YYDZE319Tmv
	OIZxr0Mdco/VmAFritBBrpFNxT19DIzvJbXOF16SlSa76WOVXTeoPNAKb+lDqZP/dE2sD1FyZGn
	Ki0zUoyaULcJawniEGihnFXt6/aJZ2Eiy5HscUWHWr3ILlQ2/jVPPz6Q4f5qOhUJBoGpWzXiB9g
	NUO0YUbn51niVASoFu8UkUpwPBbsVw4TO2tkB0
X-Gm-Gg: Acq92OHX+ELKWNl/YyM9Q/Y70Rhy3abEPQrwORfhNq2dXToQ21F5D/grfVTjuz6HjLE
	3oSrdBzGgnYqMeM96vL1jotLfnDGmi0CLhmGA4amZgP1WM45okm6AfLkWcqmPsD2uwa8dD3tRue
	1EKS+QtJmZSikL5iSePzcXvTx+RRekHvCQiD1vqiI8BtZ4607+iob5WctUPu0AedNQ1gkoWAvZZ
	N+m
X-Received: by 2002:a05:690e:1c07:b0:65e:9e71:7942 with SMTP id 956f58d0204a3-66269821a84mr2395912d50.37.1781195845239;
        Thu, 11 Jun 2026 09:37:25 -0700 (PDT)
X-Received: by 2002:a05:690e:1c07:b0:65e:9e71:7942 with SMTP id
 956f58d0204a3-66269821a84mr2395891d50.37.1781195844844; Thu, 11 Jun 2026
 09:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>
 <7e7cbc60-e9c7-4a63-9d4b-4e8fcad7bfc0@kernel.org> <58760bd8-4979-4fb1-96a3-eb94f0e8ca0c@kernel.org>
In-Reply-To: <58760bd8-4979-4fb1-96a3-eb94f0e8ca0c@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Thu, 11 Jun 2026 10:38:12 -0600
X-Gm-Features: AVVi8CeRiWREUqKN2Q_Og2MjBU5y5YTHpA1HPOjpENVr0n3Tq-KSA69EjhcH1X4
Message-ID: <CAA1CXcCuk+3T98i01fAbQ-MSDX-f6ZdpE7kTbC_TwKObJ9siwA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: CQDE5lxb0bPwSm2ZIMzi-QfOEI_OvOLu1SDVfFgklr4_1781195845
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:24=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 6/11/26 18:09, David Hildenbrand (Arm) wrote:
> > On 6/11/26 17:58, Nico Pache wrote:
> >> Hi,
> >>
> >> While testing my mTHP code I noticed that mm selftests caused an accou=
nting error in
> >> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon
> >>
> >> At first I thought I might have caused a regression, but when retestin=
g with 7.1-rc5 (without my code), the issue was still present.
> >>
> >> This issue occurs in two mm selftests:
> >> 1) hmm test
> >> 2) migration - private_anon_htlb test
> >>
> >> I spoke to David about this and he suggested the following diff which =
seems to have solved both issues.
> >>
> >> David would you like to send a formal patch or patches?
> >>
> >> Cheers,
> >> -- Nico
> >>
> >> Diff for (1)
> >>
> >> diff --git a/mm/memremap.c b/mm/memremap.c
> >> index 053842d45cb1..683a77dd679d 100644
> >> --- a/mm/memremap.c
> >> +++ b/mm/memremap.c
> >> @@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
> >>         mem_cgroup_uncharge(folio);
> >>
> >>         if (folio_test_anon(folio)) {
> >> +               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -=
1);
> >>                 for (i =3D 0; i < nr; i++)
> >>                         __ClearPageAnonExclusive(folio_page(folio, i))=
;
> >>         }
> >
> > Wasn't there another issue with hugetlb?
>
> Just realized that you sent this, but somehow my mail client got confused=
 and
> hid it.

Yeah, sorry. Thanks for the message about the email client setting I'm
probably missing. Thunderbird may actually work for me now :)

Cheers,
-- Nico

>
> --
> Cheers,
>
> David
>

