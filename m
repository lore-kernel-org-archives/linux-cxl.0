Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDE38A72C
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471083; cv=none; b=e6Z9rR+VEUT6Nj8HJ33BaqjympqaJKy9kNnV1jBggLS3YAJ+U3aPQBEKoy7NmuvYUqMDRnHHGN5XpCnPbPR7rKSukD69yQz+euNjmPbKfP9j1lI4WgqcIvbW746hG3P+CwRGAFzqER+Wy9it3ZEXr86ZFGXyAnonNSqtj5YEIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471083; c=relaxed/simple;
	bh=SypRMf865vqSHPHSTRK0rMNXSpDU8wk9nZrTlhRbY6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjb2KwA8dAI1zaM1zNCRAMbgig6HiYDfA+AAGGyd2Ht8gBUJr2gQr6MO/jntQhvkhqAJJZvw1aEYLmGjbSCuetHvWGSejZzdBQzQ7Ew8xeQTJsL6ukCbfcrraA4Yejz+FnSbQEn7CnthzSxuj8j/Up14ZFdXq8E+3IQtsAIsOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9TyhD7E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9TyhD7E"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43eb05b1875so7317850f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471079; x=1778075879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CTSBzsBgkNvhDnVz+9h4ZL7e9PYIu5uJhtdDT/D+nI=;
        b=A9TyhD7EObAG0ta15UwXsh19QXqqF/ewyCq2P+Lg0D8TmbAMoh7VOLOzalIbdmgQgc
         aVDH6NEQYyINlQEdNSBbRAGdK4jBOJvps++2lM3e1QhhZlb8Lw2ItzEbaqiGEmQNPj8t
         WIZKj5gBler7iny0uvf0T5Uy/C5h+wlr93PX6P5PTrowBWBDNfsETQLOKR+kqU6XvAXf
         LfT9tqofbDwjhb8co3BA6qlQ+SAjKBBK8fxpk1+McfUApAOHkUbm7T4Kaa6xOeZuNuAj
         2GugLX7P+EyyMnF9TQvCnuZQeTrOBkqCYGAXKAS6YNvggS0Gyy0FlYk05bPFq4em6PdL
         BlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471079; x=1778075879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CTSBzsBgkNvhDnVz+9h4ZL7e9PYIu5uJhtdDT/D+nI=;
        b=ivgrvZEHjKD+u9ZgTUBSyTLTfNZXuGsHWgMCIdUMfxwezPX0OTgcr4SFOnmsMN+kup
         ZGEIl4WyTVXx4eg+lrOmi7QugUCgkuXLY3nlTLXxI4Wlb+vHLUMbkppBO3AEhGwRDxH2
         vrGJ3h+BnfZh1JXylPmzyTfn5Vb2nkioDwqkjbvRCrm2n6jme+x46MD+YBVi4X91Vgfo
         s8I2UMzfbaXB+dxqwkJ0YnVXHQkifL54I7JPHeTXtk+tPWNLdh85PfPdatbpWiTcsu2K
         e9e6Y6l/zyouRTgt+iOrsvEToy5jwCbftUI1jN8R3LiinNMt+X2WkN52MnNklPgDSayk
         g7Eg==
X-Gm-Message-State: AOJu0YzWWBEtE5jbTF1r7h1Uz1BjdKukjxT704oCsSR7TAz8ZP8bBT6p
	nsgw/TGexAqQKgQpoUT88m/vvpGxnGqqY4aswOW7+a6JIEn+kv4E0CJTrAwXHV/L
X-Gm-Gg: AeBDietHNTP+FGV68pCMyTV+xKCoEbUZ9IVqw2zflIRulFxZnZ2qDr4MprnOHXpFx13
	N7dEiXtQ4Juh7AwBT0L8ZjEVbsYt01OvY+OZ3KEbfyqIFoqKLHX9gwx1U6JNZKy/9cxhX+lUxco
	2URRDO/tsx5G5CyWdg0eSFXeuzZCd+gtyAWTXjzXgfb8GRZfqgXOp0K6hKGCrj/UhGKY4oaNNKJ
	3vl79sPi/YwRm11VVvA5KQudyxnA+QUELFMnnfgwnxizYQpJryJD7r7s1Zp9nqLPusyGuxsrC04
	o16Xr5Q0bAUW4zMlIiHt/AmQ6ZijTyd3BDqYGfs3tWgmAd7raaTO4MJdvtvHDD4qb59YGb4odwB
	6mJ581MEioHh5RVk5frSW2foQnI4RlC+aMnIkm2/FZ/G25Qwjw2lh3txc4omxUA8smWOCRSWVIP
	+Nq3xK/uIkEuA7v3RKT1pLRHx3kE3JYUXz4btcUmzIBi4w/fVm2dBlmU4akhZ2wum8yUC/ja7V
X-Received: by 2002:a5d:5d0f:0:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-4464a447024mr14262935f8f.29.1777471079173;
        Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 03/10] cxl-type3: Properly unmap the memory-backend on device exit
Date: Wed, 29 Apr 2026 14:48:37 +0100
Message-ID: <20260429135717.3048713-4-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the backend remains mapped, meaning that if the device owning
the backend is hot-removed, it cannot be readded in the same QEMU
instance.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/mem/cxl_type3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 68cd04b7d9..414c776028 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1072,12 +1072,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_destroy_cci(&ct3d->cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, false);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
+        host_memory_backend_set_mapped(ct3d->hostpmem, false);
         address_space_destroy(&ct3d->hostpmem_as);
     }
     if (ct3d->hostvmem) {
+        host_memory_backend_set_mapped(ct3d->hostvmem, false);
         address_space_destroy(&ct3d->hostvmem_as);
     }
 }
-- 
2.47.3

