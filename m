Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779AC219A69
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710441; cv=pass; b=AtEHX14bqAGzFeB+cUwtsDABhcvcY2lQbBDpBEe+ICU0fhBF72xQMq8pBzMu/JCOCr4ZYkVYifB/LInsWaqYO5u1nvnzRkdoYyrNu2zTn004RWycSFgRdnriSVb85OLl8ksry+ez0WFvaMYPtl0fzdHLPIvMiVoaImuvFFG8yBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710441; c=relaxed/simple;
	bh=8/0QR5H/0ugk4v8OOMgePGi1P7spLl2HnKm8pyC8w1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnN/DJ2Gwie2g9xv8y7d7nyCoCGP04XyGzeIG6t1jU8qrui2BJoR3pNLHLVJ+So+43gr96PsdTTLUkU4KX4LbYuQPYUpB3k1WycqV24Vx0mWUbH9LCPSV10RjEv0PAG7CFf/byty3UROkfCXYnfWHv/utdMD1lrZItBEMVfoVgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TRBm4wEL; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TRBm4wEL"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BCA48165851;
	Fri, 20 Dec 2024 16:00:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.98.215.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 621F71655D0;
	Fri, 20 Dec 2024 16:00:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734710433; a=rsa-sha256;
	cv=none;
	b=BB3XHZ17FDOuKTw4SgrH36nwGy3WXR9LCD05WDj9qw/YCWAQ3Bk2O4TKkpixHF0VwKoLoF
	krK/byMOZi+SMoxYJKvU2zTjv3NjG2c8CoFMkEYonSyG9/PvN5z6qnWjMqhQlzL6gqyMJk
	Pcnk4AaHICbbHGy3GTgfhQ8G7wn1tatf1+BdTQmqfaJxqRxBFaI5W3RwEZzStjMlYJKjx3
	OEza9YlowtsSGP3FAQ1CghJ9XoFIXqNBSsjS0FF3h/gTDfxmsYCoJaIMpTeUbVDeP2WVz0
	XndAz/n7AGPdQ3s1mPxAurLifbhwxjmf9AG3pChZ2wveybwdZUNXWF0bTvYzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734710433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TPizwOQH8wCyHLTQDm0tGrZNM8iIbC+MwBmT1B8AqQ4=;
	b=c/4/n7R/4NHT6GM5awZVo5OOhu81PSpqYnwa5o03ucl4R5sr8pmRgduDTuWzcK1qYfyxJz
	lzaA/wMIyB37aVwSBteuEs4YfK6R5BSuvrq9koZq6TZy8aM9k6MDDHO4ftzBIBrk3mzWlw
	ZsfcjE1Z/CRtP/8h0Y3GTC032I9ZvgBrYiScmKFmAvIUYDMFCacnhJLz+e466z1jMDunLK
	/hcg3bB6onulsLz2xSsoSWrC++aY5yS5LTJyPa80n7WHjkPXI7MCCvHUWjZsieuSqxPfsB
	fi0j5iiejscceSxZH1JeGn/9ec4l5YoXnNh1JgDiuK7zBK57Lpj2spUXlpxToA==
ARC-Authentication-Results: i=1;
	rspamd-56bf78cbd4-tsrbq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Harbor: 3c49838440615716_1734710433644_3144172135
X-MC-Loop-Signature: 1734710433644:956789053
X-MC-Ingress-Time: 1734710433644
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.215.189 (trex/7.0.2);
	Fri, 20 Dec 2024 16:00:33 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFBw05v8BzCv;
	Fri, 20 Dec 2024 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734710433;
	bh=TPizwOQH8wCyHLTQDm0tGrZNM8iIbC+MwBmT1B8AqQ4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=TRBm4wELa3+rCyHCLsHUxUyCHt5b68SI25y02WVUUNbtpVBI0+V9WdnAOkyBLEUA2
	 wQUd3n8sT+8jhP/Ko+YCtDsZ2ghn/3cjBw2omnFwGpNfNOnOGp2NtzaBftA4Zy0Bf0
	 OB1scofMXs21cu+XyGlvB4Qr/wDWzyxFyKLOKXVj3+/RkJz80DVUK7X5et0mI6enV3
	 HwEo33QHvicrCxjH2dQy+cTJvyTKa5wUsU5J0tbgSPLDaGEEBaKTMxNHUGjXHDPfTX
	 jRQwGiDV1tJv8sYMC1Hi+fjR7YXy3hcPAZohAEYsOPUSR18nrNIpPXIEbcWjUR3JI1
	 PnoKQU+oR5NBw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/type3: Add 'dirty-shutdown' parameter
