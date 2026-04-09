Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E8242D89;
	Thu,  9 Apr 2026 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772170; cv=fail; b=RlGAwdqg99zTPK5jL7nC0mLV3Au/00Ixeqj7xW6W94F0jViwtVlgAHiFAPntRYzgBF9SbedbH/RQXqjpVTFktxSCZUnBCObFodkiJnLXLODtY1vqVYpP6+lv9SloDCH3B6KbcTx4PL7QTfBFgpum2e6D/eqMizPj4Jv4kukQ2ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772170; c=relaxed/simple;
	bh=/Cp7MgUh8jdNyIalX31vTGTpeeemK8h8NeMKF8dK7sU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=H3bNLNRC7peqfHdJb6XnjSe8gH9snhc3774f0k/lQs5u2mKwFZosMK9XSUQTSf4AKWzKCOGvLjCWdgsZwGhjudvCTfZw5llzpKUWg0Uhy6Xtu8LEd6ohbqKMm8UErX9yo/N9XmlpzE/CpJ6CAg/pAX5ZS80rr39z2aOvkgQ7F1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k82qT6Ie; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k82qT6Ie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpFSVtqCgUJlPEE0gKvCUX7DNy4sMtLG1VbS81gsg9V/KPyWVkLIWfcw1ACyJxV9SIESPRZViqYptMFMdvOGyE5lPkF3y//rYqHicPWvzsECJBHgQMw1uzeg3/Goy6/vEpRgAleQ1gUgOcMS88F4MoGLUQzoIiPBgWs80Qdv9de7ErIBo7W3T66C8B2YHxzPhBRYa2hPdr5ouqMTgWr+1oB+RpWGsPEnjHW43d+cRPMTCFox9iXCyGUmy+MSiEypTNjwYH3bWdDqb1R+jYsZv4Reiad5w0+DlqEa0GcPZLZHNg6BKzKtWrlxYteowJNgj46maetrZcSQTJ19xi6XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUU6oIa55Q9697/j4IdqNh7pbuiVktPUbeMYVAy3Dz0=;
 b=VwMdVBDg008+Mm9JA3QNZY2sxfvnqhwFncCZ/QK3LdLAKbnXereKAsyTSie5hWzwLDOYRFTFIxgtUaxzOrf6btIx15AWwoR8LVWZwGSm8DwdP7OE/PdfJy2xqahQxng2Ks6MjEmaaSUo5hGopzwpngCVTVpgH4v3o+NzItZsh2b8GqkNWbKXHyXMnzSL8MPiETu7xfrDVGtVvsxcQ5hYwfjywn/wnrWewIbHVHy71Yd7Cpr/V9bWKf0Sl45hMUr8hX6+mRj4LPpdUT2S/7F+UTgauJlrqyR0qQwad0Jt9b/pSwjb1NZXRCkPmPIHOnAtUzr0y4jyZi9ic/aviJa7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUU6oIa55Q9697/j4IdqNh7pbuiVktPUbeMYVAy3Dz0=;
 b=k82qT6IeHr5pqBuSeB84Xjmjz2KdqukQTh1Ohb83ZuuLY/ILezS66kgv0LgF9Z9o6rqt7R32+p+79/tJETwpRLDJL0tEHNXpLXg7/IKU5tbla5gbFGGKhtlJdtIiffUgAK+ur7cB0IQvD02XSvmTkrThbSq+h31/t3TW2PxxXFs=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 22:02:46 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::23) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 22:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Thu, 9 Apr 2026 22:02:46 +0000
