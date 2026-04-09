Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5D242D89;
	Thu,  9 Apr 2026 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772176; cv=fail; b=MfbrwTZL1wbz69LH30CPI8Qgjk01ls+tV8sLdaXcYLOg2LJ8aWQWbFNA54Nd9uq7fW+Z6DvQaAIzVHEF33nEA5kC2llr/0k0euMY7C5RcIYVPxcTpi+E8qkW1WpyL8dfa7mAUI8iXp68SvK24Gb0aA7LNX7dVDnUc5t6kglTOvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772176; c=relaxed/simple;
	bh=l538b8nh06ciUz6qNaovppUU6OHjqEYb9ccjjnZBbHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=XHfn7+bYdoDWqE8xXDdWWsJwIEmOMnCqmH6sG3o/W9d5cSgBvpjUHw7kvLME7Foxhrv29lzAInpEKV9KwaaXq1+f+4bIgW7p21qgk+Wq54wKkYdm7Tf5U7zjhFFXUS7DsY9SB7T0rZGuzoXE3bQModZWdPqm3iFvB0WPNyDitoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AuiOSywC; arc=fail smtp.client-ip=40.107.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AuiOSywC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYUuvaOs4JUhHsaDfRMl4nY5VKYHpIZNBPDZPvbhl8QGUtsTg6p633hPigbFJFxImUuGH3TgvVyrcVV5IQhX9sP8u8txlIBJUGplhAmBUMTpYGUHKGgQNI6QRFsOoMWwJFHvX0m80maJRS/keLYV9mvZ75J+356/wiEornBwQ3sQ0Asu45zZsJz2XkJxJkXVm9dWO00XzFUyJRjzCa8e/4JrZTE3TxWaSc53dSLdGjAjA7Vi7dMbs4n0KYD+HhwPos2hcMzdKowsS7a0m8smFI+GsbqhHgkyNHJwk25OglUfa5bUa0OkfjTqwBX8ZLWxKBv8APJDpbFeBw4Mov5bMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaYeBad3AERoWiKtoQthc/RjJi+suUcPiGU0I9Dk6TQ=;
 b=bFpg+58aRiIeGfqCTheWVSG8Cc0MM/BtsM+g/Y/7VhoE7b3qKKShlBpSYbFWfJA9GxmqwSUJI/aMHzN9ZW3XXCHYxl+QhWqlpjc30O5b5jF8XJ6aE372jb5v3R3spM1lTBBoPlrt7O7jy/uWwYmzYjyMKdd2XIYGGKUStXnYjf0e1FDshmJW2jtXlYhCdsuvR6CC6doN3Ij78kMoUbAEC98oHL1gZ5bVgV4viySom5Nn6Xgral9QL5p/pDvyKKGfa04c1KCjUEQOC15WIJwaY8TpXX8q1n6VOLAqI1I6xVrfY6KCeqhSXeWqhhwCdQX6sLhZkAqC4hXfHO+eLUOPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaYeBad3AERoWiKtoQthc/RjJi+suUcPiGU0I9Dk6TQ=;
 b=AuiOSywC7HuaZBodZvibdDHqsH5Y9Fu8YESZVNFwSGMwf2dCXSnUKVtClPPVtmbMDFrRSdcQ/rxXVrmK2htzBO8WIoIJ1VxJVIa1COfy226IbEhzjg3QSakExatgG93j9tFf+47nbA6GRuo8+CvjH8lxbXPjTf/3x6ZxHssr2ew=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 22:02:50 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::1d) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 22:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Thu, 9 Apr 2026 22:02:50 +0000
