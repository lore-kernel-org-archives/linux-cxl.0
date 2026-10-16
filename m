Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450684AF691
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163848; cv=none; b=KrfscMsMf+8OMWqw3umBOfGO9Ywixy8q2a/w4h7Ijw0+8oQvEjA0hsNh5fkkeHV3NQxBUD6J3EVB3E8WvX0AXD3IJN2/RUijo5qzUpqTj4w9YEG/dyWBcw1hH2mymyVsBeigYkaQ+yEYA9FpbglZRubDyCYrVNnKAJoKSJI8jbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163848; c=relaxed/simple;
	bh=YxnZvwd57GKZBvpC2GbbHw9D3LkU97A3oVoH0EYOGNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=aQYBwhMM540obswL2ZEWhuKjT2U+JHb9lHq91xQjtivySsSvRmC1OU6DN9NVPOozlI6m48S1dxkzIZuwKrU83Blf7EnYWbnubSz4MALFW0vJspYLWginwibjDg2OOIkEhhPjgArxSF3/SrDBJYsgDGOpyPaiFFnWEF7nkNaBxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2sKAyuO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2sKAyuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8E4HluxTqTz4GH5KzcjRySdZqvF11U4sB58FTslbo0s=;
	b=N2sKAyuOsIVsPhuk5X/Ak1wdfDPSgGdddRE68j2erzYL5cLBAZyph6kI735iqKICx4pJHL
	Ly2ocGIo3/9nh6u0lvSo0rRvdwh04MwO3iKV3JegfJcV3v3RAVIrBgdx77QwlEQZw13R/Q
	GiPiPmtuU5vaLe3IMsHEP5vldP3XGYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Zo9FfsrvO9G9ZqDi29eVXQ-1; Fri, 16 Oct 2026 15:17:21 +0000
X-MC-Unique: Zo9FfsrvO9G9ZqDi29eVXQ-1
X-Mimecast-MFC-AGG-ID: Zo9FfsrvO9G9ZqDi29eVXQ_1792163840
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0761224e1so810375e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163840; x=1792768640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8E4HluxTqTz4GH5KzcjRySdZqvF11U4sB58FTslbo0s=;
        b=AO7ppC6WIa25IJBpNkeTdXDk4hPeKBaIWFK5YIVTYBQdKVblqLW+mi95D8O3Kpwd/V
         f+rxEoeATJrDStSieX3wd3kmlWsBXtC5i+FauO3Re4ycMiTKzxTuoiGlHeBzrpHCC4Z8
         yRyxD9cIC58O9DAGoMMFeJ6QFsfiolQ7twdGcAlPMZTK0R2198UansH0WdfVqNDE5edH
         aLPFEPL6j2VAcIAapd9jtfu17kWa66Ru+sjQkOwKAPaV0oZETti8rtmyoI3AEAP8HQFS
         +wKq9qiM7I0x4GcCMY7mde5S0G8ModqprHYocBInMkRX1GiYozwaoom6cx1zQXbuQq6A
         gMyw==
X-Forwarded-Encrypted: i=1; AKwUvBw6rajo998lUMLxsXPrCciZweplvFJQ/6pXEBAdPANqrlvLm1U35gLO2SWaDZ2AYqDDq4C7FrGhnzc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTFPCKTOK18VBfpeL3ejwBz1mAqF8d1BbzxPNaxOVsPCNsDcf9
	cTvvF/BzDo0Kp7UYCVOwJnIrIYFZ0nzc9OPNze6bRup+pJBq9v6rdFO92146dUc5cy391YLCpku
	9/DZ86F57L5ZWVMrvLPE+/+cfpgCMw1xNlhopyvPXCvnLOr/TQz/8GrxFShWh9Q==
