Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023F3845A9
	for <linux-cxl@vger.kernel.org>; Sun,  5 Apr 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429494; cv=none; b=P0RiltzuRnwi1fb0bliAJlw5QBMDEhVoZi4nEEdUqdLC9XzVI94KLKb/5V6JQDqrS84kL4+ElJS93KXW5uPTKfbiKgXbP2kbZP8/hO7Xfm3/UB7fAtdhJyMaBg5fBIlOSl9kh4ChfLZ83qn46kismN9BXhL8SMMw8ew/JcKGBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429494; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sN7FNWVGsxdfUyVlUk4VyRHGHDZnXTqE1wi+Hvg/ROoEztdLUcjkGUH/UcO76IL0aVKTVbj1xyBTda5cHQZj9FdLtIsQGYszZ3gAYmoc2PtPC1Tmeh3iq12mGJFIOyB3P94m54TE8o4u3UC3gPoFtNn5hE9x9RyvVxBT+KYEA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XM0uTOJT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XM0uTOJT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so6321766a12.1
        for <linux-cxl@vger.kernel.org>; Sun, 05 Apr 2026 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429490; x=1776034290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=XM0uTOJTWbutFK6aL/lRkptDffA80a6fQQ1z6nJ5eKgU5DccAnDpGV3TwfcJIgd4e4
         eQUmNr65ZthX3ZDLbzUdlZ7d15+CC0i5WKrRv0+eUsABYbO28PEaBlYPYiKIL01jp6ED
         dVqHZVWuEu0vd4iWGDkdPLYmMUZyOsVprE86s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429490; x=1776034290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=hbXz/7uOc+1W7zcnsznCwlx+VQwsPKI7X3QgOKVA9vAiuKoU/X5AIsmzmlUrlbJw8+
         DbKlKE3CzD+T6HdGY5xEqgSfa6PQ5IWpfaZkPigXe0Z3xIiG66AQwnL2RJvNtVrMYuJL
         Ev0J6q9sq3C83h2lxmWVg7SACid8gZhwrjDmJJibh/yGq/FUPzKWO/frWDSYGkK5RWVN
         Q2ZA97dRG9W+1bxxioZbZjJVamlnPm4pmOsz1GsBe5hbYdOe0VI4pH/7LMmiu0c4yzgy
         u7KMWvTM8VBIdLxGWG7dXJ7iq/7OntVwXovUAO05lUM1V8mIZIJYHqVpYwH7HPbkI8fM
         oGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNVlRCXwSNWBqOK8SroSwDG2bka5gxWrWxl2ydkAVKmXfBGKeOYiS4Und3cDkP59wy7ShqVdpirD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTLmctIGavX7ktlPnHhQS7PXpvSDGkRGtP9KmSZgIdSuxhLEX
	fDhDAywiM+veaJFsD/uprJl/s/k1BfnwFS/o3LbSgGbmrgK6b7zsJQYYwEBWdE0BAKyFMONgve2
	IbZ10SG8r
X-Gm-Gg: AeBDieus4JfZcGBGujwKosahrPmSM1k/ricTwudhkmaMjlPhZPKTKuqyWX/wUnlsb6H
	ri3ZWYz6WTVOJeE1bmVUAnrkFnXj2AzeEzIDi0vHVlpb1qjSQPZdvzBzBWjZxAg54zo+XEHfQVa
	7Z70R/AdKtOvhtlholZUR6PWrf/P7dzPwrKoCZ5aYGdIV9HHho+Xgax0ZZz0k65FJRazw1oiO2G
	1+zydoh6T2Rvx7YgRpyo6VRHcm3GwqAefxIPG860LmeLfeQtXmwjH2y793NUpf0CgwDbn56I0vZ
	asIkd5VCA1gGU2dJvqe35PrjU14XGsg8aSJOp930Mad+rdPJxHlRiY2Ueble1k9TMPs9cl+5bTP
	Rh42N2l+wDU6KdWtzCvTHcs+pIiqr+2BSHarsnuPv/jD6mDmoWFv64edchnY7LyCSRgYl0qLT3R
	A/KNQJkAA4DZWvIwhNexuw6K0an412W64+XIFoV18syKL1+XPoZGfXV0DDGint+g==
X-Received: by 2002:a17:907:802:b0:b98:a49:a22e with SMTP id a640c23a62f3a-b9c679f5810mr517496666b.36.1775429490424;
        Sun, 05 Apr 2026 15:51:30 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d0287b5sm427274466b.56.2026.04.05.15.51.30
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:51:30 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so4407659a12.3
        for <linux-cxl@vger.kernel.org>; Sun, 05 Apr 2026 15:51:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU56HOYj4RakF1Ahs3KHzwbOQ4AtzCJ9ZGSqbUSUXjApy/V0sON1ylQV40pfqPWXS6JKkoGeOIL/Rg=@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
