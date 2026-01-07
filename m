Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DB39A7E7
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806063; cv=none; b=gApaHvboNkMw/Ia5NSNCXFQc6pmaamaBDS/WOcumT04HXgNtj2S2BbgbScSmTtBriRSvVxys9aAvNw9d36mIdDFlP5R4BBvd6xFsNhel9PmBplFeMui1swwms2Aq/qAUVZm4hKAN6HKX/328ISKswqW1TDHLMcF6PlsFc0VAfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806063; c=relaxed/simple;
	bh=yhcCIEmN2Tfyzu+dnQNfiM+iCJS7UZECUB107ub4/UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY7Np2pGqhh22aE5sRnCY0c7Y98zCPmgLpVXnAeW/KCnr7ewrPUMlqwaTgIsVxPDJoNWNn5vIG87rLDzwjHjR6oaz8jKWJ9W+YtQqxY1m4Ba13PtI6+6cM8ir/u/qtPmZTQPNe5OSLwqpuuxh03/gnKRhZhkXwueTFENJ/qviKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPDp357E; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPDp357E"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b21fc25ae1so242126685a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806061; x=1768410861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYCO0eJoVbD3YH1FLiCAgqRrwn5PztgMRBzzUwt58w0=;
        b=CPDp357EA9xUWWP9WOcLBbVFtfyn5Sj3TZAGHNolfrN6Hu5pcV69G6KaKtKVCPyRJV
         agg6I/bsVlVSy8/TU8Og6dgzmLEeANvfcEUIUhhcnCuYHOjBod6sv+pcWOfa9T9L2gEW
         l+vN+6pRHL7pPv04LBRnuAhPaSStUFzPyCNTNzd5mydjf+9tcRcG3ndgtYa3pUn5SdA5
         V76tuX5xmtRPWPZ7KSnuJPot1PHdZgCWfKIheIZHC1r0ZlNkwvNJ/Rv/WY6zzzSUYK6c
         OU2eJc6c1p7tQ4jugCwU/kpsDf2wioLkpCkiMKZT4YouozANz1Zi0KoUA0i9X9c6ERpn
         9ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806061; x=1768410861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYCO0eJoVbD3YH1FLiCAgqRrwn5PztgMRBzzUwt58w0=;
        b=mTd5J/wmBUKP6uF6FrW0Z2DqG/vwF0rSIyrnwV40KUpQHfL22iU3YhYadEByBtJ+Yb
         X3QpfmiCfku33zmlyobI93EBA7uZFmkbxlei629UIFp61MQE0bdjzsl3UcSR6w1aeRB/
         IXrvNlZ2u2ULViQUsE2EnLggDN9i6YshHYby1l0n5Jvmkwc5aay0A4paPyYlF6kzBoYr
         rAwcQaCvMpfBfJTOt+F9kQRO1MhtWUZwsVgBvPJwS/gMEUmSmYWqj2U1KLGQqJxtCIpa
         Ua6Dc9vDqhwDyC8Yi3gCjJNQX0L3GoyUN7E5KB1j8YhXlqdTbfMQPSs6S1/s9++ULlEX
         zcrg==
X-Forwarded-Encrypted: i=1; AJvYcCWsV7+CYM7b1eKG05H7rV9dHmrmj0q8nPMq/gbLUK8rmwr5maNBVXOg/1gKXz2xKINZVN2qQwZhYHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cD9yPtkrrroA09XpNHP2dyBTxX6WNfXK/yo1zaizoTYAmzs4
	sfDRk0mcWV4KenVpcJtU0Rq4wpbMeqr0FQNL3TBjWXblFg3rrPPifDY3zAKuHw==
X-Gm-Gg: AY/fxX5sWB059EB6Jkf6WRNs33LKiDI/YiKp9X/GTO2aeQsKSa0xNVdQhSWGX22OzaC
	tSt75VOsRnA/MSO6YPy9aKrKqp114WeVo7j6dXfzUybIyJBFHV1BWPiv+CVuuA916izGRWvs1zS
	zq+VPJqoVUOWo5EuY2wFSEzBFLJtWL9jRy7WPCTuwFNTMzCgiSY9S8FV9gQesEDxhDgTsUosGRH
	EyqhJiB0riLo9UAMUJTbV8PMUpEROsKA3JZIiWVmIA5D6j+4Gz3j6JGk1L7XRdlPFEMU0iMpNVV
	HQu3D8v9rO7JTdyaI1b2dJeeDoQkbV9Po/uVq0ph7fZ8f775NjYxI+0jybNB4Fd7xv95kVqNrWe
	CpcrU0siuYaM+nsdlQhTJdNMJl9R8sPJdtSoVGPNwspniVdn9qmtsmrNZa/7Sg8iWe9v+Wn9QA3
	xEOR37BukoVWdzb2ZY73uo2LlqorrTi7k4QE0Bcij6a80S
