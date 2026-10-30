Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793394261;
	b=4S8m48kktatmmAZz30p/bDJR8gMK2RVLfj3iXwdfkYErajlh9oYlBHRw3QGmgj7QCs47
	 IYrU5vHQKZ7GgdWTYv/qN8oJrVnHFmq/R4PGxZVjovaAmf06bwM5lZW+BU9MGbeEhI4pG
	 OY4YIOhdr4nDl/ciNABfPg+r8tqqr6ulhcGNHENmWfVi8Ae1qzR1+Iy924cQumHVrrGOJ
	 zUfaf3ghEoVMd9pqYE6q6xChQ2TzlTO+a4nZjOqBXOZZ4Mm8gGRb5Z0qzDy0aqM+P3hec
	 IC/vHG+0DF7zeiuXbtY+MAdHHkP6al/zDQu12PTY4fcjsx/fyo1bXikrBLozhFJ2S9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394261;
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
	bh=qZ6wPyppPPvMF1VoRz+wRIqPJEHUIvbsrGiMjvvtsJ0=;
	b=mvuCUNwu6uyYOO1rb3nB1vXLoNEeYay5VkVtPt6DiYF3mMflR6OWpq1Ate3P2yr/0fxU
	 5ZMMcrTCFQDrz0JBeRntmWsE1MZ4zvMXAUPDB8B2kRgaVGeWn3X+Vi1h6Hi8x9aQcC3Lb
	 lV+RJ/k87oRQdBvyz96nWPJpR5SrsBa2bc3zaexNdKBFr3TDnloWhwP0Z5ecoasAbZtFf
	 3JIJvUFzr20zffv/fqcN05SDnCpRkw1xTyIIlbgzf/PZgYLvJuQpKznln1x5bMDY0sQDv
	 GzKZjiejPLKG8GW3AiIK1B2U+Kxz7wTQOae8vuaejpHsVEvW2hvHKlEREzdQjJ30KWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XACTDBGv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.70
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E116606A31C;
	Fri, 30 Oct 2026 21:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E116606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XACTDBGv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA3Oi8rvrlXq2ztp468eb+ymKPPPhx2d3KuccGX5xGcbV3ZrbbvPHO/F7YJ14ssC8umvtLj1b66UN8bzT9tmM7lo5VGwv6GXc2pPuhRiL0hAUCvAJRJQxQecjUmbdGwNONmT7GxmNy/zcdgOiiqvE68NGPuQwHqIr4zzveMN02NnNiqgpwWue5keeyOotYSTW4o/DtcXptTyPqjG82c8SXTPSRV+I8PYqrjXZL1Gu88aSMtveJKC4/Ile00V/0f5evFlgB4tL/cEteEdEQ//SojrDL/eTNkcOHhrdYJUKWQ4KF6nD3DyjZa4OpotrJ4bxzOi43xgd4SlhGH5l4WRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ6wPyppPPvMF1VoRz+wRIqPJEHUIvbsrGiMjvvtsJ0=;
 b=zBYTL0E9MNE75FiWyoN+5xIKLasl1kyyIF8+ON87sopBwAH4lTrqm0WH4rMTiRFjeNnw14/wyhkj2sV5sZQqgs3LX8iQyifB0l7Nq0nsZaQAk5OQavjdsg8IDAtGr8huEiCJSnbbo/ta/CzqS0XViza5PMEDe/2AegWQRY3BkiWwcawHi1LNBoRbr8PijbxafvWb/w9o9nP6ZvjDd0A4IdwBANNuyaGy+5WTpWW7qISnqWDwwJofmqpdU53wKPaAnG6dOu+yCpl7rIHQeptNH8rY45Gci2jaXWvQwGt9JqAwh23bQ4f7ywZ6KhstWUj4V6s0IFBRI8gqjRib/zY2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ6wPyppPPvMF1VoRz+wRIqPJEHUIvbsrGiMjvvtsJ0=;
 b=XACTDBGvlJMxvjBhDmc1jXPrjqUXn5c7e5SjZqQom7uz9oWHBtfC5rjU9Nio3eSYE8Q75Ky5GI0JDp5Dj0UywI6mU7rUehyWk5F4LzfC49dv7QAIvBnvrG2PODoGAL5Ac9KzplRWAGY3eEi2ihVFgHK+FDvtqLuAMqp8P6k/k7A=
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:04:18 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::15) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Fri,
 30 Oct 2026 21:04:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 21:04:18 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 16:04:16 -0500
Message-ID: <7b94e71d-e582-436a-b2a3-2402fc92c773@amd.com>
Date: Fri, 30 Oct 2026 16:04:16 -0500
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
Subject: Re: [PATCH 2/4] PCI: Return -ETIMEOUT when reset readiness polling
 expires
To: Richard Cheng <icheng@nvidia.com>, <jic23@kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>
CC: <ming.li@zohomail.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <mochs@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260929020405.9724-1-icheng@nvidia.com>
 <20260929020405.9724-3-icheng@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260929020405.9724-3-icheng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e11e5e8-6868-4f97-8a68-08df36c95cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	XBGeDQYjDfN/tNefYw1QAinD5tq//YS3XH2vkoUXGw0hTLih37494RaQYOIfJFR/qKmfeShZUFZwqpC+FJ6rtTGvDvHGBE03JOv02s3OLWDqb8ZDevXBGyPd+5MAe0UGz6G4H6gw6ajbk5Xs0uztSwOpV/EhVAArK/DzMmwfKYtMUUib4pGWs6nalBhHakQ5AACB1dZKJYgScf7Ui2XfnSqlsHo5Y+R7YTTVkTETwui+7/B92X/TmsIl/L/LUW+E4dVmbOHBBCLlkID9qsl2ZytYogd8ZvwNg67qzwfxDB/nQG9qV6yVpSphwBvxtSycCpimjgd1XPw9SAduB2CKmNAEX2dPXgMTbMEzQUirt4AYTv7UdSJl/DyifCwSucFJ6Il04ScjhFPCFx/b4b4TShIUTAVUTRaZpl+0UX2OgW8KKgXrn/Hu5a0aR8MQbVZI0anArY30gGctVeCGqKBL2JC/JfC07RwfrSgSlVCgEQvcRI8DhNXd7HjdBj6xxrV2H80koC+my4ZdFux+XuF7HgHqDonN+h3yU1DwLHBdIzcJIRy19F4uHuklqVojsUrlN9jMOEAeI9si0cH2pmkMqjURrdOzOecN2Z1fRJXzsQ6KbDlBI1mAirOGb9xSu2IJJpV25LKtJPqJOYDvnUacIEfDDSxDQvF1YhSJ/wqtLSRTGfOQ6zUih70GhJTb5QN3pL1smeiERDYiTzkZv6PGcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GAwPS2uyD1EiBB9m+KmMXoC9+Gq85Uf/R/eqFFqHC/CFZlUOYeR7Rw/Gesaqe2Zm4dOI+Th6CdjcJFKR9hCoXtKq7QAT/Y0JjP3AD0esspba0NmiWCBp/NcEtW5wMKfmVxslKI+qma/ii6edVcpyI5aVZZ5xXUUyQNQsk98MN2364ws7NXDsipTWF/FDSrRlnWsMuMYJvwvDDmXZltNnhfT96lI0z59H/vyD98i94ma0fxsTdTfahLHz/RQXTYt1Fb9wpjycI1tAlvQeoK/fcyVI2Tr3TpGdH0lCgn3YEurFMv6NPf7CTB8yClHpZ3cPpLILk6F6wmHlr2aj3vb9mXKsdQTiwkNhQitZvZtQngQRQdN4JNFFbJ2QL21dR4Ki/rI9BTLJrNjoQwWpKQUUoKuwLam7Sw5OpsIlr0k+GqxTfP7mHNH+u/MwfT+9pWwF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:04:18.1182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e11e5e8-6868-4f97-8a68-08df36c95cba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

On 9/28/2026 9:04 PM, Richard Cheng wrote:
> pci_dev_wait() return -ENOTTY when the device fails to become ready. The
> reset framekwork interprets this as an unsupported reset method and may

typo in framework

> try another method.
> 
> Return -ETIMEOUT to report the timeout and stop reset-method fallback.
> 
and -ETIMEOUT is missing the 'D'.

The sashiko report also brought up my first thought with this, which is that there may
be a device and/or driver that relies on this behavior. I'm *extremely* far from an expert
on PCI code though, so someone else will have to weigh in.

> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6461274bdbcf..d59a374a350d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1279,7 +1279,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  		if (delay > timeout) {
>  			pci_err(dev, "not ready %dms after %s; giving up\n",
>  				delay - 1, reset_type);
> -			return -ENOTTY;
> +			return -ETIMEDOUT;
>  		}
>  
>  		if (delay > PCI_RESET_WAIT) {

