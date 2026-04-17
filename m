Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3351A317D
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389058; cv=pass; b=A+mmQZlv231wyM/cfJTt9R0p2JSQ9S9PJMsmn3Pvr3WoisvvSFXWr1r3cp69WGsexKwOpe37Apmjxpo+RdVv0FiF377NfzJTx+O72HFvOkwgDcLfzHvs5metP0SeC0Pev2JWoDl27iKKXw9GGREZE6pIk8Ihd/YEFd33N9rZ89g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389058; c=relaxed/simple;
	bh=/Wh0gdvtZWPb7hKtiDidqSqiK65wS9x8xeL5Zs7IDHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYQgYQPsZfxTAivKNbs9K3cg7J7wm4JMqV9FTu50npTsj2tstyFcPdYfLUsas4qwbXcYeVAEe5I4okPmRA94AawHHrjw+GIGJjXYYcPdKDgft0A4gRzIGcF/HMw+aBLMqsAS8KOcXwAP+VhmAp+RJa7U/joEo4AHaXczCx+o3Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9gj4ro7; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9gj4ro7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488c2690057so1217115e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 18:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776389056; cv=none;
        d=google.com; s=arc-20240605;
        b=jClbxwKzvRS2/lll8tbM7KAygHvJubXQE9LjSCnvuEcHoUbFl4cBLo9IvHfw4w3fc7
         LWmG9n16GE7UB9Zaj60mle3vEkC7dPrUQwdm5fR3f1giuKpofY2tsQ2x3JKaGseMbEcn
         E3nPxNRBJNLaFBhqev7g/MCLX8owIIozzv6jv53EgZjXelXrZ49mUnHXgYReRuCCBFEu
         YJXUwWZUpcNRpW3hGVl8V3TWoC848V0P80T6jamdmU0k8RuTrK9kimyyN9yhsUkR3VR/
         YpOkCWvvWIefNCLUjPmzSFSSBokMrRJxYVRbaSiFDheUMp+ls5IXE27CNqCYnddc8gK3
         0nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DF8Fi5Xe81jVgo2Oab2GxqdGUDJSWyloL5oFl/Qyv1A=;
        fh=qNWwLGjaMoKswRhtVM8MD2kaTEcTXoXihoMi8Xfmvk8=;
        b=H2TC9B4U8yJd/JQx1qT1mo6I83Y18tGthdnBa9tXxMxsJcfqfC5HACzfpRFozBN2XW
         jAdpVFFccHDPhAuVHf7tDxZy2jrJmnhyDp0bNuZqyAUVh2ph+30FykThR15bpQ1dvDsi
         /dpBaRxqUqNrerueIf04Wu4ydy+PSDBznwn509Gx4pIGFGDr4bj7erf+zW2xydmq3MOJ
         nC9GrSo5ZuA2867MNcqmfzQ6xNMin4Zml2lC9yUNZ2tfOWyMX34vvwbFQ6mOfehSE8oZ
         FUy4Mv77IZ5FDmXi9CnTJTUVULlrlXRM/nvagAp6aX/YvVjb6UHl8vrGgbqEXYiyFKr1
         8gcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776389056; x=1776993856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF8Fi5Xe81jVgo2Oab2GxqdGUDJSWyloL5oFl/Qyv1A=;
        b=W9gj4ro7l4Qht7UBExmdsEqIKCUXlxGjwsv8ZmUQwvbyIaUt3gxjz0PeCzdyghw95O
         YY81werdmPZVRzNJuGXu4sUTo5AWxiHIhLc7oNhMp/Ec1QFqOK67uZEu3GZdzRQ7Ou3c
         l2JR+VWgG8LiOWYmO3/GLnhOlyvEHR38qvu2qSqyvFH6xxi4Xh9Ted2sN32pjAyh53dw
         Lew6giTgyCrN6dE8l5u0nrzLoPkMz7Ka4UQ1aWX3N/35lW6UT5iPVQysL23yZn3ccnok
         Yp9+0ELVE0FWSs/I6Cz46wgWL0sFtj1rM3GnZYDwDhbECNiV/N6nx7HXqt7KFL+DK+wl
         ZPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776389056; x=1776993856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DF8Fi5Xe81jVgo2Oab2GxqdGUDJSWyloL5oFl/Qyv1A=;
        b=izQAZre0vNe3oLGaJFLxyZc6QIEXz5RZefbmJP/95th6HfnOun0KH28DsBhp29603Q
         CrVA3Cy3kfEZ5AiZIyKpKqMvIQ5XhTEJXvhTeoTlCYsyRpXqQ81mi0n7gVYjP9yLItrM
         DRNgzwVd6+th43RjvlAo6mX8kXOltbO7CGVQidxeNk10LjvS4IWI/nSjRk/ruqlgCHiQ
         nynnXzFJSo4aPZGqDpTdDyea61IYFhzwOdVvVJ4OtO37/dw5Pi1X3o53ofxlZg71k/Ks
         UfzincVOBbby6UjH+5IXFdd/0OoxoF9Blz4JC3gMdPcZi1ktT5wfhmFP8EEJZNaLEr3n
         /hNA==
