Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762E4A5C59
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867386; cv=none; b=bQTDYezxzOfapPJMiIZf84x0YwUnXukBYPS+nSupt7X19pqv8rMP1sJ3MssjUQEzguNlWppe8SUpNulXX0npUkvZ2EvEFXPvjGDLrKfG33ne7hYZl155UI8QglAifz+iCiEY1YpxjdjQ1orraUSxXyOjeJKnEh6v7ZR3K8ajHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867386; c=relaxed/simple;
	bh=9t1aAWmP4b4YG8k12sDVjav4RYFhEJqBqzzCt8PuK3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=acZxDdhaIB9d3OiMan6H36WHpUq/3QfO3Tf2btCYGSb78jIpHjePDvhSrXsm5W41e12nEbDoxmK0GXpfvh1QjOJevB3/abEcSMw9K3lfVEpT50CPVWfAHDE2FaKPEy7X2sOhvIrkK+WuXBJSXOoMgkJm2OSx3qWMizutZgVsMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UErQKMyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UErQKMyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790867384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qqtf/4r/JNjXdQHR8/rYcGVT30iqL+vSIact1bVLvZY=;
	b=UErQKMyXlz9WGHzWJRIXy2S+i9ZMJtLVbs86mQe7gGg2R8DutgfWYdRUW5f673xWtacROL
	JWmtBkgkQxUeMD4yxCdM/TfSb9BgUkxhXBVCq6PdokZuIZ0kssmgleYHzU1yuEXEpB3qHv
	Y6fWaaFCVvMDpm4vFPLanBn+sGKOf58=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-h8rTw8nvN7iLqyfhKwRi-Q-1; Thu, 01 Oct 2026 11:09:40 -0400
X-MC-Unique: h8rTw8nvN7iLqyfhKwRi-Q-1
X-Mimecast-MFC-AGG-ID: h8rTw8nvN7iLqyfhKwRi-Q_1790867379
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293a65b577so592819066b.2
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 08:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867379; x=1791472179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqtf/4r/JNjXdQHR8/rYcGVT30iqL+vSIact1bVLvZY=;
        b=NbXRlu8e9UBcb7DP+h2DjmirAokQfgenBaP5TPGTMIFJJItu9dlFckczgtm9N4e17m
         Wnu9pQAATE+KUxnH97zg7LKgW3bniczDReRMvEsJi3hMCI2oWmju4dWVTZK82L61+306
         lfpFBv87IVvjkRaN4kAlskaxEdAIIIlop8fOZKxY/h4DjS3RCASHqnQFQQFXDjPsv8fM
         Ls8l36C4ucsjIU1t1LqiWxN+pIeyKybBwuS3b363vRx3D/K32q3c8/iDXgOubxjcYndn
         +VOSfa10sWIcg0sYOKNYf7CixeB8so0ivK4bS23SEbQ5Li9JWcSuoHUXchtj4h9ngOv1
         fa/g==
X-Forwarded-Encrypted: i=1; AKwUvBzTGzA8dJ+lmeQl6Axzsi2PUM8i3RhlMeFP9EkkrxX59EgPhW2bjvC5yGDnysxs8tS98kW/ojHp9iA=@vger.kernel.org
X-Gm-Message-State: AFuF++nPhM6dlMcDeTUhezCZvhM0ZONO3pD/h3qRzCoc6KA9H5veXG+D
	f/ShJnRX+oDV1+eQ3XOtuHqiBI/CRAm9n43LQLLwAqQO8/WAncndmEFfvw4KAc8eDCHM3f8aTPV
	UJzCR5HFPJJf7kVxcdUl0fAlUrH9sF2tUCfBprhY/2KGw/NmoYSNF2zvSXfoXtA==
X-Gm-Gg: AYBFou1WFO+ZkZAVbVbxysAN+1XiQ4a1wG0UsjJakQImvahwtayRYLFhkKDWuAiMt/j
	sWQ9sDwU3+VvIImsPC8JRwIITXXYqwWlx001jVZpVQq8vchivviTxpk7Dm2iKoUZJMxNRCR2cHB
	3GnHcq79eHdBvT1Mk8RkOQV2dr0kzwr8QbKp3YymOen7virmOWyI82vCVNqmrzhU7U308j9GLfa
	Iq//rx9UJMxS0673r28pNC3kGcsP3glmJG2KL9melGKpVbtJwG8mdAOp/SAxn0rrlMWm4z4KBMZ
	QFhrmHaeeKlZlHIgyAUQFrLDcd2vBFOouGfXBvUqF4Yv9KyLbXGl74+MIMpVs2BwZM1ruBUEU9S
	COBNyXgvVl06KieV9LRGjKlpvdHfKe7EeiZCfWTItsJ1PIcEJLleDy7PBc4U=
X-Received: by 2002:a17:907:3e1a:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2e23cae407mr400304866b.11.1790867379359;
        Thu, 01 Oct 2026 08:09:39 -0700 (PDT)
X-Received: by 2002:a17:907:3e1a:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2e23cae407mr400302066b.11.1790867378822;
        Thu, 01 Oct 2026 08:09:38 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-188.pool.digikabel.hu. [193.226.245.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d86372sm177735166b.56.2026.10.01.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:09:36 -0700 (PDT)
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
Subject: [PATCH v2 0/8] fuse: DAX device based extent maps (famfs)
Date: Thu,  1 Oct 2026 17:07:18 +0200
Message-ID: <20261001150935.655979-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3E7_-I--pE_oK5Wo0rbpPf888bBNpV-HUND4rJVc3t8_1790867379
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

 https://github.com/szmi/libfuse.git#extent-map-v2
 https://github.com/szmi/famfs.git#extent-map-v2

This patchset:

 git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#extent-map-v2

Passes famfs smoke test on emulated dax device.

Comments are welcome.

Thanks,
Miklos

---
Changes since v1:

 - moved 3 prep patches to fuse.git#for-next
 - introduce FUSE_PASSTHROUGH_V2 (Amir)
 - lots of small fixes and cleanups (Amir, Sashiko)

---
John Groves (1):
  dax: replace exported dax_dev_get() with non-allocating dax_dev_find()

Miklos Szeredi (7):
  fuse: add helpers for EIO return value with kernel message
  fuse: support 64 bit, server allocated backing ID
  fuse: support opening 64 bit backing ID
  fuse: add support for opening dax device as backing
  fuse: add extent map data structure
  fuse: add extent map I/O support
  fuse: add support for striped backing

 drivers/dax/super.c       |  38 ++++-
 fs/fuse/Makefile          |   2 +-
 fs/fuse/backing.c         | 292 ++++++++++++++++++++++++++++++-------
 fs/fuse/dev.c             |  21 +++
 fs/fuse/dev.h             |   3 +
 fs/fuse/dir.c             |   3 +-
 fs/fuse/ext_map.c         | 299 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            |  16 +-
 fs/fuse/fuse_i.h          |  72 +++++++--
 fs/fuse/inode.c           |  17 ++-
 fs/fuse/iomode.c          | 108 +++++++-------
 fs/fuse/notify.c          |  75 ++++++++++
 fs/fuse/passthrough.c     |  63 ++++----
 include/linux/dax.h       |   6 +-
 include/uapi/linux/fuse.h |  53 ++++++-
 15 files changed, 904 insertions(+), 164 deletions(-)
 create mode 100644 fs/fuse/ext_map.c

-- 
2.54.0

