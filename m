Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC83DCD99
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797972; cv=pass; b=AVCJg+oyiz+Bx7zg0f6yZ9MkJdaJrqF9d0lg1ef5/bNZXSL7ZIqcrGWWlLZsJ7sEKeSkWCvj8ChPRd8JmhjnQq+IZ68th6Gh/OKHhbxpyZwApidFuS9oT3RYp7MxgYXwsNX3m2s2seQ+LGzr/eljqQwaENVZvsN3xaome19i1Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797972; c=relaxed/simple;
	bh=XjAQR1r0lQrKkLZCrbGbS8NnZb6P2lNtC6R50SuCzPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFCmR6OyVvbhUpeAT3EZRTbA60o3XAzZCs9gFSG4fKQ4lDB2enURY4DZvDOYxOGwYOxofJhWz19nE+MEUsh584xGXMPhDa/1c6kYQ8uqs5FbkAUiYqov1FNjKTV1/X4HZ3dgOKsZ25UnXB5PaLpLL8N2Cmz8w0Is8dP+OQ7oig8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGP77B0W; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGP77B0W"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso52760635e9.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 11:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776797968; cv=none;
        d=google.com; s=arc-20240605;
        b=MnRyzzFHs0k7eXhjvAAraoSLu1TG1+iLiowxZgZna6tsEK2NnIr/tuYW3XIrFsx97L
         6sUTKkNsoyDitF5ILTtfOrpKCSM/ev3uThLWhiUCb7Dt0UvYBeoC9hSOnnJ2A3xwrveG
         rJObsq9bk5LsJrlvWgq0IslYXL8w2qx1mOL4+h1uRs0EUU75gzDeMJr2Q/C/SoFu1/13
         3EbSFsrojjN8PN2RcSIz9aUv3+fww8CNZc8ipwIMunr/JZxXhhbWHy3fsgNzbrpo3axr
         rkOOfQvvCmR5fyo/SDWJs9K06yLt7nfptPP8jlY+JiekNg84CkdgqoiO4A974br48x2d
         HT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0dzmsSkPtY/sR6K+ga+B+dYMUbxHjr7AOGboORaA1jw=;
        fh=L9UC1LQxNQGa2KuIOH/MmoQ2T6Wf9UTYoQlAsIUiPXI=;
        b=keT6uoicasEVBlXWLHu76Z53e9NbMqArgLnryFdc/r3FDFudXhixN7epFQ1KYlBuem
         6TItgA7Fj1UBRTr59w5PsZt/FAcX7srlgt1dM1lQY0hDlL8kIFf7mUOlpGXm1KZdVX3/
         bPjJZHLEAX3FJbceJSPkFXVL8KiDwvTQrgkLX2OS0UiYmUZPqzKTQPPMQC8deJaN1XHd
         5eoNPiEFgBTT+pCHphjzhSbh7MuGivMlM7Cr5PlWVhdZGwjAhQBLiJPzYnvsduyeLrEY
         MJwQM8rywE/DLS9Viij2mkVwEBGWkEct6+651tT+9atvGED84CB4F1q1SUoBLvP986yB
         uMiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776797968; x=1777402768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dzmsSkPtY/sR6K+ga+B+dYMUbxHjr7AOGboORaA1jw=;
        b=UGP77B0WCjeXQkNfQO2Aliq+nSQP6BIn7pkDdIHTPQbqZDGZYepSAiVINA1L7zam0o
         HzNVuMnbVfEfYmvhA4CuLuzfaDNYKpN/wncm7WdAmRgnkb0/i9yTMuH+0MC7HggX9IBf
         8cyQBoIDex9BlOpOJb1MlfB5E0l2+OvYjutrryeGxwFcVMBEktKKWJw4Tttztcf+Is4R
         Qx6GVyx/afJv2bl/TlRTaRitgSYT4JLFuOGsNRJ8GyVwgEo0jlSImiz+k/Rsp0QSkodq
         wL/FeqYFHZyNE++pFUQS58XuZpyxxVK4/EyKlFouU4/HcKduuLV28KlJ6ESvTXlr361W
         AFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776797968; x=1777402768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dzmsSkPtY/sR6K+ga+B+dYMUbxHjr7AOGboORaA1jw=;
        b=N+TPydW7IWIRg0qWrTXUFxxRgPz6niZvWeloSLIy90Ncmtff/kJYmBC+GtKc/36pHI
         rjX176R18iX5GxOUQ4VBFmM6pJ8ZGoqowSZ5x4w6cKc3FMVMw82WluzJMTHN1EISJtv6
         2QItYHGElbwzSODpFoH90CiR4zoCVZ92hS81kiQavEQoh04zFMfds63sDF117q+hB5Ek
         fPmn8xgLYpe84vCSsWIzDg5z1zzDtgUJadL4aggFyb2c+D8qmhKjo4PjXSSeNlomBKj9
         Ji/FGzUqBxH6Di8MMmeki7i044/kwYi6ixOg6LgVVVJ/wFNDupNFx3bXLTq8Ut7lsX66
         Ewlw==
X-Forwarded-Encrypted: i=1; AFNElJ/1E2U7MW8tw2PiXT3OezuWtPgZD+cTl37B5KWPwzWliSqEvZD1bJYJNk8smH6jU6YF1ZQrllaIrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03+V3R+liK+8d+RFBdKiaR2E8kcWkcx2taZuKeAmW5NSJaBQO
	J9tfoGZ3w6ycc4ElyBZ9p+K3SpPIK+lKYJRWslPGZjKjxP+wxYruv3HHdCBQYRrK4Wsu8Jy5wv3
	hndXwE7IEyBWy8Ycj6fjdFK5m3zB8azY=
