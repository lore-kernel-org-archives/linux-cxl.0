Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD024367B99
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731392; cv=pass; b=LIPTJc1Y9dgscflH+tTU5VrqZjtKqojtlec9JbF+03BU98kzco6I9C8Sdxqb0G0atTSHhtZ003N/v0Czvw5xE3Pvp8woyx4kw9kMSsaq1JyEcqcfgzt57UmUUB8O7qlafD/VRDYrj94fs/bkmJr576YZ7vv69/UAiLobxpHtPB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731392; c=relaxed/simple;
	bh=ahrPeW46a3z7uaEO1zJL6eWoGd4K9B9MS3EeUm2ySI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVwbl0AFJ+3Rb4V33nUTLOxPWJqcwASJLvvws5ujjGVDVrL/ltVb7BWKa7qezKSPrRntxzEs5NrkjOMBi+xCCcOnmtW56RnEGRpQZOTYXaIFbutXBPQYmRznPsHIKuotf5oSwDDrhoPmNEpdpWHInviSqXinHs571OweOFclg/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=on3kEE9O; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="on3kEE9O"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758bd3731bso4971923f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 07:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784731387; cv=none;
        d=google.com; s=arc-20260327;
        b=n06ZyomPmHbWlLujt1upWtlgvL7LRPH/GwUudpNJ+gkrhhbOZ18GQuNwJDuxQAjIrb
         fu6JOh2RcHUA36xW0mfH6i9xZuFvhhqjedKq3hGzPbKmPgZ3EV57hxkYOB0s7Ef/Hen6
         EEO7Y4xY8q73e1rdgusgh3DjPb+DzNVSpZYXN6AsE3MFe/G2OYAUBfdct20uXRrsIhFW
         yHEeVbtcaQg9CAsT1xWpeWeqr11RSAnE6Tm5Kjvr0l5oQDjt93WqP2tyY5LXor0u+gYg
         EY6jeKx0lyA0eOrYARB/DcHK3ASdE2+XZ26aIPgmxpPNB0nskw+RvEL4zP/XxBGU77df
         Zesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbVVn3kwJvwjtX0fZqdUSffXklqAZ5aOd6f3vVAXXIo=;
        fh=cdpcBl8tvnDj0+wiiNonTxWs78+uFLIJORVRmiTREc4=;
        b=DbEEj8h4MdqEn6MN7fByYk2kAdZtS7qs9yLG2pQU0ORptfReYYRVEyhCN8KwzQtg38
         SUBxTGw4GNwddabR79eSqZ7EDSGJEtA3NEGHj+qrUlAvwRqUGSj65fFdCiSDz2VnHYZb
         RMQJh1gJLm2LFHWMAT/3qqgq/4m4QVv2ajxFwr+WRlF/SpCYApfYT5giPoOcGZ5KP0lz
         22tk8aJOQIrvisqae9nJoaXgDOifU1Pj3/umih26qEavfZaT/1RaGLopea7Cfoe9qtEd
         t9Ggk0tVqgAKynRFFCfW1n6hv8M6MXzfeikz9t3AnvgW/gZw10X8IG7I1mpfzdnI9I2B
         SzOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784731387; x=1785336187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nbVVn3kwJvwjtX0fZqdUSffXklqAZ5aOd6f3vVAXXIo=;
        b=on3kEE9OMNB+hJeb4twn9+ZM0qPUJrVcaUoVNwCKVJM/eOzbi2ZssHB/P20oep9oib
         cIUZqIws6cW5gUr28iHN8kmxKCnvXFZWPRg/cGtfqU4zCGNpY70r9eFpV1oUNd+ZpSmI
         9VzHGXInYEyNvXTxMjsa1KYq+Ha0PBMKRq/YdAArIfm504MO87chHQ14GgY+SePOMbyf
         D1uiH+W3lbqwkFTOAm1l2yd4niQs6g09xtx2q+E5TcRP5o4t9lOZlmRnpd2E+/eFLfp5
         /vg13KZ/j7Y7tV1QRUkEFP+PpXEloc6tTFBtTIwSizgTRxx+g7VoQmTGbkRRkNuEG8xY
         fLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731387; x=1785336187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbVVn3kwJvwjtX0fZqdUSffXklqAZ5aOd6f3vVAXXIo=;
        b=ZbHB12WS4PGKlc5p8JJyvTlT6E3CKQv0iOQmlXrlZQMWQBCgEP39TfVzycTzY33zKG
         9NkMzN1zjwCtOJ4XiWDkwGwBt1im6h7Q2FphBqg1dLRvJhbtbnid9hkBv6mSM/NtVEvE
         h2D5/xU+OU+OBz9qbYlhAs9PCDnKovlMfezmn2UeUPraPs3evHMlCeklJF3w4bm6tjyR
         iSr0j7CQnybzRETz+b9pV+ZnQZH5A4/guWheGfF7zcjnPQt4rmCONSMvYBc0MuIqPpNi
         6iBKkiShU3Ckdb6l0K/Gc3lVIAoM22FOEFqBgSRcyo1LCEmK8Frt9K7yn5on0SmJXP9g
         tLhw==
