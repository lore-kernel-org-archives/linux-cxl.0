Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8336AB77
	for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214724; cv=none; b=NL7MF+NLvXghxCmAYtEPwd+IdN2GHX2psLdWzDC6hEp+9Ekhf4GVFVY3nQ9uDW6y4QS9fc8FHiyRMbs7syjOhKTIS78jQPshxQDprbzYIXdJAVwkQ2wA2XQXyjYocq26lnWnQbbP/Ck9iJRLhJOqbXetBrDoJLjeGO/XZi5wajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214724; c=relaxed/simple;
	bh=7YaBT6iNVRZFSk14jBUoMTS77VVYE51p/LoYdbnTAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDfYGxHr7LfDJvo0MSD5Epx1i6/UIz1rgtPTbEZABQze507FDVbMeTX0tDj0BZIiP0SEuKWPrg2lD1CKc6WiiMCz88ZNfHLKbLv2ptvppu0JK3Z/UKK6uNuxk8tLzsKZmhokwmNnw+5WtPwgRgkASMDVdIO88iEOfHL4UPVKBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GH9QmemW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GH9QmemW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so5298417a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777214719; x=1777819519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYEWwYPnxNhfjfvrN9NBByfvj86/jsr9iqTYqVjgdNU=;
        b=GH9QmemWAO9ojjYIbbd1iH538EruKq2wI1OUxm1dKsRhiyxk/fLxgHlYEne+8ot/wg
         48evAYTITwF8ITQ+NVqt3HtgOiVGqArjuATqTQvioK58yeRfHeECak0NmOOPNa5i+jnI
         9BzBcV8VgctM/Q3MJ1Rtgyd6FpcTjrFuBrc19rvp13T8pWzDffEYBjWyysazNadIWzeb
         n4GGdPsFM8cvsG0J+3cNqmDZWhubeWhgTOkHyJw6piDUDoeKSxCHFuA1WNHnSy9Bo0OD
         jrpTNaekELKoOYUIRd+l+7ZrDiMwmOmKp6NPXvf0GjSB8c684h8PztLjL3yghoz5mpCz
         sN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214719; x=1777819519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYEWwYPnxNhfjfvrN9NBByfvj86/jsr9iqTYqVjgdNU=;
        b=MWqU/PrdBFk9g9EW3SENOh1fGEMhWBXsZPUVxOZnGXGa84MhVpk5mb/tILUsieMffi
         E3uPWucNyzD/AgME8e7ZCxwuAl2eOkZtpz0TvI2hSTQUbTdD8HV2kbH1ozbNFuU3UB8G
         kGR3e/OvhcDD5xDdK7civprVcUo9KfBLPwEiw7XwXuTZw4/CRNF6Hv0EmsqBFm8QzVZ9
         HVoaD0DmBwkPLjOp9HGPIOZqfvkPGjgpU4GMXDpbj0lsAPI9YgtZIx5W+iYOeNQrtDBe
         3AkPviCLPDyj0NWr8r5YiLjdtVM9mmsuf4h1d1DoJYZUgKW2Brr6wS0DRe/HIyNFwrnB
         7+wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AKjFFxnHgpTUiL4owsl6zEUtLk3J5PX4wmWsz/WzXKeOf64vJR4ST8jEEvZpyFcCEwNyhZ8AbzF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89i8RXnKVq18ZpaeVQLTzHMj2t6C8zUVz00FJrlfxkzcf8WwW
	JxQbZPAbL/Ep7fKc8hr4B+J9TovW4hYn48mBgfj+TArudUKc7PophjEUMlBG5RDDG8g=
X-Gm-Gg: AeBDiev4Le29g5yJlEjMM+ZcbaYUiPHxZoQSR5rQ6KSYk7mkT/bMR1N5+p/ZREtWE0C
	QRsHyXujKWE/O5F0wSPvXdzPMuU6Qcm54TfLZ398Ra/CQwziZ2X2/ju2cwtpIAdItwlzp+gHnDh
	z2OX5WDrU6JJ9MzkrwHdf8HXgWDYod6xeNBIQhtRZVPn/dehxfWFW9WCyMOq+gCyMTkc54NmQ9g
	e7uC3EmrB5EV+QN/JjBFZSjxtBdsJYJbtm0WlAfb28cvSA0dJGw0FCVLwc0ub16Lucju0UT6+HF
	2CI1HGZazWpwtuInGOP8eyuSRHq0gaA0G9xLhImmf3Gobgo/UfgKzcafdvRk1TmxY6lh47+dQRV
	XUJlKK0k/vMUNYAWLAsgNqyc1vjoim4RaND9bmVuCZemlCFjLpGeONJfOrycvBb/EYESy/ZlaKF
	fZCwFpcFkrwgoZ+Y7OOzp63+mq6/Vj
X-Received: by 2002:a17:90a:f94f:b0:35f:c5cd:cc5 with SMTP id 98e67ed59e1d1-36140498686mr40821690a91.24.1777214718891;
        Sun, 26 Apr 2026 07:45:18 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::349])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm22340550a12.24.2026.04.26.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:45:18 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: muchun.song@linux.dev,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drivers/base/memory: fix memory block reference leak in poison accounting
Date: Sun, 26 Apr 2026 22:44:47 +0800
Message-Id: <20260426144447.817722-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426144447.817722-1-songmuchun@bytedance.com>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
block via find_memory_block_by_id(), which acquires a reference to the
memory block device.

Both helpers use the returned memory block without dropping that
reference, leaking the device reference on each successful lookup. Drop
the reference after updating nr_hwpoison.

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f806a683b767..6981b55d582a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1230,8 +1230,10 @@ void memblk_nr_poison_inc(unsigned long pfn)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
@@ -1239,8 +1241,10 @@ void memblk_nr_poison_sub(unsigned long pfn, long i)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 static unsigned long memblk_nr_poison(struct memory_block *mem)
-- 
2.20.1

