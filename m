Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787B47B413
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937433; cv=none; b=kh4IkNPoWjTmLcvuIj0T4XsgGFIQJc70tGaAFWgj0vgxHTt59g+2P89YpbMM6KfsRej9HjV9S+4q8DcSP7xlQ7LNfn5IvHGQxuHM2v10VMabdkwk19e98UxZ22kKzZp/K6yDyO5aaqVpmfWElYe0u9tzkrqh/Y6Se6Xl/u9GBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937433; c=relaxed/simple;
	bh=65xZHZZmA/CzutZoj8Hzr0wBQmT54+tdnBicEdV0A+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjXrqSGPbhFH2IfJSeJlYSFnpTFV7QmNeiAnvrfB6qyt8Vs6KIaoisL4iISnCFYfXpECD71fQ3JETTLRxRFC1U3lMku0zCtyx52vPsfNQHztrYAhFxhz6c/FXkIZMJn7wtxRrrkpdYqcW8tgOQJ/Pq51ZKi9TIeF7xrXkRCeBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ1FcH7w; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ1FcH7w"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-435903c4040so628589f8f.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768937429; x=1769542229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2V6UawHQ9s5MFToZpU8099TxdYIwpRpbE9unot+c64=;
        b=FZ1FcH7w6mTcGmZqMf6g9eA906W7wZA9+KI6020Y/+Ps+3H4CYrvXZTBFicVK3oVcK
         NDI0x7UzqhU3TcArJqm0TIByLBmg7Tf8CdBaasIxv9m0YEoyks/Yhq4sCOJSy/2bcoBu
         HyYsemTl1yTFRhLw4nM8Y4x9wIGnlC99aFMyo2ezvmi5HvFoLLN8ZNXKuOKhqwVy/l8q
         agIQLvy/hqJQy3SJEk2fC6Jy93uWd0PgUCKl8Bd9hUWJUUQq4PFxLsJWcdWuY8JJl4hO
         PiHTmnHOdLeeNNvNgk3d8XLbaXWX97sYLl5qNej01VdRRYN8qCuNBccMOhGWugjV7aeT
         kHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937429; x=1769542229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2V6UawHQ9s5MFToZpU8099TxdYIwpRpbE9unot+c64=;
        b=OW2ejy6pauFr9D1A+7rhFpPUIan3QmCS9DZPerktnGECA+1InD7i6/pweWAVT5QIYk
         OaofwSTb+fTo3xCu36xMG9zyEfcUmaIgWFuTFS9dKE/NQYvVutRg9iRgpMPXFaEZwMaN
         8tlWcXX985acwCKnq+Zamb8hrL9UqmvP7sZoR5kEaDiSxU4kb7xrFOsX6mjieuvnYYUg
         mXqwOqrZBookLVdZLXI5qSZ7lzk3dYgHq6JhXMryeFeg3ywKF+ZTZODhzZDie5Qv7ts9
         Az1DGUwhXnacC+sXglN7ooQ0MtxrdMLiAcL4tF+AcvefqjuhnyD4YQV1psebJo8iZR2W
         0VmA==
X-Forwarded-Encrypted: i=1; AJvYcCUDEOf8L/OmBDuU3s/BTs5tqE5aYZpH7Ay+PIsSohqH5YIwtngbvSxZ4QY1r6asdamVaJrkI1Qb3cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFfEd5YtBnOm7l8B6wSbrojDBP7DrKInsLutJ6q8UlIiI9RRy
	udHbDTS978q9XJV/xpOhe7l4kxyWn4ZwyXV5AhwSvZA6hfwynF8tbZOI
X-Gm-Gg: AZuq6aLr5GZWF+5vCgpWPns4LHyiSj/vcRD5+TgmHoQJWFBJw7ZBEsKLhRYUqQxy2bo
	qfdUg5/NcHr4W/gSsl0tIGVO5au0xgFsP9jT1eVDtFdHwIy8qrUwYZQpF45ByKgb174MHd1DiWo
	UgYdDHAHD5oBOO9sfXIu64wHYLVIp1/z/kucKaXGuPj1gYpcF5O26U2bNQpkiRClZ030+7nr/wF
	u6F7Be9PVH24ExkLkSknbAOkHzLUHQVLSUFtNsGVXHoyYTnKYMnOPRlmUldTqjoPcPDkaJIR99W
	tMqvlSujQcV/I8b8bgBEXxSCJBjsq/yMm92oU8P5/tugOcJRkkYr7fD1EjBAcC54DqjeGhtIPYB
	ae2GAPZsOZCwQIKU2I6KqKPzDNvpZBLsRRg+nDN1+jD7nykfGvi7/6jZG2hgNACkqdUsG3gtaBv
	zSM8G1V2exX5ck/MNVd+4es7SkF9X3Qyvjj3dcYnWPB1hf2Hvx1gLExkit1tFUW0U=
