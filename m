Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA147DA66
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967347; cv=pass; b=QDwiYd6JM4N3AHOXNftpzeW35s1SBvzQX22yhcycNaR4qIWEMuHv5G70cqnuiqoRCEbhP62fBT79C37wvEqKo/EIHf8wB6zqqPHGpVb1S2LYhSvHAsEi4Tb1PuNGthUe7zCSGt982+4TQpmwz2k5r6LQG9pLaNHqbuhoG4md16o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967347; c=relaxed/simple;
	bh=ypKx3eP3NL/zPwhBFoOg655msgv91IZMb9gg1OmP6zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRahrzTm//q92J1ycTytKB4ReD/YBFV0R7FaO3Yn/4O+J3EEy/u/eFMP5hy1ilYPZerPiPn9WvVDrRjdvF+AWQCnZU19rWvgeRmLjH2D3T4n9OrVWku1l12azwH6PppRTE55JHi2t7y0KqNdLhQMEPv8o08ihDziEbzQJdH/oI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3alDEce; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3alDEce"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6afa5b9150eso350367a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 11:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790967344; cv=none;
        d=google.com; s=arc-20260327;
        b=so7Le34jH+nC2mMmlvU9Uyix452tgk7+lrib8ztzcawRZny/hcXHNFjrV6EDJfSTOF
         98yejRa/+1/IhBTbZJ9ngnnDVDtCuSGRC3/b4r2aLEUCFjXenuwLy2p/SoDz64bjMVp3
         kMOJT/hAL3aZGq8KX9FS0DGX1xy5nsjyetnsJH50bjlhOvXLRDZItiMXjBi0S4MmSzPv
         RdciLsnWFU1Qp3dQCBa9HDQqm++78o4647pLhx09pqfyCbppNWMoxRsblXrdC4kyGmfj
         eToL1qTv+lX7tV8u39ifhZPY0MfEyCNsQXyKNW7nZ2qBJ0toSccf7FYBUqKRFginMUEB
         Mtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNkTda6yyFagzwxVvIs1fSSzlLcgdVCdiWc/DPOusfc=;
        fh=mqK4TRENglR/edreSdEmSl0OttroRCbH8Td5TAal5pY=;
        b=bJaNuUGIVaDSUHWMz9XJA+NgOMbmuvvrwebLJjDGHHKYEwqhaJlLmwutVli/I3GnBQ
         8KX0RPrgWimN/AXUvm3e7FatEtWhig53xhQScyxvY64NK+YeGIhc7FUbWpV4P2sFP/gT
         fRcQqOHP7sqIJ3ccVQT4uZY9xcbhT4cgt/9ttXteeFmSYS5TCRioJQ9LlISzhAsTERVL
         ToA5j2nJM8hSL2QwjljacmDFG4JKGxyUCAgKT09CJ9AQaq8W/x1weDQm71a7lIJiAuep
         egHQnlBowT8fazMP+0E8MyrzSMaUh94Ptb40b8Xa/IyEG+zqNW9yAlR/s/7WB/S8EemQ
         2uyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790967344; x=1791572144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LNkTda6yyFagzwxVvIs1fSSzlLcgdVCdiWc/DPOusfc=;
        b=L3alDEceXPsg6p6THy2V7IP8MmNsgqazelgTpsXaGYVPDEkIQKFA5PKH6e06Qoz0gf
         2Eo/mNOj3Bv5yAq0XuIlGKUtukspwukjlJjcxibcGI8PSbzGh79nbdqRhuabIMQMrkmI
         K4O91YLCWV3cdQXCEB7KnsAnzlJbG++KDPtPECrBjoPVH/HXNdUyJEr1djPGLZAhik1V
         cfOTwYamscTTqsEXktLNafadWvWpGiNbKlLQbMj/edKZ8LBvcjWVZGAhBq8/K9o6aolC
         YzdAJOG96+1ZQ3mzspVWdgsJiH8Et3LYbOS7D4Xez7qgfhtCVL11F+8NTtd2P67PHipg
         HVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967344; x=1791572144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNkTda6yyFagzwxVvIs1fSSzlLcgdVCdiWc/DPOusfc=;
        b=r8zdETr4c66K8aXo2yJuc6gjhgotLcjwjOkLnGbgfYXqwfB7xm4J0o6ePHVZlwRnq7
         OEiknipomJhBLCKyE/HyQIVna+43/+2ciLElInyV52vcirMKce++ySlUh6sgwqo1tmcr
         TGauMs0RMFWtd8qy/KVtDHlsm4o1EOo6ZvFS9v/5hO2TWcn6bRgb26W4JsnYbO9RGiza
         tvxKgo72BolNtWL6DUdIZQ8tHGCNVD4km21rU27yvrEd/0rrADtkr3tyZdz7Vh3mr/2k
         A07gwIhcNLkejSomLIx+b/aBAtHKjfp5ekBONWEC67uFG8iQXD3h64cyXCZ6YtWg6k+c
         H94A==
