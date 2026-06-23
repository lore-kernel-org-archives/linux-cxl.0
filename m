Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA33A8FEE
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190553; cv=none; b=MErF9U2aFs8bvfpj/eKskMjzeRGvU035hH7akjTBbPLkJ4akBhjBEjj2vH5YygBQapG0NYO8kRp8sDvroJV5fHZjVsSkUa4JuNUKaI32s78PjbiFnagZsArcBjXPxxEQwe1FZFOypKTagM2Dkuif65vA+i2AjyMdkpVDMFPPrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190553; c=relaxed/simple;
	bh=dOOuhz0gbslsD4ST8T90RiWeq/7Jv/QR4cCMBYVI1hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smRcS7DpX/7LeIMvn0QgDAC6I7Ui4zn3opljJZknNwB1wMJSGMFiTUWZrPZ6duTieGwoo09hqYrCPA/Ua52/CeXlcDHEXsMDqKhUVYSBCVByi3up4lwTHy1FFBqjmfFuwP+GIdj/TtfKSbvxL5DK7bMflkPGfr+w/2gQ/Mmq3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5g7aXWG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5g7aXWG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so2115236a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190552; x=1782795352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFkOkaN8XWyxvc+VzvECi+ZxhC9H35TOQHN9OYiWt/E=;
        b=c5g7aXWG6OnkRxu7j/T0CXq7snxW9d0lWuLsrpRhsp5tZua8CXoToHbdtlJaUGIKyu
         XXwSUTgRIcHpy2vEe6ivFPM+IJohQwAMP9VokzBwrUEsdPkUNjGF0DW6Xiumz4krKmyD
         oGcBU78604WZkviApyN+DTVSmFHm7XO6mYJXUBQubET5EZwKUSZNlocUzLOAFIwK3A4/
         JWBk/EEaHg1G+d4IHFCnm5kwiDkf0x15k7gBeMdpT7tPvFIk04ADvinFc4T9rAHG3c4X
         0M2gnX4jQc52aleKN8NazNjh4CD0/YqLhha2WqRWriHnAXIvy7Z49p+juCXztix8TvxT
         05YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190552; x=1782795352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFkOkaN8XWyxvc+VzvECi+ZxhC9H35TOQHN9OYiWt/E=;
        b=s6BSFp1WeBNyD09Iw29ixzy8Anjd9JpQ83hw3xrA6450usvHN5vbHy86g2F76sMU0E
         rT9XM+QIFjj4XvLnbYQCUiEZevZo4FPV7f52588DnT7ROtzhKNnh6vIroVkJoum+oVv6
         F/cAZdKYQDWExhaN8Craso9T631/mZzY5CEGUBlaTOZNwm9TL+CJ1RmCFEgjS+6AsuuG
         vx2YRvxEtVFYBAMVZWz3fjQ79Sjw3WFhmZRMw/YQs9Yz5PTQZLPfGEIdBeb5wbkyQFct
         WgEEpQiy8g2pHpATjqomgJeZhEUq3oq3+fR0YcxPVjq6gZ9wioss0p5ULWK76zKF1+r0
         mL4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3TuXq5cGL8e+iLHgydOXVBaYHLPW1Tc6wu6uXElRkLtV25tc5oa2Kn4PO4jYYITZF2nugOkyyHfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS1WjZyORu/odn+xlM+8WSyU7hWd2Z/yLdu5yJ8ayzJZXAIKW
	HIV/5QINO3eXpkpuavX1tVggmSwyiH7/Wh1rzhz6UGeUFFT56BwUL+YgRlyRsQ==
X-Gm-Gg: AfdE7cnBjlW9bdj0P049tg+voNXBdcLzC3r2zc5mqEE+O2Ej/q9U4zwtGYHMMI4YE+b
	oRBilOFfPmow3/s26qiAJlvreCySb1uZT06fDcjx3jmNB9MngSyyt7b52nJ5siwgUgBPcmhI9/G
	/0EFjI8tL55KOGaw5QLlN23w3n/EVhzvk4mmCZolXPASgAWEprOwRLmlwjgtv+ipxP3WanuhSs0
	C7yr8TJwp5p1zUbmxC+4HpoULOMg1A1hrh090QF6p0HTCO20ABEj2HZzYPtlv0F0u3Ffr7ER/Gx
	dhXA4FzP2uYr90wFRRK8y7id6jfaNwkL/mylov8x6N3H/pj4wu+pWkQte+dQoaR+iuJ1xIBthyW
	L3Bd1fp8McHlwP0h5nRLjWGxsAAx8bj2qiMs2lJ/DHp0nzIBAvJc8ov1+1SoQ07dMuAC4WeiLWA
	JVt/c7FYnr7w34UYsbZdu7NH/5EYySLLbTdbAHifcH
X-Received: by 2002:a17:903:32d2:b0:2b2:ec46:dfed with SMTP id d9443c01a7336-2c742b5ae34mr136450075ad.31.1782190552159;
        Mon, 22 Jun 2026 21:55:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 11/21] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue, 23 Jun 2026 14:53:56 +1000
Message-ID: <20260623045406.2589547-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_host() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/pci-tsm.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 950e2c36a4ca..80e76ecefe71 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -130,7 +131,7 @@ struct pci_tsm_host {
 	struct pci_doe_mb *doe_mb;
 };
 
-/* physical function0 and capable of 'connect' */
+/* device is a TSM host and capable of 'connect' */
 static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 {
 	if (!pdev)
@@ -142,6 +143,14 @@ static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		return false;
 
+	/*
+	 * Report capable if CMA is supported, which can be supported on any PCIe
+	 * device.
+	 */
+	if (pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				 PCI_DOE_FEATURE_CMA))
+		return true;
+
 	/*
 	 * Allow for a Device Security Manager (DSM) associated with function0
 	 * of an Endpoint to coordinate TDISP requests for other functions
-- 
2.54.0

