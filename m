Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3230CDB3
	for <linux-cxl@vger.kernel.org>; Thu,  2 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411150; cv=none; b=B7l9QM4LgCCuOd1BD/AZkfVnbhYQMvPVIgnXNzD4bHcYAkHgjuQkEFDTdzoFbpMuuTPwePwhvDPRZp5dsukj35y037XoaOKOsnprKTXnCVdIV5z0B6FGKrPc3OV/GHQ81+XAxMjw3PwnTOBBog0QzISjjw2mS0q1Ab84DmpnLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411150; c=relaxed/simple;
	bh=ppas900mz8UZ1nAze0k0cgvVf6bsDr1n1l1Zsx5qMIg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tcRWU4ByxKJGprxF/04dztzOWmvPgdz8JIAPtU6M4AQ7RTsSwEyeYDBohkivnyFJSQpK+7Fd7SBkoJjwoYzGiAP/hHF1VWtZAbg5ue4r7043xtOpR5yiG7mqfaPQ3Z15/HMv165mFAegCfbV8nEURPu5M1G07gS+r2JJp1Ea4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtOU6QpN; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtOU6QpN"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb7338319so125234066b.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Oct 2025 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759411147; x=1760015947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opsuLXZalKgBtjjtUFfr16++aW0WmcWbDZvURSoXadw=;
        b=TtOU6QpNzv8icRxuaer3wPSVs9Qa9NuKzE9tzfCo1FhmvmFadrFWAI7ZcsFT6TDBT6
         4SzD0ioiXpkMgvuptYr43XoEQ3VGmnlvcQpqM4YCZUxqWpDjqaMRCzyOCvZuMLDjUzCc
         TxaqTVUXHLEwZuzj2/1OslrZXqvRLnGWva3h5dz5+X6nUPsNNDhhPLnuRoy5/uO012f9
         XnduKcQJyheRt7xLY87Fx9WC6+8t8oLgGEMVrU0w9Tp4M0+XI21rbaHzItQYtVdE0doG
         GB1Z07riVjSAZHus9SiBlTs3APCdTS/d3m8dAZI3ZFjMkX1iJU3e1xh0zYAUdEWnG/vL
         kNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411147; x=1760015947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opsuLXZalKgBtjjtUFfr16++aW0WmcWbDZvURSoXadw=;
        b=KLIdjIeJ28Sd7/mBPJtPmjVj0xsa40IQu5+yaVsBG9yuoHuKN2rWy6YDwIiF3eFBWo
         HvNNNWjj49FH8JZswej08qiTmj+opqBKbckgRmOnsQz1oMAxW0D0hhZvITjMoaiwPGOY
         39Wu/sq8CUOA/F0v+g4qDvdeWRYfgIG4kiEYuz4yY1m3F2UwTZpGwgyXYANF6N2FlvSq
         YRWhFQyhUJXg6Ufw820+oAYwKc2uUEHf0l07W7+r7lNgGfIh/Mek30xYncmFahmYs97t
         mKotVG0mqZ6M9VTpk+95elGp1/1noU4+7vZaCHekZQlvEkJ6Lq6RNwLAn11QLCsbBeuD
         LzJg==
X-Forwarded-Encrypted: i=1; AJvYcCUNDDh3Jd5tMOvxpgeVHLFGPDtdQUkZAn7bGMaeuz5fxEP/ME6XgDVJ2ankbsk33aHgh70AUdKYpp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmv+HOVQxq0YpXJ9SSSyTxMUVuc3YJIERHob8Gi3ACxOeC6DX
	l+jG0qK4EYuUTIu3PJsopOU+aSkedfWSC/c2zdahCZO/XCaUTsdKnomBDAwZnUZpXp8ah92aG/k
	wQ56EPHNAavYu851ffhzv8w==
X-Google-Smtp-Source: AGHT+IEBOtinBILzYUipbzKT6uP64K+v7i7D/BSugv8X6CMyxWJNMehP5LgieusjsvQy15d5i9FRZHYKNzdUhUgV
X-Received: from edqh26.prod.google.com ([2002:aa7:c61a:0:b0:637:b54a:d88e])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94d2:b0:b2f:2c8a:680b with SMTP id a640c23a62f3a-b46e7bbb560mr870743666b.58.1759411147168;
 Thu, 02 Oct 2025 06:19:07 -0700 (PDT)
Date: Thu,  2 Oct 2025 15:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002131900.3252980-1-mclapinski@google.com>
Subject: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Comments in linux/device/driver.h say that the goal is to do async
probing on all devices. The current behavior unnecessarily slows down
the boot by synchronous probing dax_pmem devices, so let's change that.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/dax/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..737654e8c5e8 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.probe = dax_pmem_probe,
 	.drv = {
 		.name = "dax_pmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.type = ND_DRIVER_DAX_PMEM,
 };
-- 
2.51.0.618.g983fd99d29-goog

