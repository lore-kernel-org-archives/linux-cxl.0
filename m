Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AB388E7A
	for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204854; cv=pass; b=bgiKqnbLrI1klw38XA8x8Vc0KMYBK/Bjh+CuiZzzI4mq3jGXrtqPXI22ysZIhelN1fNCsebeCpGgDqnSrHhoip/XgsWRRhSSRntD7Cfq/EgyD3P10pLJlEipoNTK3i9CPaeIemSVPnRFRTMecz4dRGvscq03Zy9mQfLbPbOKzB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204854; c=relaxed/simple;
	bh=EFuG3O2GySYI1nkRvikReQtUCyFAwyYO97i5pS4YUoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOOfsMOe76NwxhXZrtWWEW1KIMlIxYesSujoldBhpNog1ZSKy1VIO3zfsWIobJekd3VKt2coJrdMPOkvhCHEsIedD+o1pRgFl219PNa2Y7/aai90+kvenTxOUmFBkmHGdzAqm+i/88EIrqm4KVM9PiRwb97VumRFyciKPlMf6XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIpUt2aU; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIpUt2aU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso6168735f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 15:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776204849; cv=none;
        d=google.com; s=arc-20240605;
        b=eTp8hXdjuAoFQ0Vrr3mOPiSdj874BJv8OyI8gQ9t2YpLqCj0RA6GY383ahDXY2qF1N
         RMx78/TJqbLqPVCv+rl+K3y0Gfk0A8pr/eb1scvSuuc6vyfGJdUejQAUumAXMxfuKBJX
         pNxkgXpXwJ06FZj0aiRE+0F8bj8tod/o+ldNbO8B0xWuymB4uhEJsBX7XJephhK7gYmx
         vvFMFCdJOzQ1VWxZ+IiSqnPEGp0QppOGTQQWIa3+9y2587oy1NM5RNQAHdIUBg127MeQ
         yvdIGoKCQOskGqiUe8elEa30iahDURA14Dl6+WcUqYusSG/uZGSU9Hd552CWTl4hxfkk
         PLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XHGoqrVAF4yRodgucren3pErXmC922PltoQad4CPqCU=;
        fh=g1lSXh/O5mZoDFeVZnDUqcGcHvjdHOpFHHV561kAAt0=;
        b=cdIg/67p00TJUYiTmz+o2ZgRmTbBYykRJiSsT6Et2Dg1PiTx4+fSnZLiphJHBi9vda
         zxwlQDij9ZbNPKt8eVR8v1/lA2d2p152Ia3+Z6jXj6vCrxCkKLcRczV77gCRUjMKy22f
         mXS2o88flyADDUCWes2CMNSseVzfNwMIOtqRmExAki8IgHv9+CvfSsu2GeXEuE/djcTW
         1iWc89I/pphlH9J3qCdpXOj7B5y4z7baKmgG5FkYufrD9w0dz8JdNEz5OspwLVefUjSp
         9LF8Rdx1MHySFekU900K5dQ0cFAZO1bRcyE22fkYgkzoLNBrBkdq8tzzAL3QMZtF4hXV
         DuUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776204849; x=1776809649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHGoqrVAF4yRodgucren3pErXmC922PltoQad4CPqCU=;
        b=BIpUt2aUIurYcVRlz8yJ47oY+d4to0e5UTP1mP3OYO5ciZ5OGle+rbMb4oRKzMyAOQ
         CNNdxaLRMAdyTYYE4p6TQr2WIfo1H+cOljG/cUoUwfA205fhXgS/OhTYamPgRcLziF8L
         VBKT9Koyfh3C6IC/Zb1/PpM/hhbheG8EDQ9y1GNTeV7W2bni1BE5n8GhwONFSwVB2iIB
         pW9VWtWBHkUzBYGUurRh2Di4uXHJeKmjPlR3l3svMnjUYrNR0wyXqkQj7ZyNcii4OsGT
         mprKQthumNTFv2BIxeo2PyKSZc2N5ABtOJbva5diWW1cm7HJOX2blhUADsIJTahsHLnH
         E8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776204849; x=1776809649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHGoqrVAF4yRodgucren3pErXmC922PltoQad4CPqCU=;
        b=YL1ojjEgBNk9c8EEFgw3d/93WlQNqr003ztEaXQIBpXeVUCbniJ8sLYfbJ6a+3N2Fr
         9Jw5ToISTLBcNf+bp5kSUjAQEQmUVu1HiRdaYe3EepotTh3bw5cp3gD0TYvlRUEHdM/C
         971g9c/Ne02mGEHCMq8kgKgQQBOzIL5y/wYIfC1Mn+t8oPumOkIM4pGHRscNP9/UF+x2
         UoVxdjKyJRO0V+6CLgXaRzfBlHdJ/i9VvGd/5nyoSH3BVnZi1lvConziqFChIT26el4G
         NHS66Xwme71a37KyB4Y0PJpGnD/xS83d2Qn+uivy4/DqCuxdjKo/357wO1YAPchZhuI+
         G0Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/HNmRWUtSiV3SMJpEGCSWWQvhKm5Jp2x7XI1gaVN7UbI7qtJ1e/QP85xivIYE8KVV1IcHixo6qnCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyuR9iZ6/2VOu0cdVIwRWZKsKokZrgmd+nvllId5e4SrOJgQj
	+pI15H0SfYAn+fDOhCmJZ09EEhYH6SYe2/yf2Z2tRtKRO+021hp6dZ+3K8xdthKDa0qbW/MUdT2
	2uDQIWOlatB5pvPdbZ9XY/yPynXiJ1yM=
