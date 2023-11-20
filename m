Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="U5IjE7Vl"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF1A0
	for <linux-cxl@vger.kernel.org>; Mon, 20 Nov 2023 11:44:46 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 35B7D361189;
	Mon, 20 Nov 2023 19:44:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CC1BB3613E2;
	Mon, 20 Nov 2023 19:44:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700509485; a=rsa-sha256;
	cv=none;
	b=Aiz0orPi8pg8g10Gb3GWIUANXzie3F3r8I223bVwU7KZAl2TP7x9QhVguSHnHlDqdWF5fa
	TATTUtbMsRcMGVRjk7Y+DStV4mCVQF7xv1wJ9fQmzvyYkj6unUSIXmjso8Okrrtnz9tdgS
	hGeV+XuFTXyuL6yhSbS6jmcRjav2d1XZBSe+hRcTViEAn2kTVaFIVMhsz7QU0HPFi+sz1G
	0duaFTyHgfhNK6/eJvSibaZQow46g3Vgj5m071K9WJxXKmN5MGMgzcHblhhZtn1ZybzFUN
	/DWvW07Ec5+dXL4SmR4lnzMEeecPV7EeB5tS+5HzFCjb21DDj8f5YXXZQGJxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700509485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=C9fZpuTLYxalhYJNwUQf71gzUTHWeB1Y0Bf7jbLoWFc=;
	b=vsRQ6bqrklDeCeyvQCa9r77VH4+nboWCReM7oVTwLKeMlhJiA3GQgyY5W3V4JrZxa13QlE
	+D1nu+GPCC+nC4fbLee8kr3su74QNU2Inwm8DtfvVnPPE3WgFk1wNM0hrEJfi83O9UEwVd
	4FDdRVGtrH2yRsvAyqva/LO8AUvWTTpEzMFXyaj393U4BrhY1wW39kJlNpRgNUODkDBNhE
	CUehWBOLWRd2dq7CaQSNkc/SFBHx9DA6a4ZjJxLUiWIm7cGKF+W/tVLbcL8NvW5pKCBfmi
	9coKhUvN+cBuRTBY1F3CzSHvfkeAMSf+iW3MDfRFbVUQcOp+wtpxsC5G98IVLg==
ARC-Authentication-Results: i=1;
	rspamd-7f8878586f-m7477;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Squirrel: 79c0b18231f97b36_1700509486032_2662211865
X-MC-Loop-Signature: 1700509486032:2903717202
X-MC-Ingress-Time: 1700509486032
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.238.199 (trex/6.9.2);
	Mon, 20 Nov 2023 19:44:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4SYydT0PrczB7;
	Mon, 20 Nov 2023 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1700509485;
	bh=E8HUPTllwTSZCRVQYtpa0oXZ8MOUSMgdM7OOUgRoqis=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=U5IjE7VlqOUPhdoiF6KHOWpIn2HSAJ466pkLGp/frgVtm4FjCwHUtISRn0wl4FnAT
	 hWkNRNjM6+hmoWdsPKEVWEE5yVi4wMby6e04zz0iPcjkNKlhLq8GuvYwBZFE7R6Nzj
	 Oiv/M/yhT8KgwSITGIcK4Gtg1onBL0gXpf/f7oN+c/dxWmbVgj4Q9+E1rGJ7j3m8Fk
	 XKsg9Ymnk0hgvPlHPsoeSmRrf2/1+KxcKbH8GG5l1tLvSXI09+WBBTuhSrwX7IAWZ8
	 JnYxjzvr2agTUQksrj4F7l2AoZTZjC7seyWVcRIbZGl6IFyoavbPgFpwtZNk+jaGYf
	 NGGRYtmJrJkDw==
Date: Mon, 20 Nov 2023 11:44:41 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	linuxarm@huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com
Subject: Re: [RFC PATCH 1/3] hw/cxl/cxl-mailbox-utils: Add support for
 feature commands (8.2.9.6)
Message-ID: <37bcqgzeu2x573n5sbec3snqekbfkgkd7zmczxr4rb2mn7jpgw@nxxhbjpkup2k>
References: <20231114124711.1128-1-shiju.jose@huawei.com>
 <20231114124711.1128-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114124711.1128-2-shiju.jose@huawei.com>
User-Agent: NeoMutt/20231006

On Tue, 14 Nov 2023, shiju.jose@huawei.com wrote:

>From: Shiju Jose <shiju.jose@huawei.com>
>
>CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
>CXL devices supports features with changeable attributes.
>Get Supported Features retrieves the list of supported device specific
>features. The settings of a feature can be retrieved using Get Feature and
>optionally modified using Set Feature.
>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... with some comments below.