X-Received: by 2002:a05:6000:420a:b0:430:fdc8:8bbd with SMTP id ffacd0b85a97d-4356a053899mr20086025f8f.41.1768937429265;
        Tue, 20 Jan 2026 11:30:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm31642908f8f.32.2026.01.20.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:30:29 -0800 (PST)
Date: Tue, 20 Jan 2026 19:30:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 ankur.a.arora@oracle.com, dan.j.williams@intel.com, dave@stgolabs.net,
 david@kernel.org, fvdl@google.com, joao.m.martins@oracle.com,
 jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 mjguzik@gmail.com, muchun.song@linux.dev, osalvador@suse.de,
 raghavendra.kt@amd.com, wangzhou1@hisilicon.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Message-ID: <20260120193027.3d160211@pumpkin>
In-Reply-To: <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
References: <20260120094744.5d92e34a@pumpkin>
	<20260120103949.7673-1-lizhe.67@bytedance.com>
	<aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 13:18:19 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Jan 20, 2026 at 06:39:48PM +0800, Li Zhe wrote:
> > On Tue, 20 Jan 2026 09:47:44 +0000, david.laight.linux@gmail.com wrote:
> >  =20
> > > On Tue, 20 Jan 2026 14:27:06 +0800
> > > "Li Zhe" <lizhe.67@bytedance.com> wrote:
> > >  =20
> > > > In light of the preceding discussion, we appear to have reached the
> > > > following understanding:
> > > >=20
> > > > (1) At present we prefer to mitigate slow application startup (e.g.,
> > > > VM creation) by zeroing huge pages at the moment they are freed
> > > > (init_on_free). The principal benefit is that user space gains the
> > > > performance improvement without deploying any additional user space
> > > > daemon. =20
> > >=20
> > > Am I missing something?
> > > If userspace does:
> > > $ program_a; program_b
> > > and pages used by program_a are zeroed when it exits you get the delay
> > > for zeroing all the pages it used before program_b starts.
> > > OTOH if the zeroing is deferred program_b only needs to zero the pages
> > > it needs to start (and there may be some lurking). =20
> >=20
> > Under the init_on-free approach, improving the speed of zeroing may
> > indeed prove necessary.
> >=20
> > However, I believe we should first reach consensus on adopting
> > =E2=80=9Cinit_on_free=E2=80=9D as the solution to slow application star=
tup before
> > turning to performance tuning.
> >  =20
>=20
> His point was init_on_free may not actually reduce any delays on serial
> applications, and can actually introduce additional delays.
>=20
> Example
> -------
> program_a:  alloc_hugepages(10);
>             exit();
>=20
> program b:  alloc_hugepages(5);
> 	    exit();
>=20
> /* Run programs in serial */
> sh:  program_a && program_b
>=20
> in zero_on_alloc():
> 	program_a eats zero(10) cost on startup
> 	program_b eats zero(5) cost on startup
> 	Overall zero(15) cost to start program_b
>=20
> in zero_on_free()
> 	program_a eats zero(10) cost on startup

Do you get that cost? - wont all the unused memory be zeros.

> 	program_a eats zero(10) cost on exit
> 	program_b eats zero(0) cost on startup
> 	Overall zero(20) cost to start program_b
>=20
> zero_on_free is worse by zero(5)
> -------
>=20
> This is a trivial example, but it's unclear zero_on_free actually
> provides a benefit.  You have to know ahead of time what the runtime
> behavior, pre-zeroed count, and allocation pattern (0->10->5->...) would
> be to determine whether there's an actual reduction in startup time.
>=20
> But just trivially, starting from the base case of no pages being
> zeroed, you're just injecting an additional zero(X) cost if program_a()
> consumes more hugepages than program_b().

I'd consider a different test:
	for c in $(jot 1 1000); do program_a; done

Regardless of whether you zero on alloc or free all the zeroing is in line.
Move it to a low priority thread (that uses a non-aggressive loop) and
there will be reasonable chance of there being pre-zeroed pages available.
(Most DMA is far too aggressive...)

If you zero on free it might also be a waste of time.
Maybe the memory is next used to read data from a disk file.

	David

>=20
> Long way of saying the shift from alloc to free seems heuristic-y and
> you need stronger analysis / better data to show this change is actually
> beneficial in the general case.
>=20
> ~Gregory

