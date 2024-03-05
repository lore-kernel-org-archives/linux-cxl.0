Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7B29437
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619793; cv=none; b=NiPNAXoLIO6p8SF+Ki50oueusweQZ7TPQ8kDcU2mrTMJHYCQ82WjbsEADm2Ajps5lcaPz/OIebWhivWP8eITkEn0M+Bbuf/01CIrPXyKoawKnxWjoI/vIlONAhaB6UFQehcL+OXjLY+zX3boznUGhm4P6LGcZ+YSGaCrDrO4G3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619793; c=relaxed/simple;
	bh=oSQv4NUxnf7rEIn+bi0UJt8ayyHupEoJoCDqI6CLoMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCfq5x9BN3y5/dMj/enHXueWTSOyruYYsxkmLl+LX6Z0YwcN+busxR1/p6pJIuk08KhRTZpOEuIwjfps76wcrg8eeveAdbk6nadegVUWu8iqONkGz4Sik+6W6obDplG00qQzavHoJaXIk3/XTvLP+oSJ5jiUM+0eO8w2Z/tz2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LE8ERebD; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LE8ERebD"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4cb26623dc1so155450e0c.2
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709619790; x=1710224590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=LE8ERebDii+cQmF5RG+dX0zlNm4JZ9MLewpjopaim/ryWpHJebOB9+ajkT5InRWjOj
         eI0Jfob4gzRx2w/do+JxUoZuhyNGl6onmSwU0Fdp6f8IeepPtM5e90PJSpnM3EMcjGO7
         z16WhKK3Tdg7VTYKfg6Cjf2iFpUXeIJNSWOQ8xqNprb+EP9xkSPKPFBqsz00ZBbNPxe4
         Mc08wgnPAZ2u+UM1aKYHTbAOOTBFBb1Tz6QoaRERMxLSfBZeyegh6FOlbmXUOlgaxHwJ
         xwIhWX81fBDRaONbuib7MOvyyDD1INms0iXN/2ixNLztNxw4yDaS/8yLa/8FrdwIEqAx
         mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619790; x=1710224590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=UfN+cfHQSu3q1Vdz5yt2ovxuKTiN1n3LlPF6MxjFc7qhVvdQzT4tHmK6M8wyT7+X2h
         RKWKI5hSxUpgEcADUvYfLGPzyWG8dCndNeaimWF7bWJmXgvOvNCAAxRFjtMfee1zjsQJ
         sp24xPd1+HoKs41IYv6OBREx58Me1EMBLobpboKLJd16Nu3DgX3cb4WQxSAseNwwDXqN
         diNuCz2i+WF3EVOMFa+SFqK4rliFiY9Sm9/kLmzPPgEeDf0uHh6lWjaSlBN/O3yawLZU
         P9fpp2GIIV3ULpnqXi+C+IVz/Dkt3VLE09nxZKIYahod+notcekihLQuqp2RvTlKP5AD
         Inzg==
X-Forwarded-Encrypted: i=1; AJvYcCXTPfA4CMZnJeUucNEEFmG9ahEcnQkSuTrdl1sfAIEIvCHL3Pjyi1QxM1Am6S2XZ0L5vYymBkht5TOSxcaJPFcJJC8Jd3xm6Dxs
X-Gm-Message-State: AOJu0Ywy/W3cdVtfRvPb6O+M3zmoh0f3sNJl86FVDAP6onpV0x5MTc2e
	RnHIaarmM2tt1cWLE8pmaPouVcOMNTvQum0tY8MFonK+2DeUDdWMG0jUOfZu66trgK0/KtUPy8C
	hMAWQhwmGaNz24WIc0Ye5meMwgfJ6t3qYSzbGlQ==
X-Google-Smtp-Source: AGHT+IF8wFchH2Tpcwl+m9+vC++9MiGH8pjEs4cet64MI10UrFTvnJG9+E2iM+RbR2/QpLJ5rn/dajElMcAyZ2RW5JY=
X-Received: by 2002:a05:6122:da7:b0:4ca:615e:1b61 with SMTP id
 bc39-20020a0561220da700b004ca615e1b61mr914463vkb.10.1709619790595; Mon, 04
 Mar 2024 22:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com> <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 22:22:59 -0800
Message-ID: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the no=
des
> > are lumped together in the DRAM tier.
> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A=
@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>
> I think that it's unfair to call it "useless".  Yes, it doesn't work if
> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> please be specific about in which cases it doesn't work instead of too
> general "useless".
>

Thank you and I didn't mean anything specific. I simply reused phrases
we discussed
earlier in the previous patchset. I will change them to the following in v2=
:
"At boot time, current memory tiering assigns all detected memory nodes
to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
such as CXL1.1 type3 memory, being unable to be assigned to the
correct memory tier,
leading to the inability to migrate pages between different types of memory=
."

Please see if this looks more specific.

> > This patchset automatically resolves the issues. It delays the initiali=
zation
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informati=
on
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system mem=
ory
> > device backed by host CXL memory. We inject CXL memory performance attr=
ibutes
> > through QEMU, and the guest now sees memory nodes with performance attr=
ibutes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

--=20
---
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB
