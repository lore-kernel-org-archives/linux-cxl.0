Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99144284B48
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953739; cv=pass; b=d4duO/sLzAw94lmb3ZusZcpesAxH+3a34C7cr8z+em6UdzqUWjdca5yW3nXZmWZIdmw0HfdHpoPOLw0WQbV5OhRB9OVwLlJHLdNwlKjsVwfA0pkWz7dIkwuRERlo4i+ANlGCD1toOt+9jQXzJYFjw7ZaJ/2GhuVYlvks4uVOsKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953739; c=relaxed/simple;
	bh=OywDiw9IRBBIda8ynPAF8cXh2rj44QVVU2lu8JV2UYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9mq/pQCJFxl6FJ0e2o/SMLkS7lU3Yx4fwfDiYPJOmHkYFNBq6YSXcnlBp0oXK557Aqtey9mUOh2eVdCgfD6eEKwWiWmk24HEvfuLUOfFtW4PYfyeT3kLHzfyEt4EEu1seLwrALgifZ69+TU3nRzxLqLV/tUDtZzWsMR084uU5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=oFTRpyt5; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="oFTRpyt5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6C7382C4297;
	Thu, 22 May 2025 19:15:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.120.55.12])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C1A402C5E14;
	Thu, 22 May 2025 19:15:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1747941305; a=rsa-sha256;
	cv=none;
	b=wIN/0TyAevyANmlwOJonc/AJ52qfJRJu6yTmjMgJNabnujTCeaUxJjk/nL9cCdtCvAFlQM
	lbzSrP7FIHwhbch6XLbG8pdJEEm53NwSTfjpj0DSDJJkTDT45g2yZwASmiOqqrUBaeN2HG
	pXCaA4Yby6QXSCiqWAN2Egpceyy4oiiLnyF4wIGveyXYTUKw2SsY2X8pbr0NR0EY/PPDB1
	A3mVAeJHKXTozo4cSPmz/1hD6UudVBhA1+OzefG9KUtcjLwtFoiRKvtaFw4gImG0C2fQ9W
	rN8hcio/MSsfjk1J1xAG4I0S3wOP4KkUpGBfMzA6rDEorhm9bfk5ZMggwjs9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1747941305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K4cUqz35dS7dKQoragEtYnv/LjvHnd4/odkizloLND0=;
	b=JbAlFiTIdZHx5jS+BDenXin1i2xI4oPndA2P1eQzSraNa9JmwY4Jk8Y5BbLWipEjgUCAcs
	DcDtxASwTkwVVFyf5wEZjjWwcrp2RamAqAfZwe0C7ybWp7myCnQX3HGdkfPN+o2c4yqcLa
	YOwdap9NVeKukCkWnlDJ0v/JRrDeFQz3UCOu2dnd8ZUYhUGKgfqyC/wpNqM40XG6lbeVEc
	2ZwONPMA0ixuh51s23PtZPP944hYBh5zbINTqPvTnfZjQVhC8xx2a65VE/6sC6qqWvKUHt
	rwVsfySqA+yy55hye3CiNuXplRWqr98qB0e9x6iMwUhcmIjdVqQ8sC05rZ7mYQ==
ARC-Authentication-Results: i=1;
	rspamd-766f9cfddb-csmgf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Harbor: 2ab8768010bbda9b_1747941306172_1997564933
X-MC-Loop-Signature: 1747941306172:2643112698
X-MC-Ingress-Time: 1747941306172
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.55.12 (trex/7.0.3);
	Thu, 22 May 2025 19:15:06 +0000
