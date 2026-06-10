Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6D348898
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111287; cv=fail; b=oGsHSVgbixWkOpysfNo6VV6gwDBWA7ZmlAP8oWOIfCb+N4ryM7EJ/pV8AYef1zKoYq4lcwfPrRjYDotGiikHiHloVgnLSkl4Xl2W8FQsTomzD3IQHbk4qhlg1XN7AzSh6f1yIZeL6s2+vAsh4HQRV66t5y1wPpzDYuTvP89uvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111287; c=relaxed/simple;
	bh=qx+HOuyUaAx8FJR8xmLIvQwM3hRc2NGYiS+y1aCOYVs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FA0gYtZxz3K05+s4ZEyzWzkwGD1J9eHMY0qhSRK5QrcG5ON6fCiKuPKGkyA+L15e6NEfmRVN5TcJHpVjJ4HWLlZTcmlU6fTN/g6BpkW1Dj33adHSogsWGTMRctCWAQEntbCxzjeeNk6lfKNYMF7lVSjoY0pnaf2oT0icG+C9Ii8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNfh1usJ; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNfh1usJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIh2PVgSWsV9wGXZIJBIBQXajVjHAHXfKyIyxYIwYTN5fdE9LiySVYgC/Dg0wVsx57gPFCBXBJ5Y606dOwbvN5YJQPCt/sY+IMhPfuPUfmn0knBYuGugCHjOW2bCTtKt7Jtl4yAEIOKVMxP+qdByRU+JmggKR5zDv6MxZY3NmZktHdIb89UkNR9BCfeKIe3TS8GB5XargXZ8Fa3a6TPCvq37VNc9Dej71czob2MgBsFoiw+UKnQkKggD1pR4cbJJfJ13XRBoDrKZIrZMvpGyrqdqqHudOxskl6xFW65azJPmwpRK5IYBphwv68CivWEioxyCgc9nA8gALmA12I+m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evAKWPKs6o9srKM3AjcZvQjmmfbKWUXopMUxyDU+yX8=;
 b=S24z6HE6/UZ9dF4Z4prJDoQk5Xj6hR0ULG3slY1bqSCXKqwj+i59OsT4SF1DXUdEVMerRStLD/P9he8i2chRTAYpIpPApEHs6aFScrmoEjfj3U2U3B5xCa4X25UKx/pHhnFCsGf1cUU81HBLcrf0oOljHOIwsbZICwsSsXMpC6FjjXxpVyufFLQk4seq8LNxxalkiymWk+RV9nSkDQJfOdBeDrRgIOSXskhFfJadwnUCnO8xApm5x5S0rMRjw7Lp26+fVdBc5+rJTB4e3FP1Qq2Gn1T77Y46JqJFIvAcaCmBkf4WEBkciY4tVf8AjemYSKmg2QNHf0hoRHqbj7AQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evAKWPKs6o9srKM3AjcZvQjmmfbKWUXopMUxyDU+yX8=;
 b=iNfh1usJY1TBq+8QeIqiY6FVzHr0SFJXNMR/3I18R7W+jkpPeGMZTy2CvOzjUCD4Pq/ZW9B/P91QbsVxY4PuS0sxG+2yOUH7FGCqyyTy0hCdYCeEfBrQAfXNLTBzHzT+YVnADZlX9OXel/T3Kc14YX4/g5g6UkRqGOsRA5DtUwQ=
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:07:57 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::40) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 17:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 17:07:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:07:53 -0500
Received: from [10.236.180.156] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:07:48 -0700
Message-ID: <9eba4ef4-afd4-460b-b60f-b2d016a42194@amd.com>
Date: Wed, 10 Jun 2026 12:07:48 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <djbw@kernel.org>, <jic23@kernel.org>,
	<alucerop@amd.com>, <alison.schofield@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-3-dave@stgolabs.net>
 <c15c6902-3d3f-4e9b-8dc2-2e95cf0719f2@amd.com>
 <20260608225431.zvgrwk2kfqwr2usq@offworld>
Content-Language: en-US
In-Reply-To: <20260608225431.zvgrwk2kfqwr2usq@offworld>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c83b556-a967-4f6c-0776-08dec712cf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	MajrmOuyzIxXqoyYossWV+ts0/qnUvDKeAhx7XJjLzLXG0bQdhVq8f6sGETKL27jxAf0DhMViGN2J8CeyEbbD8sb8+WnLcQ3fGFaJ9hA17c3sGDWYWUWHsz3jCur+2K1u0mHA5zyH1TVUOK2hUhHnoL4HmAyzdGHSvpds8AgXGvVel+mLoWYvlLE9cFa6zlvQpiM1dkFbcYWYy5FdWwLTMBZZWLek9HznHB/3xsjRsF7/Q20x4Iv6X97vDdf2f01F3i5MDc8TfBMRrASM1wj9H0K6Q+KQrbN728LmB0U3t8pE6Vw6nmf/VLCNSqBlxmW/jnn6hRJGltF8bP3+2OM8VtLicMP47Bqjm+B+zf6uxitFvmQjd3h3s8qJVfQqiKNVQ9o+t68nUgbiC/defDyozmtyNgFLI8TK3r/tVwaBKxAsReHIWYoUeYypbc6shdPnmXPxjZmLaDJtO8yDfrjAPpYK3neOt0Cbe+JwKPqaUo6TkHRli/rAzR6mLlBgx3gjFSWHHnvBz+Kka2cQdh9cLo6ajOfmQuku6pS4WtgKdp9yE9rDUPYGwV9mTTAbJM3+t9zaroXp5TTvkg5CEG6OPbQrniA13PYDZthBbFQ+F+Mr+URS9fKkwOqtMRZ+JLmJosuQ6BFJqGIAC63fMhMtEIrp7fq4yLehe1w4Z/8+MUQDiloRdfS83KEkHMNXjGtNNZJ7GvLq8FO2swMiOTk5fvGJuNw2EcLA9YLEbGV/WI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C+KgvgBNI2fonccb54VN3ZWOor21ZiZu2pOHN5/JGtKiKkDBWZJY2zcDY/elAhRSRfaIfaE9cX0cakjJUnCS07DJ1VoazBM3NzQ1DosGF4j+K2sDuXWCT3fdVez6YSkLtN8zQ5AoBoW9Gxy7SWBvul9Umm1ZcZ7ZnpWr61Barvr1piWPIUCobsRQfvcXAf/Fhd9fxRCkF8FIHI3ccWoOsCvFxTXdHnpC8pHsfEWQb/gg0LrlZrB0qgPM+N0dOwX5oeb/xVtx+hE8gbJi0M/FC37wMuqmieaDXNo7CH7VBBhe4aZmuFW6utsJgHOaBhGIx9HgeLOhaW+5lPtdd5pxe3IGxNBevOjwNBhnYfx4gVnkvsohngY81a6dPmIR7Q1waCfZSeTcdPClbWRhb1fvoj96hjJ5LO8ctC+tr1bF2933MDKpJ+aujwampdXdcY8q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:07:53.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c83b556-a967-4f6c-0776-08dec712cf65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

