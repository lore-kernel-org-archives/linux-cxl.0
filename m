Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295D29C328
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111321; cv=fail; b=mPxFh9znoM4tTX+eQjESxVXr2iBhpLu8pwnDlNZJpDbO2Eec94epN8XkhGwcaQehdVii3wWZ0cUnPfVaz+pFGhmViB7Wk6mxOFeEbT4099pXHusOJmXOKleGx/siwll5thqd80zOFFmgMW76eWTSfzcspoA8o9LcW+8g44qdhi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111321; c=relaxed/simple;
	bh=+G2/Mg4r9rGH+aFzD5VRZpzuSJUiG7gbEBIy2sBA8J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cTipUKzHnouZz/6M9OkF5C4Iy5E74dTllJaZdihnnprl4fuUVtVaLl6lsjzjFTkGqMUX6RSA9kNzSy3ZjAIIb9hO3jlfiB9xrCkgD0yXws7JvkNCNNF3DiPtjqp52VkQLWlH6PmXpxARgpkLxmPs2/2x8Je989h8MSB2bpAYaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41IQHyN3; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41IQHyN3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdFPVmaumdyyg/km4ZIDZ35v9vU87F8rinKuw/5iVpMD2VEgbLr8P4cmuMkqRi7GfAvuiz1/TKbb0tmuKN68IzkWJe/uo/coWx7tIAwDk3UtTBCNZKAATFysWVBMMC+3orlQJ+b8r4CrMiC9kTrttdVdQbYeZGThNDmt1pPdz67GCQWTtOQAlpiT/QMuAp6hBCDU/SxhTFbiUK0V18R9e1Niyj8J361PQbZ2lY9ZcG1UG5Lb1wocsPvJlyLIl6G7WJ2F6BXjrhVr9GEFcc2xagbCXb9SmKAhhnc0VRpXeLIwDa5KCkMvr7Lj9WH634PRvzio8j4imsOYVuHiEXZCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rTxsUYdQBKPvFzHkLcKwDmK3Ljeindd3fqpfriqXE0=;
 b=vWOxw5/NWjjH1vdc5ci4diXmfcfMNLebmKFwLOq7iHcXUWULT7NUl9bUnIUBWPphelwR4dJXJ7OPTFPchakbbjCr9CfW6ueUVLkxi9Ml8mrKzFaUzGHuefKrY6CmxD6H0tZ8pRr2mmBzliZz7PTQX8uUZohseMA/jRX7wogjrT3RLO7AaDB1dUVi/z3ZuaPQs2+ks5vkUxwbVM7Uq/IfV/NYrt0FMQbwEp6AgYZkHQm64YszVg+ztShh/r6IqPJqMB8EpRu3/M2J54PBM87psAlMeC0sqS5fszT/6Gyv1DDtGJKwDRJMPio0NplxwgM3P/SnLCWHdX6W+InCms7arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rTxsUYdQBKPvFzHkLcKwDmK3Ljeindd3fqpfriqXE0=;
 b=41IQHyN3/Ov9WT4B3FUX1khtH1I6wCOJ1xHCHeF34ZbjatqsN4ZEQaX0WeVdGomSKl7XUNSeWZ+uWBAOCRqsCpdMxFdz+MX+9wf9AQPsGiYuuzJ4aaunvslIxXrosFJoUifVMLG8hCLGBmxh+xYbjbQFZigRob6TrDvcOXYhdVo=
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:08:35 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::97) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 17:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 17:08:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:07:43 -0500
Received: from [10.236.180.156] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:07:40 -0700
Message-ID: <8fd36643-c228-4b76-9832-9b622fc309b1@amd.com>
Date: Wed, 10 Jun 2026 12:07:40 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port initialization
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <djbw@kernel.org>, <jic23@kernel.org>,
	<alucerop@amd.com>, <alison.schofield@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-2-dave@stgolabs.net>
 <d430e2d5-3e16-4de1-a1a7-2ba6bb2acc4c@amd.com>
 <20260608215509.nhppkigu2oqv7i6v@offworld>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260608215509.nhppkigu2oqv7i6v@offworld>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: fd49d13d-ac60-489d-bc4f-08dec712e7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|3023799007|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	cnAPUtIDMjb/ev38Ah+fD5lXlrY+PQG+RGBURdCH76r52KGl4/4t9+Ept+Ts4wgKn7Xg1W/sd36LB8dbSeuhhDX0KxcB5V7OJogjKIYQKmpofZXkcLuSsuNRrGLU+OUaAUsoVc3lc94S5CQJfmpF7zkHHk3bPrBcLb2ZMFSUVCRgt9E3SUrYpPNVvObfesp5jwtMalJxCyEL7EXBrsKWIMTnWeisQcz/o34N3Y2Z1emUkiQoeIFVBIN2pETqNk88ql9k8KCtGQrwEJ0jUWeNLsUUDTcjtt9yWLDWpA16bqiAzUvnoT3D89/2WA/m5xALYjmIV/QRWXvz9KsjnWzJUOA7jjNKEE6mwFdxZubk/7ZHEdepSiFI1LkZAoTUyL9xYcaDER1w8kgX2qcfDQB7NUWy0rt9kGwJg0rzbDS6OHOeSMOPDTLIvlsp6fHxslPcAvYw5++vYdBASd+zCcQh9p0sxixcKwhKronJd8L0Hrf0RzJK7gvU11CJXahthrJQxlCfjMtX5YBqEfWafAFubX9/p4cDoa2tGhGlgvT+pnGnLvX6TFXh+86EijOTGfoyu2weiROE7T11jgMLIkegxThuVUa7ex8SYZiLbDgsX1LsNRtuVpEIVFjLkofjRazVePEz1aOB4cfBU4elSJeltddTzO5m5MdH0YtRCl6gQJ+ocn0tgWkc3fFpv0zxW7cERG1mpTCtWHMlNnKEdPZ0H0Bd7r3Txzi+4xuZlRqIpXg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(3023799007)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	If74wxxEv3BuViGqdpdhg0EB+uqeGWvMDFy+OifrgQ09mO6NQbneoIHMhZnTDTBy9KdlZMX21iz0FXJlnQaEaVmx9GzofXBkpT5Q6573lkA7FrnhjyTuIq+5ZWp7xclLIAr+qqDrw4k8MMJwZl19++VrLvkQrZbM5Y+7qNcjG33dC1TXnmOkhcFDpnX7wgVg4/V3KtBICAmGhJf4B9FmYqU8Ajj1Nw0ONEWPxAPcpf3GvTB0BayeJ29ZOBIuqn/o920ZrGSM8dHz1kSLgbQoN3g83H9jon/nbuPAaDwtIhEwtwoJYJ+L4N43K9IX7j3MXfV4JWD331sO+38mi7LoXgyxcMFtKB830LbwPOKvnorqs1l4luLx7vi/EQUcwfgOZp3GjO5tlXHZxyHDWUEj/rltVUaUWqFHTE7+ICZACOYhG5475Mhg+ay/BN7I2QHI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:08:34.7152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd49d13d-ac60-489d-bc4f-08dec712e7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

On 6/8/2026 4:55 PM, Davidlohr Bueso wrote:
> On Mon, 08 Jun 2026, Cheatham, Benjamin wrote:
> 
>> On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
>>>  static int cxl_switch_port_probe(struct cxl_port *port)
>>>  {
>>>      /* Reset nr_dports for rebind of driver */
>>> @@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>      /* Cache the data early to ensure is_visible() works */
>>>      read_cdat_data(port);
>>>
>>> +    cxl_port_map_bi(port);
>>> +
>>
>> I can't remember if I said something about this last revision (and I'm too lazy to go back
>> and check), but is this in the right spot? It looks like the port's component registers
>> are enumerated as part of cxl_port_add_dport() (in cxl/port.c) when the first dport is found.
>>
>> I'm pretty sure this runs before that happens, so I either got something wrong here (likely)
>> or this shouldn't work.
> 
> Yeah, I moved this, please see:
> https://lore.kernel.org/all/20260608003323.lsja233dvqltwjqm@offworld/
> 

Whoops, Sashiko only CC'ed the list so I didn't see that in my inbox with the rest of the patches.

I'll check the list next time as well!
