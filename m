Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046846F48F
	for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725115; cv=none; b=X5A0Tx4/CBth1bA15HiDtb1KLPqXjEozw/00sl1OQY+nw0mKpkSr05x+DksLJp8SGLcfYpu4qOB2OSmeOTNCBx34M5fuxAoZ7WNbjpJRDkKAu6W6wY2rQJSw3DQm0OotiqHq2GCEM3dNphlLOS+fgO4aXsj8P/6uEx7YU2526S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725115; c=relaxed/simple;
	bh=8smnFvB7KLfX2fGBOg+b+nzNyrH1O5JY7J41dres3M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahcoxxo2FkJqYZO2Xtl6jgACrYl3ZYA906MpATEn+Vdep6BagBtB33FGlWMN+5bIs/1LxmkahcO6ApmUJuet14wyXERjK3Yhdxj+p11XKNmymvluODA0mvR5dEtoPLbUR6j9bQ/pVPQWpecisqAyLUK9I3T1l82dNaS8FkB41Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLgF1n+y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLgF1n+y"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6391b114so97539985a.3
        for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786725112; x=1787329912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qP3/xbCH+ItyubGsI4w69p0TyaaTEvp23aOndMgOaFY=;
        b=gLgF1n+yZHdqsTkqXVuOfX+KCTgzT9T1yn28js701RDefBCW9FIZAbqNAXjHeALyPH
         0XntnPvuYml+f4RlAWL0vPR8g9okwyqei8kmm7/DrMDsd5ia9dGvPEKoD4NgVHtSJy7n
         4qWh3+u5dJ1Gd8OYeabUm05DzeHEc5qIhuuEg4U1gbEWoiR/MPFa2puhkQgda1LUaSmK
         pbH6PaKh0054PwsdxL6JkwmHwivHZoOaqOROhO2HJYIKMdHM6CGqiycqOrcbi8wgZgqA
         CG5DSkOu/ymmppY0G6hxE20f91gaX2KdSYGQ/Gu4nVOqeV3u+A/sI5adUcE6g4hSTm4b
         xsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725112; x=1787329912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qP3/xbCH+ItyubGsI4w69p0TyaaTEvp23aOndMgOaFY=;
        b=crWDWE5STQXSwkuhVqM2/wwkPEyAVfrq5j3GO2lx6A9I4tA9MDD+XgQ6GpOX9ZBjwa
         eQlig7SHhdyitWqaCd3jOdo3V1BIHeaPO5MNFpHFkcsSKI7T+cAoJjDuhkFSLUz0d2Dw
         nfMJIWaqrKC0zJKf54hyRd3F3WZt8b8z1jvCoUSDTDgOShUyVH5i9akf+yvuk1RNBmpe
         7YbRS4S4pEd7/xvDQMT9tavLTs9hpOskQm2DphAKV6Q86oOhrKsxSqDnJ3xkFI0kRm/V
         znvUBoxBmM+Tra2GktvKtcZ3t9FzcaQjTITpom5SSMmc3aaomoyjfI8fNtvC/ISfEZIX
         el+g==
X-Forwarded-Encrypted: i=1; AHgh+RoiWu4Wlv6mbT7dKAJqjsc4tCdXJQbld47np4K0/RJhaChHF0vsypOcEj4bnfuJpBngGEJGYBdjfDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmTcxcfmARv+x+IEiNsGJp6Puw4H7dfHmQrNuXdGAeWfYzl9A
	5Opl3yBcjzjYEp+BZBobVeQKGx06vyy4GU8oQtICbLIfUD/tVgtydtN/
