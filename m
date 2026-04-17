Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB61EB5C2
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386684; cv=pass; b=Hz0L4uruxN6XNu/t/0fsd9Q3s2AiGS5B90mYVuRZ/7SZYt/RsXXnw3xl986uUWQC9S1f9BeK+69/rkZdVw/OGLEePpt0xTdMF53q96kX9w43TMzMUQO08pmwmYEXpXp6WcKxRbHtGTyu05ZrLjffcyyGuBLiJwFKhf6zRyg351o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386684; c=relaxed/simple;
	bh=tCpq6Jo4S69VtWgQOHfdZhHmPAn9f34q/hcA9ixHo38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ten0404CW/kEFE3ioSQp51wUjAjV2IVjQ0ntyL/gCY2Ns32iQ81hk6I1BFzaHYO6hsIljeQwQjuTaxaQo7X49CgxfUEGwTZYy5nJolGLVth7Y64NC/km6cEBF+xR+gjL8eFm2M3UaqRc1+YCeRYscs9B0kd/pVvVsHo8RYnbDJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HckMoKg1; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HckMoKg1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d72875729so36138f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 17:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776386681; cv=none;
        d=google.com; s=arc-20240605;
        b=kSJHFeX9A1w/5VrtsMp3RdJi2FzmH1NVHGCcBYIUnzZTlqmemTHUWBsc22suc+saRy
         Tt0A1M+dyKHUBqWc0gHNR4jyoPuSdABCFA22UQjmQ/olGO34u0jIoSHtSQv9XzJS60Qs
         aIB8GaSDW1q9LnPAndAIAv76tcllCOfNk+6iyxfcFwMnyFXxvHoGqcKD7csDRG5I/YLj
         /g6IpXqVk3xOjPxURRbKMVL3sRs6F31+flIXBIw9jcAnw7mNKzX4uz5xUCwfGTef6pmq
         jMo4a56J1nUD/t+Ud766pq5joO2e8tVlBFF8XSvyC2ZbwhU8XAMl3PS91aXuuDN3HeJz
         4UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QaHD4Pp5DEt3l7q3lFH627j4dWsMdcfeRieD1J/u6kI=;
        fh=Q4hbBz7ZK+OEismnPQ1yJ6E7uaR9D+FlyFX3GG5dcC4=;
        b=PVZuAEKm9k0ynmD0EX4+eckvEh66miGu1i7mVdShAf0RlyxiwKv809PjJiu2XC9m/u
         ZOWil4sgC3SOMVbgc+w3WtpvgYoxPF/odUiop4KZu15VoeZ5vd3dH/ZRZaFr0GUmlmBd
         sifrDxpxUT9wNqpxKmW4vUe0dtreRbmVb8CrNIJXo/wchf5/9n4iOfIsvyqUl6MeHm4x
         jSDbTtubku7xk2pwoySaVNbX49dKSJY3tyPO4Cb9B1qliDiZVuWVm8uWIU5HmdtkYWjY
         gpxFYJ3d/iTxFMg0+H3huGmnrwWlw1eDqQg+Yy73BrHnCM7ZQCFzNe/t8xhYTiVkDt+9
         1kYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386681; x=1776991481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaHD4Pp5DEt3l7q3lFH627j4dWsMdcfeRieD1J/u6kI=;
        b=HckMoKg1WmSOkzoi2bBEHTES/NXj0R5KXSgBASRGo3Kncxj2bym0qmamncXUi/cuOr
         fUmgWcEso/RUwJh7lY/996p9oPWsXa/HzgOwh2EiloDrVEUzIMXIPvekfdWEIpNBs2r1
         us5DLnjV/osyZpHw1hfAUx5mqRhScYENW70Ci9t+IFOjTfMoO2//w0v9dqyi6cMnbHf+
         VKDfRyrRp9KwVXJxgWKKmm8PyyoxGz1LNpPY9iqWcLLTUIpvGCb8odj9JEHtxZY67ZyW
         t1tv93UYqDOa/T8t/Sst3oHRYNiNMd/dYFU9BcMybX8y4gSw3qQW85YiFahKwegV0UsD
         im7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386681; x=1776991481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaHD4Pp5DEt3l7q3lFH627j4dWsMdcfeRieD1J/u6kI=;
        b=AFyELp9wdKcogRGQeOpMubWP6oQfC7tiGXGaLZmf1wpDi2D+PNP0ZUa3EOvBOFDkNY
         V7AsBqRJLEDUnHd17iBwmYRWzHOD3fCAoOOgliDUJ3gG06p9cfKBo9vZF++8wYXyk0F2
         qGI9nN1Klh3yQcddTrfHYgr/PkqT0RbHNykXBSm3VTc2d60PHgl9QirrUy2TOtH8QjZL
         +Dv/NEe4t6pUO6zvhIfycoOQwWgSfnXsNX2AMmUKngwhZa721j4JxK0ffIBvC7Xv7OB9
         cgYvlM1z13i+2lmed5oEqeSJrMBj6yo3P4NnQ9t0ic1lcJ8XM9K+hzywIxNHaV5pcfLi
         QaDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/kiZM5ycx6FQBPzjl1gJPbZ01VC7VTeNRuNpUMgAw+Fo0313HcbGdBEMvR1GWzinHapdXsVLjQNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvogGU/qXNGEmdFTawgFJJlZ18+fytGi2IfLSc9IwCMDLCZNQ
	BED8ke3pJJF7+qqT/zv3IvrR/XCsvzwjmC3KLa/o13ML/DrvK0PPW503VhHN+h/95l3hTdcB8BC
	86J5rhOAx05qb/5/b3jCHsXz61jnH/QE=
