Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29B370AFD
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309686; cv=none; b=Cy9zzyx6muluNIuEScOFT9a3p5p5ZHHRJKfRsqdc0EcWFiLyr4aUNVqU9MjtfoLwP7WhVJ+T0hPfSNl9NZq+CO/gOdt9Pt6ukpJwA1fed4SLPnrw9Ht6xuQCGUCuAibu1b+T6dDR7mtiFzRawdQaM7XHVb/yMkZcLwYdQYaWCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309686; c=relaxed/simple;
	bh=khjQoA76ImVEwNZsVeK3BoShKiZnAqrp47XzOo+pGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=uLJLPnemy3BH2Kxzpm90t0ry2/Rgph4NZgUspYWsilNzvomro6aA1R4n1DwCq3p65xA3Yf57qiiQrO4YsFY/Wjy+VqRxq0/Lzqft8VrMjEcGKI+9zHOqi2gAru+fOU0cL1KFtFnoHld/R1ZC2abo1lFFEHZOK56vg1MQWwc3AEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGk3QdKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGk3QdKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791309684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MTZcSt4JfCHhin1MairClvPsblFEaazbyiSbWW2Ywg=;
	b=CGk3QdKzcSp01DZ/00rj4TgRV+m8vyAUjxRX1Y9vekJXnjzB7Cza3GkMcIWZaVX5Y28vBw
	WnwBgil4suGLllPS/rwLTvEK2UWom6vdiDXyzkj5Cg3JtCuCnhoYf5QlvW3h46pKuOsymr
	ZJ3BnaYhcoa/Zh79GzDRfADhBFu6b+M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-EVGNBov3Oiy_ak377O-PrQ-1; Tue, 06 Oct 2026 14:01:21 -0400
X-MC-Unique: EVGNBov3Oiy_ak377O-PrQ-1
X-Mimecast-MFC-AGG-ID: EVGNBov3Oiy_ak377O-PrQ_1791309680
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso3133933a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309680; x=1791914480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MTZcSt4JfCHhin1MairClvPsblFEaazbyiSbWW2Ywg=;
        b=RZPgrf4d2uP1vg2oPSt+aQmwt05BzLyD96iVCiqh1JdNaHY8jy4fTqpNUJENJwdQjd
         Rrq5AGVDLvTYqiRzsv05fL2vGd71sRIbVtN4KUIRWPfMc7XsgwWnEnpVxbhhxwdlO2Wx
         Rqj0dTUd6N1FBjCaaHIgL849qOgpmJ6XSm517Tw4XyWMuqfJcf3WyHyL/JHrXVILM4E0
         C0oVhMVaitYQVmFVoRcJW9raQJ6hQ51T/5qMEG8ydid+7AUkj0x+BI3Gp6cgblwDu8tn
         HVnKRrMOjrd6elg/vO3yBRDTM0FLUgTarF1S4N9d7ahgWYEyypo3hm+wXjMiXI9bNK6+
         lvJg==
X-Forwarded-Encrypted: i=1; AKwUvBwUjW4dcsrPZMUkBnxIoKvsIu50dKnu0gkuXMIm3N290zm/Q8yA7qgbmV3nvWisRKHrTzlNSHYJnsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBQ8MTAwoFc3y2fHfoo1FVuvGcLaF/ES1auiSJeZDiGN3PqfEI
	oS/8GuvPKcYl21LNTRwaS7muLHqDG5WMo01xfhm+cW8rkf5szmyD3aW5Tk/L1bWcBY+l5eVW+iM
	VGwqvCcHiCXMAhZcUkXntD0+v1bvCzGO0okQLv6+cjyiMjLdz7/x/NFKMisc6lA==
