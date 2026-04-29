Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6B389DE0
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471084; cv=none; b=OLq5VOAg8zrr7qFGywJIAdKoCB30z9ddgEafN6Ye4H3AFA02q5/chyuDR26JS2LaSLbcNSgeCs9fvTxojGryL3Klt0QQjQXTU2L8eozcmrOFUwqotRkKOvh6fGKiHW/q6hGnjf1V3kxEsaJZhas4K5dCWGPW0k1uk+SVdCJRlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471084; c=relaxed/simple;
	bh=TbPomO6kUo4wxdHaxi2XNuJHFyTeCnmUfN0Z/QTq2HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdlkhXaPtFe2FIsWhJcNfnA+9JKyBrrzaxS99E348+YtHK+qrTlRs0er+L25wmcQVyDZ1AxOyXg2k+lbS897tWzh+0PImhXR2kew/yXyDvt1X+oh2pvQUNhLiRU9a0JtOwnO5b2F3TqNH2o5dPsKu92DJtyLU5cWwHcv+wX4+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp40hmDi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp40hmDi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so108817215e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471081; x=1778075881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CbYkDBPpXawZZfXwyECFDKJfotfIOnbxLhrwBo3n24=;
        b=jp40hmDi5MPMqxPZ6ajVLApnSxKldg/PGBj52EV+sODNWons8Xv99ejHZx4VD5BKb3
         f0RuoELM6FVVT3eFbn/faS2AerKIqDTtOXp+0svdvkbWw25x85ugopLbIiV+qKRuAywL
         j4IVQicVgdmbawY0DSxKSTrONuhZ6CNDp/B17nFwn4yhEbkKqHBKF/JUerztQsfHQfD5
         j/HhlSGeYPSasmF0F1aKmmsiz/7lb55h2DGFGasTRugwI9TTwaUsUjOXCP83ALyA5fQb
         REgefboA017F7AYCT/6kVlx/BSI2dOBIymmCP2DRBNGA6P7smu1EWk/BJtZ1yArB5u6h
         VF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471081; x=1778075881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4CbYkDBPpXawZZfXwyECFDKJfotfIOnbxLhrwBo3n24=;
        b=jrjDOmGhoOGtSeltJohzwaXCAfdX054+8yfebqgFe6CcqrrSTi5nHOWlWz5TRfbi+C
         dsyKoKWGqrkNqGXTGEjxK7VIy3bgi4rDzRst4/9G2J+lApaPZvMeemny76Of9xenF+jl
         jAGJkwfKDkYCwlBlI8sVFTgPQ2E3ue4lMcTIPilKGYRL26elrmE9YIw8RDHbPmKRp1O+
         HM6F+eOMbe9BtZ0joPE5oQKahlbLiAw4Nsq1jp81A1UuKMtVmCqEkcEQDb+RJOCK1YUO
         2qXXGyL8Wd1zYHyrci6whq/hJbKqcRlw0NwXNQXdAlouuu1nNeodhRGBM7ixUaxbVFZo
         kT5Q==
X-Gm-Message-State: AOJu0YwKhGWpiX8irIOSeHWtx6X7CPwPEl0ugRbkpWTzS7cgye7ZMMWo
	CyMwRoCsASpB6Mq9LsJA5Xpz3co6UhUUTZzQY3ZnslzX/6akmwrBWh0txCBuu50k
X-Gm-Gg: AeBDiev4hCdrhuL4BUCMgzroMyMN9577n6N2vikt/mcfacmS6AoEixhJOoZy6oEfrwk
	zu/cj21YUc5v++HQdKTx5pI4EkVBkPXIdjdUPSjZmHLs6fCH9Qt8oa/lRKJYA9l7uyS1FKdUzJU
	sfNFB2xVLqr9cGZptEKT6RLpviBMex/4DSToLhpcUxyUQU2nFlyw7Ku8WWlO0ZzDJRB7dOxqROP
	bpKBRxZW8HYzWnmHKIo47In07RirlSKhvpWWl448wD596cwnrvSN+nEo+OhPhtICEZA28bQq9Jh
	JoD5tapMm5JO5yJQmTZH/roHkVnP7/iTcOpt6MFEMY6RCiuS+HlvnqMZbBm7I6eyifdlydQQgKM
	k39oCyGovmqapUXNbGhFYm7ytCR6tzVDPF+Y7fERGvJHQIpfrmQ38APPrfC8iLrN171mWVNDx1X
	GiuDW0QSAHJNugzK4xAhXWt8omj7Wrp+50Xg4J9qmCP0Ua0zE+kTCY/dO12rqu/WSYjOOIUVBr
X-Received: by 2002:a05:600c:528d:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48a7b546b7dmr72438825e9.24.1777471080538;
        Wed, 29 Apr 2026 06:58:00 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 04/10] cxl_downstream: enable power controller present capability.
Date: Wed, 29 Apr 2026 14:48:38 +0100
Message-ID: <20260429135717.3048713-5-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
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
device, so device listeners for unrealizing will not fire.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_downstream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 91c5e6a605..5322c46900 100644
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

