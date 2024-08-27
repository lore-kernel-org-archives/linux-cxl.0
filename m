Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C919D074
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777014; cv=none; b=owPytbXRB9utjE6pbbPdtqDEudFX+LwJGCVXQkCJpCmVctcpGTZin9vlP+lxoxpTKdjZ9mEuNQ3yI7R+ybnq3iz6wtI18c94H8t6+Y3m+OL5YOkQKJF60vWvdJpQ+nvB5PDdnOI2kocoT6zNVGZBXOD2tEi8zUz23SFe4XGM49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777014; c=relaxed/simple;
	bh=T6UZs+m5Daq/TV2ebC+jTD5Q4i/94vTvONzz4HBDENg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZxZ1/oVvgua0X+La+NdKydjzZ7t69FBSNl/3SSNp9RzLzRILJL/n6p+qATApdH5BZgZya+t5nkLyssuYoPupgKtC4y6AS6sDyKvTwae1MqzwOD2Yw2QlbVwZI25B4l2JrfdrTRBQaqhesWF/1RyJip1LekzCerKSHCldANTX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU8SrRcU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU8SrRcU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b59a67ba12so52339797b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777011; x=1725381811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwvM3S9SiHQZGwR6Xphu333GyFIzsUCvHKvo/gM3elM=;
        b=YU8SrRcUynIPslGYtcR2BredGpPuIUi853Q7/83s4vzFZy770NhAuc7FjMu9VwUKaS
         ImQ/wKBpG1eaQUz371YVH8q03i7PeSInqy/lZH6bE+1NJeot9N3S4LTPYH1c+WcUQ/Ea
         GbJvWslFTrOLUl7VtLU2FwDrU7gXZQU4dX1lJDDaUNSyrnM6+RDGxLJ5BUWKcZ3L+RvC
         9F05/whN+9nsEkjibAkcRKXsJKYPcd95Fb30Rn0BNIvSw6w4r3YOIoYQErRYr7yYrs/0
         gqhtYZON0cNNrL323rX5szy2k27clJ7Q+XfI9Wzgcm2Q2PHWeUzbRcW5H4ZPyTfk1k6q
         tS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777011; x=1725381811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwvM3S9SiHQZGwR6Xphu333GyFIzsUCvHKvo/gM3elM=;
        b=LgCcdoDa35y6dTPZLnkyJperKFNu27Dr6TxZoaB6uaaHeBrVj6dfPZXOTdBtBrXvU4
         XAix+N4nJUveAjirbvTnoHe5UCLMLBHq9UxTvsMjLwA1d+tUJ3h+QyWRY0JbFLeakBT+
         euv4oqWt1unNTEt0uFPn3cmz+d6N+w2cqm9UA9VVoyAG4LGcbuIURcTH5r9D7RIMCkIE
         i5keWK07ihI2jdXwFQdoYAeoW7cikKTxexE7oLmsLQorIgf05Whh5n+s9xDosxp3SXtN
         TEBnh37MI+ct8hQeRfUSYz7althMjAQwRJwjNcJqIpdPhd+NtQLc0kwUGP/i6ixeYBT6
         9SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq602kkT8t+3YJW1uVCQUoHbC6Q2ktYN67LGFkJgtWuipR9zs2nI2TQj4qLspjHW3v0G2bp1q8SuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaGo2mdoYbWu5R/oW7UaoT5k4wVG4Oo1a3SeEPNf6N3M1vTUJ
	WtYiOqJurlMWiWUK2sH3OIUaHlj6+2ijQtJ2L2dzPKoWptWtRUmq
X-Google-Smtp-Source: AGHT+IEQC25v7IZbO2OCFRpYtIyH6n2S/Ki0r5sn8cq1TjaJ4jl9KoxzebkxMgz4IGMf6hByZNYfxg==
X-Received: by 2002:a05:690c:38b:b0:6c7:a120:e10f with SMTP id 00721157ae682-6cfbbbd4c68mr36358247b3.29.1724777011572;
        Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
Received: from fan.. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 1/2] hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event records
Date: Tue, 27 Aug 2024 09:40:04 -0700
Message-ID: <20240827164304.88876-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827164304.88876-1-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, for multiple dynamic capacity event records grouped via
the More flag, the last record in the sequence should clear the More flag.

Before the change, the More flag of the event record is cleared before
the loop of inserting records into the event log, which will leave the flag
always set once it is set in the loop.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d648192ab9..e616801c81 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2060,11 +2060,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     stw_le_p(&dCap.host_id, hid);
     /* only valid for DC_REGION_CONFIG_UPDATED event */
     dCap.updated_region_id = 0;
-    dCap.flags = 0;
     for (i = 0; i < num_extents; i++) {
         memcpy(&dCap.dynamic_capacity_extent, &extents[i],
                sizeof(CXLDCExtentRaw));
 
+        dCap.flags = 0;
         if (i < num_extents - 1) {
             /* Set "More" flag */
             dCap.flags |= BIT(0);
-- 
2.43.0

