Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056313D56B
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cvcK+Eld"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29058bb2ceso364780166b.0
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jan 2024 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704828796; x=1705433596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNXImY1syEIfjZiKRHvNyY/ycuoSTKgc9Us5kd6jarM=;
        b=cvcK+EldFfMHSHbvibaneLl1mbLI3ZzmV6XcaD32WdFS1+1R4NIRkl8XLCYEL/wN7J
         gdMSi78s5/hzgWNAdqxPJ/WzGdrOTft1VSyAdNIbOE9cWWTzMBAUwdTgjyyRgqe0AqC5
         4mmhhqaq5f2pWfsZJ7hVUcw0LFkIXyB9jm5PxnmPEGJdjmXkxheSn4s5PzCgmOiDjXiL
         PnzwuzfgReJKGmsSIfQ9RRCyALK2OzkmVnwNrbh07AZvvlUpptzk5O7od822N13Vh9q/
         wyeiCUwqUHspF51teGIJkXhjrW+l9xF/ItlAXWqL1/YuctuhtmxE5etfyoEkVgSP0T/L
         EMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828796; x=1705433596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNXImY1syEIfjZiKRHvNyY/ycuoSTKgc9Us5kd6jarM=;
        b=HzPnMHCgVDU/x54/exATZ7iFMyEeupJ3JHW5C9+eRvlXkjr/JI4C/gb4UvmH3EwfBk
         LVRivSTdZb37lu3avvUd2rtgCysX7f6+Igq2T8bEeLnyQRtMTilWvzYOD+WDLMvxe1p+
         S7VYk5s5cLYPI8j0w3bWvFBoW9lwtyRn9CeqeqBX8guZApoDfFL5fnIs/ydGCS+AKAI4
         ghSzgZ8FunYgxGhPVlKztKyRdlRcrrz0ZaVZqfRKNj5vYUlbFeMC8h93kK54H42Yo+2c
         EYlg5Max/+RTXEixho+F9V+WNc3CEUF/iNm/Vxhr0Jy4AuxDIgUZPccZ7ZefNbYRY+5m
         MntQ==
X-Gm-Message-State: AOJu0Yzi7FOIi+h9P9FYb2krZokoWmt3Mf6GR8TEK7biROISMpTmRpMM
	L3sKZwOUlSgVi+Iw/T66x/yIyjqVSC0lBYLoJo3JNkKkwar28g==
X-Google-Smtp-Source: AGHT+IHQXgRrxtgHQ5gjMGdfdQOyhiS0EaVeyFCcWXPy1MwfVx+vkMQG3msfITHs4UCydqfZakNpQJKd3MIDoet7dSM=
X-Received: by 2002:a17:906:1196:b0:a2b:85de:1590 with SMTP id
 n22-20020a170906119600b00a2b85de1590mr298225eja.159.1704828796153; Tue, 09
 Jan 2024 11:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com> <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com> <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com> <ZZydwBTS4NeSizzb@memverge.com>
In-Reply-To: <ZZydwBTS4NeSizzb@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 9 Jan 2024 11:33:04 -0800
Message-ID: <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
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

On Mon, Jan 8, 2024 at 5:13=E2=80=AFPM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Mon, Jan 08, 2024 at 05:05:38PM -0800, Hao Xiang wrote:
> > On Mon, Jan 8, 2024 at 2:47=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.c=
om> wrote:
> > >
> > > On Mon, Jan 8, 2024 at 9:15=E2=80=AFAM Gregory Price <gregory.price@m=
emverge.com> wrote:
> > > >
> > > > On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> > > > > On Wed, Jan 3, 2024 at 1:56=E2=80=AFPM Gregory Price <gregory.pri=
ce@memverge.com> wrote:
> > > > > >
> > > > > > For a variety of performance reasons, this will not work the wa=
y you
> > > > > > want it to.  You are essentially telling QEMU to map the vmem0 =
into a
> > > > > > virtual cxl device, and now any memory accesses to that memory =
region
> > > > > > will end up going through the cxl-type3 device logic - which is=
 an IO
> > > > > > path from the perspective of QEMU.
> > > > >
> > > > > I didn't understand exactly how the virtual cxl-type3 device work=
s. I
> > > > > thought it would go with the same "guest virtual address ->  gues=
t
> > > > > physical address -> host physical address" translation totally do=
ne by
> > > > > CPU. But if it is going through an emulation path handled by virt=
ual
> > > > > cxl-type3, I agree the performance would be bad. Do you know why
> > > > > accessing memory on a virtual cxl-type3 device can't go with the
> > > > > nested page table translation?
> > > > >
> > > >
> > > > Because a byte-access on CXL memory can have checks on it that must=
 be
