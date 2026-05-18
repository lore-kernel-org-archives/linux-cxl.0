Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9E390C88
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139751; cv=fail; b=HUk4rJtXmAnxsmQDl4pAWZ6NQ07iXWiCLAFzl0dAFx1qCfe+nj2IfmbWcPOicC4+aM9Ry9swUWZbKth5fOEDgPkM/zTe3Q+402YTfgV7uBGF5qekc4hbBh9wajOZEU+tlrUZDBDYzkZds9auL0/WbUf1Efw5DV6blfhVIFRpBYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139751; c=relaxed/simple;
	bh=RlbctoAHB+sD8M4U+1UDo993rBBnASwPNWeOjt3b3kU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=mJhwy6pm45fUZYxpG8G3+5AKIBNr+57THN9XGP+VCEA7djg20JGGPMt8XPPd3prD0WDE7P/Q0OiId6o8RnW7eVG8ZrH3D+eN7l4SDJ+CGSpETK5Khbd6pCt5DCTKAqo5VUoampK76Z5BuVh/qE9dk1MD0VcUESdk7cKAMu/xC4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oDPwn2zD; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oDPwn2zD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3yo+wd5c3ymBC8U3t4Z4V3ClfjABSUcSBTkNHrX2wD0ICZZunv9FmJB707dcuNC90AJIh5QmbhRsKZMIijm+XtWEkOl+TaLuYSzDaQdQ27fNlaV8eXl8cwE1jbLPXrMHn9Tb7wl8dj+H70ZBA9E3hdJF0uih1NG8i7foCMxI3ASx9W9JaCMx0NyAwIoZXK5HbByCsqFF4rj9gHh9QSIuIvFHQEtE/+BlMXJXhASDOQSNM/eBDb84i1G3o8unFljNWS8vHndcWkQqU6X0pN2WZUJWluLSPGGc5K/Wj+uIH49jTPNaW81MGuJm6w2GGQ0wwNDY3iasY1H/ZZxj7XaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgZ8ANNqgP0I3PdRH5QBrqXfk06s90gLfXKbbVxs3nY=;
 b=gcZltwJzqZSXj7AC+Z0keqHPxPKZ1U0fu+cYyXgalfbotbhSfLnZrTRQwUFsSPL2XlzERdmRflXuJSD8EtKEYprFiHLv0cVETuZpnt3L4ihix3TO/eNk1ENsebZfKxh7w6xSIcmkzN8o/bwZB4CnkBjgIAUCD911xiTjWeJFt8LNKrDSI8PoJxs23hrvvhiKI57i1TIYKhRG+PKVJXIG4yuFIn2gjiXMNaCMFb6iKE/F5e4FGlDZVnW2CTrEefgpoXxTbGFxErswi+dLDBiNAEX2p5EU8Yj3Ql9l+QLgoOHh2jFQJN8YFhYbNNJxG+kU6v+q7Q7ybvJ60a+G/3i+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgZ8ANNqgP0I3PdRH5QBrqXfk06s90gLfXKbbVxs3nY=;
 b=oDPwn2zDQrnLvE6qsOEGUxRF0SIpaC1arOdIS1Im/gNmW4npD4Gz2fe5OJ0OUijDnTuHJNJdUGJulou3MTAmsEhyQaMUiQm+K2S1R+s5Hr+/k9tgvA4x4aPvqqsQLjczwxiPaZZkvzOQTGahhnQ/pcjo9TSLZyw1OBnGl1ntzUQ=
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 21:29:05 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::1) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 21:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 21:29:05 +0000
Received: from [10.254.60.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 16:29:04 -0500
Message-ID: <3c2f9051-234b-4d75-8420-16b4f49bebde@amd.com>
Date: Mon, 18 May 2026 16:29:03 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 4/5] cxl: Add HDM-DB region creation and sysfs
 interface
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-5-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260516022037.1761453-5-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6509af-90a6-4ed1-3f75-08deb5247d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|11063799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WBsdTlUaTojCaRDvL59azGBjZCCcM88nRwbNP+XdYcZzAwLafAR0xccBKyF6c+d6r+/xuyqPLhEVz1a/5JsjnnBcURex6zg04qgsnLAJgrNzpHcU6tUn4JI52UvQyJSioa9eDxKjgdhoeEbWV+afT+bxCQ93pWSfY41BWa5FLaBeb9jrGRzSwrwO5PNdg/ZqLnUJlrO+B3Xf/vKvaeORr8PWUiWdcB9VLjeI+86QvK+LC9qDkAWGGullVdl2sJOTe5xEG3u5votYDsp2D/aqTUM8gIT7Kb5aCWjHPRk2c4ot0qB1K0QdBG5PJcdvp1k2kF0ardiWiOltNuUrH8MlxoIO13dGot9TXvUO/fIcc0ds8eNsDoROb1RG4XPG/BMHC6j5PI+ikh/A+dXoaj8I2w31UdxVVwpYmhmwAtEdfmpUIBvJ3mQHB05d8pbT9GC73gSJTxRQsd/Bv+9oWQoEb971tIpTfLgOfnaRuA3uV5qaupGj0/Xz93TJ2qsLfIXFk4YY6SR2t/1XJ4x+0MS2iDbaVY/+CyiSa8yxk/vGo8TBGIpm/r0IM8h728fNs6f71wbVAuIx9YEF1I6NHcgIItw4hy5Evl3nJu2EwbfqjEfxBfrf4S4c46n9Vkh1/IR+epHh2Z68jARhFc6aPU8p7wAM1Y1HCXtNruJzi6O+uZZnhXU/t8RXUIWC1yTsBXujn/sTtwz4sIft/4O1OR1+fLKfyENraUXdiMAb2kJoUFM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zE+kox4ytrIRSmqY1bmRAeR4ujIOzY5jrUfBy38n31vPryaDCMBbIxIOS0ZwbAMjakLRZHj7pDEBJ7B8jk4EwzaGZC35x0oiy/0MKD9Hgqmw9/EFyre89FTu8/2DUorjrPcGsDZG2312ok3piejURFqpd4PQfJ4d1vrn6Yax2pqNl8kCaU4kcSe9xFHuGzouOSssyIhFb72UOig0VlPAx21m5fzN74Lp4BGIiei5xT29fKFD/fs+G/sr9gbC2I3d2mcz8DgIunosUxmhqqAbxdLGZSfLMjxDVevm4PA6TMBU1yOzPwBPyRl+mybOu6Ff/qXPFoEfWbZ3P6Z9VzTOKjeOPvZSyhWtKMN5i1I00Hd4440D9EyBPE6ugxM6z1/WazsuX0SR9MRk5B20oNC5OOqcZmDGIZZdb+pEnXAXA2/nSCYyyUAtvoLzKr/ZmctL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 21:29:05.3633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6509af-90a6-4ed1-3f75-08deb5247d12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395

On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
> A single Type 3 device can expose different parts of its memory with
> different coherency semantics: some ranges as HDM-H (host-only), others
> as HDM-DB (device-coherent with back-invalidate). Coherency models are
> therefore defined per memory region.
> 
> Surface this through the sysfs interface and region-creation flow:
> 
>   - cap_bi (root decoder, RO): set when the underlying CFMWS window
>     declares the BI restriction (ACPI_CEDT_CFMWS_RESTRICT_BI),
>     propagated via a new CXL_DECODER_F_BI flag.
> 
>   - create_{pmem,ram}_bi_region (root decoder, RW): create an HDM-DB
>     region. Visible only when cap_bi is set.
> 
>   - decoderX.Y/bi (endpoint decoder, RW): HDM-DB state of this
>     decoder. Writes ('1' to set, '0' to clear) go through
>     cxl_dpa_set_coherence() and are rejected after commit.
> 
>   - regionZ/bi (region, RO): '1' if the region is HDM-DB.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

LGTM,

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
