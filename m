Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288331B830
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416834; cv=pass; b=PhclokRvy9U5MwSW2biPzUkYVfGDKN9zwwZxTP18y9tEH/NBZYcy5Ev4eyK4v2qZSK9SzHaYw6XYROe5psdySDEJyW2viS6mf5e7LlR5UOi7usggfT69LrX2MOmxaIbGK3C3+oLqJ90rTusuSxcRTbniSaFP5JmXDFHnYHuQd9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416834; c=relaxed/simple;
	bh=5c9bOfL9xX1M5qYLTtO6chvkErafEILwQ1Vq/seoipk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExutuLRPYjtezWQhZgc2eFS2hg+PFWe58xWPZrTD8GFzi99Z25UxUYYi1A/YDmjyCxls3L1wfNwpWAdZ+89NZPrmWZfS27RYRmJt06lUSJ73u0zzmSs01cNXuhy3MzsKNEcOzxfT8vKgvo3EH8vAhkSEVG8iGf3kHWddYAoHMbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8DDWT/D; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8DDWT/D"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so66445666b.3
        for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 02:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776416831; cv=none;
        d=google.com; s=arc-20240605;
        b=fyV+6pErgYsnBekdg/YzbDmc3p/y88c7rETlKljnBO6fdsyx3Q6WkEBoc2Wtp9rL2D
         kpAl6pHwFOnRf31A5bafreoztY9KAS2EwHUnZlJ3KtuFtEaSzDcYn+Ut+jaY+F6oDYFu
         +KJCb8LA4oTG3vVkpd0aB5IeRNXnPzTlRKpPb3feYP24Y0ojBeQ6lA/Ri6fF81ppHjd0
         59jNr2Od41wWPaO2ZlwNOxZMZ19ocjhQi//4ovWPPZZbrazkm/E922/Zh71Z4rDvJs0U
         qXKBWlQetf67ljbL9DiWAldDM55bIhjYYH8X20deW1RlEVAyrdnxJIrxv5t6q5QoY7ja
         yMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c9bOfL9xX1M5qYLTtO6chvkErafEILwQ1Vq/seoipk=;
        fh=BnaRVdep493RzxWpCF8+UN3NCpWkIwbuvZS6HFSF0nY=;
        b=By6+mOV/hWt8afyWozGEveuOYhc4a9CUXlLdzNp8mZSiozKrVuHKXuXG8AWQIWwOnS
         PlksfhGtUGX8LYuG7NxWkAo+flnxcPgZLB+cTmStK2QS6cW4fSLU0uyMaPX/aJod9OSA
         kVPnheiGRCquOBRTLfc6q47LaBL8L+3bZCT1n5PccWQKwYAvP7gpa8ItHQyWxcFCeAcK
         boFytDxsTKCeMgdgOP6fpe+zAaxdXZoIZ+winGwWXFpNAoM8veExqJkgvivsiWp8riME
         f/8jCsxDAPzscRhXWjHtxptXNDjADTbWjJFJHWNDCmtnslmO2ZQuoaPKwmAFhYUG1QDC
         jpDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776416831; x=1777021631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c9bOfL9xX1M5qYLTtO6chvkErafEILwQ1Vq/seoipk=;
        b=o8DDWT/DlaErGn4DeUAkK7BgN+afJgGmhxqZ1q3b6VxSaJ4M5giKBs9fF8Qz8j2zGs
         a2F2ywQXQY4zEE50PtC5vKXIjQ4806vwpb/MxvN1jLYoUcxK8iLtb0D9L9bfiuWIkQqd
         REgBwyCvnuvvdXo9Y/ZqPaXI4fMEpgww0SJfq9cMzKCsnDRjqw2NseuYl7cy7HX/L1ue
         TaBvIVGEeZ7mTsoOmTko9qfzVr35fumAY0MAzJQBeIybwwZJySQy6amvHvvjYKh2R+QV
         P4yL/C7c1Fst1l29oFfuSgOdYkzxM/SgcvAYrCYqOmORYuQDRqRqiQcnTO/HyztDmzP7
         QEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416831; x=1777021631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5c9bOfL9xX1M5qYLTtO6chvkErafEILwQ1Vq/seoipk=;
        b=DHjr/omt74eHh5F9ISCf+vYpRgPiNAMmtizdu6UUAzqg1qu4Y7H6wDAZcUrWXztzJT
         OeRvBA00j/zatRIq71nUblun0v7RZOKKk/78NIzhgrwc0NEEy/OW2m+LqJszuN+1AVzG
         dqiZslpqtS2XVtwEM2TA8F/f2vu9sUNbuwXiatuGs2SZxfWnpJMgoc9FMJM2gTxTCOO8
         +ITADSeh2oFqFTMKbdz1JKF0C6Ta61HK3nzyASulPUllK6RkXqFrzZIBUWZPswnPbttd
         qJKFjaeEa+J0EG69+5H5M7p53qcUmJ/ZwR1Z5gG66aHRkU8b51X6tA4B+ZMY7tTHWq65
         wmGA==
