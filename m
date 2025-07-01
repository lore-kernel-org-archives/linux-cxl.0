Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FF27933C
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378719; cv=none; b=bNlBsbEOVZJvaAXtD7z4PXBQoEsqYCDLb3uFtVAukU7KwjwFGzXzRJDGITp4lMLuNdLC1gaDWzLt49BmvF7mzmwa3XKmbYlDoiXqa3z1+Fv7+BfF9tKwdyOIaZLrdf+2Pw/EcDqUnp8eKzX8gFwZLJnoAf6ZpJl1BONfv5ZKGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378719; c=relaxed/simple;
	bh=/0pGnrgXfxGGdH6CZoJ4SHFjlFI0m5/vvCOTOMSWLDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cM0cXhpGNE0tT+Abxx/m/DbyAMV+5fA20Flp+ewZmWgJLjZQ8JD6NHWVMvIGI5mIMCMTtQuxKegkJzxMt018ImOhISamS+YfeIeBWDy30MgKKZCrcGFih5nvA2C3ayleoRndF7YV0nUy80yxQ23RSODwDb8vsele681f79cPq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kvXDQ/7S; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kvXDQ/7S"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250701140514epoutp0252cf802d5275093879ecea1087a48bf9~OJalbuJKC2065020650epoutp02J
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250701140514epoutp0252cf802d5275093879ecea1087a48bf9~OJalbuJKC2065020650epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751378714;
	bh=4WQobar+oAlzo0cscLZgB8+zUXomCZEkJqh9gn+he4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvXDQ/7SPcYgNVxzc1g0GoXCh7bhcn8hpVsqOX2wNqb7dnjxHNO0fq66raWGb/SPV
	 WeVYe/F2fieclPGRCSjMTJP/exvJcG4WBxxAxuXpRNUrpaeDsLUBPxQKmZGY+bHQ8f
	 tRm56yNWa8IZ0aYol2CxcrVSbq/GGWQfAG2Bno64=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250701140513epcas5p42411ceba120e93c6a96b6c469b2112cb~OJak_L9HJ2039020390epcas5p4P;
	Tue,  1 Jul 2025 14:05:13 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bWlCr5Tv9z6B9m6; Tue,  1 Jul
	2025 14:05:12 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250701130513epcas5p1dbc2ebd058409719dcb3ae71bcc28467~OImLaagyJ3207132071epcas5p1U;
	Tue,  1 Jul 2025 13:05:13 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701130511epsmtip13ca5578cf46a6d73e0b589fbc473a653~OImKJLkPl2175421754epsmtip1p;
	Tue,  1 Jul 2025 13:05:11 +0000 (GMT)
Date: Tue, 1 Jul 2025 18:35:03 +0530
From: Alok Rathore <alok.rathore@samsung.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
	gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, a.manzanares@samsung.com,
	alokrathore20@gmail.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250701130503.srfc2fc437at4wdi@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250522191502.v7hw56s3f3cg7y3o@offworld>
X-CMS-MailID: 20250701130513epcas5p1dbc2ebd058409719dcb3ae71bcc28467
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e206d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
	<20250522063135.366295-1-vinayak.kh@samsung.com>
	<20250522191502.v7hw56s3f3cg7y3o@offworld>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e206d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/05/25 12:15PM, Davidlohr Bueso wrote:
>On Thu, 22 May 2025, Vinayak Holikatti wrote:
>
>>CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
>
>So how was this tested? Ideally this now comes with a libcxlmi (or equivalent)
>test case. See for example how Anisa is going about this with the FMAPI DCD
>patches:
>
>https://lore.kernel.org/linux-cxl/20250508001754.122180-1-anisa.su887@gmail.com/

Used libcxl-mi to test this feature. Will update the information in V1 patch.

