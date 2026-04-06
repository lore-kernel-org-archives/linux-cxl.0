Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCC39183A
	for <linux-cxl@vger.kernel.org>; Mon,  6 Apr 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497442; cv=pass; b=U2mU8mjmTTbafB4VcVvGWwoc/3weNTAa4wr9uXCUepxTcdFuvFvIX6DTYfI4GPDTnQoUwh1vKBA7UsV232y7CX3yd+HAt83TCNmVd/Bsols3iuLKSeKoQF4ciA/XT6kg335ED0oqWnbM54oDIG9bAJf9yx4+f8y6VmdI6wskfkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497442; c=relaxed/simple;
	bh=kN1xAofSCbngG4JEtiS0d2Gc6L4Z2HhrugyIqu8L330=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UthRf2gJpinREFbl/SmZ2pJ2xAwQNqsd1uo+904oscbnFCoNBExYJ38YmBQ2kZddBnCB5uuwWPmzuQ3mdvks97v2kzZAaJXZ9+QBZZ1Qvuysz4UE5kdTHrvFfDIDi33erHcBwZ3nXXu+M/BFUKc14EarWicX+BvVrD2N6ov6STY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snQ/sEF2; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snQ/sEF2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso54764125e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 06 Apr 2026 10:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775497438; cv=none;
        d=google.com; s=arc-20240605;
        b=J86+Bk6cARMCJ0Jm4UMTtpoR2cWr8kNQlcS8ogKF2W9uvOfGtzIzXfoklrBO8JK+w9
         OTk/oKaRbHOnKhY64lzGVJ+7LYEJoRJPsBtLj1RtgnbAnzjYnKRTxR4sMAPDpnuW/60N
         pxwfD+tQCKNr7OVno12ODJq2sckWjMbxi4t405kYuMVXAzIU/ZooYmOS0OPdWi4FQFif
         paAL9z7FC4n475Br56wDPyaX7lWwFZRM1WSolOgJEnuM1GWxE25uxXG99bRTFhDjP7Je
         vA9lwx2xdQYw+YwVhr1hRncXVDWGQY7XRZhZ5b7EVHx4rVCRGO8A8sNX3hClUbEqPfU4
         DpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E+H74yZNuF8Y0s9XUC3IymykIRckIxSh5bSqC9voFeo=;
        fh=S6/HKsVZIypj8Yl7x4pYgz28vid9vIvQT6V+kCk78ys=;
        b=Mrt/ZLGhc4xhxFIMy+S0IDhwUe7AiBUra0Dbq5Mk9BEP4k3FLE/zHrfNL2ikD2BvPi
         Na24vjgmpcc2Sww/2aHLA34AXgZLm0Le4+IEpKGAJ3WxxXuunuppA2bPE3/tx6GnKw66
         e7+vIx+rlNyb9x0PCEOAkeWamVq9yZPgQcE2KCx6xHDsWyuqj95Q3zfXPzKML73E/nzw
         AC7mVQnZ9x+luSCmO6DX+PJrNgw/U7aPPXN5zW4gLnBW1UZQRWcKO8G73JXPHWyXBcxw
         3nJHOq/AZb+irSSEgGK6Oa4BromZ7YOystAu/3t+Y1Fqdzuj2XW2DZhnCkyaZJgb5thg
         Kd4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775497438; x=1776102238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+H74yZNuF8Y0s9XUC3IymykIRckIxSh5bSqC9voFeo=;
        b=snQ/sEF2LHb0EDWJoQIT4WgOLi/faKTfx1uZz+vcdqS4WfaGWOner430ldL3wkvtjl
         2sEgoxjGXw8UWLlC2umz4T70qzxkgXwTVd1ja31vpHJNtOPROBD2qJ5WpHHlB5JPpAg0
         okjTiUkz/PVjIJVdKJkzEeW1vMCKWU3IUEvX/TzBvgGtSg4u7KBn8wdQN8Lh2/+UGQIM
         jTYHjHjd0NeFpF3RqRUovXKtlimBcjUp9Yvk0wct/Ff2JG9HJivp2Y+zroUrlpv7Wemb
         SVSKJkQnn59/Bb5m2y9Ko0O0yGra/TI2LNufuzksRZkK9dmu6sVr4HA3sP5vuHJmd/Ux
         P7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775497438; x=1776102238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E+H74yZNuF8Y0s9XUC3IymykIRckIxSh5bSqC9voFeo=;
        b=SH4DbQV9aAxGl4Or7OeH1GyE9fDIJkoK0YDhQETWPamUicqHXfUoYmlQhWlm+HB63+
         XBQVKaIczznPCovz+DQoKiRNMtqGCzUn6Qs2RmnpPlwF9y07D4Ong3fZe3znbaWvtiuc
         WV3kz3B8/hC0I6o6Ho+vtODLI3a7yoCNy815mJQS0HOnHJa1HFox/vLGQf/16OAGS9jM
         J6bVNz107+8K8bsnVHrGzMuk3VYombUj9Goi9HjPGfpibrHDD4VU3VcvwrGHE8Hfcuhu
         NEeNe/F/uKRopxLTpIoSzzwaa6wxXDhSW2qilW77+ELmmQllSvps70GkrJ7auCpfobX6
         kL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKcY0CYVd5alUv49LMuFk2c2939uIf1QsuEZtVVzl/fieQS9oTgNLOziMmnZ8AbF6fZ8KS0GGvXOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0WSm+qJMBHnLD+FhEBwEeGZFCSKHDhy6eZTl8pquFJi9S9QZ
	2IN6+31hbv+xcve0kYjGDAl/FkdCcsKHNtZPrjY/dxntCT6+P5aPDBKwjebvUGKPWUQI9UUDGjX
	zyq8xaj6FlUO21GWfUvvPGS9/7swHnNs=
