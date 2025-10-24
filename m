Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1F2FFDDE
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339949; cv=none; b=QXO8+pLxS8VWl7iPStv50s5pUeNugdjfllA/KAHzRevdS97HQ5LiLTzwzECe865bJ/NhQpATSQv/yjzHXGkgK9MS5DXBdx1OhDeK6m8Rp0kVkHAErjlYecl8qI9X3LO4XVOYAPBqCY/gUmyTfWdMp8hHpBMyReQQG7xYaouLrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339949; c=relaxed/simple;
	bh=h5jtxongNcjudQdK+LVORRb8tcuO7D5U5JAQHylsP2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZlMh28KO13r8Igrk0rOXnYjJEBgF5nB74mCp0SA/S2VQZiul45SyFYCnBwoaS5gcWLfFs8/aK66SXG/2efaBAeAb25DnVj20tGKJY8iTwPK77cKnu984272rxQRlqi4cvBNjbv3l8Aqs5fC7UlDtpcc0qExhFLExo0oWITvtf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwNM3NzB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwNM3NzB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47106a388cfso16231305e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339946; x=1761944746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRMTzFMIJeQxcHsoH28yuNEVa8nEsoNdV+uHVle8Mc=;
        b=TwNM3NzBYIKDHUJsnY6WPQlgIZXfGzWykXVX6JwMWqcRwV1UpOI9gxaYEWBeT2KRBK
         ti1nyRAP4RhJ/iIugLjNbvp432oV/apbIxwFYOldjAh8QbOZUXT1XVAjIjZUUiQ5l0Ki
         TSre65Jfejw3YldhDLRUDyRwBGfu9iBdRsKXYiEfzDrVTGRNgGxcnByG3Xwnfr2Sr/RU
         6/VAJcz0OPu7dfxsiww1+RAK+OJKFOrTEIgJd02CmAAVAwsL7dhn9Ei6VZ64y7mNFL2i
         zv3jBuXRzXLuZgXbKBtpr3A/8vmWU1lp9hh1dCi0Woz3SgSKqkW4qspUZ4Da4m9zIR/S
         w3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339946; x=1761944746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRMTzFMIJeQxcHsoH28yuNEVa8nEsoNdV+uHVle8Mc=;
        b=CODHJBq9sgIvZzePpBnNo6iL0F41BQ3tl46HI995mXuuhdqvKsJXjmhIth314OlWIf
         IrPwb5Xe5PsiK7ipQ8oxdyEnmRTT2N53bxy5unzS1hfRQvSvvbusaGe0bD+dTGwnTji2
         vFJWFexlYeLCAlpMHeRoTnenwKl3ZsWCJIwj0WssTmoMBu3O6peDlhXZpyQjgBecTVO7
         OetSTafoaZRG+KD0szR9IO7SwN9J2HQuwPl4NANRWBn7vIN6kmGYDJBsYYHJ+d2DAlz+
         LiD0uTEz7YvghPcP3a8ginkkya0uT3GmY+jj2EtxmiLo0ZgUoN5GE7hdvpXMo9d6E5fz
         uOTg==
X-Forwarded-Encrypted: i=1; AJvYcCV7pNhhCWVOngE4aJCNAAvddScaLThekV0oM050VB50D+ub2G+uuWYzqfkVQnf7Ub4Fac/TsjqfD98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkudYIYbi20ao8WxlPKxKN5GQ7NVhmWK78X7jPJ03pjxB4zpMe
	5MvEYePjDNYuqTaa0+PYhPHLZ7hp0THOAqxwIQgXBnGYGas00Jo4bOnbw1pQkwGfZMCgw7c/rz3
	3xLTUAFuybefkaLpUtdAdnA==
X-Google-Smtp-Source: AGHT+IFC+txOdBGCTvYrXat3a6tqgz8KACNhyZM9BjnWie/36t5aj2thznsQ3BgXECLv7OJoPPxu8dvYNdoSHEKd
X-Received: from wmju16.prod.google.com ([2002:a7b:cb10:0:b0:475:d804:bfd2])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3553:b0:471:a73:a9d2 with SMTP id 5b1f17b1804b1-471178a6484mr221961815e9.11.1761339946187;
 Fri, 24 Oct 2025 14:05:46 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:18 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-6-mclapinski@google.com>
Subject: [PATCH v3 5/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the dax device driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..74f2381a7df6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -470,6 +470,9 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
 	.type = DAXDRV_DEVICE_TYPE,
+	.drv = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init dax_init(void)
-- 
2.51.1.821.gb6fe4d2222-goog

