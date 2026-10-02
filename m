Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19244570FD
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976903; cv=none; b=Dyok738o/FMgolkosINZbnmfK+OtxHV42Ph9WqdxYThLPHE6dodYt+4viaaqnCm/eHdGPv1iWziTRL9r9XPbVBzljhEaWpz6WwtGC4ED90CjPrfhiLn7Nt+HoL3hvModCl5rSRB5/sehg0h4QVuOdXP0qUvhOYGqEgyAHpmu5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976903; c=relaxed/simple;
	bh=Gaj2nIDkm7iKsKp52muDu6Kz1AN/yv2ZmGsrL8/bMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig/KbjDhjaPJCGlwTrnd4RwwHhiSrMh7kfy3C4W/iI1S8ytUIuQ5NA1BdB2F2Qqtg7FzuTyNRN5TjrnLv75e8tPbvw/TyLBZQT/8alEs+M0Xvp7yTkpWIHjykWV9IhNsJgLptZsDkRGyVfaKveNxnUEOXRPoGn3RnGOGtiwFWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SaBXNwBl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8ZToiGbI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T4/ZGIJD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t2I1h8x8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SaBXNwBl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8ZToiGbI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T4/ZGIJD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t2I1h8x8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5AF1FDC5;
	Fri,  2 Oct 2026 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790976894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2IxeNoFs1zgMWILLB8hyk9e3lt3hkRC40MEs5rXaCM=;
	b=SaBXNwBlfIUJUHuegldFFgE1q7izh7yHRUDeReJZ3VUxn6wq7e67gRYAmerczFJMUwGEIQ
	WuTkEONnT/eRhlbJQ/3fnGg07eoyq0wczjH3A2UmrsBODaHOKb6DXzJESWU0/Iydyb4t3i
	jy0ubu0kKjJMn1Vt751JCqnUAGQseLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790976894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2IxeNoFs1zgMWILLB8hyk9e3lt3hkRC40MEs5rXaCM=;
	b=8ZToiGbIA8Brm9Tq7WUQVNwkOZoHS0Cq2cLhguKlugVp4vWO2SxuTykhleoNjJoSvVCtFF
	b9tZgFxuClHT8fCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="T4/ZGIJD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t2I1h8x8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790976890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2IxeNoFs1zgMWILLB8hyk9e3lt3hkRC40MEs5rXaCM=;
	b=T4/ZGIJDW8b0lkwKpYfa0+yxyMLgOu9NXGBab1JqRHqWcycvDTZ+wP2RC4WOZOHBbskdhY
	Ck9B3tx6veKUyhEq6buPPi0NtxuYCBJUFZEaI30fAsMsjtCXWQh92iRvNPyYohG8KgvQuk
	bbfLs3h2c7Z670reBIrwrN3c1/pT5/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790976890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2IxeNoFs1zgMWILLB8hyk9e3lt3hkRC40MEs5rXaCM=;
	b=t2I1h8x8HmPBeCIZzBp9YcUjxn8SbnvMS9NFtxKxqXNpOqAI6k3YpA9Qg7zoCLWUTPMgNx
	3vaij3aWVAfomcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14D71139E2;
	Fri,  2 Oct 2026 21:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id baj7NHkjwGpDcgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 02 Oct 2026 21:34:50 +0000
Date: Fri, 2 Oct 2026 22:34:48 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org
Subject: Re: Poor memory bandwidth performance between NUMA nodes
Message-ID: <asAjUfNg_80sA6Yn@pedro-suse.tail5790ac.ts.net>
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
 <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F>
 <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>
 <ar_zftIk5caN-5uV@gourry-fedora-PF4VCD3F>
 <CAAiJnjrjtseaUPo5vyqGZeDAt4ST6eqvaXOCWvdaTUsx2D3v5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAiJnjrjtseaUPo5vyqGZeDAt4ST6eqvaXOCWvdaTUsx2D3v5g@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,localhost:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9B5AF1FDC5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Fri, Oct 02, 2026 at 09:55:32PM +0300, Anton Gavriliuk wrote:
> > I'm unfamiliar with Valkey, but you may want to ask how contended those
> > pages are if they're actually being used during migration time.
> 
> > Do you get this same behavior when migrating the same amount of memory
> > allocated by a toy program? (i.e. known idle pages)
> 
> I don't think that there is any contention.
> There is no processing, etc.
> This is a completely idle test server.
> I just populated 300GB memory by key-value data store.
> 
> Even if I use simple stress-ng instead of Valkey,
> 
> [root@localhost ~]# numactl --cpunodebind=0 --preferred=0 stress-ng
> --vm 1 --vm-bytes 300G --vm-hang 0 &
> [1] 4353
> [root@localhost ~]# stress-ng: info:  [4353] defaulting to a 1 day run
> per stressor
> stress-ng: info:  [4353] dispatching hogs: 1 vm
> stress-ng: info:  [4355] vm: using 300GB per stressor instance (total
> 300GB of 6.43TB available memory)
> 
> 
> [root@localhost ~]# COLUMNS=500 numastat -p 4356 | cat
> 
> Per-node process memory usage (in MBs) for PID 4356 (stress-ng-vm)
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
> Private                 307201.14            0.74            0.00
>       0.00       307201.88
> ----------------  --------------- --------------- ---------------
> --------------- ---------------
> Total                   307201.23            0.74            0.00
>       0.00       307201.97
> [root@localhost ~]# man migratepages
> [root@localhost ~]# migratepages 4356 0 2
> 
> I see even slower (System PMM Write) than 1.4 GB/s,
> 
> |---------------------------------------||---------------------------------------|
> |--            System DRAM Read Throughput(MB/s):        842.67
>         --|
> |--           System DRAM Write Throughput(MB/s):        851.34
>         --|
> |--             System PMM Read Throughput(MB/s):        785.27
>         --|
> |--            System PMM Write Throughput(MB/s):        804.57
>         --|
> |--                 System Read Throughput(MB/s):       1627.94
>         --|
> |--                System Write Throughput(MB/s):       1655.91
>         --|
> |--               System Memory Throughput(MB/s):       3283.85
>         --|
> |---------------------------------------||---------------------------------------|
> 
> 
> top - 21:49:22 up  4:53,  3 users,  load average: 0.97, 0.78, 0.61
> Tasks: 774 total, 2 running, 772 sleep, 0 d-sleep, 0 stopped, 0 zombie
> %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> MiB Mem : 6839822.+total, 6432377.+free, 422358.2 used,    790.2 buff/cache
> MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6417463.+avail Mem
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    4507 root      20   0    2644   1764   1644 R  99.8   0.0   2:20.63
> migratepages
>    1592 root      20   0   82184   5056   3932 S   0.3   0.0   0:07.26
> irqbalance
>    4993 root      20   0       0      0      0 I   0.3   0.0   0:00.02
> kworker/50:0-events
>    4999 root      20   0   10916   6080   3772 R   0.3   0.0   0:00.03 top
>       1 root      20   0   25528  15488  10484 S   0.0   0.0   0:02.35 systemd
>       2 root      20   0       0      0      0 S   0.0   0.0   0:00.06 kthreadd
>       3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
> pool_workqueue_release
>       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-rcu_gp
>       5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-sync_wq
> 
> Samples: 26K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 21652648047 lost: 0/0 drop: 0/0
> Overhead  Shared Object                      Symbol
>   21.77%  [kernel]                           [k] copy_mc_fragile
>   18.88%  [kernel]                           [k] clear_highpages_kasan_tagged
>   17.81%  [kernel]                           [k] migrate_folio_unmap
>    2.67%  [kernel]                           [k] __folio_alloc_noprof
>    2.09%  [kernel]                           [k] smp_call_function_many_cond
>    1.89%  [kernel]                           [k] try_to_migrate_one
>    1.74%  [kernel]                           [k] folio_migrate_flags
>    1.69%  [kernel]                           [k] page_vma_mapped_walk
>    1.14%  [kernel]                           [k] remove_migration_pte
>    1.01%  [kernel]                           [k] rmqueue_bulk
>    0.88%  [kernel]                           [k] migrate_folio_move
>    0.87%  [kernel]                           [k] __mod_memcg_lruvec_state
> 
> Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 56222244297
> copy_mc_fragile  /proc/kcore [Percent: local period]
>    0.00 │      cmpl  $0x8,%edx
>         │    ↓ jb    43
>         │      testl $0x7,%esi
>    0.03 │    ↓ je    27
>         │      movl  %esi,%ecx
>         │      andl  $0x7,%ecx
>         │      subl  $0x8,%ecx
>         │      negl  %ecx
>         │      subl  %ecx,%edx
>         │19:   movb  (%rsi),%al
>         │      movb  %al,(%rdi)
>         │      incq  %rsi
>         │      incq  %rdi
>         │      decl  %ecx
>         │    ↑ jne   19
>         │27:   movl  %edx,%ecx
>         │      andl  $0x7,%edx
>         │      shrl  $0x3, %ecx
>    0.02 │    ↓ je    43
>   58.57 │31:   movq  (%rsi),%r8
>   12.21 │      movq  %r8,(%rdi)
>    4.22 │      addq  $0x8,%rsi
>    8.25 │      addq  $0x8,%rdi
>    0.53 │      decl  %ecx
>   16.06 │    ↑ jne   31
>         │43:   andl  %edx,%edx
>    0.02 │    ↓ je    57
>         │      movl  %edx,%ecx
>         │49:   movb  (%rsi),%al
>         │      movb  %al,(%rdi)
>         │      incq  %rsi
>         │      incq  %rdi
>         │      decl  %ecx
>         │    ↑ jne   49
>    0.02 │57:   xorl  %eax,%eax
>    0.06 │    ← retq
>         │      int3
>         │      int3
>         │      int3
>         │      int3
> 
> Samples: 187K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 84234492777
> clear_highpages_kasan_tagged  /proc/kcore [Percent: local period]
> Percent │      nop
>    0.03 │      subq 0x1a5067c(%rip),%rdi
>    0.01 │      movl %esi,%ecx
>         │      xorl %eax,%eax
>    0.03 │      sarq $0x6, %rdi
>         │      shlq $0xc, %rcx
>    0.03 │      shlq $0xc, %rdi
>    0.03 │      addq 0x1a50675(%rip),%rdi
>   99.72 │      rep  stosb   %al, %es:(%rdi)
>    0.09 │      nop
>    0.06 │    ← retq
>         │      int3
>         │      int3
>         │      int3
>         │      int3
>         │      nop
> 
> Samples: 223K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 88021056491
> migrate_folio_unmap  /proc/kcore [Percent: local period]
>    0.04 │       movq   %rdi,%rax
>         │       movq   %rcx,%rdi
>         │       movq   %rbx,0x8(%rsp)
>         │       movq   %rcx,%rbx
>    0.04 │       movq   %r12,0x18(%rsp)
>         │       movq   %rsi,%r12
>         │       movq   %rdx,%rsi
>         │       movq   %r13,0x20(%rsp)
>    0.06 │       movq   %rdx,%r13
>         │       movq   %r14,0x28(%rsp)
>         │       movl   %r9d,%r14d
>         │       movq   %r15,0x30(%rsp)
>    0.05 │       movq   %r8,%r15
>         │     → callq  *%rax
>    0.05 │       testq  %rax,%rax
>         │     ↓ je     2e3
>    0.06 │       movq   %rbp,0x10(%rsp)
>    0.04 │       movq   %rax,%rbp
>    0.20 │       movq   %rax,(%r15)
>    0.07 │       movq   $0x0,0x28(%rax)
>   97.01 │       lock
>         │       btsq   $0x0,(%rbx)

...are the struct pages on the pmem node itself?

-- 
Pedro
