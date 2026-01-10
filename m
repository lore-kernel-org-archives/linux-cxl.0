Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB522AEE1
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016858; cv=none; b=iRaOTfO1hUf/0D1eObhQD40GoSTqh6WT17/UxVqBzWuNHqPwxwvQxmm01gBENpuc/0dIYTjU/De1ktfnjmPfgvcBsbtsVumiYtfc81Mf2FbMsXQvONNVGSXtsDUAqvgf1IEtMorZNjiYXcuOP39F3SgGAshXoP10UbFl6xsiADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016858; c=relaxed/simple;
	bh=8UQ4Qrz/nMebM1Isp46fn9Y4Ax/mz6di2vk48sZRFKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwF0/DmT/pCCf7bdHjuTfpensn/cTgC1BlQX9aqgGBQVyHvQQgGIKy5HqlqYtV1VpMfvUN/lYOJZUZQi+WQtsEwGLM4y99LSIGJ3VCpir2TQ5V02Q/Ej8VYLdOCrn4ehVaK0kn+cGsPyjn9BxCSvORJdShGp0Wr11a5iBIxZOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFMd7W9O; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFMd7W9O"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-888bd3bd639so42951776d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 19:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768016855; x=1768621655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnhmeVyJEO3jTJeUnrIAC1snCzGO0yrfi4KApdK0DYg=;
        b=TFMd7W9OsPGTjClCl7sjaGTC0g0uM2UAyWjI2rgmfrXC40W0Glc32tWFjOgtalJEuz
         IdTUi4HV8zYru6ZDRzsXhakEMH3TtvhQ7kuhKQ4Ia8jiGVYBV5G78hagtx753dsXm+Jf
         j6RAyRNvnhbpTQwor9PczlfLbCi0kMQRdUow49FHFWKmhzuR6IxYQjs73ppgLhPHaxl7
         /mfoR+Us8nA1RTtMl1hnwxnRSyFraLNdxMgEx7XzI+qXxa+nl/y4HJCTQqVKntHXchdZ
         fkj7ehf/qjLZOJljviB2gOBModELvl7PxuAP/+YIil6bWWDDvrtEZOALYygBKu2cTtUp
         dpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768016855; x=1768621655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnhmeVyJEO3jTJeUnrIAC1snCzGO0yrfi4KApdK0DYg=;
        b=qVTL+CDa62dxhPsRo5wq67+ExXOmotlwBN0h6ITTBSNFFVH5woKmDd1aLiMikSS1xK
         Vi+x97xn0hJMvI4oDeZHgW0fahekC/NzixZiPMFVUxobdPGMFROIz33OwHRAXZwhtodm
         4mmw1L5uQpMpmxKFK94fQTfj7GdwUO3y+XfeB+IRNpR2U+MV6Y2CZSHPkr2desXd5Dn4
         R6nZsvcQk/aEgIOOyqAvE7JWzp5JMRchWpndjbwpcFs5Theq84FtZjmpwZCwdC9OO3rE
         xCxPQMu5QIjpl87QhrVZKlCn8nIi1PveE0/lE3aDe+Sm0iaj1GjJlcQdmgLu74I+y59J
         4+eA==
X-Gm-Message-State: AOJu0YxkCqNvKManvPKT3ekb4nJUcv5CuWsdXxZuENIw25adXC8CrLqH
	o/rgK/NnFXaQrbKDiZFpjt/hmgvBrZk+vNeDv7yupwREFCUppyuXLJQq/TTP4BCxDLlYNRqFW8q
	sNlQEdcDq7pgAA2R45/KezlNFUsWIvE8=
X-Gm-Gg: AY/fxX5zOmXuDD8FKFrwwZBIFyliuOKULpqDCBtWiFOscOAhaUAmj+mgLPXHb+vm6k1
	2ewSVOtp6HalBPW81FAakn96xO6ToMKRQjyKxOQL+omsO47X/hbfXjkGK3gY0kMICossf4w42vH
	dMySHSfJFnhkNzR2Y7etv1l7A0Hsc/Tf8l2bhp20LoKugBdmo5pB0sbaTwxVGv+C7YNquUFcKB2
	XvzgArrugld0hgSAEuTRivJEoDaOywoGefWNzqRKMMCGOeq0RMZbGWWa478U9BkmdrL0wiJpvF5
	saS6eypYvppTxFhgjsmsufE=
X-Google-Smtp-Source: AGHT+IHDD1bDtbiDilddrvwoiudcMJs16uFjR+L1wKNN1BewBSLw5FdomEQhwTNOHfkVtMMdFR85t+kBvMJ8rtFh3Fs=
X-Received: by 2002:a05:6214:80f:b0:890:7f85:81d1 with SMTP id
 6a1803df08f44-8907f858293mr162757706d6.13.1768016855637; Fri, 09 Jan 2026
 19:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-2-akinobu.mita@gmail.com> <20260108154738.00000e47@huawei.com>
In-Reply-To: <20260108154738.00000e47@huawei.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 10 Jan 2026 12:47:24 +0900
X-Gm-Features: AZwV_QhOcBPU4vb7ub0Bi4ys4AL1T23koUjpp82dgsgXLynGVT42jcEOxUlrmCM
Message-ID: <CAC5umyiwO=b91=A0zAJ=p9uryW1po9D3FoMhfidVjX3yjm=GpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memory-tiers, numa_emu: enable to create
 memory tiers using fake numa nodes
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=889=E6=97=A5(=E9=87=91) 0:47 Jonathan Cameron <jonatha=
n.cameron@huawei.com>:
>
> On Thu,  8 Jan 2026 19:15:33 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> > This makes it possible to create memory tiers using fake numa nodes
> > generated by numa emulation.
> >
> > The "numa_emulation.adistance=3D" kernel cmdline option allows you to s=
et
> > the abstract distance for each NUMA node.
> >
> > For example, you can create two fake nodes, each in a different memory
> > tier by booting with "numa=3Dfake=3D2 numa_emulation.adistance=3D576,70=
4".
> > Here, the abstract distances of node0 and node1 are set to 576 and 706,
> > respectively.
> >
> > Each memory tier covers an abstract distance chunk size of 128. Thus,
> > nodes with abstract distances between 512 and 639 are classified into t=
he
> > same memory tier, and nodes with abstract distances between 640 and 767
> > are classified into the next slower memory tier.
> >
> > The abstract distance of fake nodes not specified in the parameter will
> > be the default DRAM abstract distance of 576.
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > v2:
> > - fix the explanation about cmdline parameter in the commit log
> A couple of comments on includes, with those resolved LGTM.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> >
> >  mm/numa_emulation.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
> > index 703c8fa05048..a4266da21344 100644
> > --- a/mm/numa_emulation.c
> > +++ b/mm/numa_emulation.c
> > @@ -6,6 +6,9 @@
> >  #include <linux/errno.h>
> >  #include <linux/topology.h>
> >  #include <linux/memblock.h>
> > +#include <linux/memory-tiers.h>
> > +#include <linux/module.h>
> > +#include <linux/node.h>
>
> I can't immediately spot why the new code needs node.h

The first version used the access_coordinate struct, but that is no longer
used, so including linux/node.h is no longer necessary.

>
> Should also include
> linux/notifier.h for the notifier_block definition.

I will fix these includes in the next version.