X-Gm-Gg: AeBDieuH1z6GpXJqa1P5lRBW1fTBaJlBJY/x37a/NNu01XwHmC13nBR0Z30wgFUKW9o
	ASREfJQb3u1BUZexB2WKpzCGwyZn5IL+OBTCEdMouYr9cAoIQPHwASYkqdce/tEptTTsyD6yc9F
	G0Aw7WBtjtahOWJQsqyr7f7ZGRNkBwg/4/w+JFf1uORZd90AudDdnOajinZ4cmjehZXNpku7MIt
	mpCJjk9yYHJN32tNfPIt36nrEiKsrwJZMyrnt/kbzGhcheicm+/MhF3itLvmAZinfJdSg7Uwrwg
	zP5kjPtJYU0KjM7e
X-Received: by 2002:a5d:4443:0:b0:43d:696b:72a6 with SMTP id
 ffacd0b85a97d-43d696b7352mr16413725f8f.7.1776204849185; Tue, 14 Apr 2026
 15:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
In-Reply-To: <20260414185740.GA604658@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Apr 2026 15:13:57 -0700
X-Gm-Features: AQROBzAAIIChNBd3LuntveTzVP71atwEu6BvgneAi9g5zAgR2JCNJI8CupfByL8
Message-ID: <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:57=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Apr 14, 2026 at 08:41:42AM -0500, John Groves wrote:
> > On 26/04/14 03:19PM, Miklos Szeredi wrote:
> > > On Fri, 10 Apr 2026 at 21:44, Joanne Koong <joannelkoong@gmail.com> w=
rote:
> > >
> > > > Overall, my intention with bringing this up is just to make sure we=
're
> > > > at least aware of this alternative before anything is merged and
> > > > permanent. If Miklos and you think we should land this series, then
> > > > I'm on board with that.
> > >
> > > TBH, I'd prefer not to add the famfs specific mapping interface if no=
t
> > > absolutely necessary.  This was the main sticking point originally,
> > > but there seemed to be no better alternative.
> > >
> > > However with the bpf approach this would be gone, which is great.
>
> Well... you can't get away with having *no* mapping interface at all.

Yes but the mapping interface should be *generic*, not one that is so
specifically tailored to one server. fuse will have to support this
forever.