X-Gm-Gg: AeBDiessDfoHJSWxH+jFFOKvwPj1XtmGJPbikhUHXBybLYHo+/YhuPmE3jKzBoNeIpX
	sXV7CjcSwTEnYo2JoU1HpCZsOeyRv7m0ePsvr9IGuMlO6NHwNx9P/dDXY5QhFeRDPe40zG5Q79L
	LEr/uWo3YMeaai9LM9NUlJnnl9KIeC0DvzpYgd2qoiMaCgElp7mVm51Idw8y2pFgOs+Kp95CgBJ
	DvMpap0EukhA6ahz/xljozIN34RImzkLukSdUi6Bsl+oBvXtleNSk6gMyVLJR83WsdfeXbul6VP
	sAeCrnQYQyShtRUxpY85vfuGXjg=
X-Received: by 2002:a05:600c:4fd1:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-488fb782a04mr281702235e9.22.1776797968112; Tue, 21 Apr 2026
 11:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F> <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <aeUU8hMwPij2WvfF@groves.net> <aeVy2MzucnrLlOQx@gourry-fedora-PF4VCD3F>
 <CAJnrk1ZpPS9rOoBqOBRsqTu0Zgk=aoYzpYZ0mAVDCoeewtLhcg@mail.gmail.com> <aeeJ8Lgg2z0X-NC_@gourry-fedora-PF4VCD3F>
In-Reply-To: <aeeJ8Lgg2z0X-NC_@gourry-fedora-PF4VCD3F>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 21 Apr 2026 11:59:15 -0700
X-Gm-Features: AQROBzCRxuv-Mo8vTeVJtIkciXT2taj5PigvXEDVcF1XUKUHVIX85BjGabelR_0
Message-ID: <CAJnrk1Zd2RFE=z=sPRCHaBdqK40+23Vv_owS=7OfxYF1TtPomg@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: John Groves <John@groves.net>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 7:30=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Mon, Apr 20, 2026 at 08:12:17PM -0700, Joanne Koong wrote:
> > On Sun, Apr 19, 2026 at 5:27=E2=80=AFPM Gregory Price <gourry@gourry.ne=
t> wrote:
> > >
> > >   struct fuse_dax_fmap_ops {
> > >       char name[FUSE_DAX_FMAP_OPS_NAME_LEN];   // 16 bytes
> > >       int (*dax_fmap_parse)(struct fuse_dax_fmap_parse_ctx *ctx);
> >
> > Just a note for later, if the bpf approach gets pursued further:
> > instead of making this a dax specific ops, I think this needs to be
> > integrated interface-wise with Darrick's fuse-iomap work since he does
> > the same thing. I think dax_fmap_parse() could be renamed to something
> > like iomap_setup(), where userspace can use this to do any sort of
> > generic setup, whether that's mapping related or dax related or not.
> > In my mind, the dax vs non dax distinction is handled by the fuse
> > iomap plumbing that chooses which iomap entry points to call,  but
> > beyond that,  the callbacks and struct ops themselves should be
> > generic enough to be shared between the two.
> >
>
> I think this is reasonable.  I'm not a FUSE wizard either, but I would
> presume the iomap_setup() process would just essentially be John's
> existing GET_FMAP / GET_DAXDEV code bundled.
>
> GET_DAXDEV happens lazily to save him the round-trips to userland if the
> DAXDEVs have already been seen previously.  I think your proposal does
> in fact save him further round trips, and it would probably solve the
> performance impact he saw from porting to FUSE.
>
> > > And otherwise, imap_begin() works exactly as Joanne proposed, but wit=
h
> > > in-kernel cached data instead of the bpfmap.
> > >
> > >   const struct dax_simple_meta *meta =3D (const struct dax_simple_met=
a *)
> > >                    bpf_fuse_dax_resolve_get_meta(ctx, 0, sizeof(*meta=
));
> >
> > another note for later, if the benchmarks prove promising and after
> > the LSF discussions we decide to go with this approach: imo we
> > could/should repurpose this into a generic
> > bpf_fuse_iomap_get_inode_meta() that returns a bounded pointer into
> > whatever opaque blob was cached on the inode during iomap_setup(),
> > where it'd be a generic kfunc serving both the dax and non-dax case
> > for any kind of mapping layout
> >
>
> Note that Christian Brauner just said he preferred not having dedicated
> bpf storage in struct inode [1].
>
> sans BPF, is there value in such a metadata blob existing?
>
> If there was a generic format, then I suppose the blob storage would not
> be BPF specific, it would just overload it (simple union).

I'm not sure if this addresses Christian's concerns or not, but the
blob would reside within struct fuse_inode not struct inode. I
definitely agree with him that this should not touch or add any infra
outside fuse.

I hadn't heard of bpf arenas until his comment. If the hashmap
overhead is too high for famfs, having a custom in-arena hash table
would be much faster I think, as it could be designed to require less
pointer chasing and avoid other overhead in the bpf hashmap
implementation, though now famfs would have to manage the data
structure and complexity itself.

Thanks,
Joanne

>
> [1] https://lore.kernel.org/linux-fsdevel/20260421-arsch-gelernt-e0b5bcd8=
a7ff@brauner/T/#m8fea90f5ed4a1b23bdc2563d978948b263b2030b
>
> ~Gregory