X-Forwarded-Encrypted: i=1; AFNElJ8IE3V3Ndcpzgjua/G5vju2Avtc3C40bgYdRl19dANwL4CLn3BCnUEwrOMzxAAOFU/Ug2mSQS1cohM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+p0u70Q/Mmq5uyhUKB6gAY13VX5UdkJPb0BkrEG5Sg+P2lcK
	AHyRILaowp4TuMUf4I7rFtku7kX2HlnbGcZ+TadCmJe/bTiRw1eSQbMoabbNTG7M/BNKtXkPB+g
	9kKLVOVXaG+RehgeuwAQ4nLpUEW5dpC8=
X-Gm-Gg: AeBDieuBLo0YyjP9f3Y+3LRVyfSGpkejkRbUiB+gTQCdmqqj2D5FwUO37g1CG5HCPeL
	FZIjHZGOCy+NSFyNRkH6qGYqYY2cbwZsBtHE1QL7O8s/Qb+49s6cQG2qqYFd0LYWymrv8TkoulY
	vUPElu0CLbGqBDOWe7+lBHnRbET9bGxNAMvM4/TnLJtPkz/jJCI22dgrK3/BG90FHv7Bk+vNi/P
	uKR11tFrfzFoliMH0TbcT1zGyskFzPd+tYcEhj5g28rjE2S3SGKu5I2dZnNXB5CxN9HE32JiSPC
	uj6gnBHoA8ptqIAJ
X-Received: by 2002:a05:600c:3e05:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-488fb78049amr10083535e9.23.1776389055659; Thu, 16 Apr 2026
 18:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net> <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F>
In-Reply-To: <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Apr 2026 18:24:02 -0700
X-Gm-Features: AQROBzBg6NgZ5CNmgS4j3SGMK0DxASOwiPBNj6lTHP6QcfR7dRhxSVmDinTDkm8
Message-ID: <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: John Groves <John@groves.net>, "Darrick J. Wong" <djwong@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
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
	Ackerley Tng <ackerleytng@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 1:14=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Thu, Apr 16, 2026 at 08:56:46AM -0700, Joanne Koong wrote:
