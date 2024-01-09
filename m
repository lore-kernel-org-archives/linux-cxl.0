Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6120E7
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IrtigMuE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a293f2280c7so393631766b.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jan 2024 13:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704835659; x=1705440459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RYRcrJ2njCxlwPi4dMGvfXtU/fOWdqaKi3X1OjueHQ=;
        b=IrtigMuEKqbmoIm76tm6QV/kbkSVdtNhcacq3sR8320aZWNOlex4aCUXPClvAmg8Ot
         Iw140+aSMKVoD1Z2XbGH2A/oGMS/07XKPwpsiAtxfykbkxDQ8+cEMOeiawsRGddbwZFJ
         nvuu+NN9SIvQCWe8riYa9Mgu+tlPqqROlLTJvJKpiEn93Wby77rvKG4fJ1JvptrcZV9D
         iBROxZVk961cg8ycKeirbE5a+20RbkbllzV6SeESBSx4GbQRzwlZ0dnNLMQrlz20IV5n
         Xp7DeoNyYe0hBWikNCmaB3zEuwSL/aTaDDFxMtTmjdNYrocSwKFHOcbF+wcsbjeZ2SwM
         k5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704835659; x=1705440459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RYRcrJ2njCxlwPi4dMGvfXtU/fOWdqaKi3X1OjueHQ=;
        b=E9AD00M9/mI6Av6zxlHEbZtFcammXxulbrnlZKpWl53NzBEQ+DerbP7Z4wFG0UNept
         hD8/mJ8Cqfl3+i7TC//sO+Aot5Z5z4pHkUQ5QO37xhYZ7pXOEI/PebYpuefIb31xg3qh
         J8rMvmEZxBfhQ2GDLF5Y2Tyy8TgfuV0wiY1VkLpYpVsLBEEuf4YKNotsvUvzV60I/XCz
         Mju7hD7G/aIP5+2ENQlZ91kPde5J8H+rPoXZRrHcLI3SPOEQ8wYM7QaWanmxocNQ0nUF
         O+WCMdACytefx1B4kp/EUz/6z0mvgmoBkiXykgOAFVQjug0EBkER/0ryRotPdpU/x3G6
         nSNA==
X-Gm-Message-State: AOJu0YyFitSTfl5IR5dEihWQmTUnjMJ6OE9FZeJA8cQTjcF7vYfSMgGR
	DPMJyQNIeuKRZCIKosx3YGNnnEQaZcQykPVSquOvMfzw3OXh8Q==
X-Google-Smtp-Source: AGHT+IELB2iV38lStakkc2NRWLmg3gGjNhZ/JM43UXn64f+wOsc6MGcQVY8z7Szp+mWheb9aXuWF+h3xi7kk1Q7o10k=
X-Received: by 2002:a17:907:94c9:b0:a29:1419:f522 with SMTP id
 dn9-20020a17090794c900b00a291419f522mr40459ejc.72.1704835659487; Tue, 09 Jan
 2024 13:27:39 -0800 (PST)
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
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com> <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
 <ZZ2lNoTQ8hDHADTT@memverge.com>
In-Reply-To: <ZZ2lNoTQ8hDHADTT@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 9 Jan 2024 13:27:28 -0800
Message-ID: <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
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

On Tue, Jan 9, 2024 at 11:58=E2=80=AFAM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Tue, Jan 09, 2024 at 11:33:04AM -0800, Hao Xiang wrote:
> > On Mon, Jan 8, 2024 at 5:13=E2=80=AFPM Gregory Price <gregory.price@mem=
verge.com> wrote:
> >
> > Sounds like the technical details are explained on the other thread.
> > From what I understand now, if we don't go through a complex CXL
> > setup, it wouldn't go through the emulation path.
> >
> > Here is our exact setup. Guest runs Linux kernel 6.6rc2
> >
> > taskset --cpu-list 0-47,96-143 \
> > numactl -N 0 -m 0 ${QEMU} \
> > -M q35,cxl=3Don,hmat=3Don \
> > -m 64G \
> > -smp 8,sockets=3D1,cores=3D8,threads=3D1 \
> > -object memory-backend-ram,id=3Dram0,size=3D45G \
> > -numa node,memdev=3Dram0,cpus=3D0-7,nodeid=3D0 \
> > -msg timestamp=3Don -L /usr/share/seabios \
> > -enable-kvm \
> > -object memory-backend-ram,id=3Dvmem0,size=3D19G,host-nodes=3D${HOST_CX=
L_NODE},policy=3Dbind
> > \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-vm=
em0 \
> > -numa node,memdev=3Dvmem0,nodeid=3D1 \
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D19G,cxl-fmw.0.interleav=
e-granularity=3D8k
>
> :] you did what i thought you did
>
> -numa node,memdev=3Dvmem0,nodeid=3D1
>
> """
> Another possiblity: You mapped this memory-backend into another numa
> node explicitly and never onlined the memory via cxlcli.  I've done
> this, and it works, but it's a "hidden feature" that probably should
> not exist / be supported.
> """
>
> You're mapping vmem0 into an explicit numa node *and* into the type3
> device.  You don't need to do both - and technically this shouldn't be
> allowed.
>
> With this configuration, you can go thorugh the cxl-cli setup process
> for the CXL device, you'll find that you can create *another* node
> (node 2 in this case) that maps to the same memory you mapped to node1..
>
>
> You can drop the cxl devices objects in here and the memory will still
> come up the way you want it to.
>
> If you drop this line:
>
> -numa node,memdev=3Dvmem0,nodeid=3D1

We tried this as well and it works after going through the cxlcli
process and created the devdax device. The problem is that without the
"nodeid=3D1" configuration, we cannot connect with the explicit per numa
node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
lb information to VM's hmat.

From what I understand so far, the guest kernel will dynamically
create a numa node after a cxl devdax device is created. That means we
don't know the numa node until after VM boot. 2. QEMU can only
statically parse the lb information to the VM at boot time. How do we
connect these two things?

Assuming that the same issue applies to a physical server with CXL.
Were you able to see a host kernel getting the correct lb information
for a CXL devdax device?

>
> You have to use the CXL driver to instantiate the dax device and the
> numa node, and at *that* point you will see the read/write functions
> being called.
>
> ~Gregory
