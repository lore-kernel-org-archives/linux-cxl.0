Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BB3537FF
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957788; cv=pass; b=T5xJlf4dzxtLyj5j0Zw4sbLbCPCMdmVOhLstQDeakuWZhDPOxY5+DvaHQ8Q7/NuyeRV7cIcSmapNHRkY9D8PMJJgFcL4fTbhjrrMRZCED2zDQwupTviw8jBVMId7F1vK8RnAAL+JSUiBW3s/Tsg5EOTDP002xCoNDmb2XNmYwb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957788; c=relaxed/simple;
	bh=R90HWradiucWXVd7qFR6whm+rZ7UFw9XjT+jPWWBgAY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N8G2PNltootXQ6BX8Rtrlg/NSQ00X2clb/4mGlBrDE9pTGh7kqx773d9pCfhTK1Uc/jCQe2yxuUWuc6fIe6FXZK/DX0El/t5r00TXH8oP8vdvNf/JY0wP4EdsUJjYBPfQQV4ytVO/LMCDR95ueJwvtmQt3xF955Q00Ocjp7JKU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5YQ5ZAo; arc=pass smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5YQ5ZAo"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so79461a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 09:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790957785; cv=none;
        d=google.com; s=arc-20260327;
        b=Jy25WxAou3IT6crlPS5kA3TH9Eug+h2AyH1rBbNpV6k4hv00Gj6TT4vZWoMf4Pp96b
         KxTt0+GZbLDrsdPocpu6KLKiPIY2PJuw+R9zTs4dfyQD7A1Uo0XsjisFwA2y6xIRBIHi
         87udimrNvzlEYN0yDF0uSYArYQYgqt5USNGSoJJWhEtoJXRY/y7sqnP6JREYIxkh9hHT
         NvcBeny4GCSgRgU+uvvFnQtz4iHU5b4R464hnKQR4riW5BNdjstTWRPH1YQrM/hVV90T
         0xGsszc7bOTHsfbeKW1hPnb0OEdKzrKp7uT7HjRSF2FwARSzGLN3FP7ZwSxOa1iREUfU
         D1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=81SrQlvrYJ/nq4GpaZugKxmAIhcZ8Lzg+zQauV1EEn0=;
        fh=wl4DfucxSTpEhu/9aS2zEx5EBSOQyVVzIyKyZqDkYmU=;
        b=smc42CWSAvh4aSUxWxWSHZBcUZ57kdouYqxbNoBGQ3kjPVn16TZ5DTsygj85W5WIA8
         Zu3aPxz+EsFf95D6NPVV4+n9FqrptkdA//4jx2WZyb8D2Bc2e2wK1vhVO+Fqf7YQ/aFg
         SZTTIj3B095Wk8sgNK8/JkL7CO0SVb0E39Pm9t3RtRFgjJg3meFbDy1tv/ORZOKSKiAs
         gTLXzj+KY1Uq5hZiGVTY6ZYfBltcVQ9gTZEwReNoFvcyVTTt+pCXxo/LraPCrkbEFlw3
         AeMo/+QvOoOf1p1hDMulPnixtWYC6EYhGNa5INLioUdVqujdcGzXMpRNQ18lPN6dbIUa
         zpWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957785; x=1791562585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81SrQlvrYJ/nq4GpaZugKxmAIhcZ8Lzg+zQauV1EEn0=;
        b=G5YQ5ZAoy9O0NjmyY+0QQVMNPwPK6ZTnl+LE+OK4znFMhIVwIaH6ZsFnudpBVLnZQ6
         ka4kKQLfasVC6z1yAwVI8GD09TvAbst1ch+yOfO9x80HRfP/xP63LOy8y0DfqJPGdirC
         ICs5AejPHIOUTtLo6V/LFU+4KEp+t1/kBlLpSqK55D6+onv6npUsDvuwrQ7RuFKkEFS6
         MFYd9SvDzHttvpHGBXfbRs4KoxcfdCh2mQOgqN/cC6+/zGNi2oqKZKkIsGqM02RIcN4T
         jMGD6ol2jqvLYGsNryAKLDY4tYgPmFLF1JH+S/eIWYTKbA7fy7KJBNd05+lU3k5L4hij
         oE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957785; x=1791562585;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81SrQlvrYJ/nq4GpaZugKxmAIhcZ8Lzg+zQauV1EEn0=;
        b=bpCFpKWvWaplNs/4Q2sV0BtleVO+aphntN4lnPIAPYOxpI83Z1XQieKhN/F+ugK7I4
         P0YaDUbm5ye82VRB5Ig5h1t5896uQWgma8BnmkSflcBN1JXsAVR2jgqiGleLt09tSZFZ
         4nTdpHtxMxbGI+XiS8LoeE2TNZMhROkS99a4S3ZYgRiNWdauR4NaV3s5lodcfpkzLgUS
         qMeOrISu579BCezuNqIUasEyUsDIhM0I4cOz5m0pCMCyuyWA2VQnPW3fUWDCb8NOZRlI
         QP0/CpBsTJT8Y7UO2o3ire+W3BHLMsrG7Lw6C3+bdLrm+HBMd36IB4T4trG5p896L2kf
         +bdA==
X-Forwarded-Encrypted: i=1; AKwUvBzSqTaOj/LMnEr1cKg3T/IG9xS5G01X+XspzqNfG4OLyc1ABt1ZU6m5A6Wo3sfehrw+X3YdA8yT5HE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyc10l4eHwIhsE10I15jeacXdZAo/daCKOj2VO8TMQKWk3SazM
	3pBjJKCTfsYZVj6cQoBI2JZU0vi0sS4vtl3cUi1NR0E06ZAarRRzLKP0ox9is9n1/vKuVJppSIy
	P6BsylaVq9qr2UZ+NIz6Kyy2NTNXnk45cARbR
X-Gm-Gg: AYBFou2eEKUbRQa683e1ZEiNj/S3OoCmUiKITkgXgHjrNYCWfUMTbV2HUA/vkutQue3
	EPeBtgY5BClnGDt4W9+WrNtO6zz0iLLEN3Gr0ROMGII25Ye4nJEEd6VsUf7YXFAO2sMIWnc0FGa
	niOrHscqPrTLC6lkaN8Db8n+IDNa5Cpk05jfXmmZttN5die1NBfzPBzMj5SFBt6GRpw1YcydaGn
	XJxartmRNsDgYVvjWVOEj8f9YTM1VoY2jccVDuvZyQBkG2D9e0VZvgIB5iysnbOqaQYEwzw2PDn
	5s47wW69DNFE+ZLn4LMaeJVbLMAXyefs92LnF6QjsrxfqoZQ/sTh8RTj
X-Received: by 2002:a05:6402:4606:b0:6ac:b85d:10f1 with SMTP id
 4fb4d7f45d1cf-6af9e2ea589mr2038154a12.11.1790957784516; Fri, 02 Oct 2026
 09:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 2 Oct 2026 19:16:12 +0300
X-Gm-Features: AclHuK9ozIpKtifV_S9EpGNgj5f1FCCQ1rOkjiABvT5mW0EzReq-wWA8PmAityo
Message-ID: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
Subject: Poor memory bandwidth performance between NUMA nodes
To: linux-mm@kvack.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

There is Fedora Server 44 (up to date) on HPE DL380g10 socket server
with Optane PMEM DIMMs configured as system RAM for simulating CXL
type3 memory expanders,

[root@localhost anton]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
22 23 24 25 26 27
node 0 size: 386590 MB
node 0 free: 337352 MB
node 1 cpus: 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
47 48 49 50 51 52 53 54 55
node 1 size: 387055 MB
node 1 free: 338582 MB
node 2 cpus:
node 2 size: 3033088 MB
node 2 free: 3033088 MB
node 3 cpus:
node 3 size: 3033088 MB
node 3 free: 3033088 MB
node distances:
node     0    1    2    3
   0:   10   20   25   35
   1:   20   10   35   25
   2:   25   35   10   20
   3:   35   25   20   10
[root@localhost anton]#
[root@localhost anton]# ./Linux/mlc
Intel(R) Memory Latency Checker - v3.13
Measuring idle latencies for sequential access (in ns)...
                Numa node
Numa node            0       1       2       3
       0          82.2   147.0   173.8   237.7
       1         146.7    82.8   238.6   172.2

When I allocate memory in NUMA node 0, for example by using Valkey and
then migrate memory pages from NUMA node 0 -> 2 by using DAMON/DAMOS
Memory Tiering or even simple migratepages command, I see migration
bandwidth 1.4 GB/s.

Could you please help me analyze and improve this bandwidth
performance ?  It may also be useful with the coming CXL (type3
devices) era.

