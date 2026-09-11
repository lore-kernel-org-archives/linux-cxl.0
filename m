Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D546AA64
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117422; cv=none; b=EaE7bO50uFVpBdptM0wS51/nyT9Nona8E8CZPMa1z182tsE+DQrrRriSJw82nVBpRk4GrsxQ/1ya6/mikvgTIL1ThsvJBKX3WmcnxxuaTWu8nsRXTSIRcl+eAg9BW87hiszY7XlxmmcaRSU3IlPPZmEEa734djcCTyef264zaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117422; c=relaxed/simple;
	bh=X7HnfhlJzA2LwzbDSd0atGna2BdJArR+wvOEkFwcIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O5uPfyLZGnJzNqdf9eHv39Mdpy8GgZNisvN57UPhSdACtBlgvguXgLdwVJa/DctteJc4RPIxAlRjZpeEi9HFIjBdR0Kvo1vqeL74ypbAO0b7cjUhkElobMx3JWLCAGJQBm0NRT220vwupT1CszRCg8MNlCxuW1Z4pl8cv4I4Xu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz/PLHf7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz/PLHf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
	b=Fz/PLHf7ZPESHBsy5CGyRNfP14EmyNrGdX80fv10Xb2TiRsKbQtqPDJks0cqky6Vyll7ME
	VFtsW/vkSBCw5p7X8YHwwKeCSs4vrRGxlVultCHs5enmWTd4TesTmsoR0+dDOzuaod4CDO
	nol1rmU0iS7AsK0l0IQtlwOrvNBk1ck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-bRaOPviwO5W1fLXN-lQLeA-1; Fri, 11 Sep 2026 05:03:38 -0400
X-MC-Unique: bRaOPviwO5W1fLXN-lQLeA-1
X-Mimecast-MFC-AGG-ID: bRaOPviwO5W1fLXN-lQLeA_1789117417
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d156c917cso11792745e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 02:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117417; x=1789722217;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
        b=PWehj9oupEw967/C5ABY5mUuhbTi9E1BTjSNUNU/4nIeThWYLdj4d1TlHeJ8Q5VqRQ
         STuzjD6pUbRTvhsP9RH90mC5S2zBQVvIiLy8kPsfoPbQwm9J4spD1azoyZI62N+qZATq
         4HQAUvM3rCJtFw/uAqaVhyw+2wUxAuWjIhxRx9N+YPHB/HymLe7ybSQhXKv1HbvuQbr7
         439nBBgX+wdmFDhK+c0gx5cGImHDZ+O1J9bBBW8xmEZJ8PcCYI4Sj8jlCFnV3yS3Z7Dq
         BgjDWvu0klKCeLhVTC8I2865+V3nFdJEVFYzbZ+/3wPSoHOBWpNcDTXPYaSXSnFAdR3G
         O1nA==
X-Forwarded-Encrypted: i=1; AKwUvBwYCUZTF3slAXlVBEmogM/Vq4Lefhmvp9CiSwVtPa0AEV1VpwzAJCABYToOb/7U+Au924SEVs3JzPc=@vger.kernel.org
X-Gm-Message-State: AFuF++n4efrD7b80HiYa3FxjXntmNSN8yueaFqbl8ENaqkBzzUiN1M8C
	kpSVUbvfJf1+TL9QFkdrW02CDbIi9e6H/OGnutBK/1en+1S3LcnZDAOzjskT901kpESplPBfe96
	ctkH9XCzdUyIr5q+QPKSfGcWDBHie0PPNmBnTookFt7QOMnI3dhR2bi1w9m63TGOP1OOa/Q==
X-Gm-Gg: AYBFou0Z958YzDZB72Rx7EQX+wX8QlluNB34GSXTUGBxm4d3ZcR3m2H1IjXZFYyaeV2
	1mL7wcKGnmLulnP/FfwGrx20twoxG5nouRExVcNoicOMXkMM9D7yncQaoydYQ8MHtTwtD+xgNII
	ukbWNdGkYs+TyYQlZ0QEEL4wVvqlFy822FlEAP9EiMMacfoHNhqg0ajgr5YNbfYkJ1wzCT5Yg9y
	i0vQoEU0++zw/RyKAwhxc8D26A+E5SEmyCoQ492451zeIAuGH9D0QUoelZeiN2M4FXYV92QoB75
	bb4coQRjn731D1T/fN4lwyc4SVLoRNdg+dmMkfR0FQEMzBmlZ+xaKbHmr2WJQyIeE7a40Nnhmim
	b5RupPFV81tykxJ64hs4ZKNY=
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr37822385e9.9.1789117414252;
        Fri, 11 Sep 2026 02:03:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr37818395e9.9.1789117410371;
        Fri, 11 Sep 2026 02:03:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60946249sm69520125e9.0.2026.09.11.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:03:29 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL v2 55/75] hw/cxl: fix the CDAT DOE overlapping the Flex Bus
 DVSEC when sn= is set
Message-ID: <c9a5fd358cccd4c1616967973aedf39973833f85.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aBvf-SaGwTCzB5dzsTbURYFoxEDdfhnBiz9zygT83hU_1789117417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Junjie Cao <junjie.cao@intel.com>

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6f44770db6..a04dc74ecc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
-- 
MST

