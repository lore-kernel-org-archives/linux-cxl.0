Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06A14C5A1
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980285; cv=none; b=H3/6x/hw23pFrDiQV//vg51CuLXDwXRcNkT5BYl8KWVzoBmlp90jTcqVAATUsFKDhdXeTIyjhuzfAWFhoLc7Mnaz+uI8e/HfF02qphgaRbvPm3yj5tAx6lTjQmtZKOQk0H8jXo6m5L+5rYYswTjb0wyCwUvX84l3iPMghu4ZdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980285; c=relaxed/simple;
	bh=P+LlFXVAR3ni2Q9lpbZyAlQdpPzTbV2ToRmZ+4oEOIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=a2DCUxrKnxuGlOm/nHcxyL4Dbcddg/sfaWP+jUOIzOJZ6nmzVsghlxTAxUqfl0t3IGSy/Kig+sTTEVEJMpP+7OUt3/7HGwxrJsz8yyZD4fQuyo/GNUWCQWOigcGOySOYkZ2UTNaYOCOjPubRazCTkZuHMOPFceD4QMqvyLMusow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=E2f6Y387; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="E2f6Y387"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe28eb1bfso5645351cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 06 Aug 2024 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722980283; x=1723585083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XmlWe99DKTvSLptoxepSTHSiK1+FbVsnMpcepxt5N8=;
        b=E2f6Y3875sCi+FUMC4NnDIWYjuAY1SAoH/x5FpJ24DePrabii4oI5FqT8pU7OZgMYF
         qh/rCJ2vIPK16JkeQNZO7vSs9qTrf5R6HaNzKefw/vdlZQtp/tkEvMO2iJxPFqcZSB8C
         txvjrUzTdKdHw1TpSGJBnuDAFxEPGmAd4WV8VUk2hG7O/+XAjACvYR62XJdUI+x3VxG8
         UMaRuBy/ESUFzgrVbGEh0qDkhQb72Y9gjuGhRVDD6cL3Zu3V/gKrLdxyGgo1rOPyI8gU
         Sm6yvVIxln4bsqIZzlf6+2En2jLGeikoP5Xf/2568/veowAkdTOSykr9dyN5QA/nJ43a
         Qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980283; x=1723585083;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XmlWe99DKTvSLptoxepSTHSiK1+FbVsnMpcepxt5N8=;
        b=iHKADw9rrSWm4m8lkrk49jNSOPKMMsasPmgb3K9Sc/tVJSRZ+Qe0/AKxTV4s87QI8h
         aQZSCY8sAOnDyzWEUbxP1vFnr/CEcW8ke5oJDhZ1rJ+4dkDZNvrGF+9CaMqem3jByHF3
         /kP/DsMxa1SyK/CQepO2sPAM1jXYmmdIZlQszhZs836WuXM66SL3aNTnzqN7snN+iIBq
         lHbsws+7VzSNUw6uLs+eBdkmT+v5BIRye1AKsRWSEBx2bpw9NRnWzFW4RpiFemKpmyRQ
         8EpsJGMKXaspOjr1xZGdpJp1WD7TlDCoUfA/HnZxqjJN56py+LjVQlCxKrAeCgt/k9jT
         Wxgg==
X-Forwarded-Encrypted: i=1; AJvYcCVO6SQTyLvSvOVTPKtuKmsBoCQn12Ko72Qw6/R4gG8DBYLAHAW5e3Yj5gZ3uK5MV3eMN1pbLGzCqat5kS/RazwQmONIBbG9QB4s
X-Gm-Message-State: AOJu0YwucvrbpbaBGejMqKY1KMMe4ESt830uqm9C8MPlMuoUAyPx4wld
	Et7ApBH5MUuie0Dsi3ql7xb7f2Z9nHnQAHdBO7CX2Da+MlLcAYUw63jOSGUUWIyegSF3KiUj9VW
	ku5kWb/oxvRedTW/gU0vhj+eJMEQouS+HS7Pdqw==
X-Received: by 2002:a05:622a:1825:b0:447:dc9a:1cea with SMTP id
 d75a77b69052e-451892561c8mt209894101cf.13.1722980282606; Tue, 06 Aug 2024
 14:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com>
 <Zq0tPd2h6alFz8XF@aschofie-mobl2> <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
 <66b15addf1a80_c144829473@dwillia2-xfh.jf.intel.com.notmuch>
 <CA+CK2bC1ZsT3cuAMDAAUonys3BUxbb2JdnZXs1Ps3NbYZt5W2Q@mail.gmail.com> <ZrKNKRfaH7GliS3C@iweiny-mobl>
In-Reply-To: <ZrKNKRfaH7GliS3C@iweiny-mobl>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 6 Aug 2024 17:37:24 -0400
Message-ID: <CA+CK2bDnJsgjK-7H-8qJjdeejKJk7E7m-SDnwXatH4FHr4R0_g@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
Cc: Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, yi.zhang@redhat.com, 
	ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:53=E2=80=AFPM Ira Weiny <iweiny@iweiny-mobl> wrote=
:
>
> On Tue, Aug 06, 2024 at 01:59:54PM -0400, Pasha Tatashin wrote:
> > On Mon, Aug 5, 2024 at 7:06=E2=80=AFPM Dan Williams <dan.j.williams@int=
el.com> wrote:
> > >
> > > Pasha Tatashin wrote:
> > > [..]
> > > > Thank you for the heads up. Can you please attach a full config fil=
e,
> > > > also was anyone able to reproduce this problem in qemu with emulate=
d
> > > > nvdimm?
> > >
> > > Yes, I can reproduce the crash just by trying to reconfigure the mode=
 of
> > > a pmem namespace:
> > >
> > > # ndctl create-namespace -m raw -f -e namespace0.0
> > >
> > > ...where namespace0.0 results from:
> > >
> > >     memmap=3D4G!4G
> > >
> > > ...passed on the kernel command line.
> > >
> > > Kernel config here:
> > >
> > > https://gist.github.com/djbw/143705077103d43a735c179395d4f69a
> >
> > Excellent, I was able to reproduce this problem.
> >
> > The problem appear to be caused by this code:
> >
> > Calling page_pgdat() in depopulate_section_memmap():
> >
> > static void depopulate_section_memmap(unsigned long pfn, unsigned long =
nr_pages,
> >                 struct vmem_altmap *altmap)
> > {
> >         unsigned long start =3D (unsigned long) pfn_to_page(pfn);
> >         unsigned long end =3D start + nr_pages * sizeof(struct page);
> >
> >         mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
> > <<<< We cannot do it.
> >                             -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)=
));
> >         vmemmap_free(start, end, altmap);
> > }
> >
> > The page_pgdat() returns NULL starting from:
> > pageunmap_range()
> >     remove_pfn_range_from_zone() <- page is removed from the zone.
>
> Is there any idea on a fix?  I'm seeing the same error.
>
> [  561.867431]  ? mod_node_page_state+0x11/0xa0
> [  561.867963]  section_deactivate+0x2a0/0x2c0
> [  561.868496]  __remove_pages+0x59/0x90
> [  561.868975]  arch_remove_memory+0x1a/0x40
> [  561.869491]  memunmap_pages+0x206/0x3d0
> [  561.869972]  devres_release_all+0xa8/0xe0
> [  561.870466]  device_unbind_cleanup+0xe/0x70
> [  561.870960]  device_release_driver_internal+0x1ca/0x210
> [  561.871529]  driver_detach+0x47/0x90
> [  561.871981]  bus_remove_driver+0x6c/0xf0
>
> Shall we revert this patch until we figure out a fix?

I am working on a fix, and will send it out in a couple hours.

Pasha