>
>>Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>>---
>>This patch is generated against Jonathan Cameron's branch cxl-2025-03-20
>
>Adding him to the thread :)
>
>>
>>hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
>>hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
>>hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
>>include/hw/cxl/cxl_device.h |  6 +++
>>4 files changed, 144 insertions(+), 1 deletion(-)
>>
>>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>>index a02d130926..4f25caecea 100644
>>--- a/hw/cxl/cxl-mailbox-utils.c
>>+++ b/hw/cxl/cxl-mailbox-utils.c
>>@@ -122,6 +122,7 @@ enum {
>>        #define MANAGEMENT_COMMAND     0x0
>>    MHD = 0x55,
>>        #define GET_MHD_INFO 0x0
>>+        #define GET_MHD_HEAD_INFO 0x1
>>};
>>
>>/* CCI Message Format CXL r3.1 Figure 7-19 */
>>@@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>>    return CXL_MBOX_UNSUPPORTED;
>>}
>>
>>+/*
>>+ * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
>>+ */
>>+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>>+                                   uint8_t *payload_in, size_t len_in,
>>+                                   uint8_t *payload_out, size_t *len_out,
>>+                                   CXLCCI *cci)
>>+{
>>+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>>+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>>+    if (cvc->mhd_get_head_info) {
>>+        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
>>+                                 len_out, cci);
>>+    }
>>+    return CXL_MBOX_UNSUPPORTED;
>>+}
>>+
>>static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>>                                         uint8_t *payload_in, size_t len_in,
>>                                         uint8_t *payload_out, size_t *len_out,
>>@@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>        "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>>        cmd_media_get_scan_media_results, 0, 0 },
>>    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>>+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
>>};
>>
>>static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>>@@ -3761,6 +3780,8 @@ static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>>    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>>    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>>                                     cmd_tunnel_management_cmd, ~0, 0 },
>>+    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>>+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
>>};
>>
>>void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>>diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
>>index 9f633b3bed..981546b5ff 100644
>>--- a/hw/cxl/mhsld/mhsld.c
>>+++ b/hw/cxl/mhsld/mhsld.c
>>@@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>>    return CXL_MBOX_SUCCESS;
>>}
>>
>>+/*
>>+ * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
>>+ *
>>+ * This command retrieves the number of heads, number of supported LDs,
>>+ * and Head-to-LD mapping of a Multi-Headed device.
>>+ */
>>+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>>+                                        uint8_t *payload_in, size_t len_in,
>>+                                        uint8_t *payload_out, size_t *len_out,
>>+                                        CXLCCI *cci)
>>+{
>>+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
>>+    MHDGetHeadInfoInput *input = (void *)payload_in;
>>+    MHDGetHeadInfoOutput *output = (void *)payload_out;
>>+    int i = 0;
>>+
>>+    if (input->start_head > MHSLD_HEADS) {
>>+        return CXL_MBOX_INVALID_INPUT;
>>+    }
>>+
>>+    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
>>+    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
>>+        output->head_info_list[i].port_number =
>>+                                 s->mhd_state->head_info_blocks[i].port_number;
>>+        output->head_info_list[i].max_link_width =
>>+                              s->mhd_state->head_info_blocks[i].max_link_width;
>>+        output->head_info_list[i].nego_link_width =
>>+                             s->mhd_state->head_info_blocks[i].nego_link_width;
>>+        output->head_info_list[i].supp_link_speeds_vector =
>>+                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
>>+        output->head_info_list[i].max_link_speed =
>>+                              s->mhd_state->head_info_blocks[i].max_link_speed;
>>+        output->head_info_list[i].current_link_speed =
>>+                          s->mhd_state->head_info_blocks[i].current_link_speed;
>>+        output->head_info_list[i].ltssm_state =
>>+                                 s->mhd_state->head_info_blocks[i].ltssm_state;
>>+        output->head_info_list[i].first_nego_lane_num =
>>+                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
>>+        output->head_info_list[i].link_state_flags =
>>+                            s->mhd_state->head_info_blocks[i].link_state_flags;
>>+    }
>>+
>>+    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
>>+    return CXL_MBOX_SUCCESS;
>>+}
>>+
>>static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
>>    [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
>>        cmd_mhd_get_info, 2, 0},
>>+    [MHSLD_MHD][GET_MHD_HEAD_INFO] = {"GET_HEAD_INFO",
>>+        cmd_mhd_get_head_info, 2, 0},
>>};
>>
>>static const Property cxl_mhsld_props[] = {
>>@@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>>    s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
>>}
>>
>>+
>>+static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
>>+{
>>+    uint16_t lnksta = 0;
>>+    uint16_t current_link_speed = 0;
>>+    uint16_t negotiated_link_width = 0;
>>+    uint16_t lnkcap = 0, lnkcap2 = 0;
>>+    uint16_t max_link_width = 0;
>>+    uint16_t max_link_speed = 0;
>>+    uint16_t supported_link_speeds_vector = 0;
>>+
>>+    lnksta = pdev->config_read(pdev,
>>+                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
>>+                               sizeof(lnksta));
>>+    lnkcap = pdev->config_read(pdev,
>>+                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
>>+                               sizeof(lnkcap));
>>+    lnkcap2 = pdev->config_read(pdev,
>>+                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
>>+                                sizeof(lnkcap2));
>>+    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>>+    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>>+    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>>+    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>>+    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>>+
>>+    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
>>+                                                          negotiated_link_width;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
>>+                                                   supported_link_speeds_vector;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
>>+                                                                 max_link_speed;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
>>+                                                             current_link_speed;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
>>+    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
>>+}
>>+
>>/* Returns starting index of region in MHD map. */
>>static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
>>                                                    CXLDCRegion *r)
>>@@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
>>    }
>>
>>    cxl_mhsld_state_initialize(s, dc_size);
>>-
>>+    cxl_mhsld_init_head_info(s, pci_dev);
>>    /* Set the LD ownership for this head to this system */
>>    s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>>    return;
>>@@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
>>
>>    CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
>>    cvc->mhd_get_info = cmd_mhd_get_info;
>>+    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
>>    cvc->mhd_access_valid = cxl_mhsld_access_valid;
>>    cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
>>    cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
>>diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
>>index e7ead1f0d2..c9fbec71ca 100644
>>--- a/hw/cxl/mhsld/mhsld.h
>>+++ b/hw/cxl/mhsld/mhsld.h
>>@@ -23,6 +23,18 @@
>> */
>>#define MHSLD_HEADS  (8)
>>
>>+typedef struct MHDHeadInfoBlock {
>>+    uint8_t port_number;
>>+    uint8_t max_link_width;
>>+    uint8_t nego_link_width;
>>+    uint8_t supp_link_speeds_vector;
>>+    uint8_t max_link_speed;
>>+    uint8_t current_link_speed;
>>+    uint8_t ltssm_state;
>>+    uint8_t first_nego_lane_num;
>>+    uint8_t link_state_flags;
>>+} QEMU_PACKED MHDHeadInfoBlock;
>>+
>>/*
>> * The shared state cannot have 2 variable sized regions
>> * so we have to max out the ldmap.
>>@@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
>>    uint8_t nr_lds;
>>    uint8_t ldmap[MHSLD_HEADS];
>>    uint64_t nr_blocks;
>>+    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
>>    uint8_t blocks[];
>>} MHSLDSharedState;
>>
>>@@ -52,6 +65,7 @@ struct CXLMHSLDClass {
>>enum {
>>    MHSLD_MHD = 0x55,
>>        #define GET_MHD_INFO 0x0
>>+        #define GET_MHD_HEAD_INFO 0x1
>>};
>>
>>/*
>>@@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
>>    uint16_t resv2;
>>    uint8_t ldmap[];
>>} QEMU_PACKED MHDGetInfoOutput;
>>+
>>+typedef struct MHDGetHeadInfoInput {
>>+    uint8_t start_head;
>>+    uint8_t nr_heads;
>>+} QEMU_PACKED MHDGetHeadInfoInput;
>>+
>>+typedef struct MHDGetHeadInfoOutput {
>>+    uint8_t nr_heads;
>>+    uint8_t rsvd[3];
>>+    MHDHeadInfoBlock head_info_list[];
>>+} QEMU_PACKED MHDGetHeadInfoOutput;
>>+
>>#endif
>>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>>index ca515cab13..c93c71c45d 100644
>>--- a/include/hw/cxl/cxl_device.h
>>+++ b/include/hw/cxl/cxl_device.h
>>@@ -732,6 +732,12 @@ struct CXLType3Class {
>>                               uint8_t *payload_out,
>>                               size_t *len_out,
>>                               CXLCCI *cci);
>>+    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
>>+                               uint8_t *payload_in,
>>+                               size_t len_in,
>>+                               uint8_t *payload_out,
>>+                               size_t *len_out,
>>+                               CXLCCI *cci);
>>    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>>    bool (*mhd_reserve_extents)(PCIDevice *d,
>>                                CxlDynamicCapacityExtentList *records,
>>-- 
>>2.34.1
>>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e206d_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e206d_--