As I mentioned there is no performance difference between DAMON/DAMOS
Memory Tiering or migratepages command (in both cases ~1.4 GB/s), so
below profiling with migratepages command,

top - 12:43:59 up 13 min,  2 users,  load average: 0.65, 0.88, 0.76
Tasks: 757 total, 2 running, 755 sleep, 0 d-sleep, 0 stopped, 0 zombie
%Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.=
0 st
MiB Mem : 6839822.+total, 6438483.+free, 416313.2 used,    669.8 buff/cache
MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6423508.+avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
   2935 root      20   0    2644   1764   1644 R  99.7   0.0   0:42.19
migratepages
   2941 root      20   0   10884   6192   3916 R   0.7   0.0   0:00.04 top
   1238 systemd+  20   0   15860   6996   5952 S   0.3   0.0   0:00.37
systemd-oomd
   1928 root      20   0  666268  24448  23440 S   0.3   0.0   0:00.34 rsys=
logd
      1 root      20   0   25840  15532  10492 S   0.0   0.0   0:02.15 syst=
emd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthr=
eadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
pool_workqueue_release
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
kworker/R-rcu_gp


|---------------------------------------||---------------------------------=
------|
|--            System DRAM Read Throughput(MB/s):        759.41
        --|
|--           System DRAM Write Throughput(MB/s):        751.36
        --|
|--             System PMM Read Throughput(MB/s):        701.24
        --|
|--            System PMM Write Throughput(MB/s):       1402.15
        --|
|--                 System Read Throughput(MB/s):       1460.65
        --|
|--                System Write Throughput(MB/s):       2153.50
        --|
|--               System Memory Throughput(MB/s):       3614.15
        --|
|---------------------------------------||---------------------------------=
------|


Samples: 92K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
48280162400 lost: 0/0 drop:
Overhead  Shared Object                      Symbol
  49.82%  [kernel]                           [k] migrate_folio_unmap
  16.52%  [kernel]                           [k] clear_highpages_kasan_tagg=
ed
  13.56%  [kernel]                           [k] copy_mc_fragile
   1.80%  [kernel]                           [k] smp_call_function_many_con=
d
   1.06%  [kernel]                           [k] page_vma_mapped_walk
   0.95%  [kernel]                           [k] try_to_migrate_one
   0.94%  [kernel]                           [k] folio_migrate_flags
   0.71%  [kernel]                           [k] rmqueue_bulk
   0.61%  [kernel]                           [k] remove_migration_pte
   0.54%  [kernel]                           [k] __free_one_page
   0.50%  [kernel]                           [k] migrate_folio_move
   0.48%  [kernel]                           [k] folio_batch_move_lru
   0.47%  [kernel]                           [k]
__list_del_entry_valid_or_report


Samples: 37K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
33608407521
migrate_folio_unmap  /proc/kcore [Percent: local period]
Percent =E2=94=82       movq   %r13,0x20(%rsp)
   0.02 =E2=94=82       movq   %rdx,%r13
        =E2=94=82       movq   %r14,0x28(%rsp)
        =E2=94=82       movl   %r9d,%r14d
        =E2=94=82       movq   %r15,0x30(%rsp)
   0.01 =E2=94=82       movq   %r8,%r15
        =E2=94=82     =E2=86=92 callq  *%rax
   0.04 =E2=94=82       testq  %rax,%rax
        =E2=94=82     =E2=86=93 je     2e3
   0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
        =E2=94=82       movq   %rax,%rbp
   0.03 =E2=94=82       movq   %rax,(%r15)
        =E2=94=82       movq   $0x0,0x28(%rax)
  99.52 =E2=94=82       lock
        =E2=94=82       btsq   $0x0,(%rbx)
   0.01 =E2=94=82     =E2=86=93 jb     26b
   0.13 =E2=94=82 67:   movq   (%rbx),%rdx
   0.01 =E2=94=82       testq  $0x2,(%rbx)
   0.01 =E2=94=82     =E2=86=93 je     e2
        =E2=94=82       cmpl   $0x2,%r14d
        =E2=94=82     =E2=86=93 je     d2
        =E2=94=82       movq   0x40(%rsp),%r8
        =E2=94=82       movq   %rbx,%rdi
        =E2=94=82       movl   $0x1,%ecx
        =E2=94=82       xorl   %edx,%edx


Anton
