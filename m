Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE6272E4F
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419909; cv=none; b=ZxOvDcpjZWq1RipxUVxEEX6qyWADCW2qkypoFqnNO6PqRLJdb+8o/32gNsbr9gxi2WTyc4Le41bKwXyN3ep2BjEymESMcbIiqCKgd6Aakl77jAMmbVckUbHHEKdQbTiG1dPtipRO7PIlhMN+4xfhUr7lipQX1eyGCAMEArNn0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419909; c=relaxed/simple;
	bh=vaHMQ2ZjJxntFZc5U5J5R37wyOU0aE1VASANrNBzvTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V3o1MhNlFCTq2AE4inNz7BVIOq/ITvk/AHcbWnBTUO23wqXmoLibbE5a0xdsRBwjaTEw+90s7GlCPKDyGo/GpKOQxjCHkO5ZeSuMI7Ar5ugoXU+OX0kR92MWKOFAKUGmsCk6inYZH1fMkciofA/FB2WMADZVok3SNoqlxcdjQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+zUWDuL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+zUWDuL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so2793464f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748419905; x=1749024705; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/FCb16iLm7G0e3WCUiTZyQQx/X2uoabvGUpmWxpr2A=;
        b=D+zUWDuLXuCSyHSpEM6Xa5G8GHzw1Fh0FidaHr98vmF0wMx7IPIeMMaEoBqjoTQ17v
         FxN2bnHvAz8Z0Ijsxxi5ffVM7v9/F7lmfi6a63Cmgb3RfTU0o7qSAJIX5HQEWC5L/ioI
         1FhqrHl7h9EDm6+enRbK4ao/QyyF+l7vaiABxGy+3ydVTbaYKV6XoXZxMaaqu747SDuc
         F2/0qhrK6Wjs7khqLXCH/6SFvdDm8GP1z/6Fu1v2gYXF2BTj7MsDI4lo12DWRGHiL9tg
         7Z6G4rFf3vBQgblbuvAdYaDBqpxhbzYOBKg3+eCEtHoQkV7ME6fPFFpN4VoCV2F6SE5C
         kCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419905; x=1749024705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/FCb16iLm7G0e3WCUiTZyQQx/X2uoabvGUpmWxpr2A=;
        b=YV27djdJJvrOI1BDnK8LiF8crO3YjG+5eCxP2OwFbYRzyiVEiU8qCs+c20JBtqnvE2
         FO9GvxIECl1IL9Rz9FenMi072Tn5BcjZKMpUFY0wq2oQhtbViB1Vfp2qetXpTEcj62dg
         dlks3C8VpYmMoLA3XSWMRg9t9Qbnyw16dPT5cv5ccUizKuCli77O1JKw6xCiYNDet3It
         pGujLHk7D49nFY7JjneIgX5vYlwAC9q3lhBKMhGVSYXpZ5kaqtx6sk2tWYkgNNfsZV/X
         IfdiP/uLm9nVZovaRDTpNUASAs+DTZfMIt9hwx7cbPWksbNWKncykpFdZIeQA2sG+Ynk
         JvYg==
X-Forwarded-Encrypted: i=1; AJvYcCU7W7kRjY/5qmptNPOF98PNi0mublbvY2kcI8v4ayk6ThnNgKyNjUFQLfG/zOyTqLO0GaGBEUqpP0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytr8wgPMI1ztnOnJsUnhTeghhseEkg4PZ4lW2/xnFkEBFwen5p
	E9cRny3LPxetx9KEQeMaMxAwTXCNWDMpsQ9RrOO/TS8nMbUOeoqJE4Z0hm0F96mtFX7CAVQKUq1
	is6UQ
X-Gm-Gg: ASbGnct2mPm2VWgG0Xks0XcfDwTJEqygUhNI45Jv9iTFzpuBwffmT4lgQxil8bFUaP/
	SHtgon6Vwi3arGwRhHZbOEuVPwEd1uShYp7VmmcyitE/35M2d7DXpp9igX0A8hUeAaN/cyzF8h8
	vI9IOjntdBxscFlZQbYSra7/9u9lBxHHCO+Zd40C93bYQIQXRXra5gealIqc1lP4vg8I91XKpnb
	xE9YwI/NWyHRom0OZktYvdCKOis0lqFE6bjBPvBqexfLvdOHTw3wbA7uYKsjS+rPf4eyV8Oo4zy
	J+YQ+S/QOuiKkQFfNblElL6d1pUfEWsN8ZWb1q7ZWSxx+a6Gq3zi3u+al6d8tHT1ww4=
X-Google-Smtp-Source: AGHT+IF/wZakUcvuphAcq2wGl7JnOIxHt9unsVJgGESVrVbsKufI2U86TIxeSul0ISFVlHUGaRAdxA==
X-Received: by 2002:a05:6000:2282:b0:3a3:6958:88dd with SMTP id ffacd0b85a97d-3a4cb436d3amr13082654f8f.23.1748419905264;
        Wed, 28 May 2025 01:11:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4eac6eb45sm798948f8f.12.2025.05.28.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:11:44 -0700 (PDT)
Date: Wed, 28 May 2025 11:11:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>, Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] cxl: fix return value in cxlctl_validate_set_features()
Message-ID: <aDbFPSCujpJLY1if@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The cxlctl_validate_set_features() function is type bool.  It's supposed
to return true for valid requests and false for invalid.  However, this
error path returns ERR_PTR(-EINVAL) which is true when it was intended to
return false.

Fixes: f76e0bbc8bc3 ("cxl: Update prototype of function get_support_feature_info()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 6f2eae1eb126..7c750599ea69 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -544,7 +544,7 @@ static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
 	u32 flags;
 
 	if (rpc_in->op_size < sizeof(uuid_t))
-		return ERR_PTR(-EINVAL);
+		return false;
 
 	feat = cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
 	if (IS_ERR(feat))
-- 
2.47.2

