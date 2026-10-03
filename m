Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447E384CDD
	for <linux-cxl@vger.kernel.org>; Sat,  3 Oct 2026 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003207; cv=pass; b=AeNYu6/aMeCesE54rZkT3A+zJr56TSYU61Pc/DLSFewXHtBnZU9ZgU5sgOj6yjAHoniDDui8O3A6n08UQh6AYLscLwIORwqxFu8tGclymb0ZdJlPwymYS7qGKCbGy6dUURiUSwG22beC/zSR6hOR5kb1L1ePiZnn/pAK3990dcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003207; c=relaxed/simple;
	bh=lCsP2nEW00ZpTqXUZK6YHPbWF1mQe1/oJzMeE5lDv+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu7dnSQGKco6Oi0ZvoJNWnb+w8ns/HpJNUgZe6oZK/Nvf9Rc0CAvP6IMD8+TJd/12YR1HhtRkuqJX9p6R0tPtbkS1aEPuH4rL4SfvwJIpwWwMM0kBbSROCsUHE9x69FCAaPmMkMR0ZZAxyEjtjjdmUMiorgfs5CtTwXC8JBOaok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHD79S6y; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHD79S6y"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso264894a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 21:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791003204; cv=none;
        d=google.com; s=arc-20260327;
        b=H0tDeW2L0YW0sfe/T1m2E63F+vzaTzIrb2YWDZ0JnrBQBPdL/06e/X5cQHhjOk9cMx
         nCNH531PywgTuB0D/Den5sEUZ5T7YGtnKSylZCwyFRkLZhfk6Cmr7NQ2Ap9b5GqSqEJt
         6KWaJ8zAQRIan860aKrLSnkL0VcJnBRXhd2PsTisk1HXFzmvpPlm+o4ererNv+GBwEtX
         LdD1n0jPHbHU4I/elNwKmOx0JgQpJc00FgDibnXMC4PV5EnDhVG+3jnr1yNgNE7jFNyV
         Sy3NXAreTtFti6kxm074o00FoEQ7ipFV9zQq5NWdM6+ZsFh7Q9/I8F9a1j6S/AtDuzEk
         JCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eGcgHIqjPJ52+DRcO1cSQXGa066YESGqqYPcF0r2hns=;
        fh=XiRtcYTnkiVWk7BfksQHt2sm0s5dL0/8uiiKWkEgnpc=;
        b=B/i1//wa2HdwV+9x3Z8LH8b7BUejVZygUMmixxOhe7YJBC2kTx1iRLjykLvOzAw+DN
         xLyJ4+Iics4einNkcpKRpGhrbHqoO630lLTMP98n9wkncNvga8ZXmDCE6ASo25PaMp5T
         TxzGlf7F4QwJpTjbJSkxN+60DhEfg5BxiC95RqOLaG0OL8Pmm+q2Ti2JWXzNe3sQ4o4B
         TwlebvFZLikkbMZSDe/fXH6V8DhOVV6Ti7pfHPVMpm5+v62G0uB0dJ4kQZoad5PwoZZQ
         RE0GhALMsqCFKMWkRdTTvE8vUarol5bUKrp9hzOajGAvMihaDrn8Zp6/xFraCTKPYoSx
         eM3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003204; x=1791608004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGcgHIqjPJ52+DRcO1cSQXGa066YESGqqYPcF0r2hns=;
        b=IHD79S6yJFgulGfK0op/3BqaRHHqdAEjLV8PS240Xsv7QkP6DkVY+ldjQ2abwkCPnJ
         jl8j1IhE9r2OXJHdsngB0p58LNtFSoGe944hFB3vUNYVGXvlVfJzocsv2WWWCTzlqf8D
         QwJKMV59iccQtnLrB3d/+C1C0M51jLwMPOgmK/FnepduPhiBoN2AKCj0MtiwSJZpoInO
         XKVpQpYd1Rh9kd2zVYXIbNoUEBOmG8Y0bvqdt8cqjE8V4VmZBNMCL20298KYUp61Do7g
         vmIX+BZs7UZ3wYv2CenEKTTsaFBo53lJxeciEZvab5mTZPIPrh1ScO4qa5ib7g6OH8uY
         4PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003204; x=1791608004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGcgHIqjPJ52+DRcO1cSQXGa066YESGqqYPcF0r2hns=;
        b=Z09KhGh/upLJan/RRf5ttqgfXjMA1hWEbEAwOaqtKFjh51+/pZBs5BswaAjgLFb0hS
         A2kMEICPI4o50GyHQ34Tw/Olokewqr6pIZxzMvshHXQqpPRV9DmEoH9UTTYE1+h1hzKt
         dq7lPDaw0LZ8aCt2JoU80HYsgKODMSoOB8vd1KAy+BO0Ou4cS2bhSmcn6jFJUiJn64LE
         Dlv0DS+/HuNhE+lq4mZWo+6NqY2UkC48UL8DjPH+ABerEp+Eub3xJ/+5EBnBNlUn+pp6
         EtixqOdshRKV7UBvqhIw9+9jF7v4UOvs0s1hCf5wz18VD/ngO3S8fvVAMEQshUA6Fk24
         N2HA==
