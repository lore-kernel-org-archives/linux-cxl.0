Received: from cow.ash.relay.mailchannels.net (cow.ash.relay.mailchannels.net [23.83.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552341BD9C1
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712547; cv=pass; b=B2mjFAr9scGDUGiMiJkEwxtbkNkTIH1xW59wavjlW8/muiGrH4LnzVyiidAg0Y3lwt5GPVn51jIunBq9q7/mPptnHnxHNBTYbk3jTkbA9h/lfANu3HRiYTFPniKZw760vrWRogNg1saj1gZPISpeboZ3DgdgoRCGL/WBskHYmhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712547; c=relaxed/simple;
	bh=7/0k3zlPdIIPEyAuemggOOTWNe5K1jGt79yneiZLZro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQcNvzFL/HGwUTpOclrk69+zaPeVt/s4BqNsUkjAv+ebLrse7rK2+kiQfyQr5xOWDQINGzHswj6tSSmbftnuRPAAL8rSfNs/yymKYRD5SjhvHYgYnfSWTDGGcZvMmF5KtB1Nvfjsq7NjcRVEyRc8lUaeLockmGTozt+KTD2PKyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nYmq2Zn6; arc=pass smtp.client-ip=23.83.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nYmq2Zn6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A8B78A5660;
	Fri, 20 Dec 2024 16:00:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.106.31.92])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C95EF8A57E3;
	Fri, 20 Dec 2024 16:00:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734710432; a=rsa-sha256;
	cv=none;
	b=0rIfRRrL032Zykyd0MLka7dpcT1GTVdPgRaJDYMr7KyahXYM4JvJfLPO9hokbLVoG76BBu
	320KDd4p9p7RXk3nb3ebKRwPWFkuK27wxgB3xS1ufIYzpyF1/tAX7XMOoy0lamr6Dbg7aH
	UIwGzXvAgVPEbmDVh0TV/NdX7BlrIB/uF0gMBx5K7MNdJO74/0AXB2WhF6CFTTy3OuJd7E
	l6QWds9YfPMhF73mYGNB3Ei/J2wht83R9QKngLSwhreHh5MlYfUdZ87vJG5uberbFEOULU
	wq952MlUEwVDLL/vsSDZ1/xgG1AxkZEL1l9hx9D4153ajappTONEhYQcD+oWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734710432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DsQjoTRE74IDjdNX6QiJDDO4vYhFj/8Q0CT2cCj/dfI=;
	b=w5m/dUgU5l+IPDAAji0bbUEg1kw8XGribO4ljM53tBDMsEj+auUM6OiSSK2djeJnP9kpKi
	c9CfGdppjzKqdgx5t/7SbI95lkUlLEg43gltEwPpEERBgDDKx6AdcxB+bM5ChFN1+R4BnK
	XqBcHXbpgW2qxg/802EDKc1fXPjL3IpoJPiP6hQXRFTXgAdPkLxOSrJZwqyo6/THU6dJ5x
	KAKQLhktrk+82nxJJVJn348HFdocTo5Eye4hQr7ppw3bXSJ41s0hM4w3zolbXXgyNJiSPO
	9RZQGhoQzRB6auMXCgQol/HOrgjUjfjIYFGhVfgFKgtFy9DWUwh5NJKxVL/LvA==
ARC-Authentication-Results: i=1;
	rspamd-56bf78cbd4-xt8j7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Suffer: 6539ef50616dc8c5_1734710433064_1891154541
X-MC-Loop-Signature: 1734710433064:173551581
X-MC-Ingress-Time: 1734710433064
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.31.92 (trex/7.0.2);
	Fri, 20 Dec 2024 16:00:33 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFBw01rMkzP4;
	Fri, 20 Dec 2024 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734710432;
	bh=DsQjoTRE74IDjdNX6QiJDDO4vYhFj/8Q0CT2cCj/dfI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nYmq2Zn6zKDNoYE1NkWRxS9jvCZwNSC5BTp6p4HfRwGSCgXGSu1rY+JsdvXMVMFDn
	 ugXv0BJ9kx+SfIT0pi2WymSwq6UyVzUnYUa8COOYs1kvghJVJKo1l3ymUT9xJ9flFY
	 1sgGneQVT4sbyAo9oxOqxz0JnNabEHKoulbCDeYjs1vCQat8/gBPgcO6N0n31CtKIs
	 ny7K40ZwM0F4Xz/pcqAO49BMXRzG1Kb6yyGbzDXiBmcQGK2WRDrSIikvDrNCb+kXuv
	 /Em0OJtH9N80csUKuYntZY1/UnB3+HqMrHcYLDZ1Gi+9Ae6FbwqwOESh5n9E2PAt50
	 5gboZbdKyJ2wQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl: Support Get/Set Shutdown State commands
Date: Fri, 20 Dec 2024 08:00:25 -0800
Message-Id: <20241220160026.204055-3-dave@stgolabs.net>
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

As per the latest spec, add mailbox commands 4203h and 4204h.
While upon reboot this operation is obviously a nop (flag is
cleared but the dirty shutdown count is not increased), it
can still serve to test some basic paths.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 49 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f6f993e7bc4f..ff1d3f50610c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -86,6 +86,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_SHUTDOWN_STATE     0x3
+        #define SET_SHUTDOWN_STATE     0x4
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -1721,6 +1724,48 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+/* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
+static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    struct get_shutdown_state_pl {
+        uint8_t state;
+    } QEMU_PACKED;
+    struct get_shutdown_state_pl *out = (void *)payload_out;
+
+    out->state = cxl_dstate->shutdown_state;
+    *len_out = sizeof(out);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.2 Section 8.2.10.9.3.5: Set Shutdown State (Opcode 4204h) */
+static CXLRetCode cmd_health_set_shutdown_state(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    struct set_shutdown_state_pl {
+        uint8_t state;
+    } QEMU_PACKED;
+    struct set_shutdown_state_pl *in = (void *)payload_in;
+
+    cxl_dstate->shutdown_state = in->state;
+    *len_out = 0;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2866,6 +2911,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
+    [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
+        cmd_health_get_shutdown_state, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
+        cmd_health_set_shutdown_state, 1, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25e9..69e6330fe66d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -292,6 +292,8 @@ typedef struct cxl_device_state {
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CHMUState chmu[1];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
+
+    uint8_t shutdown_state;
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
-- 
2.39.5

