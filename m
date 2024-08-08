Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C95190489
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138704; cv=none; b=o0J2ZuEShZCdvmaVLLRoIlm/OBIqKEya1gaUSCX93rrEJfTEbIdU1V1ToqOyRc5PnQkGxXDdXtg+rlr+1HK1LT6Wok63g0ciFF7WU0bEBK0ufBmLyYx3e1Anz+6VstaWfuqbt4hSfVgnoz47t/R+4q5VSVkKXnYUIXz9kmMakaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138704; c=relaxed/simple;
	bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UctToyBK9Vbz++xleCVjypOmk5Gv1gLTrH5HS3fdI+X6eO/rl7bnCEaWsxa2HIHyodzx4Tz8LfeICnn+pDhPB2m60nd1HlHi0yXUT3KgHrrZHrbuSvSK1EWhX7Op4pKEYvykGFr40yVSixiuRR0ANeCiXl6XqNC5G2IhxVN0HoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=oIxak6Lm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="oIxak6Lm"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fee8813c3so7605501cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723138701; x=1723743501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
        b=oIxak6LmaW+ul2TX4KeGUUm6OxxMbx4lz71UosjntRsf+GPlspIb9QMRQ7FhJxgR8e
         tk7l3C8aKNJl4Fan9fmNB/gpPNGK9GMxccBt46r1kFf9i91HRB4bqUMFwpkr3aG0JNpv
         IqwdCWh+mEL3M2PnhrAnlkaLeqgZsmYPGFb5lggkINlLrNLituTTHf8VUiNTt5YMYWFI
         Gt1smUAdvv/OEo0SqXKyXcg0djrjCKJj8XH8ygjZv161G+/AqY3e2AkgH1U70Gz1jZ6N
         n+Y0Ba3e+dgQXVunJ2x67MJf3yquZI4AZI9uput4JOqU9oPHnBMb+1/WhO32nq5+o6AV
         Il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138701; x=1723743501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocAJDrTQkqPtVrAouvpO6jBQST6L6jBb7w2tfCG05PE=;
        b=mifpFKnWqfEReDhHPV+BOyVBczte1mkgLszqGoDdzMrfTZHqiSlZ3o3awB/1OXsG3j
         kmP/pxbf3RiuGWaZch8bBjIMHEUdfiayYijNFFZu+zPpPmSphxOyaS10CfQRyZr9qjR/
         84RhFdSeWhyFY1fC/ufLrYW+SmfB9WZBaE+37tcPgBrI8d0YJ703libsgfCsJvRIUGCM
         K9qZgMLJmyWcNtLo8m6HRiFtx9ZezYKue7Kj34xeHCNEx3h7+9ooRPN0uoImsDu5kDvV
         4o4M4hVEtLDv8kJqUBduKQaYDdWZ+2igMSG/+lM1FARPQ2iMKNe5eSyk/YuWZo7L/MfR
         TWTg==
X-Forwarded-Encrypted: i=1; AJvYcCXb0cbApJ37xxnardVJr0FoaBsWxxzzcXKbowZHikPcW83AICUcnOYxgt9MtnqU1CQT8JOr32udFMbe+FGnh7gwSRVv9NiAJwCB
X-Gm-Message-State: AOJu0YyDdvBfB5If27sDH/t7/uoK6OZ5M9yeLF8jrOUCz9pXs0yv/Ivw
	AVTJDoicYt882/8exCGq+iGmqJ1qkVie++88zgEJMlC6hT9fLgyami2Lkt9G1hZnGF14HRF/70n
	JjH+BB7Sd1h9ziKqzHymNXCPocNgEbSViU9n3oQ==
X-Google-Smtp-Source: AGHT+IE6o0qf7cNLixVlu3yVupxhxh/ptXeCvvwc+dwwETtd7M4Sg8SqgxhhW/X7CIyOeHv/Ao1yGWqyQOb5skvlEoQ=
X-Received: by 2002:a05:622a:5509:b0:447:ebc3:bdaa with SMTP id
 d75a77b69052e-451d41fc177mr34125541cf.9.1723138701270; Thu, 08 Aug 2024
 10:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-2-pasha.tatashin@soleen.com> <CAJD7tkazuUKaSv_S+wQ_PGSJML=0-kw1VKFmnqsDjVenBoO--g@mail.gmail.com>
 <CAJD7tkZarKQ5kN26r3hUQUvj-mWZ0fDMw+yPuSdrUU+XtTxAWw@mail.gmail.com>
In-Reply-To: <CAJD7tkZarKQ5kN26r3hUQUvj-mWZ0fDMw+yPuSdrUU+XtTxAWw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 13:37:44 -0400
Message-ID: <CA+CK2bAL7eEFh_CfYbYmc3oR-iPgGq9zx6-ghAqf62DiU79A8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: update the memmap stat before page is freed
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Aug 8, 2024 at 10:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
> > >
> > > It is more logical to update the stat before the page is freed, to av=
oid
> > > use after free scenarios.
> > >
> > > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> Actually although I think this patch is correct, it shouldn't be
> needed after patch 4 because we no longer use the page or pgdat to
> update the stats.

Good point, also there is a warning that pgdat is not used anymore.

I will remove this patch from the series, and clean-up free_page_ext()
by removing pgdat, once patches 3/4 and 4/4 are reviewed.

Pasha

Pasha
