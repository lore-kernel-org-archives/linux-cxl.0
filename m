Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE341D4EF
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065565; cv=none; b=TSOnF+fqBsdY3tDdcNBrLANX/aFGYRLqH3sVXxpVRk9h1MafLA4Cwojee5I4AtA0zOpnHSsMVpuohfjUgsREvKr1irkxQvNnY0PqISev0r7tCdcLy3DMYjQUjYUSlBslGRWRDeiT0KLyGW26VTttshXJsFIf5X7/Ee/g/by7hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065565; c=relaxed/simple;
	bh=RIOE3frsVNEF/09JlwDYf3SmDs4Wsp08R0Ba5pjSn4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPEHTMHNl/BeLRWrOSS5B5c3MvjEH0gVxNXow7jY1rPF4y9CnxAR0YqZWgpyEhiey8U5nR8R+qHjtlyEtGZgjlbOuntqd54ja9twDI5OSafot1AT8f22jpc7qv6LYjgTPYIqH0YNGWdFo1IzmjrZcMHWei80rmrohQ/eW/9eaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lCAkyebC; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lCAkyebC"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso714466a12.2
        for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790065562; x=1790670362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WvGiIb4KIaeapLTxfhgArk7ORGg9nzESK+ScS9ezaus=;
        b=lCAkyebCoB/5Yl4awmVYn5IvrEUCibfBqpPV9ak3QIHJgpsi02ITgM57OT4bDM7ETU
         ozwa3jr7nCUffGA/aasrjE7nM1po8o5m0MYJSuxqE0+OwvVzjVM922B9dzKkXsqtgIdR
         0XHd6ne05niQ5ma4IQRzTrstBW8Nnvyi79AIwrxE5K1kf71RT5Vwgp+peImkF7ucEjGr
         +jPKZUD+1I8KWMiHsrcGjTg07rXjMkDg0sSlTiUsbjehsRfnEK2y9wUqIN9ATgQJ9byg
         rvzoQjfgnWzwZ4rEZRitmrCnwaUaZHmtM2aX+WkbTgSVgOoSe8dTRtgBRH9AP9U9oz5z
         GBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065562; x=1790670362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvGiIb4KIaeapLTxfhgArk7ORGg9nzESK+ScS9ezaus=;
        b=BKepcCoKpujWRpL6hUPVhMiPm9IQl/uFgnT6aLW1w0IloSQrYC+Rot/OU/gSPxA/8E
         fGr5sRh+Rw84+0cxAvrYJsvttUYPVBDrt91SHRedSTssSyPeCB5EpIPzsEe0zkayFOox
         xAw33kJVkCXCVmyQ/3fcOik50+zSIWmMd1W83SoNgEjBr5mGTmh/KH4YZf2z1R1Gh9jZ
         6kDRCDkOUyotSw5SU3cMmwmz459E/fazKKaiEOjZ+8Lce3alQVfdaTIvfKZTagL5lQUA
         msYGCR9SAJQvp7aOWiw2lMPyeR8sBkSvEO9hrDZBsOSNujiRQ6Txz5tQPba1N2urEz9T
         OHyA==
X-Forwarded-Encrypted: i=1; AKwUvBz16EJ5R2/Lnx5QpDifcfhS4uAs/x6ozheFbdZPaQuB+iyBXzZPseGz3ZS4IXF/cJDoLm/yX7tmgBU=@vger.kernel.org
X-Gm-Message-State: AFuF++kNC+UOJQHqIEpbfFSeI5GBEwLGC2mTT/f5RBR8oMlvc+X0wySU
	UZghWr/ox/u0+gdhZ0NoOX7UnYoegZmVrHcqI8YJiI28QRM2ASyn1xNBPHVbTEZJN4w=
X-Gm-Gg: AYBFou2XculYyDW3YDQx6RseCC/XoptJ+jP49XDIYqYwe2oqJw1SuKhmursGNWHFTHv
	BVUpIdDFeqQ4BIvWwdpAPNBpKCG2nAhU9PWZvToa4a+VXIgEPvf2hWaOvMLmH8u5bB86OWiGnXQ
	qCEEQMH2FV/Heo3jjWtA07PCW6TfhXRyR0kyIX9b76HEAVYufJCeS4opQkou9ZhrVhtaShzealX
	d2YAmHN8bJMbmn0vikKWcvYzQ9UeAPAuJQDO+F69lQwfnb8fxEmnUT60fTvjZY6PjOAw3Dn71XO
	ilu3CC9apQmdbpQgoKmlTMeOcPiwMHbRF/aMPkC58TnfexOn6BAb/SxoU1mtQPzp6FU2vJwCQF1
	NqXWDSyuH8yLps/rokX8glEYapHOPaEcFffGkJpfw5xzMwoVvVRYuTa7Q/hdDVcKYHUVSwe7/C3
	56Sl8lcfNFIgM5E+bcXG/b65CJmRlDKV2AWO71T5w8CQD8FEPnwsLQVw0VvpWiHvfXrHefis8e3
	MCG/8iouW4OQNe9pp4=
X-Received: by 2002:a17:90a:e7cc:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-3a0730c5dfbmr453487a91.15.1790065561735;
        Tue, 22 Sep 2026 01:26:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07385e516sm223056a91.0.2026.09.22.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:26:01 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 1/2] dax/bus: fix mapping attribute error reporting
Date: Tue, 22 Sep 2026 16:25:50 +0800
Message-ID: <20260922082551.874901-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922082551.874901-1-songmuchun@bytedance.com>
References: <20260922082551.874901-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the DAX configuration locking was converted to rwsems, successful
lock acquisition leaves rc set to zero in mapping_store(). Two error
paths can return this stale value: an unbound region driver and a
misaligned range size. The sysfs write therefore reports success without
allocating the requested range.

Return -ENXIO when the region driver is not bound and -EINVAL when the
range size is misaligned.

Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Return explicit errors before Device DAX range allocation
  (suggested by Dave Jiang)
- Move the patch before range alignment validation for independent
  backports (suggested by Dave Jiang)
---
 drivers/dax/bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264af..e40c25401cf0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1192,7 +1192,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 		return rc;
 	if (!dax_region->dev->driver) {
 		up_write(&dax_region_rwsem);
-		return rc;
+		return -ENXIO;
 	}
 	rc = down_write_killable(&dax_dev_rwsem);
 	if (rc) {
@@ -1201,8 +1201,12 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	to_alloc = range_len(&r);
-	if (alloc_is_aligned(dev_dax, to_alloc))
+	if (!alloc_is_aligned(dev_dax, to_alloc)) {
+		dev_dbg(dev, "%s: size: %zu misaligned\n", __func__, to_alloc);
+		rc = -EINVAL;
+	} else {
 		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+	}
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
-- 
2.54.0

