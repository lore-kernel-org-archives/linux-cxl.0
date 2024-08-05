Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC87165EF1
	for <linux-cxl@vger.kernel.org>; Mon,  5 Aug 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883288; cv=none; b=g2rTz5i3W/0q11V0pQGlD5v43UahHGXAVFVs1njMHwO3Mk/H235iZec1C5evHf57gLAvYty/ftcWYfWkhNp8EXBzaR/320BdtEpNcxPOB09CsqLK+BJp6jpzquunYFbdKSk2f4fYsBOK6eMljMNqP0ZBaDpIsXX3CAxsna+7LS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883288; c=relaxed/simple;
	bh=Ys/t/CdNVJJmv2lzAuDmT1M/s6j0A9XtgN3oc62Jk5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx0bDz+MSIT8X2csDmrh3h4RivmWMwiQqR2pOaY6kauEzuNUCoffy8SlJaqGQN3ppRgX4+D0SLuhECv5tIwiPvcrbKhyuaQGUKPhujNI7ZjKsTMIxdqqR4QlFAn7vOaeEbH320gYVJS04vScMFSxKhRheesnWJvYk9f87Xs7Gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Tph/erhd; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Tph/erhd"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db16129143so6333176b6e.0
        for <linux-cxl@vger.kernel.org>; Mon, 05 Aug 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722883285; x=1723488085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXDR7qiLrGhxm4QaBcXkbXKBNxx4m/1amTQ3OxtKpcA=;
        b=Tph/erhdRxbaDcA9Hk7B6yaxgFNtP0dQEEL0icsRDcawCDeE5cVUz5zPmVb0y6uo5P
         WzBFcTTNTWY1yT5Y+EBI/+l4PIH2+XalMy/sWOKvoMzn5UJvFI0VED6IBAdcjtVUVenX
         B8E1puC7TFwcVz54Vmi73lOZjDB6VZZQ1Qvp5qzDCn9ofz6xJH5PKrQjbllHnY9InlAN
         x9/a6CEv5h8UtH9lw2AQBxg6lSwb4Hbd9AMcjJLe0t27k7Te7qn4ug9OKAHZDGQ5/fDT
         DtzrKCtgQEltlGCpVfEh73NgOpAwd+EQIihgd0Ma3RcgUcLILaBU56pMnAQmnbGqeUzS
         7jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883285; x=1723488085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXDR7qiLrGhxm4QaBcXkbXKBNxx4m/1amTQ3OxtKpcA=;
        b=TGWSs4hk2Pb2hq5z76HSywH+W4hiSwAXwXI7gda6gazGjVBeM1SGWeB1luc2YFS/QA
         KKekS0qYB9JiEe+yjSUAyAOd5CJc2OCfHErkklFDtFS6wmTPf8AKpr/vfIvg54FpA7t4
         QsenlQ2gH2VE60KlTwnCPwIzW9PBRNQt5tomYVbWpHq9OrWzP/s6fLH0jsc7jzqifCwy
         DQl5fPlbKToudYUDAqhbEEyHl4HKBUur9HZrwdEk2NOYsR+SK1qxJ5YoHmukNvk69h/Y
         EwB1au4PHeqlZudmf2/a40gESkVKojK4Sc119GH7NKrUzDhgut6kLM+DGIek87BtDMdE
         mj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWZGB1Nku/WZlznmnQ3Src6D3N7KM3hbFiky7xwy4M9GQ8trlaP7fxNfJuli+IDAY/8b5pMQTdBZsNkZOS0WVFcvEOva80eOF+D
X-Gm-Message-State: AOJu0YwgVFnS/gB994xCzSI5vuiVWWNcEVCofd98yGYoAHRAsXriiIKs
	aIC/EOZFfaEzFiG58YNi2nudpWqWmcpv2CAlYnrCMFzBvJMWjsGrPbbI7XIHbSgBPMugrRwWOsA
	AM8oB95Q/dSnG9eMiZSgAAvtw2LBv+aYahi3afw==
X-Google-Smtp-Source: AGHT+IELiX1V707IcRryP1iDqdmXzsN+eMp7QFXOkdeEr9fYlKlUd987VH8uQ7e08ycHl28xM7Hu7WLB3uBVe3WBGzg=
X-Received: by 2002:a05:6808:191a:b0:3da:e02f:eb8e with SMTP id
 5614622812f47-3db5583e3e9mr18020289b6e.43.1722883285128; Mon, 05 Aug 2024
 11:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com> <Zq0tPd2h6alFz8XF@aschofie-mobl2>
In-Reply-To: <Zq0tPd2h6alFz8XF@aschofie-mobl2>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Aug 2024 14:40:48 -0400
Message-ID: <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
To: Alison Schofield <alison.schofield@intel.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
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
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, yi.zhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:02=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> ++ nvdimm, linux-cxl, Yu Zhang
>
> On Wed, Jun 05, 2024 at 10:27:51PM +0000, Sourav Panda wrote:
> > Today, we do not have any observability of per-page metadata
> > and how much it takes away from the machine capacity. Thus,
> > we want to describe the amount of memory that is going towards
> > per-page metadata, which can vary depending on build
> > configuration, machine architecture, and system use.
> >
> > This patch adds 2 fields to /proc/vmstat that can used as shown
> > below:
> >
> > Accounting per-page metadata allocated by boot-allocator:
> >       /proc/vmstat:nr_memmap_boot * PAGE_SIZE
> >
> > Accounting per-page metadata allocated by buddy-allocator:
> >       /proc/vmstat:nr_memmap * PAGE_SIZE
> >
> > Accounting total Perpage metadata allocated on the machine:
> >       (/proc/vmstat:nr_memmap_boot +
> >        /proc/vmstat:nr_memmap) * PAGE_SIZE
> >
> > Utility for userspace:
> >
> > Observability: Describe the amount of memory overhead that is
> > going to per-page metadata on the system at any given time since
> > this overhead is not currently observable.
> >
> > Debugging: Tracking the changes or absolute value in struct pages
> > can help detect anomalies as they can be correlated with other
> > metrics in the machine (e.g., memtotal, number of huge pages,
> > etc).
> >
> > page_ext overheads: Some kernel features such as page_owner
> > page_table_check that use page_ext can be optionally enabled via
> > kernel parameters. Having the total per-page metadata information
> > helps users precisely measure impact. Furthermore, page-metadata
> > metrics will reflect the amount of struct pages reliquished
> > (or overhead reduced) when hugetlbfs pages are reserved which
> > will vary depending on whether hugetlb vmemmap optimization is
> > enabled or not.
> >
> > For background and results see:
> > lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
> >
> > Acked-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Sourav Panda <souravpanda@google.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> This patch is leading to Oops in 6.11-rc1 when CONFIG_MEMORY_HOTPLUG
> is enabled. Folks hitting it have had success with reverting this patch.
> Disabling CONFIG_MEMORY_HOTPLUG is not a long term solution.
>
> Reported here:
> https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=3DCoJkgBGP_+sNu6-6=3D6v=3D_=
L-ZBZY0bVLD3wUWZQg@mail.gmail.com/

Thank you for the heads up. Can you please attach a full config file,
also was anyone able to reproduce this problem in qemu with emulated
nvdimm?

Pasha