X-Gm-Gg: AYBFou3WcV0v/S6FR0m6Glh2bp8crue8bs0Amd2PEP7wVtSN3ZAQ9QmcIC8ub1sL+9z
	kZwbl+mBq/jd4/fioXnWWPYJR9euiEFqZeLBInX1xZ/uj282rDzBtfJAj16QKFRcUyPpfT6EKo5
	+PLY9qY8Zm7JMdZiwijrIZi66b97NMgwtasF8jtvQbCfNmgku78jVWfyuwkyofnSQNuhcqrb+up
	S2ih+yO2daDfmv3VfVu0E2zNy37gf+sft/bFMZaTuEDUiMq97ndsrhKzLMYvDJayOJoiMK2XN/Y
	prIlidlC6WIaJNM7osX4CsB90SP6YQSg+7qrLBAWuJnS34alXZ5VjdmXT5byEmOrIhj94CgUEIt
	o0P252QXU9NfHw20D/RTbaw==
X-Received: by 2002:a05:600c:4fc8:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1d75acc6amr3391315e9.2.1792163840516;
        Fri, 16 Oct 2026 08:17:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc8:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1d75acc6amr3390515e9.2.1792163840004;
        Fri, 16 Oct 2026 08:17:20 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:19 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 00/10] fuse: DAX device based extent maps (famfs)
Date: Fri, 16 Oct 2026 17:16:27 +0200
Message-ID: <20261016151638.2962413-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OpelbWoGTsChD9d0n1qEPQguHjW_b0HFfZrfK4qlxlM_1792163840
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is the FUSIfication of the famfs-fuse patchset.

 - extent maps are assigned to a backing ID

 - 64 bit backing ID's managed by server

 - maps can be linear or cyclic (striped)

 - API supports nesting, but not implemented yet (i.e. multiple striped
   extents per inode, a-la famfs)

libfuse/famfs trees for testing:

 https://github.com/szmi/libfuse.git#extent-map-v3
 https://github.com/jagalactic/famfs.git#master

This patchset:

 git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Passes famfs smoke test on emulated dax device.

Comments are welcome.

Thanks,
Miklos

---
Changes since v4:

 - extent array (John)
 - error out on truncate/hole punch on a dax backed file (Sashiko)
 - small fix (Sashiko)

Changes since v3:

 - redid the first patch (prompted by sashiko: passing dev_t is racy)
 - more fixes (John, Amir Sashiko)

Changes since v2:

 - add a trivial prep patch modifying drivers/dax/super.c
 - reserve zero value for 64 bit backing ID (Amir)
 - add Originally-by: tag to acknowledge John's work
 - more fixes and cleanups (Amir, Sashiko)

Changes since v1:

 - moved 3 prep patches to fuse.git#for-next
 - introduce FUSE_PASSTHROUGH_V2 (Amir)
 - lots of small fixes and cleanups (Amir, Sashiko)

---
John Groves (2):
  dax: add fsdev_dax_from_file()
  fuse: resolve extent maps in O(1) when possible

Miklos Szeredi (8):
  dax: use READ_ONCE() in dax_holder()
  fuse: add helpers for EIO return value with kernel message
  fuse: support 64 bit, server allocated backing ID
  fuse: support opening 64 bit backing ID
  fuse: add support for opening dax device as backing
  fuse: add extent map data structure
  fuse: add extent map I/O support
  fuse: add support for striped backing

 drivers/dax/fsdev.c       |  23 +++
 drivers/dax/super.c       |   5 +-
 fs/file.c                 |   1 +
 fs/fuse/Makefile          |   2 +-
 fs/fuse/backing.c         | 302 ++++++++++++++++++++++++------
 fs/fuse/dev.c             |  54 ++++--
 fs/fuse/dev.h             |   3 +
 fs/fuse/dir.c             |   6 +-
 fs/fuse/ext_map.c         | 376 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            |  33 +++-
 fs/fuse/fuse_i.h          |  79 +++++++-
 fs/fuse/inode.c           |  25 ++-
 fs/fuse/iomode.c          | 116 ++++++------
 fs/fuse/notify.c          |  75 ++++++++
 fs/fuse/passthrough.c     |  66 +++----
 include/linux/dax.h       |   3 +-
 include/uapi/linux/fuse.h |  53 +++++-
 17 files changed, 1044 insertions(+), 178 deletions(-)
 create mode 100644 fs/fuse/ext_map.c

-- 
2.54.0