Received: from [10.236.181.115] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 17:02:49 -0500
Message-ID: <59f69b87-e37e-44c7-8c15-c332118622b5@amd.com>
Date: Thu, 9 Apr 2026 17:02:49 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alejandro.lucero-palau@amd.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20260403210050.1058650-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: f299915a-49d8-49f2-5b4d-08de9683bdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|30052699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GLKsK71BeNDhvxiO99jey/JvgkMTwOym4JIg3IcXuah+feHvKtm1WTwvii26cV7q5UtudYL341VzxsHBtq4j0Tf6oul1mre0ioW1RUibosYgPerzABrUQV6rpChd/s4eDZeVDwROm61e1Evt5WZed7LOlrXWXy5DU/NwhDq9CDjZ1jgUM8DtBssjKVp6khFS/1rN3IaADB/V64BpESJyePJUf/Sc9Y/ZleOaAcQOMUB0RpkeucgO3T4UqIg/FaB+388ILwudHVATGBtdGtUfSX3hDerJryr3kZvQqvnWzNixenbZu6UQLEh2fUfv9gvqeQ/Z2D97RX4T4JFjtXjZUPpn+LXloaJm3McgV4RLx7YzN8tsz/n2s7K1vLSXylZLAJpoL0CsItVThd7zZFoiIaqK+9aTdzEZG2QNNTGR/ULDGSHQfXHgqTWqxDolzrpbZk1vQ6Hzg3bYotKYqTNUaqjeH34n6zdtuQGDwD35bX08vWsOqNqhrvj1ngFSlswlMlAq8vJtD4YlBlmgMg/HgAKQnNmBXhvSgeh5/IBWeVsuU4VGNexCPhjAtauIESopsEWljOrzvIKTzWKLCYxzKeGpC8ij6GyAFidQTmDLXUBgw9ziERiPmIZamDdN8Vr+ffYqKzkM6Ta5y7tYKb2Wp4Tq55uTST7kBxUlT3STcxG9wBZRstaHYCqa54uMKYOQMHTxcUZn4PQX3QjMNFdy2nAjjg1we2w9QkzK9Vej2g0ATSZsKH+FrqnbdciiXdTvnpFAEe2mn7+hCgBQDsjfMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(30052699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l79fL8juY9foXKmtLzWgjgymp9QsRBNTnY0nI/xGx2XMD+giXvj+rva8sPOjeOfq7jo3iPzEMvrrZfmUArqv44FaJWiIqurR4YSJLvkrD7kQhY/3YoTwgfIGrHlSS03X/ilfV69rs7UmrO1B+8oY2trFD/jm7rH+PUUCkPqsPeVol8tmVKOu/XhP+hMt2UVzqH09MWYTMe19bfMSt74i9cZfFZG8dY78DGarh6lvS4a4r4BoipE0Ms5MO4nJvpeBJmELOHj7c05EBe/MPJqwzp1mY/9LTUEJLdjC2PJnQyUXLnYotvkm/MMwY8HiroU6z66kP845rm+AuiKdbI6rCQB+xhpUXZ7hMaQlwOrf1jeuuE2QhkgzpJ+3bovwnPzLNabhIS9DmIRX8EDeg6Z460bQE0EvEOf5hYKDHOsm7QktDybsWrpx4bqtlxYH0RCe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:02:50.0395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f299915a-49d8-49f2-5b4d-08de9683bdb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

On 4/3/2026 4:00 PM, Dan Williams wrote:
> To date, platform firmware maps accelerator memory and accelerator drivers
> simply want an address range that they can map themselves. This typically
> results in a single region being auto-assembled upon registration of a
> memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> parameter to retrieve that region while also adhering to CXL subsystem
> locking and lifetime rules. As part of adhering to current object lifetime
> rules, if the region or the CXL port topology is invalidated, the CXL core
> arranges for the accelertor driver to be detached as well.

I'm probably missing something, but where does the core detach the accelerator driver?
I assume it's part of unregister_region(), but I'm not seeing any driver_detach() calls
on the accelerator device.

I don't think there's any demand for this at the moment, so it's more of a "food for thought"
kind of thing, but why not allow for a fallback mode of operation instead of detaching
the accelerator driver? First thing that comes to mind is an optional callback as part
of struct cxl_memdev_attach that is called by the core during CXL removal. The assumption
would be that an accelerator driver that provides the callback would clean up all of its CXL
usage in the callback then continue in a PCIe-only mode of operation (hardware willing).
When the callback isn't provided, you get the behavior in this patch. Again, this isn't
needed here but may be a nice middle-ground later on down the line.

> 
> The locking and lifetime rules were validated by this local change to
> cxl_mock_mem. This tests all the lock acquisition and cleanup at
> modprobe -r cxl_test time. More work needed to also test the full positive
> case.
> 
>     struct cxl_attach_region
>             attach = { .attach = {
>                                .probe = cxl_memdev_attach_region,
>                        } };
>     cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/cxl/cxl.h         |  16 +++++
>  drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..1698d15ec1ca 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -153,6 +153,22 @@ struct cxl_memdev_attach {
>  	int (*probe)(struct cxl_memdev *cxlmd);
>  };
>  
> +/**
> + * struct cxl_attach_region - coordinate mapping a region at memdev registration
> + * @attach: common core attachment descriptor
> + * @region: physical address range of the region
> + *
> + * For the common simple case of a CXL device with private (non-general purpose
> + * / "accelerator") memory, enumerate firmware instantiated region, or
> + * instantiate a region for the device's capacity. Destroy the region on detach.
> + */
> +struct cxl_attach_region {
> +	struct cxl_memdev_attach attach;
> +	struct range region;
> +};
> +
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 11bc0b88b05f..090f52392b20 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1123,6 +1123,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  				   struct cxl_decoder *cxld)
>  {
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		/*
> +		 * When a region's memdevs specify an @attach method the attach
> +		 * provider is responsible for dispositioning the region for
> +		 * both probe and userspace management
> +		 */
> +		if (cxlmd->attach)
> +			set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	}
> +

It seems unfortunate that you set the region lock bit here and then immediately do a check
to set the bit again. I can't think of a way to leverage cxld->flags for type 2 in an
ergonomic way though, so I guess it's fine.
>  	if (cxld->flags & CXL_DECODER_F_LOCK) {
>  		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> @@ -4226,6 +4239,115 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +static int first_mapped_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.region)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * As this is running in endpoint port remove context it does not race cxl_root
> + * destruction since port topologies are always removed depth first.
> + */
> +static void cxl_endpoint_region_autoremove(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
> +/*
> + * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> + * simple case of single mapped decoder per memdev.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		return -ENXIO;
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	/*
> +	 * TODO auto-instantiate a region, for now assume this will find an
> +	 * auto-region
> +	 */
> +	struct device *dev __free(put_device) =
> +		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +
> +	if (!dev) {
> +		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> +			dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +
> +	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"region %s not committed for memdev %s\n",
> +			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (cxlr->params.nr_targets > 1) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"Only attach to local non-interleaved region\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Only teardown regions that pass validation, ignore the rest */
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      cxl_endpoint_region_autoremove, cxlr);
> +	if (rc)
> +		return rc;
> +
> +	attach->region = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
> +
> +/*
> + * The presence of an attach method indicates that the region is designated for
> + * a purpose outside of CXL core memory expansion defaults.
> + */
> +static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
> +{

I think this should be renamed to something like "cxl_region_is_private()"; it
better matches the intended use of the function while lessening the burden on
a non-type 2 educated reader. Also has the added benefit of being one less
change site if the mechanism for determining if a region belongs to an accelerator
changes in the future.

Thanks,
Ben
