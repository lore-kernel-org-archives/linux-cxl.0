Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207742;
	b=ekzcyIF6wpEKdVgGJBujlSyfu37H/unBlXlGDe42Ppcgs0BVBZPRyxtLUFV1Jpamrr0S
	 CNC2X0Mut7cyzPOMgn7u9HENrzTZcVVw1MY4jL6HUsDKX3ylymMxov4mTGeMe0oGlvSDN
	 4KdmhiBG17N89L/v2hVW4Et79CaTR1UWVbaGydNtd1R9mAVx9fZfiposgUqJGMszYG5dH
	 Vb9ozbjvWBwFHDZ5TAVauyOwmThD9CR+6itLqyMs6iY7jnMyHKwxyt/9fLkWJlUhKSCwa
	 4Ekbc+DJaG198SuwzWoH6w7atxDsdleQ5sTNTzUzQ074vxAdWdnGn037kuuy22yMjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207742;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
	b=Yof7ngJXLk7vEhM3oJblRHD8nJMkVoCAa+jGHT3XbZLZEKuK2VAiEbFpitCZVMoYvww5
	 NLBDalzSCb2LIzSHxOPORBJ0b/cV9QbJIsXauEx0JeqaGOCSz1BdELroUZ+qMNj7ZPaEf
	 UxQXSLEud23LRJOy3rG/QhHTygcRiL9i0+HLo7dhWS7r1wNSOgRcKp10aMPn50Ic5MOtq
	 lyjhGOq+6yc+PbvsyLOIirw63nCjHaoDP9IyqfdgT2Qj8xdy7wZYebMgNAaV/nislBE+9
	 7tnzaEIGcdZ2BH0JSwkhqEmLx+QleT0exKfXWWjszxAOgFBYeHQISom+SO435AKwJMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T4e5F2Ah;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A742606A333
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A742606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T4e5F2Ah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
	b=T4e5F2AheW0wySP/Plot8PuJU4KANy9PwmSaiZKhIB4SevldqGbTZHPSh+4gYSZ8BCeTQA
	2te9W13/7bB4+13+/bfZAPPulNg4vktZJwtQ4wY5XUm5cJY7zC4XnjEXhqgyUDzArdLPqc
	OGQnh/Uc5jW6K1O8Y8QHYc1Mab5qvoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-vIEeoi7AP6usF1F2SUpV2w-1; Wed, 28 Oct 2026 13:15:33 -0400
X-MC-Unique: vIEeoi7AP6usF1F2SUpV2w-1
X-Mimecast-MFC-AGG-ID: vIEeoi7AP6usF1F2SUpV2w_1793207732
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so833272f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207732; x=1793812532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
        b=OxrA5dhfIEqmN5OiY8S+6slxH1fVitw2c5wkWzw31MhDyEC8LogNmo0abF8BEwVzXX
         Wnrxrwgv32Gsqn/6DLZbwSfc9ON5Fz5yZrGPjbxsaHN9xNju1uvIf6ndZ7ONfApUgfeG
         yb8Xgd3Pptp9yzKcGuQbsKszp8lemY+0yGGzOWu6K5rcd0AsbRdQpDR7UzUMBku8uj/v
         0692mC23QwTxpWHzRoiI/Sq+aSqt/A7izldHeREq2br1tptHQTVj1VLFIvC/2kOu7awY
         Dz/1e7trFEgDAHq0KGpVCiyTRnSTZ34QKDR1pYGOZQFyu6d1etmvjBGpuZpMwEKzkRM5
         eK+w==
X-Forwarded-Encrypted: i=1; AKwUvBxGu8rqpa6fr1FzfW9qVhCL3xA3QtDSCCQeyv3XTY/4wSoKFkBB+8vg3Cz5Aic6D39lEC9Yzuqs19Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1Ij/PmLNl25RKl0+2gMmQ4KUqmH9uRw3KGk3NM8k/Ek0UZwdk
	83OvG+xTeWoAE0wEM1yjII+4vsILBUSB3dYcnPuUKxq2ju+HE5pM+ZwnIUwxufSYlqvMVqCLlli
	1sVP4nsLp3Q4n/32nnmlIdOodoY9KF6sBKO6o8t/qq/if8v6UfJ6fQuYLK0FZOQ==
X-Gm-Gg: AYBFou0Le6XY74dfTNhUmewBfONiowI8e+wac+krRibPLLmQqmJOJfylDhhLJ1/5auc
	QCPtcT161oCjtD0Xijr2IQ8zlwmQhCkiAntIZ8um/BOTp+2bKjokOktz5dhFChw39TWUoUqV2eK
	YBhoRNh/WZSOrWZ/+OFtdnBxx5ngLGnvs9CH2j/DYneTm19lqeed8fRwAs+otgeAwJQ4R4uQhDa
	gMDwRx3k12MTfg0WX32etIrU95fgYE4wbZ8/2bumyuo/v0JDXrOMjNKQru/4d9ZNjr5uzQma0nI
	TUACdbESGmI1Ie/UDmJqY3F1gHeZqnKMKeQg2y11g8DlYiARBLzaDYg7TlWSrgPPE8GOM5blqeP
	U33Q16RN4VUyr5+/ZKObkscbuVbzmXRPWgdBW1rI7
X-Received: by 2002:a5d:6512:0:b0:48e:82f:48f7 with SMTP id ffacd0b85a97d-48e5d5b565bmr5621178f8f.10.1793207731474;
        Wed, 28 Oct 2026 10:15:31 -0700 (PDT)
X-Received: by 2002:a5d:6512:0:b0:48e:82f:48f7 with SMTP id ffacd0b85a97d-48e5d5b565bmr5621119f8f.10.1793207730933;
        Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3da7sm30955744f8f.20.2026.10.28.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 34/78] hw/cxl: destroy primary CCI before re-initialization on
 reset
Message-ID: <ae32a69fabebf1f0805786085fe98d6cf32f8946.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: On3HCvR7eQ_vuLlB93ZPC17ghACMTftL4q9b0AnJ65g_1793207732
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Junjie Cao <junjie.cao@intel.com>

ct3d_reset() re-initializes the primary CCI through the call chain
cxl_device_register_init_t3() -> cxl_initialize_mailbox_t3() ->
cxl_init_cci(), but never calls cxl_destroy_cci() first.  Each reset
cycle therefore leaks the old timer and leaves the old mutex
undestroyed while silently overwriting the CCI state.

Per CXL r4.0, the "Mailbox Interfaces Ready" bit in the Memory Device
Status register (Table 8-212) is set after a Conventional Reset or CXL
Reset once the device has re-initialized its mailbox interfaces.  The
CCI is the software abstraction of these interfaces and must be properly
torn down before re-initialization.

The secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) already follow
the correct destroy-before-reinit pattern in the same function; apply
the same discipline to the primary CCI.

Also destroy the secondary CCIs in ct3_exit() where they were
previously leaked at device removal time.  Guard the primary CCI
teardown there with the same .initialized check used for the secondary
CCIs: the primary CCI is only brought up from the reset path
(cxl_device_register_init_t3()), so a device that is unrealized before
its first reset would otherwise tear down a never-initialized CCI.

Fixes: cac36a8faffc ("hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-3-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a04dc74ecc..363ac632f9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,7 +1076,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    cxl_destroy_cci(&ct3d->cci);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1331,6 +1339,9 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
MST