X-Forwarded-Encrypted: i=1; AKwUvByK5KW8RKd9hrx0GZ0WQ7ZUCP9ko/+VPoz7hYmLeSv2hqYpHR/+ehSmetTPxtwk+hffqOl8h7q8s3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfQgWML3oA4Au16JuUXNN10K0LA9/vlW7rEUZDKXipkDYTpVDj
	jFBNOH0b8aQ/OwJbeV7PNYBg26oCx953/yRs0cMSHriz19dheDwaSglWl3U2Vi75qDb0JHNzCYb
	Dn/AB2VytC5vxNDeD4ntdAWOQngxTDys=
X-Gm-Gg: AYBFou3Q0zWxFjAfscnPOv3dDj4jp/afxB2wK4edK1zSHBijcsZ0RQ/1jJN/w+vk6JA
	vQOQvjoHNPXmvyg8tMCreXhpLV5BdvAXVbZ98/p08ty0nxNvl0lR18y0rTQYxS+PDae29L1r/xt
	eRhEW+xRtsBWDl860PpUwEz8UZwdUb8rrpm/4JUQAsx6+toDUXKhzm88pOqULSREdWBZOOzZKGg
	tkLmMRPn1Cogr339Ac7gYFqlVc3FEBQqeRiapI5BHbBMSl+8edySD4Il9l+VkFpZ1U09+d8PRql
	cTDkCAXWBEXdXtgnhjy6qShF3gVs9A6EsKm7n/QfxGMwuj2vOCNCKXZgzd9INiEFB/I=
X-Received: by 2002:a05:6402:4028:b0:6ac:26f0:15a1 with SMTP id
 4fb4d7f45d1cf-6af9e361d2bmr3727394a12.36.1791003203172; Fri, 02 Oct 2026
 21:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
 <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F> <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>
 <ar_zftIk5caN-5uV@gourry-fedora-PF4VCD3F> <CAAiJnjrjtseaUPo5vyqGZeDAt4ST6eqvaXOCWvdaTUsx2D3v5g@mail.gmail.com>
 <asAjUfNg_80sA6Yn@pedro-suse.tail5790ac.ts.net> <CAAiJnjqSMPCzO2wYg1YsUK9Nz_8Wd0R+XUxpN-YBa=3DpEMpTQ@mail.gmail.com>
In-Reply-To: <CAAiJnjqSMPCzO2wYg1YsUK9Nz_8Wd0R+XUxpN-YBa=3DpEMpTQ@mail.gmail.com>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sat, 3 Oct 2026 07:53:11 +0300
X-Gm-Features: AclHuK-csu_GJDwAIDAUw5RoP8HKTLZELHpTsEtC-oi_HHr3SQ-J_ww1UKxtXM0
Message-ID: <CAAiJnjoXsz_Oit1MCgf_m_HDard=cbPkLa40eKYwHfEsn=LoKw@mail.gmail.com>
Subject: Re: Poor memory bandwidth performance between NUMA nodes
To: pfalcato@suse.de
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have also played with PMEM options at BIOS/UEFI, but always can't
exceed 1.4 GB/s with the same stack,

|---------------------------------------||---------------------------------=
------|
|--            System DRAM Read Throughput(MB/s):        760.92
        --|
