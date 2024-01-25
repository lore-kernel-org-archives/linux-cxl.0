Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152A1B59A
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170525; cv=none; b=kfSUzzHsN6cJxc3ngc187oKeryX9tR71q+hTVt8levYC+j90G6T4ioLdiQCkC3SY/ju9HN+5hIB5iK9ZN41Koj+4kq8l3EfKWff/yzanbINZHZ/wS6/oi+Q8d7vC4w28q1bIwMrhe84uE4aY/gg8g4vLeslYqgIPPgzZJEleAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170525; c=relaxed/simple;
	bh=/dBNYHEgqhcLul2n3/hGK3U9pQ0WXMcTGfm757+EZ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCHKE+SpC/aYxSCWrmRSUpOm735GpZBm0A3Qi/ZvOpjDg4+UASiOkoWMOXXiolBR0FMhQcKWRybSotre2UFa4gJVgWj1ulM6S4NC8Qxyj7sSO7ctnJpA0lsN/leFFgVeUBmcQu68iVFX4jNg6C3xx3bZaE1cvh7QPLCgQfWXmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzhzeAM8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzhzeAM8"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so5840588a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 00:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706170521; x=1706775321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH8V0E7LZ1SDI8vGKiHRm8gmkcG4MdsVIogs98oIn+s=;
        b=kzhzeAM8AQux2cAzfJ7zOa2G3OAJQv5ilezkVzc5B+lro/r8wvAG7ZWRC4XDAH72+O
         l1OwiE5fvXUhOzJ7+hWtwo3LGugKE26ZupVURe1vm+I9N7Qmnx41wr727ReXIBgVjch2
         lcoldUIJ3ql3/zWyc5b82qfQpZOUGXydN1jilqGhIqP7PWkvWLag5I9RK0tuhjdTLB1n
         VYIk5dO59pgyGjCDAYZGncKoIhGxChhBj1/VMguu/kPeSMnjuv02OuN/TVkjPQHCPecc
         WgXCxXt1JTAGgGpmiNP+6LHPdsHAjNWY7iOSVIiaGo0qG8Tfkagwv/CmZv1Z4WF3qWu9
         PWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170521; x=1706775321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH8V0E7LZ1SDI8vGKiHRm8gmkcG4MdsVIogs98oIn+s=;
        b=jKlFcUzqfbE1Tr4/NLXCcn0SGEzVb8eUi+VkT6zqp3CnhSyuI+TNP6s8XNCAZlkYSE
         v++l8TFiCtQkTwEkxHFo1856CSxlPpO3PODETdsoWWP5rruIZf48qu//H7Y+FnulsMxW
         ++yzCDu9YKNGA3ey+P+SMMMMbRfGSxYAXbPmMdnB1FjNBDIJiXPIECzFVTpu/VvCX8YO
         hcjz1mplje5a0E3xkPmWvepHRZgC4SjVsAOZxQOEChIgbVO0pGeLMNCTa50wjtoiR6sE
         dTDmbbqmsSY0TRpjMJKczZXyzlLxMMY3WRhCbqwPn18+hyn9v/JIPD8Jst61yT1UkM9+
         FdOQ==
X-Gm-Message-State: AOJu0YyveF26Qw5OB/Fw5BqpQ7PG8XsASKcXlzTUfdqoug/co8uVTelw
	fYHDVDmj2nuUFSKyi3X0QeXCrPuSHj1C5sbYvWWgIj1SRGo0323diE5uaw7gkG40kjczx7BMyKZ
	iuvxT/F27NVqyZHPLrwWX6LiwW4ixaS5RA58wxKV9
X-Google-Smtp-Source: AGHT+IGuv3u+6IP+khEWZT020qk4qDXgc4McgofWBxNHy/sMqnva21m5qaEI85qI3+E/FSq/8EMoSHsKuQ2i+ZHgMsc=
X-Received: by 2002:aa7:cd88:0:b0:55c:7e29:a56f with SMTP id
 x8-20020aa7cd88000000b0055c7e29a56fmr194191edv.133.1706170521098; Thu, 25 Jan
 2024 00:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
