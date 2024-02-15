Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F506A349
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030541; cv=pass; b=szKJbFn1tGVoJDWdxoRlKWAt/NFouH4lEitb0+aMq2tl+bYg2qBT/VvSL+hci7dQX5IuWCTo9bvRzcaq2JaYzKkL85XH8dQFIzT9dBMSs/XO29ZF9CmsUMKVXRN+8Vo8iylZ/mpA2Yg9574Y1PwtSY76JeB++EVVbL/1UrP55Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030541; c=relaxed/simple;
	bh=JCQpWQilmCr+s+qMh3EbboJZMfxsI4ugPKmuaGL9+bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObW9hyNSK3lyfZKCOZBwJuD3X6ZtNiwDlUQUqSshTg8ABHM30lnMT6G2Te/3ANSLqvZir+ZXGG+VXlvIeGQl6Gt3fOu1oAF8B3mrHqxOCNfc7H8gjK73PRphSwlVQasFEHx4My2O7TCWrYOzrN/OK0xr+GbTIOFMlCBzpp64R0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fUVHt7JT; arc=pass smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fUVHt7JT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 07314826C1;
	Thu, 15 Feb 2024 20:55:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9252B82108;
	Thu, 15 Feb 2024 20:55:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708030537; a=rsa-sha256;
	cv=none;
	b=vE8cilq6c4ENzv/CaAscs3bC0eYjYsV07efK/PF5ex2uqyk3llaMhLwJnVf9Yxtpp53LSm
	VJnv7vEC/CkgFa14oHPo8Fo3fe2AAb+HiFiE1djgyjCFBj9vvX6IS/xJ8cM2pQnX4VYNqV
	wQ3BqKOef6m2kDnGdSuDQRznfh+XUt1hSoldr0yhdrnic5q1shz1DFqayKQfR6ofjnq1xX
	QLWb6JKwZanPCrCXNem0w9ddTxYTXJ+OoKUD9ntPEHfAk7VNSbCgDoXivNKWGT0q/PWVXh
	HlZ1qP48o4cDI1nh+sl0G3Ycebv227cnqnn6PeQH1JkmQfPPzbpi38hTYSLfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708030537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vwmBvx5X+fibWNFKs+ECHbr/PPAFojOSbFsD33ZCbzY=;
	b=S5HghzRNHAVw3uUMwW+S34/7NMz10E1YLbXeqxWnxZu9Li8D33G8HVUWm9Gh1x09tM69jo
	vMEo5Wyw2i/ZZPeMhibFJODp8RXdjzye/2do1hAQ/oFCTr/DBam0gz+TQhfJlMv1zs+rdi
	BPI9ztsDkNhq7m+kEGDrWP1f/LviGyqLp84FsvTvFCAMN7QsBKEZZOUWC3z92A0mJ2VPWV
	VY6nIwPb2ri2LPY1GI4CaS3g5EgzA3Rl4tx9/2XMhC2G/s2eMoU6pB0C//s2MtVLdP2L5v
	e+a39GS+72APBmKXNSXh2Vf3/KEWxXOleMaVz+HAeR5jCbC0wilxmd5tBwsVug==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-zkpt9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Desert: 5d67b5102d5996cc_1708030537888_3644176824
X-MC-Loop-Signature: 1708030537888:631725584
X-MC-Ingress-Time: 1708030537887
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.49.71 (trex/6.9.2);
	Thu, 15 Feb 2024 20:55:37 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4TbS5366sXz9r;
	Thu, 15 Feb 2024 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708030537;
	bh=vwmBvx5X+fibWNFKs+ECHbr/PPAFojOSbFsD33ZCbzY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fUVHt7JTTV5QFl/TLzt5kwXj2u3006T6qhLg/Q8hOpyMzD5adinZtvPquHUqb2xdC
	 TW+RNtb7lrpyo6i9aR+p3W4alxDQQV5TSWMkGPbe2m4ViS2LoI2ZqstMWyV+jTLNoK
	 wmIuPT8BEugookDO+Wl0q3QJDedVYz0qojEwm29fpRhmDNZ+k7g3aAVbKR8mzcGJ5K
	 EcUan20i2TJGd9K0R7a1lcbyFBGuRdzfUEnElbTvQ01fe+QCDccfJLHN0RTt2h+0cI
	 7OtIP3Ajcd/EosY/Kkf9d6dp9bOdTpu/IfX7tjwHgx99jY79kZwZA5YvXFH7qmnifY
	 j8voYbYR3W7FA==
Date: Thu, 15 Feb 2024 12:55:33 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <id5xykna7khba7erp24q6mm2jog4rm6dadlf3hovtckiujvm5w@n76nnywnjf75>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-3-shiju.jose@huawei.com>
User-Agent: NeoMutt/20231221