> You still have to define a UABI that BPF programs can use to convey
> mapping data into fsdax/iomap.  BTF is a nice piece of work that smooths
> over minor fluctuations in struct layout between a running kernel and
> a precompiled BPF program, but fundamentally we still need a fuse-native
> representation.
>
> That last sentence was an indirect way of saying: No, we're not going
> to export struct iomap to userspace.  The fuse-iomap patchset provides
> all the UABI pieces we need for regular filesystems (ext4) and hardware
> adjacent filesystems (famfs) to exchange file mapping data with the
> kernel.  This has been out for review since last October, but the lack
> of engagement with that patchset (or its February resubmission) doesn't
> leave me with confidence that any of it is going anywhere.
>
> Note: The reason for bolting BPF atop fuse-iomap is so that famfs can
> upload bpf programs to generate interleaved mappings.  It's not so hard
> to convert famfs' iomapping paths to use fuse-iomap, but I haven't
> helped him do that because:
>
> a) I have no idea what Miklos' thoughts are about merging any of the
> famfs stuff.
>
> b) I also have no idea what his thoughts are about fuse-iomap.  The
> sparse replies are not encouraging.
>
> c) It didn't seem fair to John to make him take on a whole new patchset
> dependency given (a) and (b).
>
> d) Nobody ever replied to my reply to the LSFMM thread about "can we do
> some code review of fuse iomap without waiting three months for LSFMM?"
> I've literally done nothing with fuse-iomap for two of the three months
> requested.
>
> > > So let us please at least have a try at this. I'm not into bpf yet,
> > > but willing to learn.
>
> I sent out the patches to enable exactly this sort of experimentation
> two months ago, and have not received any responses:
>
> https://lore.kernel.org/linux-fsdevel/177188736765.3938194.67707916882360=
41940.stgit@frogsfrogsfrogs/
>
> I would like to say this as gently as possible: I don't know what the
> problem here is, Miklos -- are you uninterested in the work?  Do you
> have too many other things to do inside RH that you can't talk about?
> Is it too difficult to figure out how the iomap stuff fits into the rest
> of the fuse codebase?  Do you need help from the rest of us to get
> reviews done?  Is there something else with which I could help?
>
> Because ... over the past few years, many of my team's filesystem
> projects have endured monthslong review cycles and often fail to get
> merged.  This has led to burnout and frustration among my teammates such
> that many of them chose to move on to other things.  For the remaining
> people, it was very difficult to justify continuing headcount when
> progress on projects is so slow that individuals cannot achieve even one
> milestone per quarter on any project.
>
> There's now nobody left here but me.
>
> I'm not blaming you (Miklos) for any of this, but that is the current
> deplorable state of things.
>
> > > Thanks,
> > > Miklos
> >
> > Thanks for responding...
> >
> > My short response: Noooooooooo!!!!!!
> >
> > I very strongly object to making this a prerequisite to merging. This
> > is an untested idea that will certainly delay us by at least a couple
> > of merge windows when products are shipping now, and the existing appro=
ach
> > has been in circulation for a long time. It is TOO LATE!!!!!!
>
> /me notes that has "we're shipping so you have to merge it over peoples'
> concerns" rarely carries the day in LKML land, and has never ended well
> in the few cases that it happens.  As Ted is fond of saying, this is a
> team sport, not an individual effort.  Unfortunately, to abuse your
> sports metaphor, we all play for the ******* A's.
>
> That said, you're clearly pissed at the goalposts changing yet again,
> and that's really not fair that we collectively keep moving them.
>
> It's a rotten situation that I could have even helped you to solve both
> our problems via fuse-iomap, but I just couldn't motivate myself to
> entwine our two projects until the technical direction questions got
> answered.
>
> > Famfs is not a science project, it's enablement for actual products and
> > early versions are available now!!!
> >
> > That doesn't mean we couldn't convert later IF THERE ARE NO HIDDEN PROB=
LEMS.
>
> Heck, the fuse command field is a u32.  There are plenty of numberspace
> left, and the kernel can just *stop issuing them*.

I don't think the problem is the command field. As I understand it, if
this lands and is converted over later, none of the famfs code in this
series can be removed from fuse. If fuse has native non-bpf support
for famfs, then it will always need to have that. That's the part that
worries me.

>
> > What are the risks of converting to BPF?

I think maybe there is a misinterpretation of what the alternative
approach entails. From my point of view, the alternative approach is
not that different from what is already in this series. The only piece
of the famfs logic that would need to use bpf is the logic for
finding/computing the extent mappings (which is the famfs-specific
logic that would not be applicable to any other server). That famfs
bpf code is minimal and already written [1], as it is just the logic
that is in patch 6 [2] in this series copied over. No other part of
famfs touches bpf. The rest is renaming the functions in
fs/fuse/famfs.c to generic fuse_iomap_dax_XXX names (the logic is the
same logic in this series, eg invoking the lower-level calls to
dax_iomap_rw/fault/etc) and moving the daxdev setup/initialization to
connection initialization time where the server passes that daxdev
setup info/configs upfront. I don't think this would delay things by
several merge windows, as the code is already mostly written. If it
would be helpful, I can clean up what's in the prototype and send that
out.