X-Gm-Gg: AeBDievEi1h4d+tYlTVyuJ/ur8igvzXRoNGnBthYOdkCYi2OfO94eizNI7KnjLeOkHM
	/dfPHGiXNzXUUkz1loiHwIdQWw92W0O542fUMuehEU50zyzZu1cbyfHo4HMXu30LRo8vHpEaQ1l
	nF8hXeTaFCwbka+8XjqCNZWqhCYMEokm6IZumV9kGiNoYoNOd2lBGxgw80+kLhqH5+v9TCijBBx
	ZO0Y1eTWQyJzDDm5AAdOyXwl+AfI8DjImpqHpQNZ+UWqJ5c/EKBvahk/7aftDHeB66q5nLU+Bta
	0MeQK9Lvg0yUB5Vj
X-Received: by 2002:a05:6000:18a3:b0:43d:7ba4:6b5a with SMTP id
 ffacd0b85a97d-43fe3df25a7mr841359f8f.22.1776386680466; Thu, 16 Apr 2026
 17:44:40 -0700 (PDT)
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
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F> <43d36427-4629-4712-a262-391e64006eb5@app.fastmail.com>
 <20260416224331.GD114184@frogsfrogsfrogs>
In-Reply-To: <20260416224331.GD114184@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Apr 2026 17:44:28 -0700
X-Gm-Features: AQROBzA3h7bYhqR2C0MA-hMnz-JkcDiwwSJMMG8OlWk7w-ds2Ru8gPIaaDYL4u4
Message-ID: <CAJnrk1Y78UGLyAGVjiQ10PERTz1d2qcimok6bqCquy7jQYaXag@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <djbw@kernel.org>, Gregory Price <gourry@gourry.net>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan J Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
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
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 3:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Apr 16, 2026 at 01:53:27PM -0700, Dan Williams wrote:
> >
> >
> > On Thu, Apr 16, 2026, at 1:14 PM, Gregory Price wrote:
> > > On Thu, Apr 16, 2026 at 08:56:46AM -0700, Joanne Koong wrote:
> > >> On Tue, Apr 14, 2026 at 5:10=E2=80=AFPM John Groves <John@groves.net=
> wrote:
> > >> >
> > >> > There is a FUSE_DAX_FMAP capability that the kernel may advertise =
or not
> > >> > at init time; this capability "is" the famfs GET_FMAP AND GET_DAXD=
EV
> > >> > commands. In the future, if we find a way to use BPF (or some othe=
r
> > >> > mechanism) to avoid needing those fuse messages, the kernel could =
be updated
> > >> > to NEVER advertise the FUSE_DAX_FMAP capability. All of the famfs-=
specific
> > >> > code could be taken out of kernels that never advertise that capab=
ility.
> > >>
> > >> I=E2=80=99m not sure the capability bit can be used like that (thoug=
h I am
> > >> hoping it can!). As I understand it, once the kernel advertises a
> > >> capability, it must continue supporting it in future kernels else
> > >> userspace programs that rely on it will break.
>
> So don't break fuse servers.  If you wanted to (say) get rid of
> GET_FMAP in favor of IOMAP_BEGIN, you could alter libfuse to translate a
> fuse server's ->get_fmap implementation into the equivalent
> ->iomap_begin, and eventually the kernel can stop making GET_FMAP calls
> to userspace.

I don't think it's this simple. We can't assume libfuse is the only
way servers talk to the kernel. Some servers use the /dev/fuse
interface directly. And, as I understand it, this would still break
users who are on older versions of libfuse if they upgrade to a newer
kernel.

My reason for pushing back isn't because I don't want this to work; I
just want to make sure that if we're going to rely on this as a safety
hatch, then we can actually do it.