X-Gm-Gg: AR+sD10kigXmB8wZ4TcEa3m8dcyi9Vahy030AHwWUy1ukex2xAosSjTXwD8AngDy6e+
	tP+4UVOlRkMZ5z7wUG/r4SwFI1lrVYcD3j/Kg0YaCb1iewBiCUqnMNRCeLazbzv6R9+KSLgBZWx
	LcG1Yqe+00ZY96e/2Q/mZ3tV5p9V1Sa8cHQ/bIP4EOmEiMh9XfK+GpYzTZLBPZh6LjQp7WN4CNW
	9nZdo5McB44a02nFXz9MMc6SMBiplTusBycwCXNpQ/ya2sjwQ9rLHpiJPMl1XYy1PgQOhb1yWMp
	H4r3Zj7n+fKvyzZvqdBNRfDe5VOkp5PK/gIH+nDofjP2G4L+mr9EmD0jnqyIThbANENVVfsDxRI
	igWLK6S+yK06SnYeFvFOceIGFC0peYlYhRl0hIsTs2TtLPj+L2JDzh3mj+xElgPH+ttp9jrid5K
	v3X51CxOQcm+48iwR24SEDKhTC0COanRbrbNE5LtI8I80XpES7XIFNwvE8EC4c4SL5V5DnKLJYc
	s5AioHYDrK0QgDcCw==
X-Received: by 2002:a05:622a:86:b0:51a:329:e802 with SMTP id d75a77b69052e-52d85525d9bmr77225441cf.41.1786725112400;
        Fri, 14 Aug 2026 09:31:52 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a921e4c3esm22570046d6.1.2026.08.14.09.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:31:52 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] firmware: memmap: slab-use-after-free in firmware_map_add_hotplug
Date: Fri, 14 Aug 2026 12:30:56 -0400
Message-ID: <20260814163117.3390709-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in firmware_map_add_hotplug

on commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40 (2026-08-13)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/6d12f2eba2f06179a20ffcafe69fcc59

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   68.640158][ T8381] BUG: KASAN: slab-use-after-free in firmware_map_add_hotplug (drivers/firmware/memmap.c:225 drivers/firmware/memmap.c:248 drivers/firmware/memmap.c:286)
[   68.640950][ T8381] Read of size 8 at addr ffff88811a4b0800 by task sh/8381
[   68.641868][ T8381]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   68.641873][ T8381]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   68.641886][ T8381]  kasan_report (mm/kasan/report.c:595)
[   68.641894][ T8381]  firmware_map_add_hotplug (drivers/firmware/memmap.c:225 drivers/firmware/memmap.c:248 drivers/firmware/memmap.c:286)
[   68.641903][ T8381]  add_memory_resource (mm/memory_hotplug.c:1571)
[   68.641933][ T8381]  __add_memory (mm/memory_hotplug.c:1611)
[   68.641936][ T8381]  probe_store (drivers/base/memory.c:582)
[   68.641949][ T8381]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
[   68.641952][ T8381]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
[   68.641973][ T8381]  ksys_write (fs/read_write.c:739)
[   68.641986][ T8381]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   68.641991][ T8381]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

[   68.669009][ T8381] Freed by task 8381 on cpu 0 at 68.618788s:
[   68.669579][ T8381]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   68.670025][ T8381]  kasan_save_free_info (mm/kasan/generic.c:584)
[   68.670507][ T8381]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   68.670960][ T8381]  kfree (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6692)
[   68.671337][ T8381]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/linux/kref.h:65 lib/kobject.c:737)
[   68.671762][ T8381]  firmware_map_add_hotplug (drivers/firmware/memmap.c:192 drivers/firmware/memmap.c:306)
[   68.672289][ T8381]  add_memory_resource (mm/memory_hotplug.c:1571)
[   68.672772][ T8381]  __add_memory (mm/memory_hotplug.c:1611)
[   68.673186][ T8381]  probe_store (drivers/base/memory.c:582)
[   68.673595][ T8381]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
[   68.674099][ T8381]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
[   68.674501][ T8381]  ksys_write (fs/read_write.c:739)
[   68.674902][ T8381]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   68.675335][ T8381]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)


Best,
Shuangpeng
