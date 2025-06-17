Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91715215F7C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155706; cv=none; b=DkVJ63oqYHqCsys76DSqGlUCCW5MiWodl0V5lkalWkC2WN+0lO5eV4SGwB8Uc9O9o7fV3R8Ogjgo03qztfFkDBp0uwkafriDIKaqqJAbaqrsUIfvgviuIavKFEUDevAOZ5L41ryC7MEm20M9HEAKNttUURAEOaiO0+rxLW/4tI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155706; c=relaxed/simple;
	bh=DTxW1K6pPf7PCMcVYYfTxcoHeOKhXFXtVux/FXL9UJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=jMHq9EPHff479RjyPG6eeBTWeQhlq5OllIsNcPyPcCNHxjSw9qS2ihH8kr1wIrleZRQQwYIEZEjzPojypMfp4AOOLjztRglUwHz+H2Rx7PtPhDG/eiKGok9d9To9y+mh94nmigqjbDqNnayUEo5tVp4xDu2Yh+8LUyqHbyg32IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=izlujs3L; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="izlujs3L"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250617102141epoutp03c1e40304ba9aded2fc3735ce90ecd98d~JzVZzm2IS1042410424epoutp03k
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 10:21:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250617102141epoutp03c1e40304ba9aded2fc3735ce90ecd98d~JzVZzm2IS1042410424epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750155701;
	bh=RHnfMDcnjkCpNXmxxzs/C20X71OBG3mUzj26FeqODOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=izlujs3LCKUBIg49nVzC6FCeUhl+kIF4XNlDjpa26bxGBYGuei461kAtoTZCbrRcA
	 P4YS/jNcatxuKjZbTsUVotoFy7GNj5N5FwYk+TRR8vbVgPZ/8/3c5ckDxYrXUVRCY8
	 p6/TqPOYtRQ12RiqHgNoCrwOXQpMx80Lda+HpwcA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250617102141epcas5p3630447b43bcedd87c29009961428e537~JzVZeEtoT1868018680epcas5p3G;
	Tue, 17 Jun 2025 10:21:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.178]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bM2wM2x7cz2SSKY; Tue, 17 Jun
	2025 10:21:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250617100204epcas5p2a5516d83ce61909c730901772fe90ae8~JzERge6Dn0477404774epcas5p2m;
	Tue, 17 Jun 2025 10:02:04 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617100202epsmtip120c42834f6a8f3ac4e6cc9f3427f716e~JzEQPyDP91516415164epsmtip1a;
	Tue, 17 Jun 2025 10:02:02 +0000 (GMT)
Date: Tue, 17 Jun 2025 15:31:56 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 2/3] hw/cxl: Simplified Identify Switch Device & Get
 Physical Port State
Message-ID: <20250617100156.nllspip2jcykteid@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250610152906.00002c4b@huawei.com>
X-CMS-MailID: 20250617100204epcas5p2a5516d83ce61909c730901772fe90ae8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b@epcas5p1.samsung.com>
	<20250602135942.2773823-3-arpit1.kumar@samsung.com>
	<20250610152906.00002c4b@huawei.com>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/06/25 03:29PM, Jonathan Cameron wrote:
>On Mon,  2 Jun 2025 19:29:41 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> Modified Identify Switch Device (Opcode 5100h)
>> & Get Physical Port State(Opcode 5101h)
>> using physical ports info stored during enumeration
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>A few additional comments in here.
>
>J
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 133 +++++++------------------------------
>>  1 file changed, 24 insertions(+), 109 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 680055c6c0..b2fa79a721 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -558,17 +558,7 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> -static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
>> -                                  void *private)
>> -{
>> -    uint8_t *bm = private;
>> -    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
>> -        uint8_t port = PCIE_PORT(d)->port;
>> -        bm[port / 8] |= 1 << (port % 8);
>> -    }
>> -}
>> -
>> -/* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
>> +/* CXL r3.2 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
>
>I'd prefer the spec reference updates in a separate patch. They are noise here
>and kind of suggest there are real changes rather than just refactoring.
>
okay
>
>> @@ -611,16 +599,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>>          out->ingress_port_id = 0;
>>      }
>>
>> -    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
>> -                                  out->active_port_bitmask);
>> -    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
>
>Ah. With this in front of me the reason for the sizeing is much clearer
>than in previous patch on it's own. Combining the two will make it all more obvious.
>
right, will do the same in next iteration(V2) of the patch series.
>> -
>> +    memcpy(out->active_port_bitmask, cci->pports.active_port_bitmask,
>> +           sizeof(cci->pports.active_port_bitmask));
>>      *len_out = sizeof(*out);
>>
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> -/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>> +/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>>  static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>                                                uint8_t *payload_in,
>>                                                size_t len_in,
>> @@ -628,44 +614,21 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>                                                size_t *len_out,
>>                                                CXLCCI *cci)
>>  {
>
>>
>>      in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>>      out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
>> @@ -673,72 +636,24 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>      if (len_in < sizeof(*in)) {
>>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>>      }
>> -    /* Check if what was requested can fit */
>> +
>
>The check is still here... So why remove the comment?
thanks for pointing this out, will add the comment back.
>
>>      if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
>>          return CXL_MBOX_INVALID_INPUT;
>>      }
>>
>> -    /* For success there should be a match for each requested */
>> -    out->num_ports = in->num_ports;
>> +    if (in->num_ports > cci->pports.num_ports) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>>
>> +    out->num_ports = in->num_ports;
>>      for (i = 0; i < in->num_ports; i++) {
>> -        struct cxl_fmapi_port_state_info_block *port;
>> -        /* First try to match on downstream port */
>> -        PCIDevice *port_dev;
>> -        uint16_t lnkcap, lnkcap2, lnksta;
>> -
>> -        port = &out->ports[i];
>> -
>> -        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
>> -        if (port_dev) { /* DSP */
>> -            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> -                ->devices[0];
>> -            port->config_state = 3;
>> -            if (ds_dev) {
>> -                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> -                    port->connected_device_type = 5; /* Assume MLD for now */
>> -                } else {
>> -                    port->connected_device_type = 1;
>> -                }
>> -            } else {
>> -                port->connected_device_type = 0;
>> +        int pn = in->ports[i];
>> +        for (int j = 0; j < PCI_DEVFN_MAX; j++) {
>> +            if (pn == cci->pports.pport_info[j].port_id) {
>
>Given port id is 0-255 and your port_info has 256 elements, why not index
>by port_id when storing them in the first place? That should reduce
>complexity of this look up.  I don't think we ever actually look up
>by devfn?
okay
>
>> +                memcpy(&out->ports[i], &(cci->pports.pport_info[pn]),
>> +                       sizeof(struct cxl_phy_port_info));

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_--
