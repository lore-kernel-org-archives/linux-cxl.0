Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F3E480
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e5LXuhcI"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso37419931fa.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jan 2024 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704844559; x=1705449359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deI9GyKmvHyCD066H+Wu2YAjGfRVp8M+T1N2HV8O5I4=;
        b=e5LXuhcIeAM/zP8PKyHWfOSL5CzmG2hlGtTfQ36WK4SCnm4nK9uvuCn67Aa8cHBwUH
         BYzqkySXiiIiZ3tFRLYXuZFcg0g1+Kx+Bc1xa4UrQ/92HaG82xYx8vKZKRaHHzPHBDLD
         GBpKQDyroAfppvtY+1c8ZgP561yvWAW38RCseCwl45BNPxT+2uOpOvdtQ/ySkypbodzX
         Rx4wVwg093Hted5BQI2YVRHJ+Xty9Q4kwxMd9VdJhw0avQV5v0bEmKedj8X5fB6O7lYD
         /XCyv/iEbyPS2MmCr9HJgnVRfuBlO4a5/iuwRyjkB8l8Ws39W3gj3+qYlReqHtniEgj/
         TQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844559; x=1705449359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deI9GyKmvHyCD066H+Wu2YAjGfRVp8M+T1N2HV8O5I4=;
        b=OfGhDpYFFjM7Z0fvY8Az7QfbCcG3fYA9mhkBuyGuCWk5GnVEAb0uJ2JAl3QX4wRV6a
         +nSu09fjAF0JMlz7EpKglWW6PjKGKT9Li3gwn3T5SAny9exJlZUcqGPOoXUHfc9BuFP2
         U1cfDMRrIZ2VwtYJ/4olg2/4rHvcpNvTBzylvrempstaiOzA8A8KSuYtc3K30cog8W6Q
         7PqSZBUQr7/Tqj4AyRlHkb6tzONArym2iD01MzruCK+EUSK/nFntj8m4f+8/3ftXQCK2
         4SqYksbxym9Ny579TR9umji3JrsEQTTdDFaOxRkDd+sEp+by5D6V2UvJ9fzBPlaqQ4q3
         vyQQ==
X-Gm-Message-State: AOJu0Yyqfr+Z27dPBezQt5WrEcggidMvm4w7YLEd24AmuFAPwPtctEXH
	gNQQFWKv1mMbm3igN3TPFhcRud3J5PvxO3gST7D5iC4DpCFraA==
X-Google-Smtp-Source: AGHT+IH8niV1qNroh8QduYcojlVVDQFS9X2GkpYdi7ulR8Zvv4CkOMPH0UDDuHXqgIb4u1lPoAwHj9mmHs1ntGL5UpY=
X-Received: by 2002:a05:6512:1587:b0:50e:7be8:4705 with SMTP id
 bp7-20020a056512158700b0050e7be84705mr24917lfb.260.1704844558979; Tue, 09 Jan
 2024 15:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com> <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com> <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com> <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
 <ZZ2lNoTQ8hDHADTT@memverge.com> <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
 <ZZ3FAegN/ezu9Ghy@memverge.com>
In-Reply-To: <ZZ3FAegN/ezu9Ghy@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 9 Jan 2024 15:55:46 -0800
Message-ID: <CAAYibXhTUgd+z3Xqk7yeWqQmHxtDmf3Ud_01iEHS0KRj9GhjUw@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: Gregory Price <gregory.price@memverge.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gregory Price <gourry.memverge@gmail.com>, 
	Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 2:13=E2=80=AFPM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Tue, Jan 09, 2024 at 01:27:28PM -0800, Hao Xiang wrote:
> > On Tue, Jan 9, 2024 at 11:58=E2=80=AFAM Gregory Price
> > <gregory.price@memverge.com> wrote:
> > >
> > > If you drop this line:
> > >
> > > -numa node,memdev=3Dvmem0,nodeid=3D1
> >
> > We tried this as well and it works after going through the cxlcli
> > process and created the devdax device. The problem is that without the
> > "nodeid=3D1" configuration, we cannot connect with the explicit per num=
a
> > node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
> > code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
> > lb information to VM's hmat.
> >
>
> Yeah, this is what Jonathan was saying - right now there isn't a good
> way (in QEMU) to pass the hmat/cdat stuff down through the device.
> Needs to be plumbed out.
>
> In the meantime: You should just straight up drop the cxl device from
> your QEMU config.  It doesn't actually get you anything.
>
> > From what I understand so far, the guest kernel will dynamically
> > create a numa node after a cxl devdax device is created. That means we
> > don't know the numa node until after VM boot. 2. QEMU can only
> > statically parse the lb information to the VM at boot time. How do we
> > connect these two things?
>
> during boot, the kernel discovers all the memory regions exposed to
> bios. In this qemu configuration you have defined:
>
> region 0: CPU + DRAM node
> region 1: DRAM only node
> region 2: CXL Fixed Memory Window (the last line of the cxl stuff)
>
> The kernel reads this information on boot and reserves 1 numa node for
> each of these regions.
>
> The kernel then automatically brings up regions 0 and 1 in nodes 0 and 1
> respectively.
>
> Node2 sits dormant until you go through the cxl-cli startup sequence.
>
>
> What you're asking for is for the QEMU team to plumb hmat/cdat
> information down through the type3 device.  I *think* that is presently
> possible with a custom CDAT file - but Jonathan probably has more
> details on that.  You'll have to go digging for answers on that one.

I think this is exactly what I was looking for. When we started with
the idea of having an explicit CXL memory backend, we wanted to
1) Bind a virtual CXL device to an actual CXL memory node on host.
2) Pass the latency/bandwidth information from the CXL backend into
the virtual CXL device.
I didn't have a concrete idea of how to do 2)
With the discussion here, I learned that the information is passed
from CDAT. Just looked into the virtual CXL code and found that
ct3_build_cdat_entries_for_mr() is the function that builds this
information. But the latency and bandwidth there are currently
hard-coded. I think it makes sense to have an explicit CXL memory
backend where QEMU can query the CXL memory attributes from the host
and pass that information from the CXL backend into the virtual CXL
type-3 device.

>
>
> Now - even if you did that - the current state of the cxl-type3 device
> is *not what you want* because your memory accesses will be routed
> through the read/write functions in the emulated device.
>
> What Jonathan and I discussed on the other thread is how you might go
> about slimming this down to allow pass-through of the memory without the
> need for all the fluff.  This is a non-trivial refactor of the existing
> device, so i would not expect that any time soon.
>
> At the end of the day, quickest way to get-there-from-here is to just
> drop the cxl related lines from your QEMU config, and keep everything
> else.

Agreed. We need the kernel to be capable of reading the memory
attributes from HMAT and establish the correct memory tier for
system-DRAM (on a CPUless numa node). Currently system-DRAM is assumed
to always be fast tier.

>
> >
> > Assuming that the same issue applies to a physical server with CXL.
> > Were you able to see a host kernel getting the correct lb information
> > for a CXL devdax device?
> >
>
> Yes, if you bring up a CXL device via cxl-cli on real hardware, the
> subsequent numa node ends up in the "lower tier" of the memory-tiering
> infrastructure.
>
> ~Gregory
