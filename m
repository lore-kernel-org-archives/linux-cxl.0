Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9516132A
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023620; cv=fail; b=moVAGJP9JZgnxD+PyJgOZypSlw6c4eVer5w5r/fiQa9ge38D9RV+WjWKPSyqm+RjuLKAYLQm+ecnvUx7D2a7UjQAJog7lEv3aeBB4eiNLR80mPcEC2ZB/cnb/YqBkpQayKP+T6bBBMV1SH/IF3fXMvs5cxFBLndImsO3RVTxvOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023620; c=relaxed/simple;
	bh=pWpBhqrQTTsnvL9fQ6Sr+wA3Jg+/wMH+e+IQrpO4h6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ViGJ8XZ4wXPUqKAIJSDutG+DWsxyU5G9fiiC0EGQal4vPJ0aZDkcuw+Lv8JHtFCD/HHn8mcYLc1yPsBZTcUu2Ay3lRFmpmTvy5Ju51USbYDDVMk/mEMgZVzNjDdyXoH7v17RrnRjMwNSj5RnQm1+oZIeLKbxHbaGXtX0bExpnq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A5SWUCyd; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A5SWUCyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsmzdWccngiNXScFWOpY2Rxd7rH2UQpqS7JNOcecGlGgg3DzGu39o2kuD8qdybpW0FWnUFi02cZj+TDc+KhChcS4qtmutk/RqfWUAYEvjFRysXYyFY9ahtG1pL3xBUt6PPufSKIAoZ+XIYV5ZD1W+8SHbleGGmNAIS0r4jaxhS6keFKjmXeY1QM+VklYb/Zt0DXEakFx/NkG1eF6Dxd04APyPbqOIz0zydTntv7bWlgSr1qrmFI7E19yUyBOgcHBnclv32B3chOFSQytQqEYlNBS1pk936TMqgrBPthWs1UOGyyYScrm0HXfhov/eFfEDql+/TY5igTYXdu4oNGDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5XxksOal0mJVBeMP61YY6Yydq/xKm/eb2DIBzM0Yb8=;
 b=lG3kp+Cfxqe/N2D/sRqdTXSEJ/NUlnMBvGQYkXjqoIoTSZ5gv22OrVIiiZqXAq7kxyuc91bqwbjawhn7qHMZLkayAK4Zv73L2FIdRqytCwOxqwYNV3AZwqKdi8uFZjbaj/0YY0IWfl+4drc3Uov4uJIv65nDTPgLx6s4mTPxFo/hdOJVmO6FZjQNM6fX0emdFAPE8+n3mKCpWGul2l8+cc10shWXfEujveRXpTU8biFIsNtAZ7xpniFlS87FSf2NbkLkp43gMmaxUjaWuTSKNPBu8Ou2CEMVCuHMGk444fizIibiTyz/OmDJAubywucMxB8u0wiytf4iYJ5KZwheAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5XxksOal0mJVBeMP61YY6Yydq/xKm/eb2DIBzM0Yb8=;
 b=A5SWUCyd9GY0yPZEn1mT1HKdsznoES470wd73hKO3jXZ7O0bDt52x1z9jCv+9vqSmGFAEQxORSee0XuPsAqjGUWz5hpntD90TUIeiDrEDJ4kdixv6erkbD7eXpoHTXA9rS/QjIkcRJHVKGN5lUR72d0MKOW3eDJfWUajnF2WtUg=
Received: from CH0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:610:b3::6)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 16:20:13 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::5a) by CH0PR03CA0031.outlook.office365.com
 (2603:10b6:610:b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 16:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:20:12 +0000
Received: from [10.31.194.50] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 11:20:11 -0500
Message-ID: <fcebf688-ac73-4a72-b4ba-683b3380bce3@amd.com>
Date: Fri, 20 Mar 2026 11:20:05 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-4-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260315202741.3264295-4-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: de7966df-9fa6-4609-12e5-08de869c9069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Avn7wi5Lehd7Tq9whn4BStiYHb2Vb8TXQ/ZwDy+fNEblefA/gaCR4j8IPz0tHKDFlsZNrxvrUOzGSQlZmtKgXcFUr3M6m4+RTmW7d8TN5hXd1ZxypdAG0kJ9lYm3SXSkNt+ijy5TyC0yuUg8EZzT2NTJB6CvMlSPIxs8bIMsJoWpAYD+xsSyvmWusMUuVo4F27rl8tQrQL9scFAU+jJnZGmS0jwuClLOLNgOVJE6cfxcWwN0TOddtDhH8sqeBumNbzNBL8nrVoX8OnRjY8cLe7IgNjxS0nP+VcweWHcH6uCQAbL+yIF93pA7QrYcTv7axCozfGdFE/hnX1Vbjz+CjIi0BHFDUQCbHfOlOY6e1pvohGkylUVAYkCCj5e5CmBA7o0yMOenYiz3RVs7SMcqE1s5yfMxioI0DPfBOge1JsgTB/oC/Q/cjoKAaLxSYq6IGN+heVV0WW7ghT+XM5FO4x29r/HNd1PmV9XDtFzvyEV7t+cGtgvohLpz24iosY5vzMMDUHpDn9at7A+JK2yRAqgHzw5M2e8hRWlFJaBz5BVKrR8JKZL/42mQcN4HuQQEgYBJsET88+djR66b/GLF45FaNnqoS/70ziIaeMhBS/bmEpQ+DecjmGiXXuQfoQYrpY7pdGcRnRvqP91AGhiL3fU3iFHaeXmRZg3MveyT4ZlyTagDUD+syvUiz597cQPwxqX5OFHXWi89dUTclPkOAA0HtwrkED5L+g6FcZ0IygQaRPJjMALwEiQL1HDNbIybgv7Wspu+hOsKlcymG4rbfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AMTLGzhNENLlaxotCaDX2b4/IF4j79RBNA9mZXNfZKsZD18dfsrnVpIbk2yhT3kwl/TBjESnOFZXuKjFYBpHVoAwitqX+fPem8hIR6PjZVazgXOzfeExWffV1lqP6C95FEDM6q6z0IknfZeuXE6aW7d/qXo//9PvmX6AzpqZBvM9tg6PVq59Rdxuctu2z41W81c53RPhAi86xHeDKreDtOI3GrWAGyui/oDUlbH5Gg1jkLZb4JGe046T6lasT+4vjxfeqlSG0lyUQld7jVfTEaZxhr7uKpL3mv7yxf4/zJOXZkgANi4aj7Wqsu68zDkiBmz2hWgD3Kn21fJglviYPmL20qN26pJV2TMdUJ4l9biDMeCoLfUdC/IGncA7kccid2JiyysJGZhLj26apIutTuDPJTSusl8LTU/AeLOf5PePpoySkgIs/rODjrZvMqAK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:20:12.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7966df-9fa6-4609-12e5-08de869c9069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091

On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() and cxl_bi_dealloc() which walk the CXL port
> topology to enable/disable BI flows on all components in the path.
> 
> Upon a successful setup, this enablement does not influence the current
> HDM decoder setup by enabling the BI bit, and therefore the device is left
> in a BI capable state, but not making use of it in the decode coherence.
> Upon a BI-ID removal event, it is expected for the device to be offline.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 339 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..5f0226397dfa 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -926,3 +926,342 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;

I think you can drop this, I don't see a case where it wasn't already checked in the last
patch. 

> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
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
> +					     int scale, int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %d\n", scale);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;

scale needs to be an unsigned int for this

> +}
> +
> +#define ___cxl_bi_commit(dev, bi, ctype)				\
> +do {									\
> +	u32 status, ctrl;						\
> +	int scale, base;						\
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

I'm split on whether it's better to use a macro here or just duplicate the
code between __cxl_bi_commit() and __cxl_bi_commit_rt(). On one hand it saves
space, but I hate looking at long macros...

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

I'd make this return void. Leaving it as an int return suggests it can fail
which isn't worth the mental overhead imo, especially if it only saves a few
lines below.

> +
> +static int __cxl_bi_commit(struct device *dev, void __iomem *bi)
> +{
> +	if (!bi)
> +		return -EINVAL;
> +
> +	___cxl_bi_commit(dev, bi, DECODER);
> +	return 0;
> +}
> +
> +/* enable or dealloc BI-ID changes in the given level of the topology */
> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	u32 ctrl, value;
> +	void __iomem *bi = dport->regs.bi;
> +	struct cxl_port *port = dport->port;
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +
> +	guard(device)(&port->dev);
> +
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
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
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
> +
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +			      readl(bi + CXL_BI_DECODER_CAPS_OFFSET))) {
> +			int rc = __cxl_bi_commit(dport->dport_dev,
> +						 dport->regs.bi);

It's been a while since I looked at how these decoders work, but why not move the
explicit commit check into __cxl_bi_commit()? I think it's only called here,
but I could be missing something.

> +			if (rc)
> +				return rc;
> +		}
> +
> +		return __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	u32 ctrl, val;
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi;
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
> +	dev_dbg(cxlds->dev, "device %scapable of issuing BI requests\n",
> +		enable ? "" : "in");

