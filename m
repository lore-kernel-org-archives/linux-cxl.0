Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34427933C
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378722; cv=none; b=UHbg+R7UpgWl7mIqkBsT0C6Kwu50wQOqipmwicWLfG4R7bELun/8g4ennaHbWKw9zgb5TvgylTv4YrYQFwNu+7S3OwBEg/gZgrA20g/aECly96kefW4b1soudACeAZ9MQUjzDcaQKCCcJTqYB20mxICeHFvtium+l6sWxPijN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378722; c=relaxed/simple;
	bh=63/uWL2oFDqZacipEH9NMtLH28o0RnFijXwPrVDGNiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=asr20rfsaqRyomjBYCKywhAFJle7MDGB+D+4c9yn9DwAYNwGGBSjNTx119aFgNUxHNa3JiPH78aVBlQnlzTH8JGPBW+171hBE7n9s11wEhthM8mFp1u+MZCINPfY5ohpMTNnYstH+fDB2FM9Bzu23J5SF+8u5qaSWUT162SbRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hgbD3VAO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hgbD3VAO"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250701140517epoutp0257ed75b8357a64c9eb398c4bf1533934~OJaoakLjx2022720227epoutp02I
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250701140517epoutp0257ed75b8357a64c9eb398c4bf1533934~OJaoakLjx2022720227epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751378717;
	bh=SoQMVZ5O2p3R61+9gmywCmv4ErJ0sDEjwYnmnfcJgoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgbD3VAOhho5YStd9cC++9vZrKVEhLOPZ5D6KccQktQw8tnX9HRdlf9fF10mx/aHW
	 P82AgYTvKvGNRbQQirlDqCyxQOBm6t4XUnsPvVuU8cvH0bE9kAF5v3X8y6LP3tDKDJ
	 Agn/U+UXzOISyjv+VXqRqOJeBhZHejzjBmY7ADLs=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250701140517epcas5p39c5acd224410f13ddb4a41b52b710bec~OJaoAiQPQ0924409244epcas5p3m;
	Tue,  1 Jul 2025 14:05:17 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.182]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bWlCv6D29z3hhT4; Tue,  1 Jul
	2025 14:05:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250701131120epcas5p35fa8d12f058a82bc637c13d176dd0477~OIriALeZL0141101411epcas5p3r;
	Tue,  1 Jul 2025 13:11:20 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701131119epsmtip13d617f872e981b6e71bbfe6a1d4f91c8~OIrgvNJUI2721527215epsmtip1F;
	Tue,  1 Jul 2025 13:11:19 +0000 (GMT)
Date: Tue, 1 Jul 2025 18:41:14 +0530
From: Alok Rathore <alok.rathore@samsung.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: nifan.cxl@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com, krish.reddy@samsung.com, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org, vishak.g@samsung.com, alokrathore20@gmail.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250701131114.67ezywkxshca4gj6@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aC-vRUoCDJ70_yox@deb-101020-bm01.eng.stellus.in>
X-CMS-MailID: 20250701131120epcas5p35fa8d12f058a82bc637c13d176dd0477
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d94_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250701131120epcas5p35fa8d12f058a82bc637c13d176dd0477
References: <20250522063135.366295-1-vinayak.kh@samsung.com>
	<aC-vRUoCDJ70_yox@deb-101020-bm01.eng.stellus.in>
	<CGME20250701131120epcas5p35fa8d12f058a82bc637c13d176dd0477@epcas5p3.samsung.com>

