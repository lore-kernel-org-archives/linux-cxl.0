Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207740;
	b=G/m7nLB/D2O1iVxIWXNR26q3aYEVyUWJTx4VMoyNVsMPzNujVzZ/jesakS2X3OYf1TL+
	 5fsss+T5L3oGtAxL+yXGsBawU67ZYHY4TYTTautKYWnrAqiiwPjHSNmu0WqjKmBz+Ufby
	 ZsUT2b3jjBfoBZm+qEjQHW+TWWSuZfnfeRmD4aD7b6AYrAHabuNCV2HBqoH33lbaIXed+
	 e9o/sC3KhvF1l865fIfSagJ/0MkQ8mBZqonpR3Dqp8SrjkdDfwAsqZ85ER/6NGOjaCpSj
	 4Z9GQxl4x0fPnXyL/D1FZabR8XVWMsYzY/81DzpYRUJDZS/oNXG39gqaIOCzrALgRZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207740;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
	b=uOCyO9uWPUCa+sN5DVjw6zVwMmK7C9TzSlZwyq9RKIcvNASH8Ddyb9SnsP/dDt55lejW
	 vxhtreDQ+62OceWN3SJ3eVJcluQJHjyKCJgkNXN+TKsD9mqjD2PdWazOti6N4abLxhEQt
	 6sXlV5ZnY7spVIGi9EHt3l9DhNyuuhUvm8IGXscxqZnlx9AmW51quVcvvZNxuQJy3hM/n
	 acBmdvNEDYrDBYAxEdXCtD875IG1xPPfpCbA4g3uxPz65JR3CbJ0ax57jK8puXtWNPoPs
	 coaS+fzS7kOvxzPYeTKFfSnHpmsj0IWT85vJTupHkCjsPLnZYAOq1ZPNW0y5KKsxuMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZNCy3NnP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EA606A324
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 050EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZNCy3NnP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
	b=ZNCy3NnPihT5CLy/a3Fcrp1QrMmOW0II4PHj2Prsv0c8OOD/nJZcEzgmkOFYE9DqJWCEti
	840fnG+MBgyJ9msbzlsYHfYGhuc0GkbYAqzzOvSk1zT/Xr3dVi6mBbgRtQBclKPD5c5R4K
	HdN+7vxNlDdvg4nPIsN/Lln7GHoAAok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-c8sPlFE1O2OJ_61s6c0nEw-1; Wed, 28 Oct 2026 13:15:37 -0400
X-MC-Unique: c8sPlFE1O2OJ_61s6c0nEw-1
X-Mimecast-MFC-AGG-ID: c8sPlFE1O2OJ_61s6c0nEw_1793207736
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b02d63407so901159f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207736; x=1793812536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
        b=2Xr5GWmumo1ZEHXrKPLl8gQ/Rfrxyy/7LgMELAJ3MI0rVvARxV0w5EyypZdpR8qZ1N
         QV+92Uq0N8Ra52MURiZYHqilmSnQsYzrxGi1S31ZchCK/FR0sTEgDEqNpFZcZhUPGT5I
         LZgJnUWDUOcHpB2W/EvzDd9jGqzydZSr3VBr6rYWJ6TIq7HUnR/TeHGJGPvt5P2axIWD
         pRDTaW8OkWvIWsupWwLyVI0GJrR8St8oJV3sRAC7pydwC0qZHXFhuhp9e5L+Z5QFZ8ko
         YkPwaN9KXxDvDTgP/kYlUUGlNhIhWUD9MjcZ1Yer4ma2LHWrWbHGf84GUfMp5vnolB5W
         Gz0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3apofMgoDceaOFU2rO4VxCLsL6G01kCQXX6iZmPxO8pdCKZjINIb43AG4c5ZuUrH4N2eFv7y5x04=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeD2j0H0YuVWy+q9L68K1SuiH1owf2Z74iltRlCowdJkAC/gKX
	zioBwyhr1TquWGExNrTSrEDLHyGa7sBW96m/V30rm+hB0wfr1NESvzKYj4L/iWHAfEbBKYOeAWc
	fe3ynfap+p5hfpiH3g0ZPpGxtnrTYq7WKLfJQR+8g5seoXgIUJ7fo6oH1GrVSFQ==
X-Gm-Gg: AYBFou3rYB+8a7gm7O5sSLYMD9LFFiZTvFv4H9IB7uGZDP+QeJGK8z8m9t2BTRUWczb
	rnjTjgQlhQJce7vyu9QXN7s4x8bQnl8ibVju47RGlNMgr4XmoPFO5+OGHHqPYSHQp1jolMFXAJM
	gSH68llJlSnJQF6B/gAJZyJZRnlxWZUjHrngODbhVsfSilAXLtuyFqMcswW+cQkOLwhs1OR1gKz
	EidM4ieXWjqMlXvf4ztdfMGohf9YAw212AofEEj41sb5DYdkaHVilce0U7NSgVWczWg+5FWz5Ov
	OrN37CBJkNOgzNmWcKshRZVk6kTnYfOA/26aVqbBU/hfMFqzXPwZzWLTqrZuE6zXrLFkloAo8+s
	5VYNeKbfHOoOPvBGHwOFfF6sLL7qebHHo5Yixd80s
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a9678c3cadmr71204465e9.35.1793207736279;
        Wed, 28 Oct 2026 10:15:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a9678c3cadmr71203535e9.35.1793207735736;
        Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f52e2sm6898845e9.9.2026.10.28.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 36/78] hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox
 teardown counterpart
Message-ID: <a900c591ce1d3d5a017044f34d658b5b632000db.1793207602.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hDGBwcAK6wsyMTHnaIRCWy_aaJYkZhHAy53bB33EtKE_1793207736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@intel.com>

The primary CCI teardown is open-coded, guarded by .initialized, at
the two places that need it: the reset path (before
cxl_device_register_init_t3() brings the mailbox back up) and
ct3_exit().

Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
helper: the primary CCI is only brought up from the reset path, so the
first reset after realize and an unrealize before any reset must both
skip the teardown.

No functional change.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-5-junjie.cao@intel.com>
---
 include/hw/cxl/cxl_device.h | 1 +
 hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
 hw/mem/cxl_type3.c          | 8 ++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b7e20e3fe4..608d05165a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -325,6 +325,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 603677a97b..bc00fec9f8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4843,6 +4843,13 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cxl_init_cci(cci, payload_max);
 }
 
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
+{
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 734397da62..04558a114f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,9 +1076,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
         cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     }
@@ -1344,9 +1342,7 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
MST

