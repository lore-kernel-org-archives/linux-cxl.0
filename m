Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870B3E2760
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942095; cv=none; b=NJ82xzezsTGN2DP+eu2tVC80RzUU5SVCaXKBcfO1CocedM9vpt2eOKKjxgregS7VfBJjR2GVztdk9JWoUW5D3+92tGhwaQ3HMPQUxebsG1Aw7a4pYHLkEAt7M3XjQwMVEBECpSI4L+QbBO1NQQfLAb/6FT+nKPXVFnrGPeEKW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942095; c=relaxed/simple;
	bh=qAiI+Aq3U5FtaCmVP1hHMWOVi++6u8t9kYFLhCkE9+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QVZuG+EAtrYuLhvWuyjOwgn50+w7lQ0FaL6jSEFGVxPoGijn8mdzf0zZ23EXJDtxh2ttm0WOIvrrNlQUC3WvX7k7oxjBKl6HXahJ9ItENrtGH3q4OxmL6Gj93Ksc68eJ5DQ1SbjBNVpFFr0EbmiT7aU54cnFBgOO0MhXnE0Hwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgDFqgUX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgDFqgUX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so39652125ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942093; x=1784546893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2euxT0qaEKfF/kpFQE4EqG1inqBHFyulv/VShZJ89Q=;
        b=bgDFqgUXoRXwqi51nSDFOfAqyUA5UJTaqigcciydCTVZv4+IDKZ47aQ3DMU12Qs0pv
         Mu2IVPGJ4PID40USrUJ8JPVG1ztsoUf28/L75oKTC8pYSDa5VNJLv6GGRRZBDkoZkS97
         bDpgkqBZ1k+CzDnYfpecm/s4Hjvy9F710UIWehxEeH+XOEJTOHGYDMltrabF3wJtlUaB
         3eX65O9ZB1TMdqzN0BIEaMEedy09cZEZcHQIMvLirDKXqbe1IXi7qZfESRAA/Z7Ma47A
         ABnLheefQnJMGRRxcIPShOIh8m7TeWD4dN6PjTCLsk9Yt21ufaHlAsP+mrARHtuy51iO
         C9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942093; x=1784546893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2euxT0qaEKfF/kpFQE4EqG1inqBHFyulv/VShZJ89Q=;
        b=g4ObNiN7N3Xi9NcM1wi954Ql9dVagf52ZRP40Cfw2EdbB94vjcqyQv/MLxAAKWZw9U
         mijxEdbR7MzPKxGGSVlOxalcfXg13/SX6GONABmpIVAuS7TYKfJHJ/1J93dzMEZ1CSXv
         guO8AaKobILVV2Mmb5AtaA1p8uQup2B4daWxRjmMy9GzlF7av4OMPal8HiCk4gVb23jM
         xA06rl2BhgIonJYHrbfCK+LJNFKQX1wNi+ipbxRYnNLKiOxQxTYL3PA8FIfJqFBy9guR
         GkflWOOrDXvGv+fIjf3pHpWyYfRoKCX1Bp0dJ6D/6wmL0q8EFpsGNVcAvjlPMO2i+vqu
         44kQ==
X-Gm-Message-State: AOJu0YzzQomu4dFp6jV4E2/oPAZAg4Ji1AsPzlEV8n8HZ5IUH8tJ+DQw
	LnRIS+i28Yfnj18Lqy/ADYUmQBp7YEj4NBf6mP65OGpJiPb9LRsDs84Y
X-Gm-Gg: AfdE7clsyYwDEmsUNgqQONaibo4ReH6+uOBzQXeLFKRjrbjLatER75mx1wPIRjmlh5M
	9BBGwji8A6d3ahw7YaKzF+7rDBjIXRlqfhqzXg9exwKqFK4VRJulrx1wgn0sfz2QlcqJInSnfMc
	BIHa79A3FjxoPxCHH2R0tjGzZlBt8570xO35HLY3mr3imjiayhGFfSrJHKfqAysoVZH6g2f1yvL
	g1aKHbbF2bUCWqqgo9TeVLKs+mAPf9jZ0fOiTEKRc8YNroIRYoI6iftzimKT65eC8jpAE37pFuq
	VrQ0+/djb1K7B1Z2pvmyRleYnGSH0VOqp84puqqRRHYJLT5tDFAtf7P1ShKGww01fy91e6KnQtF
	T6URBAWfJ+hhAthI4b31j0RFKZUYKsddVxcxcuO38fTEd00pDdSO+o/7Y6nGCo7Y/fvDQBp6BUw
	lJMQ2T
X-Received: by 2002:a17:902:e946:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2ce9e9be58fmr82776575ad.15.1783942093236;
        Mon, 13 Jul 2026 04:28:13 -0700 (PDT)
Received: from n232-175-066.byted.org ([240e:83:200::34b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d2efsm97224455ad.64.2026.07.13.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:28:12 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guzebing <Guzebing1612@gmail.com>
Subject: [PATCH] cxl/memdev: Fix firmware upload exact-fit handling
Date: Mon, 13 Jul 2026 19:27:44 +0800
Message-Id: <20260713112744.2543829-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guzebing <Guzebing1612@gmail.com>

cxl_fw_prepare() classifies a firmware image as a one-shot transfer
only when its Transfer FW input payload is smaller than the mailbox
payload size. An image that exactly fills the payload is therefore
treated as a multi-part transfer.

The firmware loader invokes cxl_fw_write() only once for that image.
Since both offset == 0 and remaining == 0, the multi-part action
selection sends INITIATE, never sends END, and then attempts to activate
the target slot.

Include equality in the one-shot classification so exact-fit images use
the FULL action.

Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
Signed-off-by: Guzebing <Guzebing1612@gmail.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13af..45e7d2be17e09 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -921,7 +921,7 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
 	if (!size)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
-	mds->fw.oneshot = struct_size(transfer, data, size) <
+	mds->fw.oneshot = struct_size(transfer, data, size) <=
 			    cxl_mbox->payload_size;
 
 	if (cxl_mem_get_fw_info(mds))
-- 
2.20.1