Received: from [10.236.181.115] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 17:02:45 -0500
Message-ID: <6fa575fa-a421-40ca-bdb7-af5728d6fb1c@amd.com>
Date: Thu, 9 Apr 2026 17:02:44 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 1/4] cxl/mem: Add support to cleanly continue after
 attach
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alejandro.lucero-palau@amd.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-2-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20260403210050.1058650-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cee4c0-23fa-43e1-23e4-08de9683bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KI1kOssxDezvgsO1CPSvxy6PMFOB3ZrOt+3fGstf3rKUFI5gPv5kuANoEdlWZ3j6EgGRWeqL0CW2wUQusvMl+XQZfq7SIJquHBH5GlCg73vkxaJDpRj5TsFNwTw0zO+RZaup+K03rpY5qFC82TtlmwDzx6CYbU+ueywTI0EBWKSoRLwkP31JKLu1f3/N9jbkK0Evo/vp55YAL9YQmduN7qUCiFPzgWuIrnb4VrGi7nx2/TjS+PARRqvnhGx1j+Z8W/OKJA4dYr8A06RiCn4Gjj9adDEjxFrrH9hgeKCK/wJzylSfurPxziA/mQc0PaDdenoEeU90xSEBA0GmLwJGGxv+oWeyS5c3ElQ2uj2THTJWWoGYZTGO02ZeS9GPiZ+hgEjCzpKQKbB3PZXzpF9HDnpB45AlW8n1if55qyJnPWYjSim7WmVZ8HfO7J6eNh5R65Bztm4TvPpa3PyELprASM+FzenExOZTFYFCrTmup7k9Gwy44pdRVx1hVs1iVKZW2Ybn4XY3eKhEe6SguJ1hqxvA5yEFd3Q3fSzh6Onoyv6czRF5VqvUXmr1i80anLqi5enrlj3MduSHbqMAfyEhHtHSc7JBnHdr95vefDaMa/GsukILQIofiZsMRa+6/JosYPpgvRHyOezD5JBm/ymHK/pf2DAWrvoBpmNrw53t7/aJxbOwvjS5Rn9u5Kvrpkld9kdNyw9hvlBXYvAglicf7VE65WinAu0eWF5b+Y6k4PEFGasP5DUKCRdNVMIp15mj0n1w6Vyj3voUYdkikSQOBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SpQIco1AL67vZkWyVS87J+RgNiqot2W7pKqWVszc5mZysIodbs4GrLMcW9Sm46FIxJv17AXuChg9NujE73V0GOoFe1XNlKxw7ixmQh6UznrpbOoE1aTSIDtFSQk5g4NTzSKxPj955XMvMj5HnulmreK5DHtBguGak+LrinVBzgOMRMKOoUwTchFNOkfi1MaSG9E6/JiIZ6DcKxXCiKYTMA2dz+skdiKIrVWVETQc0Duo+vEoS2gcR10kIzVdmqfvAxWx9q2tuFZ5fRXw0vCkxW+/fMrMJ+SNbTgaISh2cNXw8Qp6oefJ2jyTmn4VJ9b4W15ZX+TcBuOPPD9jDqiV0Epw76ut8YIJ4dsyv9u8srDaad1loxPPi5ZOFuyC+JZvWTs0oTuWHrdIa3o93HlXKoPPdFXKNMurIMKFH5BtgxLpov2dTZ1Zan26MFUqB6My
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:02:46.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cee4c0-23fa-43e1-23e4-08de9683bb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

On 4/3/2026 4:00 PM, Dan Williams wrote:
> For drivers that want to fallback to PCI-only operation, immediately
> cleanup on attach failure. Otherwise vestigial topology objects are left
> until driver unload.
> 

The usage of "attach" here is somewhat ambiguous. Does this mean the attach callback,
or cxl_mem attach? Also, I know that providing the attach callback is probably what
indicates a driver wants to fallback to PCIe operation, but it's not evident based on
the description or contents of the patch.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/mem.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ff858318091f..5e7fa378dd66 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -201,7 +201,19 @@ static int cxl_mem_probe(struct device *dev)
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_attach *attach)
>  {
> -	return __devm_cxl_add_memdev(cxlds, attach);
> +	struct cxl_memdev *cxlmd;
> +	void *group;
> +
> +	group = devres_open_group(cxlds->dev, NULL, GFP_KERNEL);
> +	if (!group)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlmd = __devm_cxl_add_memdev(cxlds, attach);
> +	if (IS_ERR(cxlmd))
> +		devres_release_group(cxlds->dev, group);
> +	else
> +		devres_remove_group(cxlds->dev, group);
> +	return cxlmd;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>  

I'm having trouble figuring out how exactly this is supposed to work. I guess I have two questions:
1) What is this devres group doing? There aren't any actions added to it (afaik), so it seems to do nothing? Maybe there's some magic
going on here I don't know about?

2) Isn't the memdev already cleaned up if cxl_mem probe fails and attach is provided? What's the extra cleanup happening here?