I think the part that is not clear yet and needs to be verified is
whether this approach runs into any technical limitations on famfs's
production workloads. For example, does the overhead of using bpf maps
lead to a noticeable performance drop on real workloads? In the
future, will there be too many extent mappings on high-scale systems
to make this feasible? etc. If there are technical reasons why the
famfs logic has to be in fuse, then imo we should figure that out and
ideally that's the discussion we should be having. I am not a cxl
expert so perhaps there is something missing in the approach that
makes it not sufficient on production systems. If we don't end up
going with the alternative approach, I still think this series should
try to make the famfs uapi additions to fuse as generic as possible
since that will be irreversible.

If we expedited the alternative approach in terms of reviewing and
merging, would that suffice? Is the main pushback the timing of it, eg
that it would take too long to get reviewed, merged, and shipped?

> >
> > - I don't know how to do it - so it'll be slow (kinda like my fuse lear=
ning
> >   curve cost about a year because this is not that similar to anything
> >   else that was already in fuse.
>
> ...and per above, BPF isn't some magic savior that avoids the expansion
> of the UABI.

It doesn't avoid the expansion of the UABI but it makes the UABI
generic (eg plenty of future servers can/will use the generic iomap
layer).

>
> > - Those of us who are involved don't fully understand either the securi=
ty
> >   or performance implications of this. It
>
> Correct.  I sure think it's swell that people can inject IR programs
> that jit/link into the kernel.  Don't ask which secondary connotation of
> "swell" I'm talking about.

bpf is used elsewhere in the kernel (eg networking, scheduling). If it
is the case that it is unsafe (which maybe it is, I don't know), then
wouldn't those other areas have the same issues?

>
> > - Famfs is enabling access to memory and mapping fault handling must be
> >   at "memory speed". We know that BPF walks some data structures when a
> >   program executes. That exposes us to additional serialized L3 cache
> >   misses each time we service a mapping fault (any TLB & page table mis=
s).
> >   This should be studied side-by-side with the existing approach under
> >   multiple loads before being adopted for production.
>
> Yes, it should.  AFAICT if one switched to a per-inode bpf program, then
> you could do per-inode bpf programs.  Then you don't even need the bpf
> map, and the ->iomap_begin becomes an indirect call into JITted x86_64
> math code.
>
> (The downside is that dyn code can't be meaningfully signed, requires
> clang on the system, and you have to deal with inode eviction issues.)
>
> > - This has never been done in production, and we're throwing it in the =
way
> >   of a project that has been soaking for years and needs to support ear=
ly
> >   shipments of products.
>
> Correct.  I haven't even implemented BPF-iomap for fuse4fs.  This BPF
> integration stuff is *highly* experimental code.

I think what fuse4fs needs for bpf is significantly more complicated
and intensive than what famfs needs. For famfs, the extent mapping
logic is straightforward computation.

>
> > If this is the only path, I'd like to revive famfs as a standalone file
> > system. I'm still maintaining that and it's still in use.
>
> Honestly, you should probably just ship that to your users.  As long as
> the ondisk format doesn't change much, switching the implementation at a
> later date is at least still possible.

I recognize this is an unfair situation John as you've already spent
years working on this and did what the community asked with rewriting
it. What I'm hoping to convey is that the approach where the extent
computing/finding logic gets moved to bpf is not radically different
from the famfs logic already in this patchset. In my view, moving this
logic to bpf is more advantageous for both fuse *and* famfs
(decoupling famfs releases from kernel releases) - it would be great
to consider this on technical merits if expediting the timeline of the
alternative approach would suffice.

Thanks,
Joanne

[1] https://github.com/joannekoong/libfuse/blob/444fa27fa9fd2118a0dc3329331=
97faf9bbf25aa/example/famfs.bpf.c
[2] https://lore.kernel.org/linux-fsdevel/0100019d43e79794-0eadcf5e-b659-43=
f7-8fdc-dec9f4ccce14-000000@email.amazonses.com/

>
> --D