[snip]

>>> +
>>> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>>> +{
>>> +    u32 status, ctrl;
>>> +    unsigned int scale, base;
>>> +
>>> +    if (!bi)
>>> +        return -EINVAL;
>>
>> Same thing here.
> 
> So this one is redundant yes, but not the bi_rt one, as it is optional.
> 
> I went with this:
> 
> @@ -1003,9 +1003,6 @@ static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
>         u32 status, ctrl;
>         unsigned int scale, base;
>  
> -       if (!bi)
> -               return 0;
> -
>         if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
>                        readl(bi + CXL_BI_RT_CAPS_OFFSET)))
>                 return 0;
> @@ -1029,9 +1026,6 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>         u32 status, ctrl;
>         unsigned int scale, base;
>  
> -       if (!bi)
> -               return -EINVAL;
> -
>         if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
>                        readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
>                 return 0;
> @@ -1111,7 +1105,9 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>                 if (rc)
>                         return rc;
>  
> -               return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +               if (port->regs.bi_rt)
> +                       return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +               return 0;
>         default:
>                 return -EINVAL;
>         }
> 

Sounds good

...

>>> +
>>> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
>>> +{
>>> +    struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>>> +    struct cxl_dport *dport_iter, *dport, *failed;
>>> +    struct cxl_port *port_iter;
>>> +    struct pci_dev *pdev;
>>> +    int rc;
>>> +
>>> +    if (!dev_is_pci(cxlds->dev))
>>> +        return 0;
>>> +
>>> +    pdev = to_pci_dev(cxlds->dev);
>>> +    struct cxl_port *port __free(put_cxl_port) =
>>> +        cxl_pci_find_port(pdev, &dport);
>>> +
>>> +    if (!port)
>>> +        return -EINVAL;
>>> +
>>> +    if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
>>> +        return 0;
>>
>> I'd return -ENXIO here since we only report the error with a dev_dbg() later on.
> 
> But this is not considered an error.
> 

You're right, don't remember what I was thinking there.

>>
>>> +
>>> +    /* walkup the topology twice, first to check, then to enable */
>>> +    port_iter = port;
>>> +    dport_iter = dport;
>>> +    while (!is_cxl_root(port_iter)) {
>>> +        /* check rp, dsp */
>>> +        if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
>>> +                       dport_iter->regs.bi_decoder))
>>> +            return -EINVAL;
>>> +
>>> +        /* check usp */
>>> +        if (dev_is_pci(port_iter->uport_dev) &&
>>> +            pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
>>> +                PCI_EXP_TYPE_UPSTREAM)
>>> +            if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
>>> +                           port_iter->regs.bi_rt))
>>> +                return -EINVAL;
>>
>> This can be one if statement: if (... && !cxl_is_bi-capable(...))> +
> 
> Sure.
> 
>>> +        dport_iter = port_iter->parent_dport;
>>> +        port_iter = dport_iter->port;
>>> +    }
>>> +
>>> +    port_iter = port;
>>> +    dport_iter = dport;
>>> +    while (!is_cxl_root(port_iter)) {
>>> +        rc = cxl_bi_ctrl_dport_enable(dport_iter);
>>> +        if (rc)
>>> +            goto err_rollback;
>>> +
>>> +        dport_iter = port_iter->parent_dport;
>>> +        port_iter = dport_iter->port;
>>> +    }
>>> +
>>> +    /* finally, enable BI on the device */
>>> +    rc = cxl_bi_ctrl_endpoint_enable(cxlds);
>>> +    if (rc)
>>> +        goto err_rollback;
>>> +
>>> +    return devm_add_action_or_reset(&cxlds->cxlmd->dev,
>>> +                    cxl_bi_dealloc, cxlds);
>>> +
>>> +err_rollback:
>>> +    /*
>>> +     * Undo all dports enabled so far, including the failed one.
>>> +     */
>>> +    failed = dport_iter;
>>> +    dport_iter = dport;
>>> +    port_iter = port;
>>> +    while (!is_cxl_root(port_iter)) {
>>> +        cxl_bi_ctrl_dport_disable(dport_iter);
>>> +        if (dport_iter == failed)
>>> +            break;
>>
>> Nit: you can move this into the while statement check above. The extra overhead
>> is worth the readability IMO.
> 
> We still need to account for the failing dport-iter, so moving that check will
> still require another flag. I'd rather leave as is.
> 

Sure, I'm fine with that.

Thanks,
Ben