In-Reply-To: <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
From: Sajjan Rao <sajjanr@gmail.com>
Date: Thu, 25 Jan 2024 13:45:09 +0530
Message-ID: <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
Subject: Re: qemu cxl memory expander shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks like something changed in QEMU 8.2 that broke running code out
of CXL memory with KVM disabled.
I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
this worked for me until I updated to the latest QEMU.

Is this a known issue? Or am I missing something?

Thanks,
Sajjan


On Thu, Aug 24, 2023 at 11:56=E2=80=AFAM Sajjan Rao <sajjanr@gmail.com> wro=
te:
>
> Understood. Thank you Jonathan.
>
> On Wed, Aug 23, 2023 at 10:21=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 23 Aug 2023 16:43:13 +0530
> > Sajjan Rao <sajjanr@gmail.com> wrote:
> >
> > > Thank you Dimitrios. That worked!
> > >
> > > On Mon, Aug 21, 2023 at 4:23=E2=80=AFPM Dimitrios Palyvos
> > > <dimitrios.palyvos@zptcorp.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Ah yes, I believe you need to enable the kernel config option
> > > > CONFIG_CXL_REGION_INVALIDATION_TEST for the region creation to work=
 in
> > > > QEMU. The help entry of that config option gives more info on the w=
hy.
> > > >
> > > > Hope that helps!
> > > >
> > > > Kind regards,
> > > > Dimitris
> > > >
> > > >
> > > > On Mon, Aug 21, 2023 at 12:01=E2=80=AFPM Sajjan Rao <sajjanr@gmail.=
com> wrote:
> > > > >
> > > > > Hello Dimitrios,
> > > > >
> > > > > Thank you for the pointers. I have the 6.4.10 kernel and modified=
 the