Going back to what Dan said about using the capability bits for
deprecation, "In some future kernel the famfs native option disappears
after a deprecation period" - what does the deprecation period/process
look like? Do you have to wait a certain amount of time before it can
be fully removed or is it pretty immediate?

>
> The trouble here is that I've also seen half a dozen projects vendoring
> libfuse so that's a nightmare that will have to be dealt with.  But
> maybe that doesn't even matter, because...
>
> > > FUSE_DAX_FMAP is already conditional on CONFIG_FUSE_DAX, the kernel i=
s
> > > not required to continue advertising FUSE_DAX_FMAP in perpetuity.
> > >
> > > Setting CONFIG_FUSE_DAX=3Dn does not mean userland "is broken", this =
would
> > > only be the case if FUSE_DAX_FMAP was advertised but not actually
> > > supported.
>
> ...the memory interleaving is a rather interesting quality of famfs.
> There's no good way to express a formulaic meta-mapping in traditional
> iomap parlance, and famfs needs that to interleave across memory
> controllers/dimm boxen/whatever.  Throwing individual iomaps at the
> kernel is a very inefficient way to do that.  So I don't think there's a
> good reason to get rid of GET_FMAP at this time...

So could we make the interleaving part generic then? Striped /
interleaved layouts are used elsewhere (eg RAID-0, md-stripe, etc.) -
could we add a generic interleave descriptor to the uapi and use that
for what famfs needs?

>
> > > If DAX were removed from the kernel (unlikely, but stick with me) thi=
s
> > > would be equivalent to permanently changing CONFIG_FUSE_DAX to always
> > > off, and there would be no squabbles over whether that particular
> > > change broke userland (there would be much strife over removing dax).
>
> ...however the strongest case (IMO) would be if (having merged famfs) we
> then merge fuse-iomap after famfs.  Then we extend the existing
> fuse-iomap-bpf prototype to allow per-mount and per-inode iomap bpf ops.
> That enables us to analyze thoroughly the performance characteristics of:
>
> a) Using GET_FMAP as-is
>
> b) Uploading raw iomaps (HA)
>
> c) Uploading a single bpf program to make iomaps, exchanging fmap-style
> mapping data into a bpf map, and having the single bpf program walk
> through the map
>
> d) Uploading a custom bpf program per famfs file to make iomaps.  No
> bpfmap required, but the setup and compilation are now much more complex
>
> Then we'll finally know which approach is the best, having broken the
> Gordian Knot of how to merge famfs and fuse-iomap.
>
> If we decide that (c) or (d) are actually better, then guess what?  To
> get any of the iomap functionality, you have to set an inode flag, and
> that (FUSE_CAP_FAMFS && FUSE_CAP_IOMAP && FUSE_ATTR_IOMAP) is the signal
> for "don't call GET_FMAP".  FUSE_CAP_FAMFS && (!FUSE_CAP_IOMAP ||
> !FUSE_ATTR_IOMAP) means "call GET_FMAP".
>
> Yes, we burn a couple of fuse command values to find out, but that's all.
>
> (TBH I still dislike GET_DAXDEV, that really should just be another
> application of backing files, and the backing file id gets passed to
> GET_FMAP.)
>
> What do you all think of doing that?

To be completely honest, this is orthogonal to what I was hoping we
could discuss on this thread. My main concern is the GET_FMAP part.
Can we make it more generic to other interleaved/striped layouts?

Thanks,
Joanne

>
> > > While not a deprecation method, this is what capability bits are
> > > designed for. Same as cpuid capability bits - just because the bit is
> > > there doesn't mean a processor is required to support it in perpetuit=
y.
> > >
> > > They're only required to support it if the bit is turned on.
> > >
> >
> > Right, if the protocol on day one is "user space must ask which method
> > is available", then userspace can not be surprised when one option
> > disappears. So to give time for the bpf approach to mature the kernel
> > can do something like "famfs and bpf  mapping support are available".
> > In some future kernel the famfs native option disappears after a
> > deprecation period.
> >
> > When folks ask 10 years from now why this ever supported optionality
> > the explanation is "oh because famfs enjoyed first mover advantage to
> > prove out fs semantics layered on dax devices", or "turns out there
> > are some cases where bpf is not fast enough but it still stops the
> > proliferation of more in kernel mapping implementations".
>
> Yes.  We're not *capable* of determining the best mechanism unless we
> can start shipping these things to users to get their feedback.  Only
> then can we iterate and make real improvements.
>
> > Something like FUSE_DAX_FMAP is always available but the backend to
> > that is optionally native vs bpf. ...or some other arrangement to make
> > it clear that native might be gone someday.
>
> --D
