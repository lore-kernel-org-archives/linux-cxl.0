Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF22F8BED;
	Wed, 13 Aug 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086168; cv=none; b=G/YoXMRGFx8R5HmBSS48tyS+th38varBKtrZ5aht2ykST45Wm/OMr6sDnDv4SFeKt6v6I1dg2L9INZHaQ/tuAe1PfOwd02xq7Nidm6L5gYXE9rt5d2BYg6EySxWpsw0PDk+QQCvlU24Hp+/GE32ZzmswavqEZz7D7LQTPKo/S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086168; c=relaxed/simple;
	bh=quV/64NGZczI17JeNf9BZ5rmwuWqx93DwhXH7Qqhw2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tw6SPKbaxanwHDOKjRwnaL38tdxMI9E/1tWvbiZzxO1ZtLwNHm2TeSaDn79iRH+ku7ANE/kKnNyYNrx28uN9GyjDIj9ch9ye4JdPBnjvrRyMSZlhGiqL3xK5xZyEGS3l0g1P8RNwm55wL+pRgfWRPKLt/oz9E6ucLf3Iz89FHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP+UJYgv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP+UJYgv"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so6044363b3a.0;
        Wed, 13 Aug 2025 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755086165; x=1755690965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etgbsIbBOnSZmFvohwhbriC8Ru0uLO2C5ab7ocfqrSQ=;
        b=XP+UJYgvz7ogpNhL0WzTdjkqRf/VWv9h5FvmjNNjgHuY0wpQ7uuYvCcjYu9jA2/UTh
         NEtsPEIN+rJC22ydSL7WjwCpOGW7DFoBfHqBLRi2qDRkbUdepDQhm3ov4td3HRFOwPZA
         1i9jQfOa1zov4DfVf9BAr7lx7yR3FM61AdzTBoyTlsiipnXyvHz8JGyOW7HV/weMbjFe
         /IwI59gEh4HuVw69fFOmhzdZrCcH9OIAfb62Dedz5q5daGgytLmEGL++uQBx6e7ewnAG
         j9aeQ7vNms7fK/z6KqLtkhpC4ETQOxltf5D9hGEaZaI4/6bkueCps28VpeWn9pIyAwfg
         SU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086165; x=1755690965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etgbsIbBOnSZmFvohwhbriC8Ru0uLO2C5ab7ocfqrSQ=;
        b=BKXHtstmrLtgK1K2MGNtSfpXQjzV8bORHnc6AkUqWB6chioutYJub16/Bos8IA7SSI
         eFAlcdexzmjgM5jHPU4R0IC/YxreyJb+hmAGuJr0DBqlq7AralAOh9Tu4ucq5WdNGxVw
         P3n5s91yF9w7ChVBC+PBDgxtAlog27aVKviHcpOfuLinfpU7nqejdRZzCq04tJ974AK0
         N0k07u2uMPKemDeF5xDI7Nk056IZzqhROtH01a050nHjYxd49H5SbXkYZfvUr51i8WIb
         O+2clpRRZcDIrsmJt43BYVCIkZ1lU4yKYCJ1jyFilLkhmZ6DVv7oFoKY7scBFHp/pv6T
         Ax1w==
X-Forwarded-Encrypted: i=1; AJvYcCVACrdiNFwPsx1S5IHLEzumrJVmWCImQYXxaWwbxxn4BQiwlAMZdwvCiMU02FQT19o/n+dU2/apUfk7+wJ4@vger.kernel.org, AJvYcCXgUJuXly+Ycu2t9Vln4pqUOAtzxIgmeLkNbYv1PRsxQONGXerktxpglJS8cY3/P69Igsu4VBZf+WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkfja84pKb/yC8oders3TAvgNnv4PfJOhtqYOPQOp3HB6hOAH
	gzhZO8Kvbr2QEMMmxlsqDaczHp8fx7VdgPcNzhgWIxjCp+PFR29ysTtQfSFrh/uyJrg=
X-Gm-Gg: ASbGncu/sW4CCxfEfyskTgCrFsvs63OAD8Ot/VvAe7mYqK6wm57ZH3wsNgB7f4t0P3n
	DJdo2C9+mFjw3uAZAuY+CmtM/oI3i/pcjB2w8LK+AR47EctcQaU1aJ6OtgxJWTqQZShJ0VLXumg
	hwWwC3+rZSFburIxIcOppRSGbzeRVtaPquLQK3vhn6bAwt0wx7PlS4d8VbQigqH81eKdaWLmw7Y
	oW5UiL+RRhze+gKdCK9U/fuyAhGsCT8lD4cd/nbPW6ZPmWGKCWIRE8xYAaZrd495iYPAzwvZqyZ
	8gJQA9NvLFzZvpLgBGqAdrVN3iv/80br8kONrwfRpL+ce+Tq8XmV7EDQ4iZYp+H1I/lK9gcse4v
	DObPiC/2gOU1bcTaOWVcBcCVKIObdz5SXsM8LlwYt13AsQPo5
X-Google-Smtp-Source: AGHT+IEqUbx2QZCO1lnqOrR8Nb6hxoGXj7FPYROLjSVP1sN6B2Zvb6IOlkA2ik+8PvTcOSR2rGc+7Q==
X-Received: by 2002:a17:902:ccc9:b0:240:49d1:6347 with SMTP id d9443c01a7336-2430d1f84cfmr44365925ad.35.1755086164799;
        Wed, 13 Aug 2025 04:56:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8898:77ef:a09b:a8f4:7c6e:b37d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ececsm322985115ad.68.2025.08.13.04.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:56:04 -0700 (PDT)
From: darshanrathod475@gmail.com
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: shiju.jose@huawei.com,
	ming.li@zohomail.com,
	peterz@infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] cxl: remove assignment from if condition in cxl_mem_get_poison
Date: Wed, 13 Aug 2025 17:25:54 +0530
Message-Id: <20250813115554.388368-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

Refactor cxl_mem_get_poison() to assign the return value of
ACQUIRE_ERR() before the conditional check, instead of performing the
assignment inside the if condition. This resolves a checkpatch.pl
warning ("do not use assignment in if condition") and improves
readability.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/cxl/core/mbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..9c5066631896 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1426,7 +1426,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int rc;
 
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
-	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+
+	rc = ACQUIRE_ERR(mutex_intr, &lock);
+	if (rc)
 		return rc;
 
 	po = mds->poison.list_out;
-- 
2.25.1