X-Forwarded-Encrypted: i=1; AKwUvBz9/c4fqGSFzTLvpx8sKARuWmArk0zSMM387n95imiZJ+dYUBeHAw4wh3Ekjse0DsttmZrKcsfA2LI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQW314iIIET4buvTl6/h62BDRpMRn8F/cSvVekX/FIN46R2hzJ
	rCR79kN9Ff2OtySEsfg5WSYeol98KUtwqwlVJJkBAPL0g4n+XHJJz5NyQuKm62hpx4o1WmdILl5
	5vG3O/5FN1lpuII/LHIe/XJ9kxoOu2O8DxDXA
X-Gm-Gg: AYBFou1quL7dQJGr9zsP+XsU6eRLpFbPpSLwXuxMjUG/mbscUy5EY7B9uuojkCitqax
	8o+geVRe9iZRKeyXKo5VTbqx6GOdCOealLtiPBnMh3fF6DU61mOBJn9HRr9Jrjc90DgvMLvQMhH
	MhyXG42m52zCKfRuUJipr+1BVCmplBNJnnN7zkVpKRo0V0yCGjwHXCLeCTv/ibTNFASirWspaq3
	oBr0C0LHwAZ6B4MghZ/qpLUvZsEQEuen5AsyPOLE+tgPY6plAl/STmbyeETxTwOSZMURYuBgmAh
	4VNM/RtYA9oLUH4AkJ5oBLYor9X0gBbcymPbwRtYcL+v/SE32V1b90Nz
X-Received: by 2002:a05:6402:50ce:b0:6aa:fc60:60d0 with SMTP id
 4fb4d7f45d1cf-6af9e3183bcmr2645064a12.33.1790967343575; Fri, 02 Oct 2026
 11:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
 <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F> <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>
 <ar_zftIk5caN-5uV@gourry-fedora-PF4VCD3F>
In-Reply-To: <ar_zftIk5caN-5uV@gourry-fedora-PF4VCD3F>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 2 Oct 2026 21:55:32 +0300
X-Gm-Features: AclHuK-OPEiDUxmD9Rz4Dp_NTbAcXn7cTqOJk7bQfyeemvZ--NfgdiNOFNhU0po
Message-ID: <CAAiJnjrjtseaUPo5vyqGZeDAt4ST6eqvaXOCWvdaTUsx2D3v5g@mail.gmail.com>
Subject: Re: Poor memory bandwidth performance between NUMA nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I'm unfamiliar with Valkey, but you may want to ask how contended those
> pages are if they're actually being used during migration time.

> Do you get this same behavior when migrating the same amount of memory
> allocated by a toy program? (i.e. known idle pages)

I don't think that there is any contention.
There is no processing, etc.
This is a completely idle test server.
I just populated 300GB memory by key-value data store.

Even if I use simple stress-ng instead of Valkey,

[root@localhost ~]# numactl --cpunodebind=3D0 --preferred=3D0 stress-ng
--vm 1 --vm-bytes 300G --vm-hang 0 &
[1] 4353
[root@localhost ~]# stress-ng: info:  [4353] defaulting to a 1 day run
per stressor
stress-ng: info:  [4353] dispatching hogs: 1 vm
stress-ng: info:  [4355] vm: using 300GB per stressor instance (total
300GB of 6.43TB available memory)


[root@localhost ~]# COLUMNS=3D500 numastat -p 4356 | cat

Per-node process memory usage (in MBs) for PID 4356 (stress-ng-vm)
                           Node 0          Node 1          Node 2
    Node 3           Total
                  --------------- --------------- ---------------
--------------- ---------------
Huge                         0.00            0.00            0.00
      0.00            0.00
Heap                         0.06            0.00            0.00
      0.00            0.06