> > On Tue, Apr 14, 2026 at 5:10=E2=80=AFPM John Groves <John@groves.net> w=
rote:
> > >
> > > There is a FUSE_DAX_FMAP capability that the kernel may advertise or =
not
> > > at init time; this capability "is" the famfs GET_FMAP AND GET_DAXDEV
> > > commands. In the future, if we find a way to use BPF (or some other
> > > mechanism) to avoid needing those fuse messages, the kernel could be =
updated
> > > to NEVER advertise the FUSE_DAX_FMAP capability. All of the famfs-spe=
cific
> > > code could be taken out of kernels that never advertise that capabili=
ty.
> >
> > I=E2=80=99m not sure the capability bit can be used like that (though I=
 am
> > hoping it can!). As I understand it, once the kernel advertises a
> > capability, it must continue supporting it in future kernels else
> > userspace programs that rely on it will break.
> >
>
> FUSE_DAX_FMAP is already conditional on CONFIG_FUSE_DAX, the kernel is
> not required to continue advertising FUSE_DAX_FMAP in perpetuity.
>
> Setting CONFIG_FUSE_DAX=3Dn does not mean userland "is broken", this woul=
d
> only be the case if FUSE_DAX_FMAP was advertised but not actually
> supported.
>
> If DAX were removed from the kernel (unlikely, but stick with me) this
> would be equivalent to permanently changing CONFIG_FUSE_DAX to always
> off, and there would be no squabbles over whether that particular
> change broke userland (there would be much strife over removing dax).
>
> While not a deprecation method, this is what capability bits are
> designed for. Same as cpuid capability bits - just because the bit is
> there doesn't mean a processor is required to support it in perpetuity.
>
> They're only required to support it if the bit is turned on.
>
> ---
>
> I think the focus here needs to be on whether this interface ACTUALLY
> needs to be more generic - and whether that is actually FEASIBLE.
>
> It's not like this is a new problem - and there are real design reasons
> why John chose this route.
>
> The additional overhead is not trivial for FAMFS - FAMFS is not doing
> i/o.  He already has data showing fuse caused a performance hit due to
> overhead on open - his concern of overhead on fault being catastrophic
> is grounded in data.
>
> For others it's an age old problem of self-describing protocols (parsing
> vs giant inflexible binary blobs, pick your poison).  It's extremely
> unlikely we will find a one-size-fits-all solution that doesn't
> eventually run right back into this same problem.
>
> I worry that this discussion is going to turn towards implementing a
> solution grounded in parsing arbitrary formats and how to store them,
> and that is completely detached from why FAMFS went this route in the
> first place.
>
> I question whether the actual issue here lies in the interface APPEARING
> more general purpose than it actually is - and therefore inviting
> attempts to over-genericize it.

Would you mind clarifying this part? Are you saying that the interface
and logic is *already* generic and usable for other dax-backed
servers, just that everything is *named* famfs but it's not really
famfs specific? That's what I was trying to figure out - looking at
the uapi, it seems pretty generic with defining bytes, strips, chunk
size, etc which all seem like general concepts but the naming of it is
so implementation-specific, eg

enum fuse_famfs_file_type {
        FUSE_FAMFS_FILE_REG,
        FUSE_FAMFS_FILE_SUPERBLOCK,
        FUSE_FAMFS_FILE_LOG,
};

enum famfs_ext_type {
        FUSE_FAMFS_EXT_SIMPLE =3D 0,
        FUSE_FAMFS_EXT_INTERLEAVE =3D 1,
};

struct fuse_famfs_simple_ext {
        uint32_t se_devindex;
        uint32_t reserved;
        uint64_t se_offset;
        uint64_t se_len;
};

struct fuse_famfs_iext { /* Interleaved extent */
        uint32_t ie_nstrips;
        uint32_t ie_chunk_size;
        uint64_t ie_nbytes; /* Total bytes for this interleaved_ext;
                             * sum of strips may be more
                             */
        uint64_t reserved;
};

struct fuse_famfs_fmap_header {
        uint8_t file_type; /* enum famfs_file_type */
        uint8_t reserved;
        uint16_t fmap_version;
        uint32_t ext_type; /* enum famfs_log_ext_type */
        uint32_t nextents;
        uint32_t reserved0;
        uint64_t file_size;
        uint64_t reserved1;
};

which made me think this is only famfs-specific. Are all of these
reusable / generally applicable structs? And just to double-check, the
computation logic in patch 6 [1] would be generic to other dax-backed
servers as well or is that part famfs-specific?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/0100019d43e79794-0eadcf5e-b659-43=
f7-8fdc-dec9f4ccce14-000000@email.amazonses.com/
>
> Is there a world here where this is solved by a name change and a
> capability bit?  I think so.
>
> ~Gregory