X-Forwarded-Encrypted: i=1; AHgh+Ro75YI1t0gSBzoRXD1t3uwowyPprrKZL46QEtyY3brXG7JO+Wl5GGzZIV70hdonLAV7+6Ij3OSmFp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsJ1jORAd8hYn8WLBFt7HzT3HMIAFsSp8z4OkxWg3XBn7AVBv
	A5dbv4KUPlIts2Fk+ync0YjLerElZQWMubUa+Vum2dMzllYj2Sf7HbuoAFzpER/DlvzsmWg7hWD
	jGxD0DnCGK3lKoSAr/qewdHWgk3bRIUI=
X-Gm-Gg: AR+sD13OI7XjI2BHi2ZgccvZ5pQO5NAQBexWfP7SBMQSXRcH4oMIGiFrpd0pfFIWZhm
	hubQAHB38hD6eF7gLC5oNl5714Q3mmqj2k2ZvQHaSePPokgD2Z4rqRIgDV1FN0ohYmv//79n0gG
	9K6r1IqL8luzZ+Z5GsrbPVWSe0xIJ1WY59nEaix8UMnfHfbVmCO1tgYUNUzoALSHR5LdjFCQTeT
	rDOweRsWCqcX/RFSUN8fqJQIsc0HEs0Cfi+frKJXeb5eCD4qTTa2mFzwgZyqT4g01/sNIgHKdMN
	GcVLPgzREX7yabpwp0set9poGVclE0uDPmdcET/JVA==
X-Received: by 2002:a05:6000:2a0f:b0:47f:6d9b:f204 with SMTP id
 ffacd0b85a97d-47f840d1199mr3725320f8f.23.1784731386878; Wed, 22 Jul 2026
 07:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com> <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jul 2026 07:42:52 -0700
X-Gm-Features: AUfX_mwxuEB8MpcAvVdcxrfmXjtIkJPDlLRoLVxYiUNlL8we5MhuKUq5tNA-EIo
Message-ID: <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:47=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jul 22, 2026 at 12:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > On Mon, 20 Jul 2026 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > > It's not about this ioctl, it's about infrastructure reuse.
> > > It's about the fact that there is NOTHING special about dax_devlist;
> > > and no reason not to manage it via backing_files_map.
> > >
> > > The reason you stated was that you want userspace to determine the
> > > daxdev_index/backing_id - fine, no problem - this is why I asked that
> > > you pass it the desired backing_id in the ioctl.
> > > In fact I think that all fuse backing_ids would be better assigned by=
 user space