> > > > > qemu options, but now I see an error creating the region.
> > > > > Is there anything else I missed?
> > > > >
> > > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -=
t ram
> > > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > > > cxl region: create_region: region0: failed to commit decode: No s=
uch
> > > > > device or address
> > > > >
> > > > > Thanks,
> > > > > Sajjan
> > > > >
> > > > > -- qemu
> > > > >
> > > > > qemu-system-x86_64 \
> > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > >  -machine type=3Dq35,cxl=3Don \
> > > > >  -m 4G \
> > > > >  -smp cpus=3D2 \
> > > > >  -accel tcg,thread=3Dsingle \
> > > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > >  -object memory-backend-ram,size=3D256M,id=3Dcxl-mem1 \
> > > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.=
0.9  \
> > > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D=
0,slot=3D2 \
> > > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem1,=
id=3Dcxl-mem1 \
> > > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > >  -nographic
> > > > >
> > > > > -----
> > > > >
> > > > > [root@cxl-test /]# uname -r
> > > > > 6.4.10-200.fc38.x86_64
> > > > > [root@cxl-test /]# cxl list
> > > > > [
> > > > >   {
> > > > >     "memdev":"mem0",
> > > > >     "ram_size":268435456,
> > > > >     "serial":0,
> > > > >     "host":"0000:0d:00.0"
> > > > >   }
> > > > > ]
> > > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -=
t ram
> > > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > > > cxl region: create_region: region0: failed to commit decode: No s=
uch
> > > > > device or address
> > > > >
> > > > > [root@cxl-test /]#
> > > > >
> > > > > On Fri, Aug 18, 2023 at 8:31=E2=80=AFPM Dimitrios Palyvos
> > > > > <dimitrios.palyvos@zptcorp.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I am not an expert (and not 100% sure if that's what you want t=
o do),
> > > > > > but here's one way to get your configuration to work:
> > > > > > 1. Disable KVM.
> >
> > Just to second this - don't use KVM and expect it to work with CXL emul=
ation
> > if you are trying to use kmem to present it as normal memory - it shoul=
d be fine
> > as long as you never run instructions resident in that memory.
> >
> > It will crash in nasty ways due to various issues with instruction emul=
ation
> > where it is running out of memory behind the emulated interleave decode=
rs.
> >
> > So far we haven't cared enough to add the complexity that would be need=
ed
> > to make that work.
> >
> > TCG is the way to go for now.
> >
> > Jonathan
> >
> > > > > > 2. Remove the CXL NUMA node from the QEMU command.
> > > > > > 3. Use the ndctl utilities in the guest to initialize your CXL =
memory
> > > > > > and associated NUMA node.
> > > > > >
> > > > > > More specifically, I changed your QEMU command as follows:
> > > > > >
> > > > > >     qemu-system-x86_64 \
> > > > > >      -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > >      -machine type=3Dq35,cxl=3Don \
> > > > > >      -m 8G \
> > > > > >      -smp cpus=3D8 \
> > > > > >      -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > >      -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > > >      -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > > >      -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
> > > > > >      -numa node,memdev=3Dm1,cpus=3D4-7,nodeid=3D1 \
> > > > > >      -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D19=
2.168.0.9  \
> > > > > >      -device virtio-net-pci,netdev=3Dnet0 \
> > > > > >      -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > >      -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chas=
sis=3D0,slot=3D2 \
> > > > > >      -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl=
-mem1,id=3Dcxl-mem1 \
> > > > > >      -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > >      -nographic
> > > > > >
> > > > > > In the guest, install ndctl: https://github.com/pmem/ndctl
> > > > > >
> > > > > > After that, you should be able to see the CXL memory:
> > > > > >     root@cxl-img:~# cxl list
> > > > > >     [
> > > > > >       {
> > > > > >         "memdev":"mem0",
> > > > > >         "ram_size":2147483648,
> > > > > >         "serial":0,
> > > > > >         "host":"0000:0d:00.0"
> > > > > >       }
> > > > > >     ]
> > > > > >
> > > > > > And initialize it as RAM:
> > > > > >     root@cxl-img:~# cxl create-region -d decoder0.0 -s 21474836=
48 -t ram
> > > > > >     ...
> > > > > >
> > > > > > root@cxl-img:~# lsmem --output-all
> > > > > >     RANGE                                  SIZE  STATE REMOVABL=
E BLOCK
> > > > > > NODE  ZONES
> > > > > >     0x0000000000000000-0x0000000007ffffff  128M online       ye=
s     0
> > > > > >    0   None
> > > > > >     0x0000000008000000-0x000000007fffffff  1.9G online       ye=
s  1-15
> > > > > >    0  DMA32
> > > > > >     0x0000000100000000-0x000000017fffffff    2G online       ye=
s 32-47
> > > > > >    0 Normal
> > > > > >     0x0000000180000000-0x000000027fffffff    4G online       ye=
s 48-79
> > > > > >    1 Normal
> > > > > >     0x0000000290000000-0x000000030fffffff    2G online       ye=
s 82-97
> > > > > >    2 Normal
> > > > > >
> > > > > >     Memory block size:       128M
> > > > > >     Total online memory:      10G
> > > > > >     Total offline memory:      0B
> > > > > >
> > > > > >
> > > > > >     root@cxl-img:~# cat /proc/iomem
> > > > > >     ...
> > > > > >     290000000-38fffffff : CXL Window 0
> > > > > >       290000000-30fffffff : region0
> > > > > >         290000000-30fffffff : dax0.0
> > > > > >           290000000-30fffffff : System RAM (kmem)
> > > > > >
> > > > > >
> > > > > > Then you can generate traffic in the CXL NUMA node, for example=
:
> > > > > >
> > > > > >     root@cxl-img:~# numactl --membind 2 ls
> > > > > >
> > > > > > Note: The above is with linux v6.4.11.
> > > > > >
> > > > > > Hope that helps!
> > > > > >
> > > > > > Kind regards,
> > > > > > Dimitris
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Fri, Aug 18, 2023 at 11:39=E2=80=AFAM Sajjan Rao <sajjanr@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > I have a qemu + cxl configuration coming up with one configur=
ed type 3
> > > > > > > device. My goal is to generate some cxl.mem traffic in this
> > > > > > > configuration.
> > > > > > > However the numa_node is always showing as -1. I have tried v=
arious
> > > > > > > qemu command line parameters including to explicitly set numa=
_node for
> > > > > > > cxl devices.
> > > > > > >
> > > > > > > Here is my qemu command line
> > > > > > > --------
> > > > > > > qemu-system-x86_64 \
> > > > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > > >  -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > > > > > >  -m 10G \
> > > > > > >  -smp cpus=3D8 \
> > > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > > > >  -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > > > > >  -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
> > > > > > >  -numa node,memdev=3Dcxl-mem1,cpus=3D4-7,nodeid=3D2 \
> > > > > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.=
168.0.9  \
> > > > > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > > > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassi=
s=3D0,slot=3D2 \
> > > > > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-m=
em1,id=3Dcxl-mem1 \
> > > > > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > > >  -enable-kvm \
> > > > > > >  -nographic
> > > > > > > -----
> > > > > > >
> > > > > > > I see that the cxl device is listed in lspci output
> > > > > > > ------
> > > > > > > #lspci | grep -i cxl
> > > > > > > 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> > > > > > >
> > > > > > > #lspci -s 0d:00.0 -vvv | grep -i numa
> > > > > > > #
> > > > > > >
> > > > > > > -------
> > > > > > >
> > > > > > > sysfs output
> > > > > > > ----------
> > > > > > > #cat /sys/bus/cxl/devices/mem0/numa_node
> > > > > > > -1
> > > > > > > --------
> > > > > > >
> > > > > > > numactl output
> > > > > > >
> > > > > > > ------------------
> > > > > > > #numactl -H
> > > > > > > available: 3 nodes (0-2)
> > > > > > > node 0 cpus: 0 1
> > > > > > > node 0 size: 3910 MB
> > > > > > > node 0 free: 3776 MB
> > > > > > > node 1 cpus: 2 3
> > > > > > > node 1 size: 4031 MB
> > > > > > > node 1 free: 3927 MB
> > > > > > > node 2 cpus: 4 5 6 7
> > > > > > > node 2 size: 2011 MB
> > > > > > > node 2 free: 1785 MB
> > > > > > > node distances:
> > > > > > > node   0   1   2
> > > > > > >   0:  10  20  20
> > > > > > >   1:  20  10  20
> > > > > > >   2:  20  20  10
> > > > > > > -------------------
> > > > > > >
> > > > > > > The numa_node 2 is expected to be mapped to a CXL device, I d=
o see
> > > > > > > some activity in numastat output, but it's unclear if this is=
 really
