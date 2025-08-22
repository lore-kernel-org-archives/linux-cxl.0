Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478EB20EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885707; cv=fail; b=OYVYNH/fbn8S7nTj1NwIDVNLT4cLFlWwLbfvgfPRc/wpoSMhYNh6Rz012eQshdEpmEs7G+RjXBYox1+of+nV9xnvawX+VGbQbNCN/caYTWoCUzkU13mpKNEMqpTbn8QwHCar6u0hyT3I/+76iW79C6Qlgx1DUkS1X4cnJOd5HT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885707; c=relaxed/simple;
	bh=JSGWgbE2/aG2P+spM5tvSBtC1OFcK1MlA7GUPL8OFSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gYEk3AeSEIoPNqZPz1op29vQTASml5okGZtvujNSpqfh5Q/ze/qXUArtwEykxNhvw6VtZWp1D2ftgDQO/KrCXAnkbUF8DkZRYn6n1JemC14jBkUHdi5DjKQ2Xn6ok88ihu3b90yRyYk3DtOAmXOnUQDhuGASm+Mq+1No+RFwnlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mfnIPV5; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mfnIPV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbC1mfHHxWEwXlvEEPDpTjQIh8IR1+8cI+MnuJ+H658fIg8IAbcv252+sJ45Fq8cJL+Qth5e+LWjPg7p1psy69Q+iwf7fTOEKOt7tVNROIeh90AUAGgWc4HfBgiAjH6ePAiHa5/ONWXJkIHd6aHgAeWGmTJaCT+RM2l9QJpNL5RWjNN12cK1avTUTsrjkuT/nTEScAPooIQkP7RX//3wJhT9T+IV9VBW+b7STtQkwofduYdW6m6mSBhLzOFrcpiU3l13PtN03swbaVRoaZmw4WCfM3acoECjglF2opHly3he0BbP7lFA7pejTTsiYPz+0q/XK6dHwn5I9JJezoGKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG9xx9YrVaDw4C66kpLyoggVFFcqkrIQUVxCytNxgWc=;
 b=Jfw1OvgWnlLW9vNXZe/4nxvKNPxEmGQc2fWep4NYBTg/jE9fkiIAUeSypYjChsd2k9R+Sk/MZIjQzsgGsdHr/6ficYNriWbUdmk8SIMTjarPt4G8GxYsZPfsdpkakvoXWslaZ9MICkbrko8dZLax4bUXNGVMsGEa+5nD2qLesE+fLuWXhwfiDOa0TKrEozcOYnNW8vywoUccRswt56YYCb2rDtuZhnMy+NPTeQR/QA4m02QNRYD17+Ne2fU1/dR1KHBjAXHUflDf2Rd8LldMS5SXF0CxmOvgXy0FtcDnoMXlc5sTFO4kh4ApKMnvhF+zsa/iLh3wMGhhhDaedTMI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG9xx9YrVaDw4C66kpLyoggVFFcqkrIQUVxCytNxgWc=;
 b=5mfnIPV5x7RIqWPOWtG+oLh/ALqj72dpVimUEepMdT+mwgR5KVL5HsxJLWXeRyyDvVw3X6E7MRjem2hUF9Y4QVT8JxlLE+rRAb3q4PTowWGVHFx5EQoUa2rAkYWHPO5zec0R8coyPvrLQimBFbpl6t32QS/gNYKYxEhzj4Dh3tM=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 18:01:42 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::79) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 18:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:42 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:41 -0500
