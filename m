Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793801303;
	b=AlwKAo25Kb9F44o2QDp4i7Ozmcmpe14gXsEjk7Of9uG6PitvEIxy7ctlL0pHcP9/6UOg
	 zcO0SvB8kjXh+Pis/XJ+YfFs9QzTf6FPNMkigyyb78skwvunAuo1G0BpL5nDRS3kHiHfy
	 de1H4WnDrpwAlL458Umt5XhUezak3TxRfUZWWbMzL48ai5877aAUyDR8Gu4W0UqjOOHOk
	 U/PboQUfaVj2DuJ8ZOS1Ir6EpxibOE9qI3zzc+VwgHx15Fjli991Qg+/Q1cG6iuHQ64nD
	 iYIlHefljLRPlLMIoksHMqJLlHHzzG//GMADYs1gVwVHTj0I5b9G7/zZ/cwW1OWXW2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801303;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1G5WcUYOumMJ48iLn6ocelyeXBMci9yoLL2bozJbBhk=;
	b=0yGZkzuwvJwWIoRLDROfpTKo5Wktc5mklCBBEOHz6FALgJA3HVkZsBjmDJqMblIgV8+B
	 zEpnqg6iTX56FdppIFcl63KTDNirGUtS7egn/p0lX3c7DXKRffh034EyCU6RRK6ntBfLy
	 pmsIUjC+9/eG4kS2uBd0IVXE6g8aBFaDfSSTDGiwHY3HLagv7L9ENzgQP0r5TyeLZ/0gh
	 GwsqNyJrh4JBSHEVaZBWDuJUxr6oAtjrjgsZskvqbxGcX0OL4D8RHJDouRvNp4Hc5EJFE
	 FbGpRL4Vwx+7ucty31vaUV43qVqbp35FSBgEgXSWRnJNyByx3pzW2qWIIm6CDfNFWGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VfoSStn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF13606A339;
	Wed,  4 Nov 2026 14:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF13606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VfoSStn0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzGXaqFcEKB/QhB6o8nLCKfksDDVBujPtBL9/aS/d8C+dkUcM3ZagtBcaT5S4LzR0VjrbynXoZ5u2MOBCv/piTGJS/ARl+pvw4sq/5T1pUiTJmnvmR2jwGmxKlLpXz5LUlsvB+bWMdwEOq66Ie1J6WIP4Bd0D9rGg+2wDgYwAHjJNTbTB/6zcZofDSxA4myzs1tiE6REKpTVUo8Q3aX7et3WZrRGRPSpI4+jUxOeJrQPCMhqzIYppQXDJLdTdC2cDQwJtijt68DFuwbTIVPg79YU04feIITAcxgWdwxoAEn1/374C/Q4GQxmHpVNJbDndVUeiqL0UyK48+feCBZ2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G5WcUYOumMJ48iLn6ocelyeXBMci9yoLL2bozJbBhk=;
 b=QiiIti83YzbHFdOARkXdZrNIorgPBNi81Wi6zlUBgc/v2XR76jSsbcdPYRZn3LyA5ouGLD6iEKbBCxP5DWaWFOOqDPeCBw1m7bN1bWCNAj+DBTQ3XmFNuFn3uxK6VVwL9xkjDP7DoO54GlvEKCBW9H5XsXZfdqxuUJPrr/HFsopkMB5T5/yTAqUfqYEJ6tqdDBwpSXhAJyCAC/ZMjEf4+7e6IvgnRlryUfuUbhcAUX9MldS+fK6UvQ+N5Lz1nqrqw3p2NmxXnSdNWqPa2HhDnqfOCwpzo7b6FSnDn4IgBlqaYjGepZ/iN3OFdCHqKlfb36zaVWD2X4e19pHT405bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G5WcUYOumMJ48iLn6ocelyeXBMci9yoLL2bozJbBhk=;
 b=VfoSStn09D1LyGijG7GRCVf9hiO1gZmO4G/dxnoh5BKl9xaw+1s2FrDxKFyi3G9ogCXXPwQtMgAx7wUF0E6iSVHVo+SwHRsdCSPbePbC9BbCSR0m2ZXTn4Ft63ZenJN6y0DU/Sz6hIazIE/onO4T4uOLLwzMoqGq0ILCxpcqtMM=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 4 Nov 2026 14:08:17 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::42) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 14:08:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 14:08:17 +0000
Received: from [192.168.86.113] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 08:08:15 -0600
Message-ID: <9535d4f1-d418-40d1-924d-df35f85a8e99@amd.com>
Date: Wed, 4 Nov 2026 08:08:15 -0600
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
Subject: Re: [PATCH v2] cxl/port: Fix endpoint RAS error unmasking
To: Dave Jiang <dave.jiang@intel.com>, Richard Cheng <icheng@nvidia.com>,
	<dave@stgolabs.net>, <jic23@kernel.org>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>