X-Forwarded-Encrypted: i=1; AFNElJ8X0QGCcR3bFbhkeRZP2TbMPFHDqpd5KCcFbkyTRdycVaG8HzENdm4aMNvEgR6Q7yBZZ/+t72+uMWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38rzEvs9zfCIghqgkxCBm1dDdWlMKEadGHsF4KiOmYCWAWD8j
	qnsX7Bm8cgEToZWknFH/bUyYYAvSM51n91MRiGcJFrLIpNqrFB01q7HmRph1m2InK1NPy6PbEe0
	geO4jlHKxZozsd/JLsjZjnEl5GrFvsNU=
X-Gm-Gg: AeBDievhh5GddlvOXn6vTAIfuaOAsXAmGkoYTVN8m6LUOl9PuXyKjHF6jUJc1mqC21q
	ufRz6XS0OoE9585Znk0QrvJvwTO+CaC52MQNEosPviAAoApgLAeqHF7pYJ66jYn5D7HFiV2u1Hw
	rUhfiTQxe68qlPw0Q1dHKKPROOYkqdS5bUl9fyUxzJVQB5XLyjxeOuw9aSPJurKqGnVW0flGIO2
	ilxfJL6KQVpLwv/Ie7/gk+gj2BnJiBw0lSw8QOmKj4JSAxRk/7U9IxRoWX8Cgke7U2MEm2c+vq7
	u462JuewdfpnXKbVBiHwiCfLtrX+q3SFT0QUGDsKL6pRhuxtxKWF
X-Received: by 2002:a17:907:742:b0:ba3:55bb:c380 with SMTP id
 a640c23a62f3a-ba41afe9047mr107433166b.37.1776416830641; Fri, 17 Apr 2026
 02:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net> <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F> <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>
 <aeHXQ2EW2ivlLb_N@gourry-fedora-PF4VCD3F>
In-Reply-To: <aeHXQ2EW2ivlLb_N@gourry-fedora-PF4VCD3F>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Apr 2026 11:06:58 +0200
X-Gm-Features: AQROBzD2EP6ID8hIkZ19dTfzX26KpQgRIz65UgWPtyN4gSS439LCb3U6ka7SEj4
Message-ID: <CAOQ4uxhXTTyySG3tXnqNnP0edbbwUxfeeC7=CypDSyw_Mod48A@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:46=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Thu, Apr 16, 2026 at 06:24:02PM -0700, Joanne Koong wrote:
> > On Thu, Apr 16, 2026 at 1:14=E2=80=AFPM Gregory Price <gourry@gourry.ne=
t> wrote:
> > >
> > > I worry that this discussion is going to turn towards implementing a
> > > solution grounded in parsing arbitrary formats and how to store them,
> > > and that is completely detached from why FAMFS went this route in the
> > > first place.
> > >
> > > I question whether the actual issue here lies in the interface APPEAR=
ING
> > > more general purpose than it actually is - and therefore inviting
> > > attempts to over-genericize it.
> >
> > Would you mind clarifying this part? Are you saying that the interface
> > and logic is *already* generic and usable for other dax-backed
> > servers, just that everything is *named* famfs but it's not really
> > famfs specific?
>
> Yes.
>
> If you just find/replace "famfs" with "dax_iomap", the structures
> here don't really seem all *that* crazy specific - they're just
> optimized for memory speeds instead of I/O.
>
> There is a circular nature to this - FAMFS figured it out first, in
> what we think is a reasonably generic way, but we can't know for sure.
>
> John, Dan, and Darrick have all proposed reasonable ways to hedge
> against the obvious fact the interface will not be perfect - which
> incorporates your BPF proposal along with a reasonably straight forward
> deprecation path that's not always possible in other arenas.
>
> All that while solving a real (and novel) problem.
>
> That's actually pretty damn cool.
>
> I would urge you to consider these proposals earnestly.
>

Apart from your suggestion to replace s/famfs/dax_iomap/
the fact that this logic sits in fs/fuse/famfs.c (or fuse/dax_iomap.c)
is the other big architecture issue.

If this logic was to be placed in fs/iomap/ as Christoph suggested,
I think the rest of the UAPI issues could be sorted out.

In any case, considering the sheer amount of discussion on this thread
I have scheduled a cross-track FS+MM+IO for Famfs and DAX iomap.

I wasn't going to include Storage people at first, but since Christoph
mentioned that stride/offset iomap could be useful for block iomap,
I included them as well.

Thanks,
Amir.