Nit: It's pretty hard to tell the difference between the enable/disable case when it's only two letters.
I'd prefer something like:
	dev_dbg(cxlds->dev, "%s issuing BI requests\n", enable ? "enabled" : "disabled");

The device part isn't really important since the dev_dbg() prints the device name anyway.

> +
> +	return 0;
> +}
> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport, *failed;
> +	struct cxl_port *parent_port, *port;
> +	int rc;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port = _port;
> +	dport = _dport;
> +	while (1) {

You should be able to replace this with "while (!is_cxl_root(port))"; it's more
resilient imo.

> +		parent_port = to_cxl_port(port->dev.parent);
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
> +				       dport->regs.bi))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (pci_pcie_type(to_pci_dev(dport->dport_dev)) ==
> +		    PCI_EXP_TYPE_DOWNSTREAM) {
> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
> +					       port->uport_regs.bi))
> +				return -EINVAL;
> +		}
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (1) {

Same thing here.

> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_ctrl_dport(dport, true);
> +		if (rc)
> +			goto err_rollback;
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	cxl_bi_ctrl_endpoint(cxlds, true);
> +	return 0;
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far by re-walking from the bottom
> +	 * up to (but not including) the failed dport.
> +	 */
> +	failed = dport;
> +	dport = _dport;
> +	port = _port;
> +	while (dport != failed) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		cxl_bi_ctrl_dport(dport, false);
> +		if (is_cxl_root(parent_port))
> +			break;
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> +
> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_port *parent_port, *port;
> +	struct cxl_dport *dport, *_dport;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxlds->bi)
> +		return 0;
> +
> +	if (endpoint) {
> +		/* ensure the device is offline and unmapped */
> +		scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +			if (cxl_num_decoders_committed(endpoint) > 0)
> +				return -EBUSY;
> +		}
> +
> +		/* first, disable BI on the device */
> +		cxl_bi_ctrl_endpoint(cxlds, false);
> +	} else {
> +		/*
> +		 * Teardown path: the endpoint was already removed, which
> +		 * tears down regions and uncommits decoders. The endpoint
> +		 * BI registers are no longer mapped so just clear the flag
> +		 * and walk the dports below.
> +		 */
> +		cxlds->bi = false;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (1) {

And here.

> +		int rc;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_ctrl_dport(dport, false);
> +		if (rc)
> +			return rc;

Would it be better to not return on an error here? It may be better to
disable as many decoders as possible, but I don't know enough to
say either way.

> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_dealloc, "CXL");