------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d94_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 22/05/25 11:12PM, Anisa Su wrote:
>On Thu, May 22, 2025 at 12:01:35PM +0530, Vinayak Holikatti wrote:
>> CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>> ---
>> This patch is generated against Jonathan Cameron's branch cxl-2025-03-20
>>
>>  hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
>>  hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
>>  hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
>>  include/hw/cxl/cxl_device.h |  6 +++
>>  4 files changed, 144 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index a02d130926..4f25caecea 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -122,6 +122,7 @@ enum {
>>          #define MANAGEMENT_COMMAND     0x0
>>      MHD = 0x55,
>>          #define GET_MHD_INFO 0x0
>> +        #define GET_MHD_HEAD_INFO 0x1
>>  };
>>
>>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>> @@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_UNSUPPORTED;
>>  }
>>
>> +/*
>> + * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
>> + */
>> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in, size_t len_in,
>> +                                   uint8_t *payload_out, size_t *len_out,
>> +                                   CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>> +    if (cvc->mhd_get_head_info) {
>> +        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
>> +                                 len_out, cci);
>> +    }
>> +    return CXL_MBOX_UNSUPPORTED;
>> +}
>> +
>>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>>                                           uint8_t *payload_in, size_t len_in,
>>                                           uint8_t *payload_out, size_t *len_out,
>> @@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>          "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>>          cmd_media_get_scan_media_results, 0, 0 },
>>      [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>> +    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
>The name here "GET_MULTI_HEADED_INFO" is the same as the previous command.

Yes, It should be GET_HEAD_INFO. Will fix in V1 patch.

>>  };
>>
>...
>> +
>> +static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
>> +{
>> +    uint16_t lnksta = 0;
>> +    uint16_t current_link_speed = 0;
>> +    uint16_t negotiated_link_width = 0;
>> +    uint16_t lnkcap = 0, lnkcap2 = 0;
>> +    uint16_t max_link_width = 0;
>> +    uint16_t max_link_speed = 0;
>> +    uint16_t supported_link_speeds_vector = 0;
>> +
>> +    lnksta = pdev->config_read(pdev,
>> +                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
>> +                               sizeof(lnksta));
>> +    lnkcap = pdev->config_read(pdev,
>> +                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
>> +                               sizeof(lnkcap));
>> +    lnkcap2 = pdev->config_read(pdev,
>> +                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
>> +                                sizeof(lnkcap2));
>> +    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>> +    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>> +    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>> +    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>> +    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>> +
>> +    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
>> +                                                          negotiated_link_width;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
>> +                                                   supported_link_speeds_vector;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
>> +                                                                 max_link_speed;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
>> +                                                             current_link_speed;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
>I think it would be helpful to make a define for the ltssm states?

Sure, Will fix in V1 patch

>> +    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
>> +    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
>> +}
>> +
>>  /* Returns starting index of region in MHD map. */
>>  static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
>>                                                      CXLDCRegion *r)
>> @@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
>>      }
>>
>>      cxl_mhsld_state_initialize(s, dc_size);
>> -
>> +    cxl_mhsld_init_head_info(s, pci_dev);
>>      /* Set the LD ownership for this head to this system */
>>      s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>>      return;
>> @@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
>>
>>      CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
>>      cvc->mhd_get_info = cmd_mhd_get_info;
>> +    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
>>      cvc->mhd_access_valid = cxl_mhsld_access_valid;
>>      cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
>>      cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
>> diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
>> index e7ead1f0d2..c9fbec71ca 100644
>> --- a/hw/cxl/mhsld/mhsld.h
>> +++ b/hw/cxl/mhsld/mhsld.h
>> @@ -23,6 +23,18 @@
>>   */
>>  #define MHSLD_HEADS  (8)
>>
>> +typedef struct MHDHeadInfoBlock {
>> +    uint8_t port_number;
>> +    uint8_t max_link_width;
>> +    uint8_t nego_link_width;
>> +    uint8_t supp_link_speeds_vector;
>> +    uint8_t max_link_speed;
>> +    uint8_t current_link_speed;
>> +    uint8_t ltssm_state;
>> +    uint8_t first_nego_lane_num;
>> +    uint8_t link_state_flags;
>> +} QEMU_PACKED MHDHeadInfoBlock;
>> +
>>  /*
>>   * The shared state cannot have 2 variable sized regions
>>   * so we have to max out the ldmap.
>> @@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
>>      uint8_t nr_lds;
>>      uint8_t ldmap[MHSLD_HEADS];
>>      uint64_t nr_blocks;
>> +    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
>>      uint8_t blocks[];
>>  } MHSLDSharedState;
>>
>> @@ -52,6 +65,7 @@ struct CXLMHSLDClass {
>>  enum {
>>      MHSLD_MHD = 0x55,
>>          #define GET_MHD_INFO 0x0
>> +        #define GET_MHD_HEAD_INFO 0x1
>>  };
>>
>>  /*
>> @@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
>>      uint16_t resv2;
>>      uint8_t ldmap[];
>>  } QEMU_PACKED MHDGetInfoOutput;
>> +
>> +typedef struct MHDGetHeadInfoInput {
>> +    uint8_t start_head;
>> +    uint8_t nr_heads;
>> +} QEMU_PACKED MHDGetHeadInfoInput;
>> +
>> +typedef struct MHDGetHeadInfoOutput {
>> +    uint8_t nr_heads;
>> +    uint8_t rsvd[3];
>> +    MHDHeadInfoBlock head_info_list[];
>> +} QEMU_PACKED MHDGetHeadInfoOutput;
>> +
>>  #endif
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index ca515cab13..c93c71c45d 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -732,6 +732,12 @@ struct CXLType3Class {
>>                                 uint8_t *payload_out,
>>                                 size_t *len_out,
>>                                 CXLCCI *cci);
>> +    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
>> +                               uint8_t *payload_in,
>> +                               size_t len_in,
>> +                               uint8_t *payload_out,
>> +                               size_t *len_out,
>> +                               CXLCCI *cci);
>I think the indent here needs to be aligned with the open parentheses on
>the first line of the function declaration

I’ll fix in V1 patch.

>>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>>      bool (*mhd_reserve_extents)(PCIDevice *d,
>>                                  CxlDynamicCapacityExtentList *records,
>> --
>> 2.34.1

------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d94_
Content-Type: text/plain; charset="utf-8"


------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d94_--
