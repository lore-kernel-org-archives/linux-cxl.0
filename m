Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7929422
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967236; cv=none; b=WN7cx/B+dILP7K/SXKw+WEgqrFp7thfjX7eYCumKGLjJtw/nwLd9y66NbCZLL+5vKjqVO6uFLAik2cXwrjg99jNIOBDU2IkpDG6NobyASIrv0uk46IyJ4U9/5qzgKaFDN73aV6q26HppowmaMyb7qKQLP011rnvJd087T1VsRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967236; c=relaxed/simple;
	bh=f2XjQVAFOMEyAF2He6DfOX7B9yvspDnOResmomHSCGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1k78u+QiVjs3YgmRl8mnY6841xMJf7mhPClMpGFeEFhwG8BlgZ2RkNrwZcromlzSmvrZo7jNmmM3c2oeM7z141tEkyj9JDxpg+cgbe0a+v667xV9WXRBEbAz/ZvY6ajJ3KL4jljfJnlvZefDbsHAxFQloF0Cpqq4FI/edSqZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ZA0r6GAS; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ZA0r6GAS"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260209df55dso443098fac.2
        for <linux-cxl@vger.kernel.org>; Tue, 06 Aug 2024 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722967233; x=1723572033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfBptZsetpueoOKsFuJCrA1Xpgd48fPSsjBhDKcmpWw=;
        b=ZA0r6GAS/SZPM6iVc5LUANeHaMqeRYQpAzDkVVWnaTI/vz7LHQHSQHQe7U+FpO8J2C
         +QUa3g6xeCyn6vi3DgwxfEIOf+CvDLej3jge4O6D8/bvxFZ34cAeDp5zWYAKmWrCjqRv
         cqdLwwok7RU0ZcupxJsxgxlzq7RFHXApzQk6Rss4X310UqeeymuKHC0+hOAV3Nl0IcxS
         xBw5O3Ei7fyxLIVcTJ9jKAvIm227O2xZxf6k971FuhpU+1YIHeIvAdQZatGU1cUh/NLd
         K+RFR/RvgMfA80CvzXiylg+cvIN+eJw+gT/pafiIhuAVt/s1Q5pSAeTZ3R2BPcAu+2+E
         ZaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967233; x=1723572033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfBptZsetpueoOKsFuJCrA1Xpgd48fPSsjBhDKcmpWw=;
        b=Yv67a0Clo35y1pi4r5arHXoLd+R8ntkJHoR7Nzoeqsp/PSs/IZBcwVOZ0YOMg+elQg
         gtaV77WgdOjd2zyNjRyQuvfFuOMQ8sruBaEbRl49rJ2Z7t7IRvLcXMEbSt032gCWg92t
         kuEYo3mxC4Bjwtxyhc+x4iCD5j4/TZYb7DQ8qrha25O8l8bSNTTjet3F8/LfaHf08d+M
         t4mE4Z0lbyAs2lVP7OR2XhEGCqiTRMQOY7uapuDFlAe8WQEUHUoYLrOEL88YvbWiq7Vd
         i0o2kODQHH/h2oD1CXsmMt2Pax+7x8gdjN8NsWrrmj4aD7tyaK77+N2Al5od/v6ZtTl3
         +zKA==
X-Forwarded-Encrypted: i=1; AJvYcCVYBJ4pyeY5XKEn8EUYQl/wFDgfllrX6MspU6H5snnXdhw5GqzbPXszYUpzs7tGer+6MthsAn/NIjre6svPt+k3QNrrY3O64UYW
X-Gm-Message-State: AOJu0Yx5ee+Ueo84W9zHbiJQW1PM06P7CWhwLo/t3qvVE9EFYgvp+3eW
	qff4/FcJ/xaxdB2DNnksVdh3jF22i7qc6N+TE3xwgXD9TElChMfGNegCxnfhhj+K1riuvq5p1zq
	t1e4OzsFISfsDfZ8Iztkki/H+6NCTwrEdpc22Yw==
X-Google-Smtp-Source: AGHT+IH+na8ZogFWe0lTnYO7BkcAEVsw1QVu/V+B8Fzmh/sUyWoO/L5FA9/YCLYS61YqWW8tMcQfLCj95kNJZH2NdC8=
X-Received: by 2002:a05:6870:15d5:b0:261:1ad0:5fd1 with SMTP id
 586e51a60fabf-26891a96625mr20245193fac.12.1722967233054; Tue, 06 Aug 2024
 11:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com>
 <Zq0tPd2h6alFz8XF@aschofie-mobl2> <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
 <66b15addf1a80_c144829473@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66b15addf1a80_c144829473@dwillia2-xfh.jf.intel.com.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 6 Aug 2024 13:59:54 -0400
Message-ID: <CA+CK2bC1ZsT3cuAMDAAUonys3BUxbb2JdnZXs1Ps3NbYZt5W2Q@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org, 
	david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com, 
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com, 
	ivan@cloudflare.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, yi.zhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:06=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Pasha Tatashin wrote:
> [..]
> > Thank you for the heads up. Can you please attach a full config file,
> > also was anyone able to reproduce this problem in qemu with emulated
> > nvdimm?
>
> Yes, I can reproduce the crash just by trying to reconfigure the mode of
> a pmem namespace:
>
> # ndctl create-namespace -m raw -f -e namespace0.0
>
> ...where namespace0.0 results from:
>
>     memmap=3D4G!4G
>
> ...passed on the kernel command line.
>
> Kernel config here:
>
> https://gist.github.com/djbw/143705077103d43a735c179395d4f69a

Excellent, I was able to reproduce this problem.

The problem appear to be caused by this code:

Calling page_pgdat() in depopulate_section_memmap():

static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_p=
ages,
                struct vmem_altmap *altmap)
{
        unsigned long start =3D (unsigned long) pfn_to_page(pfn);
        unsigned long end =3D start + nr_pages * sizeof(struct page);

        mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
<<<< We cannot do it.
                            -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
        vmemmap_free(start, end, altmap);
}

The page_pgdat() returns NULL starting from:
pageunmap_range()
    remove_pfn_range_from_zone() <- page is removed from the zone.

Pasha
