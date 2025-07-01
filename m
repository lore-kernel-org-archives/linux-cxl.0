Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5F27604B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378716; cv=none; b=Rk27PsWiKBqdVA4NDdz1SlIkZ1OiSwUMrGFmLApXtUpuhdOJEig3Sg3AF2KYASmthd9UK/yVA+X4AfzjbdsH3onRSSPCKk/3PlGlT92jYQAMPSjbo1tFGSUJUwZqDYoJyjy0iQd1V3CMHOktyXu7Rdgf6tXVBisP1RimhTEyWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378716; c=relaxed/simple;
	bh=CUQGD36VN0U91e7AXns3YcSxz90Nhigiuo8pZhNp3AI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=daUB7BXixPLPyxmN/Xwq/bXSYRvBwIXF63iBKSBUPdfneZ2P2Jkm7NNHNtvt7iw+AlCSUz9zM7HypR8WcRKYVz/bokEjtOy4xQHoWjaxw4fKvneRn8LQ1UZztJ6vbWqN3MKfxtB8ynQgToYXzTCvxSchWm5st9U9mJNBxSXFkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M4phBxy/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M4phBxy/"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250701140511epoutp04e09225cafb95b9a1969159acb180057b~OJaiZDUR90581405814epoutp04M
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250701140511epoutp04e09225cafb95b9a1969159acb180057b~OJaiZDUR90581405814epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751378711;
	bh=nB+oPxvGdY5WDKUI3ZuIzRpW7qHJsx76Yp55t6Aezcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4phBxy/ITYXWkM2u3NFA17mD9et5Om/6UImeOmFmcx6+OHe4xWqxetMtPz3vu/2O
	 IKLNVngx7Vcb8ehvsl+tnSgubSIiwvUiDB8qVyTV4E6fgqEgPuD5Vf+oAkYDV3gyKq
	 J39YA2J7CR1SRdqN9SxHInjZeN0EkmqdgpHAQiSM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250701140510epcas5p22a37f25258781eb52cbf8b001b39d843~OJaiHL9cP2585325853epcas5p2D;
	Tue,  1 Jul 2025 14:05:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.174]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bWlCn3gqHz2SSKY; Tue,  1 Jul
	2025 14:05:09 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250701125932epcas5p3283f2e1bca3eeb34104b44b11d7f8cd9~OIhOnoABJ2734327343epcas5p3s;
	Tue,  1 Jul 2025 12:59:32 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250701125931epsmtip2d8355ff2489cfed03a2b92bcfdd77266~OIhNlSMHm2456524565epsmtip2a;
	Tue,  1 Jul 2025 12:59:31 +0000 (GMT)
Date: Tue, 1 Jul 2025 18:29:09 +0530
From: Alok Rathore <alok.rathore@samsung.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250701125909.jmpc6eptgejvlic4@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <682f5543.170a0220.2bc644.8b61@mx.google.com>
X-CMS-MailID: 20250701125932epcas5p3283f2e1bca3eeb34104b44b11d7f8cd9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d27_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
	<20250522063135.366295-1-vinayak.kh@samsung.com>
	<682f5543.170a0220.2bc644.8b61@mx.google.com>

------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d27_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/05/25 09:48AM, Fan Ni wrote:
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
>That does not match the section subject of the spec
>Get Head Info (...

Thanks Fan Ni. Will fix in V1 patch.

>> + */
>> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in, size_t len_in,
>> +                                   uint8_t *payload_out, size_t *len_out,
>> +                                   CXLCCI *cci)
>The indent here is not right.

Okay. Will fix in V1 patch.

>> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>> +                                        uint8_t *payload_in, size_t len_in,
>
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>> +    if (cvc->mhd_get_head_info) {
>> +        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
>> +                                 len_out, cci);
>
>indent needs fix.

Okay. Will fix in V1 patch.

>
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
>>  };
>>
>>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>> @@ -3761,6 +3780,8 @@ static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>>      [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>>                                       cmd_tunnel_management_cmd, ~0, 0 },
>> +    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
>> +    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
>>  };
>>
>>  void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>> diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
>> index 9f633b3bed..981546b5ff 100644
>> --- a/hw/cxl/mhsld/mhsld.c
>> +++ b/hw/cxl/mhsld/mhsld.c
>> @@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/*
>> + * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
>> + *
>> + * This command retrieves the number of heads, number of supported LDs,
>> + * and Head-to-LD mapping of a Multi-Headed device.
>> + */
>> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
>> +                                        uint8_t *payload_in, size_t len_in,
>> +                                        uint8_t *payload_out, size_t *len_out,
>> +                                        CXLCCI *cci)
>> +{
>> +    CXLMHSLDState *s = CXL_MHSLD(cci->d);
>> +    MHDGetHeadInfoInput *input = (void *)payload_in;
>> +    MHDGetHeadInfoOutput *output = (void *)payload_out;
>> +    int i = 0;
>> +
>> +    if (input->start_head > MHSLD_HEADS) {
>
>Should be ">=" ?

Right. Head index starts from 0, so this condition should be there.

>
>Also, per the spec, we need also check the "number of heads" field, if
>start_head and number of heads together point to a non-exist head, we
>should return invalid input.

Yes. Will add this check in V1 patch.

>
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
>> +    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
>> +        output->head_info_list[i].port_number =
>> +                                 s->mhd_state->head_info_blocks[i].port_number;
>> +        output->head_info_list[i].max_link_width =
>> +                              s->mhd_state->head_info_blocks[i].max_link_width;
>> +        output->head_info_list[i].nego_link_width =
>> +                             s->mhd_state->head_info_blocks[i].nego_link_width;
>> +        output->head_info_list[i].supp_link_speeds_vector =
>> +                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
>> +        output->head_info_list[i].max_link_speed =
>> +                              s->mhd_state->head_info_blocks[i].max_link_speed;
>> +        output->head_info_list[i].current_link_speed =
>> +                          s->mhd_state->head_info_blocks[i].current_link_speed;
>> +        output->head_info_list[i].ltssm_state =
>> +                                 s->mhd_state->head_info_blocks[i].ltssm_state;
>> +        output->head_info_list[i].first_nego_lane_num =
>> +                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
>> +        output->head_info_list[i].link_state_flags =
>> +                            s->mhd_state->head_info_blocks[i].link_state_flags;
>> +    }
>> +
>> +    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
>>      [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
>>          cmd_mhd_get_info, 2, 0},
>> +    [MHSLD_MHD][GET_MHD_HEAD_INFO] = {"GET_HEAD_INFO",
>> +        cmd_mhd_get_head_info, 2, 0},
>>  };
>>
>>  static const Property cxl_mhsld_props[] = {
>> @@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>>      s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
>>  }
>>
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
>
>s/head_info_list/head_info/

Okay. Will use head_info in V1 patch.

>
>Fan

Thanks Fan Ni for reviewing the patch.

Alok
>
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
>>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>>      bool (*mhd_reserve_extents)(PCIDevice *d,
>>                                  CxlDynamicCapacityExtentList *records,
>> --
>> 2.34.1
>>

------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d27_
Content-Type: text/plain; charset="utf-8"


------nR.o9xAt.CKA9Q2_7V_sz8FZ15p3Iy14m0uxA3-zFK6OxaPG=_e1d27_--
