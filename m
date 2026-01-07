Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDB34C124
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806841; cv=none; b=K0XT8jCGUYpURdBvzb2xRUhUmn85k0qfqs8uwsWfeMxzj32ZcAu5sOlfeEEU93hqs0jJUCOZSp1tGSKxfBcRYVWvxS275ayXW+5BgTuNND2wY37Li2WCL88m1CBnMCoWo1V73q9EY8DVkMj+V8EQwtYXpL4UnCH+YYdX4kcjLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806841; c=relaxed/simple;
	bh=Ttkg2XpXdV7mU4TtIvuypgDn9POxEKCuiqAdPxPROfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dhrf84F6Dnh0iPPQSoXd2hpI+hfLRYDMqSYNoJnxp3v8attHEgJRoKmjP+lBThFL3kTy5dLJA1iQdI+bMXV5XP3CcGV6Q6pooo7vasLZAd86KGQ9BHmd0XDDsgIzgcp7I/9hd7tMFxoEA3yN3cbhH/h0D57B+7O7eDRqm3gEalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhqxfTrs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhqxfTrs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2599982b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806826; x=1768411626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=smDhjw69opHcgwAO6wrw0z059aJcdcN+GUjt6JFpHNc=;
        b=RhqxfTrst4ZYWbVGwexHqhF3wZK9bRo4MGeBDpbx8lNrUU9X7XiYFhmePeT/2lxqRg
         KgaylNXhJ6gzRocZ2JDKFO8KFH7G+gveU00ZZ//MpcJcDpOPoVjO6DGADzJYFrvXUhjN
         LOpikDt9flu0vP572sMn73IpPSNDHwq9GW8m4BEZ1r69SwHPXGe/BQacKW0O0nm1aamj
         AncYBeNCqwgTHuNtmrK97geCDX8tajzx+duPRWjNPXTaW88Mqg1w7HbZR/m/a1XyWNm0
         O+eS7ckOKBE75JeZT2xCAaDmnn7qDD8UWt5r9cTwi7uMlPmJkv1bOdFyFq5nVAOlwVeg
         nfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806826; x=1768411626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smDhjw69opHcgwAO6wrw0z059aJcdcN+GUjt6JFpHNc=;
        b=v4pz4eQaP6OSLogyHE8bVU/7KhRnIs5Tf4taG19wyBSlx0jy6Vnn6C7JCohF0wTXK9
         ln1ksATHGcbvSzelyvRmzE3VQoryamh3uCoU/0benHiM0DUq/QJfbsynHnRz9sBfHRwz
         fDwmtTrPVaUbyjy0ysDDMLHbhP78o0Ym5q49hIE/IGMtqcySMyGieK9wO33VI2csifLs
         nw3HJlliy1oETGc6781HaGUhFpS+EPr2XV9Se8wcFoWPzvA4mJnk3j0wjgMckBfPc67Y
         L9EBDsEoe6yE3F7+9mQxSnBI00sOXY6e+P7+1h25P929r9wrJ8J1Wa/3hljHYzOxfAwM
         Zfsg==
X-Forwarded-Encrypted: i=1; AJvYcCXjyXEIKy3Q4LEIoTd8OIi8eM6uxh9QM93WT3+keuaH/Yd4hGZcJFDowYKU5gxVCmOUIfNdLEsijqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBFHHqLniQtd9yNBnVY8/NgBWzZI8S2eEEw1IklhKJVgNjZqN
	KwJr5DuS3xap0DYwPT9e+5fl82ibGKbURl44E1Tfe//O5ZVt01zVkjaB
X-Gm-Gg: AY/fxX6yZD4F/bfDr/+CGJtLw1+7c+Izq4x4Qwy7bYfmwlQ6Y+ZOKel7PyAFncQYMzE
	9E8zqpGTJjPgTdPv7YwHpXTx5V6EHFIco+IatIr60sybLTZRfOpnvhoGvkhUp2jWE4BNW/iggCx
	LtXlZJM1yXc1irOIJb7Eql5v3V8I0xEhyydPazdhy6j4lMILYpcmTFP4JzuncbA0fftXUV0p0Q3
	TBgGDxgVj42klXL/z4MhlHH4qoRqlaZGo/x8KJBz1uo6bZYAOmGAmxSAQVpAfuW52OGcLYqoBVM
	2Lx3rMcEoGRNk8qIVe3IuzZXd1Fm0Mo+6Idc/lqnPBe7TH+bYqQVWOXOYCWq6R2FERPLUZ/EqOE
	0GQvmB2dOPgLQVlQkeXOHVIFZoiGMmsXU7+h3NwuyEB9IlYa46IWUrRmJTAYrrBRT48U6/ILURR
	WzE29gHNDQb5lZ16bcXy+8xbAZh1J+cyJNC0SSAPyp0LKP
