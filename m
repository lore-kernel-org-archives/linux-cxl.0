Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C07224FA
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794228; cv=none; b=X5/w1eOwV2KFwpUg4VA4CX03ZLagakvPvkvNIdcEJZ5RGVLAbcdAg28P5W/MSADInYhVTq8Nh1oVHfagcWInQmCUJkqnbw8uX2saJs2B4ADvvYGI2O+49u0/jAR8vxcJD5RLylVL+kz9N4rie9mUwSySq5nqFjUCBVRoebCAhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794228; c=relaxed/simple;
	bh=Wjo6DlOO19ifsglu4kQt38ll4SyYhvLN+PKoLI/cK4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=nxLqqbWc+EP07gob9cI6/F8VvoocVxXggC/e7Tsu/AN1Ta0wIeLm/VlZeddR9Oo9ELCpNh9ko19jTzbj8h6XcxR944Huc6FyYJn9ukablkXUHNaCOyBHFzjhN+jNDTdFCsoZrqPzfkAwNWQjDuVWAS3gmVg071ldAE0Nnw1fpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d8Mvu6+h; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d8Mvu6+h"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250729130343epoutp02d01be2e9da52a5c5a43aff97a230fe0c~Wuo3VRPt30505205052epoutp02L
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 13:03:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250729130343epoutp02d01be2e9da52a5c5a43aff97a230fe0c~Wuo3VRPt30505205052epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753794223;
	bh=wa4nqyovvZrDI5pzUwEzrh738KHCMO4FMKpKL8lciDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8Mvu6+hKJI0b6jfS03Qdjw4nizxVGloRS/2ZSrnpNFHW1Rss/Mb2nkpEBPjfXfUE
	 c766lhKYShoShMfGzPXtN0zcxcxv4icTZDQ2cdNCmkkyUk8yM5U9hacNmH/c0u7fcl
	 sudsRBWPWU4PVsssI3agRQJK7YaUNrd9X7R4vg+o=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250729130342epcas5p37de5e60f11438bfdb557702abf3b270c~Wuo2-AlHf0946709467epcas5p3_;
	Tue, 29 Jul 2025 13:03:42 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4brwWx6G9Wz6B9m5; Tue, 29 Jul
	2025 13:03:41 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250729130331epcas5p23a9dba2fd1dbb49c4f9d2397ea6894b5~WuossSDRp1954419544epcas5p2g;
	Tue, 29 Jul 2025 13:03:31 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250729130330epsmtip1d7879d41a454ecb7fd48003a826338f2~WuorSQ-xm0239402394epsmtip1T;
	Tue, 29 Jul 2025 13:03:30 +0000 (GMT)
Date: Tue, 29 Jul 2025 18:33:25 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
	cpgs@samsung.com