> > > > > > > mapped to the CXL device since the device itself says numa_no=
de is -1
> > > > > > > (expected to show 2).
> > > > > > >
> > > > > > > Has anybody seen this behavior? Any help will be greatly appr=
eciated.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Sajjan
> > > > > >
> > > > > > --
> > > > > > **CONFIDENTIALITY NOTICE:*
> > > > > > *
> > > > > > *The contents of this email message and any
> > > > > > attachments are intended solely for the addressee(s) and may co=
ntain
> > > > > > confidential and/or privileged information and may be legally p=
rotected
> > > > > > from disclosure. If you are not the intended recipient of this =
message or
> > > > > > their agent, or if this message has been addressed to you in er=
ror, please
> > > > > > immediately alert the sender by reply email and then delete thi=
s message
> > > > > > and any attachments. If you are not the intended recipient, you=
 are hereby
> > > > > > notified that any use, dissemination, copying, or storage of th=
is message
> > > > > > or its attachments is strictly prohibited. *
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Dimitrios Payvos-Giannas, PhD
> > > >
> > > > Software Engineer
> > > >
> > > > ZeroPoint Technologies
> > > >
> > > > Remove the waste.
> > > >
> > > > Release the power.
> > > >
> > > > --
> > > > **CONFIDENTIALITY NOTICE:*
> > > > *
> > > > *The contents of this email message and any
> > > > attachments are intended solely for the addressee(s) and may contai=
n
> > > > confidential and/or privileged information and may be legally prote=
cted
> > > > from disclosure. If you are not the intended recipient of this mess=
age or
> > > > their agent, or if this message has been addressed to you in error,=
 please
> > > > immediately alert the sender by reply email and then delete this me=
ssage
> > > > and any attachments. If you are not the intended recipient, you are=
 hereby
> > > > notified that any use, dissemination, copying, or storage of this m=
essage
> > > > or its attachments is strictly prohibited. *
> >