X-Google-Smtp-Source: AGHT+IGk3VZwDE/lNocDKTrmheVpB/dJskVwCoQ351Cwl656mI6EkUE/J2SR25sUuHffBBW1+p+c1g==
X-Received: by 2002:a05:6808:668c:10b0:45a:7773:9013 with SMTP id 5614622812f47-45a77739cc0mr200634b6e.21.1767799968204;
        Wed, 07 Jan 2026 07:32:48 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8b2sm3393292a34.15.2026.01.07.07.32.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:32:47 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH BUNDLE] famfs: Fabric-Attached Memory File System
Date: Wed,  7 Jan 2026 09:32:44 -0600
Message-ID: <20260107153244.64703-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a coordinated patch submission for famfs (Fabric-Attached Memory
File System) across three repositories:

  1. Linux kernel (21 patches) - dax fsdev driver + fuse/famfs integration
  2. libfuse (4 patches) - famfs protocol support for fuse servers
  3. ndctl/daxctl (2 patches) - support for the new "famfs" devdax mode

Each series is posted as a reply to this cover message, with individual
patches replying to their respective series cover.

Overview
--------
Famfs exposes shared memory as a file system. It consumes shared memory
from dax devices and provides memory-mappable files that map directly to
the memory with no page cache involvement. Famfs differs from conventional
file systems in fs-dax mode in that it handles in-memory metadata in a
sharable way (which begins with never caching dirty shared metadata).

Famfs started as a standalone file system [1,2], but the consensus at
LSFMM 2024 and 2025 [3,4] was that it should be ported into fuse.

The key performance requirement is that famfs must resolve mapping faults
without upcalls. This is achieved by fully caching the file-to-devdax
metadata for all active files via two fuse client/server message/response
pairs: GET_FMAP and GET_DAXDEV.

Patch Series Summary
--------------------

Linux Kernel (V3, 21 patches):
  - dax: New fsdev driver (drivers/dax/fsdev.c) providing a devdax mode
    compatible with fs-dax. Devices can be switched among 'devdax', 'fsdev'
    and 'system-ram' modes via daxctl or sysfs.
  - fuse: Famfs integration adding GET_FMAP and GET_DAXDEV messages for
    caching file-to-dax mappings in the kernel.

libfuse (V2, 4 patches):
  - Updates fuse_kernel.h to kernel 6.19 baseline
  - Adds famfs DAX fmap protocol definitions
  - Adds API for kernel mount options
  - Implements famfs DAX fmap support for fuse servers

ndctl/daxctl (2 patches):
  - Adds daxctl support for the new "famfs" mode of devdax
  - Adds test/daxctl-famfs.sh for testing mode transitions

Changes Since V2 (kernel)
-------------------------
- Dax: Completely new fsdev driver replaces the dev_dax_iomap modifications.
  Uses MEMORY_DEVICE_FS_DAX type with order-0 folios for fs-dax compatibility.
- Dax: The "poisoned page" problem is properly fixed via fsdev_clear_folio_state()
  which clears stale mapping/compound state when fsdev binds.
- Dax: Added dax_set_ops() and driver unbind protection while filesystem mounted.
- Fuse: Famfs mounts require CAP_SYS_RAWIO (exposing raw memory devices).
- Fuse: Added DAX address_space_operations with noop_dirty_folio.
- Rebased to latest kernels, compatible with recent dax refactoring.

Testing
-------
The famfs user space [5] includes comprehensive smoke and unit tests that
exercise all three components together. The ndctl series includes a
dedicated test for famfs mode transitions.

References
----------
[1] https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[2] https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
[3] https://lwn.net/Articles/983105/ (LSFMM 2024)
[4] https://lwn.net/Articles/1020170/ (LSFMM 2025)
[5] https://famfs.org (famfs user space)
[6] https://lore.kernel.org/linux-cxl/20250703185032.46568-1-john@groves.net/ (V2)

--
John Groves