X-Google-Smtp-Source: AGHT+IEPMMHpJFcXOVxAHzXczejwJhd7WQ4l4nnWAUOyK/R1wfgiMJ/DrHHz3pBb4aiMtOJFewrIOQ==
X-Received: by 2002:a05:6808:8955:b0:450:7f09:69a9 with SMTP id 5614622812f47-45a6bf1a2demr1496887b6e.49.1767800022026;
        Wed, 07 Jan 2026 07:33:42 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:33:41 -0800 (PST)
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 00/21] famfs: port into fuse
Date: Wed,  7 Jan 2026 09:33:09 -0600
Message-ID: <20260107153332.64727-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153244.64703-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is available as a git tag at [0].

Description:

This patch series introduces famfs into the fuse file system framework.
This is really two patch series concatenated.

- The patches with the 'dax:' prefix introduce necessary dax
  functionality.
- The patches with 'famfs_fuse:' introduce the famfs functionality into
  fuse. The famfs_fuse patches depend on the dax patches.

In addition, there are related patch sets for libfuse and ndctl(daxctl).

Related patches and code

- Related patch to libfuse - posted under the same cover
- Related patch to ndctl/daxctl - posted under the same cover
- The famfs user space code can be found at [1]

Dax Overview:

This series introduces a new "famfs mode" of devdax, whose driver is
drivers/dax/fsdev.c. This driver supports dax_iomap_rw() and
dax_iomap_fault() calls against a character dax instance. A dax device
now can be converted among three modes: 'system-ram', 'devdax' and
'famfs' via daxctl or sysfs (e.g. unbind devdax and bind famfs instead).

In famfs mode, a dax device initializes its pages consistent with the
fsdaxmode of pmem. Raw read/write/mmap are not supported in this mode,
but famfs is happy in this mode - using dax_iomap_rw() for read/write and
dax_iomap_fault() for mmap faults.

Fuse Overview:

Famfs started as a standalone file system, but this series is intended to
permanently supersede that implementation. At a high level, famfs adds
two new fuse server messages:

GET_FMAP   - Retrieves a famfs fmap (the file-to-dax map for a famfs
	     file)
GET_DAXDEV - Retrieves the details of a particular daxdev that was
	     referenced by an fmap

Famfs Overview

Famfs exposes shared memory as a file system. Famfs consumes shared
memory from dax devices, and provides memory-mappable files that map
directly to the memory - no page cache involvement. Famfs differs from
conventional file systems in fs-dax mode, in that it handles in-memory
metadata in a sharable way (which begins with never caching dirty shared
metadata).

Famfs started as a standalone file system [2,3], but the consensus at
LSFMM was that it should be ported into fuse [4,5].

The key performance requirement is that famfs must resolve mapping faults
without upcalls. This is achieved by fully caching the file-to-devdax
metadata for all active files. This is done via two fuse client/server
message/response pairs: GET_FMAP and GET_DAXDEV.

Famfs remains the first fs-dax file system that is backed by devdax
rather than pmem in fs-dax mode (hence the need for the new dax mode).

Notes

- When a file is opened in a famfs mount, the OPEN is followed by a
  GET_FMAP message and response. The "fmap" is the full file-to-dax
  mapping, allowing the fuse/famfs kernel code to handle
  read/write/fault without any upcalls.

- After each GET_FMAP, the fmap is checked for extents that reference
  previously-unknown daxdevs. Each such occurrence is handled with a
  GET_DAXDEV message and response.

- Daxdevs are stored in a table (which might become an xarray at some
  point). When entries are added to the table, we acquire exclusive
  access to the daxdev via the fs_dax_get() call (modeled after how
  fs-dax handles this with pmem devices). Famfs provides
  holder_operations to devdax, providing a notification path in the
  event of memory errors or forced reconfiguration.

- If devdax notifies famfs of memory errors on a dax device, famfs
  currently blocks all subsequent accesses to data on that device. The
  recovery is to re-initialize the memory and file system. Famfs is
  memory, not storage...

- Because famfs uses backing (devdax) devices, only privileged mounts are
  supported (i.e. the fuse server requires CAP_SYS_RAWIO).

- The famfs kernel code never accesses the memory directly - it only
  facilitates read, write and mmap on behalf of user processes, using
  fmap metadata provided by its privileged fuse server. As such, the
  RAS of the shared memory affects applications, but not the kernel.

- Famfs has backing device(s), but they are devdax (char) rather than
  block. Right now there is no way to tell the vfs layer that famfs has a
  char backing device (unless we say it's block, but it's not). Currently
  we use the standard anonymous fuse fs_type - but I'm not sure that's
  ultimately optimal (thoughts?)


Changes v2 [7] -> v3
- Dax: Completely new fsdev driver (drivers/dax/fsdev.c) replaces the
  dev_dax_iomap modifications to bus.c/device.c. Devdax devices can now
  be switched among 'devdax', 'famfs' and 'system-ram' modes via daxctl
  or sysfs.
- Dax: fsdev uses MEMORY_DEVICE_FS_DAX type and leaves folios at order-0
  (no vmemmap_shift), allowing fs-dax to manage folio lifecycles
  dynamically like pmem does.