Received: from offworld (unknown [104.36.25.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4b3Hzs0cksz2P;
	Thu, 22 May 2025 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1747941305;
	bh=K4cUqz35dS7dKQoragEtYnv/LjvHnd4/odkizloLND0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=oFTRpyt5MtBirrc5igNAGPBJK3s3rDqf4uukYPXK9gcjFSk70RDltJHtM7OXQ/6yl
	 Iz6rvBd1ZwkMmk+DIwoHoWlt5a0c99VxM/jaqs2TQpKrKWOwLf/7apZ+3ixnGGbBEb
	 8n+USRCSNYHLevhFi05SQAOAz9Ci7VY7XP1cX1LEWI8Ic/95quypK8i9V5uFWEIGlk
	 fub+LuyK69t+3nr8L8h7Oe7lBi4lSyJePuJKv9TvaaRR2WEKfY6tQshQfYwW0cR4Qp
	 NC4tyZRUXocPkDrgeCRZ/sMPmIe6okzvYv5aS4YQpVeMdE9nipYfUi0rXCky+VbmUK
	 u7sj5mrjRTWMw==
Date: Thu, 22 May 2025 12:15:02 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Vinayak Holikatti <vinayak.kh@samsung.com>, Jonathan.Cameron@huawei.com
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250522191502.v7hw56s3f3cg7y3o@offworld>
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
 <20250522063135.366295-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522063135.366295-1-vinayak.kh@samsung.com>
User-Agent: NeoMutt/20220429

On Thu, 22 May 2025, Vinayak Holikatti wrote:

>CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.

So how was this tested? Ideally this now comes with a libcxlmi (or equivalent)
test case. See for example how Anisa is going about this with the FMAPI DCD
patches:

https://lore.kernel.org/linux-cxl/20250508001754.122180-1-anisa.su887@gmail.com/

>Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>---
>This patch is generated against Jonathan Cameron's branch cxl-2025-03-20

Adding him to the thread :)

>
> hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
> hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
> hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
> include/hw/cxl/cxl_device.h |  6 +++
> 4 files changed, 144 insertions(+), 1 deletion(-)
>
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index a02d130926..4f25caecea 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -122,6 +122,7 @@ enum {
>         #define MANAGEMENT_COMMAND     0x0
>     MHD = 0x55,
>         #define GET_MHD_INFO 0x0
>+        #define GET_MHD_HEAD_INFO 0x1
> };
>
> /* CCI Message Format CXL r3.1 Figure 7-19 */
>@@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>     return CXL_MBOX_UNSUPPORTED;
> }
>
>+/*
>+ * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
>+ */
>+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>+                                   uint8_t *payload_in, size_t len_in,
>+                                   uint8_t *payload_out, size_t *len_out,
>+                                   CXLCCI *cci)
>+{
>+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>+    if (cvc->mhd_get_head_info) {
>+        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
>+                                 len_out, cci);
>+    }
>+    return CXL_MBOX_UNSUPPORTED;
>+}
>+
> static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>                                          uint8_t *payload_in, size_t len_in,
>                                          uint8_t *payload_out, size_t *len_out,
>@@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>         cmd_media_get_scan_media_results, 0, 0 },
>     [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
> };
>
> static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>@@ -3761,6 +3780,8 @@ static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>                                      cmd_tunnel_management_cmd, ~0, 0 },
>+    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
> };
>
> void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
>index 9f633b3bed..981546b5ff 100644
>--- a/hw/cxl/mhsld/mhsld.c
>+++ b/hw/cxl/mhsld/mhsld.c
>@@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>     return CXL_MBOX_SUCCESS;
> }
>
>+/*
>+ * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
>+ *
>+ * This command retrieves the number of heads, number of supported LDs,
>+ * and Head-to-LD mapping of a Multi-Headed device.
>+ */
>+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>+                                        uint8_t *payload_in, size_t len_in,
>+                                        uint8_t *payload_out, size_t *len_out,
>+                                        CXLCCI *cci)
>+{
>+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
>+    MHDGetHeadInfoInput *input = (void *)payload_in;
>+    MHDGetHeadInfoOutput *output = (void *)payload_out;
>+    int i = 0;
>+
>+    if (input->start_head > MHSLD_HEADS) {
>+        return CXL_MBOX_INVALID_INPUT;
>+    }
>+
>+    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
>+    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
>+        output->head_info_list[i].port_number =
>+                                 s->mhd_state->head_info_blocks[i].port_number;
>+        output->head_info_list[i].max_link_width =
>+                              s->mhd_state->head_info_blocks[i].max_link_width;
>+        output->head_info_list[i].nego_link_width =
>+                             s->mhd_state->head_info_blocks[i].nego_link_width;
>+        output->head_info_list[i].supp_link_speeds_vector =
>+                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
>+        output->head_info_list[i].max_link_speed =
>+                              s->mhd_state->head_info_blocks[i].max_link_speed;
>+        output->head_info_list[i].current_link_speed =
>+                          s->mhd_state->head_info_blocks[i].current_link_speed;
>+        output->head_info_list[i].ltssm_state =
>+                                 s->mhd_state->head_info_blocks[i].ltssm_state;
>+        output->head_info_list[i].first_nego_lane_num =
>+                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
>+        output->head_info_list[i].link_state_flags =
>+                            s->mhd_state->head_info_blocks[i].link_state_flags;
>+    }
>+
>+    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
>+    return CXL_MBOX_SUCCESS;
>+}
>+
> static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
>     [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
>         cmd_mhd_get_info, 2, 0},
>+    [MHSLD_MHD][GET_MHD_HEAD_INFO] = {"GET_HEAD_INFO",
>+        cmd_mhd_get_head_info, 2, 0},
> };
>
> static const Property cxl_mhsld_props[] = {
>@@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>     s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
> }
>
>+
>+static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
>+{
>+    uint16_t lnksta = 0;
>+    uint16_t current_link_speed = 0;
>+    uint16_t negotiated_link_width = 0;
>+    uint16_t lnkcap = 0, lnkcap2 = 0;
>+    uint16_t max_link_width = 0;
>+    uint16_t max_link_speed = 0;
>+    uint16_t supported_link_speeds_vector = 0;
>+
>+    lnksta = pdev->config_read(pdev,
>+                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
>+                               sizeof(lnksta));
>+    lnkcap = pdev->config_read(pdev,
>+                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
>+                               sizeof(lnkcap));
>+    lnkcap2 = pdev->config_read(pdev,
>+                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
>+                                sizeof(lnkcap2));
>+    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>+    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>+    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>+    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>+    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>+
>+    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
>+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
>+    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
>+                                                          negotiated_link_width;
>+    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
>+                                                   supported_link_speeds_vector;
>+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
>+                                                                 max_link_speed;
>+    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
>+                                                             current_link_speed;
>+    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
>+    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
>+    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
>+}
>+
> /* Returns starting index of region in MHD map. */
> static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
>                                                     CXLDCRegion *r)
>@@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
>     }
>
>     cxl_mhsld_state_initialize(s, dc_size);
>-
>+    cxl_mhsld_init_head_info(s, pci_dev);
>     /* Set the LD ownership for this head to this system */
>     s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>     return;
>@@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
>
>     CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
>     cvc->mhd_get_info = cmd_mhd_get_info;
>+    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
>     cvc->mhd_access_valid = cxl_mhsld_access_valid;
>     cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
>     cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
>diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
>index e7ead1f0d2..c9fbec71ca 100644
>--- a/hw/cxl/mhsld/mhsld.h
>+++ b/hw/cxl/mhsld/mhsld.h
>@@ -23,6 +23,18 @@
>  */
> #define MHSLD_HEADS  (8)
>
>+typedef struct MHDHeadInfoBlock {
>+    uint8_t port_number;
>+    uint8_t max_link_width;
>+    uint8_t nego_link_width;
>+    uint8_t supp_link_speeds_vector;
>+    uint8_t max_link_speed;
>+    uint8_t current_link_speed;
>+    uint8_t ltssm_state;
>+    uint8_t first_nego_lane_num;
>+    uint8_t link_state_flags;
>+} QEMU_PACKED MHDHeadInfoBlock;
>+
> /*
>  * The shared state cannot have 2 variable sized regions
>  * so we have to max out the ldmap.
>@@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
>     uint8_t nr_lds;
>     uint8_t ldmap[MHSLD_HEADS];
>     uint64_t nr_blocks;
>+    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
>     uint8_t blocks[];
> } MHSLDSharedState;
>
>@@ -52,6 +65,7 @@ struct CXLMHSLDClass {
> enum {
>     MHSLD_MHD = 0x55,
>         #define GET_MHD_INFO 0x0
>+        #define GET_MHD_HEAD_INFO 0x1
> };
>
> /*
>@@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
>     uint16_t resv2;
>     uint8_t ldmap[];
> } QEMU_PACKED MHDGetInfoOutput;
>+
>+typedef struct MHDGetHeadInfoInput {
>+    uint8_t start_head;
>+    uint8_t nr_heads;
>+} QEMU_PACKED MHDGetHeadInfoInput;
>+
>+typedef struct MHDGetHeadInfoOutput {
>+    uint8_t nr_heads;
>+    uint8_t rsvd[3];
>+    MHDHeadInfoBlock head_info_list[];
>+} QEMU_PACKED MHDGetHeadInfoOutput;
>+
> #endif
>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>index ca515cab13..c93c71c45d 100644
>--- a/include/hw/cxl/cxl_device.h
>+++ b/include/hw/cxl/cxl_device.h
>@@ -732,6 +732,12 @@ struct CXLType3Class {
>                                uint8_t *payload_out,
>                                size_t *len_out,
>                                CXLCCI *cci);
>+    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
>+                               uint8_t *payload_in,
>+                               size_t len_in,
>+                               uint8_t *payload_out,
>+                               size_t *len_out,
>+                               CXLCCI *cci);
>     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>     bool (*mhd_reserve_extents)(PCIDevice *d,
>                                 CxlDynamicCapacityExtentList *records,
>-- 
>2.34.1
>