|--           System DRAM Write Throughput(MB/s):        749.90
        --|
|--             System PMM Read Throughput(MB/s):        698.30
        --|
|--            System PMM Write Throughput(MB/s):       1397.39
        --|
|--                 System Read Throughput(MB/s):       1459.21
        --|
|--                System Write Throughput(MB/s):       2147.29
        --|
|--               System Memory Throughput(MB/s):       3606.50
        --|
|---------------------------------------||---------------------------------=
------|

Anton

=D1=81=D0=B1, 3 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 07:11, Anto=
n Gavriliuk <antosha20xx@gmail.com>:
>
> > ...are the struct pages on the pmem node itself?
>
> It was ("map":"dev")
>
> I re-created with ("map":"mem"),
>
> [root@localhost ~]# ndctl list
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"devdax",
>     "map":"mem",
>     "size":3234108276736,
>     "uuid":"3a3f75b9-0f03-4ed0-8175-4b4047d16615",
>     "chardev":"dax1.0",
>     "align":2097152
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"devdax",
>     "map":"mem",
>     "size":3234108276736,
>     "uuid":"d67528f5-0f41-4797-bff7-3b175d1cbc05",
>     "chardev":"dax0.0",
>     "align":2097152
>   }
> ]
> [root@localhost ~]# numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> 22 23 24 25 26 27
> node 0 size: 386590 MB
> node 0 free: 336076 MB
> node 1 cpus: 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
> 47 48 49 50 51 52 53 54 55
> node 1 size: 387055 MB
> node 1 free: 337345 MB
> node 2 cpus:
> node 2 size: 3082240 MB
> node 2 free: 3082240 MB
> node 3 cpus:
> node 3 size: 3082240 MB
> node 3 free: 3082240 MB
> node distances:
> node     0    1    2    3
>    0:   10   20   25   35
>    1:   20   10   35   25
>    2:   25   35   10   20
>    3:   35   25   20   10
> [root@localhost ~]# /home/anton/Linux/mlc
> Intel(R) Memory Latency Checker - v3.13
> Measuring idle latencies for sequential access (in ns)...
>                 Numa node
> Numa node            0       1       2       3
>        0          82.4   147.0   173.8   237.5
>        1         146.9    82.7   238.8   172.3
>
> And repeated test with stress-ng,
>
> [root@localhost ~]# numactl --cpunodebind=3D0 --preferred=3D0 stress-ng
> --vm 1 --vm-bytes 300G --vm-hang 0 &
> [1] 10761
> [root@localhost ~]# stress-ng: info:  [10761] defaulting to a 1 day
> run per stressor
> stress-ng: info:  [10761] dispatching hogs: 1 vm
> stress-ng: info:  [10763] vm: using 300GB per stressor instance (total
> 300GB of 6.52TB available memory)
>
>
> [root@localhost ~]# COLUMNS=3D500 numastat -p 10764 | cat
>
> Per-node process memory usage (in MBs) for PID 10764 (stress-ng-vm)
>                            Node 0          Node 1          Node 2
>     Node 3           Total
>                   --------------- --------------- ---------------
> --------------- ---------------
> Huge                         0.00            0.00            0.00
>       0.00            0.00
> Heap                         0.06            0.00            0.00
>       0.00            0.06
> Stack                        0.03            0.00            0.00
>       0.00            0.03
> Private                 307200.75            0.95            0.00
>       0.00       307201.70
> ----------------  --------------- --------------- ---------------
> --------------- ---------------
> Total                   307200.84            0.95            0.00
>       0.00       307201.79
> [root@localhost ~]# migratepages 10764 0 2
>
>
> |---------------------------------------||-------------------------------=
--------|
> |--            System DRAM Read Throughput(MB/s):        844.34
>         --|
> |--           System DRAM Write Throughput(MB/s):        840.21
>         --|
> |--             System PMM Read Throughput(MB/s):        783.93
>         --|
> |--            System PMM Write Throughput(MB/s):        801.99
>         --|
> |--                 System Read Throughput(MB/s):       1628.27
>         --|
> |--                System Write Throughput(MB/s):       1642.20
>         --|
> |--               System Memory Throughput(MB/s):       3270.47
>         --|
> |---------------------------------------||-------------------------------=
--------|
>
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ CO=
MMAND
>   11275 root      20   0    2644   1764   1644 R  99.5   0.0   1:46.90
> migratepages
>   11355 root      20   0   10916   6200   3896 R   0.3   0.0   0:00.03 to=
p
>       1 root      20   0   26012  15728  10484 S   0.0   0.0   0:02.57 sy=
stemd
>       2 root      20   0       0      0      0 S   0.0   0.0   0:00.13 kt=
hreadd
>       3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
> pool_workqueue_release
>       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-rcu_gp
>       5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-sync_wq
>       6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-kvfree_rcu_reclaim
>       7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-slub_flushwq
>       8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-netns
>      10 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/0:0H-events_highpri
>
> Samples: 125K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 54514328868 lost: 0/0 drop: 0/0
> Overhead  Shared Object                      Symbol
>   45.48%  [kernel]                           [k] migrate_folio_unmap
>   18.24%  [kernel]                           [k] clear_highpages_kasan_ta=
gged
>   15.00%  [kernel]                           [k] copy_mc_fragile
>    1.83%  [kernel]                           [k] smp_call_function_many_c=
ond
>    1.18%  [kernel]                           [k] page_vma_mapped_walk
>    1.07%  [kernel]                           [k] try_to_migrate_one
>    0.99%  [kernel]                           [k] folio_migrate_flags
>    0.76%  [kernel]                           [k] rmqueue_bulk
>    0.72%  [kernel]                           [k] remove_migration_pte
>    0.53%  [kernel]                           [k] __mod_memcg_lruvec_state
>    0.53%  [kernel]                           [k] migrate_folio_move
>    0.51%  [kernel]                           [k] __free_one_page
>    0.50%  [kernel]                           [k] lru_gen_add_folio
>    0.49%  [kernel]                           [k] rmap_walk_anon
>    0.49%  [kernel]                           [k] folio_batch_move_lru
>    0.46%  [kernel]                           [k]
> __list_del_entry_valid_or_report
>    0.46%  [kernel]                           [k] migrate_pages_batch
>    0.45%  [kernel]                           [k] folio_add_anon_rmap_ptes
>    0.32%  [kernel]                           [k] mod_node_page_state
>    0.32%  [kernel]                           [k] up_read
>    0.31%  [kernel]                           [k] lru_add
>    0.30%  [kernel]                           [k] __rcu_read_unlock
>
> Samples: 175K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 66480019193
> migrate_folio_unmap  /proc/kcore [Percent: local period]
>    0.01 =E2=94=82       movq   %rdi,%rax
>         =E2=94=82       movq   %rcx,%rdi
>         =E2=94=82       movq   %rbx,0x8(%rsp)
>         =E2=94=82       movq   %rcx,%rbx
>    0.01 =E2=94=82       movq   %r12,0x18(%rsp)
>         =E2=94=82       movq   %rsi,%r12
>         =E2=94=82       movq   %rdx,%rsi
>         =E2=94=82       movq   %r13,0x20(%rsp)
>    0.01 =E2=94=82       movq   %rdx,%r13
>         =E2=94=82       movq   %r14,0x28(%rsp)
>         =E2=94=82       movl   %r9d,%r14d
>         =E2=94=82       movq   %r15,0x30(%rsp)
>    0.01 =E2=94=82       movq   %r8,%r15
>         =E2=94=82     =E2=86=92 callq  *%rax
>    0.21 =E2=94=82       testq  %rax,%rax
>         =E2=94=82     =E2=86=93 je     2e3
>    0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
>    0.01 =E2=94=82       movq   %rax,%rbp
>    0.07 =E2=94=82       movq   %rax,(%r15)
>    0.00 =E2=94=82       movq   $0x0,0x28(%rax)
>   99.10 =E2=94=82       lock
>         =E2=94=82       btsq   $0x0,(%rbx)
>    0.02 =E2=94=82     =E2=86=93 jb     26b
>    0.16 =E2=94=82 67:   movq   (%rbx),%rdx
>    0.01 =E2=94=82       testq  $0x2,(%rbx)
>    0.01 =E2=94=82     =E2=86=93 je     e2
>         =E2=94=82       cmpl   $0x2,%r14d
>         =E2=94=82     =E2=86=93 je     d2
>         =E2=94=82       movq   0x40(%rsp),%r8
>         =E2=94=82       movq   %rbx,%rdi
>         =E2=94=82       movl   $0x1,%ecx
>         =E2=94=82       xorl   %edx,%edx
>         =E2=94=82       xorl   %esi,%esi
>         =E2=94=82       movl   $0xfffffff0,%ebx
>         =E2=94=82     =E2=86=92 callq  migrate_folio_undo_src
>         =E2=94=82       testq  %r12,%r12
>         =E2=94=82     =E2=86=93 je     1b0
>         =E2=94=82 9d:   movq   %rbp,%rdi
>         =E2=94=82       movq   %r13,%rsi
>         =E2=94=82     =E2=86=92 callq  *%r12
>
>
> [root@localhost ~]# COLUMNS=3D500 numastat -p 10764 | cat
>
> Per-node process memory usage (in MBs) for PID 10764 (stress-ng-vm)
>                            Node 0          Node 1          Node 2
>     Node 3           Total
>                   --------------- --------------- ---------------
> --------------- ---------------
> Huge                         0.00            0.00            0.00
>       0.00            0.00
> Heap                         0.00            0.00            0.06
>       0.00            0.06
> Stack                        0.00            0.00            0.03
>       0.00            0.03
> Private                      0.00            1.02       307200.75
>       0.00       307201.77
> ----------------  --------------- --------------- ---------------
> --------------- ---------------
> Total                        0.00            1.02       307200.84
>       0.00       307201.86
> [root@localhost ~]#
>
> Anton
>
> =D1=81=D0=B1, 3 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 00:34, Pe=
dro Falcato <pfalcato@suse.de>:
> >
> > On Fri, Oct 02, 2026 at 09:55:32PM +0300, Anton Gavriliuk wrote:
> > > > I'm unfamiliar with Valkey, but you may want to ask how contended t=
hose
> > > > pages are if they're actually being used during migration time.
> > >
> > > > Do you get this same behavior when migrating the same amount of mem=
ory
> > > > allocated by a toy program? (i.e. known idle pages)
> > >
> > > I don't think that there is any contention.
> > > There is no processing, etc.
> > > This is a completely idle test server.
> > > I just populated 300GB memory by key-value data store.
> > >
> > > Even if I use simple stress-ng instead of Valkey,
> > >
> > > [root@localhost ~]# numactl --cpunodebind=3D0 --preferred=3D0 stress-=
ng
> > > --vm 1 --vm-bytes 300G --vm-hang 0 &
> > > [1] 4353
> > > [root@localhost ~]# stress-ng: info:  [4353] defaulting to a 1 day ru=
n
> > > per stressor
> > > stress-ng: info:  [4353] dispatching hogs: 1 vm
> > > stress-ng: info:  [4355] vm: using 300GB per stressor instance (total
> > > 300GB of 6.43TB available memory)
> > >
> > >
> > > [root@localhost ~]# COLUMNS=3D500 numastat -p 4356 | cat
> > >
> > > Per-node process memory usage (in MBs) for PID 4356 (stress-ng-vm)
> > >                            Node 0          Node 1          Node 2
> > >     Node 3           Total
> > >                   --------------- --------------- ---------------
> > > --------------- ---------------
> > > Huge                         0.00            0.00            0.00
> > >       0.00            0.00
> > > Heap                         0.06            0.00            0.00
> > >       0.00            0.06
> > > Stack                        0.03            0.00            0.00
> > >       0.00            0.03
> > > Private                 307201.14            0.74            0.00
> > >       0.00       307201.88
> > > ----------------  --------------- --------------- ---------------
> > > --------------- ---------------
> > > Total                   307201.23            0.74            0.00
> > >       0.00       307201.97
> > > [root@localhost ~]# man migratepages
> > > [root@localhost ~]# migratepages 4356 0 2
> > >
> > > I see even slower (System PMM Write) than 1.4 GB/s,
> > >
> > > |---------------------------------------||---------------------------=
------------|
> > > |--            System DRAM Read Throughput(MB/s):        842.67
> > >         --|
> > > |--           System DRAM Write Throughput(MB/s):        851.34
> > >         --|
> > > |--             System PMM Read Throughput(MB/s):        785.27
> > >         --|
> > > |--            System PMM Write Throughput(MB/s):        804.57
> > >         --|
> > > |--                 System Read Throughput(MB/s):       1627.94
> > >         --|
> > > |--                System Write Throughput(MB/s):       1655.91
> > >         --|
> > > |--               System Memory Throughput(MB/s):       3283.85
> > >         --|
> > > |---------------------------------------||---------------------------=
------------|
> > >
> > >
> > > top - 21:49:22 up  4:53,  3 users,  load average: 0.97, 0.78, 0.61
> > > Tasks: 774 total, 2 running, 772 sleep, 0 d-sleep, 0 stopped, 0 zombi=
e
> > > %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 s=
i,  0.0 st
> > > MiB Mem : 6839822.+total, 6432377.+free, 422358.2 used,    790.2 buff=
/cache
> > > MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6417463.+avai=
l Mem
> > >
> > >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME=
+ COMMAND
> > >    4507 root      20   0    2644   1764   1644 R  99.8   0.0   2:20.6=
3
> > > migratepages
> > >    1592 root      20   0   82184   5056   3932 S   0.3   0.0   0:07.2=
6
> > > irqbalance
> > >    4993 root      20   0       0      0      0 I   0.3   0.0   0:00.0=
2
> > > kworker/50:0-events
> > >    4999 root      20   0   10916   6080   3772 R   0.3   0.0   0:00.0=
3 top
> > >       1 root      20   0   25528  15488  10484 S   0.0   0.0   0:02.3=
5 systemd
> > >       2 root      20   0       0      0      0 S   0.0   0.0   0:00.0=
6 kthreadd
> > >       3 root      20   0       0      0      0 S   0.0   0.0   0:00.0=
0
> > > pool_workqueue_release
> > >       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.0=
0
> > > kworker/R-rcu_gp
> > >       5 root       0 -20       0      0      0 I   0.0   0.0   0:00.0=
0
> > > kworker/R-sync_wq
> > >
> > > Samples: 26K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> > > 21652648047 lost: 0/0 drop: 0/0
> > > Overhead  Shared Object                      Symbol
> > >   21.77%  [kernel]                           [k] copy_mc_fragile
> > >   18.88%  [kernel]                           [k] clear_highpages_kasa=
n_tagged
> > >   17.81%  [kernel]                           [k] migrate_folio_unmap
> > >    2.67%  [kernel]                           [k] __folio_alloc_noprof
> > >    2.09%  [kernel]                           [k] smp_call_function_ma=
ny_cond
> > >    1.89%  [kernel]                           [k] try_to_migrate_one
> > >    1.74%  [kernel]                           [k] folio_migrate_flags
> > >    1.69%  [kernel]                           [k] page_vma_mapped_walk
> > >    1.14%  [kernel]                           [k] remove_migration_pte
> > >    1.01%  [kernel]                           [k] rmqueue_bulk
> > >    0.88%  [kernel]                           [k] migrate_folio_move
> > >    0.87%  [kernel]                           [k] __mod_memcg_lruvec_s=
tate
> > >
> > > Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.)=
:
> > > 56222244297
> > > copy_mc_fragile  /proc/kcore [Percent: local period]
> > >    0.00 =E2=94=82      cmpl  $0x8,%edx
> > >         =E2=94=82    =E2=86=93 jb    43
> > >         =E2=94=82      testl $0x7,%esi
> > >    0.03 =E2=94=82    =E2=86=93 je    27
> > >         =E2=94=82      movl  %esi,%ecx
> > >         =E2=94=82      andl  $0x7,%ecx
> > >         =E2=94=82      subl  $0x8,%ecx
> > >         =E2=94=82      negl  %ecx
> > >         =E2=94=82      subl  %ecx,%edx
> > >         =E2=94=8219:   movb  (%rsi),%al
> > >         =E2=94=82      movb  %al,(%rdi)
> > >         =E2=94=82      incq  %rsi
> > >         =E2=94=82      incq  %rdi
> > >         =E2=94=82      decl  %ecx
> > >         =E2=94=82    =E2=86=91 jne   19
> > >         =E2=94=8227:   movl  %edx,%ecx
> > >         =E2=94=82      andl  $0x7,%edx
> > >         =E2=94=82      shrl  $0x3, %ecx
> > >    0.02 =E2=94=82    =E2=86=93 je    43
> > >   58.57 =E2=94=8231:   movq  (%rsi),%r8
> > >   12.21 =E2=94=82      movq  %r8,(%rdi)
> > >    4.22 =E2=94=82      addq  $0x8,%rsi
> > >    8.25 =E2=94=82      addq  $0x8,%rdi
> > >    0.53 =E2=94=82      decl  %ecx
> > >   16.06 =E2=94=82    =E2=86=91 jne   31
> > >         =E2=94=8243:   andl  %edx,%edx
> > >    0.02 =E2=94=82    =E2=86=93 je    57
> > >         =E2=94=82      movl  %edx,%ecx
> > >         =E2=94=8249:   movb  (%rsi),%al
> > >         =E2=94=82      movb  %al,(%rdi)
> > >         =E2=94=82      incq  %rsi
> > >         =E2=94=82      incq  %rdi
> > >         =E2=94=82      decl  %ecx
> > >         =E2=94=82    =E2=86=91 jne   49
> > >    0.02 =E2=94=8257:   xorl  %eax,%eax
> > >    0.06 =E2=94=82    =E2=86=90 retq
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >
> > > Samples: 187K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.)=
:
> > > 84234492777
> > > clear_highpages_kasan_tagged  /proc/kcore [Percent: local period]
> > > Percent =E2=94=82      nop
> > >    0.03 =E2=94=82      subq 0x1a5067c(%rip),%rdi
> > >    0.01 =E2=94=82      movl %esi,%ecx
> > >         =E2=94=82      xorl %eax,%eax
> > >    0.03 =E2=94=82      sarq $0x6, %rdi
> > >         =E2=94=82      shlq $0xc, %rcx
> > >    0.03 =E2=94=82      shlq $0xc, %rdi
> > >    0.03 =E2=94=82      addq 0x1a50675(%rip),%rdi
> > >   99.72 =E2=94=82      rep  stosb   %al, %es:(%rdi)
> > >    0.09 =E2=94=82      nop
> > >    0.06 =E2=94=82    =E2=86=90 retq
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >         =E2=94=82      int3
> > >         =E2=94=82      nop
> > >
> > > Samples: 223K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.)=
:
> > > 88021056491
> > > migrate_folio_unmap  /proc/kcore [Percent: local period]
> > >    0.04 =E2=94=82       movq   %rdi,%rax
> > >         =E2=94=82       movq   %rcx,%rdi
> > >         =E2=94=82       movq   %rbx,0x8(%rsp)
> > >         =E2=94=82       movq   %rcx,%rbx
> > >    0.04 =E2=94=82       movq   %r12,0x18(%rsp)
> > >         =E2=94=82       movq   %rsi,%r12
> > >         =E2=94=82       movq   %rdx,%rsi
> > >         =E2=94=82       movq   %r13,0x20(%rsp)
> > >    0.06 =E2=94=82       movq   %rdx,%r13
> > >         =E2=94=82       movq   %r14,0x28(%rsp)
> > >         =E2=94=82       movl   %r9d,%r14d
> > >         =E2=94=82       movq   %r15,0x30(%rsp)
> > >    0.05 =E2=94=82       movq   %r8,%r15
> > >         =E2=94=82     =E2=86=92 callq  *%rax
> > >    0.05 =E2=94=82       testq  %rax,%rax
> > >         =E2=94=82     =E2=86=93 je     2e3
> > >    0.06 =E2=94=82       movq   %rbp,0x10(%rsp)
> > >    0.04 =E2=94=82       movq   %rax,%rbp
> > >    0.20 =E2=94=82       movq   %rax,(%r15)
> > >    0.07 =E2=94=82       movq   $0x0,0x28(%rax)
> > >   97.01 =E2=94=82       lock
> > >         =E2=94=82       btsq   $0x0,(%rbx)
> >
> > ...are the struct pages on the pmem node itself?
> >
> > --
> > Pedro
