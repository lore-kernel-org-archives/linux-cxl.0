Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3E334681;
	Mon, 13 Apr 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090314; cv=fail; b=WWQkDRvq4b/tKziMICjOmSzaM1BB6AeuzXKpVbTTf9Jsa/j6Bd9ozyhcZwFbMFDJlf2f2WrRYIZX8kuG4mtSiheu9SouIzvGmWmhZ2IRSGn5sQe+WeCGThwYLi2v789gY3pLVFX2me+y0hYUUIyI0twqnNq0fJtWZ+KO1zK3N18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090314; c=relaxed/simple;
	bh=EqzALhc/zKcj2Ja13H0+bq4j7tOsPRS/ZilmtKH1o6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iGfEVwYlMwn+WZ5jmZFNt/RN2KNFKK/xPc4toACVhQR2rYD6S2Q1my7NSEnFuW7cBwLsRWwSWXXoezYCWX4Un/OiGS+EbZKj/51tHxDALnGaGLdgcjw3TFy3BpJDYcLUKO/RJcqwa+4TfTGx+K9ukPQMm27sj9bYDHuux0xA4n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BNjePtpz; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BNjePtpz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHq5vLH38pk55fnRw5ecqcYh4Cy/Zl0/Gy7S/w5w+q027VVv6PRgYeObUg+q/Uh5TtOY9dpCco29OaST4BFiXq4ETo1tzoOYdurrMGJ8x0Q/P5Bc+UXS0b8WJ+Z3qOcBQ+c0UW+xNzBd6waZ4N8T/o8CuCgNzpHwo79LU8jn7Nblf5nxWj5Q/+lzQIioqNkH6xq7j2YzrsV+Trkmb89/nn4PnNwdOJIZjfDVH0Nrdihv812sXIRU50s3qQVaRwHUq0wzYAgaEZK+C2whHh8uEI530ddKwWCB70iIfJbkA956VBaK1ll/DHrysb9v/LkUKJwHxk4DD8Gh4QjTFsxaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHHCaydMWSXvFmKU3EOLnDCGPlKq4E5Xs2TMCVogVjE=;
 b=o40N2M8p/+YMehGy8s4Ol/BxYE9fqCdlZZQmEjaBqlWsSJF9RsBlKeTEQeH1T3v9oKHGn1oTtyyf1CPtNv4uJcHp+jZjNfG1OsrYwlCVCx1cyI4RDvQHSi1BxOXklwX/6vE0h39J3RhBkeApudyfnWoYYEzOskuS1H+Q4W/eVO9RJoVTXHpbTJUdy3MG1pSAcKqHPZ5iW/fQ4dhhhZsc3VOcUOFFPaIjTT6WGkHGXEPcNryuJvH9d/jUyVj9H/tmvwBXdG0wUOvkx8bk6t1VOouNRtMQS9zu61MMjtW54DLBH9QYdhbwZBqt5HuoMkXuhrFDtwYvbYuGVwvbAlC1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHHCaydMWSXvFmKU3EOLnDCGPlKq4E5Xs2TMCVogVjE=;
 b=BNjePtpz26RVux1774yOdbvDbdfaa3/inaFB/HTXdTnDAumKGZk5tszXlZMGgDS/jhIQwBfQo9Td7sSLSUlgUVjQe0c4qL5U2PKp+xImugASHpYl4Pvur0hL0faMeXJT6Ebw+n5kt8Hp4nHyTRmIcepVxh+yA2vQYSq/c4aAGHg=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:25:10 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::d4) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:25:10 +0000
Received: from [10.254.59.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:25:08 -0500
Message-ID: <c5487f86-f9ed-4d54-b420-4ef451be558e@amd.com>
Date: Mon, 13 Apr 2026 09:25:02 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
To: Dan Williams <djbw@kernel.org>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alejandro.lucero-palau@amd.com>, <lukas@wunner.de>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <59f69b87-e37e-44c7-8c15-c332118622b5@amd.com>
 <69dad30a614d7_fdcb41008c@djbw-dev.notmuch>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <69dad30a614d7_fdcb41008c@djbw-dev.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b70f5-fde0-4bc4-7f6b-08de99687810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xM3uk1JAMT08t9rnilIHc/c+eOM4zCMyBrb26INniqSIMbXNjY++dj8SkRN2G+D2sk0VGzu+DGkimu6xKPsVawI4t1RF4A/gmSKGVTP73jYWcQBkDsueo1sAadE/HWZai/rtmZKUFbjnbbqgy35KQmnH91RsNo+jwlPNmA3rVcXCf7DDk6vdDjO9vfpsllWy28qqo21U7VUjIstUlisjUtos7VWs87TXWrlLtNtrEkoXQxre9Sc7WwP/0Bdsmx69h7KUYclCYKm3y8LF/iRYHuipTo/CMMOrKySs4IblFkIJsg5R3pY9DXuhm+qlS+9qG7PVVdRMBVgH+a6X7oeu5OmrcYFQeVWGBWi5DP21Ncj0sIqNeYEwpkV7qYbOXw6YZRZd5rTiUZiTMOgxcStuOBVRHF1wVjR4bsJynRRfWbZ9RKGHZexY6TejcAUppiX4/wz5WJ14XViNmdXInVoBFvPDwILZLAYXw6SMLnRi7HIMCYFeI6zsfg79aWSDBrDbaRuFY6qlkkhnL9anM56Xgy/ZYZqaqXp5Csx3Hk1XhUMc4Rr/A4zOcgUxUG2CJ9O8fEglZWX3kNdqY4Vymq/eDD3hWhRpa22ABF6OiiZICQQ5KNZveZR2ViSod7sNtOTaEY8oBoNHLxyyvHoMaa9EsTfOER/RMtjrJ84z2kkW6BuJCP4RdBYTdgF9dJJb5ZWcpTjS1RudHsqdW46FrrKLxBGdCnIEWNJGWONvNd6Myjr9lD4H+hDTK2S9PWq8COwAlhxHXUjj0TWoobZs36zZZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OpzA7sWIg2RzDjONV5xPvX0z+q9mpIziD42CNlqxTJtvqKqppWwltHdVwNQ0EKzbHkiYRKffLX7PeSPSR3PrdDuiG14CKP+MzxsQlt9MEno1Jr5taZD1R1+6fa8+VYEHTHhWUj4pcOFiueFZjBC883bIqofDJulKMQHzP4pdmUmFHm6xcSBVRrGng+AfFS1TDMd3gqS+ZaeCrTLqWYOvWE3v/wrNhJsmxsOdRFLeMyyR20y7QVSliPRIwqHYeQEYjq2w2nRtdfhoRZhmSuWla2bKc0BP70rElcekKi7yTSinfapSAsvrlE+W01Avv48s61e7Oo/KlNo7eu/OUXnZIgR3dDa9ykpw2J6DaGIMtohWE1dJwr8lcHiquhpQrmPLcnOVKHaeiaAAYuR3agAacjf/WPvnq+9I7woFGsy4wUR20GsIoGxmqV2q6ff+Aa0v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:25:10.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b70f5-fde0-4bc4-7f6b-08de99687810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

On 4/11/2026 6:02 PM, Dan Williams wrote:

[snip]

>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 11bc0b88b05f..090f52392b20 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -1123,6 +1123,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>>  static void cxl_region_setup_flags(struct cxl_region *cxlr,
>>>                                struct cxl_decoder *cxld)
>>>  {
>>> +   if (is_endpoint_decoder(&cxld->dev)) {
>>> +           struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
>>> +           struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>> +
>>> +           /*
>>> +            * When a region's memdevs specify an @attach method the attach
>>> +            * provider is responsible for dispositioning the region for
>>> +            * both probe and userspace management
>>> +            */
>>> +           if (cxlmd->attach)
>>> +                   set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>>> +   }
>>> +
>>
>> It seems unfortunate that you set the region lock bit here and then
>> immediately do a check to set the bit again.
> 
> There are 2 different cases to lock the region here, presence of attach, or
> presence of hardware locked decoder.
> 
>> I can't think of a way to leverage cxld->flags for type 2 in an
>> ergonomic way though, so I guess it's fine.
> 
> The flags are just caching hardware state, I do not want to have drivers
> play games with the flags that dilute that "cached hardware value"
> meaning.
> 

Didn't realize that, makes sense.

> [..]
>>> +/*
>>> + * The presence of an attach method indicates that the region is designated for
>>> + * a purpose outside of CXL core memory expansion defaults.
>>> + */
>>> +static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
>>> +{
>>
>> I think this should be renamed to something like "cxl_region_is_private()"; it
>> better matches the intended use of the function while lessening the burden on
>> a non-type 2 educated reader. Also has the added benefit of being one less
>> change site if the mechanism for determining if a region belongs to an accelerator
>> changes in the future.
> 
> Why does the CXL core naming need to cater to accelerator vs expansion
> use case naming?  CXL core developer needs to understand all the use
> cases and wants to make them unified as much as possible.

It doesn't. I agree that developers that are going to touch this code should
understand all the use cases but the naming here doesn't accurately convey
the intended use case. memdev_attach is only used by accelerator drivers, so
this function is checking the device type/driver.

That does somewhat go against unifying the use cases but the use cases
definitely do diverge here. It's really more about clearly delineating where
the cases diverge to someone who is less knowledgeable about accelerators
(which is most people in my experience).

> "cxl_region_is_private()" says nothing about what "private" means and
> where to look next. It also muddies the namespace for when CXL regions
> start becoming the backing store for "private" nodes. Is that a
> "private" region?

Bad naming suggestion on my part, I forgot about the private nodes set.
I was about to suggest changing it to "cxl_region_is_reserved()" but that's
an even more overloaded term :/. Going along the lines of what I said above,
maybe something like "cxl_region_reserved_by_acclerator()"? Kind of long, but
gets to the point.

Thanks,
Ben

