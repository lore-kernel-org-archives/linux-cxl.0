Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586B26AE1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XBW5v38L"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55790581457so2049997a12.3
        for <linux-cxl@vger.kernel.org>; Mon, 08 Jan 2024 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704754069; x=1705358869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU5iUIUz5AvAKHcKU1Jgq94VzySO/q5wQJDD8hZswmM=;
        b=XBW5v38L3rjoQWjTi/iYcWrlEVyBSRHs27TvdsCFIQ+ZloFrgZvS9ZOKw3x07dA7bf
         +HTVpJclsiMRACsT1WY7V2xF/Rkwm8G+G3zqKA8VfaTSDHmWlKnGxLn6dcXSM77FV6+E
         Wlc0q6ggjn++gch5j3QmrqF87983V+i7kJrHnVXvMBG8vdZwhkbx1/esykac6PzfjffS
         G0/w5WSK5VoGQE7nYqROe3phR4Ca1xvB0HnhT4upaDI2euGOnilQbi7BoIx03DkvLy5g
         IQqBPXc9EdDcTHnoqfI5glABIGz6Lmi9hb+EzHVYnrtbpgHDaE9ojfI6giKJa07C3sC4
         BXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704754069; x=1705358869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU5iUIUz5AvAKHcKU1Jgq94VzySO/q5wQJDD8hZswmM=;
        b=ovnnWf8Jbz8qtD4/pYMci2Fb7vN9IIK/1x4wuc3bGNDReEZr330kyb/n3ix4pjbwUb
         536hqdtqc32F/2h6b8c/7rsxDzt/BNd50mPK6AfWJknBdhdjHzzxHIkmJnYarCaY+fn/
         n3LMwY1pqf3ijb5JNsR2Q+nl8dA1m2Akx321IcVShkxAbODNQet5mVnW2l1I/tCObOzx
         6J69lOcPRG6WgdSJzOhzBxI0z4iyhfH19EFofWlQdX9xtkWqVhIvK7gig7gNooWvmKW+
         XAZCxvGvrq1d8h1uNy0ZpwXlNBDEAVvUebLNhZSGTJh4mu68Ljku9Ogz8kmO6SznRMb8
         vBRw==
X-Gm-Message-State: AOJu0Yzh4S6uE6YnRfAJkjSSwbJVgYzU4fxytnqd1duZOY6wMVeHNQls
	h4NzMajiQmD0YRtklTAJ5VFQUtfPn254QXJUOnCmkTv7Pr9J0Q==
X-Google-Smtp-Source: AGHT+IHxjyzHsgvVkrQ/nH+HF/FWxC5IUrrAwOyyY+znamR0WhvZKfmd11bHaKCdubV6+fL09EqQLpW1nNqhpdo6EgA=
X-Received: by 2002:aa7:c601:0:b0:554:1af:fe19 with SMTP id
 h1-20020aa7c601000000b0055401affe19mr2499884edq.71.1704754068840; Mon, 08 Jan
 2024 14:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com> <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com> <ZZwtmiucNXxmrZ7S@memverge.com>
In-Reply-To: <ZZwtmiucNXxmrZ7S@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 8 Jan 2024 14:47:37 -0800
Message-ID: <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: Gregory Price <gregory.price@memverge.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben Widawsky <ben.widawsky@intel.com>, 
	Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
	Ira Weiny <ira.weiny@intel.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:15=E2=80=AFAM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> > On Wed, Jan 3, 2024 at 1:56=E2=80=AFPM Gregory Price <gregory.price@mem=
verge.com> wrote:
> > >
> > > For a variety of performance reasons, this will not work the way you
> > > want it to.  You are essentially telling QEMU to map the vmem0 into a
> > > virtual cxl device, and now any memory accesses to that memory region
> > > will end up going through the cxl-type3 device logic - which is an IO
> > > path from the perspective of QEMU.
> >
> > I didn't understand exactly how the virtual cxl-type3 device works. I
> > thought it would go with the same "guest virtual address ->  guest
> > physical address -> host physical address" translation totally done by
> > CPU. But if it is going through an emulation path handled by virtual
> > cxl-type3, I agree the performance would be bad. Do you know why
> > accessing memory on a virtual cxl-type3 device can't go with the
> > nested page table translation?
> >
>
> Because a byte-access on CXL memory can have checks on it that must be
> emulated by the virtual device, and because there are caching
> implications that have to be emulated as well.

Interesting. Now that I see the cxl_type3_read/cxl_type3_write. If the
CXL memory data path goes through them, the performance would be
pretty problematic. We have actually run Intel's Memory Latency
Checker benchmark from inside a guest VM with both system-DRAM and
virtual CXL-type3 configured. The idle latency on the virtual CXL
memory is 2X of system DRAM, which is on-par with the benchmark
running from a physical host. I need to debug this more to understand
why the latency is actually much better than I would expect now.

>
> The cxl device you are using is an emulated CXL device - not a
> virtualization interface.  Nuanced difference:  the emulated device has
> to emulate *everything* that CXL device does.
>
> What you want is passthrough / managed access to a real device -
> virtualization.  This is not the way to accomplish that.  A better way
> to accomplish that is to simply pass the memory through as a static numa
> node as I described.

That would work, too. But I think a kernel change is required to
establish the correct memory tiering if we go this routine.

>
> >
> > When we had a discussion with Intel, they told us to not use the KVM
> > option in QEMU while using virtual cxl type3 device. That's probably
> > related to the issue you described here? We enabled KVM though but
> > haven't seen the crash yet.
> >
>
> The crash really only happens, IIRC, if code ends up hosted in that
> memory.  I forget the exact scenario, but the working theory is it has
> to do with the way instruction caches are managed with KVM and this
> device.
>
> > >
> > > You're better off just using the `host-nodes` field of host-memory
> > > and passing bandwidth/latency attributes though via `-numa hmat-lb`
> >
> > We tried this but it doesn't work from end to end right now. I
> > described the issue in another fork of this thread.
> >
> > >
> > > In that scenario, the guest software doesn't even need to know CXL
> > > exists at all, it can just read the attributes of the numa node
> > > that QEMU created for it.
> >
> > We thought about this before. But the current kernel implementation
> > requires a devdax device to be probed and recognized as a slow tier
> > (by reading the memory attributes). I don't think this can be done via
> > the path you described. Have you tried this before?
> >
>
> Right, because the memory tiering component lumps the nodes together.
>
> Better idea:  Fix the memory tiering component
>
> I cc'd you on another patch line that is discussing something relevant
> to this.
>
> https://lore.kernel.org/linux-mm/87fs00njft.fsf@yhuang6-desk2.ccr.corp.in=
tel.com/T/#m32d58f8cc607aec942995994a41b17ff711519c8
>
> The point is: There's no need for this to be a dax device at all, there
> is no need for the guest to even know what is providing the memory, or
> for the guest to have any management access to the memory.  It just
> wants the memory and the ability to tier it.
>
> So we should fix the memory tiering component to work with this
> workflow.

Agreed. We really don't need the devdax device at all. I thought that
choice was made due to the memory tiering concept being started with
pmem ... Let's continue this part of the discussion on the above
thread.

>
> ~Gregory
