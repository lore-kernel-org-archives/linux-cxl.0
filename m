Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19C8564F
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704206; cv=none; b=PLmbjf34LikcTYlVjn7GEy3ds0RmFvK+l4wo9Kem5RvRZhDWazR1I7fWJhJrr/SbPj2A4MIW1JtokXA6ldUPmliGeQfmcsDzjDLrAa2GASqkITCX7/SV3tFH5SqQ/04DVdKLDzwHvYHdQ76KcBmpWzEgNOyCliaw2hoMMWF+EOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704206; c=relaxed/simple;
	bh=MnSBREf1/ZfgMhsdgHA0pvIo22AgghcA4rYn6itMmko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6ntfO115nrzUFjX3PJmcEH/3wciBmV7fYA0401G5WPB8OIvHMXCSWJmIklzqdmhI10CTT/sQfkT0HBXpd72R1tZmFulLwwcpVOjy/3zWPBE24ok6+gnCB8N64azOUWrb753SxE+FgdPSPYMFLtYalW+03HEsbCtl0nLtTLznCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lHXtJi8P; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lHXtJi8P"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so4666672276.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Apr 2024 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712704203; x=1713309003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
        b=lHXtJi8PI+x57bhfWrfVxHMmH5ZBk4DrD5/0lSFHvimPxy/HahcG/uX4eCJWs/+gQU
         rEn3i5g/mZBbrrWslTTH8obEeJcXwbUxmUzMeqniC3mfG4x0/3IXWYkIG+XEXaTgHPs6
         KTZAWCuPBlwp06JLkBk/wtmmM/9ZZoNI4ELsdcUxCyXy8etcE9/T0Jso4oxj/oJ4PMWS
         /J8DnhmD8qIZCN7jZXaL4z6gE06SUpw/xS3q58o9k91ByOYQSKdQ6lD12bTZTRW/dQWT
         li/AGe7rxB+cwDYV56Q5Iif6Hiu5L5Arl4K4kkX/k/1Nf17HDE8EeL4fPevNzjAB30uQ
         YjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712704203; x=1713309003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
        b=ayCB1F/6OUfhHK27Idg7yH38Bz4FZrXyAkb1eK0ooOEBHDmriiPsygxkOvzzVaYoop
         m9fIeQDJM9Ww/6RKyJQQ0TpxIP7u2z1+Cv6aSdZ7gQ0ckUcK79sKP6DmxgAdtKKF65Qw
         Zuf5bJCQ/DoCZYqtux7SmCJFlg/4qIz1lEG63Q3IMgDjwSzRttZlTVz36Ia8lFgkd+5b
         AHQ5cz+eYXT7xDh7zwx/tjZj89ew3VLMzp6iuPzgB0oBmixhYmVa1mNwhKPuAGmddUh3
         4uP02HXYqSYatAV73Q6sd5cAg02V0456URu1lyPICehfzo6zSj8WvfI+MWZqygrQYxYM
         p/ww==
X-Forwarded-Encrypted: i=1; AJvYcCVYb/uQnLTzecqq2DYmPljk9cg4Y25gD6TGaZ7TfZosYuOkxfF9aB3BlxjtTQbytOOfB+d+8RT0b1WzirFCFr+gE+kTOREXps/L
X-Gm-Message-State: AOJu0YzrUff+Th8tQCWMGYJf7muLLtw6fjTctFSN98S4SbflWEeLyzFm
	Q77GmiXtbOLzTZiLueEVYx0pzQj1/41u8CApl3ecDO3tG5Jnp8mNpXqQBfrIvhIisEuiDWjlzE3
	Miorsq6nkbs8UwEr3RTy0KTc8j2U7e7CHnfNp+Q==
X-Google-Smtp-Source: AGHT+IGKj70giI0uSMILbO3VPM9mbHT4HM6rigAIadI6TUaytzdkRQBEfqv4b6oKHX4IAAJuxwSf30E0yhjaCwWCgiY=
X-Received: by 2002:a25:f306:0:b0:de0:cd0f:e9ac with SMTP id
 c6-20020a25f306000000b00de0cd0fe9acmr2372195ybs.31.1712704202827; Tue, 09 Apr
 2024 16:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com> <20240405145624.00000b31@Huawei.com>
 <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com> <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
In-Reply-To: <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 16:09:52 -0700
Message-ID: <CAKPbEqqWLrD-bJiyE9Yc0CYLh_8_uMtf+9nD_eenXh3S=Ro=pQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:50=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 9 Apr 2024 12:00:06 -0700 "Ho-Ren (Jack) Chuang" <horenchuang@byt=
edance.com> wrote:
>
> > Hi Jonathan,
> >
> > On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri,  5 Apr 2024 00:07:05 +0000
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > Since different memory devices require finding, allocating, and put=
ting
> > > > memory types, these common steps are abstracted in this patch,
> > > > enhancing the scalability and conciseness of the code.
> > > >
> > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
> > >
> > Thank you for reviewing and for adding your "Reviewed-by"!
> > I was wondering if I need to send a v12 and manually add
> > this to the commit description, or if this is sufficient.
>
> I had added Jonathan's r-b to the mm.git copy of this patch.

Got it~ Thank you Andrew!

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB
