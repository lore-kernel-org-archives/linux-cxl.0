Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B43955FD
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953041; cv=fail; b=Uu4LiwHZ14fSa09BV5hrlJnqm/7Iju9C51wG9itYqOwqX+zyGFDgbdiJlDRw1pRA0+y2e/ZPxSaLmoFuN69bxX8mBLW8hhsMNzlypLm/Xq+Z1JaCoIl0p6lS91oGCUOvTnkBBQnGCuNmAPQuyyjS0TFMhQSTGRi0cVDJTPpY3DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953041; c=relaxed/simple;
	bh=Hov10GD3FuOMIFbS0GvEuw3tNU/6l+BIMVJRNvNuXPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JrO02TrBAN1ca/Axxf0NN6iTgtrzAHO4mF47J/cx1HGbPxAcUkpmJThqPj8XrjkTO3XP94Huz79AJfohU3SstW2ds/qgkGgo5G1P8bm6RM3ksHTnF8SudJIkHTU042QMvNJYjbdnUCcCTh3TyJeRBPVe4NA5dFyhsnPB/hIEm4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XxHiUsCG; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XxHiUsCG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/+A5RyRM3W/8fMyarv4aw6xiiX8sJfQje3E1Z87oeisZ6+23zuYPsrashPgjRsSA2R+J8hNrkWI2tpHwo/FUxV9S1qnbi918c1a4XEqYZVZ2Fca3jy5rtP8oZrpzkm8xKeHPUoF42aw0Qv9MQ9AHxSspu5z9Blc8MVGRN7VEZoA2uLbmHzsBjr676hVbJQLKBOsPluYg1Np2d5ZrKIGchuxxJ21kv0mPOgXrg5lhEXqK5DAIIFRU8t4/B70ZeNYiE2g34JKHo54EBtodjJIpoqby6dW9WbG2P4onf4PYjyOhB4vOskKNjMyhZkzMQx8UJE3uN7l//n8XvhD84Rylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1afIXYYh79j6927ej8LbDztKfhuKJlNaKliUpDcnDg=;
 b=ZwCpQUOc1LOuBRube9KA+BPX53yJoRvIGlDg6ODoswAz84oEgQMeUb9XRMRbynECrwRy9DiPT87SepIufdD16jaErCf4z/pVqt3bqaXfc7QUW05QFjTs6S5XYKxiyVkkqwkKNp0BFeI+hq1uiOG9ZG12uXT3/9v+mqeIrAmBw5H0bOLNDKUUd1n/lBg+9GpQ2HCZ9bCJzYHihaEDk51EWFgZkXxWj69qpOUsR+Ys8cMQWEqNxx30pH67xwNKIXWi9CYSdt6GaIcqr7sKept3jKjqkFd2tOWINsvfdMfmXl/uLMzVmqsHjsi45r/cw4yixooCTq4wsaF3CPqZ1bwmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1afIXYYh79j6927ej8LbDztKfhuKJlNaKliUpDcnDg=;
 b=XxHiUsCGrqCty3ld8XQJXfkW0bOQvGbiFKmfy7iVR4/eFA0ZzJsRNad+vKXRcSD0rLHNCpUzvLDlJsfUDFoMvILOrcFi2Ttbz5exMYmPFlmzbBcW5jaRK/LbNb2RSOJrntsJQpRqJNE5E8d3jDxHWykMGDQTfsmLnzuKrnE3634=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 21:10:30 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::65) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 21:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 21:10:30 +0000
Received: from [172.31.129.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:10:28 -0500
Message-ID: <c15c6902-3d3f-4e9b-8dc2-2e95cf0719f2@amd.com>
Date: Mon, 8 Jun 2026 16:10:28 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<gourry@gourry.net>, <dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-3-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260605003329.2584012-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: debb991e-4ccd-4d34-f33f-08dec5a25ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|6133799003|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GgPhThcxXgTOJhRsN8v1FNR0LaV9oqLKY2uab2kGK4PIPPcV94TSpZr0Ygo4fMqQG8r7xfpZoIhNJXk0haDbYo3dTMYiEDMnYGVWbZKK8SgCH43WKa/Jv7ZpXWnwu5c2QG45nORWyzzr9RARrPSBAxEozK9ajlY2KWvYKsHplbGs4Qla0WSTpsrPrb1YHplskz/YFwnN435QI0lhThRfLsNo6qdVvR927Kv0AZ52drWkJ6NRicCt17ujFxRWgULhaHPekJ82Hj78Bv3X49YV4viYVhoCzYzOAymMaTJcFAOu2/p3CJdPrhMi1Rjnr2vVjuAd5Tibki4X7KM2d8lWJjPTK1L/kYIxokF2Akaz/e9Ydz0tcCtlCA4bJx0DK068n0hIgBdZn53W1hFngO4OAEWrt+L4hhpzbNfbM9RKZwGkdFlrnhbV8VFgyJvIbAdDDnsn/UrzkSeUm6BA+HJXl64mjCznZdRQDw5EZzOWSATyO2Jnu5rSxuCeEADXH2gbhk4qk67scohlajYrcGvB2GzLNaqUKfUAJLT0cTwkCFcO35tKOaOKQeBUAWt1I/FFG8Um4BCwqlchsEYOaHkqPKkv8pevw27wi4v/qN9PypPMV9qUVLYe3Jo+GRLy8Skyy9YYASn0JKZMBXlI8T6SfvqntOP0JIwOluTpR6UYA6wsZRUDqFGHLkIuDI7oPz1oEWqvSzZegf9RGX+vdgywDLUMNZIeS7yLGOt/nZWEbsI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(6133799003)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j5uO7WSM8ya0WkpNtNRKtl0AVOm6EMgIhGd6UGGvDHoUW5BA588fXkR4AWUCp01Uk65EGbqY17eWxJ5im/HHfbYkEI3eGPby3ATaGrsPvkbJrFwQsBFWvSO3RhCjsYIw++qRO42tduKbFid8gZgrjz1G9aYWije0Z38CGYGDdhgfdDFkYIt+racrOZv6ruRtZB/qYpuansNSrxKZv+enAT1avneFgjGg0WXvMriCcvsKITw4bRx0morbRon/yujHtlCGtF5zetzYkjxPwNOgDSVF6ZNfUjtAuKhel+OiyWkhlokJr0SU4yNoWAaQwViiGquJGobwVHkICn+43sfFsYl6bEPkYw1zIRKp/1PC8VW1QThwjKaJLfVj5GkWzfm47M2wklPJsi3K/C9HDQ3RgIs73l71RcnvXk9Rgu+udD3zxWgTyAm9iJXtf4KFNIHp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 21:10:30.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debb991e-4ccd-4d34-f33f-08dec5a25ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
> Implement cxl_bi_setup(), which walks the CXL port topology to enable
> BI flows on the device and every component in the path between the
> device and the root port. The walk is two-pass: first to verify each
> component advertises BI capability, then to write BI Enable on each
> dport's BI Decoder Control register and on the device. On failure
> during the enable pass, partially-enabled dports are rolled back.
> 
> The teardown counterpart, cxl_bi_dealloc(), runs automatically on
> cxl_mem unbind.
> 
> cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
> in each decoder is programmed separately at commit time. After a
> successful setup the device is BI-capable but not yet using BI for
> decode coherence.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

A few nits below, so with those fixed (and suggested changes in other thread):

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c | 365 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  28 ++++
>  drivers/cxl/mem.c      |   4 +
>  include/cxl/cxl.h      |   2 +
>  4 files changed, 399 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..291d4f617e71 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,11 +2,13 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +928,366 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +/*
> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
> + */
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     unsigned int scale,
> +					     unsigned int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
> +				u32 committed_bit, u32 err_bit,
> +				unsigned int scale, unsigned int base)
> +{
> +	unsigned long tmo_us, poll_us;
> +	ktime_t start;
> +	u32 status;
> +	int rc;
> +
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> +		       __cxl_bi_get_timeout_us(dev, scale, base));
> +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> +	start = ktime_get();
> +
> +	rc = readx_poll_timeout(readl, status_reg, status,
> +				status & (committed_bit | err_bit),
> +				poll_us, tmo_us);
> +	if (rc) {
> +		dev_dbg(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
> +		return rc; /* -ETIMEDOUT */
> +	}
> +
> +	if (status & err_bit) {
> +		dev_dbg(dev, "BI-ID commit rejected by hardware\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
> +		ktime_to_us(ktime_sub(ktime_get(), start)));
> +	return 0;
> +}
> +
> +/* BI RT only exists on switch upstream ports. */
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!bi)
> +		return 0;

Don't need this check since we already checked at the call site(s).> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!bi)
> +		return -EINVAL;

Same thing here.

> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +

[snip]

> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport_iter, *dport, *failed;
> +	struct cxl_port *port_iter;
> +	struct pci_dev *pdev;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
> +		return 0;

I'd return -ENXIO here since we only report the error with a dev_dbg() later on.

> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM)
> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +					       port_iter->regs.bi_rt))
> +				return -EINVAL;

This can be one if statement: if (... && !cxl_is_bi-capable(...))> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter)) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		if (dport_iter == failed)
> +			break;

Nit: you can move this into the while statement check above. The extra overhead
is worth the readability IMO.
