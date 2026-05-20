Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD43E9C1C
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286790; cv=none; b=GTK7nBZVxi+szi3mbJTgQc0ZcbXoutwOGSyTsmr9aGB/rMAWvZs75Tj0n8TSm2QwudZF58kmEaVtVeY5G/P3951YjR69Y47oFmq/c8P4qR7FWOaj/swJplfpv5MxsrTWcKNLZt+drV8DyPpkJh4M9RXlaxVZr3W0nhb+eTgxGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286790; c=relaxed/simple;
	bh=mxxipzClZMji0kkxXkdte0hetv8lEF/b1QxcS+BoDM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je8xDMIQ4ppLkH4u4TNlLrV94/40URhHkEYgXf68CejAZBdkb5ziYX3INh1T2AaNvheo6FWM9j0j7T65/mM8WImj/mchiloprSV9FIsgQ2MTgYC+LPkP8TAFt317RGMF9Q/c4Pdv3rYD3OXxF1E2coEKZOmi7sWNPNPIMk9R4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYoh64A; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYoh64A"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e7c636e74so2518102f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286779; x=1779891579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvfu3jIepwqrR0ib70UOj5oO4kL3iAwaeWevkcT3dmc=;
        b=IKYoh64Ad4Tu4nliGo7lODtL+FMgFtaLeWRzGqBECTTdDrMv8kjqiQ8U8QJP7ld2m1
         RNhUna76aruhEBflHjqV5uHYTOQxa7dhhalXQU96Vx1XxF6Y/k8vVUXXcNtZKZ3k+Q8s
         wHzO57E6QxgMnQ8om6/InkUYr/LwiGAaUOi4KdyI4tyuSlPd9rgWxeWGRiQnO8L0RuCQ
         tjJitonTSDk4ExYwu7nhtz16Y9XXQ63/mlCr9JIlF1CFsWfrn+mSH82roMxUzR+FRMoM
         gLISdLiYKARke6fqJAH980gafi4AiLxS40hEmKCo2eVLQu1YfD44e5ZDL+/fFXRUE2ty
         2NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286779; x=1779891579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvfu3jIepwqrR0ib70UOj5oO4kL3iAwaeWevkcT3dmc=;
        b=idxe0hizI9dEHjMchjeAn5pcuFc27LOZUlwGMzNOP8m8L0iPGMbYxsX8iQoQjaPKJN
         0UWar66efO9jfL+Vsn8wyomuex+6x3pSaaG7JUamh8+3a+Ae4VapW0VSV/kTRXZVU5+y
         BpPphtDFQnC6dQLx7WG8bH3aKuO7jsbCjEGw50zqCRHMgB3iyNYXoxzN2bJbZLW+cn3y
         dCDqGhkTZD4ZW+fhS6dmInolNTS9RZJOQuhD2QH15+w3/TvFZFxRQLBiQa0T89uBuMfY
         8PUXMkYKI7YRqopI6f9sG8rfltp0mUWv31gQZI1LmZZb/wd2DAHy3taip3eUcr4wzxR3
         W1Hw==
X-Gm-Message-State: AOJu0Yw8xR3V9PeI/csRvjwbleSMkr7pFsXGql1dd8rZ1umKmN9rZ7g4
	O0y92wcdICwe9mm3nDq4HNGN5OEEP3AOqK/xs/ZkG15328EYqRr7BuIp03mDEg==
X-Gm-Gg: Acq92OEPXOpHz7fiBaXTrYYwaLJgGWfNjeBWmOAigW4gK3IJuGXlQRX0YIUYXcuKsU8
	fuLTj84297A6sveB8pqDj2+eIMwG0u3Cv9crp5VJyK9zXBkoZcYeTcD/5Z5qxFjaEqorWlPJtdN
	s7Tuz8Ctdt5jgNLDRkG2DKOJ4K08UE+c7+Px0BWROnzGvojMTumitP0T93yHOZEpV/jZTmr1w6Y
	GXDpjsYUiNflqDb3fj4NYPmydZJ2NofpD2Zo3F5nU0gtdxr7W7AJqR6xfTURwVveD7yXc5rlFml
	toYZfMljcJsUuU0qw4sl+sYY/+NYJM4EtSlLSGiiU/UkxqtpIiTlL7wu9rVDXdOTgqbEcN/H8e6
	qzpXNi9R+3VxCAPhSCYsRnbvYVMANOv/IE+uW6tzOaFxNKK6mYMCcCMD8fSdztWiE+o6mXq/HMV
	dvhT0huuO0jUsvB+qMn7tjnml50w/hAh4V4OWIqgLKFfPxQPW8lWWOvj+4b+OTfw==
X-Received: by 2002:a05:6000:1a8e:b0:439:c661:3245 with SMTP id ffacd0b85a97d-45e5c5ebd96mr36752842f8f.34.1779286779292;
        Wed, 20 May 2026 07:19:39 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm55387740f8f.32.2026.05.20.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:19:38 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: jic23@kernel.org,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU PATCH 2/2] cxl_downstream: enable power controller present capability.
Date: Wed, 20 May 2026 15:16:48 +0100
Message-ID: <20260520141816.3240010-4-joshualant@gmail.com>
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

PCI_EXP_SLTCAP_PCP (Power Controller Present) must be set in the DSP's
slot capabilities for PCIe managed hot-remove to complete. Without this
notification from the guest of removal cannot be sent back to the
device.

Fixes: 845f94de78c ("hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.")

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_downstream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index ec450d1aa0..6ba6f1aa52 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -228,6 +228,8 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
-- 
2.47.3

