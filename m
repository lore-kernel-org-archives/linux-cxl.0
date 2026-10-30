Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793394269;
	b=nlHrAQtWI1hzmU1ve2vx7z5zMJBGl5I3oJ2oVwOn2v9thdYF99wkPYNjx6K9LNLMXq8w
	 Bj89IUeoVJ+Obecwqg+vNJeGd6OaQZzXduK+3mj4ITlnxsJdiIc3iPSsNJjaNft0tvzza
	 cEB5O/CeMvFiSYHGXByTY5DNp4ocATgAKTutc71vrqAAcOCx2uIwp4JG5x17B9H4swAPk
	 oig2I7q3v4iWESILoeWCqM0eomGyvrjlL+V1gFuuhpOk1z+zradaYFN6fOoIbG1ygekyH
	 fiyEfnQBlUrahifJhESYZVTQD+WmODWM6MVy/NEuwaB5DM02fAdrhD/2inpTyuwPI1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394269;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oGtJeausXXt+5zxrsSt4SAHsrdcbk4OJO7Gm/HITqb0=;
	b=2n8U3QDw3k9cFXn8UfaPCkKamTV9uQ8zIPqh5q8h5XHRVEwvMfu9uck4XvNI1/YiREcA
	 yeyLP1/L1ll8K+T1GV++Ym4LuetoEa8HPsOY8Cc/NITPx88gaDip270QKGtwqCuP1Fp8P
	 PrZ91sZdg0cpwnD1Ij0CjO/BO3fBSxhsJuHNj6OoHm2XQTHr7bnMJbDFlat/fVkLORRsr
	 mWYAfm2+B8RdARRfF+wRujA6N05LyZ3bhcnGQJKMjzG2w6TSF8xwWQMQbn+nCiQ54Lof+
	 OMaaNN49PweH2QD6Xtt8Y4pbZGW56Ej7MeTXl5TR9vlYWC2P0t+/gtWuBhEMd4OrB2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIM07+hF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED5606A333;
	Fri, 30 Oct 2026 21:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DED5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIM07+hF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvyzUYBMZiaXoh4XQPbDSCIXJ1B3wOKtcSCfciXe4RL5qhCMrMXFit/N9YmFEVk8DWqgVujOmTbJnNXp4x+L5nP425tja4/FY7PvzEHfAsaN9SEbeuWfkv8iW+wlFwJ/QkV4d/SrIeATnv30UHJ3nPzISSO7q3WULwrMWLBt1oapQkA3T4J2R2Kj2N9eTbBSmEmlGoJXAP7Z/c92Z38+MQJHw0piU8CQupCjWYBmxD1M9r5BnwRj4pBKf2B3AKSkRLX6OG/KiNT+WfjwmrEVrHxyLkSk2ssGzgO09d8IAdwj38ledVjnjUbt66q5Vi/QDNHUYCDMYD64SUYWr59Nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGtJeausXXt+5zxrsSt4SAHsrdcbk4OJO7Gm/HITqb0=;
 b=F2IDvSw6HbR9EdngreYJ8kd+hgQK/en5hyaHyKAxc4WpaFe7CVaf9NYxq8wdmmgC8v3UXEUk0FO3IWHPIeOFCm2r01O/mFnUm6U29y2UHAFX88wzkLYrCNZyf/si//QEvzTLvK9kkMDq+mm7naxlfrz7orQhKP8+QRZMVJ1o9W6m/INLC0OhkkZJhEGHJf2CgL5kh8ghXjJ4fgTZy/ltwIPDSQVb1aM3f+KM24xyRNeg4cYdc3UDiXIhvkSOB+onWjXQocLo3bGA4Otklm/U6rQvjkaNE+sQ8wotl4RXgdHgHR9MMdwURUulw9q2HqMYtlcTZKl0HOQlFT9ovCOcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGtJeausXXt+5zxrsSt4SAHsrdcbk4OJO7Gm/HITqb0=;
 b=IIM07+hFLJKs07s3dJVdtUznuKXAK/bH3jyVp8BtDzqjG4uUEt2HbymjqReJWTlNBjtkoEwaYKif0URoNVI3l4mjr4GALdfMIKCUaPZmNLWMsTo9GGyPVZplHQWAEWr4uuLJ6a2PLOhmwwD2OGd6W9Pmnf6nfBGsTBMd1o+htnk=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:04:23 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::6f) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 21:04:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 21:04:23 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 16:04:22 -0500
Message-ID: <8a19d63c-db9a-40ab-a811-5d761252638f@amd.com>
Date: Fri, 30 Oct 2026 16:04:22 -0500
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4] PCI: Skip state restoration when configuration is
 inaccessible
