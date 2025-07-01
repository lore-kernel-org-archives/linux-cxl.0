Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AA26B755
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379158; cv=none; b=aIRrls6KkyxCAc0AZkoOttQfIcbeOqhILdHTTkyQCLwf2jz8XU6HmH2r2Kofs6WdLki6Nz/GYgrRrNoKh6bjXn5MFeFByMr5Pruy8PWWUQ1byau+VQPCnglfaUPkmmeIb6svygREqothBZriK5TOfQRPIwc+xW9ViEXRaGzRFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379158; c=relaxed/simple;
	bh=3bYwBqiXTOGKp+1ZDUHsKWO4e+ShPxKoZneXROveacw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=GWiDULftt+J5m/NWWorxdk+fbcibsZuMOXKMWjjmU+vH7qighjV4F9nxIBVaZzuUgBY74SGa5SBWROxwWZXriz3e5c8WdMG64/vVt+DbXK12l6bh/ybU9qba8HYq1onpqiIgRcA2CvPy5O7FSlMhB+tO4fcfw8pe/3cM1ETYz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hl584sE2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hl584sE2"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250701141231epoutp016a03597ff68f9fe081e272ff691c88f3~OJg85Ctwa2753227532epoutp01k
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:12:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250701141231epoutp016a03597ff68f9fe081e272ff691c88f3~OJg85Ctwa2753227532epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751379151;
	bh=oMqwRA0BuFQSGoKP9WQQfybT8xfLVslYMJnSFZ2NF54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hl584sE2KI4lHe2OONXo+kBAVNOasEAuX7qHemoAMhBxuWiB0FioxW2/VESOBSTd/
	 cfxaSedte7yBlN4acxAdttbTBOaXbZHYjPNmIb8ZHrNB57WU0Pk60D7pGLTxTD1Xgc
	 QiiximrYLNoAYvSC2SuEpT2AQvCiTE5iYCrk24hQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250701141231epcas5p394df7f3797ad21742c312565e9a81f4e~OJg8Vk5W90748207482epcas5p3h;
	Tue,  1 Jul 2025 14:12:31 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bWlNF6k5Pz6B9m5; Tue,  1 Jul
	2025 14:12:29 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250701131950epcas5p3f977cca555243ae726922f864d2fced5~OIy8ldrmi1263712637epcas5p3p;
	Tue,  1 Jul 2025 13:19:50 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701131949epsmtip122dcc4ca354f57ea3fa2df1cdb50792e~OIy7U3JG23002830028epsmtip1P;
	Tue,  1 Jul 2025 13:19:49 +0000 (GMT)
Date: Tue, 1 Jul 2025 18:49:34 +0530
From: Alok Rathore <alok.rathore@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alokrathore20@gmail.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250701131934.gohv3ztfcxil6pyt@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250529131352.00007aaf@huawei.com>
X-CMS-MailID: 20250701131950epcas5p3f977cca555243ae726922f864d2fced5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e2361_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
	<20250522063135.366295-1-vinayak.kh@samsung.com>
	<20250529131352.00007aaf@huawei.com>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e2361_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 29/05/25 01:13PM, Jonathan Cameron wrote:
>On Thu, 22 May 2025 12:01:35 +0530
>Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>
>> CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
>>
>> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
>
>Hi Vinayak,
>
>Some code simplification suggestions below.

Thanks Jonathan for reviewing the patch.

Alok
>
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
>
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
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
>> +    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
>
>Can we get away with a memcpy()?  Any endian issues on any of these?

Sure, I’ll check with memcpy()

>
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
>
>>  static const Property cxl_mhsld_props[] = {
>> @@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>>      s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
>>  }
>>
>> +
>> +static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
>> +{
>> +    uint16_t lnksta = 0;
>
>No need to initialize when they are always set below.

Sure, I’ll fix in V1 patch.

>
>> +    uint16_t current_link_speed = 0;
>> +    uint16_t negotiated_link_width = 0;
>> +    uint16_t lnkcap = 0, lnkcap2 = 0;
>> +    uint16_t max_link_width = 0;
>> +    uint16_t max_link_speed = 0;
>
>Once you drop the unnecessary init combine width and speed on one line.
>Or as below, get rid of most of these local variables entirely.
>
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
>Worth considering adding defines for that to incluw/hw/pci/pcie_regs.h

Okay. I’ll add in V1 patch.
>
>> +    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>
>Use PCI_EXP_LNK_MLW_SHIFT to extract that.
>(we should also tidy this up in physical port state.

Sure. I’ll fix in V1 patch.

>
>
>> +    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>> +    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>> +    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>Similar - there should be a suitable define for that shift.
>> +
>> +    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
>
>I would use something like
>
>    s->mhd_state->head_info_blocks[s->mhd_head] = (MHDHeadInfoBlock) {
>        .max_link_width = lnkcap & PCI_EXP_LNKCAP_SLS,
>        .nego_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4, //with the define
>        .supp_link_speeds_vector = (lnkcap2 & 0xFE) >> 1,
>etc
>    };

Sure, I’ll remove local variable and assign in this way.

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
>Avoid the white space noise by leaving a blank line here.

Okay, Will fix in V1 patch

>
>>      /* Set the LD ownership for this head to this system */
>>      s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>>      return;

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e2361_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_e2361_--
