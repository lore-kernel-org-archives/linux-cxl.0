Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EB3AC09
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCsxcNTj"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD995
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 15:38:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-419c16a4209so51957971cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697495879; x=1698100679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7L9aoj9nr5/GszQMO+ElBcIyyvDITzt7cA5WzEqXY4=;
        b=jCsxcNTjhBW5th0R9xH2R/LiNTyw7z1rG8HpF+/bhCqh2gL3ZSCkF2gjva6St59IBg
         4x5VP/7xeyvPukkF59EN21DTeXDvc0+/UW+a4x5fWIRw7r3JmRhT2oxWuiTC8kLEGpwm
         Y7Ydn0w2A/TJcheikHpf3yVJf4XXXLYUnrfXTqVgniHHnBvUEEgnz09FmF8QdDpEqPBQ
         crY7iwsGCp30wdLN7ql4xLLwRprtdkLC0sEF1s4zDaSSPJCmawc6zluQ0Nfd3F7nSe71
         XzSWLlSfhemyzoNJx8MiJibXT8q6lpLkGiohS3w1W7ENh7oBNxBG8Lh+HFLiqWUlyLVC
         9NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495879; x=1698100679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7L9aoj9nr5/GszQMO+ElBcIyyvDITzt7cA5WzEqXY4=;
        b=vlO6mKGwIPS3EE3+RJUNkUjhL0lQEqBDxjX47ipyUUtFZh0MlkQJJnBe6jKcsY06y2
         yfnB4OnsSp8ju7a3KWw3WojaXl1enuofDkEjVvRpFFlO2LuZ5znWB/njTQ9P53dw/56h
         h5ZSGPGiOssH1ZRST/4TbcVZne5l14RxxJbhxcL+1JfyG9vAN0S8h07z1Z5BtB/5zUdw
         LGbIEIZKOrRR5LnN33jarM5C+aOLj1y1M00ygVn/XoOIyJ0WTWEv4gSHFNt1NYbxCO5N
         QjhKRhgrKimmmTMgxdlhTQt3+85V9Lf15daDNyjBO+1zMu8uOdPRwVXOBsVDvlGkwb/U
         h9Lw==
X-Gm-Message-State: AOJu0YzuLWhH3Dfj7x0tSAoF0sfx85ocVFyUAstslqpB34e6RQ5AbNEU
	xPkIYi72vQFpTxwKyteUmk8W4PccVfZfA10A1WI2540uLfFbMu2X
X-Google-Smtp-Source: AGHT+IECTiK/yS4oysysakbTdS4lYOxqHAUUCZtkAUH/8b78CpDGR1OKg+29JGHlqabx4X98WG7nFDDDbUUH9wm7hAo=
X-Received: by 2002:a05:6214:20af:b0:66d:1e99:6111 with SMTP id
 15-20020a05621420af00b0066d1e996111mr233164qvd.32.1697495879328; Mon, 16 Oct
 2023 15:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKJOkCoxLG01Dt7xMjOPWRqhyLPuaNGRUaDn-sgAFfhERtAYJA@mail.gmail.com>
 <20231016105538.00000de5@Huawei.com>
In-Reply-To: <20231016105538.00000de5@Huawei.com>
From: lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date: Mon, 16 Oct 2023 15:37:49 -0700
Message-ID: <CAKJOkCpfDPh-pbzVZ5+KnUu8C9QNB1b1VKu8bk2f+dbqUZh7PQ@mail.gmail.com>
Subject: Re: Performance Issue with CXL-emulation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel-request@nongnu.org, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jonathan,

Thanks for your quick and detailed response. I'll explore these
options further and asses if I get any performance uptick.

Thanks & Regards,
Lokesh


On Mon, Oct 16, 2023 at 2:56=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 15 Oct 2023 10:39:46 -0700
> lokesh jaliminche <lokesh.jaliminche@gmail.com> wrote:
>
> > Hi Everyone,
> >
> > I am facing performance issues while copying data to the CXL device
> > (Emulated with QEMU). I get approximately 500KB/Sec. Any suggestion on =
how
> > to improve this?
>
> Hi Lokesh,
>
> The target so far of QEMU emulation of CXL devices has been on functional=
ity.
> I'm in favour of work to improve on that, but it isn't likely to be my fo=
cus
> - can offer some pointers on where to look though!
>
> The fundamental problem (probably) is address decoding in CXL for interle=
aving
> is at a sub page granularity. That means we can't use page table to perfo=
rm the address
> look ups in hardware. Note this also has the side effect that kvm won't w=
ork if
> there is any chance that you will run instructions out of the CXL memory =
- it's
> fine if you are interested in data only (DAX etc). (I've had a note in my=
 todo list
> to add a warning message about the KVM limitations for a while).
>
> There have been a few discussions (mostly when we were debugging some TCG=
 issues
> and considering KVM support) about how we 'might' be able to improve this=
.  That focused
> on a general 'fix', but there may be some lower hanging fruit.
>
> The options I think might work are:
>
> 1) Special case configurations where there is no interleave going on.
>    I'm not entirely sure how this would fit together and it won't deal wi=
th the
>    more interesting cases - if it does work I'd want it to be minimally i=
nvasive because
>    those complex cases are the main focus of testing etc.  There is an ex=
tension of this
>    where we handle interleave, but only if it is 4k or above (on appropri=
ately configured
>    host).
>
> 2) Add caching layer to the CXL fixed memory windows.  That would hold co=
pies of a
>    number of pages that have been accessed in a software cache and setup =
the mappings for
>    the hardware page table walkers to find them. If the page isn't cached=
 we'd trigger
>    a pagefault and have to bring it into the cache. If the configuration =
of the interleave
>    is touched, all caches would need to be written back etc. This would n=
eed to be optional
>    because I don't want to have to add cache coherency protocols etc when=
 we add shared
>    memory support (fun though it would be ;)
>
> 3) Might be worth looking at the critical paths for lookups in your confi=
guration.
>    Maybe we can optimize the address decoders (basically a software TLB f=
or HPA to DPA).
>    I've not looked at the performance of those paths.  For your example t=
he lookup is
>    * CFMWS - nothing to do
>    * Host bridge - nothing to do beyond a sanity check on range I think.
>    * Nothing to to do.
>    * Type 3 device - basic range match.
>    So I'm not sure it is worth while - but you could do a really simple t=
est by detecting
>    no interleave is going on and caching the offset needed to go HPA to D=
PA + a device reference
>    for the first time cxl_cfmws_find_device() is called.
>    https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-host.c#L129
>
>
>    Then just match on hwaddr on another call of cxl_cmws_find_device() an=
d return the device
>    directly.  Maybe also shortcut lookups in cxl_type3_hpa_to_as_and_dpa(=
) which does the endpoint
>    decoding part. A quick hack would let you know if it was worth looking=
 at something more general.
>
>    Gut feeling is this last approach might get you some perf uptick but n=
ot going to solve
>    the fundamental problem that in general we can't do the translation in=
 hardware (unlike most
>    other memory accesses in QEMU).
>
>    Not I believe all writes to file backed memory will go all the way to =
the file. So you might want
>    to try backing it with RAM but I as with the above, that's not going t=
o address the fundamental
>    problem.
>
>
> Jonathan
>
>
>
>
> >
> > Steps to reproduce :
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. QEMU Command:
> > sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> > -hda ./images/ubuntu-22.04-server-cloudimg-amd64.img \
> > -hdb ./images/user-data.img \
> > -M q35,cxl=3Don,accel=3Dkvm,nvdimm=3Don \
> > -smp 16 \
> > -m 16G,maxmem=3D32G,slots=3D8 \
> > -object
> > memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/mnt/qemu_files=
/cxltest.raw,size=3D256M
> > \
> > -object
> > memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/mnt/qemu_files=
/lsa.raw,size=3D256M
> > \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > -device
> > cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1=
,id=3Dcxl-pmem0
> > \
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > -nographic \
> >
> > 2. Configure device with fsdax mode
> > ubuntu@ubuntu:~$ cxl list
> > [
> >   {
> >     "memdevs":[
> >       {
> >         "memdev":"mem0",
> >         "pmem_size":268435456,
> >         "serial":0,
> >         "host":"0000:0d:00.0"
> >       }
> >     ]
> >   },
> >   {
> >     "regions":[
> >       {
> >         "region":"region0",
> >         "resource":45365592064,
> >         "size":268435456,
> >         "type":"pmem",
> >         "interleave_ways":1,
> >         "interleave_granularity":1024,
> >         "decode_state":"commit"
> >       }
> >     ]
> >   }
> > ]
> >
> > 3. Format the device with ext4 file system in dax mode
> >
> > 4. Write data to mounted device with dd
> >
> > ubuntu@ubuntu:~$ time sudo dd if=3D/dev/urandom
> > of=3D/home/ubuntu/mnt/pmem0/test bs=3D1M count=3D128
> > 128+0 records in
> > 128+0 records out
> > 134217728 bytes (134 MB, 128 MiB) copied, 244.802 s, 548 kB/s
> >
> > real    4m4.850s
> > user    0m0.014s
> > sys     0m0.013s
> >
> >
> > Thanks & Regards,
> > Lokesh
> >
>