To: Richard Cheng <icheng@nvidia.com>, <jic23@kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>
CC: <ming.li@zohomail.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <mochs@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260929020405.9724-1-icheng@nvidia.com>
 <20260929020405.9724-4-icheng@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260929020405.9724-4-icheng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: b05d92a9-f5e2-4dfc-28b6-08df36c95fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|56012099006|4143699003|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Egx9kgpXZIP0YkEuzHqMLF93PUxDQTrF7UwuzozaVq+L9V4AQM8CpsxMVkw4DXoyCxQfEYJ5eCy6e69CsnVkkSpqK6M2y24GCQyDdfQaF3Cnk1vO5xG+PsrvtP3JvyfruuIApijap0Hv7Cv2/s8mDmRpzAcLTTdza3rq7dSalv/Dcc8TxWVctWpe4rfl0lhTdt1yrx7G7XFMt/cr1oPRTbM/prgB1fdHMgNKDwC7OgxM3Nwol0dvCBN3zg1swByDH61yaRiWtWGpIx7brJ8AXFr/9TU27tyLJxS4nMXWtAtxKcO0TpQicw7zHD5QIV8o7IAUSiN6s7H/C9XlwWOiYSPbATRgCZsj1kEwQVJDkoOEQcOCYGLxu8ATVrZUGd/rP5+WLKd05Ns35+7Ye/ot45W1htvyELFmP2ujVDs5xEEkCpZbrDZ13KeBEk5xS8U6QQHhjxg49U674Yt3aAgK1Nnc1tb54ObsrEg7JOlB0+o0nCfs0jA3JW77PHOZWgICp1wxQ357fpYyNyKVKTwnNmB8fF7dqiCBSeTep9u+j9S7nyVBA6a0Y6tJBIGwkRG1zg7dRIiZoyXl7zzIYvUcbp/1XVWPFc8zUp04R6XdUtVV3HMgofcF3DjHBbOfCDbGFk0ut9DepBbSltoui4jSFyoSriAu9WVayOkheKuNhZQCkTbkmKXa1NpBaFCK93mrk51kl8uiXDQPB788TuqrJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tnx0PsdmJPy0v4JL34Wdv28Y+y5begg5305nYb53zThDViNRo1/HfwcrQ1vQ6KAdn58uOW+wSPL25VhgNd7XBZlqP2ZukP2+FdFU13HxwSx00SXPfNiNZ6nRcAFzjLwUEDa/xVTlYPmBsJMWmNTuOilgv7iIoEZWMp5R7nGQwGIbYvhYSBHuIbd5XaxMIoBUflBB3xpL3Sn4GUyKDSiHJC4EHDvY9A5n71JwrAv+V9GRN0xK9RE+5Vb2OegyxUNLyySHrG5YzOHv1oQ5gI0cl7AkAlYzyVCzp3YTM+uPvL85QBveiAm9nvaiQB3KQ0sSbfsQJTRc8gaNLKWt6QPZXxgzJTlXIB8+Ktg2AK1VAQavm3D0btObZdmt+U9fcm1Ig8vS0D7EvCCqRiaJBaSh/mzQ5U0dZKgMA8igDHKaWeN2JDtPqX+JBy1utf0g3AJ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:04:23.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d92a9-f5e2-4dfc-28b6-08df36c95fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

On 9/28/2026 9:04 PM, Richard Cheng wrote:
> pci_dev_restore() restores state even when the device is inaccessible.
> MSI-X restoration can then issue MMIO accesses that trigger DPC.
> 
> Check configuration accessibility before restoring state. Keep driver
> reset callbacks and reset return values unchanged.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d59a374a350d..9a343f8b5429 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5127,7 +5127,9 @@ static void pci_dev_restore(struct pci_dev *dev)
>  	const struct pci_error_handlers *err_handler =
>  			dev->driver ? dev->driver->err_handler : NULL;
>  
> -	pci_restore_state(dev);
> +	/* MSI-X restoration may access device MMIO. */
> +	if (pci_dev_config_accessible(dev, "restore state"))
> +		pci_restore_state(dev);

Again, far from an expert, but this one seems a bit more cut and dry. I looked at the CXL reset_done handler
since I know that code, and it seems like it expects this state to be restored. There's a good amount of
drivers that implement this handler, so messing with this seems a bit cavalier. Seeing the next patch kind
of confirms that as well. If this is going to change you'll probably need to check and/or modify the other
handlers as well, or mention why they're left unmodified in the commit description.

If MSI-X restoration is the thing causing the issue, then maybe the right move is to leave MSI-X unrestored
in pci_restore_state()? It still has the same issue as not restoring everything, but the surface area is
a lot smaller.

I think the best thing to do would be to come at this from the device's driver that you're seeing this issue
with though.

Thanks,
Ben

>  
>  	/*
>  	 * dev->driver->err_handler->reset_done() is protected against