>---
> hw/cxl/cxl-mailbox-utils.c | 140 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 140 insertions(+)
>
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 6184f44339..93960afd44 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -66,6 +66,10 @@ enum {
>     LOGS        = 0x04,
>         #define GET_SUPPORTED 0x0
>         #define GET_LOG       0x1
>+    FEATURES    = 0x05,
>+        #define GET_SUPPORTED 0x0
>+        #define GET_FEATURE   0x1
>+        #define SET_FEATURE   0x2
>     IDENTIFY    = 0x40,
>         #define MEMORY_DEVICE 0x0
>     CCLS        = 0x41,
>@@ -785,6 +789,135 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>     return CXL_MBOX_SUCCESS;
> }
>
>+/* CXL r3.0 section 8.2.9.6: Features */
>+typedef struct CXLSupportedFeatureHeader {
>+    uint16_t entries;
>+    uint16_t nsuppfeats_dev;
>+    uint32_t reserved;
>+} QEMU_PACKED CXLSupportedFeatureHeader;
>+
>+typedef struct CXLSupportedFeatureEntry {
>+    QemuUUID uuid;
>+    uint16_t feat_index;
>+    uint16_t get_feat_size;
>+    uint16_t set_feat_size;
>+    uint32_t attrb_flags;
>+    uint8_t get_feat_version;
>+    uint8_t set_feat_version;
>+    uint16_t set_feat_effects;
>+    uint8_t rsvd[18];
>+} QEMU_PACKED CXLSupportedFeatureEntry;
>+
>+enum CXL_SUPPORTED_FEATURES_LIST {
>+    CXL_FEATURE_MAX
>+};
>+
>+typedef struct CXLSetFeatureInHeader {
>+        QemuUUID uuid;
>+        uint32_t flags;
>+        uint16_t offset;
>+        uint8_t version;
>+        uint8_t rsvd[9];
>+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
>+
>+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
>+#define CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER    0
>+#define CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER    1
>+#define CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER    2
>+#define CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER    3
>+#define CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER    4

Maybe enum here?

>+
>+/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>+static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>+                                             uint8_t *payload_in,
>+                                             size_t len_in,
>+                                             uint8_t *payload_out,
>+                                             size_t *len_out,
>+                                             CXLCCI *cci)
>+{
>+    struct {
>+        uint32_t count;
>+        uint16_t start_index;
>+        uint16_t reserved;
>+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
>+
>+    struct {
>+        CXLSupportedFeatureHeader hdr;
>+        CXLSupportedFeatureEntry feat_entries[];
>+    } QEMU_PACKED QEMU_ALIGNED(16) * supported_feats = (void *)payload_out;

s/supported_feats/get_feats_out.

>+    uint16_t index;
>+    uint16_t entry, req_entries;
>+    uint16_t feat_entries = 0;
>+
>+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>+        get_feats_in->start_index > CXL_FEATURE_MAX) {

Ah I see you update this to '>=' in the next patch.

>+        return CXL_MBOX_INVALID_INPUT;
>+    } else {

This branch is not needed.

>+        req_entries = (get_feats_in->count -
>+                        sizeof(CXLSupportedFeatureHeader)) /
>+                        sizeof(CXLSupportedFeatureEntry);
>+    }
>+    if (req_entries > CXL_FEATURE_MAX) {
>+        req_entries = CXL_FEATURE_MAX;
>+    }

min()?

>+    supported_feats->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;

Logically this should go below, when setting the feature entries.

>+    index = get_feats_in->start_index;
>+
>+    entry = 0;
>+    while (entry < req_entries) {
>+        switch (index) {
>+        default:
>+            break;
>+        }
>+        index++;
>+        entry++;
>+    }
>+
>+    supported_feats->hdr.entries = feat_entries;
>+    *len_out = sizeof(CXLSupportedFeatureHeader) +
>+                      feat_entries * sizeof(CXLSupportedFeatureEntry);
>+
>+    return CXL_MBOX_SUCCESS;
>+}
>+
>+/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
>+static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>+                                           uint8_t *payload_in,
>+                                           size_t len_in,
>+                                           uint8_t *payload_out,
>+                                           size_t *len_out,
>+                                           CXLCCI *cci)
>+{
>+    struct {
>+        QemuUUID uuid;
>+        uint16_t offset;
>+        uint16_t count;
>+        uint8_t selection;
>+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
>+    uint16_t bytes_to_copy = 0;
>+
>+    get_feature = (void *)payload_in;
>+
>+    if (get_feature->offset + get_feature->count > cci->payload_max) {
>+        return CXL_MBOX_INVALID_INPUT;
>+    }

For now maybe return unsupported if a non-zero selection is passed?

>+
>+    *len_out = bytes_to_copy;
>+
>+    return CXL_MBOX_SUCCESS;
>+}
>+
>+/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
>+static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>+                                           uint8_t *payload_in,
>+                                           size_t len_in,
>+                                           uint8_t *payload_out,
>+                                           size_t *len_out,
>+                                           CXLCCI *cci)
>+{
>+    return CXL_MBOX_SUCCESS;
>+}
>+
> /* 8.2.9.5.1.1 */
> static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>                                              uint8_t *payload_in,
>@@ -1954,6 +2087,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                               0, 0 },
>     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>+                                  cmd_features_get_supported, 0x8, 0 },
>+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>+                                cmd_features_get_feature, 0x15, 0 },
>+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
>+                                cmd_features_set_feature,
>+                                ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },

I don't think we are actually doing anything with these, but in addition to
the config, set_feature would need IMMEDIATE_DATA_CHANGE, IMMEDIATE_POLICY_CHANGE,
IMMEDIATE_LOG_CHANGE and SECURITY_STATE_CHANGE.

>     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
>         cmd_identify_memory_device, 0, 0 },
>     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
>--
>2.34.1
>
