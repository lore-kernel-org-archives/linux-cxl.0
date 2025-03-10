Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423418DB24
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628242; cv=none; b=lq55XUXo/jPkh5IsmBAeKmZNoB4QUGhdzgdY837ZR6ts1LitPVkSPnk8fINfe1uBsrfMT+/wOYk6Dke1Vp+0yo8yNTFesvFadAy8gR4wClrpYsyAqVNHB+1cTquFjSGQw1Wr7GBKfYaNl3vtHYkIt04oinC9O3DBiaVJu6PT3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628242; c=relaxed/simple;
	bh=i6Oo7JPXw8ZwmU7Z0I7uQJavpVnJwASSBjVbtHCaYIs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkey3TKmTgODQBQSL4/YbcafPdqpCmHNj8PVPBZA8Bc00MH0bZ8+Kbml6+Qk01kto2pWTFqXMaembhC1uTEUcG0u4pFMbICWieJiknmCt6o9qIqPyuCLjqCk+z+FGcpCKwmYwfPV9zIVMrS1tFMJM7ZrGluiaablLiEBfN2i3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M91icAJS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M91icAJS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so89432705ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741628240; x=1742233040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oDR0+j+SKc2WpKlSDjcVra1dqxqdQly0Qkl/wbhTKlc=;
        b=M91icAJSfqmpE+RH4Ou/1l3U6HQNDU+zV/494p5b4wvVPXxPuo7clg3ft04aKnJl7K
         bSBK7VzgtM1zxb/2kwoG+NfWAdAKgV9/OpcIwukGVcy7GfittRHywv1UGWNQ5NSthgWM
         OsFkQkqO9IvDPHsSJK4fFJgAbs4YKIDKjxICAf25K1QN5xb7j6Jno7YAZ6OWDazG3RlC
         gpaz2Cv5bkd34WTYCm5z92XhskYp9LMkH0HONc6GrpR22AZ3/SFpKQlXjUFwbRlcrJkb
         IKAJVX0ObMVhG7yXS3zxg4G4JvtPKTqNQDqPK8MWcgwHVVGlteSFb/QGTq2YKXnLoL53
         1Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628240; x=1742233040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDR0+j+SKc2WpKlSDjcVra1dqxqdQly0Qkl/wbhTKlc=;
        b=U3INY8eKhVWzqySAr3UVMN9vF04nqxFlFBQzqQjBQkEZ5EXhnBKcdeDY9lTlZy3744
         gNYD+6rOHrKdOvC5paDTbkQVEvDhcAh4vcpCih2xgI7knOcmmbDEqW9hfgrkO590/xgK
         xX7wXhZ9GEAt19AvDyVfUbM019bHn2jKk5sexy8SieufqUVR07a6bkS4Sl4hnyiMuqNM
         /qh9x+1xfLQwwzP6L2u9pH98hCHayHy6T2GQjme3ESvB6AaYjln4S1H2kOUjgoQtkx/M
         AzvX13KsPuorODE9+BWj0DiqKDp0hhSfhp0FxVXNjmj4aQQNyuG0hgyMhzzPfsFSfG4B
         4jgg==
X-Forwarded-Encrypted: i=1; AJvYcCUvjwQd8Ai0vNS60bjsRjrg/Qaf5CRmCGUupbZN1inMfDB21xXwuHY1tE0+hKSeQeT5s3cSr7r6BOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEPwCeouayyB09eu1vB26BXCgViknrghQ4Ue4+zXuZJhDfOuY
	vqoyv5Y3Ikq9D9mPFmOzSl0B0bn32TIg+ZwFKlCQ/BVJuy/Qf9Ar
X-Gm-Gg: ASbGncvm32MpA6U5J4uOFbrEezWtDuRnPuY2seu28ILnkax68ayYS/LaDxsJsGiFbTn
	4zaJ5Gal9Dm3o/1ecFTHff4c8CHMwetSAtmHC/crEEhGiwwZl79hRdNhvd0UEiHOkowFDc+8Qxj
	D+8G1G8VHTTOdAZu166ajhDJgNrWR/tMLFXPUSeFppkWexa3MWxPY2SVo06Sb3DIKQFuLdJU+nt
	/ObzJHSdFWl5p+vweEbbX4Hy7Tii+2+IEHS+mZly+OjpGVdozQWMDPdDH08xl0udo3MafJtropM
	CGoarhgMOe28Z8PXVPRm1O9369hGkntONnsoSFE=
X-Google-Smtp-Source: AGHT+IEl0MEtLJu05m9zmLYXS8093neAsRWHbdZkcxs1YlR4kX2dtvfRaVk1HANT4momLrQkQ1D9/A==
X-Received: by 2002:a17:903:1a0e:b0:224:1c95:451e with SMTP id d9443c01a7336-22428c0568amr227129615ad.33.1741628239587;
        Mon, 10 Mar 2025 10:37:19 -0700 (PDT)
Received: from debian ([2607:fb90:3763:49d4:27e:1b17:d3f8:f347])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c7f69089sm4103497b3a.65.2025.03.10.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:37:19 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 10 Mar 2025 10:37:15 -0700
To: Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com, dave@stgolabs.net, anisa.su887@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ira.weiny@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [ISSUE]: cxl create region with one memdev fails when we have
 more than one HBs in the cxl topology setup
Message-ID: <Z88jS06tQdN9gVNd@debian>
References: <Z8tH8BeFQ_WMYs5U@debian>
 <67cb56eea05f7_1a7f294a9@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67cb56eea05f7_1a7f294a9@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Mar 07, 2025 at 12:28:30PM -0800, Dan Williams wrote:
> Fan Ni wrote:
> > [ISSUE]: Create region with one memdev failed when we have 2 HBs in cxl=
 topology setup
> >=20
> > I create a cxl topology with 2 HBs like below:
> >              CFMW
> >            /    \
> >         HB0     HB1
> >          |       |
> >         RP0     RP1
> >          |       |
> >         pmem    ram
> >=20
> > qemu command line:
> >=20
> > /home/fan/cxl/qemu/build/qemu-system-x86_64 -s  -kernel /home/fan/cxl/l=
inux-fixes//arch/x86/boot/bzImage -append "root=3D/dev/sda rw console=3Dtty=
S0,115200 ignore_loglevel nokaslr cxl_acpi.dyndbg=3D+fplm cxl_pci.dyndbg=3D=
+fplm cxl_core.dyndbg=3D+fplm cxl_mem.dyndbg=3D+fplm cxl_pmem.dyndbg=3D+fpl=
m cxl_port.dyndbg=3D+fplm cxl_region.dyndbg=3D+fplm cxl_test.dyndbg=3D+fplm=
 cxl_mock.dyndbg=3D+fplm cxl_mock_mem.dyndbg=3D+fplm dax.dyndbg=3D+fplm dax=
_cxl.dyndbg=3D+fplm device_dax.dyndbg=3D+fplm" -smp 8 -accel kvm -serial mo=
n:stdio  -nographic  -qmp tcp:localhost:4445,server,wait=3Doff -netdev user=
,id=3Dnetwork0,hostfwd=3Dtcp::2024-:22 -device e1000,netdev=3Dnetwork0  -mo=
nitor telnet:127.0.0.1:12346,server,nowait -drive file=3D/home/fan/cxl/imag=
es/qemu-image.img,index=3D0,media=3Ddisk,format=3Draw -machine q35,cxl=3Don=
 -cpu qemu64,mce=3Don -m 8G,maxmem=3D64G,slots=3D8  -virtfs local,path=3D/o=