CC: <iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kaihengf@nvidia.com>, <kobak@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>
References: <20261103063409.18275-1-icheng@nvidia.com>
 <aaa772ba-554a-4bef-8910-e271580c2a5b@amd.com>
 <f1e51d7f-645b-490e-b67c-36732b6db644@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <f1e51d7f-645b-490e-b67c-36732b6db644@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 048a8597-d01a-4ad3-58e9-08df3a7d132b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	wP5QS7NLqSmzxQwEsGkqzUCvDZTHqJ7JGXEFsrdmZslZp1/fmdOWBw3zS01xgBDEF9TY+sj9rR9RNYYH7LZDYMAAOoZUwNxSHZf86Ke9G8e+aiGSlqyLRtE8dsO+Ts3xQEKDWtqnazMgnHejlq3iSwgPUGykjiP0Bd+NEHLRKxffb09glmR5T9B3yZjkmIhu+CA7vlqO0RT/UAFZDwE0y5XYbsv3bTVnc49e7B4aSmb7k7s3O127AK+YVTtphU0hzduUB2pxQfp4hRwCxdZltyc7ockCk9/VYm3uL2x5slMqlurs32dgS/aWinAj1W19/xgFPaghs7oK6R6Uw4KSeSz/SDoWdDV6LZx/VrzoWCMMms0ReQ0oPoR7jYIZEysGhXfXPF14ZcMeNtjSy+GHf0vQ/ako4MeX0ddF424iJ4gsI72NC8P/3pM/XBBYx3bIJY8FiqhFqLIFExTpE6qHQa3HvHo/XAWFlx6969kMzaioHqC6oLxF7Z0IzDYlecdAyYqBNhXLMGy3qfluLLfOlGEe4Fl35InfZNwYPtJUpr1TOe8a6WYy+KkRxPqFUtrh43Sbd9ywvUfCjhJDcaQ2C1FJkBQ5lWD7PhcDhsyrRSzu9ZOHGiuqy2Nd6pvJbl/9VdtJgyEHNkdXeb1hCmAOvfrsWH23NMEzbsfMCozqlqEVyntxOQQpSW09PcY2flyaDqz7rurXnKb8yRS5raXXaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KjKOMqMPSSJKWry8BekTT+OlplZWlHpeXUOjUbTyKKJqPUXYtQPvB3tzanJLq3+pI/VU7uO91K+Wxg9y3cD5CK33ZxmTZQZTM+v8qHU2kHg7577wFSKeZLGmwF9ixnPrDi6E7rTyo72z+fwiUJmX8lvCL9rvAexbsu0CmyJyPAaV8Hq2dKTDxDW9u0dSB7IHk86j3A2RxbTADlo6p69CwYipCg2Xi/XhuU+xJ3hXCgu6MtuG6coIqVwadcsw6R9HLObX8Nb4ud+4WF4IY5WE2x7H2H2k9sbVQhYjwe2vSCWuhUJD4nXuYsbsE1R4ep7QEfH6yCOwAkurr38emSmL0eSLk9OZtT5/ZjXil2CGNzlnRCpVCSXRa3UVprZXNGnL9EZBwsDx04uQKgzx9GexN5ztBepY/TEngNWvO9H1jC9kpaErE07pklfzsp1l+tHr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:08:17.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048a8597-d01a-4ad3-58e9-08df3a7d132b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061



On 11/3/2026 5:15 PM, Dave Jiang wrote:
> 
> 
> On 11/3/26 11:35 AM, Cheatham, Benjamin wrote:
>> On 11/3/2026 12:34 AM, Richard Cheng wrote:
>>> Moving endpoint RAS handling from cxl_pci to cxl_port left
>>> cxl_ras_unmask() checking whether port->uport_dev is a PCI device.
>>> Endpoint ports always use a cxl_memdev as uport_dev, so this check
>>> returns early and leaves the CXL RAS error masks unchanged.
>>>
>>> Resolve the PCI device directly through the memdev's parent. Rename
>>> helper to cxl_endpoint_ras_unmask() and its param to endpoint to make
>>> its endpoint-only scope explicit.
>>>
>>> Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>> ---
>>
>> ...
>>
>>> -static int cxl_ras_unmask(struct cxl_port *port)
>>> +static int cxl_endpoint_ras_unmask(struct cxl_port *endpoint)
>>>  {
>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>>> +	struct device *parent = cxlmd->dev.parent;
>>
>> Two small nits:
>>
>> 1. Maybe just use endpoint->uport_dev.parent directly and drop the cxlmd part? It's less
>> readable, but it's future proofing for when/if CXL.cache devices come along.
>>
>> 2. I don't think you need to rename the port parameter if you change the name to endpoint. It's
>> self-explanatory at that point and cuts down on the diff.
> 
> I asked for that change. Since we are making changes on that line already, may as well make it explicit for readability. Or at least satisfies my OCD :)
> 
> DJ
> 

Ahh ok, then that's fine with me.

Thanks,
Ben
