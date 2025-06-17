Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865E28B3F9
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155708; cv=none; b=tl1/8NNmO0ed6TgAb36U/L6CPGU8f8A2PJ0LE4MDGP5nIvNFnBtQBEdCsbMib8a2qdki0sxGyFtfGFE9ziFFrM0t/qGo97RP9r0tyiVQwlMlq7UrDUkHOMsPMx1AccGyxEnmp/NRIkFTg/OqubCuGYOA9aRyzn57y4wwBzxIksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155708; c=relaxed/simple;
	bh=iO7Km8/B29OZwQG0g4bxX/V5elNUV+4k/B+3YHxLAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=YFAV8EC1h1kiceiWLb9DBBmU19PiQF0WujpEbfFgwDg823v/L6brlvlB9W926YLmpp/v1JP/e20YGFX70/K2YUof3TvVkgjDvUbKHEA2lu84RvyD/n8oswvTzB4klJ1sx/JEX1XgT+F5NauGv7qFLM22dG7Ar+dVozG8PIv9OnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tQZyY0oK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQZyY0oK"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250617102144epoutp04405e649260794f6299a3985e0ae96c01~JzVcjBXzK1125911259epoutp04a
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 10:21:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250617102144epoutp04405e649260794f6299a3985e0ae96c01~JzVcjBXzK1125911259epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750155704;
	bh=3KgvRgTU4cn4BM4l0esPAnPMKhdKDAdRbUBviGxOSKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQZyY0oKjVGWmKb5P6D7kdehWwGzjoLpKB78XpszGuc6fGDvDG2R6vr1hMlY4E+kz
	 aLV8rFWZ3N8KkzmPbvlf/bGC0r74bZojZWM2cyxbbtduw/OSLaEfFjQEdyvH0ynXUg
	 kHuwb2+Azkmg27MfGHHls0P8RdJLGUB+eFqD5D3g=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250617102144epcas5p2c6ae5fd671c6b8434674381ffffddb13~JzVcR4YPO0587405874epcas5p2S;
	Tue, 17 Jun 2025 10:21:44 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bM2wQ48s1z6B9m4; Tue, 17 Jun
	2025 10:21:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250617101142epcas5p480d44eef68b94fb4590949e5fbf31e69~JzMsIoPeq1786417864epcas5p4z;
	Tue, 17 Jun 2025 10:11:42 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617101141epsmtip118bbb4d9ca9bc2fac510f4653dd7b2f4~JzMq15knE2132521325epsmtip1P;
	Tue, 17 Jun 2025 10:11:41 +0000 (GMT)
Date: Tue, 17 Jun 2025 15:41:36 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 3/3] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250617101136.z4ityaayhuglrvqu@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250610154501.0000213b@huawei.com>
X-CMS-MailID: 20250617101142epcas5p480d44eef68b94fb4590949e5fbf31e69
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a5bcc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35@epcas5p2.samsung.com>
	<20250602135942.2773823-4-arpit1.kumar@samsung.com>
	<20250610154501.0000213b@huawei.com>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a5bcc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/06/25 03:45PM, Jonathan Cameron wrote:
>On Mon,  2 Jun 2025 19:29:42 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>
>Very interesting to see support for this. It will enable a load
>of additional test cases.
>
>> added assert-deassert PERST implementation, reset PPB
>> for physical port.
>Added
okay
>
>Please also include some details of testing done and what happens.
>Given I know we have some issues with reset that we haven't resolved
>I'm curious if you see them here.
>
sure, I have tested this command using libcxl-mi. will share the details in the
next iteration (V2) of the patch series.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>> +/* Assert - Deassert PERST */
>> +#define ASSERT_WAIT_TIME_MS 100
>> +
>>  /* link state flags */
>>  #define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
>>  #define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
>> @@ -662,6 +666,114 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +static struct PCIDevice *cxl_find_port_dev(uint8_t ppb_id, PCIBus *bus)
>> +{
>> +    PCIDevice *d;
>> +    int devfn;
>> +
>> +    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
>
>As in patch one, maybe use the for_each_pci_...  Though with the callback
>needed it may end up slightly more complex that this.
>
right, will use the same.
>
>> +        d = bus->devices[devfn];
>> +        if (d) {
>> +            if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
>> +                uint8_t port = PCIE_PORT(d)->port;
>I'd not bother with the local variable for this one.
>
okay
>                 if (PCIE_PORT(d)->port == ppb_id) {
>                     return d;
>                 }
>
>> +                if (port == ppb_id) {
>> +                    return d;
>> +                }
>> +            }
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static CXLRetCode deassert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    ResettableState *s = rc->get_state(obj);
>> +
>> +    if (cci->pports.perst[pn].issued_assert_PERST) {
>> +        if (cci->pports.perst[pn].asrt_time == -1 && !s->hold_phase_pending) {
>
>I'd flip the logic as then can return early in error case and reduce
>indent of the rest.
>
okay, will update in V2.
>
>> +            qemu_mutex_lock(&cci->pports.perst[pn].lock);
>
>            QEMU_LOCK_GUARD(&cci->pports.prst[pn].lock);
>
>> +            resettable_release_reset(obj, type);
>> +            cci->pports.perst[pn].issued_assert_PERST = false;
>> +            cci->pports.pport_info[pn].link_state_flags &=
>> +                ~LINK_STATE_FLAG_PERST_ASSERTED;
>> +            cci->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
>> +            qemu_mutex_unlock(&cci->pports.perst[pn].lock);
>and drop explicit unlock.
got it
>> +        } else {
>> +            return CXL_MBOX_INTERNAL_ERROR;
>> +        }
>> +    } else {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +static CXLRetCode assert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(ocpgs@samsung.combj);
>> +    ResettableState *s = rc->get_state(obj);
>> +
>> +    if (cci->pports.perst[pn].issued_assert_PERST || s->exit_phase_in_progress) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>
>WITH_QEMU_LOCK_GUARD() perhaps
okay
>
>> +    qemu_mutex_lock(&cci->pports.perst[pn].lock);
>> +    cci->pports.perst[pn].issued_assert_PERST = true;
>> +    cci->pports.pport_info[pn].link_state_flags |=
>> +        LINK_STATE_FLAG_PERST_ASSERTED;
>> +    resettable_assert_reset(obj, type);
>> +    qemu_mutex_unlock(&cci->pports.perst[pn].lock);
>> +
>> +    /* holding reset phase for 100ms */
>> +    while (cci->pports.perst[pn].asrt_time--) {
>> +        usleep(1000);
>Is this happening synchronously?  I'd kind of expect it to be a background thing
>where we'd just check it had finished.
okay, will update it in V2 of patch series.
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/*CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h)*/
>> +static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
>> +                                            uint8_t *payload_in,
>> +                                            size_t len_in,
>> +                                            uint8_t *payload_out,
>> +                                            size_t *len_out,
>> +                                            CXLCCI *cci)
>> +{
>> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +    PCIDevice *dev;
>> +    struct cxl_fmapi_get_physical_port_control_req_pl {
>> +        uint8_t PPB_ID;
>> +        uint8_t Ports_Op;
>> +    } QEMU_PACKED *in;
>> +
>> +    in = (struct cxl_fmapi_get_physical_port_control_req_pl *)payload_in;
>
>Often we cheat on these where the type is locally defined and do
>
>    struct cxl_fmapi_get_physical_port_control_req_pl {
>        uint8_t ppb_id;
>        uint8_t ports_op;
>    } QEMU_PACKED *in = (void *)payload_in;
>
>Given it's all together the type isn't confusing or ambiguous even
>though we use a void * instead of the more specific cast.
>
>Note also that it is better to stick to local style and use lower_case
>style for structure element naming etc.
>
got it
>> +
>> +    if (len_in < sizeof(*in)) {
>> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>> +    }
>> +
>> +    uint8_t pn = in->PPB_ID;
>> +    dev = cxl_find_port_dev(pn, bus);
>> +    if (!dev) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    switch (in->Ports_Op) {
>> +    case 0:
>> +        assert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
>
>Even for these probably
>
>assert_perst()
>
okay
>> +        break;
>return CXL_MBOX_SUCESS;
>> +    case 1:
>> +        deassert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
>> +        break;
>> +    case 2:
>> +        device_cold_reset(&dev->qdev);
>> +        break;
>> +    default:
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>
>> @@ -3878,4 +3995,15 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>>      cxl_set_phy_port_info(cci); /* store port info */
>> +    /* physical port control */
>> +    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
>> +        qemu_mutex_init(&cci->pports.perst[i].lock);
>
>perst is definitely port wise - not linked to CCI so that stuff should be
>in the port structures themselves.
>
>> +        cci->pports.perst[i].issued_assert_PERST = false;
>> +        /* Assert PERST involves physical port to be in
>wrap at 80 chars.
okay
>> +         * hold reset phase for minimum 100ms. No other calls
>> +         * are entertained until Deassert PERST command.
>> +         * https://patchwork.ozlabs.org/project/linux-pci/patch/20190523194409.17718-1-niklas.cassel@linaro.org/#2178369
>
>Blocking other commands is fine but we should lock up emulation of other stuff
>in the system and I think you currently do.
>
got it. I think you meant 'we should *not lock up..'
>> +         */
>> +        cci->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
>> +    }
>>  }
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index 9eb128a1e8..f877d60b39 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -146,10 +146,18 @@ struct cxl_phy_port_info {
>>      uint8_t supported_ld_count;
>>  } QEMU_PACKED;
>>
>> +/* assert-deassert PERST */
>> +struct pperst {
>> +    bool issued_assert_PERST;
>> +    int asrt_time;
>> +    QemuMutex lock;
>> +};
>> +
>>  struct phy_port {
>>      uint8_t num_ports;
>>      uint8_t active_port_bitmask[0x20];
>>      struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
>> +    struct pperst perst[PCI_DEVFN_MAX];
>>  };
>>
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a5bcc_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a5bcc_--