Message-ID: <e88bc571-9dc0-4207-8454-019d755b596d@amd.com>
Date: Fri, 22 Aug 2025 13:01:41 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/18] cxl/cache: Implement Cache ID Route Table
 programming
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
 <20250819160744.00005535@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819160744.00005535@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 12be071f-51f2-48aa-c329-08dde1a5f340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUJZblMrcDRxQmNlbkFwaHFvUlFPazdnelJEdTZEVklUcUdGWVdJMStGUkVS?=
 =?utf-8?B?MW1KUUk5UDZOdFU4ZTEzZVhBbzYzdjU5bW9rNkRMMURXTi9NYm1BMHNYbzZX?=
 =?utf-8?B?bkNBOGIvWjNGT2NQNDJXdGFvakhSWjBMWUVvdXo3RWQzcXE4dFpMM2dONUJX?=
 =?utf-8?B?c1dzMkJWeDNCSnhPRTRuWEozeUpvcmx5TElzdWlJQytTT1hVWG1PaENwbXk2?=
 =?utf-8?B?dnhHbW9PRisvbTAzR050TFVMS050bXpncCs0MmhHOUdKOFJZWTBMb0dSOFJ2?=
 =?utf-8?B?TmJpY005cmVJRDhuZzFvcFJGRm5xamxucENMZExKWXJKdFBJVWsrTTVKWE1Y?=
 =?utf-8?B?cUgySGt4V080OWxmZmgvYkxTM1BmUVZRMVViQVFmaDlyK1JNYXVrTmZMSnVW?=
 =?utf-8?B?Y01UZVdtRk5xS0JsVk4xemFJbzFkRDlRMEFybzBtTGhZQ0xmZDNhbE4vWjRR?=
 =?utf-8?B?bWZLd0FsbUNGVUNzSUI2WDUyaDhNREdZQ3daNWdLa2NndVlVY3BjSmtQTVd3?=
 =?utf-8?B?dTFnZG1kcmZtbERrSTZKbzlXVHQzUWV0TnNSZmlscTN5UXM1U1VKUGcrRjdC?=
 =?utf-8?B?NE53cUUwYWF0NGFrT3VUaGI2MWl6TmxIdTZzdDQ3WUJqU1d3OVRuWXBlUE44?=
 =?utf-8?B?dEtrNVIvY1BxRURYakhTbFF1dDNVbjZrMEZqWmpsb1ZvSTFvNmd5NXFLVmd0?=
 =?utf-8?B?Ulo5TWNPc284U3hqK3V1NERLa0tzZ1VhNTllbUxnSnZEa25KQzBKL2J5OWxM?=
 =?utf-8?B?ZnJRR1ErbitOZEN1WUhuUDdTZ2E2cGlLZlZ6bHdabHE5dTN0SzhCeWdPTVZX?=
 =?utf-8?B?UFlxRjc2V0lBRndONC9TL1EvZFFhbnlZemRTL0V6QloyaThoWkdEOVY2OVpF?=
 =?utf-8?B?S0ZZRUVPcFN4Z3dWRFlmaHVWZ1VYT0U4RXhLeHNnbmV6SVlJSjlMSTRadmQw?=
 =?utf-8?B?NllMa3huRXNlOE9SNHJXcVdmWjZiVHZFMWo3TGlxRzBBQm9aTjZabWZqMUk3?=
 =?utf-8?B?MVhmbUdNVmZ3Q3cyQnpMYVZOczFHOUFsd281LzJobkpvMmRwbytFZVFodmNm?=
 =?utf-8?B?QjRvUkJZK29hNW9JTDFtU2hPT2RvTnVSVXJHNUwzZ0tJalpucDVDRjMxdTJT?=
 =?utf-8?B?Rk4zY2x1R1E4SUtKcktGNjNQcWkvME1PL1Y4V3lmQ1BpYzRYNW8yWDhyYnN5?=
 =?utf-8?B?MUZWNnhNTDBXS3h4TmEzY2xvbzVzRk9tK0lrSm13TE9uWEFVTnJYYXRiR3Ir?=
 =?utf-8?B?S09jMjAwMTB3UjJhNTBpS045V3VhZTZtOHVXRW9KZVVIcXdaSVMzSGVxN1Mw?=
 =?utf-8?B?MnVDTEZreklhVmE0dGpveXBkSlorMmJnWDYwbjZ4bkdkTnpia3dCa1JvRUxm?=
 =?utf-8?B?UmNXN3NVNkxDM0QzTzludjlOYWI0ckxGQXRZVU0rZGZ1Ulg3OHJXWGZWc29a?=
 =?utf-8?B?SGxSUVk2OEo1YVhMV3poUVM0NVV3WmNUSWtSeGV1d1Q3ckhPQ0lhb1ROZ1lN?=
 =?utf-8?B?dnBkMUNmdHZLemZscEVZTDlmS3VrVW1oQVVyb1llZHhuaitCcktvclJCN0ZW?=
 =?utf-8?B?blpIdjgySFhKOWo1TTRjd1ROTm0xemxQSGJqUjJDTmF2cElWa245T3pQUW91?=
 =?utf-8?B?MHFqQTBCellyVzVySHp5U1VhVld1N1Zvc3JnZmhVRGtHbHdUdnZSTkhSK3Ni?=
 =?utf-8?B?aHEzOWk2REI4V1IzTWduOGxhOTBYQUFoSFRwYUlNSTNjY3JQWW0raERiUlZu?=
 =?utf-8?B?K2Exc2lQZk1sZ01JaVJDTmlmVDdsTktnYnVOcko3VW53ejZuOGdBZ0NzN0dK?=
 =?utf-8?B?YnZiSFR2VUNESU1jL3ZqTU1HZGhGNjNKSkJ2OVB1d2tmeVVlSEhrUXZlbndp?=
 =?utf-8?B?b0ducVVIdDQ5NGFzWXhaeTZ6ZGlEeGtPNkovRDhSVzZFcVkvN1hxcyt6UENF?=
 =?utf-8?B?bkU3eFIyY0xUOE5JMG1XVnNRSlhuSHVxUTFUaTAvQ1hMRTI0eEc4UHJVY0k5?=
 =?utf-8?B?MUt5SVVsM3J4STh6MmlDdm9pV0krbGxHTDZNaHpENHNYT0dHa0lmT0xWYjhJ?=
 =?utf-8?Q?z+n7vl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:42.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be071f-51f2-48aa-c329-08dde1a5f340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494