pt/lib/modules,mount_tag=3Dmodshare,security_model=3Dmapped  -virtfs local,=
path=3D/home/fan,mount_tag=3Dhomeshare,security_model=3Dmapped -device pxb-=
cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 -device cxl-rp,port=3D13,bus=3Dcxl.=
1,id=3Droot_port13,chassis=3D0,slot=3D2 -object memory-backend-file,id=3Dhm=
em0,share=3Don,mem-path=3D/tmp/host//hmem0.raw,size=3D512M -object memory-b=
ackend-file,id=3Dlsa0,share=3Don,mem-path=3D/tmp/host//lsa0.raw,size=3D2M -=
device cxl-type3,bus=3Droot_port13,memdev=3Dhmem0,lsa=3Dlsa0,id=3Dcxl-memde=
v0,sn=3D3840 -device pxb-cxl,bus_nr=3D112,bus=3Dpcie.0,id=3Dcxl.2 -device c=
xl-rp,port=3D14,bus=3Dcxl.2,id=3Droot_port14,chassis=3D0,slot=3D3 -object m=
emory-backend-file,id=3Dhmem1,share=3Don,mem-path=3D/tmp/host//hmem1.raw,si=
ze=3D512M -device cxl-type3,bus=3Droot_port14,volatile-memdev=3Dhmem1,id=3D=
cxl-vmemdev1,sn=3D3841 -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=
=3Dcxl.2,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-granularity=3D8K=20
> >=20
> >=20
> > -----------------
> > # cxl create-region -m -d decoder0.0 -w 1 mem1 -s 512M -t pmem
> > cxl region: create_region: region0: set_interleave_ways failed: Invalid=
 argument
> > cxl region: cmd_create_region: created 0 regions
> > -----------------
> >=20
> > The reason is for the root decoder, iw =3D 2, while for creating the re=
gion as
> > above, number of ways is 1, which fails the check here:
> >=20
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/dr=
ivers/cxl/core/region.c?h=3Dfixes#n491
> >=20
> > -----------------
> > 	if (!is_power_of_2(val / cxld->interleave_ways) ||
> > 	    (val % cxld->interleave_ways)) {
> > 		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> > 		return -EINVAL;
> > 	}
> > -----------------
> > 491		if (!is_power_of_2(val / cxld->interleave_ways) ||
> > (gdb) n
> > 493			dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> > (gdb) p val
> > $8 =3D 1
> > (gdb) p cxld->interleave_ways
> > $9 =3D 2
> >=20
> > So how can we create a region with only one memdev when there are more =
than 1 HBs,
> > but we only want to touch device under one HB?
>=20
> Then you would need a new CFMWS entry to allow that. On hardware
> platforms with multiple host bridges you will see a set like this
> following for a 2 host bridge platform with RAM + PMEM support:
>=20
> CFMWS0: HB0, IW =3D 1, RAM
> CFMWS1: HB1, IW =3D 1, RAM
> CFMWS2: HB0, IW =3D 1, PMEM
> CFMWS3: HB1, IW =3D 1, PMEM
> CFMWS4: HB0 + HB1, IW =3D 2, RAM
> CFMWS5: HB0 + HB1, IW =3D 2, PMEM
>=20
> So, in this case it looks like your CFMWS set ("decoders:root0") only
> includes something like CFMWS5, so you need to update QEMU to produce
> one or more of CFMWS[0-3] windows.

Thanks Dan for the detailed explanation. It is much clearer to me now
how this works.

Fan
>=20
> [..]
> >     "decoders:root0":[
> >       {
> >         "decoder":"decoder0.0",
> >         "resource":79725330432,
> >         "size":4294967296,
> >         "interleave_ways":2,
> >         "interleave_granularity":8192,
> >         "max_available_extent":4294967296,
> >         "pmem_capable":true,
> >         "volatile_capable":true,
> >         "accelmem_capable":true,
> >         "qos_class":0,
> >         "nr_targets":2,
> >         "targets":[
> >           {
> >             "target":"pci0000:70",
> >             "alias":"ACPI0016:00",
> >             "position":1,
> >             "id":112
> >           },
> >           {
> >             "target":"pci0000:0c",
> >             "alias":"ACPI0016:01",
> >             "position":0,
> >             "id":12
> >           }
> >         ]
> >       }
> >     ]
