Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B432FFDD5
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339946; cv=none; b=GiYPngqoScP5wvq+MarXS+i+bvWnCp3m1+sjWX2Cucr6hDkxejh1EGNltiyDPSTyWvVsvRlyIIkFam+Y1rz3wyK4Fp99nnw+kHyH8RiinYfBn2wUJrA6u/QsWAX7pf9xLPcGhqsEajshQ3dA4x4lnL4X6Dt+WWO04wRfR8EDIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339946; c=relaxed/simple;
	bh=Sk7FXCfhyYx52fhTC+oVdW7154ngTvS7Nom9mMmbUho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsJ9GMSYvDg5WxoIWJgz4kk1pw47vgR+5rz8xrsxKrTzgippHpOaXNzNzXRldiNaNW5W5aNUTVRPwv0ueZjqqUyzTeoK3r2p0LCd7ukMbjMvLPzn4SL966PKCsSOTE0ZGTPXldICjKiz/Gs15ZTFXLmrmQmxLSUPC32r8XelZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgfNfEVO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgfNfEVO"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e39567579so12357245e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339943; x=1761944743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+Cy44AYBoCkgjbDfs6NtFid05XxsG/awplIO2CaC8=;
        b=HgfNfEVOKS3swW31oFAEB+QbtFIFSmrcxscl6XXwLSw7wbz09kksKJuLVBe9EQZhzl
         a7uVbk6JmxCO8h9pFJsdGa0yK5F3BujtAF5v9orQGMI90tPY+8mfpRLj3iFYq4Srh42h
         JyUuMxZ1CElkT8yyH2UxwtetFA453Ss8+0CZjbbfgvF9kYn1mB0s9zUpiPed9bthWZLx
         bsj5pN3WsicvO7n56tVuKmdDXCyGWEeDQFZ4yxwq9UTL3enEcls40vmQABub82xIhpfP
         m2Zi5sNnFrvfqV8ifhPan/36EK6ruUPorOI0nWFWaXq7ZcJQFWNv0Ti9dym/UlwX0+py
         QDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339943; x=1761944743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+Cy44AYBoCkgjbDfs6NtFid05XxsG/awplIO2CaC8=;
        b=NqYr68RutHaTxG8vu0L3E6hboF5HGnuzcRRsURLe1lBj6k74BQ5Wo9nalY+9ci27Zb
         2N5YFnEtPX2EdPBmytcJhliCSeELCxs8RN0aMwr5seux0mY+VTv4YbNLQvibOsu4EvMb
         OB277pJqANjBv4c/kHl3nVcRy7TDc8Jor1UM3Xbmi2EobB0wWVckh0XE+p0ntPVFTsbg
         cduHqoLNr2QeJizuupvsJcugL7wpieydQo4AYKdp2sv8l6ViBgNt6nqW/uGYqkIb4Wxm
         AdLVFsPcfma+51I7PJw92GM9bOttgXTGYAL0lFDKgowmrW6F1Z1bpeGclCwvEr+E4BuB
         4Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCXfTYbJzjW64MnYzzNRBom9RRFiHu/mEXq2Y2HcczDjPZcrzAyFON6SEDXoTKA3G06oeJIJ/tZWXn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0giiN8B4cpC3FjiHYaRsdDDEZqhowNTnqH7JyIuDROlNxRsGS
	Keh9C7dipeO8V7QTSo1AR5WavxgXEbroTH8WaY0fV94ajoHTyl1wnZsiHbTM190BFLoHkCJszt1
	rWeuLFJVpeXLfrDlMTrqhvg==
X-Google-Smtp-Source: AGHT+IE0VF5/lk9M0gB+9FwFwSpgfvP2xoVnB0QJD8xhVyJZbghsyqA7z63NaA5pNd/HN1prAz26F2QKnP+cnxCu
X-Received: from wmwr4.prod.google.com ([2002:a05:600d:8384:b0:46e:3d73:fc5f])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b0c:b0:471:58f:601f with SMTP id 5b1f17b1804b1-47117912389mr234934035e9.30.1761339943347;
 Fri, 24 Oct 2025 14:05:43 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:17 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-5-mclapinski@google.com>
Subject: [PATCH v3 4/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c18451a37e4f..5a6d99d90f77 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -45,6 +45,7 @@ static struct platform_driver dax_hmem_driver = {
 	.probe = dax_hmem_probe,
 	.driver = {
 		.name = "hmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -131,6 +132,7 @@ static struct platform_driver dax_hmem_platform_driver = {
 	.probe = dax_hmem_platform_probe,
 	.driver = {
 		.name = "hmem_platform",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.51.1.821.gb6fe4d2222-goog