Date: Fri, 20 Dec 2024 08:00:26 -0800
Message-Id: <20241220160026.204055-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220160026.204055-1-dave@stgolabs.net>
References: <20241220160026.204055-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new parameter for type3 memory devices to set the
dirty shutdown count to a specified value. This allows
emulating failure paths and informing the admin of such
event via the Get Health Info command.

For example, upon a failed GPF, users can boot with
dirty-shutdown=1 and with the cleared shutdown state,
to emulate the hardware behavior.

root@cxl:~# cxl list -m mem1 -H
  {
    "memdev":"mem1",
    "pmem_size":2147483648,
    "health":{
      "maintenance_needed":false,
      "performance_degraded":false,
      "hw_replacement_needed":false,
      "media_normal":true,
      "media_not_ready":false,
      "media_persistence_lost":false,
      "media_data_lost":false,
      "media_powerloss_persistence_loss":false,
      "media_shutdown_persistence_loss":false,
      "media_persistence_loss_imminent":false,
      "media_powerloss_data_loss":false,
      "media_shutdown_data_loss":false,
      "media_data_loss_imminent":false,
      "ext_life_used":"normal",
      "ext_temperature":"normal",
      "ext_corrected_volatile":"normal",
      "ext_corrected_persistent":"normal",
      "life_used_percent":20,
      "temperature":30,
      "dirty_shutdowns":1,
      "volatile_errors":0,
      "pmem_errors":0
    },
    "serial":0,
    "host":"0000:0e:00.0"
  }

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 32 ++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ff1d3f50610c..85a58ab96bef 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -87,6 +87,7 @@ enum {
         #define GET_LSA       0x2
         #define SET_LSA       0x3
     HEALTH_INFO_ALERTS = 0x42,
+        #define GET_HEALTH_INFO        0x0
         #define GET_SHUTDOWN_STATE     0x3
         #define SET_SHUTDOWN_STATE     0x4
     MEDIA_AND_POISON = 0x43,
@@ -1724,6 +1725,35 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+/* CXL r3.2 Section 8.2.10.9.3.1: Get Shutdown State (Opcode 4200h) */
+static CXLRetCode cmd_health_get_health_info(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct get_health_info_pl {
+        uint8_t health_status;
+        uint8_t media_status;
+        uint8_t additional_status;
+        uint8_t life_used;
+        uint16_t device_temperature;
+        uint32_t dirty_shutdown_count;
+        uint32_t corrected_volatile_error_count;
+        uint32_t corrected_persistent_error_count;
+    } QEMU_PACKED *out = (void *)payload_out;
+
+    /* anything not set explicitly is considered under normal health */
+    out->life_used = 20;
+    out->device_temperature = 30;
+    out->dirty_shutdown_count = ct3d->dirty_shutdown;
+    *len_out = sizeof(out);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
 static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
                                                 uint8_t *payload_in,
@@ -2911,6 +2941,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
+    [HEALTH_INFO_ALERTS][GET_HEALTH_INFO] = { "HEALTH_INFO_ALERTS_GET_HEALTH_INFO",
+        cmd_health_get_health_info, 0, 0 },
     [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
         cmd_health_get_shutdown_state, 0, 0 },
     [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5f365afb4dd1..e622eb9101ce 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1380,6 +1380,7 @@ static Property ct3_props[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
+    DEFINE_PROP_UINT32("dirty-shutdown", CXLType3Dev, dirty_shutdown, 0),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 69e6330fe66d..f756e1a99f33 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -653,6 +653,9 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
+
+    /* Dirty shutdown count */
+    uint32_t dirty_shutdown;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.39.5

