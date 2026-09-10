Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361539098E
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071273; cv=none; b=iPLojSipFU6f6a12oMpCztTBWaciqC32TINowJml2O7VoKfG3ms1PNLdFQIhzB+JlrVtZsrx18x+CcGphofL5W4As1vZItCcX6+igm7fWTQd4Fh73Oe0lgyP6EIGZQA7V5mkgwePp5FXp8ldoUmT0m0IUTODbqjV0bwcjhxFLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071273; c=relaxed/simple;
	bh=X7HnfhlJzA2LwzbDSd0atGna2BdJArR+wvOEkFwcIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AvRv+J2mZiewnYAV8e2UYMAOYzfgo/SqsHOKN1Xmy9DJewPpZfK7YzTjVD4WjdLzCzL+F3NmN3JpTxiGSGOA9Q0qZfyC91hd2enSfqn0RUk1rCjV2W2pEUt8bijg04AOB7FBJdUqexEWGA6/jQonhffUnWzI8C4/zqYZm9zlTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByEyjqnL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByEyjqnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789071268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
	b=ByEyjqnLbpwqQz9pPUXhTa5CdFo7yHx6LYqdIgG015sx0srWbm8ITSEVkpt4wKH2CVmSao
	KEOzLRELafwZR06dBzf94aSXHkVMuDiPC0iQPeoYHcKtUj9L1nQDkv26KZeeN4F5UKV+eI
	a+nqEpKSwM6F04K2uOeukvJem5Qpvzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-uO7JmflkNIijPyTBGtO3IA-1; Thu, 10 Sep 2026 16:14:27 -0400
X-MC-Unique: uO7JmflkNIijPyTBGtO3IA-1
X-Mimecast-MFC-AGG-ID: uO7JmflkNIijPyTBGtO3IA_1789071266
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b7c1dcc82so1280935e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 13:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071266; x=1789676066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
        b=dEUrqH9K/Bi5iip+chEdj50AbWLwvJltapFxCQ8CkU7sKaDrR/FPdznlF/3qMdOc4a
         E1OZbRhmpw4k9lqgDt4cbKQmLBwcGMhBjay1PkjmenMzjqXVd/jzalBOCt9CtR9mttxM
         0TPWB2Jgpawzr/7LTGo/gzLcSIhuFtWCxdetycqDcNyb47767G2/jFTN99auLSUZTW/E
         7v1lHZOSC4Vah8cofK19wHxNO26w3RCHEks2P1kbea+pIdd3qVanD4PmZKTq6IoTh65E
         qyXUzHAVgXtg7vVxq2FSghWitre5o7co6WUGM1FY6JpQHd1dWHQUUvTto63SM1ArpmGN
         21fg==
X-Forwarded-Encrypted: i=1; AKwUvBxn+vN8E3MXOTKugJogGRfrr6j9n7fDMNK07H51ufsjJSkJREn+poGEy/rqLz8FJisRvauOTeFSADQ=@vger.kernel.org
X-Gm-Message-State: AFuF++neDJyxxRZcIQfOWsvZyFl/NNF8xCtTpte8d23P/yJPsrx3MO05
	amNQhmotaGPM5HZbYuHYtMdm3LO0v7Eg5ACRBLJvXcrykoe9aEQ4b8+3jxKoZULIVRXoJehLJkN
	C6ExIqJW/yDUwPBApAOlWQmWB9zydCE1DPceeAowB2d54czbNGUKgbWO2S7mHrrE3HaseJg==
X-Gm-Gg: AYBFou3wervSMrlFacjtDQVen+V0IQi/EhIbS6vyHHA9LdWm5KDgZGDzXs4ClDi5V/m
	2thteHZTMtdgLANnhngGx0XJAviwWtkDwXtXyISF9SbNuw75UzG9EjHSdlNHGlI6ITrDTQmdhSX
	qzgliB7KEM0huvappQiR+UTJm5byjUcRhZ7Az948h8j2nTdyYuBZVEMfR7wMJvK31GQvpJrxXt0
	8AdjIR+PVUyVKvXLOTAjoG8pch7Ighz5Fqgr1m4/JfWVlLXhGHBW4+xkc9dnhPK6QBPI7kqwvJC
	8zJjirQDLV/gKhcLrK7O3d4dMvjI659rqmwqNYSV0Hhd8O4iqUdu73xNpWHuS/jT/9Po2ekQ0R6
	Er2zZqWRZ+2pB6UxFiC3kkH8=
X-Received: by 2002:a05:600c:8a1a:10b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49e6198d0a6mr6071255e9.9.1789071265706;
        Thu, 10 Sep 2026 13:14:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8a1a:10b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49e6198d0a6mr6070975e9.9.1789071265196;
        Thu, 10 Sep 2026 13:14:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm104182515e9.15.2026.09.10.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:14:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 70/90] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC
 when sn= is set
Message-ID: <aec100794247860605cf259effc085eac43d0e8e.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zJ76Mwj01XZAN8CJBQqijuZcKxDpUaIWClZOCcuouxE_1789071266
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

