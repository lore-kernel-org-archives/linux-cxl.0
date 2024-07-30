Received: from earwig.ash.relay.mailchannels.net (earwig.ash.relay.mailchannels.net [23.83.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F5824AF
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jul 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320234; cv=pass; b=kKz89l0Ne1IjxIT7DbHQBiwvKUFwwNYqNplO2YHJ62wfCzqXa/50B41/KEY4seKzsU2kfnbZqOaWdvKTzM63JaKB1iyUBKD24f7IDoLbegY8XTOaO8gAv5Btw2woUG1d/1jZNTLkRSmMwVjc/TUtT4gcUSNQlIRtsduFZLLGGJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320234; c=relaxed/simple;
	bh=CsY41/VLt8Itj8ivSGo1nn4M+tU07qEDxrFNgbtyVD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1x/ExdicUC2KEdwgjd+OvwCsTtTa3tHEEkeS0pCkv1m/riP6NbaUG3W0q2fjJoa9uQ7tH9YLDPkr676tfRwVnbW1ga+ARZH7WUX+Y9A8S1t49kVyGW756iibHoFnS++8YK8aneS3mbheXeriHMrBYRJk8nAgo++wIBq8jcXUNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LQI0T1r1; arc=pass smtp.client-ip=23.83.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LQI0T1r1"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2E57B14469E;
	Tue, 30 Jul 2024 06:08:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a211.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B100314344F;
	Tue, 30 Jul 2024 06:07:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722319679; a=rsa-sha256;
	cv=none;
	b=viABw7ZyUCElmBoC2enWzf4rdi7ESfygQTM0k4oi4G1u4IcUu4r4KA9XaXfWLvVZfRy1g/
	RIc0eEz1tzXMYMmWUKgs7DaboeulINiCV0MAjTb8M6teqPJ1OorFDEwSH8+NNKnsvH3kYo
	T+uRqzS6dmumkij0gzU9pcgcDxMKDU2gTu6t1VE92GXDV7KX8GeqFy9wr97cJP6PTSsEo8
	9CGNAPcmbRkl0eDt2hfZhE8Df9PGGjk1d1X3cpriRCj7ZKdq8Q0y5G6Hg7oqKucXpjUcV7
	keR0huqcIUb09eFZKmq+pLhNOvkORsMeQpLjjgoinsH0LRGzhIAN/Y2odfWPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722319679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9lsFnKQ6gtPA4p1PA827uOV9Xnmwgy8Qo0YgWI1YaMM=;
	b=y9EsPWScNIKmn8Ckjjf+cPOADDAycRlSrX8WdzNoiri59csU+O3N8jiUJBF2SMZf4Qp7en
	tqjlJiJyWYa2LphCJNzFd9vpSV3sGqodPNWoTCIVcFJaIn0qPWkwb/vPkk94meTkcm+ceF
	xwrtyA4SVtcWc3jWDL5BA6hyfMRZrgSzGHufMkw/6FCt1AQQyLyuwjzXWibtfMK6ULHxup
	Kpiemzrxk6txgh0WLmbZixxZo5/f3pqAIJ/rKRSJ7/ooqBM+3ex3yjnBMPYgjZRYSm6HuA
	BcUx2jpV1I26WxBOAcpRA6FXa0CrVi/K6FH/yldg/vy+eu7NVoEfcJF7FVkPtw==
ARC-Authentication-Results: i=1;
	rspamd-7f77fccf7d-gr7w8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Wiry: 447e49ae7e2c7f9c_1722319680041_969434441
X-MC-Loop-Signature: 1722319680041:63948551
X-MC-Ingress-Time: 1722319680041
Received: from pdx1-sub0-mail-a211.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.124.91 (trex/7.0.2);
	Tue, 30 Jul 2024 06:08:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a211.dreamhost.com (Postfix) with ESMTPSA id 4WY4XG6p0XzLf;
	Mon, 29 Jul 2024 23:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722319679;
	bh=9lsFnKQ6gtPA4p1PA827uOV9Xnmwgy8Qo0YgWI1YaMM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LQI0T1r1Xd/4BRIWUFExO6rTon++QyhfspZAyY7+o5cUCCuoL2rGr81dev7P01qVk
	 PNeEKyqAYfyaHKSjh+eJRp5JOHMRpNFc3N/IwGOj+xyRD00Pyr+QZzd6rmz/GcOy4Y
	 xSn/hKE2tlXik9wHJaHU4MbPP8CeEBKlxEuVKaARufk2RcmAeP+HtMy21CA23Oniht
	 uAtRNRMs5hQfE8LqzII9RUcqvfIfTCiPuzR2p1u1NDlijfwuMJZTDrQIhxg4QwNwQh
	 TDtVg4fNBM/X8OsczNJTWnnOFDh+DaAAXHyPJ1BSmsCBtJAmJKiLIupVxVlzbb2AO1
	 zNP1wH26sNoAQ==
Date: Mon, 29 Jul 2024 23:07:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: ajay.opensrc@micron.com
Cc: Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	john@jagalactic.com, emirakhur@micron.com, ajayjoshi@micron.com, 
	sthanneeru@micron.com, ravis.opensrc@micron.com, arramesh@micron.com, 
	Tushar Mulgund <tmmulgund@micron.com>
Subject: Re: [PATCH] hw/cxl: Add support for abort of background operation
Message-ID: <jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240729102010.20996-1-ajay.opensrc@micron.com>
User-Agent: NeoMutt/20240425

On Mon, 29 Jul 2024, ajay.opensrc@micron.com wrote:\n
>From: Ajay Joshi <ajay.opensrc@micron.com>
>
>This patch adds the support for aborting the background
>operation if one is progress(r3.1 8.2.9.1.5)
>
>"Request Abort Background Operation" command is requested
>by the host to cancel an ongoing background operation. When
>the command is sent, the device will abort the ongoing
>background operation.  When the operation is aborted,
>background command status register will maintain a completion
>percentage value of less then 100. The "Request Abort
>Background Operation" command support has to be advertised in
>the Command Effects Log to be honoured.

So I had a patch for this which I had not sent out, and compared
to this one I think the below is more robust, would you mind
testing this out?

Thanks,
Davidlohr

--8<--------
[PATCH] hw/cxl: Support aborting background commands

As of 3.1 spec, background commands can be canceled with a new
abort command. Implement the support, which is advertised in
the CEL. No ad-hoc context undoing is necessary as all the
command logic of the running bg command is done upon completion.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  hw/cxl/cxl-device-utils.c    |  2 +-
  hw/cxl/cxl-mailbox-utils.c   | 39 ++++++++++++++++++++++++++++++++++--
  include/hw/cxl/cxl_device.h  |  1 +
  include/hw/cxl/cxl_mailbox.h |  1 +
  4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6dd8..4f4ccfa92d82 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -95,7 +95,7 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
	 }
	 if (offset == A_CXL_DEV_MAILBOX_STS) {
	     uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
-            if (cci->bg.complete_pct) {
+            if (cci->bg.complete_pct || cci->bg.aborted) {
		 status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
					 0);
		 cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 80a80f1ec29b..ae4b3cabbb86 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -53,6 +53,7 @@ enum {
      INFOSTAT    = 0x00,
	 #define IS_IDENTIFY   0x1
	 #define BACKGROUND_OPERATION_STATUS    0x2
+        #define BACKGROUND_OPERATION_ABORT     0x5
      EVENTS      = 0x01,
	 #define GET_RECORDS   0x0
	 #define CLEAR_RECORDS   0x1
@@ -815,6 +816,33 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
      return CXL_MBOX_SUCCESS;
  }

+/* CXL r3.1 Section 8.2.9.1.5: Request Abort Background Operation (Opcode 0005h) */
+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    int bg_set = cci->bg.opcode >> 8;
+    int bg_cmd = cci->bg.opcode & 0xff;
+    const struct cxl_cmd *bg_c = &cci->cxl_cmd_set[bg_set][bg_cmd];
+
+    if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
+    }
+
+    if (cci->bg.runtime) {
+        assert(cci->bg.complete_pct < 100);
+        timer_del(cci->bg.timer);
+        cci->bg.ret_code = CXL_MBOX_ABORTED;
+        cci->bg.starttime = 0;
+        cci->bg.runtime = 0;
+        cci->bg.aborted = true;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
						uint8_t *payload_in,
@@ -2149,6 +2177,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
  }

  static const struct cxl_cmd cxl_cmd_set[256][256] = {
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
      [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
	 cmd_events_get_records, 1, 0 },
      [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -2176,7 +2206,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
	 (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
	  CXL_MBOX_SECURITY_STATE_CHANGE |
-         CXL_MBOX_BACKGROUND_OPERATION)},
+         CXL_MBOX_BACKGROUND_OPERATION  | CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
	 cmd_get_security_state, 0, 0 },
      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2189,7 +2219,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
	 "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
	 cmd_media_get_scan_media_capabilities, 16, 0 },
      [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17,
+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT},
      [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
	 "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
	 cmd_media_get_scan_media_results, 0, 0 },
@@ -2214,6 +2245,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
      [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
	 cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
			  CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2295,6 +2328,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
	 cci->bg.opcode = (set << 8) | cmd;

	 cci->bg.complete_pct = 0;
+        cci->bg.aborted = false;
	 cci->bg.ret_code = 0;

	 now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -2386,6 +2420,7 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
      cxl_rebuild_cel(cci);

      cci->bg.complete_pct = 0;
+    cci->bg.aborted = false;
      cci->bg.starttime = 0;
      cci->bg.runtime = 0;
      cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d38391b26f0e..d83b359e9994 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -197,6 +197,7 @@ typedef struct CXLCCI {
      struct {
	 uint16_t opcode;
	 uint16_t complete_pct;
+        bool aborted;
	 uint16_t ret_code; /* Current value of retcode */
	 uint64_t starttime;
	 /* set by each bg cmd, cleared by the bg_timer when complete */
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index beb048052e1b..9008402d1c46 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -14,5 +14,6 @@
  #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)

  #endif
--
2.44.0
