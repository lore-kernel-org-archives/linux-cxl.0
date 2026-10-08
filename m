Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4571E2834
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458413; cv=none; b=AQ22wdAAOYAs1p722WaqbBUBhfEDMf73kdAXG8MicpGQD+nfRils4QhXWiuQdg0H990frIxO7O6lWQrcpYBdkz2CTZqvEe1PCucAYszDeoCqGFTkr5wpmNZxgmacQYWoNT8U4WJrzw/xe2j776BmHjZti6/pgDkTMv/NZ9vwjTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458413; c=relaxed/simple;
	bh=eKqk5TpASnodNyqjN7Xpdbgw/li/RvFAwZ7jMFr5HYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CCBhMAd920bRMeNCsdN+ElIW6lE9yxb6NZaLYtX9KlLmiurIJZLAxxBU/ZHFXN6DpNpPsi9Szv4Dl75bhCd5waPmVcFWDwfmG4AaqYt6o/G47w4mBpvtAdJbQTvpRTVDFhgqZgMvzf1X1h8Zf85+hEJ6RYwuYAeDqH1yYYJ2QxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aatzQVdB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aatzQVdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791458411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o5M+l3eYF5+1BrspbqKZlSFj3dX2QU6FqGOUNjFSg00=;
	b=aatzQVdB/vNcyCt5CVUbrAnLiNlOkTsCvlzQ+SO4LYwEfOvzr6tfWagvSwrwzMpoBrCdp6
	SfiyWeKr0DDbzpx0PIXkQaEJz5mgyCmVM0g3UPgj1mfcC5yxn3iO2g0ge6Dw7HdvGtM7Xw
	9QxaWVVhk24v8JDsUBZYTbuDRIllB60=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-HFbal4ujOFqICQ4y33JvKA-1; Thu, 08 Oct 2026 07:20:10 -0400
X-MC-Unique: HFbal4ujOFqICQ4y33JvKA-1
X-Mimecast-MFC-AGG-ID: HFbal4ujOFqICQ4y33JvKA_1791458409
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e6affec80so490087466b.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Oct 2026 04:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458409; x=1792063209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5M+l3eYF5+1BrspbqKZlSFj3dX2QU6FqGOUNjFSg00=;
        b=bDbq/GivjYet4OJ2JtYaHI5g25CE2fL1/cmKpuGBweUPq5rchJJLcjQt8hrZFMWTdK
         DfN5HfDEi7MkRlA79EkGp8ltXX1gNkd+a4qv4yQrmmYY8KtqmjRyioeJiuVdhsEuif+D
         VO5IOyfbKlfQkpjtj+PQqoJVnZFIabHGSv7ldKgWd4g3wcHvKNqG/HgDJwrNontt8qcE
         Sn1gqAUVgkrps7H/lPPRyAGeEvmk1jyDKyzkMRyw1pwDeYwxmbOU9w31p985StrqpJmW
         xJ/1pBJX/NNe/uGy7M0m8q4uZ0F0FXUBi0SSW3fwi6t2/hEuw1jjM4b18ITlVBDciWo9
         6ilQ==
X-Forwarded-Encrypted: i=1; AKwUvByMof7YszSJY2xq1SYSNifeEy4vN9y/4/XE15fjQzUyNDmi33ekWQwzetq+rgCrtls9u3wLSRAF60I=@vger.kernel.org
X-Gm-Message-State: AFuF++nSt6IC2RpqlhUKzGFEB3U+X5RFSQqqQyUAIgZKU+Q6tms+p2HS
	q769AlL2a8fVGPetpzQICVFXWebAtL3FXM4NWdX1lamMsdYuV3oxqe/jI51VYdRQNeXPD6i0Cwh
	ztu4gXupf7poLmqJ8kAGFTKN/TuOx/0Obu5CrkNC+jHSgwg8ZHJS5HyIBimF3Og==
X-Gm-Gg: AYBFou1+fpW3JBbuktDCSDAsKJel7/STs4lY4Ql0bzolUKTD5MQ7iONiEkKDH31Jm2k
	I6mDcUr83T/0/ia+X5JJDaWxsPA6rt69wT7T49PvSj4/e5dUD5+ROVSwErBXwN2LzNfospn3kiI
	1sU+TAl5bwI+irmptRfo7CZguitmpOsSLeoJay1qwf5CFyTK6fPOS0dYICs9iJp42A4UBd75mwC
	MGvKIdLNlPxEZ+ji43tYKXeRnLUnxy+ycF/abEQJJ+3eNY+RYO/hg0NBEpMgf+m3KEpeSv4OLhH
	7b8BZPif8Q2U3ssVvGCofugi79venObmzPrQ45kZ5bdhDMp5YKu1rl+hlMTztOvAeFBXs7g6aUz
	lGcTENSQ9eSKHTHUnMPKtqUKGs8V045o9hyDle09DbsMqvmMmdvh2WQZM
X-Received: by 2002:a17:906:c14c:b0:c2a:8d00:f8d0 with SMTP id a640c23a62f3a-c317bb373a6mr550091166b.4.1791458409321;
        Thu, 08 Oct 2026 04:20:09 -0700 (PDT)
X-Received: by 2002:a17:906:c14c:b0:c2a:8d00:f8d0 with SMTP id a640c23a62f3a-c317bb373a6mr550080066b.4.1791458407407;
        Thu, 08 Oct 2026 04:20:07 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2fae53sm204251866b.49.2026.10.08.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:20:06 -0700 (PDT)
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
Subject: [PATCH v4 0/9] fuse: DAX device based extent maps (famfs)
Date: Thu,  8 Oct 2026 13:19:51 +0200
Message-ID: <20261008112004.1899560-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tyono32duhBajl0D-7Rr4nIZdLWhoo34uIMfdUjiDHQ_1791458409
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

 git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#extent-map-v4

Passes famfs smoke test on emulated dax device.

Comments are welcome.

Thanks,
Miklos

---
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
John Groves (1):
  dax: add fsdev_dax_from_file()

Miklos Szeredi (8):
  dax: use READ_ONCE() in dax_holder()
  fuse: add helpers for EIO return value with kernel message
  fuse: support 64 bit, server allocated backing ID
  fuse: support opening 64 bit backing ID
  fuse: add support for opening dax device as backing
  fuse: add extent map data structure
  fuse: add extent map I/O support
  fuse: add support for striped backing

 drivers/dax/fsdev.c       |  24 +++
 drivers/dax/super.c       |   5 +-
 fs/file.c                 |   1 +
 fs/fuse/Makefile          |   2 +-
 fs/fuse/backing.c         | 303 +++++++++++++++++++++++++++++-------
 fs/fuse/dev.c             |  54 +++++--
 fs/fuse/dev.h             |   3 +
 fs/fuse/dir.c             |   3 +-
 fs/fuse/ext_map.c         | 319 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            |  25 ++-
 fs/fuse/fuse_i.h          |  75 +++++++--
 fs/fuse/inode.c           |  25 ++-
 fs/fuse/iomode.c          | 116 ++++++++------
 fs/fuse/notify.c          |  75 +++++++++
 fs/fuse/passthrough.c     |  63 ++++----
 include/linux/dax.h       |   3 +-
 include/uapi/linux/fuse.h |  53 ++++++-
 17 files changed, 971 insertions(+), 178 deletions(-)
 create mode 100644 fs/fuse/ext_map.c

-- 
2.54.0