> > > so the extension of padding =3D> backing_id is not unique to famfs.
> >
> > Right, so I suggest to just reuse FUSE_DEV_IOC_BACKING_OPEN and add
> > two flags: one to enable user supplied backing ID and the other to
> > indicate that fd refers to DAX device.  The changes to do compared to
> > the current patchset are quite minimal.
> >
> > > And the best part is that this request requires no changes to your us=
erspace.
> > > You already bite the bullet and maintain the new/old uapi but changin=
g the
> > > kernel implementation does not require this burden from you, so to be=
 honest
> > > I really don't understand why you did not follow Miklos' suggestion.
> >
> > Code reuse is also important, but I understand John's position to want
> > to separate famfs from existing codebase as much as possible.  And
> > because this is an implementation detail I don't want to make this a
> > show stopper.  We can easily fix it later.
> >
> > > > - Lose the famfs interleaved extent format. I have complied with th=
is request.
> > > >   It makes some things worse, but we'll discuss that later.
> > > >
> > >
> > > I am really not aware of a request to lose the interleaved extent for=
mat.
> > > How can this patch [2] from Miklos which reimplements this format as =
a generic
> > > uapi be mistaken for a request to lose this format?
> >
> > Let's not care.  We can easily add this later if famfs (or any other
> > use case) decides to want this after all.
> >
> > Making the initial patchset smaller is win in any case.
> >
> > > Let me recap the former review requests as I understand them:
> > >
> > > 1. Use ioctl instead of GET_DAXDEV
> >
> > This is done, just need to reuse the existing ioctl instead of add a
> > new one with the same semantics (okay not true because of the fixed
> > backing ID extension...)
> >
> > > 2. Use backing files infra for daxdev table
> >
> > Leave this later.
> >
> > > 3. Use ioctl instead of GET_FMAP
> >
> > Not sure we agreed to use an ioctl for extent mapping.   What we did
> > agree on was to use a generic interface that doesn't have anything
> > famfs specific in it.
>
> My bad. I thought that FUSE_DEV_IOC_STRIPE_OPEN was an
> example of how GET_FMAP should be made into a generic interface.

I had the same impression as Amir. The FUSE_DEV_IOC_STRIPE_OPEN patch
[1] right now is only for the interleaved case to handle striping, but
imo it seems a lot cleaner to make FUSE_DEV_IOC_STRIPE_OPEN a generic
interface for handling any backing layout that corresponds to a
backing id, and having the simple extent case go through this same
infrastructure / path. Especially since John's future patches for
adding the interleaving will go through the ioctl, it seems nicer
server-side as well for famfs to have one consolidated path instead of
needing two totally different ones. I think also file passthrough will
want this infrastructure in the future too, and their use case would
be mostly non-striped extents.

I was imagining something like:

struct fuse_backing_member {
    uint32_t backing_id;
    uint32_t reserved;
    uint64_t offset;
    uint64_t length;
};

struct fuse_backing_layout {
    uint16_t nr_members;
    uint16_t reserved1;
    uint32_t reserved2;
    uint64_t chunk_size;
    uint64_t flags;

    struct fuse_backing_member members[] __counted_by(nr_members);
};

which is the same as what was in the FUSE_DEV_IOC_STRIPE_OPEN patch
but just renamed and a uint64_t flags and uint64_t length field added.

This would let us eliminate GET_FMAP, which imo needs to be
eliminated. The ioctl also gives famfs more flexibility with being
able to preload extent mappings outside of the hot path instead of
being forced to only upload it on opens.

If not the ioctl, what did you have in mind for a generic interface? I
think anything else would have to keep GET_FMAP, but maybe I'm wrong
here.

I think John has patiently endured a lot of demands in the last 2
years, so I agree that anything that isn't uapi-dependent should just
be done in the future as follow-up work and shouldn't block this
series. imo the ideal version of this series would have nothing famfs
specific in it, but I think a lot of that can be renamed /
restructured internally later on. But the extent uploading / GET_FMAP
part seems like the last thing needed to figure out.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260601152327.2069787-1-mszeredi=
@redhat.com/#t