> > > > emulated by the virtual device, and because there are caching
> > > > implications that have to be emulated as well.
> > >
> > > Interesting. Now that I see the cxl_type3_read/cxl_type3_write. If th=
e
> > > CXL memory data path goes through them, the performance would be
> > > pretty problematic. We have actually run Intel's Memory Latency
> > > Checker benchmark from inside a guest VM with both system-DRAM and
> > > virtual CXL-type3 configured. The idle latency on the virtual CXL
> > > memory is 2X of system DRAM, which is on-par with the benchmark
> > > running from a physical host. I need to debug this more to understand
> > > why the latency is actually much better than I would expect now.
> >
> > So we double checked on benchmark testing. What we see is that running
> > Intel Memory Latency Checker from a guest VM with virtual CXL memory
> > VS from a physical host with CXL1.1 memory expander has the same
> > latency.
> >
> > From guest VM: local socket system-DRAM latency is 117.0ns, local
> > socket CXL-DRAM latency is 269.4ns
> > From physical host: local socket system-DRAM latency is 113.6ns ,
> > local socket CXL-DRAM latency is 267.5ns
> >
> > I also set debugger breakpoints on cxl_type3_read/cxl_type3_write
> > while running the benchmark testing but those two functions are not
> > ever hit. We used the virtual CXL configuration while launching QEMU
> > but the CXL memory is present as a separate NUMA node and we are not
> > creating devdax devices. Does that make any difference?
> >
>
> Could you possibly share your full QEMU configuration and what OS/kernel
> you are running inside the guest?

Sounds like the technical details are explained on the other thread.
From what I understand now, if we don't go through a complex CXL
setup, it wouldn't go through the emulation path.

Here is our exact setup. Guest runs Linux kernel 6.6rc2

taskset --cpu-list 0-47,96-143 \
numactl -N 0 -m 0 ${QEMU} \
-M q35,cxl=3Don,hmat=3Don \
-m 64G \
-smp 8,sockets=3D1,cores=3D8,threads=3D1 \
-object memory-backend-ram,id=3Dram0,size=3D45G \
-numa node,memdev=3Dram0,cpus=3D0-7,nodeid=3D0 \
-msg timestamp=3Don -L /usr/share/seabios \
-enable-kvm \
-object memory-backend-ram,id=3Dvmem0,size=3D19G,host-nodes=3D${HOST_CXL_NO=
DE},policy=3Dbind
\
-device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
-device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
-device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-vmem0 =
\
-numa node,memdev=3Dvmem0,nodeid=3D1 \
-M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D19G,cxl-fmw.0.interleave-gr=
anularity=3D8k
\
-numa dist,src=3D0,dst=3D0,val=3D10 \
-numa dist,src=3D0,dst=3D1,val=3D14 \
-numa dist,src=3D1,dst=3D0,val=3D14 \
-numa dist,src=3D1,dst=3D1,val=3D10 \
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dread-=
latency,latency=3D91
\
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dread-=
latency,latency=3D100
\
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dwrite=
-latency,latency=3D91
\
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dwrite=
-latency,latency=3D100
\
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dread-=
bandwidth,bandwidth=3D262100M
\
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dread-=
bandwidth,bandwidth=3D30000M
\
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dwrite=
-bandwidth,bandwidth=3D176100M
\
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dwrite=
-bandwidth,bandwidth=3D30000M
\
-drive file=3D"${DISK_IMG}",format=3Dqcow2 \
-device pci-bridge,chassis_nr=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0xd \
-netdev tap,id=3Dvm-sk-tap22,ifname=3Dtap22,script=3D/usr/local/etc/qemu-if=
up,downscript=3Dno
\
-device virtio-net-pci,netdev=3Dvm-sk-tap22,id=3Dnet0,mac=3D02:11:17:01:7e:=
33,bus=3Dpci.3,addr=3D0x1,bootindex=3D3
\
-serial mon:stdio

>
> The only thing I'm surprised by is that the numa node appears without
> requiring the driver to generate the NUMA node.  It's possible I missed
> a QEMU update that allows this.
>
> ~Gregory
