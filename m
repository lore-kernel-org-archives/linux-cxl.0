Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084753EBF0F
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286790; cv=none; b=bvE1n33OAzlr3bjp4d/LxgSVttTrhliK24wHx303j/xVO0A8iIT5ddqyhCW4TqhZYp28zwsgy89+5jVHb3ipCoHe90YIsD2E8o5606fJITe3awIzBaXl7WVXSqpRrdNX4DnRDXYpRnD4n5Sqi9xNBlTmxhNyVWBWLO2mATk/cNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286790; c=relaxed/simple;
	bh=1vGSBsOqwSPKJSrTGp1hUkt9RHB6bnrXNKPoZr/mu08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG0xBM22uKqVNkUENvuv4lvj0HpUUwXILK+6Q+uQ/i7mKSopJIb7xZO4tmH3pNBOoPwGStEkiYo2QkysbxN7jP3O/5feek87T6xZI9oR1P5EDt+Uc9xYqX00MhVv7LdZ7KQ98H1NyAlqWZJgywqrN49DylHKmNX+++EXlgvqKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTwG1c2t; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTwG1c2t"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2818047f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286778; x=1779891578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4xwZJjD+x8pUXNAyzlanJoC/U9UHp4YFZZpOj5yGH4=;
        b=aTwG1c2tiWSadpjZIAOHTf6nYxDfi5Vj6O2CM4p1s4Vs2Ysf02ug45KG6btrqkxCnS
         tNjt8w2+iHiJOi5t38Ut1QOD/14nXiufqgC6thfQ5Pry5LmKEC4S8XSol5lUAhuPw2EB
         fm4OiHv89ubkmBBK+S4u9s/gQOXG9gtBEGh2zw/iWGmDhCisRx48B2Vvsu/Z61YG8Iru
         d5t0VKtgI9CI+njNeICdqLBUpgWg1QjaXULShGucTPVz47cZ8TMQU597Bu8p9Fi+EonR
         2+TyTvgytAydnvhliHE9KYCHDYLGQrCwPeQFH0b8AGMtLz8feLNLmfohASqiElAzG+fM
         YHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286778; x=1779891578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4xwZJjD+x8pUXNAyzlanJoC/U9UHp4YFZZpOj5yGH4=;
        b=EhV8OFX+IwG5klFquV9DgpsyQa44XU/YDvpkRDoagTmVclL/10mixJ5js5DbaiX63X
         g9oCVZWe+fVBGIB+QQJdsknMcKV2UB21mrDhzdb5CxBHOum6851cgWZXMNNsaUb2MEi7
         t4JHdkgxtHoBo71F51kO02tSBYBtk7+2GAduT7izL+og2bG97s2glITlYv50zMTheSan
         pxAuzgVOzzFn+47nXUM1wfYrbovPIHKVNv7lp99QcUAJZH7N9jtqcIhUE4LJfYJMjfMx
         cbHHfCvWvpVQ3GkpYSSstr9Km7fVEsTIYQy7JZU4PhB7wiXg3ERTgHELQ7fKz5hSqR0Q
         NPEg==
X-Gm-Message-State: AOJu0YwXvdvJg6JTpakgjaMQmx2KiLVeAvRzeYbaHd7b9b2LQ8uTtYVT
	9uFndcAMxTbVTu2InDbOcp6zNXrtCbbHzWwvwsatpLmCIx2XkTRmHfPVQ6PN0A==
X-Gm-Gg: Acq92OG8Y4q2uaXLdKspOkRQcxxX8UxMJu7C4qQGpHpxZOB2QshA0GGR0o5fmwnRWWB
	wWAOmUhS/m8jsOPZGjncydl1OyAh6ZAr9R2kN/GDbvg47VqprVbbeKx3r9aJsx1oWEnDPav4fjr
	BJ+gfSHAlVNaOWicBvhIozTVnMa2Jiqw/yQdDxKwdiCWRhn4PAdUcqmJMWWRbqKEVu2EboKVCGn
	8DX8TZdkUlMe34Fbs+4GDQgsPc6krXzXIimYFhzh0ZBRxbYj5TFVpOErGYf1xDx7xo6Sb3QynzL
	AvUDEnxzKsaOawf5H5ummUZjtOdQFPp7ZW081QqV5fBQ+7GeYRYyk0sSucrPP3NUk95+7tx/MLl
	KCxSUz0Ae1cZHxUKxcW/5bvjNcpXBJkPuWMJfJD4Byj1Ec0kYUoZRYSp2hw/44Pvl6/z6NgjiYQ
	r6DFKHoTfcSz+ceQBesbgYkRc+JRN2lZFg00rNLRikHpZCHRw1JORcAaIg3q8ccg==
X-Received: by 2002:a05:6000:2482:b0:454:811:9207 with SMTP id ffacd0b85a97d-45e5c5af469mr39519146f8f.17.1779286778476;
        Wed, 20 May 2026 07:19:38 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm55387740f8f.32.2026.05.20.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:19:38 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: jic23@kernel.org,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU PATCH 1/2] cxl-type3: Properly unmap the memory-backend on device exit
Date: Wed, 20 May 2026 15:16:47 +0100
Message-ID: <20260520141816.3240010-3-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520141816.3240010-2-joshualant@gmail.com>
References: <20260520141816.3240010-2-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the memory backend remains mapped, meaning that if the device owning
the backend is hot-removed, it cannot be readded in the same QEMU instance.

Fixes: 5fcc499ee34 ("mem/cxl_type3: Add read and write functions for associated hostmem.")

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/mem/cxl_type3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..105526edd4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1049,12 +1049,15 @@ err_free_special_ops:
     g_free(regs->special_ops);
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
@@ -1072,12 +1075,15 @@ static void ct3_exit(PCIDevice *pci_dev)
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

