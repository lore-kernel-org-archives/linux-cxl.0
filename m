Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AB157A47
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689225; cv=none; b=WEMXPaqS70NSK7Y14jIpzW6PjvAdDnXV0vmHZpS8iVI6otKcgG78oRojs7nlHzsEBERplGFAqoSJQ1OgJMM5RkcxOmWs190IMh7hOjfj/RxzYhP54dODfXGeh+qEGlbBvgZ8W7jtnAIgVd7V+O80Cuao8RVUBeTIwV4MQ/WgzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689225; c=relaxed/simple;
	bh=sKjDn1VUyv3xKTnhS+ZfRKeoso++HGRzElJEX6ZqbIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyqIDwYdevjx6HxGidsL4ql+NjTOP2PjuIYaBJW/LdS1vKcofBBO0KX8zcv1hmPFj7bBbXsuC2McwSUtgZDVpDtS0fJdQBfMTR8M8yo67Cx3HMBgFg/X33Blu6RkmY+BFnkezGhGSmGJJMYZPVPnnfNSAQCMPVu+S6jRhEMeLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O3H6unne; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O3H6unne"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so5191065276.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Apr 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712689217; x=1713294017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
        b=O3H6unneIn+4CDzcZC1LjwiFyECB8Vz7OKk6wL5bgUrlWs0LMzYoPUA4oIXYu1O65C
         NEKsMM5NJT7p1tgRO2sOzRUB8IAIF6oNd/zpUvEdFSAVIHNhbMxSAH2eDaujD1sNEzo4
         cgkhPLt1FULr6NChXj8ow2Chfa6OyCWlMMxGEwaBxl1AJvUGWdSjMC8K3ajZAWwCJXu5
         xUU3jfhkQUwjPhG7ZK66GKvzERTx7c4MjJqIPsnzZFhkfl2nr4pp31JIfBp56TBl75Md
         bxPBZeczAQ2+8P9AxPg4zboCWV2yVXwOXn3O0RJUJkzFTj4EGytYCjWIL9H5ICu9tlx7
         rwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689217; x=1713294017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
        b=WmU+SIoJNQBdZC2GzTsDjrAEXors1EQHtdpNxUJMoRTYQSSJAa9VznHx3cWS/WhbCK
         lxIppRldLYvTlHB9ED7W3p1MtWsJpsXFQcqmMGRJ6C7WThUDz5fQWMDICnGA+NYMv+SB
         eTWp60NRODTfg8Q6SZRYV3f/LYg/qKjgDk5I6Nc/En8ITibbJAiGidCtGtBEqwNj6F/d
         A99JuHsXZBNVw5qmGm46OIzPIhfvQUHGDU2yGBFf7nHVm1kpPloOXclUB16XYyffbFGI
         U+3vOvs3Kdwrexv/lKbWsNZ3qwa+Ofry0oWD9kvPtT4pwIn8nNlWzrPTfy6jUicE/f3n
         bkzw==
X-Forwarded-Encrypted: i=1; AJvYcCVva0keztJMfsOAzGzwdIjeG9k0y8NrkxD4GdoGkTdneXqcvujENoV9fjkId8RqZxGPY4M7/TFjQ783/cD5cpf28xpVUXYtysUn
X-Gm-Message-State: AOJu0YzAV4/q/vndxfi9SeYCB+GfW5bp/ZPVQMUCZAcakDbjXMXRr4jg
	8l8C1svI95HfH3k6Ymb4SXqfDtqkJQQ/0oWSUGXQJ7MK8yuLmXlf46At7tSriJmGs6Te7zywOWh
	uD+mdhk/wJxOfP0mZLtbU3WXgLpgrX3XTDV/SMQ==
X-Google-Smtp-Source: AGHT+IGW6ppz/qE4BrLvmNCRDbTF9xfQE/vBrRFhezaSlxNTiNANoYpDGSEDGNZJ8OzMKjviuEREaTWu0J3o1ZesD1c=
X-Received: by 2002:a25:2748:0:b0:dcd:ba5a:8704 with SMTP id
 n69-20020a252748000000b00dcdba5a8704mr700084ybn.24.1712689217227; Tue, 09 Apr
 2024 12:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com> <20240405145624.00000b31@Huawei.com>
In-Reply-To: <20240405145624.00000b31@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 12:00:06 -0700
Message-ID: <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri,  5 Apr 2024 00:07:05 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
>
Thank you for reviewing and for adding your "Reviewed-by"!
I was wondering if I need to send a v12 and manually add
this to the commit description, or if this is sufficient.

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB
