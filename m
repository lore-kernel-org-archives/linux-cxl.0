Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C8371053
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139741; cv=fail; b=bwNr+iTlbso7pAmGba7krxxAx66ipWuq4G2N9eHepGdZeEdSo7eX3WM0r+CACW72zNMv68UjYgiKAtjBuFWSGDvNXrqNMb3qS1zKGUMcwG7aH4Mv1Kb2V9YCoxcp9WCfoLZB2cpCY7nr5qRwxju6qfNVhhcb8vsTjTZmpLsuorE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139741; c=relaxed/simple;
	bh=J0Sv9b/aCEDcqD00/Du5opYggYpjREhj1TBAwPZCkJ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=T5UFIQCliFruuCtseC4EbdC2jHbtI3hHgVZyKUvilCqLgLpXIwenJ+ifmCDuHWAwUdI9Ts+4tdN46Mq9ZuZ+1xtDILje1sqwFj9xLXoJyP9d+Yng0WFQYtphCKIo3S7eW7U5Fvo5l38jOIiRR6QZ4llM6qHiUemYsB8Gnf2nzE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYI1ZBQD; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYI1ZBQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogi6ZlTCSJ0A+X6tpKYZP1kUDxA+IqifjIC3MDFDfBjlbcb5hIRyxlxERyUKRhAqVyqxSfTT6q8EmnAjI6dab3arigSzQJxYMowDD1SldVmNJMS/QEHP+5nsXd+SFhsbfx9917Lj8KW5z99jUFBbdbd5TeqIsvJgIfRnuukAeZ4cWiSi1v5Rz7CX5KK5Ld4JBw+4R23UETWJNjINhgzn+qGuQkF7/jmRQ42yzA6lD3gwVU6BgrMgZYKx7qP04fahlkmq2WzhyGNrXZ3vwwmdgsyDyx10IgpR9dzsbrUtQPPSjEOu6GP27p+LpQQVN3RhKGBfCXj4p3aR+skYsvxEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mWMcSGa9xHMNOXWtPMJkloLG/yXPQKkNsrzyS5T95w=;
 b=MMGEEtbiPAI50ooqyGJwVpLxE1lkYP5cI6dJjJSd/SYOXY8+EWO+c0/Odz2niwWqCwRKvat+r6u4OvZW4zwWnQFbhKMlnnXw7wtWP0tqdQ31UNUI09MHQ0A2PFb09k/2B4K7FbIfkD9FUNl133zs8GRls6UOrPwfzz1h3fCbbsT8OlVCE8U6pvagoUG1/OUGbpn98yFsWptc3TRSx5vjEN+HJlAuzJ+W2T8gcoxjCuN3+qlY9mxSf5FFGSr/PLPYU1FBC4xmY/vtpkz6Qr/Mh3r1atoIfwHfxEq8auu9Tio+St5oj5qfYnfG/apFfZSwisuBJchSZURyODNWqvfhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mWMcSGa9xHMNOXWtPMJkloLG/yXPQKkNsrzyS5T95w=;
 b=uYI1ZBQDEamS6dtC3f/tUfWiwYTqtOIGOVV5HJrskHrYxPBTja6ZUjbuT0CFjCB8YdUw0UMWLYZR8GpSAgad006xnzNh+x05iZb+g4EANtlXx4/mM1mohdIZ0CFu1XYovT3bBtqWPljNjnZCRiHjPoOHAmFG3pNgUJgTDRl48eI=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 21:28:52 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 21:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 21:28:51 +0000
Received: from [10.254.60.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 16:28:49 -0500
Message-ID: <4a1d36f5-3221-4e27-9666-d03185fef732@amd.com>
Date: Mon, 18 May 2026 16:28:49 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 2/5] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-3-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260516022037.1761453-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: d1101593-fdfd-47dc-d9cf-08deb52474a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BI2JmM8zXkvzMgpy6xZhJGtfMRxaAINFEnpozNJFION4GiHbd9sDjXMuCgbjNGeEyMZIWTVC1HdUBhbzBPrpeWzvxV1VjYYkYxvbxtdvlnJesw1HkfkFnkz0FW30gQ4hQ2Zy0GPaIt2OnU/4XXucXzTXVMX84SOiw1nwKXR97AEzzU0KH+IancK9qdVXjepRcEtU7M14pZ66j9R5A28EVIRhKwtQCVghaHX4WST7fUJbUboUQ6oH285h43MQapmbvMQ37sPyczrdUm7jtcQ3Do3udk6IWheY5k0Wf6JvKMXs40zy+S74cV+Pd865qY+XxzFWt5ngatlFCe27pGrKXNbO1uD0bFgMCDDCPPsYWfNEiYWeV1Et1TnjrouoBmeg+c8Y6W1bnU44FN1m8S/9tqFB4Ydn9XtokuBppJ0xfHaoVSt4ZrKXkWwb0rr1ju6ZpXJJuxJLWHvqRVdr5U0xk5zZtgXarQSu9gwYYAtMYN+QdrF5jBs8jSMfBD/9jl2Eo2g3DJSC/AVzo/8A6XVBMYnvTj4AEP5As+RKmE64ZJC5JOrLCkM76tE/yuzTsihvuEezERdM8uxGZMKhRlov30hXFHyVODiaQdzlQmiGeurREUXEB4SVJBgRHnA9EF2ioI8n9oqF4vkD09Ulczph2/MgQDURTK+nsyEtxf8yRMZD3ywu3ekeEAWT2n/3QnjvoErBDgTIxrBIbBvexMStes+00GPG/qAgJjJpQFIKBDo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0nsa+b1ndPq/L+oZTBRzEwxSalafYsdl+513glwfg7syBYvBJfZnc/VOH0yBIFP8kJmQEg13I4VW45haX8bW6FVXdZwLPmxY1VWi/QQ/0Xl/HuFUyo3ehDTvgQCH+cZ/ouBM9TQZtY7w1conpgLDiLXOYlGT7nKr5qipr9OMlS6O9HG+iLP7IYy0OEJ68vl25iKwWCpqNTQtYUlx/L8N7uekjNwbMD0yXGgDGemTSuYBV4IqqR0sbkuqBVnjuEpp5Rvfu6KH/GbcH5fE7ytwx61CgZGywIcpGv5jhu1UZJdM5TDOt2+g9v7dViLW65OKLsGqvVzuA/dEAryEx2oW99wS84rXGjsKVh+EjrDxxMApCCpof3ajo15/4ZMYPmChSRgfGYmHIbZN3Y6iT6wjPFYtKebX88gVBr9WHcPBu/8IFl/ic7E+8SveoC6aELpo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 21:28:51.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1101593-fdfd-47dc-d9cf-08deb52474a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
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
> ---
>  drivers/cxl/core/pci.c | 319 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  28 ++++
>  include/cxl/cxl.h      |   2 +
>  3 files changed, 349 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..7029055217c3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +927,321 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {

I think this is wrong, but I'm not 100% sure of the intention here. My first thought
was that the && should be a ||, but I'm not sure that's right. At the end of the patch
in cxl_bi_setup() you call this explicitly on PCI_EXP_TYPE_UPSTREAM ports so
it should fail as-is, no? So then what is this trying to accomplish?

> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +
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
> +#define ___cxl_bi_commit(dev, bi, ctype)				\
> +do {									\
> +	u32 status, ctrl;						\
> +	unsigned int scale, base;					\
> +	ktime_t tmo, now, start;					\
> +	unsigned long poll_us, tmo_us;					\
> +									\
> +	ctrl = readl(bi + CXL_BI_##ctype##_CTRL_OFFSET);		\
> +	writel(ctrl & ~CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
> +	writel(ctrl | CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
> +									\
> +	status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);		\
> +	scale = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_SCALE,	\
> +			  status);					\
> +	base = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_BASE,	\
> +			 status);					\
> +									\
> +	/* ... and poll */						\
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,		\
> +		       __cxl_bi_get_timeout_us((dev), scale, base));	\
> +	poll_us = tmo_us / 10; /* arbitrary 10% of timeout */		\
> +	start = now = ktime_get();					\
> +	tmo = ktime_add_us(now, tmo_us);				\
> +	while (!FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMITTED, status) && \
> +	       !FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED,	\
> +			  status)) {					\
> +		if (ktime_after(now, tmo)) {				\
> +			dev_dbg((dev), "BI-ID commit timed out (%luus)\n", \
> +				tmo_us);				\
> +			return -ETIMEDOUT;				\
> +		}							\
> +									\
> +		fsleep(poll_us);					\
> +		now = ktime_get();					\
> +		status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);	\
> +	}								\
> +									\
> +	if (FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED, status)) \
> +		return -EIO;						\
> +									\
> +	dev_dbg((dev), "BI-ID commit wait took %lluus\n",		\
> +		ktime_to_us(ktime_sub(now, start)));			\
> +} while (0)
> +
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	if (!bi)
> +		return 0;
> +
> +	if (FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		      readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		___cxl_bi_commit(dev, bi, RT);
> +
> +	return 0;
> +}
> +
> +static int __cxl_bi_commit(struct device *dev, void __iomem *bi)

This needs a different name, probably __cxl_bi_commit_decoder(). It obviously compiles
since you've tested it, but it'll definitely lead to confusion for readers later on.

> +{
> +	if (!bi)
> +		return -EINVAL;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	___cxl_bi_commit(dev, bi, DECODER);
> +	return 0;
> +}
> +
> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(device)(&port->dev);
> +

Nit: I would considers this extra space, but that's just my opinion.

> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (enable) {
> +			/*
> +			 * There is no point of failure from here on,
> +			 * BI will be enabled on the endpoint device.
> +			 */
> +			port->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl))
> +				return 0;
> +
> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(port->nr_bi == 0))
> +				return -EINVAL;
> +			if (--port->nr_bi > 0)
> +				return 0;
> +
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return 0;
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (enable) {
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		rc = __cxl_bi_commit(dport->dport_dev, bi);
> +		if (rc)
> +			return rc;
> +
> +		return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			WARN_ON_ONCE(!cxlds->bi);
> +			return 0;

I think it's appropriate to return an error if the WARN_ON_ONCE() is true.
I think this only happens when the driver is torn down but didn't get to clear the
BI registers, or if BIOS enabled BI on boot. I would argue that both of these
scenarios warrant an error, unless you want to do a silent clean up of the driver
state in the first case. I'm not sure how you would figure out which is which though...
> +		}
> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			WARN_ON_ONCE(cxlds->bi);
> +			return 0;
> +		}
> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}
> +
> +/*
> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
> + * committed here (cxl_workqueue tears them down asynchronously), but
> + * memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport;
> +	struct cxl_port *port;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
> +

Now this space is extra :)

> +	if (!_port || !cxlds->bi)
> +		return;
> +
> +	if (endpoint) {
> +		scoped_guard(rwsem_read, &cxl_rwsem.region)
> +			cxl_bi_ctrl_endpoint(cxlds, false);
> +	} else {
> +		/*
> +		 * Endpoint already removed: regions torn down and
> +		 * decoders uncommitted. Endpoint BI registers are no
> +		 * longer mapped; just clear the flag.
> +		 */
> +		cxlds->bi = false;
> +	}
> +
> +	port = _port;
> +	dport = _dport;

Nit: I would rename port and dport to port_iter and dport_iter since it's what they're
used for.
> +	while (!is_cxl_root(port)) {
> +		int rc = cxl_bi_ctrl_dport(dport, false);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +}
> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport, *failed;
> +	struct cxl_port *port;
> +	int rc;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port = _port;
> +	dport = _dport;
> +	while (!is_cxl_root(port)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
> +				       dport->regs.bi_decoder))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (dev_is_pci(port->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM)
> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
> +					       port->regs.bi_rt))
> +				return -EINVAL;

Issue I pointed out above is here. All ports that are PCI_EXP_TYPE_UPSTREAM will
fail the cxl_is_bi_capable() check.

> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (!is_cxl_root(port)) {
> +		rc = cxl_bi_ctrl_dport(dport, true);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	cxl_bi_ctrl_endpoint(cxlds, true);
> +
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed = dport;
> +	dport = _dport;
> +	port = _port;
> +	while (!is_cxl_root(port)) {
> +		cxl_bi_ctrl_dport(dport, false);
> +		if (dport == failed)
> +			break;
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 760f51b43891..564cdcd9409e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -167,6 +167,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>  
> +/* CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure */
> +#define CXL_BI_RT_CAPS_OFFSET 0x0
> +#define   CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ BIT(0)
> +#define CXL_BI_RT_CTRL_OFFSET 0x4
> +#define   CXL_BI_RT_CTRL_BI_COMMIT BIT(0)
> +#define CXL_BI_RT_STATUS_OFFSET 0x8
> +#define   CXL_BI_RT_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
> +/* CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure */
> +#define CXL_BI_DECODER_CAPS_OFFSET 0x0
> +#define   CXL_BI_DECODER_CAPS_HDMD_CAP BIT(0)
> +#define   CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ BIT(1)
> +#define CXL_BI_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_BI_DECODER_CTRL_BI_FW BIT(0)
> +#define   CXL_BI_DECODER_CTRL_BI_ENABLE BIT(1)
> +#define   CXL_BI_DECODER_CTRL_BI_COMMIT BIT(2)
> +#define CXL_BI_DECODER_STATUS_OFFSET 0x8
> +#define   CXL_BI_DECODER_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -553,6 +578,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @nr_bi: number of BI-enabled endpoints below this port
>   * @component_reg_phys: Physical address of component register
>   */
>  struct cxl_port {
> @@ -578,6 +604,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	int nr_bi;
>  	resource_size_t component_reg_phys;
>  };
>  
> @@ -906,6 +933,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 8ce9b4e9ca73..4938e93edb63 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -168,6 +168,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -187,6 +188,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];