Stack                        0.03            0.00            0.00
      0.00            0.03
Private                 307201.14            0.74            0.00
      0.00       307201.88
----------------  --------------- --------------- ---------------
--------------- ---------------
Total                   307201.23            0.74            0.00
      0.00       307201.97
[root@localhost ~]# man migratepages
[root@localhost ~]# migratepages 4356 0 2

I see even slower (System PMM Write) than 1.4 GB/s,

|---------------------------------------||---------------------------------=
------|
|--            System DRAM Read Throughput(MB/s):        842.67
        --|
|--           System DRAM Write Throughput(MB/s):        851.34
        --|
|--             System PMM Read Throughput(MB/s):        785.27
        --|
|--            System PMM Write Throughput(MB/s):        804.57
        --|
|--                 System Read Throughput(MB/s):       1627.94
        --|
|--                System Write Throughput(MB/s):       1655.91
        --|
|--               System Memory Throughput(MB/s):       3283.85
        --|
|---------------------------------------||---------------------------------=
------|


top - 21:49:22 up  4:53,  3 users,  load average: 0.97, 0.78, 0.61
Tasks: 774 total, 2 running, 772 sleep, 0 d-sleep, 0 stopped, 0 zombie
%Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.=
0 st
MiB Mem : 6839822.+total, 6432377.+free, 422358.2 used,    790.2 buff/cache
MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6417463.+avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
   4507 root      20   0    2644   1764   1644 R  99.8   0.0   2:20.63
migratepages
   1592 root      20   0   82184   5056   3932 S   0.3   0.0   0:07.26
irqbalance
   4993 root      20   0       0      0      0 I   0.3   0.0   0:00.02
kworker/50:0-events
   4999 root      20   0   10916   6080   3772 R   0.3   0.0   0:00.03 top
      1 root      20   0   25528  15488  10484 S   0.0   0.0   0:02.35 syst=
emd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.06 kthr=
eadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
pool_workqueue_release
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
kworker/R-rcu_gp
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
kworker/R-sync_wq

Samples: 26K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
21652648047 lost: 0/0 drop: 0/0
Overhead  Shared Object                      Symbol
  21.77%  [kernel]                           [k] copy_mc_fragile
  18.88%  [kernel]                           [k] clear_highpages_kasan_tagg=
ed
  17.81%  [kernel]                           [k] migrate_folio_unmap
   2.67%  [kernel]                           [k] __folio_alloc_noprof
   2.09%  [kernel]                           [k] smp_call_function_many_con=
d
   1.89%  [kernel]                           [k] try_to_migrate_one
   1.74%  [kernel]                           [k] folio_migrate_flags
   1.69%  [kernel]                           [k] page_vma_mapped_walk
   1.14%  [kernel]                           [k] remove_migration_pte
   1.01%  [kernel]                           [k] rmqueue_bulk
   0.88%  [kernel]                           [k] migrate_folio_move
   0.87%  [kernel]                           [k] __mod_memcg_lruvec_state

Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
56222244297
copy_mc_fragile  /proc/kcore [Percent: local period]
   0.00 =E2=94=82      cmpl  $0x8,%edx
        =E2=94=82    =E2=86=93 jb    43
        =E2=94=82      testl $0x7,%esi
   0.03 =E2=94=82    =E2=86=93 je    27
        =E2=94=82      movl  %esi,%ecx
        =E2=94=82      andl  $0x7,%ecx
        =E2=94=82      subl  $0x8,%ecx
        =E2=94=82      negl  %ecx
        =E2=94=82      subl  %ecx,%edx
        =E2=94=8219:   movb  (%rsi),%al
        =E2=94=82      movb  %al,(%rdi)
        =E2=94=82      incq  %rsi
        =E2=94=82      incq  %rdi
        =E2=94=82      decl  %ecx
        =E2=94=82    =E2=86=91 jne   19
        =E2=94=8227:   movl  %edx,%ecx
        =E2=94=82      andl  $0x7,%edx
        =E2=94=82      shrl  $0x3, %ecx
   0.02 =E2=94=82    =E2=86=93 je    43
  58.57 =E2=94=8231:   movq  (%rsi),%r8
  12.21 =E2=94=82      movq  %r8,(%rdi)
   4.22 =E2=94=82      addq  $0x8,%rsi
   8.25 =E2=94=82      addq  $0x8,%rdi
   0.53 =E2=94=82      decl  %ecx
  16.06 =E2=94=82    =E2=86=91 jne   31
        =E2=94=8243:   andl  %edx,%edx
   0.02 =E2=94=82    =E2=86=93 je    57
        =E2=94=82      movl  %edx,%ecx
        =E2=94=8249:   movb  (%rsi),%al
        =E2=94=82      movb  %al,(%rdi)
        =E2=94=82      incq  %rsi
        =E2=94=82      incq  %rdi
        =E2=94=82      decl  %ecx
        =E2=94=82    =E2=86=91 jne   49
   0.02 =E2=94=8257:   xorl  %eax,%eax
   0.06 =E2=94=82    =E2=86=90 retq
        =E2=94=82      int3
        =E2=94=82      int3
        =E2=94=82      int3
        =E2=94=82      int3