X-Gm-Gg: AYBFou0rYfd0MZtlmrE0U/dg0FOGzXfErdUdpXZdMz2U2GuGwnJJ4Gy8H0i3ObSLg/k
	kNvpXrMezPK0jbFcmCkpQX0LAqepp9SrL91F58ZGC/PQyYMo9wS8NlraLjQEfHIZYqWwMDafoxz
	42IXYLCX5YNxII8yma6tIGIjITf2dfjoUo37d4AjTSYjkMq3cuHzhIw6d2NsrPHk9K2hM+HKeTC
	j+quXVDI2iastUK6yoDbs1kj2lik7TTFJkteFJsSP6K2sTIxf2mXmBQG6qfpavBUZs5yTcVLS03
	j2zk43Mh9t9m8FLnmxEOQnBzzUExtVRBOl2jFV5h7i2RbzenSlH4kRJuOolWolm6oTEsMewZ/mQ
	XRMXkf/gXmZmdv6stDabJuBfRA9C9HifRiRd8bpnnN8/XP3a5PkZLaLd1
X-Received: by 2002:a05:6402:13ce:b0:6aa:f7f4:24b3 with SMTP id 4fb4d7f45d1cf-6afe29de45cmr2370952a12.35.1791309680437;
        Tue, 06 Oct 2026 11:01:20 -0700 (PDT)
X-Received: by 2002:a05:6402:13ce:b0:6aa:f7f4:24b3 with SMTP id 4fb4d7f45d1cf-6afe29de45cmr2370926a12.35.1791309680029;
        Tue, 06 Oct 2026 11:01:20 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5942sm5056684a12.9.2026.10.06.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:01:17 -0700 (PDT)
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
Subject: [PATCH v3 0/9] fuse: DAX device based extent maps (famfs)
Date: Tue,  6 Oct 2026 20:01:05 +0200
Message-ID: <20261006180115.1425232-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: neTF4Q4Z1nKdTDxtE2UGmG__KV4C9PJCBwvMl8DiwfI_1791309680
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
 https://github.com/szmi/famfs.git#extent-map-v3

This patchset:

 git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#extent-map-v3

Passes famfs smoke test on emulated dax device.

Comments are welcome.

Thanks,
Miklos

---
Changes since v2:

 - add a trivial prep patch modifying drivers/dax/super.c
 - reserve zero value for 64 bit backing ID (Amir)
 - add Originally-by: tag to acknowledge John's work 
 - more fixes and cleanups (Amir, Sashiko)

Changes since v1:

 - moved 3 prep patches to fuse.git#for-next
 - introduce FUSE_PASSTHROUGH_V2 (Amir)
 - lots of small fixes and cleanups (Amir, Sashiko)


John Groves (1):
  dax: replace exported dax_dev_get() with non-allocating dax_dev_find()

Miklos Szeredi (8):
  dax: use READ_ONCE() in dax_holder()
  fuse: add helpers for EIO return value with kernel message
  fuse: support 64 bit, server allocated backing ID
  fuse: support opening 64 bit backing ID
  fuse: add support for opening dax device as backing
  fuse: add extent map data structure
  fuse: add extent map I/O support
  fuse: add support for striped backing

 drivers/dax/super.c       |  40 ++++-
 fs/fuse/Makefile          |   2 +-
 fs/fuse/backing.c         | 305 +++++++++++++++++++++++++++++-------
 fs/fuse/dev.c             |  24 +++
 fs/fuse/dev.h             |   3 +
 fs/fuse/dir.c             |   3 +-
 fs/fuse/ext_map.c         | 316 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            |  18 ++-
 fs/fuse/fuse_i.h          |  78 ++++++++--
 fs/fuse/inode.c           |  26 +++-
 fs/fuse/iomode.c          | 116 ++++++++------
 fs/fuse/notify.c          |  75 +++++++++
 fs/fuse/passthrough.c     |  63 ++++----
 include/linux/dax.h       |   6 +-
 include/uapi/linux/fuse.h |  53 ++++++-
 15 files changed, 965 insertions(+), 163 deletions(-)
 create mode 100644 fs/fuse/ext_map.c

-- 
2.54.0