Subject: Re: [PATCH v2 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250729130325.pjv5cr6p4wggedgt@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250725155912.0000551d@huawei.com>
X-CMS-MailID: 20250729130331epcas5p23a9dba2fd1dbb49c4f9d2397ea6894b5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_50133_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
	<CGME20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113@epcas5p1.samsung.com>
	<20250710144338.2839512-3-arpit1.kumar@samsung.com>
	<20250725155912.0000551d@huawei.com>

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_50133_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 25/07/25 03:59PM, Jonathan Cameron wrote:
>On Thu, 10 Jul 2025 20:13:38 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> -added assert-deassert PERST implementation
>>  for physical ports (both USP and DSP's).
>> -assert PERST involves bg operation for holding 100ms.
>> -reset PPB implementation for physical ports.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Hi Arpit,
>
>Minor comments inline.
>
>We have plenty of time given where the qemu cycle is, so no huge rush
>for a v3.
>
>Jonathan
>
>> +static struct PCIDevice *cxl_find_port_dev(uint8_t pn, CXLCCI *cci)
>> +{
>> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
>> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +
>> +    if (pp->pports.pport_info[pn].current_port_config_state ==
>> +        CXL_PORT_CONFIG_STATE_USP) {
>> +        PCIDevice *usp_dev = pci_bridge_get_device(bus);
>> +        return usp_dev;
>
>As below.
>
>> +    }
>> +
>> +    if (pp->pports.pport_info[pn].current_port_config_state ==
>> +        CXL_PORT_CONFIG_STATE_DSP) {
>> +        PCIDevice *dsp_dev = pcie_find_port_by_pn(bus, pn);
>> +        return dsp_dev;
>
>What benefit do we get from a local variable?
>
thanks for pointing out.
>> +    }
>> +    return NULL;
>> +}
>> +
>> +/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
>> +static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
>> +                                            uint8_t *payload_in,
>> +                                            size_t len_in,
>> +                                            uint8_t *payload_out,
>> +                                            size_t *len_out,
>> +                                            CXLCCI *cci)
>> +{
>> +   CXLUpstreamPort *pp = CXL_USP(cci->d);
>> +   PCIDevice *dev;
>> +   uint8_t ret = CXL_MBOX_SUCCESS;
>> +
>> +   struct cxl_fmapi_get_physical_port_control_req_pl {
>> +        uint8_t ppb_id;
>> +        uint8_t ports_op;
>> +    } QEMU_PACKED *in = (void *)payload_in;
>> +
>> +    if (len_in < sizeof(*in)) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>> +
>> +    uint8_t pn = in->ppb_id;
>
>Avoid inline declarations of local variables.
>
got it.
>> +    if (pp->pports.pport_info[pn].port_id != pn) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    dev = cxl_find_port_dev(pn, cci);
>> +    if (!dev) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    switch (in->ports_op) {
>> +    case 0:
>> +        ret = assert_perst(OBJECT(&dev->qdev), pn, pp);
>> +        break;
>> +    case 1:
>> +        ret = deassert_perst(OBJECT(&dev->qdev), pn, pp);
>> +        break;
>> +    case 2:
>> +        if (pp->pports.perst[pn].issued_assert_perst ||
>> +            pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
>> +            return CXL_MBOX_INTERNAL_ERROR;
>> +        }
>> +        device_cold_reset(&dev->qdev);
>> +        break;
>> +    default:
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +    return ret;
>> +}
>
>> @@ -3810,4 +3932,17 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>>      cxl_set_phy_port_info(cci);
>> +    /* physical port control */
>> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
>
>Still sticking to the old style c option of declarations at the top of the scope.
>
okay
>> +    for (int i = 0; i < CXL_MAX_PHY_PORTS; i++) {
>> +        qemu_mutex_init(&pp->pports.perst[i].lock);
>> +        pp->pports.perst[i].issued_assert_perst = false;
>> +        /*
>> +         * Assert PERST involves physical port to be in
>> +         * hold reset phase for minimum 100ms. No other
>> +         * physcial port control requests are entertained
>> +         * until Deassert PERST command.
>> +         */
>> +         pp->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
>> +    }
>>  }
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index 1fa6cf7536..bb47e671eb 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -128,6 +128,7 @@
>>                    (1 << 16))
>>
>>  #define CXL_MAX_PHY_PORTS 256
>> +#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>>
>>  #define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
>>  #define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
>> @@ -203,10 +204,19 @@ struct cxl_phy_port_info {
>>      uint8_t supported_ld_count;
>>  } QEMU_PACKED;
>>
>> +/* Assert - Deassert PERST */
>> +struct pperst {
>
>Prefix this name. pperst is a PCIE thing so it may otherwise end up confusing.
>
okay
>> +    bool issued_assert_perst;
>> +    QemuMutex lock;
>
>Good practice to add a comment to say exactly what data this lock is protecting.
>
got it.
>> +    uint64_t asrt_time;
>> +    QemuThread asrt_thread; /* thread for 100ms delay */
>> +};
>> +
>>  struct phy_port {
>>      uint8_t num_ports;
>>      uint8_t active_port_bitmask[0x20];
>>      struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
>> +    struct pperst perst[CXL_MAX_PHY_PORTS];
>>  };
>>
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_50133_
Content-Type: text/plain; charset="utf-8"


------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_50133_--