X-Gm-Gg: AeBDiesshj19Y7kgA8KfsZR3rALQvEAcmKxo7ifxqbMYWqD66nhYtciuKKdt9JDWUeL
	1EIFiYrCb/ZaGa2uDX3jnrfQxnpHXWHEMUaZdDsrOpVLLPAr5DYVnMClMB9EFTWdOVeXCyTyhda
	cj7Pe83aKw0PCCqCBNC+m20qIsfhH/DQzoes9txoZslRsE2s88v5D8YUqETnkD5ago+bnO9BjoM
	cc2lkJ6Qky+zkHUpZf+aSXeqyIHmeBydJo/nqAbxNSufbcM5KJmitvLZhplt52FVrGqdDjIwZnE
	AtU6Uw==
X-Received: by 2002:a7b:c386:0:b0:488:a9c3:44a3 with SMTP id
 5b1f17b1804b1-488a9c34679mr73518215e9.2.1775497437387; Mon, 06 Apr 2026
 10:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
In-Reply-To: <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Apr 2026 10:43:45 -0700
X-Gm-Features: AQROBzC6Xk9KyqnD1Txff3iqNtHENscY_BmN07M5XTh2dbYHWP5Uwt1B85UeMJ4
Message-ID: <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 5:37=E2=80=AFAM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <john@groves.net>
>
> NOTE: this series depends on the famfs dax series in Ira's for-7.1/dax-fa=
mfs
> branch [0]
>
> Changes v9 -> v10
> - Rebased to Ira's for-7.1/dax-famfs branch [0], which contains the requi=
red
>   dax patches
> - Add parentheses to FUSE_IS_VIRTIO_DAX() macro, in case something bad is
>   passed in as fuse_inode (thanks Jonathan's AI)
>
> Description:
>
> This patch series introduces famfs into the fuse file system framework.
> Famfs depends on the bundled dax patch set.
>
> The famfs user space code can be found at [1].
>
> Fuse Overview:
>
> Famfs started as a standalone file system, but this series is intended to
> permanently supersede that implementation. At a high level, famfs adds
> two new fuse server messages:
>
> GET_FMAP   - Retrieves a famfs fmap (the file-to-dax map for a famfs
>              file)
> GET_DAXDEV - Retrieves the details of a particular daxdev that was
>              referenced by an fmap
>
> Famfs Overview
>
> Famfs exposes shared memory as a file system. Famfs consumes shared
> memory from dax devices, and provides memory-mappable files that map
> directly to the memory - no page cache involvement. Famfs differs from
> conventional file systems in fs-dax mode, in that it handles in-memory
> metadata in a sharable way (which begins with never caching dirty shared
> metadata).
>
> Famfs started as a standalone file system [2,3], but the consensus at
> LSFMM was that it should be ported into fuse [4,5].
>
> The key performance requirement is that famfs must resolve mapping faults
> without upcalls. This is achieved by fully caching the file-to-devdax
> metadata for all active files. This is done via two fuse client/server
> message/response pairs: GET_FMAP and GET_DAXDEV.
>
> Famfs remains the first fs-dax file system that is backed by devdax
> rather than pmem in fs-dax mode (hence the need for the new dax mode).
>
> Notes
>
> - When a file is opened in a famfs mount, the OPEN is followed by a
>   GET_FMAP message and response. The "fmap" is the full file-to-dax
>   mapping, allowing the fuse/famfs kernel code to handle
>   read/write/fault without any upcalls.
>
> - After each GET_FMAP, the fmap is checked for extents that reference
>   previously-unknown daxdevs. Each such occurrence is handled with a
>   GET_DAXDEV message and response.
>
> - Daxdevs are stored in a table (which might become an xarray at some
>   point). When entries are added to the table, we acquire exclusive
>   access to the daxdev via the fs_dax_get() call (modeled after how
>   fs-dax handles this with pmem devices). Famfs provides
>   holder_operations to devdax, providing a notification path in the
>   event of memory errors or forced reconfiguration.
>
> - If devdax notifies famfs of memory errors on a dax device, famfs
>   currently blocks all subsequent accesses to data on that device. The
>   recovery is to re-initialize the memory and file system. Famfs is
>   memory, not storage...
>
> - Because famfs uses backing (devdax) devices, only privileged mounts are
>   supported (i.e. the fuse server requires CAP_SYS_RAWIO).
>
> - The famfs kernel code never accesses the memory directly - it only
>   facilitates read, write and mmap on behalf of user processes, using
>   fmap metadata provided by its privileged fuse server. As such, the
>   RAS of the shared memory affects applications, but not the kernel.
>
> - Famfs has backing device(s), but they are devdax (char) rather than
>   block. Right now there is no way to tell the vfs layer that famfs has a
>   char backing device (unless we say it's block, but it's not). Currently
>   we use the standard anonymous fuse fs_type - but I'm not sure that's
>   ultimately optimal (thoughts?)
>
> Changes v8 -> v9
> - Kconfig: fs/fuse/Kconfig:CONFIG_FUSE_FAMFS_DAX now depends on the
>   new CONFIG_DEV_DAX_FSDEV (from drivers/dax/Kconfig) rather than
>   just CONFIG_DEV_DAX and CONFIG_FS_DAX. (CONFIG_FUSE_FAMFS_DAX
>   depends on those...)
>
> Changes v7 -> v8
> - Moved to inline __free declaration in fuse_get_fmap() and
>   famfs_fuse_meta_alloc(), famfs_teardown()
> - Adopted FIELD_PREP() macro rather than manual bitfield manipulation
> - Minor doc edits
> - I dropped adding magic numbers to include/uapi/linux/magic.h. That
>   can be done later if appropriate
>
> Changes v6 -> v7
> - Fixed a regression in famfs_interleave_fileofs_to_daxofs() that
>   was reported by Intel's kernel test robot
> - Added a check in __fsdev_dax_direct_access() for negative return
>   from pgoff_to_phys(), which would indicate an out-of-range offset
> - Fixed a bug in __famfs_meta_free(), where not all interleaved
>   extents were freed
> - Added chunksize alignment checks in famfs_fuse_meta_alloc() and
>   famfs_interleave_fileofs_to_daxofs() as interleaved chunks must
>   be PTE or PMD aligned
> - Simplified famfs_file_init_dax() a bit
> - Re-ran CM's kernel code review prompts on the entire series and
>   fixed several minor issues
>
> Changes v4 -> v5 -> v6
> - None. Re-sending due to technical difficulties
>
> Changes v3 [9] -> v4
> - The patch "dax: prevent driver unbind while filesystem holds device"
>   has been dropped. Dan Williams indicated that the favored behavior is
>   for a file system to stop working if an underlying driver is unbound,
>   rather than preventing the unbind.
> - The patch "famfs_fuse: Famfs mount opt: -o shadow=3D<shadowpath>" has
>   been dropped. Found a way for the famfs user space to do without the
>   -o opt (via getxattr).
> - Squashed the fs/fuse/Kconfig patch into the first subsequent patch
>   that needed the change
>   ("famfs_fuse: Basic fuse kernel ABI enablement for famfs")
> - Many review comments addressed.
> - Addressed minor kerneldoc infractions reported by test robot.
>
> Changes v2 [7] -> v3
> - Dax: Completely new fsdev driver (drivers/dax/fsdev.c) replaces the
>   dev_dax_iomap modifications to bus.c/device.c. Devdax devices can now
>   be switched among 'devdax', 'famfs' and 'system-ram' modes via daxctl
>   or sysfs.
> - Dax: fsdev uses MEMORY_DEVICE_FS_DAX type and leaves folios at order-0
>   (no vmemmap_shift), allowing fs-dax to manage folio lifecycles
>   dynamically like pmem does.
> - Dax: The "poisoned page" problem is properly fixed via
>   fsdev_clear_folio_state(), which clears stale mapping/compound state
>   when fsdev binds. The temporary WARN_ON_ONCE workaround in fs/dax.c
>   has been removed.
> - Dax: Added dax_set_ops() so fsdev can set dax_operations at bind time
>   (and clear them on unbind), since the dax_device is created before we
>   know which driver will bind.
> - Dax: Added custom bind/unbind sysfs handlers; unbind return -EBUSY if a
>   filesystem holds the device, preventing unbind while famfs is mounted.
> - Fuse: Famfs mounts now require that the fuse server/daemon has
>   CAP_SYS_RAWIO because they expose raw memory devices.
> - Fuse: Added DAX address_space_operations with noop_dirty_folio since
>   famfs is memory-backed with no writeback required.
> - Rebased to latest kernels, fully compatible with Alistair Popple
>   et. al's recent dax refactoring.
> - Ran this series through Chris Mason's code review AI prompts to check
>   for issues - several subtle problems found and fixed.
> - Dropped RFC status - this version is intended to be mergeable.
>
> Changes v1 [8] -> v2:
>
> - The GET_FMAP message/response has been moved from LOOKUP to OPEN, as
>   was the pretty much unanimous consensus.
> - Made the response payload to GET_FMAP variable sized (patch 12)
> - Dodgy kerneldoc comments cleaned up or removed.
> - Fixed memory leak of fc->shadow in patch 11 (thanks Joanne)
> - Dropped many pr_debug and pr_notice calls
>
>
> References
>
> [0] - https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/
> [1] - https://famfs.org (famfs user space)
> [2] - https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.=
net/
> [3] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.=
net/
> [4] - https://lwn.net/Articles/983105/ (lsfmm 2024)
> [5] - https://lwn.net/Articles/1020170/ (lsfmm 2025)
> [6] - https://lore.kernel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4=
d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com/
> [7] - https://lore.kernel.org/linux-fsdevel/20250703185032.46568-1-john@g=
roves.net/ (famfs fuse v2)
> [8] - https://lore.kernel.org/linux-fsdevel/20250421013346.32530-1-john@g=
roves.net/ (famfs fuse v1)
> [9] - https://lore.kernel.org/linux-fsdevel/20260107153244.64703-1-john@g=
roves.net/T/#mb2c868801be16eca82dab239a1d201628534aea7 (famfs fuse v3)
>
>
> John Groves (10):
>   famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
>   famfs_fuse: Basic fuse kernel ABI enablement for famfs
>   famfs_fuse: Plumb the GET_FMAP message/response
>   famfs_fuse: Create files with famfs fmaps
>   famfs_fuse: GET_DAXDEV message and daxdev_table
>   famfs_fuse: Plumb dax iomap and fuse read/write/mmap
>   famfs_fuse: Add holder_operations for dax notify_failure()
>   famfs_fuse: Add DAX address_space_operations with noop_dirty_folio
>   famfs_fuse: Add famfs fmap metadata documentation
>   famfs_fuse: Add documentation
>
>  Documentation/filesystems/famfs.rst |  142 ++++
>  Documentation/filesystems/index.rst |    1 +
>  MAINTAINERS                         |   10 +
>  fs/fuse/Kconfig                     |   13 +
>  fs/fuse/Makefile                    |    1 +
>  fs/fuse/dir.c                       |    2 +-
>  fs/fuse/famfs.c                     | 1180 +++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h               |  167 ++++
>  fs/fuse/file.c                      |   45 +-
>  fs/fuse/fuse_i.h                    |  116 ++-
>  fs/fuse/inode.c                     |   35 +-
>  fs/fuse/iomode.c                    |    2 +-
>  fs/namei.c                          |    1 +
>  include/uapi/linux/fuse.h           |   88 ++
>  14 files changed, 1790 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/filesystems/famfs.rst
>  create mode 100644 fs/fuse/famfs.c
>  create mode 100644 fs/fuse/famfs_kfmap.h
>
>
> base-commit: 2ae624d5a555d47a735fb3f4d850402859a4db77
> --
> 2.53.0
>

Hi John,

I=E2=80=99m curious to hear your thoughts on whether you think it makes sen=
se
for the famfs-specific logic in this series to be moved to a bpf
program that goes through a generic fuse iomap dax layer.

Based on [1], this gives feature-parity with the famfs logic in this
series. In my opinion, having famfs go through a generic fuse iomap
dax layer makes the fuse kernel code more extensible for future
servers that will also want to use dax iomap, and keeps the fuse code
cleaner by not having famfs-specific logic hardcoded in and having to
introduce new fuse uapis for something famfs-specific. In my
understanding of it, fuse is meant to be generic and it feels like
adding server-specific logic goes against that design philosophy and
sets a precedent for other servers wanting similar special-casing in
the future. I'd like to explore whether the bpf and generic fuse iomap
dax layer approach can preserve that philosophy while still giving
famfs the flexibility it needs.

I think moving the famfs logic to bpf benefits famfs as well:
- Instead of needing to issue a FUSE_GET_FMAP request after a file is
opened, the server can directly populate the metadata map from
userspace with the mapping info when it processes the FUSE_OPEN
request, which gets rid of the roundtrip cost
- The server can dynamically update the metadata / bpf maps during
runtime from userspace if any mapping info needs to change
- Future code changes / updates for famfs are all server-side and can
be deployed immediately instead of needing to go through the upstream
kernel mailing list process
- Famfs updates / new releases can ship independently of kernel releases

I'd appreciate the chance to discuss tradeoffs or if you'd rather
discuss this at the fuse BoF at lsf, that sounds great too.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX=
5uhUv=3DOSPyA=3DG5EE+Q@mail.gmail.com/

>