On 8/19/2025 10:07 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:16 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL Cache ID Route Table is an optional capability for CXL-enabled
>> upstream switch ports and CXL host bridges. This capability is required
>> for having multiple CXL.cache enabled devices under a single port
>> (CXL 3.2 8.2.4.28).
>>
>> Implement route table programming. In the case BIOS has already
>> programmed the route table(s), check the configuration for validity.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Whilst it's a bit big, I'd smash this patch with the previous. They don't
> really separate as we end up with things half done but not returning errors.
> 
> A lot of my initial comments on that patch were along the lines of
> 'you didn't check this' when turns out you did in this patch.
> 

Yeah, I'll probably squash it (same with next two patches). I'll go back and take a look at
re-organizing this series to flow a bit better in general.


>> ---
>>  drivers/cxl/cache.c     |   4 ++
>>  drivers/cxl/core/port.c | 135 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  10 +++
>>  drivers/cxl/cxlcache.h  |   4 ++
>>  4 files changed, 153 insertions(+)
>>
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> index fd2ae1fa44bc..24559b9ba8e8 100644
>> --- a/drivers/cxl/cache.c
>> +++ b/drivers/cxl/cache.c
>> @@ -134,6 +134,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  			if (rc)
>>  				return rc;
>>  		}
>> +
>> +		rc = devm_cxl_port_program_cache_idrt(port, dport, cxlcd);
>> +		if (rc)
>> +			return rc;
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 26ea22a2638c..f491796f6e60 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -945,6 +945,141 @@ int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
>>  
>> +static int cxl_port_commit_idrt(struct cxl_port *port)
>> +{
>> +	unsigned long timeout, start, end;
>> +	u32 cap, ctrl, status;
>> +	int i;
>> +
>> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT))
>> +		return 0;
>> +
>> +	ctrl = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +	if (ctrl & CXL_CACHE_IDRT_CTRL_COMMIT) {
>> +		ctrl &= ~CXL_CACHE_IDRT_CTRL_COMMIT;
>> +		writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +	}
>> +
>> +	ctrl |= CXL_CACHE_IDRT_CTRL_COMMIT;
>> +	writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +
>> +	status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
>> +
>> +	i = FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK, status);
>> +	timeout = 1 * HZ;
>> +	while (i-- > 3)
>> +		timeout *= 10;
> 
> I've no idea how that relates to the spec. Perhaps some comments.

It doesn't really, just an arbitrary timeout. I'll add a comment.

> 
>> +
>> +	timeout *= FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK, status);
>> +	start = jiffies;
>> +	do {
>> +		status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
>> +		if (status & CXL_CACHE_IDRT_STAT_ERR_COMMIT)
>> +			return -EBUSY;
>> +
>> +		if (status & CXL_CACHE_IDRT_STAT_COMMITTED)
>> +			return 0;
>> +
>> +		end = jiffies;
>> +	} while (time_before(end, start + timeout));
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +struct cxl_cache_idrt_entry {
>> +	struct cxl_port *port;
>> +	int port_num;
>> +	int id;
>> +};
>> +
>> +static int cxl_port_enable_idrt_entry(struct cxl_cache_idrt_entry *entry)
>> +{
>> +	struct cxl_port *port = entry->port;
>> +	int id = entry->id, port_num;
>> +	u32 entry_n;
>> +
>> +	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> 
> It's 16bit so readw?
> 

Yep, will fix.

>> +	if (entry_n & CXL_CACHE_IDRT_TARGETN_VALID) {
>> +		port_num = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry_n);
>> +		if (port_num != entry->port_num) {
>> +			dev_err(&port->dev,
>> +				"Cache ID Route Table entry%d: Invalid port id %d, expected %d\n",
>> +				id, port_num, entry->port_num);
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	entry_n &= ~CXL_CACHE_IDRT_TARGETN_PORT_MASK;
> 
> Maybe just start from 0. There aren't any other fields as long as we stick
> to not reading and writing neighboring entry.
> 

Makes sense, I'll change it.

>> +	entry_n |= FIELD_PREP(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry->port_num);
>> +	entry_n |= CXL_CACHE_IDRT_TARGETN_VALID;
>> +	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> 
> writew()
> 
>> +
>> +	return cxl_port_commit_idrt(port);
>> +}
>> +
>> +static void free_cache_idrt_entry(void *data)
>> +{
>> +	struct cxl_cache_idrt_entry *entry = data;
>> +	struct cxl_port *port = entry->port;
>> +	int id = entry->id;
>> +	u32 cap, entry_n;
>> +
>> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
> 
> How could this happen?
> 

I'll double check, but it probably can't. I'll remove if so.

>> +		return;
>> +
>> +	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
>> +	entry_n &= ~CXL_CACHE_IDRT_TARGETN_VALID;
>> +	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
>> +
>> +	cxl_port_commit_idrt(port);
>> +
>> +	kfree(entry);
>> +}
>> +
>> +int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
>> +				     struct cxl_dport *dport,
>> +				     struct cxl_cachedev *cxlcd)
>> +{
>> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
>> +	int id = cstate->cache_id, rc;
> 
> I'm always moaning about these but to me combining assignment and
> non assignment declarations just ends up hiding stuff.
> I'd always burn a line to keep them separate.
> 

Sure.

>> +	u32 cap, max_hdmd;
>> +
>> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
> 
> Check if in 68B flit mode as if we are this number may need capping
> to a much lower level (field description talks about this.
> 

Yep, will do.

>> +		return -EINVAL;
>> +
>> +	if (is_cxl_root(parent_port_of(port))) {
>> +		max_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_T2_MAX_MASK, cap);
>> +		if (cxlcd->cxlds->type == CXL_DEVTYPE_DEVMEM && cstate->hdmd)
>> +			port->nr_hdmd++;
>> +
>> +		if (port->nr_hdmd > max_hdmd) {
>> +			port->nr_hdmd--;
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	struct cxl_cache_idrt_entry *entry __free(kfree) =
>> +		kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENXIO;
>> +
>> +	entry->port_num = dport->port_id;
>> +	entry->port = port;
>> +	entry->id = id;
>> +
>> +	rc = cxl_port_enable_idrt_entry(entry);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return devm_add_action(&cxlcd->dev, free_cache_idrt_entry, entry);
> 
> At this point entry is freed.  So by the time that action gets called
> it's a use after free.  Maybe also need the _or_reset() variant
> in case this call itself fails.
> 

I'll fix it and change to _or_reset() as well.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c147846855e2..1a2918aaee62 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -163,8 +163,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>  /* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
>>  #define CXL_CACHE_IDRT_CAP_OFFSET 0x0
>>  #define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
>> +#define   CXL_CACHE_IDRT_CAP_T2_MAX_MASK GENMASK(11, 8)
>> +#define   CXL_CACHE_IDRT_CAP_COMMIT BIT(16)
> 
> I'd get explicit in that name. It is an odd bit of design to have
> the option for device to not require it so making it clear that
> the absense of this bit doesn't mean it never makes the entrees
> active / committed.  Maybe REQUIRES_COMMIT
> 

I agree, I'll change it. Some of these names get a bit long, so I was probably
trying to cut down on the length...

>> +#define CXL_CACHE_IDRT_CTRL_OFFSET 0x4
>> +#define   CXL_CACHE_IDRT_CTRL_COMMIT BIT(0)
>>  #define CXL_CACHE_IDRT_STAT_OFFSET 0x8
>>  #define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
>> +#define   CXL_CACHE_IDRT_STAT_ERR_COMMIT BIT(0)
> 
> Nope.  They aren't both BIT(0)

Woops, thanks for pointing that out.

> 
>> +#define   CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK GENMASK(11, 8)
>> +#define   CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK GENMASK(15, 12)
>>  #define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
>>  #define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
>>  #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
>> @@ -618,6 +625,7 @@ struct cxl_dax_region {
>>   * @cdat: Cached CDAT data
>>   * @cdat_available: Should a CDAT attribute be available in sysfs
>>   * @pci_latency: Upstream latency in picoseconds
>> + * @nr_hdmd: Number of HDM-D devices below port
>>   */
>>  struct cxl_port {
>>  	struct device dev;
>> @@ -643,6 +651,7 @@ struct cxl_port {
>>  	} cdat;
>>  	bool cdat_available;
>>  	long pci_latency;
>> +	int nr_hdmd;
>>  };
>>  
>>  /**
>> @@ -786,6 +795,7 @@ struct cxl_cache_state {
>>  	u32 unit;
>>  	u16 snoop_id;
>>  	int cache_id;
>> +	bool hdmd;
>>  };
>>  
>>  /**
>> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
>> index c4862f7e6edc..d28222123102 100644
>> --- a/drivers/cxl/cxlcache.h
>> +++ b/drivers/cxl/cxlcache.h
>> @@ -28,4 +28,8 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>>  
>>  int cxl_dport_setup_snoop_filter(struct cxl_dport *dport);
>>  int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
>> +
>> +int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
>> +				     struct cxl_dport *dport,
>> +				     struct cxl_cachedev *cxlcd);
>>  #endif
> 