On Fri, 24 Nov 2023, shiju.jose@huawei.com wrote:

>From: Shiju Jose <shiju.jose@huawei.com>
>
>CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
>feature. The device patrol scrub proactively locates and makes corrections
>to errors in regular cycle. The patrol scrub control allows the request to
>configure patrol scrub input configurations.
>
>The patrol scrub control allows the requester to specify the number of
>hours for which the patrol scrub cycles must be completed, provided that
>the requested number is not less than the minimum number of hours for the
>patrol scrub cycle that the device is capable of. In addition, the patrol
>scrub controls allow the host to disable and enable the feature in case
>disabling of the feature is needed for other purposes such as
>performance-aware operations which require the background operations to be
>turned off.
>
>Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>---
> hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 96 insertions(+), 1 deletion(-)
>
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 1bbc9a48a6..5a6f4e4029 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {
> } QEMU_PACKED CXLSupportedFeatureEntry;
>
> enum CXL_SUPPORTED_FEATURES_LIST {
>+    CXL_FEATURE_PATROL_SCRUB = 0,
>     CXL_FEATURE_MAX
> };
>
>@@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>     CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> };
>
>+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
>+static const QemuUUID patrol_scrub_uuid = {
>+    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
>+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
>+};
>+
>+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
>+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
>+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
>+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
>+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
>+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
>+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
>+
>+/* CXL memdev patrol scrub control attributes */
>+struct CXLMemPatrolScrubReadAttrbs {
>+        uint8_t scrub_cycle_cap;
>+        uint16_t scrub_cycle;
>+        uint8_t scrub_flags;
>+} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
>+
>+typedef struct CXLMemPatrolScrubWriteAttrbs {
>+    uint8_t scrub_cycle_hr;
>+    uint8_t scrub_flags;
>+} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;

fyi there is an ask, which I certainly agree with, to make
these static here instead of at runtime.

https://lore.kernel.org/linux-cxl/20240119175006.00007f74@Huawei.com/

Also, this series probably needs rebasing per Jonathan's
latest branch with lots of updates.

>+
>+typedef struct CXLMemPatrolScrubSetFeature {
>+        CXLSetFeatureInHeader hdr;
>+        CXLMemPatrolScrubWriteAttrbs feat_data;
>+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
>+
> /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
> static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                              uint8_t *payload_in,
>@@ -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>     uint16_t feat_entries = 0;
>
>     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>-        get_feats_in->start_index > CXL_FEATURE_MAX) {
>+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
>         return CXL_MBOX_INVALID_INPUT;
>     }
>     req_entries = (get_feats_in->count -
>@@ -884,6 +916,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>     entry = 0;
>     while (entry < req_entries) {
>         switch (index) {
>+        case  CXL_FEATURE_PATROL_SCRUB:
>+            /* Fill supported feature entry for device patrol scrub control */
>+            get_feats_out->feat_entries[entry] =
>+                           (struct CXLSupportedFeatureEntry) {
>+                .uuid = patrol_scrub_uuid,
>+                .feat_index = index,
>+                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
>+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
>+                /* Bit[0] : 1, feature attributes changeable */
>+                .attrb_flags = 0x1,
>+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
>+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
>+                .set_feat_effects = 0,
>+            };
>+            feat_entries++;
>+            /* Set default value for device patrol scrub read attributes */
>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
>+                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
>+                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
>+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
>+            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
>+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
>+            break;
>         default:
>             break;
>         }
>@@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>         return CXL_MBOX_INVALID_INPUT;
>     }
>
>+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
>+        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
>+            return CXL_MBOX_INVALID_INPUT;
>+        }
>+        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
>+                                             get_feature->offset;
>+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
>+                               get_feature->count : bytes_to_copy;

min()?

>+        memcpy(payload_out,
>+               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
>+               bytes_to_copy);
>+    } else {
>+        return CXL_MBOX_UNSUPPORTED;
>+    }
>+
>     *len_out = bytes_to_copy;
>
>     return CXL_MBOX_SUCCESS;
>@@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                            size_t *len_out,
>                                            CXLCCI *cci)
> {
>+    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
>+    CXLMemPatrolScrubSetFeature *ps_set_feature;
>+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
>+
>+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>+        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
>+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
>+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
>+            return CXL_MBOX_UNSUPPORTED;
>+        }
>+
>+        ps_set_feature = (void *)payload_in;
>+        ps_write_attrbs = &ps_set_feature->feat_data;
>+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
>+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
>+                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
>+        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
>+        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
>+                          ps_write_attrbs->scrub_flags & 0x1;
>+    } else {
>+        return CXL_MBOX_UNSUPPORTED;
>+    }
>+
>     return CXL_MBOX_SUCCESS;
> }
>
>--
>2.34.1
>
