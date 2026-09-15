Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5547F76F
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466197; cv=none; b=NDJw3g3eZBCtU8Vt8S44gI+iFUHZAR/3EBLHPlLldfOQF9T/Y7vmpwVonpc/QkF5Q8EZW04iDEKwgmUEaz5DXsNZCCCz0qb5JDx2v4HtKNVZ3wR4+b5ezUs4YfkhNhYdZd7bxjNICnuCIrzqlhzOZcjha1TbD774DnaKFvB3kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466197; c=relaxed/simple;
	bh=0ldLI0jIdMK8AiSGipfQlJFMXUeME3rzoXRpb5rfrmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRvwiTL7JwwShqF5Qj5PGdTHlBjSvgH3c6T00lL29HtT3tkIELv78S9zlbwqF7XzwL1ej+TE81i5AyS/vJN/A6JSkFx1YtTbbL0fH4TzjzrDoDWVHQhN2qzLqeSf3A6OGk0qCIJK4E1p6uemUMKtqr51vqWhPzpS5qqdvRx9TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bEm6i+h7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bEm6i+h7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so58435a91.3
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789466194; x=1790070994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvp3AKdBFRuYXKGE5C8H1XVVcyDgnt4wpE1IB5bJa88=;
        b=bEm6i+h7blKf6wpQSvFMiBTrEG4i1jhAxD194Vdo0qpjTukmqypChECy1GenGBDr6/
         xr71Ucb3OSMciAny1RgksWs6js5dmWdUK+K1YIQkwlwp/D4pf2Ll7/akVCs6UKIFdRZE
         TIOXv8Opabz9obRFw8ItLuRfO1e4agkSglI9UhRjDArhv4kJp0a2W0Ck3W8RySEOXUdF
         BYyh5MQbU/qIgIo3L6TX242XzDyQE59R20nqhf5tIeIbD3kFx4TH12TqaGTlFCAguSUc
         pM0rLSETAt2noGH84EmkPDZfEjv41DAp+3hGXhgF2qPai7XESt2x2eSMW14J7wZiMKVD
         8hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789466194; x=1790070994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvp3AKdBFRuYXKGE5C8H1XVVcyDgnt4wpE1IB5bJa88=;
        b=0b7cnbK+s5lYL/WvDzvpeDwL82HE7jxbWCdBxAIRNpka96E8vlncp7inbVsIOww+Vz
         PaKj6ss3CLj3ROqCI77ykaPkKYkaNtN2tC+5AhWmwCucIP09/r9pQMzeI5mXa9Po5WLf
         ugTXnBXEpJ89Va2xvVGyoB1ORPAt0ZsvO994TbwWD/n0gV+dOOsvms3S1s2D0EksKPE+
         vDLRMkKDvpkKDkN/PLRP1QQu942DxVXTfDP9Py71ggdz2g46hG6U8w89iHhHbjxgm/K1
         pqy8/cGjJtnWHokLIl3odcNlExUXnJwztFwQjUV4a9B1SW85dP1hxiM89pbCOa87OZIC
         cbPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzI2gHIzRuwiZHB51la5uyVSxsjbLygjD0OTJyB/jNum81/1AErqRYEVy9p1ZadimatFRRjIHClWa0=@vger.kernel.org
X-Gm-Message-State: AFuF++nYXwcxyztLfVHMpF4virVgHUb3++hKaw/NIDeo2u377hFd/x0u
	n5eMw393Lyb7ivi/KF8iCh5dZtQyFQI5T6pofSk4Lupys0reEDFWWCp/ibEHDSSD97g=
X-Gm-Gg: AYBFou1dC3UUYZX7OKPXixATT2LpVnPFDcGsdepejss37Ne7H31rVpfOPtdSCJDkhsR
	+6hov3x5wIY/dI2kfqtrOOu/JqyR+O1lO9HLIqKmEXiCSG8eAOF88R9wkrE6aKVl/Sh/ceDT286
	3L7xtTnn2xPaAllip1IwdkwlSMYt5ISf5Ui78TbnvmTVSX3OUxbLqaj9XUZWIUENxTEwNgPqym3
	tOMJg98gDyzxbbmaWsrjJsW6OeqwXuppG1JTOTiNlidytrOXuxLdZQzu+7ZTub9SzETtglkiDHv
	eI9qcMnTlTgS9nB6dI/ETLScfP91nOmQseD2vVV869mBbb62gluD1XG+DoZ1ObnjjqS4k69HLbF
	PDR29TipbyPahk180Pimg0QgdFeFmNcn5d9o8qkQVskSVVSvyOg0Yok7qjM4SHjpuyXJxDKOeed
	KA8BfYxBR5jwUCW1qdtTeD9hA8SfKt/Ydvvi39GrT34kB5ylw26JDEfcT2E0DVr0sQQOzIBdRDl
	qCfiv1EeIJTLJjaUjAZ
X-Received: by 2002:a17:90b:2c8f:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39e1107004emr273952a91.21.1789466193983;
        Tue, 15 Sep 2026 02:56:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd6b9687sm4477827a91.0.2026.09.15.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:56:33 -0700 (PDT)
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
Subject: [PATCH 2/2] dax/bus: fix mapping attribute error reporting
Date: Tue, 15 Sep 2026 17:56:21 +0800
Message-ID: <20260915095621.3744167-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915095621.3744167-1-songmuchun@bytedance.com>
References: <20260915095621.3744167-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the DAX configuration locking was converted to rwsems, successful
lock acquisition leaves rc set to zero in mapping_store(). If the requested
range size is misaligned, the allocation is skipped and the zero rc is
converted to len. The sysfs write therefore reports success without
allocating the requested range.

Call alloc_dev_dax_range() unconditionally and let its full range
validation return -EINVAL for a misaligned start or size.

Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/dax/bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 54e4bbc98218..f232001ff5b7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1276,8 +1276,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	to_alloc = range_len(&r);
-	if (size_is_aligned(dev_dax, to_alloc))
-		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+	rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
-- 
2.54.0