- Dax: The "poisoned page" problem is properly fixed via
  fsdev_clear_folio_state(), which clears stale mapping/compound state
  when fsdev binds. The temporary WARN_ON_ONCE workaround in fs/dax.c
  has been removed.
- Dax: Added dax_set_ops() so fsdev can set dax_operations at bind time
  (and clear them on unbind), since the dax_device is created before we
  know which driver will bind.
- Dax: Added custom bind/unbind sysfs handlers; unbind return -EBUSY if a
  filesystem holds the device, preventing unbind while famfs is mounted.
- Fuse: Famfs mounts now require that the fuse server/daemon has
  CAP_SYS_RAWIO because they expose raw memory devices.
- Fuse: Added DAX address_space_operations with noop_dirty_folio since
  famfs is memory-backed with no writeback required.
- Rebased to latest kernels, fully compatible with Alistair Popple
  et. al's recent dax refactoring.
- Ran this series through Chris Mason's code review AI prompts to check
  for issues - several subtle problems found and fixed.
- Dropped RFC status - this version is intended to be mergeable.

Changes v1 [8] -> v2:

- The GET_FMAP message/response has been moved from LOOKUP to OPEN, as
  was the pretty much unanimous consensus.
- Made the response payload to GET_FMAP variable sized (patch 12)
- Dodgy kerneldoc comments cleaned up or removed.
- Fixed memory leak of fc->shadow in patch 11 (thanks Joanne)
- Dropped many pr_debug and pr_notice calls


References

[0] - https://github.com/jagalactic/linux/tree/famfs-v3 (this patch set)
[1] - https://famfs.org (famfs user space)
[2] - https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[3] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
[4] - https://lwn.net/Articles/983105/ (lsfmm 2024)
[5] - https://lwn.net/Articles/1020170/ (lsfmm 2025)
[6] - https://lore.kernel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com/
[7] - https://lore.kernel.org/linux-fsdevel/20250703185032.46568-1-john@groves.net/ (famfs fuse v2)
[8] - https://lore.kernel.org/linux-fsdevel/20250421013346.32530-1-john@groves.net/ (famfs fuse v1)



John Groves (21):
  dax: move dax_pgoff_to_phys from [drivers/dax/] device.c to bus.c
  dax: add fsdev.c driver for fs-dax on character dax
  dax: Save the kva from memremap
  dax: Add dax_operations for use by fs-dax on fsdev dax
  dax: Add dax_set_ops() for setting dax_operations at bind time
  dax: Add fs_dax_get() func to prepare dax for fs-dax usage
  dax: prevent driver unbind while filesystem holds device
  dax: export dax_dev_get()
  famfs_fuse: magic.h: Add famfs magic numbers
  famfs_fuse: Kconfig
  famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
  famfs_fuse: Basic fuse kernel ABI enablement for famfs
  famfs_fuse: Famfs mount opt: -o shadow=<shadowpath>
  famfs_fuse: Plumb the GET_FMAP message/response
  famfs_fuse: Create files with famfs fmaps
  famfs_fuse: GET_DAXDEV message and daxdev_table
  famfs_fuse: Plumb dax iomap and fuse read/write/mmap
  famfs_fuse: Add holder_operations for dax notify_failure()
  famfs_fuse: Add DAX address_space_operations with noop_dirty_folio
  famfs_fuse: Add famfs fmap metadata documentation
  famfs_fuse: Add documentation

 Documentation/filesystems/famfs.rst |  142 ++++
 Documentation/filesystems/index.rst |    1 +
 MAINTAINERS                         |   18 +
 drivers/dax/Kconfig                 |   17 +
 drivers/dax/Makefile                |    2 +
 drivers/dax/bus.c                   |   86 +-
 drivers/dax/bus.h                   |    3 +
 drivers/dax/dax-private.h           |    5 +
 drivers/dax/device.c                |   23 -
 drivers/dax/fsdev.c                 |  369 ++++++++
 drivers/dax/super.c                 |   95 ++-
 fs/fuse/Kconfig                     |   14 +
 fs/fuse/Makefile                    |    1 +
 fs/fuse/dir.c                       |    2 +-
 fs/fuse/famfs.c                     | 1221 +++++++++++++++++++++++++++
 fs/fuse/famfs_kfmap.h               |  167 ++++
 fs/fuse/file.c                      |   45 +-
 fs/fuse/fuse_i.h                    |  126 ++-
 fs/fuse/inode.c                     |   59 +-
 fs/fuse/iomode.c                    |    2 +-
 fs/namei.c                          |    1 +
 include/linux/dax.h                 |    7 +
 include/uapi/linux/fuse.h           |   88 ++
 include/uapi/linux/magic.h          |    2 +
 24 files changed, 2454 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/filesystems/famfs.rst
 create mode 100644 drivers/dax/fsdev.c
 create mode 100644 fs/fuse/famfs.c
 create mode 100644 fs/fuse/famfs_kfmap.h


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.49.0

