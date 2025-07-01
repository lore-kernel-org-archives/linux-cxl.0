Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816323F41D
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371594; cv=none; b=Tijnt05dP4A3GtfvdO9kdxOz3GHRfrMzNRL6AHAs4loX4LyUu4yT5ELZTywGPPGszDSJSQnxtADv6ItO29mUYWvnMJDHesT7xp1THa+JX8qjXyKtQlev3kPdMc1DP8U/oXdyfFn49S62Mm7Sf/J7d7ZsAX+aJgurLy6XxJn2ge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371594; c=relaxed/simple;
	bh=fwZQhFulCtk6W9St9reCgVe3JkeISDZLWskJCaogHtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5V1VNf2nwfDqlCAmBMOD+wZ+8zyuxGqzy8ta228RbI/gvplvzl311sg7D3NzHln77IHBX76UGpe+x7Q0ZA6chS+Y7XCGA920FMMZiyZmP6zv5libBijUXFJ+fVg8RAw/mNFa3dMX7cJJVGPKkUwZS32unB4/izy6hvnDXUCfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zImGM2RB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zImGM2RB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so114215ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751371591; x=1751976391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwZQhFulCtk6W9St9reCgVe3JkeISDZLWskJCaogHtY=;
        b=zImGM2RBPz/vycaCoiTRNCq8beO5NLj9NhJOdtCsbGN2Uo/hek01RNagPWqBF8n5Q+
         yQQvrc9SIah4ux88gPrZB1aTmVfU/QK9Z2ECanZj6NaxdKoPlgTJbDSDme5a3rZHqttc
         AyMdOzbKiS18foFSLC6LSvJE68bTcdji7XWE+PC9Iq6FLzCtIIi8bMrYtyPczcDpnmmA
         B9pjKze72+a+BxozEMccX+rnSm0Zp1VefdK+wyjjKPTaCSMy8UGYD1fFgQ+2HeUChC9A
         yGZjjZPdHKvz9MWMyLoIWXdeu9rMv84YBHg2pBPbapZk//eQntFjHByln6xs2TsjqSXf
         z7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371591; x=1751976391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwZQhFulCtk6W9St9reCgVe3JkeISDZLWskJCaogHtY=;
        b=ap0PT8Aa33FYDz6YTlbhw1fxR1dGtidyl0/t1fr0TyiduyliNaEIUsNoVT+xqv1s35
         cJFxsWe0/wluebnLBZzL8AHreWDhdnXLyvMt8jpZgo7HYsq8KTKU8tLj5bcAAg4NPJfg
         DlOslVES5Uvbn2DN7rvkrRtpe4lC4c3+DQQ4W3hjO0aE76793fSVyRJdVDaItBkLleq4
         BdwVs06WHn5/+ive4s4L9J+YVthBHH2ffaS1SQA6LkZVhcoKomsEojs1pmmOvk2qt4/y
         ByiG4sS2DBFICR3fhWQ1Ld76GYdo5023JMdwJV/4RGZ7kewlypqbGbfY4DOFzR3CkWmq
         8asg==
X-Forwarded-Encrypted: i=1; AJvYcCUjAWXaR0f75bFil5mAFXl8aL3kgTNXhKyyiCDiLlXVWm2iwLV4VM/d6Gq7EWdcvLL6K6CeOUvwXbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynx+hOuzIU8zf/0VNsHcKG3JiuVl3c18Q8aHyuMGDab80cYfdM
	ghvh9pqTvCCIGlaFYlmaLrehAoPUbMuaWi5w2jod8RwMk5suEbUrwzd94+POhmTex16igaz8iCy
	9xuQC8aIOkckOK3QB6Fj9YzeMoASVxXu6Vhx8l/lx
X-Gm-Gg: ASbGncvCwBRIo9YOAm57irJVs/DbjrJkaOhkodYS023orHr/Zah6xcRczeHry/nmFqX
	z53gjV9aTwRdQBPueUslcoFsXXfplGxzp6zlgMbROU+8JZ3hs3P24JbcHZzP3KFCBgtLfOnPXbe
	xYZvzvUHjdhkggVCmYQm9lZTvDC3Pf+Dk4iKnzjvlHnQ==
X-Google-Smtp-Source: AGHT+IGFAwjulo/i4stzSeDZyvangI+UZ0rJXA7wz0l2gf+G3c7FdoUDkNvfVQlKGJ7tNf7XQG97q/uJgkbiheh/1nA=
X-Received: by 2002:a17:903:110d:b0:23c:5f63:b67 with SMTP id
 d9443c01a7336-23c5fef26b2mr2103895ad.4.1751371591226; Tue, 01 Jul 2025
 05:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612114210.2786075-1-mclapinski@google.com> <685c67525ba79_2c35442945@iweiny-mobl.notmuch>
In-Reply-To: <685c67525ba79_2c35442945@iweiny-mobl.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Tue, 1 Jul 2025 14:05:59 +0200
X-Gm-Features: Ac12FXxGIEan-Q08VvikT9LVQKRxgvs42efMWiz53YaKommHJZr1vh6fiZw9HYE
Message-ID: <CAAi7L5cq9OqRGdyZ07rHhsA8GRh2xVXYGh7n20UoTCRfQK03WA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] libnvdimm/e820: Add a new parameter to configure
 many regions per e820 entry
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:16=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Michal Clapinski wrote:
> > This includes:
> > 1. Splitting one e820 entry into many regions.
> > 2. Conversion to devdax during boot.
> >
> > This change is needed for the hypervisor live update. VMs' memory will
> > be backed by those emulated pmem devices. To support various VM shapes
> > I want to create devdax devices at 1GB granularity similar to hugetlb.
> > Also detecting those devices as devdax during boot speeds up the whole
> > process. Conversion in userspace would be much slower which is
> > unacceptable while trying to minimize
>
> Did you explore the NFIT injection strategy which Dan suggested?[1]
>
> [1] https://lore.kernel.org/all/6807f0bfbe589_71fe2944d@dwillia2-xfh.jf.i=
ntel.com.notmuch/
>
> If so why did it not work?

I'm new to all this so I might be off on some/all of the things.

My issues with NFIT:
1. I can either go with custom bios or acpi nfit injection. Custom
bios sounds rather aggressive to me and I'd prefer to avoid this. The
NFIT injection is done via initramfs, right? If a system doesn't use
initramfs at the moment, that would introduce another step in the boot
process. One of the requirements of the hypervisor live update project
is that the boot process has to be blazing fast and I'm worried
introducing initramfs would go against this requirement.
2. If I were to create an NFIT, it would have to contain thousands of
entries. That would have to be parsed on every boot. Again, I'm
worried about the performance.

Do you think an NFIT solution could be as fast as the simple command
line solution?

[snip]