Samples: 187K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
84234492777
clear_highpages_kasan_tagged  /proc/kcore [Percent: local period]
Percent =E2=94=82      nop
   0.03 =E2=94=82      subq 0x1a5067c(%rip),%rdi
   0.01 =E2=94=82      movl %esi,%ecx
        =E2=94=82      xorl %eax,%eax
   0.03 =E2=94=82      sarq $0x6, %rdi
        =E2=94=82      shlq $0xc, %rcx
   0.03 =E2=94=82      shlq $0xc, %rdi
   0.03 =E2=94=82      addq 0x1a50675(%rip),%rdi
  99.72 =E2=94=82      rep  stosb   %al, %es:(%rdi)
   0.09 =E2=94=82      nop
   0.06 =E2=94=82    =E2=86=90 retq
        =E2=94=82      int3
        =E2=94=82      int3
        =E2=94=82      int3
        =E2=94=82      int3
        =E2=94=82      nop

Samples: 223K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
88021056491
migrate_folio_unmap  /proc/kcore [Percent: local period]
   0.04 =E2=94=82       movq   %rdi,%rax
        =E2=94=82       movq   %rcx,%rdi
        =E2=94=82       movq   %rbx,0x8(%rsp)
        =E2=94=82       movq   %rcx,%rbx
   0.04 =E2=94=82       movq   %r12,0x18(%rsp)
        =E2=94=82       movq   %rsi,%r12
        =E2=94=82       movq   %rdx,%rsi
        =E2=94=82       movq   %r13,0x20(%rsp)
   0.06 =E2=94=82       movq   %rdx,%r13
        =E2=94=82       movq   %r14,0x28(%rsp)
        =E2=94=82       movl   %r9d,%r14d
        =E2=94=82       movq   %r15,0x30(%rsp)
   0.05 =E2=94=82       movq   %r8,%r15
        =E2=94=82     =E2=86=92 callq  *%rax
   0.05 =E2=94=82       testq  %rax,%rax
        =E2=94=82     =E2=86=93 je     2e3
   0.06 =E2=94=82       movq   %rbp,0x10(%rsp)
   0.04 =E2=94=82       movq   %rax,%rbp
   0.20 =E2=94=82       movq   %rax,(%r15)
   0.07 =E2=94=82       movq   $0x0,0x28(%rax)
  97.01 =E2=94=82       lock
        =E2=94=82       btsq   $0x0,(%rbx)
   0.04 =E2=94=82     =E2=86=93 jb     26b
   0.70 =E2=94=82 67:   movq   (%rbx),%rdx
   0.12 =E2=94=82       testq  $0x2,(%rbx)
   0.04 =E2=94=82     =E2=86=93 je     e2
        =E2=94=82       cmpl   $0x2,%r14d
        =E2=94=82     =E2=86=93 je     d2
        =E2=94=82       movq   0x40(%rsp),%r8
        =E2=94=82       movq   %rbx,%rdi
        =E2=94=82       movl   $0x1,%ecx
        =E2=94=82       xorl   %edx,%edx
        =E2=94=82       xorl   %esi,%esi
        =E2=94=82       movl   $0xfffffff0,%ebx
        =E2=94=82     =E2=86=92 callq  migrate_folio_undo_src
        =E2=94=82       testq  %r12,%r12
        =E2=94=82     =E2=86=93 je     1b0
        =E2=94=82 9d:   movq   %rbp,%rdi
        =E2=94=82       movq   %r13,%rsi
        =E2=94=82     =E2=86=92 callq  *%r12


Anton
