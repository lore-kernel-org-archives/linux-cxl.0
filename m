Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCD39A06A
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290353; cv=fail; b=MXVqZb32knruYeVBtZxP75v6VaPoaRD27jWsfVJdKP0oUGpIQPRuQpYmhDUJ+mtQ8NMOCuVfqAmYwsNr42VMYOLWRfLmtvShydpXimJADjJjxAvBza/kgqGPz49Gl+8UWCsnsvWsBkij2n/A5hp0+GRBxu3pRtai/KCwkaVsAY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290353; c=relaxed/simple;
	bh=9lbCDlAdGyc3SsUT1OrxSoY/mUz/aI7DgX/OvIdcEC4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ebF3P4Fb0hiIXjXvw3DgM9ETMapRVmhcRItOeHf+9JvFz3e113bnEbfdWViQlrVcdBkf0YV13jnOemVRD6UlXVAoYaTe4GQy6NWfzfpQK93d26MMT3TU6w/I136BTjfoKEfuTip7X5Tf+dUuzHBzpZhyKRGVMBqUpRXVNyQHJXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHXbssbl; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHXbssbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpwop4dvmc5P1wqOXtIS8Hk5GDTYYsCA7q7uBkgiHCxtGFQdNwhSz9tx6pe1Yp3To9/Sl2T6w3rRR5JnUmKO+eflG+7sCot9IgZEY/XvgBKkwf5ZD4kMdApcIaaDDfCj38NGgNyL42rQyNSxaH0KvBh/E+X0Ol169Q787wOBXHN09EnSEg2le9A+/Adcxxhz+J6sf/cHc5W7gCPP4uOI33lwOtz4ukuIgxyxKXCMujLmfALMrbXfp0x7GuJs8oJWRsEAaMQjsJszhQACEm5CjSU1EnlAWhO8yAUrEZzmQQaJGwWetPaqe9VO060Xcqvkprl6MUYDwfuHpLEwDvlTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pInVauN+nlAs3dn+rpzhgExu1Q8RP2pM3W4XP0CrLs=;
 b=NW2tiBR5eDLeCz6OsDgg3I0OBeCCpSolGcHyQqB9PN7cZvXTUNLKm7T7e8OLzWMFyi7PgoW3E4vHzRJ1hpPLORI9EoYn7z2Po2/hhinJkUeXzh2NBC6ngA9Fz3AbMK5RZ2XvAoY5ORO6+8FPEjQT1PP4LOFmF/NUMcgpBys4wQ3aGoKGVZIWjz5ZwhTn1SzDV957P3H+kOPHqnFVoKuvt8Ts0WwsFfVGxZ5dt9JsUq9KRvFTp/eCw8QY13Eza0JeeLY8PI8rDDatFhCDv/snenySqvG6EAF3tQLiKSzGhgi14mon4Q1ycMR4kxldU8S6IV+wKVrR5/wNGleFjDzo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pInVauN+nlAs3dn+rpzhgExu1Q8RP2pM3W4XP0CrLs=;
 b=KHXbssbl0dJODiz8TjSPXBwAnjQQCMSkSOIW3JRFjaXyDSxwqZ/Tgb7oXgBW+/La4O+YzjQeN7GJAmdse9uELbCHfvJbDCRuOv/JB65ND4IDjqvCDoN0PH1DVJqVb26D4CoxNXKn7ROrAG97/M3YB0wvsU2WNAWJYqhHGjan+bU=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:19:04 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 19:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:19:02 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:19:02 -0500
Message-ID: <ae21fed6-014a-49b5-86c8-543d100fe26a@amd.com>
Date: Tue, 1 Sep 2026 14:19:01 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 2/4] cxl/events: Validate the record count reported by
 the device
To: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-3-anisa.su@samsung.com>
Content-Language: en-US
In-Reply-To: <20260901002912.958-3-anisa.su@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: 666a9b0f-48e3-4dce-60ce-08df085de234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4huo8AUarQWdA850LxHAD15BHxpaNQ/yjNCLIMBg1Nay2QzqOLZhs89V2WRffyTsl2B77Io0Kbj6BLg9ehjwL9WXeZq7Un9GcFaL/Q9L1YR+DRyzHbo2Es4vUD7DBkNKZamdA6r/VbhGUO/1hBHuB/jjeUnW2Z10nLeyuBAQ8LShSt9dXB5oYUsj91FhmZ+th8vFWDJ6xDdcZZZTpTdIs0P2yzzHqKcapFmp3uXGQn4ntSYY5MepwcZvl3+T+bhyhawiZHuWGWY8BniqHm8urT6Arq1FHHiKGQVOhx2Nea5noRcvpZ5YHaxbkRrLNmjvXgkAMLwEGOC+4cOJ8SOnEtC6KXeoUs7MgLQRKAews1rneTaEruF0p5iaCkgr06Ky/9hmBMNXSvQnCx+iVnywNYxOTG0HW05h/uzReZtjirSIWJaSafEnnDhD7e7xq0LPTCZlwALsVwxO+VKxfvjr9jEatZS/BQtkjL0LjgKs3dypmSz8r9fApyR17j6SYXUddak5/6hZtnqze97Oyw5PBzW9Zi5P1ZKHr/T+9LT+XAp+Ief2FKjI86f0VZQXevB9h83W3pcdCZIV8knPSAfW+KJkccl0C1fBUbLXiDZRzPt35eKGdC90p+dGN7PVVbB7UA6Ms0LESf4vRZrJkQW2h/b3bs5MolWkkKGRNaF2M2y9OSf+oW9601DaS7IskDjLwEqp1dapcmWLf8qXFy1ngQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	odJzkxSlnqvM3KHt8I0TZ+ArPif5ZW0fbx8/vumFRImvTdyW5ZSeavHu68GcLcjRgPO3/+/xkWfV4d/d82dWeJ1bpKKbZZRisYaWxm73ensZsw7KCV0fuzoFaByvxwnm57BaBk4rtJiLCC8iYkkvLP62MycbZ+f/ItHPDz9mxWqK3E6LtfFRG73J/NMaBm4fcRMviOmLliWnFMAHDQv013AFjEOu4dDoiY4BJovzHXG74+T+7TLyhBwdvdKx/nYYx2CQTVAnDL4VsUAjb3EGKnP9ucnpHam1H33lsqA71cVzu4ZRQ3rcupPT++GmkjRbRUZbZASCvKvrAPg9Cvbm7DeHDFJ2FhdqcKW2xAm3gcSsWZhsiCl7llGoWj32IlYgzEbH/APJcrC/WEth4CzKSaKSVPXTO3cxGdu9kfaPwYnLnssb/tgIt8bZnibfeTMQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:19:02.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a9b0f-48e3-4dce-60ce-08df085de234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A

On 8/31/2026 7:26 PM, Anisa Su wrote:
> cxl_mem_get_records_log() takes the record count straight out of the Get
> Event Records payload and uses it to read from payload->records[].
> An oversized count reads past that buffer. Both
> __cxl_event_trace_record() and cxl_clear_event_record() use the record
> count to iterate oer payload->records[].
		   ^ over> 
> Bound the count by mbox_cmd.size_out which is already sanitized by
>  __cxl_pci_mbox_send_cmd(). Report a bad record count as an error rather than a
> drained log, so a device repeating the bad count does not keep the event
> thread re-reading it.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  drivers/cxl/core/mbox.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2b71a8e1f35f..02b8c33a74b6 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1110,6 +1110,14 @@ static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		nr_rec = le16_to_cpu(payload->record_count);
>  		if (!nr_rec)
>  			break;
> +
> +		if (struct_size(payload, records, nr_rec) > mbox_cmd.size_out) {
> +			dev_err_ratelimited(dev,
> +				"Event log '%d': record count %u mismatch in %zu byte payload",

The units should probably match here, so either the record count should be the size in bytes or the
size_out should be the number of records expected.

With that:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> +				type, nr_rec, mbox_cmd.size_out);
> +			rc = -EIO;
> +			break;
> +		}
>  		*got_records = true;
>  
>  		for (i = 0; i < nr_rec; i++)

