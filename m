Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29519755B
	for <linux-cxl@vger.kernel.org>; Fri, 19 Sep 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279811; cv=none; b=QlsJKELAQAFNQBGQHV/WJJ0oUy7V56b5A9JXodp0zEilAJOacZCp4W9gzEL79DVRlrHlN3eUKrYk42gO44YX9jQIU7/lLFWzTc1ilcJkRXJnOEjOQs7JCJDxXmM/Y3zyjr5rtoZCfkySCB9FiduFFvpTujFSJACpSXmjBTZAvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279811; c=relaxed/simple;
	bh=OxbrzSFC1EPNAfXl/IWTc6wZg4oz2KAGit6n/46HSUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=pQAkiuHOXdbfzJdsFcCJwkSYUdrWNvOZpMqHfHtSZTPostRJG42LkTuSSA3R9twL5S3WmletzcBfspUqZ6lARY2KovEQ5PzxdGZerZ3AGyiZzH4LwJXz1n4J5qupDEKM2f0hkG8fBW9AkgZ74ErfIHOSQMfg4muRuX5vcGnIRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iZVQgNXo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iZVQgNXo"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250919110325epoutp04c652d09f64659330ec381b10cd26d342~mqirtGFWW1637616376epoutp04O
	for <linux-cxl@vger.kernel.org>; Fri, 19 Sep 2025 11:03:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250919110325epoutp04c652d09f64659330ec381b10cd26d342~mqirtGFWW1637616376epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758279805;
	bh=6kmVAHMIY5EUz8/oQT22z2+iEFOIcjXTLGTMM76hRUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZVQgNXoDO9MvNk92urbtwm/zG66OBoWtfD5BF7tSULsPsL3faIfLyK4tKhv8FfNh
	 dH4lm+xFcTcJyu5s/n2LbFGV//PxIcwJmaavivJMz2GSyQVqH5mx8vfCjWXrqlhHuh
	 zNNR8TEO0GPVW80UycKBxIIrYt1AaOxs5cExCza8=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250919110324epcas5p205ecc138beaa8dca32cabc6905e1e101~mqiqq1-jQ1991019910epcas5p2s;
	Fri, 19 Sep 2025 11:03:24 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cSqP75wwXz6B9m6; Fri, 19 Sep
	2025 11:03:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250919110323epcas5p38ea4211afa939c30510a8a0f9cff1c5f~mqipWW0x91372513725epcas5p35;
	Fri, 19 Sep 2025 11:03:23 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250919110321epsmtip1030d4158b8b7f48695c99043044221e9~mqin6tbwy0084900849epsmtip1g;
	Fri, 19 Sep 2025 11:03:21 +0000 (GMT)
Date: Fri, 19 Sep 2025 16:33:12 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, arpit.sysdev@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH v4 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250919110312.naudjnvhsjmxaxjk@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250917165535.000021b1@huawei.com>
X-CMS-MailID: 20250919110323epcas5p38ea4211afa939c30510a8a0f9cff1c5f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080803epcas5p1cd11689108b259f21908d9779993cc0f
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<CGME20250916080803epcas5p1cd11689108b259f21908d9779993cc0f@epcas5p1.samsung.com>
	<20250916080736.1266083-2-arpit1.kumar@samsung.com>
	<20250917165535.000021b1@huawei.com>

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/09/25 04:55PM, Jonathan Cameron wrote:
>On Tue, 16 Sep 2025 13:37:35 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> -Storing physical ports info during enumeration.
>> -Refactored changes using physical ports info for
>>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
>>  (Opcode 5101h) physical switch FM-API command set.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Hi Arpit.  One question inline, and one comment on code I've moved
>around whilst queue this up.  I'll push out a tree to gitlab
>(probably tomorrow) and when I do please check I didn't mess that up!
>
>Jonathan
>

Hi Jonathan,
Thank you for the swift response and review comments.
Sure, will look into gitlab tree once up.

Thanks,
Arpit
>
>> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
>> +                                    CXLCCI *cci)
>> +{
>> +    uint8_t current_port_config_state;
>> +    uint8_t connected_device_type;
>> +    uint8_t supported_ld_count;
>> +    uint16_t lnkcap, lnkcap2, lnksta;
>> +    PCIBus *bus;
>> +    PCIDevice *port_dev;
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>> +
>> +    if (usp->port == pnum) {
>> +        port_dev = PCI_DEVICE(usp);
>> +        current_port_config_state = CXL_PORT_CONFIG_STATE_USP;
>> +        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>> +        supported_ld_count = 0;
>> +    } else {
>> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +        port_dev = pcie_find_port_by_pn(bus, pnum);
>> +        if (port_dev) { /* DSP */
>> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> +                ->devices[0];
>> +            current_port_config_state = CXL_PORT_CONFIG_STATE_DSP;
>> +            if (ds_dev) {
>> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> +                    /* To-do: controllable */
>
>In what sense controllable?  It should always match what the downstream device
>is presenting as.  Do you ultimately mean if we mess with the alternate modes
>and reset the port to have it come up as a PCI only device?
>This will need to be more complex as we add different CXL type 3 device support
>of course, but I'd still expect to auto detect it rather that control it directly.
>

This is with respect to your review comment from v1 patch:
https://lore.kernel.org/qemu-devel/20250602135942.2773823-1-arpit1.kumar@samsung.com/T/
As per my understanding, controllable was identification of the specific type of 
CXL type 3 device and accordingly initializing connected_device_type. Since you 
mention auto-detect, does it mean using object_get_typename() to identify the type
of device and initiliaze it directly to connected_device_type rather than specifying
it explicitly. If yes, then this anyways rules out controllable part, hence the comment
can be removed.

>> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
>> +                } else {
>> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
>> +                }
>> +            } else {
>> +                connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>> +            }
>> +            supported_ld_count = 3;
>> +        } else {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +    }
>
>>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>                                    DeviceState *d, size_t payload_max)
>>  {
>> @@ -4691,6 +4706,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci);
>>  }
>>
>>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>> @@ -4777,4 +4793,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci);
>
>I'll shift this to a later patch whilst picking this up for my staging tree.
>I want this ahead of where we introduce cxl_initialize_usp_mctpcci.
>
Okay
>>  }

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_
Content-Type: text/plain; charset="utf-8"


------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_--
